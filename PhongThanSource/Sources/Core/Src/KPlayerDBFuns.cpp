#include "KCore.h"

#ifdef _SERVER
#include "KEngine.h"
#include "KSubWorldSet.h"
#include "KSubWorld.h"
#include "KPlayer.h"
#include "KNpc.h"
#include "KItem.h"
#include "KItemList.h"
#include "KItemGenerator.h"
#include "KItemSet.h"
#include "KNpcSet.h"
#include "KPlayerSet.h"
#include "KPhongThanAppearance.h"
#include "KPhongThanProfessionSkills.h"
#include <time.h>
#include <stdarg.h>
//#include "MyAssert.H"
#include "KTaskFuns.h"

// Implemented in ScriptFuns.cpp. The restore point is deliberately after the
// complete task payload so IBBuff persistence remains in the locked role ABI.
extern void RestorePhongThanIBBuffs(int nPlayerIndex);
extern void PhongThanMigrateCreditToRepute(int nPlayerIndex);	// engine2:D2x


// �Ƿ����ݿ��ȡ�������ݱ��������Թ�����
//#define DEBUGOPT_DB_ROLEDATA_OUT 




KList g_DBMsgList;

static void CoreLoginDiag(const char *pszFormat, ...)
{
	FILE *pFile = fopen("core_login_diag.log", "a+b");
	if (!pFile)
		return;
	va_list args;
	va_start(args, pszFormat);
	vfprintf(pFile, pszFormat, args);
	va_end(args);
	fputc('\n', pFile);
	fclose(pFile);
}

int KPlayer::AddDBPlayer(char * szPlayerName, int sex, DWORD * pdwID)
{
	return FALSE;
}

int KPlayer::LoadCharacterState(const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	int &nStep, unsigned int &nParam)
{
	if (!pState || !PhongThanValidateCharacterState(pState, pState->StateSize))
		return 0;
	int nRet = 0;
	int nRetValue = 0;
	switch(nStep)
	{
	case STEP_BASE_INFO:
		nRet = LoadPlayerBaseInfo(pState, nParam);
		break;
	case STEP_FIGHT_SKILL_LIST:
		nRet = LoadPlayerFightSkillList(pState, nParam);
		break;
	case STEP_STATE_SKILL_LIST:
		nRet = LoadPlayerStateSkillList(pState, nParam);
		break;
	case STEP_TASK_LIST:
		nRet = LoadPlayerTaskList(pState, nParam);
		if (nRet == 1)
		{
			for (int i = 0; i < TASKVALUE_MAXWAYPOINT_COUNT; ++i)
			{
				const int nWayPoint = m_cTask.GetSaveVal(
					TASKVALUE_SAVEWAYPOINT_BEGIN + i);
				if (nWayPoint)
				{
					KIndexNode* pNewNode = new KIndexNode;
					pNewNode->m_nIndex = nWayPoint;
					m_PlayerWayPointList.AddTail(pNewNode);
				}
			}
			for (int j = 0; j < TASKVALUE_MAXSTATION_COUNT / 2; ++j)
			{
				const DWORD nStations = (DWORD)m_cTask.GetSaveVal(
					TASKVALUE_SAVESTATION_BEGIN + j);
				const int nStation1 = (int)HIWORD(nStations);
				const int nStation2 = (int)LOWORD(nStations);
				if (nStation1)
				{
					KIndexNode* pNewNode = new KIndexNode;
					pNewNode->m_nIndex = nStation1;
					m_PlayerStationList.AddTail(pNewNode);
				}
				if (nStation2)
				{
					KIndexNode* pNewNode = new KIndexNode;
					pNewNode->m_nIndex = nStation2;
					m_PlayerStationList.AddTail(pNewNode);
				}
			}
			g_TimerTask.LoadTask(this);
		}
		break;
	case STEP_ITEM_LIST:
		nRet = LoadPlayerItemList(pState, nParam);
		if (nRet == 1) { extern void PhongThanGrantStarterBag(KPlayer&); PhongThanGrantStarterBag(*this); }
		break;
	default:
		nStep = STEP_SYNC_END;
		break;
	}

	if (nStep != STEP_SYNC_END)
	{
		if (nRet == 1)
		{
			nRetValue = SendSyncData(nStep, nParam);
			++nStep;
			nParam = 0;
		}
		else if (nRet == -1)
		{
			++nStep;
			nParam = 0;
			return 0;
		}
		else
		{
			nRetValue = SendSyncData(nStep, nParam);
		}
	}
	if (nStep == STEP_SYNC_END)
		m_PlayerDBLoad = TRUE;
	return nRetValue;
}

int KPlayer::UpdateCharacterState(PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	unsigned int nCapacity)
{
	if (!pState || nCapacity < sizeof(*pState) ||
		nCapacity > PHONGTHAN_CHARACTER_MAX_STATE_SIZE)
		return -1;
	PHONGTHAN_CHARACTER_STATE_HEADER Previous;
	ZeroMemory(&Previous, sizeof(Previous));
	if (pState->StateSize >= sizeof(*pState) &&
		pState->StateSize <= nCapacity &&
		PhongThanValidateCharacterState(pState, pState->StateSize))
		Previous = *pState;
	ZeroMemory(pState, nCapacity);
	pState->SchemaVersion = PHONGTHAN_CHARACTER_SCHEMA_VERSION;
	pState->Revision = Previous.Revision + 1;
	pState->RoleTime = Previous.RoleTime;
	if (SavePlayerBaseInfo(pState) != 1 ||
		SavePlayerFightSkillList(pState, nCapacity) != 1 ||
		SavePlayerStateSkillList(pState, nCapacity) != 1 ||
		SavePlayerTaskList(pState, nCapacity) != 1 ||
		SavePlayerItemList(pState, nCapacity) != 1)
		return -1;
	pState->StateSize = PhongThanCharacterExpectedStateSize(pState);
	return PhongThanValidateCharacterState(pState, pState->StateSize) ? 1 : -1;
}

int KPlayer::LoadPlayerBaseInfo(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam)
{
	if (!pState || nParam != 0)
		return -1;
	CoreLoginDiag("load_base_start name=%s use_revive=%d revive_map=%d revive_pos=%d enter_map=%d enter_x=%d enter_y=%d",
		pState->RoleName, (int)pState->UseRevive, (int)pState->ReviveMapId,
		(int)pState->ReviveX, (int)pState->EnterMapId,
		(int)pState->EnterX, (int)pState->EnterY);

#define PLAYER_MALE_NPCTEMPLATEID -1
#define PLAYER_FEMALE_NPCTEMPLATEID -2
	const int nLevel = pState->FightLevel;
	int nSexTemplate = pState->Gender ?
		MAKELONG(nLevel, PLAYER_FEMALE_NPCTEMPLATEID) :
		MAKELONG(nLevel, PLAYER_MALE_NPCTEMPLATEID);
	m_sLoginRevivalPos.m_nSubWorldID = pState->ReviveMapId;
	m_sLoginRevivalPos.m_ReviveID = 0;
	m_sLoginRevivalPos.m_nMpsX = pState->ReviveX;
	m_sLoginRevivalPos.m_nMpsY = pState->ReviveY;
	bool bUseRevive = pState->UseRevive != 0;

label_retry:
	POINT Pos;
	if (m_sLoginRevivalPos.m_nMpsX <= 0 || m_sLoginRevivalPos.m_nMpsY <= 0)
		return -1;
	PLAYER_REVIVAL_POS tempPos;
	if (bUseRevive)
	{
		tempPos.m_nSubWorldID = m_sLoginRevivalPos.m_nSubWorldID;
		tempPos.m_ReviveID = m_sLoginRevivalPos.m_ReviveID;
		tempPos.m_nMpsX = m_sLoginRevivalPos.m_nMpsX;
		tempPos.m_nMpsY = m_sLoginRevivalPos.m_nMpsY;
	}
	else
	{
		tempPos.m_nSubWorldID = pState->EnterMapId;
		tempPos.m_nMpsX = pState->EnterX;
		tempPos.m_nMpsY = pState->EnterY;
	}
	int nWorldIndex = g_SubWorldSet.SearchWorld(tempPos.m_nSubWorldID);
	if (nWorldIndex == -1)
	{
		return -1;
	}
	m_nIndex = NpcSet.Add(nSexTemplate, nWorldIndex,
		tempPos.m_nMpsX, tempPos.m_nMpsY);
	if (m_nIndex <= 0)
	{
		g_DebugLog("[Error!] Add player entity failed in Phong Than character loader");
		if (bUseRevive)
			return -1;
		bUseRevive = true;
		goto label_retry;
	}

	m_sDeathRevivalPos = m_sLoginRevivalPos;
	KNpc* pNpc = &Npc[m_nIndex];
	pNpc->m_Kind = kind_player;
	pNpc->SetPlayerIdx(m_nPlayerIndex);
	pNpc->m_Level = nLevel;
	strncpy(pNpc->Name, (const char*)pState->RoleName, sizeof(pNpc->Name) - 1);
	pNpc->Name[sizeof(pNpc->Name) - 1] = 0;
	m_nForbiddenTm = pState->ForbiddenUntil;
	m_nAttributePoint = pState->RemainingAttributePoints;
	m_nSkillPoint = pState->RemainingSkillPoints;
	m_nStrength = pState->Power;
	m_nDexterity = pState->Agility;
	m_nVitality = pState->Physique;
	m_nEngergy = pState->Wisdom;
	m_nLucky = pState->Luck;
	m_cTong.Clear();
	m_cTong.DBSetTongNameID(pState->ClanId);
	m_nCurStrength = m_nStrength;
	m_nCurDexterity = m_nDexterity;
	m_nCurVitality = m_nVitality;
	m_nCurEngergy = m_nEngergy;
	pNpc->m_CurrentLucky = m_nLucky;
	SetFirstDamage();
	SetBaseAttackRating();
	SetBaseDefence();
	m_nExp = pState->FightExperience;
	pNpc->m_byTranslife = pState->Transcendence;
	m_nNextLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(
		pNpc->m_Level, pNpc->m_byTranslife);
	m_nLeadLevel = pState->LeadershipLevel;
	m_nLeadExp = pState->LeadershipExperience;
	if (!m_cProfession.SetProfession(pState->Profession))
		return -1;
	pNpc->m_RankID = pState->TitleRank;
	pNpc->m_ExpandRank.Release();
	strncpy(pNpc->m_ExpandRank.szName, (const char*)pState->RankName,
		sizeof(pNpc->m_ExpandRank.szName) - 1);
	pNpc->m_ExpandRank.dwColor = pState->RankColor;
	pNpc->m_ExpandRank.nStateGraphics = pState->RankGraphic;
	pNpc->m_ExpandRank.dwLeftTime = pState->RankRemainingTime;
	if (pNpc->m_ExpandRank.dwLeftTime &&
		pNpc->m_ExpandRank.dwLeftTime < KSG_GetCurSec())
		pNpc->m_ExpandRank.Release();
	m_nWorldStat = pState->WorldState;
	m_nProfessionRank = pState->ProfessionRank;
	m_nKillPeopleNumber = pState->KillCount;
	m_dwEquipExpandTime = pState->ExtraItemRole;
	m_btRepositoryNum = pState->ExtraBox;
	m_cTong.m_dwLeaveTime = pState->ClanLeaveTime;
	m_ImagePlayer = pState->HelmResource;
	m_ItemList.Init(GetPlayerIndex());
	m_ItemList.SetMoney(pState->Money, pState->BankMoney, 0);
	pNpc->m_Series = pState->Profession;
	pNpc->m_Camp = m_cProfession.GetCamp();
	pNpc->m_nSex = pState->Gender;
	pNpc->m_LifeMax = pState->MaxLife;
	pNpc->m_StaminaMax = pState->MaxStamina;
	pNpc->m_ManaMax = pState->MaxMana;
	// Administrative level/stat grants can leave the persisted base pools at
	// level one. Repair that stale floor before equipment/state bonuses apply.
	char basePath[80];
	sprintf(basePath, NEW_PLAYER_INI_FILE_NAME, pNpc->m_Series * 2 + pNpc->m_nSex);
	KIniFile base;
	BOOL repairedPools = FALSE;
	if (base.Load(basePath))
	{
		int life, mana, stamina, vitality, energy, initialLevel;
		base.GetInteger("ROLE", "imaxlife", 0, &life);
		base.GetInteger("ROLE", "imaxinner", 0, &mana);
		base.GetInteger("ROLE", "imaxstamina", 0, &stamina);
		base.GetInteger("ROLE", "iouter", 0, &vitality);
		base.GetInteger("ROLE", "iinside", 0, &energy);
		base.GetInteger("ROLE", "ifightlevel", 1, &initialLevel);
		int levels = nLevel > initialLevel ? nLevel - initialLevel : 0;
		int vit = m_nVitality > vitality ? m_nVitality - vitality : 0;
		int en = m_nEngergy > energy ? m_nEngergy - energy : 0;
		life += levels * PlayerSet.m_cLevelAdd.GetLifePerLevel(pNpc->m_Series) +
			vit * PlayerSet.m_cLevelAdd.GetLifePerVitality(pNpc->m_Series);
		mana += levels * PlayerSet.m_cLevelAdd.GetManaPerLevel(pNpc->m_Series) +
			en * PlayerSet.m_cLevelAdd.GetManaPerEnergy(pNpc->m_Series);
		stamina += levels * PlayerSet.m_cLevelAdd.GetStaminaPerLevel(pNpc->m_nSex, pNpc->m_Series) +
			vit * PlayerSet.m_cLevelAdd.GetStaminaPerVitality(pNpc->m_Series);
		if (pNpc->m_LifeMax < life) { pNpc->m_LifeMax = life; repairedPools = TRUE; }
		if (pNpc->m_ManaMax < mana) { pNpc->m_ManaMax = mana; repairedPools = TRUE; }
		if (pNpc->m_StaminaMax < stamina) { pNpc->m_StaminaMax = stamina; repairedPools = TRUE; }
	}
	pNpc->m_LifeReplenish = PLAYER_LIFE_REPLENISH;
	pNpc->m_ManaReplenish = PLAYER_MANA_REPLENISH;
	pNpc->m_StaminaGain = PLAYER_STAMINA_GAIN;
	pNpc->m_StaminaLoss = PLAYER_STAMINA_LOSS;
	SetBaseResistData();
	SetBaseSpeedAndRadius();
	pNpc->RestoreNpcBaseInfo();
	pNpc->m_CurrentLife = pState->CurrentLife;
	pNpc->m_CurrentMana = pState->CurrentMana;
	pNpc->m_CurrentStamina = pState->CurrentStamina;
	if (repairedPools)
	{
		pNpc->m_CurrentLife = pNpc->m_LifeMax;
		pNpc->m_CurrentMana = pNpc->m_ManaMax;
		pNpc->m_CurrentStamina = pNpc->m_StaminaMax;
		printf("[PhongThan] repaired base pools level=%d life=%d mana=%d stamina=%d\n",
			nLevel, pNpc->m_LifeMax, pNpc->m_ManaMax, pNpc->m_StaminaMax);
	}
	m_cPK.SetLockPKState(pState->PkStatus, pState->LockPkState);
	m_cPK.SetPKValue(pState->PkValue);
	for (int i = 0; i < PHONGTHAN_CHARACTER_STAT_TASK_COUNT; ++i)
		m_cTask.SetSaveVal(TASKVALUE_STATTASK_REPUTE + i,
			pState->StatTask[i]);
	m_BuyInfo.Clear();
	m_cMenuState.Release();
	m_cChat.Release();
	m_cTeam.Release();
	m_cTeam.SetCreatTeamFlag(m_nPlayerIndex, TRUE);
	m_cTeam.SetFreezeTeamFlag(m_nPlayerIndex, TRUE);
	m_nPeapleIdx = 0;
	m_nObjectIdx = 0;
	memset(m_szTaskAnswerFun, 0, sizeof(m_szTaskAnswerFun));
	m_nAvailableAnswerNum = 0;
	Npc[m_nIndex].m_ActionScriptID = 0;
	Npc[m_nIndex].m_TrapScriptID = 0;
	m_nViewEquipTime = 0;
	pNpc->m_Experience = 0;
	g_PhongThanAppearance.SetDefault(&pNpc->m_Appearance);
	SetExtPoint(m_nExtPoint, m_nChangeExtPoint);
	pNpc->m_FightMode = pState->FightMode;
	nParam = 1;
	return 1;
}

int KPlayer::LoadPlayerItemList(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam)
{
	if (!pState)
		return -1;
	const int nItemCount = (int)pState->ItemCount;
	if (!nItemCount)
		return 1;
	if (nParam >= (unsigned int)nItemCount)
		return -1;
	const int nBegin = (int)nParam;
	int nEnd = nBegin + DBLOADPERTIME_ITEM;
	if (nEnd > nItemCount)
		nEnd = nItemCount;
	nParam = nEnd;
	const PHONGTHAN_CHARACTER_ITEM_RECORD* pItems =
		PhongThanCharacterItems(pState);
	for (int i = nBegin; i < nEnd; ++i)
	{
		const PHONGTHAN_CHARACTER_ITEM_RECORD* pItemData = &pItems[i];
		if (pItemData->SchemaVersion != PHONGTHAN_EMBEDDED_ITEM_VERSION)
			return -1;
		if (pItemData->ExpireTime && pItemData->ExpireTime < KSG_GetCurSec())
			continue;
		KItem NewItem;
		ZeroMemory(&NewItem, sizeof(NewItem));
		NewItem.m_CommonAttrib.nDetailType = pItemData->DetailType;
		NewItem.m_CommonAttrib.nParticularType = pItemData->ParticularType;
		NewItem.m_CommonAttrib.nLevel = pItemData->Level;
		NewItem.m_CommonAttrib.nSeries = pItemData->Series;
		NewItem.m_CommonAttrib.nRow = pItemData->TemplateRow;
		memcpy(NewItem.m_GeneratorParam.nGeneratorLevel,
			pItemData->GeneratorLevel,
			sizeof(NewItem.m_GeneratorParam.nGeneratorLevel));
		NewItem.m_GeneratorParam.nVersion = pItemData->TableVersion;
		NewItem.m_GeneratorParam.uRandomSeed = pItemData->RandomSeed;
		NewItem.m_GeneratorParam.nLuck = pItemData->Luck;
		BOOL bGenerated = FALSE;
		switch(pItemData->Genre)
		{
		case item_equip:
			bGenerated = ItemGen.Gen_ExistEquipmentByTemplateRow(
				pItemData->DetailType, pItemData->TemplateRow,
				pItemData->Series, NewItem.m_GeneratorParam.nGeneratorLevel,
				pItemData->Luck, pItemData->TableVersion, &NewItem);
			break;
		case item_medicine:
			bGenerated = ItemGen.Gen_Medicine(pItemData->DetailType,
				pItemData->Level, pItemData->TableVersion, &NewItem);
			break;
		case item_event:
			bGenerated = ItemGen.Gen_Event(pItemData->DetailType, &NewItem);
			break;
		case item_materials:
			bGenerated = ItemGen.Gen_Material(pItemData->DetailType, &NewItem);
			break;
		case item_task:
			bGenerated = ItemGen.Gen_Quest(pItemData->DetailType, &NewItem);
			break;
		case item_townportal:
			bGenerated = ItemGen.Gen_TownPortal(pItemData->DetailType, &NewItem);
			break;
		case item_magicscript:
			bGenerated = ItemGen.Gen_MagicScript(pItemData->DetailType,
				&NewItem, pItemData->Level, pItemData->Series, pItemData->Luck);
			break;
		case item_skillbook:
			bGenerated = ItemGen.Gen_SkillBook(pItemData->DetailType,
				pItemData->ParticularType, pItemData->Level, &NewItem);
			break;
		case item_ibitem:
			bGenerated = ItemGen.Gen_IBItem(pItemData->DetailType,
				pItemData->ParticularType, &NewItem);
			break;
		}
		if (pItemData->TemplateRow == 59 || pItemData->TemplateRow == 249)
		{
			FILE* log = fopen("equipment_delivery.log", "a");
			if (log) { fprintf(log,"LOAD row=%d detail=%d generated=%d size=%d,%d position=%d,%d,%d\n",
				pItemData->TemplateRow,pItemData->DetailType,bGenerated,NewItem.GetWidth(),NewItem.GetHeight(),
				pItemData->Container,pItemData->SlotX,pItemData->SlotY); fclose(log); }
		}
		if (!bGenerated)
			continue;
		if (pItemData->Durability != -2)
			NewItem.SetDurability(pItemData->Durability);
		NewItem.GetBackLocal()->Release();
		NewItem.SetExpireTime(pItemData->ExpireTime);
		NewItem.SetOwner(pItemData->OwnerId);
		NewItem.SetTradePrice(pItemData->TradePrice);
		KLockItem Lock;
		Lock.nState = pItemData->LockState;
		Lock.dwLockTime = pItemData->LockUntil;
		if (Lock.nState == LOCK_STATE_UNLOCK && Lock.dwLockTime <= KSG_GetCurSec())
		{
			Lock.nState = LOCK_STATE_NORMAL;
			Lock.dwLockTime = 0;
		}
		NewItem.SetLock(&Lock);
		NewItem.SetFortune(pItemData->Fortune);
		NewItem.SetLockSell(pItemData->LockSell ? TRUE : FALSE);
		NewItem.SetLockTrade(pItemData->LockTrade ? TRUE : FALSE);
		NewItem.SetLockDrop(pItemData->LockDrop ? TRUE : FALSE);
		NewItem.SetParam(pItemData->ScriptParam);
		NewItem.SetStackNum(pItemData->StackCount);
		NewItem.SetFlash(pItemData->Flash);
		if(NewItem.GetGenre()==item_equip && !NewItem.ApplyUpgradeState(pItemData->UpgradeLevel))
		{
			CoreLoginDiag("Invalid/unresolved equipment upgrade state detail=%d row=%d state=%d",
				pItemData->DetailType,pItemData->TemplateRow,pItemData->UpgradeLevel);
			return -1;
		}
		NewItem.m_CommonAttrib.nPhysicVal = pItemData->PhysicalValue;
		NewItem.m_CommonAttrib.nMagicVal = pItemData->MagicValue;
		NewItem.SetRow(pItemData->TemplateRow);
		const int nIndex = ItemSet.Add(&NewItem);
		if (nIndex > 0)
			m_ItemList.Add(nIndex, pItemData->Container,
				pItemData->SlotX, pItemData->SlotY, false);
	}
	return nParam >= (unsigned int)nItemCount ? 1 : 0;
}

int KPlayer::LoadPlayerFightSkillList(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int& nParam)
{
	if (!pState)
		return -1;
	const unsigned int nCount = pState->FightSkillCount;
	if (nParam > nCount)
		return -1;

	int nFirstProfessionSkill = 0;
	int nLastProfessionSkill = 0;
	const int nProfession = m_cProfession.GetProfession();
	if (!PhongThanGetProfessionSkillRange(nProfession,
		&nFirstProfessionSkill, &nLastProfessionSkill))
		return -1;

	// A reused player/NPC slot must not retain the previous character's list.
	if (nParam == 0)
		Npc[m_nIndex].m_SkillList.Clear();
	const PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
		PhongThanCharacterFightSkills(pState);
	for (unsigned int i = nParam; i < nCount; ++i)
	{
		const int nSkillId = pSkills[i].SkillId;
		const int nLevel = pSkills[i].Level;
		if (nSkillId <= 0 || nSkillId >= MAX_SKILL ||
			nLevel <= 0 || nLevel >= MAX_SKILLLEVEL)
			continue;
		if (PhongThanIsProfessionSkill(nSkillId) &&
			!PhongThanProfessionOwnsSkill(nProfession, nSkillId))
			continue;
		Npc[m_nIndex].m_SkillList.Add(nSkillId, nLevel,
			pSkills[i].Value);
	}
	nParam = nCount;

	// Repair empty or partial legacy character lists during login. Existing
	// levels are preserved; only missing canonical VNG skills are inserted.
	for (int nCommon = PHONGTHAN_COMMON_SKILL_FIRST;
		nCommon <= PHONGTHAN_COMMON_SKILL_LAST; ++nCommon)
	{
		if (!Npc[m_nIndex].m_SkillList.FindSame(nCommon))
			Npc[m_nIndex].m_SkillList.Add(nCommon,
				PHONGTHAN_PROFESSION_SKILL_LEVEL, 0);
	}
	for (int nSkillId = nFirstProfessionSkill;
		nSkillId <= nLastProfessionSkill; ++nSkillId)
	{
		if (!Npc[m_nIndex].m_SkillList.FindSame(nSkillId))
			Npc[m_nIndex].m_SkillList.Add(nSkillId,
				PHONGTHAN_PROFESSION_SKILL_LEVEL, 0);
	}
	return 1;
}

int KPlayer::LoadPlayerStateSkillList(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int& nParam)
{
	if (!pState)
		return -1;
	const unsigned int nCount = pState->StateSkillCount;
	if (!nCount)
		return 1;
	if (nParam >= nCount)
		return -1;
	const PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
		PhongThanCharacterStateSkills(pState);
	for (unsigned int i = nParam; i < nCount; ++i)
	{
		KSkill* pSkill = (KSkill*)g_SkillManager.GetSkill(
			pSkills[i].SkillId, pSkills[i].Level);
		if (!pSkill)
			continue;
		int nLeftTime = pSkills[i].Value;
		if (IS_TU_CHAN_SEAL_SKILL(pSkills[i].SkillId) &&
			(nLeftTime <= 0 || nLeftTime > TU_CHAN_SEAL_DURATION_TICKS))
			nLeftTime = TU_CHAN_SEAL_DURATION_TICKS;
		pSkill->CastStateSkill(m_nIndex, 0, 0, nLeftTime, TRUE);
	}
	nParam = nCount;
	return 1;
}

int KPlayer::LoadPlayerTaskList(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int& nParam)
{
	if (!pState)
		return -1;
	if (nParam == 0)
	{
		while (m_PlayerStationList.GetHead())
		{
			KIndexNode* pNode = (KIndexNode*)m_PlayerStationList.GetHead();
			m_PlayerStationList.RemoveHead();
			delete pNode;
		}
		while (m_PlayerWayPointList.GetHead())
		{
			KIndexNode* pNode = (KIndexNode*)m_PlayerWayPointList.GetHead();
			m_PlayerWayPointList.RemoveHead();
			delete pNode;
		}
		m_cTask.Release();
	}
	const unsigned int nCount = pState->TaskCount;
	if (!nCount)
		return 1;
	if (nParam >= nCount)
		return -1;
	unsigned int nEnd = nParam + DBLOADPERTIME_TASK;
	if (nEnd > nCount)
		nEnd = nCount;
	const PHONGTHAN_CHARACTER_TASK_RECORD* pTasks = PhongThanCharacterTasks(pState);
	for (unsigned int i = nParam; i < nEnd; ++i)
	{
		if (pTasks[i].TaskId < 0 || pTasks[i].TaskId >= MAX_TASK ||
			!pTasks[i].Value[0])
			continue;
		if (pTasks[i].TaskId == TASKVALUE_BASEDATA_PASSWORD)
			SetSavePw((char*)pTasks[i].Value, FALSE);
		else
			m_cTask.SetSaveVal(pTasks[i].TaskId, (char*)pTasks[i].Value);
	}
	nParam = nEnd;
	if (nParam < nCount)
		return 0;
	const int nTitleEnabled = m_cTask.GetSaveVal(TASKVALUE_PT_TITLE_FUNCTION);
	const int nCurrentTitle = m_cTask.GetSaveVal(TASKVALUE_PT_CURRENT_TITLE);
	m_nPhongThanTaskState = m_cTask.GetSaveVal(TASKVALUE_PT_TASK_STATE);
	m_nPhongThanTaskSubState = m_cTask.GetSaveVal(TASKVALUE_PT_TASK_SUB_STATE);
	m_dwPhongThanTaskRevision = (DWORD)m_cTask.GetSaveVal(TASKVALUE_PT_TASK_REVISION);
	if (m_nIndex > 0 && m_nIndex < MAX_NPC)
		Npc[m_nIndex].SetRank(nTitleEnabled && nCurrentTitle >= 0 &&
			nCurrentTitle <= 255 ? nCurrentTitle : 0);
	RestorePhongThanIBBuffs(m_nPlayerIndex);
	PhongThanMigrateCreditToRepute(m_nPlayerIndex);	// engine2:D2l old credit wallet -> danh vong (task 210)
	return 1;
}

int KPlayer::SavePlayerBaseInfo(PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	if (!pState || m_nIndex <= 0)
		return -1;
	KNpc* pNpc = &Npc[m_nIndex];
	if (!pState->RoleTime)
		pState->RoleTime = KSG_GetCurSec();
	strncpy((char*)pState->RoleName, Name, sizeof(pState->RoleName) - 1);
	strncpy((char*)pState->AccountName, AccountName,
		sizeof(pState->AccountName) - 1);
	pState->ForbiddenUntil = m_nForbiddenTm;
	pState->RemainingAttributePoints = m_nAttributePoint;
	pState->RemainingSkillPoints = m_nSkillPoint;
	pState->Power = m_nStrength;
	pState->Agility = m_nDexterity;
	pState->Physique = m_nVitality;
	pState->Wisdom = m_nEngergy;
	pState->Luck = m_nLucky;
	pState->ClanLeaveTime = m_cTong.m_dwLeaveTime;
	pState->ClanId = m_cTong.GetTongNameID();
	strncpy((char*)pState->ClanName, m_cTong.m_szName,
		sizeof(pState->ClanName) - 1);
	pState->ClanLevel = m_cTong.m_btLevel;
	pState->ClanMemberCount = m_cTong.m_dwMemberNum +
		m_cTong.m_btManagerNum + m_cTong.m_btDirectorNum;
	pState->ClanEffect = m_cTong.m_dwTotalEff;
	pState->FightExperience = m_nExp;
	pState->FightLevel = pNpc->m_Level;
	pState->Transcendence = pNpc->m_byTranslife;
	pState->LeadershipLevel = m_nLeadLevel;
	pState->LeadershipExperience = m_nLeadExp;
	pState->Profession = (PHONGTHAN_U8)m_cProfession.GetProfession();
	pState->TitleRank = pNpc->m_RankID;
	strncpy((char*)pState->RankName, pNpc->m_ExpandRank.szName,
		sizeof(pState->RankName) - 1);
	pState->RankColor = pNpc->m_ExpandRank.dwColor;
	pState->RankGraphic = pNpc->m_ExpandRank.nStateGraphics;
	pState->RankRemainingTime = pNpc->m_ExpandRank.dwLeftTime;
	pState->WorldState = m_nWorldStat;
	pState->ProfessionRank = m_nProfessionRank;
	pState->KillCount = m_nKillPeopleNumber;
	pState->ExtraItemRole = m_dwEquipExpandTime;
	pState->ExtraBox = m_btRepositoryNum;
	pState->LockPkState = m_nLockPKState;
	pState->HelmResource = m_ImagePlayer;
	pState->Money = m_ItemList.GetMoney(room_equipment);
	pState->BankMoney = m_ItemList.GetMoney(room_repository);
	pState->TeamId = pNpc->m_Camp;
	pState->Gender = (PHONGTHAN_U8)pNpc->m_nSex;
	pState->MaxLife = pNpc->m_LifeMax;
	pState->MaxStamina = pNpc->m_StaminaMax;
	pState->MaxMana = pNpc->m_ManaMax;
	pState->CurrentLife = pNpc->m_CurrentLife;
	pState->CurrentMana = pNpc->m_CurrentMana;
	pState->CurrentStamina = pNpc->m_CurrentStamina;
	pState->ReviveMapId = m_sLoginRevivalPos.m_nSubWorldID;
	pState->ReviveX = m_sLoginRevivalPos.m_nMpsX;
	pState->ReviveY = m_sLoginRevivalPos.m_nMpsY;
	if (m_bExchangeServer)
	{
		pState->UseRevive = 0;
		pState->IsExchange = 1;
		pState->EnterMapId = m_sExchangePos.m_dwMapID;
		pState->EnterX = m_sExchangePos.m_nX;
		pState->EnterY = m_sExchangePos.m_nY;
		pState->FightMode = (PHONGTHAN_U8)pNpc->m_FightMode;
	}
	else if (pNpc->m_SubWorldIndex >= 0 && pNpc->m_RegionIndex >= 0 &&
		pNpc->m_Doing != do_death && pNpc->m_Doing != do_revive)
	{
		pState->UseRevive = m_bUseReviveIdWhenLogin ? 1 : 0;
		pState->EnterMapId = SubWorld[pNpc->m_SubWorldIndex].m_SubWorldID;
		pNpc->GetMpsPos(&pState->EnterX, &pState->EnterY);
		pState->FightMode = (PHONGTHAN_U8)pNpc->m_FightMode;
	}
	else
	{
		pState->UseRevive = 1;
		pState->FightMode = enumFightNone;
		if (pNpc->m_Doing == do_death || pNpc->m_Doing == do_revive)
		{
			pState->CurrentLife = pNpc->m_LifeMax;
			pState->CurrentMana = pNpc->m_ManaMax;
			pState->CurrentStamina = pNpc->m_StaminaMax;
		}
	}
	pState->PkStatus = (PHONGTHAN_U8)m_cPK.GetNormalPKState();
	pState->PkValue = m_cPK.GetPKValue();
	for (int i = 0; i < PHONGTHAN_CHARACTER_STAT_TASK_COUNT; ++i)
		pState->StatTask[i] = m_cTask.GetSaveVal(TASKVALUE_STATTASK_REPUTE + i);
	return 1;
}

int KPlayer::SavePlayerItemList(PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	unsigned int nCapacity)
{
	if (!pState)
		return -1;
	PHONGTHAN_CHARACTER_ITEM_RECORD* pItems = PhongThanCharacterItems(pState);
	int nItemCount = 0;
	int nIdx = 0;
	while ((nIdx = m_ItemList.m_UseIdx.GetNext(nIdx)) != 0)
	{
		const int nItemIndex = m_ItemList.m_Items[nIdx].nIdx;
		if (Item[nItemIndex].IsTemp())
			continue;
		if (nItemCount >= PHONGTHAN_CHARACTER_MAX_ITEMS)
			return -1;
		const unsigned __int64 nRequired =
			(unsigned __int64)((BYTE*)&pItems[nItemCount + 1] - (BYTE*)pState);
		if (nRequired > nCapacity)
			return -1;
		PHONGTHAN_CHARACTER_ITEM_RECORD* pItem = &pItems[nItemCount];
		ZeroMemory(pItem, sizeof(*pItem));
		pItem->SchemaVersion = PHONGTHAN_EMBEDDED_ITEM_VERSION;
		pItem->Genre = Item[nItemIndex].m_CommonAttrib.nItemGenre;
		pItem->DetailType = Item[nItemIndex].m_CommonAttrib.nDetailType;
		pItem->ParticularType = Item[nItemIndex].m_CommonAttrib.nParticularType;
		pItem->Level = Item[nItemIndex].m_CommonAttrib.nLevel;
		pItem->Series = Item[nItemIndex].m_CommonAttrib.nSeries;
		if (Item[nItemIndex].GetBackLocal()->nPlace >= pos_hand &&
			Item[nItemIndex].GetBackLocal()->nPlace < pos_num)
		{
			pItem->Container = Item[nItemIndex].GetBackLocal()->nPlace;
			pItem->SlotX = Item[nItemIndex].GetBackLocal()->nX;
			pItem->SlotY = Item[nItemIndex].GetBackLocal()->nY;
		}
		else
		{
			pItem->Container = m_ItemList.m_Items[nIdx].nPlace;
			pItem->SlotX = m_ItemList.m_Items[nIdx].nX;
			pItem->SlotY = m_ItemList.m_Items[nIdx].nY;
		}
		pItem->TableVersion = Item[nItemIndex].GetItemParam()->nVersion;
		pItem->RandomSeed = Item[nItemIndex].GetItemParam()->uRandomSeed;
		memcpy(pItem->GeneratorLevel,
			Item[nItemIndex].GetItemParam()->nGeneratorLevel,
			sizeof(pItem->GeneratorLevel));
		pItem->Luck = Item[nItemIndex].GetItemParam()->nLuck;
		pItem->Durability = Item[nItemIndex].GetDurability();
		pItem->StackCount = Item[nItemIndex].GetStackNum();
		pItem->ExpireTime = Item[nItemIndex].GetExpireTime();
		pItem->LockState = Item[nItemIndex].GetLock()->nState;
		pItem->LockUntil = Item[nItemIndex].GetLock()->dwLockTime;
		pItem->ScriptParam = Item[nItemIndex].GetParam();
		pItem->Fortune = Item[nItemIndex].GetFortune();
		pItem->OwnerId = Item[nItemIndex].GetOwner();
		pItem->TradePrice = Item[nItemIndex].GetTradePrice();
		pItem->LockSell = Item[nItemIndex].m_CommonAttrib.bLockSell ? 1 : 0;
		pItem->LockTrade = Item[nItemIndex].m_CommonAttrib.bLockTrade ? 1 : 0;
		pItem->LockDrop = Item[nItemIndex].m_CommonAttrib.bLockDrop ? 1 : 0;
		pItem->Flash = Item[nItemIndex].GetFlash();
		pItem->UpgradeLevel = Item[nItemIndex].GetUpgradeState();
		pItem->PhysicalValue = Item[nItemIndex].m_CommonAttrib.nPhysicVal;
		pItem->MagicValue = Item[nItemIndex].m_CommonAttrib.nMagicVal;
		pItem->TemplateRow = Item[nItemIndex].GetRow();
		++nItemCount;
	}
	pState->ItemCount = nItemCount;
	return 1;
}

int KPlayer::SavePlayerFightSkillList(PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	unsigned int nCapacity)
{
	if (!pState || m_nIndex <= 0 ||
		nCapacity < sizeof(*pState) +
			PHONGTHAN_CHARACTER_MAX_SKILLS * sizeof(PHONGTHAN_CHARACTER_SKILL_RECORD))
		return -1;
	PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
		PhongThanCharacterFightSkills(pState);
	const int nCount = Npc[m_nIndex].m_SkillList.UpdateDBSkillList(
		pSkills);
	if (nCount < 0 || nCount > PHONGTHAN_CHARACTER_MAX_SKILLS)
		return -1;
	pState->FightSkillCount = nCount;
	return 1;
}

int KPlayer::SavePlayerStateSkillList(PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	unsigned int nCapacity)
{
	if (!pState || m_nIndex <= 0)
		return -1;
	PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
		PhongThanCharacterStateSkills(pState);
	const unsigned __int64 nRemaining = nCapacity -
		((BYTE*)pSkills - (BYTE*)pState);
	if (nRemaining < PHONGTHAN_CHARACTER_MAX_SKILLS * sizeof(*pSkills))
		return -1;
	const int nCount = Npc[m_nIndex].UpdateDBStateList(pSkills);
	if (nCount < 0 || nCount > PHONGTHAN_CHARACTER_MAX_SKILLS)
		return -1;
	pState->StateSkillCount = nCount;
	return 1;
}

int KPlayer::SavePlayerTaskList(PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	unsigned int nCapacity)
{
	if (!pState)
		return -1;
	KIndexNode* pNode = (KIndexNode*)m_PlayerStationList.GetHead();
	int n = 0;
	memset(&m_cTask.szSave[TASKVALUE_SAVESTATION_BEGIN], 0,
		(TASKVALUE_MAXSTATION_COUNT / 2) *
		sizeof(m_cTask.szSave[TASKVALUE_SAVESTATION_BEGIN]));
	memset(&m_cTask.szSave[TASKVALUE_SAVEWAYPOINT_BEGIN], 0,
		TASKVALUE_MAXWAYPOINT_COUNT *
		sizeof(m_cTask.szSave[TASKVALUE_SAVEWAYPOINT_BEGIN]));
	while (pNode && n < TASKVALUE_MAXSTATION_COUNT)
	{
		DWORD nValue = m_cTask.GetSaveVal(
			TASKVALUE_SAVESTATION_BEGIN + n / 2);
		nValue |= ((DWORD)pNode->m_nIndex) << ((n % 2) * 16);
		itoa(nValue, m_cTask.szSave[TASKVALUE_SAVESTATION_BEGIN + n / 2], 10);
		++n;
		pNode = (KIndexNode*)pNode->GetNext();
	}
	n = 0;
	pNode = (KIndexNode*)m_PlayerWayPointList.GetHead();
	while (pNode && n < TASKVALUE_MAXWAYPOINT_COUNT)
	{
		if (pNode->m_nIndex)
			itoa(pNode->m_nIndex,
				m_cTask.szSave[TASKVALUE_SAVEWAYPOINT_BEGIN + n++], 10);
		pNode = (KIndexNode*)pNode->GetNext();
	}
	g_TimerTask.SaveTask(this);

	PHONGTHAN_CHARACTER_TASK_RECORD* pTasks = PhongThanCharacterTasks(pState);
	int nTaskCount = 0;
	for (int i = 0; i < MAX_TASK; ++i)
	{
		if (!m_cTask.szSave[i][0])
			continue;
		if (nTaskCount >= PHONGTHAN_CHARACTER_MAX_TASKS ||
			(unsigned __int64)((BYTE*)&pTasks[nTaskCount + 1] - (BYTE*)pState) >
				nCapacity)
			return -1;
		pTasks[nTaskCount].TaskId = i;
		strncpy((char*)pTasks[nTaskCount].Value, m_cTask.GetSaveStr(i),
			sizeof(pTasks[nTaskCount].Value) - 1);
		++nTaskCount;
	}
	pState->TaskCount = nTaskCount;
	return 1;
}
#endif


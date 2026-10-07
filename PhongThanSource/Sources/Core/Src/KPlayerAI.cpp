//*******************************************************//
//*******************************************************//
//*******************************************************//
//*******************************************************//

//TamLTM check code co them moi file KPlayerAI viet auto

//*******************************************************//
//*******************************************************//
//*******************************************************//
//*******************************************************//

#include	"KCore.h"
#include	"KNpc.h"
#include	"KPlayer.h"
#include	"KBuySell.h"
#include 	"ImgRef.h"
#include	"KPlayerDef.h"
#include	"KPlayerAI.h"
#include	"KSubWorldSet.h"
#include 	"KMath.h"

#define		INTERVAL_AUTO			1000

static char* szPotionName	= "Tói d­îc phÈm";
static const char szMagicScriptName[][32] =
{
	"Tiªn Th¶o Lé",
	"Tiªn Th¶o Lé ®Æc biÖt",
	"NÕn Vui vÎ",
	"NÕn B×nh an",
	"NÕn May m¾n",
	"NÕn H¹nh phóc",
	"Song ThÊt Thñy",
	"§µo v¹n thä nh©n t¸o",
	"Lång ®Ìn b­¬m b­ím",
	"Lång ®Ìn ng«i sao",
	"Lång ®Ìn èng",
	"Lång ®Ìn trßn",
	"Lång ®Ìn c¸ chÐp",
	"Lång ®Ìn kÐo qu©n",
};


#ifndef _SERVER
#include	"CoreShell.h"
#include	"KPlayerPK.h"

void KPlayerAI::Init()
{
	Release();
}

int KEquipmentArray::FindSame(int i)
{
	int nIdx = 0;
	while(1)
	{
		nIdx = m_Link.GetNext(nIdx);
		if (!nIdx)
			break;

		if (nIdx == i)
			return nIdx;
	}
	return 0;
}


void KPlayerAI::Release()
{
	m_uTotalTime		 	= 0;
	m_bIsActive				= FALSE;
	m_nLastFightMode		= enumFightNone;
	m_bPriorityUseMouse 	= FALSE;
	m_bFightUseSB 			= FALSE;
	m_bHoldSpaceBar			= FALSE;
	m_nLifeAutoV 			= 0;
	m_nLifeAutoP 			= 0;
	m_nManaAutoV 			= 0;
	m_nManaAutoP 			= 0;
	m_bTPLife 				= FALSE;
	m_nTPLifeV 				= 0;
	m_bTPMana 				= FALSE;
	m_nTPManaV 				= 0;
	m_bTPNotMedicineBlood 	= FALSE;
	m_bTPNotMedicineMana 	= FALSE;
	m_bTPHightMoney 		= FALSE;
	m_nTPHightMoneyV 		= 0;
	m_bTPDamageEquip 		= FALSE;
	m_nTPDamageEquipV 		= 0;
	m_bTPNotEquipment 		= FALSE;
	m_nTPNotEquipmentV 		= 0;
	m_bAntiPoison			= FALSE;
	m_bEnchaseExp			= FALSE;
	m_bLifeReplenish		= FALSE;
	m_nLifeReplenishP		= 0;
	m_bInventoryMoney		= FALSE;
	m_bInventoryItem		= FALSE;
	m_bReturnPortal			= FALSE;
	m_nReturnPortalSec		= 0;
	m_nCurReturnPortalSec	= 0;
	m_bWithDrawa			= FALSE; // rut tien;
	m_bWithDrawaMoney		= 0; // rut tien;
	m_bFightNear 			= FALSE;
	m_nRadiusAuto 			= 0;
	m_nRadiusQuanhDiemXY 	= 0;
	m_nDistanceAuto 		= 0;
	m_nFightSkill 			= 0;
	m_nFightBack			= 0;
	m_nFightBoss 			= OverLookNothing;
	m_nActiveAuraID1 		= 0;
	m_nActiveAuraID2		= 0;
	m_nTargetIdx 			= 0;
	m_uLifeCountDown		= 0;
	m_uManaCountDown 		= 0;
	m_uPortalCountDown 		= 0;
	m_uAntiPoisonCountDown	= 0;
	m_uEnchaseExpCountDown	= 0;
	m_uOpenMedicineCountDown= 0;
	m_bEatLife 				= FALSE;
	m_bEatMana 				= FALSE;
	m_uLifeTimeUse 			= 0;
	m_uManaTimeUse 			= 0;
	m_nCount_Attack_OverLook = 0;
	m_nLifeOverLook 		= 0;
	m_nCount_Run_OverLook 	= 0;
	m_nObject 				= 0;
	m_bPickFightNone		= FALSE;
	m_bPickMoney 			= FALSE;
	m_bPickNotEquip 		= FALSE;
	m_bPickEquip 			= FALSE;
	m_bFollowPick			= FALSE;
	m_nPickEquipKind 		= enumPickEquipAll;
	m_bFilterEquipment		= FALSE;
	m_bSaveTrash 			= FALSE;
	m_nSaveTrashPrice 		= 0;
	m_bSaveJewelry 			= FALSE;
	m_bFollowPeople 		= FALSE;
	m_szFollowName[0] 		= 0;
	m_nFollowRadius			= 0;
	m_bFollowRadius			= FALSE; // them check chay toa do
	m_bAttackNpc			= FALSE;
	m_bAutoParty			= FALSE;
	m_bAutoInvite 			= FALSE;
	m_bAutoInviteList 		= FALSE;
	m_bOverTarget			= FALSE;
	m_bFollowTarget 		= FALSE;
	m_bQuanhDiem	 		= FALSE; // quanh diem
	m_bOpenMedicine			= FALSE;
	m_bRepairEquip			= FALSE;
	m_bMoveMps 				= FALSE;
	m_nMoveStep 			= 0;
	m_nMoveCount			= 0;
	m_bSortEquipment 		= FALSE;
	m_nReturnPortalStep		= Step_Training;
	m_bNotGetEquipment		= FALSE;

	m_nMovePosX				= 0;
	m_nMovePosY				= 0;

	//TamLTM Attack miss
	m_AttackNumberMiss		= 1;
	m_IgnoreAttackMiss		= 1;
	m_RadiusAttackMapLag	= 0;
	m_IgnoreCornerLag		= 1;
	m_IsIgnoreMoveMpsLag	= FALSE;
	//Auto run
	m_bAutoRunMap			= FALSE;
	m_nMapX					= 0;
	m_nMapY					= 0;
	m_bAutoRunFlagMap		= FALSE;
	m_nFlagMapX				= 0;
	m_nFlagMapY				= 0;
	//end code

    //Son check ban rac
    m_bSellTrash = FALSE;
    m_bSellItem  = FALSE;
    m_DelayTime = 0;
    //end code

	memset(m_nFilterMagic, 0, sizeof(m_nFilterMagic));
	memset(m_szPartyList, 0, sizeof(m_szPartyList));
	memset(m_nMoveMps, 0, sizeof(m_nMoveMps));
	memset(m_nSupportSkills, 0, sizeof(m_nSupportSkills));
	ClearArrayNpcNeast();
	ClearArrayObjectNeast();
	ClearArrayNpcOverLook();
	ClearArrayObjectOverLook();
	ClearArrayTimeNpcOverLook();
	ClearArrayTimeObjectOverLook();
	ClearArrayInvitePlayer();
	ClearArrayTimeInvitePlayer();
	m_sListEquipment.m_Link.Init(MAX_EQUIPMENT_ITEM);
}

void KPlayerAI::Active()
{
	// Phong Than 2026-10-03 autofight:H1 client auto fight tick (PhongThanAutoFight.inl, end of this file).
	{ extern void PTAutoFight_Tick(); PTAutoFight_Tick(); }
	// Phong Than 2026-10-04 timduong:H1 go to coordinates tick (PhongThanGoTo.inl, end of this file).
	{ extern void PTGoTo_Tick(); PTGoTo_Tick(); }
	//if (Player[0].m_cPK.GetPKNamePlayer() != NULL)
	//{
	//	Player[CLIENT_PLAYER_INDEX].m_cPK.GetPKNamePlayer();
	//}


	if (Player[CLIENT_PLAYER_INDEX].CheckTrading())
		return;

	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_death ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_revive)
		return;
    
	if (m_bIsActive)
	{
		EatItem();
		SwitchAura();
		if (m_bPriorityUseMouse)
		{
			ClearArrayNpcOverLook();
			ClearArrayTimeNpcOverLook();
			//ClearArrayObjectOverLook();
			//ClearArrayTimeObjectOverLook();
			m_nTargetIdx = 0;
			//m_nObject = 0;
			m_nLifeOverLook = 0;
			m_nCount_Run_OverLook = 0;
			m_nCount_Attack_OverLook = 0;

			if (!m_nObject)
			{
				m_nObject = GetNearObjectArray();
				if (m_nObject)
				{
					BOOL _flagOverLook = FALSE;
					for (int i=0; i<MAX_AUTO_SIZE; i++)
					{
						if (m_nArrayObjectOverLook[i] == m_nObject)
						{
							_flagOverLook = TRUE;
							break;
						}
					}
					if (_flagOverLook)
					{
						m_nObject = 0;
						m_nLifeOverLook = 0;
						m_nCount_Run_OverLook = 0;
						m_nCount_Attack_OverLook = 0;
					}
					else
					{
						ItemPos	sItemPos;
						if (Object[m_nObject].m_nKind == Obj_Kind_Item)
						{
                        	if ( FALSE == Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchPosition(Object[m_nObject].m_nItemWidth,
							Object[m_nObject].m_nItemHeight, &sItemPos) || sItemPos.nPlace != pos_equiproom)
						//	if (FALSE == Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchPosition(
							//	Object[m_nObject].m_nItemWidth,
							//	Object[m_nObject].m_nItemHeight, &sItemPos, true))
							{
								m_nObject = 0;
								m_nLifeOverLook = 0;
								m_nCount_Run_OverLook = 0;
								m_nCount_Attack_OverLook = 0;
							}
						}
					}
				}
			}
			if (m_nObject)
			{
				if (FollowObject(m_nObject))
					return;
			}
		}
		else
		{
			if (IR_GetCurrentTime() - m_uTotalTime > INTERVAL_AUTO)
			{
				if(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == m_nLastFightMode)
				{
				}
				else
				{
					m_nLastFightMode = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode;
					ClearArrayNpcOverLook();
					ClearArrayTimeNpcOverLook();
					ClearArrayObjectOverLook();
					ClearArrayTimeObjectOverLook();
					m_nTargetIdx = 0;
					m_nObject = 0;
					m_nLifeOverLook = 0;
					m_nCount_Run_OverLook = 0;
					m_nCount_Attack_OverLook = 0;
				}
				if (m_bFilterEquipment)
                {
	                FilterEquip();
   	            }

				if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == enumFightActive)
				{
					if (m_nReturnPortalStep == Step_Training)
					{
					}
					else
						m_nReturnPortalStep = Step_Training;

					if (CastStateSkill())
						return;
				}
				else
				{
					if(ReturnFromPortal() && m_nReturnPortalStep < Step_Return)

						return;
				}
				m_uTotalTime = IR_GetCurrentTime();

			}
			SortEquipment();

			int i = 0;
			int nCountNpcOverLook = 0;
			int nCountObjectOverLook = 0;
			for (i=0; i<MAX_AUTO_SIZE; i++)
			{
				if (m_nArrayNpcOverLook[i] > 0)
				{
					nCountNpcOverLook++;
					if (GetTickCount() - m_nArrayTimeNpcOverLook[i] > MAX_TIME_RESET_OVERLOOK)
					{
						m_nArrayNpcOverLook[i] = 0;
						m_nArrayTimeNpcOverLook[i] = 0;
					}
				}
				if (m_nArrayObjectOverLook[i] > 0)
				{
					nCountObjectOverLook++;
					if (GetTickCount() - m_nArrayTimeObjectOverLook[i] > MAX_TIME_RESET_OVERLOOK)
					{
						m_nArrayObjectOverLook[i] = 0;
						m_nArrayTimeObjectOverLook[i] = 0;
					}
				}
			}

			if (nCountNpcOverLook >= MAX_AUTO_SIZE)
			{
				ClearArrayNpcOverLook();
				ClearArrayTimeNpcOverLook();
			}

			if (nCountObjectOverLook >= MAX_AUTO_SIZE)
			{
				ClearArrayObjectOverLook();
				ClearArrayTimeObjectOverLook();
			}

			if (m_bAutoParty && m_bAutoInvite && Player[CLIENT_PLAYER_INDEX].m_cTeam.m_bCreatTeamFlag)
			{
				if (!Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag)
				{
					Player[CLIENT_PLAYER_INDEX].ApplyCreateTeam();
					ClearArrayInvitePlayer();
					ClearArrayTimeInvitePlayer();
			//		g_DebugLog("fdsfsdfsdf");
				}
				else
				{
					InviteParty();
				}
			//	g_DebugLog("fdsfsdfsdf 2");
			}

			if (m_bFollowPeople && m_szFollowName[0])
			{
				int		nNpc, nRegionNo, i;
				nNpc = SubWorld[0].m_Region[Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex].SearchNpcName(m_szFollowName);
				if(nNpc <= 0)
				{
					for (i = 0; i < 8; i++)
					{
						nRegionNo = SubWorld[0].m_Region[Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex].m_nConnectRegion[i];
						if ( nRegionNo < 0)
							continue;
						nNpc = SubWorld[0].m_Region[nRegionNo].SearchNpcName(m_szFollowName);
						if (nNpc > 0)
							break;
					}
				}
				if (nNpc)
				{
					int distance = NpcSet.GetDistance(Player[CLIENT_PLAYER_INDEX].m_nIndex, nNpc);
					if (distance > m_nFollowRadius)
					{
						int nX, nY;
						Npc[nNpc].GetMpsPos(&nX,&nY);
						MoveTo(nX, nY);
						//g_DebugLog("MoveTo(nX, nY); 4");

						m_nTargetIdx = 0;
						m_nObject = 0;
						m_nLifeOverLook = 0;
						m_nCount_Run_OverLook = 0;
						m_nCount_Attack_OverLook = 0;
						return;
					}
				}
			}

			if (!m_nObject)
			{
				m_nObject = GetNearObjectArray();
				if (m_nObject)
				{
					BOOL _flagOverLook = FALSE;
					for (i=0; i<MAX_AUTO_SIZE; i++)
					{
						if (m_nArrayObjectOverLook[i] == m_nObject)
						{
							_flagOverLook = TRUE;
							break;
						}
					}
					if (_flagOverLook)
					{
						m_nObject = 0;
						m_nLifeOverLook = 0;
						m_nCount_Run_OverLook = 0;
						m_nCount_Attack_OverLook = 0;
					}
					else
					{
						ItemPos	sItemPos;
						if (Object[m_nObject].m_nKind == Obj_Kind_Item)
						{
							if (FALSE == Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchPosition(
								Object[m_nObject].m_nItemWidth,
								Object[m_nObject].m_nItemHeight, &sItemPos, true))
							{
								m_nObject = 0;
								m_nLifeOverLook = 0;
								m_nCount_Run_OverLook = 0;
								m_nCount_Attack_OverLook = 0;
							}
						}
					}
				}
			}
			if (m_nObject > 0 )
			{
				if (FollowObject(m_nObject))
					return;
			}

			if (!m_nTargetIdx || (m_nTargetIdx && Npc[m_nTargetIdx].m_Kind == kind_normal))
			{
				i = GetNearNpcArray(relation_enemy);
				if (i > 0)
				{
					if(!m_nTargetIdx || Npc[i].m_Kind == kind_player)
					{
						m_nTargetIdx = i;

						BOOL _flagOverLook = FALSE;
						for (i=0; i<MAX_AUTO_SIZE; i++)
						{
							if (m_nArrayNpcOverLook[i] == m_nTargetIdx)
							{
								_flagOverLook = TRUE;
								break;
							}
						}
						if (_flagOverLook)
							m_nTargetIdx = 0;

						m_nLifeOverLook = 0;
						m_nCount_Run_OverLook = 0;
						m_nCount_Attack_OverLook = 0;
					}
				}
			}

			if (m_nTargetIdx)
			{
				if (FollowAttack(m_nTargetIdx))
					return;
			}

			if (m_bMoveMps)
				MoveMps();
		}
	}

	//TamLTM auto move map
	if (m_bAutoRunMap || m_bAutoRunFlagMap)
	{
		MoveToRunPlayer();
	}
	else
	{
		int nNpcIdx = Player[CLIENT_PLAYER_INDEX].m_nIndex;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier3 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier4 = FALSE;
	}
	//end code

	MoveQuanhDiem();
}


//TamLTM Chay quanh diem
int nDesX, nDesY;
void KPlayerAI::MoveQuanhDiem()
{
	int nNpcIdx = Player[CLIENT_PLAYER_INDEX].m_nIndex;

	if (Npc[nNpcIdx].m_Doing == do_attack ||
		Npc[nNpcIdx].m_Doing == do_skill ||
		Npc[nNpcIdx].m_Doing == do_magic ||
		Npc[nNpcIdx].m_Doing == do_goattack)
		return;

	if (m_bFightUseSB)
		return;

	//Fix lai
	if (m_bQuanhDiem == FALSE)
	{
		Npc[nNpcIdx].GetMpsPos(&nDesX, &nDesY);
	//	g_DebugLog("111111111111111");
	}
	else
	{
		int distance, newX, newY;
		Npc[nNpcIdx].GetMpsPos(&newX, &newY);
		distance = sqrt((nDesX - newX) * (nDesX - newX) + (nDesY - newY) * (nDesY - newY));
		//	g_DebugLog("m_nRadiusQuanhDiemXY %d", m_nRadiusQuanhDiemXY);

		if (distance <= 50)
		{
			m_bAttackNpc = TRUE;
			return;
		}

	//	g_DebugLog("distance %d", distance);
      if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == enumFightNone)
	    	return ;

		if (m_bAttackNpc == FALSE && m_bQuanhDiem == TRUE)
		{
			if (Npc[nNpcIdx].m_Doing == do_attack && distance <= 1000) // m_nRadiusQuanhDiemXY)
			{
			//	g_DebugLog("22222222222222");
				if (Npc[nNpcIdx].m_Doing == do_stand && m_bIsActive)
				{
					if (Npc[nNpcIdx].m_Doing == do_walk)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 1);
					}
					else
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 0);
					}
				}
			}
			else if (Npc[nNpcIdx].m_Doing == do_stand && m_bIsActive || distance >= 1000 && m_bIsActive)
			{
			//	g_DebugLog("33333333333333");
				m_bAttackNpc = FALSE;
				if (Npc[nNpcIdx].m_Doing == do_walk)
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 1);
				}
				else
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 0);
				}
			}
		}
		else if (m_bAttackNpc == TRUE && m_bQuanhDiem == TRUE)
		{
			if (Npc[nNpcIdx].m_Doing == do_attack && distance <= 1000) // m_nRadiusQuanhDiemXY)
			{
			//	g_DebugLog("4444444444444444444");
				if (Npc[nNpcIdx].m_Doing == do_stand && m_bIsActive)
				{
					if (Npc[nNpcIdx].m_Doing == do_walk)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 1);
					}
					else
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 0);
					}
				}
			}
			else if (Npc[nNpcIdx].m_Doing == do_stand && m_bIsActive || distance >= 1000 && m_bIsActive)
			{
			//	g_DebugLog("555555555555");
				m_bAttackNpc = FALSE;
				if (Npc[nNpcIdx].m_Doing == do_walk)
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 1);
				}
				else
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(nDesX, nDesY, 0);
				}
			}
		}
	}
}
//end code

//TamLTM tinh toan move map trong mini
int countRunPlayerMoveMap = 1;
int countRunPlayerFlagMoveMap = 1;
int isCheckMoveBarrier = 1;
int countIndexVaChamBarriers = 1;
int countIndexVaChamBarriers2 = 1;
int countIndexAutoRun = 0;
void KPlayerAI::MoveToRunPlayer()
{
	//Set Flag mini map auto run
	//Input box x y Auto run
	if (GetAsyncKeyState(VK_SPACE) & 0x80000000)
	{
		m_bAutoRunMap = FALSE;
		m_bAutoRunFlagMap = FALSE;
		countRunPlayerMoveMap = 1;
		countIndexVaChamBarriers = 1;
	}

	int nNpcIdx = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	if (m_bAutoRunMap && m_bIsActive == false || m_bAutoRunFlagMap && m_bIsActive == false)
	{
		int newX;
		int newY;
		if (m_bAutoRunFlagMap)
		{
			newX = Npc[nNpcIdx].m_nMoveToFlagMiniMapX;
			newY = Npc[nNpcIdx].m_nMoveToFlagMiniMapY;
		}
		else if (m_bAutoRunMap)
		{
			newX = m_nMapX * 8 * 32;
			newY = m_nMapY * 16 * 32;
		}

		//TamLTM Uu tien return neu su dung chuot
		if (GetAsyncKeyState(VK_LBUTTON) && Player[CLIENT_PLAYER_INDEX].m_nIndex) //Mouse left click button
		{
			countIndexAutoRun++;
			countIndexVaChamBarriers = 1;
			return;
		}

		if (Npc[nNpcIdx].m_Doing == do_walk && countIndexAutoRun == 1)
		{
			Npc[nNpcIdx].MoveToBarrierPlayer(newX + 145, newY + 145, 1); //Di bo
			countIndexAutoRun = 0;
		}
		else
		{
			//Check vi tri khi di chuyen 8 huong nhan vat
			//1 R->left //2 L->right //3 T->bottom //4 B->top

			int nX, nY;
			Npc[nNpcIdx].GetMpsPos(&nX, &nY);
			int nDir = g_GetDirIndex(nX, nY, newX, newY);

			if (Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 || Npc[nNpcIdx].m_bActivateAutoMoveBarrier3) //Left
			{
			//	g_DebugLog("dajsdkhaksd 1 %d", nDir);
				countIndexVaChamBarriers++;
				isCheckMoveBarrier++;

				if (isCheckMoveBarrier <= 35) // RLeft
				{
					if (nDir >= 0 && nDir <= 10) // Huong 6h down
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX + 50, newY - 100, 0); //Chay
						return;
					}

					if (nDir > 15 && nDir <= 25)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 25 && nDir <= 28)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 >= 40 && countIndexVaChamBarriers2 <= 80)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 31 && nDir <= 35)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 >= 30 && countIndexVaChamBarriers2 <= 60)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 35 && nDir <= 37)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY - 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 37 && nDir <= 41)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 41 && nDir <= 45)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 45 && nDir <= 55)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY - 100, 0); //Chay
						return;
					}

					if (nDir > 55 && nDir <= 64)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX - 50, newY - 100, 0); //Chay
						return;
					}
				}

				if (isCheckMoveBarrier == 36)
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 0);
				}

				if (isCheckMoveBarrier == 40)
				{
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier3 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier4 = FALSE;
					isCheckMoveBarrier = 1;
					countIndexVaChamBarriers2 = 1;
					Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 0);
				}
			}
			else if (Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 || Npc[nNpcIdx].m_bActivateAutoMoveBarrier4) //LRight
			{
				countIndexVaChamBarriers++;
				isCheckMoveBarrier++;

				if (isCheckMoveBarrier <= 35)
				{
					if (nDir >= 0 && nDir <= 4) // Huong 6h down
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 >= 40 && countIndexVaChamBarriers2 <= 90)
						{
							if (countIndexVaChamBarriers2 >= 60)
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY, 0); //Chay
							}
							else
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY + 100, 0); //Chay
							}
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 4 && nDir <= 10) // Huong 6h down
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY - 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 10 && nDir <= 16)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY + 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY + 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir > 25 && nDir <= 35)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 100, 0); //Chay
						return;
					}

					if (nDir > 45 && nDir <= 55)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 100, 0); //Chay
						return;
					}

					if (nDir > 55 && nDir <= 58)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY - 100, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 100, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}

					if (nDir >= 59 && nDir <= 64)
					{
						countIndexVaChamBarriers2++;

						if (countIndexVaChamBarriers2 <= 30)
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY, 0); //Chay
						}
						else
						{
							Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY, 0); //Chay
							if (countIndexVaChamBarriers2 >= 110)
								countIndexVaChamBarriers2 = 1;
						}
						return;
					}
				}

				if (isCheckMoveBarrier == 36)
				{
					Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 0);
				}

				if (isCheckMoveBarrier == 40)
				{
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier3 = FALSE;
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier4 = FALSE;
					isCheckMoveBarrier = 1;
					Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 0);
				}
			}
			else
			{
				isCheckMoveBarrier = 1;

				if (Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 == FALSE ||
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 == FALSE ||
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier3 == FALSE ||
					Npc[nNpcIdx].m_bActivateAutoMoveBarrier4 == FALSE)
				{
					//distance = sqrt( (x2 – x1) * (x2 – x1) + (y2 – y1) * (y2 – y1) );
					int distance, oldX1, oldY1;
					Npc[nNpcIdx].GetMpsPos(&oldX1, &oldY1);
					distance = sqrt((newX - oldX1) * (newX - oldX1) + (newY - oldY1) * (newY - oldY1));

					if (Npc[nNpcIdx].m_Doing == do_walk && countIndexAutoRun == 1)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 1); //di bo
						countIndexAutoRun = 0;
					}
					else if (distance >= 18410 && distance >= 17410 && countIndexAutoRun == 1 ||
							 distance <= 15410 && distance >= 14410 && countIndexAutoRun == 1)
					{
						Npc[nNpcIdx].MoveToBarrierPlayer(newX, newY, 0); //Chay
						countIndexAutoRun = 0;
					}
					else
					{
						if (countIndexVaChamBarriers <= 450)
						{
							if (distance <= 250)
							{
								m_bAutoRunMap = FALSE;
								m_bAutoRunFlagMap = FALSE;
								countIndexVaChamBarriers = 1;
							}
							else
							{
								countIndexVaChamBarriers++;
								Npc[nNpcIdx].MoveToBarrierPlayer(newX + 145, newY + 145, 0); //Chay
							}

							return;
						}

						if (distance <= 550)
						{
							countIndexVaChamBarriers2 = 1;
							countIndexVaChamBarriers = 1;
							return;
						}

						if (nDir >= 0 && nDir <= 16 || nDir >= 48 && nDir <= 64) // huong xuong trai
						{
						//	g_DebugLog("1 nDir %d - distance %d", nDir, distance);

							if (nDir >= 0 && nDir <= 4) // Huong 6h down
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 >= 40 && countIndexVaChamBarriers2 <= 90)
								{
									if (countIndexVaChamBarriers2 >= 60)
									{
										Npc[nNpcIdx].MoveToBarrierPlayer(nX + 380, nY, 0); //Chay
									}
									else
									{
										Npc[nNpcIdx].MoveToBarrierPlayer(nX + 250, nY + 145, 0); //Chay
									}
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX + 250, newY + 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 4 && nDir <= 10) // Huong 6h down
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 150, nY - 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 150, newY - 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 10 && nDir <= 16)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX + 150, nY + 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX + 150, newY + 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 25 && nDir <= 35)
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 245, 0); //Chay
								return;
							}

							if (nDir > 45 && nDir <= 55)
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 245, 0); //Chay
								return;
							}

							if (nDir > 55 && nDir <= 58)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY - 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY - 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir >= 59 && nDir <= 64)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 150, nY, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 150, newY, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}
						}
						else if (nDir >= 17 && nDir <= 47) // huong trai len
						{
						//	g_DebugLog("2 nDir %d - distance %d", nDir, distance);

							if (nDir >= 0 && nDir <= 10) // Huong 6h down
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(newX + 50, newY - 245, 0); //Chay
								return;
							}

							if (nDir > 15 && nDir <= 25)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY + 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 25 && nDir <= 28)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 40)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 150, nY + 250, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 150, newY + 250, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 31 && nDir <= 35)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX + 150, nY + 200, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX + 150, newY + 200, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 35 && nDir <= 37)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 120, nY - 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 120, newY - 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 37 && nDir <= 41)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX - 100, nY + 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX - 100, newY + 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 41 && nDir <= 45)
							{
								countIndexVaChamBarriers2++;

								if (countIndexVaChamBarriers2 <= 30)
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(nX + 100, nY + 245, 0); //Chay
								}
								else
								{
									Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY + 245, 0); //Chay
									if (countIndexVaChamBarriers2 >= 110)
										countIndexVaChamBarriers2 = 1;
								}
								return;
							}

							if (nDir > 45 && nDir <= 55)
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(newX + 100, newY - 245, 0); //Chay
								return;
							}

							if (nDir > 55 && nDir <= 64)
							{
								Npc[nNpcIdx].MoveToBarrierPlayer(newX - 50, newY - 245, 0); //Chay
								return;
							}
						}
					}
				}
			}
		}

		//Stop move khi dung` lai toa do da~ den'
		if (Npc[nNpcIdx].m_Doing == do_stand && isCheckMoveBarrier == 1)
		{
			countRunPlayerMoveMap++;

			if (countRunPlayerMoveMap == 4)
			{
				m_bAutoRunMap = FALSE;
				m_bAutoRunFlagMap = FALSE;
				countRunPlayerMoveMap = 1;
			}
		}
		else
		{
			countRunPlayerMoveMap = 1;
		}
	}
	else
	{
		m_bAutoRunMap = FALSE;
		m_bAutoRunFlagMap = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier1 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier2 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier3 = FALSE;
		Npc[nNpcIdx].m_bActivateAutoMoveBarrier4 = FALSE;
	}
}
//end code

BOOL KPlayerAI::CheckNpc(int nIndex)
{
	if (nIndex <= 0 || Npc[nIndex].m_SubWorldIndex != Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SubWorldIndex ||
		Npc[nIndex].m_RegionIndex < 0 ||
	   (Npc[nIndex].m_Kind == kind_player && (Npc[nIndex].m_FightMode == enumFightNone || m_bFollowPeople)) ||
	   (Npc[nIndex].m_Kind == kind_normal &&
	   (Npc[nIndex].m_btSpecial && m_nFightBoss == OverLookAllBoss) ||
	   (Npc[nIndex].m_btSpecial == npc_blue && m_nFightBoss == OverLookBlueBoss) ||
	   (Npc[nIndex].m_btSpecial == npc_gold && m_nFightBoss == OverLookGoldBoss) ||
	   (Npc[nIndex].m_btSpecial == npc_pink && m_nFightBoss == OverLookPinkBoss)) ||
	   (Npc[nIndex].m_Kind == kind_normal && !m_bAttackNpc) ||
		Npc[nIndex].m_CurrentLife <= 0 ||
		Npc[nIndex].m_CurrentLifeMax <= 0 ||
		Npc[nIndex].m_HideState.nTime > 0 ||
		Npc[nIndex].m_Doing == do_death ||
		Npc[nIndex].m_Doing == do_revive)
	{
		m_nTargetIdx = 0;
		m_nLifeOverLook = 0;
		m_nCount_Run_OverLook = 0;
		m_nCount_Attack_OverLook = 0;
		return TRUE;
	}
	return FALSE;
}

BOOL KPlayerAI::AddNpc2Array(int nRelation)
{
	int nRangeX = 0;
	int	nRangeY = 0;
	int	nSubWorldIdx = 0;
	int	nRegion = 0;
	int	nMapX = 0;
	int	nMapY = 0;
	if (m_nRadiusAuto <= 0)
		return FALSE;
	else
	{
		nRangeX = m_nRadiusAuto;
		nRangeY = m_nRadiusAuto;
	}

	nSubWorldIdx = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SubWorldIndex;
	nRegion = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex;
	nMapX = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapX;
	nMapY = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapY;

	int	nRet;
	int	nRMx, nRMy, nSearchRegion;

	nRangeX = nRangeX / SubWorld[nSubWorldIdx].m_nCellWidth;
	nRangeY = nRangeY / SubWorld[nSubWorldIdx].m_nCellHeight;

	ClearArrayNpcNeast();

	//TamLTM add code
/*	if (m_nFightBack == 1) //0
	{
		if (Npc[0].m_Kind == kind_player && UseItem(TownPortal) && m_nFightBack == 1)
		{
			m_uPortalCountDown = IR_GetCurrentTime();
			return FALSE;
		}
	}*/
	//end code

	for (int i = 0; i < nRangeX; i++)
	{
		for (int j = 0; j < nRangeY; j++)
		{
			if ((i * i + j * j) > nRangeX * nRangeX)
				continue;

			nRMx = nMapX + i;
			nRMy = nMapY + j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;
			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindNpc(nRMx, nRMy, Player[CLIENT_PLAYER_INDEX].m_nIndex, nRelation);
			if (Npc[nRet].m_HideState.nTime > 0)
				nRet = 0;
			if (nRet > 0)
			{
				if (m_nFightBack == 1) //1
				{
					if (Npc[nRet].m_Kind == kind_player && UseItem(TownPortal) && m_nFightBack == 1)
					{
						m_uPortalCountDown = IR_GetCurrentTime();
						return FALSE;
					}
				}
				if(Npc[nRet].m_Kind == kind_player && m_nFightBack == 2)
				{
					for (int k=0; k < (MAX_AUTO_SIZE/2); k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == (MAX_AUTO_SIZE/2))
						return TRUE;
				}
				else if(Npc[nRet].m_Kind == kind_normal)
				{
					for (int k=(MAX_AUTO_SIZE/2); k < MAX_AUTO_SIZE; k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == MAX_AUTO_SIZE)
						return TRUE;
				}
			}
			nRMx = nMapX - i;
			nRMy = nMapY + j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;
			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindNpc(nRMx, nRMy, Player[CLIENT_PLAYER_INDEX].m_nIndex, nRelation);
			if (Npc[nRet].m_HideState.nTime > 0)
				nRet = 0;

		//	g_DebugLog("%d", m_nFightBack);
			if (nRet > 0)
			{
				if (m_nFightBack == 1) //2
				{
					if (Npc[nRet].m_Kind == kind_player && UseItem(TownPortal))
					{
						m_uPortalCountDown = IR_GetCurrentTime();
						return FALSE;
					}
				}
				if(Npc[nRet].m_Kind == kind_player && m_nFightBack == 2)
				{
					for (int k=0; k < (MAX_AUTO_SIZE/2); k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == (MAX_AUTO_SIZE/2))
						return TRUE;
				}
				else if(Npc[nRet].m_Kind == kind_normal)
				{
					for (int k=(MAX_AUTO_SIZE/2); k < MAX_AUTO_SIZE; k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == MAX_AUTO_SIZE)
						return TRUE;
				}
			}
			nRMx = nMapX - i;
			nRMy = nMapY - j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;
			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindNpc(nRMx, nRMy, Player[CLIENT_PLAYER_INDEX].m_nIndex, nRelation);
			if (Npc[nRet].m_HideState.nTime > 0)
				nRet = 0;
			if (nRet > 0)
			{
				if (m_nFightBack == 1) //3
				{
					if (Npc[nRet].m_Kind == kind_player && UseItem(TownPortal))
					{
						m_uPortalCountDown = IR_GetCurrentTime();
						return FALSE;
					}
				}
				if(Npc[nRet].m_Kind == kind_player && m_nFightBack == 2)
				{
					for (int k=0; k < (MAX_AUTO_SIZE/2); k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == (MAX_AUTO_SIZE/2))
						return TRUE;
				}
				else if(Npc[nRet].m_Kind == kind_normal)
				{
					for (int k=(MAX_AUTO_SIZE/2); k < MAX_AUTO_SIZE; k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == MAX_AUTO_SIZE)
						return TRUE;
				}
			}
			nRMx = nMapX + i;
			nRMy = nMapY - j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;

			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindNpc(nRMx, nRMy, Player[CLIENT_PLAYER_INDEX].m_nIndex, nRelation);
			if (Npc[nRet].m_HideState.nTime > 0)
				nRet = 0;
			if (nRet > 0)
			{
				if (m_nFightBack == 1) //4
				{
					if (Npc[nRet].m_Kind == kind_player && UseItem(TownPortal))
					{
						m_uPortalCountDown = IR_GetCurrentTime();
						return FALSE;
					}
				}
				if(Npc[nRet].m_Kind == kind_player && m_nFightBack == 2)
				{
					for (int k=0; k < (MAX_AUTO_SIZE/2); k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == (MAX_AUTO_SIZE/2))
						return TRUE;
				}
				else if(Npc[nRet].m_Kind == kind_normal)
				{
					for (int k=(MAX_AUTO_SIZE/2); k < MAX_AUTO_SIZE; k++)
					{
						if (m_nArrayNpcNeast[k] == 0)
						{
							m_nArrayNpcNeast[k] = nRet;
							break;
						}
					}
					if(k == MAX_AUTO_SIZE)
						return TRUE;
				}
			}
		}
	}
	return TRUE;
}

BOOL KPlayerAI::AddObject2Array()
{
	int nRangeX = 0;
	int	nRangeY = 0;
	int	nSubWorldIdx = 0;
	int	nRegion = 0;
	int	nMapX = 0;
	int	nMapY = 0;

	if (m_nRadiusAuto <= 0)
		return FALSE;
	else
	{
		nRangeX = m_nRadiusAuto;
		nRangeY = m_nRadiusAuto;
	}

	nSubWorldIdx = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SubWorldIndex;
	nRegion = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_RegionIndex;
	nMapX = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapX;
	nMapY = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_MapY;

	int	nRet;
	int	nRMx, nRMy, nSearchRegion;

	nRangeX = nRangeX / SubWorld[nSubWorldIdx].m_nCellWidth;
	nRangeY = nRangeY / SubWorld[nSubWorldIdx].m_nCellHeight;

	ClearArrayObjectNeast();

	for (int i = 0; i < nRangeX; i++)
	{
		for (int j = 0; j < nRangeY; j++)
		{
			if ((i * i + j * j) > nRangeX * nRangeX)
				continue;

			nRMx = nMapX + i;
			nRMy = nMapY + j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;

			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindObject(nRMx, nRMy, true);
			if (nRet > 0)
			{
				for (int k=0; k < MAX_AUTO_SIZE; k++)
				{
					if (m_nArrayObjectNeast[k] == 0)
					{
						m_nArrayObjectNeast[k] = nRet;
						break;
					}
				}
				if(k == MAX_AUTO_SIZE)
					return TRUE;
			}
			nRMx = nMapX - i;
			nRMy = nMapY + j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;

			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindObject(nRMx, nRMy, true);
			if (nRet > 0)
			{
				for (int k=0; k < MAX_AUTO_SIZE; k++)
				{
					if (m_nArrayObjectNeast[k] == 0)
					{
						m_nArrayObjectNeast[k] = nRet;
						break;
					}
				}
				if(k == MAX_AUTO_SIZE)
					return TRUE;
			}
			nRMx = nMapX - i;
			nRMy = nMapY - j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;

			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindObject(nRMx, nRMy, true);
			if (nRet > 0)
			{
				for (int k=0; k < MAX_AUTO_SIZE; k++)
				{
					if (m_nArrayObjectNeast[k] == 0)
					{
						m_nArrayObjectNeast[k] = nRet;
						break;
					}
				}
				if(k == MAX_AUTO_SIZE)
					return TRUE;
			}
			nRMx = nMapX + i;
			nRMy = nMapY - j;
			nSearchRegion = nRegion;
			if (nRMx < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[2];
				nRMx += SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			else if (nRMx >= SubWorld[nSubWorldIdx].m_nRegionWidth)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[6];
				nRMx -= SubWorld[nSubWorldIdx].m_nRegionWidth;
			}
			if (nSearchRegion == -1)
				continue;
			if (nRMy < 0)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[4];
				nRMy += SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			else if (nRMy >= SubWorld[nSubWorldIdx].m_nRegionHeight)
			{
				nSearchRegion = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].m_nConnectRegion[0];
				nRMy -= SubWorld[nSubWorldIdx].m_nRegionHeight;
			}
			if (nSearchRegion == -1)
				continue;

			nRet = SubWorld[nSubWorldIdx].m_Region[nSearchRegion].FindObject(nRMx, nRMy, true);
			if (nRet > 0)
			{
				for (int k=0; k < MAX_AUTO_SIZE; k++)
				{
					if (m_nArrayObjectNeast[k] == 0)
					{
						m_nArrayObjectNeast[k] = nRet;
						break;
					}
				}
				if(k == MAX_AUTO_SIZE)
					return TRUE;
			}
		}
	}
	return TRUE;
}

int KPlayerAI::GetNearNpcArray(int nRelation)
{
	int nRet = 0;
	if(AddNpc2Array(nRelation))
	{
		int distance = 0 ;
		int distanceMin = 0 ;
		BOOL _fg = FALSE;
		int i = 0;
		int j = 0;
		for (i=0; i < MAX_AUTO_SIZE; i++)
		{
			if (m_nArrayNpcNeast[i] > 0)
			{
				BOOL _findOverLook = FALSE;
				for (j=0; j < MAX_AUTO_SIZE; j++)
				{
					if (m_nArrayNpcNeast[i] == m_nArrayNpcOverLook[j])
					{
						_findOverLook = TRUE;
						break;
					}
				}
				if (_findOverLook == TRUE)
					continue;
				if (CheckNpc(m_nArrayNpcNeast[i]))
					continue;
				int nX, nY;
				Npc[m_nArrayNpcNeast[i]].GetMpsPos(&nX, &nY);

				distance = NpcSet.GetDistance(Player[CLIENT_PLAYER_INDEX].m_nIndex, m_nArrayNpcNeast[i]);
				if (FALSE == _fg)
				{
					distanceMin = distance;
					_fg = TRUE;
					nRet = m_nArrayNpcNeast[i];
				}
				if (distance <= distanceMin)
				{
					distanceMin = distance;
					nRet = m_nArrayNpcNeast[i];
				}
			}
		}
	}
	return nRet;
}

int KPlayerAI::GetNearObjectArray()
{
	int nRet = 0 ;
	if (AddObject2Array())
	{
		int distance = 0 ;
		int distanceMin = 0 ;
		BOOL _fg = FALSE;
		for (int i=0; i < MAX_AUTO_SIZE; i++)
		{
			if (m_nArrayObjectNeast[i] != 0)
			{
				BOOL _findOverLook = FALSE;
				for (int j=0; j < MAX_AUTO_SIZE; j++)
				{
					if (Object[m_nArrayObjectNeast[i]].m_nID == m_nArrayObjectOverLook[j])
					{
						_findOverLook = TRUE;
						break;
					}
				}
				if (_findOverLook == TRUE)
					continue;
				if (CheckObject(m_nArrayObjectNeast[i]))
					continue;
				int nX, nY;
				Object[m_nArrayObjectNeast[i]].GetMpsPos(&nX, &nY);

				distance = Object[m_nArrayObjectNeast[i]].GetDistanceSquare(Player[CLIENT_PLAYER_INDEX].m_nIndex);
				if (FALSE == _fg)
				{
					distanceMin = distance ;
					_fg = TRUE;
					nRet = m_nArrayObjectNeast[i];
				}
				if (distance <= distanceMin)
				{
					distanceMin = distance ;
					nRet = m_nArrayObjectNeast[i];
				}
			}
		}
	}
	return nRet;
}

#define PLAYERAUTO_PICKUP_CLIENT_DISTANCE PLAYER_PICKUP_CLIENT_DISTANCE
BOOL KPlayerAI::CheckObject(int nObject)
{
	//TamLTM fix khi truong hop dang danh thi thoat ra ko cho chay
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill )
		return FALSE;
	//end code

	if (!m_bPickFightNone && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == enumFightNone)
		return TRUE;

	if (nObject > 0 && nObject < MAX_OBJECT)
	{
		if(Object[nObject].m_bOverLook && !m_bPickFightNone && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == enumFightActive)
			return TRUE;

		if(!m_bFollowPick) // Chay den nhat
		{
			int nX1, nY1, nX2, nY2;
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&nX1, &nY1);
			Object[nObject].GetMpsPos(&nX2, &nY2);

			if ((nX1 - nX2) * (nX1 - nX2) + (nY1 - nY2) * (nY1 - nY2) > PLAYERAUTO_PICKUP_CLIENT_DISTANCE * PLAYERAUTO_PICKUP_CLIENT_DISTANCE)
				return FALSE;
		}

	//	g_DebugLog("m_bFollowPick 2 %d", m_bFollowPick);

		if (Object[nObject].m_nKind == Obj_Kind_Money /*&& m_bFollowPick*/)
		{
			if (m_bPickMoney)
				return FALSE;
		}
		else if (Object[nObject].m_nKind == Obj_Kind_Item  /*&& m_bFollowPick*/)
		{
			if (Object[nObject].m_nGenre == item_equip  /*&& m_bFollowPick*/)
			{
				if (m_bPickEquip)
				{
					if (Object[nObject].m_nDetailType >= equip_horse &&
						Object[nObject].m_nDetailType < equip_detailnum)
						return FALSE;

					if (m_nPickEquipKind == enumPickEquipAll)
						return FALSE;
					else if (m_nPickEquipKind == enumPickEquipJewelry)
					{
						if (CheckEquip(Object[nObject].m_nDetailType))
							return FALSE;
					}
					else if (m_nPickEquipKind == enumPickEquipHaveMagic)
					{
						if (Object[nObject].m_nColorID > equip_normal &&
							Object[nObject].m_nColorID < equip_number)
							return FALSE;
					}
				}
			}
			else
			{
				if (m_bPickNotEquip)
					return FALSE;
			}
		}
	}
	return TRUE;
}

BOOL KPlayerAI::CheckEquip(BYTE btDetail)
{
	if (btDetail == equip_ring ||
		btDetail == equip_amulet ||
		btDetail == equip_pendant)
		return TRUE;
	return FALSE;
}

BOOL KPlayerAI::CheckEquipMagic(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM)
		return FALSE;

	int i, j;
	for (i = 0; i < MAX_AUTO_FILTERL; i++)
	{
		if (m_nFilterMagic[i][0])
		{
			for (j = 0; j < MAX_ITEM_MAGICATTRIB; j++)
			{
				if (Item[nIdx].m_aryMagicAttrib[j].nAttribType == m_nFilterMagic[i][0] &&
					Item[nIdx].m_aryMagicAttrib[j].nValue[0] >= m_nFilterMagic[i][1])
					return TRUE;
			}
		}
	}
	return FALSE;
}

//Ham attack theo va attack npc chay lien tuc
int isStandOutTimer = 0;
BOOL KPlayerAI::FollowAttack(int i)
{
	if ( CheckNpc(i) )
	{
		return FALSE;
	}

	//Check click point
//	if (GetAsyncKeyState(VK_LBUTTON))
//	{
	//	return FALSE;
//	}

	//Su dung space de danh
	if (m_bFightUseSB && !m_bHoldSpaceBar)
	{
		return FALSE;
	}

	if (m_nCount_Attack_OverLook >= MAX_TIME_OVERLOOK || m_nCount_Run_OverLook >= MAX_TIME_OVERLOOK)
	{
		for (int j=0; j < MAX_AUTO_SIZE; j++)
		{
			if (m_nArrayNpcOverLook[j] == 0)
			{
				m_nArrayNpcOverLook[j] = i;
				m_nArrayTimeNpcOverLook[j] = GetTickCount();
				m_nTargetIdx = 0;
				m_nLifeOverLook = 0;
				m_nCount_Run_OverLook = 0;
				m_nCount_Attack_OverLook = 0;
				return FALSE;
			}
		}
	}

	int nIdx = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.FindSame(Player[CLIENT_PLAYER_INDEX].GetLeftSkill());
	if (m_nFightSkill)
		nIdx = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.FindSame(m_nFightSkill);
	if (nIdx)
	{
		if(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID == nIdx)
		{
		}
		else
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SetActiveSkill(nIdx);
	}

	int distance = NpcSet.GetDistance(Player[CLIENT_PLAYER_INDEX].m_nIndex, i);
	int distanceskill = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentAttackRadius;

	if (m_bFightNear)
	{
		distanceskill = m_nDistanceAuto;
		if (distanceskill > Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentAttackRadius)
			distanceskill = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentAttackRadius;
	}

	//TamLTM Ne' goc lag auto move Barrier
/*	isStandOutTimer++;
	if (isStandOutTimer >= 50 && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_stand ||
		isStandOutTimer >= 50 && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ClientDoing == cdo_stand ||
		isStandOutTimer >= 50 && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ClientDoing == cdo_attack)
	{
		int nDesX, nDesY;
		Npc[i].GetMpsPos(&nDesX, &nDesY);
		MoveTo(nDesX + 50, nDesY + 50);
		isStandOutTimer = 0;
	}*/

	if (distance <= distanceskill && distance <= m_nRadiusAuto)
	{
		//Check truong hop attack miss npc then move player to other object ne' goc
		if (m_AttackNumberMiss)
			m_AttackNumberMiss++;

		if (m_AttackNumberMiss >= 70)
		{
			if (m_AttackNumberMiss == 82)
			{
				m_AttackNumberMiss = 1;
				isStandOutTimer = 0;
			//	m_nCount_Run_OverLook = 0;
			}

			//Check neu su dung di chuyen toa do quanh diem, thi bo? qua move lien tuc

			if (m_bFollowRadius)
				return TRUE;

			//Move player if attack miss npc
			if (m_bFollowTarget)
			{
				int nDesX, nDesY;
				Npc[i].GetMpsPos(&nDesX, &nDesY);
				MoveTo(nDesX + 80, nDesY + 80);
				return TRUE;
			}
		}
		else
		{
		/*	if (GetKeyState('S') < 0) {
				// The S key is down.
				g_DebugLog("m_bFollowTarget ssssss");
			}
			else {
				// The S key is up.
			}*/

			//TamLTM fix khi thi trien skill
			if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_goattack ||
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill)
			{
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nCheckAutoMoveBarrier = 0;//TamLTM
				m_IgnoreCornerLag = 1;

				return FALSE;
			}
			//End code TamLTM fix tu danh;

			KSkill* pSkill = (KSkill*)g_SkillManager.GetSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, 1);
			if (pSkill)
			{
				if (pSkill->GetHorseLimit())
				{
					switch (pSkill->GetHorseLimit())
					{
					case 1:
						if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_bRideHorse)
							SendClientCmdRide();
						break;
					case 2:
						if (!Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_bRideHorse)
							SendClientCmdRide();
						break;
					}
				}

				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, i);
				SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[i].m_dwID);

				if (m_nLifeOverLook == Npc[i].m_CurrentLife)
				{
					Npc[CLIENT_PLAYER_INDEX].GetCheckAutoMoveBarr(FALSE); //TamLTM
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nCheckAutoMoveBarrier = 0;//TamLTM

					if (!m_bOverTarget && Npc[i].m_Kind == kind_normal)
					{
						m_nCount_Attack_OverLook++;
					}
				}
				else
				{
					m_nCount_Attack_OverLook = 0;
					m_AttackNumberMiss = 1; // set lai timer = 1 neu follow other object npc
					m_IgnoreCornerLag = 1; //
					isStandOutTimer = 0; // reset stand
					//g_DebugLog("OVER Tim doi tuong m_nCount_Attack_OverLook = 0");
				}

				m_nLifeOverLook = Npc[i].m_CurrentLife;
			}
			m_nCount_Run_OverLook = 0;
		//	pSkill = NULL;
		}
		//end code
		return TRUE;
	}
	else
	{
		if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nCheckAutoMoveBarrier == 1 && m_bIsActive)
		{
			//TamLTM Ne' goc lag auto move Barrier
			if (m_IgnoreAttackMiss)
				m_IgnoreAttackMiss++;

			m_IgnoreCornerLag = 1;

			if (m_IgnoreAttackMiss == 10)
			{
				Npc[CLIENT_PLAYER_INDEX].GetCheckAutoMoveBarr(TRUE);

			//	int nX, nY;
			//	Npc[i].GetMpsPos(&nX, &nY);
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nCheckAutoMoveBarrier = 0;
			//	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].MoveToBarrierPlayer(nX, nY, 0);
				m_IgnoreAttackMiss = 1;
			//	g_DebugLog("m_nCheckAutoMoveBarrier 1");
			}
			//end code
		}
		else
		{
			if (m_IgnoreCornerLag)
				m_IgnoreCornerLag++;
			if (m_IgnoreCornerLag >= 10)
			{
				int nDesX, nDesY;
				Npc[i].GetMpsPos(&nDesX, &nDesY);
				MoveTo(nDesX + 40, nDesY + 40);

				if (!m_bOverTarget)
					m_nCount_Run_OverLook++;

				if (m_IgnoreCornerLag == 15)
					m_IgnoreCornerLag = 1;

				return TRUE;
			}
			else
			{
				if (m_bFollowTarget)
				{
					int nDesX, nDesY;
					Npc[i].GetMpsPos(&nDesX, &nDesY);
					MoveTo(nDesX, nDesY);

					if (!m_bOverTarget/* && Npc[i].m_Kind== kind_normal*/)
						m_nCount_Run_OverLook++;
					return TRUE;
				}
			}
		}
	}

	return FALSE;
}

//Dat thiet bi sap xep
void KPlayerAI::SetSortEquipment(BOOL bFlag)
{
	if (m_bIsActive)
	{
		for (int i = MAX_EQUIPMENT_ITEM - 1; i > 0 ; i--)
		{
			m_sListEquipment.m_Link.Remove(i);
		}
		m_bSortEquipment = bFlag;
	}
}

//Sap xep trang bi
void KPlayerAI::SortEquipment()
{
	if (m_bSortEquipment)
	{
		int nHand = Player[CLIENT_PLAYER_INDEX].m_ItemList.Hand();
		if (nHand)
		{
			ItemPos	P;
			if ( FALSE == Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchPosition(Item[nHand].GetWidth(), Item[nHand].GetHeight(), &P) )
			{
				m_bSortEquipment = FALSE;
				return;
			}
			Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
			if (!m_sListEquipment.FindSame(nHand))
			{
				m_sListEquipment.m_Link.Insert(nHand);
			}
		}
		else
		{
			ItemPos	P;
			PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();

			if (pItem)
			{
				if (pItem->nPlace == pos_equiproom)
				{
					if (!m_sListEquipment.FindSame(pItem->nIdx))
					{
						P.nPlace = pItem->nPlace;
						P.nX = pItem->nX;
						P.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
						return;
					}
				}
			}

			while(pItem)
			{
				pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetNextItem();
				if (pItem)
				{
					if (pItem->nPlace == pos_equiproom)
					{
						if (!m_sListEquipment.FindSame(pItem->nIdx))
						{
							P.nPlace = pItem->nPlace;
							P.nX = pItem->nX;
							P.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
							return;
						}
					}
				}
			}
			m_bSortEquipment = FALSE;
		}
	}
}

//Loc trang bi
int countIdxItemHand = 0;
int checkWhileIdxItemHand = 0;
int countTimer = 0;
void KPlayerAI::FilterEquip()
{
/*	//Code cu loc do trang bi
	if(m_bSortEquipment)
		return;
	if (Player[CLIENT_PLAYER_INDEX].m_bLockState)
		return;

//	if (m_bFilterEquipment)
//	{
		int nHand = Player[CLIENT_PLAYER_INDEX].m_ItemList.Hand();
		if (nHand)
		{

            if (Item[nHand].GetSetID() <= 0 && Item[nHand].GetGenre() == item_equip &&
				Item[nHand].GetDetailType() < equip_horse)   // day ne
            {
                if(CheckEquipMagic(nHand))	//xu ly khi dang xep do khong loc do
				return;
		     	if(m_bSaveJewelry && CheckEquip(Item[nHand].GetDetailType())) //xu ly khi dang xep do khong loc do
				return;

			SendClientCmdDropItem(Item[nHand].GetID());
		}
   }
		else
		{
			PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();

			if (pItem)
			{
				if ((pItem->nPlace == pos_equiproom || pItem->nPlace == pos_equiproomex) &&
					Item[pItem->nIdx].GetGenre() == item_equip &&
                    Item[pItem->nIdx].GetDetailType() < equip_horse)
				{
					BOOL bMatch = TRUE;
					if (Item[pItem->nIdx].GetSetID() > 0)
						bMatch = FALSE;
					else if (Item[pItem->nIdx].GetLock()->IsLock() ||
						Item[pItem->nIdx].GetLockDrop() ||
						Item[pItem->nIdx].GetSetID() > 0)
						bMatch = FALSE;
					else if (Item[pItem->nIdx].GetGenre() == item_equip &&
						(Item[pItem->nIdx].GetDetailType() == equip_horse))
						bMatch = FALSE;
					else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
						bMatch = FALSE;
					else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
						bMatch = FALSE;
					else
					{
						if (CheckEquipMagic(pItem->nIdx))
							bMatch = FALSE;
					}
					if (bMatch)
					{
						ItemPos	P;
                      	P.nPlace = pItem->nPlace;
						P.nX = pItem->nX;
						P.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
						return;
					}
				}
			}

			while(pItem)
			{
				pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetNextItem();
				if (pItem)
				{
					if ((pItem->nPlace == pos_equiproom || pItem->nPlace == pos_equiproomex) &&
					Item[pItem->nIdx].GetGenre() == item_equip &&
                    Item[pItem->nIdx].GetDetailType() < equip_horse)
			    	{
						BOOL bMatch = TRUE;
					if (Item[pItem->nIdx].GetSetID() > 0)
						bMatch = FALSE;
					else if (Item[pItem->nIdx].GetLock()->IsLock() ||
						Item[pItem->nIdx].GetLockDrop() ||
						Item[pItem->nIdx].GetSetID() > 0)
						bMatch = FALSE;
					else if (Item[pItem->nIdx].GetGenre() == item_equip &&
						(Item[pItem->nIdx].GetDetailType() == equip_horse))
						bMatch = FALSE;
					else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
						bMatch = FALSE;
					else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
						bMatch = FALSE;
					else
					{
						if (CheckEquipMagic(pItem->nIdx))
							bMatch = FALSE;
					}
						if (bMatch)
						{
							ItemPos	P;
                           	P.nPlace = pItem->nPlace;
							P.nX = pItem->nX;
							P.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
							return;
						}
					}
				}
			}
		}
	}*/

	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_goattack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic)
		return;


	//Sort item
/*	if (m_bAttackNpc == FALSE)
	{
		m_bSortEquipment = FALSE;
	}
	else if (m_bAttackNpc == TRUE)
	{
		m_bSortEquipment = TRUE;
	} // end code*/

	//TamLTM fix lai loc do trang bi
	if (m_bSortEquipment)
		return;
	if (Player[CLIENT_PLAYER_INDEX].m_bLockState)
		return;

//	if (m_bFilterEquipment)
//	{
		int nHand = Player[CLIENT_PLAYER_INDEX].m_ItemList.Hand();
		if (nHand)
		{
			if (Item[nHand].GetSetID() <= 0 && Item[nHand].GetGenre() == item_equip &&
				Item[nHand].GetDetailType() < equip_detailnum)   // day ne
			   {
            if(CheckEquipMagic(nHand))	//xu ly khi dang xep do khong loc do
				return;
		     	if(m_bSaveJewelry && CheckEquip(Item[nHand].GetDetailType())) //xu ly khi dang xep do khong loc do
				return;
				SendClientCmdDropItem(Item[nHand].GetID());

				countIdxItemHand++;
				m_bAttackNpc = FALSE;

				int x, y;
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&x, &y);
				if (countIdxItemHand == 1)
				{
					MoveTo(x + 80, y + 80);
				}
				else if (countIdxItemHand == 2)
				{
					MoveTo(x + 80, y);
				}
				else if (countIdxItemHand == 3)
				{
					MoveTo(x, y - 80);
				}
				else if (countIdxItemHand == 4)
				{
					MoveTo(x + 80, y - 80);
				}
				else if (countIdxItemHand == 5)
				{
					MoveTo(x - 80, y);
				}
				else
				{
					MoveTo(x + 80, y + 80);
					countIdxItemHand = 0;
				}

				m_bNotGetEquipment = TRUE;
				m_bAttackNpc = TRUE;
				countTimer = 0;
			}
		}
		else
		{
			ItemPos	P;
			PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();

			countTimer++;
			if (countTimer == 6)
			{
				m_bNotGetEquipment = FALSE;
				countTimer = 0;
			}

			if (m_bAttackNpc == FALSE)
			{
				return;
			}
			else if (m_bAttackNpc == TRUE)
			{
				m_bAttackNpc = TRUE;
			}

			if (pItem)
			{
				if (pItem->nPlace == pos_equiproom &&
					Item[pItem->nIdx].GetGenre() == item_equip &&
					Item[pItem->nIdx].GetDetailType() < equip_detailnum)
				{
					BOOL bFilter = TRUE;
					if (Item[pItem->nIdx].GetSetID() > 0)
						bFilter = FALSE;
					else if (Item[pItem->nIdx].GetLock()->IsLock() ||
						Item[pItem->nIdx].GetLockDrop() ||
						Item[pItem->nIdx].GetSetID() > 0)
						bFilter = FALSE;
					else if (Item[pItem->nIdx].GetGenre() == item_equip &&
						(Item[pItem->nIdx].GetDetailType() == equip_horse))
						bFilter = FALSE;
					else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
						bFilter = FALSE;
					else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
						bFilter = FALSE;
					else
					{
						if (CheckEquipMagic(pItem->nIdx))
							bFilter = FALSE;
					}

					if (bFilter)
					{
						P.nPlace = pItem->nPlace;
						P.nX = pItem->nX;
						P.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
						return;
					}
				}
			}

			int n = 0;

			while (pItem)
			{
				pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetNextItem();
				n++;
				if (pItem)
				{
					checkWhileIdxItemHand++;

					if (checkWhileIdxItemHand <= 54)
					{
						countIdxItemHand = 0;
						checkWhileIdxItemHand = 0;
						return;
					}

					if (pItem->nPlace == pos_equiproom &&
						Item[pItem->nIdx].GetGenre() == item_equip &&
						Item[pItem->nIdx].GetDetailType() < equip_detailnum)
					{
						BOOL bFilter = TRUE;
						if (Item[pItem->nIdx].GetSetID() > 0)
							bFilter = FALSE;
						else if (Item[pItem->nIdx].GetLock()->IsLock() ||
							Item[pItem->nIdx].GetLockDrop() ||
							Item[pItem->nIdx].GetSetID() > 0)
							bFilter = FALSE;
						else if (Item[pItem->nIdx].GetGenre() == item_equip &&
							(Item[pItem->nIdx].GetDetailType() == equip_horse))
							bFilter = FALSE;
						else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
							bFilter = FALSE;
						else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
							bFilter = FALSE;
						else
						{
							if (CheckEquipMagic(pItem->nIdx))
								bFilter = FALSE;
						}

						if (bFilter)
						{
							P.nPlace = pItem->nPlace;
							P.nX = pItem->nX;
							P.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
							return;
						}
					}
				}
			}
		}
	}
	//end code

    // bien cuc bo
	int countItem = 0;
	int openShop = 0;

//Son fix cat do vao ruong
BOOL KPlayerAI::InventoryItem()
{
    int nHand = Player[CLIENT_PLAYER_INDEX].m_ItemList.Hand();
    if (nHand)
    {
        POINT pPos;
        for(int nRoom = room_repository; nRoom <= room_repository+Player[CLIENT_PLAYER_INDEX].m_btRepositoryNum && nRoom <= room_repository5; nRoom++)
        {
            if(Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Room[nRoom].FindRoom(Item[nHand].GetWidth(), Item[nHand].GetHeight(), &pPos))
            {
                ItemPos	P;
                P.nPlace = pos_repositoryroom+nRoom-room_repository;
                P.nX = pPos.x;
                P.nY = pPos.y;
                Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
                return FALSE;
            }
        }
        return TRUE;
    }
    else
    {
        ItemPos	P;
        PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();

        if (pItem)
        {
            if (pItem->nPlace == pos_equiproom || pItem->nPlace == pos_equiproomex)
            {
                BOOL bMatch = FALSE;
                if (Item[pItem->nIdx].GetSetID() > 0)
                    bMatch = TRUE;
                else if(Item[pItem->nIdx].m_CommonAttrib.nItemGenre == item_task)
                    bMatch = TRUE;
                else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
                    bMatch = TRUE;
                else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
                    bMatch = TRUE;
                else
                {
                    if (CheckEquipMagic(pItem->nIdx))
                        bMatch = TRUE;
                }
                if (bMatch)
                {
                    POINT pPos;
                    for(int nRoom = room_repository; nRoom <= room_repository+Player[CLIENT_PLAYER_INDEX].m_btRepositoryNum && nRoom <= room_repository5; nRoom++)
                    {
                        if(Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Room[nRoom].FindRoom(Item[pItem->nIdx].GetWidth(), Item[pItem->nIdx].GetHeight(), &pPos))
                        {
                            ItemPos	P;
                            P.nPlace = pItem->nPlace;
                            P.nX = pItem->nX;
                            P.nY = pItem->nY;
                            Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
                            return FALSE;
                        }
                    }
                    return TRUE;
                }
            }
        }

        while(pItem)
        {
            pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetNextItem();
            if (pItem)
            {
                if (pItem->nPlace == pos_equiproom)
                {
                    BOOL bMatch = FALSE;
                    if (Item[pItem->nIdx].GetSetID() > 0)
                        bMatch = TRUE;
                    else if(Item[pItem->nIdx].m_CommonAttrib.nItemGenre == item_task)
                        bMatch = TRUE;
                    else if (m_bSaveTrash && Item[pItem->nIdx].GetSalePrice() >= m_nSaveTrashPrice)
                        bMatch = TRUE;
                    else if (m_bSaveJewelry && CheckEquip(Item[pItem->nIdx].GetDetailType()))
                        bMatch = TRUE;
                    else
                    {
                        if (CheckEquipMagic(pItem->nIdx))
                            bMatch = TRUE;
                    }
                    if (bMatch)
                    {
                        POINT pPos;
                        for(int nRoom = room_repository; nRoom <= room_repository+Player[CLIENT_PLAYER_INDEX].m_btRepositoryNum && nRoom <= room_repository5; nRoom++)
                        {
                            if(Player[CLIENT_PLAYER_INDEX].m_ItemList.m_Room[nRoom].FindRoom(Item[pItem->nIdx].GetWidth(), Item[pItem->nIdx].GetHeight(), &pPos))
                            {
                                ItemPos	P;
                                P.nPlace = pItem->nPlace;
                                P.nX = pItem->nX;
                                P.nY = pItem->nY;
                                Player[CLIENT_PLAYER_INDEX].MoveItem(P, P);
                                return FALSE;
                            }
                        }
                        return TRUE;
                    }
                }
            }
        }
    }
    return TRUE;
}

//Chuyen doi vong sang skill
void KPlayerAI::SwitchAura()
{
	if (m_bIsActive)
	{
		if (m_nActiveAuraID1 && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].IsNpcSkillExist(m_nActiveAuraID1) &&
			m_nActiveAuraID2 && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].IsNpcSkillExist(m_nActiveAuraID2))
		{
			if(KSG_GetCurSec() % 2 == 0)
				Player[CLIENT_PLAYER_INDEX].SetRightSkill((int)m_nActiveAuraID1);
			else
				Player[CLIENT_PLAYER_INDEX].SetRightSkill((int)m_nActiveAuraID2);
		}
	}
}

//Can mau
void KPlayerAI::EatItem()
{
	if(m_bEatLife)
	{
		if ((m_nLifeAutoP && (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife * MAX_PERCENT / Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLifeMax) < m_nLifeAutoP) ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife < m_nLifeAutoV)
		{
			if (IR_GetCurrentTime() - m_uLifeCountDown > m_uLifeTimeUse)
			{
				if(UseItem(Blood))
				{
				//	g_DebugLog("m_bEatLife4  %d", m_bEatLife);
					m_uLifeCountDown = IR_GetCurrentTime();
				}
			}
		}
	}
	if(m_bEatMana)
	{
		if ((m_nManaAutoP && (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentMana * MAX_PERCENT / Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentManaMax) < m_nManaAutoP) ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentMana < m_nManaAutoV)
		{
			if (IR_GetCurrentTime() - m_uManaCountDown > m_uManaTimeUse)
			{
				if (UseItem(Mana))
				{
					//g_DebugLog("m_bEatMana  %d", m_bEatMana);
					m_uManaCountDown = IR_GetCurrentTime();
				}
			}
		}
	}
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode)
	{
		bool bTPFlag = false;
		if ((m_bTPNotMedicineBlood && Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_blood) <= 0 &&
			 Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_both) <= 0) ||
			(m_bTPNotMedicineMana && Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_mana) <= 0 &&
			 Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_both) <= 0)
			 )
		{
		//	g_DebugLog("m_bOpenMedicine 0 %d", medicine_blood);
			if (m_bOpenMedicine) // Mo tui mau
			{
				if (IR_GetCurrentTime() - m_uOpenMedicineCountDown > MAX_TIME_SPACE)
				{
			//		g_DebugLog("m_bOpenMedicine 1");
					if (UseItem(MecidineBag))
					{
						m_uOpenMedicineCountDown = IR_GetCurrentTime();
			//			g_DebugLog("m_bOpenMedicine 2");
					}
				}
				else
					bTPFlag = true;
			}
			else
				bTPFlag = true;
		}

		//Check sl nl
		if ((m_bTPLife && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife < m_nTPLifeV) ||
			(m_bTPMana && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentMana < m_nTPManaV) ||
			(m_bTPHightMoney && Player[CLIENT_PLAYER_INDEX].m_ItemList.GetEquipmentMoney() > MONEY_FLOOR && Player[CLIENT_PLAYER_INDEX].m_ItemList.GetEquipmentMoney() / MONEY_FLOOR > m_nTPHightMoneyV) ||
			(m_bTPDamageEquip && Player[CLIENT_PLAYER_INDEX].m_ItemList.HaveDamageItem(m_nTPDamageEquipV))
			)
		{
			bTPFlag = true;
		}
		if (m_bTPNotEquipment)
		{
			switch (m_nTPNotEquipmentV)
			{
				case enumRoomNotEnough1:
					if (Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchEquipment(1,1) == FALSE)
						bTPFlag = true;
					break;
				case enumRoomNotEnough2:
					if (Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchEquipment(1,2) == FALSE &&
						Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchEquipment(2,1) == FALSE)
						bTPFlag = true;
					break;
				case enumRoomNotEnough4:
					if (Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchEquipment(2,2) == FALSE)
						bTPFlag = true;
					break;
				case enumRoomNotEnough6:
					if (Player[CLIENT_PLAYER_INDEX].m_ItemList.SearchEquipment(2,3) == FALSE)
						bTPFlag = true;
					break;
			}
		}
		if (bTPFlag && IR_GetCurrentTime() - m_uPortalCountDown > MAX_TIME_SPACE)
		{
            if (UseItem(TownPortal))
            {
                m_uPortalCountDown = IR_GetCurrentTime();
                m_bSellItem = TRUE;
            }
		}
	}
	if (m_bAntiPoison && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_PoisonState.nTime)
	{
		if (IR_GetCurrentTime() - m_uAntiPoisonCountDown > MAX_TIME_SPACE)
		{
			if(UseItem(AntiPoison))
				m_uAntiPoisonCountDown = IR_GetCurrentTime();
		}
	}
	if (m_bEnchaseExp && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentExpEnhance <= 0)
	{
		if (IR_GetCurrentTime() - m_uEnchaseExpCountDown > MAX_TIME_SPACE)
		{
			if(UseItem(EnchaseExp))
				m_uEnchaseExpCountDown = IR_GetCurrentTime();
		}
	}
}

//Di chuyen den??? player
void KPlayerAI::MoveTo(int nX, int nY)
{
	//TamLTM Fix khi thi trien hoan dung thi khong move
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_goattack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill)
	{
		return;
	}
	//end code

	int nMapX, nMapY;
	int nDestX, nDestY, dX, dY;

	if (Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames >= defMAX_PLAYER_SEND_MOVE_FRAME)
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&nMapX, &nMapY);
		dX = nMapX & 0x1F;
		dY = nMapY & 0x1F;
		nDestX = nX + 0x10 - dX;
		nDestY = nY + 0x10 - dY;

		if (!Player[CLIENT_PLAYER_INDEX].m_RunStatus)
		{
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_walk, nDestX, nDestY);
			SendClientCmdWalk(nDestX, nDestY);
		//	g_DebugLog("do_walk");
		}
		else
		{
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_run, nDestX, nDestY);
			SendClientCmdRun(nDestX, nDestY);
		//	g_DebugLog("do_run");
		}

		Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
	}
}

//Trang thai ky nang
int couterTimeBuff = 0;
int couterDelayTimeBuff = 0;
BOOL KPlayerAI::CastStateSkill()
{
	//Return ra khi thi trien skill
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_goattack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_run)
	{
		return TRUE;
	}
	//end code

	for (int i = 0; i < MAX_AUTO_STATESKILL; i ++)
	{
		if (m_nSupportSkills[i])
		{
			ISkill * pSkill = g_SkillManager.GetSkill(m_nSupportSkills[i], 1);

			if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.CanCast(m_nSupportSkills[i],
				SubWorld[0].m_dwCurrentTime) &&
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Cost(pSkill->GetSkillCostType(), pSkill->GetSkillCost(this), TRUE, TRUE) &&
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].IsNpcStateExist(m_nSupportSkills[i]) == FALSE &&
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].IsNpcSkillExist(m_nSupportSkills[i]))
			{
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, m_nSupportSkills[i], -1, Player[CLIENT_PLAYER_INDEX].m_nIndex);
				SendClientCmdSkill(m_nSupportSkills[i], -1, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID);
				couterTimeBuff++;
				return TRUE;
			}

		//	pSkill = NULL;
		}
	}

//	g_DebugLog("name %s", Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Name);

	if (m_bLifeReplenish)
	{

		if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_goattack ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill)
		{
			return FALSE; //TamLTM fix tu danh khi thi trien skill;
		}

		int nSkillLifeReplenishID = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.FindSkillLifeReplenish();
		ISkill * pSkill = g_SkillManager.GetSkill(nSkillLifeReplenishID, 1);
		if (nSkillLifeReplenishID &&
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].Cost(pSkill->GetSkillCostType(), pSkill->GetSkillCost(this), TRUE, TRUE) ||
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Kind == kind_player)
		{

			//TamLTM code buff team
			//°´ÕÕObject / Enemy / Ally buff to doi team
			int nTargetIdx = 0;
			couterTimeBuff++;
			couterDelayTimeBuff++;

			if (pSkill->IsTargetAlly() /*&& couterDelayTimeBuff >= 10*/)
			{
			//	if (couterDelayTimeBuff >= 30)
			//	{
			//		couterDelayTimeBuff = 0;
					//Player[CLIENT_PLAYER_INDEX].SetTargetNpc(0);
			//	}

				if (couterTimeBuff == 1)
				{
					m_nMovePosX = 383;
					m_nMovePosY = 331;
				}
				else if (couterTimeBuff == 3)
				{
					m_nMovePosX = 347;
					m_nMovePosY = 316;
				}
				else if (couterTimeBuff == 5)
				{
					m_nMovePosX = 347;
					m_nMovePosY = 342;
				}
				else if (couterTimeBuff == 7)
				{
					m_nMovePosX = 436;
					m_nMovePosY = 344;
				}
				else if (couterTimeBuff == 9)
				{
					m_nMovePosX = 250;
					m_nMovePosY = 209;
				}
				else if (couterTimeBuff == 11)
				{
					m_nMovePosX = 392;
					m_nMovePosY = 207;
				}
				//4
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff
				Player[CLIENT_PLAYER_INDEX].SetTargetNpc(4);

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{

					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);

			//		return TRUE;
				}

				if (couterTimeBuff == 13)
				{
					m_nMovePosX = 471;
					m_nMovePosY = 220;
				}
				else if (couterTimeBuff == 15)
				{
					m_nMovePosX = 366;
					m_nMovePosY = 272;
				}
				//8
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}
				if (couterTimeBuff == 17)
				{
					m_nMovePosX = 319;
					m_nMovePosY = 312;
				}
				else if (couterTimeBuff == 19)
				{
					m_nMovePosX = 300;
					m_nMovePosY = 338;
				}
				else if (couterTimeBuff == 21)
				{
					m_nMovePosX = 344;
					m_nMovePosY = 381;
				}
				// 12
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 23)
				{
					m_nMovePosX = 390;
					m_nMovePosY = 393;
				}
				else if (couterTimeBuff == 25)
				{
					m_nMovePosX = 464;
					m_nMovePosY = 329;
				}
				else if (couterTimeBuff == 27)
				{
					m_nMovePosX = 511;
					m_nMovePosY = 301;
				}
				else if (couterTimeBuff == 29)
				{
					m_nMovePosX = 442;
					m_nMovePosY = 200;
				}
				//16
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 31)
				{
					m_nMovePosX = 456;
					m_nMovePosY = 182;
				}
				else if (couterTimeBuff == 33)
				{
					m_nMovePosX = 299;
					m_nMovePosY = 242;
				}
				else if (couterTimeBuff == 35)
				{
					m_nMovePosX = 294;
					m_nMovePosY = 302;
				}
				else if (couterTimeBuff == 37)
				{
					m_nMovePosX = 282;
					m_nMovePosY = 305;
				}
				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 39)
				{
					m_nMovePosX = 296;
					m_nMovePosY = 331;
				}
				else if (couterTimeBuff == 41)
				{
					m_nMovePosX = 348;
					m_nMovePosY = 390;
				}
				else if (couterTimeBuff == 43)
				{
					m_nMovePosX = 364;
					m_nMovePosY = 388;
				}
				else if (couterTimeBuff == 45)
				{
					m_nMovePosX = 530;
					m_nMovePosY = 392;
				}
				//24
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 47)
				{
					m_nMovePosX = 450;
					m_nMovePosY = 331;
				}
				else if (couterTimeBuff == 49)
				{
					m_nMovePosX = 489;
					m_nMovePosY = 317;
				}
				else if (couterTimeBuff == 51)
				{
					m_nMovePosX = 518;
					m_nMovePosY = 306;
				}
				else if (couterTimeBuff == 53)
				{
					m_nMovePosX = 483;
					m_nMovePosY = 218;
				}
				//28
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 55)
				{
					m_nMovePosX = 476;
					m_nMovePosY = 215;
				}
				else if (couterTimeBuff == 57)
				{
					m_nMovePosX = 370;
					m_nMovePosY = 316;
				}
				else if (couterTimeBuff == 59)
				{
					m_nMovePosX = 367;
					m_nMovePosY = 142;
				}
				else if (couterTimeBuff == 61)
				{
					m_nMovePosX = 623;
					m_nMovePosY = 300;
				}

				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 63)
				{
					m_nMovePosX = 537;
					m_nMovePosY = 265;
				}
				else if (couterTimeBuff == 65)
				{
					m_nMovePosX = 577;
					m_nMovePosY = 275;
				}
				else if (couterTimeBuff == 67)
				{
					m_nMovePosX = 249;
					m_nMovePosY = 205;
				}
				else if (couterTimeBuff == 69)
				{
					m_nMovePosX = 388;
					m_nMovePosY = 352;
				}

				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 71)
				{
					m_nMovePosX = 396;
					m_nMovePosY = 270;
				}
				else if (couterTimeBuff == 73)
				{
					m_nMovePosX = 385;
					m_nMovePosY = 266;
				}
				else if (couterTimeBuff == 73)
				{
					m_nMovePosX = 395;
					m_nMovePosY = 269;
				}
				else if (couterTimeBuff == 75)
				{
					m_nMovePosX = 395;
					m_nMovePosY = 269;
				}

				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 77)
				{
					m_nMovePosX = 399;
					m_nMovePosY = 265;
				}
				else if (couterTimeBuff == 79)
				{
					m_nMovePosX = 404;
					m_nMovePosY = 267;
				}
				else if (couterTimeBuff == 81)
				{
					m_nMovePosX = 398;
					m_nMovePosY = 264;
				}
				else if (couterTimeBuff == 83)
				{
					m_nMovePosX = 395;
					m_nMovePosY = 266;
				}

				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 85)
				{
					m_nMovePosX = 399;
					m_nMovePosY = 272;
				}
				else if (couterTimeBuff == 87)
				{
					m_nMovePosX = 396;
					m_nMovePosY = 269;
				}
				else if (couterTimeBuff == 89)
				{
					m_nMovePosX = 399;
					m_nMovePosY = 259;
				}
				else if (couterTimeBuff == 91)
				{
					m_nMovePosX = 402;
					m_nMovePosY = 264;
				}
				//20
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				//	return TRUE;
				}

				if (couterTimeBuff == 93)
				{
					m_nMovePosX = 398;
					m_nMovePosY = 263;
				}
				else if (couterTimeBuff == 93)
				{
					m_nMovePosX = 391;
					m_nMovePosY = 277;
				}
				else if (couterTimeBuff == 95)
				{
					m_nMovePosX = 397;
					m_nMovePosY = 268;
				}
				else if (couterTimeBuff == 97)
				{
					m_nMovePosX = 396;
					m_nMovePosY = 261;

				}
				else if (couterTimeBuff == 99)
				{
					m_nMovePosX = 469;
					m_nMovePosY = 328;
				}
				else if (couterTimeBuff == 101)
				{
					m_nMovePosX = 522;
					m_nMovePosY = 310;
				}
			//	g_DebugLog("couterTimeBuff %d %d", m_nMovePosX, m_nMovePosY);
				Player[CLIENT_PLAYER_INDEX].FindSelectNpc(m_nMovePosX, m_nMovePosY, relation_ally); // toa do muc tieu buff

				if (Player[CLIENT_PLAYER_INDEX].GetTargetNpc())
				{
					nTargetIdx = Player[CLIENT_PLAYER_INDEX].GetTargetNpc();
					Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, nTargetIdx);
					SendClientCmdSkill(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_ActiveSkillID, -1, Npc[nTargetIdx].m_dwID);
				}

				if (couterTimeBuff >= 101)
				{
					couterTimeBuff = 0;
				}
			//	g_DebugLog("fffsdfsdf %d", couterTimeBuff);
			//	Player[CLIENT_PLAYER_INDEX].SetTargetNpc(0);
			}
			//end code

			if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLife * MAX_PERCENT / Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLifeMax < m_nLifeReplenishP)
			{
			//	m_bAttackNpc = FALSE; // Kinox and TamLTM - add khi thi trien skill buff nga ngy
				Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_skill, nSkillLifeReplenishID, -1, Player[CLIENT_PLAYER_INDEX].m_nIndex);
				SendClientCmdSkill(nSkillLifeReplenishID, -1, Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_dwID);
			//	m_bAttackNpc = TRUE; // Kinox and TamLTM - add khi thi trien skill buff nga ngy
				return TRUE;
			}
		}
	//	pSkill = NULL;
	}

	return FALSE;
}

//Theo doi tuong nhat do
BOOL KPlayerAI::FollowObject(int nObject)
{
	//TamLTM fix khi truong hop dang danh thi thoat ra ko cho chay
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_attack ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_magic ||
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Doing == do_skill)
		return FALSE;
	//end code

	if ( CheckObject(nObject) )
	{
		m_nObject = 0;
		return FALSE;
	}

	int nX1, nY1, nX2, nY2;
	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&nX1, &nY1);
	Object[nObject].GetMpsPos(&nX2, &nY2);

	if ((nX1 - nX2) * (nX1 - nX2) + (nY1 - nY2) * (nY1 - nY2) < PLAYERAUTO_PICKUP_CLIENT_DISTANCE * PLAYERAUTO_PICKUP_CLIENT_DISTANCE)
	{
		//TamLTM Fix Theo sau va nhat do lai
		if (m_bNotGetEquipment == FALSE)
		{
			Player[CLIENT_PLAYER_INDEX].CheckObject(nObject); //TamLTM Fix Theo sau va nhat do lai
		}
		//end code

		for (int i=0; i<MAX_AUTO_SIZE; i++)
		{
			if (m_nArrayObjectOverLook[i] == 0)
			{
			//	g_DebugLog("abc dddddfffff 2");
				m_nArrayObjectOverLook[i] = Object[m_nObject].m_nID;
				m_nArrayTimeObjectOverLook[i] = GetTickCount();
				break;
			}
		}
		m_nObject = 0;
		m_nCount_Run_OverLook = 0;

		return FALSE;
	}
	else
	{
		if(m_bFollowPick && !m_bPriorityUseMouse)
		{
		//	g_DebugLog("abc dddddfffff 3");
			MoveTo(nX2, nY2);
			//g_DebugLog("MoveTo(nX, nY); 2");
			m_nCount_Run_OverLook++;
			if (m_nCount_Run_OverLook >= MAX_TIME_OVERLOOK * 2)
			{
				for (int i=0; i<MAX_AUTO_SIZE; i++)
				{
					if (m_nArrayObjectOverLook[i] == 0)
					{
					//	g_DebugLog("abc dddddfffff 4");
						m_nArrayObjectOverLook[i] = Object[nObject].m_nID;
						m_nArrayTimeObjectOverLook[i] = GetTickCount();
						m_nObject = 0;
						nObject = 0;
						break;
					}
				}
				return FALSE;
			}
			return TRUE;
		}
		else
		{
			m_nObject = 0;
			m_nCount_Run_OverLook = 0;
		//	g_DebugLog("abc dddddfffff 5");
		}
	}
	return FALSE;
}

//Su dung vat pham -> can thuoc lac'
BOOL KPlayerAI::UseItem(int type)
{
	if(type == Blood ||
		type == Mana)
	{
		if (m_bOpenMedicine && Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode &&
			(Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_blood) <= 0 ||
			Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_mana) <= 0) &&
			Player[CLIENT_PLAYER_INDEX].m_ItemList.CountCommonItem(item_medicine, medicine_both) <= 0)
		{
			if (IR_GetCurrentTime() - m_uOpenMedicineCountDown > MAX_TIME_SPACE)
			{
				if(UseItem(MecidineBag))
				{
					m_uOpenMedicineCountDown = IR_GetCurrentTime();
					return TRUE;
				}
			}
		}
	}

	ItemPos    Pos;
	PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();

	if (pItem)
	{
		if (pItem->nPlace == pos_equiproom ||
			pItem->nPlace == pos_immediacy)
		{
			switch(type)
			{
			case Blood:
				if (Item[pItem->nIdx].GetGenre() == item_medicine)
				{
					if (Item[pItem->nIdx].GetDetailType() == medicine_blood ||
						Item[pItem->nIdx].GetDetailType() == medicine_both)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				break;
			case Mana:
				if (Item[pItem->nIdx].GetGenre() == item_medicine)
				{
					if (Item[pItem->nIdx].GetDetailType() == medicine_mana ||
						Item[pItem->nIdx].GetDetailType() == medicine_both)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				break;
			case TownPortal:
				if (Item[pItem->nIdx].GetGenre() == item_townportal)
				{
					if (Item[pItem->nIdx].GetDetailType() != townportal_special)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				break;
			case TownPortal_l:
				if (Item[pItem->nIdx].GetGenre() == item_townportal)
				{
					if (Item[pItem->nIdx].GetDetailType() == townportal_special)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				break;
			case AntiPoison:
				if (Item[pItem->nIdx].GetGenre() == item_medicine)
				{
					if (Item[pItem->nIdx].GetDetailType() == medicine_antipoison)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				break;
			case EnchaseExp:
				{
				for(int i=0; i < sizeof(szMagicScriptName)/sizeof(szMagicScriptName[0]);i++)
				{
					if (strcmp(Item[pItem->nIdx].GetName(), szMagicScriptName[i]) == 0)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
				}
				}
				break;
			case MecidineBag:
				if (strcmp(Item[pItem->nIdx].GetName(), szPotionName) == 0)
				{
					Pos.nPlace = pItem->nPlace;
					Pos.nX = pItem->nX;
					Pos.nY = pItem->nY;
					Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
					return TRUE;
				}
				break;
			}
		}
	}

	while(pItem)
	{
		pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetNextItem();
		if (pItem)
		{
			if (pItem->nPlace == pos_equiproom ||
				pItem->nPlace == pos_immediacy)
			{
				switch(type)
				{
				case Blood:
					if (Item[pItem->nIdx].GetGenre() == item_medicine)
					{
						if (Item[pItem->nIdx].GetDetailType() == medicine_blood ||
							Item[pItem->nIdx].GetDetailType() == medicine_both)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					break;
				case Mana:
					if (Item[pItem->nIdx].GetGenre() == item_medicine)
					{
						if (Item[pItem->nIdx].GetDetailType() == medicine_mana ||
							Item[pItem->nIdx].GetDetailType() == medicine_both)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					break;
				case TownPortal:
					if (Item[pItem->nIdx].GetGenre() == item_townportal)
					{
						if (Item[pItem->nIdx].GetDetailType() != townportal_special)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					break;
				case TownPortal_l:
					if (Item[pItem->nIdx].GetGenre() == item_townportal)
					{
						if (Item[pItem->nIdx].GetDetailType() == townportal_special)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					break;
				case AntiPoison:
					if (Item[pItem->nIdx].GetGenre() == item_medicine)
					{
						if (Item[pItem->nIdx].GetDetailType() == medicine_antipoison)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					break;
				case EnchaseExp:
					{
					for(int i=0; i < sizeof(szMagicScriptName)/sizeof(szMagicScriptName[0]);i++)
					{
						if (strcmp(Item[pItem->nIdx].GetName(), szMagicScriptName[i]) == 0)
						{
							Pos.nPlace = pItem->nPlace;
							Pos.nX = pItem->nX;
							Pos.nY = pItem->nY;
							Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
							return TRUE;
						}
					}
					}
					break;
				case MecidineBag:
					if (strcmp(Item[pItem->nIdx].GetName(), szPotionName) == 0)
					{
						Pos.nPlace = pItem->nPlace;
						Pos.nX = pItem->nX;
						Pos.nY = pItem->nY;
						Player[CLIENT_PLAYER_INDEX].ApplyUseItem(pItem->nIdx, Pos);
						return TRUE;
					}
					break;
				}
			}
		}
	}
	return FALSE;
}

//Moi to doi
void KPlayerAI::InviteParty()
{
	for (int i=0; i < MAX_AUTO_SIZE; i++)
	{
		if (m_nArrayTimeInvitePlayer[i] > 0)
		{
			m_nArrayTimeInvitePlayer[i]--;
			if (m_nArrayTimeInvitePlayer[i] == 0)
				m_nArrayInvitePlayer[i] = 0;
		}
	}

	if (g_Team[0].m_nMemNum < g_Team[0].CalcCaptainPower())
	{
		int nCount = NpcSet.GetAroundPlayerForTeamInvite(NULL, 0);
		if(nCount)
		{
			KUiPlayerItem*	m_pNearbyPlayersList = (KUiPlayerItem*)malloc(sizeof(KUiPlayerItem) * nCount);
			NpcSet.GetAroundPlayerForTeamInvite(m_pNearbyPlayersList, nCount);
			for (i = 0; i < nCount; i++)
			{
				if (m_bAutoInviteList && !CheckPTList(m_pNearbyPlayersList[i].Name))
					continue;
				if (FindSameInvitePlayer(m_pNearbyPlayersList[i].uId))
					continue;
				int j = FindFreeInvitePlayer();
				if (j>=0)
				{
					Player[CLIENT_PLAYER_INDEX].TeamInviteAdd(m_pNearbyPlayersList[i].uId);
					m_nArrayInvitePlayer[j] = m_pNearbyPlayersList[i].uId;
					m_nArrayTimeInvitePlayer[j] = INTERVAL_AUTO;
				}
			}
			free (m_pNearbyPlayersList);
		}
	}
}

//PT danh sach kiem tra
BOOL KPlayerAI::CheckPTList(const char *Name)
{
	if (!Name || !Name[0])
		return TRUE;

	for (int i = 0; i < MAX_AUTO_LIST; i ++)
	{
		if (m_szPartyList[i][0] && strcmp(m_szPartyList[i], Name) == 0)
			return TRUE;
	}
	return FALSE;
}

//Move toa do map
BOOL KPlayerAI::MoveMps() // Cai nay move theo toa do
{
	if (m_bMoveMps == TRUE) // bien gi enhi ngoi do ko :)
	{
		m_nRadiusAuto = 400; // radius gi quen roi
		// m_bAttackNpc  = FALSE;
		if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == enumFightActive)
		{
			if (m_nMoveStep >= m_nMoveCount)
				m_nMoveStep = 0;

			if (!m_nMoveMps[m_nMoveStep][0] ||
				(m_nMoveMps[m_nMoveStep][0] != SubWorld[0].m_SubWorldID))
			{
				m_nMoveStep++;
				return FALSE;
			}
			int nMapX, nMapY, dX, dY, dZ;
			Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&nMapX, &nMapY);
			dX = nMapX - m_nMoveMps[m_nMoveStep][1];
			dY = nMapY - m_nMoveMps[m_nMoveStep][2];
			dZ = (int)sqrt((float)dX * dX + (float)dY * dY);
			if (dZ >= 64)
			{
				MoveTo(m_nMoveMps[m_nMoveStep][1], m_nMoveMps[m_nMoveStep][2]);
				//g_DebugLog("MoveTo(nX, nY); 3");
			}
			else
				m_nMoveStep++;
		}
	}
	else
	{
		m_nRadiusAuto = 800;
		// m_bAttackNpc  = FALSE;
	}

	return FALSE;
}

int countOneSellItem = 0;
int nPlaceRoom = 0;

BOOL KPlayerAI::ReturnFromPortal()
{
    BOOL nRet = TRUE;
    switch (m_nReturnPortalStep)
    {
    case Step_Training:
        m_nReturnPortalStep = Step_SellTrash;
        break;
    case Step_SellTrash:
    {
        if (m_bSellTrash && m_bSellItem)
        {
            m_DelayTime++;
            if (m_DelayTime >= 30 && nPlaceRoom == 0)
            {
                m_nCurReturnPortalSec = KSG_GetCurSec() + m_nReturnPortalSec;
                SendClientAutoSellItemCmd(12);
                nPlaceRoom = 0;
                m_nReturnPortalStep = Step_SellTrash;
            }
            if (m_DelayTime == 150)
            {
                m_nReturnPortalStep = Step_Repair;
            }
        }
        else
        {
            m_nReturnPortalStep = Step_Repair;
        }
    }
    break;
    case Step_Repair:
        if (m_bRepairEquip)
        {
            for (int i = itempart_head; i < itempart_horse; i++)
            {
                int nIdx = Player[CLIENT_PLAYER_INDEX].m_ItemList.m_EquipItem[i];
                if (nIdx && Item[nIdx].GetRepairPrice())
                {
                    if (Player[CLIENT_PLAYER_INDEX].m_ItemList.GetEquipmentMoney() < Item[nIdx].GetRepairPrice())
                        continue;
                    else
                        Step_WithDrawaMoney;
                    SendClientCmdRepair(Item[nIdx].GetID());
                }
            }
        }
        m_nReturnPortalStep = Step_InventoryMoney;
        break;
    case Step_InventoryMoney:
        if (m_bInventoryMoney)
            Player[CLIENT_PLAYER_INDEX].m_ItemList.ExchangeMoney(room_equipment, room_repository, Player[CLIENT_PLAYER_INDEX].m_ItemList.GetEquipmentMoney());
        m_nReturnPortalStep = Step_WithDrawaMoney;
        break;
    case Step_WithDrawaMoney://rut tien;
        if (m_bWithDrawa)
        {
            if (Player[CLIENT_PLAYER_INDEX].GetLockState() > 0)
            {
                C2S_BUF_COMMAND sUL;
                sUL.ProtocolType = c2s_unlockcommand;
                strcpy(sUL.szBuf, m_bPassReposion);
                g_pClient->SendPackToServer((BYTE*)&sUL, sizeof(C2S_BUF_COMMAND));
                m_nReturnPortalStep = Step_InventoryItem;
                return 0;
            }
            else
            {
                Player[CLIENT_PLAYER_INDEX].m_ItemList.WithDrawaMoney(room_repository, room_equipment, m_bWithDrawaMoney);
                m_nReturnPortalStep = Step_InventoryItem;
                return 0;
            }
        }
        m_nReturnPortalStep = Step_InventoryItem;
        break;
    case Step_InventoryItem:
        if (m_bInventoryItem)
        {
            if (InventoryItem())
            {
                m_nCurReturnPortalSec = KSG_GetCurSec() + m_nReturnPortalSec;
                m_nReturnPortalStep = Step_Return;
            }
        }
        else
        {
            m_nCurReturnPortalSec = KSG_GetCurSec() + m_nReturnPortalSec;
            m_nReturnPortalStep = Step_Return;
        }
        break;
    case Step_Return:
        if (m_bReturnPortal)
        {
            if (KSG_GetCurSec() >= m_nCurReturnPortalSec)
            {
                m_DelayTime = 0;
                m_bSellItem = FALSE;
                nPlaceRoom = 0;
                PLAYER_COMMAND	sRP;
                sRP.ProtocolType = c2s_playercommand;
                sRP.m_wMsgID = enumC2S_PLAYERCOMMAND_ID_RETURN;
                sRP.m_lpBuf = 0;
                sRP.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
                g_pClient->SendPackToServer((BYTE*)&sRP, sRP.m_wLength + 1);
                nRet = FALSE;
            }
        }
        break;
    }
    return nRet;
}

void KPlayerAI::AutoBanRac(int Index)
{
    int m_nIndex = Player[CLIENT_PLAYER_INDEX].m_nIndex;
    if (Npc[m_nIndex].m_Doing == do_death ||
        m_bSellItem == FALSE ||
        m_bIsActive == FALSE ||
        Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_FightMode == 1)
    {
        return;
    }

    if (m_bSellTrash && m_bSellItem && m_nIndex && Npc[m_nIndex].m_FightMode == 0)
    {
        PlayerItem* pItem = Player[CLIENT_PLAYER_INDEX].m_ItemList.GetFirstItem();
        if (pItem->nPlace == pos_equiproom)
        {
            if (Item[Index].m_CommonAttrib.nDetailType == itempart_horse ||
                Item[Index].GetSetID() > 0 ||
                Item[Index].m_CommonAttrib.nItemGenre == item_task ||
                Item[Index].m_CommonAttrib.nItemGenre == item_magicscript ||
                Item[Index].m_CommonAttrib.nItemGenre == item_medicine ||
                Item[Index].m_CommonAttrib.nItemGenre == item_event ||
                Item[Index].m_CommonAttrib.nItemGenre == item_townportal ||
                Item[Index].m_CommonAttrib.nItemGenre == item_ibitem ||
                Item[Index].m_CommonAttrib.nItemGenre == item_materials)
            {
                return;
            }
            if (CheckEquipMagic(Index))
            {
                return;
            }
            if (m_bSaveJewelry && CheckEquip(Item[Index].GetDetailType()))
            {
                return;
            }
            //g_DebugLog("nPlaceRoom : %d", nPlaceRoom);
            //g_DebugLog("countOneSellItem : %d", countOneSellItem);

            if (Item[Index].m_CommonAttrib.nItemGenre == item_equip && countOneSellItem == 0)
            {
                int GetId = Item[Index].GetID();
                countOneSellItem++;
                SendClientAutoSellItemCmd(12);
                SendClientCmdSell(GetId, 1);
                // g_DebugLog("GetId : %d", GetId);
                nPlaceRoom = 0;
            }
            else
            {
                nPlaceRoom = 1;
            }
        }
        else
        {
            nPlaceRoom = 1;
        }
    }
    countOneSellItem = 0;
}
//end code
#endif

// Phong Than 2026-10-03 autofight:H5 client auto fight (Alt+A / Alt+S / Alt+D), see PhongThanAutoFight.inl.
#ifndef _SERVER
#include "PhongThanAutoFight.inl"
#endif

// Phong Than 2026-10-04 timduong:H5 go to coordinates (Alt+F), see PhongThanGoTo.inl (after the auto fight).
#ifndef _SERVER
#include "PhongThanGoTo.inl"
#endif

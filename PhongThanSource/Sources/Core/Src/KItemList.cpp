#include	"KCore.h"
#include	"MyAssert.H"
#include	"KItem.h"
#include	"KItemSet.h"
#include	"KNpc.h"
#include	"KMath.h"
#include	"KPlayer.h"
#include	"KPlayerSet.h"
#include	"KItemList.h"
#include	"KPhongThanAppearance.h"
#include "ItemActionDiag.h"
#include	"KSortScript.h"
#include	<time.h>
#include    "../../Engine/Src/KSG_StringProcess.h"
#ifdef _SERVER
//#include	"../../Headers/IServer.h"
#include	"KObjSet.h"
#endif
#ifndef _SERVER
#include	"CoreShell.h"
#include	"../../Headers/IClient.h"
#endif


// PK�����ͷ�������װ������װ�������Ȩֵ
#define		defEQUIP_POWER
#ifdef defEQUIP_POWER
	int		g_nEquipPower[itempart_num] =
	{2, 4, 2, 4, 1, 1, 1, 1, 1, 1, 0};
#endif

#ifdef _SERVER
static void SendEquippedAppearanceNow(int nPlayerIdx)
{
	if (!g_pServer || nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER)
		return;
	const int nNpcIdx = Player[nPlayerIdx].m_nIndex;
	const int nConnection = Player[nPlayerIdx].m_nNetConnectIdx;
	if (nNpcIdx <= 0 || nNpcIdx >= MAX_NPC || nConnection < 0 ||
		Npc[nNpcIdx].m_SubWorldIndex < 0 || Npc[nNpcIdx].m_RegionIndex < 0)
		return;
	PHONGTHAN_PLAYER_SNAPSHOT snapshot;
	// Incremental snapshot updates selectors without resetting animation.
	Npc[nNpcIdx].BuildPhongThanPlayerSnapshot(&snapshot, false);
	// Send directly even if this player is not yet in the region audience list.
	g_pServer->PackDataToClient(nConnection, (BYTE*)&snapshot, sizeof(snapshot));
	Npc[nNpcIdx].SendDataToNearRegion(&snapshot, sizeof(snapshot));
	FILE* log = fopen("equipment_appearance_sync.log", "a");
	if (log)
	{
		fprintf(log, "equip_sync entity=%u helm=%d armor=%d weapon=%d mounted=%d\n",
			snapshot.EntityId, snapshot.Helm.ResourceId, snapshot.Armor.ResourceId,
			snapshot.Weapon.ResourceId, snapshot.Mounted);
		fclose(log);
	}
}

static void SendPhongThanItemRemove(int nNetConnectIdx, DWORD dwItemId)
{
	if (!g_pServer || nNetConnectIdx < 0 || dwItemId == 0)
		return;
	PHONGTHAN_ITEM_REMOVE_MESSAGE Message;
	ZeroMemory(&Message, sizeof(Message));
	PhongThanInitializeWireHeader(&Message.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE, sizeof(Message),
		PHONGTHAN_WIRE_FLAG_NONE, 0);
	Message.ItemId = dwItemId;
	g_pServer->PackDataToClient(nNetConnectIdx, &Message, sizeof(Message));
}

static void SendPhongThanItemDurability(int nNetConnectIdx, DWORD dwItemId,
	int nDurability)
{
	if (!g_pServer || nNetConnectIdx < 0 || dwItemId == 0 || nDurability < 0)
		return;
	PHONGTHAN_ITEM_DURABILITY_MESSAGE Message;
	ZeroMemory(&Message, sizeof(Message));
	PhongThanInitializeWireHeader(&Message.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY, sizeof(Message),
		PHONGTHAN_WIRE_FLAG_NONE, 0);
	Message.ItemId = dwItemId;
	Message.Durability = nDurability;
	g_pServer->PackDataToClient(nNetConnectIdx, &Message, sizeof(Message));
}
#endif

KItemList::KItemList()
{
	m_PlayerIdx = 0;
	m_nListCurIdx = 0;
}

KItemList::~KItemList()
{

}


/*!*****************************************************************************
// Function		: KItemList::GetWeaponType
// Purpose		: ȡ�����װ������������
// Return		: int 
// Comments		:
// Author		: Spe
*****************************************************************************/
int KItemList::GetWeaponType()
{
	if (m_EquipItem[itempart_weapon])
		return Item[m_EquipItem[itempart_weapon]].GetDetailType();
	else
		return -1;
}

void KItemList::GetWeaponDamage(int* nMin, int* nMax)
{
	int nWeaponIdx = m_EquipItem[itempart_weapon];
	if (nWeaponIdx)
	{
		_ASSERT(Item[nWeaponIdx].m_CommonAttrib.nItemGenre == item_equip 
			&& (Item[nWeaponIdx].m_CommonAttrib.nDetailType == equip_meleeweapon
			|| Item[nWeaponIdx].m_CommonAttrib.nDetailType == equip_rangeweapon));
		int nMinDamage, nMaxDamage, nEnhance;
		int nDamageMinBase = Item[nWeaponIdx].m_aryBaseAttrib[0].nValue[0];
		int	nDamageMaxBase = Item[nWeaponIdx].m_aryBaseAttrib[1].nValue[0];
		nMinDamage = 0;
		nMaxDamage = 0;
		nEnhance = 0;
		for (int i = 0; i < MAX_ITEM_MAGICATTRIB; i++)
		{
			switch(Item[nWeaponIdx].m_aryMagicAttrib[i].nAttribType)
			{
			case magic_weapondamagemin_v:
				nMinDamage += Item[nWeaponIdx].m_aryMagicAttrib[i].nValue[0];
				break;
			case magic_weapondamagemax_v:
				nMaxDamage += Item[nWeaponIdx].m_aryMagicAttrib[i].nValue[0];
				break;
			case magic_weapondamageenhance_p:
				nEnhance += Item[nWeaponIdx].m_aryMagicAttrib[i].nValue[0];
				break;
			default:
				break;
			}
		}
		*nMin = (nDamageMinBase + nMinDamage) * (100 + nEnhance) / 100;
		*nMax = (nDamageMaxBase + nMaxDamage) * (100 + nEnhance) / 100;
	}
	else	// ����
	{
		/*
		int nDamageBase = Player[m_PlayerIdx].m_nCurStrength * Player[m_PlayerIdx].m_nCurDexterity;
		*nMin = nDamageBase >> 9;
		*nMax = nDamageBase >> 8;
		*/
		// ��ֵ���㷽���޸ģ���ӢҪ�� by Spe 03/06/11
		_ASSERT(STRENGTH_SET_DAMAGE_VALUE > 0);
		*nMin = Player[m_PlayerIdx].m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
		*nMax = Player[m_PlayerIdx].m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE;
	}
}

BOOL KItemList::SearchPosition(int nWidth, int nHeight, ItemPos* pPos, bool bOverLookHand)
{
	if (nWidth < 0 || nHeight < 0 || NULL == pPos)
	{
		return FALSE;
	}

	POINT	pPt;
	if (!m_Room[room_equipment].FindRoom(nWidth, nHeight, &pPt))
	{
	/*	if((Player[m_PlayerIdx].m_dwEquipExpandTime - KSG_GetCurSec() > 0) && m_Room[room_equipmentex].FindRoom(nWidth, nHeight, &pPt))
		{
			pPos->nPlace = pos_equiproomex;
			pPos->nX = pPt.x;
			pPos->nY = pPt.y;
		}
		else*/
		if (!bOverLookHand) // tat hanh trang nho
		{
			if (0 != m_Hand)
			{
				return FALSE;
			}
			pPos->nPlace = pos_hand;
			pPos->nX = 0;
			pPos->nY = 0;
		}
		else
			return FALSE;
	}
	else
	{
		pPos->nPlace = pos_equiproom;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
	}
	return TRUE;
}

BOOL KItemList::SearchPosition(POINT ItemSize, ItemPos* pPos) //Hanh trang
{
	POINT	pPt;
	
	if (m_Room[room_equipment].FindRoom((int)ItemSize.x, (int)ItemSize.y, &pPt))
	{
		pPos->nPlace = pos_equiproom;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	// tat hanh trang nho
	/*else if((Player[m_PlayerIdx].m_dwEquipExpandTime - KSG_GetCurSec() > 0) && m_Room[room_equipmentex].FindRoom((int)ItemSize.x, (int)ItemSize.y, &pPt))
	{
		pPos->nPlace = pos_equiproomex;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}*/
	return FALSE;
}

int KItemList::Add(int nIdx, POINT ItemSize, bool bAutoStack)
{
	ItemPos pos;
//	pos.nPlace = pos_equiproom;
	if(SearchPosition(ItemSize, &pos) == false)
		return 0;

	return Add(nIdx, pos.nPlace, pos.nX, pos.nY, bAutoStack);
}
/*!*****************************************************************************
// Function		: KItemList::Add
// Purpose		: ��ҵõ�һ��װ��
// Return		: int 
// Argumant		: int nIdx		Item�����idx
// Argumant		: int nPlace
// Argumant		: int nX
// Argumant		: int nY
// Comments		:
// Author		: Spe
*****************************************************************************/
int KItemList::Add(int nIdx, int nPlace, int nX, int nY, bool bAutoStack)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM || nPlace <= 0 || nPlace >= pos_num)
		return 0;

	if (Item[nIdx].GetID() == 0)
		return 0;
#ifdef _SERVER
	int pnX, pnY=0;
	if (Item[nIdx].IsStack() && bAutoStack)
	{
		int pnIdx = 0;
		if (Player[m_PlayerIdx].m_ItemList.m_Room[PositionToRoom(nPlace)].FindSameItemToStack(nIdx, &pnIdx, &pnX, &pnY))
		{
			int nNum = Item[pnIdx].AddStackNum(Item[nIdx].GetStackNum());
			SyncItem(pnIdx);
			if (nNum)
			{
				Item[nIdx].SetStackNum(nNum);
				return Add(nIdx, nPlace, nX, nY, bAutoStack);
			}
			int nOwnedIndex = FindSame(pnIdx);
			ItemSet.Remove(nIdx);
			return nOwnedIndex;
		}
	}

	if (Item[nIdx].GetOwner() != Player[m_PlayerIdx].m_dwID)
	{
		Item[nIdx].SetOwner(Player[m_PlayerIdx].m_dwID);
		Item[nIdx].SetTradePrice(0);
	}
#endif

	int i = FindFree();
	if (!i)
		return 0;

	switch(nPlace)
	{
	case pos_hand:
		if (m_Hand)
			return 0;
		m_Items[i].nPlace = pos_hand;
		m_Items[i].nX = 0;
		m_Items[i].nY = 0;
		m_Hand = nIdx;
		break;
	case pos_equip:
		if (nX < 0 || nX >= itempart_num)
			return 0;
		if (m_EquipItem[nX])
			return 0;
//	�п���������������������װ�����ϵġ��Ƿ���װ��Ӧ�÷ŵ�Equipʱ���
//		if (!CanEquip(nIdx, nX))
//			return 0;
		m_Items[i].nPlace = pos_equip;
		m_Items[i].nX = nX;
		m_Items[i].nY = 0;
		break;
	case pos_equiproom:
		if (!m_Room[room_equipment].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_equiproom;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;
		break;
#ifndef _SERVER
	case pos_trade1:
		if ( !Player[CLIENT_PLAYER_INDEX].CheckTrading() )
			return 0;
		if (!m_Room[room_trade1].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_trade1;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;
		break;
#endif
	case pos_repositoryroom:
		if (!m_Room[room_repository].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_repositoryroom1:
		if (!m_Room[room_repository1].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom1;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_repositoryroom2:
		if (!m_Room[room_repository2].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom2;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_repositoryroom3:
		if (!m_Room[room_repository3].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom3;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_repositoryroom4:
		if (!m_Room[room_repository4].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom4;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_repositoryroom5:
		if (!m_Room[room_repository5].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_repositoryroom5;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_equiproomex:
		if (!m_Room[room_equipmentex].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_equiproomex;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;
		break;
	case pos_immediacy:
		if (!m_Room[room_immediacy].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_immediacy;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;	
	case pos_give:
		if (!m_Room[room_give].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_give;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	case pos_compound:
		if (nX < 0 || nX >= MAX_COMPOUND_ITEM)
			return 0;
		if (m_CompoundItem[nX])
			return 0;
		m_Items[i].nPlace = pos_compound;
		m_Items[i].nX = nX;
		m_Items[i].nY = 0;
		break;
	//TamLTM kham nam xanh
	case pos_builditem:
		if (nX < 0 || nX >= MAX_PART_BUILD)
			return 0;
		if (m_BuildItem[nX])
			return 0;
		m_Items[i].nPlace = pos_builditem;
		m_Items[i].nX = nX;
		m_Items[i].nY = 0;
		break;
	//end
	case pos_compoundroom:
		if (!m_Room[room_compound].PlaceItem(nX, nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
			return 0;
		m_Items[i].nPlace = pos_compoundroom;
		m_Items[i].nX = nX;
		m_Items[i].nY = nY;		
		break;
	default:
		return 0;
	}

	m_Items[i].nIdx = nIdx;
	m_FreeIdx.Remove(i);
	m_UseIdx.Insert(i);

	if (m_Items[i].nPlace == pos_equip)
	{
		Equip(m_Items[i].nIdx, nX);
	}
	if (m_Items[i].nPlace == pos_compound)
	{
		PutCompound(m_Items[i].nIdx, nX);
	}
	//TamLTM Kham nam Xanh
	if (m_Items[i].nPlace == pos_builditem)
	{
		BuildItem(m_Items[i].nIdx, nX);
	}
	//End code
#ifdef _SERVER
	SyncItem(nIdx, TRUE, m_Items[i].nPlace, m_Items[i].nX, m_Items[i].nY, m_PlayerIdx);
	Player[m_PlayerIdx].m_uMustSave = SAVE_REQUEST; //TamLTM fix save data player
#endif

#ifndef _SERVER
	KUiObjAtContRegion	pInfo;

	int PartConvert[itempart_num] = 
	{
		UIEP_HEAD,
		UIEP_BODY,
		UIEP_WAIST,
		UIEP_HAND,
		UIEP_FOOT,
		UIEP_FINESSE,
		UIEP_NECK,
		UIEP_FINGER1,
		UIEP_FINGER2,
		UIEP_WAIST_DECOR,
		UIEP_HORSE,
		UIEP_SIGNET,
		UIEP_SHIPIN,
	};

	//TamLTM kham nam xanh
	int PartBuildItem[MAX_PART_BUILD] = 
	{
		UIEP_BUILDITEM1,
		UIEP_BUILDITEM2,
		UIEP_BUILDITEM3,
		UIEP_BUILDITEM4,
		UIEP_BUILDITEM5,
		UIEP_BUILDITEM6,
		UIEP_BUILDITEM7,
		UIEP_BUILDITEM8,
		UIEP_BUILDITEM9,
	};
	//End code

	int PartCompoundConvert[MAX_COMPOUND_ITEM] =
	{
		MOSAICENCRUSTED_UIEP_BOX_1,
		MOSAICENCRUSTED_UIEP_BOX_2,
		MOSAICENCRUSTED_UIEP_BOX_3,
	};

	pInfo.Obj.uGenre = CGOG_ITEM;	//Դװ��
	pInfo.Obj.uId = nIdx;
	pInfo.Region.Width = Item[nIdx].GetWidth();
	pInfo.Region.Height = Item[nIdx].GetHeight();

	switch(nPlace)
	{
	case pos_immediacy:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_IMMEDIA_ITEM;
		break;
	case pos_hand:
		pInfo.eContainer = UOC_IN_HAND;
		break;
	case pos_equip:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartConvert[nX];
		pInfo.eContainer = UOC_EQUIPTMENT;
		break;
	case pos_equiproomex:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_ITEM_TAKE_WITH_EX;
		break;
	case pos_equiproom:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_ITEM_TAKE_WITH;
		break;
	case pos_repositoryroom:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX;
		break;
	case pos_repositoryroom1:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX1;
		break;
	case pos_repositoryroom2:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX2;
		break;
	case pos_repositoryroom3:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX3;
		break;
	case pos_repositoryroom4:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX4;
		break;
	case pos_repositoryroom5:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_STORE_BOX5;
		break;
	case pos_trade1:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		break;
	case pos_give:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_ITEM_GIVE;
		break;
	case pos_compound:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartCompoundConvert[nX];
		pInfo.eContainer = UOC_COMPOUND;
		break;
	//TamLTM kham nam xanh
	case pos_builditem:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartBuildItem[nX];
		pInfo.eContainer = UOC_BUILD_ITEM;
		break;
	//End code
	case pos_compoundroom:
		pInfo.Region.h = nX;
		pInfo.Region.v = nY;
		pInfo.eContainer = UOC_COMPOUND_BOX;
		break;
	}
	if (nPlace != pos_trade1)
		CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&pInfo, 1);
	else
	{
		CoreDataChanged(GDCNI_TRADE_DESIRE_ITEM, (DWORD)&pInfo, 1);
	}
#endif
	return i;
}

/*!*****************************************************************************
// Function		: KItemList::Remove
// Purpose		: ���ʧȥһ��װ��
// Return		: int 
// Argumant		: int nGameIdxΪ��Ϸ�����е�������ı��
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KItemList::Remove(int nGameIdx)
{
	if (!nGameIdx)
		return FALSE;

	int nIdx = FindSame(nGameIdx);

	if (!nIdx)
		return FALSE;

#ifdef _SERVER
	DWORD dwRemovedItemId = Item[nGameIdx].m_dwID;
#endif

	switch(m_Items[nIdx].nPlace)
	{
	case pos_hand:
		m_Hand = 0;
		break;
	case pos_equip:
		UnEquip(m_Items[nIdx].nIdx);
		break;
	case pos_immediacy:
		m_Room[room_immediacy].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_equiproom:
		m_Room[room_equipment].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom:
		m_Room[room_repository].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom1:
		m_Room[room_repository1].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom2:
		m_Room[room_repository2].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom3:
		m_Room[room_repository3].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom4:
		m_Room[room_repository4].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_repositoryroom5:
		m_Room[room_repository5].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_equiproomex:
		m_Room[room_equipmentex].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_traderoom:
		m_Room[room_trade].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	case pos_give:
		m_Room[room_give].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
#ifndef _SERVER
	case pos_trade1:
		if ( !Player[CLIENT_PLAYER_INDEX].CheckTrading() )
		{
			_ASSERT(0);
		}
		m_Room[room_trade1].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
#endif
	case pos_compound:
		DropCompound(m_Items[nIdx].nIdx);
		break;
	//TamLTM Kham Nam
	case pos_builditem:
		UnBuildItem(m_Items[nIdx].nIdx);
		break;
	//end code
	case pos_compoundroom:
		m_Room[room_compound].PickUpItem(
			nGameIdx,
			m_Items[nIdx].nX,
			m_Items[nIdx].nY,
			Item[m_Items[nIdx].nIdx].GetWidth(),
			Item[m_Items[nIdx].nIdx].GetHeight());
		break;
	default:
		return FALSE;
	}
#ifndef _SERVER
	// �ͻ��˴��������ȥ��װ����Ӧ�ô�װ������ȥ������
	ItemSet.Remove(m_Items[nIdx].nIdx);

	// ���洦��
	KUiObjAtContRegion pInfo;

	int PartConvert[itempart_num] = 
	{
		UIEP_HEAD,
		UIEP_BODY,
		UIEP_WAIST,
		UIEP_HAND,
		UIEP_FOOT,
		UIEP_FINESSE,
		UIEP_NECK,
		UIEP_FINGER1,
		UIEP_FINGER2,
		UIEP_WAIST_DECOR,
		UIEP_HORSE,
		UIEP_SIGNET,
		UIEP_SHIPIN,
	};

	//TamLTM kham nam xanh
	int PartBuildItem[MAX_PART_BUILD] = 
	{
		UIEP_BUILDITEM1,
		UIEP_BUILDITEM2,
		UIEP_BUILDITEM3,
		UIEP_BUILDITEM4,
		UIEP_BUILDITEM5,
		UIEP_BUILDITEM6,
		UIEP_BUILDITEM7,
		UIEP_BUILDITEM8,
		UIEP_BUILDITEM9,
	};
	//End code

	int PartCompoundConvert[MAX_COMPOUND_ITEM] =
	{
		MOSAICENCRUSTED_UIEP_BOX_1,
		MOSAICENCRUSTED_UIEP_BOX_2,
		MOSAICENCRUSTED_UIEP_BOX_3,
	};
	pInfo.Obj.uGenre = CGOG_ITEM;
	pInfo.Obj.uId = m_Items[nIdx].nIdx;
	pInfo.Region.Width = Item[m_Items[nIdx].nIdx].GetWidth();
	pInfo.Region.Height = Item[m_Items[nIdx].nIdx].GetHeight();

	switch(m_Items[nIdx].nPlace)
	{
	case pos_hand:
		pInfo.Obj.uGenre = CGOG_NOTHING;
		pInfo.Region.h = 0;
		pInfo.Region.v = 0;
		pInfo.eContainer = UOC_IN_HAND;
		break;
	case pos_equiproom:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_ITEM_TAKE_WITH;
		break;
	case pos_equiproomex:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_ITEM_TAKE_WITH_EX;
		break;
	case pos_repositoryroom:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX;
		break;
	case pos_repositoryroom1:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX1;
		break;
	case pos_repositoryroom2:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX2;
		break;
	case pos_repositoryroom3:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX3;
		break;
	case pos_repositoryroom4:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX4;
		break;
	case pos_repositoryroom5:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_STORE_BOX5;
		break;
	case pos_immediacy:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_IMMEDIA_ITEM;
		break;
	case pos_equip:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartConvert[m_Items[nIdx].nX];
		pInfo.eContainer = UOC_EQUIPTMENT;
		break;
	case pos_trade1:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		break;
	case pos_give:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_ITEM_GIVE;
		break;
	case pos_compound:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartCompoundConvert[m_Items[nIdx].nX];
		pInfo.eContainer = UOC_COMPOUND;
		break;
	//TamLTM kham nam xanh
	case pos_builditem:
		pInfo.Region.h = 0;
		pInfo.Region.v = PartBuildItem[m_Items[nIdx].nX];
		pInfo.eContainer = UOC_BUILD_ITEM;
		break;
	//End code
	case pos_compoundroom:
		pInfo.Region.h = m_Items[nIdx].nX;
		pInfo.Region.v = m_Items[nIdx].nY;
		pInfo.eContainer = UOC_COMPOUND_BOX;
		break;
	}
	if (m_Items[nIdx].nPlace != pos_trade1)
	{
		CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&pInfo, 0);
	}
	else
	{
		CoreDataChanged(GDCNI_TRADE_DESIRE_ITEM, (DWORD)&pInfo, 0);
	}
#endif
	m_Items[nIdx].nIdx = 0;
	m_Items[nIdx].nPlace = 0;
	m_Items[nIdx].nX = 0;
	m_Items[nIdx].nY = 0;
	m_FreeIdx.Insert(nIdx);
	m_UseIdx.Remove(nIdx);

#ifdef _SERVER
	SendPhongThanItemRemove(Player[m_PlayerIdx].m_nNetConnectIdx, dwRemovedItemId);
#endif
	return TRUE;
}

/*!*****************************************************************************
// Function		: KItemList::FindFree
// Purpose		: ���ҿ��ÿ�����
// Return		: int 
// Comments		:
// Author		: Spe
*****************************************************************************/
int KItemList::FindFree()
{
	return m_FreeIdx.GetNext(0);
}

/*!*****************************************************************************
// Function		: KItemList::FindSame
// Purpose		: 
// Return		: int 
// Argumant		: int nGameIdx
// Comments		:
// Author		: Spe
*****************************************************************************/
int KItemList::FindSame(int nGameIdx)
{
	int nIdx = 0;
	while(1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (!nIdx)
			break;

		if (m_Items[nIdx].nIdx == nGameIdx)
			return nIdx;
	}
	return 0;
}


int KItemList::FindSame(DWORD dwID)
{
	if (dwID == 0)
		return 0;

	int nIdx = 0;
	while(1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (!nIdx)
			break;

		// m_UseIdx is populated from persisted data.  A corrupt/stale list
		// entry must not turn into an out-of-bounds Item[] access.
		if (nIdx > 0 && nIdx < MAX_PLAYER_ITEM &&
			m_Items[nIdx].nIdx > 0 && m_Items[nIdx].nIdx < MAX_ITEM &&
			Item[m_Items[nIdx].nIdx].GetID() == dwID)
			return nIdx;
	}
	return 0;
}
/*!*****************************************************************************
// Function		: KItemList::Init
// Purpose		: ��ʼ�����װ���б�
// Return		: BOOL
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KItemList::Init(int nPlayerIdx)
{
	m_PlayerIdx = nPlayerIdx;
	m_Hand = 0;
	m_nBackHand = 0;
	m_bMaskLock = FALSE;
#ifndef _SERVER
	m_bLockOperation = FALSE;
#endif
	m_Room[room_equipment].Init(EQUIPMENT_ROOM_WIDTH, EQUIPMENT_ROOM_HEIGHT);
	m_Room[room_repository].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_repository1].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_repository2].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_repository3].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_repository4].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_repository5].Init(REPOSITORY_ROOM_WIDTH, REPOSITORY_ROOM_HEIGHT);
	m_Room[room_equipmentex].Init(EQUIPMENT_ROOM_WIDTH, EQUIPMENT_ROOM_HEIGHT);
	m_Room[room_trade].Init(TRADE_ROOM_WIDTH, TRADE_ROOM_HEIGHT);
	m_Room[room_tradeback].Init(EQUIPMENT_ROOM_WIDTH, EQUIPMENT_ROOM_HEIGHT);
	m_Room[room_immediacy].Init(IMMEDIACY_ROOM_WIDTH, IMMEDIACY_ROOM_HEIGHT);
	m_Room[room_give].Init(GIVE_ROOM_WIDTH, GIVE_ROOM_HEIGHT);
	m_Room[room_compound].Init(MOSAICENCRUSTED_ROOM_WIDTH, MOSAICENCRUSTED_ROOM_HEIGHT);
#ifndef _SERVER
	m_Room[room_trade1].Init(TRADE_ROOM_WIDTH, TRADE_ROOM_HEIGHT);		// ����Ĵ�С������ room_trade �Ĵ�Сһ��
#endif
	ZeroMemory(m_EquipItem, sizeof(m_EquipItem));				// ���װ���ĵ��ߣ���Ӧ��Ϸ�����е��������������
	ZeroMemory(m_Items, sizeof(m_Items));						// ���ӵ�е����е��ߣ�����װ���ŵĺ�������ŵģ���Ӧ��Ϸ�����е��������������
	ZeroMemory(m_CompoundItem, sizeof(m_CompoundItem));
	m_nListCurIdx = 0;											// ���� GetFirstItem �� GetNextItem
	
	m_FreeIdx.Init(MAX_PLAYER_ITEM);
	m_UseIdx.Init(MAX_PLAYER_ITEM);

	for (int i = MAX_PLAYER_ITEM - 1; i > 0 ; i--)
	{
		m_FreeIdx.Insert(i);
	}
	return TRUE;
}

/*!*****************************************************************************
// Function		: KItemList::CanEquip
// Purpose		: 
// Return		: BOOL 
// Argumant		: int nIdx
// Argumant		: int nPlace
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KItemList::CanEquip(int nIdx, int nPlace)
{
	if (m_PlayerIdx <= 0 || nIdx <= 0 || nIdx >= MAX_ITEM || Item[nIdx].GetGenre() != item_equip)
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;

	KMagicAttrib* pData = NULL;

	if ((Item[nIdx].GetMaxDurability() > 0 && Item[nIdx].GetDurability() == 0) || (nPlace != -1 && !Fit(nIdx, nPlace)))
	{
		return FALSE;
	}

	int nCount = 0;
	do
	{
		pData = (KMagicAttrib*)Item[nIdx].GetRequirement(nCount);
		if (pData && !EnoughAttrib(pData))
		{
			return FALSE;
		}
		nCount++;
	} while (pData != NULL);
	return TRUE;
}

BOOL KItemList::CanEquip(KItem* pItem, int nPlace /* = -1 */)
{
	if (m_PlayerIdx <= 0 || !pItem)
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;

	KMagicAttrib* pData = NULL;

	if ((pItem->GetMaxDurability() > 0 && pItem->GetDurability() == 0) || (nPlace != -1 && !Fit(pItem, nPlace)))
	{
		return FALSE;
	}

	int nCount = 0;
	do
	{
		pData = (KMagicAttrib*)pItem->GetRequirement(nCount);
		if (pData && !EnoughAttrib(pData))
		{
			return FALSE;
		}
		nCount++;
	} while (pData != NULL);

	return TRUE;
}

BOOL KItemList::EnoughAttrib(void* pAttrib)
{
	KMagicAttrib*	pData = (KMagicAttrib *)pAttrib;
	_ASSERT(pData);
	switch(pData->nAttribType)
	{
	case magic_requirestr:
		if (Player[m_PlayerIdx].m_nCurStrength < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requiredex:
		if (Player[m_PlayerIdx].m_nCurDexterity < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requirevit:
		if (Player[m_PlayerIdx].m_nCurVitality < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requireeng:
		if (Player[m_PlayerIdx].m_nCurEngergy < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requirelevel:
		if (Npc[Player[m_PlayerIdx].m_nIndex].m_Level < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requiremenpai:
		if (Player[m_PlayerIdx].m_cProfession.m_nProfession != pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requireseries:
		if (Npc[Player[m_PlayerIdx].m_nIndex].m_Series != pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_requiresex:
		if (Npc[Player[m_PlayerIdx].m_nIndex].m_nSex != pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_require_translife:
		if (Npc[Player[m_PlayerIdx].m_nIndex].m_byTranslife < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	case magic_require_fortune_value:
		if (GetPlayerFortune() < pData->nValue[0])
		{
			return FALSE;
		}
		break;
	default:
		break;
	}
	return TRUE;
}


int KItemList::GetPlayerFortune()
{
	int nFortune = 0;
	for (int i = 0; i < itempart_num; i ++)
	{
		int nIdx = GetEquipment(i);
		nFortune += Item[nIdx].GetFortune();
	}
	return nFortune;
}

int KItemList::HaveDamageItem(int nDur)
{
	int nIndex = 0;
	for (int i = 0; i < itempart_num; i ++)
	{
		nIndex = GetEquipment(i);
		if (Item[nIndex].GetDurability() >= 0 && 
			Item[nIndex].GetMaxDurability() > 0 && 
			Item[nIndex].GetDurability() < nDur)
		{
			return nIndex;
		}
	}
	return 0;
}

/*!*****************************************************************************
// Function		: KItemList::Equip
// Purpose		: 
// Return		: BOOL
// Argumant		: int nIdx����Ϸ�����еĵ��������ţ�Ҫ��һ����װ�������
// Argumant		: int nPlace������װ����λ�ã�-1�Զ���λ��
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KItemList::Equip(int nIdx, int nPlace /* = -1 */)
{
	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;

	if (m_PlayerIdx <= 0 || nIdx <= 0 || nNpcIdx <= 0 || item_equip != Item[nIdx].GetGenre())
		return FALSE;

	int nItemListIdx = FindSame(nIdx);
	if (!nItemListIdx)
	{
		_ASSERT(0);
		return FALSE;
	}

	int nEquipPlace = nPlace;
	if (-1 == nEquipPlace)
	{
		nEquipPlace = GetEquipPlace(Item[nIdx].GetDetailType());
	}
	else if (!Fit(nIdx, nEquipPlace))
	{
		return FALSE;
	}
#ifdef _SERVER
	PHONGTHAN_VISUAL_PART Visual;
	ZeroMemory(&Visual, sizeof(Visual));
	// VNG *Part tables are keyed by the one-based item record number,
	// not the equipment category stored in the item's EquipId column.
	const int nAppearanceRecord = Item[nIdx].GetRow() + 1;
	switch(nEquipPlace)
	{
	case itempart_head:
		if (!g_PhongThanAppearance.ResolveHelm(nAppearanceRecord, &Visual))
			return FALSE;
		Npc[nNpcIdx].m_Appearance.Helm = Visual;
		break;
	case itempart_pendant:
		if (!g_PhongThanAppearance.ResolvePhiPhong(Item[nIdx].GetEquipId(), &Visual))
			return FALSE;
		Npc[nNpcIdx].m_Appearance.PhiPhong = Visual;
		break;
	case itempart_body:
		if (!g_PhongThanAppearance.ResolveArmor(nAppearanceRecord, &Visual))
			return FALSE;
		Npc[nNpcIdx].m_Appearance.Armor = Visual;
		break;
	case itempart_weapon:
		// Phong Than 2026-10-03 weaponequip: VNG_WeaponPart.txt stops at record 3291, so the ptfix starter
		// weapons (3412-3414) and VNG rows 3292-3411 (Tien Ma, quest bows) have no sprite row. A missing
		// sprite must not refuse the equip (the caller ignored the FALSE and orphaned the item in pos_hand).
		if (!g_PhongThanAppearance.ResolveWeapon(Item[nIdx].GetDetailType(),
			nAppearanceRecord, &Visual))
		{
			ZeroMemory(&Visual, sizeof(Visual));
			Visual.bVisible = TRUE;		// same state as UnEquip (bare hands)
		}
		Npc[nNpcIdx].m_Appearance.Weapon = Visual;
		break;
	case itempart_horse:
		if (!g_PhongThanAppearance.ResolveHorse(nAppearanceRecord, &Visual))
			return FALSE;
		Npc[nNpcIdx].m_Appearance.Horse = Visual;
		break;
	default:
		break;
	}
#endif
	m_EquipItem[nEquipPlace] = nIdx;
	m_Items[nItemListIdx].nPlace = pos_equip;
	m_Items[nItemListIdx].nX = nEquipPlace;
	m_Items[nItemListIdx].nY = 0;

	if(nEquipPlace == itempart_horse)
	{
		if (Npc[nNpcIdx].m_bRideHorse)
		{
			//do
		}
		else
		{
			Npc[nNpcIdx].m_bRideHorse = TRUE;
			// Equipping a horse while the saved character state is sit creates an
			// invalid VNG combination. Normalize gameplay state immediately.
			if (Npc[nNpcIdx].m_Doing == do_sit)
				Npc[nNpcIdx].SendCommand(do_stand);
		}
	}

	if (itempart_weapon == nEquipPlace)
	{		
#ifndef _SERVER
		Player[CLIENT_PLAYER_INDEX].UpdateWeaponSkill();
#endif
		Player[m_PlayerIdx].SetNpcDamageAttrib();
	}
	Player[m_PlayerIdx].UpdataCurData();
	#ifdef _SERVER
	SendEquippedAppearanceNow(m_PlayerIdx);
	#endif
	return TRUE;
	
}

BOOL KItemList::UnEquip(int nIdx, int nPos/* = -1*/)
{
	int i = 0;
	if (m_PlayerIdx <= 0)
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;
	if (nIdx <= 0)
		return FALSE;

	if (nPos <= 0)
	{
		for (i = 0; i < itempart_num; i++)
		{
			if (m_EquipItem[i] == nIdx)
			{
				break;
			}
		}
		
		if (i == itempart_num)
			return FALSE;

	}
	else
	{
		if (m_EquipItem[nPos] != nIdx)	
			return FALSE;
		i = nPos;
	}

	if(i == itempart_horse)
	{
		if (Npc[nNpcIdx].m_bRideHorse)
			Npc[nNpcIdx].m_bRideHorse = FALSE;
	}
	m_EquipItem[i] = 0;
#ifdef _SERVER
	switch(i)
	{
	case itempart_head:
		ZeroMemory(&Npc[nNpcIdx].m_Appearance.Helm, sizeof(PHONGTHAN_VISUAL_PART));
		Npc[nNpcIdx].m_Appearance.Helm.bVisible = TRUE;
		break;
	case itempart_pendant:
		ZeroMemory(&Npc[nNpcIdx].m_Appearance.PhiPhong, sizeof(PHONGTHAN_VISUAL_PART));
		break;
	case itempart_body:
		ZeroMemory(&Npc[nNpcIdx].m_Appearance.Armor, sizeof(PHONGTHAN_VISUAL_PART));
		Npc[nNpcIdx].m_Appearance.Armor.bVisible = TRUE;
		break;
	case itempart_weapon:
		ZeroMemory(&Npc[nNpcIdx].m_Appearance.Weapon, sizeof(PHONGTHAN_VISUAL_PART));
		Npc[nNpcIdx].m_Appearance.Weapon.bVisible = TRUE;
		break;
	case itempart_horse:
		ZeroMemory(&Npc[nNpcIdx].m_Appearance.Horse, sizeof(PHONGTHAN_VISUAL_PART));
		break;
	default:
		break;
	}
#endif


	if (itempart_weapon == i)
	{
#ifndef _SERVER
		Player[CLIENT_PLAYER_INDEX].UpdateWeaponSkill();
#endif
		Player[m_PlayerIdx].SetNpcDamageAttrib();
	}

	Player[m_PlayerIdx].UpdataCurData();
	#ifdef _SERVER
	SendEquippedAppearanceNow(m_PlayerIdx);
	#endif
	return TRUE;
}

int KItemList::GetEquipPlace(int nType)
{
	int nRet = -1;
	switch(nType)
	{
	case equip_meleeweapon:
	case equip_rangeweapon:
		nRet = itempart_weapon;
		break;
	case equip_armor:
		nRet = itempart_body;
		break;
	case equip_helm:
		nRet = itempart_head;
		break;
	case equip_boots:
		nRet = itempart_foot;
		break;
	case equip_ring:
		nRet = itempart_ring1;
		break;
	case equip_amulet:
		nRet = itempart_amulet;
		break;
	case equip_belt:
		nRet = itempart_belt;
		break;
	case equip_cuff:
		nRet = itempart_cuff;
		break;
	case equip_pendant:
		nRet = itempart_pendant;
		break;
	case equip_horse:
		nRet = itempart_horse;
		break;
	case equip_signet:
		nRet = itempart_signet;
		break;
	case equip_shipin:
		nRet = itempart_shipin;
		break;
	default:
		break;
	}
	return nRet;
}

/*!*****************************************************************************
// Function		: KItemList::Fit
// Purpose		: 
// Return		: BOOL 
// Argumant		: int nIdx
// Argumant		: int nPlace
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KItemList::Fit(int nIdx, int nPlace)
{
	BOOL	bRet = FALSE;
	_ASSERT(Item[nIdx].GetGenre() == item_equip);
	switch(Item[nIdx].GetDetailType())
	{
	case equip_meleeweapon:
	case equip_rangeweapon:
		if (nPlace == itempart_weapon)
			bRet = TRUE;
		break;
	case equip_armor:
		if (nPlace == itempart_body)
			bRet = TRUE;
		break;
	case equip_belt:
		if (nPlace == itempart_belt)
			bRet = TRUE;
		break;
	case equip_boots:
		if (nPlace == itempart_foot)
			bRet = TRUE;
		break;
	case equip_cuff:
		if (nPlace == itempart_cuff)
			bRet = TRUE;
		break;
	case equip_ring:
		if (nPlace == itempart_ring1 || nPlace == itempart_ring2)
			bRet = TRUE;
		break;
	case equip_amulet:
		// Phong Than 2026-09-30: phap bao also fit the 2 Talisman (ring) slots
		if (nPlace == itempart_amulet || nPlace == itempart_ring1 || nPlace == itempart_ring2)
			bRet = TRUE;
		break;
	case equip_pendant:
		if (nPlace == itempart_pendant)
			bRet = TRUE;
		break;
	case equip_helm:
		if (nPlace == itempart_head)
			bRet = TRUE;
		break;
	case equip_horse:
		if (nPlace == itempart_horse)
			bRet = TRUE;
		break;
	case equip_signet:
		if (nPlace == itempart_signet)
			bRet = TRUE;
		break;
	case equip_shipin:
		if (nPlace == itempart_shipin)
			bRet = TRUE;
		break;
	}
	return bRet;
}

BOOL KItemList::Fit(KItem* pItem, int nPlace)
{
	BOOL	bRet = FALSE;
	_ASSERT(pItem->GetGenre() == item_equip);
	switch(pItem->GetDetailType())
	{
	case equip_meleeweapon:
	case equip_rangeweapon:
		if (nPlace == itempart_weapon)
			bRet = TRUE;
		break;
	case equip_armor:
		if (nPlace == itempart_body)
			bRet = TRUE;
		break;
	case equip_belt:
		if (nPlace == itempart_belt)
			bRet = TRUE;
		break;
	case equip_boots:
		if (nPlace == itempart_foot)
			bRet = TRUE;
		break;
	case equip_cuff:
		if (nPlace == itempart_cuff)
			bRet = TRUE;
		break;
	case equip_ring:
		if (nPlace == itempart_ring1 || nPlace == itempart_ring2)
			bRet = TRUE;
		break;
	case equip_amulet:
		// Phong Than 2026-09-30: phap bao also fit the 2 Talisman (ring) slots
		if (nPlace == itempart_amulet || nPlace == itempart_ring1 || nPlace == itempart_ring2)
			bRet = TRUE;
		break;
	case equip_pendant:
		if (nPlace == itempart_pendant)
			bRet = TRUE;
		break;
	case equip_helm:
		if (nPlace == itempart_head)
			bRet = TRUE;
		break;
	case equip_horse:
		if (nPlace == itempart_horse)
			bRet = TRUE;
		break;
	case equip_signet:
		if (nPlace == itempart_signet)
			bRet = TRUE;
		break;
	case equip_shipin:
		if (nPlace == itempart_shipin)
			bRet = TRUE;
		break;
	}
	return bRet;
}

#include "../../../Headers/PhongThanSetActivation.h"
int KItemList::GetGoldEquipEnhance(int nPlace)
{
	if (m_PlayerIdx <= 0 || nPlace < 0 || nPlace >= itempart_num)
		return 0;

	int nItemIdx = m_EquipItem[nPlace];
	if (nItemIdx <= 0 || nItemIdx >= MAX_ITEM)
		return 0;

	const KItem& SetItem = Item[nItemIdx];
	if (SetItem.GetGenre() != item_equip)
		return 0;

	const int nGroup = SetItem.GetGroup();
	const int nSetID = SetItem.GetSetID();
	if (nGroup <= 0 || nSetID <= 0)
		return 0;

	int nEquippedPieces = 0;
	for (int i = 0; i < itempart_num; ++i)
	{
		int nEquippedIdx = m_EquipItem[i];
		if (nEquippedIdx <= 0 || nEquippedIdx >= MAX_ITEM)
			continue;

		const KItem& EquippedItem = Item[nEquippedIdx];
		if (EquippedItem.GetGenre() != item_equip ||
			EquippedItem.GetGroup() != nGroup || EquippedItem.GetSetID() != nSetID)
			continue;

		++nEquippedPieces;
	}

	if (nEquippedPieces < 3)
		return 0;
	int effectCount = 0;
	for (int slot = MAX_ITEM_NORMAL_MAGICATTRIB; slot < MAX_ITEM_MAGICATTRIB; ++slot)
		if (SetItem.m_aryMagicAttrib[slot].nAttribType > 0) ++effectCount;
	return PhongThanActiveSetEffectCount(nEquippedPieces, effectCount);
}

BOOL KItemList::NowEatItem(int nIdx)
{
	// The local client player is CLIENT_PLAYER_INDEX (0); only negative is invalid there.
#ifdef _SERVER
	if (m_PlayerIdx <= 0)
#else
	if (m_PlayerIdx < 0)
#endif
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;
	int nItemGenre = Item[nIdx].GetGenre();
	int	nDetailType = Item[nIdx].GetDetailType();
	SO_ItemActionDiagText("NowEatItem_BEGIN", Item[nIdx].GetScript(), nIdx, Item[nIdx].GetID());

	_ASSERT(nItemGenre == item_equip || 
			nItemGenre == item_medicine || 
			nItemGenre == item_event || 
			nItemGenre == item_materials || 
			nItemGenre == item_task || 
			nItemGenre == item_townportal ||
			nItemGenre == item_magicscript ||
			nItemGenre == item_skillbook ||
			nItemGenre == item_ibitem);

	if (Npc[Player[m_PlayerIdx].m_nIndex].m_Doing == do_sit)
	{
		Npc[Player[m_PlayerIdx].m_nIndex].SendCommand(do_stand);
	}
	if (nItemGenre == item_equip)
		return TRUE;

	else if (nItemGenre == item_medicine)
		Item[nIdx].ApplyMagicAttribToNPC(&Npc[nNpcIdx], MAX_ITEM_MAGICATTRIB / 2);
	else
	{
		if (Player[m_PlayerIdx].GetLockMove()->bLock)
		{
			if (Player[m_PlayerIdx].GetLockMove()->nPlace <= 0)
				return FALSE;
		}
#ifdef _SERVER
		ExecuteScript(nIdx);
#endif
		return TRUE;
	}
#ifdef _SERVER
	RemoveItem(nIdx, 1);
#endif
	return TRUE;
}

#ifndef _SERVER
int KItemList::UseItem(int nIdx)
{
	// The local client player is CLIENT_PLAYER_INDEX (0); only negative is invalid there.
#ifdef _SERVER
	if (m_PlayerIdx <= 0)
#else
	if (m_PlayerIdx < 0)
#endif
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;

	if (0 == FindSame(nIdx))
		return 0;

	int		nRet = 0;
	switch(Item[nIdx].GetGenre())
	{
    case item_equip:
		break;
/*		if (Equip(nNpcIdx, nIdx))
			nRet = REQUEST_EQUIP_ITEM;*/
		break;
//	case item_townportal:
//	case item_task:
	case item_medicine:
		if (NowEatItem(nIdx))
			nRet = REQUEST_EAT_MEDICINE;
		break;
	default:
		nRet = REQUEST_EAT_OTHER;
		break;
	}
	return nRet;
}
#endif

#ifndef _SERVER
BOOL KItemList::SearchEquipment(int nWidth, int nHeight)
{
	if (nWidth < 0 || nHeight < 0)
	{
		return FALSE;
	}

	POINT	pPt;
	if (!m_Room[room_equipment].FindRoom(nWidth, nHeight, &pPt))
	{
		return FALSE;
	}
	return TRUE;
}
int KItemList::ChangeItemInPlayer(int nIdx)
{
	// The local client player is stored at CLIENT_PLAYER_INDEX (0).  Rejecting
	// index 0 made every right-click equip request stop here before a move
	// packet could be sent to the server.
	if (m_PlayerIdx < 0 || m_PlayerIdx >= MAX_PLAYER)
		return FALSE;

	int nNpcIdx = Player[m_PlayerIdx].m_nIndex;

	if (0 == FindSame(nIdx))
	{
		return 0;
	}
	int		nRet = Item[nIdx].GetDetailType();
	switch(nRet)
	{
		case itempart_head:
			break;
		case itempart_body:
			break;
		case itempart_belt:
			break;
		case itempart_weapon:
			break;
		case itempart_foot:
			break;
		case itempart_cuff:
			break;
		case itempart_amulet:
			break;
		case itempart_ring1:
			break;
		case itempart_ring2:
			break;
		case itempart_pendant:
			break;
case itempart_num:
			break;
		case itempart_horse:
			break;
		default:
			break;
	}
	return nRet;
}

BOOL KItemList::SearchStoreBox(int nRepositoryNum, int nWidth, int nHeight, ItemPos* pPos)
{
	if (nWidth < 0 || nHeight < 0 || NULL == pPos)
	{
		return FALSE;
	}

	POINT	pPt;
	if (m_Room[room_repository].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	if (nRepositoryNum > REPOSITORY_ONE && m_Room[room_repository1].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom1;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	if (nRepositoryNum > REPOSITORY_TWO && m_Room[room_repository2].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom2;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	if (nRepositoryNum > REPOSITORY_THREE && m_Room[room_repository3].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom3;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	if (nRepositoryNum > REPOSITORY_FOUR && m_Room[room_repository4].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom4;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	if (nRepositoryNum > REPOSITORY_FIVE && m_Room[room_repository5].FindRoom(nWidth, nHeight, &pPt))
	{
		pPos->nPlace = pos_repositoryroom5;
		pPos->nX = pPt.x;
		pPos->nY = pPt.y;
		return TRUE;
	}
	return FALSE;
}
#endif

int	KItemList::SearchID(int nID)
{
	if (m_PlayerIdx <= 0)
		return 0;
	int nIdx = 0;
	while(1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (!nIdx)
			break;
		if (Item[m_Items[nIdx].nIdx].GetID() == (DWORD)nID)
			return m_Items[nIdx].nIdx;
	}
	return 0;
}

void KItemList::ExchangeMoney(int pos1, int pos2, int nMoney)
{
	if (pos1 < 0 || pos2 < 0 || pos1 > room_trade || pos2 > room_trade)
		return;

	if(Npc[Player[m_PlayerIdx].m_nIndex].m_FightMode)
		return;

#ifdef _SERVER
	if (m_Room[pos1].AddMoney(-nMoney))		// Դλ�����ó���ô��Ǯ��
	{
		if (!m_Room[pos2].AddMoney(nMoney))	// Ŀ�ĵ��ܷŲ���ȥ
		{
			m_Room[pos1].AddMoney(nMoney);	// ��ԭԴλ�õ�Ǯ
		}
	}
	else
	{
		return;
	}
#endif

#ifndef _SERVER
	if (pos1 == room_equipment && pos2 == room_repository)
		SendClientCmdStoreMoney(0, nMoney);
	else if (pos1 == room_repository && pos2 == room_equipment)
		SendClientCmdStoreMoney(1, nMoney);
#endif
#ifdef _SERVER
	SendMoneySync();
#endif	
}

// rut tien;
void KItemList::WithDrawaMoney(int pos1, int pos2, int nMoney) // rut tien;
{
	if (pos1 < 0 || pos2 < 0 || pos1 > room_trade || pos2 > room_trade)
		return;

	if(Npc[Player[m_PlayerIdx].m_nIndex].m_FightMode)
		return;

#ifdef _SERVER
	if (m_Room[pos1].AddMoney(-nMoney))		// Դλ�����ó���ô��Ǯ��
	{
		if (!m_Room[pos2].AddMoney(nMoney))	// Ŀ�ĵ��ܷŲ���ȥ
		{
			m_Room[pos1].AddMoney(nMoney);	// ��ԭԴλ�õ�Ǯ
		}
	}
	else
	{
		return;
	}
#endif

#ifndef _SERVER
	if (pos1 == room_repository && pos2 == room_equipment)
		SendClientCmdWithDrawaMoney(0, nMoney);
	else if (pos1 == room_equipment && pos2 == room_repository)
		SendClientCmdWithDrawaMoney(1, nMoney);
#endif
#ifdef _SERVER
	SendMoneySync();
#endif	
}
//end code

//----------------------------------------------------------------------
//	���ܣ��õ���Ʒ���ʹ��������Ǯ��
//----------------------------------------------------------------------
int KItemList::GetMoneyAmount()
{
	return (m_Room[room_equipment].GetMoney() + m_Room[room_repository].GetMoney());
}

//----------------------------------------------------------------------
//	���ܣ��õ���Ʒ���ʹ������Ǯ��
//----------------------------------------------------------------------
int KItemList::GetRepositoryMoney()
{
	return m_Room[room_repository].GetMoney();
}

int KItemList::GetEquipmentMoney()
{
	return m_Room[room_equipment].GetMoney();
}

int KItemList::GetTradeMoney()
{
	return m_Room[room_trade].GetMoney();
}

BOOL KItemList::AddMoney(int nRoom, int nMoney)
{
	if (nRoom < 0 || nRoom >= room_num)
		return FALSE;

	if (!m_Room[nRoom].AddMoney(nMoney))
		return FALSE;

#ifdef _SERVER
	SendMoneySync();
#endif

	return TRUE;
}

//TamLTM Gui tien vao truong muc bang hoi
BOOL KItemList::CostMoney(int nMoney)
{
//	g_DebugLog("TamLTM Debug Send money bang hoi CostMoney nMoney %d + ",nMoney);

	if (nMoney > GetEquipmentMoney())
		return FALSE;

	if (!m_Room[room_equipment].AddMoney(-nMoney))
		return FALSE;

#ifdef _SERVER
	SendMoneySync();
#endif

	return TRUE;
}

BOOL KItemList::DecMoney(int nMoney) //Description
{
	if (nMoney < 0)
		return FALSE;

	if (nMoney > m_Room[room_equipment].GetMoney())
	{
		nMoney -= m_Room[room_equipment].GetMoney();
		SetRoomMoney(room_equipment, 0);
		if (nMoney > m_Room[room_repository].GetMoney())
			SetRoomMoney(room_repository, 0);
		else
			AddMoney(room_repository, -nMoney);
	}
	else
	{
		AddMoney(room_equipment, -nMoney);
	}

#ifdef _SERVER
	SendMoneySync();
#endif

	return TRUE;
}

#ifdef _SERVER
//----------------------------------------------------------------------------------
//	���ܣ����ô˽ӿڱ��뱣֤�����nMoney��һ����Ч��(�����Ҳ���������Ǯ��)
//----------------------------------------------------------------------------------
void	KItemList::TradeMoveMoney(int nMoney)
{
	// �Լ�Ǯ�Ĵ���
	m_Room[room_trade].SetMoney(nMoney);
	SendMoneySync();
	char szMsg[128];
	sprintf(szMsg, MSG_TRADE_INPUT_MONEY, nMoney);
	KPlayerChat::SendSystemInfo(1, Player[m_PlayerIdx].m_cTrade.m_nTradeDest, MESSAGE_SYSTEM_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) );	
	// ���Է�����Ϣ
	TRADE_MONEY_SYNC	sMoney;
	sMoney.ProtocolType = s2c_trademoneysync;
	sMoney.m_nMoney = nMoney;
	g_pServer->PackDataToClient(Player[Player[m_PlayerIdx].m_cTrade.m_nTradeDest].m_nNetConnectIdx, (BYTE*)&sMoney, sizeof(TRADE_MONEY_SYNC));
}
#endif

#ifdef _SERVER
//----------------------------------------------------------------------------------
//	���ܣ���������moneyͬ����Ϣ���ͻ���
//----------------------------------------------------------------------------------
void	KItemList::SendMoneySync()
{
	PLAYER_MONEY_SYNC	sMoney;
	sMoney.ProtocolType = s2c_syncmoney;
	sMoney.m_nMoney1 = m_Room[room_equipment].GetMoney();
	sMoney.m_nMoney2 = m_Room[room_repository].GetMoney();
	sMoney.m_nMoney3 = m_Room[room_trade].GetMoney();
	g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMoney, sizeof(PLAYER_MONEY_SYNC));

//	g_DebugLog("TamLTM Debug Send money bang hoi 1 %d + 2 %d + 3 %d",sMoney.m_nMoney1,sMoney.m_nMoney2,sMoney.m_nMoney3);
}
#endif

void KItemList::SetMoney(int nMoney1, int nMoney2, int nMoney3)
{
	m_Room[room_equipment].SetMoney(nMoney1);
	m_Room[room_repository].SetMoney(nMoney2);
	m_Room[room_trade].SetMoney(nMoney3);
#ifndef _SERVER
	KUiObjAtContRegion	sMoney;
	sMoney.Obj.uGenre = CGOG_MONEY;
	sMoney.Obj.uId = nMoney2;
	sMoney.eContainer = UOC_STORE_BOX;
	CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&sMoney, 1);
#endif
}

void KItemList::SetRoomMoney(int nRoom, int nMoney)
{
	if (nRoom >= 0 && nRoom < room_num)
		m_Room[nRoom].SetMoney(nMoney);
}

//Vi tri item
void KItemList::ExchangeItem(ItemPos* SrcPos, ItemPos* DesPos)
{
	if (!SrcPos || !DesPos || SrcPos->nPlace <= 0 || SrcPos->nPlace >= pos_num ||
		DesPos->nPlace <= 0 || DesPos->nPlace >= pos_num ||
		SrcPos->nX < 0 || SrcPos->nX > 255 || SrcPos->nY < 0 || SrcPos->nY > 255 ||
		DesPos->nX < 0 || DesPos->nX > 255 || DesPos->nY < 0 || DesPos->nY > 255)
		return;
#ifdef _SERVER
	if(Player[m_PlayerIdx].m_PTrade.nTrade)
#else
	if(Npc[Player[m_PlayerIdx].m_nIndex].m_PTrade.nTrade)
#endif
		return;

	if (SrcPos->nPlace != DesPos->nPlace)
	{
#ifdef _SERVER
		// The Phong Than client sends right-click equip as one atomic move from
		// the inventory room to an equipment slot. The legacy item list only
		// knows how to mutate one container at a time, so execute the request
		// through its existing hand state instead of silently dropping it.
		if (m_Hand)
			return;

		ItemPos Source = *SrcPos;
		ItemPos Destination = *DesPos;

		// Pick the requested source item into the authoritative server hand.
		ExchangeItem(&Source, &Source);
		const int nMovingItem = m_Hand;
		if (nMovingItem <= 0 || nMovingItem >= MAX_ITEM)
			return;

		// Place/equip it at the destination. On rejection the old single-room
		// code deliberately leaves nMovingItem in hand, which lets us restore it.
		ExchangeItem(&Destination, &Destination);
		if (m_Hand == nMovingItem)
		{
			ExchangeItem(&Source, &Source);
			return;
		}

		// A destination item was displaced. Prefer the vacated source cell;
		// if its dimensions differ, use another free inventory cell.
		if (m_Hand)
		{
			ExchangeItem(&Source, &Source);
			if (m_Hand && Source.nPlace == pos_equiproom)
			{
				ItemPos FreePos;
				if (SearchPosition(Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight(), &FreePos))
					ExchangeItem(&FreePos, &FreePos);
			}
		}
#endif
		return;
	}

	int nTempHand = m_Hand;
	int	nEquipIdx1 = 0;
	
#ifdef _SERVER
	PHONGTHAN_ITEM_MOVE_MESSAGE	sMove;
	ZeroMemory(&sMove, sizeof(sMove));
	PhongThanInitializeWireHeader(&sMove.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_MOVE, sizeof(sMove),
		PHONGTHAN_WIRE_FLAG_NONE, 0);
	sMove.FromContainer = (PHONGTHAN_U8)SrcPos->nPlace;
	sMove.FromX = (PHONGTHAN_U8)SrcPos->nX;
	sMove.FromY = (PHONGTHAN_U8)SrcPos->nY;
	sMove.ToContainer = (PHONGTHAN_U8)DesPos->nPlace;
	sMove.ToX = (PHONGTHAN_U8)DesPos->nX;
	sMove.ToY = (PHONGTHAN_U8)DesPos->nY;
#endif

	// Դװ����SrcPos�����ϣ����ϵ�װ����DesPos
	if (Player[m_PlayerIdx].GetLockMove()->bLock)
	{
		if (DesPos->nPlace != pos_equiproom && 
			Player[m_PlayerIdx].GetLockMove()->nPlace >= pos_hand && 
			Player[m_PlayerIdx].GetLockMove()->nPlace < pos_num && 
			DesPos->nPlace != Player[m_PlayerIdx].GetLockMove()->nPlace)
			return;
	}
	if(Npc[Player[m_PlayerIdx].m_nIndex].m_FightMode && DesPos->nPlace >= pos_repositoryroom && DesPos->nPlace <= pos_repositoryroom5)
		return;

	switch(SrcPos->nPlace)
	{
	case pos_hand:
		//g_DebugLog("%s exchange item error", Npc[Player[m_PlayerIdx].m_nIndex].Name);
		return;
		break;
	case pos_equip:
		if (Player[this->m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (SrcPos->nX < 0 || SrcPos->nX >= itempart_num || DesPos->nX < 0 || DesPos->nX >= itempart_num)
			return;
		nEquipIdx1 = m_EquipItem[SrcPos->nX];
		if (nEquipIdx1)
		{
			UnEquip(nEquipIdx1, SrcPos->nX);
		}
		if (m_Hand)
		{
			// Phong Than 2026-10-03 weaponequip: honour Equip()'s result. On FALSE the item stays in hand
			// (list entry pos_hand == m_Hand), so the atomic caller puts it back in its source cell.
			if (CanEquip(m_Hand, DesPos->nX) && Equip(m_Hand, DesPos->nX))
			{
				m_Hand = nEquipIdx1;
				if (nEquipIdx1)
					m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			else
			{
				if (nEquipIdx1) Equip(nEquipIdx1, SrcPos->nX);
#ifdef _SERVER
				char message[] = "Khong the mac vat pham vao o nay. Hay dat lai vao tui do.";
				KPlayerChat::SendSystemInfo(1, m_PlayerIdx, "Phong Than", message, strlen(message));
#endif
			}
		}
		else
		{
			m_Hand = nEquipIdx1;
			m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	case pos_immediacy:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		// �ж��Ƿ���ͬ���͵���Ʒ���еĻ����÷���ȥ
		if (m_Hand)
		{
			if (Item[m_Hand].CanShortKey())
			{
				if (m_Room[room_immediacy].CheckSameImmediacyItem(m_Hand))
				{
#ifdef _SERVER
					SHOW_MSG_SYNC	sMsg;
					sMsg.ProtocolType = s2c_msgshow;
					sMsg.m_wMsgID = enumMSG_ID_ITEM_SAME_IMMEDIATE;
					sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
					if(g_pServer && Player[m_PlayerIdx].m_nNetConnectIdx != -1)
						g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif
					return;
				}
			}
			else
			{
#ifdef _SERVER
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wMsgID = enumMSG_ID_ITEM_CANTPUT_IMMEDIATE;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
				if(g_pServer && Player[m_PlayerIdx].m_nNetConnectIdx != -1)
					g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif
				return;
			}

		}
		nEquipIdx1 = m_Room[room_immediacy].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;
		
		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_immediacy].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}

		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
	if (m_Hand)
		{
			if (m_Room[room_immediacy].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_immediacy;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_immediacy].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	case pos_repositoryroom:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		nEquipIdx1 = m_Room[room_repository].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	//====================================================================================
	case pos_repositoryroom1:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_btRepositoryNum <= REPOSITORY_ONE)
			return;
		nEquipIdx1 = m_Room[room_repository1].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository1].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository1].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository1].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom1;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository1].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
//---------------------------------------------------
	case pos_repositoryroom2:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_btRepositoryNum <= REPOSITORY_TWO)
			return;
		nEquipIdx1 = m_Room[room_repository2].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository2].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository2].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository2].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom2;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository2].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
//----------------------------------------------------------------------
	case pos_repositoryroom3:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_btRepositoryNum <= REPOSITORY_THREE)
			return;
		nEquipIdx1 = m_Room[room_repository3].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository3].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository3].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository3].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom3;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository3].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	//====================================================================================
	case pos_repositoryroom4:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_btRepositoryNum <= REPOSITORY_FOUR)
			return;
		nEquipIdx1 = m_Room[room_repository4].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository4].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository4].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository4].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom4;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository4].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	//====================================================================================
	case pos_repositoryroom5:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_btRepositoryNum <= REPOSITORY_FIVE)
			return;
		nEquipIdx1 = m_Room[room_repository5].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_repository5].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_repository5].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_repository5].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_repositoryroom5;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_repository5].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
//--------------------------------------------------------------------
	case pos_equiproomex:
		if (Player[m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (m_Hand && Player[m_PlayerIdx].m_dwEquipExpandTime <= KSG_GetCurSec())
			return;
		nEquipIdx1 = m_Room[room_equipmentex].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_equipmentex].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}

		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_equipmentex].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_equipmentex].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_equiproomex;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_equipmentex].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}

#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	//--------------------------------------------------------------------------
	case pos_equiproom:
		nEquipIdx1 = m_Room[room_equipment].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_equipment].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}

		if (m_Hand)
		{
			if (CanCombie(nEquipIdx1, m_Hand))
			{
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				int nNum = Item[nEquipIdx1].AddStackNum(Item[m_Hand].GetStackNum());
				if (nNum)
					Item[m_Hand].SetStackNum(nNum);
				else
				{
					Remove(m_Hand);
					ItemSet.Remove(m_Hand);
				}
				m_Room[room_equipment].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
				
				return;				
			}
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_equipment].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				if (Player[m_PlayerIdx].GetLockMove()->bLock)
				{
					if (Item[m_Hand].GetBackLocal()->nPlace < pos_hand || 
						Item[m_Hand].GetBackLocal()->nPlace >= pos_num)
						return;

					Item[m_Hand].GetBackLocal()->Release();
					int nListIdx = FindSame(nEquipIdx1);
					Item[nEquipIdx1].SetBackLocal(&m_Items[nListIdx]);
				}
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_equiproom;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				if (Player[m_PlayerIdx].GetLockMove()->bLock)
				{
					if (Item[m_Hand].GetBackLocal()->nPlace < pos_hand || 
						Item[m_Hand].GetBackLocal()->nPlace >= pos_num)
						return;
				}
				m_Room[room_equipment].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				if (Player[m_PlayerIdx].GetLockMove()->bLock)
					Item[nEquipIdx1].SetBackLocal(&m_Items[nListIdx]);			
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	case pos_traderoom:
		if ( !Player[m_PlayerIdx].CheckTrading() )	// ���ڽ���
			return;
		nEquipIdx1 = m_Room[room_trade].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_trade].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		//char szMsg[128];
		if (m_Hand)
		{
			if (m_Room[room_trade].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_traderoom;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
#ifdef _SERVER
				// ����Ϣ�����׶Է�
				if (nEquipIdx1)	// �������ж���������
				{
					SendPhongThanItemRemove(
					Player[Player[m_PlayerIdx].m_cTrade.m_nTradeDest].m_nNetConnectIdx,
					Item[nEquipIdx1].m_dwID);
				}
				// ���ϵĶ��������˽�����
				SyncItem(m_Hand, TRUE, pos_trade1, DesPos->nX, DesPos->nY, Player[m_PlayerIdx].m_cTrade.m_nTradeDest);
				
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
				m_Hand = nEquipIdx1;
				if (FindSame(nEquipIdx1))
					m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_trade].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
#ifdef _SERVER
			// ����Ϣ�����׶Է�
			if (nEquipIdx1)	// �������ж���������
			{
				SendPhongThanItemRemove(
					Player[Player[m_PlayerIdx].m_cTrade.m_nTradeDest].m_nNetConnectIdx,
					Item[nEquipIdx1].m_dwID);
			}
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
		}
		break;
	case pos_give:
		nEquipIdx1 = m_Room[room_give].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_give].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_give].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_give;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_give].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}

#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	case pos_compound:
		if (Player[this->m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		if (SrcPos->nX < 0 || SrcPos->nX >= MAX_COMPOUND_ITEM || DesPos->nX < 0 || DesPos->nX >= MAX_COMPOUND_ITEM)
			return;

		nEquipIdx1 = m_CompoundItem[SrcPos->nX];
		if (m_Hand)
		{
		    if(PutCompound(m_Hand, DesPos->nX) == TRUE)
			{
				if (nEquipIdx1)
				{
					DropCompound(nEquipIdx1, SrcPos->nX);
				}
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			else if (nEquipIdx1)
			{
				PutCompound(nEquipIdx1, SrcPos->nX);
			}	
		}
		else
		{
			if (nEquipIdx1)
			{
				DropCompound(nEquipIdx1, SrcPos->nX);
			}
			m_Hand = nEquipIdx1;
			m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif		
			
		}
		break;
	//TamLTM Kham nam xanh ------------------------------------------------------------------------------
	case pos_builditem:
		if (Player[this->m_PlayerIdx].CheckTrading())	// ??????????
			return;
		if (SrcPos->nX < 0 || SrcPos->nX >= MAX_PART_BUILD || DesPos->nX < 0 || DesPos->nX >= MAX_PART_BUILD)
			return;

		nEquipIdx1 = m_BuildItem[SrcPos->nX];
		if (m_Hand)
		{
		    if(BuildItem(m_Hand, DesPos->nX) == TRUE)
			{
				if (nEquipIdx1)
				{
					UnBuildItem(nEquipIdx1, SrcPos->nX);
				}
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			else if (nEquipIdx1)
			{
				BuildItem(nEquipIdx1, SrcPos->nX);
			}	
		}
		else
		{
			if (nEquipIdx1)
			{
				UnBuildItem(nEquipIdx1, SrcPos->nX);
			}
			m_Hand = nEquipIdx1;
			m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif		
			
		}
		break;
		//End code ------------------------------------------------------------------------------
	case pos_compoundroom:
		if (Player[this->m_PlayerIdx].CheckTrading())	// ������ڽ���
			return;
		nEquipIdx1 = m_Room[room_compound].FindItem(SrcPos->nX, SrcPos->nY);
		if (nEquipIdx1 < 0)
			return;

		// �ȰѶ���������
		if (nEquipIdx1)
		{
			if (!m_Room[room_compound].PickUpItem(nEquipIdx1, SrcPos->nX, SrcPos->nY, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight()))
				return;
		}
		// ���������ж������������ܲ��ܰ�������ȥ��������еĻ������ð�ԭ���Ķ����Ż�ȥ
		if (m_Hand)
		{
			if (m_Room[room_compound].PlaceItem(DesPos->nX, DesPos->nY, m_Hand, Item[m_Hand].GetWidth(), Item[m_Hand].GetHeight()))
			{
				int nListIdx = FindSame(m_Hand);
				m_Items[nListIdx].nPlace = pos_compoundroom;
				m_Items[nListIdx].nX = DesPos->nX;
				m_Items[nListIdx].nY = DesPos->nY;
				m_Hand = nEquipIdx1;
				m_Items[FindSame(nEquipIdx1)].nPlace = pos_hand;
#ifdef _SERVER
				g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
			}
			// ��ԭ���Ķ����Ż�ȥ
			else
			{
				m_Room[room_compound].PlaceItem(SrcPos->nX, SrcPos->nY, nEquipIdx1, Item[nEquipIdx1].GetWidth(), Item[nEquipIdx1].GetHeight());
			}
		}
		// ��������û�ж�����ֻ��Ҫ�Ѽ������Ķ����ŵ������
		else
		{
			int nListIdx = FindSame(nEquipIdx1);
			if (nEquipIdx1 && nListIdx)
			{
				m_Items[nListIdx].nPlace = pos_hand;
				m_Hand = nEquipIdx1;
			}
#ifdef _SERVER
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&sMove, sizeof(sMove));
#endif
		}
		break;
	}


#ifndef _SERVER
	// Notify to Menu
	if (m_Hand != nTempHand)	// �����ɹ���
	{
	//uParam = (KUiObjAtRegion*)pInfo -> ��Ʒ���ݼ����������λ����Ϣ
	//nParam = bAdd -> 0ֵ��ʾ���������Ʒ����0ֵ��ʾ���������Ʒ
		KUiObjAtContRegion pInfo1, pInfo2;
		if (nTempHand == 0)
		{
			pInfo2.Obj.uGenre = CGOG_NOTHING;
			pInfo2.Obj.uId = 0;
			pInfo2.Region.Width = 0;
			pInfo2.Region.Height = 0;
		}
		else
		{
			pInfo2.Obj.uGenre = CGOG_ITEM;	//Դװ��
			pInfo2.Obj.uId = nTempHand;
			pInfo2.Region.Width = Item[nTempHand].GetWidth();
			pInfo2.Region.Height = Item[nTempHand].GetHeight();
		}
		
		if (m_Hand == 0)
		{
			pInfo1.Obj.uGenre = CGOG_NOTHING;
			pInfo1.Obj.uId = 0;
			pInfo1.Region.Width = 0;
			pInfo1.Region.Height = 0;
		}
		else
		{
			pInfo1.Obj.uGenre = CGOG_ITEM;
			pInfo1.Obj.uId = m_Hand;
			pInfo1.Region.Width = Item[m_Hand].GetWidth();
			pInfo1.Region.Height = Item[m_Hand].GetHeight();
		}

		int PartConvert[itempart_num] = 
		{
			UIEP_HEAD,
			UIEP_BODY,
			UIEP_WAIST,
			UIEP_HAND,
			UIEP_FOOT,
			UIEP_FINESSE,
			UIEP_NECK,
			UIEP_FINGER1,
			UIEP_FINGER2,
			UIEP_WAIST_DECOR,
			UIEP_HORSE,
			UIEP_SIGNET,
			UIEP_SHIPIN,
		};

		// TamLTM code kham nam xanh
		int PartBuildItem[MAX_PART_BUILD] = 
		{
			UIEP_BUILDITEM1,
			UIEP_BUILDITEM2,
			UIEP_BUILDITEM3,
			UIEP_BUILDITEM4,
			UIEP_BUILDITEM5,
			UIEP_BUILDITEM6,
			UIEP_BUILDITEM7,
			UIEP_BUILDITEM8,
			UIEP_BUILDITEM9,
		};
		//End code

		int PartCompoundConvert[MAX_COMPOUND_ITEM] =
		{
			MOSAICENCRUSTED_UIEP_BOX_1,
			MOSAICENCRUSTED_UIEP_BOX_2,
			MOSAICENCRUSTED_UIEP_BOX_3,
		};

		switch(SrcPos->nPlace)
		{
		case pos_immediacy:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_IMMEDIA_ITEM;
			pInfo2.eContainer = UOC_IMMEDIA_ITEM;
			break;
		case pos_equiproom:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_ITEM_TAKE_WITH;
			pInfo2.eContainer = UOC_ITEM_TAKE_WITH;
			break;
		case pos_equiproomex:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_ITEM_TAKE_WITH_EX;
			pInfo2.eContainer = UOC_ITEM_TAKE_WITH_EX;
			break;
		case pos_equip:
			pInfo1.Region.h = 0;
			pInfo1.Region.v = PartConvert[SrcPos->nX];
			pInfo2.Region.h = 0;
			pInfo2.Region.v = PartConvert[DesPos->nX];
			pInfo1.eContainer = UOC_EQUIPTMENT;
			pInfo2.eContainer = UOC_EQUIPTMENT;
			break;
		case pos_repositoryroom:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX;
			pInfo2.eContainer = UOC_STORE_BOX;
			break;
		case pos_repositoryroom1:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX1;
			pInfo2.eContainer = UOC_STORE_BOX1;
			break;
		case pos_repositoryroom2:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX2;
			pInfo2.eContainer = UOC_STORE_BOX2;
			break;
		case pos_repositoryroom3:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX3;
			pInfo2.eContainer = UOC_STORE_BOX3;
			break;
		case pos_repositoryroom4:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX4;
			pInfo2.eContainer = UOC_STORE_BOX4;
			break;
		case pos_repositoryroom5:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_STORE_BOX5;
			pInfo2.eContainer = UOC_STORE_BOX5;
			break;
		case pos_traderoom:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_TO_BE_TRADE;
			pInfo2.eContainer = UOC_TO_BE_TRADE;
			break;
		case pos_give:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_ITEM_GIVE;
			pInfo2.eContainer = UOC_ITEM_GIVE;
			break;
		case pos_compound:
			pInfo1.Region.h = 0;
			pInfo1.Region.v = PartCompoundConvert[SrcPos->nX];
			pInfo2.Region.h = 0;
			pInfo2.Region.v = PartCompoundConvert[DesPos->nX];
			pInfo1.eContainer = UOC_COMPOUND;
			pInfo2.eContainer = UOC_COMPOUND;
			break;
		//TamLTM Code kham nam xanh
		case pos_builditem:
			pInfo1.Region.h = 0;
			pInfo1.Region.v = PartBuildItem[SrcPos->nX];
			pInfo2.Region.h = 0;
			pInfo2.Region.v = PartBuildItem[DesPos->nX];
			pInfo1.eContainer = UOC_BUILD_ITEM;
			pInfo2.eContainer = UOC_BUILD_ITEM;
			break;
		//End code
		case pos_compoundroom:
			pInfo1.Region.h = SrcPos->nX;
			pInfo1.Region.v = SrcPos->nY;
			pInfo2.Region.h = DesPos->nX;
			pInfo2.Region.v = DesPos->nY;
			pInfo1.eContainer = UOC_COMPOUND_BOX;
			pInfo2.eContainer = UOC_COMPOUND_BOX;
			break;
		}
		CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&pInfo1, 0);
		CoreDataChanged(GDCNI_HOLD_OBJECT, (DWORD)&pInfo2, 0);
		CoreDataChanged(GDCNI_HOLD_OBJECT, (DWORD)&pInfo1, 1);
		CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&pInfo2, 1);
	}
#endif
	if (Npc[Player[m_PlayerIdx].m_nIndex].m_Doing == do_sit)
	{
		Npc[Player[m_PlayerIdx].m_nIndex].SendCommand(do_stand);
	}
}

#ifndef	_SERVER
//---------------------------------------------------------------------
//	���ܣ���Ʒ��һ���ط�ֱ���ƶ�����һ���ط����������������м����
//---------------------------------------------------------------------
BOOL	KItemList::AutoMoveItem(ItemPos SrcPos,ItemPos DesPos)
{
	if (Player[this->m_PlayerIdx].CheckTrading())	// ������ڽ���
		return FALSE;

	BOOL	bMove = FALSE;
	int		nIdx, nListIdx;

	// Ŀǰֻ֧�ִ�room_equipment��room_immediacy
	switch (SrcPos.nPlace)
	{
	case pos_equiproom:
		{
			switch (DesPos.nPlace)
			{
			case pos_immediacy:
				{
					nIdx = m_Room[room_equipment].FindItem(SrcPos.nX, SrcPos.nY);
					if (nIdx <= 0)
						return FALSE;
					if (Item[nIdx].GetGenre() == item_equip)
					//if (Item[nIdx].GetGenre() != item_medicine)
					{
						_ASSERT(0);
						return FALSE;
					}
					if (!m_Room[room_equipment].PickUpItem(nIdx, SrcPos.nX, SrcPos.nY, Item[nIdx].GetWidth(), Item[nIdx].GetHeight()))
						return FALSE;
					m_Room[room_immediacy].PlaceItem(DesPos.nX, DesPos.nY, nIdx, Item[nIdx].GetWidth(), Item[nIdx].GetHeight());
					nListIdx = FindSame(nIdx);
					if (nListIdx <= 0)
						return FALSE;
					m_Items[nListIdx].nPlace = pos_immediacy;
					m_Items[nListIdx].nX = DesPos.nX;
					m_Items[nListIdx].nY = DesPos.nY;
					bMove = TRUE;
				}
				break;
			}
		}
		break;
	}

	if (!bMove)
		return bMove;

	// ֪ͨ����
	KUiObjAtContRegion sSrcInfo, sDestInfo;

	sSrcInfo.Obj.uGenre		= CGOG_ITEM;
	sSrcInfo.Obj.uId		= nIdx;
	sSrcInfo.Region.Width	= Item[nIdx].GetWidth();
	sSrcInfo.Region.Height	= Item[nIdx].GetHeight();
	sSrcInfo.Region.h		= SrcPos.nX;
	sSrcInfo.Region.v		= SrcPos.nY;
	sSrcInfo.eContainer		= UOC_ITEM_TAKE_WITH;

	sDestInfo.Obj.uGenre	= CGOG_ITEM;
	sDestInfo.Obj.uId		= nIdx;
	sDestInfo.Region.Width	= Item[nIdx].GetWidth();
	sDestInfo.Region.Height	= Item[nIdx].GetHeight();
	sDestInfo.Region.h		= DesPos.nX;
	sDestInfo.Region.v		= DesPos.nY;
	sDestInfo.eContainer	= UOC_IMMEDIA_ITEM;

	CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&sSrcInfo, 0);
	CoreDataChanged(GDCNI_OBJECT_CHANGED, (DWORD)&sDestInfo, 1);

	return bMove;
}
#endif

#ifndef	_SERVER
//---------------------------------------------------------------------
//	���ܣ���Ʒ��һ���ط�ֱ���ƶ�����һ���ط����������������м����
//---------------------------------------------------------------------
void	KItemList::MenuSetMouseItem()
{
	KUiObjAtContRegion	sInfo;
	if (!m_Hand)
	{
		CoreDataChanged(GDCNI_HOLD_OBJECT, 0, 0);
	}
	else
	{
		sInfo.Obj.uGenre = CGOG_ITEM;
		sInfo.Obj.uId = m_Hand;
		sInfo.Region.Width = Item[m_Hand].GetWidth();
		sInfo.Region.Height = Item[m_Hand].GetHeight();
		sInfo.Region.h = 0;
		sInfo.Region.v = 0;
		sInfo.eContainer = UOC_IN_HAND;
		CoreDataChanged(GDCNI_HOLD_OBJECT, (DWORD)&sInfo, 0);
	}
}
#endif

#ifdef _SERVER
BOOL KItemList::EatItem(int nPlace, int nX, int nY)
{
	SO_ItemActionDiag("EatItem_COORD_BEGIN", 0, 0, nX, nY, 0, 0, nPlace, m_PlayerIdx);
	int nItemIdx = 0;
	switch(nPlace)
	{
	case pos_equiproom:
		nItemIdx = m_Room[room_equipment].FindItem(nX, nY);
		if (nItemIdx > 0 && nItemIdx < MAX_ITEM)
			return NowEatItem(nItemIdx);
		break;
	case pos_equiproomex:
		nItemIdx = m_Room[room_equipmentex].FindItem(nX, nY);
		if (nItemIdx > 0 && nItemIdx < MAX_ITEM)
			return NowEatItem(nItemIdx);
		break;
	case pos_immediacy:
		nItemIdx = m_Room[room_immediacy].FindItem(nX, nY);
		if (nItemIdx > 0 && nItemIdx < MAX_ITEM)
			return NowEatItem(nItemIdx);
		break;
	}

	return FALSE;
}

BOOL KItemList::EatItemByID(DWORD dwItemID, int nPlace, int nX, int nY)
{
	SO_ItemActionDiag("EatItemByID_BEGIN", 0, (unsigned int)dwItemID, nX, nY, 0, 0, nPlace, m_PlayerIdx);
	// Prefer the persistent id so a stale/mismatched UI coordinate cannot
	// consume another item.  Only inventory/quick-use rooms are executable.
	if (dwItemID != 0)
	{
		int nListIdx = FindSame(dwItemID);
		SO_ItemActionDiagText("EatItemByID_RESOLVE", "FindSame", nListIdx, (int)dwItemID);
		if (nListIdx > 0 && nListIdx < MAX_PLAYER_ITEM)
		{
			int nItemIdx = m_Items[nListIdx].nIdx;
			if (nItemIdx > 0 && nItemIdx < MAX_ITEM)
			{
				switch (m_Items[nListIdx].nPlace)
				{
				case pos_equiproom:
				case pos_equiproomex:
				case pos_immediacy:
				{
					BOOL bRet = NowEatItem(nItemIdx);
					SO_ItemActionDiag("EatItemByID_EXECUTE", Item[nItemIdx].GetGenre(), nItemIdx, m_Items[nListIdx].nX, m_Items[nListIdx].nY, 0, 0, m_Items[nListIdx].nPlace, bRet);
					return bRet;
				}
				default:
					break;
				}
			}
		}
	}

	// Compatibility path for clients predating persistent-id packets.
	return EatItem(nPlace, nX, nY);
}
#endif

PlayerItem* KItemList::GetFirstItem()
{
	m_nListCurIdx = m_UseIdx.GetNext(0);
	return &m_Items[m_nListCurIdx];
}

PlayerItem* KItemList::GetNextItem()
{
	if ( !m_nListCurIdx )
		return NULL;
	m_nListCurIdx = m_UseIdx.GetNext(m_nListCurIdx);
	return &m_Items[m_nListCurIdx];
}

void	KItemList::ClearRoom(int nRoom)
{
	if (nRoom >= 0 && nRoom < room_num)
		this->m_Room[nRoom].Clear();
}

void	KItemList::BackupTrade()
{
	if ( !m_Room[room_tradeback].m_pArray )
		m_Room[room_tradeback].Init(m_Room[room_equipment].m_nWidth, m_Room[room_equipment].m_nHeight);
	memcpy(m_Room[room_tradeback].m_pArray, m_Room[room_equipment].m_pArray, sizeof(int) * m_Room[room_tradeback].m_nWidth * m_Room[room_tradeback].m_nHeight);

	memcpy(this->m_sBackItems, this->m_Items, sizeof(PlayerItem) * MAX_PLAYER_ITEM);

	m_nBackHand = m_Hand;
}

void	KItemList::RecoverTrade()
{
	memcpy(m_Room[room_equipment].m_pArray, m_Room[room_tradeback].m_pArray, sizeof(int) * m_Room[room_tradeback].m_nWidth * m_Room[room_tradeback].m_nHeight);

#ifndef _SERVER
	int nIdx = 0;
	while((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		if (m_Items[nIdx].nPlace == pos_trade1)
			Remove(m_Items[nIdx].nIdx);
	}
/*	for (int i = 0; i < MAX_PLAYER_ITEM; i++)
	{
		if (m_Items[i].nIdx && m_Items[i].nPlace == pos_trade1)
			Remove(m_Items[i].nIdx);
	}*/
#endif
	memcpy(m_Items, m_sBackItems, sizeof(PlayerItem) * MAX_PLAYER_ITEM);
	m_Hand = m_nBackHand;
}

void	KItemList::StartTrade()
{
	BackupTrade();
	ClearRoom(room_trade);
	ClearRoom(room_trade1);
}

/*!*****************************************************************************
// Function		: KItemList::RemoveAll
// Purpose		: �˳�ʱ������е�װ��
// Return		: void
// Comments		: ��ʵ�ʵش���Ϸ�����еĵ���������ȥ��
// Author		: Spe
*****************************************************************************/
void KItemList::RemoveAll()
{
	int nIdx = m_UseIdx.GetNext(0);
	int nIdx1 = 0;
	while(nIdx)
	{
		nIdx1 = m_UseIdx.GetNext(nIdx);
		int nGameIdx = m_Items[nIdx].nIdx;
		Remove(m_Items[nIdx].nIdx);
#ifdef _SERVER
		// �ͻ���������KItemList::Remove()�Ѿ�����ItemSet.Remove()
		ItemSet.Remove(nGameIdx);
#endif
		nIdx = nIdx1;
	}
}

int KItemList::GetWeaponParticular()
{
	if (m_EquipItem[itempart_weapon])
		return Item[m_EquipItem[itempart_weapon]].GetParticularMelee();
	return -1;
}

int		KItemList::CountCommonItem(int nItemGenre, int nDetailType, int nLevel, int nSeries, int P)
{
	int		nIdx = 0;
	int nResult = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		int nGameIdx = m_Items[nIdx].nIdx;

		if (nItemGenre != Item[nGameIdx].GetGenre())
			continue;

		if (nDetailType > -1 && (nDetailType != Item[nGameIdx].GetDetailType()))
			continue;

		if (nLevel > -1 && (nLevel != Item[nGameIdx].GetLevel()))
			continue;

		if (nSeries > -1 && (nSeries != Item[nGameIdx].GetSeries()))
			continue;

		if (m_Items[nIdx].nPlace != P)
			continue;

		if (Item[nGameIdx].IsStack())
			nResult += Item[nGameIdx].GetStackNum();
		else
			nResult++;
	}
	return nResult;
}


int		KItemList::GetItemCountRoom(int P)
{
	int		nNo = 0;
	int		nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		if (m_Items[nIdx].nPlace != P)
			continue;
		nNo++;
	}
	return nNo;
}

int		KItemList::FindItem(int nItemGenre, int nDetailType, int nLevel, int nSeries)
{
	int		nIdx = 0;
	int nCount = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		int nGameIdx = m_Items[nIdx].nIdx;

		if (nItemGenre != Item[nGameIdx].GetGenre())
			continue;

		if (nDetailType > -1 && (nDetailType != Item[nGameIdx].GetDetailType()))
			continue;

		if (nLevel > -1 && (nLevel != Item[nGameIdx].GetLevel()))
			continue;

		if (nSeries > -1 && (nSeries != Item[nGameIdx].GetSeries()))
			continue;

		return nIdx;
	}
	return 0;
}

int		KItemList::FindItemByTemplateRow(int nTemplateRow)
{
	int		nIdx = 0;
	int nCount = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		int nGameIdx = m_Items[nIdx].nIdx;
		if (nTemplateRow == Item[nGameIdx].GetRow())
			return nIdx;
	}
	return 0;
}

#ifdef _SERVER
int KItemList::RemoveCommonItem(int nCount, int nItemGenre, int nDetailType, int nLevel, int nSeries, int P)
{
	int nIdx, nResult = 0;
	for (int i = 0; i < nCount; i++)
	{
		if (!FindSameToRemove(nItemGenre, nDetailType, nLevel, nSeries, P, &nIdx))
			break;

		if (nIdx)
		{
			if (Item[nIdx].IsStack() && 
				Item[nIdx].GetStackNum() > 1)
			{
				Item[nIdx].SetStackNum(Item[nIdx].GetStackNum() - 1);
				this->SyncItem(nIdx);
				nResult ++;
				continue;
			}
			else
			{
				this->Remove(nIdx);
				ItemSet.Remove(nIdx);
				nResult ++;
				continue;
			}
		}
	}
	return nResult;
}
#endif

#ifdef _SERVER
//--------------------------------------------------------------------------
//	���ܣ������а� trade room �е� item �� idx width height ��Ϣд�� itemset �е� m_psItemInfo ��ȥ
//--------------------------------------------------------------------------
void	KItemList::GetTradeRoomItemInfo()
{
	_ASSERT(ItemSet.m_psItemInfo);
//	if (!ItemSet.m_psItemInfo)
//	{
//		ItemSet.m_psItemInfo = new TRADE_ITEM_INFO[TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT];
//	}
	memset(ItemSet.m_psItemInfo, 0, sizeof(TRADE_ITEM_INFO) * TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT);

	int		nItemIdx, nXpos, nYpos, nPos;

	nItemIdx = 0;
	nXpos = 0;
	nYpos = 0;
	nPos = 0;

	while (1)
	{
		nItemIdx = m_Room[room_trade].GetNextItem(nItemIdx, nXpos, nYpos, &nXpos, &nYpos);
		if (nItemIdx == 0)
			break;
		_ASSERT(nPos < TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT);

		ItemSet.m_psItemInfo[nPos].m_nIdx = nItemIdx;
		ItemSet.m_psItemInfo[nPos].m_nWidth = Item[nItemIdx].GetWidth();
		ItemSet.m_psItemInfo[nPos].m_nHeight = Item[nItemIdx].GetHeight();
		nPos++;
	}

	// �Ӵ�С����
	TRADE_ITEM_INFO	sTemp;
	for (int i = nPos - 1; i >= 0; i--)
	{
		for (int j = 0; j < i; j++)
		{
			if (ItemSet.m_psItemInfo[j].m_nWidth * ItemSet.m_psItemInfo[j].m_nHeight < 
				ItemSet.m_psItemInfo[j + 1].m_nWidth * ItemSet.m_psItemInfo[j + 1].m_nHeight)
			{
				sTemp = ItemSet.m_psItemInfo[j];
				ItemSet.m_psItemInfo[j] = ItemSet.m_psItemInfo[j + 1];
				ItemSet.m_psItemInfo[j + 1] = sTemp;
			}
		}
	}
}
#endif

#ifdef _SERVER
//--------------------------------------------------------------------------
//	���ܣ��������ж��������Ʒ�ܲ�����ȫ�Ž��Լ�����Ʒ��
//--------------------------------------------------------------------------
BOOL	KItemList::TradeCheckCanPlace()
{
	LPINT	pnTempRoom;
	pnTempRoom = new int[EQUIPMENT_ROOM_WIDTH * EQUIPMENT_ROOM_HEIGHT];
	memcpy(pnTempRoom, m_Room[room_equipment].m_pArray, sizeof(int) * EQUIPMENT_ROOM_WIDTH * EQUIPMENT_ROOM_HEIGHT);

	int		nPos, i, j, a, b, nFind, nNext;
	for (nPos = 0; nPos < TRADE_ROOM_WIDTH * TRADE_ROOM_HEIGHT; nPos++)
	{
		if (!ItemSet.m_psItemInfo[nPos].m_nIdx)
			break;
		nFind = 0;
		for (i = 0; i < EQUIPMENT_ROOM_HEIGHT - ItemSet.m_psItemInfo[nPos].m_nHeight + 1; i++)
		{
			for (j = 0; j < EQUIPMENT_ROOM_WIDTH - ItemSet.m_psItemInfo[nPos].m_nWidth + 1; j++)
			{
				nNext = 0;
				for (a = 0; a < ItemSet.m_psItemInfo[nPos].m_nHeight; a++)
				{
					for (b = 0; b < ItemSet.m_psItemInfo[nPos].m_nWidth; b++)
					{
						if (pnTempRoom[(i + a) * EQUIPMENT_ROOM_WIDTH + j + b])
						{
							nNext = 1;
							break;
						}
					}
					if (nNext)
						break;
				}
				// �ҵ�һ��λ��
				if (!nNext)
				{
					// ���ݴ���
					ItemSet.m_psItemInfo[nPos].m_nX = j;
					ItemSet.m_psItemInfo[nPos].m_nY = i;
					for (a = 0; a < ItemSet.m_psItemInfo[nPos].m_nHeight; a++)
					{
						for (b = 0; b < ItemSet.m_psItemInfo[nPos].m_nWidth; b++)
							pnTempRoom[(i + a) * EQUIPMENT_ROOM_WIDTH + j + b] = ItemSet.m_psItemInfo[nPos].m_nIdx;
					}

					nFind = 1;
					break;
				}
			}
			if (nFind)
				break;
		}
		if (!nFind)
		{
			delete []pnTempRoom;
			return FALSE;
		}
	}

	delete []pnTempRoom;
	return TRUE;
}
#endif

//--------------------------------------------------------------------------
//	���ܣ��ж�һ����������Ʒ�ܷ�Ž���Ʒ�� (Ϊ�˷�����Ч�ʣ�����������û�е�����������)
//--------------------------------------------------------------------------
BOOL	KItemList::CheckCanPlaceInEquipment(int nWidth, int nHeight, int *pnP, int *pnX, int *pnY)
{
	if (nWidth <= 0 || nHeight <= 0 || !pnX || !pnY)
		return FALSE;

	_ASSERT(m_Room[room_equipment].m_pArray);

	LPINT	pnTempRoom;
	int		i, j, a, b, nNext;

	pnTempRoom = m_Room[room_equipment].m_pArray;

	for (i = 0; i < EQUIPMENT_ROOM_HEIGHT - nHeight + 1; i++)
	{
		for (j = 0; j < EQUIPMENT_ROOM_WIDTH - nWidth + 1; j++)
		{
			nNext = 0;
			for (a = 0; a < nHeight; a++)
			{
				for (b = 0; b < nWidth; b++)
				{
					if (pnTempRoom[(i + a) * EQUIPMENT_ROOM_WIDTH + j + b])
					{
						nNext = 1;
						break;
					}
				}
				if (nNext)
					break;
			}
			if (!nNext)
			{
				*pnP = pos_equiproom;
				*pnX = j;
				*pnY = i;
				return TRUE;
			}
		}
	}

	if (Player[m_PlayerIdx].m_dwEquipExpandTime - KSG_GetCurSec() > 0)
	{
		_ASSERT(m_Room[room_equipmentex].m_pArray);

		pnTempRoom = m_Room[room_equipmentex].m_pArray;

		for (i = 0; i < EQUIPMENT_ROOM_HEIGHT - nHeight + 1; i++)
		{
			for (j = 0; j < EQUIPMENT_ROOM_WIDTH - nWidth + 1; j++)
			{
				nNext = 0;
				for (a = 0; a < nHeight; a++)
				{
					for (b = 0; b < nWidth; b++)
					{
						if (pnTempRoom[(i + a) * EQUIPMENT_ROOM_WIDTH + j + b])
						{
							nNext = 1;
							break;
						}
					}
					if (nNext)
						break;
				}
				if (!nNext)
				{
					*pnP = pos_equiproomex;
					*pnX = j;
					*pnY = i;
					return TRUE;
				}
			}
		}
	}

	return FALSE;
}

#ifdef _SERVER
BOOL	KItemList::FindSameToRemove(int nItemGenre, int nDetailType, int nLevel, int nSeries, int P, int *pnIdx)
{
	return m_Room[PositionToRoom(P)].FindSameToRemove(nItemGenre, nDetailType, nLevel, nSeries, pnIdx);
}
//------------------------------------------------------------------------------
//	���ܣ��Զ���һ��ҩƷ��room_equipment�ƶ���room_immediacy
//------------------------------------------------------------------------------
BOOL	KItemList::AutoMoveItemFromEquipmentRoom(int nItemIdx, int nSrcX, int nSrcY, int nDestX, int nDestY)
{
	if (!m_Room[room_equipment].m_pArray || !m_Room[room_immediacy].m_pArray)
		return FALSE;
	if (nSrcX < 0 || nSrcX >= m_Room[room_equipment].m_nWidth || nSrcY < 0 || nSrcY >= m_Room[room_equipment].m_nHeight)
		return FALSE;
	if (nDestX < 0 || nDestX >= m_Room[room_immediacy].m_nWidth || nDestY < 0 || nDestY >= m_Room[room_immediacy].m_nHeight)
		return FALSE;
	if (nItemIdx != m_Room[room_equipment].m_pArray[nSrcY * m_Room[room_equipment].m_nWidth + nSrcX] ||
		0 != m_Room[room_immediacy].m_pArray[nDestY * m_Room[room_immediacy].m_nWidth + nDestX])
		return FALSE;

	_ASSERT(Item[nItemIdx].GetWidth() == 1 && Item[nItemIdx].GetHeight() == 1);
	if (!m_Room[room_equipment].PickUpItem(nItemIdx, nSrcX, nSrcY, Item[nItemIdx].GetWidth(), Item[nItemIdx].GetHeight()))
		return FALSE;
	if (!m_Room[room_immediacy].PlaceItem(nDestX, nDestY, nItemIdx, Item[nItemIdx].GetWidth(), Item[nItemIdx].GetHeight()))
	{
		m_Room[room_equipment].PlaceItem(nSrcX, nSrcY, nItemIdx, Item[nItemIdx].GetWidth(), Item[nItemIdx].GetHeight());
		return FALSE;
	}

	int nListIdx = FindSame(nItemIdx);
	_ASSERT(nListIdx > 0);
	m_Items[nListIdx].nPlace = pos_immediacy;
	m_Items[nListIdx].nX = nDestX;
	m_Items[nListIdx].nY = nDestY;

	PHONGTHAN_ITEM_MOVE_MESSAGE sMove;
	ZeroMemory(&sMove, sizeof(sMove));
	PhongThanInitializeWireHeader(&sMove.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE, sizeof(sMove),
		PHONGTHAN_WIRE_FLAG_NONE, 0);
	sMove.FromContainer = (PHONGTHAN_U8)pos_equiproom;
	sMove.FromX = (PHONGTHAN_U8)nSrcX;
	sMove.FromY = (PHONGTHAN_U8)nSrcY;
	sMove.ToContainer = (PHONGTHAN_U8)pos_immediacy;
	sMove.ToX = (PHONGTHAN_U8)nDestX;
	sMove.ToY = (PHONGTHAN_U8)nDestY;

//	g_DebugLog("s2c_ItemAutoMove %d", s2c_ItemAutoMove); //TamLTM Debug error packet

	if (g_pServer)
		g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, &sMove, sizeof(sMove));

	return TRUE;
}
#endif

void	KItemList::RemoveRoom(int nRoom)
{
	if (nRoom < 0 || nRoom >= room_num)
		return;

	int		nItemIdx, nXpos, nYpos, nPos;

	nItemIdx = 0;
	nXpos = 0;
	nYpos = 0;
	nPos = 0;

	while (1)
	{
		nItemIdx = m_Room[nRoom].GetNextItem(nItemIdx, nXpos, nYpos, &nXpos, &nYpos);
		if (nItemIdx == 0)
			break;
		_ASSERT(nPos < m_Room[nRoom].m_nWidth * m_Room[nRoom].m_nHeight);

		Remove(nItemIdx);
#ifdef _SERVER
		ItemSet.Remove(nItemIdx);
#endif
		nPos++;
	}
	ClearRoomItemOnly(nRoom);
}

int KItemList::CalcFreeItemCellCount(int nWidth, int nHeight, int nRoom)
{
	_ASSERT(m_Room[nRoom].m_pArray);

	return m_Room[nRoom].FindFreeCell(nWidth, nHeight);
}


#ifndef _SERVER
void KItemList::LockOperation()
{
	if (IsLockOperation())
	{
		_ASSERT(0);
		return;
	}
	m_bLockOperation = TRUE;
}
#endif

#ifndef _SERVER
void KItemList::UnlockOperation()
{
	if (!IsLockOperation())
	{
		return;
	}
	m_bLockOperation = FALSE;
}
#endif

int KItemList::GetActiveAttribNum(int nIdx)
{
	// Phong Than equipment has no SwordOnline elemental prefix/suffix graph.
	// Fixed properties are active immediately; set properties are counted below.
	return 0;
}

int KItemList::GetGoldActiveAttribNum(int nIdx)
{
	for (int i = 0; i < itempart_num; i++)
	{
		if (nIdx == m_EquipItem[i])
		{
			return GetGoldEquipEnhance(i);
		}
	}
	return 0;
}

#ifdef _SERVER
void		KItemList::AutoDurationItem(int nRate)
{
	if (nRate <= 0 || nRate > 100)
	return;
	
	int		nNo = 0;
	int		nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		
		int nGameIdx = m_Items[nIdx].nIdx;

		if (nGameIdx <= 0 || nGameIdx >= MAX_ITEM)
			continue;

        if (m_Items[nIdx].nPlace != pos_equip)
			continue;
	
		int  nDetail = Item[nGameIdx].GetDetailType();
		if (nDetail == 11 || nDetail == 10 || nDetail == 4 || nDetail == 9 || nDetail == 3)
			continue;
			
			int nOldDur = Item[nGameIdx].GetDurability();	
		if (nOldDur <= 0)
			continue;
			
			int Durability = nOldDur - (nRate * Item[nGameIdx].GetMaxDurability() / 100);
			if (Durability < 0)
			Durability = 1;

			Item[nGameIdx].SetDurability(Durability);
			
				SyncItemDurability(nGameIdx);
	}
}
#endif
#ifdef _SERVER
//-------------------------------------------------------------------------------
//	���ܣ���ʧ������Ʒ
//-------------------------------------------------------------------------------
void	KItemList::AutoLoseItemFromEquipmentRoom(int nRate)
{
	if (Player[m_PlayerIdx].CheckTrading())
		return;
	if (nRate <= 0 || nRate > 100)
		return;

	int		nItemIdx, nXpos, nYpos, nPos;

	nItemIdx = 0;
	nXpos = 0;
	nYpos = 0;
	nPos = 0;

	// ��ͳ��������Ʒ���ų�������Ʒ
	while (1)
	{
		nItemIdx = m_Room[room_equipment].GetNextItem(nItemIdx, nXpos, nYpos, &nXpos, &nYpos);
		if (nItemIdx == 0)
			break;
		if (Item[nItemIdx].GetLockDrop() || 
			Item[nItemIdx].GetLock()->IsLock())
			continue;
		ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nIdx = nItemIdx;
		ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nPlace = pos_equiproom;
		ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nX = nXpos;
		ItemSet.m_sLoseItemFromEquipmentRoom[nPos].nY = nYpos;
		nPos++;
	}
	if (nPos == 0)
		return;

	KMapPos			sMapPos;
	int				nSelect;
	int				nObj;
	KObjItemInfo	sInfo;

	for (int i = 0; i < nPos; i++)
	{
		if (g_Random(100) >= nRate)
			continue;
		nItemIdx = ItemSet.m_sLoseItemFromEquipmentRoom[i].nIdx;
		Player[m_PlayerIdx].GetAboutPos(&sMapPos);
		// ����
		if (Remove(nItemIdx))
		{
			sInfo.m_nItemID = nItemIdx;
			sInfo.m_nItemWidth = Item[nItemIdx].GetWidth();
			sInfo.m_nItemHeight = Item[nItemIdx].GetHeight();
			sInfo.m_nMoneyNum = 0;
			strcpy(sInfo.m_szName, Item[nItemIdx].GetName());
			sInfo.m_nColorID = Item[nItemIdx].GetQuality();
			sInfo.m_nGenre = Item[nItemIdx].GetGenre();
			sInfo.m_nDetailType = Item[nItemIdx].GetDetailType();
			sInfo.m_nMovieFlag = 1;
			sInfo.m_nSoundFlag = 1;
			sInfo.m_bOverLook = FALSE;

			nObj = ObjSet.Add(Item[nItemIdx].GetObjIdx(), sMapPos, sInfo);
			if (nObj >= 0)
			{
				Object[nObj].SetItemBelong(-1);
			}

			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_DEATH_LOSE_ITEM;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID) + sizeof(sInfo.m_szName);
			sMsg.m_lpBuf = new BYTE[sMsg.m_wLength + 1];
			memcpy(sMsg.m_lpBuf, &sMsg, sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID));
			memcpy((char*)sMsg.m_lpBuf + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), sInfo.m_szName, sizeof(sInfo.m_szName));
			g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
		}
	}
}
#endif

#ifdef _SERVER
//-------------------------------------------------------------------------------
//	���ܣ���ʧһ���������ϵ�װ��(�������)
//-------------------------------------------------------------------------------
void	KItemList::AutoLoseEquip()
{
#ifndef defEQUIP_POWER
	int		i, nPos = 0;

	for (i = 0; i < itempart_num; i++)
	{
		if (m_EquipItem[i] <= 0)
			continue;
		if (i == itempart_horse)
			continue;
		if (Item[ItemSet.m_sLoseEquipItem[nPos].nIdx].GetLockDrop() || 
			Item[ItemSet.m_sLoseEquipItem[nPos].nIdx].GetLock()->IsLock())
			continue;
		ItemSet.m_sLoseEquipItem[nPos].nIdx = m_EquipItem[i];
		ItemSet.m_sLoseEquipItem[nPos].nPlace = nPos;
		nPos++;
	}
	if (nPos == 0)
		return;

	int		nSelect = g_Random(nPos);
#endif

#ifdef defEQUIP_POWER
	int		i, nPos = 0, nTotalPower = 0;

	for (i = 0; i < itempart_num; i++)
	{
		if (m_EquipItem[i] <= 0)
			continue;
		nTotalPower += g_nEquipPower[i];
		ItemSet.m_sLoseEquipItem[nPos].nIdx = m_EquipItem[i];
		ItemSet.m_sLoseEquipItem[nPos].nPlace = nPos;
		ItemSet.m_sLoseEquipItem[nPos].nX = nTotalPower;	// nX ����һ��
		nPos++;
	}
	if (nTotalPower == 0)
		return;
	int		nSelect = g_Random(nTotalPower);
	for (i = 0; i < nPos; i++)
	{
		if (ItemSet.m_sLoseEquipItem[i].nX > nSelect)
		{
			nSelect = i;
			break;
		}
	}
	if (i >= nPos)
		return;
#endif

	int			 nItemIdx;
	KMapPos		sMapPos;

	nItemIdx = ItemSet.m_sLoseEquipItem[nSelect].nIdx;
	Player[m_PlayerIdx].GetAboutPos(&sMapPos);
	if (Remove(nItemIdx))
	{
		int		nObj;
		KObjItemInfo	sInfo;
		sInfo.m_nItemID = nItemIdx;
		sInfo.m_nItemWidth = Item[nItemIdx].GetWidth();
		sInfo.m_nItemHeight = Item[nItemIdx].GetHeight();
		sInfo.m_nMoneyNum = 0;
		strcpy(sInfo.m_szName, Item[nItemIdx].GetName());
		sInfo.m_nColorID = Item[nItemIdx].GetQuality();
		sInfo.m_nGenre = Item[nItemIdx].GetGenre();
		sInfo.m_nDetailType = Item[nItemIdx].GetDetailType();
		sInfo.m_nMovieFlag = 1;
		sInfo.m_nSoundFlag = 1;
		sInfo.m_bOverLook = FALSE;

		nObj = ObjSet.Add(Item[nItemIdx].GetObjIdx(), sMapPos, sInfo);
		if (nObj >= 0)
		{
			Object[nObj].SetItemBelong(-1);
		}

		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_DEATH_LOSE_ITEM;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID) + sizeof(sInfo.m_szName);
		sMsg.m_lpBuf = new BYTE[sMsg.m_wLength + 1];
		memcpy(sMsg.m_lpBuf, &sMsg, sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID));
		memcpy((char*)sMsg.m_lpBuf + sizeof(SHOW_MSG_SYNC) - sizeof(LPVOID), sInfo.m_szName, sizeof(sInfo.m_szName));
		g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, sMsg.m_lpBuf, sMsg.m_wLength + 1);
	}
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------------
//	���ܣ�
//-------------------------------------------------------------------------------
int		KItemList::GetSameDetailItemNum(int nImmediatePos)
{
	if (nImmediatePos < 0 || nImmediatePos >= IMMEDIACY_ROOM_WIDTH * IMMEDIACY_ROOM_HEIGHT)
		return 0;
	int		nIdx = m_Room[room_immediacy].FindItem(nImmediatePos, 0);
	if (nIdx <= 0)
		return 0;
	return m_Room[room_equipment].CalcSameDetailType(Item[nIdx].GetGenre(), Item[nIdx].GetDetailType(), Item[nIdx].GetLevel(), Item[nIdx].GetSeries()) + Item[nIdx].GetStackNum();
}
#endif

#ifdef _SERVER
//TamLTM Do ben == 0 thi trang bi hu hong
void KItemList::Abrade(int nType)
{
//	g_DebugLog("TamLTM 1 %d", nType);

	int nItemIdx = 0;
	for (int i = 0; i < itempart_num; i++)
	{
		nItemIdx = m_EquipItem[i];
		if (nItemIdx)
		{
			int nOldDur = Item[nItemIdx].GetDurability();
			if(nOldDur ==0)
				continue;
			int nDur = Item[nItemIdx].Abrade(nType == enumAbradeDefend ? PlayerSet.m_sPKPunishParam[Player[m_PlayerIdx].m_cPK.GetPKValue()].m_nAbradeP : 0, 
				ItemSet.GetAbradeRange(nType, i));
			if(nDur == -1)
				continue;
			if (nOldDur != nDur && nDur != -1) //TamLTM Fix
			{
			//	g_DebugLog("%d + %d", nOldDur, nDur);
				SyncItemDurability(nItemIdx);
			}
			if (nDur == 0)
			{
				Remove(nItemIdx);
				InsertEquipment(nItemIdx);
			//	g_DebugLog("nDur == 0", nDur);
			}
		}
	}

	//Cu~ Goc Code
/*	int nItemIdx = 0;
	for (int i = 0; i < itempart_num; i++)
	{
		nItemIdx = m_EquipItem[i];
		if (nItemIdx)
		{
			int nOldDur = Item[nItemIdx].GetDurability();
			int nDur = Item[nItemIdx].Abrade(ItemSet.GetAbradeRange(nType, i));
			if (nDur == 0)
			{
				// ���ͻ��˷���Ϣ
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				//sMsg.m_wMsgID = enumMSG_ID_ITEM_DAMAGED;
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
				sMsg.m_lpBuf = (void *)Item[nItemIdx].m_dwID;
				if (g_pServer)
					g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				sMsg.m_lpBuf = 0;

				Remove(nItemIdx);
				ItemSet.Remove(nItemIdx);
			}
			else if (nOldDur != nDur && nDur != -1)
			{
				SyncItemDurability(nItemIdx);
			}
		}
	}*/
}
#endif

BOOL KItemList::CanCombie(int Source, int Dest)
{
	if (Player[m_PlayerIdx].CheckTrading() )	// ���ڽ���
		return FALSE;
	if (Player[m_PlayerIdx].GetLockMove()->bLock)
		return FALSE;
	if  (Item[Source].GetLock()->IsLock())
		return FALSE;
	if (Item[Source].IsStack() && Item[Dest].IsStack() && 
		Item[Source].GetGenre() == Item[Dest].GetGenre() && 
		Item[Source].GetDetailType() == Item[Dest].GetDetailType() && 
		Item[Source].GetParticular() == Item[Dest].GetParticular() && 
		Item[Source].GetSeries() == Item[Dest].GetSeries() && 
		Item[Source].GetLevel() == Item[Dest].GetLevel() && 
		Item[Source].IsStack() == Item[Dest].IsStack() && 
		Item[Dest].GetStackNum() < Item[Dest].GetMaxStackNum() && 
		Item[Source].GetStackNum() < Item[Source].GetMaxStackNum() && 
		Item[Source].GetExpireTime() == Item[Dest].GetExpireTime() && 
		Item[Source].GetLockSell() == Item[Dest].GetLockSell() &&
		Item[Source].GetLockTrade() == Item[Dest].GetLockTrade() &&
		Item[Source].GetLockDrop() == Item[Dest].GetLockDrop() &&
		Item[Source].GetParam() == Item[Dest].GetParam()
	)
		return TRUE;

	return FALSE;
}


BOOL KItemList::CompareRemoveItem(int Source, int Dest)
{
	if (Player[m_PlayerIdx].CheckTrading() )	// ���ڽ���
		return FALSE;
	if (Item[Source].GetGenre() == Item[Dest].GetGenre() && 
		Item[Source].GetDetailType() == Item[Dest].GetDetailType() && 
		Item[Source].GetParticular() == Item[Dest].GetParticular() && 
		Item[Source].GetSeries() == Item[Dest].GetSeries() && 
		Item[Source].GetLevel() == Item[Dest].GetLevel() && 
		Item[Source].GetRow() == Item[Dest].GetRow() && 
		Item[Source].IsStack() == Item[Dest].IsStack() && 
		Item[Source].GetExpireTime() == Item[Dest].GetExpireTime() && 
		Item[Source].GetLockSell() == Item[Dest].GetLockSell() &&
		Item[Source].GetLockTrade() == Item[Dest].GetLockTrade() &&
		Item[Source].GetLockDrop() == Item[Dest].GetLockDrop() &&
		Item[Source].GetParam() == Item[Dest].GetParam()
		)
		return TRUE;
	return FALSE;
}

//Dong bo item
#ifdef _SERVER
void KItemList::SyncItem(int nIdx, BOOL bIsNew, int nPlace, int nX, int nY, int nPlayerIndex)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM ||
		nPlace < 0 || nPlace > 255 || nX < 0 || nX > 255 || nY < 0 || nY > 255 ||
		Item[nIdx].GetGenre() < 0 || Item[nIdx].GetGenre() > 255 ||
		Item[nIdx].GetSeries() < 0 || Item[nIdx].GetSeries() > 255 ||
		Item[nIdx].GetLevel() < 0 || Item[nIdx].GetLevel() > 255 ||
		Item[nIdx].m_GeneratorParam.nVersion < 0 ||
		Item[nIdx].m_GeneratorParam.nVersion > 65535 ||
		MAX_ITEM_MAGICLEVEL != PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT)
	{
		g_DebugLog("[PhongThanWire] Refuse invalid item snapshot idx=%d", nIdx);
		return;
	}

	PHONGTHAN_ITEM_SNAPSHOT sItem;
	ZeroMemory(&sItem, sizeof(sItem));
	PhongThanInitializeWireHeader(&sItem.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT, sizeof(sItem),
		PHONGTHAN_WIRE_FLAG_RESPONSE, 0);

	sItem.ItemId = Item[nIdx].GetID();
	sItem.OwnerId = Item[nIdx].GetOwner();
	sItem.TradePrice = Item[nIdx].GetTradePrice();
	sItem.TemplateRow = Item[nIdx].GetRow();
	sItem.DetailType = Item[nIdx].GetDetailType();
	sItem.ParticularType = Item[nIdx].GetParticular();
	sItem.Luck = Item[nIdx].m_GeneratorParam.nLuck;
	sItem.RandomSeed = Item[nIdx].m_GeneratorParam.uRandomSeed;
	sItem.GeneratorVersion = (PHONGTHAN_U16)Item[nIdx].m_GeneratorParam.nVersion;
	sItem.Genre = (PHONGTHAN_U8)Item[nIdx].GetGenre();
	sItem.Series = (PHONGTHAN_U8)Item[nIdx].GetSeries();
	sItem.Level = (PHONGTHAN_U8)Item[nIdx].GetLevel();
	sItem.Container = (PHONGTHAN_U8)nPlace;
	sItem.SlotX = (PHONGTHAN_U8)nX;
	sItem.SlotY = (PHONGTHAN_U8)nY;
	sItem.IsNew = bIsNew ? 1 : 0;
	sItem.IsTemporary = Item[nIdx].IsTemp() ? 1 : 0;
	sItem.LockSell = Item[nIdx].GetLockSell() ? 1 : 0;
	sItem.LockTrade = Item[nIdx].GetLockTrade() ? 1 : 0;
	sItem.LockDrop = Item[nIdx].GetLockDrop() ? 1 : 0;
	sItem.StackCount = Item[nIdx].GetStackNum();
	sItem.ExpireTime = Item[nIdx].GetExpireTime();
	sItem.Durability = Item[nIdx].GetDurability();
	sItem.LockState = Item[nIdx].GetLock()->nState;
	sItem.LockUntil = Item[nIdx].GetLock()->dwLockTime;
	sItem.Param = Item[nIdx].GetParam();
	sItem.Fortune = Item[nIdx].GetFortune();

	PlayerItem* pBack = Item[nIdx].GetBackLocal();
	sItem.BackIsSkill = pBack->bIsSkill ? 1 : 0;
	sItem.BackIndex = pBack->nIdx;
	sItem.BackContainer = pBack->nPlace;
	sItem.BackX = pBack->nX;
	sItem.BackY = pBack->nY;
	if (Item[nIdx].GetRow() == 59 || Item[nIdx].GetRow() == 249)
	{
		FILE* log = fopen("equipment_delivery.log", "a");
		if (log) { fprintf(log,"SEND id=%u row=%d detail=%d position=%d,%d,%d flags=%u\n",
			sItem.ItemId,sItem.TemplateRow,sItem.DetailType,nPlace,nX,nY,sItem.Header.Flags); fclose(log); }
	}
	sItem.UpgradeLevel = Item[nIdx].GetUpgradeState();
	sItem.PhysicalValue = Item[nIdx].m_CommonAttrib.nPhysicVal;
	sItem.MagicValue = Item[nIdx].m_CommonAttrib.nMagicVal;

	for (int j = 0; j < PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT; ++j)
		sItem.PropertyValues[j] = Item[nIdx].m_GeneratorParam.nGeneratorLevel[j];

	const int nTargetPlayer =
		(nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER) ? nPlayerIndex : m_PlayerIdx;
	if (nTargetPlayer > 0 && nTargetPlayer < MAX_PLAYER && g_pServer)
	{
		g_pServer->PackDataToClient(Player[nTargetPlayer].m_nNetConnectIdx,
			(BYTE*)&sItem, sizeof(sItem));
	}
}

void KItemList::SyncItemDurability(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM || m_PlayerIdx <= 0 || m_PlayerIdx >= MAX_PLAYER)
		return;
	SendPhongThanItemDurability(Player[m_PlayerIdx].m_nNetConnectIdx,
		Item[nIdx].GetID(), Item[nIdx].GetDurability());
}

void KItemList::SyncItemMagicAttrib(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM || m_PlayerIdx <= 0 ||
		m_PlayerIdx >= MAX_PLAYER || !g_pServer ||
		MAX_ITEM_MAGICLEVEL != PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT ||
		MAX_ITEM_MAGICATTRIB != PHONGTHAN_ITEM_ATTRIBUTE_COUNT)
	{
		return;
	}

	PHONGTHAN_ITEM_PROPERTIES_MESSAGE Message;
	ZeroMemory(&Message, sizeof(Message));
	PhongThanInitializeWireHeader(&Message.Header,
		PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES, sizeof(Message),
		PHONGTHAN_WIRE_FLAG_NONE, 0);
	Message.ItemId = Item[nIdx].GetID();
	for (int i = 0; i < PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT; ++i)
		Message.PropertyValues[i] = Item[nIdx].m_GeneratorParam.nGeneratorLevel[i];
	for (int j = 0; j < PHONGTHAN_ITEM_ATTRIBUTE_COUNT; ++j)
	{
		Message.Attributes[j].Type = Item[nIdx].m_aryMagicAttrib[j].nAttribType;
		for (int k = 0; k < 3; ++k)
			Message.Attributes[j].Value[k] = Item[nIdx].m_aryMagicAttrib[j].nValue[k];
	}
	g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx,
		&Message, sizeof(Message));
}


BOOL KItemList::RemoveItem(int nItemGenre,int nDetailType,int nParticularType,int nLevel)
{
	int nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		int nGameIdx = m_Items[nIdx].nIdx;
		if (	nItemGenre == Item[nGameIdx].GetGenre()
			&&	nDetailType == Item[nGameIdx].GetDetailType()
			&&  nParticularType == Item[nGameIdx].GetParticular()
			&&  nLevel == Item[nGameIdx].GetLevel()			
			)
		{
			Remove(nGameIdx);
			ItemSet.Remove(nGameIdx);
			return TRUE;
		}
	}
	return FALSE;
}

BOOL KItemList::RemoveItem(int nIdx, int nNum)
{
	if(nIdx<=0)
		return FALSE;
	if(nNum > Item[nIdx].GetStackNum())
		return FALSE;

	int nListIndex = FindSame(nIdx);
	if (!nListIndex)
	{
		_ASSERT(0);
		return FALSE;
	}

	if (nNum == 0 || nNum == Item[nIdx].GetStackNum())
	{
		if(m_Items[nListIndex].nPlace == pos_immediacy)
			goto REMOVE_IMMEDIACY;
		else
		{
			Remove(nIdx);
			ItemSet.Remove(nIdx);
			return TRUE;
		}
	}
	else
	{
		if (Item[nIdx].IsStack())
		{
			Item[nIdx].SetStackNum(Item[nIdx].GetStackNum() - nNum);
			this->SyncItem(nIdx);
			return TRUE;
		}
		else
		{
			if(m_Items[nListIndex].nPlace == pos_immediacy)
				goto REMOVE_IMMEDIACY;
			else
			{
				Remove(nIdx);
				ItemSet.Remove(nIdx);
				return TRUE;
			}
		}
	}

REMOVE_IMMEDIACY:
	int pnIdx,pnX,pnY;
	if (Player[m_PlayerIdx].m_ItemList.m_Room[room_equipment].FindSameItemToMove(nIdx, &pnIdx, &pnX, &pnY))
	{
		int nX = m_Items[nListIndex].nX;
		int nY = m_Items[nListIndex].nY;
		Remove(nIdx);
		ItemSet.Remove(nIdx);
		this->AutoMoveItemFromEquipmentRoom(pnIdx, pnX, pnY, nX, nY);
	}
	else
	{
		Remove(nIdx);
		ItemSet.Remove(nIdx);
	}
	return TRUE;
}

BOOL KItemList::Lock(int nIdx, BOOL bLock)
{
	if(nIdx<=0)
		return FALSE;
	if(Item[nIdx].GetLock()->nState == LOCK_STATE_FOREVER || Item[nIdx].GetLock()->nState == LOCK_STATE_CHARACTER)
		return FALSE;
	
	if(bLock != 1)
	return FALSE;
		
	if(Item[nIdx].GetLock()->nState == LOCK_STATE_LOCK)
	return FALSE;
	
	Item[nIdx].LockItem(LOCK_STATE_LOCK);
	
	SyncItem(nIdx);
	
	return TRUE;
}

BOOL KItemList::UnLock(int nIdx, BOOL bUnLock)
{
	if(nIdx<=0)
		return FALSE;
	if(Item[nIdx].GetLock()->nState == LOCK_STATE_FOREVER || Item[nIdx].GetLock()->nState == LOCK_STATE_CHARACTER)
		return FALSE;

	if (bUnLock != 2)
		return FALSE;
	if(Item[nIdx].GetLock()->nState == LOCK_STATE_UNLOCK || Item[nIdx].GetLock()->nState == LOCK_STATE_NORMAL)
		return FALSE;
	
	Item[nIdx].LockItem(259200);
	

	SyncItem(nIdx);
	

	return TRUE;
}

#endif
		

int		KItemList::GetItemNum(int nItemGenre, int nDetailType, int nParticular, int nLevel)
{
	int		nNo = 0, nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		{	
				if (nItemGenre == Item[m_Items[nIdx].nIdx].GetGenre() && 
					nDetailType == Item[m_Items[nIdx].nIdx].GetDetailType() && 
					nParticular == Item[m_Items[nIdx].nIdx].GetParticular() &&
					nLevel == Item[m_Items[nIdx].nIdx].GetLevel())
				{
					if (Item[m_Items[nIdx].nIdx].IsStack())
					{
						nNo += Item[m_Items[nIdx].nIdx].GetStackNum();
						break;
					}
					else
						nNo++;
				}
		}
	}
	return nNo;
}

//TamLTM Kham Nam xanh

BOOL KItemList::BuildItem(int nIdx, int nPlace /* = -1 */)
{
	if (m_PlayerIdx <= 0 || nIdx <= 0)
		return FALSE;

	
	int nItemListIdx = FindSame(nIdx);
	if (!nItemListIdx)
	{
		_ASSERT(0);
		return FALSE;
	}

	m_BuildItem[nPlace] = nIdx;
	m_Items[nItemListIdx].nPlace = pos_builditem;
	m_Items[nItemListIdx].nX = nPlace;
	m_Items[nItemListIdx].nY = 0;
	return TRUE;
}


void KItemList::UnBuildItem(int nIdx, int nPos/* = -1*/)
{
	int i = 0;
	if (m_PlayerIdx <= 0)
		return;

	if (nIdx <= 0)
		return;

	if (nPos <= 0)
	{
		for (i = 0; i < MAX_PART_BUILD; i++)
		{
			if (m_BuildItem[i] == nIdx)
				break;
		}
		if (i == MAX_PART_BUILD)
			return;

	}
	else
	{
		if (m_BuildItem[nPos] != nIdx)	// ????????
			return;
		i = nPos;
	}

	m_BuildItem[i] = 0;
	return;
}

//end code

BOOL KItemList::PutCompound(int nIdx, int nPlace /* = -1 */)
{
	if (m_PlayerIdx <= 0 || nIdx <= 0)
		return FALSE;

	
	int nItemListIdx = FindSame(nIdx);
	if (!nItemListIdx)
	{
		_ASSERT(0);
		return FALSE;
	}

	m_CompoundItem[nPlace] = nIdx;
	m_Items[nItemListIdx].nPlace = pos_compound;
	m_Items[nItemListIdx].nX = nPlace;
	m_Items[nItemListIdx].nY = 0;
	return TRUE;
}


void KItemList::DropCompound(int nIdx, int nPos/* = -1*/)
{
	int i = 0;
	if (m_PlayerIdx <= 0)
		return;

	if (nIdx <= 0)
		return;

	if (nPos <= 0)
	{
		for (i = 0; i < MAX_COMPOUND_ITEM; i++)
		{
			if (m_CompoundItem[i] == nIdx)
				break;
		}
		if (i == MAX_COMPOUND_ITEM)
			return;

	}
	else
	{
		if (m_CompoundItem[nPos] != nIdx)	// ��������
			return;
		i = nPos;
	}

	m_CompoundItem[i] = 0;
	return;
}

void KItemList::SetMaskLock( BOOL bFlag )
{
	m_bMaskLock = bFlag;
#ifdef _SERVER
	NPC_MASK_SYNC Sync;
	Sync.ProtocolType = s2c_syncmasklock;
	Sync.ID = m_bMaskLock;
	g_pServer->PackDataToClient(Player[m_PlayerIdx].m_nNetConnectIdx, (BYTE*)&Sync, sizeof(NPC_MASK_SYNC));
#endif
}


BOOL KItemList::IsEnoughToActive()
{
	for (int i = 0; i < itempart_num; ++i)
		if (m_EquipItem[i] > 0 && GetGoldEquipEnhance(i) > 0)
			return TRUE;
	return FALSE;
}

#ifdef _SERVER
void KItemList::BackLocal()
{
	int		nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)))
	{
		PlayerItem TempBackLocal = *Item[nIdx].GetBackLocal();
		if((TempBackLocal.nPlace < pos_hand) || (TempBackLocal.nPlace >= pos_num))
			continue;

		this->Remove(nIdx);

		Item[nIdx].GetBackLocal()->Release();

		if(m_Room[PositionToRoom(TempBackLocal.nPlace)].FindItem(TempBackLocal.nX, TempBackLocal.nY)<= 0)
		{
			Add(nIdx, TempBackLocal.nPlace, TempBackLocal.nX, TempBackLocal.nY, false);
		}
		else
		{
			InsertEquipment(nIdx);
		}
	}
}

void KItemList::InsertEquipment(int nIdx, bool bAutoStack)
{
	int p,x, y;
	if (CheckCanPlaceInEquipment(Item[nIdx].GetWidth(), Item[nIdx].GetHeight(), &p,&x, &y))
	{
		Add(nIdx, p, x, y, bAutoStack);
	}
	else
	{
		if  (Item[nIdx].GetLock()->IsLock())
		{
			POINT pPos;
			for(int nRoom = room_repository; nRoom <= room_repository+Player[m_PlayerIdx].m_btRepositoryNum && nRoom <= room_repository5; nRoom++)
			{
				if(m_Room[nRoom].FindRoom(Item[nIdx].GetWidth(), Item[nIdx].GetHeight(), &pPos))
				{
					Add(nIdx, pos_repositoryroom+nRoom-room_repository, pPos.x ,pPos.y);
					return;
				}
			}
		}

		int	nIndex = m_Hand;
		if (nIndex)
		{
			Remove(nIndex);
			
			KMapPos sMapPos;
			KObjItemInfo	sInfo;
			
			Player[m_PlayerIdx].GetAboutPos(&sMapPos);
			
			sInfo.m_nItemID = nIndex;
			sInfo.m_nItemWidth = Item[nIndex].GetWidth();
			sInfo.m_nItemHeight = Item[nIndex].GetHeight();
			sInfo.m_nMoneyNum = 0;
			strcpy(sInfo.m_szName, Item[nIndex].GetName());
			sInfo.m_nColorID = Item[nIndex].GetQuality();
			sInfo.m_nGenre = Item[nIndex].GetGenre();
			sInfo.m_nDetailType = Item[nIndex].GetDetailType();
			sInfo.m_nMovieFlag = 1;
			sInfo.m_nSoundFlag = 1;
			sInfo.m_bOverLook = FALSE;
			
			int nObj = ObjSet.Add(Item[nIndex].GetObjIdx(), sMapPos, sInfo);
			if (nObj >= 0)
			{
				if (Item[nIndex].LockPick())
				{
					Object[nObj].SetEntireBelong(this->m_PlayerIdx);
				}
				else
				{
					Object[nObj].SetItemBelong(this->m_PlayerIdx);
				}
			}
		}
		Add(nIdx, pos_hand, 0 ,0);
	}
}

void KItemList::ExecuteScript(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_ITEM || m_PlayerIdx <= 0)
		return;

	int nGenre = Item[nIdx].GetGenre();
	if (nGenre == item_magicscript && Item[nIdx].GetDetailType() == 61000) {
		extern bool PhongThanOpenStarterBag(KPlayer&, int);
		PhongThanOpenStarterBag(Player[m_PlayerIdx], nIdx);
		return;
	}
	if (nGenre == item_equip)
		return;

	if (nGenre == item_medicine)
	{
		Item[nIdx].ApplyMagicAttribToNPC(&Npc[Player[m_PlayerIdx].m_nIndex], MAX_ITEM_MAGICATTRIB / 2);
		return;
	}

	if (nGenre != item_event &&
		nGenre != item_townportal &&
		nGenre != item_magicscript &&
		nGenre != item_ibitem)
		return;

	char* szScriptFile = Item[nIdx].GetScript();
	SO_ItemActionDiagText("ExecuteScript_BEGIN", szScriptFile, nIdx, Item[nIdx].GetID());
	if (!szScriptFile || !szScriptFile[0])
		return;

	int nScriptLen = 0;
	while (nScriptLen < 128 && szScriptFile[nScriptLen])
		nScriptLen++;
	if (nScriptLen <= 4 || nScriptLen >= 128)
		return;

	for (int i = 0; i < nScriptLen; i++)
	{
		unsigned char ch = (unsigned char)szScriptFile[i];
		if (ch < 32 || ch == ':')
			return;
	}

	if (strstr(szScriptFile, ".."))
		return;

	char* pszExt = strrchr(szScriptFile, '.');
	if (!pszExt || _stricmp(pszExt, ".lua") != 0)
		return;

	// Phong Than 2026-10-05 natives-20261005: VNG item scripts are main(nLevel, nGenTime, nTargetNpc,
	// nItemIdx); scripts of this project are main(nItemIdx). Call main(idx, now, target, idx) through the
	// parameter-list form of ExecuteScript so both get the item index (PhongThanLuaItemNativesCore.h).
	// The engine stores no creation time: the use time stands in for nGenTime.
	char szItemMain[64];
	int nTargetNpc = 0;
	if (Player[m_PlayerIdx].m_nIndex > 0 && Player[m_PlayerIdx].m_nIndex < MAX_NPC)
		nTargetNpc = Npc[Player[m_PlayerIdx].m_nIndex].m_nPeopleIdx;
	if (nTargetNpc < 0 || nTargetNpc >= MAX_NPC)
		nTargetNpc = 0;
	sprintf(szItemMain, "%s(%d,%d,%d,%d)", NORMAL_FUNCTION_NAME, nIdx, (int)time(NULL), nTargetNpc, nIdx);
	BOOL bScriptRet = Player[m_PlayerIdx].ExecuteScript(szScriptFile, szItemMain, nIdx);
	SO_ItemActionDiagText("ExecuteScript_RESULT", szScriptFile, nIdx, bScriptRet);
}
#endif

int KItemList::PositionToIndex(int P, int i)
{
	if (P >= pos_hand && P < pos_num)
	{
		switch (P)
		{
		case pos_equip:
			return m_EquipItem[i];
		}
	}
	return 0;
}

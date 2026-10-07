#include "KEngine.h"
#include "KCore.h"
#include "KTabFile.h"
#include "KPlayer.h"
#include "KPlayerSet.h"
#include "KTongData.h"
#include "KNpc.h"
#include "KItemGenerator.h"
#include "KSubWorldSet.h"
#include "KItemSet.h"
#include "KBuySell.h"
#include "KObjSet.h"
#include "KTongProtocol.h"
#ifndef _STANDALONE
#include "CoreShell.h"
#include "crtdbg.h"
#endif
#include "CoreUseNameDef.h"
#ifdef _SERVER
//#include "../MultiServer/Heaven/Interface/iServer.h"
#endif

#include	<time.h>

#define	SHOP_BOX_WIDTH		6
#define	SHOP_BOX_HEIGHT		10
#define	SSHOP_BOX_WIDTH		12
#define	SSHOP_BOX_HEIGHT	10

#define PHONGTHAN_IBSHOP_GOODS_FILE "\\settings\\ibshop\\ibshopgoods.txt"

static char* g_PhongThanIBShopCategoryFiles[PHONGTHAN_IBSHOP_TAB_COUNT - 1] =
{
	"\\settings\\ibshop\\suggestgoods.txt",
	"\\settings\\ibshop\\potiongoods.txt",
	"\\settings\\ibshop\\charmgoods.txt",
	"\\settings\\ibshop\\upgradegoods.txt",
	"\\settings\\ibshop\\promisegoods.txt",
	"\\settings\\ibshop\\micsgoods.txt",
	"\\settings\\ibshop\\pendantgoods.txt",
	"\\settings\\ibshop\\specialgoods.txt"
};

static BOOL IsPhongThanIBShop(int nShop)
{
	return nShop >= PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX &&
		nShop < PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + PHONGTHAN_IBSHOP_TAB_COUNT;
}

static BOOL GenerateShopItem(const ItemGenerate& itemKey, KItem* pItem)
{
	if (!pItem)
		return FALSE;

	switch (itemKey.nGenre)
	{
	case item_equip:
		return ItemGen.Gen_Equipment(itemKey.nDetailType,
			itemKey.nParticularType, itemKey.nSeriesReq, itemKey.nLevel,
			NULL, 0, g_SubWorldSet.GetGameVersion(), pItem);
	case item_medicine:
		return ItemGen.Gen_Medicine(itemKey.nDetailType, itemKey.nLevel,
			g_SubWorldSet.GetGameVersion(), pItem);
	case item_event:
		return ItemGen.Gen_Event(itemKey.nDetailType, pItem);
	case item_materials:
		return ItemGen.Gen_Material(itemKey.nDetailType, pItem);
	case item_task:
		return ItemGen.Gen_Quest(itemKey.nDetailType, pItem);
	case item_townportal:
		return ItemGen.Gen_TownPortal(itemKey.nDetailType, pItem);
	case item_magicscript:
		return ItemGen.Gen_MagicScript(itemKey.nDetailType, pItem,
			itemKey.nLevel, itemKey.nSeriesReq, 0);
	case item_ibitem:
		return ItemGen.Gen_IBItem(itemKey.nDetailType, itemKey.nParticularType, pItem);
	default:
		return FALSE;
	}
}

KBuySell	BuySell;

KBuySell::KBuySell()
{
#ifndef _SERVER
	m_pShopRoom = NULL;
	m_pSShopRoom = NULL;
#endif
	m_Item = NULL;
	m_SellItem = NULL;
	m_Width = 0;
	m_Height = 0;
	m_ItemNum = 0;
}

KBuySell::~KBuySell()
{
#ifndef _SERVER
	if (m_pShopRoom)
	{
		delete m_pShopRoom;
		m_pShopRoom = NULL;
	}
	if (m_pSShopRoom)
	{
		delete m_pSShopRoom;
		m_pSShopRoom = NULL;
	}
#endif
	if (m_Item)
	{
		delete [] m_Item;
		m_Item = NULL;
	}
	if (m_SellItem)
	{
		for (int i = 0; i < m_Height; i++)
		{
			if (m_SellItem[i])
			{
				delete[] m_SellItem[i];
				m_SellItem[i] = NULL;
			}
		}
		delete[] m_SellItem;
		m_SellItem = NULL;
	}
	m_Width = 0;
	m_Height = 0;
	m_ItemNum = 0;
}

int KBuySell::Init()
{
	KTabFile		GoodsFile;
	KTabFile		BuySellFile;
	KTabFile		IBShopGoodsFile;
//	g_SetFilePath("\\");
	if (!BuySellFile.Load(BUYSELL_FILE) || !GoodsFile.Load(GOODS_FILE))
		return 0;

	int nGoodsHeight = GoodsFile.GetHeight() - 1;
	int nGoodsWidth = GoodsFile.GetWidth() - 1;
	if (nGoodsWidth <= 0 || nGoodsHeight <= 0)
		return 0;

	BOOL bHasIBShop = IBShopGoodsFile.Load(PHONGTHAN_IBSHOP_GOODS_FILE);
	int nIBShopHeight = bHasIBShop ? IBShopGoodsFile.GetHeight() - 1 : 0;
	const int nVngShopHeight = nIBShopHeight;
	int nTravelRow = -1;
	for (int travel = 0; travel < nVngShopHeight; ++travel)
	{
		int genre, detail, particular;
		IBShopGoodsFile.GetInteger(travel + 2, 2, -1, &genre);
		IBShopGoodsFile.GetInteger(travel + 2, 3, -1, &detail);
		IBShopGoodsFile.GetInteger(travel + 2, 4, -1, &particular);
		if (genre == item_ibitem && detail == 35 && particular == 2)
			{ nTravelRow = travel; break; }
	}
	// Use the original VNG IBItem record and Lua, not a synthetic item.
	if (bHasIBShop && nTravelRow < 0) nTravelRow = nIBShopHeight++;
	int nIBShopGenerated = 0;
	int nIBShopCategoryLoaded = 0;
	int nIBShopFailedRows[32];
	int nIBShopFailedCount = 0;
	int nItemCapacity = nGoodsHeight + nIBShopHeight;
	int* pIBShopItemIndex = NULL;

	m_Item = (KItem *)new KItem[nItemCapacity];
	if (!m_Item)
		return 0;
	if (nIBShopHeight > 0)
	{
		pIBShopItemIndex = new int[nIBShopHeight];
		if (!pIBShopItemIndex)
			return 0;
		for (int nIBInitRow = 0; nIBInitRow < nIBShopHeight; ++nIBInitRow)
			pIBShopItemIndex[nIBInitRow] = -1;
	}

	ItemGenerate itemKey;
	for (int k = 0; k < nGoodsHeight; ++k)
	{
		GoodsFile.GetInteger(k + 2, 1, -1, &itemKey.nGenre);
		GoodsFile.GetInteger(k + 2, 2, -1, &itemKey.nDetailType);
		GoodsFile.GetInteger(k + 2, 3, -1, &itemKey.nParticularType);
		GoodsFile.GetInteger(k + 2, 4, series_nil, &itemKey.nSeriesReq);
		GoodsFile.GetInteger(k + 2, 5, 0, &itemKey.nLevel);

		if (!GenerateShopItem(itemKey, &m_Item[m_ItemNum]))
			continue;
		m_Item[m_ItemNum].GetBackLocal()->Release();
		++m_ItemNum;
	}

	for (int nIBLoadRow = 0; nIBLoadRow < nIBShopHeight; ++nIBLoadRow)
	{
		int nStackCount = 1;
		int nNewArrival = 0;
		IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 2, -1, &itemKey.nGenre);
		if (nIBLoadRow == nVngShopHeight)
		{
			itemKey.nGenre = item_ibitem;
			itemKey.nDetailType = 35;
			itemKey.nParticularType = 2;
			itemKey.nLevel = 0;
			itemKey.nSeriesReq = 0;
		}
		else if (itemKey.nGenre >= item_number)
		{
			// A small VNG tail block omits the Genre cell. Its first numeric
			// value is the IBItem detail id, so restore the declared schema.
			itemKey.nDetailType = itemKey.nGenre;
			itemKey.nGenre = item_ibitem;
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 3, -1, &itemKey.nParticularType);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 4, 0, &itemKey.nLevel);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 5, series_nil, &itemKey.nSeriesReq);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 6, 1, &nStackCount);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 13, 0, &nNewArrival);
		}
		else
		{
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 3, -1, &itemKey.nDetailType);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 4, -1, &itemKey.nParticularType);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 5, 0, &itemKey.nLevel);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 6, series_nil, &itemKey.nSeriesReq);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 7, 1, &nStackCount);
			IBShopGoodsFile.GetInteger(nIBLoadRow + 2, 14, 0, &nNewArrival);
		}

		if (!GenerateShopItem(itemKey, &m_Item[m_ItemNum]))
		{
			if (nIBShopFailedCount < sizeof(nIBShopFailedRows) / sizeof(nIBShopFailedRows[0]))
				nIBShopFailedRows[nIBShopFailedCount++] = nIBLoadRow + 1;
			continue;
		}
		m_Item[m_ItemNum].SetNewPrice(PHONGTHAN_IBSHOP_UNIT_PRICE);
		m_Item[m_ItemNum].SetStackNum(nStackCount > 0 ? nStackCount : 1);
		m_Item[m_ItemNum].SetNewArrival(nNewArrival > 0);
		m_Item[m_ItemNum].GetBackLocal()->Release();
		pIBShopItemIndex[nIBLoadRow] = m_ItemNum;
		++m_ItemNum;
		++nIBShopGenerated;
	}

	int nNormalShopHeight = BuySellFile.GetHeight() - 1;
	int nIBShopEnd = PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + PHONGTHAN_IBSHOP_TAB_COUNT;
	m_Height = nNormalShopHeight > nIBShopEnd ? nNormalShopHeight : nIBShopEnd;
	m_Width = BuySellFile.GetWidth();
	if (nIBShopHeight > m_Width)
		m_Width = nIBShopHeight;
	
	if (m_Width <= 0 || m_Height <= 0)
	{
		delete [] pIBShopItemIndex;
		return 0;
	}

	m_SellItem = (int **)new int*[m_Height];
	if (!m_SellItem)
	{
		delete [] pIBShopItemIndex;
		return 0;
	}
	for (int i = 0; i < m_Height; i++)
	{
		m_SellItem[i] = NULL;
		m_SellItem[i] = (int *)new int[m_Width];
		if (!m_SellItem[i])
		{
			delete [] pIBShopItemIndex;
			return 0;
		}
		for (int j = 0; j < m_Width; ++j)
			m_SellItem[i][j] = -1;
	}

	for (int nNormalRow = 0; nNormalRow < nNormalShopHeight; ++nNormalRow)
	{
		for (int nNormalColumn = 0; nNormalColumn < BuySellFile.GetWidth(); ++nNormalColumn)
		{
			BuySellFile.GetInteger(nNormalRow + 2, nNormalColumn + 2, -1,
				&m_SellItem[nNormalRow][nNormalColumn]);
			if (m_SellItem[nNormalRow][nNormalColumn] == -1)
				continue;
			_ASSERT(m_SellItem[nNormalRow][nNormalColumn] > 0);		// ????????1??????
			if (m_SellItem[nNormalRow][nNormalColumn] > 0)
				m_SellItem[nNormalRow][nNormalColumn] -= 1;			// ??????????1????????
		}
	}

	if (pIBShopItemIndex)
	{
		for (int nCategory = 0; nCategory < PHONGTHAN_IBSHOP_TAB_COUNT - 1; ++nCategory)
		{
			KTabFile CategoryFile;
			if (!CategoryFile.Load(g_PhongThanIBShopCategoryFiles[nCategory]))
				continue;
			++nIBShopCategoryLoaded;
			int nCategorySlot = 0;
			// Put travel on page one of Suggested and Charms.
			if ((nCategory == 0 || nCategory == 2) && nTravelRow >= 0 &&
				pIBShopItemIndex[nTravelRow] >= 0)
				m_SellItem[PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + nCategory][nCategorySlot++] =
					pIBShopItemIndex[nTravelRow];
			for (int nRow = 2; nRow <= CategoryFile.GetHeight(); ++nRow)
			{
				int nIBIndex = 0;
				CategoryFile.GetInteger(nRow, 1, 0, &nIBIndex);
				if (nIBIndex <= 0 || nIBIndex > nIBShopHeight)
					continue;
				int nItemIndex = pIBShopItemIndex[nIBIndex - 1];
				if ((nCategory == 0 || nCategory == 2) && nIBIndex - 1 == nTravelRow)
					continue;
				if (nItemIndex >= 0 && nCategorySlot < m_Width)
					m_SellItem[PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + nCategory][nCategorySlot++] = nItemIndex;
			}
		}

		int nAllSlot = 0;
		for (int nIBAllRow = 0; nIBAllRow < nIBShopHeight; ++nIBAllRow)
		{
			if (pIBShopItemIndex[nIBAllRow] >= 0)
				m_SellItem[PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + PHONGTHAN_IBSHOP_TAB_COUNT - 1][nAllSlot++] = pIBShopItemIndex[nIBAllRow];
		}
	}
	delete [] pIBShopItemIndex;
#ifdef _SERVER
	FILE* pIBShopDiag = fopen("ibshop_loader_diag.log", "wt");
	if (pIBShopDiag)
	{
		fprintf(pIBShopDiag,
			"source=%s rows=%d generated=%d tabs=%d categories=%d unit_price=%d result=%s\n",
			PHONGTHAN_IBSHOP_GOODS_FILE, nIBShopHeight, nIBShopGenerated,
			PHONGTHAN_IBSHOP_TAB_COUNT, nIBShopCategoryLoaded,
			PHONGTHAN_IBSHOP_UNIT_PRICE,
			(bHasIBShop && nIBShopGenerated == nIBShopHeight &&
			 nIBShopCategoryLoaded == PHONGTHAN_IBSHOP_TAB_COUNT - 1) ? "ready" : "incomplete");
		if (nIBShopFailedCount > 0)
		{
			fprintf(pIBShopDiag, "failed_rows=");
			for (int nFailed = 0; nFailed < nIBShopFailedCount; ++nFailed)
				fprintf(pIBShopDiag, "%s%d", nFailed ? "," : "", nIBShopFailedRows[nFailed]);
			fprintf(pIBShopDiag, "\n");
		}
		fclose(pIBShopDiag);
	}
#endif
#ifndef _SERVER
	if (!m_pShopRoom)
	{
		m_pShopRoom = new KInventory;
		m_pShopRoom->Init(SHOP_BOX_WIDTH, SHOP_BOX_HEIGHT);
	}
	if (!m_pSShopRoom)
	{
		m_pSShopRoom = new KInventory;
		m_pSShopRoom->Init(SSHOP_BOX_WIDTH, SSHOP_BOX_HEIGHT);
	}
#endif
	return m_ItemNum;
}

KItem* KBuySell::GetItem(int nIndex)
{
	if (nIndex < 0 || nIndex >= m_ItemNum || !m_Item)
		return NULL;

	return &m_Item[nIndex];
}

int KBuySell::GetItemIndex(int nShop, int nIndex)
{
	if (!m_SellItem || nShop < 0 || nShop >= m_Height || nIndex < 0 || nIndex >= m_Width)
		return -1;

	if (!m_SellItem[nShop])
		return -1;

	return m_SellItem[nShop][nIndex];
}

BOOL KBuySell::BuySellCheck(int nBuy, int nBuyIdx)
{
	if (nBuy < 0 || nBuy >= m_Height)
		return FALSE;
	if (nBuyIdx < 0 || nBuyIdx >= m_Width)
		return FALSE;
	int nIdx = m_SellItem[nBuy][nBuyIdx];
	if (nIdx < 0 || nIdx >= m_ItemNum)
		return FALSE;

	return TRUE;
}

#ifdef _SERVER
BOOL KBuySell::CanBuy(int nPlayerIdx, int nBuy, int nBuyIdx, int nBuyNumber)
{
	BOOL bShowMsg = TRUE;
	if (nPlayerIdx < 0 || nPlayerIdx >= MAX_PLAYER)
	{
		_ASSERT(0);
		return FALSE;
	}
	if (Player[nPlayerIdx].CheckTrading())
		return FALSE;

	if (BuySellCheck(nBuy, nBuyIdx) == FALSE)
		return FALSE;

	if (nBuy == -1)
	{
		printf("[error]BuySell: %s buy idx error (%d)!", Npc[Player[nPlayerIdx].m_nIndex].Name, nBuy);
		return FALSE;
	}

	if (nBuyNumber <= 0)
		return FALSE;

	int nIdx = m_SellItem[nBuy][nBuyIdx];
	int nUnitPrice = IsPhongThanIBShop(nBuy) ? PHONGTHAN_IBSHOP_UNIT_PRICE : m_Item[nIdx].GetCurPrice();
	int nPrice = nUnitPrice * nBuyNumber;
	SHOW_MSG_SYNC	sMsg;
	sMsg.ProtocolType = s2c_msgshow;
	sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
	if (FALSE && !IsPhongThanIBShop(nBuy) && Npc[Player[nPlayerIdx].m_nIndex].m_FightMode)	/* Phong Than 2026-10-02: buy in fight mode too */
	{
		bShowMsg = FALSE;		
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR1;
	}
	else
	{
		switch (Player[nPlayerIdx].m_BuyInfo.m_nMoneyUnit)
		{
		case moneyunit_money:
			if (Player[nPlayerIdx].m_ItemList.GetEquipmentMoney() < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_MONEY;
			}
			break;
		case moneyunit_extpoint:
			if (Player[nPlayerIdx].GetExtPoint() < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_EXTPOINT;
			}
			break;
		case moneyunit_fuyuan:
			if (Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_FUYUAN) < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_FUYUAN;
			}
			break;
		case moneyunit_repute:
			if (Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_REPUTE) < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_REPUTE;
			}
			break;
		case moneyunit_accum:
			if (Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_ACCUM) < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_ACCUM;
			}	
			break;
		case moneyunit_honor:
			if (Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_HONOR) < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_HONOR;
			}
			break;
		case moneyunit_respect:
			if (Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_RESPECT) < nPrice)
			{
				bShowMsg = FALSE;		
				sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_RESPECT;
			}
			break;
		default:
			return FALSE;
		}
	}

	ItemPos	Pos;
	if (Player[nPlayerIdx].m_ItemList.SearchPosition(m_Item[nIdx].GetWidth(), m_Item[nIdx].GetHeight(), &Pos, true) == FALSE)
	{
		bShowMsg = FALSE;		
		sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_ROOM;
	}

	if (!bShowMsg)
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);	

	return bShowMsg;
}

BOOL KBuySell::Buy(int nPlayerIdx, int nBuy, int nBuyIdx, BYTE nBuyNumber)
{
	KASSERT(nPlayerIdx >= 0 && nPlayerIdx < MAX_PLAYER);

	if (nPlayerIdx < 0 || nPlayerIdx >= MAX_PLAYER ||
		nBuy < 0 || nBuy >= m_Height ||
		nBuyIdx < 0 || nBuyIdx >= m_Width || nBuyNumber == 0 ||
		!m_SellItem || !m_SellItem[nBuy])
	{
		printf("BuySell: invalid purchase player=%d shop=%d slot=%d count=%u",
			nPlayerIdx, nBuy, nBuyIdx, (unsigned int)nBuyNumber);
		return FALSE;
	}

	if (m_SellItem[nBuy][nBuyIdx] < 0 || m_SellItem[nBuy][nBuyIdx] >= m_ItemNum)
		return FALSE;

	if (CanBuy(nPlayerIdx, nBuy, nBuyIdx, nBuyNumber) == FALSE)
		return FALSE;
		
	int nIdx = m_SellItem[nBuy][nBuyIdx];
	int nWidth = m_Item[nIdx].GetWidth();
	int nHeight = m_Item[nIdx].GetHeight();

	if (m_Item[nIdx].GetExpirePoint())
	{
		m_Item[nIdx].SetExpireTime(KSG_GetCurSec() + m_Item[nIdx].GetExpirePoint());
	}

	int nPrice = IsPhongThanIBShop(nBuy) ? PHONGTHAN_IBSHOP_UNIT_PRICE : m_Item[nIdx].GetCurPrice();

	//TamLTM Thue bang hoi chiem linh thanh thi thon
	int nMoneyMapVG = 0;
//	bool m_bIsCheckMoneyGold = false;

	if (SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_bCheckTong /*&& m_bIsCheckMoneyGold*/)
	{
		int nTongVG = SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_nTongVG;
		if (nTongVG >= 0 && nTongVG <= 50)
		{
			if (SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_dwTongName == Player[nPlayerIdx].m_cTong.GetTongNameID())
			{
				nMoneyMapVG = nPrice * nTongVG / 200;
			}
			else
			{
				nMoneyMapVG = nPrice * nTongVG / 100;
			}

			if (nPrice <= nMoneyMapVG || nMoneyMapVG < 0)
			{
				nMoneyMapVG = 0;
			}
		}
	}
	//end code

	for(int i = 0; i < nBuyNumber; i++)
	{
		int nItemIdx = ItemSet.Add(&m_Item[nIdx]);

		if (nItemIdx <= 0)
			return FALSE;	

		ItemPos	Pos;
		if (Player[nPlayerIdx].m_ItemList.SearchPosition(nWidth, nHeight, &Pos, true))
		{
			Player[nPlayerIdx].m_ItemList.Add(nItemIdx, pos_equiproom, Pos.nX, Pos.nY);
		}
		else
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_SHOP_NO_ROOM;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			break;
		}
	}

	if (i)
	{
		switch (Player[nPlayerIdx].m_BuyInfo.m_nMoneyUnit)
		{
			case moneyunit_money:
				Player[nPlayerIdx].Pay((nPrice * i) + nMoneyMapVG);
		//		m_bIsCheckMoneyGold = true;
				break;
			case moneyunit_extpoint:
				Player[nPlayerIdx].PayExtPoint(nPrice*i);
		//		m_bIsCheckMoneyGold = false;
				break;
			case moneyunit_fuyuan:
				Player[nPlayerIdx].m_cTask.SetSaveVal(TASKVALUE_STATTASK_FUYUAN, 
					Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_FUYUAN)-(nPrice*i));
		//		m_bIsCheckMoneyGold = false;
				break;
			case moneyunit_repute:
				Player[nPlayerIdx].m_cTask.SetSaveVal(TASKVALUE_STATTASK_REPUTE, 
					Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_REPUTE)-(nPrice*i));
		//		m_bIsCheckMoneyGold = false;
				break;
			case moneyunit_accum:
				Player[nPlayerIdx].m_cTask.SetSaveVal(TASKVALUE_STATTASK_ACCUM, 
					Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_ACCUM)-(nPrice*i));
			//	m_bIsCheckMoneyGold = false;
				break;
			case moneyunit_honor:
				Player[nPlayerIdx].m_cTask.SetSaveVal(TASKVALUE_STATTASK_HONOR, 
					Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_HONOR)-(nPrice*i));
//				m_bIsCheckMoneyGold = false;
				break;
			case moneyunit_respect:
				Player[nPlayerIdx].m_cTask.SetSaveVal(TASKVALUE_STATTASK_RESPECT, 
					Player[nPlayerIdx].m_cTask.GetSaveVal(TASKVALUE_STATTASK_RESPECT)-(nPrice*i));
			//	m_bIsCheckMoneyGold = false; //
				break;
			default:
				printf("[error]BuySell %s moneyunit (%d)", Npc[Player[nPlayerIdx].m_nIndex].Name, Player[nPlayerIdx].m_BuyInfo.m_nMoneyUnit);
				break;
		}
	}

	// TamLTM Thue bang hoi chiem linh thanh thi thon
	if (Player[nPlayerIdx].m_ItemList.GetEquipmentMoney() < (nPrice + nMoneyMapVG) /*&& m_bIsCheckMoneyGold*/)
		return FALSE;

	if (SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_bCheckTong /*&& m_bIsCheckMoneyGold*/)
	{
//		m_bIsCheckMoneyGold = false;

		try
		{	
			bool bExecuteScriptMistake = true;
			KLuaScript * pScript = (KLuaScript* )g_GetScript("\\script\\item\\banghoi\\banghoi.lua");;
			if (pScript)
			{
				int nTopIndex = 0;
					
				pScript->SafeCallBegin(&nTopIndex);

				if (pScript->CallFunction("AddMoneyMain",0, "dsd", 
					SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_dwTongName, 
					SubWorld[Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex].m_szTongNameBC, nMoneyMapVG * i));
				{
					bExecuteScriptMistake = false;
				}

				pScript->SafeCallEnd(nTopIndex);
			}
		}
		catch(...)
		{
		//	printf("Exception Have Caught When Execute Script[%d]!!!!!", g_FileName2Id("\\script\\item\\banghoi\\banghoi.lua"));
		}
	}
	//end code */

	return TRUE;
}
/*******************************************************************************
???? nIdx ????????Item??????????
*******************************************************************************/
BOOL KBuySell::Sell(int nPlayerIdx, int nBuy, int nIdx, int nBuyNumber)
{
	KASSERT(nPlayerIdx >= 0 && nPlayerIdx < MAX_PLAYER);
	KASSERT(nIdx >= 0 && nIdx < MAX_ITEM);
	
	if (FALSE && Npc[Player[nPlayerIdx].m_nIndex].m_FightMode)	/* Phong Than 2026-10-02: sell in fight mode too */
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_FIGHT_MODE_ERROR1;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		if(g_pServer && Player[nPlayerIdx].m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}	
	
	if (nBuy == -1)
	{
		printf("BuySell: %s buy idx error!", Npc[Player[nPlayerIdx].m_nIndex].Name);
		return FALSE;
	}

	if (Item[nIdx].GetLock()->IsLock() || 
		Item[nIdx].GetLockSell())
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_LOCK_NOT_TRADE;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		if(g_pServer && Player[nPlayerIdx].m_nNetConnectIdx != -1)
			g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}

	int nMoney = Item[nIdx].GetSalePrice() * Item[nIdx].GetStackNum();

	if (nMoney)
		Player[nPlayerIdx].Earn(nMoney);
	Player[nPlayerIdx].m_ItemList.Remove(nIdx);
	ItemSet.Remove(nIdx);	

	return TRUE;
}
#endif

#ifndef _SERVER
void KBuySell::PaintItem(int nIdx, int nX, int nY, BOOL bStack)
{
	int nShop = Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nShopIdx[Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nCurShop];
	if (nShop < 0 || nShop >= m_Height)
		return;
	int nItemIdx = GetItemIndex(nShop, nIdx);

	int x = nX;
	int y = nY;

	KItem* pItem = GetItem(nItemIdx);

	if (pItem)
	{
		pItem->Paint(x, y, false, false);
	}
}

void KBuySell::OpenSale(BuySellInfo *pInfo)
{
	if (pInfo->m_nShopIdx[0] < 0 || pInfo->m_nShopIdx[0] >= m_Height)
		return;
	Player[CLIENT_PLAYER_INDEX].m_BuyInfo.Clear();
	Player[CLIENT_PLAYER_INDEX].m_BuyInfo = *pInfo;
	Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nCurShop = 0;
	CoreDataChanged(GDCNI_NPC_TRADE, NULL, TRUE);
}

void KBuySell::OpenSale(int nSaleType, BuySellInfo *pInfo)
{
	if(nSaleType < 0 || nSaleType > 1)
		return;

	Player[CLIENT_PLAYER_INDEX].m_BuyInfo.Clear();
	Player[CLIENT_PLAYER_INDEX].m_BuyInfo = *pInfo;
	Player[CLIENT_PLAYER_INDEX].m_BuyInfo.m_nCurShop = 0;
	CoreDataChanged(GDCNI_SUPERSHOP, (unsigned int)pInfo, nSaleType);
}
#endif

#ifdef _SERVER
void KBuySell::OpenSale(int nPlayerIdx, int nShop, int nShopMoneyUnit)
{
	if (nPlayerIdx <= 0 || nPlayerIdx > MAX_PLAYER)
		return;
	if (nShop < 0 || nShop >= m_Height)
		return;
	Player[nPlayerIdx].m_BuyInfo.Clear();
	Player[nPlayerIdx].m_BuyInfo.m_nShopIdx[0] = nShop;
	Player[nPlayerIdx].m_BuyInfo.m_nShopNum = 1;
	Player[nPlayerIdx].m_BuyInfo.m_nMoneyUnit = nShopMoneyUnit;
	Player[nPlayerIdx].m_BuyInfo.m_SubWorldID = Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex;
	Npc[Player[nPlayerIdx].m_nIndex].GetMpsPos(
		&Player[nPlayerIdx].m_BuyInfo.m_nMpsX,
		&Player[nPlayerIdx].m_BuyInfo.m_nMpsY);

	SALE_BOX_SYNC saleSync;
	saleSync.ProtocolType = s2c_opensalebox;
	memcpy(&saleSync.m_BuySellInfo, &Player[nPlayerIdx].m_BuyInfo, sizeof(BuySellInfo));
	g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, &saleSync, sizeof(SALE_BOX_SYNC));
}

void KBuySell::OpenSale(int nPlayerIdx, int nSaleType, int nMoneyUnit, int nShopNum, int *nShopId)
{
	if (nPlayerIdx <= 0 || nPlayerIdx > MAX_PLAYER)
		return;
	if(nSaleType < 0 || nSaleType > 1)
		return;
	if(nMoneyUnit < moneyunit_money || nMoneyUnit >= moneyunit_num)
		return;
	if(nShopNum <= 0 || nShopNum >= MAX_SUPERSHOP_SHOPTAB)
		return;

	Player[nPlayerIdx].m_BuyInfo.Clear();
	memcpy(&Player[nPlayerIdx].m_BuyInfo.m_nShopIdx, nShopId, sizeof(int) * MAX_SUPERSHOP_SHOPTAB);
	Player[nPlayerIdx].m_BuyInfo.m_nShopNum = nShopNum;
	Player[nPlayerIdx].m_BuyInfo.m_nMoneyUnit = nMoneyUnit;
	Player[nPlayerIdx].m_BuyInfo.m_SubWorldID = Npc[Player[nPlayerIdx].m_nIndex].m_SubWorldIndex;
	Npc[Player[nPlayerIdx].m_nIndex].GetMpsPos(
		&Player[nPlayerIdx].m_BuyInfo.m_nMpsX,
		&Player[nPlayerIdx].m_BuyInfo.m_nMpsY);

	S2C_SUPERSHOP	sSale;
	if (nShopNum == PHONGTHAN_IBSHOP_TAB_COUNT &&
		nShopId[0] == PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX)
	{
		PHONGTHAN_IBSHOP_OPEN_RESPONSE response;
		ZeroMemory(&response, sizeof(response));
		PhongThanInitializeWireHeader(&response.Header,
			PHONGTHAN_MSG_IBSHOP_OPEN_RESPONSE, sizeof(response),
			PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		response.ShopCount = nShopNum;
		memcpy(response.ShopIds, nShopId, sizeof(response.ShopIds));
		g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx,
			&response, sizeof(response));
		return;
	}
	sSale.ProtocolType = s2c_syncsupershop;
	sSale.m_nSaleType = nSaleType;
	memcpy(&sSale.m_BuySellInfo, &Player[nPlayerIdx].m_BuyInfo, sizeof(BuySellInfo));

//	g_DebugLog("s2c_syncsupershop %d", s2c_syncsupershop); //TamLTM Debug error packet

	g_pServer->PackDataToClient(Player[nPlayerIdx].m_nNetConnectIdx, (BYTE*)&sSale, sizeof(S2C_SUPERSHOP));
}
#endif


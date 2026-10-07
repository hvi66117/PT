/*******************************************************************************
// FileName			:	ScriptFuns.cpp
// FileAuthor		:	RomanDou
// FileCreateDate	:	2002-11-19 15:58:20
// FileDescription	:	????????????????
// Revision Count	:
*******************************************************************************/
#ifndef WIN32
#include <string>
#endif

#include "KWin32.h"
#include "KEngine.h"
#include "KDebug.h"
#include "KStepLuaScript.h"
#include "LuaLib.h"
#include "KScriptList.h"
#include <string.h>
#include "LuaFuns.h"
#include "KCore.h"
#include "PhongThanPlayerProtocol.h"
#include "KNpc.h"
#include "KSubWorld.h"
#include "KObjSet.h"
#include "KItemSet.h"
//#include "KNetClient.h"
#include "KScriptValueSet.h"
#include "KNpcSet.h"
#include "KPhongThanAppearance.h"
#include "KPlayerSet.h"
#include "KPlayer.h"
#include "PhongThanScriptWire.h"
#include "PhongThanNativeBroadcast.h"
#include "PhongThanGameplayProtocol.h"
#include "KPlayerTask.h"
#include "KSubWorldSet.h"
#include "KProtocolProcess.h"
#include "KBuySell.h"
#include "KTaskFuns.h"
#include "KPlayerDef.h"
#include "KGameData.h"
#include "KNpcTemplate.h"
#include "KTongData.h"
#include "KLadder.h"
#include "KMath.h"
#include "KSortScript.h"
#include "../../Engine/Src/Text.h"
#include "../../Engine/Src/KSG_StringProcess.h"
#include <time.h>
#ifdef _SERVER
//#include "KNetServer.h"
//#include "../MultiServer/Heaven/interface/iServer.h"
#include "../../../Headers/KProtocolDef.h"
#include "../../../Headers/KProtocol.h"
#include "../../../Headers/KRelayProtocol.h"
#include "../../../Headers/KTongProtocol.h"
#include "KNewProtocolProcess.h"
static void PhongThanBroadcastScriptAction(const KPhongThanScriptAction& action, bool local)
{
	PHONGTHAN_U8 packet[sizeof(PHONGTHAN_UI_ACTION_HEADER) + PHONGTHAN_UI_MAX_KEY + PHONGTHAN_UI_MAX_CONTENT];
	const unsigned int size = PhongThanBuildScriptPacket(action, packet, sizeof(packet));
	if (!size) return;
	if (local) g_NewProtocolProcess.BroadcastLocalServer(packet, size);
	else if (!PhongThanQueueUiBroadcast(packet, size)) g_DebugLog("[PhongThanUI] Global broadcast rejected");
}

#endif
#include "KSortScript.h"
#ifndef __linux
#include "Shlwapi.h"
#include "windows.h"
#include "lmcons.h"//Get computer Name
#include "winbase.h"
#include <direct.h>
#else
#include "unistd.h"
#endif

#ifdef _STANDALONE
#include "KSG_StringProcess.h"
#else
#include "../../Engine/Src/KSG_StringProcess.h"
#endif

#ifndef WIN32
typedef struct  _SYSTEMTIME
{
    WORD wYear;
    WORD wMonth;
    WORD wDayOfWeek;
    WORD wDay;
    WORD wHour;
    WORD wMinute;
    WORD wSecond;
    WORD wMilliseconds;
}	SYSTEMTIME;
typedef struct  _FILETIME
{
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
}	FILETIME;
#endif

#if !defined(_SERVER) && defined(PHONGTHAN_MODERN_BUILD)
#include <winsock2.h>
#endif
inline const char* _ip2a(DWORD ip) { in_addr ia; ia.s_addr = ip; return inet_ntoa(ia);}
inline DWORD _a2ip(const char* cp) { return inet_addr(cp);}

KScriptList		g_StoryScriptList;
KStepLuaScript * LuaGetScript(Lua_State * L);
int	GetPlayerIndex(Lua_State * L);
static int PhongThanQuestTeamMember(int team,int ordinal);
extern int g_GetPriceToStation(int,int);
extern int g_GetPriceToWayPoint(int,int);
extern int g_GetPriceToDock(int ,int );

//BitValue = GetBit(Value, BitNo)
int LuaGetBit(Lua_State * L)
{
    int nBitValue = 0;
    int nIntValue = (int)Lua_ValueToNumber(L, 1);
    int nBitNumber = (int)Lua_ValueToNumber(L, 2);

    if (nBitNumber >= 32 || nBitNumber <= 0)
        goto lab_getbit;
    nBitValue = (nIntValue & (1 << (nBitNumber - 1))) != 0;
    lab_getbit:
    Lua_PushNumber(L, nBitValue);
    return 1;
}

//NewBit = SetBit(Value, BitNo, BitValue)
int LuaSetBit(Lua_State * L)
{
    int nIntValue = (int)Lua_ValueToNumber(L, 1);
    int nBitNumber = (int)Lua_ValueToNumber(L, 2);
    int nBitValue = (int)Lua_ValueToNumber(L,3);
    nBitValue = (nBitValue == 1);

    if (nBitNumber > 32 || nBitNumber <= 0)
        goto lab_setbit;

    if(nBitValue)nIntValue = (int)((unsigned int)nIntValue | (1u << (nBitNumber - 1)));
    else nIntValue = (int)((unsigned int)nIntValue & ~(1u << (nBitNumber - 1)));
    lab_setbit:
    Lua_PushNumber(L, nIntValue);
    return 1;
}

//ByteValue = GetByte(Value, ByteNo)
int LuaGetByte(Lua_State * L)
{
    int nByteValue = 0;
    int nIntValue = (int)Lua_ValueToNumber(L, 1);
    int nByteNumber = (int)Lua_ValueToNumber(L, 2);

    if (nByteNumber > 4 || nByteNumber <= 0)
        goto lab_getByte;
    nByteValue = ((unsigned int)nIntValue >> ((nByteNumber - 1) * 8)) & 0xff;

    lab_getByte:
    Lua_PushNumber(L, nByteValue);
    return 1;
}

//NewByte = SetByte(Value, ByteNo, ByteValue)
int LuaSetByte(Lua_State * L)
{
    BYTE * pByte =	NULL;
    int nIntValue = (int)Lua_ValueToNumber(L, 1);
    int nByteNumber = (int)Lua_ValueToNumber(L, 2);
    int nByteValue = (int)Lua_ValueToNumber(L,3);
    nByteValue = (nByteValue & 0xff);

    if (nByteNumber > 4 || nByteNumber <= 0)
        goto lab_setByte;

    pByte = (BYTE*)&nIntValue;
    *(pByte + (nByteNumber -1)) = (BYTE)nByteValue;
    //nIntValue = (nIntValue | (0xff << ((nByteNumber - 1) * 8) )) ;
    lab_setByte:
    Lua_PushNumber(L, nIntValue);
    return 1;
}
//------------------------------

//============================================
int GetSubWorldIndex(Lua_State * L)
{
    const int top=Lua_GetTopIndex(L);
    Lua_GetGlobal(L, SCRIPT_SUBWORLDINDEX);
    int nIndex=lua_isnumber(L,-1)?(int)Lua_ValueToNumber(L,-1):-1;
    Lua_SetTopIndex(L,top);
    if (nIndex >= MAX_SUBWORLD || nIndex < 0)
    {
        _ASSERT(0);
        return -1;
    }
    if (SubWorld[nIndex].m_nIndex >= MAX_SUBWORLD || SubWorld[nIndex].m_nIndex < 0)
    {
        _ASSERT(0);
        return -1;
    }
    return nIndex;
}

//Idx = SubWorldID2Idx(dwID)
int LuaSubWorldIDToIndex(Lua_State * L)
{
    int nTargetSubWorld = -1;
    int nSubWorldID = 0;
    if (Lua_GetTopIndex(L) < 1)
        goto lab_subworldid2idx;

    nSubWorldID = (int)Lua_ValueToNumber(L, 1);
    nTargetSubWorld = g_SubWorldSet.SearchWorld(nSubWorldID);

    lab_subworldid2idx:
    Lua_PushNumber(L, nTargetSubWorld);
    return 1;
}

int LuaSubWorldIndexToID(Lua_State * L)
{
    int nTargetSubWorld = -1;
    int nSubWorldIndex = 0;
    if (Lua_GetTopIndex(L) < 1)
        goto lab_subworldid2idx;

    nSubWorldIndex = (int)Lua_ValueToNumber(L, 1);
    nTargetSubWorld = SubWorld[nSubWorldIndex].m_SubWorldID;

    lab_subworldid2idx:
    Lua_PushNumber(L, nTargetSubWorld);
    return 1;
}

/*
Say(sMainInfo, nSelCount, sSel1, sSel2, sSel3, .....,sSeln)
Say(nMainInfo, nSelCount, sSel1, sSel2, sSel3, .....,sSeln)
Say(nMainInfo, nSelCount, SelTab)
????????????????????????????????????????????????????????????????????????????????????????

  Say(100, 3, 10, 23,43)
  Say("??????????????????", 2, "??????/yes", "??????/no");
  Say("????????", 2, SelTab);
*/
//**************************************************************************************************************************************************************
//												?????????????????
//**************************************************************************************************************************************************************
int LuaSelectUI(Lua_State * L)
{
    char * strMain  = NULL;
    int nMainInfo = 0;
    int nDataType = 0;
    int nOptionNum = 0;
    int nReduceVal = 0;
    char * pImage = NULL;
    char * pContent = NULL;

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;
    Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;

    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 2) return 0;

    if (nParamNum > 3 && (pImage = strstr((char *)Lua_ValueToString(L,1), "LINK:")))
    {
        nReduceVal = 2;
    }
    if (nParamNum > 2 && Lua_IsNumber(L,2+nReduceVal))
    {
        nOptionNum = (int)Lua_ValueToNumber(L,2+nReduceVal);
        if (nReduceVal && nParamNum < 5) nOptionNum = 0;
    }
    else
    {
        //_ASSERT(0);
        //return 0;
        nOptionNum = 0;
    }

    if  (Lua_IsNumber(L,1+nReduceVal))
    {
        nMainInfo = (int)Lua_ValueToNumber(L,1+nReduceVal);
        nDataType = 1 ;
    }
    else if (Lua_IsString(L, 1+nReduceVal)) 	//???????????????????????????????????????????????????????????????????????????????????
    {
        strMain = (char *)Lua_ValueToString(L, 1+nReduceVal);
        nDataType = 0 ;
    }
    else
        return 0;

    BOOL bStringTab = FALSE;//???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

    if (Lua_IsString(L,3+nReduceVal))
        bStringTab = FALSE;
    else if (Lua_IsTable(L, 3+nReduceVal))
    {
        bStringTab = TRUE;
    }
    else
    {
        if (nOptionNum > 0) return 0;
    }

    if (bStringTab == FALSE)
    {
        //???????????????????????????????????????????????
        if (nOptionNum > nParamNum - 2+nReduceVal) nOptionNum = nParamNum - 2+nReduceVal;
    }

    if (nOptionNum < 0) nOptionNum = 0;
    if (nOptionNum > MAX_ANSWERNUM) nOptionNum = MAX_ANSWERNUM;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    ZeroMemory(Player[nPlayerIndex].m_szTaskAnswerFun, sizeof(Player[nPlayerIndex].m_szTaskAnswerFun));
    UiInfo.View = UI_SELECTDIALOG;
    UiInfo.ResourceText = nDataType;//????????????????????????????????????????????????(0)??????????????????(1)
    UiInfo.BooleanArgument = (BOOL)nReduceVal;
    if (UiInfo.BooleanArgument)
    {
        g_StrCpyLen(UiInfo.Key, pImage + 5, sizeof(UiInfo.Key));
        UiInfo.AuxiliaryArgument = (int)Lua_ValueToNumber(L,2);
    }
    else
    {
        memset(UiInfo.Key, 0, sizeof(UiInfo.Key));
        UiInfo.AuxiliaryArgument = 0;
    }

    //??????????????????????????????
    if (nDataType == 0)
    {
        if (strMain)
            g_StrCpyLen(UiInfo.Content, strMain, sizeof(UiInfo.Content));
        pContent = UiInfo.Content;
    }
    else if (nDataType == 1) //????????????????????????????????
    {
        *(int *)UiInfo.Content = nMainInfo;
        pContent = UiInfo.Content + sizeof(int);
        *pContent = 0;
    }

    int nOptionCount = 0;
    for (int i  = 0; i < nOptionNum; i ++)
    {
        char  pAnswer[100];
        pAnswer[0] = 0;

        if (bStringTab)
        {
            Lua_PushNumber(L, i + 1);
            Lua_RawGet(L, 3+nReduceVal);
            char * pszString = (char *)Lua_ValueToString(L, Lua_GetTopIndex(L));
            if (pszString)
            {
                g_StrCpyLen(pAnswer, pszString, 100);
            }
        }
        else
        {
            char * pszString = (char *)Lua_ValueToString(L, i + 3+nReduceVal);
            if (pszString)
                g_StrCpyLen(pAnswer, pszString, 100);
        }
        char * pFunName = strstr(pAnswer, "/");

        if (pFunName)
        {
            g_StrCpyLen(Player[nPlayerIndex].m_szTaskAnswerFun[i], pFunName + 1, sizeof(Player[nPlayerIndex].m_szTaskAnswerFun[0]));
            *pFunName = 0;
            int nUsed = strlen(pContent);
            int nContentOffset = (int)(pContent - UiInfo.Content);
            int nRemaining = sizeof(UiInfo.Content) - nContentOffset - nUsed;
            if (nRemaining <= 2)
                break;
            pContent[nUsed] = '|';
            pContent[nUsed + 1] = 0;
            g_StrCpyLen(pContent + nUsed + 1, pAnswer, nRemaining - 1);
        }
        else
        {
            //strcpy(Player[nPlayerIndex].m_szTaskAnswerFun[i], NORMAL_FUNCTION_NAME);
            //sprintf(pContent, "%s|%s", pContent, pAnswer);
            break;
        }
        nOptionCount++;
    }

    if(nParamNum > ((bStringTab?1:nOptionCount)+2+nReduceVal+1))
        UiInfo.NumberArgument = (int)Lua_ValueToNumber(L, (bStringTab?1:nOptionCount)+2+nReduceVal+1);
    else
        UiInfo.NumberArgument = -1;
    UiInfo.OptionCount = nOptionCount;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    Player[nPlayerIndex].m_nAvailableAnswerNum = nOptionCount;
    if (nDataType == 0)
        UiInfo.ContentLength  = strlen(pContent);
    else
        UiInfo.ContentLength = strlen(pContent) + sizeof(int);

#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif

    if (nOptionNum == 0)
    {
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    }
    else
    {
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = true;
    }
    Player[nPlayerIndex].m_SelUiScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

//AddGlobalNews(Newsstr)
int LuaAddGlobalNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_NORMAL;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;
    int nTimes = 1;
    if(Lua_GetTopIndex(L) > 1)
        nTimes = (int)Lua_ValueToNumber(L,2);

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTimes;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTimes;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}


int LuaAddGlobalNews2(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO1;
    UiInfo.OptionCount = NEWSMESSAGE_NORMAL;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;
    int nTimes = 1;
    if(Lua_GetTopIndex(L) > 1)
        nTimes = (int)Lua_ValueToNumber(L,2);

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTimes;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTimes;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}
//AddLocalNews(Newsstr)
int LuaAddLocalNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_NORMAL;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;
    int nTimes = 1;
    if(Lua_GetTopIndex(L) > 1)
        nTimes = (int)Lua_ValueToNumber(L,2);

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTimes;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTimes;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, true);
#endif
    return 0;
}

//AddGlobalCountNews(strNew/newid, time)
int LuaAddGlobalCountNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 2)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_COUNTING;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    int nTime = (int)Lua_ValueToNumber(L,2);

    if (nTime <= 0)
        nTime = 1;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTime;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTime;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}

int LuaAddGlobalCountNews2(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO1;
    UiInfo.OptionCount = NEWSMESSAGE_COUNTING;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    int nTime = (int)Lua_ValueToNumber(L,2);

    if (nTime <= 0)
        nTime = 1;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTime;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTime;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}
//AddLocalCountNews(strNew/newid, time)
int LuaAddLocalCountNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 2)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_COUNTING;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    int nTime = (int)Lua_ValueToNumber(L,2);

    if (nTime <= 0)
        nTime = 1;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        *(int *)((char *)UiInfo.Content + sizeof(int)) = nTime;
        UiInfo.ContentLength = sizeof(int) * 2;
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
        *(int *)((char *)UiInfo.Content + UiInfo.ContentLength) = nTime;
        UiInfo.ContentLength += sizeof(int);
        UiInfo.ResourceText = 0;
    }

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, true);
#endif
    return 0;
}

//AddGlobalTimeNews(strNew/newid, year,month,day,hour,mins)
int LuaAddGlobalTimeNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 6)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_TIMEEND;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        UiInfo.ContentLength = sizeof(int) + sizeof(SYSTEMTIME);
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content)) + sizeof(SYSTEMTIME);
        UiInfo.ResourceText = 0;
    }

    SYSTEMTIME *pSystemTime = 	(SYSTEMTIME *)((char *)UiInfo.Content + UiInfo.ContentLength - sizeof(SYSTEMTIME));
    memset(pSystemTime, 0, sizeof(SYSTEMTIME));

    SYSTEMTIME LocalTime ;
    memset(&LocalTime, 0, sizeof(SYSTEMTIME));

    LocalTime.wYear = (WORD)Lua_ValueToNumber(L,2);
    LocalTime.wMonth =(WORD)Lua_ValueToNumber(L,3);
    LocalTime.wDay = (WORD)Lua_ValueToNumber(L, 4);
    LocalTime.wHour = (WORD)Lua_ValueToNumber(L,5);
    LocalTime.wMinute = (WORD)Lua_ValueToNumber(L,6);
    FILETIME ft;
    FILETIME sysft;
#ifdef WIN32
    SystemTimeToFileTime(&LocalTime, &ft);
	LocalFileTimeToFileTime(&ft, &sysft);
	FileTimeToSystemTime(&sysft, pSystemTime);
#else
    memcpy(pSystemTime, &LocalTime, sizeof(LocalTime));
#endif

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}


int LuaAddGlobalTimeNews2(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 6)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO1;
    UiInfo.OptionCount = NEWSMESSAGE_TIMEEND;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        UiInfo.ContentLength = sizeof(int) + sizeof(SYSTEMTIME);
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content)) + sizeof(SYSTEMTIME);
        UiInfo.ResourceText = 0;
    }

    SYSTEMTIME *pSystemTime = 	(SYSTEMTIME *)((char *)UiInfo.Content + UiInfo.ContentLength - sizeof(SYSTEMTIME));
    memset(pSystemTime, 0, sizeof(SYSTEMTIME));

    SYSTEMTIME LocalTime ;
    memset(&LocalTime, 0, sizeof(SYSTEMTIME));

    LocalTime.wYear = (WORD)Lua_ValueToNumber(L,2);
    LocalTime.wMonth =(WORD)Lua_ValueToNumber(L,3);
    LocalTime.wDay = (WORD)Lua_ValueToNumber(L, 4);
    LocalTime.wHour = (WORD)Lua_ValueToNumber(L,5);
    LocalTime.wMinute = (WORD)Lua_ValueToNumber(L,6);
    FILETIME ft;
    FILETIME sysft;
#ifdef WIN32
    SystemTimeToFileTime(&LocalTime, &ft);
	LocalFileTimeToFileTime(&ft, &sysft);
	FileTimeToSystemTime(&sysft, pSystemTime);
#else
    memcpy(pSystemTime, &LocalTime, sizeof(LocalTime));
#endif

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, false);
#endif
    return 0;
}

//AddLocalTimeNews(strNew/newid, year,month,day,hour,mins)
int LuaAddLocalTimeNews(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 6)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NEWSINFO;
    UiInfo.OptionCount = NEWSMESSAGE_TIMEEND;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    if (Lua_IsNumber(L,1))
    {
        nMsgId = (int)Lua_ValueToNumber(L,1);
        *((int *)(UiInfo.Content)) = nMsgId;
        UiInfo.ResourceText = 1;
        UiInfo.ContentLength = sizeof(int) + sizeof(SYSTEMTIME);
    }
    else
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 512);
        UiInfo.ContentLength = strlen(((char *)UiInfo.Content)) + sizeof(SYSTEMTIME);
        UiInfo.ResourceText = 0;
    }

    SYSTEMTIME *pSystemTime = 	(SYSTEMTIME *)((char *)UiInfo.Content + UiInfo.ContentLength - sizeof(SYSTEMTIME));
    memset(pSystemTime, 0, sizeof(SYSTEMTIME));

    SYSTEMTIME LocalTime ;
    memset(&LocalTime, 0, sizeof(SYSTEMTIME));

    LocalTime.wYear = (WORD)Lua_ValueToNumber(L,2);
    LocalTime.wMonth =(WORD)Lua_ValueToNumber(L,3);
    LocalTime.wDay = (WORD)Lua_ValueToNumber(L, 4);
    LocalTime.wHour = (WORD)Lua_ValueToNumber(L,5);
    LocalTime.wMinute = (WORD)Lua_ValueToNumber(L,6);
    FILETIME ft;
    FILETIME sysft;
#ifdef WIN32
    SystemTimeToFileTime(&LocalTime, &ft);
	LocalFileTimeToFileTime(&ft, &sysft);
	FileTimeToSystemTime(&sysft, pSystemTime);
#else
    memcpy(pSystemTime, &LocalTime, sizeof(LocalTime));
#endif

#ifndef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    UiInfo.ServerOwned = 0;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
    UiInfo.ServerOwned = 1;
	PhongThanBroadcastScriptAction(UiInfo, true);
#endif
    return 0;
}

//AddNote(str/strid)
int LuaAddNote(Lua_State * L)
{
    //int nMainInfo = 0;
    //int nDataType = 0;

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0)
        return 0;

    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 3)
        return 0;


    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NOTEINFO;
    UiInfo.ResourceText = 0;//nDataType;//????????????????????????????????????????????????(0)??????????????????(1)
#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif

    UiInfo.OptionCount = 0;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.BooleanArgument = FALSE;

    int nParam2 = 0;

    if  (Lua_IsNumber(L,3))
    {
        UiInfo.ResourceText = 1 ;
    }
    else if (Lua_IsString(L, 3))
    {
        UiInfo.ResourceText = 0 ;
    }
    else
        return 0;

    if (nParamNum > 3)
    {
        nParam2 = (int)Lua_ValueToNumber(L, 4);
    }

    sprintf(UiInfo.Content, "%s|%s",(char *)Lua_ValueToString(L, 1),
            (char *)Lua_ValueToString(L, 3));
    UiInfo.NumberArgument = (int)Lua_ValueToNumber(L,2);

    int nLen = strlen(UiInfo.Content);
    *(int*)(UiInfo.Content + nLen) = nParam2;
    UiInfo.ContentLength = nLen + sizeof(int)+1;

    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

int LuaAddMissionNote(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0)
        return 0;

    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 3)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NOTEINFO;
    UiInfo.ResourceText = 0;//nDataType;//????????????????????????????????????????????????(0)??????????????????(1)
#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif

    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.BooleanArgument = TRUE;

    int nParam2 = 0;

    if  (Lua_IsNumber(L,2))
    {
        UiInfo.ResourceText = 1 ;
    }
    else if (Lua_IsString(L, 2))
    {
        UiInfo.ResourceText = 0 ;
    }
    else
        return 0;

    if (nParamNum > 2)
    {
        nParam2 = (int)Lua_ValueToNumber(L, 3);
    }

    sprintf(UiInfo.Content, "%s|%s",(char *)Lua_ValueToString(L, 1),
            (char *)Lua_ValueToString(L, 2));

    int nLen = strlen(UiInfo.Content);
    *(int*)(UiInfo.Content + nLen) = nParam2;
    UiInfo.ContentLength = nLen + sizeof(int)+1;

    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

// Phong Than VNG task-note projection. The original TaskNote API addresses a
// task template and a step. This engine already has a stable UI_NOTEINFO wire
// contract, so keep that ordinal and project VNG task updates into its 36
// journal headers. The full task id and every dynamic argument remain visible
// in the record text instead of being discarded.
static int PhongThanTaskHeader(int nTaskId)
{
    if (nTaskId < 0)
        nTaskId = -nTaskId;
    return nTaskId % 36;
}

static void SendPhongThanTaskRecord(int nPlayerIndex, int nTaskId,
    int nStep, int nAction, const char *pszText)
{
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER ||
        Player[nPlayerIndex].m_nIndex <= 0 || !pszText || !pszText[0])
        return;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_NOTEINFO;
    UiInfo.ResourceText = 0;
#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif
    UiInfo.OptionCount = 0;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.BooleanArgument = FALSE;
    UiInfo.NumberArgument = nAction;

    char szHeader[16];
    sprintf(szHeader, "%d", PhongThanTaskHeader(nTaskId));
    _snprintf(UiInfo.Content, sizeof(UiInfo.Content) - sizeof(int) - 2,
        "%s|%s", szHeader, pszText);
    UiInfo.Content[sizeof(UiInfo.Content) - sizeof(int) - 2] = 0;

    int nLen = strlen(UiInfo.Content);
    // UI_NOTEINFO's legacy decoder expects a trailing integer. Keep it zero so
    // it also terminates the preceding string on every byte order.
    *(int *)(UiInfo.Content + nLen) = 0;
    UiInfo.ContentLength = nLen + sizeof(int) + 1;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
}

static void BuildPhongThanTaskText(Lua_State *L, int nTaskId, int nStep,
    int nFirstArgument, char *pszText, int nTextSize)
{
    if (!pszText || nTextSize <= 0)
        return;
    _snprintf(pszText, nTextSize - 1, "Task %d - step %d", nTaskId, nStep);
    pszText[nTextSize - 1] = 0;

    int nTop = Lua_GetTopIndex(L);
    for (int i = nFirstArgument; i <= nTop; ++i)
    {
        const char *pszValue = Lua_ValueToString(L, i);
        if (!pszValue)
            continue;
        int nUsed = strlen(pszText);
        if (nUsed >= nTextSize - 4)
            break;
        _snprintf(pszText + nUsed, nTextSize - nUsed - 1,
            "%s%s", i == nFirstArgument ? ": " : ", ", pszValue);
        pszText[nTextSize - 1] = 0;
    }
}

int LuaTaskNoteCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 2)
        return 0;
    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nStep = (int)Lua_ValueToNumber(L, 2);
    int nAction = nStep < 0 ? 2 : (nStep == 0 ? 0 : 1);
    char szText[MAX_SCIRPTACTION_BUFFERNUM - 64];
    BuildPhongThanTaskText(L, nTaskId, nStep, 3, szText, sizeof(szText));
    SendPhongThanTaskRecord(nPlayerIndex, nTaskId, nStep, nAction, szText);
    return 0;
}

int LuaNewTaskNoteCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 1)
        return 0;
    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nStep = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    char szText[MAX_SCIRPTACTION_BUFFERNUM - 64];
    BuildPhongThanTaskText(L, nTaskId, nStep, 3, szText, sizeof(szText));
    SendPhongThanTaskRecord(nPlayerIndex, nTaskId, nStep, 0, szText);
    return 0;
}

int LuaFinishNpcCollectionCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 1)
        return 0;
    int nCollectionId = (int)Lua_ValueToNumber(L, 1);
    char szName[128];
    char szDescription[512];
    szName[0] = 0;
    szDescription[0] = 0;

    KTabFile Collection;
    if (Collection.Load("\\settings\\npccollection.txt"))
    {
        for (int nRow = 2; nRow <= Collection.GetHeight(); ++nRow)
        {
            int nId = -1;
            Collection.GetInteger(nRow, 1, -1, &nId);
            if (nId == nCollectionId)
            {
                Collection.GetString(nRow, 2, "", szName, sizeof(szName));
                Collection.GetString(nRow, 3, "", szDescription, sizeof(szDescription));
                break;
            }
        }
        Collection.Clear();
    }

    char szText[768];
    if (szName[0] || szDescription[0])
        _snprintf(szText, sizeof(szText) - 1, "%s%s%s",
            szName, szName[0] && szDescription[0] ? ": " : "", szDescription);
    else
        _snprintf(szText, sizeof(szText) - 1, "NPC collection %d complete", nCollectionId);
    szText[sizeof(szText) - 1] = 0;
    SendPhongThanTaskRecord(nPlayerIndex, 34, nCollectionId, 2, szText);
    Lua_PushNumber(L, (szName[0] || szDescription[0]) ? 1 : 0);
    return 1;
}

#include "PhongThanNpcDialogLua.inl"

int LuaSetPlayerTaskStateCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 2)
    {
        Player[nPlayerIndex].m_nPhongThanTaskState = (int)Lua_ValueToNumber(L, 1);
        Player[nPlayerIndex].m_nPhongThanTaskSubState = (int)Lua_ValueToNumber(L, 2);
        ++Player[nPlayerIndex].m_dwPhongThanTaskRevision;
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_TASK_STATE,
            Player[nPlayerIndex].m_nPhongThanTaskState, TRUE);
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_TASK_SUB_STATE,
            Player[nPlayerIndex].m_nPhongThanTaskSubState, TRUE);
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_TASK_REVISION,
            (int)Player[nPlayerIndex].m_dwPhongThanTaskRevision, TRUE);
    }
    return 0;
}

int LuaSetMateTaskCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
#ifdef _SERVER
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 2)
    {
        // In VNG marriage scripts "Mate" means the other member of the
        // current two-person team before a marriage exists. The old port only
        // searched TASKVALUE_BASEDATA_MATENAME, making the proposal handshake
        // impossible for unmarried players.
        int nMateIndex = 0;
        if (Player[nPlayerIndex].m_cTeam.m_nFlag)
        {
            int nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
            if (nTeamId >= 0 && nTeamId < MAX_TEAM &&
                g_Team[nTeamId].m_nMemNum == 1)
            {
                if (g_Team[nTeamId].m_nCaptain == nPlayerIndex)
                    nMateIndex = g_Team[nTeamId].m_nMember[0];
                else
                    nMateIndex = g_Team[nTeamId].m_nCaptain;
            }
        }
        if (nMateIndex <= 0)
        {
            const char *pszMate = Player[nPlayerIndex].m_cTask.GetSaveStr(
                TASKVALUE_BASEDATA_MATENAME);
            nMateIndex = PlayerSet.GetNextPlayerFrom(0);
            while (nMateIndex > 0)
            {
                if (pszMate && pszMate[0] &&
                    strcmp(Player[nMateIndex].Name, pszMate) == 0)
                    break;
                nMateIndex = PlayerSet.GetNextPlayerFrom(nMateIndex);
            }
        }
        int nTaskId = (int)Lua_ValueToNumber(L, 1);
        if (nMateIndex > 0 && nMateIndex < MAX_PLAYER &&
            Player[nMateIndex].m_nIndex > 0 && nTaskId >= 0 &&
            nTaskId < MAX_TASK)
        {
            Player[nMateIndex].m_cTask.SetSaveVal(nTaskId,
                (int)Lua_ValueToNumber(L, 2), TRUE);
            nResult = 1;
        }
    }
#endif
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaSetSubTaskCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 3)
        return 0;
    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nSubTask = (int)Lua_ValueToNumber(L, 2);
    int nState = (int)Lua_ValueToNumber(L, 3);
    char szText[160];
    _snprintf(szText, sizeof(szText) - 1, "Task %d - subtask %d - state %d",
        nTaskId, nSubTask, nState);
    szText[sizeof(szText) - 1] = 0;
    SendPhongThanTaskRecord(nPlayerIndex, nTaskId, nSubTask,
        nSubTask < 0 ? 2 : (nState ? 1 : 0), szText);
    return 0;
}

int LuaRefreshAllNpcTaskCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
    {
        ++Player[nPlayerIndex].m_dwPhongThanTaskRevision;
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_TASK_REVISION,
            (int)Player[nPlayerIndex].m_dwPhongThanTaskRevision, TRUE);
    }
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        (double)Player[nPlayerIndex].m_dwPhongThanTaskRevision : 0);
    return 1;
}

int LuaIsNewBirthCompleteCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nNpcIndex = nPlayerIndex > 0 ? Player[nPlayerIndex].m_nIndex : 0;
    Lua_PushNumber(L, nNpcIndex > 0 && nNpcIndex < MAX_NPC &&
        Npc[nNpcIndex].m_byTranslife > 0 ? 1 : 0);
    return 1;
}

static int GetJEMainTaskBit(int nPlayerIndex, int nTaskId)
{
    if (nPlayerIndex <= 0 || nTaskId <= 0 || nTaskId > 128)
        return 0;
    int nTask = TASKVALUE_PT_JE_MAIN_TASK_BEGIN + (nTaskId - 1) / 32;
    unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTask);
    return (nValue & (1U << ((nTaskId - 1) % 32))) != 0;
}

static int SetJEMainTaskBit(int nPlayerIndex, int nTaskId)
{
    if (nPlayerIndex <= 0 || nTaskId <= 0 || nTaskId > 128)
        return 0;
    int nTask = TASKVALUE_PT_JE_MAIN_TASK_BEGIN + (nTaskId - 1) / 32;
    unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTask);
    nValue |= 1U << ((nTaskId - 1) % 32);
    Player[nPlayerIndex].m_cTask.SetSaveVal(nTask, (int)nValue, TRUE);
    return 1;
}

int LuaIsJEMainTaskCompleteCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTaskId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    Lua_PushNumber(L, GetJEMainTaskBit(nPlayerIndex, nTaskId));
    return 1;
}

int LuaJEMainTaskCompleteCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTaskId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    Lua_PushNumber(L, SetJEMainTaskBit(nPlayerIndex, nTaskId));
    return 1;
}

int LuaTaskCheckCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTaskId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nResult = SetJEMainTaskBit(nPlayerIndex, nTaskId);
    if (nResult)
    {
        char szText[96];
        sprintf(szText, "Task check %d complete", nTaskId);
        SendPhongThanTaskRecord(nPlayerIndex, nTaskId, 0, 2, szText);
    }
    Lua_PushNumber(L, nResult);
    return 1;
}
/*
**
**????????1:Talk(SentenceNum, CallBack-Fun(?????????????????????????????????????), sTalk1, sTalk2, sTalk3, sTalk4,...sTalkN);
Talk(SentenceNum, CallBack-Fun(?????????????????????????????????????), nTalk1, nTalk2,nTalk3,nTalk4,...nTalkN);
**????????2:Talk(SentenceNum, CallBack-Fun, SentenceTab);
**????????????:Talk(3,"EndTalk", "?????????????????????????????????????????????????????????", "??????????????????????????5??????????????????","????????????????????");
**
*/

int LuaTalkUI(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
        return 0;
    Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    int nMainInfo = 0;
    int nDataType = 0;
    int nOptionNum = 0;
    char * pContent = NULL;

    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 3)
        return 0;

    if (Lua_IsNumber(L,1))
    {
        nOptionNum = (int)Lua_ValueToNumber(L,1);
    }
    else
    {
        _ASSERT(0);
        return 0;
    }

    const char * pCallBackFun = Lua_ValueToString(L,2);

    //???????????????????????????????????????????????????????????????????????????????????

    if  (Lua_IsNumber(L,3))
    {
        nDataType = 1 ;
    }
    else if (Lua_IsString(L, 3))
    {
        nDataType = 0 ;
    }
    else
        return 0;


    //???????????????????????????????????????????????
    if (nOptionNum > nParamNum - 2)
        nOptionNum = nParamNum - 2;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_TALKDIALOG;
    UiInfo.ResourceText = nDataType;//????????????????????????????????????????????????(0)??????????????????(1)
    UiInfo.OptionCount = nOptionNum;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.BooleanArgument = FALSE;
    memset(UiInfo.Key, 0, sizeof(UiInfo.Key));
    UiInfo.AuxiliaryArgument = 0;
    pContent = UiInfo.Content;
    pContent[0] = 0;
    size_t nContentLen = 0;
    for (int i  = 0; i < nOptionNum; i ++)
    {
        const char * pString = NULL;
        if (!nDataType)//StringInfo
        {
            pString = Lua_ValueToString(L, i + 3);
            if (nContentLen  + strlen(pString) >= MAX_SCIRPTACTION_BUFFERNUM)
            {
                nOptionNum = i;
                UiInfo.OptionCount = nOptionNum;
                break;
            }
            nContentLen += strlen(pString);
            sprintf(pContent, "%s%s|", pContent, pString);
        }
        else
        {
            int j = (int)Lua_ValueToNumber(L, i + 3);
            sprintf(pContent, "%s%d|", pContent, j);
        }
    }
    UiInfo.ContentLength  = strlen(pContent);

    if (!pCallBackFun || strlen(pCallBackFun) <= 0)
    {
        UiInfo.NumberArgument = 0;
        Player[nPlayerIndex].m_nAvailableAnswerNum = 0;
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    }
    else
    {
        UiInfo.NumberArgument = 1;
        Player[nPlayerIndex].m_nAvailableAnswerNum = 1;
        g_StrCpyLen(Player[nPlayerIndex].m_szTaskAnswerFun[0], pCallBackFun, sizeof(Player[nPlayerIndex].m_szTaskAnswerFun[0]));
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = true;
    }

#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif
    Player[nPlayerIndex].m_TalkUiScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;

}

int LuaSelUI(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
        return 0;
    Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    int nMainInfo = 0;
    int nDataType = 0;
    int nOptionNum = 3;
    char * pContent = NULL;

    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 4)
        return 0;

    const char * pCallBackFun = Lua_ValueToString(L,1);

    //???????????????????????????????????????????????????????????????????????????????????

    if  (Lua_IsNumber(L,2))
    {
        nDataType = 1 ;
    }
    else if (Lua_IsString(L, 2))
    {
        nDataType = 0 ;
    }
    else
        return 0;


    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_TALKDIALOG;
    UiInfo.ResourceText = nDataType;//????????????????????????????????????????????????(0)??????????????????(1)
    UiInfo.OptionCount = nOptionNum;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.BooleanArgument = TRUE;
    memset(UiInfo.Key, 0, sizeof(UiInfo.Key));
    if (nParamNum > 5)
        UiInfo.AuxiliaryArgument = (int)Lua_ValueToNumber(L, 5);
    else
        UiInfo.AuxiliaryArgument = -1;
    pContent = UiInfo.Content;
    pContent[0] = 0;
    size_t nContentLen = 0;
    for (int i  = 0; i < nOptionNum; i ++)
    {
        const char * pString = NULL;
        if (!nDataType)//StringInfo
        {
            pString = Lua_ValueToString(L, i + 2);
            if (nContentLen  + strlen(pString) >= MAX_SCIRPTACTION_BUFFERNUM)
            {
                nOptionNum = i;
                UiInfo.OptionCount = nOptionNum;
                break;
            }
            nContentLen += strlen(pString);
            sprintf(pContent, "%s%s|", pContent, pString);
        }
        else
        {
            int j = (int)Lua_ValueToNumber(L, i + 2);
            sprintf(pContent, "%s%d|", pContent, j);
        }
    }

    UiInfo.ContentLength  = strlen(pContent);

    if (!pCallBackFun || strlen(pCallBackFun) <= 0)
    {
        UiInfo.NumberArgument = 0;
        Player[nPlayerIndex].m_nAvailableAnswerNum = 0;
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    }
    else
    {
        UiInfo.NumberArgument = 1;
        Player[nPlayerIndex].m_nAvailableAnswerNum = 2;
        g_StrCpyLen(Player[nPlayerIndex].m_szTaskAnswerFun[0], pCallBackFun, sizeof(Player[nPlayerIndex].m_szTaskAnswerFun[0]));
        Player[nPlayerIndex].m_bWaitingPlayerFeedBack = true;
    }

#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif
    Player[nPlayerIndex].m_TalkUiScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;

}


#include "PhongThanLuaInclude.inl"

//**************************************************************************************************************************************************************
//												?????????????????
//**************************************************************************************************************************************************************
int LuaGetTaskValue(Lua_State * L)
{

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
    {
        int nValue = 0;
#ifdef _SERVER
        nValue = Player[nPlayerIndex].m_cTask.GetSaveVal((int)Lua_ValueToNumber(L,1));
#endif
        Lua_PushNumber(L, nValue);
    }
    else
        Lua_PushNil(L);

    return 1;
}

// Phong Than stores several quest states inside one persistent task integer.
// Byte/word/bit indexes are 1-based, matching the VNG Lua contract.
int LuaGetTaskByte(Lua_State * L)
{
    int nResult = 0;
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum >= 2 && nPlayerIndex > 0)
    {
        int nTaskId = (int)Lua_ValueToNumber(L, 1);
        int nByteNo = (int)Lua_ValueToNumber(L, 2);
        if (nTaskId >= 0 && nTaskId < MAX_TASK && nByteNo >= 1 && nByteNo <= 4)
        {
            unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
            nResult = (int)((nValue >> ((nByteNo - 1) * 8)) & 0xff);
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaSetTaskByte(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum < 3 || nPlayerIndex <= 0)
        return 0;

    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nByteNo = (int)Lua_ValueToNumber(L, 2);
    unsigned int nByteValue = (unsigned int)Lua_ValueToNumber(L, 3) & 0xff;
    if (nTaskId < 0 || nTaskId >= MAX_TASK || nByteNo < 1 || nByteNo > 4)
        return 0;
#ifdef _SERVER
    unsigned int nShift = (unsigned int)(nByteNo - 1) * 8;
    unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
    nValue = (nValue & ~(0xffU << nShift)) | (nByteValue << nShift);
    Player[nPlayerIndex].m_cTask.SetSaveVal(nTaskId, (int)nValue);
#endif
    return 0;
}

int LuaGetTaskWord(Lua_State * L)
{
    int nResult = 0;
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum >= 2 && nPlayerIndex > 0)
    {
        int nTaskId = (int)Lua_ValueToNumber(L, 1);
        int nWordNo = (int)Lua_ValueToNumber(L, 2);
        if (nTaskId >= 0 && nTaskId < MAX_TASK && nWordNo >= 1 && nWordNo <= 2)
        {
            unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
            nResult = (int)((nValue >> ((nWordNo - 1) * 16)) & 0xffff);
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaSetTaskWord(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum < 3 || nPlayerIndex <= 0)
        return 0;

    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nWordNo = (int)Lua_ValueToNumber(L, 2);
    unsigned int nWordValue = (unsigned int)Lua_ValueToNumber(L, 3) & 0xffff;
    if (nTaskId < 0 || nTaskId >= MAX_TASK || nWordNo < 1 || nWordNo > 2)
        return 0;
#ifdef _SERVER
    unsigned int nShift = (unsigned int)(nWordNo - 1) * 16;
    unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
    nValue = (nValue & ~(0xffffU << nShift)) | (nWordValue << nShift);
    Player[nPlayerIndex].m_cTask.SetSaveVal(nTaskId, (int)nValue);
#endif
    return 0;
}

int LuaGetTaskBit(Lua_State * L)
{
    int nResult = 0;
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum >= 2 && nPlayerIndex > 0)
    {
        int nTaskId = (int)Lua_ValueToNumber(L, 1);
        int nBitNo = (int)Lua_ValueToNumber(L, 2);
        if (nTaskId >= 0 && nTaskId < MAX_TASK && nBitNo >= 1 && nBitNo <= 32)
        {
            unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
            nResult = (int)((nValue >> (nBitNo - 1)) & 1U);
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaSetTaskBit(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    if (nParamNum < 3 || nPlayerIndex <= 0)
        return 0;

    int nTaskId = (int)Lua_ValueToNumber(L, 1);
    int nBitNo = (int)Lua_ValueToNumber(L, 2);
    int nBitValue = (int)Lua_ValueToNumber(L, 3);
    if (nTaskId < 0 || nTaskId >= MAX_TASK || nBitNo < 1 || nBitNo > 32)
        return 0;
#ifdef _SERVER
    unsigned int nMask = 1U << (nBitNo - 1);
    unsigned int nValue = (unsigned int)Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
    nValue = nBitValue ? (nValue | nMask) : (nValue & ~nMask);
    Player[nPlayerIndex].m_cTask.SetSaveVal(nTaskId, (int)nValue);
#endif
    return 0;
}

int LuaGetTaskString(Lua_State * L)
{

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
    {
#ifdef _SERVER
        Lua_PushString(L, Player[nPlayerIndex].m_cTask.GetSaveStr((int)Lua_ValueToNumber(L,1)));
#endif
    }
    else
        Lua_PushNil(L);

    return 1;
}

int LuaSetTaskValue(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nValueIndex = (int)Lua_ValueToNumber(L, 1);

    if (nPlayerIndex <= 0) return 0;

    if(nValueIndex < 0 || nValueIndex >= MAX_TASK_SCRIPTFUNC)
        return 0;
#ifdef _SERVER
    const char* value=Lua_GetTopIndex(L)>=2?Lua_ValueToString(L,2):NULL;
    if(!value || strlen(value)>=sizeof(Player[nPlayerIndex].m_cTask.szSave[0]))
    {lua_error(L,"SetTask value exceeds saved task field");return 0;}
    Player[nPlayerIndex].m_cTask.SetSaveVal(nValueIndex, (char*)value);
#endif
    return 0;
}

int LuaSyncTaskValue(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nValueIndex = (int)Lua_ValueToNumber(L, 1);

    if (nPlayerIndex <= 0) return 0;
#ifdef _SERVER
    Player[nPlayerIndex].m_cTask.SyncTaskValue(nValueIndex);
#endif
    return 0;
}

#ifndef _SERVER
#define MAX_TEMPVALUENUM_INCLIENT 500
int g_TempValue[MAX_TEMPVALUENUM_INCLIENT];
#endif

int LuaGetTempTaskValue(Lua_State * L)
{
    int nTempIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));

#ifdef _SERVER
    if(nTempIndex >= MAX_TEMP_TASK)
	{
		Lua_PushNil(L) ;
		return 1;
	}
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
	{
		Lua_PushNil(L);
		return 1;
	}

	int nValue = Player[nPlayerIndex].m_cTask.GetClearVal(nTempIndex);
	Lua_PushNumber(L, nValue);
#else

    if (nTempIndex >= 0 && nTempIndex < MAX_TEMPVALUENUM_INCLIENT)
        Lua_PushNumber(L, g_TempValue[nTempIndex]);
    else
        Lua_PushNil(L);
#endif
    return 1;
}

int LuaGetTempTaskString(Lua_State * L)
{
    int nTempIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));

#ifdef _SERVER
    if(nTempIndex >= MAX_TEMP_TASK)
	{
		Lua_PushNil(L) ;
		return 1;
	}
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
	{
		Lua_PushNil(L);
		return 1;
	}

	Lua_PushString(L, (char*)Player[nPlayerIndex].m_cTask.GetClearStr(nTempIndex));
#else

    if (nTempIndex >= 0 && nTempIndex < MAX_TEMPVALUENUM_INCLIENT)
        Lua_PushNumber(L, g_TempValue[nTempIndex]);
    else
        Lua_PushNil(L);
#endif
    return 1;
}

int LuaSetTempTaskValue(Lua_State * L)
{
    int nTempIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L) - 1);
    char* szValue = (char*)Lua_ValueToString(L, Lua_GetTopIndex(L));
#ifdef _SERVER
    Lua_GetGlobal(L, SCRIPT_PLAYERINDEX);
	int nPlayerIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));
	if (nPlayerIndex <= 0) return 0;
	Player[nPlayerIndex].m_cTask.SetClearVal(nTempIndex, szValue);
#else
    g_TempValue[nTempIndex] = atoi(szValue);
#endif
    return 0;
}

#ifdef _SERVER
//---------------------------------??????????????????????????????????????????????????????-----------------------
//Sale(id)
//------------------------------------------------------------------------------
int LuaSale(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nShopId = (int)Lua_ValueToNumber(L,1);
		int nShopMoneyUnit = moneyunit_money;
		//----????????????????????????????????????????????????????????????!
		if (Lua_GetTopIndex(L) > 2)
			nShopMoneyUnit = (int)Lua_ValueToNumber(L,2);
		BuySell.OpenSale(nPlayerIndex, nShopId - 1, nShopMoneyUnit);
	}
	return 0;
}

int LuaNewSale(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0) return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 4) return 0;

	int nShopNum = (int)Lua_ValueToNumber(L, 3);

	if (nShopNum > MAX_SUPERSHOP_SHOPTAB)
		nShopNum = MAX_SUPERSHOP_SHOPTAB;

	int nShopId[MAX_SUPERSHOP_SHOPTAB];
	int nFirstShopId = (int)Lua_ValueToNumber(L, 4) - 1;
	int i = 0;
	if (nFirstShopId == PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX)
	{
		nShopNum = PHONGTHAN_IBSHOP_TAB_COUNT;
		for (i = 0; i < nShopNum; ++i)
			nShopId[i] = PHONGTHAN_IBSHOP_FIRST_SHOP_INDEX + i;
	}
	else
	{
		for (i = 0; i < nShopNum; ++i)
			nShopId[i] = (int)Lua_ValueToNumber(L, 4+i) - 1;
	}

	for(; i < MAX_SUPERSHOP_SHOPTAB; i++)
		nShopId[i] = -1;

	BuySell.OpenSale(nPlayerIndex, (int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2), nShopNum, nShopId);
	return 0;
}

int LuaOpenBox(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	SOME_BOX_SYNC command;
	command.ProtocolType = (BYTE)s2c_opensomebox;
	command.bEquipEx = FALSE;
	command.nBoxIndex = -1;
	if (Lua_GetTopIndex(L)>1)
		command.nBoxIndex = (int)Lua_ValueToNumber(L,1) -1;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &command, sizeof(SOME_BOX_SYNC));
	return 0;
}

//TamLTM kham nam xanh
//SetPItemID
int LuaGetPOItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	BYTE nX, nY, nPos;
	int nIndex = 0;
	nPos = (BYTE)Lua_ValueToNumber(L,1);
	if (nPos < pos_equip /*|| nPos > pos_compound_item*/)
	{
		Lua_PushNumber(L,0);
		return 0;
	}
	nX = (BYTE)Lua_ValueToNumber(L,2);

//	g_DebugLog("Debug abc xyz %d + %d - %d", nPos, pos_equip, pos_builditem);
	if (nPos)
	{
		if (pos_equip == 2)
		{
			nIndex = Player[nPlayerIndex].m_ItemList.GetEquipment(nX);
		//	g_DebugLog("Debug abc xyz");
		}

		if (pos_builditem == 16) {
			nIndex = Player[nPlayerIndex].m_ItemList.GetBuildItem(nX);
		//	g_DebugLog("Debug abc xyz 2");
		}
	} // */

/*	switch (nPos)
	{
	case pos_equip:
		nIndex = Player[nPlayerIndex].m_ItemList.GetEquipment(nX);
		g_DebugLog("Debug abc xyz");
		break;
	case pos_builditem:
		nIndex = Player[nPlayerIndex].m_ItemList.GetBuildItem(nX);
		break;
/*	case pos_compound_item:
		nIndex = Player[nPlayerIndex].m_ItemList.GetComPoundItem(nX);
		break; */
/*	default:
	//	g_DebugLog("Debug defaulf");
		break;
	} // */

	Lua_PushNumber(L,nIndex);
	return 1;
}

int LuaSetPItemID(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	BOOL bExist = FALSE;
	int nIndex = (int)Lua_ValueToNumber(L, 1);

	if (nIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	BYTE nX, nY, nPos;
	nPos = (BYTE)Lua_ValueToNumber(L,2);
	if (nPos < pos_equip /*|| nPos > pos_compound_item*/)
	{
		Lua_PushNumber(L,0);
		return 0;
	}
	nX = (BYTE)Lua_ValueToNumber(L,3);

	if (nPos == 12)
	{
		if (pos_equip == 2) {
			nIndex = Player[nPlayerIndex].m_ItemList.GetEquipment(nX);
		//	g_DebugLog("Debug abc xyz");
		}

		if (pos_builditem == 16) {
			bExist = (BOOL)Player[nPlayerIndex].m_ItemList.GetBuildItem(nX);
		//	g_DebugLog("Debug abc xyz 2");
		}
	} //*/

/*	switch (nPos)
	{
	case pos_equip:
		bExist = (BOOL)Player[nPlayerIndex].m_ItemList.GetEquipment(nX);
		break;
	case pos_builditem:
		bExist = (BOOL)Player[nPlayerIndex].m_ItemList.GetBuildItem(nX);
		break;
/*	case pos_compound_item:
		bExist = (BOOL)Player[nPlayerIndex].m_ItemList.GetComPoundItem(nX);
		break; */
/*	default:
		break;
	} // */

	if (!bExist)
		Player[nPlayerIndex].m_ItemList.Add(nIndex, nPos, nX, 0, false);
	else
	{
		int	nIdx = Player[nPlayerIndex].m_ItemList.Hand();
		if (nIdx)
		{
			Player[nPlayerIndex].m_ItemList.Remove(nIdx);

			KMapPos sMapPos;
			KObjItemInfo	sInfo;
			char	szNameTemp[OBJ_NAME_LENGHT];
			Player[nPlayerIndex].GetAboutPos(&sMapPos);

			sInfo.m_nItemID = nIdx;
			sInfo.m_nItemWidth = Item[nIdx].GetWidth();
			sInfo.m_nItemHeight = Item[nIdx].GetHeight();
			sInfo.m_nMoneyNum = 0;
			if (Item[nIdx].GetStackNum() > 1)
			{
				sprintf(szNameTemp, "%s x %d", Item[nIdx].GetName(), Item[nIdx].GetStackNum());
				strcpy(sInfo.m_szName, szNameTemp);
			}
			else
				strcpy(sInfo.m_szName, Item[nIdx].GetName());
			sInfo.m_nColorID = Item[nIdx].GetColorItem();
			sInfo.m_nGenre = Item[nIdx].GetGenre();
			sInfo.m_nDetailType = Item[nIdx].GetDetailType();
			sInfo.m_nMovieFlag = 1;
			sInfo.m_nSoundFlag = 1;
			sInfo.m_dwNpcId = 0;

			int nObj = ObjSet.Add(Item[nIdx].GetObjIdx(), sMapPos, sInfo);
			if (nObj >= 0)
			{
				if (Item[nIdx].GetGenre() == item_task ||
					Item[nIdx].GetGenre() == item_materials)
					Object[nObj].SetEntireBelong(nPlayerIndex);
				else
					Object[nObj].SetItemBelong(nPlayerIndex);
			}
		}
		Player[nPlayerIndex].m_ItemList.Add(nIndex, pos_hand, 0 ,0);
	}
	Lua_PushNumber(L,1);
	return 1;
}


int LuaOpenTrembleItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);

	S2C_OTHER_BOX NetCommand;
	NetCommand.ProtocolType = s2c_otherbox;
	NetCommand.nValue = 0;
	if(g_pServer && Player[nPlayerIndex].m_nNetConnectIdx != -1)
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx,&NetCommand,sizeof(S2C_OTHER_BOX));

	return 0;
}
//end code kham nam xanh

int LuaOpenEquipEx(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	SOME_BOX_SYNC command;
	command.ProtocolType = (BYTE)s2c_opensomebox;
	command.bEquipEx = TRUE;
	command.nBoxIndex = 0;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &command, sizeof(SOME_BOX_SYNC));
	return 0;
}

//TamLTM Bang hoi chiem linh
int LuaLoadTongMap(Lua_State * L)
{
	int nNumberPrama = Lua_GetTopIndex(L);

	g_DebugLog("0 -> %d", nNumberPrama);

	if (nNumberPrama < 7)
     return 0;

	int nIdMap = (int) Lua_ValueToNumber(L,1);
	int nMapTongId = (int) Lua_ValueToNumber(L,3);
	int nMapTongT  =  (int) Lua_ValueToNumber(L,4);
	int nMapTongVG  =  (int) Lua_ValueToNumber(L,5);
	int nMapTongBCId = (int) Lua_ValueToNumber(L,7);
	int nCheckMap = (int) Lua_ValueToNumber(L,8);

	g_DebugLog("1");

	char szMapTongName[32];
	char szMapTongNameBC[32];

	g_StrCpyLen(szMapTongName, (char*)Lua_ValueToString(L,2), 32);
	g_StrCpyLen(szMapTongNameBC, (char*)Lua_ValueToString(L,6), 32);

	int nIdxMap = g_SubWorldSet.SearchWorld(nIdMap);
	g_DebugLog("nIdxMap %d - nIdMap %d", nIdxMap, nIdMap);

	if (nIdxMap != -1)
	{
		g_DebugLog("2 %d", nIdxMap);
		SubWorld[nIdxMap].LoadTong(szMapTongName,nMapTongId,nMapTongT,nMapTongVG,szMapTongNameBC,nMapTongBCId,nCheckMap);
	}

	return 0;
}

int LuaGetTongMap(Lua_State * L)
{
	int nNumberPrama = Lua_GetTopIndex(L);

	if (nNumberPrama < 1)
     return 0;

	int nIdMap = (int) Lua_ValueToNumber(L,1);

	int nIdxMap = g_SubWorldSet.SearchWorld(nIdMap);

	if (nIdxMap != -1)
	{

		Lua_PushNumber(L, SubWorld[nIdxMap].m_bCheckTong);
		Lua_PushString(L, SubWorld[nIdxMap].m_szTongName);
		Lua_PushNumber(L, SubWorld[nIdxMap].m_dwTongName);
		Lua_PushString(L, SubWorld[nIdxMap].m_szTongNameBC);
		Lua_PushNumber(L, SubWorld[nIdxMap].m_dwTongNameBC);
		Lua_PushNumber(L, SubWorld[nIdxMap].m_nTongT);
		Lua_PushNumber(L, SubWorld[nIdxMap].m_nTongVG);

		return 7;
	}

	return 0;
}

int LuaSetTongMap(Lua_State * L)
{
	int nNumberPrama = Lua_GetTopIndex(L);

	g_DebugLog("LuaSetTongMap -> %d", nNumberPrama);

	if (nNumberPrama < 7)
     return 0;

	int nIdMap = (int) Lua_ValueToNumber(L,1);


	int nIdxMap = g_SubWorldSet.SearchWorld(nIdMap);

	if (nIdxMap != -1)
	{
		int nMapTongId = (int) Lua_ValueToNumber(L,3);

		int nMapTongT  =  (int) Lua_ValueToNumber(L,6);
		int nMapTongVG  =  (int) Lua_ValueToNumber(L,7);
		int nMapTongBCId = (int) Lua_ValueToNumber(L,5);

		char szMapTongName[32];
		char szMapTongNameBC[32];

		g_StrCpyLen(szMapTongName, Lua_ValueToString(L,2), 32);
		g_StrCpyLen(szMapTongNameBC, Lua_ValueToString(L,4), 32);

		try
		{
			bool bExecuteScriptMistake = true;
			KLuaScript * pScript = (KLuaScript* )g_GetScript("\\script\\item\\banghoi\\banghoi.lua");;
			if (pScript)
			{
				g_DebugLog("\\script\\item\\banghoi\\banghoi.lua");
				int nTopIndex = 0;

				pScript->SafeCallBegin(&nTopIndex);

				if (pScript->CallFunction("SetTongMapMain",0, "dsdsddd",nIdMap,szMapTongName,nMapTongId,szMapTongNameBC,nMapTongBCId,nMapTongT,nMapTongVG));
				{
					bExecuteScriptMistake = false;
				}

				pScript->SafeCallEnd(nTopIndex);
			}
		}
		catch(...)
		{
			printf("Exception Have Caught When Execute Script[%d]!!!!!", g_FileName2Id("\\script\\item\\banghoi\\banghoi.lua"));
			g_DebugLog("error \\script\\admin\\banghoi\\banghoi.lua");
		}
		return 0;
	}

	return 0;
}

//end code

//---------------------------------????????????????????-------------------------------------
//SetTimer(Time, TimerTaskId)
int LuaSetTimer(Lua_State  * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2 ) return 0;
	int nPlayerIndex  = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	Player[nPlayerIndex].SetTimer((DWORD) (int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L,2));
	return 0;
}

int LuaStopTimer(Lua_State * L)
{
	int nPlayerIndex  = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	Player[nPlayerIndex].CloseTimer();
	return 0;
}

int LuaGetCurTimerId(Lua_State * L)
{
	int nPlayerIndex  = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nTimerId = Player[nPlayerIndex].m_TimerTask.GetTaskId();
	Lua_PushNumber(L, nTimerId);
	return 1;
}

int LuaGetRestTime(Lua_State * L)
{
	int nPlayerIndex  = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNil(L);
		return 1;
	}
	int nRestTime = Player[nPlayerIndex].m_TimerTask.GetRestTime();//m_dwTimeTaskTime - g_SubWorldSet.GetGameTime();

	if (nRestTime > 0)
		Lua_PushNumber(L, nRestTime);
	else
		Lua_PushNumber(L, 0);

	return 1;
}

int LuaGetMissionRestTime(Lua_State * L)
{
	int RestTime = 0;
	if (Lua_GetTopIndex(L) >= 2)
	{
		int nSubWorldIndex = GetSubWorldIndex(L);
		if (nSubWorldIndex >= 0)
		{
			int nMissionId = (int)Lua_ValueToNumber(L, 1);
			int nTimerId = (int)Lua_ValueToNumber(L, 2);

			if (nMissionId < 0 || nTimerId < 0 )
				goto lab_getmissionresttime;

			KMission Mission;
			Mission.SetMissionId(nMissionId);
			KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
			if (pMission)
			{
				RestTime = (int)pMission->GetTimerRestTimer(nTimerId);
			}
		}
	}

lab_getmissionresttime:
	Lua_PushNumber(L, RestTime);
	return 1;
}


//**************************************************************************************************************************************************************
//												?????????????
//**************************************************************************************************************************************************************
int LuaIsLeader(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0 )
	{
		if (Player[nPlayerIndex].m_cTeam.m_nFlag && Player[nPlayerIndex].m_cTeam.m_nFigure == TEAM_CAPTAIN)
			Lua_PushNumber(L,1);
		else
			Lua_PushNumber(L,0);
	}
	else
		Lua_PushNumber(L, 0);

	return 1;
}

int LuaGetTeamId(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTeam.m_nFlag)
			Lua_PushNumber(L, Player[nPlayerIndex].m_cTeam.m_nID);
		else
			Lua_PushNil(L);
	}
	else
		Lua_PushNil(L);

	return 1;
}

int LuaTeamDoScript(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	char* nValueIndex = (char*)Lua_ValueToString(L, 1);
	char* sFunc = (char*)Lua_ValueToString(L, 2);
	int	Value1 = (int)Lua_ValueToNumber(L, 3);
	int	Value2 = (int)Lua_ValueToNumber(L, 4);
	int	Value3 = (int)Lua_ValueToNumber(L, 5);
	DWORD ScriptID = g_FileName2Id(nValueIndex);
	int Count = 0;
	if (nPlayerIndex < 0)
		return 0;
	if (Player[nPlayerIndex].m_cTeam.m_nID >= 0)
	{
		int nTeamLeaderId = g_Team[Player[nPlayerIndex].m_cTeam.m_nID].m_nCaptain;
		if (nTeamLeaderId)
		{
			Player[nTeamLeaderId].ExecuteScript3Param(ScriptID, sFunc, 0, Value1, Value2, Value3);
			Count = Count + 1;
		}
		else
			return 0;
		for (int i = 0; i < MAX_TEAM_MEMBER; i ++)
		{
			int nMemberId = g_Team[Player[nPlayerIndex].m_cTeam.m_nID].m_nMember[i] ;
			if (nMemberId)
			{
				Player[nMemberId].ExecuteScript3Param(ScriptID, sFunc, 0, Value1, Value2, Value3);
				Count = Count + 1;
				Sleep(5);
			}
		}
	}
	Lua_PushNumber(L,Count);
	return Count;
}

int LuaGetTeamSize(Lua_State * L)
{
	int nTeamSize = 0;
	int nTeamId = -1;
	if (Lua_GetTopIndex(L) >= 1)
	{
		nTeamId = Lua_ValueToNumber(L, 1);
	}
	else
	{
		int nPlayerIndex = GetPlayerIndex(L);
		if (nPlayerIndex > 0)
		{
			if (Player[nPlayerIndex].m_cTeam.m_nFlag)
				nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
			else
				nTeamId = -1;
		}
	}

	while(PhongThanQuestTeamMember(nTeamId,nTeamSize+1))++nTeamSize;
	Lua_PushNumber(L, nTeamSize);
	return 1;
}

int LuaGetTeamMem(Lua_State * L)
{
	int nTeamId = -1;
	int nMemId = 0;
	int nResult =0;
	if (Lua_GetTopIndex(L) >= 2)
	{
		nTeamId = Lua_ValueToNumber(L, 1);
		nMemId = Lua_ValueToNumber(L, 2);
	}
	else
	{
		int nPlayerIndex = GetPlayerIndex(L);
		if (nPlayerIndex > 0)
		{
			if (Player[nPlayerIndex].m_cTeam.m_nFlag)
				nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
			else
				nTeamId = -1;
			nMemId = Lua_ValueToNumber(L, 1);
		}
	}

	if (nTeamId >= 0)
		nResult = nMemId==0?g_Team[nTeamId].m_nCaptain:g_Team[nTeamId].m_nMember[nMemId-1];

	Lua_PushNumber(L, nResult);
	return 1;
}

// VNG GetTeamMember is 1-based and includes the captain at position 1.
// The legacy GetTeamMem API is intentionally kept unchanged (0 = captain).
int LuaGetTeamMember(Lua_State * L)
{
	int nResult = 0;
	int nParamNum = Lua_GetTopIndex(L);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nParamNum < 1 || nPlayerIndex <= 0 || !Player[nPlayerIndex].m_cTeam.m_nFlag)
	{
		Lua_PushNumber(L, nResult);
		return 1;
	}

	int nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
	int nOrdinal = (int)Lua_ValueToNumber(L, 1);
	nResult=PhongThanQuestTeamMember(nTeamId,nOrdinal);
	Lua_PushNumber(L, nResult > 0 ? nResult : 0);
	return 1;
}

int LuaLeaveTeam(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTeam.m_nFlag)
		{
			PLAYER_APPLY_LEAVE_TEAM	sLeaveTeam;
			sLeaveTeam.ProtocolType = c2s_teamapplyleave;
			sLeaveTeam.bMySelf = TRUE;
			Player[nPlayerIndex].LeaveTeam((BYTE*)&sLeaveTeam);
		}
	}
	return 0;
}

int LuaSetCreateTeamOption(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Player[nPlayerIndex].m_cTeam.SetCreatTeamFlag(nPlayerIndex, (int)Lua_ValueToNumber(L, 1) > 0);
	}
	return 0;
}

int LuaSetFreezeTeamOption(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Player[nPlayerIndex].m_cTeam.SetFreezeTeamFlag(nPlayerIndex, (int)Lua_ValueToNumber(L, 1) > 0);
	}
	return 0;
}
//**************************************************************************************************************************************************************
//												????????????????????????????
//**************************************************************************************************************************************************************
extern TLua_Funcs GameScriptFuns[];
extern TLua_Funcs WorldScriptFuns[];

int g_GetGameScriptFunNum();
int g_GetWorldScriptFunNum();
//**************************************************************************************************************************************************************
//												????????????????????????????
//**************************************************************************************************************************************************************

int	LuaMsgToPlayer(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		const char *  szMsg = (char*)Lua_ValueToString(L,1);
		if (szMsg)
		{
			int nChannelID = -1;
			if(nParamNum > 1)
				nChannelID = (int)Lua_ValueToNumber(L, 2);
			KPlayerChat::SendSystemInfo(1, nPlayerIndex, MESSAGE_BROADCAST_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) ,nChannelID);
		}
	}

	return 0;
}

int LuaMsgToTeam(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0	) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTeam.m_nID >= 0)
		{
			const char * szMsg = Lua_ValueToString(L,1);
			Player[nPlayerIndex].SendTeamMessage(Player[nPlayerIndex].m_cTeam.m_nID, szMsg);
		}
	}
	return 0;
}

int LuaMsgToSubWorld(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0;
	int nParamNum = Lua_GetTopIndex(L);

	const char *  szMsg = (char*)Lua_ValueToString(L,1);
	if (szMsg)
	{
		int nChannelID = -1;
		if(nParamNum > 1)
			nChannelID = (int)Lua_ValueToNumber(L, 2);
		KPlayerChat::SendSystemInfo(0, 0, MESSAGE_BROADCAST_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) ,nChannelID);
	}

	return 0;
}

int LuaMsgToTong(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	if(!Player[nPlayerIndex].m_cTong.m_nFlag)
		return 0;

	STONG_MESSAGE_INFO_COMMAND	TongMsg;
	TongMsg.ProtocolID = enumC2S_MESSAGE_TO_TONG;
	TongMsg.ProtocolFamily = pf_tong;
	TongMsg.dwParam = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
	strcpy(TongMsg.szName, Player[nPlayerIndex].Name);
	strcpy(TongMsg.szMsg, (char *)Lua_ValueToString(L, 1));
	if (g_pTongClient)
		g_pTongClient->SendPackToServer((const void*)&TongMsg, sizeof(STONG_MESSAGE_INFO_COMMAND));

	return 0;
}

int LuaMsgToProfession(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	if(Player[nPlayerIndex].m_cProfession.m_nProfession < 0)
		return 0;

	STONG_MESSAGE_INFO_COMMAND	ProfessionMsg;
	ProfessionMsg.ProtocolID = enumC2S_MESSAGE_TO_PROFESSION;
	ProfessionMsg.ProtocolFamily = pf_tong;
	ProfessionMsg.dwParam = Player[nPlayerIndex].m_cProfession.m_nProfession;
	strcpy(ProfessionMsg.szName, Player[nPlayerIndex].Name);
	strcpy(ProfessionMsg.szMsg, (char *)Lua_ValueToString(L, 1));
	if (g_pTongClient)
		g_pTongClient->SendPackToServer((const void*)&ProfessionMsg, sizeof(STONG_MESSAGE_INFO_COMMAND));

	return 0;
}

int LuaMsgToChatRoom(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	if(!Player[nPlayerIndex].m_cRoom.m_nFlag)
		return 0;

	STONG_MESSAGE_INFO_COMMAND	RoomMsg;
	RoomMsg.ProtocolID = enumC2S_MESSAGE_TO_CHATROOM;
	RoomMsg.ProtocolFamily = pf_tong;
	RoomMsg.dwParam = Player[nPlayerIndex].m_cRoom.m_nID;
	strcpy(RoomMsg.szName, Player[nPlayerIndex].Name);
	strcpy(RoomMsg.szMsg, (char *)Lua_ValueToString(L, 1));
	if (g_pTongClient)
		g_pTongClient->SendPackToServer((const void*)&RoomMsg, sizeof(STONG_MESSAGE_INFO_COMMAND));

	return 0;
}

int LuaMsgToAroundRegion(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);

	int nSubWorldIndex = g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L,1));

	if (nSubWorldIndex >= 0 && nSubWorldIndex < MAX_SUBWORLD)
	{
		const char *  szMsg = (char*)Lua_ValueToString(L,2);
		int nChannelID = -1;
		if(nParamNum > 3)
			nChannelID = (int)Lua_ValueToNumber(L, 3);
		if (szMsg)
		{
			int nIndex = PlayerSet.GetFirstPlayer();
			while(nIndex > 0)
			{
				if (Npc[Player[nIndex].m_nIndex].m_SubWorldIndex == nSubWorldIndex)
					KPlayerChat::SendSystemInfo(1, nIndex, MESSAGE_BROADCAST_ANNOUCE_HEAD, (char *) szMsg, strlen(szMsg) , nChannelID);

				nIndex = PlayerSet.GetNextPlayer();
			}
		}
	}
	return 0;
}

//**************************************************************************************************************************************************************
//												????????????????
//**************************************************************************************************************************************************************

//**************************************************************************************************************************************************************
//												????????????????
//**************************************************************************************************************************************************************

/*?????????????????????????????????????????????????????????????????????????
nPlayerIndex:??????????????Index
nSubWorldIndex:????????????????????id
nPosX:
nPosY:
*/
//NewWorld(WorldId, X,Y)
int LuaEnterNewWorld(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;

	int nResult = 0;
	if (Lua_GetTopIndex(L) >= 3)
	{
		DWORD dwWorldId = (DWORD)Lua_ValueToNumber(L, 1);
		// Independent runtime: original VNG world 1..118 maps to 1001..1118.
		if (dwWorldId >= 1 && dwWorldId <= 118)
			dwWorldId += 1000;
		nResult = Npc[Player[nPlayerIndex].m_nIndex].ChangeWorld(dwWorldId, (int)Lua_ValueToNumber(L,2) * 32, (int)Lua_ValueToNumber(L,3) * 32);
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaNpcEnterNewWorld(Lua_State * L)
{
	int nParamCount = 0;
	if ((nParamCount = Lua_GetTopIndex(L)) < 3) return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0) return 0;

	int nResult = 0;
	if (Lua_GetTopIndex(L) > 3)
	{
		DWORD dwWorldId = (DWORD)Lua_ValueToNumber(L, 2);
		nResult = Npc[nNpcIndex].ChangeWorld(dwWorldId, (int)Lua_ValueToNumber(L,3) * 32, (int)Lua_ValueToNumber(L,4) * 32);
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

//SetPos(X,Y)
int LuaSetPos(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount != 2) return 0;
	int nPlayerIndex = GetPlayerIndex(L);

	int nX = (int) Lua_ValueToNumber(L,1);
	int nY = (int) Lua_ValueToNumber(L,2);

	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].SetPos(nX * 32, nY * 32);
	}
	return 0;
}

int LuaGetPos(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex > 0)
	{
		int nPosX = 0;
		int nPosY = 0;
		Npc[Player[nPlayerIndex].m_nIndex].GetMpsPos(&nPosX, &nPosY);
		Lua_PushNumber(L, nPosX);
		Lua_PushNumber(L, nPosY);
		Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex);
	}
	else
		return 0;
	return 3;
}

//W,X,Y = GetWorldPos()
int LuaGetNewWorldPos(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex > 0)
	{
		int nPosX = 0;
		int nPosY = 0;
		Npc[Player[nPlayerIndex].m_nIndex].GetMpsPos(&nPosX, &nPosY);

		int nSubWorldIndex = Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex;
		int nSubWorldID = 0;
		if (nSubWorldIndex >= 0 && nSubWorldIndex < MAX_SUBWORLD)
		{
			nSubWorldID = SubWorld[nSubWorldIndex].m_SubWorldID;
		}

		Lua_PushNumber(L, nSubWorldID);
		Lua_PushNumber(L, ((int)(nPosX/32)));
		Lua_PushNumber(L, ((int)(nPosY/32)));
	}
	else
	{
		Lua_PushNil(L);
		return 1;
	}
	return 3;
}


int LuaGetNewWorldName(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
	{
		int nPlayerIndex = GetPlayerIndex(L);

		if (nPlayerIndex > 0)
		{
			int nSubWorldID = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
			Lua_PushString(L, g_SubWorldSet.m_sMapListInfo[nSubWorldID].szName);
			return 1;
		}
	}
	else
	{
		int nSubWorldID = (int)Lua_ValueToNumber(L,1);
		Lua_PushString(L, g_SubWorldSet.m_sMapListInfo[nSubWorldID].szName);
		return 1;
	}
	return 0;
}

int LuaGetNewWorldKind(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
	{
		int nPlayerIndex = GetPlayerIndex(L);

		if (nPlayerIndex > 0)
		{
			int nSubWorldID = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
			Lua_PushNumber(L, g_SubWorldSet.m_sMapListInfo[nSubWorldID].nKind);
			return 1;
		}
	}
	else
	{
		int nSubWorldID = (int)Lua_ValueToNumber(L,1);
		Lua_PushNumber(L, g_SubWorldSet.m_sMapListInfo[nSubWorldID].nKind);
		return 1;
	}
	return 0;
}

int LuaGetNpcPos(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
	{
		Lua_PushNumber(L, 0);
		Lua_PushNumber(L, 0);
		Lua_PushNumber(L, 0);
		return 3;
	}

	int nNpcIndex = (int)Lua_ValueToNumber(L,1);

	if (nNpcIndex > 0 && nNpcIndex < MAX_NPC && Npc[nNpcIndex].m_dwID != 0)
	{
		int nPosX = 0;
		int nPosY = 0;
		Npc[nNpcIndex].GetMpsPos(&nPosX, &nPosY);

		int nSubWorldIndex = Npc[nNpcIndex].m_SubWorldIndex;
		int nSubWorldID = 0;
		if (nSubWorldIndex >= 0 && nSubWorldIndex < MAX_SUBWORLD)
		{
			nSubWorldID = SubWorld[nSubWorldIndex].m_SubWorldID;
		}

		Lua_PushNumber(L, nSubWorldID);
		Lua_PushNumber(L, ((int)(nPosX / 32)));
		Lua_PushNumber(L, ((int)(nPosY / 32)));
		return 3;
	}
	Lua_PushNumber(L, 0);
	Lua_PushNumber(L, 0);
	Lua_PushNumber(L, 0);
	return 3;
}

int LuaDropMoney(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;

	int nIndex = 0;
	int nSubWorldIndex = 0;
	int nX, nY;
	int nMoney = 0;

	if (nParamNum > 1)
	{
		nIndex = Player[nPlayerIndex].m_nIndex;
		nMoney = (int)Lua_ValueToNumber(L, 1);
	}
	if (nParamNum > 2)
	{
		nIndex = (int)Lua_ValueToNumber(L, 1);
		nMoney = (int)Lua_ValueToNumber(L, 2);
	}

	if (nIndex <= 0)
	{
		nIndex = Player[nPlayerIndex].m_nIndex;
	}
	if (nMoney <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	Npc[nIndex].GetMpsPos(&nX, &nY);
	nSubWorldIndex = Npc[nIndex].GetSubWorldIndex();

	if (nSubWorldIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	POINT	ptLocal;
	KMapPos	Pos;
	ptLocal.x = nX;
	ptLocal.y = nY;
	SubWorld[nSubWorldIndex].GetFreeObjPos(ptLocal);

	Pos.nSubWorld = nSubWorldIndex;
	SubWorld[nSubWorldIndex].Mps2Map(ptLocal.x, ptLocal.y,
		&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
		&Pos.nOffX, &Pos.nOffY);
	int nObj = ObjSet.AddMoneyObj(Pos, nMoney * g_MoneyRate);
	if (nObj > 0)
	{
		Object[nObj].SetItemBelong(nPlayerIndex);
		Lua_PushNumber(L,nObj);
		return 1;
	}
	return 0;
}

int LuaDropItem(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;

	int nIndex = 0;
	int nSubWorldIndex = 0;
	int nX, nY;
	int nIdx = 0;

	if (nParamNum > 1)
	{
		nIdx = (int)Lua_ValueToNumber(L, 1);
	}
	if (nParamNum > 2)
	{
		nIndex = (int)Lua_ValueToNumber(L, 1);
		nIdx = (int)Lua_ValueToNumber(L, 2);
	}

	if (nIndex <= 0)
		nIndex = Player[nPlayerIndex].m_nIndex;

	if (nIdx <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	Npc[nIndex].GetMpsPos(&nX, &nY);
	nSubWorldIndex = Npc[nIndex].GetSubWorldIndex();

	if (nSubWorldIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	if (nIdx)
	{
		POINT	ptLocal;
		KMapPos	Pos;
		KObjItemInfo	sInfo;
		ptLocal.x = nX;
		ptLocal.y = nY;
		SubWorld[nSubWorldIndex].GetFreeObjPos(ptLocal);

		Pos.nSubWorld = nSubWorldIndex;
		SubWorld[nSubWorldIndex].Mps2Map(ptLocal.x, ptLocal.y,
			&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
			&Pos.nOffX, &Pos.nOffY);
		sInfo.m_nItemID = nIdx;
		sInfo.m_nItemWidth = Item[nIdx].GetWidth();
		sInfo.m_nItemHeight = Item[nIdx].GetHeight();
		sInfo.m_nMoneyNum = 0;
		strcpy(sInfo.m_szName, Item[nIdx].GetName());
		sInfo.m_nColorID = Item[nIdx].GetQuality();
		sInfo.m_nGenre = Item[nIdx].GetGenre();
		sInfo.m_nDetailType = Item[nIdx].GetDetailType();
		sInfo.m_nMovieFlag = 1;
		sInfo.m_nSoundFlag = 1;
		sInfo.m_bOverLook = 0;
		int nObj = ObjSet.Add(Item[nIdx].GetObjIdx(), Pos, sInfo);
		if (nObj > 0)
		{
			if (Item[nIndex].LockPick())
			{
				Object[nObj].SetEntireBelong(nPlayerIndex);
			}
			else
			{
				Object[nObj].SetItemBelong(nPlayerIndex);
			}
			Lua_PushNumber(L, nObj);
			return 1;
		}
	}
	return 0;
}

int LuaDropMapItem(Lua_State *L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 4)
		return 0;

	int nIndex = 0;
	int nSubWorldIndex = 0;
	int nX, nY;
	int nIdx = 0;

	if (nParamNum > 3)
	{
		nSubWorldIndex = g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L, 1));
		nX = (int)Lua_ValueToNumber(L, 2);
		nY = (int)Lua_ValueToNumber(L, 3);
		nIdx = (int)Lua_ValueToNumber(L, 4);
	}

	if (nIdx <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	if (nSubWorldIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	if (nIdx)
	{
		POINT	ptLocal;
		KMapPos	Pos;
		KObjItemInfo	sInfo;
		ptLocal.x = nX;
		ptLocal.y = nY;
		SubWorld[nSubWorldIndex].GetFreeObjPos(ptLocal);

		Pos.nSubWorld = nSubWorldIndex;
		SubWorld[nSubWorldIndex].Mps2Map(ptLocal.x, ptLocal.y,
			&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
			&Pos.nOffX, &Pos.nOffY);
		sInfo.m_nItemID = nIdx;
		sInfo.m_nItemWidth = Item[nIdx].GetWidth();
		sInfo.m_nItemHeight = Item[nIdx].GetHeight();
		sInfo.m_nMoneyNum = 0;
		strcpy(sInfo.m_szName, Item[nIdx].GetName());
		sInfo.m_nColorID = Item[nIdx].GetQuality();
		sInfo.m_nGenre = Item[nIdx].GetGenre();
		sInfo.m_nDetailType = Item[nIdx].GetDetailType();
		sInfo.m_nMovieFlag = 1;
		sInfo.m_nSoundFlag = 1;
		sInfo.m_bOverLook = 0;
		int nObj = ObjSet.Add(Item[nIdx].GetObjIdx(), Pos, sInfo);
		if (nObj > 0)
		{
			Object[nObj].SetItemBelong(-1);
			Lua_PushNumber(L, nObj);
			return 1;
		}
	}
	return 0;
}

// Translate the VNG normal-item tuple into the table identity used by this
// Core.  Only table families backed by verified VNG item\001 payloads are
// accepted here; unsupported genres must remain quarantined.
#include "PhongThanQuestItemTuple.h"
static BOOL MapVngNormalItemTuple(int nGenre, int nDetail, int nParticular,
	int* pnRuntimeGenre, int* pnRuntimeDetail)
{
	if (!pnRuntimeGenre || !pnRuntimeDetail)
		return FALSE;
	*pnRuntimeGenre = -1;
	*pnRuntimeDetail = -1;
	PhongThanQuestItemTuple tuple;
	if(PhongThanMapQuestItemIdentity(nGenre,nDetail,nParticular,tuple))
	{
		*pnRuntimeGenre=tuple.genre;*pnRuntimeDetail=tuple.detail;return TRUE;
	}
	return FALSE;
}

static int CreateVngNormalItem(int nGenre, int nDetail, int nParticular,
	int nLevel, int nSeries, int nLuck)
{
	PhongThanQuestItemTuple tuple;
	if (!PhongThanDecodeQuestItemTuple(nGenre,nDetail,nParticular,nLevel,nSeries,nLuck,tuple))
		return 0;

	int nMagicLevel[MAX_ITEM_MAGICLEVEL];
	ZeroMemory(nMagicLevel, sizeof(nMagicLevel));
	int nIndex = ItemSet.Add(tuple.genre, tuple.series,
		tuple.level, tuple.luck, tuple.detail, tuple.particular, nMagicLevel,
		g_SubWorldSet.GetGameVersion());
	if (nIndex <= 0)
		return 0;

	// KItemSet::Add historically returns an allocated slot even when a table
	// generator rejects its key.  Validate the generated identity before the
	// item is allowed into an inventory or map object.
	if (!PhongThanQuestItemMatches(Item[nIndex],tuple) ||
		Item[nIndex].GetWidth() <= 0 || Item[nIndex].GetHeight() <= 0)
	{
		ItemSet.Remove(nIndex);
		return 0;
	}
	return nIndex;
}

#include "PhongThanQuestExchange.inl"
int LuaGetNpcLevel(Lua_State * L)
{
	int nNpcIndex = 0;
	if (Lua_GetTopIndex(L) >= 1)
		nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	Lua_PushNumber(L, Npc[nNpcIndex].m_Level);
	return 1;
}

int LuaIsExistItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 3)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nRuntimeGenre = -1;
	int nRuntimeDetail = -1;
	PhongThanQuestItemTuple identity;
	if (!MapVngNormalItemTuple(
		(int)Lua_ValueToNumber(L, 1),
		(int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3),
		&nRuntimeGenre, &nRuntimeDetail) ||
		!PhongThanMapQuestItemIdentity(
		(int)Lua_ValueToNumber(L, 1),
		(int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3), identity))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nCount = 0;
	PlayerItem* pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
	while (pOwned)
	{
		int nItemIndex = pOwned->nIdx;
		if (nItemIndex > 0 && nItemIndex < MAX_ITEM &&
			Item[nItemIndex].GetGenre() == nRuntimeGenre &&
			Item[nItemIndex].GetDetailType() == nRuntimeDetail &&
			Item[nItemIndex].GetParticular() == identity.particular)
		{
			nCount += Item[nItemIndex].IsStack() ?
				Item[nItemIndex].GetStackNum() : 1;
		}
		pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
	}
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaAddNormalItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 6)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nIndex = CreateVngNormalItem(
		(int)Lua_ValueToNumber(L, 1),
		(int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3),
		(int)Lua_ValueToNumber(L, 4),
		(int)Lua_ValueToNumber(L, 5),
		(int)Lua_ValueToNumber(L, 6));
	if (nIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	POINT itemSize;
	itemSize.x = Item[nIndex].GetWidth();
	itemSize.y = Item[nIndex].GetHeight();
	if (Player[nPlayerIndex].m_ItemList.Add(nIndex, itemSize, false) <= 0)
	{
		ItemSet.Remove(nIndex);
		Lua_PushNumber(L, 0);
		return 1;
	}
	if (Lua_GetTopIndex(L) >= 7 && (int)Lua_ValueToNumber(L, 7) > 0)
	{
		Item[nIndex].LockItem(LOCK_STATE_FOREVER);
#ifdef _SERVER
		Player[nPlayerIndex].m_ItemList.SyncItem(nIndex);
#endif
	}
	Lua_PushNumber(L, nIndex);
	return 1;
}

// VNG keeps the external IBItem tuple (8, detail, particular), while the
// runtime uses item_ibitem to avoid colliding with legacy item_materials.
int LuaFindAValidIBItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 4 ||
		(int)Lua_ValueToNumber(L, 1) != 8)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	const int nDetail = (int)Lua_ValueToNumber(L, 2);
	const int nParticular = (int)Lua_ValueToNumber(L, 3);
	const int nLevel = (int)Lua_ValueToNumber(L, 4);
	PlayerItem* pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
	while (pOwned)
	{
		const int nItemIndex = pOwned->nIdx;
		if (nItemIndex > 0 && nItemIndex < MAX_ITEM &&
			Item[nItemIndex].GetGenre() == item_ibitem &&
			Item[nItemIndex].GetDetailType() == nDetail &&
			Item[nItemIndex].GetParticular() == nParticular &&
			(nLevel <= 0 || Item[nItemIndex].GetLevel() == nLevel) &&
			(Item[nItemIndex].GetExpireTime() == 0 ||
			 Item[nItemIndex].GetExpireTime() > KSG_GetCurSec()))
		{
			Lua_PushNumber(L, nItemIndex);
			return 1;
		}
		pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
	}
	Lua_PushNumber(L, 0);
	return 1;
}

int LuaCostIBItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nItemIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (nPlayerIndex > 0 && nItemIndex > 0 && nItemIndex < MAX_ITEM &&
		Item[nItemIndex].GetGenre() == item_ibitem &&
		Player[nPlayerIndex].m_ItemList.FindSame(nItemIndex) > 0)
	{
		nResult = Player[nPlayerIndex].m_ItemList.RemoveItem(nItemIndex, 1);
	}
	Lua_PushNumber(L, nResult ? 1 : 0);
	return 1;
}

int LuaThrowItem(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 8)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nOwnerPlayer = (int)Lua_ValueToNumber(L, 2);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC ||
		Npc[nNpcIndex].m_SubWorldIndex < 0 ||
		(Lua_GetTopIndex(L) >= 9 && (int)Lua_ValueToNumber(L, 9) != 0))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	if (nOwnerPlayer == 0)
		nOwnerPlayer = GetPlayerIndex(L);
	if (nOwnerPlayer < -1 || nOwnerPlayer >= MAX_PLAYER)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nItemIndex = CreateVngNormalItem(
		(int)Lua_ValueToNumber(L, 3),
		(int)Lua_ValueToNumber(L, 4),
		(int)Lua_ValueToNumber(L, 5),
		(int)Lua_ValueToNumber(L, 6),
		(int)Lua_ValueToNumber(L, 7),
		(int)Lua_ValueToNumber(L, 8));
	if (nItemIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nX = 0;
	int nY = 0;
	Npc[nNpcIndex].GetMpsPos(&nX, &nY);
	int nSubWorldIndex = Npc[nNpcIndex].GetSubWorldIndex();
	POINT localPos;
	localPos.x = nX;
	localPos.y = nY;
	SubWorld[nSubWorldIndex].GetFreeObjPos(localPos);
	KMapPos mapPos;
	mapPos.nSubWorld = nSubWorldIndex;
	SubWorld[nSubWorldIndex].Mps2Map(localPos.x, localPos.y,
		&mapPos.nRegion, &mapPos.nMapX, &mapPos.nMapY,
		&mapPos.nOffX, &mapPos.nOffY);

	KObjItemInfo info;
	ZeroMemory(&info, sizeof(info));
	info.m_nItemID = nItemIndex;
	info.m_nItemWidth = Item[nItemIndex].GetWidth();
	info.m_nItemHeight = Item[nItemIndex].GetHeight();
	strncpy(info.m_szName, Item[nItemIndex].GetName(), sizeof(info.m_szName) - 1);
	info.m_szName[sizeof(info.m_szName) - 1] = 0;
	info.m_nColorID = Item[nItemIndex].GetQuality();
	info.m_nGenre = Item[nItemIndex].GetGenre();
	info.m_nDetailType = Item[nItemIndex].GetDetailType();
	info.m_nMovieFlag = 1;
	info.m_nSoundFlag = 1;
	int nObjectIndex = ObjSet.Add(Item[nItemIndex].GetObjIdx(), mapPos, info);
	if (nObjectIndex <= 0)
	{
		ItemSet.Remove(nItemIndex);
		Lua_PushNumber(L, 0);
		return 1;
	}
	Object[nObjectIndex].SetItemBelong(nOwnerPlayer);
	Lua_PushNumber(L, nObjectIndex);
	return 1;
}

int LuaAddItem(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 5)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nItemGenre = (int)Lua_ValueToNumber(L, 1);
	int nDetailType = (int)Lua_ValueToNumber(L, 2);
	int nParticularType = (int)Lua_ValueToNumber(L, 3);
	int nLevel = (int)Lua_ValueToNumber(L, 4);
	int nSeries = (int)Lua_ValueToNumber(L, 5);
	int nLuck = nParamNum >= 6 ? (int)Lua_ValueToNumber(L, 6) : 0;
	if (nItemGenre < item_equip || nItemGenre >= item_number)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nItemLevel[MAX_ITEM_MAGICLEVEL];
	ZeroMemory(nItemLevel, sizeof(nItemLevel));
	for (int i = 0; i < MAX_ITEM_MAGICLEVEL && 7 + i <= nParamNum; ++i)
		nItemLevel[i] = (int)Lua_ValueToNumber(L, 7 + i);

	int nIndex = ItemSet.Add(nItemGenre, nSeries, nLevel, nLuck,
		nDetailType, nParticularType, nItemLevel,
		g_SubWorldSet.GetGameVersion());
	Lua_PushNumber(L, nIndex > 0 ? nIndex : 0);
	return 1;
}

int LuaAddItemIdx(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nIdx = (int)Lua_ValueToNumber(L, 1);
	if (nIdx < 0 || nIdx >= MAX_ITEM)
		return 0;
	int nIndex = ItemSet.Add(&Item[nIdx]);
	if (nIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	Lua_PushNumber(L, nIndex);
	return 1;
}


int LuaAddItemID(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	int nIndex = (int)Lua_ValueToNumber(L, 1);

	if (nIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int	P = pos_equiproom, x = 0, y = 0;
	POINT	pPos;
	if (nParamNum > 2)
	{
		P = (int)Lua_ValueToNumber(L, 2);
	}
	if (nParamNum > 3)
	{
		P = (int)Lua_ValueToNumber(L, 2);
		x = (int)Lua_ValueToNumber(L, 3);
	}
	if (nParamNum > 4)
	{
		P = (int)Lua_ValueToNumber(L, 2);
		x = (int)Lua_ValueToNumber(L, 3);
		y = (int)Lua_ValueToNumber(L, 4);
	}
	if (P < pos_hand || P > pos_num)
		return 0;

	if (nParamNum == 5 && Player[nPlayerIndex].m_ItemList.m_Room[PositionToRoom(P)].CheckRoom(x, y, Item[nIndex].GetWidth(), Item[nIndex].GetHeight()))
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, x, y, false);
	else if (nParamNum == 4 && Player[nPlayerIndex].m_ItemList.PositionToIndex(P, x) <= 0)
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, x, 0, false);
	else if (nParamNum == 3 && Player[nPlayerIndex].m_ItemList.m_Room[PositionToRoom(P)].FindRoom(Item[nIndex].GetWidth(), Item[nIndex].GetHeight(), &pPos))
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, pPos.x, pPos.y, false);
	else
		Player[nPlayerIndex].m_ItemList.InsertEquipment(nIndex, false);
	if (Item[nIndex].GetGenre() == item_magicscript &&
		Item[nIndex].GetDetailType() == 4813)
	{
		int nGuideCount = Player[nPlayerIndex].m_ItemList.CountCommonItem(
			item_magicscript, 4813, -1, -1, pos_equiproom);
		FILE *pGuideLog = fopen("camnang_f4_diag.log", "a+b");
		if (pGuideLog)
		{
			fprintf(pGuideLog, "AddItemID account=%s player=%d item=%d params=%d requested_place=%d count_f4_after=%d\r\n",
				Player[nPlayerIndex].AccountName, nPlayerIndex, nIndex, nParamNum, P, nGuideCount);
			fclose(pGuideLog);
		}
	}

	Lua_PushNumber(L, nIndex);
	return 1;
}


int LuaAddItemIDStack(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	int nIndex = (int)Lua_ValueToNumber(L, 1);

	if (nIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int	P = pos_equiproom, x = 0, y = 0;
	POINT	pPos;
	if (nParamNum > 2)
	{
		P = (int)Lua_ValueToNumber(L, 2);
	}
	if (nParamNum > 3)
	{
		P = (int)Lua_ValueToNumber(L, 2);
		x = (int)Lua_ValueToNumber(L, 3);
	}
	if (nParamNum > 4)
	{
		P = (int)Lua_ValueToNumber(L, 2);
		x = (int)Lua_ValueToNumber(L, 3);
		y = (int)Lua_ValueToNumber(L, 4);
	}
	if (P < pos_hand || P > pos_num)
		return 0;
	if (nParamNum == 5 && Player[nPlayerIndex].m_ItemList.m_Room[PositionToRoom(P)].CheckRoom(x, y, Item[nIndex].GetWidth(), Item[nIndex].GetHeight()))
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, x, y);
	else if (nParamNum == 4 && Player[nPlayerIndex].m_ItemList.PositionToIndex(P, x) <= 0)
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, x, 0);
	else if (nParamNum == 3 && Player[nPlayerIndex].m_ItemList.m_Room[PositionToRoom(P)].FindRoom(Item[nIndex].GetWidth(), Item[nIndex].GetHeight(), &pPos))
		Player[nPlayerIndex].m_ItemList.Add(nIndex, P, pPos.x, pPos.y);
	else
		Player[nPlayerIndex].m_ItemList.InsertEquipment(nIndex, true);
	return 0;
}

int LuaGetMagicAttrib(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	int nIndex;
	if (nParamNum < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	nIndex = (int)Lua_ValueToNumber(L, 1);
	if (nIndex > 0)
	{
		for (int i = 0; i < MAX_ITEM_MAGICATTRIB; i ++)
		{
			Lua_PushNumber(L, Item[nIndex].m_aryMagicAttrib[i].nAttribType);
			Lua_PushNumber(L, Item[nIndex].m_aryMagicAttrib[i].nValue[0]);
			Lua_PushNumber(L, Item[nIndex].m_aryMagicAttrib[i].nValue[2]);
		}
		return MAX_ITEM_MAGICATTRIB * 3;
	}
	else
	{
		for (int i = 0; i < MAX_ITEM_MAGICATTRIB; i ++)
		{
			Lua_PushNumber(L, 0);
			Lua_PushNumber(L, 0);
			Lua_PushNumber(L, 0);
		}
		return MAX_ITEM_MAGICATTRIB * 3;
	}
	return 0;
}


int LuaSetMagicAttrib(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
		return 0;

	int nParamNum = Lua_GetTopIndex(L);

	if (nParamNum < 24)
		return 0;

	int nIndex = (int)Lua_ValueToNumber(L, 1);

	if (nIndex > 0 && Item[nIndex].GetGenre() == item_equip)
	{
		int i = 0, k = 2;
		for (i = 0; i < MAX_ITEM_MAGICATTRIB; i ++)
		{
			Item[nIndex].m_GeneratorParam.nGeneratorLevel[i] = (int)Lua_ValueToNumber(L, k);
			Item[nIndex].m_GeneratorParam.nGeneratorLevel[i + MAX_ITEM_MAGICATTRIB] = MAKELONG((int)Lua_ValueToNumber(L, k + 1),
				(int)Lua_ValueToNumber(L, k + 2));
			Item[nIndex].m_aryMagicAttrib[i].nAttribType = (int)Lua_ValueToNumber(L, k);
			Item[nIndex].m_aryMagicAttrib[i].nValue[0] = (int)Lua_ValueToNumber(L, k + 1);
			Item[nIndex].m_aryMagicAttrib[i].nValue[1] = -1;
			Item[nIndex].m_aryMagicAttrib[i].nValue[2] = (int)Lua_ValueToNumber(L, k + 2);
			k += 3;
		}
		for (NULL; i < MAX_ITEM_MAGICATTRIB; i ++)
		{
			Item[nIndex].m_GeneratorParam.nGeneratorLevel[i] = 0;
			Item[nIndex].m_GeneratorParam.nGeneratorLevel[i + MAX_ITEM_MAGICATTRIB] = 0;
			Item[nIndex].m_aryMagicAttrib[i].nAttribType = 0;
			Item[nIndex].m_aryMagicAttrib[i].nValue[0] = 0;
			Item[nIndex].m_aryMagicAttrib[i].nValue[1] = 0;
			Item[nIndex].m_aryMagicAttrib[i].nValue[2] = 0;
		}
		Player[nPlayerIndex].m_ItemList.SyncItemMagicAttrib(nIndex);
	}
	return 0;
}

/*
AddMagic(nPlayerIndex, nMagicID, nLevel)
DelMagic(nPlayerIndex, nMagicId)
HaveMagic(nPlayerIndex, nMagicId)
GetMagicLevel(nPlayerIndex, nMagicId)
SetMagicLevel(nPlayerIndex, nMagicId, nLevel)
ModifyMagicLevel(nPlayerIndex ,nMagicId, nDLevel)
*/
int LuaAddMagic(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;
	if (nParamCount < 1) return 0;
	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nSkillId = 0;
	if (Lua_IsNumber(L, 1))
	{
		nSkillId = (int)Lua_ValueToNumber (L, 1);
	}
	else
	{
		const char * sSkillName = Lua_ValueToString(L, 1);
		g_OrdinSkillsSetting.GetInteger((char*)sSkillName, "SkillId", 0, &nSkillId);
		if (nSkillId <= 0 ) return 0;
	}
	int nSkillLevel = 0;
	if (nParamCount >=2)
		nSkillLevel = (int)Lua_ValueToNumber(L,2);
	else
		nSkillLevel = 0;

    int nRet = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.Add(nSkillId, nSkillLevel);
	if (nRet)
	{
		Player[nPlayerIndex].UpdataCurData();
		PHONGTHAN_SKILL_LEVEL_UPDATE NewSkill;
		ZeroMemory(&NewSkill, sizeof(NewSkill));
	PhongThanInitializeWireHeader(&NewSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(NewSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NewSkill.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	NewSkill.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
		NewSkill.SkillId = nSkillId;
		NewSkill.Level = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId);
		NewSkill.BonusLevel = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetAddLevel(nSkillId);
		NewSkill.Experience = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetExp(nSkillId);
		NewSkill.Temporary = (Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.IsTempSkill(nSkillId)) ? 1 : 0;
		NewSkill.RemainingPoints = Player[nPlayerIndex].m_nSkillPoint;
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, (BYTE*)&NewSkill, sizeof(NewSkill));
	}

	Lua_PushNumber(L, nRet);
	return 1;
}

int LuaDelMagic(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;
	if (nParamCount < 1) return 0;

    nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	int nSkillId = 0;
	if (Lua_IsNumber(L, 1))
	{
		nSkillId = (int)Lua_ValueToNumber (L, 1);
	}
	else
	{
		const char * sSkillName = Lua_ValueToString(L, 1);
		g_OrdinSkillsSetting.GetInteger((char*)sSkillName, "SkillId", 0, &nSkillId);
		if (nSkillId <= 0 ) return 0;
	}
	Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.Remove(nSkillId);

	Player[nPlayerIndex].SendSyncData_Skill();
	return 0;
}

int LuaDelAllMagic(Lua_State * L)
{
	int nPlayerIndex = 0;

    nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (!Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.IsBaseSkill(
			Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.m_Skills[i].SkillId))
			Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.RemoveIdx(i);
	}

	Player[nPlayerIndex].SendSyncData_Skill();
	return 0;
}

int LuaHaveMagic(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;
	if (nParamCount < 1) return 0;

	nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	int nSkillId = 0;
	if (Lua_IsNumber(L, 1))
	{
		nSkillId = (int)Lua_ValueToNumber (L, 1);
	}
	else
	{
		const char * sSkillName = Lua_ValueToString(L, 1);
		g_OrdinSkillsSetting.GetInteger((char *)sSkillName, "SkillId", 0, &nSkillId);
		if (nSkillId <= 0 )
		{
			Lua_PushNumber(L, -1);
		}
		return 1;
	}

	if (Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.FindSame(nSkillId))
	{
		Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId));
	}
	else
	{
		Lua_PushNumber(L, -1);
	}

	return 1;
}

int LuaIncSkill(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;
	if (nParamCount < 2) return 0;

	nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	int nSkillId = 0, nAddLevel = 0;
	nSkillId = (int)Lua_ValueToNumber(L, 1);
	nAddLevel = (int)Lua_ValueToNumber(L, 2);
	if (nSkillId <= 0 || nAddLevel <= 0)
		return 0;
	Player[nPlayerIndex].IncSkillLevel(nSkillId, nAddLevel);
	return 0;
}

int LuaIncSkillExp(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;
	if (nParamCount < 2) return 0;

	nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	int nSkillId = 0, nAddExp = 0;
	nSkillId = (int)Lua_ValueToNumber(L, 1);
	nAddExp = (int)Lua_ValueToNumber(L, 2);
	if (nSkillId <= 0 || nAddExp <= 0)
		return 0;
	Player[nPlayerIndex].IncSkillExp(nSkillId, nAddExp);
	return 0;
}

int LuaGetSkillIdInSkillList(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	int nSkillIndex = (int)Lua_ValueToNumber (L, 1);
	int nSkillId = 0;
	if (nSkillIndex > 0)
	{
		nSkillId = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetSkillId(nSkillIndex);
	}
	Lua_PushNumber(L, nSkillId);
	return 1;
}

int LuaSetSkillLevel(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	int nSkillId = 0;

	if (Lua_IsNumber(L, 1))
	{
		nSkillId = (int)Lua_ValueToNumber (L, 1);
	}
	else
	{
		const char * sSkillName = Lua_ValueToString(L, 1);
		g_OrdinSkillsSetting.GetInteger((char *)sSkillName, "SkillId", 0, &nSkillId);
		if (nSkillId <= 0 ) return 0;
	}
	int nSkillLevel = (int)Lua_ValueToNumber(L, 2);
	if (nSkillLevel >= 0)
		Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.SetSkillLevelDirectlyUsingId(nSkillId, nSkillLevel);
	return 0;
}

int LuaSetSkillTemp(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	int nSkillIdx = (int)Lua_ValueToNumber (L, 1);
	BOOL bSkillTemp = (int)Lua_ValueToNumber(L, 2) > 0;

	Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.SetTempSkill(nSkillIdx, bSkillTemp);
	return 0;
}

int LuaRollBackSkills(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	bool bRbAll = false;
	if (Lua_GetTopIndex(L) > 1)
		bRbAll = (int)Lua_ValueToNumber(L,1) > 0;

	int nTotalSkill = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.RollBackSkills(bRbAll);

	Player[nPlayerIndex].SendSyncData_Skill();

	Lua_PushNumber(L, nTotalSkill);
	return 1;
}

int LuaGetMagicLevel(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	int nPlayerIndex = 0;

	if (nParamCount < 1) return 0;
	nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	int nSkillId = 0;
	if (Lua_IsNumber(L, 1))
	{
		nSkillId = (int)Lua_ValueToNumber (L, 1);
	}
	else
	{
		const char * sSkillName = Lua_ValueToString(L, 1);
		g_OrdinSkillsSetting.GetInteger((char *)sSkillName, "SkillId", 0, &nSkillId);
		if (nSkillId <= 0 ) return 0;
	}
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId));
	return 1;

}

// ---------------------------------------------------------------------------
// Phong Than VNG item-script compatibility (P0 batch).
// Keep these wrappers narrow and validate every engine index before access.
// ---------------------------------------------------------------------------
int LuaGetItemPartByID(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nItemIndex = (int)Lua_ValueToNumber(L, 1);
	if (nItemIndex <= 0 || nItemIndex >= MAX_ITEM)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	// MagicScript's item-part checks use the VNG Particular column.  DetailType
	// is only the broad item subtype (for example 1 for a magic-script item),
	// while Phàm Nhân Ấn and the other migrated seals are identified by their
	// Particular value (5803, ...).  Returning DetailType makes every VNG Lua
	// branch that compares GetItemPartByID() silently take its fallback path.
	// Phong Than 2026-10-05 natives-20261005: a magic-script item keeps its VNG key in DetailType and
	// ParticularType 0 (KBasPropTbl.CPP loader, KItem::operator=(KBASICPROP_MAGICSCRIPT)), so this
	// answered 0 for every (6,1,P) item. Answer P for those; every other genre is unchanged.
	if (Item[nItemIndex].GetGenre() == item_magicscript && Item[nItemIndex].GetParticular() == 0 &&
		Item[nItemIndex].GetDetailType() > 0)
	{
		Lua_PushNumber(L, Item[nItemIndex].GetDetailType());
		return 1;
	}
	Lua_PushNumber(L, Item[nItemIndex].GetParticular());
	return 1;
}

int LuaIsSkillActived(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSkillId = (int)Lua_ValueToNumber(L, 1);
	if (nSkillId <= 0 || nSkillId >= MAX_SKILL)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	Lua_PushNumber(L,
		Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId) > 0 ? 1 : 0);
	return 1;
}

int LuaActiveNewBirthSkill(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSkillId = (int)Lua_ValueToNumber(L, 1);
	if (nSkillId <= 0 || nSkillId >= MAX_SKILL)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
#ifdef _SERVER
	KSkillList& SkillList = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList;
	if (SkillList.GetLevel(nSkillId) > 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSkillIndex = SkillList.Add(nSkillId, 1);
	if (nSkillIndex > 0)
		Player[nPlayerIndex].SendSyncData_Skill();
	Lua_PushNumber(L, nSkillIndex > 0 ? 1 : 0);
#else
	Lua_PushNumber(L, 0);
#endif
	return 1;
}

int LuaAddSkillLevelCompat(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 2)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSkillId = (int)Lua_ValueToNumber(L, 1);
	int nAddLevel = (int)Lua_ValueToNumber(L, 2);
	if (nSkillId <= 0 || nSkillId >= MAX_SKILL || nAddLevel <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
#ifdef _SERVER
	KSkillList& SkillList = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList;
	int nOldLevel = SkillList.GetLevel(nSkillId);
	int nNewLevel = nOldLevel + nAddLevel;
	if (nNewLevel >= MAX_SKILLLEVEL)
		nNewLevel = MAX_SKILLLEVEL - 1;
	int nResult = 0;
	if (nOldLevel <= 0)
		nResult = SkillList.Add(nSkillId, nNewLevel);
	else
		nResult = SkillList.SetSkillLevelDirectlyUsingId(nSkillId, nNewLevel);
	if (nResult > 0)
		Player[nPlayerIndex].SendSyncData_Skill();
	Lua_PushNumber(L, nResult > 0 ? 1 : 0);
#else
	Lua_PushNumber(L, 0);
#endif
	return 1;
}

int LuaSetSummonBeastMorph(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nTemplateId = (int)Lua_ValueToNumber(L, 1);
	// These are the six verified P0 VNG summon-beast appearance templates.
	if (nTemplateId < 2651 || nTemplateId > 2656)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
#ifdef _SERVER
	int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
	int nPetIndex = (nPlayerNpc > 0 && nPlayerNpc < MAX_NPC) ?
		Npc[nPlayerNpc].m_nPetIdx : 0;
	if (nPetIndex <= 0 || nPetIndex >= MAX_NPC ||
		Npc[nPetIndex].m_RegionIndex < 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	Npc[nPetIndex].m_NpcSettingIdx = nTemplateId;
	Npc[nPetIndex].SendSyncData(0, TRUE);
	Lua_PushNumber(L, 1);
#else
	Lua_PushNumber(L, 0);
#endif
	return 1;
}
/*
int LuaSetMagicLevel(Lua_State * L)
{
int nParamCount = Lua_GetTopIndex(L);
int nPlayerIndex = 0;
int nTemp = 0;
if (nParamCount < 1) return 0;

  nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0) return 0;

	  int nSkillId = 0;
	  if (Lua_IsNumber(L, nTemp))
	  {
	  nSkillId = (int)Lua_ValueToNumber (L, 1);
	  }
	  else
	  {
	  const char * sSkillName = Lua_ValueToString(L, 1);
	  nSkillId = g_OrdinSkillsSetting.FindRow((char *)sSkillName) - 2;
	  if (nSkillId <= 0 ) return 0;
	  }
	  int nNpcIndex = Player[nPlayerIndex].m_nIndex;
	  if (nNpcIndex > 0)
	  Lua_PushNumber(L,Npc[nNpcIndex].m_SkillList.SetSkillLevel(nSkillId, (int)Lua_ValueToNumber(L, 2)));
	  return 0;
	  }
*/
//**************************************************************************************************************************************************************
//												NPC????????????????????
//**************************************************************************************************************************************************************
/*nNpcTemplateId GetNpcTmpId(sName)
??????????????Npc?????????????????????????????????sName??????Npc??????????????????????Id
sName:Npc????????????
nNpcTemplateID:??????????????Id
*/

int LuaGetNpcTemplateID(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex > 0)
	{
		Lua_PushNumber(L,Npc[nNpcIndex].m_NpcSettingIdx);
		return 1;
	}
	return 0;
}

int LuaGetNpcTempName(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;

	int nNpcSettingIdx = (int)Lua_ValueToNumber(L, 1);
	char	Name[32];
	g_NpcSetting.GetString(nNpcSettingIdx + 2, "Name", "", Name, sizeof(Name));
	Lua_PushString(L,Name);
	return 1;
}

int LuaGetNpcTempTypeName(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;

	int nNpcSettingIdx = (int)Lua_ValueToNumber(L, 1);
	char	szNpcTypeName[32];
	g_NpcSetting.GetString(nNpcSettingIdx + 2, "NpcResType", "", szNpcTypeName, sizeof(szNpcTypeName));
	Lua_PushString(L,szNpcTypeName);
	return 1;
}
//player bot
int LuaAddPlayerBot(Lua_State * L)
{
	char * pName = NULL;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if	(Lua_IsString(L,1))
	{
		pName = (char *)lua_tostring(L,1);
	}
	int nPosX = 0;
	int nPosY = 0;
	Npc[Player[nPlayerIndex].m_nIndex].GetMpsPos(&nPosX, &nPosY);

	int nSubWorldIndex = Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex;
    // T???o Bot ?????ng ngay c???nh Admin
    int nNpcIndex = PlayerSet.AddBot(pName, nSubWorldIndex, nPosX + 10, nPosY + 10);
	Lua_PushNumber(L, nNpcIndex);
	
    return 1;
}

/*
nNpcIndex AddNpc(nNpcTemplateId,nLevel, nSubWorldIndex, nPosX, nPosY )

  ????????????????????????????????????????????????NPC
  ??????????????????
  nNpcTemplateId: NPC??????NPC????????????????id
  nLevel:Npc??????????
  nSubWorldIndex:??????????????????????????????id
  nPosX??????X (??????????????????)
  nPosY??????Y (??????????????????)
  nNpcIndex:????????????????????????????????Npc?????????????????????????????Index?????????????????????????????????????????nil
*/

int LuaAddNpc(Lua_State * L)
{
	char * pName = NULL;
	int	   nId = 0;
	if (Lua_GetTopIndex(L) < 6) return 0;

	if (Lua_IsNumber(L,1))
	{
		nId = (int)Lua_ValueToNumber(L,1);
	}
	else if	(Lua_IsString(L,1))
	{
		pName = (char *)lua_tostring(L,1);
		nId = g_NpcSetting.FindRow((char*)pName) - 2;
	}
	else return 0;

	if (nId < 0 || nId > (g_NpcSetting.GetHeight()-2)) return 0;

	int nLevel = (int)lua_tonumber(L,2);
	//if (nLevel >= 128) nLevel = 127;
	if (nLevel < 0 ) nLevel = 1;

	int	nNpcIdxInfo = MAKELONG(nLevel, nId);//(nId << 7) + nLevel;
	//question
	if ((int)lua_tonumber(L, 3) != -1)
	{
		int nNpcIdx = NpcSet.Add(nNpcIdxInfo, (int)lua_tonumber(L, 3), (int)lua_tonumber(L,4), (int)lua_tonumber(L,5), (BOOL)lua_tonumber(L,6));
		Lua_PushNumber(L, nNpcIdx);
		return 1;
	}
	Lua_PushNumber(L, 0);
    return 1;
}

/*nResult DelNpc (nNpcIndex)
????????????????????????????????????????????NPC
nResult:?????????????????????????,1??????????,0??????????
*/
int LuaDelNpc(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex > 0)
	{
		if (Npc[nNpcIndex].m_RegionIndex >= 0)
		{
			SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].RemoveNpc(nNpcIndex);
			SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].DecRef(Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
		}
		NpcSet.Remove(nNpcIndex);
	}
	return 0;
}

int LuaClearMapNpc(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L , 0);
		return 1;
	}
	int nSubWorldIndex = g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L, 1));

	int nResult = 0;
	if (nSubWorldIndex >= 0)
	{
		for (int nNpcIndex=1;nNpcIndex<MAX_NPC;++nNpcIndex)
		{
			if (Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex)
			{
				if (Npc[nNpcIndex].m_RegionIndex >= 0)
				{
					SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].RemoveNpc(nNpcIndex);
					SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].DecRef(Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
				}
				NpcSet.Remove(nNpcIndex);
				nResult++;
			}
		}
	}
	Lua_PushNumber(L , nResult);
	return 1;
}

int LuaClearMapNpcWithName(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L , 0);
		return 1;
	}
	int nSubWorldIndex = g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L, 1));

	int nResult = 0;
	if (nSubWorldIndex >= 0)
	{
		for (int nNpcIndex=1;nNpcIndex<MAX_NPC;++nNpcIndex)
		{
			if (Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex)
			{
				if (strcmp(Npc[nNpcIndex].Name, (char*)Lua_ValueToString(L, 2)) == 0)
				{
					if (Npc[nNpcIndex].m_RegionIndex >= 0)
					{
						SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].RemoveNpc(nNpcIndex);
						SubWorld[Npc[nNpcIndex].m_SubWorldIndex].m_Region[Npc[nNpcIndex].m_RegionIndex].DecRef(Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
					}
					NpcSet.Remove(nNpcIndex);
					nResult++;
				}
			}
		}
	}
	Lua_PushNumber(L , nResult);
	return 1;
}

/*
nDelCount DelNpcsInRgn(nSubWorld,nRegionId, nKind)
????????????????????????????????????????????????????????????????Region???????????????????????????????NPC
????????????:??????????????Npc????????????
*/

int LuaDelNpcsInRgn(Lua_State * L)
{
	//Question
	return 0;
}
/*
nDelCount DelNpcsInWld(nSubWorldId, nKind)
??????????????????????????????????????????????????????????????????????Npc
*/
int LuaDelNpcsInWld(Lua_State * L)
{
	return 0;
}

int LuaSyncNpc(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1 ) return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC) return 0;
	Npc[nNpcIndex].SendSyncData(0, TRUE);
	return 0;
}

int LuaSetNpcPos(Lua_State * L)
{
	int nParamCount = 0;
	if ((nParamCount = Lua_GetTopIndex(L)) < 3) return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0) return 0;

	int nX = (int)Lua_ValueToNumber(L,2);
	int nY = (int)Lua_ValueToNumber(L,3);

	Npc[nNpcIndex].SetPos(nX * 32, nY * 32);
	return 0;
}


int LuaSetNpcActionScript(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2 ) return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC) return 0;
	strcpy(Npc[nNpcIndex].ActionScript, Lua_ValueToString(L,2));
	Npc[nNpcIndex].m_ActionScriptID = g_FileName2Id((char *)Lua_ValueToString(L,2));

	if (Npc[nNpcIndex].m_Kind == kind_normal)
		NpcSet.ExecuteScript(nNpcIndex, Npc[nNpcIndex].m_ActionScriptID, "Revive", nNpcIndex);
	return 0;
}

int LuaSetNpcKind(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nKind = (int)Lua_ValueToNumber(L, 2);
	if (nKind < kind_normal || nKind >= kind_num)
		return 0;

	Npc[nNpcIndex].m_Kind = nKind;
	return 0;
}

int LuaSetNpcSeries(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].SetSeries((int)Lua_ValueToNumber(L, 2));
	return 0;
}


int LuaGetNpcSeries(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushNumber(L,Npc[nNpcIndex].m_Series);
	return 1;
}

int LuaSetNpcExp(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nExp = (int)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentExperience = nExp;
	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_Experience = nExp;
	return 0;
}

int LuaSetNpcLife(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nLife = (int)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentLife = nLife;
	Npc[nNpcIndex].m_CurrentLifeMax = nLife;

	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_LifeMax = nLife;
	return 0;
}


int LuaGetNpcLife(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushNumber(L, Npc[nNpcIndex].m_CurrentLifeMax);
	return 1;
}


int LuaSetNpcLifeReplenish(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nLifeRep = (int)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentLifeReplenish = nLifeRep;
	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_LifeReplenish = nLifeRep;
	return 0;
}

int LuaSetNpcAR(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nAttackR = (int)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentAttackRating = nAttackR;
	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_AttackRating = nAttackR;
	return 0;
}

int LuaSetNpcDefense(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	int nDefense = (int)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentDefend = nDefense;
	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_Defend = nDefense;
	return 0;
}

int LuaSetNpcDamage(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].SetPhysicsDamage((int)Lua_ValueToNumber(L, 2), (int)Lua_ValueToNumber(L, 3));
	return 0;
}


int LuaSetNpcDmgEx(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 6)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	if ((nParamNum > 6) && (int)Lua_ValueToNumber(L, 7))
	{
		Npc[nNpcIndex].m_CurrentAddPhysicsDamage = (int)Lua_ValueToNumber(L, 2);
		Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[0] = (int)Lua_ValueToNumber(L, 3);
		if (Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[0] > 0)
		{
			Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[1] = POISON_DAMAGE_TIME;//pMagic->nValue[1];
			Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[2] = POISON_DAMAGE_INTERVAL;//pMagic->nValue[2];
		}
		else
		{
			Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[0] = 0;
			Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[1] = 0;
			Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[2] = 0;
		}
		Npc[nNpcIndex].m_CurrentColdDamage.nValue[0] = (int)Lua_ValueToNumber(L, 4);
		Npc[nNpcIndex].m_CurrentColdDamage.nValue[2] = (int)Lua_ValueToNumber(L, 4);
		if (Npc[nNpcIndex].m_CurrentColdDamage.nValue[0] > 0 && Npc[nNpcIndex].m_CurrentColdMagic.nValue[2] > 0)
			Npc[nNpcIndex].m_CurrentColdDamage.nValue[1] = COLD_DAMAGE_TIME;
		else
		{
			Npc[nNpcIndex].m_CurrentColdDamage.nValue[0] = 0;
			Npc[nNpcIndex].m_CurrentColdDamage.nValue[2] = 0;
			Npc[nNpcIndex].m_CurrentColdDamage.nValue[1] = 0;
		}
		Npc[nNpcIndex].m_CurrentFireDamage.nValue[0] = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_CurrentFireDamage.nValue[2] = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_CurrentLightDamage.nValue[0] = (int)Lua_ValueToNumber(L, 6);
		Npc[nNpcIndex].m_CurrentLightDamage.nValue[2] = (int)Lua_ValueToNumber(L, 6);
	}
	else
	{
		Npc[nNpcIndex].m_CurrentAddPhysicsMagic = (int)Lua_ValueToNumber(L, 2);
		Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[0] = (int)Lua_ValueToNumber(L, 3);
		if (Npc[nNpcIndex].m_CurrentPoisonDamage.nValue[0] > 0)
		{
			Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[1] = POISON_DAMAGE_TIME;//pMagic->nValue[1];
			Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[2] = POISON_DAMAGE_INTERVAL;//pMagic->nValue[2];
		}
		else
		{
			Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[0] = 0;
			Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[1] = 0;
			Npc[nNpcIndex].m_CurrentPoisonMagic.nValue[2] = 0;
		}
		Npc[nNpcIndex].m_CurrentColdMagic.nValue[0] = (int)Lua_ValueToNumber(L, 4);
		Npc[nNpcIndex].m_CurrentColdMagic.nValue[2] = (int)Lua_ValueToNumber(L, 4);
		if (Npc[nNpcIndex].m_CurrentColdMagic.nValue[0] > 0 && Npc[nNpcIndex].m_CurrentColdMagic.nValue[2] > 0)
			Npc[nNpcIndex].m_CurrentColdMagic.nValue[1] = COLD_DAMAGE_TIME;
		else
		{
			Npc[nNpcIndex].m_CurrentColdMagic.nValue[0] = 0;
			Npc[nNpcIndex].m_CurrentColdMagic.nValue[2] = 0;
			Npc[nNpcIndex].m_CurrentColdMagic.nValue[1] = 0;
		}
		Npc[nNpcIndex].m_CurrentFireMagic.nValue[0] = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_CurrentFireMagic.nValue[2] = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_CurrentLightMagic.nValue[0] = (int)Lua_ValueToNumber(L, 6);
		Npc[nNpcIndex].m_CurrentLightMagic.nValue[2] = (int)Lua_ValueToNumber(L, 6);
	}
	return 0;
}

int LuaSetNpcResist(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 6)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentPhysicsResistMax = (int)Lua_ValueToNumber(L, 2);
	Npc[nNpcIndex].m_CurrentPoisonResistMax = (int)Lua_ValueToNumber(L, 3);
	Npc[nNpcIndex].m_CurrentLightResistMax = (int)Lua_ValueToNumber(L, 4);
	Npc[nNpcIndex].m_CurrentFireResistMax = (int)Lua_ValueToNumber(L, 5);
	Npc[nNpcIndex].m_CurrentColdResistMax = (int)Lua_ValueToNumber(L, 6);

	Npc[nNpcIndex].m_CurrentPhysicsResist = (int)Lua_ValueToNumber(L, 2);
	Npc[nNpcIndex].m_CurrentPoisonResist = (int)Lua_ValueToNumber(L, 3);
	Npc[nNpcIndex].m_CurrentLightResist = (int)Lua_ValueToNumber(L, 4);
	Npc[nNpcIndex].m_CurrentFireResist = (int)Lua_ValueToNumber(L, 5);
	Npc[nNpcIndex].m_CurrentColdResist = (int)Lua_ValueToNumber(L, 6);

	if ((nParamNum > 6) && (int)Lua_ValueToNumber(L, 7))
	{
		Npc[nNpcIndex].m_PhysicsResist = (int)Lua_ValueToNumber(L, 2);
		Npc[nNpcIndex].m_PoisonResist = (int)Lua_ValueToNumber(L, 3);
		Npc[nNpcIndex].m_LightResist = (int)Lua_ValueToNumber(L, 4);
		Npc[nNpcIndex].m_FireResist = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_ColdResist = (int)Lua_ValueToNumber(L, 6);

		Npc[nNpcIndex].m_PhysicsResistMax = (int)Lua_ValueToNumber(L, 2);
		Npc[nNpcIndex].m_PoisonResistMax = (int)Lua_ValueToNumber(L, 3);
		Npc[nNpcIndex].m_LightResistMax = (int)Lua_ValueToNumber(L, 4);
		Npc[nNpcIndex].m_FireResistMax = (int)Lua_ValueToNumber(L, 5);
		Npc[nNpcIndex].m_ColdResistMax = (int)Lua_ValueToNumber(L, 6);
	}
	return 0;
}

int LuaSetNpcRevTime(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].SetReviveFrame((int)Lua_ValueToNumber(L, 2));
	return 0;
}

int LuaSetNpcSpeed(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentWalkSpeed = (int)Lua_ValueToNumber(L, 2);
	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_WalkSpeed = (int)Lua_ValueToNumber(L, 2);
	return 0;
}

int LuaSetNpcHitRecover(Lua_State *L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_CurrentHitRecover = (int)Lua_ValueToNumber(L, 2);

	if (nParamNum>2 && (int)Lua_ValueToNumber(L, 3)>0)
		Npc[nNpcIndex].m_HitRecover = (int)Lua_ValueToNumber(L, 2);
	return 0;
}

int LuaSetNpcBoss(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_btSpecial = (int)Lua_ValueToNumber(L, 2);
	return 0;
}

int LuaGetNpcBoss(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushNumber(L, Npc[nNpcIndex].m_btSpecial);
	return 1;
}

int LuaIsBlueBoss(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	if (Npc[nNpcIndex].m_btSpecial == npc_blue)
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaGetNpcExpRate(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 0;
	}
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentExpEnhance);
	return 1;
}

int LuaIsRideHorse(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 0;
	}
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_bRideHorse);
	return 1;
}

int LuaSetNpcRemoveDeath(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_bNpcRemoveDeath = (BOOL)Lua_ValueToNumber(L, 2);
	return 0;
}

int LuaSetNpcTimeout(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Npc[nNpcIndex].m_nNpcTimeout = (int)Lua_ValueToNumber(L, 2) + g_SubWorldSet.GetGameTime();
	return 0;
}

int LuaSetNpcTimer(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	int nNpcIndex;
	int nSeconds;
	const char* pszSource;
	char szScript[MAX_NPC_SCRIPT_FILE_NAME];
	int nSource = 0;
	int nOutput = 0;

	if (nParamNum < 3)
		return 0;
	nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	pszSource = Lua_ValueToString(L, 2);
	nSeconds = (int)Lua_ValueToNumber(L, 3);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC || !pszSource)
		return 0;

	while (*pszSource == '.')
		++pszSource;
	if (_strnicmp(pszSource, "\\root\\script\\", 13) == 0)
		pszSource += 5;
	if (*pszSource != '\\' && nOutput < sizeof(szScript) - 1)
		szScript[nOutput++] = '\\';
	while (pszSource[nSource] && nOutput < sizeof(szScript) - 1)
	{
		szScript[nOutput++] = pszSource[nSource] == '/' ? '\\' :
			pszSource[nSource];
		++nSource;
	}
	szScript[nOutput] = 0;
	g_StrLower(szScript);

	Npc[nNpcIndex].m_TimerScriptID = szScript[0] ?
		g_FileName2Id(szScript) : 0;
	Npc[nNpcIndex].m_nNpcTimerValue = nSeconds;
	Npc[nNpcIndex].m_dwNpcTimerDeadline = nSeconds > 0 ?
		g_SubWorldSet.GetGameTime() + nSeconds * GAME_FPS : 0;
	return 0;
}

int LuaGetNpcTimeout(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushNumber(L, g_SubWorldSet.GetGameTime() - Npc[nNpcIndex].m_nNpcTimeout < 0 ? 0 : g_SubWorldSet.GetGameTime() - Npc[nNpcIndex].m_nNpcTimeout);
	return 1;
}

int LuaSetNpcParam(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	if (nParamNum > 2)
	{
		int nParamIndex = (int)Lua_ValueToNumber(L,2);
		if (nParamIndex < 0 || nParamIndex >= MAX_NPCPARAM)
			return 0;
		Npc[nNpcIndex].m_nNpcParam[nParamIndex] = (int)Lua_ValueToNumber(L,3);
	}
	else
		Npc[nNpcIndex].m_nNpcParam[0] = (int)Lua_ValueToNumber(L,2);
	return 0;
}

int LuaGetNpcParam(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	if (nParamNum > 1)
	{
		int nParamIndex = (int)Lua_ValueToNumber(L,2);
		if (nParamIndex < 0 || nParamIndex >= MAX_NPCPARAM)
			Lua_PushNumber(L, 0);
		else
			Lua_PushNumber(L, Npc[nNpcIndex].m_nNpcParam[nParamIndex]);
	}
	else
		Lua_PushNumber(L, Npc[nNpcIndex].m_nNpcParam[0]);
	return 1;
}

int LuaSetNpcOwner(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
		return 0 ;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;
	strcpy(Npc[nNpcIndex].Owner, (char*)Lua_ValueToString(L,2));
	Npc[nNpcIndex].m_nOwnerIdx = Player[nPlayerIndex].m_nIndex;
	int nPlayerIndex1 = Player[nPlayerIndex].m_nIndex;
	if (nParamNum >= 3)
		Npc[nNpcIndex].m_bNpcFollowFindPath = (BOOL)Lua_ValueToNumber(L,3);
	/////////////////////////
	Npc[nNpcIndex].m_PhysicsDamage              = Npc[nPlayerIndex1].m_PhysicsDamage;
    Npc[nNpcIndex].m_PhysicsMagic              = Npc[nPlayerIndex1].m_PhysicsMagic;
    Npc[nNpcIndex].m_CurrentFireDamage           = Npc[nPlayerIndex1].m_CurrentFireDamage;

    Npc[nNpcIndex].m_CurrentColdDamage         = Npc[nPlayerIndex1].m_CurrentColdDamage;
    Npc[nNpcIndex].m_CurrentLightDamage               = Npc[nPlayerIndex1].m_CurrentLightDamage;

    Npc[nNpcIndex].m_CurrentPoisonDamage           = Npc[nPlayerIndex1].m_CurrentPoisonDamage;
    Npc[nNpcIndex].m_CurrentFireMagic           = Npc[nPlayerIndex1].m_CurrentFireMagic;
    Npc[nNpcIndex].m_CurrentColdMagic          = Npc[nPlayerIndex1].m_CurrentColdMagic;
    Npc[nNpcIndex].m_CurrentLightMagic         = Npc[nPlayerIndex1].m_CurrentLightMagic;
    Npc[nNpcIndex].m_CurrentPoisonMagic        = Npc[nPlayerIndex1].m_CurrentPoisonMagic;

	Npc[nNpcIndex].m_CurrentAttackRating           = Npc[nPlayerIndex1].m_CurrentAttackRating;
    Npc[nNpcIndex].m_CurrentDefend           = Npc[nPlayerIndex1].m_CurrentDefend;
	

    Npc[nNpcIndex].m_CurrentWalkSpeed             = Npc[nPlayerIndex1].m_CurrentWalkSpeed;
    Npc[nNpcIndex].m_CurrentRunSpeed            = Npc[nPlayerIndex1].m_CurrentRunSpeed;


    Npc[nNpcIndex].m_CurrentAttackSpeed          = Npc[nPlayerIndex1].m_CurrentAttackSpeed;
    Npc[nNpcIndex].m_CurrentCastSpeed            = Npc[nPlayerIndex1].m_CurrentCastSpeed;

    Npc[nNpcIndex].m_CurrentLifeMax       = Npc[nPlayerIndex1].m_CurrentLifeMax;
    Npc[nNpcIndex].m_CurrentManaMax       = Npc[nPlayerIndex1].m_CurrentManaMax;
	/////////////////////////
	Npc[nNpcIndex].m_uFindPathTime = g_SubWorldSet.GetGameTime();
	return 0;
}

int LuaGetNpcOwner(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	lua_pushstring(L, Npc[nNpcIndex].Owner);

	return 1;
}

int LuaSetNpcFindPathTime(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	DWORD dwTime = (DWORD)Lua_ValueToNumber(L, 2);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	if (dwTime != -1)
		Npc[nNpcIndex].m_uFindPathMaxTime = dwTime*20;
	else
		Npc[nNpcIndex].m_uFindPathMaxTime = -1;
//	g_DebugLog("%s %d",Npc[nNpcIndex].m_uFindPathMaxTime,nNpcIndex);
	return 0;
}

int LuaSetNpcName(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);

	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	if (Lua_IsNumber(L,2))
	{
		KTabFile Replace;
		Replace.Load(NPC_NAME_FILE);
		Replace.GetString((int)Lua_ValueToNumber(L,2)+2, "targetname","", Npc[nNpcIndex].Name, sizeof(Npc[nNpcIndex].Name));
	}
	else if (Lua_IsString(L,2))
		strcpy(Npc[nNpcIndex].Name, (char*)Lua_ValueToString(L,2));

	return 0;
}

int LuaGetNpcName(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushString(L, Npc[nNpcIndex].Name);
	return 1;
}

int LuaGetNpcID(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0 ;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return 0;

	Lua_PushNumber(L, Npc[nNpcIndex].m_dwID);
	return 1;
}

int LuaSetNpcSkill(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 4)
		return 0;

	int nNpcIdx = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIdx <= 0 || nNpcIdx >= MAX_NPC)
		return 0;
	int nSkillID = (int)Lua_ValueToNumber(L, 2);
	if (nSkillID <= 0)
		return 0;
	int nSkillLevel = (int)Lua_ValueToNumber(L, 3);
	if (nSkillLevel < 1)
		nSkillLevel = 1;
	int nSkillPos = (int)Lua_ValueToNumber(L, 4);
	if (nSkillPos < 0 || nSkillPos > MAX_NPCSKILL)
		return 0;
	Npc[nNpcIdx].m_SkillList.SetNpcSkill(nSkillPos, nSkillID, nSkillLevel);
	return 1;
}

int LuaSetNpcDropScript(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 2 ) return 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC) return 0;
	Npc[nNpcIndex].m_DropScriptID = g_FileName2Id((char *)Lua_ValueToString(L,2));
	return 0;
}

int LuaSetPlayerRevivalPos(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;
	int nParamCount = Lua_GetTopIndex(L);
	if(nParamCount < 1)
		return 0;
	int nSubWorldId = 0;
	int nRevId = 0;

	if (nParamCount > 2)
	{
		nSubWorldId = (int) Lua_ValueToNumber(L, 1);
		nRevId = (int) Lua_ValueToNumber(L, 2);
	}
	else
	{
		nRevId = (int) Lua_ValueToNumber(L, 1);
	}

	Player[nPlayerIndex].SetRevivalPos(nSubWorldId, nRevId);
	return 0;
}

int LuaGetPlayerRevivalPos(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;
	int nParamCount = Lua_GetTopIndex(L);
	if(nParamCount < 1)
		return 0;
	int nSubWorldId = 0;
	int nRevId = 0;

	if (nParamCount > 2)
	{
		nSubWorldId = (int) Lua_ValueToNumber(L, 1);
		nRevId = (int) Lua_ValueToNumber(L, 2);
	}
	else
	{
		nRevId = (int) Lua_ValueToNumber(L, 1);
	}

	POINT Pos;
	g_SubWorldSet.GetRevivalPosFromId(nSubWorldId ? nSubWorldId : SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID, nRevId, &Pos);
	Lua_PushNumber(L, nSubWorldId);
	Lua_PushNumber(L, Pos.x);
	Lua_PushNumber(L, Pos.y);
	return 3;
}

int LuaGetPlayerRevival(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
	{
		return 0;
	}

	POINT Pos;
	Player[nPlayerIndex].GetLoginRevival(&Pos);
	Lua_PushNumber(L, Pos.x);
	Lua_PushNumber(L, Pos.y);
	return 2;
}

int LuaGetPlayerRevivalID(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
	{
		return 0;
	}

	Lua_PushNumber(L, Player[nPlayerIndex].GetLoginRevivalID());
	return 1;
}
//**************************************************************************************************************************************************************
//												????????????????????????????
//**************************************************************************************************************************************************************

//**********************************************************************************************
//							?????????????????????????????
//**********************************************************************************************


#define MacroFun_GetPlayerInfoInt(L, MemberName) { int nPlayerIndex = GetPlayerIndex(L);\
	if (nPlayerIndex > 0){	int nNpcIndex = Player[nPlayerIndex].m_nIndex;	if (nNpcIndex > 0)Lua_PushNumber(L, Npc[nNpcIndex].MemberName);\
	else Lua_PushNil(L);}\
	else Lua_PushNil(L);\
return 1;}

//????????
int LuaGetPlayerCurrentCamp(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L, m_CurrentCamp);
}

int LuaGetPlayerCamp(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L, m_Camp);
}

int LuaSetPlayerCamp(Lua_State * L)
{
	int nValue = (int)Lua_ValueToNumber(L,1);
	if (nValue < 0 ) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].SetCamp(nValue);
	}
	return 0;
}

int LuaSetPlayerCurrentCamp(Lua_State * L)
{
	int nValue = (int)Lua_ValueToNumber(L,1);
	if (nValue < 0 ) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].SetCurrentCamp(nValue);
	}
	return 0;
}

int LuaSetNpcCurCamp(Lua_State * L)
{
	int nNpcIndex = (int)Lua_ValueToNumber(L,1);
	if (nNpcIndex <= 0 && nNpcIndex > MAX_NPC) return 0;
	int nValue = (int )Lua_ValueToNumber(L,2);
	if (nValue >= camp_num) return 0;
		Npc[nNpcIndex].SetCurrentCamp(nValue);
	return 0;
}

int LuaRestorePlayerCamp(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].RestoreCurrentCamp();
	}
	return 0;
}

int LuaOpenTong(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	KPhongThanScriptAction UiInfo;
	ZeroMemory(&UiInfo, sizeof(UiInfo));
	UiInfo.View = UI_OPENTONGUI;
	UiInfo.OptionCount = 0;
	UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

	int nMsgId = 0;

	UiInfo.ResourceText = 0;
	UiInfo.ContentLength = sizeof(int);

#ifndef _SERVER
	UiInfo.ServerOwned = 0;
	Player[nPlayerIndex].DoScriptAction(&UiInfo);
#else
	UiInfo.ServerOwned = 1;
	Player[nPlayerIndex].DoScriptAction(&UiInfo);
#endif
	return 0;
}

int LuaJoinTong(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0) return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	if (Npc[Player[nPlayerIndex].m_nIndex].m_Camp == camp_begin)
		return 0;

	Player[nPlayerIndex].m_cTong.JoinTong((char*)Lua_ValueToString(L, 1));
	return 0;
}


int LuaCreateTong(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0) return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
		return 0;

	if (Npc[Player[nPlayerIndex].m_nIndex].m_Camp == camp_begin)
		return 0;

	if ((int)Lua_ValueToNumber(L, 2) < camp_justice || (int)Lua_ValueToNumber(L, 2) > camp_balance)
		return 0;

	char* lpszTongName = (char*)Lua_ValueToString(L, 1);

	TONG_CREATE_SYNC	sCreate;
	sCreate.ProtocolType = s2c_createtong;
	sCreate.m_btCamp = (int)Lua_ValueToNumber(L, 2);
	if (strlen(lpszTongName) < sizeof(sCreate.m_szName))
		strcpy(sCreate.m_szName, lpszTongName);
	else
	{
		memcpy(sCreate.m_szName, lpszTongName, sizeof(sCreate.m_szName) - 1);
		sCreate.m_szName[sizeof(sCreate.m_szName) - 1] = 0;
	}
	if (g_pServer)
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sCreate, sizeof(TONG_CREATE_SYNC));

	return 0;
}

int LuaGetTongFlag(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_nFlag);
		return 1;
	}
	return 0;
}

int LuaGetTongName(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushString(L, Player[nPlayerIndex].m_cTong.m_szName);
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_dwTongNameID);
		return 2;
	}
	return 0;
}

int LuaGetTongCamp(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_nCamp);
		return 1;
	}
	return 0;
}

int LuaGetTongMemNum(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_dwMemberNum);
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_btManagerNum);
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_btDirectorNum);
		return 3;
	}
	return 0;
}

int LuaGetTongFigure(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_nFigure);
		return 1;
	}
	return 0;
}

int LuaGetTongMoney(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_dwMoney);
		return 1;
	}
	return 0;
}

int LuaGetTongLevel(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_btLevel);
		return 1;
	}
	return 0;
}

int LuaGetTongEff(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_dwTotalEff);
		return 1;
	}
	return 0;
}

int LuaGetTongParam(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_cTong.m_nTongParam);
		return 1;
	}
	return 0;
}

int LuaGetTongJoinTm(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (Lua_GetTopIndex(L) > 1)
		nPlayerIndex = (int)Lua_ValueToNumber(L, 1);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, (int)Player[nPlayerIndex].m_cTong.m_nJoinTm);
		return 1;
	}
	return 0;
}

int LuaCommendMaster(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		STONG_ACCEPT_MASTER_COMMAND	sAccept;

		sAccept.ProtocolFamily	= pf_tong;
		sAccept.ProtocolID		= enumC2S_TONG_ACCEPT_MASTER;
		sAccept.m_dwParam		= nPlayerIndex;
		sAccept.m_dwTongNameID	= g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
		sAccept.m_btFigure		= Player[nPlayerIndex].m_cTong.m_nFigure;
		sAccept.m_btPos			= 1;
		sAccept.m_btAcceptFalg = Player[nPlayerIndex].m_cTong.CheckGetMasterPower();
		memcpy(sAccept.m_szName, Npc[Player[nPlayerIndex].m_nIndex].Name, sizeof(Npc[Player[nPlayerIndex].m_nIndex].Name));

		if (g_pTongClient)
			g_pTongClient->SendPackToServer((const void*)&sAccept, sizeof(STONG_ACCEPT_MASTER_COMMAND));
	}
	return 0;
}


int LuaSetTongLevel(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_INFO_COMMAND	sLevel;
			sLevel.ProtocolID = enumC2S_CHANGE_TONG_LEVEL;
			sLevel.ProtocolFamily = pf_tong;
			sLevel.m_dwTongNameID = g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sLevel.m_dwParam = nPlayerIndex;
			sLevel.m_nValue = (int)Lua_ValueToNumber(L, 1);
			if (g_pTongClient)
				g_pTongClient->SendPackToServer((const void*)&sLevel, sizeof(STONG_CHANGE_TONG_INFO_COMMAND));
		}
	}
	return 0;
}

int LuaSetTongMoney(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_INFO_COMMAND	sMoney;
			sMoney.ProtocolID = enumC2S_CHANGE_TONG_MONEY;
			sMoney.ProtocolFamily = pf_tong;
			sMoney.m_dwTongNameID = g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sMoney.m_dwParam = nPlayerIndex;
			sMoney.m_nValue = (int)Lua_ValueToNumber(L, 1);
			if (g_pTongClient)
				g_pTongClient->SendPackToServer((const void*)&sMoney, sizeof(STONG_CHANGE_TONG_INFO_COMMAND));
		}
	}
	return 0;
}

int LuaSetTongEff(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_INFO_COMMAND	sEff;
			sEff.ProtocolID = enumC2S_CHANGE_TONG_EFF;
			sEff.ProtocolFamily = pf_tong;
			sEff.m_dwTongNameID = g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sEff.m_dwParam = nPlayerIndex;
			sEff.m_nValue = (int)Lua_ValueToNumber(L, 1);
			if (g_pTongClient)
				g_pTongClient->SendPackToServer((const void*)&sEff, sizeof(STONG_CHANGE_TONG_INFO_COMMAND));
		}
	}
	return 0;
}

int LuaSetTongMemEffLW(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_MEMBEREFF_COMMAND	sMemEff;
			sMemEff.ProtocolFamily	= pf_tong;
			sMemEff.ProtocolID		= enumC2S_CHANGE_TONG_MEMBEREFF;
			sMemEff.m_nValue1		= KSG_StringSetValue(3, Player[nPlayerIndex].m_cTong.m_nSaveEff, defTONG_EFF_LASTWEEK, (int)Lua_ValueToNumber(L, 1));
			sMemEff.m_nValue2		= 0;
			sMemEff.m_dwParam		= nPlayerIndex;
			sMemEff.m_dwTongNameID	= g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sMemEff.m_btFigure	= Player[nPlayerIndex].m_cTong.m_nFigure;
			memcpy(sMemEff.m_szName, Npc[Player[nPlayerIndex].m_nIndex].Name, sizeof(Npc[Player[nPlayerIndex].m_nIndex].Name));
			if (g_pTongClient)
					g_pTongClient->SendPackToServer((const void*)&sMemEff, sizeof(sMemEff));
		}
	}
	return 0;
}

int LuaSetTongMemEffTW(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_MEMBEREFF_COMMAND	sMemEff;
			sMemEff.ProtocolFamily	= pf_tong;
			sMemEff.ProtocolID		= enumC2S_CHANGE_TONG_MEMBEREFF;
			sMemEff.m_nValue1		= KSG_StringSetValue(3, Player[nPlayerIndex].m_cTong.m_nSaveEff, defTONG_EFF_THISWEEK, (int)Lua_ValueToNumber(L,1));
			sMemEff.m_nValue1		= KSG_StringSetValue(3, sMemEff.m_nValue1, defTONG_EFF_USEABLE,
				KSG_StringGetValue(3, Player[nPlayerIndex].m_cTong.m_nSaveEff, defTONG_EFF_USEABLE)+(int)Lua_ValueToNumber(L,1));
			sMemEff.m_nValue2		= (int)Lua_ValueToNumber(L, 1);
			sMemEff.m_dwParam		= nPlayerIndex;
			sMemEff.m_dwTongNameID	= g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sMemEff.m_btFigure	= Player[nPlayerIndex].m_cTong.m_nFigure;
			memcpy(sMemEff.m_szName, Npc[Player[nPlayerIndex].m_nIndex].Name, sizeof(Npc[Player[nPlayerIndex].m_nIndex].Name));
			if (g_pTongClient)
					g_pTongClient->SendPackToServer((const void*)&sMemEff, sizeof(sMemEff));
		}
	}
	return 0;
}

int LuaSetTongMemEffUB(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_MEMBEREFF_COMMAND	sMemEff;
			sMemEff.ProtocolFamily	= pf_tong;
			sMemEff.ProtocolID		= enumC2S_CHANGE_TONG_MEMBEREFF;
			sMemEff.m_nValue1		= KSG_StringSetValue(3, Player[nPlayerIndex].m_cTong.m_nSaveEff, defTONG_EFF_USEABLE, (int)Lua_ValueToNumber(L,1));
			sMemEff.m_nValue2		= 0;
			sMemEff.m_dwParam		= nPlayerIndex;
			sMemEff.m_dwTongNameID	= g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sMemEff.m_btFigure	= Player[nPlayerIndex].m_cTong.m_nFigure;
			memcpy(sMemEff.m_szName, Npc[Player[nPlayerIndex].m_nIndex].Name, sizeof(Npc[Player[nPlayerIndex].m_nIndex].Name));
			if (g_pTongClient)
					g_pTongClient->SendPackToServer((const void*)&sMemEff, sizeof(sMemEff));
		}
	}
	return 0;
}

int LuaGetTongMemEff(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (Lua_GetTopIndex(L) > 1)
		nPlayerIndex = (int)Lua_ValueToNumber(L, 1);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, KSG_StringGetValue(3,(int)Player[nPlayerIndex].m_cTong.m_nSaveEff,defTONG_EFF_LASTWEEK));
		Lua_PushNumber(L, KSG_StringGetValue(3,(int)Player[nPlayerIndex].m_cTong.m_nSaveEff,defTONG_EFF_THISWEEK));
		Lua_PushNumber(L, KSG_StringGetValue(3,(int)Player[nPlayerIndex].m_cTong.m_nSaveEff,defTONG_EFF_USEABLE));
		return 3;
	}
	return 0;
}

int LuaSetTongParam(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);
		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_INFO_COMMAND	TongParam;
			TongParam.ProtocolID = enumC2S_TONG_CHANGE_TONGPARAM;
			TongParam.ProtocolFamily = pf_tong;
			TongParam.m_dwTongNameID = g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			TongParam.m_dwParam = nPlayerIndex;
			TongParam.m_nValue = (int)Lua_ValueToNumber(L, 1);
			if (g_pTongClient)
				g_pTongClient->SendPackToServer((const void*)&TongParam, sizeof(STONG_CHANGE_TONG_INFO_COMMAND));
		}
	}
	return 0;
}

//????????????
int LuaGetPlayerProfessionKey(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		char szName[32];
		Player[nPlayerIndex].GetProfessionKey(szName);
		Lua_PushString(L, szName);
	}
	else
	{
		Lua_PushString(L,"");
	}
	return 1;
}

int LuaGetPlayerProfessionName(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		char szName[32];
		Player[nPlayerIndex].GetProfessionName(szName);
		Lua_PushString(L, szName);
	}
	else
	{
		Lua_PushString(L,"");
	}
	return 1;
}

int LuaGetPlayerProfessionCamp(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
		Lua_PushNumber(L, Player[nPlayerIndex].GetProfessionCamp());
	else
		Lua_PushNumber(L, -1);

	return 1;
}

int LuaGetPlayerProfession(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
		Lua_PushNumber(L, Player[nPlayerIndex].GetProfession());
	else
		Lua_PushNumber(L, -1);

	return 1;
}

int LuaSetPlayerProfession(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (nPlayerIndex > 0)
	{
		const char *pszProfession = Lua_ValueToString(L,1);
		if (pszProfession && pszProfession[0])
			nResult = Player[nPlayerIndex].SetProfession((char *)pszProfession);
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

//???????????? *************************************************************************************
//0????????????????,1??????????????????,2????????????????????
int LuaGetPlayerColdResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentColdResist);break;
		case 1:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_ColdResist); break;
		case 2:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_ColdResistMax);break;
		default:
			Lua_PushNil(L);
		}
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaSetPlayerColdResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L,2);
		if (nValue < 0) nValue = 0;
		if (nValue > Npc[Player[nPlayerIndex].m_nIndex].m_ColdResistMax) nValue = Npc[Player[nPlayerIndex].m_nIndex].m_ColdResistMax;

		int nType = (int)Lua_ValueToNumber(L,1);

		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Npc[Player[nPlayerIndex].m_nIndex].m_CurrentColdResist = nValue;
			break;

		case 1:
			Npc[Player[nPlayerIndex].m_nIndex].m_ColdResist = nValue;
			break;
		case 2:
			Npc[Player[nPlayerIndex].m_nIndex].m_ColdResistMax = nValue;
			break;
		}


	}
	return 0;

}

int LuaGetPlayerFireResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentFireResist);break;
		case 1:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_FireResist); break;
		case 2:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_FireResistMax);break;
		default:
			Lua_PushNil(L);
		}
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaSetPlayerFireResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L,2);
		if (nValue < 0) nValue = 0;
		if (nValue > Npc[Player[nPlayerIndex].m_nIndex].m_FireResistMax)
			nValue = Npc[Player[nPlayerIndex].m_nIndex].m_FireResistMax;

		int nType = (int)Lua_ValueToNumber(L,1);

		switch(nType)
		{
		case 0:
			Npc[Player[nPlayerIndex].m_nIndex].m_CurrentFireResist = nValue;
			break;

		case 1:
			Npc[Player[nPlayerIndex].m_nIndex].m_FireResist = nValue;
			break;
		case 2:
			Npc[Player[nPlayerIndex].m_nIndex].m_FireResistMax = nValue;
			break;
		}
	}
	return 0;
}


int LuaGetPlayerLightResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentLightResist);break;
		case 1:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_LightResist); break;
		case 2:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_LightResistMax);break;
		default:
			Lua_PushNil(L);
		}
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaSetPlayerLightResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		int nValue = (int)Lua_ValueToNumber(L,2);
		if (nValue < 0) nValue = 0;
		if (nValue > Npc[Player[nPlayerIndex].m_nIndex].m_LightResistMax) nValue = Npc[Player[nPlayerIndex].m_nIndex].m_LightResistMax;

		int nType = (int)Lua_ValueToNumber(L,1);

		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Npc[Player[nPlayerIndex].m_nIndex].m_CurrentLightResist = nValue;
			break;

		case 1:
			Npc[Player[nPlayerIndex].m_nIndex].m_LightResist = nValue;
			break;
		case 2:
			Npc[Player[nPlayerIndex].m_nIndex].m_LightResistMax = nValue;
			break;
		}
	}
	else
		Lua_PushNil(L);
	return 0;
}


int LuaGetPlayerPoisonResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentPoisonResist);break;
		case 1:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResist); break;
		case 2:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResistMax);break;
		default:
			Lua_PushNil(L);
		}
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaSetPlayerPoisonResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		{
			int nValue = (int)Lua_ValueToNumber(L,2);
            if (nValue < 0) nValue = 0;
            if (nValue > Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResistMax) nValue = Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResistMax;

            int nType = (int)Lua_ValueToNumber(L,1);

			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Npc[Player[nPlayerIndex].m_nIndex].m_CurrentPoisonResist = nValue;
				break;

			case 1:
				Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResist = nValue;
                break;
			case 2:
				Npc[Player[nPlayerIndex].m_nIndex].m_PoisonResistMax = nValue;
                break;
			}
		}

	}


	return 0;

}

int LuaGetPlayerPhysicsResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		{
			int nType = (int)Lua_ValueToNumber(L,1);
			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentPhysicsResist);break;
			case 1:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResist); break;
			case 2:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResistMax);break;
			default:
				Lua_PushNil(L);
			}
		}

	}
	else
		Lua_PushNil(L);
	return 1;
}



int LuaSetPlayerPhysicsResist(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		{
			int nValue = (int)Lua_ValueToNumber(L,2);
            if (nValue < 0) nValue = 0;
            if (nValue > Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResistMax) nValue = Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResistMax;

            int nType = (int)Lua_ValueToNumber(L,1);

			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Npc[Player[nPlayerIndex].m_nIndex].m_CurrentPhysicsResist = nValue;
				break;

			case 1:
				Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResist = nValue;
                break;
			case 2:
				Npc[Player[nPlayerIndex].m_nIndex].m_PhysicsResistMax = nValue;
                break;
			}
		}

	}
	return 0;

}

int LuaGetNextExp(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nNextLevelExp);
	}
	else
		Lua_PushNil(L);
	return 1;
}

//??????????????*********************************************************************
int LuaGetPlayerExp(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nExp);
	}
	else
		Lua_PushNil(L);
	return 1;
}

//TamLTM Get luyen Exp X2 skill
int LuaGetNpcExpSkillsRate(Lua_State * L)//TamLTM expskills x2
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
	{
		Lua_PushNumber(L,0);
		return 0;
	}
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentExpSkillsEnchance);
	return 1;
}
//Set false
/*int LuaSetExpSkill(Lua_State* L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].SetExpX1Skill();
	//	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].SetExpX1Skill();)
	}
	else
		Lua_PushNil(L); //
	return 1;
}
//end code */

//AddExp(200,10,0)
int LuaModifyPlayerExp(Lua_State * L)
{
	int bAllTeamGet = 0;
	if (Lua_GetTopIndex(L) >= 3)
		bAllTeamGet = (int)Lua_ValueToNumber(L,3);

	DWORD nDValue = (DWORD)Lua_ValueToNumber(L,1);
	DWORD nTarLevel = (DWORD)Lua_ValueToNumber(L,2);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if (bAllTeamGet)
			Player[nPlayerIndex].AddExp(nDValue, nTarLevel);
		else
			Player[nPlayerIndex].AddSelfExp(nDValue, nTarLevel);
	}
	return 0;
}

int LuaAddOwnExp(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <=0 ) return 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nExp = (int)Lua_ValueToNumber(L,1);
		if(nExp < MAX_INT)
			Player[nPlayerIndex].DirectAddExp(nExp);
	}
	return 0;
}

int LuaAddStackExp(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1 )
        return 0;
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
        return 0;

    int nExp = (DWORD)Lua_ValueToNumber(L,1);
    if (nExp > 0)
    {
        while (nExp > 0)
        {
            int nExpAdd = Player[nPlayerIndex].m_nNextLevelExp - Player[nPlayerIndex].m_nExp;
            if (nExp >= nExpAdd)
            {
                nExp = nExp - nExpAdd;
            }
            else
            {
                nExpAdd = nExp;
                nExp = 0;
            }
            Player[nPlayerIndex].DirectAddExp(nExpAdd);
        }
    }
    return 0;
}


int LuaGetPlayerLevel(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_Level);
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaGetPlayerLife(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		{
			int nType = (int)Lua_ValueToNumber(L,1);
			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentLife);break;
			case 1:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentLifeMax); break;
			case 2:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_LifeMax);break;
			default:
				Lua_PushNil(L);
			}
		}

	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaRestorePlayerLife(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].RestoreLife();
	}
	return 0;
}

int LuaRestorePlayerMana(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].RestoreMana();
	}
	return 0;
}

int LuaRestorePlayerStamina(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].RestoreStamina();
	}
	return 0;
}

int LuaGetPlayerLifeReplenish(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt( L, m_LifeReplenish);
}


int LuaGetPlayerMana(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		{
			int nType = (int)Lua_ValueToNumber(L,1);
			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentMana);break;
			case 1:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_ManaMax); break;
			case 2:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_ManaMax);break;
			default:
				Lua_PushNil(L);
			}
		}

	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaGetPlayerStamina(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		{
			int nType = (int)Lua_ValueToNumber(L,1);
			switch((int)Lua_ValueToNumber(L,1))
			{
			case 0:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentStamina);break;
			case 1:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_StaminaMax); break;
			case 2:
				Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_StaminaMax);break;
			default:
				Lua_PushNil(L);
			}
		}

	}
	else
		Lua_PushNil(L);
	return 1;
}


int LuaGetPlayerManaReplenish(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L , m_ManaReplenish);
}

int LuaGetPlayerDefend(Lua_State * L)
{
    MacroFun_GetPlayerInfoInt(L , m_Defend);
}

int LuaGetPlayerSex(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L , m_nSex);
}

int LuaGetPlayerIndex(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L , GetPlayerIdx());
	return 0;
}


int LuaGetPlayerNpcIdx(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	int nIndex = nPlayerIndex;
	if (nPlayerIndex > 0)
	{
		if (Lua_GetTopIndex(L) > 1)
			nIndex = (int)Lua_ValueToNumber(L, 1);
        Lua_PushNumber(L, Player[nIndex].m_nIndex);
	}
	else
		Lua_PushNil(L);
	return 1;
}

int LuaGetPlayerAccount(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	int nIndex = nPlayerIndex;
	if (nPlayerIndex > 0)
	{
		if (Lua_GetTopIndex(L) > 1)
			nIndex = (int)Lua_ValueToNumber(L, 1);
        Lua_PushString(L, Player[nIndex].AccountName);
	}
	else
		Lua_PushNil(L);

	return 1;

}
//anti 1 acc tong kim PC Name
int	LuaGetKeyPc(Lua_State * L)
{
//	char nPlayerIndex = GetPlayerIndex(L);
//	int nIndex = nPlayerIndex;

	//Get user computer
	// TCHAR compUser[UNLEN+1];
	// DWORD compUser_len=UNLEN+1;
		// GetUserName((TCHAR*)compUser,&compUser_len);
		// printf("compUser: %s ",compUser);

/*	//Get computer Name
	TCHAR compname[UNLEN+1];
	DWORD compname_len=UNLEN+1;
	if (nPlayerIndex > 0)
	{
		GetComputerName((TCHAR*)compname,&compname_len);
		if (Lua_GetTopIndex(L) > 1)
			nIndex = (int)Lua_ValueToNumber(L, 1);
        Lua_PushString(L,compname);
	}
	else
		Lua_PushNil(L);
	return 1;*/

	//TamLTM Get PC Name
	int nResult = 0;
	int nPlayerIndex = 0;
	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getpcname;

	nResult = Player[nPlayerIndex].GetMacSQL();

	lab_getpcname:
	Lua_PushNumber(L, nResult);
	return 1;
	//end code
}

//TamLTM Update version game
int	LuaGetVersionUpdateGame(Lua_State * L)
{
	int nResult = 0;
	int nPlayerIndex = 0;
	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getversiongame;

	nResult = Player[nPlayerIndex].GetVersionGame();

	lab_getversiongame:
	Lua_PushNumber(L, nResult);
	return 1;
}
//end code

//TamLTM call fix lag posu
int LuaSetPosU(Lua_State* L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2) return 0;
	int nPlayerIndex = GetPlayerIndex(L);

	int nX = (int)Lua_ValueToNumber(L, 1);
	int nY = (int)Lua_ValueToNumber(L, 2);

	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].SetPosU(nX * 32, nY * 32);
	}
	return 0;
}
//end code

int LuaGetPlayerSeries(Lua_State * L)
{
	MacroFun_GetPlayerInfoInt(L , m_Series);
}

int LuaSetPlayerSeries(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L,1);
		Npc[Player[nPlayerIndex].m_nIndex].SetSeries(nValue);
	}
	return 0;

}

int LuaGetPlayerCount(Lua_State * L)
{
	Lua_PushNumber(L, PlayerSet.GetPlayerNumber());
	return 1;
}

int LuaGetNpcCount(Lua_State * L)
{
	Lua_PushNumber(L, NpcSet.GetNpcNumber());
	return 1;
}

int LuaGetTotalItem(Lua_State * L)
{
	Lua_PushNumber(L, ItemSet.GetItemNumber());
	return 1;
}

int LuaGetPlayerName(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	int nIndex = nPlayerIndex;
	if (nPlayerIndex > 0)
	{
		if (Lua_GetTopIndex(L) > 1)
			nIndex = (int)Lua_ValueToNumber(L, 1);
        Lua_PushString(L, Player[nIndex].Name);
	}
	else
		Lua_PushNil(L);

	return 1;

}

int LuaGetPlayerID(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nParamNum >= 1 && Lua_IsNumber(L, 1))
		nPlayerIndex = (int)Lua_ValueToNumber(L, 1);
	if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER && Player[nPlayerIndex].m_nIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_dwID);
	}
	else
		Lua_PushNil(L);

	return 1;
}

int LuaGetMateName(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	Lua_PushString(L, Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME));
	return 1;
}

int LuaFindPlayer(Lua_State * L)
{
	int nIndex = 0;
	if (Lua_IsNumber(L, 1))
	{
		DWORD dwID = (DWORD)Lua_ValueToNumber(L,1);
		nIndex = NpcSet.SearchUUID(dwID);
	}
	else if (Lua_IsString(L, 1))
	{
		const char*	pszName = (const char*)Lua_ValueToString(L,1);
		nIndex = PlayerSet.GetFirstPlayer();
		while(nIndex > 0)
		{
			if (strcmp(Player[nIndex].Name, pszName) == 0)
				break;

			nIndex = PlayerSet.GetNextPlayer();
		}
	}
	Lua_PushNumber(L, nIndex);
	return 1;
}

int LuaFindNamePlayer(Lua_State* L)
{
	if (Lua_GetTopIndex(L) > 2)
		return 0;

	const char* szName = (const char*)Lua_ValueToString(L, 1);

	int nPlayerIndex = PlayerSet.GetFirstPlayer();

	while (nPlayerIndex > 0)
	{
		if (strcmp(Player[nPlayerIndex].Name, szName) == 0)
			break;

		nPlayerIndex = PlayerSet.GetNextPlayer();
	}

	if (nPlayerIndex > 0 && Player[nPlayerIndex].m_nNetConnectIdx >= 0)
	{
		Lua_PushNumber(L, nPlayerIndex);
	}
	else
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	return 1;
}

int LuaFindNearNpc(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nIndex = 0;
		if (Lua_IsNumber(L,1))
			nIndex = Player[nPlayerIndex].FindNearNpc((int)Lua_ValueToNumber(L,1),
				Lua_GetTopIndex(L) > 2?(int)Lua_ValueToNumber(L,2):0);
		else if (Lua_IsString(L,1))
			nIndex = Player[nPlayerIndex].FindNearNpc((char*)Lua_ValueToString(L,1),
				Lua_GetTopIndex(L) > 2?(int)Lua_ValueToNumber(L,2):0);
		Lua_PushNumber(L, nIndex);
		return 1;
	}
	return 0;
}

int LuaFindAroundNpc(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if (Lua_IsNumber(L, 1))
		{
			int nIndex = Player[nPlayerIndex].FindAroundNpc((DWORD)Lua_ValueToNumber(L,1));
            g_DebugLog("son debug nIdex Find %d", nIndex);
			Lua_PushNumber(L, nIndex);
			return 1;
		}
		else
			Lua_PushNil(L);
	}
	return 0;
}

int LuaGetPlayerLeadExp(Lua_State * L)
{

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nLeadExp);
	}
	else
		Lua_PushNil(L);

	return 1;
}

int LuaGetPlayerLeadLevel(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nLeadLevel);
	}
	else
		Lua_PushNil(L);

	return 1;
}



int LuaGetPlayerRestAttributePoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nAttributePoint);
	}
	else
		Lua_PushNil(L);

	return 1;
}

int LuaGetPlayerRestSkillPoint(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
        Lua_PushNumber(L, Player[nPlayerIndex].m_nSkillPoint);
	}
	else
		Lua_PushNil(L);

	return 1;
}

/*
int LuaModifyPlayerRestSkillPoint(Lua_State *L)
{
//Question
int nPlayerIndex = GetPlayerIndex(L);
if (nPlayerIndex > 0)
{
int nDValue = (int)Lua_ValueToNumber(L, 1);

  int nNewSkillPoint = Player[nPlayerIndex].m_nSkillPoint + nDValue;
  if (nNewSkillPoint < 0 ) return 0;

	Player[nPlayerIndex].m_nSkillPoint = nNewSkillPoint;
	}

	  return 0;
	  }
*/

//????????????????????????
int LuaGetPlayerLucky(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurrentLucky);
			break;
		case 1:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nLucky);
			break;
		case 2:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nLucky);
			break;
		default:
			Lua_PushNil(L);
		}

	}
	return 1;
}

int LuaGetPlayerEngergy(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nCurEngergy);break;
		case 1:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nEngergy);break;
		case 2:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nEngergy);break;
		default:
			Lua_PushNil(L);
		}
	}

	return 1;
}

int LuaResetBaseAttribute(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	int nParamCount = 0;
	if ( (nParamCount = Lua_GetTopIndex(L)) < 2) return 0;

	if (nPlayerIndex > 0)
	{
		Player[nPlayerIndex].ResetBaseAttribute((int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2));
	}
	return 1;
}

int LuaResetProp(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	int nResult = 0;
	if (nPlayerIndex > 0)
		nResult = Player[nPlayerIndex].ResetProp();

	Lua_PushNumber(L, nResult);
	return 1;

}

int LuaSetPlayerEngergy(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L, 1);
		if (nValue < 0 && Player[nPlayerIndex].m_nEngergy - nValue <= 0)
			nValue = 0;
		Player[nPlayerIndex].m_nAttributePoint -= nValue;
		Player[nPlayerIndex].SetBaseEngergy(nValue);
	}
	return 1;
}

int LuaGetPlayerDexterity(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nCurDexterity);break;
		case 1:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nDexterity);break;
		case 2:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nDexterity);break;
		default:
			Lua_PushNil(L);
		}

	}
	return 1;
}

int LuaSetPlayerDexterity(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L, 1);
		if (nValue < 0 && Player[nPlayerIndex].m_nDexterity - nValue <= 0)
			nValue = 0;
		Player[nPlayerIndex].m_nAttributePoint -= nValue;
		Player[nPlayerIndex].SetBaseDexterity(nValue);
	}
	return 1;
}

int LuaGetPlayerStrength(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nCurStrength);break;
		case 1:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nStrength);break;
		case 2:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nStrength);break;
		default:
			Lua_PushNil(L);
		}

	}
	return 1;

}

int LuaSetPlayerStrength(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L, 1);
		if (nValue < 0 && Player[nPlayerIndex].m_nStrength - nValue <= 0)
			nValue = 0;
		Player[nPlayerIndex].m_nAttributePoint -= nValue;
		Player[nPlayerIndex].SetBaseStrength(nValue);
	}
	return 1;
}

int LuaGetPlayerVitality(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{

		int nType = (int)Lua_ValueToNumber(L,1);
		switch((int)Lua_ValueToNumber(L,1))
		{
		case 0:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nCurVitality);break;
		case 1:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nVitality);break;
		case 2:
			Lua_PushNumber(L, Player[nPlayerIndex].m_nVitality);break;
		default:
			Lua_PushNil(L);
		}

	}
	return 1;

}

int LuaSetPlayerVitality(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;
    int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nValue = (int)Lua_ValueToNumber(L, 1);
		if (nValue < 0 && Player[nPlayerIndex].m_nVitality - nValue <= 0)
			nValue = 0;
		Player[nPlayerIndex].m_nAttributePoint -= nValue;
		Player[nPlayerIndex].SetBaseVitality(nValue);
	}
	return 1;
}

int LuaGetPlayerCashMoney(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);

    if (nPlayerIndex > 0)
	{
		if(Lua_GetTopIndex(L) > 1)
		{
			int nType = (int)Lua_ValueToNumber(L,1);
			if(nType == 1)
				Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.GetMoney(room_repository));
			else if(nType == 2)
				Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.GetMoney(room_equipment)+Player[nPlayerIndex].m_ItemList.GetMoney(room_repository));
		}
		else
			Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.GetMoney(room_equipment));
	}
	else Lua_PushNumber(L,0);

	return 1;
}

int LuaPlayerPayMoney(Lua_State * L)
{

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
	{
        int nMoney = (int)Lua_ValueToNumber(L, 1);
        if (nMoney <= 0) return 0;
		if(Lua_GetTopIndex(L) > 2)
		{
			int nType = (int)Lua_ValueToNumber(L,2);
			if(nType == 1)
				Player[nPlayerIndex].m_ItemList.AddMoney(room_repository, -nMoney);
			else if(nType == 2)
			{
				int nLMoney = nMoney - Player[nPlayerIndex].m_ItemList.GetMoney(room_equipment);
				if(nLMoney > 0)
				{
					Player[nPlayerIndex].m_ItemList.AddMoney(room_repository, Player[nPlayerIndex].m_ItemList.GetMoney(room_equipment));
					Player[nPlayerIndex].m_ItemList.AddMoney(room_equipment, -nLMoney);
				}
				else
					Player[nPlayerIndex].m_ItemList.AddMoney(room_repository, nMoney);
			}
			Lua_PushNumber(L, 1);
		}
		else
		{
			if (Player[nPlayerIndex].Pay(nMoney))
				Lua_PushNumber(L, 1);
			else
				Lua_PushNumber(L, 0);
		}
	}
	else
		Lua_PushNumber(L, 0);

	return 1;
}

int LuaPlayerEarnMoney (Lua_State  *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
	{
        int nMoney = (int)Lua_ValueToNumber(L, 1);
        if (nMoney <= 0) return 0;
        Player[nPlayerIndex].Earn(nMoney);
	}
	return 0;
}

int LuaPlayerPrePayMoney(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0)
	{
        int nMoney = (int)Lua_ValueToNumber(L, 1);
        if (nMoney <= 0) return 0;
        if (Player[nPlayerIndex].PrePay(nMoney))
			Lua_PushNumber(L, 1);
		else
			Lua_PushNumber(L, 0);
	}
	else
		Lua_PushNumber(L, 0);

	return 1;
}

int LuaGetPlayerFortune(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);

    if (nPlayerIndex > 0)
	{
		Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.GetPlayerFortune());
	}
	else Lua_PushNumber(L,0);

	return 1;
}

//Attack dwID, Damage
int LuaAttackNpc(Lua_State * L)
{
	int nParamCount = 0;
	if ( (nParamCount = Lua_GetTopIndex(L)) < 2) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	DWORD nNpcID = (DWORD)Lua_ValueToNumber(L,1);
	int nNpcIndex = Player[nPlayerIndex].FindAroundNpc(nNpcID);//NpcSet.SearchID(nNpcID);
	if (nNpcIndex <= 0) return 0;

	KMagicAttrib DamageMagicAttribs[MAX_MISSLE_DAMAGEATTRIB];
	memset(DamageMagicAttribs, 0, sizeof(DamageMagicAttribs));

	DamageMagicAttribs[0].nAttribType = magic_attackrating_v;
	DamageMagicAttribs[0].nValue[0] = Npc[nNpcIndex].m_CurrentLife;

	DamageMagicAttribs[1].nAttribType = magic_ignoredefense_p;
	DamageMagicAttribs[1].nValue[0] = 1;

	for (int i = 0; i < nParamCount - 1; i++)
	{
		int nVlau = (int)Lua_ValueToNumber(L, 2 + i);
		DamageMagicAttribs[i + 2].nValue[0] = (int)Lua_ValueToNumber(L, 2 + i);
		DamageMagicAttribs[i + 2].nValue[2] = (int)Lua_ValueToNumber(L, 2 + i);
	}

	Npc[nNpcIndex].ReceiveDamage(Player[nPlayerIndex].m_nIndex, -1, 0, DamageMagicAttribs, 0, 1, 0);
	return 0;
}

int LuaSetPlayerChatForbiddenFlag(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;
	int nFlag = Lua_ValueToNumber(L, 1);
	Player[nPlayerIndex].SetChatForbiddenTm(nFlag);
	return 0;
}

// SetRoleChatFlag(roleName,flag)
int LuaSetRoleChatFlag(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);

	if ( nParamCount < 1)
		return 0;

	const char*	pszName = (const char*)Lua_ValueToString(L, 1);
	int nIndex = PlayerSet.GetFirstPlayer();
	while(nIndex > 0)
	{
		if (strcmp(Player[nIndex].Name, pszName) == 0)
			break;

		nIndex = PlayerSet.GetNextPlayer();
	}


	if (nIndex && Player[nIndex].m_nNetConnectIdx >= 0)
	{
		int nFlag;
		if ( nParamCount >=2 )
		{
			nFlag = (int) Lua_ValueToNumber(L, 2);
		}
		else
			nFlag=1;
		Player[nIndex ].SetChatForbiddenTm(nFlag);
	}
	return 0;
}

//ShutDownServer bIsSavePlayer
int LuaShutDownServer(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);

	g_ReleaseCore();

	return 0;
}

int LuaKickOutPlayer(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	const char*	pszName = (const char*)Lua_ValueToString(L, 1);

	int nIndex = PlayerSet.GetFirstPlayer();
	while(nIndex > 0)
	{
		if (strcmp(Player[nIndex].Name, pszName) == 0)
			break;

		nIndex = PlayerSet.GetNextPlayer();
	}
	if (nIndex && Player[nIndex].m_nNetConnectIdx >= 0)
	{
		printf("GM Kick out specific player.\n");
		g_pServer->ShutdownClient(Player[nIndex].m_nNetConnectIdx);
	}
	return 0;
}

int LuaKickOutAccount(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	const char*	pszName = (const char*)Lua_ValueToString(L, 1);

	int nIndex = PlayerSet.GetFirstPlayer();
	while(nIndex > 0)
	{
		if (strcmpi(Player[nIndex].AccountName, pszName) == 0)
			break;

		nIndex = PlayerSet.GetNextPlayer();
	}
	if (nIndex && Player[nIndex].m_nNetConnectIdx >= 0)
		g_pServer->ShutdownClient(Player[nIndex].m_nNetConnectIdx);

	return 0;
}

int LuaKickOutSelf(Lua_State *L)
{
	int nIndex = GetPlayerIndex(L);

	if (nIndex <= 0)
		return 0;

	if (Player[nIndex].m_nNetConnectIdx >= 0)
		g_pServer->ShutdownClient(Player[nIndex].m_nNetConnectIdx);
	return 0;
}

int LuaKillNpc(Lua_State * L)
{
	int nParamCount = 0;
	if ( (nParamCount = Lua_GetTopIndex(L)) < 1) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	DWORD nNpcID = (DWORD)Lua_ValueToNumber(L,1);
	int nNpcIndex = Player[nPlayerIndex].FindAroundNpc(nNpcID);
	if (nNpcIndex <= 0) return 0;
	KMagicAttrib DamageMagicAttribs[MAX_MISSLE_DAMAGEATTRIB];
	memset(DamageMagicAttribs, 0, sizeof(DamageMagicAttribs));
	DamageMagicAttribs[9].nAttribType = magic_physicsdamage_v;
	DamageMagicAttribs[9].nValue[0] = 100000;
	DamageMagicAttribs[9].nValue[2] = 100000;
	Npc[nNpcIndex].ReceiveDamage(Player[nPlayerIndex].m_nIndex, -1, 0, DamageMagicAttribs, 0, 1, 0);
	return 0;
}

int LuaKillPlayer(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	KMagicAttrib DamageMagicAttribs[MAX_MISSLE_DAMAGEATTRIB];
	memset(DamageMagicAttribs, 0, sizeof(DamageMagicAttribs));
	DamageMagicAttribs[9].nAttribType = magic_physicsdamage_v;
	DamageMagicAttribs[9].nValue[0] = 100000;
	DamageMagicAttribs[9].nValue[2] = 100000;
	Npc[Player[nPlayerIndex].m_nIndex].ReceiveDamage(Player[nPlayerIndex].m_nIndex, -1, 0, DamageMagicAttribs, 0, 1, 0);
	return 0;
}

int LuaSetFightState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	Npc[Player[nPlayerIndex].m_nIndex].SetFightMode(Lua_ValueToNumber(L,1) != 0);
	return 0;
}

int LuaGetFightState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_FightMode);
	return 1;
}

int LuaSetLevel(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 0;
	}

	if (Lua_IsNumber(L,1))
	{
		int nValue = (int)Lua_ValueToNumber(L, 1);
		Player[nPlayerIndex].SetLevel(nValue);
		Lua_PushNumber(L,1);
	}
	else
		Lua_PushNumber(L,0);

	return 1;
}


int LuaGetLevel(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)		Lua_PushNumber(L,0);

	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	Lua_PushNumber(L, Npc[Player[nPlayerIndex].m_nIndex].m_Level);
	return 1;
}
//
int	LuaUseTownPortal(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	int nResult = Player[nPlayerIndex].UseTownPortal();
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaReturnFromTownPortal(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	if (Player[nPlayerIndex].BackToTownPortal())
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}
#endif

#include "PhongThanQuestLuaContext.inl"

int GetObjIndex(Lua_State * L)
{
    Lua_GetGlobal(L, SCRIPT_OBJINDEX);
    if (lua_isnil(L,Lua_GetTopIndex(L)))
        return -1;
    int nIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));
    if (nIndex >= MAX_OBJECT || nIndex <= 0)
    {
        _ASSERT(0);
        return -1;
    }
    if (Object[nIndex].m_nIndex != nIndex)
    {
        _ASSERT(0);
        return -1;
    }
    return nIndex;
}




int  LuaMessage(Lua_State * L)
{
    const char * szString;
    szString  = lua_tostring (L,1);
    g_DebugLog((char *)szString);
    return 0;
}
#ifdef _SERVER
//AddStation(N)
int LuaAddPlayerWayPoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nWayPoint = (int)Lua_ValueToNumber(L,1);
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	{
		KIndexNode * pNode = (KIndexNode*) Player[nPlayerIndex].m_PlayerWayPointList.GetHead();
		while(pNode)
		{
			if (pNode->m_nIndex == nWayPoint) return 0;
			pNode = (KIndexNode*)pNode->GetNext();
		}

		KIndexNode * pNewNode = new KIndexNode;
		pNewNode->m_nIndex = nWayPoint;
		int nCount = Player[nPlayerIndex].m_PlayerWayPointList.GetNodeCount();
		for (int i = 0; i < nCount - 2; i ++ )
		{
			KIndexNode *  pDelNode = (KIndexNode*)Player[nPlayerIndex].m_PlayerWayPointList.RemoveHead();
			delete pDelNode;
		}
		Player[nPlayerIndex].m_PlayerWayPointList.AddTail(pNewNode);
	}
	return 0;
}

int LuaAddPlayerStation(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nStation = (int )Lua_ValueToNumber(L,1);
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	{
		KIndexNode * pNode = (KIndexNode*) Player[nPlayerIndex].m_PlayerStationList.GetHead();
		while(pNode)
		{
			if (pNode->m_nIndex == nStation) return 0;
			pNode = (KIndexNode*)pNode->GetNext();
		}

		KIndexNode * pNewNode = new KIndexNode;
		pNewNode->m_nIndex = nStation;
		Player[nPlayerIndex].m_PlayerStationList.AddTail(pNewNode);
	}
	return 0;
}

int LuaGetPlayerStationCount(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	Lua_PushNumber(L, Player[nPlayerIndex].m_PlayerStationList.GetNodeCount());
	return 1;
}

//????????????????????????????????????????????????????????????n??????????????????????????????????????????????????
int LuaGetPlayerStation(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}

	int nStationId = 0;
	KIndexNode * pNode = 	(KIndexNode*)Player[nPlayerIndex].m_PlayerStationList.GetHead();
	if (pNode)
	{
		int nNo = (int )Lua_ValueToNumber(L, 1);
		int nCurStation = (int) Lua_ValueToNumber(L,2);
		int nVisitNo = 0;
		while(pNode)
		{
			if (pNode->m_nIndex != nCurStation && g_GetPriceToStation( nCurStation , pNode->m_nIndex) > 0)
			{
				nVisitNo ++;
				if (nVisitNo == nNo)
				{
					nStationId = pNode->m_nIndex;
					break;
				}
			}
			pNode = (KIndexNode*)pNode->GetNext();
		}
	}

	Lua_PushNumber(L, nStationId);

	return 1;
}

int LuaGetPlayerWayPoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	KIndexNode * pNode = (KIndexNode*)	Player[nPlayerIndex].m_PlayerWayPointList.GetHead();
	if (pNode)
	{
		int nNo = (int)Lua_ValueToNumber(L, 1);
		if (nNo > TASKVALUE_MAXWAYPOINT_COUNT)
			Lua_PushNumber(L, 0);
		else
		{
			for (int i = 0; i < nNo - 1; i ++)
			{
				if (pNode == NULL ) break;
				pNode = (KIndexNode *)pNode->GetNext();
			}

			if (pNode)
				Lua_PushNumber(L, pNode->m_nIndex);
			else
				Lua_PushNumber(L, 0);

		}
	}
	else
		Lua_PushNumber(L, 0);

	return 1;
}
//???????????????????????????????????id???????????????????????????
int LuaGetStationName(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	if (Lua_GetTopIndex(L) <= 0 )
	{
		Lua_PushString(L, "");
		return 1;
	}
	int nStationId = (int)Lua_ValueToNumber(L,1);
	char szName[50];
	g_StationTabFile.GetString(nStationId + 1, "DESC", NORMAL_UNCLEAR_WORD,  szName, 50 );
	Lua_PushString(L, szName);
	return 1;
}

int LuaGetWayPointName(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	if (Lua_GetTopIndex(L) <= 0 )
	{
		Lua_PushString(L, "");
		return 1;
	}
	int nWayPointId = (int)Lua_ValueToNumber(L,1);
	char szName[50];
	g_WayPointTabFile.GetString(nWayPointId + 1, "DESC", NORMAL_UNCLEAR_WORD,  szName, 50 );
	Lua_PushString(L, szName);
	return 1;
}

//GetCityCount
int LuaGetAllStationCount(Lua_State * L)
{
	int nCityCount = g_StationTabFile.GetHeight() - 1;
	if (nCityCount < 0) nCityCount = 0;
	Lua_PushNumber(L,nCityCount);
	return 1;
}

//cityid, price = GetCity(citynum, curcity)
int LuaGetCity(Lua_State * L)
{
	return 0;
}


int LuaGetPriceToWayPoint(Lua_State *L)
{

	int nCurStation = (int)Lua_ValueToNumber(L,1);
	int nDesWayPoint = (int)Lua_ValueToNumber(L,2);
	Lua_PushNumber(L, g_GetPriceToWayPoint(nCurStation, nDesWayPoint));
	return 1;
}

int LuaGetPriceToStation(Lua_State *L)
{
	int nCurStation	 = (int)Lua_ValueToNumber(L,1);
	int nNextStation = (int)Lua_ValueToNumber(L,2);
	Lua_PushNumber(L, g_GetPriceToStation(nCurStation, nNextStation));
	return 1;
}

int LuaGetStationPos(Lua_State * L)
{
	int nStationId = (int)Lua_ValueToNumber(L,1);
	char szPos[100] ;
	int nCount = 0;
	int nRow = g_StationTabFile.FindColumn("COUNT");
	g_StationTabFile.GetInteger(nStationId + 1, nRow,  0, &nCount);
	if (nCount <= 0) return 0;
	int nRandSect = g_Random(100) % nCount + 1;
	char szSectName[32];
	sprintf(szSectName, "SECT%d", nRandSect);
	char szValue[100];
	nRow = g_StationTabFile.FindColumn(szSectName);
	g_StationTabFile.GetString(nStationId + 1, nRow, "0,0,0", szValue, 100);

    int nX, nY, nWorld;
    const char *pcszTemp = szValue;

    nWorld = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nX = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nY = KSG_StringGetInt(&pcszTemp, 0);
	//sscanf(szValue, "%d,%d,%d", &nWorld, &nX, &nY);

    Lua_PushNumber(L,nWorld);
	Lua_PushNumber(L,nX);
	Lua_PushNumber(L,nY);
	return 3;
}

int LuaGetWayPointPos(Lua_State * L)
{
	int nWayPointId = (int)Lua_ValueToNumber(L,1);
	char szPos[100] ;
	int nCount = 0;
	char szValue[30];
	int nRow;
	nRow = g_WayPointTabFile.FindColumn("SECT");
	g_WayPointTabFile.GetString(nWayPointId + 1, nRow, "0,0,0", szValue, 30);
	int nX, nY, nWorld;
    const char *pcszTemp = szValue;

    nWorld = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nX = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nY = KSG_StringGetInt(&pcszTemp, 0);
	//sscanf(szValue, "%d,%d,%d", &nWorld, &nX, &nY);

	Lua_PushNumber(L,nWorld);
	Lua_PushNumber(L,nX);
	Lua_PushNumber(L,nY);
	return 3;
}

int LuaGetWayPointFight(Lua_State * L)
{
	int nWayPointId = (int)Lua_ValueToNumber(L,1);
	int nFight;
	int nRow;
	nRow = g_WayPointTabFile.FindColumn("FightState");
	g_WayPointTabFile.GetInteger(nWayPointId + 1, nRow, 0, &nFight);

	Lua_PushNumber(L,nFight);
	return 1;
}

int LuaGetRank(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Lua_PushNumber(L,Npc[Player[nPlayerIndex].m_nIndex].m_RankID);
	return 1;
}

int LuaSetRank(Lua_State * L)
{
	BYTE nRankID = (BYTE)Lua_ValueToNumber(L,1);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Npc[Player[nPlayerIndex].m_nIndex].m_RankID = nRankID;
	return 1;
}

int LuaGetExpandRank(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Lua_PushString(L, Npc[Player[nPlayerIndex].m_nIndex].m_CurExpandRank.szName);
	return 1;
}

int LuaSetExpandRank(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	KExpandRank tmp;
	tmp.Release();

	strcpy(tmp.szName, (char*)Lua_ValueToString(L,1));
	if (nParamNum > 2)
		tmp.dwColor = TGetColor((char*)Lua_ValueToString(L,2));
	if (nParamNum > 3)
		tmp.nStateGraphics = (int)Lua_ValueToNumber(L,3);
	if (nParamNum > 4)
		tmp.dwLeftTime = (DWORD)Lua_ValueToNumber(L,4);

	Npc[Player[nPlayerIndex].m_nIndex].SetExpandRank(&tmp);
	return 1;
}

int LuaRestoreExpandRank(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	Npc[Player[nPlayerIndex].m_nIndex].SetExpandRank(&Npc[Player[nPlayerIndex].m_nIndex].m_ExpandRank);
	return 1;
}

int LuaGetEquipItemEx(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_dwEquipExpandTime - KSG_GetCurSec() > 0)
		Lua_PushNumber(L, Player[nPlayerIndex].m_dwEquipExpandTime);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaSetEquipItemEx(Lua_State * L)
{
	int nValue = (int)Lua_ValueToNumber(L, 1);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Player[nPlayerIndex].SetEquipExpandTime((int)Lua_ValueToNumber(L, 1));
	return 0;
}

int LuaGetExpandBox(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Lua_PushNumber(L, Player[nPlayerIndex].m_btRepositoryNum);
	return 1;
}

int LuaSetExpandBox(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;

	Player[nPlayerIndex].SetExpandBoxNum((int)Lua_ValueToNumber(L, 1));
	return 0;
}


int LuaSetObjPropState(Lua_State *L)
{
	int  nParamNum = ( int ) Lua_GetTopIndex(L);
	int nState  = 1;

	if (nParamNum >= 1)
	{
		nState = (int)Lua_ValueToNumber(L,1);
		nState = (nState == 0)?0 : 1;
	}

	int nIndex = 0;
	if ((nIndex = GetObjIndex(L)) < 0)
		return 0;

	Object[nIndex].SetState(nState);
	return 0;
}


int	LuaGetServerName(Lua_State * L)
{
	char szServerName[100]  ;
	unsigned long   stServerNameLen = 100;

#ifndef __linux
	if (GetComputerName(szServerName, &stServerNameLen))
	{
		Lua_PushString(L, szServerName);
	}
	else
#else
	if (SOCKET_ERROR != gethostname(szServerName, sizeof(szServerName)))
	{
		Lua_PushString(L, szServerName);
	}
	else
#endif
	Lua_PushString(L, "");

	return 1;
}

//GetWharfCount(nDock)
int LuaGetDockCount(Lua_State * L)
{
	int nCount = 0;
	int nCurStation = 0;
	int nTotalCount = 0;
	int i  = 0;
	if (Lua_GetTopIndex(L) < 1 )
	{
		goto DockCount;
	}

	nCurStation = (int)Lua_ValueToNumber(L,1);
	nTotalCount = g_DockPriceTabFile.GetHeight() - 1;

	for (i = 0; i < nTotalCount; i ++)
	{
		int nPrice = g_GetPriceToDock(nCurStation, i + 1);
		if (nPrice > 0) nCount ++;
	}

DockCount:
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaGetDockPrice(Lua_State * L)
{
	int nCurDock = (int)Lua_ValueToNumber(L,1);
	int nDesDock = (int)Lua_ValueToNumber(L,2);
	Lua_PushNumber(L, g_GetPriceToDock(nCurDock, nDesDock));
	return 1;
}

int LuaGetDock(Lua_State * L)
{
	int nCurDock = (int)Lua_ValueToNumber(L, 1);
	int nDock = (int)Lua_ValueToNumber(L, 2);
	int nCount = 0;
	int nTotalCount = g_DockPriceTabFile.GetHeight() - 1;
	int nGetDock = 0;

	for (int i = 0; i < nTotalCount; i ++)
	{
		int nPrice = g_GetPriceToDock(nCurDock, i + 1);
		if (nPrice > 0)
		{
			nCount ++ ;
			if (nCount == nDock)
			{
				nGetDock = i + 1;
				break;
			}
		}
	}
	Lua_PushNumber(L, nGetDock);
	return 1;
}

int LuaGetDockName(Lua_State * L)
{
	int nDock  = (int)Lua_ValueToNumber(L, 1);
	char szName[100] ;

	if (nDock > g_DockPriceTabFile.GetHeight() - 1)
	{
		strcpy(szName, "????????????");
		goto DockName;
	}

	g_DockTabFile.GetString(nDock + 1, "DESC", "????????????", szName, 100);

DockName:
	Lua_PushString (L, szName);
	return 1;
}

int LuaGetDockPos(Lua_State * L)
{
	int nDock  = (int)Lua_ValueToNumber(L, 1);
	if (nDock > g_DockTabFile.GetHeight() - 1)
	{
		printf("GetWharfPos Script Is Error!");
		return 0;
	}

	char szPos[100] ;
	int nCount = 0;
	int nRow = g_DockTabFile.FindColumn("COUNT");
	g_DockTabFile.GetInteger(nDock + 1, nRow,  0, &nCount);
	if (nCount <= 0) return 0;
	int nRandSect = g_Random(100) % nCount + 1;
	char szSectName[32];
	sprintf(szSectName, "SECT%d", nRandSect);
	char szValue[100];
	nRow = g_DockTabFile.FindColumn(szSectName);
	g_DockTabFile.GetString(nDock + 1, nRow, "0,0,0", szValue, 100);
	int nX, nY, nWorld;
    const char *pcszTemp = szValue;

    nWorld = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nX = KSG_StringGetInt(&pcszTemp, 0);
    KSG_StringSkipSymbol(&pcszTemp, ',');
    nY = KSG_StringGetInt(&pcszTemp, 0);
	//sscanf(szValue, "%d,%d,%d", &nWorld, &nX, &nY);

	Lua_PushNumber(L,nWorld);
	Lua_PushNumber(L,nX);
	Lua_PushNumber(L,nY);
	return 3;
}

int LuaGetWayPointFightState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0) return 0;
	int nFightState = 0;
	if (Lua_GetTopIndex(L) > 0 )
	{
		int nWayPointId = (int)Lua_ValueToNumber(L,1);
		g_WayPointTabFile.GetInteger(nWayPointId + 1, "FightState", 0,  &nFightState);
	}
	Lua_PushNumber(L, nFightState);
	return 1;
}

// SetMission(valueid, value)
int LuaSetMission(Lua_State * L)
{
	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;

	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;

	int nValueId = (int)Lua_ValueToNumber(L, 1);
	char* szValue = (char*)Lua_ValueToString(L, 2);

	if (nValueId  < 0)
		return 0;

	SubWorld[nSubWorldIndex].m_MissionArray.SetMission(nValueId, szValue);
	return 0;
}

int LuaGetMissionValue(Lua_State * L)
{
	int nResultValue = 0;
	int nSubWorldIndex = -1;
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 1)
		goto lab_getmissionvalue;

	nSubWorldIndex = GetSubWorldIndex(L);

	if (nSubWorldIndex >= 0)
	{
		int  nValueId = (int)Lua_ValueToNumber(L, 1);
		if (nValueId >= 0)
			nResultValue = SubWorld[nSubWorldIndex].m_MissionArray.GetMissionValue(nValueId);
	}

lab_getmissionvalue:
	Lua_PushNumber(L, nResultValue);
	return 1;
}

int LuaGetMissionString(Lua_State * L)
{
	int nSubWorldIndex = -1;
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 1)
		goto lab_getmissionstring;

	nSubWorldIndex = GetSubWorldIndex(L);

	if (nSubWorldIndex >= 0)
	{
		int  nValueId = (int)Lua_ValueToNumber(L, 1);
		if (nValueId >= 0)
		{
			Lua_PushString(L, SubWorld[nSubWorldIndex].m_MissionArray.GetMissionString(nValueId));
			return 1;
		}
	}

lab_getmissionstring:
	Lua_PushNil(L);
	return 1;
}

// SetMissionValue(mapid/mapname, valueid, value)
int LuaSetGlobalMission(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;

	int nValueId = (int)Lua_ValueToNumber(L, 1);
	char* szValue = (char*)Lua_ValueToString(L, 2);

	if (nValueId  < 0)
		return 0;
	g_GlobalMissionArray.SetMission(nValueId, szValue);
	return 0;
}

int LuaGetGlobalMissionValue(Lua_State * L)
{
	int nResultValue = 0;
	int nValueId = 0;
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 1)
		goto lab_getglobalmissionvalue;
	nValueId = (int)Lua_ValueToNumber(L, 1);
	if (nValueId < 0)
		goto lab_getglobalmissionvalue;

	nResultValue = g_GlobalMissionArray.GetMissionValue(nValueId);

lab_getglobalmissionvalue:
	Lua_PushNumber(L, nResultValue);
	return 1;
}

int LuaGetGlobalMissionString(Lua_State * L)
{
	int nValueId = 0;
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 1)
		goto lab_getglobalmissionstring;
	nValueId = (int)Lua_ValueToNumber(L, 1);
	if (nValueId < 0)
		goto lab_getglobalmissionstring;

	Lua_PushString(L, g_GlobalMissionArray.GetMissionString(nValueId));

lab_getglobalmissionstring:
	Lua_PushNil(L);
	return 1;
}

int LuaGetMissionName(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;

	KMission Mission;
	Mission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);

	if (pMission)
	{
		Lua_PushString(L, pMission->GetMissionName());
		return 1;
	}
	return 0;
}

//StartMission(missionid)
int LuaInitMission(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;

	KMission Mission;
	Mission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
	if (pMission)
	{
		_ASSERT(0);
		return 0;
	}

	pMission = SubWorld[nSubWorldIndex].m_MissionArray.Add();
	if (pMission)
	{
		pMission->m_MissionPlayer.Clear();
		pMission->m_MissionNpc.Clear();
		pMission->SetMissionId(nMissionId);
		if(Lua_GetTopIndex(L) > 4)
		{
			int nParam[MAX_GLBMISSION_PARAM];
			for(int i = 0; i < MAX_GLBMISSION_PARAM; i++)
				nParam[i] = (int)Lua_ValueToNumber(L, 4+i);
			pMission->SetMissionLadder((char*)Lua_ValueToString(L,2), (int)Lua_ValueToNumber(L,3), nParam);
		}
		char szScript[MAX_PATH];
		sprintf(szScript, MISSIONTASK_SCRIPTFILE, nMissionId);
		if (szScript[0])
		{
			KLuaScript * pScript =(KLuaScript*) g_GetScript(szScript);
			Lua_PushNumber(pScript->m_LuaState, nSubWorldIndex);
			pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);
			pScript->CallFunction("InitMission", 0, "d", nMissionId);
		}
	}
	return 0;
}

int LuaRunMission(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;

	KMission Mission;
	Mission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);

	if (pMission)
	{
		char szScript[MAX_PATH];
		sprintf(szScript, MISSIONTASK_SCRIPTFILE, nMissionId);
		if (szScript[0])
		{
			KLuaScript * pScript =(KLuaScript*) g_GetScript(szScript);
			Lua_PushNumber(pScript->m_LuaState, nSubWorldIndex);
			pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);
			pScript->CallFunction("RunMission", 0, "d", nMissionId);
		}
	}
	return 0;
}

int LuaIsMission(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;

	KMission Mission;
	Mission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
	if (pMission)
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaGetMSLadder(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;
	KMission Mission;
	Mission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
	if (pMission)
	{
		int nOrdinal = (int)Lua_ValueToNumber(L,2);
		if(nOrdinal >= 0 && nOrdinal < MISSION_STATNUM)
		{
			Lua_PushString(L, pMission->m_MissionLadder[nOrdinal].Name);
			Lua_PushNumber(L, pMission->m_MissionLadder[nOrdinal].ucGroup);
			Lua_PushNumber(L, pMission->m_MissionLadder[nOrdinal].nParam[pMission->GetMissionLadderParam()]);
			return 3;
		}

	}
	return 0;
}

//CloseMission(missionId)
int LuaCloseMission(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	if (nMissionId < 0 )
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex < 0)
		return 0;
	KMission StopMission;
	StopMission.SetMissionId(nMissionId);
	KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&StopMission);
	if (pMission)
	{
		char szScript[MAX_PATH];
		sprintf(szScript, MISSIONTASK_SCRIPTFILE, nMissionId);
		if (szScript[0])
		{
			KLuaScript * pScript =(KLuaScript*) g_GetScript(szScript);
			Lua_PushNumber(pScript->m_LuaState, nSubWorldIndex);
			pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);
			pScript->CallFunction("EndMission", 0, "d", nMissionId);
		}
		pMission->StopMission();
		SubWorld[nSubWorldIndex].m_MissionArray.Remove(pMission);

	}
	return 0;
}
//StopMissionTimer(missionid, timerid)
int LuaStopMissionTimer(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;
	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	int nTimerId = (int)Lua_ValueToNumber(L, 2);
	int nSubWorldIndex = GetSubWorldIndex(L);

	if (nMissionId < 0 || nTimerId < 0 )
		return 0;

	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			KTimerTaskFun StopTimer;
			StopTimer.SetTimer(1, nTimerId);
			KTimerTaskFun * pTimer = pMission->m_cTimerTaskSet.GetData(&StopTimer);
			if (pTimer)
			{
				pTimer->CloseTimer();
				pMission->m_cTimerTaskSet.Remove(pTimer);
			}
		}

	}

	return 0;
}

//StartMissionTimer(missionid, timerid, time)
int LuaStartMissionTimer(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 3)
		return 0;
	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	int nTimerId = (int)Lua_ValueToNumber(L, 2);
	int nTimeInterval = (int)Lua_ValueToNumber(L, 3);
	int nSubWorldIndex = GetSubWorldIndex(L);

	if (nMissionId < 0 || nTimerId < 0 || nTimeInterval < 0)
		return 0;

	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			KTimerTaskFun * pTimer = pMission->m_cTimerTaskSet.Add();
			if (pTimer)
			{
				pTimer->SetTimer(nTimeInterval, nTimerId);
			}
		}

	}
	return 0;
}
//SetTempRev(worldid, x, y)
int LuaSetDeathRevivalPos(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
		return 0;
	int nParamCount = Lua_GetTopIndex(L);

	PLAYER_REVIVAL_POS * pTempRev = Player[nPlayerIndex].GetDeathRevivalPos();

	if (nParamCount > 2)
	{
		pTempRev->m_nSubWorldID  = (int) Lua_ValueToNumber(L, 1);
		pTempRev->m_nMpsX = (int) Lua_ValueToNumber(L, 2);
		pTempRev->m_nMpsY = (int) Lua_ValueToNumber(L, 3);
	}
	else if (nParamCount == 1)
	{
		pTempRev->m_nSubWorldID = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
		POINT Pos;
		int nRevId = (int) Lua_ValueToNumber(L, 1);
		g_SubWorldSet.GetRevivalPosFromId(pTempRev->m_nSubWorldID, nRevId, &Pos);
		pTempRev->m_ReviveID = nRevId;
		pTempRev->m_nMpsX = Pos.x;
		pTempRev->m_nMpsY = Pos.y;
	}
	else
	{
		return 0;
	}

	return 0;
}


int LuaPlayerExecuteRevive(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex <= 0)
		return 0;
	int nParamCount = Lua_GetTopIndex(L);

	int nReviveType = REMOTE_REVIVE_TYPE;

	if (nParamCount > 1)
		nReviveType  = (int) Lua_ValueToNumber(L, 1);

	Player[nPlayerIndex].Revive(nReviveType);
	return 0;
}

//AddMSPlayer(MissionId, PlayerIndex, groupid); / AddMSPlayer(MissionId, groupid)
int LuaAddMissionPlayer(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;
	int nMissionId = 0;
	int nPlayerIndex = 0;
	int nGroupId = 0;
	if (nParamCount >=3)
	{
		nMissionId = (int)Lua_ValueToNumber(L,1);
		nPlayerIndex = (int )Lua_ValueToNumber(L,2);
		nGroupId = (int) Lua_ValueToNumber(L,3);
	}
	else
	{
		nMissionId = (int)Lua_ValueToNumber(L,1);
		nGroupId = (int) Lua_ValueToNumber(L,2);
		nPlayerIndex = GetPlayerIndex(L);
	}

	if (nMissionId < 0 || nPlayerIndex <= 0 || nGroupId <0)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			int nPlayerDataIdx = pMission->AddPlayer(nPlayerIndex, Player[nPlayerIndex].m_dwID, nGroupId);
			Lua_PushNumber(L, nPlayerDataIdx);
			return 1;
		}
	}
	return 0;
}

int LuaAddMissionNpc(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;

	int nMissionId = (int)Lua_ValueToNumber(L,1);
	int	nNpcIndex = (int )Lua_ValueToNumber(L,2);
	int nGroupId = 0;
	if (nParamCount >= 3)
		nGroupId = (int )Lua_ValueToNumber(L,3);

	if (nMissionId < 0 || nNpcIndex <= 0 || nGroupId <0)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			int nNpcDataIdx = pMission->AddNpc(nNpcIndex, Npc[nNpcIndex].m_dwID, nGroupId);
			Lua_PushNumber(L, nNpcDataIdx);
			return 1;
		}
	}
	return 0;
}

int LuaSetMissionGroup(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Npc[Player[nPlayerIndex].m_nIndex].m_nMissionGroup = (int)Lua_ValueToNumber(L,1);
	Player[nPlayerIndex].SendMSGroup();
	return 0;
}

int LuaRevivalAllNpc(Lua_State * L)
{
	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		SubWorld[nSubWorldIndex].RevivalAllNpc();
	}
	return 0;
}

//RemoveMSPlayer(MissionId, PlayerIndex, groupid)
int LuaRemoveMissionPlayer(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;
	int nMissionId = 0;
	int nPlayerIndex = 0;
	int nGroupId = 0;
	if (nParamCount >=2)
	{
		nMissionId = (int)Lua_ValueToNumber(L,1);
		nPlayerIndex = (int )Lua_ValueToNumber(L,2);
	}
	else
	{
		nMissionId = (int)Lua_ValueToNumber(L,1);
		nPlayerIndex = GetPlayerIndex(L);
	}

	if (nMissionId < 0 || nPlayerIndex <= 0)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			pMission->RemovePlayer(nPlayerIndex/*, Player[nPlayerIndex].m_dwID*/);
		}
	}
	return 0;
}

int LuaRemoveMissionNpc(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;
	int nMissionId = (int)Lua_ValueToNumber(L,1);
	int	nNpcIndex = (int )Lua_ValueToNumber(L,2);

	if (nMissionId < 0 || nNpcIndex <= 0)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			pMission->RemoveNpc(nNpcIndex);
		}
	}
	return 0;
}

//MSMsg2Group(missionid, string , group)
int LuaMissionMsg2Group(Lua_State * L)
{
	int nMissionId = (int)Lua_ValueToNumber(L,1);
	char * strMsg = (char *)Lua_ValueToString(L, 2);
	int	nGroupId = (int) Lua_ValueToNumber(L, 3);

	if (nMissionId < 0 || !strMsg || nGroupId <0)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			int nChannelID = -1;
			if(Lua_GetTopIndex(L) > 4)
				nChannelID = (int)Lua_ValueToNumber(L, 4);
			pMission->Msg2Group(strMsg, nGroupId, nChannelID);
		}
	}

	return 0;
}

//MSMsg2Group(missionid, string)
int LuaMissionMsg2All(Lua_State * L)
{
	int nMissionId = (int)Lua_ValueToNumber(L,1);
	char * strMsg = (char *)Lua_ValueToString(L, 2);

	if (nMissionId < 0 || !strMsg)
		return 0;

	int nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			int nChannelID = -1;
			if(Lua_GetTopIndex(L) > 3)
				nChannelID = (int)Lua_ValueToNumber(L, 3);
			pMission->Msg2All(strMsg, nChannelID);
		}
	}

	return 0;
}

int LuaMissionPlayerCount(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	unsigned long ulCount = 0;
	int nMissionId = 0;
	int nGroupId = -1;
	int nSubWorldIndex = 0;
	if (nParamCount < 1)
		goto lab_getmissionplayercount;

	nMissionId = (int)Lua_ValueToNumber(L,1);
	if (nParamCount >=2)
		nGroupId = (int)Lua_ValueToNumber(L,2);

	if (nMissionId < 0)
		goto lab_getmissionplayercount;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			if (nGroupId >= 0 && nParamCount >=2)
				ulCount = pMission->GetGroupPlayerCount(nGroupId);
			else
				ulCount = pMission->GetPlayerCount();
		}
	}

lab_getmissionplayercount:
	Lua_PushNumber(L, ulCount);
	return 1;
}

int LuaMissionNpcCount(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	unsigned long ulCount = 0;
	int nMissionId = 0;
	int nGroupId = -1;
	int nSubWorldIndex = 0;
	if (nParamCount < 1)
		goto lab_getmissionnpccount;

	    nMissionId = (int)Lua_ValueToNumber(L,1);
	if (nParamCount > 1)
		nGroupId = (int)Lua_ValueToNumber(L,2);

	if (nMissionId < 0)
		goto lab_getmissionnpccount;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			if (nGroupId >= 0)
				ulCount = pMission->GetGroupNpcCount(nGroupId);
			else
				ulCount = pMission->GetNpcCount();
		}
	}

lab_getmissionnpccount:
	Lua_PushNumber(L, ulCount);
	return 1;
}

int LuaSetPlayerDeathScript(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	char * szScript = (char *)Lua_ValueToString(L, 1);
	Player[nPlayerIndex].m_dwDeathScriptId = g_FileName2Id(szScript);
	return 0;
}

int LuaSetPlayerDamageScript(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	char * szScript = (char *)Lua_ValueToString(L, 1);
	Player[nPlayerIndex].m_dwDamageScriptId = g_FileName2Id(szScript);
	return 0;
}

int LuaNpcIndexToPlayerIndex(Lua_State * L)
{
	int nResult = 0;
	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex <=  0 || nNpcIndex >= MAX_NPC)
		goto lab_npcindextoplayerindex;

	if (Npc[nNpcIndex].m_Index > 0 && Npc[nNpcIndex].IsPlayer())
	{
		if (Npc[nNpcIndex].GetPlayerIdx() > 0)
			nResult = Npc[nNpcIndex].GetPlayerIdx();
	}

lab_npcindextoplayerindex:
	Lua_PushNumber(L, nResult);
	return 1;

}
//
int LuaGetMissionPlayer_PlayerIndex(Lua_State * L)
{
	unsigned long nResult = 0;
	int nSubWorldIndex = 0;
	if (Lua_GetTopIndex(L) < 2)
		goto lab_getmissionplayer_npcindex;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		int nMissionId = (int)Lua_ValueToNumber(L, 1);
		int nDataIndex = (int)Lua_ValueToNumber(L, 2);
		if (nMissionId < 0 || nDataIndex < 0)
			goto lab_getmissionplayer_npcindex;

		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			nResult = pMission->GetMissionPlayer_PlayerIndex(nDataIndex);
		}
	}

lab_getmissionplayer_npcindex:
	Lua_PushNumber(L,nResult);
	return 1;
}

int LuaGetMissionPlayer_DataIndex(Lua_State * L)
{
	unsigned long nResult = 0;
	int nSubWorldIndex = 0;
	if (Lua_GetTopIndex(L) < 2)
		goto lab_getmissionplayer_dataindex;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		int nMissionId = (int)Lua_ValueToNumber(L, 1);
		int nPlayerIndex = (int)Lua_ValueToNumber(L, 2);
		if (nMissionId < 0 || nPlayerIndex < 0)
			goto lab_getmissionplayer_dataindex;

		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			nResult = pMission->GetMissionPlayer_DataIndex(Player[nPlayerIndex].Name, nPlayerIndex, Player[nPlayerIndex].m_dwID);
		}
	}

lab_getmissionplayer_dataindex:
	Lua_PushNumber(L,nResult);
	return 1;
}

//SetMPParam(missionid, nDidx, vid, v)
int LuaSetMissionPlayerParam(Lua_State * L)
{
	int nSubWorldIndex = 0;
	if (Lua_GetTopIndex(L) < 4)
		return 0;

	g_DebugLog("Chay vao nDataIndex");

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		int nMissionId = (int)Lua_ValueToNumber(L, 1);
		int nDataIndex = (int)Lua_ValueToNumber(L, 2);
		int nParamId =	 (int)Lua_ValueToNumber(L ,3);
		int nValue =	 (int )Lua_ValueToNumber(L, 4);
		g_DebugLog("Chay vao nDataIndex2: %d", nDataIndex);
		g_DebugLog("Chay vao nParamId2: %d", nParamId);
		g_DebugLog("Chay vao nValue2: %d", nValue);

		if (nMissionId < 0 || nDataIndex < 0 || nParamId > MAX_MISSION_PARAM)
			return 0;

		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			//pMission->m_MissionPlayer.SetParam(nDataIndex, nParamId, nValue);
			pMission->SetPlayerParam(nDataIndex, nParamId, nValue);
			g_DebugLog("Chay vao mission: %d", nDataIndex);
		}
	}
	return 0;
}

int LuaGetMissionPlayerParam(Lua_State * L)
{
	int nResult = 0;
	int nSubWorldIndex = 0;
	if (Lua_GetTopIndex(L) < 3)
		goto lab_getmissionplayerparam;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		int nMissionId = (int)Lua_ValueToNumber(L, 1);
		int nDataIndex = (int)Lua_ValueToNumber(L, 2);
		int nParamId =	 (int)Lua_ValueToNumber(L ,3);

		if (nMissionId < 0 || nDataIndex < 0 || nParamId > MAX_MISSION_PARAM)
			goto lab_getmissionplayerparam;

		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			nResult = pMission->m_MissionPlayer.GetParam(nDataIndex, nParamId);
		}
	}
lab_getmissionplayerparam:
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetPlayerMissionGroup(Lua_State * L)
{
	int nResult = 0;
	int nSubWorldIndex = 0;
	if (Lua_GetTopIndex(L) < 2)
		goto lab_getmissionplayergroup;

	nSubWorldIndex = GetSubWorldIndex(L);
	if (nSubWorldIndex >= 0)
	{
		int nMissionId = (int)Lua_ValueToNumber(L, 1);
		int nNpcIndex = (int)Lua_ValueToNumber(L, 2);

		if (nMissionId < 0 || nNpcIndex < 0)
			goto lab_getmissionplayergroup;

		KMission Mission;
		Mission.SetMissionId(nMissionId);
		KMission * pMission = SubWorld[nSubWorldIndex].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			nResult = pMission->GetMissionPlayer_GroupId(nNpcIndex);
		}
	}
lab_getmissionplayergroup:
	Lua_PushNumber(L ,nResult);
	return 1;

}

int LuaSetPlayerRevivalOptionWhenLogout(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	int nType = (int)Lua_ValueToNumber(L, 1);

	if (nType)
		Player[nPlayerIndex].SetLoginType(1);
	else
		Player[nPlayerIndex].SetLoginType(0);

	return 0;
}


int LuaSetPlayerPKValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nPKValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cPK.SetPKValue(nPKValue);
	return 0;
}

int LuaGetPlayerPKValue(Lua_State * L)
{
	int nPKValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerpkvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerpkvalue;
	nPKValue = Player[nPlayerIndex].m_cPK.GetPKValue();

lab_getplayerpkvalue:
	Lua_PushNumber(L, nPKValue);
	return 1;
}

int LuaGetGameTime(Lua_State * L)
{
	Lua_PushNumber(L, g_SubWorldSet.GetGameTime());
	return 1;
}

int LuaGetPlayerLoginTime(Lua_State * L)
{
	int nResult = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerlogintime;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerlogintime;
	nResult = Player[nPlayerIndex].m_dwLoginTime;

lab_getplayerlogintime:
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetPlayerOnlineTime(Lua_State * L)
{
	int nResult = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayeronlinetime;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayeronlinetime;
	nResult = g_SubWorldSet.GetGameTime() - Player[nPlayerIndex].m_dwLoginTime;

lab_getplayeronlinetime:
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaOfflineLive(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Value = 0;
	sMsg.Operation = PHONGTHAN_PLAYER_EXIT;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));
	return 0;
}

/*int LuaOfflineLive(Lua_State* L) // offlive
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	S2C_PLAYER_SYNC_OFFLINE_LIVE	sMsg;
	sMsg.ProtocolType = s2c_playersyncofflive; // TamLTM Fix
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_OFFLINE_LIVE) - 1;
	sMsg.m_lpBuf = 0;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_EXIT;
	//	g_DebugLog("s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
	return 0;
}*/

int LuaSetValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;
	int nValueIndex = (int)Lua_ValueToNumber(L,1);
	int nValue = (int)Lua_ValueToNumber(L,2);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;

	if (nValueIndex < 0 || nValueIndex >= MAX_STATTASK)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(nValueIndex,nValue);
	return 0;
}

int LuaAddValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;
	int nValueIndex = (int)Lua_ValueToNumber(L,1);
	int nValue = (int)Lua_ValueToNumber(L,2);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;

	if (nValueIndex < 0 || nValueIndex >= MAX_STATTASK)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(nValueIndex,
		Player[nPlayerIndex].m_cTask.GetSaveVal(nValueIndex)+nValue);
	return 0;
}


int LuaGetValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayervalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayervalue;
		nValue = Player[nPlayerIndex].m_cTask.GetSaveVal((int)Lua_ValueToNumber(L,1));

lab_getplayervalue:
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaSetPlayerReputeValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nReputeValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_REPUTE, nReputeValue);
	return 0;
}

int LuaAddPlayerReputeValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nReputeValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_REPUTE,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_REPUTE)+nReputeValue);
	return 0;
}

int LuaGetPlayerReputeValue(Lua_State * L)
{
	int nReputeValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerreputevalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerreputevalue;
		nReputeValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_REPUTE);

lab_getplayerreputevalue:
	Lua_PushNumber(L, nReputeValue);
	return 1;
}

int LuaSetPlayerFuYuanValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nFuYuanValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_FUYUAN,nFuYuanValue);
	return 0;
}


int LuaAddPlayerFuYuanValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nFuYuanValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_FUYUAN,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_FUYUAN)+nFuYuanValue);
	return 0;
}

int LuaGetPlayerFuYuanValue(Lua_State * L)
{
	int nFuYuanValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerfuyuanvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerfuyuanvalue;
		nFuYuanValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_FUYUAN);

lab_getplayerfuyuanvalue:
	Lua_PushNumber(L, nFuYuanValue);
	return 1;
}

int LuaAddPlayerAccumValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nAccumValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_ACCUM,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_ACCUM)+nAccumValue);
	return 0;
}

int LuaGetPlayerAccumValue(Lua_State * L)
{
	int nAccumValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayeraccumvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayeraccumvalue;
		nAccumValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_ACCUM);

lab_getplayeraccumvalue:
	Lua_PushNumber(L, nAccumValue);
	return 1;
}

int LuaAddPlayerHonorValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nHonorValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_HONOR,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_HONOR)+nHonorValue);
	return 0;
}

int LuaGetPlayerHonorValue(Lua_State * L)
{
	int nHonorValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerhonorvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerhonorvalue;
		nHonorValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_HONOR);

lab_getplayerhonorvalue:
	Lua_PushNumber(L, nHonorValue);
	return 1;
}

int LuaAddPlayerRespectValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nRespectValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_RESPECT,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_RESPECT)+nRespectValue);
	return 0;
}

int LuaGetPlayerRespectValue(Lua_State * L)
{
	int nRespectValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerrespectvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerrespectvalue;
		nRespectValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_RESPECT);

lab_getplayerrespectvalue:
	Lua_PushNumber(L, nRespectValue);
	return 1;
}

int LuaAddPlayerTranslifeValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nTranslifeValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Npc[Player[nPlayerIndex].m_nIndex].m_byTranslife += nTranslifeValue;
	return 0;
}

int LuaGetPlayerTranslifeValue(Lua_State * L)
{
	int nTranslifeValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayertranslifevalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayertranslifevalue;
		nTranslifeValue = Npc[Player[nPlayerIndex].m_nIndex].m_byTranslife;

lab_getplayertranslifevalue:
	Lua_PushNumber(L, nTranslifeValue);
	return 1;
}

int LuaAddPlayerViprankValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;
	int nViprankValue = (int)Lua_ValueToNumber(L,1);

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_STATTASK_VIPRANK,
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_VIPRANK)+nViprankValue);
	return 0;
}

int LuaGetPlayerViprankValue(Lua_State * L)
{
	int nViprankValue = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getplayerviprankvalue;

	if (Player[nPlayerIndex].m_nIndex <= 0)
		goto lab_getplayerviprankvalue;
		nViprankValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_STATTASK_VIPRANK);

lab_getplayerviprankvalue:
	Lua_PushNumber(L, nViprankValue);
	return 1;
}


int	LuaGetCurNpcIndex(Lua_State * L)
{
	int nNpcIndex = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getcurnpcindex;

lab_getcurnpcindex:
	Lua_PushNumber(L, Player[nPlayerIndex].m_nIndex);
	return 1;
}



//showladder(count, ladderid1, ladderid2.....)
int LuaShowLadder(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;
	int nLadderCount = (DWORD) Lua_ValueToNumber(L, 1);
	if (nLadderCount <= 0)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	if (nLadderCount > nParamCount - 1 )
		nLadderCount = nParamCount - 1;
	BYTE Buffer[sizeof(LADDER_LIST) + 50 * sizeof(DWORD)];
	LADDER_LIST * pLadderList = (LADDER_LIST*)&Buffer;
	pLadderList->ProtocolType = s2c_ladderlist;
	pLadderList->nCount = nLadderCount;
	pLadderList->wSize = sizeof(LADDER_LIST) + nLadderCount * sizeof(DWORD) - 1;
	for (int i = 0; i < nLadderCount; i ++)
	{
		pLadderList->dwLadderID[i] = (DWORD)Lua_ValueToNumber(L, i + 2);
	}
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &Buffer, pLadderList->wSize + 1);
	return 0;

}

int LuaGetLadder(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount < 2)
		return 0;

	void* pData = (void *)Ladder.GetTopTen((DWORD)Lua_ValueToNumber(L,1));
	if (pData)
	{
		TRoleList	StatData[10];
		memcpy(StatData, pData, sizeof(StatData));
		int nOrdinal = (int)Lua_ValueToNumber(L,2);
		if(nOrdinal >= 0 && nOrdinal < 10)
		{
			Lua_PushString(L, StatData[nOrdinal].Name);
			Lua_PushNumber(L, StatData[nOrdinal].nValue);
			Lua_PushNumber(L, StatData[nOrdinal].bySort);
			return 3;
		}
	}
	return 0;
}

int LuaSwearBrother(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nTeamID = Lua_ValueToNumber(L, 1);

	if (nTeamID >= MAX_TEAM || nTeamID < 0)
		return 0;

	KPlayerChat::STRINGLIST BrotherList;
	_ASSERT(g_Team[nTeamID].m_nCaptain > 0);

	std::string strCapName;
	strCapName = Npc[Player[g_Team[nTeamID].m_nCaptain].m_nIndex].Name;
	BrotherList.push_back(strCapName);

	for (int i  = 0; i < g_Team[nTeamID].m_nMemNum; i++)
	{
		int nPlayerIndex = g_Team[nTeamID].m_nMember[i];
		if ( nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER)
		{
			std::string strName;
			strName = 	Npc[Player[nPlayerIndex].m_nIndex].Name;
			BrotherList.push_back(strName);
		}
	}

	KPlayerChat::MakeBrother(BrotherList);
	return 0;
}

int LuaMakeEnemy(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;
	char* szEnemy = (char*)Lua_ValueToString(L, 1);

	if (szEnemy[0])
	{
		KPlayerChat::MakeEnemy(Player[nPlayerIndex].Name, szEnemy);
	}
	return 0;
}

int LuaMakeMate(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_BASEDATA_MATENAME, (char*)Lua_ValueToString(L, 1));
	return 0;
}

int LuaDeleteMate(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	const char* szMateName = Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME);
	if (szMateName[0])
		Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_BASEDATA_MATENAME, "");

	return 0;
}

int LuaAddLeadExp(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	int nLeadExp = (int)Lua_ValueToNumber(L, 1);
	Player[nPlayerIndex].AddLeadExp(nLeadExp);
	return 0;
}

int LuaSetLeadLevel(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	int nLeadLevel = (int)Lua_ValueToNumber(L, 1);
	Player[nPlayerIndex].SetLeadLevel(nLeadLevel);
	return 0;
}

int LuaGetLeadLevel(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nLeadLevel = 0;
	if (nPlayerIndex <= 0)
		goto lab_getleadlevel;
	nLeadLevel = (int)Player[nPlayerIndex].m_nLeadLevel;

lab_getleadlevel:
	Lua_PushNumber(L, nLeadLevel);
	return 1;
}

int LuaAddMagicPoint(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	Player[nPlayerIndex].m_nSkillPoint += (int)Lua_ValueToNumber(L, 1);
	if (Player[nPlayerIndex].m_nSkillPoint < 0)
		Player[nPlayerIndex].m_nSkillPoint = 0;

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Value = Player[nPlayerIndex].m_nSkillPoint ;
	sMsg.Operation = PHONGTHAN_PLAYER_SKILL_POINTS;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));
	return 0;
}

/*//TamLTM fix send packet
int LuaAddMagicPoint(Lua_State* L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	Player[nPlayerIndex].m_nSkillPoint += (int)Lua_ValueToNumber(L, 1);
	if (Player[nPlayerIndex].m_nSkillPoint < 0)
		Player[nPlayerIndex].m_nSkillPoint = 0;

	S2C_PLAYER_SYNC_MAGIC_POINT	sMsg;
	sMsg.ProtocolType = s2c_playersyncmagicpoint;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_MAGIC_POINT) - 1;
	sMsg.m_lpBuf = (LPVOID)Player[nPlayerIndex].m_nSkillPoint;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_MAGICPOINT;
	//	g_DebugLog("LuaAddMagicPoint s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
	return 0;
}
//end code */

int LuaGetMagicPoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillPoint = 0;
	if (nPlayerIndex <= 0)
		goto lab_getmagicpoint;

lab_getmagicpoint:
	Lua_PushNumber(L, Player[nPlayerIndex].m_nSkillPoint);
	return 1;
}

int LuaAddPropPoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPropPoint = 0;
	if (nPlayerIndex <= 0)
		return 0;

	Player[nPlayerIndex].m_nAttributePoint += (int)Lua_ValueToNumber(L, 1);
	if (Player[nPlayerIndex].m_nAttributePoint < 0)
		Player[nPlayerIndex].m_nAttributePoint = 0;

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Value = Player[nPlayerIndex].m_nAttributePoint ;
	sMsg.Operation = PHONGTHAN_PLAYER_ATTRIBUTE_POINTS;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));
	return 0;
}

/*//TamLTM fix send packet
int LuaAddPropPoint(Lua_State* L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPropPoint = 0;
	if (nPlayerIndex <= 0)
		return 0;

	Player[nPlayerIndex].m_nAttributePoint += (int)Lua_ValueToNumber(L, 1);
	if (Player[nPlayerIndex].m_nAttributePoint < 0)
		Player[nPlayerIndex].m_nAttributePoint = 0;

	S2C_PLAYER_SYNC_PROP_POINT	sMsg;
	sMsg.ProtocolType = s2c_playersyncproppoint;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_PROP_POINT) - 1;
	sMsg.m_lpBuf = (LPVOID)Player[nPlayerIndex].m_nAttributePoint;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_PROPPOINT;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
	return 0;
}
//end code */

int LuaSetExtPoint(Lua_State * L) // TamLTM fix xu;
{
	int nResult = 0;
	int nExtPoint = 0;
	int nChange = 1;
	int nPlayerIndex = 0;
	if (Lua_GetTopIndex(L) < 1)
		goto lab_setextpoint;

	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_setextpoint;
	nExtPoint = Lua_ValueToNumber(L, 1);
	if (nExtPoint < 0)
		goto lab_setextpoint;
	Player[nPlayerIndex].SetExtPoint(nExtPoint, nChange);

lab_setextpoint:
	Lua_PushNumber(L, 0);
	return 1;
}

int LuaAddExtPoint(Lua_State * L) //TamLTM fix xu;
{
	int nResult = 0;
	int nExtPoint = 0;
	int nChange = 1;
	int nPlayerIndex = 0;
	if (Lua_GetTopIndex(L) < 1)
		goto lab_setextpoint;

	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_setextpoint;
	nExtPoint = Lua_ValueToNumber(L, 1);
	if (nExtPoint < 0)
		goto lab_setextpoint;
	Player[nPlayerIndex].SetExtPoint(Player[nPlayerIndex].GetExtPoint() + nExtPoint, nChange);

lab_setextpoint:
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaPayExtPoint(Lua_State * L)
{
	int nResult = 0;
	int nPay = 0;
	int nPlayerIndex = 0;
	if (Lua_GetTopIndex(L) < 1)
		goto lab_payextpoint;

	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_payextpoint;
	nPay = Lua_ValueToNumber(L, 1);
	if (nPay < 0)
		goto lab_payextpoint;
	nResult = Player[nPlayerIndex].PayExtPoint(nPay);

lab_payextpoint:
	Lua_PushNumber(L, nResult);
	return 1;
}

//PayExtPoint
int LuaGetExtPoint(Lua_State * L)
{
	int nResult = 0;
	int nPlayerIndex = 0;
	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getextpoint;

	nResult = Player[nPlayerIndex].GetExtPoint();

lab_getextpoint:
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetRestPropPoint(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPropPoint = 0;
	if (nPlayerIndex <= 0)
		goto lab_getrestproppoint;
	nPropPoint = Player[nPlayerIndex].m_nAttributePoint;

lab_getrestproppoint:
	Lua_PushNumber(L, nPropPoint);
	return 1;
}

//Msg2GM(str, id)
int LuaMsgToGameMaster(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if ( nParamCount < 1 )
		return 0;
	int nParamID = 0;
	const char * szMsg = Lua_ValueToString(L, 1) ;
	if (!szMsg)
		return 0;

	if (nParamCount < 2)
	{
		nParamID = 0;
	}
	else
	{
		nParamID = (int) Lua_ValueToNumber(L, 2);
	}

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		char szID[32];

		sprintf(szID, "%d", nParamID);
		//KPlayerChat::SendInfoToGM(Player[nPlayerIndex].AccountName, Npc[Player[nPlayerIndex].m_nIndex].Name, (char *) szMsg, strlen(szMsg) );
		KPlayerChat::SendInfoToGM(MESSAGE_SYSTEM_ANNOUCE_HEAD, szID, (char *) szMsg, strlen(szMsg) );
	}
	return 0;
}

//Msg2IP(IP, ID, str)
int LuaMsgToIP(Lua_State * L)
{
	int nParamCount = Lua_GetTopIndex(L);
	if ( nParamCount < 3 )
		return 0;
	int nIP = 0;
	const char * szIP = Lua_ValueToString(L, 1) ;
	nIP = _a2ip(szIP);
	if (nIP == 0)
		return 0;

	int nID = (int) Lua_ValueToNumber(L, 2);
	const char * szMsg = Lua_ValueToString(L, 3) ;
	if (!szMsg)
		return 0;

	int nParamID = 0;
	if (nParamCount < 4)
	{
		nParamID = 0;
	}
	else
	{
		nParamID = (int) Lua_ValueToNumber(L, 4);
	}
	char szID[32];
	sprintf(szID, "%d", nParamID);
	KPlayerChat::SendInfoToIP(nIP, nID, MESSAGE_SYSTEM_ANNOUCE_HEAD, szID, (char *) szMsg, strlen(szMsg) );
	return 0;
}

int LuaGetIP(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	char szDesMsg[200];
	szDesMsg[0] = 0;
	KPlayer * pPlayer = NULL;
	if (nPlayerIndex <= 0)
		goto lab_getplayerip;
	pPlayer = &Player[nPlayerIndex];
	strcpy(szDesMsg, g_pServer->GetClientInfo(pPlayer->m_nNetConnectIdx));

lab_getplayerip:
	Lua_PushString(L, szDesMsg);
	return 1;
}

int LuaSetDeathPunish(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		if ((int)Lua_ValueToNumber(L, 1))
			Npc[Player[nPlayerIndex].m_nIndex].m_nCurPKPunishState = enumDEATH_MODE_PKBATTLE_PUNISH;
		else
			Npc[Player[nPlayerIndex].m_nIndex].m_nCurPKPunishState = 0;

	}
	return 0;
}

int LuaSetReviveNow(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		Npc[Player[nPlayerIndex].m_nIndex].m_bReviveNow = (BOOL)Lua_ValueToNumber(L, 1);
	}
	return 0;
}

//TamLTM Add money truong muc bang hoi
int LuaAddTongMoney(Lua_State* L)
{
/*	int nPlayerIndex = GetPlayerIndex(L);

	if (nPlayerIndex > 0)
	{
		int nMoney = (int)Lua_ValueToNumber(L, 1);
		if (nMoney <= 0)
			return 0;
	//	Player[nPlayerIndex].Earn(nMoney);
		Player[nPlayerIndex].m_ItemList.CostMoney(nMoney);
	}
	return 0;*/

	int nPlayerIndex = GetPlayerIndex(L);
	int nAddMoney = (int)Lua_ValueToNumber(L, 1);

	if (nPlayerIndex > 0)
	{
		int nParamNum = Lua_GetTopIndex(L);

		if (nAddMoney <= 0)
			return 0;
	//	Player[nPlayerIndex].m_ItemList.CostMoney(nAddMoney);

		if (nParamNum > 1)
		{
			STONG_CHANGE_TONG_INFO_COMMAND	sMoney;
			sMoney.ProtocolID = enumC2S_CHANGE_TONG_MONEY;
			sMoney.ProtocolFamily = pf_tong;
			sMoney.m_dwTongNameID = g_FileName2Id(Player[nPlayerIndex].m_cTong.m_szName);
			sMoney.m_dwParam = nPlayerIndex;
			sMoney.m_AddMoneyThue = nAddMoney;
			sMoney.m_nValue = Player[nPlayerIndex].m_cTong.m_dwMoney + nAddMoney;
			sMoney.m_MessStr = 1;
			//g_DebugLog("Player[nPlayerIndex].m_cTong.m_dwMoney %d", Player[nPlayerIndex].m_cTong.m_dwMoney);
			if (g_pTongClient)
				g_pTongClient->SendPackToServer((const void*)&sMoney, sizeof(STONG_CHANGE_TONG_INFO_COMMAND));
		}
	}
	return 0;
}
//end code


int LuaNpcChat(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex > 0 && nNpcIndex < MAX_NPC)
	{
		char* szMsg = (char*)Lua_ValueToString(L,2);
		if (!szMsg)
			return 0;
		int nLen= TEncodeText(szMsg, strlen(szMsg));
		if(nLen < 0)
			return 0;
		NPC_CHAT_SYNC	command;
		ZeroMemory(&command, sizeof(command));
		command.ProtocolType = s2c_npcchat;
		command.ID = Npc[nNpcIndex].m_dwID;
		g_StrCpyLen(command.szMsg, szMsg, sizeof(command.szMsg));
		command.nMsgLen = strlen(command.szMsg);
		Npc[nNpcIndex].SendDataToNearRegion(&command, sizeof(NPC_CHAT_SYNC));
	}

	return 0;
}

int LuaHideNpc(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2)
		return 0;

	int nNpcIndex  = 0;

	if (Lua_IsNumber(L,1))
	{
		nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	}
	else
	{
		const char * szName = Lua_ValueToString(L, 1);
		int nSubWorldIndex = GetSubWorldIndex(L);
		if (nSubWorldIndex < 0)
			return 0;

		nNpcIndex = SubWorld[nSubWorldIndex].FindNpcFromName(szName);
	}

	if (nNpcIndex > 0 || nNpcIndex < MAX_NPC)
	{
		int nFrame = Lua_ValueToNumber(L, 2);
		if (nFrame <= 0)
			nFrame = 1;

		Npc[nNpcIndex].ExecuteRevive();
		Npc[nNpcIndex].m_Frames.nTotalFrame = nFrame;
		Npc[nNpcIndex].m_Frames.nCurrentFrame = 0;
	}

	return 0;
}

//TamLTM add bien luu tam skill id
int skillIdStateNumber = 0;
//end code

int LuaAddSkillState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
	{
		g_DebugLog("[LuaAddSkillState] invalid player index=%d", nPlayerIndex);
		Lua_PushNumber(L, 0);
		return 1;
	}
	if (Player[nPlayerIndex].m_nIndex <= 0 ||
		Player[nPlayerIndex].m_nIndex >= MAX_NPC)
	{
		g_DebugLog("[LuaAddSkillState] invalid npc index player=%d npc=%d",
			nPlayerIndex, Player[nPlayerIndex].m_nIndex);
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 4)
	{
		g_DebugLog("[LuaAddSkillState] missing args player=%d count=%d",
			nPlayerIndex, nParamNum);
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSkillId = (int)Lua_ValueToNumber(L, 1);
	int nSkillLevel = (int)Lua_ValueToNumber(L, 2);
	int nIfMagic = (int)Lua_ValueToNumber(L, 3);
	int nTime = (int)Lua_ValueToNumber(L, 4);
	BOOL bOverLook = FALSE;
	if(nParamNum >= 5)
		bOverLook = (BOOL)Lua_ValueToNumber(L, 5);
	if (nSkillId <= 0 || nSkillId >= MAX_SKILL ||
		nSkillLevel <= 0 || nSkillLevel >= MAX_SKILLLEVEL)
	{
		g_DebugLog("[LuaAddSkillState] invalid skill player=%d skill=%d level=%d",
			nPlayerIndex, nSkillId, nSkillLevel);
		Lua_PushNumber(L, 0);
		return 1;
	}

	if (IS_TU_CHAN_SEAL_SKILL(nSkillId))
	{
		if (nTime <= 0 || nTime > TU_CHAN_SEAL_DURATION_TICKS)
			nTime = TU_CHAN_SEAL_DURATION_TICKS;
		// Tu Chan seals must survive logout/login during their 24-hour life.
		bOverLook = TRUE;
	}
	else if (nTime <= 0)
	{
		nTime = -1;
	}

	BOOL bApplied = FALSE;
	int nStateAttribsNum = -1;
	if (nIfMagic)
	{
		KSkill *pSkill = (KSkill*)g_SkillManager.GetSkill(nSkillId, nSkillLevel);
		if (!pSkill)
		{
			g_DebugLog("[LuaAddSkillState] skill not loaded player=%d skill=%d level=%d",
				nPlayerIndex, nSkillId, nSkillLevel);
			Lua_PushNumber(L, 0);
			return 1;
		}
		nStateAttribsNum = pSkill->GetStateAttribsNum();
		if (nStateAttribsNum <= 0)
		{
			g_DebugLog("[LuaAddSkillState] skill has no state attributes player=%d skill=%d level=%d",
				nPlayerIndex, nSkillId, nSkillLevel);
			Lua_PushNumber(L, 0);
			return 1;
		}
		bApplied = pSkill->CastStateSkill(Player[nPlayerIndex].m_nIndex,
			0, 0, nTime, bOverLook);

		if (bApplied)
			skillIdStateNumber = nSkillId;
	}
	else
	{
		KMagicAttrib DamageMagicAttribs[MAX_MISSLE_DAMAGEATTRIB];
		memset(DamageMagicAttribs, 0, sizeof(DamageMagicAttribs));
		DamageMagicAttribs[0].nAttribType = magic_attackrating_v;
		DamageMagicAttribs[0].nValue[0] = 0;
		Npc[Player[nPlayerIndex].m_nIndex].SetStateSkillEffect(
			Player[nPlayerIndex].m_nIndex, nSkillId, nSkillLevel,
			DamageMagicAttribs, 1, nTime, bOverLook);
		bApplied = TRUE;
	}
	if (!bApplied)
		g_DebugLog("[LuaAddSkillState] state was not applied player=%d skill=%d level=%d",
			nPlayerIndex, nSkillId, nSkillLevel);
	Lua_PushNumber(L, bApplied ? 1 : 0);
	return 1;
}
//TamLTM Get SkillId state
int LuaGetSkillState(Lua_State* L)
{
	int nResult = 0;
	int nPlayerIndex = 0;
	nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		goto lab_getskillid;

	nResult = skillIdStateNumber;

	lab_getskillid:
	Lua_PushNumber(L, nResult);

	g_DebugLog("nSkillId nResult %d", nResult);

	return 1;
}
//end code

int LuaAddNpcSkillState(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 5)
		return 0;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);

	if (nNpcIndex < 0 || nNpcIndex >= MAX_NPC) return 0;

	int nSkillId = (int)Lua_ValueToNumber(L, 2);
	int nSkillLevel = (int)Lua_ValueToNumber(L, 3);
	int nIfMagic = (int)Lua_ValueToNumber(L, 4);
	int nTime	 = (int)Lua_ValueToNumber(L, 5);

	if (nIfMagic)
	{
		KSkill *pSkill = (KSkill*)g_SkillManager.GetSkill(nSkillId, nSkillLevel);
		pSkill->CastStateSkill(nNpcIndex, 0, 0, nTime, TRUE);
	}
	else
	{
		KMagicAttrib DamageMagicAttribs[MAX_MISSLE_DAMAGEATTRIB];
		memset(DamageMagicAttribs, 0, sizeof(DamageMagicAttribs));
		DamageMagicAttribs[0].nAttribType = magic_attackrating_v;
		DamageMagicAttribs[0].nValue[0] = 0;
		Npc[nNpcIndex].SetStateSkillEffect(nNpcIndex, nSkillId, nSkillLevel, DamageMagicAttribs, 1, nTime, TRUE);
	}
	return 0;
}


int LuaIgnoreState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;
	if (Player[nPlayerIndex].m_nIndex <= 0)
		return 0;
	Npc[Player[nPlayerIndex].m_nIndex].IgnoreState(FALSE);
	return 0;
}

int LuaCastSkill(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 3)
		return 0;

	int nSkillId = (int)Lua_ValueToNumber(L, 1);
	int nSkillLevel = (int)Lua_ValueToNumber(L, 2);
	if (nSkillId < MAX_SKILL && nSkillLevel < MAX_SKILLLEVEL)
		Npc[Player[nPlayerIndex].m_nIndex].Cast(nSkillId, nSkillLevel);
	return 0;
}

int LuaNpcCastSkill(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 3)
		return 0;

	int nNpcIndex = (int)Lua_ValueToNumber(L, 1);
	if (nNpcIndex > 0 || nNpcIndex < MAX_NPC)
	{
		int nSkillId = (int)Lua_ValueToNumber(L, 2);
		int nSkillLevel = (int)Lua_ValueToNumber(L, 3);
		if (nSkillId < MAX_SKILL && nSkillLevel < MAX_SKILLLEVEL)
			Npc[nNpcIndex].Cast(nSkillId, nSkillLevel);
	}
	return 0;
}

int LuaSetMask(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	int nMaskType = (int)Lua_ValueToNumber(L,1);
	if(nMaskType > 0)
	{
		Player[nPlayerIndex].m_ItemList.SetMaskLock(TRUE);
		Npc[Player[nPlayerIndex].m_nIndex].m_MaskType = nMaskType;
	}
	else
	{
		Player[nPlayerIndex].m_ItemList.SetMaskLock(FALSE);
		Npc[Player[nPlayerIndex].m_nIndex].m_MaskType = 0;
	}
	return 0;
}

int LuaAddTrap(Lua_State * L)
{
	int nSubWorldIndex = g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L, 1));

	if (nSubWorldIndex < 0 || nSubWorldIndex >= MAX_SUBWORLD)
		return 0;

	if (SubWorld[nSubWorldIndex].m_Region == NULL)
		return 0;

	int nRegion = -1, nMapX = 0, nMapY = 0, nOffX = 0, nOffY = 0;

	SubWorld[nSubWorldIndex].Mps2Map((int)Lua_ValueToNumber(L, 2), (int)Lua_ValueToNumber(L, 3), &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
	if (nRegion < 0 || nRegion >= SubWorld[nSubWorldIndex].m_nTotalRegion)
		return 0;

	const char* szFile = Lua_ValueToString(L, 4);
	if (!szFile || !szFile[0])
		return 0;

	DWORD dwTrapId = (DWORD)g_FileName2Id((char*)szFile);
	SubWorld[nSubWorldIndex].m_Region[nRegion].SetTrap(dwTrapId, nMapX, nMapY);
	return 0;
}

int LuaAddObj(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 5)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	int nObjID = (int)Lua_ValueToNumber(L,1);
	if (nObjID <= 0 || nObjID >= ObjSet.m_cTabFile.GetHeight())
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nSubWorldIndex	= g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L,2));

	if (nSubWorldIndex == -1)
		return 0;

	KMapPos	Pos;

	Pos.nSubWorld = nSubWorldIndex;
	SubWorld[nSubWorldIndex].Mps2Map((int)Lua_ValueToNumber(L,3),(int)Lua_ValueToNumber(L,4),
	&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
	&Pos.nOffX, &Pos.nOffY);
	KObjItemInfo	sInfo;
	sInfo.m_nItemID = 0;
	sInfo.m_nItemWidth = 0;
	sInfo.m_nItemHeight = 0;
	sInfo.m_nMoneyNum = 0;
	sInfo.m_szName[0] = 0;
	sInfo.m_nColorID = 0;
	sInfo.m_nGenre = 0;
	sInfo.m_nDetailType = 0;
	sInfo.m_nMovieFlag = 1;
	sInfo.m_nSoundFlag = 1;
	sInfo.m_bOverLook = 0;
	int nObj = ObjSet.Add(nObjID, Pos, sInfo);
	if (nObj <= 0) return 0;

	Object[nObj].SetScriptFile((char *)Lua_ValueToString(L,5));
	if (nParamNum > 5)
		Object[nObj].SetImageDir((int)Lua_ValueToNumber(L,6));
	if (nParamNum > 6)
		Object[nObj].SetState((int)Lua_ValueToNumber(L,7));

	Lua_PushNumber(L, nObj);
    return 1;
}

int LuaDelObj(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;

	int nObjIndex = 0;
	if(Lua_GetTopIndex(L) >= 3)
	{
		int nSubWorldIndex	= g_SubWorldSet.SearchWorld((int)Lua_ValueToNumber(L,1));

		if (nSubWorldIndex == -1)
			return 0;

		KMapPos	Pos;

		Pos.nSubWorld = nSubWorldIndex;
		SubWorld[nSubWorldIndex].Mps2Map((int)Lua_ValueToNumber(L,2),(int)Lua_ValueToNumber(L,3),
		&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
		&Pos.nOffX, &Pos.nOffY);
		nObjIndex = ObjSet.SearchObjAt(Pos);
	}
	else
		nObjIndex = (int)Lua_ValueToNumber(L, 1);

	if (nObjIndex > 0)
	{
		Object[nObjIndex].SyncRemove(FALSE);
		if (Object[nObjIndex].m_nRegionIdx >= 0)
			SubWorld[Object[nObjIndex].m_nSubWorldID].m_Region[Object[nObjIndex].m_nRegionIdx].RemoveObj(nObjIndex);
		ObjSet.Remove(nObjIndex);
	}
	return 0;
}

int LuaSetObjScript(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nObjId;
	char* szScriptName;
	nObjId		= (int)Lua_ValueToNumber(L,1);
	szScriptName	= (char *)Lua_ValueToString(L,2);

	if (nObjId > 0)
	{
		if (szScriptName)
		{
			Object[nObjId].SetScriptFile(szScriptName);
			Object[nObjId].m_dwScriptID = g_FileName2Id((char *)Lua_ValueToString(L,2));
		}
	}
    return 0;
}

int LuaSetObjValue(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nId, nValue;
	nId		= (int)Lua_ValueToNumber(L,1);
	nValue	= (int)Lua_ValueToNumber(L,2);

	if (nId > 0)
	{
		Object[nId].SetObjValue(nValue);
	}
    return 0;
}

int LuaGetObjValue(Lua_State * L)
{
	if (Lua_GetTopIndex(L) <= 0 ) return 0 ;
	int nObjIndex = (int)Lua_ValueToNumber(L, 1);
	if (nObjIndex > 0)
	{
		Lua_PushNumber(L, Object[nObjIndex].GetObjValue());
	}
	return 1;
}

int LuaSetObjPickExecute(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nId, nValue;
	nId		= (int)Lua_ValueToNumber(L,1);
	nValue	= (int)Lua_ValueToNumber(L,2);

	if (nId > 0)
	{
		Object[nId].SetObjPickExecute(nValue > 0);
	}
    return 0;
}

int LuaOpenGive(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
		return 0;

	Player[nPlayerIndex].m_szTaskExcuteFun[0] = 0;

	PLAYER_GIVE PGive;
	PGive.ProtocolType = (BYTE)s2c_opengive;
	strcpy(PGive.m_szName, (char *)Lua_ValueToString(L,1));
	strcpy(PGive.m_szInitString, (char *)Lua_ValueToString(L,2));
	strcpy(Player[nPlayerIndex].m_szTaskExcuteFun, (char *)Lua_ValueToString(L, 3));
	Player[nPlayerIndex].m_dwTaskExcuteScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
//	g_DebugLog("(BYTE)s2c_opengive %d", (BYTE)s2c_opengive); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &PGive, sizeof(PLAYER_GIVE));

	return 0;
}

//TamLTM hien thi nhan do da tau VNG
int LuaFinishQuest(Lua_State* L)
{
	if (Lua_GetTopIndex(L) <= 0) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nDT = 0;
	if (Lua_IsNumber(L, 1))
	{
		nDT = (int)Lua_ValueToNumber(L, 1);
	}
	if (nDT)
	{
		FINISH_QUEST_SYNC DTSync;
		DTSync.ProtocolType = s2c_finishquest;
		DTSync.nIdQuestIndex = nDT;
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &DTSync, sizeof(FINISH_QUEST_SYNC));
	}
	return 0;
}
//end code


//TamLTM LuaOpenProgressBar
int LuaOpenProgressBar(Lua_State* L)
{
	if (Lua_GetTopIndex(L) <= 0) return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nPrBar = 0;
	if (Lua_IsNumber(L, 1))
	{
		nPrBar = (int)Lua_ValueToNumber(L, 1);
	}
	if (nPrBar)
	{
		OPEN_PROGRESS_BAR_SYNC ProBarSync;
		ProBarSync.ProtocolType = s2c_openprogressbar;
		ProBarSync.nIdQuestIndex = nPrBar;
		g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &ProBarSync, sizeof(OPEN_PROGRESS_BAR_SYNC));
	}
	return 0;
}
//end code

int LuaRemoveRoom(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Lua_GetTopIndex(L) < 1)
	{
		return 0;
	}
	int nRoom = (int)Lua_ValueToNumber(L, 1);
	if (nRoom < room_equipment || nRoom > room_num)
		return 0;
	Player[nPlayerIndex].m_ItemList.RemoveRoom(nRoom);
	return 0;
}

int LuaCalcFreeItemCellCount(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nWidth = 1;
	int nHeight = 1;
	int nRoom = room_equipment;
	if (Lua_GetTopIndex(L) > 2)
	{
		nWidth = (int)Lua_ValueToNumber(L, 1);
		nHeight = (int)Lua_ValueToNumber(L, 2);
	}
	if (Lua_GetTopIndex(L) > 3)
	{
		nRoom = (int)Lua_ValueToNumber(L, 3);
	}
	if (nRoom < room_equipment || nRoom > room_num)
		return 0;
	int nCount = Player[nPlayerIndex].m_ItemList.CalcFreeItemCellCount(nWidth, nHeight, nRoom);
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaIsNumber(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Lua_IsNumber(L, 1))
	{
		Lua_PushNumber(L,1);
		return 1;
	}
	else
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	return 1;
}

int LuaIsTable(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Lua_IsTable(L, 1))
	{
		Lua_PushNumber(L,1);
		return 1;
	}
	else
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	return 1;
}

int LuaOpenURL(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Lua_IsString(L, 1))
	{
		ShellExecute(NULL,"open",(char*)Lua_ValueToString(L,1),NULL,NULL,SW_SHOWNORMAL);
		return 0;
	}
	return 0;
}

int LuaOpenExplore(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Lua_IsString(L, 1))
	{
		ShellExecute(NULL,"explore",(char*)Lua_ValueToString(L,1),NULL,NULL,SW_SHOWNORMAL);
		return 0;
	}
	return 0;
}

int LuaModifyAttrib(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 5)
		return 0;
	KNpc *pNPC = &Npc[Player[nPlayerIndex].m_nIndex];
	KMagicAttrib pBaseAttrib;
	pBaseAttrib.nAttribType = (int)Lua_ValueToNumber(L, 1);
	pBaseAttrib.nValue[0] = (int)Lua_ValueToNumber(L, 2);
	pBaseAttrib.nValue[1] = (int)Lua_ValueToNumber(L, 3);
	pBaseAttrib.nValue[2] = (int)Lua_ValueToNumber(L, 4);
	KMagicAttrib *pAttrib = &pBaseAttrib;
	if (-1 != pAttrib->nAttribType)
	{
		pNPC->ModifyAttrib(pNPC->m_Index, (void *)pAttrib);
	}
	return 0;
}


int LuaRANDOM(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);

	if (nParamNum < 1)
		return 0;
	int nResult = 0;
	if (nParamNum > 1)
		nResult = GetRandomNumber((int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2));
	else
		nResult = GetRandomNumber(0, (int)Lua_ValueToNumber(L, 1));
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaRANDOMC(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);

	if (nParamNum < 2)
		return 0;

	srand( (unsigned)time( NULL ) );
	if (Lua_IsTable(L,1))
	{
		Lua_PushNumber(L, (int)Lua_ValueToNumber(L,2));
		Lua_RawGet(L, 1);
		Lua_PushNumber(L, (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L)));
	}
	else if (Lua_IsTable(L,2))
	{
		int nResult = ::GetRandomNumber(1, (int)Lua_ValueToNumber(L,1));
		Lua_PushNumber(L, nResult);
		Lua_RawGet(L, 2);
		Lua_PushNumber(L, (int)Lua_ValueToNumber(L, (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L))));
	}
	else
	{
		int nResult = ::GetRandomNumber(1, nParamNum);
		Lua_PushNumber(L, (int)Lua_ValueToNumber(L, nResult));
	}
	return 1;
}

int LuaIsMyItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER &&
		Player[nPlayerIndex].m_nIndex > 0 &&
		Player[nPlayerIndex].m_nIndex < MAX_NPC)
	{
		if (Lua_GetTopIndex(L) >= 1)
		{
			int nGameIdx = (int)Lua_ValueToNumber(L, 1);
			if (nGameIdx > 0 && nGameIdx < MAX_ITEM &&
				Item[nGameIdx].GetID() != 0 &&
				Player[nPlayerIndex].m_ItemList.SearchID(Item[nGameIdx].GetID()))
				nResult = 1;
			else if (nGameIdx <= 0 || nGameIdx >= MAX_ITEM)
				g_DebugLog("[LuaIsMyItem] invalid item index player=%d item=%d",
					nPlayerIndex, nGameIdx);
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}
// Phong Than 2026-10-04 hanhtrang: PTItemSaleInfo(nItemIdx) for the "Don tui" of the Lenh Bai Hanh Trang
// (script\phongthan\item\hanhtrang_*.lua). Nothing when the item is not the script player's. Else 4 numbers:
// place (pos_equiproom = 3 is the bag), quality (KItem::GetQuality: 0 white, 1 magic, 2 broken, 3 set),
// money of a shop sale (exactly KBuySell::Sell: GetSalePrice() * GetStackNum()), 1 if a shop would buy it
// (not locked, not lock-sell; KBuySell::Sell refuses those). The script removes the item (RemoveItem) and
// pays the money (Earn) itself; this function changes nothing.
int LuaPTItemSaleInfo(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER || Lua_GetTopIndex(L) < 1)
		return 0;
	int nGameIdx = (int)Lua_ValueToNumber(L, 1);
	if (nGameIdx <= 0 || nGameIdx >= MAX_ITEM || Item[nGameIdx].GetID() == 0)
		return 0;
	int nList = Player[nPlayerIndex].m_ItemList.FindSame(nGameIdx);
	if (!nList)
		return 0;
	Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nList].nPlace);
	Lua_PushNumber(L, Item[nGameIdx].GetQuality());
	Lua_PushNumber(L, Item[nGameIdx].GetSalePrice() * Item[nGameIdx].GetStackNum());
	Lua_PushNumber(L, (Item[nGameIdx].GetLock()->IsLock() || Item[nGameIdx].GetLockSell()) ? 0 : 1);
	return 4;
}
int LuaInput(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER) return 0;
	int nParamNum = Lua_GetTopIndex(L);
    if (Player[nPlayerIndex].m_nIndex <= 0 || Player[nPlayerIndex].m_nIndex >= MAX_NPC) return 0;
    if (Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID == 0) return 0;
	if (nParamNum < 2)
		return 0;

	Player[nPlayerIndex].m_dwTaskExcuteScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
	strcpy(Player[nPlayerIndex].m_szTaskExcuteFun, (char *)Lua_ValueToString(L,1));
	int max = 0;
	if(nParamNum > 2)
		max=(int)Lua_ValueToNumber(L,2);

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Operation = PHONGTHAN_PLAYER_INPUT_PANEL;
	sMsg.Value = max;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));

	return 0;
}

/*//TamLTM fix send packet
int LuaInput(Lua_State* L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	Player[nPlayerIndex].m_dwTaskExcuteScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;
	strcpy(Player[nPlayerIndex].m_szTaskExcuteFun, (char*)Lua_ValueToString(L, 1));
	int max = 0;
	if (nParamNum > 2)
		max = (int)Lua_ValueToNumber(L, 2);

	S2C_PLAYER_SYNC_INPUT	sMsg;
	sMsg.ProtocolType = s2c_playersyncinput;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_INPUT) - 1;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_INPUT;
	sMsg.m_lpBuf = (LPVOID)max;
	//	g_DebugLog("s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

	return 0;
}
//end code */

int LuaGetInput(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	Lua_PushString(L, Player[nPlayerIndex].m_szLastInput);
	return 1;
}

int LuaOpenEnchase(Lua_State * L) //Ep do tim
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Operation = PHONGTHAN_PLAYER_ENCHASE_PANEL;
	sMsg.Value = 0;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));
	return 0;
}

/*//TamLTM fix send packet
int LuaOpenEnchase(Lua_State* L) //Ep do tim
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;

	S2C_PLAYER_SYNC_ENCHASE	sMsg;
	sMsg.ProtocolType = s2c_playersyncopenenchase;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_ENCHASE) - 1;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_ENCHASE;
	sMsg.m_lpBuf = 0;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
	return 0;
}
//end code */

int LuaEnchase(Lua_State * L) // Nhan test do tim
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0)
		return 0;
	Player[nPlayerIndex].Enchase(2,(int)Lua_ValueToNumber(L,1),(int)Lua_ValueToNumber(L,2),(int)Lua_ValueToNumber(L,3)); // 3 thong so item get do tim
	return 0;
}


int LuaCheckRoom(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nIndex, nWidth = 0, nHeight = 0;;

	if (Lua_GetTopIndex(L) >= 2)
	{
		nIndex = (int)Lua_ValueToNumber(L,1);
		nWidth = Item[nIndex].GetWidth();
		nHeight = Item[nIndex].GetHeight();
	}
	if (Lua_GetTopIndex(L) >= 3)
	{
		nWidth = (int)Lua_ValueToNumber(L,1);
		nHeight = (int)Lua_ValueToNumber(L,2);
	}
	if (nPlayerIndex <= 0)
		return 0;

	if (nWidth <= 0 || nHeight <= 0)
		return 0;

	POINT ItemSize;
	ItemSize.x = nWidth;
	ItemSize.y = nHeight;
	ItemPos	sItemPos;
	if ( FALSE == Player[nPlayerIndex].m_ItemList.SearchPosition(ItemSize, &sItemPos) )
		Lua_PushNumber(L, 0);
	else
		Lua_PushNumber(L, 1);

	return 1;
}

int LuaSendMessageInfo(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1)
		return 0;

	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex < 0) return 0;

	KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
	UiInfo.View = UI_MSGINFO;
	UiInfo.OptionCount = 1;
	UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
	UiInfo.NumberArgument = SMT_NORMAL;
	UiInfo.AuxiliaryArgument = SMCT_NONE;
	if(nParamNum > 1)
		UiInfo.NumberArgument = (int)Lua_ValueToNumber(L,2);
	if(nParamNum > 2)
		UiInfo.AuxiliaryArgument = (int)Lua_ValueToNumber(L,3);

	int nMsgId = 0;

	if (Lua_IsNumber(L,1))
	{
		nMsgId = (int)Lua_ValueToNumber(L,1);
		*((int *)(UiInfo.Content)) = nMsgId;
		UiInfo.ResourceText = 1;
		UiInfo.ContentLength = sizeof(int);
	}
	else
	{

		g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), 256);
		UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
		UiInfo.ResourceText = 0;
	}

#ifndef _SERVER
	UiInfo.ServerOwned = 0;
#else
	UiInfo.ServerOwned = 1;
#endif
	Player[nPlayerIndex].DoScriptAction(&UiInfo);
	return 0;
}

// Phong Than VNG UI/time/global compatibility (P0.3.3).
static int LuaSendPhongThanPlayerText(Lua_State * L, int nUiId)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
        return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;
    UiInfo.View = (BYTE)nUiId;

    if (Lua_IsNumber(L, 1))
    {
        *(int *)UiInfo.Content = (int)Lua_ValueToNumber(L, 1);
        UiInfo.ResourceText = 1;
        UiInfo.ContentLength = sizeof(int);
    }
    else if (Lua_IsString(L, 1))
    {
        g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L, 1), sizeof(UiInfo.Content));
        UiInfo.ResourceText = 0;
        UiInfo.ContentLength = strlen(UiInfo.Content);
    }
    else
    {
        return 0;
    }

#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

int LuaTopMessage(Lua_State * L)
{
    return LuaSendPhongThanPlayerText(L, UI_TOPMESSAGE);
}

int LuaScrollMessage(Lua_State * L)
{
    return LuaSendPhongThanPlayerText(L, UI_SCROLLMESSAGE);
}

int LuaCloseDialog(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
        return 0;

    Player[nPlayerIndex].m_bWaitingPlayerFeedBack = false;
    Player[nPlayerIndex].m_nAvailableAnswerNum = 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.Operation = PHONGTHAN_SCRIPT_CLOSE;
#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif
    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

// VNG IBItem scripts use SetExeState as an execution-result marker. Item
// consumption is explicit through CostIBItem in this runtime, while Say and
// CloseDialog own the dialog wait state, so this compatibility API must not
// alter either state.
int LuaSetExeStateCompat(Lua_State * L)
{
    int nState = Lua_GetTopIndex(L) >= 1 ?
        (int)Lua_ValueToNumber(L, 1) : 0;
    Lua_PushNumber(L, nState);
    return 1;
}

int LuaWriteLog(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1 || !Lua_IsString(L, 1))
        return 0;

    const char *pszMessage = Lua_ValueToString(L, 1);
    if (!pszMessage)
        return 0;

    FILE *pLog = fopen("script_runtime.log", "a+b");
    if (pLog)
    {
        time_t rawtime;
        time(&rawtime);
        struct tm *pLocalTime = localtime(&rawtime);
        if (pLocalTime)
        {
            fprintf(pLog, "%04d-%02d-%02d %02d:%02d:%02d [Lua] %s\r\n",
                pLocalTime->tm_year + 1900, pLocalTime->tm_mon + 1,
                pLocalTime->tm_mday, pLocalTime->tm_hour,
                pLocalTime->tm_min, pLocalTime->tm_sec, pszMessage);
        }
        else
        {
            fprintf(pLog, "[Lua] %s\r\n", pszMessage);
        }
        fclose(pLog);
    }
    return 0;
}

int LuaSystemTime(Lua_State * L)
{
    time_t rawtime;
    time(&rawtime);
    Lua_PushNumber(L, (double)rawtime);
    return 1;
}

int LuaLocalSystemTime(Lua_State * L)
{
    time_t rawtime;
    time(&rawtime);

    struct tm *pLocal = localtime(&rawtime);
    if (!pLocal)
    {
        Lua_PushNumber(L, (double)rawtime);
        return 1;
    }
    struct tm localTime = *pLocal;

    struct tm *pUtc = gmtime(&rawtime);
    if (!pUtc)
    {
        Lua_PushNumber(L, (double)rawtime);
        return 1;
    }
    struct tm utcTime = *pUtc;
    utcTime.tm_isdst = localTime.tm_isdst;

    time_t localEpoch = mktime(&localTime);
    time_t utcAsLocalEpoch = mktime(&utcTime);
    double utcOffset = difftime(localEpoch, utcAsLocalEpoch);
    Lua_PushNumber(L, (double)rawtime + utcOffset);
    return 1;
}

int LuaGetGlobalValue(Lua_State * L)
{
    int nIndex = (int)Lua_ValueToNumber(L, 1);
    int nValue = 0;
    if (nIndex >= 0 && nIndex < TASKGLOBALVALUENUM)
        nValue = g_TaskGlobalValue[nIndex];
    Lua_PushNumber(L, nValue);
    return 1;
}

int LuaSetGlobalValue(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 2)
        return 0;
    int nIndex = (int)Lua_ValueToNumber(L, 1);
    if (nIndex >= 0 && nIndex < TASKGLOBALVALUENUM)
        g_TaskGlobalValue[nIndex] = (int)Lua_ValueToNumber(L, 2);
    return 0;
}

// Phong Than VNG Lua completion campaign - Wave 1.
// These functions preserve the VNG call contracts while keeping the server as
// the authoritative owner of player, subworld and global-value state.
static int LuaGetLocalTimeParts(Lua_State *L, BOOL bDate)
{
    time_t rawtime;
    time(&rawtime);
    struct tm *pTime = localtime(&rawtime);
    if (!pTime)
        return 0;
    if (bDate)
    {
        Lua_PushNumber(L, pTime->tm_year + 1900);
        Lua_PushNumber(L, pTime->tm_mon + 1);
        Lua_PushNumber(L, pTime->tm_mday);
    }
    else
    {
        Lua_PushNumber(L, pTime->tm_hour);
        Lua_PushNumber(L, pTime->tm_min);
        Lua_PushNumber(L, pTime->tm_sec);
    }
    return 3;
}

int LuaGetYMD(Lua_State *L)
{
    return LuaGetLocalTimeParts(L, TRUE);
}

int LuaGetHMS(Lua_State *L)
{
    return LuaGetLocalTimeParts(L, FALSE);
}

int LuaGetWeekDayCompat(Lua_State *L)
{
    time_t rawtime;
    time(&rawtime);
    struct tm *pTime = localtime(&rawtime);
    Lua_PushNumber(L, pTime ? pTime->tm_wday : 0);
    return 1;
}

int LuaGetGameServerNameCompat(Lua_State *L)
{
    char szServerName[128];
    szServerName[0] = 0;
    g_GameSetting.GetString("ServerConfig", "GameServerName", "", szServerName, sizeof(szServerName));
    if (!szServerName[0])
        g_GameSetting.GetString("ServerConfig", "ServerName", "", szServerName, sizeof(szServerName));
#ifndef __linux
    if (!szServerName[0])
    {
        DWORD dwSize = sizeof(szServerName);
        GetComputerName(szServerName, &dwSize);
    }
#else
    if (!szServerName[0])
        gethostname(szServerName, sizeof(szServerName));
#endif
    szServerName[sizeof(szServerName) - 1] = 0;
    Lua_PushString(L, szServerName);
    return 1;
}

int LuaIsWarServerCompat(Lua_State *L)
{
    int nWarServer = 0;
    g_GameSetting.GetInteger("ServerConfig", "IsWarServer", 0, &nWarServer);
    Lua_PushNumber(L, nWarServer ? 1 : 0);
    return 1;
}

static BOOL GetGlobalValueSlot(Lua_State *L, int nOrdinalMax, int *pnIndex, int *pnOrdinal)
{
    if (Lua_GetTopIndex(L) < 2)
        return FALSE;
    int nIndex = (int)Lua_ValueToNumber(L, 1);
    int nOrdinal = (int)Lua_ValueToNumber(L, 2);
    if (nIndex < 0 || nIndex >= TASKGLOBALVALUENUM || nOrdinal < 1 || nOrdinal > nOrdinalMax)
        return FALSE;
    *pnIndex = nIndex;
    *pnOrdinal = nOrdinal;
    return TRUE;
}

int LuaGetGlobalValueByteCompat(Lua_State *L)
{
    int nIndex = 0, nOrdinal = 0;
    unsigned int uValue = 0;
    if (GetGlobalValueSlot(L, 4, &nIndex, &nOrdinal))
        uValue = ((unsigned int)g_TaskGlobalValue[nIndex] >> ((nOrdinal - 1) * 8)) & 0xff;
    Lua_PushNumber(L, uValue);
    return 1;
}

int LuaSetGlobalValueByteCompat(Lua_State *L)
{
    int nIndex = 0, nOrdinal = 0;
    if (Lua_GetTopIndex(L) >= 3 && GetGlobalValueSlot(L, 4, &nIndex, &nOrdinal))
    {
        unsigned int nShift = (nOrdinal - 1) * 8;
        unsigned int nMask = 0xffU << nShift;
        unsigned int nValue = ((unsigned int)Lua_ValueToNumber(L, 3) & 0xffU) << nShift;
        g_TaskGlobalValue[nIndex] = (int)(((unsigned int)g_TaskGlobalValue[nIndex] & ~nMask) | nValue);
    }
    return 0;
}

int LuaGetGlobalValueWordCompat(Lua_State *L)
{
    int nIndex = 0, nOrdinal = 0;
    unsigned int uValue = 0;
    if (GetGlobalValueSlot(L, 2, &nIndex, &nOrdinal))
        uValue = ((unsigned int)g_TaskGlobalValue[nIndex] >> ((nOrdinal - 1) * 16)) & 0xffff;
    Lua_PushNumber(L, uValue);
    return 1;
}

int LuaSetGlobalValueWordCompat(Lua_State *L)
{
    int nIndex = 0, nOrdinal = 0;
    if (Lua_GetTopIndex(L) >= 3 && GetGlobalValueSlot(L, 2, &nIndex, &nOrdinal))
    {
        unsigned int nShift = (nOrdinal - 1) * 16;
        unsigned int nMask = 0xffffU << nShift;
        unsigned int nValue = ((unsigned int)Lua_ValueToNumber(L, 3) & 0xffffU) << nShift;
        g_TaskGlobalValue[nIndex] = (int)(((unsigned int)g_TaskGlobalValue[nIndex] & ~nMask) | nValue);
    }
    return 0;
}

int LuaGetIPValueCompat(Lua_State *L)
{
    DWORD dwAddress = 0;
#ifdef _SERVER
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER && g_pServer)
    {
        const char *pszAddress = g_pServer->GetClientInfo(Player[nPlayerIndex].m_nNetConnectIdx);
        if (pszAddress && pszAddress[0])
        {
            DWORD dwParsed = _a2ip(pszAddress);
            if (dwParsed != INADDR_NONE)
                dwAddress = dwParsed;
        }
    }
#endif
    Lua_PushNumber(L, (double)dwAddress);
    return 1;
}

int LuaPCallCompat(Lua_State *L)
{
    int nArgs = Lua_GetTopIndex(L) - 1;
    if (nArgs < 0 || Lua_GetValueType(L, 1) != LUA_TFUNCTION)
    {
        Lua_SetTopIndex(L, 0);
        Lua_PushNil(L);
        Lua_PushString(L, "pcall expects a function");
        return 2;
    }
    int nStatus = Lua_Call(L, nArgs, LUA_MULTRET);
    if (nStatus != 0)
    {
        Lua_SetTopIndex(L, 0);
        Lua_PushNil(L);
        Lua_PushNumber(L, nStatus);
        return 2;
    }
    int nResults = Lua_GetTopIndex(L);
    Lua_PushNumber(L, 1);
    Lua_InsertValue(L, 1);
    return nResults + 1;
}

static int LuaIPairsIteratorCompat(Lua_State *L)
{
    if (!Lua_IsTable(L, 1))
        return 0;
    int nOrdinal = (int)Lua_ValueToNumber(L, 2) + 1;
    Lua_RawGetI(L, 1, nOrdinal);
    if (lua_isnil(L, Lua_GetTopIndex(L)))
        return 0;
    Lua_PushNumber(L, nOrdinal);
    Lua_InsertValue(L, -2);
    return 2;
}

int LuaIPairsCompat(Lua_State *L)
{
    if (!Lua_IsTable(L, 1))
        return 0;
    Lua_PushCFunction(L, LuaIPairsIteratorCompat);
    Lua_PushValue(L, 1);
    Lua_PushNumber(L, 0);
    return 3;
}

static void SendMapAnnouncement(int nSubWorldIndex, const char *pszMessage)
{
#ifdef _SERVER
    if (nSubWorldIndex < 0 || nSubWorldIndex >= MAX_SUBWORLD || !pszMessage || !pszMessage[0])
        return;
    int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
    while (nPlayerIndex > 0)
    {
        int nNpcIndex = Player[nPlayerIndex].m_nIndex;
        if (nNpcIndex > 0 && nNpcIndex < MAX_NPC && Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex)
            KPlayerChat::SendSystemInfo(1, nPlayerIndex, MESSAGE_BROADCAST_ANNOUCE_HEAD,
                (char *)pszMessage, strlen(pszMessage));
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
    }
#endif
}

int LuaMsg2CurMapAnnounceEx(Lua_State *L)
{
    if (Lua_GetTopIndex(L) >= 2 && Lua_IsString(L, 2))
    {
        int nSubWorldIndex = g_SubWorldSet.SearchWorld((DWORD)Lua_ValueToNumber(L, 1));
        SendMapAnnouncement(nSubWorldIndex, Lua_ValueToString(L, 2));
    }
    return 0;
}

int LuaMsg2CurMapAnnounce(Lua_State *L)
{
    if (Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1))
    {
        int nPlayerIndex = GetPlayerIndex(L);
        if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER)
        {
            int nNpcIndex = Player[nPlayerIndex].m_nIndex;
            if (nNpcIndex > 0 && nNpcIndex < MAX_NPC)
                SendMapAnnouncement(Npc[nNpcIndex].m_SubWorldIndex, Lua_ValueToString(L, 1));
        }
    }
    return 0;
}



int LuaNpcSayCompat(Lua_State *L)
{
    return LuaNpcChat(L);
}

int LuaInfoBoxCompat(Lua_State *L)
{
    return LuaSendMessageInfo(L);
}

int LuaGetDialogNpcNameCompat(Lua_State *L)
{
    int nNpcIndex = 0;
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER)
        nNpcIndex = Player[nPlayerIndex].m_nLastNpcIndex;
    if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
    {
        int nTop = Lua_GetTopIndex(L);
        Lua_GetGlobal(L, "NpcIndex");
        if (Lua_IsNumber(L, Lua_GetTopIndex(L)))
            nNpcIndex = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));
        Lua_SetTopIndex(L, nTop);
    }
    Lua_PushString(L, (nNpcIndex > 0 && nNpcIndex < MAX_NPC) ? Npc[nNpcIndex].Name : "");
    return 1;
}

int LuaSearchPlayerByIdCompat(Lua_State *L)
{
    DWORD dwPlayerId = Lua_GetTopIndex(L) >= 1 ? (DWORD)Lua_ValueToNumber(L, 1) : 0;
    Lua_PushNumber(L, dwPlayerId ? PlayerSet.FindSame(dwPlayerId) : 0);
    return 1;
}

int LuaGetPlayerIndexByNameCompat(Lua_State *L)
{
    const char *pszName = Lua_GetTopIndex(L) >= 1 ? Lua_ValueToString(L, 1) : NULL;
    int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
    while (nPlayerIndex > 0)
    {
        if (pszName && strcmp(Player[nPlayerIndex].Name, pszName) == 0)
            break;
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
    }
    Lua_PushNumber(L, nPlayerIndex);
    return 1;
}

int LuaGetSubWorldPlayerCountCompat(Lua_State *L)
{
    int nSubWorldIndex = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nCount = 0;
    if (nSubWorldIndex >= 0 && nSubWorldIndex < MAX_SUBWORLD)
    {
        int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
        while (nPlayerIndex > 0)
        {
            int nNpcIndex = Player[nPlayerIndex].m_nIndex;
            if (nNpcIndex > 0 && nNpcIndex < MAX_NPC && Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex)
                ++nCount;
            nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
        }
    }
    Lua_PushNumber(L, nCount);
    return 1;
}

int LuaGetSubWorldPlayerIdxByNumCompat(Lua_State *L)
{
    int nSubWorldIndex = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nOrdinal = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    int nPlayerIndex = 0;
    if (nSubWorldIndex >= 0 && nSubWorldIndex < MAX_SUBWORLD && nOrdinal > 0)
    {
        int nSeen = 0;
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
        while (nPlayerIndex > 0)
        {
            int nNpcIndex = Player[nPlayerIndex].m_nIndex;
            if (nNpcIndex > 0 && nNpcIndex < MAX_NPC && Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex && ++nSeen == nOrdinal)
                break;
            nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
        }
    }
    Lua_PushNumber(L, nPlayerIndex);
    return 1;
}

int LuaGetFirstPlayerInAllCompat(Lua_State *L)
{
    Lua_PushNumber(L, PlayerSet.GetFirstPlayer());
    return 1;
}

int LuaGetNextPlayerInAllCompat(Lua_State *L)
{
    Lua_PushNumber(L, PlayerSet.GetNextPlayer());
    return 1;
}

int LuaGetSessionNextPlayerCompat(Lua_State *L)
{
    int nCursor = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nSubWorldIndex = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    if (nSubWorldIndex == 0)
    {
        int nCurrentPlayer = GetPlayerIndex(L);
        if (nCurrentPlayer > 0 && nCurrentPlayer < MAX_PLAYER)
        {
            int nNpcIndex = Player[nCurrentPlayer].m_nIndex;
            if (nNpcIndex > 0 && nNpcIndex < MAX_NPC)
                nSubWorldIndex = Npc[nNpcIndex].m_SubWorldIndex;
        }
    }
    int nPlayerIndex = PlayerSet.GetNextPlayerFrom(nCursor);
    while (nPlayerIndex > 0)
    {
        int nNpcIndex = Player[nPlayerIndex].m_nIndex;
        if (nNpcIndex > 0 && nNpcIndex < MAX_NPC &&
            (nSubWorldIndex < 0 || Npc[nNpcIndex].m_SubWorldIndex == nSubWorldIndex))
            break;
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
    }
    Lua_PushNumber(L, nPlayerIndex);
    Lua_PushNumber(L, nPlayerIndex);
    return 2;
}

int LuaPlayerIndexToNpcIndexCompat(Lua_State *L)
{
    int nPlayerIndex = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nNpcIndex = 0;
    if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER)
    {
        int nCandidate = Player[nPlayerIndex].m_nIndex;
        if (nCandidate > 0 && nCandidate < MAX_NPC)
            nNpcIndex = nCandidate;
    }
    Lua_PushNumber(L, nNpcIndex);
    return 1;
}

// Phong Than VNG Lua completion campaign - Wave 2.
static BOOL GetVngNormalTuple(Lua_State *L, int nStart,
    int *pnGenre, int *pnDetail, int *pnLevel, int *pnSeries, int *pnParticular)
{
    if (Lua_GetTopIndex(L) < nStart + 3)
        return FALSE;
    int nRuntimeGenre = -1;
    int nRuntimeDetail = -1;
    if (!MapVngNormalItemTuple(
        (int)Lua_ValueToNumber(L, nStart),
        (int)Lua_ValueToNumber(L, nStart + 1),
        (int)Lua_ValueToNumber(L, nStart + 2),
        &nRuntimeGenre, &nRuntimeDetail))
        return FALSE;
    *pnGenre = nRuntimeGenre;
    *pnDetail = nRuntimeDetail;
    PhongThanQuestItemTuple identity;
    if(!PhongThanMapQuestItemIdentity((int)Lua_ValueToNumber(L,nStart),
        (int)Lua_ValueToNumber(L,nStart+1),(int)Lua_ValueToNumber(L,nStart+2),identity))return FALSE;
    *pnParticular=identity.particular;
    *pnLevel = (int)Lua_ValueToNumber(L, nStart + 3);
    *pnSeries = Lua_GetTopIndex(L) >= nStart + 4 ? (int)Lua_ValueToNumber(L, nStart + 4) : -1;
    return TRUE;
}

static BOOL MatchVngOwnedItem(int nGameIndex, int nGenre, int nDetail,
    int nLevel, int nSeries, int nParticular=-1)
{
    if (nGameIndex <= 0 || nGameIndex >= MAX_ITEM || Item[nGameIndex].GetID() == 0)
        return FALSE;
	if (Item[nGameIndex].GetGenre() != nGenre ||
        Item[nGameIndex].GetDetailType() != nDetail)
        return FALSE;
    if(nParticular>=0 && Item[nGameIndex].GetParticular()!=nParticular)return FALSE;
    if (nLevel >= 0 && Item[nGameIndex].GetLevel() != nLevel)
        return FALSE;
    if (nSeries > 0 && Item[nGameIndex].GetSeries() != nSeries)
        return FALSE;
    return TRUE;
}

static int CountVngOwnedItems(int nPlayerIndex, int nGenre, int nDetail,
    int nLevel, int nSeries, int nPlace, int nParticular=-1)
{
    int nCount = 0;
    PlayerItem *pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
    while (pOwned)
    {
        if ((nPlace < 0 || pOwned->nPlace == nPlace) &&
            MatchVngOwnedItem(pOwned->nIdx, nGenre, nDetail, nLevel, nSeries,nParticular))
            nCount += Item[pOwned->nIdx].IsStack() ? Item[pOwned->nIdx].GetStackNum() : 1;
        pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
    }
    return nCount;
}

static int AddVngNormalItemToInventory(int nPlayerIndex, int nGenre, int nDetail,
    int nParticular, int nLevel, int nSeries, int nLuck, BOOL bAutoStack, BOOL bBind)
{
    int nGameIndex = CreateVngNormalItem(nGenre, nDetail, nParticular,
        nLevel, nSeries, nLuck);
    if (nGameIndex <= 0)
        return 0;
    if (bBind)
        Item[nGameIndex].LockItem(LOCK_STATE_FOREVER);
    POINT itemSize;
    itemSize.x = Item[nGameIndex].GetWidth();
    itemSize.y = Item[nGameIndex].GetHeight();
    int nOwnedIndex = Player[nPlayerIndex].m_ItemList.Add(nGameIndex, itemSize, bAutoStack != FALSE);
    if (nOwnedIndex <= 0)
    {
        ItemSet.Remove(nGameIndex);
        return 0;
    }
#ifdef _SERVER
    if (bBind && nGameIndex > 0 && nGameIndex < MAX_ITEM && Item[nGameIndex].GetID() != 0)
        Player[nPlayerIndex].m_ItemList.SyncItem(nGameIndex);
#endif
    return nOwnedIndex;
}

int LuaHaveNormalItemCompat(Lua_State *L)
{
    // GetPlayerIndex pushes its global onto the Lua stack. Do not interpret
    // that value as the optional fifth (series) argument of a four-field tuple.
    const int nArgumentCount = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    Lua_SetTopIndex(L, nArgumentCount);
    int nGenre = -1, nDetail = -1, nLevel = -1, nSeries = -1, nParticular = -1;
    int nCount = 0;
    if (nPlayerIndex > 0 && GetVngNormalTuple(L, 1, &nGenre, &nDetail, &nLevel, &nSeries, &nParticular))
        nCount = CountVngOwnedItems(nPlayerIndex, nGenre, nDetail, nLevel, nSeries, -1, nParticular);
    Lua_PushNumber(L, nCount);
    return 1;
}

int LuaAddNormalItemPileCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 6)
        nResult = AddVngNormalItemToInventory(nPlayerIndex,
            (int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2),
            (int)Lua_ValueToNumber(L, 3), (int)Lua_ValueToNumber(L, 4),
            (int)Lua_ValueToNumber(L, 5), (int)Lua_ValueToNumber(L, 6), TRUE, FALSE);
    Lua_PushNumber(L, nResult);
    return 1;
}

static int GetInventoryFreeCells(int nPlayerIndex)
{
    return Player[nPlayerIndex].m_ItemList.CalcFreeItemCellCount(1, 1, room_equipment);
}

int LuaIsHaveSpaceForTreasureCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nRequired = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 1;
    if (nRequired < 1)
        nRequired = 1;
    Lua_PushNumber(L, nPlayerIndex > 0 && GetInventoryFreeCells(nPlayerIndex) >= nRequired ? 1 : 0);
    return 1;
}

static int CountVngEventItems(int nPlayerIndex, int nDetail)
{
    return CountVngOwnedItems(nPlayerIndex, item_task, nDetail, -1, -1, -1);
}

int LuaAddEventItemCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nDetail = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nResult = 0;
    // VNG EventItem IDs in the audited scripts are sparse QuestKey IDs.  The
    // authoritative item\001\questkey.txt loader resolves them by DetailType.
    if (nPlayerIndex > 0 && nDetail >= 0)
        nResult = AddVngNormalItemToInventory(nPlayerIndex, item_task, nDetail,
            0, 0, 0, 0, TRUE, FALSE);
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaHaveEventItemCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nDetail = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    Lua_PushNumber(L, nPlayerIndex > 0 && nDetail >= 0 && CountVngEventItems(nPlayerIndex, nDetail) > 0 ? 1 : 0);
    return 1;
}

int LuaHaveEventItemCountCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nDetail = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    Lua_PushNumber(L, nPlayerIndex > 0 && nDetail >= 0 ? CountVngEventItems(nPlayerIndex, nDetail) : 0);
    return 1;
}

static int RemoveVngItems(int nPlayerIndex, int nGenre, int nDetail,
    int nLevel, int nSeries, int nPlace, BOOL bRemoveAll, int nParticular=-1)
{
#ifdef _SERVER
    int nRemoved = 0;
    while (TRUE)
    {
        int nGameIndex = 0;
        PlayerItem *pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
        while (pOwned)
        {
            if ((nPlace < 0 || pOwned->nPlace == nPlace) &&
                MatchVngOwnedItem(pOwned->nIdx, nGenre, nDetail, nLevel, nSeries,nParticular))
            {
                nGameIndex = pOwned->nIdx;
                break;
            }
            pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
        }
        if (nGameIndex <= 0)
            break;
        if (!bRemoveAll && Item[nGameIndex].IsStack() && Item[nGameIndex].GetStackNum() > 1)
        {
            Item[nGameIndex].SetStackNum(Item[nGameIndex].GetStackNum() - 1);
            Player[nPlayerIndex].m_ItemList.SyncItem(nGameIndex);
            ++nRemoved;
            break;
        }
        int nAmount = Item[nGameIndex].IsStack() ? Item[nGameIndex].GetStackNum() : 1;
        if (!Player[nPlayerIndex].m_ItemList.Remove(nGameIndex))
            break;
        ItemSet.Remove(nGameIndex);
        nRemoved += bRemoveAll ? nAmount : 1;
        if (!bRemoveAll)
            break;
    }
    return nRemoved;
#else
    return 0;
#endif
}

int LuaClearItemCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nGenre = -1, nDetail = -1, nLevel = -1, nSeries = -1, nParticular = -1;
    int nRemoved = 0;
    if (nPlayerIndex > 0 && GetVngNormalTuple(L, 1, &nGenre, &nDetail, &nLevel, &nSeries, &nParticular))
        nRemoved = RemoveVngItems(nPlayerIndex, nGenre, nDetail, nLevel, nSeries, -1, TRUE, nParticular);
    Lua_PushNumber(L, nRemoved);
    return 1;
}

int LuaDelNormalItemCompat(Lua_State *L)
{
    // Match HaveNormalItem: only caller-supplied tuple fields may filter items.
    const int nArgumentCount = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    Lua_SetTopIndex(L, nArgumentCount);
    int nGenre = -1, nDetail = -1, nLevel = -1, nSeries = -1, nParticular = -1;
    int nRemoved = 0;
    if (nPlayerIndex > 0 && GetVngNormalTuple(L, 1, &nGenre, &nDetail, &nLevel, &nSeries, &nParticular))
        nRemoved = RemoveVngItems(nPlayerIndex, nGenre, nDetail, nLevel, nSeries, pos_equiproom, FALSE, nParticular);
    Lua_PushNumber(L, nRemoved);
    return 1;
}

int LuaAddNormalItemBindCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 6)
        nResult = AddVngNormalItemToInventory(nPlayerIndex,
            (int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2),
            (int)Lua_ValueToNumber(L, 3), (int)Lua_ValueToNumber(L, 4),
            (int)Lua_ValueToNumber(L, 5), (int)Lua_ValueToNumber(L, 6), TRUE, TRUE);
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaHaveItemInAllRoomCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nGenre = -1, nDetail = -1, nLevel = -1, nSeries = -1, nParticular = -1;
    int nCount = 0;
    if (nPlayerIndex > 0 && GetVngNormalTuple(L, 1, &nGenre, &nDetail, &nLevel, &nSeries, &nParticular))
        nCount = CountVngOwnedItems(nPlayerIndex, nGenre, nDetail, nLevel, nSeries, -1, nParticular);
    Lua_PushNumber(L, nCount);
    return 1;
}

int LuaGetBoxSizeCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nRequired = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 1;
    if (nRequired < 1)
        nRequired = 1;
    int nFree = nPlayerIndex > 0 ? GetInventoryFreeCells(nPlayerIndex) : 0;
    Lua_PushNumber(L, nFree >= nRequired ? nFree : 0);
    return 1;
}

int LuaIsEquipItem(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nGenre = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nParticular = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : -1;
    int nFound = 0;
    if (nPlayerIndex > 0)
    {
        for (int i = 0; i < itempart_num; ++i)
        {
            int nGameIndex = Player[nPlayerIndex].m_ItemList.GetEquipment(i);
            if (nGameIndex > 0 && nGameIndex < MAX_ITEM &&
                (nGenre < 0 || Item[nGameIndex].GetGenre() == nGenre) &&
                (nParticular < 0 || Item[nGameIndex].GetParticular() == nParticular))
            {
                nFound = 1;
                break;
            }
        }
    }
    Lua_PushNumber(L, nFound);
    return 1;
}

int LuaAbradeEquipCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nType = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) - 1 : enumAbradeMove;
    if (nType < enumAbradeAttack || nType >= enumAbradeNum)
        nType = enumAbradeMove;
    int nBefore[itempart_num];
    ZeroMemory(nBefore, sizeof(nBefore));
    if (nPlayerIndex > 0)
    {
        for (int i = 0; i < itempart_num; ++i)
            nBefore[i] = Player[nPlayerIndex].m_ItemList.GetEquipment(i);
#ifdef _SERVER
        Player[nPlayerIndex].m_ItemList.Abrade(nType);
#endif
    }
    int nBroken = 0;
    for (int j = 0; j < itempart_num; ++j)
        if (nBefore[j] > 0 && nBefore[j] < MAX_ITEM && Item[nBefore[j]].GetDurability() == 0)
            ++nBroken;
    Lua_PushNumber(L, nBroken);
    return 1;
}

int LuaDelEventItemCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nDetail = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nRemoved = nPlayerIndex > 0 && nDetail >= 0 ?
        RemoveVngItems(nPlayerIndex, item_task, nDetail, -1, -1, -1, FALSE) : 0;
    Lua_PushNumber(L, nRemoved);
    return 1;
}

int LuaGetNormalItemNameCompat(Lua_State *L)
{
    char szName[128];
    szName[0] = 0;
    if (Lua_GetTopIndex(L) >= 4)
    {
        int nGameIndex = CreateVngNormalItem(
            (int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2),
            (int)Lua_ValueToNumber(L, 3), (int)Lua_ValueToNumber(L, 4), 0, 0);
        if (nGameIndex > 0)
        {
            g_StrCpyLen(szName, Item[nGameIndex].GetName(), sizeof(szName));
            ItemSet.Remove(nGameIndex);
        }
    }
    Lua_PushString(L, szName);
    return 1;
}

int LuaDelNormalItemInQuickCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nGenre = -1, nDetail = -1, nLevel = -1, nSeries = -1, nParticular=-1;
    int nRemoved = 0;
    if (nPlayerIndex > 0 && GetVngNormalTuple(L, 1, &nGenre, &nDetail, &nLevel, &nSeries, &nParticular))
        nRemoved = RemoveVngItems(nPlayerIndex, nGenre, nDetail, nLevel, nSeries, pos_immediacy, FALSE,nParticular);
    Lua_PushNumber(L, nRemoved);
    return 1;
}

// Phong Than VNG Lua completion campaign - Wave 3.
// Role values use the engine-reserved task range declared in GameDataDef.h;
// this keeps the locked database ABI intact while retaining relog persistence.
static int GetPlayerArgumentOrCurrent(Lua_State *L, int nArgument)
{
    int nPlayerIndex = 0;
    if (Lua_GetTopIndex(L) >= nArgument && Lua_IsNumber(L, nArgument))
        nPlayerIndex = (int)Lua_ValueToNumber(L, nArgument);
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
        nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER ||
        Player[nPlayerIndex].m_nIndex <= 0 || Player[nPlayerIndex].m_nIndex >= MAX_NPC)
        return 0;
    return nPlayerIndex;
}

static void GetPersistentMasterName(int nPlayerIndex, char *pszName, int nNameSize)
{
    if (!pszName || nNameSize <= 0)
        return;
    pszName[0] = 0;
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
        return;
    int nLength = 0;
    for (int i = TASKVALUE_PT_MASTER_NAME_BEGIN;
        i <= TASKVALUE_PT_MASTER_NAME_END && nLength < nNameSize - 1; ++i)
    {
        const char *pszPart = Player[nPlayerIndex].m_cTask.GetSaveStr(i);
        int nPartLength = pszPart ? strlen(pszPart) : 0;
        if (nPartLength > nNameSize - 1 - nLength)
            nPartLength = nNameSize - 1 - nLength;
        if (nPartLength > 0)
        {
            memcpy(pszName + nLength, pszPart, nPartLength);
            nLength += nPartLength;
        }
    }
    pszName[nLength] = 0;
}

static int FindOnlinePlayerByExactName(const char *pszName)
{
    if (!pszName || !pszName[0])
        return 0;
    int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
    while (nPlayerIndex > 0)
    {
        if (strcmp(Player[nPlayerIndex].Name, pszName) == 0)
            return nPlayerIndex;
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
    }
    return 0;
}

int LuaGetPlayerExtLevelCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ? Npc[Player[nPlayerIndex].m_nIndex].m_Level : 0);
    return 1;
}

int LuaGetJusticEvilCreditCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_JUSTICE_EVIL) : 0);
    return 1;
}

int LuaChangeJusticEvilCreditCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 1)
    {
        int nValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_JUSTICE_EVIL);
        nValue += (int)Lua_ValueToNumber(L, 1);
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_JUSTICE_EVIL, nValue, TRUE);
    }
    return 0;
}

int LuaGetPlayerTypeCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    int nType = -1;
    if (nPlayerIndex > 0)
    {
        int nSeries = Npc[Player[nPlayerIndex].m_nIndex].m_Series;
        // Phong Than creates Knight/Wizard/Druid with authoritative series 0..2.
        if (nSeries >= 0 && nSeries <= 2)
            nType = nSeries;
    }
    Lua_PushNumber(L, nType);
    return 1;
}

int LuaIsMantlePrenticeCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    char szMaster[64];
    GetPersistentMasterName(nPlayerIndex, szMaster, sizeof(szMaster));
    Lua_PushNumber(L, szMaster[0] ? 1 : 0);
    return 1;
}

static BOOL IsOnlineMasterOfAnyPlayer(int nMasterIndex)
{
    if (nMasterIndex <= 0 || nMasterIndex >= MAX_PLAYER)
        return FALSE;
    int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
    while (nPlayerIndex > 0)
    {
        char szMaster[64];
        GetPersistentMasterName(nPlayerIndex, szMaster, sizeof(szMaster));
        if (szMaster[0] && strcmp(szMaster, Player[nMasterIndex].Name) == 0)
            return TRUE;
        nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
    }
    return FALSE;
}

int LuaIsMantleMasterCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    int nPersistedCount = nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_MASTER_APPRENTICE_COUNT) : 0;
    Lua_PushNumber(L, nPlayerIndex > 0 &&
        (nPersistedCount > 0 || IsOnlineMasterOfAnyPlayer(nPlayerIndex)) ? 1 : 0);
    return 1;
}

int LuaGetMantleMasterNameCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    char szMaster[64];
    GetPersistentMasterName(nPlayerIndex, szMaster, sizeof(szMaster));
    Lua_PushString(L, szMaster);
    return 1;
}

int LuaGetMasterPlayerIndexCompat(Lua_State *L)
{
    int nTarget = GetPlayerArgumentOrCurrent(L, 1);
    char szMaster[64];
    GetPersistentMasterName(nTarget, szMaster, sizeof(szMaster));
    Lua_PushNumber(L, FindOnlinePlayerByExactName(szMaster));
    return 1;
}

int LuaIsMasterPRRelationCompat(Lua_State *L)
{
    int nCurrent = GetPlayerIndex(L);
    int nTarget = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nResult = 0;
    if (nCurrent > 0 && nTarget > 0 && nTarget < MAX_PLAYER)
    {
        char szCurrentMaster[64], szTargetMaster[64];
        GetPersistentMasterName(nCurrent, szCurrentMaster, sizeof(szCurrentMaster));
        GetPersistentMasterName(nTarget, szTargetMaster, sizeof(szTargetMaster));
        if ((szCurrentMaster[0] && strcmp(szCurrentMaster, Player[nTarget].Name) == 0) ||
            (szTargetMaster[0] && strcmp(szTargetMaster, Player[nCurrent].Name) == 0))
            nResult = 1;
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaIsPlayerInsideWeaponCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_INSIDE_WEAPON) : 0);
    return 1;
}

int LuaIsPlayerInDeathCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    int nDead = 0;
    if (nPlayerIndex > 0)
    {
        KNpc &rNpc = Npc[Player[nPlayerIndex].m_nIndex];
        nDead = (rNpc.m_Doing == do_death || rNpc.m_Doing == do_revive ||
            rNpc.m_CurrentLife <= 0) ? 1 : 0;
    }
    Lua_PushNumber(L, nDead);
    return 1;
}

int LuaAddHelpScoreCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 1)
    {
        nResult = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_HELP_SCORE) +
            (int)Lua_ValueToNumber(L, 1);
        if (nResult < 0)
            nResult = 0;
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_HELP_SCORE, nResult, TRUE);
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

typedef struct tagPhongThanTeamTaskState
{
    int nCaptain;
    DWORD dwCaptainId;
    enum { MAX_VALUE = 16 };
    int nKey[MAX_VALUE];
    int nValue[MAX_VALUE];
} PHONGTHAN_TEAM_TASK_STATE;

static PHONGTHAN_TEAM_TASK_STATE g_PhongThanTeamTask[MAX_TEAM];

static PHONGTHAN_TEAM_TASK_STATE *GetCurrentTeamTaskState(int nPlayerIndex)
{
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER ||
        !Player[nPlayerIndex].m_cTeam.m_nFlag)
        return NULL;
    int nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
    if (nTeamId < 0 || nTeamId >= MAX_TEAM || g_Team[nTeamId].m_nCaptain <= 0)
        return NULL;
    PHONGTHAN_TEAM_TASK_STATE *pState = &g_PhongThanTeamTask[nTeamId];
    int nCaptain = g_Team[nTeamId].m_nCaptain;
    DWORD dwCaptainId = Player[nCaptain].m_dwID;
    if (pState->nCaptain != nCaptain || pState->dwCaptainId != dwCaptainId)
    {
        ZeroMemory(pState, sizeof(*pState));
        pState->nCaptain = nCaptain;
        pState->dwCaptainId = dwCaptainId;
        for (int i = 0; i < PHONGTHAN_TEAM_TASK_STATE::MAX_VALUE; ++i)
            pState->nKey[i] = -1;
    }
    return pState;
}

int LuaGetTeamTaskCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nKey = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nValue = 0;
    PHONGTHAN_TEAM_TASK_STATE *pState = GetCurrentTeamTaskState(nPlayerIndex);
    if (pState && nKey >= 0)
        for (int i = 0; i < PHONGTHAN_TEAM_TASK_STATE::MAX_VALUE; ++i)
            if (pState->nKey[i] == nKey)
            {
                nValue = pState->nValue[i];
                break;
            }
    Lua_PushNumber(L, nValue);
    return 1;
}

int LuaSetTeamTaskCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (Lua_GetTopIndex(L) >= 2)
    {
        int nKey = (int)Lua_ValueToNumber(L, 1);
        int nValue = (int)Lua_ValueToNumber(L, 2);
        PHONGTHAN_TEAM_TASK_STATE *pState = GetCurrentTeamTaskState(nPlayerIndex);
        if (pState && nKey >= 0)
        {
            int nFree = -1;
            for (int i = 0; i < PHONGTHAN_TEAM_TASK_STATE::MAX_VALUE; ++i)
            {
                if (pState->nKey[i] == nKey)
                {
                    pState->nValue[i] = nValue;
                    nResult = 1;
                    break;
                }
                if (nFree < 0 && pState->nKey[i] < 0)
                    nFree = i;
            }
            if (!nResult && nFree >= 0)
            {
                pState->nKey[nFree] = nKey;
                pState->nValue[nFree] = nValue;
                nResult = 1;
            }
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

static BOOL CallTeamActionForPlayer(KLuaScript *pScript, const char *pszFunction,
    int nPlayerIndex, int nValue1, int nValue2, int nValue3)
{
    if (!pScript || !pszFunction || !pszFunction[0] || nPlayerIndex <= 0)
        return FALSE;
    int nTop = 0;
    pScript->SafeCallBegin(&nTop);
    Lua_PushNumber(pScript->m_LuaState, nPlayerIndex);
    pScript->SetGlobalName(SCRIPT_PLAYERINDEX);
    BOOL bCalled = pScript->CallFunction((char *)pszFunction, 1, "ddd",
        nValue1, nValue2, nValue3);
    BOOL bSucceeded = bCalled;
    if (bCalled && Lua_IsNumber(pScript->m_LuaState,
        Lua_GetTopIndex(pScript->m_LuaState)))
    {
        bSucceeded = Lua_ValueToNumber(pScript->m_LuaState,
            Lua_GetTopIndex(pScript->m_LuaState)) != 0;
    }
    pScript->SafeCallEnd(nTop);
    return bSucceeded;
}

int LuaTeamActionCompat(Lua_State *L)
{
    int nTop = Lua_GetTopIndex(L);
    if (nTop < 1 || !Lua_IsString(L, 1))
    {
        Lua_PushNumber(L, 0);
        return 1;
    }
    char szFunction[64];
    g_StrCpyLen(szFunction, Lua_ValueToString(L, 1), sizeof(szFunction));
    int nValue1 = nTop >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    int nValue2 = nTop >= 3 ? (int)Lua_ValueToNumber(L, 3) : 0;
    int nValue3 = nTop >= 4 ? (int)Lua_ValueToNumber(L, 4) : 0;
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (nPlayerIndex > 0 && Player[nPlayerIndex].m_cTeam.m_nFlag)
    {
        int nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
        KLuaScript *pScript = g_StoryScriptList.GetScript(L);
        if (nTeamId >= 0 && nTeamId < MAX_TEAM && pScript)
        {
            int nOriginalPlayer = nPlayerIndex;
            nResult = CallTeamActionForPlayer(pScript, szFunction,
                g_Team[nTeamId].m_nCaptain, nValue1, nValue2, nValue3) ? 1 : 0;
            for (int i = 0; nResult && i < MAX_TEAM_MEMBER; ++i)
            {
                int nMember = g_Team[nTeamId].m_nMember[i];
                if (nMember > 0 && nMember != g_Team[nTeamId].m_nCaptain)
                    nResult = CallTeamActionForPlayer(pScript, szFunction,
                        nMember, nValue1, nValue2, nValue3) ? 1 : 0;
            }
            Lua_PushNumber(pScript->m_LuaState, nOriginalPlayer);
            pScript->SetGlobalName(SCRIPT_PLAYERINDEX);
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaAddOwnExtendExpCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nRequested = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nAccepted = 0;
    if (nPlayerIndex > 0 && nRequested > 0)
    {
        int nRemaining = nRequested;
        while (nRemaining > 0 && Npc[Player[nPlayerIndex].m_nIndex].m_Level < MAX_LEVEL)
        {
            int nNeed = Player[nPlayerIndex].m_nNextLevelExp - Player[nPlayerIndex].m_nExp;
            if (nNeed <= 0)
                break;
            int nPart = nRemaining < nNeed ? nRemaining : nNeed;
            Player[nPlayerIndex].DirectAddExp(nPart);
            nRemaining -= nPart;
            nAccepted += nPart;
        }
    }
    Lua_PushNumber(L, nAccepted);
    return 1;
}

static unsigned long GetTitleQualifyWord(int nPlayerIndex, int nWord)
{
    if (nPlayerIndex <= 0 || nWord < 0 || nWord > 15)
        return 0;
    const char *pszValue = Player[nPlayerIndex].m_cTask.GetSaveStr(
        TASKVALUE_PT_TITLE_QUALIFY_BEGIN + nWord);
    return pszValue && pszValue[0] ? strtoul(pszValue, NULL, 16) : 0;
}

static BOOL HasTitleQualification(int nPlayerIndex, int nTitle)
{
    if (nTitle == 0)
        return TRUE;
    if (nTitle < 0 || nTitle >= 512)
        return FALSE;
    unsigned long dwWord = GetTitleQualifyWord(nPlayerIndex, nTitle / 32);
    return (dwWord & (1UL << (nTitle % 32))) != 0;
}

int LuaActiveTitleQualifyCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTitle = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nResult = 0;
    if (nPlayerIndex > 0 && nTitle >= 0 && nTitle < 512)
    {
        int nWord = nTitle / 32;
        unsigned long dwValue = GetTitleQualifyWord(nPlayerIndex, nWord);
        dwValue |= 1UL << (nTitle % 32);
        char szValue[16];
        sprintf(szValue, "%08lX", dwValue);
        Player[nPlayerIndex].m_cTask.SetSaveVal(
            TASKVALUE_PT_TITLE_QUALIFY_BEGIN + nWord, szValue, TRUE);
        nResult = 1;
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaHaveQualifyCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTitle = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    Lua_PushNumber(L, HasTitleQualification(nPlayerIndex, nTitle) ? 1 : 0);
    return 1;
}

int LuaSetCurTitleCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nTitle = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nResult = 0;
    if (nPlayerIndex > 0 && nTitle >= 0 && nTitle <= 255 &&
        HasTitleQualification(nPlayerIndex, nTitle))
    {
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_CURRENT_TITLE, nTitle, TRUE);
        Npc[Player[nPlayerIndex].m_nIndex].SetRank(nTitle);
        nResult = 1;
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaActiveTitleFuncCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nResult = 0;
    if (nPlayerIndex > 0 && Lua_GetTopIndex(L) >= 1)
    {
        nResult = Lua_ValueToNumber(L, 1) != 0 ? 1 : 0;
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_TITLE_FUNCTION, nResult, TRUE);
        if (!nResult)
        {
            Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_CURRENT_TITLE, 0, TRUE);
            Npc[Player[nPlayerIndex].m_nIndex].SetRank(0);
        }
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaGetPosterityTypeCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_POSTERITY_TYPE) : 0);
    return 1;
}

int LuaIsMarriedCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    const char *pszMate = nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME) : NULL;
    Lua_PushNumber(L, pszMate && pszMate[0] ? 1 : 0);
    return 1;
}

int LuaGetExploitCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_EXPLOIT) : 0);
    return 1;
}

int LuaSetExploitCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nValue = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    if (nValue < 0)
        nValue = 0;
    if (nPlayerIndex > 0)
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_EXPLOIT, nValue, TRUE);
    Lua_PushNumber(L, nValue);
    return 1;
}

int LuaGetExploitVCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_EXPLOIT_V) : 0);
    return 1;
}

int LuaSetExploitVCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nValue = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    if (nValue < 0)
        nValue = 0;
    if (nPlayerIndex > 0)
        Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_EXPLOIT_V, nValue, TRUE);
    Lua_PushNumber(L, nValue);
    return 1;
}

int LuaGetExploitLevelCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    int nExploit = nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_EXPLOIT) : 0;
    int nLevel = 0;
    KTabFile ExploitLevel;
    if (ExploitLevel.Load("\\settings\\npc\\player\\exploit_level.txt"))
    {
        for (int nRow = 2; nRow <= ExploitLevel.GetHeight(); ++nRow)
        {
            int nNeed = -1;
            int nConfiguredLevel = nRow - 1;
            ExploitLevel.GetInteger(nRow, "NeedExploit", -1, &nNeed);
            ExploitLevel.GetInteger(nRow, "Level", nConfiguredLevel, &nConfiguredLevel);
            if (nNeed < 0 || nExploit < nNeed)
                break;
            nLevel = nConfiguredLevel;
        }
    }
    Lua_PushNumber(L, nLevel);
    return 1;
}

int LuaGetPlayerTargetCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerArgumentOrCurrent(L, 1);
    Lua_PushNumber(L, nPlayerIndex > 0 ?
        Npc[Player[nPlayerIndex].m_nIndex].m_nPeopleIdx : 0);
    return 1;
}

int LuaGetAssignedAttribCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nAttribute = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nValue = nPlayerIndex > 0 && nAttribute >= 0 && nAttribute < 4 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(
            TASKVALUE_PT_ASSIGNED_PENDING_BEGIN + nAttribute) : 0;
    Lua_PushNumber(L, nValue);
    return 1;
}

int LuaAddAssignedAttribCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nAttribute = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : -1;
    int nResult = 0;
    if (nPlayerIndex > 0 && nAttribute >= 0 && nAttribute < 4 && Lua_GetTopIndex(L) >= 2)
    {
        int nTask = TASKVALUE_PT_ASSIGNED_PENDING_BEGIN + nAttribute;
        nResult = Player[nPlayerIndex].m_cTask.GetSaveVal(nTask) +
            (int)Lua_ValueToNumber(L, 2);
        if (nResult < 0)
            nResult = 0;
        Player[nPlayerIndex].m_cTask.SetSaveVal(nTask, nResult, TRUE);
    }
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaApplyAssignedAttribCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex <= 0)
    {
        Lua_PushNumber(L, 0);
        return 1;
    }
    int nChanged = 0;
    for (int nAttribute = 0; nAttribute < 4; ++nAttribute)
    {
        int nPending = Player[nPlayerIndex].m_cTask.GetSaveVal(
            TASKVALUE_PT_ASSIGNED_PENDING_BEGIN + nAttribute);
        int nApplied = Player[nPlayerIndex].m_cTask.GetSaveVal(
            TASKVALUE_PT_ASSIGNED_APPLIED_BEGIN + nAttribute);
        int nDelta = nPending - nApplied;
        if (nDelta)
        {
            switch (nAttribute)
            {
            case 0: Player[nPlayerIndex].SetBaseStrength(nDelta); break;
            case 1: Player[nPlayerIndex].SetBaseDexterity(nDelta); break;
            case 2: Player[nPlayerIndex].SetBaseVitality(nDelta); break;
            case 3: Player[nPlayerIndex].SetBaseEngergy(nDelta); break;
            }
            Player[nPlayerIndex].m_cTask.SetSaveVal(
                TASKVALUE_PT_ASSIGNED_APPLIED_BEGIN + nAttribute, nPending, TRUE);
            ++nChanged;
        }
    }
    Lua_PushNumber(L, nChanged);
    return 1;
}

int LuaPetGetTypeCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nType = nPlayerIndex > 0 ?
        Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_PET_TYPE) : 0;
    if (nType <= 0 && nPlayerIndex > 0)
    {
        int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
        int nPetNpc = nPlayerNpc > 0 ? Npc[nPlayerNpc].m_nPetIdx : 0;
        if (nPetNpc > 0 && nPetNpc < MAX_NPC && Npc[nPetNpc].m_RegionIndex >= 0)
            nType = Npc[nPetNpc].m_NpcSettingIdx;
    }
    Lua_PushNumber(L, nType);
    return 1;
}

// engine2:BEGIN C5 2026-10-04 GetSummonPetIdx(): NPC index of the player's skill pet (summon skills 450-461,
// Npc[player].m_nPetIdx), 0 when there is none or it is dead / gone. petexp_lib.lua can find that pet now.
// (KSkills.cpp SKILL_SS_CreateNpc already gives these pets their own level 1-10 stats.)
int LuaGetSummonPetIdx(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPet = 0;
	if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER)
	{
		int nOwner = Player[nPlayerIndex].m_nIndex;
		if (nOwner > 0 && nOwner < MAX_NPC)
		{
			nPet = Npc[nOwner].m_nPetIdx;
			if (nPet <= 0 || nPet >= MAX_NPC || Npc[nPet].m_dwID == 0 || Npc[nPet].m_RegionIndex < 0 ||
				Npc[nPet].m_nOwnerIdx != nOwner || Npc[nPet].m_Doing == do_death || Npc[nPet].m_Doing == do_revive)
				nPet = 0;
		}
	}
	Lua_PushNumber(L, nPet);
	return 1;
}
// engine2:END

// engine2:BEGIN A4 2026-10-04 SetNpcAllocZone(1): the AddNpc calls of this game loop take NPC indices from the high
// zone (>= GetNpcLowZone() = 48000) only (ext matdo: density extras); SetNpcAllocZone(0) or the next game loop ends
// it. KNpcSet.cpp PtFindFree. Doc: docs\features\engine-gaps-phong-than-20261004.md
int LuaSetNpcAllocZone(Lua_State *L)
{
	int nZone = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	NpcSet.PtSetHighZone(nZone == 1);
	Lua_PushNumber(L, 1);
	return 1;
}

int LuaGetNpcLowZone(Lua_State *L)
{
	Lua_PushNumber(L, PT_NPC_LOW_ZONE);
	return 1;
}
// engine2:END

// engine2:BEGIN D1s 2026-10-04 GetNpcStateExpRate(): the part of GetNpcExpRate() (m_CurrentExpEnhance) that comes from
// states (getmoreexp_p of skill states and of AddIBBuff ibitem effects). pt_ibitem_lib.lua PTIB_Refresh subtracts
// it, so a native state starting or ending is not taken for a stat recompute (that re-applied its own buffs twice).
int LuaGetNpcStateExpRate(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSum = 0;
	if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER &&
		Player[nPlayerIndex].m_nIndex > 0 && Player[nPlayerIndex].m_nIndex < MAX_NPC)
	{
		KStateNode *pNode = (KStateNode *)Npc[Player[nPlayerIndex].m_nIndex].m_StateSkillList.GetHead();
		while (pNode)
		{
			for (int i = 0; i < MAX_SKILL_STATE; i++)
				if (pNode->m_State[i].nAttribType == magic_getmoreexp_p)
					nSum -= pNode->m_State[i].nValue[0];	// the node keeps the negated value
			pNode = (KStateNode *)pNode->GetNext();
		}
	}
	Lua_PushNumber(L, nSum);
	return 1;
}
// engine2:END

#ifdef _SERVER
// Phong Than VNG Lua completion campaign - Wave 4.
//
// IBBuff is a distinct VNG namespace; its ids are not aliases for combat
// skills even when an id happens to exist in Skills.txt. The authoritative
// metadata therefore lives in this bounded store. When a same-id skill has
// state attributes, those verified attributes and the existing state-effect
// packet are reused for combat/UI synchronization. Marker-only entries still
// drive the VNG quest/event contracts instead of inventing unrelated effects.
enum
{
    // Official vng00 bufferconfig.ini declares 48 visible slots and 9,999
    // registry ids (highest populated id in the locked payload is 9,325).
    PHONGTHAN_MAX_IBBUFF = 48,
    PHONGTHAN_MAX_NPC_IBBUFF_OWNER = 512,
    PHONGTHAN_IBBUFF_ID_MASK = 0x3fff,
    PHONGTHAN_IBBUFF_LEVEL_MASK = 0x00ff,
    PHONGTHAN_IBBUFF_TIMES_MASK = 0x03ff
};

typedef struct tagPhongThanIBBuffEntry
{
    int nId;
    int nLevel;
    int nTimes;
    DWORD dwExpireTime;             // 0 means registry/default permanent.
} PHONGTHAN_IBBUFF_ENTRY;

typedef struct tagPhongThanIBBuffStore
{
    int nOwnerIndex;
    DWORD dwOwnerId;
    PHONGTHAN_IBBUFF_ENTRY Entry[PHONGTHAN_MAX_IBBUFF];
} PHONGTHAN_IBBUFF_STORE;

static PHONGTHAN_IBBUFF_STORE g_PhongThanPlayerIBBuff[MAX_PLAYER];
static PHONGTHAN_IBBUFF_STORE g_PhongThanNpcIBBuff[PHONGTHAN_MAX_NPC_IBBUFF_OWNER];

static BOOL IsValidIBBuffId(int nId)
{
    return nId > 0 && nId <= PHONGTHAN_IBBUFF_ID_MASK;
}

static DWORD PackIBBuffIdentity(const PHONGTHAN_IBBUFF_ENTRY *pEntry)
{
    if (!pEntry || !IsValidIBBuffId(pEntry->nId))
        return 0;
    int nLevel = pEntry->nLevel;
    int nTimes = pEntry->nTimes;
    if (nLevel < 0) nLevel = 0;
    if (nLevel > PHONGTHAN_IBBUFF_LEVEL_MASK) nLevel = PHONGTHAN_IBBUFF_LEVEL_MASK;
    if (nTimes < 1) nTimes = 1;
    if (nTimes > PHONGTHAN_IBBUFF_TIMES_MASK) nTimes = PHONGTHAN_IBBUFF_TIMES_MASK;
    return (DWORD)(pEntry->nId | (nLevel << 14) | (nTimes << 22));
}

static void UnpackIBBuffIdentity(DWORD dwValue, PHONGTHAN_IBBUFF_ENTRY *pEntry)
{
    if (!pEntry)
        return;
    pEntry->nId = (int)(dwValue & PHONGTHAN_IBBUFF_ID_MASK);
    pEntry->nLevel = (int)((dwValue >> 14) & PHONGTHAN_IBBUFF_LEVEL_MASK);
    pEntry->nTimes = (int)((dwValue >> 22) & PHONGTHAN_IBBUFF_TIMES_MASK);
}

static void PersistPlayerIBBuffStore(int nPlayerIndex)
{
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
        return;
    PHONGTHAN_IBBUFF_STORE *pStore = &g_PhongThanPlayerIBBuff[nPlayerIndex];
    for (int i = 0; i < PHONGTHAN_MAX_IBBUFF; ++i)
    {
        int nTask = TASKVALUE_PT_IBBUFF_BEGIN + i * 2;
        DWORD dwPacked = PackIBBuffIdentity(&pStore->Entry[i]);
        if (dwPacked)
        {
            Player[nPlayerIndex].m_cTask.SetSaveVal(nTask, (int)dwPacked, FALSE);
            if (pStore->Entry[i].dwExpireTime)
                Player[nPlayerIndex].m_cTask.SetSaveVal(nTask + 1,
                    (int)pStore->Entry[i].dwExpireTime, FALSE);
            else
                Player[nPlayerIndex].m_cTask.szSave[nTask + 1][0] = 0;
        }
        else
        {
            Player[nPlayerIndex].m_cTask.szSave[nTask][0] = 0;
            Player[nPlayerIndex].m_cTask.szSave[nTask + 1][0] = 0;
        }
    }
}

// engine2:BEGIN D1 2026-10-04 AddIBBuff(id) = the effect of ibitem 8/id (VNG, cankhon3 report). The ibitem.txt row,
// now loaded with its buff columns (seconds + 6 attribute pairs, KBasPropTbl.CPP), gives the attributes and the
// default time; they run as a native state (SetStateSkillEffect: kept through stat recomputes, ends by itself, sent
// to the client). Before, the engine cast the SKILL with the same id: 175 -> marker without end, 176 -> run speed,
// 12/13 -> skill attributes. Only plain additive attributes are applied: the stat buffs of pt_ibitem_lib.lua
// (scratchpad\ibitem\gen.py SAFE_ATTRS) plus experience 181 and skill experience 187; a row with none of them
// stays a marker (quest flags 217, 326-350, 418 ...). Ids without an ibitem row keep the old behaviour.
#include "KItemGenerator.h"
#define PT_IBBUFF_LEGACY_DROP(id) ((id) == 12 || (id) == 13 || (id) == 175 || (id) == 176)

static const int s_nPtIBBuffAttribs[] = { 85, 86, 88, 89, 90, 92, 97, 98, 99, 100, 102, 103, 104, 105, 111, 113,
	114, 115, 116, 121, 122, 123, 124, 126, 146, 160, 161, 162, 176, 177, 179, 181, 182, 187, 188 };

static const KBASICPROP_IBITEM *PhongThanIBItemRow(int nId)
{
	if (nId <= 0)
		return NULL;
	return ItemGen.Catalog().GetIBItem(nId, 0);
}

static int PhongThanIBBuffAttribs(const KBASICPROP_IBITEM *pRow, KMagicAttrib *pOut, int nMax)
{
	int nCount = 0;
	if (!pRow || !pOut)
		return 0;
	for (int i = 0; i < PT_IBITEM_BUFF_ATTRIBS && nCount < nMax; i++)
	{
		int nType = pRow->m_nBuffAttrib[i];
		int nValue = pRow->m_nBuffValue[i];
		if (nType <= 0 || nValue == 0)
			continue;
		BOOL bOk = FALSE;
		for (int k = 0; k < (int)(sizeof(s_nPtIBBuffAttribs) / sizeof(s_nPtIBBuffAttribs[0])); k++)
			if (s_nPtIBBuffAttribs[k] == nType)
			{
				bOk = TRUE;
				break;
			}
		if (!bOk)
			continue;
		ZeroMemory(&pOut[nCount], sizeof(KMagicAttrib));
		pOut[nCount].nAttribType = nType;
		pOut[nCount].nValue[0] = nValue;
		nCount++;
	}
	return nCount;
}

// remove the state with this id at once (attributes back); the next add starts from the ibitem row
static void PhongThanIBBuffDropState(int nNpcIndex, int nBuffId)
{
	if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
		return;
	KStateNode *pNode = (KStateNode *)Npc[nNpcIndex].m_StateSkillList.GetHead();
	while (pNode)
	{
		KStateNode *pNext = (KStateNode *)pNode->GetNext();
		if (pNode->m_SkillID == nBuffId)
		{
			for (int i = 0; i < MAX_SKILL_STATE; i++)
				if (pNode->m_State[i].nAttribType)
					Npc[nNpcIndex].ModifyAttrib(nNpcIndex, &pNode->m_State[i]);
			pNode->Remove();
			delete pNode;
			Npc[nNpcIndex].UpdateNpcStateInfo();
		}
		pNode = pNext;
	}
}
// engine2:END

static int GetIBBuffDefaultSeconds(int nBuffId, int nLevel)
{
    // engine2:D1t the ibitem row's own time (VNG); the skill time only for ids without a row
    const KBASICPROP_IBITEM *pPtRow = PhongThanIBItemRow(nBuffId);
    if (pPtRow)
        return pPtRow->m_nBuffSeconds > 0 ? pPtRow->m_nBuffSeconds : 0;
    int nSkillLevel = nLevel + 1;
    if (nSkillLevel <= 0) nSkillLevel = 1;
    if (nSkillLevel >= MAX_SKILLLEVEL) nSkillLevel = MAX_SKILLLEVEL - 1;
    KSkill *pSkill = (KSkill *)g_SkillManager.GetSkill(nBuffId, nSkillLevel);
    if (!pSkill || pSkill->GetStateAttribsNum() <= 0 || !pSkill->GetStateAttribs())
        return 0;
    int nTicks = pSkill->GetStateAttribs()[0].nValue[1];
    if (nTicks <= 0)
        return 0;
    return (nTicks + GAME_FPS - 1) / GAME_FPS;
}

static void ApplyNativeIBBuffState(int nNpcIndex, const PHONGTHAN_IBBUFF_ENTRY *pEntry)
{
    if (!pEntry || nNpcIndex <= 0 || nNpcIndex >= MAX_NPC ||
        !IsValidIBBuffId(pEntry->nId))
        return;
    int nSkillLevel = pEntry->nLevel + 1;
    if (nSkillLevel <= 0) nSkillLevel = 1;
    if (nSkillLevel >= MAX_SKILLLEVEL) nSkillLevel = MAX_SKILLLEVEL - 1;
    int nSeconds = 0;
    if (pEntry->dwExpireTime)
    {
        DWORD dwNow = KSG_GetCurSec();
        if (pEntry->dwExpireTime <= dwNow)
            return;
        nSeconds = (int)(pEntry->dwExpireTime - dwNow);
    }
    int nTicks = nSeconds > 0 ? nSeconds * GAME_FPS : -1;
    // engine2:BEGIN D1a ibitem row -> native state with the row's attributes (a marker when none applies)
    const KBASICPROP_IBITEM *pPtRow = PhongThanIBItemRow(pEntry->nId);
    if (pPtRow)
    {
        KMagicAttrib PtAttribs[PT_IBITEM_BUFF_ATTRIBS];
        int nPtCount = PhongThanIBBuffAttribs(pPtRow, PtAttribs, PT_IBITEM_BUFF_ATTRIBS);
        if (nPtCount <= 0)
        {
            ZeroMemory(&PtAttribs[0], sizeof(KMagicAttrib));
            PtAttribs[0].nAttribType = magic_attackrating_v;
            nPtCount = 1;
        }
        PhongThanIBBuffDropState(nNpcIndex, pEntry->nId);
        Npc[nNpcIndex].SetStateSkillEffect(nNpcIndex, pEntry->nId, nSkillLevel, PtAttribs, nPtCount, nTicks, TRUE);
        // no state picture of the unrelated skill that happens to have the same id
        KStateNode *pPtNode = (KStateNode *)Npc[nNpcIndex].m_StateSkillList.GetHead();
        while (pPtNode)
        {
            if (pPtNode->m_SkillID == pEntry->nId && pPtNode->m_StateGraphics)
            {
                pPtNode->m_StateGraphics = 0;
                Npc[nNpcIndex].UpdateNpcStateInfo();
            }
            pPtNode = (KStateNode *)pPtNode->GetNext();
        }
        return;
    }
    // engine2:END
    KSkill *pSkill = (KSkill *)g_SkillManager.GetSkill(pEntry->nId, nSkillLevel);
    if (pSkill && pSkill->GetStateAttribsNum() > 0 && pSkill->GetStateAttribs())
    {
        pSkill->CastStateSkill(nNpcIndex, 0, 0, nTicks, TRUE);
        return;
    }

    // A VNG marker buff can legitimately have no combat attributes. Keep it
    // in the native state list with a neutral attribute so duration, relog
    // persistence and state synchronization still use the engine pipeline.
    KMagicAttrib Marker;
    ZeroMemory(&Marker, sizeof(Marker));
    Marker.nAttribType = magic_attackrating_v;
    Npc[nNpcIndex].SetStateSkillEffect(nNpcIndex, pEntry->nId, nSkillLevel,
        &Marker, 1, nTicks, TRUE);
}

static void ExpireNativeIBBuffState(int nNpcIndex, int nBuffId)
{
    if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC)
        return;
    KStateNode *pNode = (KStateNode *)Npc[nNpcIndex].m_StateSkillList.GetHead();
    while (pNode)
    {
        if (pNode->m_SkillID == nBuffId)
        {
            pNode->m_LeftTime = 0;
            return;
        }
        pNode = (KStateNode *)pNode->GetNext();
    }
}

static void CompactIBBuffStore(PHONGTHAN_IBBUFF_STORE *pStore, int nNpcIndex)
{
    if (!pStore)
        return;
    DWORD dwNow = KSG_GetCurSec();
    int nWrite = 0;
    for (int i = 0; i < PHONGTHAN_MAX_IBBUFF; ++i)
    {
        PHONGTHAN_IBBUFF_ENTRY Entry = pStore->Entry[i];
        if (!IsValidIBBuffId(Entry.nId) || Entry.nTimes <= 0)
            continue;
        if (Entry.dwExpireTime && Entry.dwExpireTime <= dwNow)
        {
            ExpireNativeIBBuffState(nNpcIndex, Entry.nId);
            continue;
        }
        if (nWrite != i)
            pStore->Entry[nWrite] = Entry;
        ++nWrite;
    }
    while (nWrite < PHONGTHAN_MAX_IBBUFF)
        ZeroMemory(&pStore->Entry[nWrite++], sizeof(PHONGTHAN_IBBUFF_ENTRY));
}

static PHONGTHAN_IBBUFF_STORE *GetPlayerIBBuffStore(int nPlayerIndex)
{
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER ||
        Player[nPlayerIndex].m_nIndex <= 0 || Player[nPlayerIndex].m_nIndex >= MAX_NPC)
        return NULL;
    PHONGTHAN_IBBUFF_STORE *pStore = &g_PhongThanPlayerIBBuff[nPlayerIndex];
    if (pStore->nOwnerIndex != nPlayerIndex ||
        pStore->dwOwnerId != Player[nPlayerIndex].m_dwID)
    {
        ZeroMemory(pStore, sizeof(*pStore));
        pStore->nOwnerIndex = nPlayerIndex;
        pStore->dwOwnerId = Player[nPlayerIndex].m_dwID;
    }
    CompactIBBuffStore(pStore, Player[nPlayerIndex].m_nIndex);
    return pStore;
}

static PHONGTHAN_IBBUFF_STORE *GetNpcIBBuffStore(int nNpcIndex)
{
    if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC || Npc[nNpcIndex].m_Index <= 0)
        return NULL;
    PHONGTHAN_IBBUFF_STORE *pStore = NULL;
    PHONGTHAN_IBBUFF_STORE *pFree = NULL;
    for (int i = 0; i < PHONGTHAN_MAX_NPC_IBBUFF_OWNER; ++i)
    {
        PHONGTHAN_IBBUFF_STORE *pCandidate = &g_PhongThanNpcIBBuff[i];
        if (pCandidate->nOwnerIndex == nNpcIndex &&
            pCandidate->dwOwnerId == Npc[nNpcIndex].m_dwID)
        {
            pStore = pCandidate;
            break;
        }
        if (!pFree && (pCandidate->dwOwnerId == 0 ||
            pCandidate->nOwnerIndex <= 0 || pCandidate->nOwnerIndex >= MAX_NPC ||
            Npc[pCandidate->nOwnerIndex].m_dwID != pCandidate->dwOwnerId))
            pFree = pCandidate;
    }
    if (!pStore)
    {
        if (!pFree)
            return NULL;
        pStore = pFree;
        ZeroMemory(pStore, sizeof(*pStore));
        pStore->nOwnerIndex = nNpcIndex;
        pStore->dwOwnerId = Npc[nNpcIndex].m_dwID;
    }
    CompactIBBuffStore(pStore, nNpcIndex);
    return pStore;
}

static int FindIBBuffSlot(PHONGTHAN_IBBUFF_STORE *pStore, int nBuffId)
{
    if (!pStore)
        return -1;
    for (int i = 0; i < PHONGTHAN_MAX_IBBUFF; ++i)
        if (pStore->Entry[i].nId == nBuffId)
            return i;
    return -1;
}

static int CountIBBuffs(PHONGTHAN_IBBUFF_STORE *pStore)
{
    if (!pStore)
        return 0;
    int nCount = 0;
    while (nCount < PHONGTHAN_MAX_IBBUFF && pStore->Entry[nCount].nId > 0)
        ++nCount;
    return nCount;
}

static int AddIBBuffToStore(PHONGTHAN_IBBUFF_STORE *pStore, int nNpcIndex,
    int nBuffId, int nSeconds, int nLevel)
{
    if (!pStore || !IsValidIBBuffId(nBuffId) || nLevel < 0)
        return 0;
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    if (nSlot < 0)
    {
        nSlot = CountIBBuffs(pStore);
        if (nSlot >= PHONGTHAN_MAX_IBBUFF)
            return 0;
        ZeroMemory(&pStore->Entry[nSlot], sizeof(PHONGTHAN_IBBUFF_ENTRY));
        pStore->Entry[nSlot].nId = nBuffId;
    }
    PHONGTHAN_IBBUFF_ENTRY *pEntry = &pStore->Entry[nSlot];
    if (pEntry->nTimes < PHONGTHAN_IBBUFF_TIMES_MASK)
        ++pEntry->nTimes;
    pEntry->nLevel = nLevel > PHONGTHAN_IBBUFF_LEVEL_MASK ?
        PHONGTHAN_IBBUFF_LEVEL_MASK : nLevel;
    if (nSeconds < 0)
        nSeconds = 0;
    if (nSeconds == 0)
        nSeconds = GetIBBuffDefaultSeconds(nBuffId, pEntry->nLevel);
    pEntry->dwExpireTime = nSeconds > 0 ? KSG_GetCurSec() + (DWORD)nSeconds : 0;
    ApplyNativeIBBuffState(nNpcIndex, pEntry);
    return 1;
}

static int RemoveIBBuffFromStore(PHONGTHAN_IBBUFF_STORE *pStore,
    int nNpcIndex, int nBuffId)
{
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    if (nSlot < 0)
        return 0;
    ExpireNativeIBBuffState(nNpcIndex, nBuffId);
    for (int i = nSlot; i < PHONGTHAN_MAX_IBBUFF - 1; ++i)
        pStore->Entry[i] = pStore->Entry[i + 1];
    ZeroMemory(&pStore->Entry[PHONGTHAN_MAX_IBBUFF - 1],
        sizeof(PHONGTHAN_IBBUFF_ENTRY));
    return 1;
}

void RestorePhongThanIBBuffs(int nPlayerIndex)
{
    if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER ||
        Player[nPlayerIndex].m_nIndex <= 0 || Player[nPlayerIndex].m_nIndex >= MAX_NPC)
        return;
    PHONGTHAN_IBBUFF_STORE *pStore = &g_PhongThanPlayerIBBuff[nPlayerIndex];
    ZeroMemory(pStore, sizeof(*pStore));
    pStore->nOwnerIndex = nPlayerIndex;
    pStore->dwOwnerId = Player[nPlayerIndex].m_dwID;
    int nWrite = 0;
    DWORD dwNow = KSG_GetCurSec();
    for (int i = 0; i < PHONGTHAN_MAX_IBBUFF; ++i)
    {
        int nTask = TASKVALUE_PT_IBBUFF_BEGIN + i * 2;
        PHONGTHAN_IBBUFF_ENTRY Entry;
        ZeroMemory(&Entry, sizeof(Entry));
        UnpackIBBuffIdentity((DWORD)Player[nPlayerIndex].m_cTask.GetSaveVal(nTask), &Entry);
        Entry.dwExpireTime = (DWORD)Player[nPlayerIndex].m_cTask.GetSaveVal(nTask + 1);
        if (!IsValidIBBuffId(Entry.nId) || Entry.nTimes <= 0 ||
            (Entry.dwExpireTime && Entry.dwExpireTime <= dwNow))
            continue;
        // engine2:D1m legacy entries: the old engine stored "no end" (0) when the same-id SKILL had no time. A row
        // with a VNG time gets it from now; the old Can Khon Luan rewards 12/13/175/176 (cankhon3 purges them) are
        // dropped instead of turning into effects nobody was given.
        if (!Entry.dwExpireTime)
        {
            const KBASICPROP_IBITEM *pPtRow = PhongThanIBItemRow(Entry.nId);
            if (pPtRow && pPtRow->m_nBuffSeconds > 0)
            {
                if (PT_IBBUFF_LEGACY_DROP(Entry.nId))
                {
                    PhongThanIBBuffDropState(Player[nPlayerIndex].m_nIndex, Entry.nId);
                    continue;
                }
                Entry.dwExpireTime = dwNow + (DWORD)pPtRow->m_nBuffSeconds;
            }
        }
        pStore->Entry[nWrite++] = Entry;
        ApplyNativeIBBuffState(Player[nPlayerIndex].m_nIndex, &Entry);
    }
    PersistPlayerIBBuffStore(nPlayerIndex);
}

int LuaHaveIBBuffCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    Lua_PushNumber(L, FindIBBuffSlot(pStore, nBuffId) >= 0 ? 1 : 0);
    return 1;
}

int LuaAddIBBuffCompat(Lua_State *L)
{
    int nTop = Lua_GetTopIndex(L);
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = nTop >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nSeconds = nTop >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    int nLevel = nTop >= 3 ? (int)Lua_ValueToNumber(L, 3) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nResult = pStore ? AddIBBuffToStore(pStore,
        Player[nPlayerIndex].m_nIndex, nBuffId, nSeconds, nLevel) : 0;
    if (nResult)
        PersistPlayerIBBuffStore(nPlayerIndex);
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaRemoveIBBuffCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nResult = pStore ? RemoveIBBuffFromStore(pStore,
        Player[nPlayerIndex].m_nIndex, nBuffId) : 0;
    if (nResult)
        PersistPlayerIBBuffStore(nPlayerIndex);
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaGetIBBuffTimesCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    Lua_PushNumber(L, nSlot >= 0 ? pStore->Entry[nSlot].nTimes : 0);
    return 1;
}

int LuaGetIBBuffLeftTimesCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    int nSeconds = 0;
    if (nSlot >= 0)
    {
        DWORD dwExpire = pStore->Entry[nSlot].dwExpireTime;
        nSeconds = dwExpire ? (int)(dwExpire - KSG_GetCurSec()) : -1;
    }
    Lua_PushNumber(L, nSeconds);
    return 1;
}

int LuaGetIBBuffCountCompat(Lua_State *L)
{
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(GetPlayerIndex(L));
    Lua_PushNumber(L, CountIBBuffs(pStore));
    return 1;
}

int LuaNpcRemoveIBBuffCompat(Lua_State *L)
{
    int nNpcIndex = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nBuffId = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetNpcIBBuffStore(nNpcIndex);
    Lua_PushNumber(L, RemoveIBBuffFromStore(pStore, nNpcIndex, nBuffId));
    return 1;
}

int LuaNpcHaveIBBuffCompat(Lua_State *L)
{
    int nNpcIndex = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nBuffId = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetNpcIBBuffStore(nNpcIndex);
    Lua_PushNumber(L, FindIBBuffSlot(pStore, nBuffId) >= 0 ? 1 : 0);
    return 1;
}

int LuaGetIBBuffLevelCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    Lua_PushNumber(L, nSlot >= 0 ? pStore->Entry[nSlot].nLevel : 0);
    return 1;
}

int LuaNpcAddIBBuffCompat(Lua_State *L)
{
    int nTop = Lua_GetTopIndex(L);
    int nNpcIndex = nTop >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nBuffId = nTop >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    int nSeconds = nTop >= 3 ? (int)Lua_ValueToNumber(L, 3) : 0;
    int nLevel = nTop >= 4 ? (int)Lua_ValueToNumber(L, 4) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetNpcIBBuffStore(nNpcIndex);
    Lua_PushNumber(L, AddIBBuffToStore(pStore, nNpcIndex,
        nBuffId, nSeconds, nLevel));
    return 1;
}

int LuaCostIBBuffCompat(Lua_State *L)
{
    int nPlayerIndex = GetPlayerIndex(L);
    int nBuffId = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
    int nCost = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 0;
    PHONGTHAN_IBBUFF_STORE *pStore = GetPlayerIBBuffStore(nPlayerIndex);
    int nSlot = FindIBBuffSlot(pStore, nBuffId);
    int nResult = 0;
    if (nSlot >= 0 && nCost > 0 && pStore->Entry[nSlot].nTimes >= nCost)
    {
        pStore->Entry[nSlot].nTimes -= nCost;
        nResult = 1;
        if (pStore->Entry[nSlot].nTimes == 0)
            RemoveIBBuffFromStore(pStore, Player[nPlayerIndex].m_nIndex, nBuffId);
        PersistPlayerIBBuffStore(nPlayerIndex);
    }
    Lua_PushNumber(L, nResult);
    return 1;
}
#endif

int LuaRemoveServerItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	int nIdx = (int)Lua_ValueToNumber(L,1);

	if (!nIdx)
		return 0;

	ItemSet.Remove(nIdx);
	return 0;
}

// Phong Than 2026-10-01: RepairAllEquip() - free full repair of every equipped item (Lenh Bai Huy Do).
// KPlayer::RepairItem returns silently when GetRepairPrice() is 0 (items with price 0), so shop repair
// cannot fix them; broken items (durability 0) stay broken like the VNG rule. Returns the repaired count.
int LuaRepairAllEquip(Lua_State * L)
{
	int nRepaired = 0;
	int nPlayerIndex = GetPlayerIndex(L);
#ifdef _SERVER
	if (nPlayerIndex > 0)
	{
		for (int i = 0; i < itempart_num; ++i)
		{
			int nIdx = Player[nPlayerIndex].m_ItemList.GetEquipment(i);
			if (nIdx <= 0 || nIdx >= MAX_ITEM)
				continue;
			int nMaxDur = Item[nIdx].GetMaxDurability();
			int nDur = Item[nIdx].GetDurability();
			if (nMaxDur <= 0 || nDur <= 0 || nDur >= nMaxDur)
				continue;
			Item[nIdx].SetDurability(nMaxDur);
			Player[nPlayerIndex].m_ItemList.SyncItemDurability(nIdx);
			++nRepaired;
		}
	}
#endif
	Lua_PushNumber(L, nRepaired);
	return 1;
}

int LuaRemoveItemIdx(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3)
	{
		Lua_PushNumber(L, 0);
	}
	else
	{
		if(Player[nPlayerIndex].m_ItemList.RemoveItem((int)Lua_ValueToNumber(L,1),(int)Lua_ValueToNumber(L,2)))
			Lua_PushNumber(L,1);
	}
	return 1;
}

int LuaLockMoveItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 1) return 0;

	LockMoveItem LockMove;
	LockMove.bLock = (BOOL)Lua_ValueToNumber(L,1);
	LockMove.nPlace = 0;
	Player[nPlayerIndex].SetLockMove(&LockMove);
	return 0;
}

int LuaSyncItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nItemIdx = (int)Lua_ValueToNumber(L,1);


	if (nItemIdx <= 0 || nItemIdx > MAX_ITEM)
		return 0;

	Player[nPlayerIndex].m_ItemList.SyncItem(nItemIdx);
	return 0;
}

int LuaSetTempItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetTemp((BOOL)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetLevelItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetLevel((int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetSeriesItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetSeries((int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetParamItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetParam((int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetFortuneItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetFortune((int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetTimeItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetExpireTime(KSG_GetCurSec()+(int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaAddTimeItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 3) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		if (Item[nIdx].GetExpireTime())
			Item[nIdx].SetExpireTime(Item[nIdx].GetExpireTime() + (int)Lua_ValueToNumber(L, 2));
		else
			Item[nIdx].SetExpireTime(KSG_GetCurSec()+(int)Lua_ValueToNumber(L, 2));

		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}


int LuaLockItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	if (nParamNum > 4)
	{
		int nIdx = (int)Lua_ValueToNumber(L, 1);
		if (nIdx > 0)
		{
			Item[nIdx].SetLockTrade((BOOL)Lua_ValueToNumber(L,2));
			Item[nIdx].SetLockSell((BOOL)Lua_ValueToNumber(L,3));
			Item[nIdx].SetLockDrop((BOOL)Lua_ValueToNumber(L,4));
			Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
			Lua_PushNumber(L,nIdx);
			return 1;
		}
	}
	else
	{
		int nIdx = (int)Lua_ValueToNumber(L, 1);
		int nLock = LOCK_STATE_FOREVER;
		if (nIdx > 0)
		{
			if (nParamNum > 2)
				nLock = (int)Lua_ValueToNumber(L, 2);
			Item[nIdx].LockItem(nLock);
			Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
			Lua_PushNumber(L,nIdx);
			return 1;
		}
	}
	return 0;
}


int LuaSetStackItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetStackNum((int)Lua_ValueToNumber(L, 2));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaSetFlashItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2) return 0;

	int nIdx = (int)Lua_ValueToNumber(L, 1);

	if (nIdx > 0)
	{
		Item[nIdx].SetFlash(TGetColor((char*)Lua_ValueToString(L, 2)));
		Player[nPlayerIndex].m_ItemList.SyncItem(nIdx);
		Lua_PushNumber(L,nIdx);
		return 1;
	}
	return 0;
}

int LuaGetFreeObjPos(Lua_State * L)
{
	int nSubWorldIndex, nNpcIndex;

	POINT	ptLocal;
	if (Lua_GetTopIndex(L) > 2)
	{
		nNpcIndex = (int)Lua_ValueToNumber(L,1);
		ptLocal.x = (int)Lua_ValueToNumber(L,2);
		ptLocal.y = (int)Lua_ValueToNumber(L,3);
	}
	else if (Lua_GetTopIndex(L) > 1)
	{
		int nPlayerIndex = GetPlayerIndex(L);
		if (nPlayerIndex <= 0) return 0;
		nNpcIndex = Player[nPlayerIndex].m_nIndex;
		nSubWorldIndex = Npc[nNpcIndex].m_SubWorldIndex;
		ptLocal.x = (int)Lua_ValueToNumber(L,1);
		ptLocal.y = (int)Lua_ValueToNumber(L,2);
	}
	else
		return 0;

	SubWorld[nSubWorldIndex].GetFreeObjPos(ptLocal);
	Lua_PushNumber(L, (int)(ptLocal.x/32));
	Lua_PushNumber(L, (int)(ptLocal.y/32));
	return 2;
}

int LuaOpenRankData(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	sMsg.Operation = PHONGTHAN_PLAYER_RANK_PANEL;
	sMsg.Value = 0;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sizeof(sMsg));

	return 0;
}

/*//TamLTM fix send packet
int LuaOpenRankData(Lua_State* L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	S2C_PLAYER_SYNC_RANK_DATA	sMsg;
	sMsg.ProtocolType = s2c_playersyncrankdata;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_RANK_DATA) - 1;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_RANKDATA;
	sMsg.m_lpBuf = 0;
	//	g_DebugLog("s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);

	return 0;
}
//end code */

int LuaSetSavePw(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	Player[nPlayerIndex].SetSavePw((char*)Lua_ValueToString(L,1), TRUE);
	return 0;
}

int LuaGetSavePw(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
		return 0;

	Lua_PushString(L, (char*)Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_PASSWORD));
	return 1;
}

int LuaSetLockState(Lua_State * L)
{
	int bLock = (int)Lua_ValueToNumber(L,1);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}

	Player[nPlayerIndex].SetLockState(bLock > 0);
	return 0;
}

int LuaGetLockState(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	if (Player[nPlayerIndex].GetLockState())
	{
		Lua_PushNumber(L,1);
	}
	else
	{
		Lua_PushNumber(L,0);
	}
	return 1;
}

int LuaIsHideNpc(Lua_State * L)
{
	int nRet = -1;
	if (Lua_GetTopIndex(L) == 1)
	{
		int nNpcIndex  = 0;
		nNpcIndex = (int)Lua_ValueToNumber(L, 1);
		if (nNpcIndex > 0 || nNpcIndex < MAX_NPC)
		{
			if (Npc[nNpcIndex].IsAlive())
				nRet = 0;
			else
				nRet = 1;
		}
	}
	Lua_PushNumber(L ,nRet);
	return 1;
}

int LuaSetPKState(Lua_State *L)
{
	int nPKSet = 0;
	int nPKState = 0;
	int nPlayerIndex = GetPlayerIndex(L);
	int nParamNum = Lua_GetTopIndex(L);
	if (nPlayerIndex > 0)
	{
		if (nParamNum <= 2)
		{
			nPKSet = (int)Lua_ValueToNumber(L, 1);
			nPKState = Player[nPlayerIndex].m_cPK.GetLockPKState();
		}
		else
		{
			nPKSet = (int)Lua_ValueToNumber(L, 1);
			nPKState = (int)Lua_ValueToNumber(L, 2);
		}
		if (nPKSet < 0 || nPKSet >= enumPKNum)
			return 0;

		if (nPKState < enumPKLogNothing || nPKSet >= enumPKLogNum)
			return 0;

		Player[nPlayerIndex].m_cPK.SetLockPKState(nPKSet, nPKState);
		Lua_PushNumber(L, 1);
	}
	else
	{
		Lua_PushNumber(L,0);
	}
	return 1;
}

int LuaForbidChangePK(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum > 1)
	{
		Player[nPlayerIndex].m_cPK.SetLockPKState(Player[nPlayerIndex].m_cPK.GetNormalPKState(), (int)Lua_ValueToNumber(L, 1));
	}
	return 0;
}

int LuaGetPKState(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nResult = Player[nPlayerIndex].m_cPK.GetLockPKState();
		Lua_PushNumber(L, nResult);
	}
	else
	{
		Lua_PushNumber(L,0);
	}
	return 1;
}

int LuaGetNormalPKState(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex > 0)
	{
		int nResult = Player[nPlayerIndex].m_cPK.GetNormalPKState();
		Lua_PushNumber(L, nResult);
	}
	else
	{
		Lua_PushNumber(L,0);
	}
	return 1;
}

int LuaPaceBar(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0)
	{
		Lua_PushNumber(L,0);
		return 1;
	}
	int nParamCount = Lua_GetTopIndex(L);
	if (nParamCount<2)
		return 0;

	strcpy(Player[nPlayerIndex].m_szTaskExcuteFun, (char *)Lua_ValueToString(L,1));
	Player[nPlayerIndex].m_nPaceBarTime = (int)Lua_ValueToNumber(L,2);
	Player[nPlayerIndex].m_nPaceBarTimeMax = (int)Lua_ValueToNumber(L,2);
	Player[nPlayerIndex].m_dwTaskExcuteScriptId = Npc[Player[nPlayerIndex].m_nIndex].m_ActionScriptID;

	return 0;
}

int LuaDelItem(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nParamNum = Lua_GetTopIndex(L);
	if (nPlayerIndex <= 0 || nParamNum < 2)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nCount = (int)Lua_ValueToNumber(L, 1);
	int nGenre = (int)Lua_ValueToNumber(L, 2);
	int nDetail = nParamNum >= 3 ? (int)Lua_ValueToNumber(L, 3) : -1;
	int nLevel = nParamNum >= 4 ? (int)Lua_ValueToNumber(L, 4) : -1;
	int nSeries = nParamNum >= 5 ? (int)Lua_ValueToNumber(L, 5) : -1;
	int nPlace = nParamNum >= 6 ? (int)Lua_ValueToNumber(L, 6) : pos_equiproom;
	Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.RemoveCommonItem(
		nCount, nGenre, nDetail, nLevel, nSeries, nPlace));
	return 1;
}

int LuaGetItemCount(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nParamNum = Lua_GetTopIndex(L);
	if (nPlayerIndex <= 0 || nParamNum < 1)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nGenre = (int)Lua_ValueToNumber(L, 1);
	int nDetail = nParamNum >= 2 ? (int)Lua_ValueToNumber(L, 2) : -1;
	int nLevel = nParamNum >= 3 ? (int)Lua_ValueToNumber(L, 3) : -1;
	int nSeries = nParamNum >= 4 ? (int)Lua_ValueToNumber(L, 4) : -1;
	int nPlace = nParamNum >= 5 ? (int)Lua_ValueToNumber(L, 5) : pos_equiproom;
	Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.CountCommonItem(
		nGenre, nDetail, nLevel, nSeries, nPlace));
	return 1;
}

int LuaGetItemCountRoom(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum > 0)
	{
		int nPlayerIndex = GetPlayerIndex(L);
		if (nPlayerIndex > 0)
			Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.GetItemCountRoom((int)Lua_ValueToNumber(L, 1)));
	}
	return 1;
}

int LuaGetTrade(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Player[nPlayerIndex].m_PTrade.nTrade)
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaForbidUseTownP(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;
	Player[nPlayerIndex].ForbidUseTownP(Lua_ValueToNumber(L,1) > 0);
	return 0;
}

int LuaForbidTrade(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Player[nPlayerIndex].ForbidTrade((BOOL)Lua_ValueToNumber(L, 1));
	return 0;
}

int LuaForbidEnmity(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Player[nPlayerIndex].ForbidEnmity((BOOL)Lua_ValueToNumber(L, 1));
	return 0;
}

int LuaForbidName(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Player[nPlayerIndex].ForbidName((int)Lua_ValueToNumber(L, 1));
	return 0;
}

int LuaForbidCamp(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0) return 0;

	if (Lua_GetTopIndex(L) < 2)
		return 0;

	Player[nPlayerIndex].ForbidCamp((BOOL)Lua_ValueToNumber(L, 1));
	return 0;
}

int LuaGetDistance(Lua_State * L)
{
	Lua_PushNumber(L, g_GetDistance((int)Lua_ValueToNumber(L,1),(int)Lua_ValueToNumber(L,2),
		(int)Lua_ValueToNumber(L,3),(int)Lua_ValueToNumber(L,4)));
	return 1;
}

int LuaGetDir(Lua_State * L)
{
	Lua_PushNumber(L, g_GetDirIndex((int)Lua_ValueToNumber(L,1),(int)Lua_ValueToNumber(L,2),
		(int)Lua_ValueToNumber(L,3),(int)Lua_ValueToNumber(L,4)));
	return 1;
}

int LuaDirSin(Lua_State * L)
{
	Lua_PushNumber(L, g_DirSin((int)Lua_ValueToNumber(L,1),64));
	return 1;
}

int LuaDirCos(Lua_State * L)
{
	Lua_PushNumber(L, g_DirCos((int)Lua_ValueToNumber(L,1),64));
	return 1;
}

int LuaFileExists(Lua_State * L)
{
	char * szFileName = (char *)Lua_ValueToString(L, 1);
	if (g_FileExists(szFileName))
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaFileName2Id(Lua_State * L)
{
	char * szScript = (char *)Lua_ValueToString(L, 1);
	Lua_PushNumber(L, g_FileName2Id(szScript));
	return 1;
}

int LuaTabFile_Load(Lua_State * L)
{
	KTabFile TabFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	if (TabFile.Load(szFileName))
		return 1;
	else
		return 0;
	return 1;
}


int LuaIniFile_IsSectionExist(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSection = (char *)Lua_ValueToString(L,2);
	if (IniFile.Load(szFileName))
	{
		if (IniFile.IsSectionExist(szSection))
		{
			Lua_PushNumber(L, 1);
			return 1;
		}
	}
	Lua_PushNumber(L, 0);
	return 1;
}

int LuaIniFile_Load(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	if (IniFile.Load(szFileName))
		Lua_PushNumber(L, 1);
	else
		Lua_PushNumber(L, 0);
	return 1;
}

int LuaIniFile_GetStr(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	char szValue[128];
	if (IniFile.Load(szFileName))
	{
		IniFile.GetString(szSectName,szKeyName,"",szValue, sizeof(szValue));
		Lua_PushString(L, szValue);
		return 1;
	}
	return 0;
}

int LuaIniFile_GetInt(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	int nValue;
	if (IniFile.Load(szFileName))
	{
		IniFile.GetInteger(szSectName,szKeyName,0,&nValue);
		Lua_PushNumber(L, nValue);
		return 1;
	}
	return 0;
}

int LuaIniFile_GetInt2(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	int nValue1, nValue2;
	if (IniFile.Load(szFileName))
	{
		IniFile.GetInteger2(szSectName,szKeyName,&nValue1,&nValue2);
		Lua_PushNumber(L, nValue1);
		Lua_PushNumber(L, nValue2);
		return 2;
	}
	return 0;
}

int LuaIniFile_Save(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);

	IniFile.Save(szFileName);
	return 0;
}

int LuaIniFile_SaveStr(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	char * szValue = (char *)Lua_ValueToString(L,4);
	if (IniFile.Load(szFileName))
	{
		IniFile.WriteString(szSectName,szKeyName,szValue);
		IniFile.Save(szFileName);
	}
	return 0;
}

int LuaIniFile_SaveInt(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	int nValue = (int)Lua_ValueToNumber(L,4);
	if (IniFile.Load(szFileName))
	{
		IniFile.WriteInteger(szSectName,szKeyName,nValue);
		IniFile.Save(szFileName);
	}
	return 0;
}

int LuaIniFile_SaveInt2(Lua_State * L)
{
	KIniFile IniFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	char * szSectName = (char *)Lua_ValueToString(L,2);
	char * szKeyName = (char *)Lua_ValueToString(L,3);
	int nValue1 = (int)Lua_ValueToNumber(L,4);
	int nValue2 = (int)Lua_ValueToNumber(L,5);
	if (IniFile.Load(szFileName))
	{
		IniFile.WriteInteger2(szSectName,szKeyName,nValue1,nValue2);
		IniFile.Save(szFileName);
	}
	return 0;
}

int LuaTabFile_GetRowCount(Lua_State * L)
{
	KTabFile TabFile;
	char * szFileName = (char *)Lua_ValueToString(L,1);
	int nCount = 0;
	TabFile.Load(szFileName);
	nCount = TabFile.GetHeight();
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaTabFile_GetCell(Lua_State * L)
{
	KTabFile TabFile;
	char szString[128];
	char * szFileName = (char *)Lua_ValueToString(L, 1);
	if (TabFile.Load(szFileName))
	{
		if (Lua_IsNumber(L, 2) && Lua_IsNumber(L, 3))
		{
			int nRow = (int)Lua_ValueToNumber(L, 2);
			int nColumn = (int)Lua_ValueToNumber(L, 3);
			TabFile.GetString(nRow, nColumn, "", szString, sizeof(szString));
		}
		else if (Lua_IsNumber(L, 2) && Lua_IsString(L, 3))
		{
			int nRow = (int)Lua_ValueToNumber(L, 2);
			char szColumn[32];
			strcpy(szColumn, Lua_ValueToString(L, 3));
			TabFile.GetString(nRow, szColumn, "", szString, sizeof(szString));
		}
		else if (Lua_IsString(L, 2) && Lua_IsString(L, 3))
		{
			char szRow[32];
			char szColumn[32];
			strcpy(szRow, Lua_ValueToString(L, 2));
			strcpy(szColumn, Lua_ValueToString(L, 3));
			TabFile.GetString(szRow, szColumn, "", szString, sizeof(szString));
		}
		else
			return 0;

		Lua_PushString(L, szString);
		TabFile.Clear();
		return 1;
	}
	return 0;
}

int LuaGetDataInt(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1) return 0;
	int nId = (int)Lua_ValueToNumber(L,1);
	Lua_PushNumber(L, GameData.GetDataInt(nId));
	return 1;
}

int LuaGetDataStr(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1) return 0;
	int nId = (int)Lua_ValueToNumber(L,1);
	Lua_PushString(L, GameData.GetDataStr(nId));
	return 1;
}

int LuaSetData(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 2) return 0;
	int nNo = (int)Lua_ValueToNumber(L,1);
	char* szValue = (char*)Lua_ValueToString(L,2);
	GameData.SetData(nNo, szValue);
	return 0;
}

int LuaSendReport(Lua_State * L)
{
	return 0;
}

int LuaGetTime(Lua_State * L)
{
	time_t rawtime;
	struct tm * timeinfo;

	time ( &rawtime );
	timeinfo = localtime ( &rawtime );

	Lua_PushNumber(L, timeinfo->tm_year + 1900);
	Lua_PushNumber(L, timeinfo->tm_mon + 1);
	Lua_PushNumber(L, timeinfo->tm_mday);
	Lua_PushNumber(L, timeinfo->tm_hour);
	Lua_PushNumber(L, timeinfo->tm_min);
	Lua_PushNumber(L, timeinfo->tm_sec);
	Lua_PushNumber(L, timeinfo->tm_wday);
	Lua_PushNumber(L, timeinfo->tm_yday);
	return 8;
}

int LuaGetTimeDate(Lua_State * L)
{
	int nParamNum = Lua_GetTopIndex(L);
	if (nParamNum < 2)
		return 0;

	time_t rawtime=(int)Lua_ValueToNumber(L,2)+1451581200;

	struct tm * timeinfo = localtime(&rawtime);

	const char* pszKey = (char*)Lua_ValueToString(L,1);

	char pszTimeFormat[256];
	if (strftime(pszTimeFormat, sizeof(pszTimeFormat), pszKey, timeinfo))
	{
		Lua_PushString(L, pszTimeFormat);
		return 1;
	}
	return 0;
}

int LuaGetLocalDate(Lua_State * L)
{
	time_t rawtime;
	struct tm * timeinfo;

	time ( &rawtime );
	timeinfo = localtime ( &rawtime );

	const char* pszKey = (char*)Lua_ValueToString(L,1);

	char pszTimeFormat[256];
	if (strftime(pszTimeFormat, sizeof(pszTimeFormat), pszKey, timeinfo))
	{
		Lua_PushString(L, pszTimeFormat);
		return 1;
	}
	return 0;
}

//Son code Reload
int LuaReLoadScript(Lua_State * L)
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    char* szScript = (char*)Lua_ValueToString(L, 1);
    ReLoadScript(szScript);
    return 0;
}


//Hung add ham reload script
int LuaReloadAllScript(Lua_State * L)
{
    ReLoadAllScript();
    return 1;
}


int LuaAddDataGr(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1) return 0;

	char* szName1 = (char*)Lua_ValueToString(L, 1);
	int nNameId = g_FileName2Id(szName1);

	KDataGroup Info;
	Info.nNameId = nNameId;
	memset(Info.nValue, 0, sizeof(Info.nValue));
	strcpy(Info.szName1, szName1);
	memset(Info.szName2, 0, sizeof(Info.szName2));

	Lua_PushNumber(L, GameData.AddDataGr(&Info));
	return 1;
}

int LuaSetDataGr(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 8) return 0;
	int i=0,j=0;
	KDataGroup Info;
	j++;
	int nGroup = (int)Lua_ValueToNumber(L,j);
	j++;
	Info.nNameId = (int)Lua_ValueToNumber(L,j);
	j++;
	for (i = 0; i < MAX_DATAGROUP_VALUE; i++)
		Info.nValue[i] = (int)Lua_ValueToNumber(L,j+i);
	strcpy(Info.szName1, (char*)Lua_ValueToString(L, MAX_DATAGROUP_VALUE+j));
	strcpy(Info.szName2, (char*)Lua_ValueToString(L, MAX_DATAGROUP_VALUE+j+1));
	GameData.SetDataGr(nGroup, &Info);
	return 0;
}

int LuaGetDataGr(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1) return 0;

	int nNo = (int)Lua_ValueToNumber(L, 1);

	Lua_PushNumber(L, GameData.GetDataGr_dwName(nNo));
	for (int j = 0; j < MAX_DATAGROUP_VALUE; j++)
		Lua_PushNumber(L, GameData.GetDataGr_nValue(nNo, j));
	Lua_PushString(L, GameData.GetStrDataGr_Name1(nNo));
	Lua_PushString(L, GameData.GetStrDataGr_Name2(nNo));
	return 7;

}

int LuaFindDataId(Lua_State * L)
{
	if (Lua_GetTopIndex(L) < 1) return 0;

	int nNo = (int)Lua_ValueToNumber(L, 1);

	Lua_PushNumber(L, GameData.FindDataId((DWORD)Lua_ValueToNumber(L, 1)));
	return 1;
}

int LuaSaveDataFile(Lua_State * L)
{
	GameData.Save(); //TamLTM save 7
	return 0;
}


int LuaChatRoom_Create(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	if (Lua_GetTopIndex(L) < 4) return 0;
	BOOL bIsGmRoom = FALSE;
	if(Lua_GetTopIndex(L) >4)
		bIsGmRoom = (BOOL)Lua_ValueToNumber(L,4);
	if(Player[nPlayerIndex].m_cRoom.CreateChatRoom((char*)Lua_ValueToString(L,1),(int)Lua_ValueToNumber(L,2),(int)Lua_ValueToNumber(L,3),bIsGmRoom))
		Lua_PushNumber(L,1);
	else
		Lua_PushNumber(L,0);
	return 1;
}

int LuaChatRoom_AddTime(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if(nPlayerIndex <= 0) return 0;
	if (Lua_GetTopIndex(L) < 2) return 0;
	if(Player[nPlayerIndex].m_cRoom.AddTime((char*)Lua_ValueToString(L,1), (int)Lua_ValueToNumber(L,2)))
		Lua_PushNumber(L,1);
	else
		Lua_PushNumber(L,0);
	return 1;
}
#endif

int LuaGetCurServerSec(Lua_State * L)
{
    Lua_PushNumber(L, KSG_GetCurSec());
    return 1;
}

int LuaSetNumber(Lua_State * L)
{
    int nResult = 0;
    if (Lua_GetTopIndex(L) < 4)
        goto lab_setnumber;

    nResult = KSG_StringSetValue((int)Lua_ValueToNumber(L,1),
                                 (int)Lua_ValueToNumber(L,2),
                                 (int)Lua_ValueToNumber(L,3),
                                 (int)Lua_ValueToNumber(L,4));

    lab_setnumber:
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaGetNumber(Lua_State * L)
{
    int nResult = 0;
    if (Lua_GetTopIndex(L) < 3)
        goto lab_getnumber;
    nResult = KSG_StringGetValue((int)Lua_ValueToNumber(L,1),
                                 (int)Lua_ValueToNumber(L,2),
                                 (int)Lua_ValueToNumber(L,3));

    lab_getnumber:
    Lua_PushNumber(L, nResult);
    return 1;
}

int LuaGetNameItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushString(L, Item[nIdx].GetName());
        return 1;
    }
    return 0;
}

int LuaGetParamItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushNumber(L, Item[nIdx].GetParam());
        return 1;
    }
    return 0;
}

int LuaGetFortuneItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushNumber(L, Item[nIdx].GetFortune());
        return 1;
    }
    return 0;
}

int LuaGetLockItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushNumber(L, Item[nIdx].GetLock()->nState);
        if (KSG_GetCurSec() < Item[nIdx].GetLock()->dwLockTime)
            Lua_PushNumber(L, Item[nIdx].GetLock()->dwLockTime - KSG_GetCurSec());
        else
            Lua_PushNumber(L, Item[nIdx].GetLock()->dwLockTime);
        return 2;
    }
    Lua_PushNumber(L, 0);
    Lua_PushNumber(L, 0);
    return 2;
}

int LuaGetStackItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushNumber(L, Item[nIdx].GetStackNum());
        return 1;
    }
    return 0;
}

int LuaGetMaxStackItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum < 1) return 0;

    int nIdx = (int)Lua_ValueToNumber(L, 1);
    if (nIdx > 0)
    {
        Lua_PushNumber(L, Item[nIdx].GetMaxStackNum());
        return 1;
    }
    return 0;
}

int LuaFindItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum > 0)
    {
        int nPlayerIndex = GetPlayerIndex(L);
        if (nPlayerIndex > 0)
        {
            if (nParamNum <= 1)
            {
                int nIdx = Player[nPlayerIndex].m_ItemList.FindSame((int)Lua_ValueToNumber(L, 1));
                if (nIdx)
                {
                    Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nPlace);
                    Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nX);
                    Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nY);
                    return 3;
                }
                else
                    return 0;
            }
            int nItemGenre, nDetailType, nLevel, nSeries;
            nItemGenre = nDetailType = nLevel = nSeries = -1;

            nItemGenre = (int)Lua_ValueToNumber(L, 1);

            if (nParamNum > 1)
                nDetailType = (int)Lua_ValueToNumber(L, 2);

            if (nParamNum > 2)
                nLevel = (int)Lua_ValueToNumber(L, 3);

            if (nParamNum > 3)
                nSeries = (int)Lua_ValueToNumber(L, 4);

            int nIdx = Player[nPlayerIndex].m_ItemList.FindItem(nItemGenre,nDetailType,nLevel,nSeries);

            if (nIdx)
            {
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nIdx);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nPlace);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nX);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nY);
                return 4;
            }
        }
    }
    Lua_PushNumber(L, 0);
    Lua_PushNumber(L, 0);
    Lua_PushNumber(L, 0);
    Lua_PushNumber(L, 0);
    return 4;
}

int LuaFindSetItem(Lua_State * L)
{
    int nParamNum = Lua_GetTopIndex(L);
    if (nParamNum > 0)
    {
        int nPlayerIndex = GetPlayerIndex(L);
        if (nPlayerIndex > 0)
        {
            int nIndex = 0;

            nIndex = (int)Lua_ValueToNumber(L, 1);

            int nIdx = Player[nPlayerIndex].m_ItemList.FindItemByTemplateRow(nIndex);

            if (nIdx)
            {
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nIdx);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nPlace);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nX);
                Lua_PushNumber(L, Player[nPlayerIndex].m_ItemList.m_Items[nIdx].nY);
                return 4;
            }
        }
    }
    Lua_PushNil(L);
    return 1;
}

int LuaFindItemEx(Lua_State * L)
{
    int nPlayerIndex = GetPlayerIndex(L);

    if (nPlayerIndex <= 0)
    {
        Lua_PushNumber(L,0);
        return 1;
    }
    int nParamNum = Lua_GetTopIndex(L);

    if (nParamNum <= 2)
    {
        int nIndex, nItemGenre = -1, nDetail = -1, nParticur = -1, nLevel = -1, nSeries = series_num, nLuck = 0, nStackNum = 0;
        nIndex = (int)Lua_ValueToNumber(L, 1);
        if (nIndex > 0)
        {
            nItemGenre = Item[nIndex].GetGenre();
            nDetail = Item[nIndex].GetDetailType();
            nParticur = Item[nIndex].GetParticular();
            nLevel = Item[nIndex].GetLevel();
            nSeries = Item[nIndex].GetSeries();
            nLuck = Item[nIndex].m_GeneratorParam.nLuck;
            nStackNum = Item[nIndex].GetStackNum();
        }

        Lua_PushNumber(L, nItemGenre);
        Lua_PushNumber(L, nDetail);
        Lua_PushNumber(L, nParticur);
        Lua_PushNumber(L, nLevel);
        Lua_PushNumber(L, nSeries);
        Lua_PushNumber(L, nLuck);
        Lua_PushNumber(L, nStackNum);
        return 7;
    }

    int nIndex = 0, nItemGenre = -1, nDetail = -1, nParticur = -1, nLevel = -1, nSeries = series_num, nLuck = 0, nStackNum = 0;
    if (nParamNum > 2)
    {
        nIndex = Player[nPlayerIndex].m_ItemList.PositionToIndex((int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2));
    }
    if (nParamNum > 3)
    {
        nIndex = Player[nPlayerIndex].m_ItemList.m_Room[PositionToRoom((int)Lua_ValueToNumber(L, 1))].FindItem((int)Lua_ValueToNumber(L, 2), (int)Lua_ValueToNumber(L, 3));
    }

    if (nIndex > 0)
    {
        nItemGenre = Item[nIndex].GetGenre();
        nDetail = Item[nIndex].GetDetailType();
        nParticur = Item[nIndex].GetParticular();
        nLevel = Item[nIndex].GetLevel();
        nSeries = Item[nIndex].GetSeries();
        nLuck			= Item[nIndex].m_GeneratorParam.nLuck;
        nStackNum = Item[nIndex].GetStackNum();
    }
    Lua_PushNumber(L, nIndex);
    Lua_PushNumber(L, nItemGenre);
    Lua_PushNumber(L, nDetail);
    Lua_PushNumber(L, nParticur);
    Lua_PushNumber(L, nLevel);
    Lua_PushNumber(L, nSeries);
    Lua_PushNumber(L, nLuck);
    Lua_PushNumber(L, nStackNum);
    return 8;
}

int LuaPlayMusic(Lua_State * L)//PlayMusic(musicname,loop=1, vol );
{
    if (Lua_GetTopIndex(L) < 1)
        return 0;

    int nPlayerIndex = GetPlayerIndex(L);
    if (nPlayerIndex < 0) return 0;

    KPhongThanScriptAction UiInfo;
    ZeroMemory(&UiInfo, sizeof(UiInfo));
    UiInfo.View = UI_PLAYMUSIC;
    UiInfo.OptionCount = 1;
    UiInfo.Operation = PHONGTHAN_SCRIPT_SHOW;

    int nMsgId = 0;

    g_StrCpyLen(UiInfo.Content, Lua_ValueToString(L,1), sizeof(UiInfo.Content));
    UiInfo.ContentLength = strlen(((char *)UiInfo.Content));
    UiInfo.ResourceText = 0;

#ifndef _SERVER
    UiInfo.ServerOwned = 0;
#else
    UiInfo.ServerOwned = 1;
#endif

    Player[nPlayerIndex].DoScriptAction(&UiInfo);
    return 0;
}

#ifdef _SERVER
// Phong Than VNG Lua completion campaign - Wave 6.
// Skill state is owned by the player NPC. Timed actions reuse the existing
// pace-bar callback fields and shortcut changes reuse the legacy player-sync
// envelope with append-only sub-command ids.
int LuaGetLiveSkillLevelCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nLevel = 0;
	if (nPlayerIndex > 0 && nSkillId > 0 && nSkillId < MAX_SKILL)
		nLevel = Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetCurrentLevel(nSkillId);
	Lua_PushNumber(L, nLevel);
	return 1;
}

int LuaBeginLvSkillCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || Lua_GetTopIndex(L) < 2 ||
		!Lua_IsString(L, 1))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	const char *pszScript = Lua_ValueToString(L, 1);
	int nSeconds = (int)Lua_ValueToNumber(L, 2);
	if (!pszScript || !pszScript[0] || !g_GetScript(pszScript))
	{
		g_DebugLog("[LuaBeginLvSkill] unloaded script player=%d script=%s",
			nPlayerIndex, pszScript ? pszScript : "");
		Lua_PushNumber(L, 0);
		return 1;
	}
	if (nSeconds < 1) nSeconds = 1;
	if (nSeconds > 3600) nSeconds = 3600;
	Player[nPlayerIndex].m_dwTaskExcuteScriptId = g_FileName2Id((char *)pszScript);
	const char *pszFunction = Lua_GetTopIndex(L) >= 4 && Lua_IsString(L, 4) ?
		Lua_ValueToString(L, 4) : NULL;
	g_StrCpyLen(Player[nPlayerIndex].m_szTaskExcuteFun,
		pszFunction && pszFunction[0] ? pszFunction : MAINFUNCTIONNAME,
		sizeof(Player[nPlayerIndex].m_szTaskExcuteFun));
	Player[nPlayerIndex].m_nPaceBarTime = nSeconds * GAME_FPS;
	Player[nPlayerIndex].m_nPaceBarTimeMax = Player[nPlayerIndex].m_nPaceBarTime;
	Lua_PushNumber(L, 1);
	return 1;
}

int LuaDoSkillActionCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (nPlayerIndex > 0)
	{
		int nNpcIndex = Player[nPlayerIndex].m_nIndex;
		if (nNpcIndex > 0 && nNpcIndex < MAX_NPC && Npc[nNpcIndex].IsAlive())
		{
			// End movement before the server-owned timed action begins.
			Npc[nNpcIndex].SendCommand(do_stand, 0, 0, 0);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetskill_eventskilllevelCompat(Lua_State *L)
{
	int nLevel = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	if (nLevel < 0) nLevel = 0;
	if (nLevel >= MAX_SKILLLEVEL) nLevel = MAX_SKILLLEVEL - 1;
	char szValue[48];
	sprintf(szValue, "%d,0,0", nLevel);
	Lua_PushString(L, szValue);
	return 1;
}

static void SyncPhongThanClientSkill(int nPlayerIndex, int nSkillId,
	BOOL bRightSkill)
{
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
		return;
	PHONGTHAN_PLAYER_EVENT Sync;
	ZeroMemory(&Sync, sizeof(Sync));
	ZeroMemory(&Sync, sizeof(Sync));
	PhongThanInitializeWireHeader(&Sync.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(Sync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	Sync.MapId = SubWorld[Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex].m_SubWorldID;
	Sync.EntityId = Npc[Player[nPlayerIndex].m_nIndex].m_dwID;
	Sync.Operation = bRightSkill ? PHONGTHAN_PLAYER_RIGHT_SKILL :
		PHONGTHAN_PLAYER_LEFT_SKILL;
	Sync.Value = nSkillId;
	g_pServer->PackDataToClient(Player[nPlayerIndex].m_nNetConnectIdx,
		&Sync, sizeof(Sync));
}

int LuaSetClientLeftSkillCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (nPlayerIndex > 0 && nSkillId >= 0 && nSkillId < MAX_SKILL &&
		(nSkillId == 0 || Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId) > 0))
	{
		SyncPhongThanClientSkill(nPlayerIndex, nSkillId, FALSE);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetClientRightSkillCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (nPlayerIndex > 0 && nSkillId >= 0 && nSkillId < MAX_SKILL &&
		(nSkillId == 0 || Npc[Player[nPlayerIndex].m_nIndex].m_SkillList.GetLevel(nSkillId) > 0))
	{
		SyncPhongThanClientSkill(nPlayerIndex, nSkillId, TRUE);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaRemoveSpecialSkillCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nLevel = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nRemoved = 0;
	if (nPlayerIndex > 0 && nSkillId > 0 && nSkillId < MAX_SKILL)
	{
		int nNpcIndex = Player[nPlayerIndex].m_nIndex;
		KStateNode *pNode = (KStateNode *)Npc[nNpcIndex].m_StateSkillList.GetHead();
		while (pNode)
		{
			if (pNode->m_SkillID == nSkillId &&
				(nLevel <= 0 || pNode->m_Level == nLevel))
			{
				pNode->m_LeftTime = 0;
				nRemoved = 1;
				break;
			}
			pNode = (KStateNode *)pNode->GetNext();
		}
		if (Npc[nNpcIndex].m_SkillList.GetLevel(nSkillId) > 0)
		{
			Npc[nNpcIndex].m_SkillList.Remove(nSkillId);
			Player[nPlayerIndex].SendSyncData_Skill();
			nRemoved = 1;
		}
	}
	Lua_PushNumber(L, nRemoved);
	return 1;
}

int LuaPlayerCastSkillCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSkillId = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nLevel = Lua_GetTopIndex(L) >= 3 ?
		(int)Lua_ValueToNumber(L, 3) : 1;
	int nResult = 0;
	if (nPlayerIndex > 0 && nSkillId > 0 && nSkillId < MAX_SKILL &&
		nLevel > 0 && nLevel < MAX_SKILLLEVEL &&
		g_SkillManager.GetSkill(nSkillId, nLevel))
	{
		Npc[Player[nPlayerIndex].m_nIndex].Cast(nSkillId, nLevel);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

#include "PhongThanLuaWave7.h"
#include "PhongThanLuaWave8.h"
#include "PhongThanLuaWave9.h"
#include "PhongThanLuaCarriage.h"	// 2026-10-03 vantieu: SendCarriage, GetTGuardNum, GetTGuardTimeScale, AddTongAttr
#include "PhongThanLuaCongThanh.h"	// 2026-10-03 congthanh: GetCityTask, SetCityTask, AddCityIndexRes, GetCityIndexRes, GetOwnCityLevel, IsHaveTongRight, Get/AddTongContri
#include "PhongThanDieuTriLua.inl"
#include "PhongThanXichTungTuService.inl"
#include "PhongThanLuaMasterPR.h"	// 2026-10-03 sudocpp: VNG master-apprentice API, Na Tra suc luc
#include "PhongThanLuaCppBatch.h"	// 2026-10-03 cppbatch:H1 SetNpcAiMode, OpenNpcCollectionDlg
#include "PhongThanPartyBot.h"	// 2026-10-03 botparty:P4 SetPartyBotBonus, GetPartyBotBonus
#include "PhongThanBotPet.h"	// 2026-10-04 dinhanbot: AddNpcPet, GetNpcPetIdx (de tu of the Di Nhan party bots)
#include "PhongThanLuaItemNatives.h"	// 2026-10-05 natives-20261005: IsPlayer, GetNpc*Resist, VNG item API, SetItemUpgrade
#endif

int LuaFadeInMusic(Lua_State * L)
{
    return 0;
}

int LuaFadeOutMusic(Lua_State * L)
{
    return 0;
}




#ifdef _SERVER
// Phong Than 2026-10-02: Can Khon Luan. Roulette(k[, "name0|name1|..."]) starts the server-side
// spin of the calling script (Thai Tue Su). Finished() of that script runs when the spin stops on
// sector k. Returns 1 when the spin started, nil when another spin is running or no script/player.
int LuaRoulette(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER || Lua_GetTopIndex(L) < 1 || !Lua_IsNumber(L, 1))
	{
		Lua_PushNil(L);
		return 1;
	}
	KPlayer & rPlayer = Player[nPlayerIndex];
	DWORD dwScriptId = 0;
	if (rPlayer.m_nIndex > 0 && rPlayer.m_nIndex < MAX_NPC)
		dwScriptId = Npc[rPlayer.m_nIndex].m_ActionScriptID;	// script being executed (set by ExecuteScript)
	if (!dwScriptId)
		dwScriptId = rPlayer.m_dwTaskExcuteScriptId;
	const char * pszNames = NULL;
	if (Lua_GetTopIndex(L) >= 2 && Lua_IsString(L, 2))
		pszNames = Lua_ValueToString(L, 2);
	if (rPlayer.PhongThanRouletteStart((int)Lua_ValueToNumber(L, 1), dwScriptId, pszNames))
		Lua_PushNumber(L, 1);
	else
		Lua_PushNil(L);
	return 1;
}

// RouletteBusy(): 1 while a Can Khon Luan spin is running for the player, otherwise 0.
int LuaRouletteBusy(Lua_State * L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	Lua_PushNumber(L, Player[nPlayerIndex].m_nRouletteK >= 0 ? 1 : 0);
	return 1;
}
#endif

#ifndef _SERVER

int LuaPlaySound(Lua_State * L)
{
    return 0;
}

int LuaPlaySprMovie(Lua_State * L)
{
    return 0;
}
#endif
TLua_Funcs GameScriptFuns[] =
        {
                {"Say", LuaSelectUI},
                {"Talk", LuaTalkUI},
                {"Sel", LuaSelUI},
                {"GetTaskTemp", LuaGetTempTaskValue},
                {"GetTaskTempS", LuaGetTempTaskString},
                {"SetTaskTemp", LuaSetTempTaskValue},
                {"Message", LuaMessage},

                {"GetBit",	LuaGetBit},
                {"GetByte",	LuaGetByte},
                {"SetBit",	LuaSetBit},
                {"SetByte",	LuaSetByte},
                {"Include",LuaIncludeFile},
                {"AddNews",LuaAddGlobalNews},
                {"AddGlobalNews",LuaAddGlobalNews},
                {"AddNews2",LuaAddGlobalNews2},
                {"AddTimeNews",LuaAddGlobalTimeNews},
                {"AddTimeNews2",LuaAddGlobalTimeNews2},
                {"AddCountNews",LuaAddGlobalCountNews},
                {"AddGlobalCountNews",LuaAddGlobalCountNews},
                {"AddCountNews2",LuaAddGlobalCountNews2},
                {"AddLocalNews",LuaAddLocalNews},
                {"AddLocalTimeNews",LuaAddLocalTimeNews},
                {"AddLocalCountNews",LuaAddLocalCountNews	},


#ifdef _SERVER
	// Phong Than VNG Lua completion campaign - Wave 1.
	{"GetYMD", LuaGetYMD},
	{"GetHMS", LuaGetHMS},
	{"GetWeekDay", LuaGetWeekDayCompat},
	{"GetGameServerName", LuaGetGameServerNameCompat},
	{"GetIPValue", LuaGetIPValueCompat},
	{"GetGlobalValueByte", LuaGetGlobalValueByteCompat},
	{"SetGlobalValueByte", LuaSetGlobalValueByteCompat},
	{"GetGlobalValueWord", LuaGetGlobalValueWordCompat},
	{"SetGlobalValueWord", LuaSetGlobalValueWordCompat},
	{"IsWarServer", LuaIsWarServerCompat},
	{"pcall", LuaPCallCompat},
	{"ipairs", LuaIPairsCompat},
	{"Msg2CurMapAnnounceEx", LuaMsg2CurMapAnnounceEx},
	{"Msg2CurMapAnnounce", LuaMsg2CurMapAnnounce},
	{"MsgBox", LuaMsgBoxCompat},
	{"NpcSay", LuaNpcSayCompat},
	{"InfoBox", LuaInfoBoxCompat},
	{"GetDialogNpcName", LuaGetDialogNpcNameCompat},
	{"SearchPlayerById", LuaSearchPlayerByIdCompat},
	{"GetPlayerIndexByName", LuaGetPlayerIndexByNameCompat},
	{"GetSubWorldPlayerCount", LuaGetSubWorldPlayerCountCompat},
	{"GetSubWorldPlayerIdxByNum", LuaGetSubWorldPlayerIdxByNumCompat},
	{"GetFirstPlayerInAll", LuaGetFirstPlayerInAllCompat},
	{"GetNextPlayerInAll", LuaGetNextPlayerInAllCompat},
	{"GetSessionNextPlayer", LuaGetSessionNextPlayerCompat},
	{"PlayerIndexToNpcIndex", LuaPlayerIndexToNpcIndexCompat},
	// Phong Than VNG item/inventory completion - Wave 2.
	{"HaveNormalItem", LuaHaveNormalItemCompat},
	{"AddNormalItemPile", LuaAddNormalItemPileCompat},
	{"IsHaveSpaceForTreasure", LuaIsHaveSpaceForTreasureCompat},
	{"AddEventItem", LuaAddEventItemCompat},
	{"ClearItem", LuaClearItemCompat},
	{"HaveEventItem", LuaHaveEventItemCompat},
	{"DelNormalItem", LuaDelNormalItemCompat},
	{"AddNormalItemBind", LuaAddNormalItemBindCompat},
	{"HaveItemInAllRoom", LuaHaveItemInAllRoomCompat},
	{"GetBoxSize", LuaGetBoxSizeCompat},
	{"HaveEventItemCount", LuaHaveEventItemCountCompat},
	{"IsEquipItem", LuaIsEquipItem},
	{"AbradeEquip", LuaAbradeEquipCompat},
	{"DelEventItem", LuaDelEventItemCompat},
	{"GetNormalItemName", LuaGetNormalItemNameCompat},
	{"DelNormalItemInQuick", LuaDelNormalItemInQuickCompat},
	// Phong Than VNG progression/relation/title/team completion - Wave 3.
	{"GetPlayerExtLevel", LuaGetPlayerExtLevelCompat},
	{"GetJusticEvilCredit", LuaGetJusticEvilCreditCompat},
	{"GetPlayerType", LuaGetPlayerTypeCompat},
	{"IsMantlePrentice", LuaIsMantlePrenticeCompat},
	{"IsPlayerInsideWeapon", LuaIsPlayerInsideWeaponCompat},
	{"TeamAction", LuaTeamActionCompat},
	{"IsMasterPRRelation", LuaIsMasterPRRelationCompat},
	{"IsMantleMaster", LuaIsMantleMasterCompat},
	{"GetMantleMasterName", LuaGetMantleMasterNameCompat},
	{"IsPlayerInDeath", LuaIsPlayerInDeathCompat},
	{"AddHelpScore", LuaAddHelpScoreCompat},
	{"GetTeamTask", LuaGetTeamTaskCompat},
	{"SetTeamTask", LuaSetTeamTaskCompat},
	{"AddOwnExtendExp", LuaAddOwnExtendExpCompat},
	{"ActiveTitleQualify", LuaActiveTitleQualifyCompat},
	{"SetCurTitle", LuaSetCurTitleCompat},
	{"GetMasterPlayerIndex", LuaGetMasterPlayerIndexCompat},
	{"ChangeJusticEvilCredit", LuaChangeJusticEvilCreditCompat},
	{"GetExploitLevel", LuaGetExploitLevelCompat},
	{"ActiveTitleFunc", LuaActiveTitleFuncCompat},
	{"GetPosterityType", LuaGetPosterityTypeCompat},
	{"IsMarried", LuaIsMarriedCompat},
	{"GetExploit", LuaGetExploitCompat},
	{"SetExploitV", LuaSetExploitVCompat},
	{"SetExploit", LuaSetExploitCompat},
	{"GetExploitV", LuaGetExploitVCompat},
	{"GetPlayerTarget", LuaGetPlayerTargetCompat},
	{"ApplyAssignedAttrib", LuaApplyAssignedAttribCompat},
	{"AddAssignedAttrib", LuaAddAssignedAttribCompat},
	{"GetAssignedAttrib", LuaGetAssignedAttribCompat},
	{"HaveQualify", LuaHaveQualifyCompat},
	{"PetGetType", LuaPetGetTypeCompat},
	{"GetSummonPetIdx", LuaGetSummonPetIdx},			// engine2:C5t
	{"SetNpcAllocZone", LuaSetNpcAllocZone},			// engine2:A4 high NPC index zone (ext matdo)
	{"GetNpcLowZone", LuaGetNpcLowZone},				// engine2:A4
	{"GetNpcStateExpRate", LuaGetNpcStateExpRate},		// engine2:D1 (pt_ibitem_lib.lua)
	// 2026-10-03 sudocpp: VNG master-apprentice API (PhongThanLuaMasterPR.h).
	{"MasterPRVersion", LuaMasterPRVersionCompat},
	{"GetMasterPRValue", LuaGetMasterPRValueCompat},
	{"AddMasterPRValue", LuaAddMasterPRValueCompat},
	{"DecMasterPRValue", LuaDecMasterPRValueCompat},
	{"CanMasterPR", LuaCanMasterPRCompat},
	{"DoMasterPR", LuaDoMasterPRCompat},
	{"UnMasterPREx", LuaUnMasterPRExCompat},
	{"CanChangeMasterPRValue", LuaCanChangeMasterPRValueCompat},
	{"ChangeMasterPRValue", LuaChangeMasterPRValueCompat},
	{"IsMaster", LuaIsMantleMasterCompat},
	{"GetNativeWeightMax", LuaGetNativeWeightMaxCompat},
	{"AddWeightMax", LuaAddWeightMaxCompat},
	// Authoritative VNG APIs required by the 26 original Dieu Tri NPC scripts.
	{"AddNormalItem2", LuaAddNormalItem2Vng},
	{"GetItemLevel2", LuaGetItemLevel2Vng},
	{"DelItem2", LuaDelItem2Vng},
	{"SaleEx", LuaSaleExVng},
	{"GetPetType", LuaGetPetTypeVng},
	{"DelPet", LuaDelPetVng},
	{"CanMarry", LuaCanMarryVng},
	{"GetMateTask", LuaGetMateTaskVng},
	{"GetMateNameID", LuaGetMateNameIDVng},
	{"GetNameID", LuaGetNameIDVng},
	{"DoMarry", LuaDoMarryVng},
	{"Enhance", LuaEnhanceVng},
	{"GetCredit", LuaGetCreditVng},
	{"XichTungTuService", LuaXichTungTuService},
	{"AddCredit", LuaAddCreditVng},
	{"DecCredit", LuaDecCreditVng},
	{"GetTreasureCount", LuaGetTreasureCountVng},
	{"AddTreasure", LuaAddTreasureVng},
	{"WasteTreasure", LuaWasteTreasureVng},
	{"IsHaveSpaceForCopperCash", LuaIsHaveSpaceForCopperCashVng},
	{"AddCopperCash", LuaAddCopperCashVng},
	{"UseSilver", LuaUseSilverVng},
	{"StopUsePills", LuaStopUsePillsVng},
	{"ReplaceBoxPwd", LuaReplaceBoxPwdVng},
	{"AddCon", LuaAddConVng},
	{"AddInt", LuaAddIntVng},
	// Phong Than VNG player/NPC IBBuff completion - Wave 4.
	{"HaveIBBuff", LuaHaveIBBuffCompat},
	{"AddIBBuff", LuaAddIBBuffCompat},
	{"RemoveIBBuff", LuaRemoveIBBuffCompat},
	{"GetIBBuffTimes", LuaGetIBBuffTimesCompat},
	{"GetIBBuffLeftTimes", LuaGetIBBuffLeftTimesCompat},
	{"GetIBBuffCount", LuaGetIBBuffCountCompat},
	{"NpcRemoveIBBuff", LuaNpcRemoveIBBuffCompat},
	{"NpcHaveIBBuff", LuaNpcHaveIBBuffCompat},
	{"GetIBBuffLevel", LuaGetIBBuffLevelCompat},
	{"NpcAddIBBuff", LuaNpcAddIBBuffCompat},
	{"CostIBBuff", LuaCostIBBuffCompat},
	// Phong Than VNG task/journal completion - Wave 5.
	{"TaskNote", LuaTaskNoteCompat},
	{"FinishNpcCollection", LuaFinishNpcCollectionCompat},
	{"SayTask", LuaSayTaskCompat},
	{"SetPlayerTaskState", LuaSetPlayerTaskStateCompat},
	{"SetMateTask", LuaSetMateTaskCompat},
	{"SetSubTask", LuaSetSubTaskCompat},
	{"RefreshAllNpcTask", LuaRefreshAllNpcTaskCompat},
	{"IsNewBirthComplete", LuaIsNewBirthCompleteCompat},
	{"IsJEMainTaskComplete", LuaIsJEMainTaskCompleteCompat},
	{"JEMainTaskComplete", LuaJEMainTaskCompleteCompat},
	{"NewTaskNote", LuaNewTaskNoteCompat},
	{"TaskCheck", LuaTaskCheckCompat},
	// Phong Than VNG skill/combat/action completion - Wave 6.
	{"GetLiveSkillLevel", LuaGetLiveSkillLevelCompat},
	{"BeginLvSkill", LuaBeginLvSkillCompat},
	{"DoSkillAction", LuaDoSkillActionCompat},
	{"Getskill_eventskilllevel", LuaGetskill_eventskilllevelCompat},
	{"SetClientRightSkill", LuaSetClientRightSkillCompat},
	{"RemoveSpecialSkill", LuaRemoveSpecialSkillCompat},
	{"SetClientLeftSkill", LuaSetClientLeftSkillCompat},
	{"PlayerCastSkill", LuaPlayerCastSkillCompat},
	// Phong Than VNG NPC/AI/effect completion - Wave 7.
	{"GetHardNpcAttrib", LuaGetHardNpcAttribCompat},
	{"NpcPolyMorph", LuaNpcPolyMorphCompat},
	{"SetAIScript", LuaSetAIScriptCompat},
	{"SetNpcCamp", LuaSetNpcCampCompat},
	{"SetGuardLevel", LuaSetGuardLevelCompat},
	{"AddTotemNpc", LuaAddTotemNpcCompat},
	// 2026-10-03 cppbatch:H2 pet AI mode 11/13 and the Giang Son book stub (PhongThanLuaCppBatch.h)
	{"SetNpcAiMode", LuaSetNpcAiModeCompat},
	// 2026-10-03 botparty:P5 party-bot EXP bonus (PhongThanPartyBot.h, KNpcDeathCalcExp.cpp)
	{"SetPartyBotBonus", LuaSetPartyBotBonusCompat},
	{"GetPartyBotBonus", LuaGetPartyBotBonusCompat},
	// 2026-10-04 dinhanbot: de tu (summon pet) owned by a Di Nhan party bot (PhongThanBotPet.h)
	{"AddNpcPet", LuaAddNpcPetCompat},
	{"GetNpcPetIdx", LuaGetNpcPetIdxCompat},
	{"OpenNpcCollectionDlg", LuaOpenNpcCollectionDlgCompat},
	{"AddMyTrap", LuaAddMyTrapCompat},
	{"GetMorphType", LuaGetMorphTypeCompat},
	{"SetNpcTarget", LuaSetNpcTargetCompat},
	{"PolyMorph", LuaPolyMorphCompat},
	{"GetCreatureInfo", LuaGetCreatureInfoCompat},
	{"SetCreatureType", LuaSetCreatureTypeCompat},
	{"DelNpcTimer", LuaDelNpcTimerCompat},
	{"CancelNpcBelonger", LuaCancelNpcBelongerCompat},
	{"BeginMotion", LuaBeginMotionCompat},
	{"GetBossTargetPlayer", LuaGetBossTargetPlayerCompat},
	{"GetNpcPolyMorph", LuaGetNpcPolyMorphCompat},
	{"SetEffectNpc", LuaSetEffectNpcCompat},
	{"SetEffectNpcCount", LuaSetEffectNpcCountCompat},
	{"GetFreeNpcCount", LuaGetFreeNpcCountCompat},
	{"HaveEffectNpc", LuaHaveEffectNpcCompat},
	{"ClearEffectNpc", LuaClearEffectNpcCompat},
	{"ModifyEffectNpc", LuaModifyEffectNpcCompat},
	{"CaptureNpc", LuaCaptureNpcCompat},
	{"CallMonsterAttacker", LuaCallMonsterAttackerCompat},
	{"GetNpcBelonger", LuaGetNpcBelongerCompat},
	{"DelBuildingNpc", LuaDelBuildingNpcCompat},
	{"GetNpcEnmityItem", LuaGetNpcEnmityItemCompat},
	{"GetGuardLevel", LuaGetGuardLevelCompat},
	{"GetNpcEnmityCount", LuaGetNpcEnmityCountCompat},
	{"GetNpcOwer", LuaGetNpcOwerCompat},
	// Phong Than VNG Tong/city/siege completion - Wave 8.
	{"IsTongMember", LuaIsTongMemberCompat},
	{"Msg2TongMember", LuaMsg2TongMemberCompat},
	{"Msg2TongMemberByTongName", LuaMsg2TongMemberByTongNameCompat},
	{"IsOwnerCity", LuaIsOwnerCityCompat},
	{"GetCityInfo", LuaGetCityInfoCompat},
	{"NewSiegeWeapon", LuaNewSiegeWeaponCompat},
	{"GetSiegeWeaponNpcIndex", LuaGetSiegeWeaponNpcIndexCompat},
	{"GetTongIDByName", LuaGetTongIDByNameCompat},
	{"GetSiegeWeaponPlayerCount", LuaGetSiegeWeaponPlayerCountCompat},
	{"GetCityInfoByID", LuaGetCityInfoByIDCompat},
	{"GetNpcMapCityID", LuaGetNpcMapCityIDCompat},
	{"GetTGuardInfo", LuaGetTGuardInfoCompat},
	{"GetCityTaskByID", LuaGetCityTaskByIDCompat},
	{"DeleteSiegeWeapon", LuaDeleteSiegeWeaponCompat},
	{"GetTGuardIndexByCarriageIndex", LuaGetTGuardIndexByCarriageIndexCompat},
	{"GetSiegeWeaponIndexByNpcIndex", LuaGetSiegeWeaponIndexByNpcIndexCompat},
	{"GetTGuardIndexByPlayerName", LuaGetTGuardIndexByPlayerNameCompat},
	{"ModifyUnionTongWarPowerByName", LuaModifyUnionTongWarPowerByNameCompat},
	{"GetTongTaskByID", LuaGetTongTaskByIDCompat},
	{"GetUnionTongNameByPosterityType", LuaGetUnionTongNameByPosterityTypeCompat},
	{"SetCityTaskByID", LuaSetCityTaskByIDCompat},
	{"GetUnionTongIDByPosterityType", LuaGetUnionTongIDByPosterityTypeCompat},
	{"GetHeavenCityUnion", LuaGetHeavenCityUnionCompat},
	{"GetCityGateNpcIdxByNpc", LuaGetCityGateNpcIdxByNpcCompat},
	{"IsInMonsterAttackDay", LuaIsInMonsterAttackDayCompat},
	{"GetCityTotemNpcIdxByNpc", LuaGetCityTotemNpcIdxByNpcCompat},
	{"SetTongTask", LuaSetTongTaskCompat},
	{"AddTongRes", LuaAddTongResCompat},
	{"GetTongTask", LuaGetTongTaskCompat},
	{"GetCityName", LuaGetCityNameCompat},
	// Phong Than VNG instance/world-event/map completion - Wave 9.
	{"WorldBossDeath", LuaWorldBossDeathCompat},
	{"SetInstanceTempValue", LuaSetInstanceTempValueCompat},
	{"InstanceMsg2All", LuaInstanceMsg2AllCompat},
	{"MonsterOnDeath", LuaMonsterOnDeathCompat},
	{"PlayerInOrOut", LuaPlayerInOrOutCompat},
	// 2026-10-03 vantieu: Van Tieu / Van Luong escort carriages (PhongThanLuaCarriage.h)
	{"SendCarriage", LuaSendCarriageCompat},
	{"GetTGuardNum", LuaGetTGuardNumCompat},
	{"GetTGuardTimeScale", LuaGetTGuardTimeScaleCompat},
	{"AddTongAttr", LuaAddTongAttrCompat},
	// 2026-10-03 congthanh: VNG territory natives, guild mode (PhongThanLuaCongThanh.h)
	{"GetCityTask", LuaGetCityTaskCompat},
	{"SetCityTask", LuaSetCityTaskCompat},
	{"AddCityIndexRes", LuaAddCityIndexResCompat},
	{"GetCityIndexRes", LuaGetCityIndexResCompat},
	{"GetOwnCityLevel", LuaGetOwnCityLevelCompat},
	{"IsHaveTongRight", LuaIsHaveTongRightCompat},
	{"GetTongContri", LuaGetTongContriCompat},
	{"AddTongContri", LuaAddTongContriCompat},
	{"AddEvent", LuaAddEventCompat},
	{"GetInstanceActiveInfo", LuaGetInstanceActiveInfoCompat},
	{"GetInstanceBaseInfo", LuaGetInstanceBaseInfoCompat},
	{"GetInstanceTempValue", LuaGetInstanceTempValueCompat},
	{"SetMissionV", LuaSetMissionVCompat},
	{"GetWorldEventValue", LuaGetWorldEventValueCompat},
	{"SetWorldEventValue", LuaSetWorldEventValueCompat},
	{"DeleteSubWorldKindNpcs", LuaDeleteSubWorldKindNpcsCompat},
	{"SetBarrierState", LuaSetBarrierStateCompat},
	{"SetWorldEventProgress", LuaSetWorldEventProgressCompat},
	{"GetWorldEventProgress", LuaGetWorldEventProgressCompat},
                {"PutMessage"	,	LuaSendMessageInfo},
	{"TopMessage",	LuaTopMessage},
	{"ScrollMessage",	LuaScrollMessage},
	{"CloseDialog",	LuaCloseDialog},
	{"SetExeState",	LuaSetExeStateCompat},
	{"WriteLog",		LuaWriteLog},
	{"SystemTime",		LuaSystemTime},
	{"LocalSystemTime",	LuaLocalSystemTime},
	{"GetGlobalValue",	LuaGetGlobalValue},
	{"SetGlobalValue",	LuaSetGlobalValue},
	{"GetGameTime",	LuaGetGameTime},
	{"GetLoginTime", LuaGetPlayerLoginTime},
	{"GetOnlineTime", LuaGetPlayerOnlineTime},
	{"OfflineLive", LuaOfflineLive},

	{"SetValue", LuaSetValue},
	{"AddValue", LuaAddValue},
	{"GetValue",LuaGetValue},
	{"SetRepute", LuaSetPlayerReputeValue},
	{"AddRepute", LuaAddPlayerReputeValue},
	{"GetRepute",LuaGetPlayerReputeValue},
	{"AddTranslife", LuaAddPlayerTranslifeValue},
	{"GetTranslife",LuaGetPlayerTranslifeValue},
	{"GetNewBirthTimes",LuaGetPlayerTranslifeValue},
	{"AddViprank", LuaAddPlayerViprankValue},
	{"GetViprank",LuaGetPlayerViprankValue},
	{"SetFuYuan", LuaSetPlayerFuYuanValue},
	{"AddFuYuan", LuaAddPlayerFuYuanValue},
	{"GetFuYuan",LuaGetPlayerFuYuanValue},
	{"AddAccum", LuaAddPlayerAccumValue},
	{"GetAccum",LuaGetPlayerAccumValue},
	{"AddHonor", LuaAddPlayerHonorValue},
	{"GetHonor",LuaGetPlayerHonorValue},
	{"AddRespect", LuaAddPlayerRespectValue},
	{"GetRespect",LuaGetPlayerRespectValue},
	{"GetNpcIdx", LuaGetCurNpcIndex},

	{"SetTimer",		LuaSetTimer},		//SetTimer(??????????????, ????????TaskId):?????????????????????????????,????????????????????????????????????OnTimer????????????
	{"StopTimer",		LuaStopTimer},		//StopTimer()???????????????????????????????????????
	{"GetRestTime",		LuaGetRestTime},	//GetRestTime:???????????????????????????????????????????????????????????
	{"GetTimerId",		LuaGetCurTimerId},	//CurTimerId = GetTimerId():???????????????????????????????????????id,???????????????????????????0
	{"GetTask",			LuaGetTaskValue},	//GetTask(???????????????):???????????????????????????????????????????
	{"GetTaskS",		LuaGetTaskString},	//GetTask(???????????????):???????????????????????????????????????????
	{"SetTask",			LuaSetTaskValue},	//SetTask(???????????????,??):??????????????????????????
	{"GetTaskByte",	LuaGetTaskByte},
	{"SetTaskByte",	LuaSetTaskByte},
	{"GetTaskWord",	LuaGetTaskWord},
	{"SetTaskWord",	LuaSetTaskWord},
	{"GetTaskBit",	LuaGetTaskBit},
	{"SetTaskBit",	LuaSetTaskBit},
	{"SyncTaskValue",	LuaSyncTaskValue},	//SetTask(???????????????,??):??????????????????????????
	{"IsCaptain",		LuaIsLeader},		//IsCaptain()??????????????????
	{"GetTeam",			LuaGetTeamId},		//GetTeam()?????????????????????????????ID
	{"GetTeamSize",		LuaGetTeamSize},	//GetTeamSize()
	{"GetTeamMem",		LuaGetTeamMem},
	{"GetTeamMember",	LuaGetTeamMember},
	{"LeaveTeam",		LuaLeaveTeam},		//LeaveTeam()?????????????????????????????????????????????
	{"TeamDoScript",	LuaTeamDoScript},	//TeamDoScript(links,func) return number player has set
	{"Msg2Player",		LuaMsgToPlayer	},	//Msg2Player(????????)
	{"Msg2Team",		LuaMsgToTeam},		//Msg2Team(????????)?????????????????????
	{"Msg2SubWorld",	LuaMsgToSubWorld},	//Msg2SubWorld(????????)????????????????
	{"Msg2Profession",		LuaMsgToProfession},
	{"Msg2Tong",		LuaMsgToTong},
	{"Msg2Room",		LuaMsgToChatRoom},
	{"Msg2Region",		LuaMsgToAroundRegion},//Msg2Region(????????)????????????Region
	{"Msg2GM",			LuaMsgToGameMaster}, //Msg2GM(StrInfo)
	{"Msg2IP",			LuaMsgToIP}, //Msg2IP(IP, ID, StrInfo)
	{"GetIP",			LuaGetIP},
	{"SetPos",			LuaSetPos},			//SetPos(x,y)????????????????????
	{"GetPos",			LuaGetPos},			//GetPos() return x,y,subworldindex
	{"GetWorldPos",		LuaGetNewWorldPos},	//W,X,Y = GetWorldPos()??????????????????NewWorld???????????????????????????
	{"GetWorldName",	LuaGetNewWorldName},
	{"GetWorldKind",	LuaGetNewWorldKind},
	{"GetFreePos",		LuaGetFreeObjPos},
	{"GetNpcPos",		LuaGetNpcPos},
	{"GetNpcWorldPos",	LuaGetNpcPos},
	{"NewWorld",		LuaEnterNewWorld},
	{"NpcNewWorld",		LuaNpcEnterNewWorld},

	//TamLTM Bang hoi chiem linh
	{"LoadTongMap",LuaLoadTongMap},
	{"GetTongMap",LuaGetTongMap},
	{"SetTongMap",LuaSetTongMap},
	//end code

	{"DropMoney",		LuaDropMoney},
	{"DropItem",		LuaDropItem},
	{"DropMapItem",		LuaDropMapItem},
	{"ThrowItem",		LuaThrowItem},
///////////////////////////////////////////
	{"AddNormalItem",		LuaAddNormalItem},
	{"QuestExchange", LuaQuestExchange},
	{"IsExistItem",		LuaIsExistItem},
	{"FindAValidIBItem",	LuaFindAValidIBItem},
	{"CostIBItem",		LuaCostIBItem},
	{"AddItem",				LuaAddItem},
	{"AddItemIdx",			LuaAddItemIdx},
	{"AddItemID",			LuaAddItemID},
	{"AddItemIDStack",		LuaAddItemIDStack},

	{"DelItem",				LuaDelItem},
	{"ConsumeItem",			LuaDelItem},
	{"GetItemCount",		LuaGetItemCount},
	{"GetItemCountRoom",	LuaGetItemCountRoom},
	{"GetItemPartByID",	LuaGetItemPartByID},

	{"GetMagicAttrib",		LuaGetMagicAttrib},
	{"SetMagicAttrib",		LuaSetMagicAttrib},

	{"AddMagic",		LuaAddMagic},		//AddMagic(????????id????????????????????)?????????????????????????????????
	{"DelMagic",		LuaDelMagic},		//DelMagic(????????id????????????????????)
	{"DelAllMagic",		LuaDelAllMagic},		//DelMagic(????????id????????????????????)
	{"HaveMagic",		LuaHaveMagic},		//HaveMagic(????????id????????????????????)????????????0??????1
	{"IncSkill",		LuaIncSkill},
	{"IncSkillExp",		LuaIncSkillExp},
	{"GetMagicLevel",	LuaGetMagicLevel},	//GetMagicLevel(????????id????????????????????)????????????????
	{"IsSkillActived",	LuaIsSkillActived},
	{"ActiveNewBirthSkill", LuaActiveNewBirthSkill},
	{"AddSkillLevel",	LuaAddSkillLevelCompat},
	{"SetSummonBeastMorph", LuaSetSummonBeastMorph},
	{"AddMagicPoint",	LuaAddMagicPoint},
	{"GetMagicPoint",	LuaGetMagicPoint},

	{"SubWorldID2Idx",	LuaSubWorldIDToIndex}, //SubWorldID2Idx
	{"SubWorldIdx2ID",	LuaSubWorldIndexToID}, //SubWorldID2Idx


	{"AddLeadExp",		LuaAddLeadExp},
	{"SetLeadLevel",	LuaSetLeadLevel},
	{"GetLeadLevel",	LuaGetLeadLevel},

	{"SetFightState",	LuaSetFightState},
	{"GetFightState",	LuaGetFightState},

	{"GetNpcTemplateID",LuaGetNpcTemplateID},
	{"GetNpcSettingIdx",LuaGetNpcTemplateID},
	{"GetNpcTempName",	LuaGetNpcTempName},
	{"GetNpcTempTypeName",	LuaGetNpcTempTypeName},
	{"AddPlayerBot",			LuaAddPlayerBot},	
	{"AddNpc",			LuaAddNpc},			//AddNpc(????????????????????id????????????????????????????????,????????????????????????id????????????????????????x,??????????????????y),????????????npcid??
	{"DelNpc",			LuaDelNpc},			//DelNpc(Npcid)
	{"ClearMapNpc",		LuaClearMapNpc},
	{"ClearMapNpcWithName",		LuaClearMapNpcWithName},
	{"SetNpcKind",		LuaSetNpcKind},
	{"SetNpcSeries",	LuaSetNpcSeries},
	{"SetNpcSer",		LuaSetNpcSeries},
	{"GetNpcSer",		LuaGetNpcSeries},
	{"SetNpcExp",		LuaSetNpcExp},
	{"SetNpcLife",		LuaSetNpcLife},
	{"GetNpcLife",		LuaGetNpcLife},
	{"GetNpcLevel",		LuaGetNpcLevel},
	{"SetNpcReplenish",	LuaSetNpcLifeReplenish},
	{"SetNpcAR",		LuaSetNpcAR},
	{"SetNpcDefense",	LuaSetNpcDefense},
	{"SetNpcDamage",	LuaSetNpcDamage},
	{"SetNpcDmgEx",		LuaSetNpcDmgEx},
	{"SetNpcResist",	LuaSetNpcResist},
	{"SetNpcRevTime",	LuaSetNpcRevTime},
	{"SetNpcSpeed",		LuaSetNpcSpeed},
	{"SetNpcHitRecover",LuaSetNpcHitRecover},
	{"SetNpcBoss",		LuaSetNpcBoss},
	{"GetNpcBoss",		LuaGetNpcBoss},
	{"IsBlueBoss",		LuaIsBlueBoss},
	{"GetNpcExpRate",	LuaGetNpcExpRate},
	{"IsRideHorse",		LuaIsRideHorse},
	{"SyncNpc",			LuaSyncNpc},
	{"SetNpcPos",		LuaSetNpcPos},
	{"SetNpcScript",	LuaSetNpcActionScript},	//SetNpcScript(npcid, ??????????????????????)????????????npc??????????????????
	{"SetNpcName",		LuaSetNpcName},
	{"GetNpcName",		LuaGetNpcName},
	{"GetNpcID",		LuaGetNpcID},
	{"SetNpcSkill",		LuaSetNpcSkill},
	{"SetNpcDropScript",LuaSetNpcDropScript},
	{"SetNpcRemoveDeath",	LuaSetNpcRemoveDeath},
	{"SetNpcTimeout",	LuaSetNpcTimeout},
	{"SetNpcTimer",		LuaSetNpcTimer},
	{"GetNpcTimeout",	LuaGetNpcTimeout},
	{"SetNpcParam",		LuaSetNpcParam},
	{"SetNpcValue",		LuaSetNpcParam},
	{"GetNpcParam",		LuaGetNpcParam},
	{"GetNpcValue",		LuaGetNpcParam},
	{"SetNpcTask",		LuaSetNpcParam},
	{"GetNpcTask",		LuaGetNpcParam},
	{"SetNpcOwner",		LuaSetNpcOwner},
	{"GetNpcOwner",		LuaGetNpcOwner},
	{"SetNpcFindPathTime",LuaSetNpcFindPathTime},
	{"SetNpcCurCamp",	LuaSetNpcCurCamp},
	{"SetRevPos",		LuaSetPlayerRevivalPos},//SetRevPos(??????????????X????????????????????Y)?????????????????????????????????????????????????????????????
	{"Rev2Pos",			LuaGetPlayerRevivalPos},//SetRevPos(??????????????X????????????????????Y)?????????????????????????????????????????????????????????????
	{"GetCurRev",		LuaGetPlayerRevival},
	{"GetCurRevID",		LuaGetPlayerRevivalID},
	{"SetTempRevPos",	LuaSetDeathRevivalPos}, //SetTempRevPos(subworldid, x, y ) or SetTempRevPos(id);
	{"Revive",			LuaPlayerExecuteRevive}, //SetTempRevPos(subworldid, x, y ) or SetTempRevPos(id);
	{"GetCurCamp",		LuaGetPlayerCurrentCamp},//GetCurCamp()????????????????????????????????
	{"GetCamp",			LuaGetPlayerCamp},//GetCamp()??????????????????????????
	{"SetCurCamp",		LuaSetPlayerCurrentCamp},//SetCurCamp(??????????????):?????????????????????????????????
	{"SetCamp",			LuaSetPlayerCamp},		  //SetCamp(??????????????):????????????????????
	{"RestoreCamp",		LuaRestorePlayerCamp},//RestoreCamp()????????????????
	{"GetProfessionKey",		LuaGetPlayerProfessionKey,},//GetProfessionKey()??????????????????????????????????????
	{"GetProfessionName",	LuaGetPlayerProfessionName,},
	{"GetProfessionCamp",	LuaGetPlayerProfessionCamp,},
	{"GetProfession",	LuaGetPlayerProfession},
	{"SetProfession",	LuaSetPlayerProfession},
	{"GetColdR",		LuaGetPlayerColdResist},
	{"SetColdR",		LuaSetPlayerColdResist},
	{"GetFireR",		LuaGetPlayerFireResist},
	{"SetFireR",		LuaSetPlayerFireResist},
	{"GetLightR",		LuaGetPlayerLightResist},
	{"SetLightR",		LuaSetPlayerLightResist},
	{"GetPoisonR",		LuaGetPlayerPoisonResist},
	{"SetPoisonR",		LuaSetPlayerPoisonResist},
	{"GetPhyR",			LuaGetPlayerPhysicsResist},
	{"SetPhyR",			LuaSetPlayerPhysicsResist},
	{"GetNextExp",		LuaGetNextExp},			//GetExp():??????????????????????????????????????
	{"GetExp",			LuaGetPlayerExp	},			//GetExp():??????????????????????????????????????
	{"AddExp",			LuaModifyPlayerExp},		//AddExp(?????????????????????????????????????????????????????????????????????????????????)
	{"AddOwnExp",		LuaAddOwnExp},				//AddOwnExp(Exp)???????????????????????????????????????
	{"AddStackExp",		LuaAddStackExp},				//AddSumExp(Exp)???????????????????????????????????????
	{"GetLife",			LuaGetPlayerLife},			//GetLife()??????????????????????????????????
	{"RestoreLife",		LuaRestorePlayerLife},		//RestoreLife()???????????????????????????????
	{"GetMana",			LuaGetPlayerMana},			//GetMana()????????????????????Mana
	{"RestoreMana",		LuaRestorePlayerMana},		//RestoreMana()???????????????????Mana
	{"GetStamina",		LuaGetPlayerStamina},		//GetStamina()??????????????????Stamina
	{"RestoreStamina",	LuaRestorePlayerStamina},	//RestoreMana()???????????????????Stamina
	{"GetDefend",		LuaGetPlayerDefend},		//GetDefend()??????????????????????????????????
	{"GetSex",			LuaGetPlayerSex},			//GetSex()????????????????????????????
	{"GetSeries",		LuaGetPlayerSeries},		//GetSeries()??????????????????????0man/1woman
	{"SetSeries",		LuaSetPlayerSeries},		//SetSeries(???????????)
	{"GetName",			LuaGetPlayerName},			//GetName()????????????????????????????????
	{"GetPlayerNpcIdx",	LuaGetPlayerNpcIdx},
	{"GetMateName",		LuaGetMateName},
	{"GetAccount",		LuaGetPlayerAccount},
	{"GetKeyPc",		LuaGetKeyPc},				//anti 1 acc tong kim
	{"GetUUID",			LuaGetPlayerID},			//GetUUID()????????????????????????ID
	{"GetPlayerID",		LuaGetPlayerID},
	{"FindPlayer",		LuaFindPlayer},			//GetUUID()????????????????????????ID
	{"FindNamePlayer",	LuaFindNamePlayer },			//Ham su dung duoc cho ca Player dat ten la Number
	{"FindNearNpc",		LuaFindNearNpc},
	{"FindAroundNpc",	LuaFindAroundNpc},
	{"GetLeadExp",		LuaGetPlayerLeadExp},		//GetLeadExp()??????????????????????????????????????
	{"GetLeadLevel",	LuaGetPlayerLeadLevel},		//GetLeadLevel()????????????????????????????????
	{"SetLevel",		LuaSetLevel},
	{"GetLevel",		LuaGetLevel},				//GetLevel()GetPlayers Level
	{"GetPlayerLevel",	LuaGetLevel},				//GetLevel()GetPlayers Level
	{"GetRestAP",		LuaGetPlayerRestAttributePoint},//GetRestAP()????????????????????????????????????????????????
	{"GetRestSP",		LuaGetPlayerRestSkillPoint},	//GetRestSP()????????????????????????????????????????????
	{"GetLucky",		LuaGetPlayerLucky},			//GetLucky()??????????????????????????????????
	{"GetEng",			LuaGetPlayerEngergy},		//GetEng()??????????????????????????????????Eng
	{"AddEng",			LuaSetPlayerEngergy},		//AddEng(Value)??????????????????????????????????Eng
	{"GetDex",			LuaGetPlayerDexterity},		//GetDex()????????????????????Dex
	{"AddDex",			LuaSetPlayerDexterity},		//AddDex(Value)??????????????????????????????????Eng
	{"GetStrg",			LuaGetPlayerStrength},		//GetStrg()
	{"AddStrg",			LuaSetPlayerStrength},		//AddStrg(Value)??????????????????????????????????Eng
	{"GetVit",			LuaGetPlayerVitality},		//GetVit()
	{"AddVit",			LuaSetPlayerVitality},		//AddVit(Value)??????????????????????????????????Eng
	{"ResetBaseAttrib",	LuaResetBaseAttribute},		// ????????????????????????????????
	{"ResetProp",		LuaResetProp},
	{"GetCash",			LuaGetPlayerCashMoney},		//GetCash()????????????????????????????
	{"Pay",				LuaPlayerPayMoney},			//Pay(???????????????)?????????????????????????????????????????1??????????????????????0
	{"Earn",			LuaPlayerEarnMoney},		//Earn(???????????????)?????????????????????????
	{"PrePay",			LuaPlayerPrePayMoney},		//????????????????????????????????????1??????????????????????0
	{"GetPlayerFortune",LuaGetPlayerFortune},		//GetCash()????????????????????????????
	{"AttackNpc",		LuaAttackNpc},				//AttackNpc(NpcDwid,??????????????????????????????????????????????????????????????
	{"KillNpc",			LuaKillNpc},				//KillNpc(NpcDWID)
	{"KillPlayer",		LuaKillPlayer},				//KillPlayer();
	{"Sale",			LuaSale},					//Sale(SaleId)??????????????????SaleId????????????????????????????????????????????id
	{"NewSale",			LuaNewSale},
	{"UseTownPortal",	LuaUseTownPortal},
	{"ReturnFromPortal",LuaReturnFromTownPortal},
	{"OpenBox",			LuaOpenBox},
	{"OpenEquipEx",		LuaOpenEquipEx},
	{"AddStation",		LuaAddPlayerStation},
	{"AddTermini",		LuaAddPlayerWayPoint},
	{"GetStation",		LuaGetPlayerStation	},
	{"GetStationCount", LuaGetPlayerStationCount},

	{"TrembleItem",		LuaOpenTrembleItem}, // TamLTM Kham nam Xanh
	{"GetPOItem",		LuaGetPOItem}, // TamLTM Kham nam
	{"SetPItemID",		LuaSetPItemID}, // TamLTM Kham nam

	// get set x2 skill LuaGetExp2Skill LuaSetExpSkill
	{"GetNpcSkillsExpRate",		LuaGetNpcExpSkillsRate },			//GetExp2Skill():??????????????????????????????????????
	//{"SetExpSkill",			LuaSetExpSkill},			//SetExpSkill():??????????????????????????????????????

	{"OpenProgressBar",	LuaOpenProgressBar},//TamLTM Mo loading progress bar OpenProgressBar(1)

	//{"GetVersionUpdateGame",	LuaGetVersionUpdateGame},//TamLTM Lua Get Version Update Game
	{"SetNpcPosU",		LuaSetPosU },//TamLTM Lua Set posu npc

	{"GetCityCount",	LuaGetAllStationCount},
	{"GetCity",			LuaGetCity},

	{"GetWayPoint",			LuaGetPlayerWayPoint},
	{"GetStationName",		LuaGetStationName},
	{"GetWayPointName",		LuaGetWayPointName},
	{"GetPrice2Station",	LuaGetPriceToStation},
	{"GetPrice2WayPoint",	LuaGetPriceToWayPoint	},
	{"GetStationPos",		LuaGetStationPos},
	{"GetWayPointPos",		LuaGetWayPointPos},
	{"GetWayPointFight",	LuaGetWayPointFight},
	{"GetPlayerCount",		LuaGetPlayerCount},
	{"GetNpcCount",			LuaGetNpcCount},
	{"GetTotalItem",		LuaGetTotalItem},
	{"GetRank",				LuaGetRank},
	{"SetRank",				LuaSetRank},
	{"SetRankEx",			LuaSetExpandRank},
	{"GetRankEx",			LuaGetExpandRank},
	{"RestoreRankEx",		LuaRestoreExpandRank},
	{"GetEquipItemEx",		LuaGetEquipItemEx},
	{"SetEquipItemEx",		LuaSetEquipItemEx},
	{"GetExpandBox",		LuaGetExpandBox},
	{"SetExpandBox",		LuaSetExpandBox},
	{"SetPropState",		LuaSetObjPropState},
	{"GetServerName",		LuaGetServerName},

	//------------------Station Script ---------------
	{"GetWharfName",	LuaGetDockName},
	{"GetWharfCount",	LuaGetDockCount},
	{"GetWharfPrice",	LuaGetDockPrice},
	{"GetWharf",		LuaGetDock},
	{"GetWharfPos",		LuaGetDockPos},
	{"GetTerminiFState", LuaGetWayPointFightState},
	//------------------------------------------------
	{"KickOutPlayer",	LuaKickOutPlayer},
	{"KickOutSelf",		LuaKickOutSelf},
	{"KickOutAccount",	LuaKickOutAccount},
	{"GetSkillId",		LuaGetSkillIdInSkillList},
	{"SetSkillLevel",	LuaSetSkillLevel},
	{"SetSkillTemp",	LuaSetSkillTemp},
	{"SetChatFlag",		LuaSetPlayerChatForbiddenFlag},
	//------------------------------------------------

	{"AddNote", LuaAddNote},
	{"AddMissionNote", LuaAddMissionNote},
	//-----------------Mission Script-----------------
	{"GetMissionV", LuaGetMissionValue},//GetMissionV(Vid)
	{"GetMissionS", LuaGetMissionString},
	{"SetMission", LuaSetMission},//SetMissionV(Vid, Value)
	{"GetGlbMissionV", LuaGetGlobalMissionValue	},
	{"GetGlbMissionS", LuaGetGlobalMissionString	},
	{"SetGlbMission", LuaSetGlobalMission	},
	{"GetMissionName", LuaGetMissionName},//OpenMission(missionid)
	{"OpenMission", LuaInitMission},//OpenMission(missionid)
	{"RunMission", LuaRunMission},
	{"CloseMission", LuaCloseMission},//CloseMission(missionid)
	{"IsMission", LuaIsMission},
	{"GetMSLadder",LuaGetMSLadder},
	{"StartMissionTimer", LuaStartMissionTimer},////StartMissionTimer(missionid, timerid, time)
	{"StopMissionTimer", LuaStopMissionTimer},
	{"GetMSRestTime", LuaGetMissionRestTime}, //GetMSRestTime(missionid, timerid)
	{"GetMSIdxGroup",LuaGetPlayerMissionGroup},//GetPlayerGroup(missionid, playerid);

	{"AddMSPlayer", LuaAddMissionPlayer},
	{"AddMSNpc", LuaAddMissionNpc},
	{"DelMSPlayer", LuaRemoveMissionPlayer},
	{"DelMSNpc", LuaRemoveMissionNpc},
	{"SetMSGroup", LuaSetMissionGroup},
	{"PIdx2MSDIdx", LuaGetMissionPlayer_DataIndex},//(missionid, pidx)
	{"MSDIdx2PIdx", LuaGetMissionPlayer_PlayerIndex},//(missionid, dataidx)
	{"NpcIdx2PIdx", LuaNpcIndexToPlayerIndex},
	{"GetMSPlayerCount", LuaMissionPlayerCount},//GetMSPlayerCount(missionid, group = 0)
	{"GetMSNpcCount", LuaMissionNpcCount},//GetMSPlayerCount(missionid, group = 0)

	{"RevivalAllNpc",	LuaRevivalAllNpc},

	{"SetPMParam", LuaSetMissionPlayerParam},
	{"GetPMParam", LuaGetMissionPlayerParam},
	{"Msg2MSGroup", LuaMissionMsg2Group},
	{"Msg2MSAll", LuaMissionMsg2All},
	{"SetDeathScript", LuaSetPlayerDeathScript},
	{"SetDmgScript", LuaSetPlayerDamageScript},

	{"NpcChat", LuaNpcChat}	,
	{"HideNpc", LuaHideNpc}	,//HideNpc(npcindex/npcname, hidetime)
	{"SetLogoutRV", LuaSetPlayerRevivalOptionWhenLogout},
	{"SetCreateTeam",LuaSetCreateTeamOption},
	{"ForbidTeam",LuaSetFreezeTeamOption},
	{"GetPK", LuaGetPlayerPKValue},  //pkValue = GetPK()
	{"SetPK", LuaSetPlayerPKValue}, //SetPK(pkValue)
	//------------------------------------------------
	//?????????????????????????????
	{"ShowLadder", LuaShowLadder}, //ShowLadder(LadderCount, LadderId1,LadderId2,...);
	{"GetLadder",  LuaGetLadder},
	//------------------------------------------------

	{"OpenTong",			LuaOpenTong},	//OpenTong()???????????????????????????????
	{"CreateTong",			LuaCreateTong},
	{"JoinTong",			LuaJoinTong},	//OpenTong()???????????????????????????????
	{"CommendMaster",		LuaCommendMaster},
	{"GetTongFlag",			LuaGetTongFlag},
	{"GetTongName",			LuaGetTongName},
	{"GetTongCamp",			LuaGetTongCamp},
	{"GetTongMemNum",		LuaGetTongMemNum},
	{"GetTongFigure",		LuaGetTongFigure},
	{"GetTongMoney",		LuaGetTongMoney},
	{"GetTongLevel",		LuaGetTongLevel},
	{"GetTongEff",			LuaGetTongEff},
	{"GetTongParam",		LuaGetTongParam},
	{"GetTongJoinTm",		LuaGetTongJoinTm},
	{"SetTongLevel",		LuaSetTongLevel},
	{"SetTongMoney",		LuaSetTongMoney},
	{"SetTongEff",			LuaSetTongEff},
	{"SetTongParam",		LuaSetTongParam},
	{"SetTongMemELW",		LuaSetTongMemEffLW},
	{"SetTongMemETW",		LuaSetTongMemEffTW},
	{"SetTongMemEUB",		LuaSetTongMemEffUB},
	{"GetTongMemEff",		LuaGetTongMemEff},
	{"SetPunish",			LuaSetDeathPunish},// SetPunish(0/1)
	{"SetReviveNow",		LuaSetReviveNow},
	{"AddTongMoney",		LuaAddTongMoney}, // Add money bang hoi / thue suat bang hoi
	//-------------------------------------------------
	//?????????
	//{"SwearBrother", LuaSwearBrother}, // ret = SwearBrother(TeamId);
	//{"MakeEnemy",	LuaMakeEnemy}, //????????? MakeEnemy(enemyname)
	{"MakeMate", LuaMakeMate}, // ret = MakeMate(matename);
	//{"UnMarry", LuaDeleteMate}, // ret = DeleteMate(matename);
	{"RollbackSkill", LuaRollBackSkills},
	//-------------------------------------------------

	{"AddProp",		LuaAddPropPoint},//?????????????????????????????
	{"AddPropPoint",LuaAddPropPoint},//?????????????????????????????
	{"GetProp",		LuaGetRestPropPoint},

	{"SetExtPoint",	LuaSetExtPoint},
	{"AddExtPoint",	LuaAddExtPoint},
	{"GetExtPoint",	LuaGetExtPoint},
	{"PayExtPoint",	LuaPayExtPoint},

	//TamLTM Get skill id
	{ "GetSkillState",	LuaGetSkillState },
	//end code

	{"AddSkillState",	LuaAddSkillState},
	{"AddNpcSkillState",LuaAddNpcSkillState},
	{"IgnoreState",		LuaIgnoreState},
	{"CastSkill",		LuaCastSkill},
	{"NpcCastSkill",	LuaNpcCastSkill},
	{"SetMask",			LuaSetMask},

	{"AddTrap",			LuaAddTrap},

	{"AddObj",			LuaAddObj},
	{"SetObjValue",		LuaSetObjValue},
	{"GetObjValue",		LuaGetObjValue},
	{"SetObjPickExecute",	LuaSetObjPickExecute},
	{"SetObjScript",	LuaSetObjScript},
	{"DelObj",			LuaDelObj},
	{"RemoveItem",		LuaRemoveItemIdx},
	{"RepairAllEquip",	LuaRepairAllEquip},
	{"LockMoveItem",	LuaLockMoveItem},
	{"SyncItem",		LuaSyncItem},

	{"SetTempItem",		LuaSetTempItem},
	{"SetLevelItem",	LuaSetLevelItem},
	{"SetSeriesItem",	LuaSetSeriesItem},
	{"SetParamItem",	LuaSetParamItem},
	{"SetFortuneItem",	LuaSetFortuneItem},
	{"SetExpireTimeItem",LuaSetTimeItem},
	{"SetTimeItem",		LuaSetTimeItem},
	{"AddExpireTimeItem",LuaAddTimeItem},
	{"AddTimeItem",		LuaAddTimeItem},
	{"LockItem",		LuaLockItem},
	{"SetStackItem",	LuaSetStackItem},
	{"SetFlashItem",	LuaSetFlashItem},

	{"SetSavePw",			LuaSetSavePw},
	{"GetSavePw",			LuaGetSavePw},
	{"SetLockState",		LuaSetLockState},
	{"GetLockState",		LuaGetLockState},
	{"CheckRoom",			LuaCheckRoom},

	{"OpenRankData",		LuaOpenRankData},
	{"Input",				LuaInput},
	{"GetInput",			LuaGetInput},
	{"EnchaseItem", LuaEnchaseItem},
	{"OpenEnchase",			LuaOpenEnchase}, // Box Ep do tiem
	{"Enchase",				LuaEnchase}, // Nhan test do tim
	{"GiveItemUI",			LuaOpenGive},

	{"OpenFinishDatauBox",	LuaFinishQuest}, //TamLTM hien thi khung da tau finish cach su dung OpenFinishDatauBox(1); 	local indexRan = RANDOM(8)	OpenFinishDatauBox(indexRan);

	{"SetPKMode",			LuaSetPKState},
	{"ForbidChangePK",		LuaForbidChangePK},
	{"GetPKState",			LuaGetPKState},
	{"GetNormalPKState",	LuaGetNormalPKState},

	{"IsHideNpc",			LuaIsHideNpc},
	{"PaceBar",				LuaPaceBar}, //Progress bar on thanh mau player
	{"GetTrade",			LuaGetTrade},
	{"ForbidUseTownP",		LuaForbidUseTownP},
	{"ForbidTrade",			LuaForbidTrade},
	{"ForbidEnmity",		LuaForbidEnmity},
	{"ForbidName",			LuaForbidName},
	{"ForbidCamp",			LuaForbidCamp},

	{"GetDistance",			LuaGetDistance},
	{"GetDir",				LuaGetDir},
	{"DirSin",				LuaDirSin},
	{"DirCos",				LuaDirCos},
	{"FileExists",			LuaFileExists},
	{"FileName2Id",			LuaFileName2Id},
	{"TabFile_Load",		LuaTabFile_Load},
	{"IniFile_IsSectionExist",		LuaIniFile_IsSectionExist},
	{"IniFile_Load",		LuaIniFile_Load},
	{"IniFile_GetStr",		LuaIniFile_GetStr},
	{"IniFile_GetInt",		LuaIniFile_GetInt},
	{"IniFile_GetInt2",		LuaIniFile_GetInt2},
	{"IniFile_Save",		LuaIniFile_Save},
	{"IniFile_SaveStr",		LuaIniFile_SaveStr},
	{"IniFile_SaveInt",		LuaIniFile_SaveInt},
	{"IniFile_SaveInt2",		LuaIniFile_SaveInt2},
	{"TabFile_GetRowCount",	LuaTabFile_GetRowCount},
	{"TabFile_GetCell",		LuaTabFile_GetCell},
	{"RemoveRoom",			LuaRemoveRoom},
	{"CalcFreeItemCellCount",LuaCalcFreeItemCellCount},
	{"IsNumber",			LuaIsNumber},
	{"IsTable",				LuaIsTable},
	{"OpenURL",				LuaOpenURL},
	{"OpenExplore",			LuaOpenExplore},
	{"ModifyAttrib",		LuaModifyAttrib},
	{"RANDOM",				LuaRANDOM},
	{"RANDOMC",				LuaRANDOMC},
	{"IsMyItem",			LuaIsMyItem},
	{"PTItemSaleInfo",	LuaPTItemSaleInfo},	// Phong Than 2026-10-04 hanhtrang
	{"GetDataInt",			LuaGetDataInt},
	{"GetDataStr",			LuaGetDataStr},
	{"SetData",				LuaSetData},
	{"SendReport",			LuaSendReport},
	{"GetTime",				LuaGetTime},
	{"GetTimeDate",			LuaGetTimeDate},
	{"GetLocalDate",		LuaGetLocalDate},
    //son code reload
	{"ReLoadScript",		LuaReLoadScript },
    //end code
	{"ReloadAllScript", LuaReloadAllScript}, //Hung Ham reload script
	{"AddDataGr",			LuaAddDataGr},
	{"SetDataGr",			LuaSetDataGr},
	{"GetDataGr",			LuaGetDataGr},
	{"FindDataId",			LuaFindDataId},
	{"SaveDataFile",		LuaSaveDataFile},

	{"ChatRoom_Create",		LuaChatRoom_Create},
	{"ChatRoom_AddTime",	LuaChatRoom_AddTime},
	// Phong Than 2026-10-02: Can Khon Luan server-side spin (Thai Tue Su).
	{"Roulette",			LuaRoulette},
	{"RouletteBusy",		LuaRouletteBusy},
	// Phong Than 2026-10-05 natives-20261005 (PhongThanLuaItemNatives.h)
	// #2 missile hit scripts (script\skill\missle\*.lua OnHitTarget)
	{"IsPlayer",				LuaPTN_IsPlayer},
	{"GetNpcFireResist",		LuaPTN_GetNpcFireResist},
	{"GetNpcColdResist",		LuaPTN_GetNpcColdResist},
	{"GetNpcPoisonResist",	LuaPTN_GetNpcPoisonResist},
	{"GetNpcLightResist",		LuaPTN_GetNpcLightResist},
	{"GetNpcEarthResist",		LuaPTN_GetNpcEarthResist},
	{"GetNpcPhysicsResist",	LuaPTN_GetNpcPhysicsResist},
	// #3 VNG item / gift / card / transformation scripts
	{"GetNpcLifeMax",			LuaPTN_GetNpcLifeMax},
	{"FindAValidItemID",		LuaPTN_FindAValidItemID},
	{"GetItemGen",			LuaPTN_GetItemGen},
	{"GetItemDetail",			LuaPTN_GetItemDetail},
	{"IsItemBind",			LuaPTN_IsItemBind},
	{"SetItemBind",			LuaPTN_SetItemBind},
	{"DelItemByID",			LuaPTN_DelItemByID},
	{"HaveNormalItemInQuick",	LuaPTN_HaveNormalItemInQuick},
	{"AddItemPileNum",		LuaPTN_AddItemPileNum},
	{"EarnBind",				LuaPTN_EarnBind},
	{"GetIBItemGenTime",		LuaPTN_GetIBItemGenTime},
	{"Time2LocalYMD",			LuaPTN_Time2LocalYMD},
	{"GetServerStartTime",	LuaPTN_GetServerStartTime},
	{"GetCompeteFlag",		LuaPTN_GetCompeteFlag},
	{"CanPolyMorph",			LuaPTN_CanPolyMorph},
	{"GetGlobalStoreValue",	LuaPTN_GetGlobalStoreValue},
	{"SetGlobalStoreValue",	LuaPTN_SetGlobalStoreValue},
	{"GetGlobalStoreValueByte",	LuaPTN_GetGlobalStoreValueByte},
	{"SetGlobalStoreValueByte",	LuaPTN_SetGlobalStoreValueByte},
	{"GetGlobalStoreValueWord",	LuaPTN_GetGlobalStoreValueWord},
	{"SetGlobalStoreValueWord",	LuaPTN_SetGlobalStoreValueWord},
	{"SendGlobalMessage",		LuaMsgToSubWorld},
	{"AddEmoteBalloon",		LuaPTN_AddEmoteBalloon},
	// #13 equipment upgrade (web admin "Cuong hoa")
	{"SetItemUpgrade",		LuaPTN_SetItemUpgrade},
	{"GetItemUpgrade",		LuaPTN_GetItemUpgrade},
	{"GetItemListEntry",		LuaPTN_GetItemListEntry},
#else
                {"PlaySound", LuaPlaySound}, //PlaySound(Sound);
                {"PlaySprMovie",LuaPlaySprMovie},//PlaySprMovie(npcindex, Movie, times)
#endif
                {"GetCurServerSec",		LuaGetCurServerSec},
                {"SetNumber",			LuaSetNumber},
                {"GetNumber",			LuaGetNumber},

                {"GetNameItem",		LuaGetNameItem},
                {"GetParamItem",	LuaGetParamItem},
                {"GetFortuneItem",	LuaGetFortuneItem},
                {"GetLockItem",		LuaGetLockItem},
                {"GetStackItem",	LuaGetStackItem},
                {"GetMaxStackItem",	LuaGetMaxStackItem},
                {"FindItem",		LuaFindItem},
                {"FindSetItem",	LuaFindSetItem},
                {"FindItemEx",		LuaFindItemEx},

                {"PlayMusic", LuaPlayMusic}, //PlayMusic(Music,Loop)
                {"FadeInMusic",LuaFadeInMusic},
                {"FadeOutMusic",LuaFadeOutMusic},
        };


TLua_Funcs WorldScriptFuns[] =// ?????????????????????????????????????
        {
                //????????????????

                {"AddLocalNews",LuaAddLocalNews},
                {"AddLoaclTimeNews",LuaAddLocalTimeNews},
                {"AddLocalCountNews",LuaAddLocalCountNews	},
                //????????????????????????????????????
#ifdef _SERVER
                {"Msg2SubWorld",	LuaMsgToSubWorld},	//Msg2SubWorld(????????)????????????????
	{"Msg2IP",			LuaMsgToIP}, //Msg2IP(IP, ID, StrInfo)
	{"SubWorldID2Idx",	LuaSubWorldIDToIndex}, //SubWorldID2Idx
	{"GetServerName",	LuaGetServerName},
	{"KickOutPlayer",	LuaKickOutPlayer},
	{"KickOutAccount",	LuaKickOutAccount},
	{"SetRoleChatFlag",	LuaSetRoleChatFlag},
	{"ShutDownServer",	LuaShutDownServer},
#endif
        };

int g_GetGameScriptFunNum()
{
    return sizeof(GameScriptFuns)  / sizeof(GameScriptFuns[0]);
}

int g_GetWorldScriptFunNum()
{
    return sizeof(WorldScriptFuns)  / sizeof(WorldScriptFuns[0]);
}



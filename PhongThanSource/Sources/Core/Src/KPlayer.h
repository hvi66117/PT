#ifndef KPlayerH
#define	KPlayerH
//#include <objbase.h>
#include "KWorldMsg.h"
#include "KMessage.h"
#include "KInventory.h"
#include "KPlayerProfession.h"
#include "KPlayerChat.h"
#include "KPlayerTask.h"
#include "KPlayerMenuState.h"
#include "KPlayerTrade.h"
#include "KPlayerTeam.h"
#include "KPlayerPK.h"
#include "KPlayerAI.h"
#include "KPlayerTong.h"
#include "KPlayerChatRoom.h"
#include "KItemList.h"
#include "KNpc.h"
#include "KSkills.h"
#include <fstream> // TamLTM
#include <string> // TamLTM
#include "KPlayerDef.h"
#include "PhongThanCharacter.h"
#include "PhongThanProtocol.h"
#include "PhongThanScriptAction.h"

#define		PLAYER_LIFE_REPLENISH			0
#define		PLAYER_MANA_REPLENISH			0
#define		PLAYER_STAMINA_GAIN				1
#define		PLAYER_STAMINA_LOSS				4

#define		STRENGTH_SET_DAMAGE_VALUE		5
#define		DEXTERITY_SET_DAMAGE_VALUE		5
#define		ENGERGY_SET_DAMAGE_VALUE		0

#define		MAX_AVENGE_NUM					4


// ������λ����Ϣ
typedef struct PLAYER_REVIVAL_POS_DATA
{
	int				m_nSubWorldID;		// �������ͼ
	int				m_ReviveID;			// ����������
	int				m_nMpsX;			// �������ͼλ�� x
	int				m_nMpsY;			// �������ͼλ�� y
} PLAYER_REVIVAL_POS;

typedef struct
{
	int				m_nSubWorldId;		// ����������ID
	int				m_nTime;			// �����ű���ʱ��
	int				m_nMpsX;
	int				m_nMpsY;
} PLAYER_TOWNPORTAL_POS;

typedef struct
{
	DWORD			m_dwMapID;
	int				m_nX;
	int				m_nY;
} PLAYER_EXCHANGE_POS;

class KIniFile;


#ifdef TOOLVERSION
class CORE_API KPlayer
#else
class KPlayer
#endif
{
private:

#ifndef _SERVER
	int				m_nLeftSkillID;
	int				m_nLeftSkillLevel;
	int				m_nRightSkillID;
	int				m_nRightSkillLevel;
	BOOL			m_MouseDown[2];
	int				m_nExtPoint;// TamLTM fix xu;
	int				m_nChangeExtPoint;

#endif

#ifdef _SERVER
	PLAYER_REVIVAL_POS		m_sLoginRevivalPos;	// ����������λ�ã�����̣�
	PLAYER_REVIVAL_POS		m_sDeathRevivalPos;	// ���������㣨Ĭ��Ϊ���������㣬�����̣�
	PLAYER_TOWNPORTAL_POS	m_sPortalPos;		// ������λ��
	BOOL			m_bUseReviveIdWhenLogin;
	int				m_nExtPoint;// TamLTM fix xu;
	int				m_nChangeExtPoint; // TamLTM fix xu;
#endif
	int				m_nPhysicsSkillID;		//��ǰ��ҵ�������������
	int				m_nPeapleIdx;
	int				m_nObjectIdx;
	int				m_nPickObjectIdx;
	int				m_nPlayerIndex;				// ��ʵ���� Player �����е�λ��
	KCacheNode *	m_pLastScriptCacheNode;

public:
	PHONGTHAN_U32 m_UiDialogSerial;
	PHONGTHAN_U32 m_UiDialogToken;
	PHONGTHAN_U16 m_UiDialogView;
	BOOL			m_bIsBot;//Doi ten nhan vat
#ifdef _SERVER
	char			m_szLastName[32];//Doi ten nhan vat
	DWORD			m_dwTaskExcuteScriptId;
	char			m_szTaskExcuteFun[32];
	char			m_szLastInput[32];
//	BYTE			m_byLixian;
	PLAYER_EXCHANGE_POS		m_sExchangePos;
	KTimerTaskFun	m_TimerTask;
	BOOL			m_bIsQuiting;
	UINT			m_uMustSave;
	DWORD			m_ulLastSaveTime;
	DWORD			m_dwLoginTime;
	//DWORD			m_uLastPingTime;
	char			AccountName[32];
	void*			m_pStatusLoadPlayerInfo;	//���������Ϣʱ��
	BYTE*			m_pCurStatusOffset;			//������ʱ����¼����ָ��λ����
	BOOL			m_bFinishLoading;			//��ɼ���
	BYTE			m_SaveBuffer[64 * 1024];	//���滺��
	int				m_nLastNetOperationTime;	//���һ���������ʱ��
	BOOL			m_bSleepMode;
	KList			m_PlayerWayPointList;		//
	KList			m_PlayerStationList;
	int				m_nViewEquipTime;			// ���һ�β쿴����װ����ʱ��
	int				m_nPrePayMoney;

	enum
	{
		FF_CHAT = 0x01,
	};
	int				m_nForbiddenTm;			// ��ֹ��־
	BOOL			m_bForbidEnmity;
	BOOL			m_bForbidTrade;
	BOOL			m_bForbidUseTownP;
	BOOL			m_bForbidName;
	BOOL			m_bForbidCamp;
	BOOL			m_PlayerDBLoad;

	// Phong Than 2026-10-02: Can Khon Luan (Thai Tue Su) server-side spin for Lua Roulette(k[, names]).
	// The client has no roulette window: the spin is a slowing sequence of top messages, and the
	// script's Finished() runs only when the spin stops on sector k (never when it is aborted).
	enum { PT_ROULETTE_MAX_SECTORS = 16, PT_ROULETTE_NAME_LEN = 32 };
	int				m_nRouletteK;				// -1 = idle, otherwise the winning sector
	int				m_nRouletteCount;			// number of sectors (names)
	int				m_nRouletteStep;			// current animation step
	int				m_nRouletteSubWorld;		// subworld index at spin start (abort on map change)
	DWORD			m_dwRouletteNextFrame;		// game loop time of the next step
	DWORD			m_dwRouletteScriptId;		// script whose Finished() gives the reward
	char			m_szRouletteNames[PT_ROULETTE_MAX_SECTORS][PT_ROULETTE_NAME_LEN];
	BOOL			PhongThanRouletteStart(int nWinK, DWORD dwScriptId, const char* pszNames);
	void			PhongThanRouletteAbort(const char* pszReason, BOOL bNotify);
	void			PhongThanRouletteActive();
	void			PhongThanRouletteClear();
	void			PhongThanRouletteSend(const char* pszText);
#endif

#ifndef _SERVER
	int				m_RunStatus;				// ���ܻ�����
	int				m_nNextLevelLeadExp;		// ͳ������һ������ֵ
	int				m_nSendMoveFrames;	// ���ڿ��ƿͻ���������������ƶ�(�߻���)Э���Ƶ�ʣ�ʹ֮���ܷ��ʹ������ƶ�Э�飬��С����ѹ��
	DWORD			m_dwRightMouse;
	TMissionLadderSelfInfo m_MissionData;
	TMissionLadderInfo m_MissionRank[MISSION_STATNUM];
	BOOL			m_bDebugMode;
#endif

	KIndexNode		m_Node;
	PHONGTHAN_U8	m_SessionTicket[PHONGTHAN_SESSION_TICKET_SIZE];
	BOOL			m_bExchangeServer;
	DWORD			m_dwID;						// ��ҵ�32λID
	int				m_nIndex;					// ��ҵ�Npc���
	int				m_nLastNpcIndex;			// Last dialog NPC on both server and client.
	int				m_nNetConnectIdx;			// �ڼ�����������
	KItemList		m_ItemList;					// ��ҵ�װ���б�
	BuySellInfo		m_BuyInfo;					// ���еĽ����б�
	KPlayerMenuState	m_cMenuState;			// �Ƿ��ڽ��׻���鿪��״̬
	KTrade			m_cTrade;					// ����ģ��

	//TamLTM check nhat do cua nguoi khac
	BOOL			m_bNotPickUpItem;
	BOOL			m_bNotPickUpMoney;
	//end code

#ifdef _SERVER
	PLAYERTRADE		m_PTrade;			// �Ƿ��ڽ��׻���鿪��״̬
#endif
	int				m_nAttributePoint;			// δ�������Ե�
	int				m_nSkillPoint;				// δ���似�ܵ�

	int				m_nStrength;				// ��ҵĻ������������������˺���
	int				m_nDexterity;				// ��ҵĻ������ݣ��������С�������
	int				m_nVitality;				// ��ҵĻ�������������������������
	int				m_nEngergy;					// ��ҵĻ�������������������
	int				m_nLucky;					// ��ҵĻ���������Ӱ��õ�װ���ĺû���

	int				m_nCurStrength;				// ��ҵĵ�ǰ���������������˺���
	int				m_nCurDexterity;			// ��ҵĵ�ǰ���ݣ��������С�������
	int				m_nCurVitality;				// ��ҵĵ�ǰ����������������������
	int				m_nCurEngergy;				// ��ҵĵ�ǰ����������������

	int				m_nExp;						// ��ǰ����ֵ(��ǰ�ȼ���npc����)
	int				m_nNextLevelExp;			// ��һ������ֵ

	int				m_nLeadExp;				// ͳ��������ֵ
	int				m_nLeadLevel;				// ͳ�����ȼ�
	char				Name[32];
	int				m_ImagePlayer;

	KPlayerTeam		m_cTeam;					// ��ҵ������Ϣ
	KPlayerProfession	m_cProfession;					// ��ҵ�������Ϣ

	KPlayerChat		m_cChat;

	KPlayerTask		m_cTask;					// �������ϵͳ(����)

	KPlayerPK		m_cPK;						// PK��ϵ����

	KPlayerAI		m_cAI;

	KPlayerTong		m_cTong;					// �Լ��İ����Ϣ

	KPlayerChatRoom	m_cRoom;					// �Լ��İ����Ϣ

	//TamLTM Toi uu hinh anh game
	BOOL            m_bIsHideNpc;    //hide noc
	BOOL            m_bIsHidePlayer; // hide player
	//end code

	//TamLTM Fix set save pass Khoa ruong
	BOOL			m_bLock; //1 SetSaveVal
	BOOL			m_bOk; //2 CheckSavePw
	//end code

	DWORD			m_dwDeathScriptId;			//
	DWORD			m_dwDamageScriptId;			//

	char			m_szTaskAnswerFun[MAX_ANSWERNUM][32];
	int				m_nAvailableAnswerNum;//��ǰѡ������£����ش�����
	bool			m_bWaitingPlayerFeedBack;	//��ǰ�Ƿ����ȴ�����ڿͻ��˵ķ�������״̬�£���ǰ�ű����ÿ�.��ʽ�Ի�ѡ�����
	// Phong Than player-specific NPC quest marker state. The revision is
	// advanced by RefreshAllNpcTask so consumers can invalidate cached marks.
	int				m_nPhongThanTaskState;
	int				m_nPhongThanTaskSubState;
	DWORD			m_dwPhongThanTaskRevision;
//	DWORD			m_dwOutOfDateFeedBackTime;	//��ǰ�ȴ������������ű�����������޶�ʱ�̣����������Ϸʱ����������δ�����������ϡ�
	BYTE			m_btTryExecuteScriptTimes;	//
	//char			m_CurScriptName[128];
	int				m_nWorldStat;
	int				m_nProfessionRank;
	int				m_nKillPeopleNumber;

	BYTE			m_nLockPKState;

	DWORD			m_TalkUiScriptId;
	DWORD			m_SelUiScriptId;

	int				m_nPaceBarTime;
	int				m_nPaceBarTimeMax;
	int				m_nIndexProgressBarIndex;
public:
	KPlayer();
	~KPlayer();

	void			SetLockMove(LockMoveItem *LockMove);
	LockMoveItem*	GetLockMove() {return &m_LockMove;};
#ifdef _SERVER
	void			SetLevel(int nLevel);
	void			UpdateSQL(IN char *cAccName, IN int nExtPoint, bool iCheckExtPoint); //TamLTM add update sql
	void			GetMacInSQL(IN char *cAccountName); //TamLTM sql
	void			GetHardwareIDPC(); //Get id cho phan cung trong pc 1 may
	void			GetNameForDatabase(int numberChange); //Get id cho phan cung trong pc 1 may
	// Fetches the MAC address and prints it
	void			GetMACaddress();
	void			SetExtPoint(int nPoint, int nChangePoint); //TamLTM fix xu;
	int				GetExtPoint();//TamLTM fix xu;
	int				GetExtPointChanged();//TamLTM fix xu;
	BOOL			PayExtPoint(int nPoint);
#endif
	void			SetLockState(BOOL bLock);
	BOOL			GetLockState();
	void			SetEquipExpandTime(int dwTime);
	void			SetExpandBoxNum(int nNum);

	void			GetDataSQL();

	//TamLTM Get SQL Database
	int				GetMacSQL();

	//TamLTM Get Update Version game
	int				GetVersionGame();

	void			SetPlayerIndex(int nNo);					// �趨 m_nPlayerIndex
	void			GetAboutPos(KMapPos *pMapPos);			// �����Ҹ���һ����λ��
	int				GetPlayerIndex();							// ��ñ�ʵ���� Player �����е�λ��
	DWORD			GetPlayerID(){return m_dwID;};
	void			GetProfessionKey(char *lpszName);	// ��õ�ǰ�������� not end
	void			GetProfessionName(char *lpszName);	// ��õ�ǰ�������� not end
	int				GetProfessionCamp();
	int				GetProfession();
	BOOL			ExecuteScript(char * ScriptFileName, char * szFunName, int nParam = 0);
	BOOL			ExecuteScript(char * ScriptFileName, char * szFunName, char * szParams);
	BOOL			ExecuteScript(DWORD dwScriptId, char * szFunName, char *  szParams);
	BOOL			ExecuteScript(DWORD dwScriptId,  char * szFunName, int nParam);

	BOOL			ExecuteScript2Param(char * ScriptFileName, char * szFunName, int nResultCount, int nParam1 = 0, int nParam2 = 0);
	BOOL			ExecuteScript2Param(DWORD dwScriptId, char * cFuncName, int nResultCount, int nParam1, int nParam2);
		;
	BOOL			ExecuteScript3Param(char * ScriptFileName, char * szFunName, int nResultCount, int nParam1 = 0, int nParam2 = 0, int nParam3 = 0);
	BOOL 			ExecuteScript3Param(DWORD dwScriptId, char * cFuncName, int nResultCount, int nParam1, int nParam2, int nParam3);

	// TamLTM kham
	BOOL			ExecuteScript2(char * ScriptFileName, char * szFunName, int nParam1 = 0, int nParam2 = 0);
	BOOL			ExecuteScript2(char * ScriptFileName, char * szFunName, char * szParams1, char * szParams2);
	BOOL			ExecuteScript2(DWORD dwScriptId, char * szFunName, char *  szParams1, char *  szParams2);
	BOOL			ExecuteScript2(DWORD dwScriptId,  char * szFunName, int nParam1, int nParam2);
	//end code

	BOOL			DoScript(char * ScriptCommand);				//ִ��ĳ���ű�ָ��
	void			SendTitle();

	void			ChangeCurStrength(int nData);			// �ı䵱ǰ����(�� nData С�� 0 ʱ������)
	void			ChangeCurDexterity(int nData);			// �ı䵱ǰ����(�� nData С�� 0 ʱ������)
	void			ChangeCurVitality(int nData);			// �ı䵱ǰ����(�� nData С�� 0 ʱ������)
	void			ChangeCurEngergy(int nData);			// �ı䵱ǰ����(�� nData С�� 0 ʱ������)
	BOOL			ExecuteScript(char * ScriptFileName);
	void			Release();
	void			Active();								// ���ÿ����Ϸѭ������Ҫ�����Ķ���
	void			ProcessMsg(KWorldMsgNode *lpMsg);		// ����������Ϣ��תΪNPC����

	LPSTR			GetPlayerName() { return Name; };

	BOOL			NewPlayerGetBaseAttribute(int Series);	// ����ҵ�½ʱ�����������Բ��� ���� ���� ���� ���� ������ֵ
	void			AddBaseLucky(int nData);				// ���ӻ�������
#ifdef _SERVER
//	void			AddExp(int nExp, int nTarLevel);		// ���Ӿ���(ԭʼ���ݣ���δ��������)
	void			AddExp(int nExp, int nTarLevel, BOOL bCheck = FALSE);		// TamLTM fix exp
	void			AddSelfExp(int nExp, int nTarLevel);	// ���Ӿ���(����Ҫ�پ����������Ĵ���������Ҫ���Ǳ�����npc�ĵȼ�)
	void			AddSkillExp(int nExp);
	void			DirectAddExp(int nExp);					// ֱ�����Ӿ���ֵ����������������
	void			LevelUp();								// ��һ��
#endif
	void			AddLeadExp(int nExp);					// ����ͳ��������
	void			SetLeadLevel(int nLevel);					// ����ͳ��������
	void			UpdataCurData();
	void			ReCalcEquip();							// ���¼������ϵ�װ��
	void			ReCalcState();
	void			ChangePlayerCamp(int nCamp);			// �ı������Ӫ
	void			Revive(int nType);

	BOOL			CheckTrading(bool bOverLookTrade = false);
	void			SetFirstDamage();
	void			SetFirstMagic();
	void			SetBaseAttackRating();
	void			SetBaseDefence();
	void			SetBaseResistData();
	void			SetBaseSpeedAndRadius();
	int				GetPhysicsSkillId(){return m_nPhysicsSkillID;};
	void			SetPhysicsSkillId(int nPhysicsSkillID)
	{
		if (nPhysicsSkillID <= 0) return ;
		ISkill * pISkill =  g_SkillManager.GetSkill(nPhysicsSkillID, 1);
		if (!pISkill)
            return ;

        if (nPhysicsSkillID > 0 && pISkill->IsPhysical())
			m_nPhysicsSkillID = nPhysicsSkillID;
	};

	int				m_nMacDatabase;//TamLTM Get nMac database
	int				m_nVersionGame;//TamLTM Get m_nVersionGame database
	BOOL			m_bLockState;
	int				m_dwEquipExpandTime;
	int				m_btRepositoryNum;
	LockMoveItem	m_LockMove;
#ifndef _SERVER
	void			SetExtPoint(int nPoint); // set gia tri xu
	int				GetExtPoint() { return m_nExtPoint; }; // lay gia tri xu
	int				GetTargetNpc() { return m_nPeapleIdx; };
	int				GetTargetObj() { return m_nObjectIdx; };
	void			SetTargetNpc(int n) { m_nPeapleIdx = n; };
	void			SetTargetObj(int n) { m_nObjectIdx = n; };
	void			FindSelectNpc(int x, int y, int nRelation);
	void			FindSelectObject(int x, int y);
	void			Walk(int nDir, int nSpeed);
	void			TurnLeft();
	void			TurnRight();
	void			TurnBack();
	BOOL			ConformIdx(int nIdx);
	void			GetEchoDamage(int* nMin, int* nMax, int nType);// ��ȡ������Ҫ��ʾ���˺�ֵ

	// TamLTM damage Attack ho tro skill 5x 6x do chinh xac
	void			GetEchoAttack(int* nAttack, int nType);
	//end code

	void			ProcessInputMsg(UINT uMsg, WPARAM wParam, LPARAM lParam);// �������������Ϣ
	void			RecvSyncData();								// ����ͬ������

	void			ApplyTeamInfo(DWORD dwNpcID);				// ������������ѯĳ��npc���ڶ������Ϣ
	void			ApplySelfTeamInfo();						// ������������ѯ��������Ķ������
	BOOL			ApplyCreateTeam();//char *lpszTeamName);		// �������������봴������
	BOOL			ApplyTeamOpenClose(BOOL bFlag);				// �ӳ�����������뿪�š��رն����Ƿ����������Ա״̬
	BOOL			ApplyTeamPKFollow(BOOL bFlag);
	BOOL			ApplyTeamModePick(int nSel);
	void			ApplyAddTeam(int nNpcIndex);				// �����������������ĳ������
	void			AcceptTeamMember(DWORD dwNpcID);			// ���֪ͨ����������ĳ��npcΪ�����Ա
	void			TeamDropApplyOne(DWORD dwNpcID);			// �ӳ�ɾ��������������б��е�ĳ��npc
	void			LeaveTeam();								// ֪ͨ������������뿪����
	void			TeamKickMember(DWORD dwNpcID);				// �ӳ�֪ͨ�������߳�ĳ����Ա
	void			ApplyTeamChangeCaptain(DWORD dwNpcID);		// �ӳ��������������Լ��Ķӳ����ݽ�����Ķ�Ա
	void			ApplyTeamDismiss();							// �ӳ�������������ɢ����
	void			ApplySetPK(BOOL bPK);						// ��������������򿪡��ر�pk����
	void			SendChat(KUiMsgParam *pMsg, char *lpszSentence);// �ͻ��˷�����������������
	void			ApplyAddBaseAttribute(int nAttribute, int nNo);// �ӳ��������������������������ĳһ��ĵ���(0=Strength 1=Dexterity 2=Vitality 3=Engergy)
	BOOL			ApplyAddSkillLevel(int nSkillID, int nAddPoint);// �����������ĳ����������
	BOOL			ApplyUseItem(int nItemID, ItemPos SrcPos);	// �����������ʹ��ĳ����Ʒ������Ҽ��������Ʒ��
	BOOL			CanUseItem(int nIdx);
	void			PickUpObj(int nObjIndex);					// �ͻ��������obj����ĳ����Ʒ�������������Ϣ
	void			ObjMouseClick(int nObjIndex);				// �ͻ��������obj�������������Ϣ
	void			MoveItem(ItemPos DownPos, ItemPos UpPos);	// DownPos �������֣�UpPos ��������
	int				ThrowAwayItem();
	void			TradeApplyOpen(char *lpszSentence, int nLength);
	void			TradeApplyClose();
	void			TradeApplyStart(int nNpcIdx, bool bFolkGame);
	BOOL			TradeMoveMoney(int nMoney);					// ����ʱ�����Լ���Ǯ
	void			TradeDecision(int nDecision, int nId =-1);				// if nDecision == 0 �Ƴ�����  if nDecision == 1 ȷ������  if nDecision == 2 ȡ������ȷ��
	void			TradeApplyLock();				// ����������ȡ������

	void			SetChatCurChannel(int nChannelNo);			// �趨��ǰ����Ƶ��
	void			TeamInviteAdd(DWORD dwNpcID);				// ����������

	void			SetLeftSkill(int nSkillID);
	void			SetRightSkill(int nSkillID);
	void			UpdateWeaponSkill();
	int				GetLeftSkill(){return m_nLeftSkillID;};
	int				GetRightSkill(){return m_nRightSkillID;};
	void			SetDefaultImmedSkill();
	void			s2cApplyAddTeam(BYTE* pProtocol);			// �յ�������֪ͨ��������������
	void			s2cTradeChangeState(BYTE* pMsg);
	void			s2cTradeMoneySync(BYTE* pMsg);
	void			s2cTradeDecision(BYTE* pMsg);				// �յ�������֪ͨ������ɻ�ȡ��
	void			SyncCurPlayer(BYTE* pMsg);
	BOOL			dacheck;
	void			s2cLevelUp(BYTE* pMsg);
	void			s2cGetCurAttribute(BYTE* pMsg);
	void			s2cSetExp(int nExp);
	void			s2cSyncMoney(BYTE* pMsg);
	void			s2cTradeApplyStart(BYTE* pMsg);
	void			s2cJoinTongReply(BYTE* pMsg);
	void			s2cSparApplyStart(BYTE* pMsg);
	void			CheckObject(int nIdx);
	void			PickObjectNear();
#endif
#ifdef _SERVER
	void			RepairItem(DWORD dwItemID);
	void			AutoLoseItem(DWORD dwItemID);
	void			PlayerBreakItem(DWORD dwItemID, int nNum, BOOL bIsBreakAll = FALSE);
	BOOL			PrePay(int nMoney);
	void			SetLastNetOperationTime(int nTime);
	int				FindAroundPlayer(DWORD dwNpcID);		// Ѱ�������Χ��ĳ��ָ��npc id��player index
	int				FindAroundNpc(DWORD dwNpcID);			// Ѱ�������Χ��ĳ��ָ��npc id��npc index
	int				FindNearNpc(int nNpcSettingIdx, int nDist =0);
	int				FindNearNpc(const char* szName, int nDist =0);
	BOOL			IsExchangingServer();
	void			TobeExchangeServer(DWORD dwMapID, int nX, int nY);
	BOOL			IsWaitingRemove();
	BOOL			IsLoginTimeOut();
	void			WaitForRemove();
	void			LoginTimeOut();
	BOOL			UseTownPortal();
	BOOL			BackToTownPortal();
	void			GetLoginRevivalPos(int *lpnSubWorld, int *lpnMpsX, int *lpnMpsY);		// ��ȡ��ҵ���������λ��
	void			GetDeathRevivalPos(int *lpnSubWorld, int *lpnMpsX, int *lpnMpsY);		// ��ȡ�������������λ��
	void			SetRevivalPos(int nSubWorld, int nRevalId);								// �趨���������ID
	void			GetLoginRevival(POINT *Pos) {
		Pos->x = m_sLoginRevivalPos.m_nSubWorldID;
		Pos->y = m_sLoginRevivalPos.m_ReviveID;
	};
	int				GetLoginRevivalID() {return m_sLoginRevivalPos.m_ReviveID;};
	BOOL			Save();									// �����������
	BOOL			CanSave();
	void			ProcessUser();
	BOOL			SendSyncData(int &nStep, unsigned int &nParam);	// ����ͬ������
	BOOL			SendSyncData_Skill();					// ����ͬ������ - ����
	void			SendCurNormalSyncData();				// ����ƽʱ���Լ���ͬ������
	void			SetChatForbiddenTm(int nTm)
	{
		m_nForbiddenTm = nTm;
	};
	void			ForbidEnmity(BOOL bFlag);
	void			ForbidTrade(BOOL bFlag);
	void			ForbidUseTownP(BOOL bFlag);
	void			ForbidName(BOOL bFlag);
	void			ForbidCamp(BOOL bFlag);

	BOOL			SetProfession(char *pszProfession);
	BOOL			SetProfession(int nProfession);

	void			BuyItem(BYTE* pProtocol);
	void			SellItem(BYTE* pProtocol);
	void			QuitGame(int nQuitType);				// �˳���Ϸ
	void			S2CSendTeamInfo(BYTE* pProtocol);		// �յ��ͻ��˲�ѯĳ��npc�����Ϣ�������������ͻ��˷��Ͷ�����Ϣ
	void			SendSelfTeamInfo();						// ��������ͻ��˷��Ͷ�����Ϣ
	BOOL			CreateTeam(BYTE* pProtocol);			// �յ��ͻ������󴴽�һ֧����
	BOOL			SetTeamState(BYTE* pProtocol);			// �յ��ͻ������󿪷š��رձ�player�����Ƿ�������Ա����״̬
	BOOL			S2CSendAddTeamInfo(BYTE* pProtocol);	// �յ��ͻ����������һ֧����
	BOOL			AddTeamMember(BYTE* pProtocol);			// �ӳ�֪ͨ����������ĳ��npcΪ�����Ա
	void			LeaveTeam(BYTE* pProtocol);				// �յ��ͻ��˶�Ա֪ͨ�뿪����
	void			SendSystemMessage(const char* szHead, const char* szMessage);
	void			SendTeamMessage(int nTeamID, const char* szMessage);
	void			TeamKickOne(BYTE* pProtocol);			// �յ��ͻ��˶ӳ�֪ͨ�߳�ĳ����Ա
	BOOL			TeamChangeCaptain(BYTE* pProtocol);		// �յ��ͻ��˶ӳ�֪ͨ�Ѷӳ����ݽ���ĳ����Ա
	void			TeamDismiss(BYTE* pProtocol);			// �յ��ͻ��˶ӳ������ɢ����
	void			SetPK(BYTE* pProtocol);					// �յ��ͻ��������趨PK״̬
	void			ServerSendChat(BYTE* pProtocol);		// �յ��ͻ��˷������������
	void			AddBaseAttribute(BYTE* pProtocol);		// �յ��ͻ���Ҫ�����ӻ������Ե�(0=Strength 1=Dexterity 2=Vitality 3=Engergy)
	int				ResetProp();
	void			ResetBaseAttribute(int attribute, int value);
	void			AddSkillPoint(BYTE* pProtocol);			// �յ��ͻ���Ҫ������ĳ�����ܵĵ���
	void			IncSkillLevel(int nSkillId, int nAddLevel);
	void			IncSkillExp(int nSkillId, int nAddExp);
	BOOL			ServerPickUpItem(BYTE* pProtocol);		// �յ��ͻ�����Ϣ�����ĳ��obj����װ�����Ǯ
	void			EatItem(BYTE* pProtocol);				// �յ��ͻ�����Ϣ��ҩ
	void			ServerMoveItem(BYTE* pProtocol);		// �յ��ͻ�����Ϣ�ƶ���Ʒ
	void			ServerThrowAwayItem(BYTE* pProtocol);	// �յ��ͻ�����Ϣ������Ʒ
	void			TradeApplyOpen(BYTE* pProtocol);		// �յ��ͻ���������������״̬
	void			TradeApplyClose(BYTE* pProtocol);		// �յ��ͻ�������ȡ��������״̬
	void			TradeApplyStart(BYTE* pProtocol);		// �յ��ͻ������뿪ʼ����
	void			TradeMoveMoney(BYTE* pProtocol);		// �յ��ͻ������뽻����money�ĸı�
	void			TradeDecision(BYTE* pProtocol);			// �յ��ͻ������뽻��ȷ����ȡ��
	void			TradeFolkGameDecision(BYTE btDecision);			// �յ��ͻ������뽻��ȷ����ȡ��
	void			c2sTradeReplyStart(BYTE* pProtocol);
	void			SyncTradeState(BOOL bSelfAsk = FALSE, BOOL bDestReply = FALSE);						// ������˫���Ŀͻ��˷��ͽ���״̬��Ϣ
	void			SendEquipItemInfo(int nTargetPlayer);	// �����Լ�װ�������ϵ�װ����Ϣ�����˿�

	void			SparApplyStart(BYTE* pProtocol);		// �յ��ͻ������뿪ʼ����

	PLAYER_REVIVAL_POS* GetDeathRevivalPos()
	{
		return &m_sDeathRevivalPos;
	};
	BOOL			IsUseReviveIdWhenLogin() { return m_bUseReviveIdWhenLogin; };
	void			SetLoginType(BOOL bUseReviveId) { m_bUseReviveIdWhenLogin = bUseReviveId; };

	BOOL			CreateTong(int nCamp, char *lpszTongName);
	void			SetNumImg(int nNumber);

	void			TradeStart(BYTE* pProtocol);
	void			SendTradeCancel();
	BOOL			SendTradeItem(int nIndex);	// �����Լ����õĳ�����Ϣ�����˿�
	void			SendTradeCount(int nIndex);
	int				GetTradeCount();

	void			LoadScript( int nScript); //TamLTM da tau vng
	void			LoadScriptProgressBar(int nScript); //TamLTM Load progress bar
	void			Offline();//TamLTM Uy Thac offline

	void			SendMSGroup();
	void			SendMSRank(TMissionLadderSelfInfo* SelfData, TMissionLadderInfo* RankData);

	void			SetSavePw(char* szTask, BOOL bShow);
	BOOL			CheckSavePw(const char* szTask);

	void			RecoveryBox(DWORD dwID, int nX, int nY); // TamLTM Kham nam xanh

	int				Compound(int);
	int				Enchase(int,int,int,int);
#endif
private:
//	void			CalcCurStrength();						// ���㵱ǰ����
//	void			CalcCurDexterity();						// ���㵱ǰ����
//	void			CalcCurVitality();						// ���㵱ǰ����
//	void			CalcCurEngergy();						// ���㵱ǰ����
	void			LevelAddBaseLifeMax();					// �ȼ���һ�����������������
	void			LevelAddBaseManaMax();					// �ȼ���һ�����������������
	void			LevelAddBaseStaminaMax();				// �ȼ���һ�����������������

	void			SendProfessionData();						// ��ͻ��˷�����������

	void			SyncCurrentBaseAttriibute(int type,int attribute,int curAttribute);
	void			AddBaseStrength(int nData);				// ���ӻ�������
	void			AddBaseDexterity(int nData);			// ���ӻ�������
	void			AddBaseVitality(int nData);				// ���ӻ�������
	void			AddBaseEngergy(int nData);				// ���ӻ�������

	void			ResetBaseStrength(int nData);			// ���ӻ�������
	void			ResetBaseDexterity(int nData);			// ���ӻ�������
	void			ResetBaseVitality(int nData);			// ���ӻ�������
	void			ResetBaseEngergy(int nData);			// ���ӻ�������

	void			SetNpcPhysicsDamage();					// �ɵ�ǰ���������Ӧnpc�������˺�(PhysicsDamage)
	void			SetNpcAttackRating();					// �ɵ�ǰ���ݼ����Ӧnpc�Ĺ���������(AttackRating)
	void			SetNpcDefence();						// �ɵ�ǰ���ݼ����Ӧnpc�ķ�����
//	void			SetNpcWalkSpeed();						// �ɵ�ǰ���ݼ����Ӧnpc�������ٶ�
//	void			SetNpcRunSpeed();						// �ɵ�ǰ���ݼ����Ӧnpc���ܲ��ٶ�
#ifndef _SERVER
	void			ProcessMouse(int x, int y, int Key, MOUSE_BUTTON nButton);
	void			OnButtonUp(int x,int y,MOUSE_BUTTON nButton);				// ��������̧��
	void			OnButtonDown(int x,int y,int Key,MOUSE_BUTTON nButton);		// ������������
	void			OnButtonMove(int x,int y,int Key,MOUSE_BUTTON nButton);		// �����������º��ƶ�
	void			OnMouseMove(int x,int y);									// ��������ƶ�

	//Question:Ϊ�������԰�ʹ��
	friend			int LuaInitStandAloneGame(Lua_State * L);
#endif


// �����Ķ���
private:
	void			S2CExecuteScript(char * ScriptName, char * szParam);

#ifdef _SERVER
//���ݿ�ģ�麯��-----------------
private:
	int				LoadPlayerBaseInfo(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam);
	int				LoadPlayerItemList(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam);
	int				LoadPlayerFightSkillList(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam);
	int				LoadPlayerStateSkillList(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam);
	int				LoadPlayerTaskList(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int &nParam);
	int				SavePlayerBaseInfo(PHONGTHAN_CHARACTER_STATE_HEADER* pState);
	int				SavePlayerItemList(PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int nCapacity);
	int				SavePlayerFightSkillList(PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int nCapacity);
	int				SavePlayerStateSkillList(PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int nCapacity);
	int				SavePlayerTaskList(PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int nCapacity);

#endif

public:
	void			SetNpcDamageAttrib();
	void			DoScriptAction(KPhongThanScriptAction * pUIInfo); //֪ͨ�ÿͻ�����ʾĳ��UI����
	void ExecuteUiSelection(int selection, int view);
	void			ProcessPlayerSelectFromUI(BYTE* pProtocol);			// ��������Ҵ�ѡ��˵�ѡ��ĳ��ʱ�Ĳ���
#ifndef _SERVER
	void			DialogNpc(int nIndex);
	void			OnSelectFromUI(KPhongThanUiSelection * pSelectUI, UIInfo eUIInfo);//����Ҵ�ѡ�����ѡ��ĳ��󣬽������������
	void			OnScriptAction(KPhongThanScriptAction * );
#endif
#ifdef _SERVER
	void			RestoreLiveData();						//������ָ���ҵĻ�������
	void			SetTimer(DWORD nTime, int nTimeTaskId);//ʱ������ű���������ʱ��
	void			CloseTimer();							//�ر�ʱ���ʱ��

	int				AddDBPlayer(char * szPlayerName, int sex, DWORD * pdwID );
	int				LoadCharacterState(const PHONGTHAN_CHARACTER_STATE_HEADER* pState, int &nStep, unsigned int &nParam);
	BOOL			GetNewPlayerFromIni(KIniFile * pIniFile, BYTE * pRoleBuffer);
	int				UpdateCharacterState(PHONGTHAN_CHARACTER_STATE_HEADER* pState, unsigned int nCapacity);
	int				DeletePlayer(char * szPlayerName = NULL);//ע�⣺���������������ʺţ���������������
	void			LaunchPlayer();
	BOOL			Pay(int nMoney);
	BOOL			Earn(int nMoney);
	void			DialogNpc(BYTE * pProtocol);

	void			SetBaseStrength(int nData);
	void			SetBaseDexterity(int nData);
	void			SetBaseVitality(int nData);
	void			SetBaseEngergy(int nData);
#endif
};

#ifdef TOOLVERSION
extern CORE_API KPlayer	Player[MAX_PLAYER];
#else
extern KPlayer	Player[MAX_PLAYER];
#endif
#endif //KPlayerH

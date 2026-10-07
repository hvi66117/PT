#ifndef KPlayerSetH
#define	KPlayerSetH

#include "KLinkArray.h"
#include "PhongThanProtocol.h"

typedef struct
{
	int		m_nExpP;
	int		m_nExpV;
	int		m_nMoney;
	int		m_nItem;
	int		m_nEquip;
	int		m_nAbradeP;
} KPK_DEATH_PUNISH_PARAM;

class KLevelAdd
{
private:
	int		m_nLevelExp[MAX_LEVEL];				// ��������
	int		m_nLevelExpAdd[MAX_TRANSLIFE_VALUE][MAX_LEVEL];				// ��������
	int		m_nLifePerLevel[MAX_SERIES];			// ÿ��ϵ������������
	int		m_nStaminaMalePerLevel[MAX_SERIES];			// ÿ��ϵ������������
	int		m_nStaminaFemalePerLevel[MAX_SERIES];			// ÿ��ϵ������������
	int		m_nManaPerLevel[MAX_SERIES];			// ÿ��ϵ������������
	int		m_nLifePerVitality[MAX_SERIES];			// ÿ��ϵ����������һ�������������
	int		m_nStaminaPerVitality[MAX_SERIES];		// ÿ��ϵ����������һ�������������
	int		m_nManaPerEnergy[MAX_SERIES];			// ÿ��ϵ����������һ�������������
	int		m_nLeadExpShare[MAX_SERIES];			// ÿ��ϵ���ս������ʱ����ͳ��������Ĳ���
	int		m_nFireResistPerLevel[MAX_SERIES];		// ÿ��ϵ�����ӻ���
	int		m_nColdResistPerLevel[MAX_SERIES];		// ÿ��ϵ�����ӱ�����
	int		m_nPoisonResistPerLevel[MAX_SERIES];	// ÿ��ϵ�����Ӷ�����
	int		m_nLightResistPerLevel[MAX_SERIES];		// ÿ��ϵ�����ӵ翹��
	int		m_nEarthResistPerLevel[MAX_SERIES];		// ÿϵӵ翹
	int		m_nPhysicsResistPerLevel[MAX_SERIES];	// ÿϵ
	int		m_nStaminaMaleBase[MAX_SERIES];	// ÿϵ
	int		m_nStaminaFemaleBase[MAX_SERIES];	// ÿϵ
public:
	KLevelAdd();
	BOOL		Init();
	int			GetLevelExp(int nLevel, int nTranslife);
	int			GetLifePerLevel(int nSeries);
	int			GetStaminaPerLevel(int nSex, int nSeries);
	int			GetManaPerLevel(int nSeries);
	int			GetLifePerVitality(int nSeries);
	int			GetStaminaPerVitality(int nSeries);
	int			GetManaPerEnergy(int nSeries);
	int			GetLeadExpShare(int nSeries);
	int			GetFireResist(int nSeries, int nLevel);
	int			GetColdResist(int nSeries, int nLevel);
	int			GetPoisonResist(int nSeries, int nLevel);
	int			GetLightResist(int nSeries, int nLevel);
	int			GetEarthResist(int nSeries, int nLevel);
	int			GetPhysicsResist(int nSeries, int nLevel);
	int			GetStaminaBase(int nSex, int nSeries);
};

class KMagicLevelExp
{
private:
	KTabFile	m_MagicLevelExpFile;
public:
	KMagicLevelExp();
	BOOL		Init();
	
	int			GetNextExp(int nSkillId, int nLevel);
};

class KTeamLeadExp
{
public:
	struct LEADLEVEL
	{
		DWORD	m_dwExp;								// ͳ������������
		DWORD	m_dwMemNum;								// ͳ�ʵȼ�������ͳ�ʵĶ�Ա����
	}	m_sPerLevel[MAX_LEAD_LEVEL];
public:
	KTeamLeadExp();
	BOOL		Init();									// ��ʼ��
	int			GetLevel(DWORD dwExp, int nCurLeadLevel = 0);// ���뾭���õȼ��� (������뵱ǰ�ȼ������Լӿ������ٶ�)
	int			GetMemNumFromExp(DWORD dwExp);			// ���뾭���ÿɴ���Ա��
	int			GetMemNumFromLevel(int nLevel);			// ����ȼ���ÿɴ���Ա��
	int			GetLevelExp(int nLevel);				// ����ȼ�����������辭��ֵ
};

class KNewPlayerAttribute
{
public:
	int			m_nStrength[series_num];
	int			m_nDexterity[series_num];
	int			m_nVitality[series_num];
	int			m_nEngergy[series_num];
	int			m_nLucky[series_num];
public:
	KNewPlayerAttribute();
	BOOL		Init();
};

class KPlayerStamina
{
public:
	int			m_nNormalAdd;
	int			m_nExerciseRunSub;
	int			m_nFightRunSub;
	int			m_nKillRunSub;
	int			m_nTongWarRunSub;
	int			m_nSitAdd;
public:
	KPlayerStamina();
	BOOL		Init();
};

class KPlayerSet
{
private:	// �����Ż������ٶ�
	KLinkArray		m_FreeIdx;				//	���ñ�
	KLinkArray		m_UseIdx;				//	���ñ�
	int				m_nListCurIdx;			// ���� GetFirstPlayer �� GetNextPlayer
#ifdef _SERVER
	unsigned long	m_ulNextSaveTime;
	unsigned long	m_ulDelayTimePerSave;	//1mins
	unsigned long	m_ulMaxSaveTimePerPlayer; //30mins
#endif

public:
	KLevelAdd				m_cLevelAdd;
	KMagicLevelExp			m_cMagicLevelExp;
	KTeamLeadExp			m_cLeadExp;
	KNewPlayerAttribute		m_cNewPlayerAttribute;
	KPlayerStamina			m_cPlayerStamina;
#ifndef _SERVER
	char					m_szNationalEmblemPic[MAX_TONG_NATIONALEMBLEM][MAX_PATH];
	char					m_szViprankPic[MAX_ITEM_LEVEL+1][MAX_PATH];
	char					m_szFortuneRankPic[MAX_ITEM_LEVEL+1][MAX_PATH];
	char					m_szTranlifePic[MAX_TRANSLIFE_VALUE+1][MAX_PATH];
#endif

#ifdef _SERVER
	KPK_DEATH_PUNISH_PARAM	m_sPKPunishParam[MAX_DEATH_PUNISH_PK_VALUE + 1];	// PK�ͷ�����
#endif

public:
	KPlayerSet();
	~KPlayerSet();
	BOOL	Init();
	int		FindSame(DWORD dwID);
	int		GetFirstPlayer();				// ����������ҵ�һ��
	int		GetNextPlayer();				// �������������һ��(��֧������������һ֧����֮����ܵ���)
	int		GetNextPlayerFrom(int nCursor);	// Re-entrant cursor enumeration for VNG Lua session APIs.
	int		GetOnlinePlayerCount() { return m_UseIdx.GetCount(); }
//	int		FindClient(int nClient);

#ifdef	_SERVER
	void	Activate();
	int		AddBot(char* szBotName, int nMapID, int nX, int nY);
	int		Add(LPSTR szPlayerID, const PHONGTHAN_U8* pSessionTicket);
	void	PrepareRemove(int nClientIdx);
	void	PrepareExchange(int nIndex);
	void	PrepareLoginFailed(int nIndex);
	void	RemoveQuiting(int nIndex);
	void	RemoveLoginTimeOut(int nIndex);
	void	RemoveExchanging(int nIndex);
	void	AutoSave();
	void	ProcessClientMessage(int nClient, const char* pChar, int nSize);
	int		GetPlayerNumber() { return m_UseIdx.GetCount(); }
	BOOL	GetPlayerName(int nClient, char* szName);
	BOOL	GetPlayerAccount(int nClient, char* szName);
	int		Broadcasting(char* pMessage, int nLen);
	void	SetSaveBufferPtr(void* pData);
	int		AttachPlayer(const unsigned long lnID,
		const PHONGTHAN_U8* pSessionTicket);
	int		GetPlayerIndexBySessionTicket(
		const PHONGTHAN_U8* pSessionTicket);
	int		ExecuteScript(int nPlayerIndex, char* szScriptName, char* szFuncName, int nParam);
	int		ExecuteScript(int nPlayerIndex, DWORD dwScriptId, char* szFuncName, int nParam);
#endif

private:
	int		FindFree();
//TamLTM fix auto save
#ifdef	_SERVER
private:
	int		m_nNumPlayer;
	int		m_nPlayerNumMax;
#endif
//end code
};

extern KPlayerSet PlayerSet;
#endif //KPlayerSetH

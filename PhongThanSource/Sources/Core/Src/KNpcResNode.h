//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KNpcResNode.h
// Date:	2002.01.06
// Code:	�߳�����
// Desc:	Obj Class
//---------------------------------------------------------------------------

#pragma once

#ifndef _SERVER
#include	"KNode.h"

// ������ Ů���� ��ƴ��npc�� ��ͨnpc
enum
{
	NPC_RES_SPECIAL = 0,
	NPC_RES_NORMAL,
	MAX_NPC_RES_KIND,
};

#define MAX_BODY_PART			5
// VNG player resources define three component slots per group in the
// original player-part list (head/body/weapon/cloak/horse groups).
// The old runtime used four slots, which shifted every group after the
// first one and made the VNG sort table (indices 0..14) point at the wrong
// arrays.  Keep the layout identical to the authoritative VNG tables.
#define MAX_BODY_PART_SECT		3
#define MAX_PART				(MAX_BODY_PART*MAX_BODY_PART_SECT)
#define MAX_NPC_IMAGE_NUM		(1 + MAX_PART + 6 + 1 + 1) 

#define MAX_ACTION				128
#define MAX_RES_STATE			256

// ������������������
class CActionName
{
private:
	char	m_szName[MAX_ACTION][FILE_NAME_LENGTH];	// ��������
	int		m_nMaxAction;				// ���������������
	int		m_nCurActionNo;				// ��������

public:
	CActionName();
	// ��ȡ�������ࡢ���Ƶ���Ϣ
	BOOL	Init(char *lpszFileName);
	// �ɶ������Ƶõ��������
	int		GetActionNo(char *lpszName);
	// �õ�����������
	int		GetActionCount();
	// �ɶ�����ŵõ���������
	BOOL	GetActionName(int nNo, char *lpszName, int nSize);

};

class CShadowFileName
{
private:
	struct	SShadowFileInfo
	{
		char	m_szName[FILE_NAME_LENGTH];
		int		m_nTotalFrame;
		int		m_nTotalDir;
		int		m_nInterval;
		int		m_nCgX;
		int		m_nCgY;
	}	*m_psInfo;
	int		m_nInfoLength;

public:
	CShadowFileName();
	~CShadowFileName();
	// ��ʼ���ڴ����
	void		Init(int nActionCount);
	// �õ�ĳ����������Ӱ�ļ�����������ļ���Ϣ
	BOOL		GetFile(int nActionNo, int *pnFrame, int *pnDir, int *pnInterval, int *pnCgX, int *pnCgY, char *lpszName);
friend class KNpcResNode;
};

enum StateMagicType
{
	STATE_MAGIC_HEAD = 0,
	STATE_MAGIC_BODY,
	STATE_MAGIC_FOOT,
	STATE_MAGIC_TYPE_NUM,
};

// ״̬��������Ч��Ӧ��
class CStateMagicTable
{
private:
	int			m_nType[MAX_RES_STATE];			// ���ͣ�ͷ�����ŵס�����
	int			m_nPlayType[MAX_RES_STATE];		// �������ͣ�ѭ������
	int			m_nBackStart[MAX_RES_STATE];	// ��������npc����ʼ֡
	int			m_nBackEnd[MAX_RES_STATE];		// ��������npc�������֡
	int			m_nTotalFrame[MAX_RES_STATE];	// spr �ļ���֡��
	int			m_nTotalDir[MAX_RES_STATE];		// spr �ļ��ܷ�����
	int			m_nInterVal[MAX_RES_STATE];// spr �ļ�֡���
	char		m_szName[MAX_RES_STATE][80];	// spr �ļ���
public:
	CStateMagicTable();							// ���캯��
	BOOL		Init();							// ��ʼ��
	// ����:	�õ�ĳ��״̬�Ĺ�ӰЧ������Ϣ
	void		GetInfo(int nNo, char *lpszGetName, int *pnType, int *pnPlayType, int *pnBackStart, int *pnBackEnd, int *pnTotalFrame, int *pnTotalDir, int *pnInterVal);
};

typedef struct SPR_INFO
{
	int		nTotalFrames;
	int		nTotalDirs;
	int		nInterval;
	int		nTotalEffectFrames;
	int		nTotalEffectDirs;
	int		nEffectInterval;
	char	szFileName[80];
	char	szEffectFileName[80];
} CSPR_INFO;
// ĳ����������װ���ڸ��ֶ����µ�ͼ���ļ���
class CRESINFO
{
public:
	int			m_nActionKind;				// ����������
	int			m_nEquipKind;				// װ��������
	CSPR_INFO	*m_cSprInfo;				// ĳ����������Դ�ļ��������Ϣ
public:
	CRESINFO();
	~CRESINFO();
	// �������
	void		AutoDelete();
	// �趨������������װ������������������ڴ滺����
	BOOL		AutoNew(int nWidth, int nHeight);
	// ���ݶ�����š�װ����ŵõ���Դ�ļ���
	BOOL		GetName(int nActionNo, int nEquipNo, char *lpszDefault, char *lpszGetName, int nStrLen,bool bEffect=false);
	int			GetInterval(int nActionNo, int nEquipNo, int nDefault,bool bEffect=false);
	int			GetTotalFrames(int nActionNo, int nEquipNo, int nDefault,bool bEffect=false);
	int			GetTotalDirs(int nActionNo, int nEquipNo, int nDefault,bool bEffect=false);
};


// װ����״̬�붯�����ձ���KNpcResNode ����������һ������û�����ģ�һ������������
class CEquipStyleTable
{
private:
	int			m_nStyleKind;		// ״̬������
	int			m_nEquipKind;		// װ��������
	int			*m_lpnActionNo;		// �������ݣ���СΪ m_nStyleKind * m_nEquipKind
public:
	CEquipStyleTable();
	~CEquipStyleTable();
	// �������
	void		AutoDelete();
	// �趨���񳤿�����ʼ�����񻺳���
	BOOL		AutoNew(int nWidth, int nHeight);
	// �趨������ĳһ���ֵ
	void		SetValue(int nXpos, int nYpos, int nValue);
	// �õ�������ĳһ���ֵ
	int			GetValue(int nXpos, int nYpos);
};


// ���������
typedef struct SACTTABLEOFF
{
	int		nActOff;			// �˶�����˳���Ӧ������Ϣ��λ��
	int		nLineNum;			// �˶����ڶ�Ӧ���е���Ӧ��Ϣ�ж�����
	BOOL	bUseDefault;		// �˶������������˳����Ϣ�Ƿ�ʹ��Ĭ�Ϸ�ʽ
	SACTTABLEOFF() { Clear(); };
	void	Clear() { nActOff = 0; nLineNum = 0; bUseDefault = TRUE; };
} SActTableOff;

// ��������Ĵ���
class CSortTable
{
private:
	SActTableOff	m_sActTableOff[MAX_ACTION];	// ÿ�������ڱ����еĲ��ҷ�ʽ
	int				*m_lpnSortTable;			// ���������СΪ��m_nSortTableSize * (m_nPartNum + 1)
	int				m_nSortTableSize;			// �����ж�����
	int				m_nPartNum;					// �ж����ֲ���������ÿһ�е�һ����Ԫ��ʾ�ڼ��壬
												// ������� m_nPartNum ����Ԫ���洢ÿ�������ı��
	
public:
	CSortTable();
	~CSortTable();
	char			m_sSortTableFileName[100]; //��������ļ��������ڱ༩��
	// �������ļ��а�������Ϣ��ȡ��������Ҫ�������Ϣ�У������ļ��������ֶ��������Ƶ���Ϣ������������
	BOOL			GetTable(char *lpszFileName, CActionName *cActionName, int nPartNum);
	BOOL			GetTable(KIniFile *pIni, CActionName *cActionName, int nPartNum);
	// �ӱ����еõ�һ��������Ϣ
	BOOL			GetSort(int nActNo, int nDir, int nFrameNo, int *lpnTable, int nTableLen);
private:
	// �������
	void			Release();
	// ���ַ����а�һϵ������ȡ����
	void			SortStrToNum(char *lpszStr, int *lpnTable, int nTableSize);
};
// ע������ǰ�� MAX_SORT_DIR �������ж�����Ĭ�Ϸ�ʽ�µ�����ʽ��������ָ��ʹ��Ĭ��
//     ��ʽ���Ҳ���������������ʹ����Щ��Ϣ�����������ж���������������Ϣ��ÿһ��
//     ����һ����Ԫ��ÿ����Ԫ��Ϊ�����֣���һ���������� MAX_SORT_DIR �������������
//     Ϣ������˶���ָ������Ĭ�Ϸ�ʽ����������ִ��ڲ���ռ MAX_SORT_DIR �У��ڶ���
//     ���������������ʽ��������������ɶ���ָ���������ڵ�һ����ʱΪ nLineNum - 
//     MAX_SORT_DIR���������ڵ�һ����ʱΪ nLineNum�������û�������壬���ⲿ�ֲ�����

#ifndef TOOLVERSION
class KNpcResNode : public KNode
#else
class CORE_API KNpcResNode : public KNode
#endif
{
private:
	int					m_nNpcKind;				// ������ Ů���� ��ͨnpc
	int					m_nPartNum;
	char				m_szResPath[80];		// ͼ���ļ�(spr)��ŵ�·��
	CRESINFO			m_cResInfo[MAX_PART];	// ĳ������������Դ�ļ���Ϣ������������Դ�ļ�����
	CEquipStyleTable	m_NoHorseTable;
	CEquipStyleTable	m_OnHorseTable;
	char				m_szSoundName[MAX_ACTION][80];
	
public:
	CSortTable			m_cSortTable;

	struct SECTINFO
	{
		int				nFlag;					// �˲����Ƿ����
		char			szSectName[32];			// �˲����Ĳ�����
		char			szSectResName[80];		// �˲�����Ӧ����Դ˵���ļ���
		char			szSectSprInfoName[80];	// �˲�����Ӧ����Դ��Ϣ˵���ļ�
		char			szSectEffectName[80];
		char			szSectEffectInfoName[80];
		SECTINFO() { Clear(); };
		void	Clear() { nFlag = 0; szSectName[0] = 0; szSectResName[0] = 0; szSectSprInfoName[0] = 0; szSectEffectName[0] = 0; szSectEffectInfoName[0] = 0; };

	}		 			m_nSectInfo[MAX_PART];	// ������Ϣ

	CShadowFileName		m_cShadowInfo;			// ��Ӧ���ж�������Ӱ�ļ���Ϣ

	char				m_szNpcName[80];		// ���������

public:
	KNpcResNode();
	~KNpcResNode();
	//	��ʼ��������������Ӧ����
	BOOL			Init(char *lpszNpcName, CActionName *cActionName, CActionName *cNpcAction);
	// �ж���Դ����(��ƴ�����ͻ���ƴ������)
	int				GetNpcKind() { return m_nNpcKind; };
	// �ж�ĳ�������Ƿ����
	BOOL			CheckPartExist(int nPartNo);
	// ���ĳ��������ĳ��װ����ĳ�������µ� spr �ļ���
	BOOL			GetFileName(int nPartNo, int nActionNo, int nEquipNo, char *lpszDefault, char *lpszGetName, int nStrLen, bool bEffect=false);
	// ���ĳ��������ĳ��װ����ĳ�������µ� spr �ļ���֡���
	int				GetInterval(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect=false);
	// ���ĳ��������ĳ��װ����ĳ�������µ� spr �ļ�����֡��
	int				GetTotalFrames(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect=false);
	// ���ĳ��������ĳ��װ����ĳ�������µ� spr �ļ����ܷ�����
	int				GetTotalDirs(int nPartNo, int nActionNo, int nEquipNo, int nDefault, bool bEffect=false);
	// ���ĳ����ĳ״̬�µĶ������
	int				GetActNo(int nDoing, int nEquipNo, BOOL bRideHorse);
	// �ӱ����еõ�һ��������Ϣ
	BOOL			GetSort(int nActNo, int nDir, int nFrameNo, int *lpnTable, int nTableLen);

	// ��·�����ļ����ϳ���һ���Ϊ��·�����ļ���
	void			ComposePathAndName(char *lpszGet, char *lpszPath, char *lpszName);
	// ���ĳ��������Ӧ����Ч�ļ���
	void			GetActionSoundName(int nAction, char *lpszSoundName);

	static void		GetShadowName(char *lpszShadow, char *lpszSprName);
};
#endif

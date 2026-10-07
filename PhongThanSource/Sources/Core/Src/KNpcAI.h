#ifndef	KNpcAIH
#define	KNpcAIH

#include "KMath.h"

class	KNpcAI
{
public:
	int				m_nIndex;
	BOOL			m_bActivate;
private:
public:
	KNpcAI();	
	void			Activate(int nIndex);
	void			NotActivate(int nIndex);
	void			Enable(){ m_bActivate = TRUE; }
	void			Disable(){ m_bActivate = FALSE; }	
private:	
	int				GetNearestNpc(int nRelation);
	int				GetNpcNumber(int nRelation);
	void			ProcessPlayer();

/*	void			ProcessAIType1();
	void			ProcessAIType2();
	void			ProcessAIType3();
	void			ProcessAIType4();
	void			ProcessAIType5();
	void			ProcessAIType6();
	void			ProcessAIType7();
	void			ProcessAIType8();
	void			ProcessAIType9();
	void			ProcessAIType10();*/
	void			ProcessAIType01();		// ��ͨ������1
	void			ProcessAIType02();		// ��ͨ������2
	void			ProcessAIType03();		// ��ͨ������3
	void			ProcessAIType04();		// ��ͨ������1
	void			ProcessAIType05();		// ��ͨ������2
	void			ProcessAIType06();		// ��ͨ������3
	void			ProcessAIType11();		// ��ͨ������3
	void			TriggerObjectTrap();
	void			TriggerMapTrap();
	void			FollowAttack(int nIdx);
	BOOL			InEyeshot(int nIdx);
	void			CommonAction();
	BOOL			KeepActiveRangeOwern();
	BOOL			KeepActiveRange();
	void			KeepAttackRange(int nEnemy, int nRange);
	void			Flee(int nIdx);
	BOOL			CheckNpc(int nIndex);
#ifndef _SERVER
	void			FollowPeople(int nIdx);
	void			FollowObject(int nIdx);
#else
	void			FindPathNpc();
#endif
	friend class KNpc;
#ifndef _SERVER
	// װ������NPC�˶�����ϵ�� 
	// flying add these on Jun.4.2003
	// ����װ����NPC�˶�������ڣ���Activate(int)�ڲ�����
	int				ProcessShowNpc();
	int  			ShowNpcType11();
	int				ShowNpcType12();
	int				ShowNpcType13();
	int				ShowNpcType14();
	int				ShowNpcType15();
	int				ShowNpcType16();
	int				ShowNpcType17();
	int             GetNpcMoveOffset(int nDir, int nDistance, int *pnX, int *pnY);

	// �ж��Ƿ񳬳���Χ
	//BOOL KeepActiveShowRange();
	// 16/17 AiMode NPC�����ݶ���
	int				DoShowFlee(int nIdx);

	// �ж��Ƿ����֡�ڿ��Ը���NPC��ָ��
	BOOL			CanShowNpc();
#endif
	// flying add the function to get nearest player.
	int			IsPlayerCome();
};

#if !defined _SERVER
inline int KNpcAI::GetNpcMoveOffset(int nDir, int nDistance, int *pnX, int *pnY)
{
    _ASSERT(pnX);
    _ASSERT(pnY);

    *pnX = -nDistance * g_DirSin(nDir, 64);
    *pnY = -nDistance * g_DirCos(nDir, 64);

    return true;
}

inline BOOL KNpcAI::CanShowNpc()
{
	BOOL bResult = TRUE;
	if (Npc[m_nIndex].m_AiParam[5] < Npc[m_nIndex].m_AiParam[4])
		bResult = FALSE;
	Npc[m_nIndex].m_AiParam[5]++;
	return bResult;
}
#endif

extern KNpcAI NpcAI;
#endif

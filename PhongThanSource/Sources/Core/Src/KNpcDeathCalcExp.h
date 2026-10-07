//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KNpcDeathCalcExp.h
// Date:	2003.07.21
// Code:	�߳�����
// Desc:	KNpcDeathCalcExp Class
//---------------------------------------------------------------------------

#ifndef KNPCDEATHCALCEXP_H
#define KNPCDEATHCALCEXP_H

#define		defMAX_CALC_EXP_NUM		3
#define		defMAX_CALC_EXP_TIME	1200

typedef struct
{
	int		m_nAttackIdx;
	int		m_nTotalDamage;
	int		m_nTime;
} KCalcExpInfo;

class KNpcDeathCalcExp
{
	friend class KNpc;
private:
	int				m_nNpcIdx;
	KCalcExpInfo	m_sCalcInfo[defMAX_CALC_EXP_NUM];
public:
	void			Init(int nNpcIdx);
	void			Active();
#ifdef _SERVER
	void			AddDamage(int nPlayerIdx, int nDamage);
//	int				CalcExp();
	int				CalcExp(int nAttacker = -1); //TamLTM fix exp
#endif
	void			Clear();
};

#endif

/*
int	g_CastSkill(TSkillParam * pSkillParam)
{
	if (pSkillParam->usSkillID > g_ulSkillCount || pSkillParam->usSkillLevel > MAX_SKILLLEVEL)	return FALSE;
	if (!g_pSkill[pSkillParam->usSkillID][pSkillParam->usSkillLevel])
	{
		if (!g_GenSkillData(pSkillParam->usSkillID, pSkillParam->usSkillLevel)) return FALSE;
	}

	return g_pSkill[pSkillParam->usSkillID][pSkillParam->usSkillLevel]->Cast(pSkillParam);
}

BOOL	g_InstanceSkill(eSKillStyle eStyle, unsigned long ulSkillID, unsigned long ulSkillLevel)
{
	if (!g_pSkill[ulSkillID][ulSkillLevel])
	{
		switch(eStyle)
		{
		case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
			{
				g_pSkill[ulSkillID][ulSkillLevel] = new KMissleSkill;
			}break;
		case SKILL_SS_Melee:
			{
				
			}break;
		case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
		case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
			{
				g_pSkill[ulSkillID][ulSkillLevel] = new KStateFightSkill;
			}break;
		default:
				g_pSkill[ulSkillID][ulSkillLevel] = new ISkill;
		}	

	}
	return TRUE;
}

ISkill * g_GetSkill(unsigned long ulSkillID, unsigned long ulSkillLevel)
{
	_ASSERT(usSkillID < g_ulSkillCount || usSkillLevel < MAX_SKILLLEVEL);

	if (!g_pSkill[ulSkillID][ulSkillLevel])
	{
		_ASSERT(ulSkillLevel != 0);

		if (!g_InstanceSkill(g_pSkill[ulSkillID][0].GetSkillStyle(), ulSkillID, ulSkillLevel)) return NULL;
		g_pSkill[ulSkillID][ulSkillLevel]->SetRowIdInSkillTabFile(g_pSkill[ulSkillID][0]->GetRowIdInSkillTabFile());
		*g_pSkill[ulSkillID][ulSkillLevel] = *g_pSkill[ulSkillID][0];
		g_pSkill[ulSkillID][ulSkillLevel]->SetSkillLevelData(ulSkillLevel);	
	}
		return g_pSkill[ulSkillID][ulSkillLevel];
}
*/
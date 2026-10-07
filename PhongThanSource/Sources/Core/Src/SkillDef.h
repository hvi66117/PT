#ifndef __SKILLDEF_H__
#define __SKILLDEF_H__

#define MAX_SKILL							4096
#define TU_CHAN_SEAL_LEGACY_SKILL		1973
#define TU_CHAN_SEAL_SKILL_BEGIN			2800
#define TU_CHAN_SEAL_SKILL_END			3898
#define TU_CHAN_SEAL_DURATION_TICKS		1728000
#define IS_TU_CHAN_SEAL_SKILL(skillId) \
	((skillId) == TU_CHAN_SEAL_LEGACY_SKILL || \
	 ((skillId) >= TU_CHAN_SEAL_SKILL_BEGIN && (skillId) <= TU_CHAN_SEAL_SKILL_END))
#define	MAX_LIVESKILL						10
#define MAX_SKILLLEVEL						64
#define MAX_TRAIN_SKILLEXPLEVEL				20
#define MaxMissleDir						64
#define MAXSKILLLEVELSETTINGNUM				20  //����д��������ʱ���������������
#define MAX_MISSLESTYLE						550
#define MISSLE_MIN_COLLISION_ZHEIGHT		0	  //�ӵ������ײ�ĸ߶ȡ�
#define MISSLE_MAX_COLLISION_ZHEIGHT		20   //�ӵ����ڸø߶�ʱ,��������ײ	
#define MAX_ADDSKILLDAMAGE					9
#define MAX_APPENDSKILL						5
#define MAX_AUTOSKILL						3

//---------------------------------------------------------------------------
// MoveKind �˶�����
//---------------------------------------------------------------------------
enum eMissleMoveKind
{
	MISSLE_MMK_Stand,							//	ԭ��
		MISSLE_MMK_Line,							//	ֱ�߷���
		MISSLE_MMK_Random,							//	������У����ڶ�Ů�׵�Charged Bolt��
		MISSLE_MMK_Circle,							//	���з��У�Χ�������ߣ����ڶ��̿͵ļ�����
		MISSLE_MMK_Helix,							//	�����׵������ߣ����ڶ�������Bless Hammer��
		MISSLE_MMK_Follow,							//	����Ŀ�����
		MISSLE_MMK_Motion,							//	��Ҷ�����
		MISSLE_MMK_Parabola,						//	������
		MISSLE_MMK_SingleLine,						//	���еĵ�һֱ�߷���ħ��
		MISSLE_MMK_RollBack = 100,					//  �ӵ����ط���
		MISSLE_MMK_Toss		,						//	������
};

//---------------------------------------------------------------------------
// FollowKind ��������	(��Ҫ�����ԭ�ء������������߷���������)
//---------------------------------------------------------------------------
enum eMissleFollowKind
{
	MISSLE_MFK_None,							//	�������κ����
	MISSLE_MFK_NPC,								//	����NPC�����
	MISSLE_MFK_Missle,							//	�����ӵ�
};

#define	MAX_MISSLE_STATUS 4
enum eMissleStatus
{
	MS_DoWait,
	MS_DoFly,
	MS_DoVanish,
	MS_DoCollision,
};


enum eSkillLRInfo
{
	BothSkill,          //���Ҽ��Կ�
	LeftOnlySkill,		//���
	RightOnlySkill,		//�Ҽ�
	NoneSkill,			//������
};

//--------------------------------------------------------Skill.h

//���ܷ����ߵ�����
enum eGameActorType
{
	Actor_Npc,
	Actor_Obj,
	Actor_Missle,
	Actor_Sound,
	Actor_None,
};
enum eSkillLauncherType
{
	SKILL_SLT_Npc = 0,
	SKILL_SLT_Obj ,
	SKILL_SLT_Missle,
};


#ifndef _SERVER

struct	TOrginSkill
{
	int		nNpcIndex;				//	Npc��index
	DWORD	nSkillId;				//	���͵�skillid
};

#endif


enum eSkillParamType
{
	SKILL_SPT_TargetIndex	= -1,
	SKILL_SPT_Direction		= -2,
};

//���ܵ�����
enum eSKillStyle
{
	SKILL_SS_Missles = 0,			//	�ӵ���		���������ڷ����ӵ���
		SKILL_SS_Melee = 1,
		SKILL_SS_InitiativeNpcState,	//	������		���������ڸı䵱ǰNpc������״̬
		SKILL_SS_PassivityNpcState,		//	������		���������ڸı�Npc�ı���״̬
		SKILL_SS_CreateNpc,				//	����Npc��	��������������һ���µ�Npc
		SKILL_SS_BuildPoison,			//	������		��������������
		SKILL_SS_AddPoison,				//	�Ӷ���		���������ڸ������Ӷ���
		SKILL_SS_GetObjDirectly,		//	ȡ����		���������ڸ���ȡ��
		SKILL_SS_StrideObstacle ,		//	��Խ��		���������ڿ�Խ�ϰ�
		SKILL_SS_BodyToObject,			//	������		���������ڽ�ʬ���ɱ���
		SKILL_SS_Mining,				//	�ɿ���		���������ڲɿ�������ɿ�ʯ
		SKILL_SS_RepairWeapon,			//	�޸���		�����������޸�װ��
		SKILL_SS_Capture,				//	��׽��		���������ڲ�׽����Npc
		SKILL_SS_Thief,					//	͵����
		SKILL_SS_Reserved14 = 14,
		SKILL_SS_PhongThanAttack = 15,
		SKILL_SS_PhongThanProduce = 16,
		SKILL_SS_PhongThanAwaken = 17,
};


//ͬʱ�����Ķ���ӵ��ķ�����ʼ��ʽ
enum eMisslesForm
{
	SKILL_MF_Wall	= 0,			//ǽ��	����ӵ��ʴ�ֱ�������У���ʽ��ǽ״
		SKILL_MF_Line,					//����	����ӵ���ƽ������ҷ�������
		SKILL_MF_Spread,				//ɢ��	����ӵ���һ���ĽǶȵķ�ɢ״	
		SKILL_MF_Circle,				//Բ��	����ӵ�Χ��һ��Ȧ
		SKILL_MF_Random,				//���	����ӵ�����ŷ�
		SKILL_MF_Zone,					//����	����ӵ�������ĳ����Χ��
		SKILL_MF_AtTarget,				//����	����ӵ�����
		SKILL_MF_AtFirer,				//����	����ӵ�ͣ����ҵ�ǰλ��
		SKILL_MF_COUNT,
};

enum eMeleeForm
{
	Melee_AttackWithBlur = SKILL_MF_COUNT,
	Melee_Jump,
	Melee_JumpAndAttack,
	Melee_RunAndAttack,
	Melee_ManyAttack,
	Melee_MoveWithBlur,
	Melee_Go, //TamLTM fix auto xy map
};


enum eSKillCostType
{
	SKILL_SCT_MANA		= 1,
		SKILL_SCT_LIFE		= 2,
		SKILL_SCT_STAMINA	= 8,
		SKILL_SCT_MONEY		= 16,
};

enum eMisslesGenerateStyle
{
	SKILL_MGS_NULL		= 0,
		SKILL_MGS_SAMETIME	,    //ͬʱ
		SKILL_MGS_ORDER		,	 //��˳��
		SKILL_MGS_RANDONORDER,
		SKILL_MGS_RANDONSAME,
		SKILL_MGS_CENTEREXTENDLINE,  //���м���������ɢ
};

typedef struct 
{
	int dx;
	int dy;
}TCollisionOffset;

typedef struct 
{
	int nRegion;
	int nMapX;
	int nMapY;
}
TMisslePos;

typedef struct 
{
	TCollisionOffset m_Offset [4];
}
TCollisionMatrix;
extern TCollisionMatrix g_CollisionMatrix[64];


typedef struct 
{
	int nLauncher;	
	DWORD dwLauncherID;			
	eSkillLauncherType eLauncherType; //�����ߣ�һ��ΪNpc


	int nParent;
	eSkillLauncherType eParentType;	  //ĸ	 
	DWORD dwParentID;

	int nParam1;
	int nParam2;
	int nWaitTime;
	int nTargetId;
	DWORD dwTargetNpcID;
}
TOrdinSkillParam, * LPOrdinSkillParam;

#endif //__SKILLDEF_H__

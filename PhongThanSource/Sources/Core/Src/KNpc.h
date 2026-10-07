#ifndef KNpcH
#define KNpcH
#include "PhongThanWorldProtocol.h"
//---------------------------------------------------------------------------
class ISkill;
#include "KCore.h"
#include "KSkillList.h"
#include "KMagicAttrib.h"
#include "GameDataDef.h"
#include "KNpcFindPath.h"
#include "KNpcDeathCalcExp.h"
#include "KIndexNode.h"

class KSkill;
#ifndef _SERVER
#include "KNpcRes.h"
#endif
//---------------------------------------------------------------------------
#define MAX_NPCSTYLE	4096

#define MAX_NPC_SCRIPT_FILE_NAME	128

#define		MAX_AI_PARAM				11
#define		MAX_NPC_USE_SKILL			4

#define		BLOOD_COUNT					9
//	�ܶ��ٶ��������ٶȵı���
//#define	WALK_RUN_TIMES	3

#define		STATE_FREEZE	0x0001
#define		STATE_POISON	0x0002
#define		STATE_STUN		0x0004
#define		STATE_HIDE		0x0008
#define		STATE_FROZEN	0x0010
#define		STATE_WALKRUN	0x0020
//Son fix loi ket map
#define		MAX_FLOOD_SHOW				9
//end code

enum NPCATTRIB
{
	attrib_mana_v,
	attrib_stamina_v,
	attrib_life_v,
	attrib_mana_p,
	attrib_stamina_p,
	attrib_life_p,
};

enum NPCCMD
{
	do_none,		// ʲôҲ����
	do_stand,		// վ��
	do_walk,		// ����
	do_run,			// �ܶ�
	do_jump,		// ��Ծ
	do_skill,		// �����ܵ�����
	do_magic,		// ʩ��
	do_attack,		// ����
	do_sit,			// ����
	do_hurt,		// ����
	do_death,		// ����
	do_defense,		// ��
	do_idle,		// ����
	do_specialskill,// ���ܿ��ƶ���
	do_special1,	// ����1
	do_special2,	// ����2
	do_special3,	// ����3
	do_blurmove,	// ����4
	do_runattack,
	do_manyattack,
	do_jumpattack,
	do_revive,
	do_goattack,
};

enum CLIENTACTION
{
	cdo_fightstand,
	cdo_stand,
	cdo_stand1,
	cdo_fightwalk,
	cdo_walk,
	cdo_fightrun,
	cdo_run,
	cdo_hurt,
	cdo_death,
	cdo_attack,
	cdo_attack1,
	cdo_magic,
	cdo_sit,
	cdo_jump,
	cdo_none,
	cdo_count,
};

enum DAMAGE_TYPE
{
	damage_physics = 0,		// �����˺�
	damage_fire,			// �����˺�
	damage_cold,			// �����˺�
	damage_light,			// �����˺�
	damage_earth,			// ˺
	damage_poison,			// ˺
	damage_magic,			// ˺
	damage_num,				// ˺Ŀ
};

// DoDeath ʱ�Ĳ�������Ӧ��ͬ�������ͷ�
enum	enumDEATH_MODE
{
	enumDEATH_MODE_NPC_KILL = 0,		// ��npcɱ��
	enumDEATH_MODE_PLAYER_NO_PUNISH,	// �д�ģʽ�����ɱ��
	enumDEATH_MODE_PLAYER_SPAR_NO_PUNISH,	// �д�ģʽ�����ɱ��
	enumDEATH_MODE_PLAYER_PUNISH,		// �����PK����������PKֵ���гͷ�
	enumDEATH_MODE_PKBATTLE_PUNISH,		// ��ʽ�ڹ�սʱ�ĳͷ�����
	enumDEATH_MODE_TOURNAMENTS_PUNISH,
	enumDEATH_MODE_NUM,
};

typedef struct
{
	NPCCMD		CmdKind;		// ����C
	int			Param_X;		// ����X
	int			Param_Y;		// ����Y
	int			Param_Z;		// ����Y
} NPC_COMMAND;

typedef struct
{
	int		nTotalFrame;
	int		nCurrentFrame;
} DOING_FRAME;

struct KState
{
	int	nMagicAttrib;
	int	nValue[2];
	int	nTime;
};

//TamLTM Lag pos npc
struct	KSyncPos
{
	DWORD	m_dwRegionID;
	int		m_nMapX;
	int		m_nMapY;
	int		m_nOffX;
	int		m_nOffY;
	int		m_nDoing;
};
//end code

class KStateNode : public KNode
{
public:

	int				m_SkillID;					// ����ID
	int				m_Level;					// ���ܵȼ�
	int				m_LeftTime;					// ʣ��ʱ��
	BOOL			m_bOverLook;
	BOOL			m_bTempStateGraphics;
	KMagicAttrib	m_State[MAX_SKILL_STATE];	// �޸������б�
	int				m_StateGraphics;			// ״̬��������
};

#ifndef _SERVER
/*--- ���ڱ����ͻ���npc���ĸ�region�ĵڼ���npc ��
�������һ�����������Ƶ�npc ��ID ֵΪ 0 ��No ֵΪ -1  ---*/
struct	KClientNpcID
{
	DWORD	m_dwRegionID;
	int		m_nNo;
};
#endif

class KNpc
{
	friend class KNpcSet;
public:
	BOOL				m_IsCheckAutoPlay;		//TamLTM them check auto move maps
	DWORD				m_dwID;					// Npc��ID
	int					m_Index;				// Npc������
	KIndexNode			m_Node;					// Npc's Node
	int					m_Level;				// Npc�ĵȼ�
	DWORD				m_Kind;					// Npc������
	int					m_Series;				// Npc��ϵ
	BYTE				m_btSpecial;			// Npc�ļ�ǿ���ͣ��ƽ���
	BOOL				m_bNpcRemoveDeath;
	int					m_nNpcTimeout;
	DWORD				m_dwNpcTimerDeadline;
	int					m_nNpcTimerValue;
	int					m_nDeathScriptPlayerIdx;
	DWORD				m_dwDeathScriptPlayerID;
	int					m_nNpcParam[MAX_NPCPARAM];
	BOOL				m_bNpcFollowFindPath;
	DWORD				m_uFindPathTime;
	DWORD				m_uFindPathMaxTime;
	DWORD				m_uLastFindPathTime;
	int					m_Height;				// Npc�ĸ߶�(��Ծ��ʱ�����)
	BYTE				m_RankID;
	KExpandRank			m_ExpandRank;
	KExpandRank			m_CurExpandRank;
	int					m_nStature;				//Tall
	BYTE				m_byTranslife;
	BYTE				m_byViprank;
	BYTE				m_byFortuneRankLevel;
	BYTE				m_ImagePlayer;
	int					m_nProfession;
	BYTE				m_btStateInfo[MAX_SKILL_STATE];	// Npc��ǰ���µļ���״̬
	//����Npcģ����У���FALSE��ʾ��Npc���ݵ�ǰ����Ч�� ����ֵδ�����ű����㣬��Ҫ����.
	//TRUE��ʾ��Ч����
	BOOL				m_bHaveLoadedFromTemplate;//

	KState				m_PoisonState;			// �ж�״̬
	KState				m_FreezeState;			// ����״̬
	KState				m_BurnState;			// ȼ��״̬
	KState				m_StunState;			// ѣ��״̬
	KState				m_FrozenAction;			// ȼ��״̬
	KState				m_LifeState;			// ��Ѫ״̬
	KState				m_ManaState;			// ��MANA״̬
	KState				m_LoseMana;			// ����״̬
	KState				m_HideState;
	KState				m_SilentState;
	KState				m_RandMove;			// ����״̬
	KState				m_WalkRun;

	KState				m_PhysicsArmor;
	KState				m_ColdArmor;
	KState				m_LightArmor;
	KState				m_EarthArmor;
	KState				m_PoisonArmor;
	KState				m_FireArmor;
	KState				m_ManaShield;
    //son fix loi ket map
    int                 m_nCurrentShareDame;
	KList				m_StateSkillList;		// ����״̬�����б���ͬ���ܲ����ӣ�
	int					m_Camp;					// Npc����Ӫ
	int					m_CurrentCamp;			// Npc�ĵ�ǰ��Ӫ
	NPCCMD				m_Doing;				// Npc����Ϊ
	CLIENTACTION		m_ClientDoing;			// Npc�Ŀͻ�����Ϊ
	DOING_FRAME			m_Frames;				// Npc����Ϊ֡��
	KSkillList			m_SkillList;			// Npc�ļ����б�
	int					m_SubWorldIndex;		// Npc���ڵ�SubWorld ID
	int					m_RegionIndex;			// Npc���ڵ�Region ID
	int					m_ActiveSkillID;		// Npc����ļ���ID

	int					m_ActiveAuraID;			// Npc����Ĺ⻷����ID

	// Npc��ʵ�����ݣ��Ѿ�����װ�������ܵ������ˣ�
	int					m_CurrentExperience;	// Npc��ɱ���ͳ��ľ���
	int					m_CurrentLife;			// Npc�ĵ�ǰ����
	int					m_CurrentLifeMax;		// Npc�ĵ�ǰ�������ֵ
	int					m_CurrentLifeReplenish;	// Npc�ĵ�ǰ�����ظ��ٶ�
	int					m_CurrentLifeReplenishPercent;
	int					m_CurrentMana;			// Npc�ĵ�ǰ����
	int					m_CurrentManaMax;		// Npc�ĵ�ǰ�������
	int					m_CurrentManaReplenish;	// Npc�ĵ�ǰ�����ظ��ٶ�
	int					m_CurrentStamina;		// Npc�ĵ�ǰ����
	int					m_CurrentStaminaMax;	// Npc�ĵ�ǰ�������
	int					m_CurrentStaminaGain;	// Npc�ĵ�ǰ�����ظ��ٶ�
	int					m_CurrentStaminaLoss;	// Npc�ĵ�ǰ�����½��ٶ�
	KMagicAttrib		m_PhysicsDamage;		// Npc�ĵ�ǰ�˺�(�����������������˺�������������ֱ�Ӽ��˺���ħ������)
	KMagicAttrib		m_PhysicsMagic;
	KMagicAttrib		m_CurrentFireDamage;	// Npc�ĵ�ǰ���˺�
	KMagicAttrib		m_CurrentColdDamage;	// Npc�ĵ�ǰ���˺�
	KMagicAttrib		m_CurrentLightDamage;	// Npc�ĵ�ǰ���˺�
	KMagicAttrib		m_CurrentEarthDamage;	// Npcĵǰ˺
	KMagicAttrib		m_CurrentPoisonDamage;	// Npcĵǰ˺
	KMagicAttrib		m_CurrentFireMagic;
	KMagicAttrib		m_CurrentColdMagic;
	KMagicAttrib		m_CurrentLightMagic;
	KMagicAttrib		m_CurrentEarthMagic;
	KMagicAttrib		m_CurrentPoisonMagic;

	int					m_CurrentAttackRating;	// Npc�ĵ�ǰ������
	int					m_CurrentDefend;		// Npc�ĵ�ǰ����

	int					m_CurrentFireResist;	// Npc�ĵ�ǰ����
	int					m_CurrentColdResist;	// Npc�ĵ�ǰ������
	int					m_CurrentPoisonResist;	// Npc�ĵ�ǰ������
	int					m_CurrentLightResist;	// Npc�ĵ�ǰ�翹��
	int					m_CurrentEarthResist;	// Npc�ĵ�ǰ�翹��
	int					m_CurrentPhysicsResist;	// Npc�ĵ�ǰ��������
	int					m_CurrentFireResistMax;		// Npc�ĵ�ǰ������
	int					m_CurrentColdResistMax;		// Npc�ĵ�ǰ��������
	int					m_CurrentPoisonResistMax;	// Npc�ĵ�ǰ��󶾿���
	int					m_CurrentLightResistMax;	// Npc�ĵ�ǰ���翹��
	int					m_CurrentEarthResistMax;	// Npcĵǰ翹
	int					m_CurrentPhysicsResistMax;	// Npcĵǰ

	float				m_CurrentWalkSpeed;		// Npc�ĵ�ǰ�߶��ٶ�
	float				m_CurrentRunSpeed;		// Npc�ĵ�ǰ�ܶ��ٶ�
	int					m_CurrentJumpSpeed;		// Npc�ĵ�ǰ��Ծ�ٶ�
	int					m_CurrentJumpFrame;		// Npc�ĵ�ǰ��Ծ֡��
	int					m_CurrentAttackSpeed;	// Npc�ĵ�ǰ�����ٶ�
	int					m_CurrentCastSpeed;		// Npc�ĵ�ǰʩ���ٶ�
	int					m_CurrentVisionRadius;	// Npc�ĵ�ǰ��Ұ��Χ
	int					m_CurrentAttackRadius;	// Npc�ĵ�ǰ������Χ
	int					m_CurrentActiveRadius;	// Npc�ĵ�ǰ���Χ
	int					m_CurrentHitRecover;	// Npc�ĵ�ǰ�ܻ��ظ��ٶ�

// ��������ֻ��Ҫ��ǰֵ������ֵ��Ϊ0
	int					m_CurrentMeleeDmgRetPercent;	// Npc�����˺����صİٷֱ�
	int					m_CurrentMeleeDmgRet;			// Npc���̱���ʱ���ص��˺�����
	int					m_CurrentRangeDmgRetPercent;	// NpcԶ���˺����صİٷֱ�
	int					m_CurrentRangeDmgRet;			// NpcԶ�̱���ʱ���ص��˺�����
	int					m_CurrentReturnResPercent;
	BOOL				m_CurrentSlowMissle;			// Npc�Ƿ��������ӵ�״̬��

	int					m_CurrentDamageReduce;			// �����˺�����
	int					m_CurrentElementDamageReduce;	// Ԫ���˺�����

	int					m_CurrentDamage2Mana;			// �˺�ת�����ٷֱ�
	int					m_CurrentLifeStolen;			// ͵�����ٷֱ�
	int					m_CurrentManaStolen;			// ͵�����ٷֱ�
	int					m_CurrentStaminaStolen;			// ͵�����ٷֱ�
	int					m_CurrentDeadlyStrikeEnhanceP;			// ����һ���ٷֱ�
	int					m_CurrentFatallyStrikeEnhanceP;			// ����һ���ٷֱ�
	int					m_CurrentFatallyStrikeResP;
	int					m_CurrentFatallyStrikeLifeP;		// engine2:D3 enhance_fatallystrike_p (magic 295): + % of the 1/4 life
	int					m_CurrentExDefend;
	int					m_CurrentIgnoreDefensePercent;
	int					m_CurrentIgnoreExDefence;
	int					m_CurrentIgnoreFireResist;
	int					m_CurrentIgnoreColdResist;
	int					m_CurrentIgnoreLightResist;
	int					m_CurrentIgnoreEarthResist;
	int					m_CurrentColdDamageMinPercent;
	int					m_CurrentColdDamageMaxPercent;
	int					m_CurrentAllMagicDeadlyStrike;
	int					m_CurrentFireDeadlyStrike;
	int					m_CurrentColdDeadlyStrike;
	int					m_CurrentLightDeadlyStrike;
	int					m_CurrentEarthDeadlyStrike;
	int					m_CurrentReducePhysicsDeadlyStrike;
	int					m_CurrentReduceMagicDeadlyStrike;
	int					m_CurrentPiercePercent;			// ��͸�����ٷֱ�
	int					m_CurrentFreezeTimeReducePercent;	// ����ʱ����ٰٷֱ�
	int					m_CurrentPoisonTimeReducePercent;	// �ж�ʱ����ٰٷֱ�
	int					m_CurrentStunTimeReducePercent;		// ѣ��ʱ����ٰٷֱ�
	int			 		m_CurrentReturnSkillPercent;
	int					m_CurrentIgnoreSkillPercent;
	int 				m_CurrentPoisonDamageReturn;
	int 				m_CurrentPoisonDamageReturnPercent;
	KMagicAutoSkill 	m_ReplySkill[MAX_AUTOSKILL];
	KMagicAutoSkill 	m_RescueSkill[MAX_AUTOSKILL];
	KMagicAutoSkill 	m_AttackSkill[MAX_AUTOSKILL];
	KMagicAutoSkill 	m_DeathSkill[MAX_AUTOSKILL];
	int					m_CurrentIgnoreNegativeStateP;

	int					m_CurrentFireEnhance;			// ���ǿ
	int					m_CurrentColdEnhance;			// ����ǿ
	int					m_CurrentPoisonEnhance;			// ����ǿ
	int					m_CurrentLightEnhance;			// ���ǿ
	int					m_CurrentEarthEnhance;			// ˺ǿ
	int					m_CurrentAddPhysicsDamage;		// ֱӵ˺ǿ
	int					m_CurrentAddPhysicsMagic;		// Sat thuong vat ly noi cong
	int					m_CurrentMeleeEnhance[MAX_MELEE_WEAPON];	// ����������ǿ
	int					m_CurrentRangeEnhance;			// Զ��������ǿ
	int					m_CurrentHandEnhance;			// ����������ǿ
	int			 		m_CurrentManaShield;
	int			 		m_CurrentStaticMagicShieldP;
	int					m_CurrentLucky;
	int					m_CurrentExpEnhance;

	int					m_CurrentSkillEnhancePercent;
	int					m_CurrentFiveElementsEnhance;
	int					m_CurrentFiveElementsResist;
	int					m_CurrentManaToSkillEnhanceP;
// ֻ��Ҫ��ǰֵ�����ݽ���
	int					m_Dir;							// Npc�ķ���
	int					m_RedLum;						// Npc������
	int					m_GreenLum;
	int					m_BlueLum;
	int					m_MapX, m_MapY, m_MapZ;			// Npc�ĵ�ͼ����
	int					m_OffX, m_OffY;					// Npc�ڸ����е�ƫ�����꣨�Ŵ���1024����
	int					m_DesX, m_DesY;					// Npc��Ŀ������
	int					m_SkillParam1, m_SkillParam2;
	int					m_OriginX, m_OriginY;			// Npc��ԭʼ����
	int					m_NextAITime;
	BYTE				m_AIMAXTime;//NpcAI
// Npc��װ���������ͻ��˵Ļ�װ����
	PHONGTHAN_APPEARANCE	m_Appearance;
	BOOL				m_bRideHorse;				// Npc�Ƿ�����
	DWORD				m_dwNextSwitchHorseTime;
	int					m_MaskType;					// Npc ��߹���
	BOOL				m_bMaskFeature;				// Npc�Ƿ�����
	BYTE				m_nPKFlag;
	int					m_nMissionGroup;
	int					m_CurrentExpSkillsEnchance;//TamLTM ExpSkills x2
#ifndef _SERVER
	PLAYERTRADE			m_PTrade;					// Npc�Ƿ���װ��
	int					m_MarkMask;
	DWORD				m_dwTongNameID;
	char				m_szTongName[defTONG_NAME_LENGTH_32];
	char				m_szTongAgname[defTONG_NAME_LENGTH_32];
	int					m_nTongNationalEmblem;
	int					m_nFigure;
	int					m_nTeamServerID;
#endif
	char				Name[32];				// Npc������
	char				Owner[32];
	char				MateName[16];	
	int					m_nOwnerIdx;			// Npc������
	int					m_nPetIdx;			// Npc������
	int					m_nSex;					// Npc���Ա�0Ϊ�У�1ΪŮ
	int					m_NpcSettingIdx;		// Npc���趨�ļ�����
	int					m_CorpseSettingIdx;		// Npc��ʬ�嶨������
	char				ActionScript[MAX_NPC_SCRIPT_FILE_NAME];		// Per-instance/interaction script
	DWORD				m_ActionScriptID;		// Npc����Ϊ�ű�ID��ʹ��ʱ�������������
	DWORD				m_DeathScriptID;
	DWORD				m_TimerScriptID;
	DWORD				m_LevelScriptID;
	DWORD				m_DropScriptID;		// Npc����Ϊ�ű�ID��ʹ��ʱ�������������

	DWORD				m_TrapScriptID;			// Npc�ĵ�ǰTrap�ű�ID;

	int					m_nPeopleIdx;			// ��������
	int					m_nLastDamageIdx;		// ���һ���˺�����������
	int					m_nLastPoisonDamageIdx;	// ���һ�ζ��˺�����������
	int					m_nObjectIdx;			// ������Ʒ

	// Npc�Ļ������ݣ�δ����װ�������ܵ�Ӱ�죩
	int					m_Experience;			// Npc��ɱ��õľ���
	int					m_LifeMax;				// Npc���������
	int					m_LifeReplenish;		// Npc�������ظ��ٶ�
	int					m_ManaMax;				// Npc���������
	int					m_ManaReplenish;		// Npc�������ظ��ٶ�
	int					m_StaminaMax;			// Npc���������
	int					m_StaminaGain;			// Npc�������ظ��ٶ�
	int					m_StaminaLoss;			// Npc�������½��ٶ�
	int					m_AttackRating;			// Npc��������
	int					m_Defend;				// Npc�ķ���
	int					m_ExDefend;
	int					m_FireResist;			// Npc�Ļ���
	int					m_ColdResist;			// Npc���俹��
	int					m_PoisonResist;			// Npc�Ķ�����
	int					m_LightResist;			// Npc�ĵ翹��
	int					m_EarthResist;			// Npcĵ翹
	int					m_PhysicsResist;		// Npc
	int					m_FireResistMax;		// Npc
	int					m_ColdResistMax;		// Npc
	int					m_PoisonResistMax;		// Npc󶾿
	int					m_LightResistMax;		// Npc翹
	int					m_EarthResistMax;		// Npc翹
	int					m_PhysicsResistMax;		// Npc
	int					m_WalkSpeed;			// Npcٶ
	int					m_RunSpeed;				// Npcܶٶ
	int					m_JumpSpeed;			// NpcԾٶ
	int					m_AttackSpeed;			// NpcĹٶ
	int					m_CastSpeed;			// Npcʩٶ
	int					m_VisionRadius;			// NpcҰΧ
	int					m_DialogRadius;			// NpcĶԻΧ
	int					m_ActiveRadius;			// NpcĻΧ
	int					m_HitRecover;			// Npcܻظٶ
	BOOL				m_bClientOnly;			//

	int					m_nCurrentMeleeSkill;	// Npc��ǰ��ִ�еĸ񶷼���
	int					m_nCurrentMeleeTime;

	// AI����
	int					m_AiMode;				// AIģʽ
	int					m_AiParam[MAX_AI_PARAM];// ����AIģ�����AI
	int					m_AiAddLifeTime;

	int					m_HeadImage;

	int					m_FightMode;			// �ͻ��˴��������á�
	int					m_OldFightMode;
	BOOL				m_bExchangeServer;

	BOOL				m_bActivateAutoMoveBarrier1; //TamLTM Them check auto move barrier
	BOOL				m_bActivateAutoMoveBarrier2; //TamLTM Them check auto move barrier
	BOOL				m_bActivateAutoMoveBarrier3; //TamLTM Them check auto move barrier
	BOOL				m_bActivateAutoMoveBarrier4; //TamLTM Them check auto move barrier

	//TamLTM Them check auto
	bool				isCheckNotBarrierPlayer;
	bool				isCheckAutoRunPlayer;

	//pos
	int					m_nMovePosX;
	int					m_nMovePosY;
    int					m_PrevX, m_PrevY;
	//enc code

	int 				m_nRankInWorld;
	int 				m_nRepute;
	int 				m_nFuYuan;
	int 				m_nPKValue;
    void			    RunWalkStopCmd();

#ifdef _SERVER

	NPC_COMMAND         m_NowCommand;
	int					m_AiSkillRadiusLoadFlag;// ս��npc���ܷ�Χ�Ƿ��Ѿ���ʼ�� ֻ��Ҫ�ڹ����ʱ���ʼ��һ��
	KNpcDeathCalcExp	m_cDeathCalcExp;		// ս��npc�������ͳ��������ͬ��player
#endif
	int					m_nCurPKPunishState;	// PK����ʱ�ĳͷ����ʣ����ڹ�ս
	BOOL				m_bReviveNow;
#ifndef	_SERVER
//	int					m_nPeopleIdxCheckClient;
	int					m_SyncSignal;			// ͬ���ź�
	KClientNpcID		m_sClientNpcID;			// ���ڱ����ͻ���npc���ĸ�region�ĵڼ���npc
	DWORD				m_dwRegionID;			// ��npc����region��id
	char				m_szChatBuffer[MAX_SENTENCE_LENGTH];
	int					m_nChatContentLen;
	int					m_nChatNumLine;
	int					m_nChatFontWidth;
	unsigned int		m_nCurChatTime;
	int					m_nSleepFlag;
	int					m_nHurtHeight;
	int					m_nHurtDesX;
	int					m_nHurtDesY;
	BOOL				m_bIsPosEdition;
	BYTE				m_nPacePercent;
	BOOL				m_bTongFlag;			// �Ƿ�������ͼ��
	KSyncPos			m_sSyncPos; //TamLTM lag pos Npc
#endif
private:
	int					m_LoopFrames;			// ѭ��֡��
	int					m_nPlayerIdx;
	int					m_DeathFrame;			// ����֡��
	int					m_StandFrame;
	int					m_HurtFrame;
	int					m_AttackFrame;
	int					m_CastFrame;
	int					m_WalkFrame;
	int					m_RunFrame;
	int					m_StandFrame1;
	int					m_ReviveFrame;			// ����֡��
	int					m_SitFrame;
	int					m_JumpFrame;
	int					m_JumpFirstSpeed;
	NPC_COMMAND			m_Command;				// ����ṹ
	BOOL				m_ProcessAI;			// ����AI��־
	BOOL				m_ProcessState;			// ����״̬��־
	int					m_XFactor;
	int					m_YFactor;
	int					m_JumpStep;
	int					m_JumpDir;
	int					m_SpecialSkillStep;		// ���⼼�ܲ���
	NPC_COMMAND			m_SpecialSkillCommand;	// ���⼼����Ϊ����
	KNpcFindPath		m_PathFinder;
	BOOL				m_bActivateFlag;

#ifndef	_SERVER
	int					m_ResDir;
	KNpcRes				m_DataRes;				// Npc�Ŀͻ�����Դ��ͼ��������
	// ������ͨս��npcðѪ����
	BYTE				m_btCurBlood;
	int					m_nBlood[BLOOD_COUNT];
	char				m_szBlood[BLOOD_COUNT][16];

    //son fix loi ket map
    int					m_nBloodNo[MAX_FLOOD_SHOW];
    int					m_nBloodAlpha[MAX_FLOOD_SHOW];
    int					m_nBloodTime[MAX_FLOOD_SHOW];
    char				m_szBloodNo[MAX_FLOOD_SHOW][32];
#endif

private:
	BOOL				WaitForFrame();
	BOOL				IsReachFrame(int nPercent);
	void				DoStand();
	void				OnStand();
	void				DoRevive();
	void				OnRevive();
	void				DoWait();
	void				OnWait();
	void				DoWalk();
	void				OnWalk();
	void				DoRun();
	void				OnRun(int nAddSpeed = 0); //TamLTM fix auto xy map int nAddSpeed=0
	void				DoSkill(int nX, int nY);
	int					DoOrdinSkill(KSkill * pSkill, int nX, int nY);
	void				OnSkill();
	void				DoJump();
	BOOL				OnJump();
	void				DoSit();
	void				OnSit();
    void				DoHurt(int nHurtFrames = 0, int nX = 0, int nY =0,int nHurtI = 100);
	void				OnHurt();

	//TamLTM
	void				ActiveAutoMoveBarrier(int moveX, int moveY); //TamLTM Fix move toa do xy player.

	// mode == 0 npc ���� == 1 player ���£��������� == 2 player ���£�������
	// �� DeathPunish �Ĳ�����Ӧ ������� enumDEATH_MODE
	//void				DoDeath(int nMode = 0); //Son fix loi exp party
	void				DoDeath(int nMode = 0, int nAttacker = -1); // TamLTM fix exp

	void				OnDeath();
	void				DoDefense(); //Phong thu
	void				OnDefense();
	void				DoIdle();
	void				OnIdle();

//	�йظ񶷼��ܵ�------------------------------------------

	BOOL				DoBlurMove();
	void				OnBlurMove();

	BOOL				DoManyAttack();
	void				OnManyAttack();
	BOOL				DoBlurAttack();

	BOOL				DoJumpAttack();
	BOOL				OnJumpAttack();

	BOOL				DoRunAttack();
	void				OnRunAttack();

	BOOL				DoGoAttack(); //TamLTM fix auto xy map
	void				OnGoAttack(); //TamLTM fix auto xy map

	BOOL				CastMeleeSkill(KSkill * pSkill);

	void				DoSpecial1();
	void				OnSpecial1();
	void				DoSpecial2();
	void				OnSpecial2();
	void				DoSpecial3();
	void				OnSpecial3();
	void				Goto(int nMpsX, int nMpsY);
	void				RunTo(int nMpsX, int nMpsY);
	void				JumpTo(int nMpsX, int nMpsY);
	void				ServerMove(int nSpeed);
	void				ServerJump(int nSpeed);
	BOOL				NewPath(int nMpsX, int nMpsY);
	BOOL				NewJump(int nMpsX, int nMpsY);
	BOOL				CheckHitTarget(int nAR, int nDf, int nIngore = 0);
#ifdef _SERVER
	void				PlayerDeadCreateMoneyObj(int nMoneyNum);	// �������ʱ���������Ǯ����һ��object
public:	// KPlayer set-aura code (2026-09-29) refreshes the state info
	void				UpdateNpcStateInfo();		//���¸��½�ɫ��״̬��Ϣ
#endif

public:
	friend class KNpcAttribModify;
	friend class KThiefSkill;
	KNpc();
	void				SetActiveFlag(BOOL bFlag) { m_bActivateFlag = bFlag; };
	BOOL				CheckTrap(int nMapX, int nMapY);
	void				Init();
	void				Remove();
	void				Activate();
	BOOL				IsPlayer();
	void				SetFightMode(BOOL bFightMode);
	void				TurnTo(int nIdx);
	void				SendCommand(NPCCMD cmd, int x = 0, int y = 0, int z = 0);
	void				ProcCommand(int nAI);
	ISkill* 			GetActiveSkill();
	BOOL				ProcessState();
	void				ProcStatus();
	void				ModifyAttrib(int nAttacker, void* pData);
	void				SetId(DWORD	dwID)	{ m_dwID = dwID;};
	BOOL				IsMatch(DWORD dwID)	{ return dwID == m_dwID; };	// �Ƿ�ID���Indexƥ��
	BOOL				Cost(NPCATTRIB nType, int nCost, BOOL bIsAudit = FALSE, BOOL bNotShowMessage = FALSE);				// ��������������,���OnlyCheckCanCostΪTRUE,��ʾֻ�Ǽ�鵱ǰ���������Ƿ����ģ�����ʵ�ʵĿ�
	void				Load(int nNpcSettingIdx, int nLevel);						// ��TabFile�м���
	void				GetMpsPos(int * pPosX, int *pPosY);
	BOOL				SetActiveSkill(int nSkillIdx);
	void				SetAuraSkill(int nSkillID);
	void				SetSkillAppendAura(int nAppendNo, int nSkillID);
	void				SetCamp(int nCamp);
	void				SwitchMaskFeature();

	//TamLTM Fix move toa do xy player.
//	void				CheckMoveBarrier(BOOL Obstacle_LT /*12h*/, BOOL Obstacle_RT /*6h*/, BOOL Obstacle_LB /*9h*/, BOOL Obstacle_RB /*3h*/);
//	void				CheckMoveBarrier();
//	void				CheckTimerMoveBarrier();
	void				DoAutoMoveBarrier(int arrowMove);

	BOOL				GetCheckAutoMoveBarr(BOOL isCheck);
	void				MoveToBarrierPlayer(int nX, int nY, int isCheckMoveCalculator = 0);
	void				MiniMapXY(int nX, int nY);
	//end code

	//TamLTM show name pk
	void				ShowPKNamePlayer(char* m_nNamePK); //TamLTM Show ten va thong bao cua nhan vat dang cuu sat voi nhau
	//end code

#ifdef _SERVER
	void				SetTempCurrentCamp(int nCamp);
#endif
	void				SetCurrentCamp(int nCamp);
	void				ChangeCurrentCamp(int nCamp);
	void				RestoreCurrentCamp();
	void				SetRank(int nRank);
	void				SetExpandRank(KExpandRank* ExpandRank);
	void				SetStateSkillEffect(int nLauncher, int nSkillID, int nLevel, void *pData, int nDataNum, int nTime = -1, BOOL bOverLook = FALSE);	// �������������뱻������
	void				ClearStateSkillEffect();
	void				IgnoreState(BOOL bNegative);
	void				ReCalcStateEffect();
	void				ClearNormalState();
	BOOL				IsNpcStateExist(int nId);
	BOOL				IsNpcSkillExist(int nId);
	void				SetImmediatelySkillEffect(int nLauncher, void *pData, int nDataNum);
	void				AppendSkillEffect(int nSkillID, BOOL bIsPhysical, BOOL bIsMelee, void *pSrcData, void *pDesData);
	int					ModifyMissleLifeTime(int nLifeTime);
	int					ModifyMissleSpeed(int nSpeed);
	BOOL				ModifyMissleCollsion(BOOL bCollsion);
	void				RestoreNpcBaseInfo(); //Set Current_Data ;
	void				RestoreState();
	void				ClearNpcState();
	BOOL				SetPlayerIdx(int nIdx);
	void				DialogNpc(int nIndex);
	void				Revive();
	void				AddBaseLifeMax(int nLife);	// ���ӻ������������
	void				AddCurLifeMax(int nLife);
	void				AddBaseStaminaMax(int nStamina);// ���ӻ������������
	void				AddCurStaminaMax(int nStamina);
	void				AddBaseManaMax(int nMana);	// ���ӻ������������
	void				AddCurManaMax(int nMana);
	void				SetBaseLifeMax(int nLifeMax); // ���û������������
	void				SetBaseStaminaMax(int nStamina);
	void				SetBaseManaMax(int nMana);
	void				CalcCurLifeReplenish();		// ���㵱ǰ�����ظ��ٶ�
	void				CalcCurLucky();		// ���㵱ǰ�����ظ��ٶ�
	void				SetSeries(int nSeries);// �趨�� npc ���������ԣ����ݻ�û��ɣ�
	void				GetNpcCopyFromTemplate(int nNpcTemplateId);
	void				SetPhysicsDamage(int nMinDamage, int nMaxDamage);	// �趨���������������Сֵ
	void				SetReviveFrame(int nReviveFrame);
	void				SetBaseAttackRating(int nAttackRating);					// �趨����������
	void				SetBaseDefence(int nDefence);							// �趨������
	int					GetCurActiveWeaponSkill();
	void				LoadDataFromTemplate(int nNpcTemplateId);
	void				ResetNpcTypeName(int nMark);

	inline bool			IsAlive() const {return (m_Doing != do_death && m_Doing != do_revive);}
	int					GetMapX(void) const {	return m_MapX;	};
	int					GetMapY(void) const {	return m_MapY;	};
    void				Madnessto(int nMpsX, int nMpsY);
	int					GetMapZ(void) const {	return m_MapZ;	};
	int					GetOffX(void) const {	return m_OffX;	};
	int					GetOffY(void) const {	return m_OffY;	};
	inline int			GetSubWorldIndex() {return m_SubWorldIndex;}
	void				SwitchRideHorse(BOOL bRideHorse);
#ifdef	_SERVER
	int UpdateDBStateList(PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills);
	BOOL				CanSwitchRideHorse();
	void				ExecuteRevive(){DoRevive();};
	void BuildPhongThanPlayerSnapshot(PHONGTHAN_PLAYER_SNAPSHOT* snapshot, bool full);
	BOOL				SendSyncData(int nClient, BOOL bBroadCast = FALSE);						// ��һ���ͻ��˷�����ͬ������
	void				NormalSync();
    void				BroadCastState();							// �㲥Сͬ��
	void				BroadCastRevive(int nType);
	int					GetPlayerIdx();
	BOOL				CalcDamage(int nAttacker, int nMissleSeries, int nMin, int nMax, DAMAGE_TYPE nType, BOOL bIsMelee, BOOL bReturn = FALSE , int nSeries_DamageP = 0, int nStole_Life = 0, int nStole_Mana = 0, int nStole_Stamina = 0, BOOL bIsDS = FALSE, BOOL bIsFS = FALSE);
	void				ReplySkill();
	void				RescueSkill();
	void				AttackSkill(int nUnderAttacker);
	void				DeathSkill();
	BOOL				ReceiveDamage(int nLauncher, int nMissleSeries, BOOL bIsMelee, void *pData, BOOL bUseAR, int nDoHurtP, int nMissRate);
	void				Cast(int nSkillId, int nSkillLevel);
	// mode == 0 npc ���� == 1 player ���£��������� == 2 player ���£�������
	// �� DoDeath �Ĳ�����Ӧ ������� enumDEATH_MODE
	void				DeathPunish(int nMode, int nBelongPlayer);

	void				RestoreLiveData();								// ������ָ�Npc�Ļ�������
	int					SetPos(int nX, int nY); //TamLTM fix lag pos
	int					SetPosU(int nX, int nY); //TamLTM fix lag posU
	int					ChangeWorld(DWORD dwSubWorldID, int nX, int nY);	// �л�����
	void				TobeExchangeServer(DWORD dwMapID, int nX, int nY);
	void				RestoreLife(){m_CurrentLife = m_CurrentLifeMax;	};
	void				RestoreMana(){m_CurrentMana = m_CurrentManaMax;};
	void				RestoreStamina(){m_CurrentStamina = m_CurrentStaminaMax; };
	void				SendDataToNearRegion(void* pBuffer, DWORD dwSize);// ����Χ�����㲥
	int					DeathCalcPKValue(int nKiller);					// ����ʱ�����PKֵ
	int					FindAroundPlayer(const char* Name);// ������Χ9��Region���Ƿ���ָ���� player
#endif

//TamLTM fix add ham fix xy map
#ifndef _SERVER
	void				HurtAutoMove();
	void				AutoFixXY();
	int					m_nCheckAutoMoveBarrier;
	int					m_nMoveToFlagMiniMapX;
	int					m_nMoveToFlagMiniMapY;
#endif
//end code

#ifndef _SERVER
	void				SetSleepMode(BOOL bSleep) { m_nSleepFlag = bSleep; m_DataRes.SetSleepState(bSleep);};
	void				SetNpcState(BYTE* pNpcState);
	void				RemoveRes();
	void				ProcNetCommand(NPCCMD cmd, int x = 0, int y = 0, int z = 0);
	void				Paint();
	int					PaintInfo(int nHeightOffset, int nFontSize = 12, DWORD	dwBorderColor = 0);
	void				PaintPaceBar(int nPercent,int nPacePercent);// thanh process core
	void				PaintTop(int nHeightOffset, int nnHeightOffset, int nFontSize = 12, DWORD	dwBorderColor = 0);
	int					PaintChat(int nHeightOffset);
	int					SetChatInfo(const char* Name, const char* pMsgBuff, unsigned short nMsgLength);
	int					PaintLife(int nHeightOffset, bool bSelect);
	int					PaintFortuneRank(int nHeightOff, int nFontSize, int nMpsX, int nMpsY);
	int					PaintViprank(int nHeightOff, int nFontSize, int nMpsX, int nMpsY);
	int					PaintTranslife(int nHeightOff, int nFontSize, int nMpsX, int nMpsY);
	void				DrawBorder();
	int					DrawMenuState(int n);
	void				DrawBlood();	//����Ѫ���������ڹ̶�λ��
	BOOL				IsCanInput() { return m_ProcessAI; };
	void				SetMenuState(int nState, char *lpszSentence = NULL, int nLength = 0);	// �趨ͷ��״̬
	int					GetMenuState();				// ���ͷ��״̬
	DWORD				SearchAroundID(DWORD dwID);	// ������Χ9��Region���Ƿ���ָ�� ID �� npc
	void				SetSpecialSpr(char *lpszSprName);// �趨�����ֻ����һ�������spr�ļ�
	void				SetInstantSpr(int nNo);
	int					GetNormalNpcStandDir(int nFrame);
	KNpcRes*			GetNpcRes(){return &m_DataRes;};
	void				GetNpcResFile(int nNpcSettingIdx, char* pszResPath);
	void				KeyToImage(char*, int, KUiImage*);

	int GetNpcPate();
	int GetNpcPatePeopleInfo();

	// ðѪ����
	void				AddBlood(int nNo);
	int					PaintBlood(int nHeightOffset);	//����ðѪ

    // son fix loi ket map
    void				ClearBlood(int nid);
    void				SetBlood(int nNo);
#endif
};
#ifndef TOOLVERSION
extern KNpc Npc[MAX_NPC];
#else
extern CORE_API KNpc Npc[MAX_NPC];
#endif

#endif

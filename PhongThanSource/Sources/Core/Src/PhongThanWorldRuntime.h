#ifndef PHONGTHAN_WORLD_RUNTIME_H
#define PHONGTHAN_WORLD_RUNTIME_H
#include "PhongThanWorldProtocol.h"
#include "KNpc.h"
inline void PhongThanEncodeVisualPart(PHONGTHAN_VISUAL_PART_WIRE& wire,
	const PHONGTHAN_VISUAL_PART& part)
{
	wire.ResourceId = part.nResourceId;
	wire.PaletteId = part.nPaletteId;
	wire.Visible = part.bVisible ? 1 : 0;
}
inline void PhongThanDecodeVisualPart(PHONGTHAN_VISUAL_PART& part,
	const PHONGTHAN_VISUAL_PART_WIRE& wire)
{
	part.nResourceId = wire.ResourceId;
	part.nPaletteId = wire.PaletteId;
	part.bVisible = wire.Visible;
}
// Core actions are mapped explicitly; runtime enum ordinals are not wire values.
inline PHONGTHAN_U16 PhongThanEncodeEntityAction(NPCCMD action)
{
	switch (action)
	{
	case do_none: return PHONGTHAN_ACTION_NONE;
	case do_stand: return PHONGTHAN_ACTION_STAND;
	case do_walk: return PHONGTHAN_ACTION_WALK;
	case do_run: return PHONGTHAN_ACTION_RUN;
	case do_jump: return PHONGTHAN_ACTION_JUMP;
	case do_skill: return PHONGTHAN_ACTION_SKILL;
	case do_magic: return PHONGTHAN_ACTION_MAGIC;
	case do_attack: return PHONGTHAN_ACTION_ATTACK;
	case do_sit: return PHONGTHAN_ACTION_SIT;
	case do_hurt: return PHONGTHAN_ACTION_HURT;
	case do_death: return PHONGTHAN_ACTION_DEATH;
	case do_defense: return PHONGTHAN_ACTION_DEFENSE;
	case do_idle: return PHONGTHAN_ACTION_IDLE;
	case do_specialskill: return PHONGTHAN_ACTION_SPECIAL_SKILL;
	case do_special1: return PHONGTHAN_ACTION_SPECIAL1;
	case do_special2: return PHONGTHAN_ACTION_SPECIAL2;
	case do_special3: return PHONGTHAN_ACTION_SPECIAL3;
	case do_blurmove: return PHONGTHAN_ACTION_BLUR_MOVE;
	case do_runattack: return PHONGTHAN_ACTION_RUN_ATTACK;
	case do_manyattack: return PHONGTHAN_ACTION_MANY_ATTACK;
	case do_jumpattack: return PHONGTHAN_ACTION_JUMP_ATTACK;
	case do_revive: return PHONGTHAN_ACTION_REVIVE;
	case do_goattack: return PHONGTHAN_ACTION_GO_ATTACK;
	default: return PHONGTHAN_ACTION_NONE;
	}
}
inline NPCCMD PhongThanDecodeEntityAction(PHONGTHAN_U16 action)
{
	switch (action)
	{
	case PHONGTHAN_ACTION_NONE: return do_none;
	case PHONGTHAN_ACTION_STAND: return do_stand;
	case PHONGTHAN_ACTION_WALK: return do_walk;
	case PHONGTHAN_ACTION_RUN: return do_run;
	case PHONGTHAN_ACTION_JUMP: return do_jump;
	case PHONGTHAN_ACTION_SKILL: return do_skill;
	case PHONGTHAN_ACTION_MAGIC: return do_magic;
	case PHONGTHAN_ACTION_ATTACK: return do_attack;
	case PHONGTHAN_ACTION_SIT: return do_sit;
	case PHONGTHAN_ACTION_HURT: return do_hurt;
	case PHONGTHAN_ACTION_DEATH: return do_death;
	case PHONGTHAN_ACTION_DEFENSE: return do_defense;
	case PHONGTHAN_ACTION_IDLE: return do_idle;
	case PHONGTHAN_ACTION_SPECIAL_SKILL: return do_specialskill;
	case PHONGTHAN_ACTION_SPECIAL1: return do_special1;
	case PHONGTHAN_ACTION_SPECIAL2: return do_special2;
	case PHONGTHAN_ACTION_SPECIAL3: return do_special3;
	case PHONGTHAN_ACTION_BLUR_MOVE: return do_blurmove;
	case PHONGTHAN_ACTION_RUN_ATTACK: return do_runattack;
	case PHONGTHAN_ACTION_MANY_ATTACK: return do_manyattack;
	case PHONGTHAN_ACTION_JUMP_ATTACK: return do_jumpattack;
	case PHONGTHAN_ACTION_REVIVE: return do_revive;
	case PHONGTHAN_ACTION_GO_ATTACK: return do_goattack;
	default: return do_none;
	}
}
#endif

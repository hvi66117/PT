#ifndef PHONG_THAN_PARTY_BOT_H
#define PHONG_THAN_PARTY_BOT_H

// Phong Than 2026-10-03 botparty:P6 Lua natives of the bot party EXP bonus. Included by ScriptFuns.cpp inside
// the _SERVER section, after PhongThanLuaWave7.h (PhongThanIsLivePlayer). Storage and the bonus itself live in
// KNpcDeathCalcExp.cpp (KNpcDeathCalcExp::CalcExp, no-team branch).
//
//   SetPartyBotBonus(pct) -> 1 when stored for the current player (PlayerIndex), 0 otherwise.
//     pct = EXP bonus in percent (0..400) for the monsters this player kills alone; kept 3 minutes, so the
//     minute tick of script\phongthan\bots\party.lua refreshes it. The existence of this function is also the
//     Lua capability check ("if SetPartyBotBonus then ...").
//   GetPartyBotBonus() -> the bonus in percent that applies right now to the current player (0 = none/expired).
//
// Kills of the party bots themselves are already the player's kills: KNpc::CalcDamage books the damage of an
// owned AiMode-11 NPC on its owner (m_nOwnerIdx), so nothing else is credited here (no double count).

void	PhongThanSetPartyBotBonus(int nPlayerIdx, int nPct);
int		PhongThanPartyBotBonus(int nPlayerIdx);

int LuaSetPartyBotBonusCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPct = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nOk = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex))
	{
		PhongThanSetPartyBotBonus(nPlayerIndex, nPct);
		nOk = 1;
	}
	Lua_PushNumber(L, nOk);
	return 1;
}

int LuaGetPartyBotBonusCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nPct = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex))
		nPct = PhongThanPartyBotBonus(nPlayerIndex);
	Lua_PushNumber(L, nPct);
	return 1;
}

#endif // PHONG_THAN_PARTY_BOT_H

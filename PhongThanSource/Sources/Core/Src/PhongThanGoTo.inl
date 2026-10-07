// Phong Than 2026-10-04 timduong: "tim duong theo toa do" (go to coordinates), like VNG's auto path.
// docs\features\tim-duong-toa-do-phong-than-20261004.md
//
// Included ONCE, at the end of KPlayerAI.cpp after PhongThanAutoFight.inl, client build only. ASCII only;
// the player-visible strings are TCVN3 bytes written as escapes.
//
// Use: Alt+F (ShortcutKey.cpp, unless autoexec.lua binds the key) or a click on the coordinates of the mini
// map (UiMiniMap.cpp) opens an input box; "168/192", "168.192", "168 192" ... = the coordinates the mini map and
// the quest texts show (x = Mps / 256, y = Mps / 512). A trailing a / s / d turns the auto fight (Alt+A/S/D
// mode) on at arrival, "-" never; without it, an auto fight that was running when the trip started comes back.
// The UI passes the text with KCoreShell::PAIOperation(PTGO_GPI, PTGO_OP_TEXT, (int)text) -> PTGoTo_Operation.
//
// Path: the obstacle grid of the WHOLE current map, read from the same Region_C.dat files the scene loads
// (\Maps\<WorldSet.ini name>\v_<ry>\<rx>_Region_C.dat, PAK first), one region on first use, cached per map;
// weighted A* over 32 x 32 cells, then string pulling to straight free segments (PhongThanGoToPath.h).
//
// Walk: KPlayerAI::Active() -> PTGoTo_Tick() every frame, a decision at most every 100 ms. Each move is the
// same pair of calls as a click on the ground (Npc.SendCommand + SendClientCmdRun / SendClientCmdWalk), at
// most one every 400 ms and only for a new waypoint (or again after standing still 0.9 s), never farther than
// 640 Mps (inside the regions the client has loaded). Nothing is added to the protocol, nothing server-side.
// Stops: arrival (message), a click or drag in the game world (KPlayer::ProcessMouse -> PTGoTo_OnManualInput),
// Esc or Alt+F again (ShortcutKey.cpp), map change, death, a server dialog, trading, the auto fight being
// turned on, the old TamLTM mini-map auto run, stuck 4 x 3 s.
#ifndef _SERVER
#ifndef PHONGTHAN_GOTO_INL
#define PHONGTHAN_GOTO_INL

#include "PhongThanGoToPath.h"
#include "Scene/KScenePlaceC.h"

#ifndef MAPLIST_SETTING_FILE
#define MAPLIST_SETTING_FILE    "\\settings\\WorldSet.ini"
#endif
#ifndef PTAF_QUERY
#define PTAF_QUERY              0xFF
#endif

#define PTGO_GPI                0x5054474F  // 'PTGO', private PAIOperation code (ShortcutKey.cpp, UiMiniMap.cpp)
#define PTGO_OP_TEXT            1           // nParam = (const char*) "x/y[ a|s|d|-]" -> 1 started, 0 refused
#define PTGO_OP_CANCEL          2           // -> 1 when a trip was cancelled
#define PTGO_OP_QUERY           3           // -> 1 while a trip runs
#define PTGO_OP_GO              4           // nParam = x, nParam1 = y (display), default arrival mode

#define PTGO_THINK_MS           100
#define PTGO_MOVE_GAP_MS        400         // never two move requests closer than this (same pace as the auto fight)
#define PTGO_RESEND_MS          900         // standing still with a waypoint ahead: send it again after this
#define PTGO_SEG_MAX            640         // farthest point of one move request
#define PTGO_WP_REACH           40          // a waypoint closer than this is done
#define PTGO_ARRIVE             56          // arrived
#define PTGO_LOOKAHEAD          6           // waypoints checked for a straight shortcut
#define PTGO_STUCK_MS           3000        // no progress for this long -> plan again
#define PTGO_STUCK_DIST         24
#define PTGO_MAX_STUCK          4           // ... this many times in a row -> give up
#define PTGO_REPLAN_GAP_MS      1000        // off the planned line: plan again at most once a second
#define PTGO_MAX_EXPAND         900000
#define PTGO_MAX_PTS            512

// TCVN3 strings (generated from Unicode with the tcvn() table of S\ptfix\build_ptfix.py, S\timduong\gen_tcvn.py).
#define PTGO_S_START     "T\xd7m \xae\xad\xeang t\xedi (%d/%d)%s - b\xcam chu\xe9t ho\xc6""c Esc \xae\xd3 h\xf1y."   // Tim duong toi (%d/%d)%s - bam chuot hoac Esc de huy.
#define PTGO_S_FIGHT     ", t\xedi n\xaci t\xf9 \xae\xb8nh"   // , toi noi tu danh
#define PTGO_S_ARRIVE    "\xa7\xb7 t\xedi n\xaci (%d/%d)."   // Da toi noi (%d/%d).
#define PTGO_S_CANCEL    "\xa7\xb7 h\xf1y t\xd7m \xae\xad\xeang."   // Da huy tim duong.
#define PTGO_S_STOP      "D\xf5ng t\xd7m \xae\xad\xeang"   // Dung tim duong
#define PTGO_S_R_MAP     " - \xae\xb7 \xae\xe6i b\xb6n \xae\xe5."   //  - da doi ban do.
#define PTGO_S_R_DEATH   " - nh\xa9n v\xcbt b\xde tr\xe4ng th\xad\xacng."   //  - nhan vat bi trong thuong.
#define PTGO_S_R_DIALOG  " - \xae""ang m\xeb h\xe9i tho\xb9i."   //  - dang mo hoi thoai.
#define PTGO_S_R_TRADE   " - \xae""ang giao d\xde""ch."   //  - dang giao dich.
#define PTGO_S_R_STUCK   " - b\xde k\xd1t, kh\xabng \xaei ti\xd5p \xae\xad\xee""c."   //  - bi ket, khong di tiep duoc.
#define PTGO_S_NOPATH    "Kh\xabng t\xd7m \xae\xad\xee""c \xae\xad\xeang t\xedi (%d/%d)."   // Khong tim duoc duong toi (%d/%d).
#define PTGO_S_OUTSIDE   "T\xe4""a \xae\xe9 (%d/%d) n\xbbm ngo\xb5i b\xb6n \xae\xe5 n\xb5y."   // Toa do (%d/%d) nam ngoai ban do nay.
#define PTGO_S_GOAL      "T\xe4""a \xae\xe9 (%d/%d) n\xbbm trong v\xcbt c\xb6n."   // Toa do (%d/%d) nam trong vat can.
#define PTGO_S_NOMAP     "Kh\xabng \xae\xe4""c \xae\xad\xee""c d\xf7 li\xd6u b\xb6n \xae\xe5 \xae\xd3 t\xd7m \xae\xad\xeang."   // Khong doc duoc du lieu ban do de tim duong.
#define PTGO_S_BAD       "T\xe4""a \xae\xe9 kh\xabng h\xeep l\xd6. Nh\xcbp d\xb9ng 168/192 ho\xc6""c 168.192, th\xaam a \xae\xd3 t\xf9 \xae\xb8nh khi t\xedi n\xaci."   // Toa do khong hop le. Nhap dang 168/192 hoac 168.192, them a de tu danh khi toi noi.
#define PTGO_S_TRADE     "\xa7""ang giao d\xde""ch, kh\xabng th\xd3 t\xd7m \xae\xad\xeang."   // Dang giao dich, khong the tim duong.

static PTGP_Grid        s_PTGOGrid;                 // obstacle grid of s_nPTGOGridMap
static int              s_nPTGOGridMap = 0;
static char             s_szPTGOMapDir[200];        // \Maps\<name>
static int              s_bPTGOActive = 0;
static int              s_nPTGOWorldID = 0;
static int              s_nPTGOShowX = 0;           // destination, display coordinates
static int              s_nPTGOShowY = 0;
static int              s_nPTGODestX = 0;           // destination asked, Mps
static int              s_nPTGODestY = 0;
static int              s_nPTGOMode = 0;            // auto fight mode at arrival (0 none)
static int              s_aPTGOPts[PTGO_MAX_PTS * 2];
static int              s_nPTGOPts = 0;
static int              s_nPTGOIdx = 0;
static unsigned int     s_uPTGODialogToken = 0;
static DWORD            s_uPTGOLastThink = 0;
static DWORD            s_uPTGOLastMove = 0;
static DWORD            s_uPTGOLastPlan = 0;
static int              s_nPTGOSentX = -1;
static int              s_nPTGOSentY = -1;
static int              s_nPTGOSentIdx = -1;      // waypoint of the last request
static DWORD            s_uPTGOProgressAt = 0;
static int              s_nPTGOProgressX = 0;
static int              s_nPTGOProgressY = 0;
static int              s_nPTGOStuck = 0;

static void PTGO_Say(const char* sz, BOOL bTop)
{
	KSystemMessage sMsg;
	memset(&sMsg, 0, sizeof(sMsg));
	_snprintf(sMsg.szMessage, sizeof(sMsg.szMessage) - 1, "%s", sz ? sz : "");
	sMsg.szMessage[sizeof(sMsg.szMessage) - 1] = 0;
	sMsg.eType = SMT_NORMAL;
	sMsg.byConfirmType = SMCT_NONE;
	sMsg.byPriority = 0;
	sMsg.byParamSize = 0;
	CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
	if (bTop)
		CoreDataChanged(GDCNI_TOP_MESSAGE, (unsigned int)sMsg.szMessage, (int)strlen(sMsg.szMessage));
}

static void PTGO_SayXY(const char* szFormat, int x, int y, BOOL bTop)
{
	char sz[256];
	_snprintf(sz, sizeof(sz) - 1, szFormat, x, y);
	sz[sizeof(sz) - 1] = 0;
	PTGO_Say(sz, bTop);
}

static int PTGO_Me()
{
	int n = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	return (n > 0 && n < MAX_NPC) ? n : 0;
}

static double PTGO_D2(int x1, int y1, int x2, int y2)
{
	double dx = (double)(x1 - x2);
	double dy = (double)(y1 - y2);
	return dx * dx + dy * dy;
}

// Region loader of the grid: the files KScenePlaceRegionC::Load reads (combined file, else the old layout).
static int PTGO_LoadRegion(void* pCtx, int nRegionX, int nRegionY, unsigned char* pOut)
{
	const char* szDir = (const char*)pCtx;
	char szPath[260];
	KPakFile File;
	_snprintf(szPath, sizeof(szPath) - 1, "%s\\v_%03d\\%03d_Region_C.dat", szDir, nRegionY, nRegionX);
	szPath[sizeof(szPath) - 1] = 0;
	if (File.Open(szPath))
	{
		DWORD uSize = File.Size();
		unsigned char* p = (uSize >= 4 && uSize <= 0x400000) ? (unsigned char*)malloc(uSize) : NULL;
		if (p && File.Read(p, uSize) == uSize)
			PTGP_DecodeRegion(p, uSize, pOut);
		else
			PTGP_DecodeRegion(NULL, 0, pOut);
		if (p)
			free(p);
		File.Close();
		return 1;
	}
	_snprintf(szPath, sizeof(szPath) - 1, "%s\\v_%03d\\%03d_OBSTACLE.DAT", szDir, nRegionY, nRegionX);
	szPath[sizeof(szPath) - 1] = 0;
	if (!File.Open(szPath))
		return 0;       // no region here: blocked
	{
		unsigned char aObst[PTGP_RCX * PTGP_RCY * 4];
		DWORD uRead = File.Read(aObst, sizeof(aObst));
		File.Close();
		PTGP_DecodeObstacle(aObst, uRead, pOut);
	}
	_snprintf(szPath, sizeof(szPath) - 1, "%s\\v_%03d\\%03d_Trap.dat", szDir, nRegionY, nRegionX);
	szPath[sizeof(szPath) - 1] = 0;
	if (File.Open(szPath))
	{
		DWORD uSize = File.Size();
		unsigned char* p = (uSize >= 12 && uSize <= 0x100000) ? (unsigned char*)malloc(uSize) : NULL;
		if (p && File.Read(p, uSize) == uSize)
			PTGP_DecodeTraps(p, uSize, pOut);
		if (p)
			free(p);
		File.Close();
	}
	return 1;
}

// Grid of the current map: folder from WorldSet.ini [List] (as KScenePlaceC::OpenPlace), region rectangle from
// the map's .wor [MAIN] rect (else 24 regions around the player).
static BOOL PTGO_PrepareMap(int nMe)
{
	int nMap = SubWorld[0].m_SubWorldID;
	if (s_nPTGOGridMap == nMap && s_PTGOGrid.pCell)
		return TRUE;
	PTGP_GridFree(&s_PTGOGrid);
	s_nPTGOGridMap = 0;

	KIniFile Ini;
	char szKey[16], szName[160], szWor[260];
	if (!Ini.Load(MAPLIST_SETTING_FILE))
		return FALSE;
	sprintf(szKey, "%d", nMap);
	szName[0] = 0;
	if (!Ini.GetString("List", szKey, "", szName, sizeof(szName)) || szName[0] == 0)
		return FALSE;
	_snprintf(s_szPTGOMapDir, sizeof(s_szPTGOMapDir) - 1, "\\Maps\\%s", szName);
	s_szPTGOMapDir[sizeof(s_szPTGOMapDir) - 1] = 0;

	RECT rc;
	rc.left = rc.top = rc.right = rc.bottom = -1;
	_snprintf(szWor, sizeof(szWor) - 1, "%s.wor", s_szPTGOMapDir);
	szWor[sizeof(szWor) - 1] = 0;
	KIniFile Wor;
	if (Wor.Load(szWor))
		Wor.GetRect("MAIN", "rect", &rc);
	if (rc.left < 0 || rc.top < 0 || rc.right < rc.left || rc.bottom < rc.top ||
		rc.right - rc.left >= 256 || rc.bottom - rc.top >= 256)
	{
		int x, y;
		Npc[nMe].GetMpsPos(&x, &y);
		rc.left = x / (PTGP_RCX * PTGP_CELL) - 24;
		rc.top = y / (PTGP_RCY * PTGP_CELL) - 24;
		rc.right = x / (PTGP_RCX * PTGP_CELL) + 24;
		rc.bottom = y / (PTGP_RCY * PTGP_CELL) + 24;
		if (rc.left < 0)
			rc.left = 0;
		if (rc.top < 0)
			rc.top = 0;
	}
	if (!PTGP_GridInit(&s_PTGOGrid, rc.left, rc.top, rc.right, rc.bottom, PTGO_LoadRegion, s_szPTGOMapDir))
		return FALSE;
	s_nPTGOGridMap = nMap;
	return TRUE;
}

// Path from the player to the destination into s_aPTGOPts. Returns the PTGP_FindPath code.
static int PTGO_Plan(int nMe, DWORD uNow)
{
	int sx, sy, nExpanded = 0, n;
	Npc[nMe].GetMpsPos(&sx, &sy);
	n = PTGP_FindPath(&s_PTGOGrid, sx, sy, s_nPTGODestX, s_nPTGODestY, PTGO_MAX_EXPAND,
		s_aPTGOPts, PTGO_MAX_PTS, &nExpanded);
	s_uPTGOLastPlan = uNow ? uNow : 1;
	if (n > 0)
	{
		s_nPTGOPts = n;
		s_nPTGOIdx = 0;
		s_nPTGOSentX = s_nPTGOSentY = -1;
		s_nPTGOSentIdx = -1;
	}
	return n;
}

// Same gate as a mouse click: the player NPC accepts input and is not in the middle of an action.
static BOOL PTGO_Ready(int nMe)
{
	KNpc& me = Npc[nMe];
	if (!me.IsCanInput())
		return FALSE;
	switch (me.m_Doing)
	{
	case do_none:
	case do_stand:
	case do_walk:
	case do_run:
	case do_sit:
	case do_idle:
		return TRUE;
	default:
		return FALSE;
	}
}

static void PTGO_Stop(const char* szReason)
{
	if (!s_bPTGOActive)
		return;
	s_bPTGOActive = 0;
	s_nPTGOPts = 0;
	g_ScenePlace.DirectFindPos(0, 0, FALSE, FALSE);     // mini map target line off (bPaintMode = false)
	if (szReason)
	{
		char sz[256];
		_snprintf(sz, sizeof(sz) - 1, "%s%s", PTGO_S_STOP, szReason);
		sz[sizeof(sz) - 1] = 0;
		PTGO_Say(sz, TRUE);
	}
}

static int PTGO_Start(int nShowX, int nShowY, int nMode)
{
	int nMe = PTGO_Me();
	if (!nMe || SubWorld[0].m_SubWorldID <= 0)
		return 0;
	KNpc& me = Npc[nMe];
	KPlayer& pl = Player[CLIENT_PLAYER_INDEX];
	if (me.m_Doing == do_death || me.m_Doing == do_revive || me.m_CurrentLife <= 0)
		return 0;
	if (pl.CheckTrading())
	{
		PTGO_Say(PTGO_S_TRADE, TRUE);
		return 0;
	}
	if (!PTGO_PrepareMap(nMe))
	{
		PTGO_Say(PTGO_S_NOMAP, TRUE);
		return 0;
	}
	if (s_bPTGOActive)
		PTGO_Stop(NULL);
	DWORD uNow = IR_GetCurrentTime();
	s_nPTGODestX = nShowX * PTGP_UNIT_X + PTGP_UNIT_X / 2;
	s_nPTGODestY = nShowY * PTGP_UNIT_Y + PTGP_UNIT_Y / 2;
	int n = PTGO_Plan(nMe, uNow);
	if (n <= 0)
	{
		if (n == PTGP_ERR_OUTSIDE)
			PTGO_SayXY(PTGO_S_OUTSIDE, nShowX, nShowY, TRUE);
		else if (n == PTGP_ERR_GOAL)
			PTGO_SayXY(PTGO_S_GOAL, nShowX, nShowY, TRUE);
		else
			PTGO_SayXY(PTGO_S_NOPATH, nShowX, nShowY, TRUE);
		return 0;
	}

	// One driver at a time: the auto fight, the old TamLTM auto play / mini-map auto run, a click-follow target.
	int nFight = PTAutoFight_Operation(PTAF_QUERY, 0, 0);
	if (nFight)
		PTAutoFight_Operation(0, 0, 0);
	if (nMode < 0)
		nMode = nFight;     // fighting when the trip started: fight again at arrival
	pl.m_cAI.m_bIsActive = FALSE;
	pl.m_cAI.m_bAutoRunMap = FALSE;
	pl.m_cAI.m_bAutoRunFlagMap = FALSE;
	me.m_nPeopleIdx = 0;

	s_bPTGOActive = 1;
	s_nPTGOWorldID = SubWorld[0].m_SubWorldID;
	s_nPTGOShowX = nShowX;
	s_nPTGOShowY = nShowY;
	s_nPTGOMode = (nMode >= 1 && nMode <= 3) ? nMode : 0;
	s_uPTGODialogToken = pl.m_UiDialogToken;
	s_uPTGOLastThink = 0;
	s_uPTGOLastMove = 0;
	s_uPTGOProgressAt = uNow;
	me.GetMpsPos(&s_nPTGOProgressX, &s_nPTGOProgressY);
	s_nPTGOStuck = 0;

	// target line on the mini map, as the old coordinate box did (KScenePlaceMapC::DirectFindPos, bSync FALSE)
	g_ScenePlace.bFlagMode = false;
	g_ScenePlace.bPaintMode = true;
	g_ScenePlace.DirectFindPos(nShowX, nShowY, FALSE, TRUE);

	char sz[256];
	_snprintf(sz, sizeof(sz) - 1, PTGO_S_START, nShowX, nShowY, s_nPTGOMode ? PTGO_S_FIGHT : "");
	sz[sizeof(sz) - 1] = 0;
	PTGO_Say(sz, TRUE);
	return 1;
}

static void PTGO_Arrive()
{
	int nMode = s_nPTGOMode;
	PTGO_Stop(NULL);
	PTGO_SayXY(PTGO_S_ARRIVE, s_nPTGOShowX, s_nPTGOShowY, TRUE);
	if (nMode >= 1 && nMode <= 3 && PTAutoFight_Operation(PTAF_QUERY, 0, 0) != nMode)
		PTAutoFight_Operation(nMode, 0, 0);
}

// Same calls as a click on the ground (KPlayer::ProcessMouse), rate limited.
static void PTGO_Send(int nMe, int x, int y, DWORD uNow)
{
	KPlayer& pl = Player[CLIENT_PLAYER_INDEX];
	if (pl.m_RunStatus)
	{
		Npc[nMe].SendCommand(do_run, x, y);
		SendClientCmdRun(x, y);
	}
	else
	{
		Npc[nMe].SendCommand(do_walk, x, y);
		SendClientCmdWalk(x, y);
	}
	pl.m_nSendMoveFrames = 0;
	s_uPTGOLastMove = uNow ? uNow : 1;
	s_nPTGOSentX = x;
	s_nPTGOSentY = y;
}

// UI entry (KCoreShell::PAIOperation, code PTGO_GPI).
int PTGoTo_Operation(unsigned int uOp, int nParam, int nParam1)
{
	int x, y, nMode;
	switch (uOp)
	{
	case PTGO_OP_TEXT:
		if (!PTGP_ParseCoord((const char*)nParam, &x, &y, &nMode))
		{
			PTGO_Say(PTGO_S_BAD, TRUE);
			return 0;
		}
		return PTGO_Start(x, y, nMode);
	case PTGO_OP_GO:
		return PTGO_Start(nParam, nParam1, -1);
	case PTGO_OP_CANCEL:
		if (!s_bPTGOActive)
			return 0;
		PTGO_Stop(NULL);
		PTGO_Say(PTGO_S_CANCEL, TRUE);
		return 1;
	case PTGO_OP_QUERY:
		return s_bPTGOActive;
	}
	return 0;
}

// A manual click or drag in the game world: the player takes over.
void PTGoTo_OnManualInput()
{
	if (!s_bPTGOActive)
		return;
	PTGO_Stop(NULL);
	PTGO_Say(PTGO_S_CANCEL, FALSE);
}

void PTGoTo_Tick()
{
	if (!s_bPTGOActive)
		return;
	int nMe = PTGO_Me();
	if (!nMe)
	{
		PTGO_Stop(NULL);    // loading a map, logging out
		return;
	}
	KPlayer& pl = Player[CLIENT_PLAYER_INDEX];
	KNpc& me = Npc[nMe];
	if (SubWorld[0].m_SubWorldID != s_nPTGOWorldID)
	{
		PTGO_Stop(PTGO_S_R_MAP);
		return;
	}
	if (me.m_Doing == do_death || me.m_Doing == do_revive || me.m_CurrentLife <= 0)
	{
		PTGO_Stop(PTGO_S_R_DEATH);
		return;
	}
	if (pl.m_UiDialogToken != s_uPTGODialogToken)
	{
		s_uPTGODialogToken = pl.m_UiDialogToken;
		if (s_uPTGODialogToken)
		{
			PTGO_Stop(PTGO_S_R_DIALOG);
			return;
		}
	}
	if (pl.CheckTrading())
	{
		PTGO_Stop(PTGO_S_R_TRADE);
		return;
	}
	if (PTAutoFight_Operation(PTAF_QUERY, 0, 0) || pl.m_cAI.m_bAutoRunMap || pl.m_cAI.m_bAutoRunFlagMap)
	{
		PTGO_Stop(NULL);    // the player chose another driver (Alt+A/S/D, mini map flag)
		PTGO_Say(PTGO_S_CANCEL, FALSE);
		return;
	}
	DWORD uNow = IR_GetCurrentTime();
	if (uNow - s_uPTGOLastThink < PTGO_THINK_MS)
		return;
	s_uPTGOLastThink = uNow;

	int x, y, i;
	me.GetMpsPos(&x, &y);
	int nEndX = s_aPTGOPts[(s_nPTGOPts - 1) * 2], nEndY = s_aPTGOPts[(s_nPTGOPts - 1) * 2 + 1];
	if (PTGO_D2(x, y, nEndX, nEndY) <= (double)PTGO_ARRIVE * PTGO_ARRIVE)
	{
		if (s_nPTGOPts < PTGO_MAX_PTS)
		{
			PTGO_Arrive();
			return;
		}
		PTGO_Plan(nMe, uNow);   // the route was longer than PTGO_MAX_PTS points: the next part
		return;
	}

	// progress / stuck
	if (!PTGO_Ready(nMe))
	{
		s_uPTGOProgressAt = uNow;   // an action (hit, skill ...) is not "stuck"
		return;
	}
	if (PTGO_D2(x, y, s_nPTGOProgressX, s_nPTGOProgressY) > (double)PTGO_STUCK_DIST * PTGO_STUCK_DIST)
	{
		s_nPTGOProgressX = x;
		s_nPTGOProgressY = y;
		s_uPTGOProgressAt = uNow;
		s_nPTGOStuck = 0;
	}
	else if (uNow - s_uPTGOProgressAt > PTGO_STUCK_MS)
	{
		s_uPTGOProgressAt = uNow;
		if (++s_nPTGOStuck > PTGO_MAX_STUCK || PTGO_Plan(nMe, uNow) <= 0)
		{
			PTGO_Stop(PTGO_S_R_STUCK);
			return;
		}
		s_uPTGOLastMove = 0;    // send the new route at once
	}

	// waypoints reached, then a straight shortcut to a later one
	while (s_nPTGOIdx < s_nPTGOPts - 1 &&
		PTGO_D2(x, y, s_aPTGOPts[s_nPTGOIdx * 2], s_aPTGOPts[s_nPTGOIdx * 2 + 1]) <= (double)PTGO_WP_REACH * PTGO_WP_REACH)
		s_nPTGOIdx++;
	for (i = s_nPTGOIdx + PTGO_LOOKAHEAD; i > s_nPTGOIdx; i--)
	{
		if (i >= s_nPTGOPts)
			continue;
		if (PTGP_LineFree(&s_PTGOGrid, x, y, s_aPTGOPts[i * 2], s_aPTGOPts[i * 2 + 1]))
		{
			s_nPTGOIdx = i;
			break;
		}
	}
	int tx = s_aPTGOPts[s_nPTGOIdx * 2], ty = s_aPTGOPts[s_nPTGOIdx * 2 + 1];
	double d2 = PTGO_D2(x, y, tx, ty);
	if (d2 > 64.0 * 64.0 && !PTGP_LineFree(&s_PTGOGrid, x, y, tx, ty) && uNow - s_uPTGOLastPlan >= PTGO_REPLAN_GAP_MS)
	{
		// pushed off the planned line (a monster, the engine's own detour): plan again from here
		if (PTGO_Plan(nMe, uNow) <= 0)
		{
			PTGO_Stop(PTGO_S_R_STUCK);
			return;
		}
		tx = s_aPTGOPts[0];
		ty = s_aPTGOPts[1];
		d2 = PTGO_D2(x, y, tx, ty);
	}
	if (d2 > (double)PTGO_SEG_MAX * PTGO_SEG_MAX)
	{
		double k = PTGO_SEG_MAX / sqrt(d2);
		tx = x + (int)((tx - x) * k);
		ty = y + (int)((ty - y) * k);
	}

	// send like a click: one request per PTGO_MOVE_GAP_MS at most, only when something changed
	if (pl.m_nSendMoveFrames < defMAX_PLAYER_SEND_MOVE_FRAME)
		return;
	if (uNow - s_uPTGOLastMove < PTGO_MOVE_GAP_MS)
		return;
	if (s_nPTGOIdx == s_nPTGOSentIdx && s_nPTGOSentX >= 0)
	{
		BOOL bMoving = (me.m_Doing == do_run || me.m_Doing == do_walk);
		BOOL bSame = PTGO_D2(tx, ty, s_nPTGOSentX, s_nPTGOSentY) < 24.0 * 24.0;
		BOOL bFar = PTGO_D2(tx, ty, s_nPTGOSentX, s_nPTGOSentY) >= 160.0 * 160.0;   // the clipped point moved on
		if (bMoving && (bSame || !bFar))
			return;     // on the way
		if (!bMoving && bSame && uNow - s_uPTGOLastMove < PTGO_RESEND_MS)
			return;     // standing still: the same request again only after PTGO_RESEND_MS
	}
	PTGO_Send(nMe, tx, ty, uNow);
	s_nPTGOSentIdx = s_nPTGOIdx;
}

#endif // PHONGTHAN_GOTO_INL
#endif // _SERVER

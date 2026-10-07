// Phong Than 2026-10-03 partypanel: data shared by CoreClient (PhongThanPartyPanel.inl) and Game.exe
// (GameClient\Ui\UiCase\UiPartyPanel.cpp) for the VNG-style team list on the right side of the screen.
//
// Game.exe asks CoreClient through the existing iCoreShell::PAIOperation entry with a private code, the same
// way autofight does ('PTAF'), so the iCoreShell interface and the GDI_/GPI_ enums stay unchanged:
//     KPTPartyInfo Info; Info.nSize = sizeof(Info);
//     g_pCoreShell->PAIOperation(PTPP_GPI_QUERY, (unsigned int)&Info, sizeof(Info), 0);
// The call fills Info and returns Info.nCount (rows). Client build only; nothing is sent to the server.
// ASCII only.
#ifndef PHONGTHAN_PARTYPANEL_H
#define PHONGTHAN_PARTYPANEL_H

#define PTPP_GPI_QUERY          0x50545050  // 'PTPP'
#define PTPP_MAX_MEMBER         8           // VNG team: captain + 7 members (MAX_TEAM_MEMBER = 7)
#define PTPP_NAME_LEN           32

// KPTPartyInfo::nMode
#define PTPP_MODE_NONE          0           // no team, no bot companion near the player
#define PTPP_MODE_BOT           1           // bot party (docs\features\to-doi-bot-phong-than-20261003.md)
#define PTPP_MODE_TEAM          2           // real team (KTeam g_Team[0])

// KPTPartyMember::nFlags
#define PTPP_F_SELF             0x01        // the local player
#define PTPP_F_CAPTAIN          0x02        // team captain (VNG CaptainNameColor + flag)
#define PTPP_F_BOT              0x04        // a "[To doi]" bot companion
#define PTPP_F_DEAD             0x08        // dead (VNG skeleton icon)
#define PTPP_F_FAR              0x10        // not in view: no life data (real team member far away)

// KPTPartyMember::nProfession: 0 Giap Si (jiashi), 1 Thuat Si (daoshi), 2 Di Nhan (yiren), -1 unknown.

struct KPTPartyMember
{
	char			szName[PTPP_NAME_LEN];	// TCVN3, zero terminated, "[To doi] " prefix removed
	int				nLevel;					// 0 = unknown
	int				nLifePercent;			// 0..100, -1 = unknown
	int				nProfession;
	unsigned int	uNpcID;					// client Npc m_dwID (0 = not in view)
	int				nFlags;					// PTPP_F_*
};

struct KPTPartyInfo
{
	int				nSize;					// caller sets sizeof(KPTPartyInfo)
	int				nMode;					// PTPP_MODE_*
	int				nBots;					// bot companions found
	int				nCount;					// rows in aMember
	KPTPartyMember	aMember[PTPP_MAX_MEMBER];
};

#endif // PHONGTHAN_PARTYPANEL_H

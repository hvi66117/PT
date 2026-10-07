require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

function OnDeath(npcidx)

    WorldBossDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> §· th¶ ra hån ph¸ch mét trong thËp nhÞ b¸t tó--<color=yel>N÷ Thæ Bøc<color>, thÇn lùc thËt ®¸ng sî!")

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>N÷ Thæ Bøc<c>: ThÕ lùc nh©n giíi kh«ng thÓ xem th­êng, xem ra ngµy s­ t«n <c=yel>Th¸i Vi Viªn-Sø Linh-H­<c> xuÊt s¬n kh«ng cßn xa, chØ cã Tinh Quan ë TriÒu Ca míi biÕt ®­îc thiªn c¬ nµy.")

    DelNpc(npcidx)
end


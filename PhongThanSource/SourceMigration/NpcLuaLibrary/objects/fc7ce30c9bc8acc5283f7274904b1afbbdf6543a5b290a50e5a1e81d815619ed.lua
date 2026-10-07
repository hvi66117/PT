require("Ä§¼ÒËÄ½«BOSS.luax")
WorldBossDeath = FOURBOSS.WorldBossDeath
CallBossTable = FOURBOSS.CallBossTable

function OnDeath(npcidx)

    WorldBossDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> §· th¶ ra hån ph¸ch mét trong thËp nhÞ b¸t tó--<color=yel>TÜnh Méc Ng¹n<color>, thÇn lùc thËt ®¸ng sî!")

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>TÜnh Méc Ng¹n<c>: Nh©n qu¶ lu©n håi, linh hån ta bÊt diÖt.")

    DelNpc(npcidx)
end


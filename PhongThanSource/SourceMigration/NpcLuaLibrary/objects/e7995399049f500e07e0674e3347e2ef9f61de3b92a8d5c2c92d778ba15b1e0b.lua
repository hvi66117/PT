function OnDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> §· th¶ ra hån ph¸ch mét trong thËp nhŞ b¸t tó--<color=yel>§Ó Thæ H¹c<color>, thÇn lùc thËt ®¸ng sî!") -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı 

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>§Ó Thæ H¹c<c>: Nh©n qu¶ lu©n håi, linh hån ta bÊt diÖt.")

    DelNpc(npcidx)
end


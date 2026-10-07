function OnDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> §· th¶ ra hån ph¸ch mét trong thËp nhŞ b¸t tó--<color=yel>T©m NguyÖt Hå<color>, thÇn lùc thËt ®¸ng sî!") -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı 

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>T©m NguyÖt Hå<c>: ThÕ lùc nh©n giíi kh«ng thÓ xem th­êng, xem ra ngµy s­ t«n <c=yel>Thiªn ThŞ Viªn-Sø Linh-Ph¸<c> xuÊt s¬n kh«ng cßn xa, chØ cã Tinh Quan ë TriÒu Ca míi biÕt ®­îc thiªn c¬ nµy.")

    DelNpc(npcidx)
end


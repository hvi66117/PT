function OnDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> ®· ®¸nh b¹i <color=yel>Thiªn ThŞ Viªn-Sø Linh-Ph¸<color>, thËt lµ c«ng ®øc v« l­îng.") -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı 

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>Thiªn ThŞ Viªn-Sø Linh-Ph¸<c>:  H«m nay ta cam chŞu b¹i d­íi tay c¸c ng­¬i! Nh­ng ahy nhí: Ta sÏ cßn quay l¹i b¸o thï!")

    DelNpc(npcidx)
end


function OnDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> ®· ®¸nh b¹i <color=yel>Th¸i Vi Viªn-Sø Linh-H­<color>, thËt lµ c«ng ®øc v« l­îng.")

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>Th¸i Vi Viªn-Sø Linh-H­<c>: Hìi Phong Háa L«i §Þa, xin ban thªm cho ta søc m¹nh!")

    DelNpc(npcidx)
end


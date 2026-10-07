function OnDeath(npcidx)

    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> ®· ®¸nh b¹i <color=yel>Tö Vi Viªn-Sø Linh-Kh«ng<color>, thËt lµ c«ng ®øc v« l­îng.")

    local mapid, x, y = GetWorldPos()
    PlayerIndex = NpcIdx2PIdx(npcindex)
    Msg2CurMapAnnounceEx(mapid, "<c=yel>Tö Vi Viªn-Sø Linh-Kh«ng<c>:  LÏ nµo ®©y lµ sè m¹ng cña ta?! Ta thËt kh«ng cam lßng...")

    DelNpc(npcidx)
end


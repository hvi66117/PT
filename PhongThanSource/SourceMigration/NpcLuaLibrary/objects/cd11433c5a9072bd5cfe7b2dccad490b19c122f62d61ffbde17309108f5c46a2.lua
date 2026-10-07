function OnDeath(npcidx)
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    local playername = GetName()
    if (GetTongName() == CityTongName) then
        Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> gi¶i tho¸t thµnh c«ng hån ph¸ch cña Thñ hé ThÇn thó, thËt lµ c«ng ®øc v« l­îng.</bc>")
        local OldPlayerIndex = PlayerIndex

        local p = GetFirstPlayerInAll()
        while (p > 0) do
            PlayerIndex = p
            if (IsPlayerInDeath() == 0) and (GetTongName() == CityTongName) and (IsOwnerCity() == 1) and (HaveIBBuff(1010) == 1) then
                local w1, x1, y1 = GetWorldPos()
                local w2, x, y = GetNpcWorldPos(npcidx)
                rv = (x - x1) ^ 2 + (y - y1) ^ 2
                if (rv <= 800) then
                    RemoveIBBuff(1010)
                    AddIBBuff(1089)
                    Msg2Player("NhËn ®­îc Thñ Hé Nguyªn Linh-Háa, cã thÓ vÒ Phong ThÇn ®µi gÆp B¸ Gi¸m nhËn th­ëng.")
                end
            end

            p = GetNextPlayerInAll()
        end

        PlayerIndex = OldPlayerIndex
    else
        local nTongID = GetTongIDByName(CityTongName)
        Msg2TongMemberByTongName(CityTongName, "Thñ hé ThÇn thó bÞ " .. GetTongName() .. "L·nh ®Þa-" .. GetName() .. "´ò°Ü, ¿ÉÏ§Î´ÄÜÖúÆä¶É½Ù³É¹¦")
        Msg2TongMemberByTongName(GetTongName(), GetName() .. "Thµnh c«ng ®¸nh b¹i " .. CityTongName .. "¹úµÄÊØ»¤ÉñÊÞ´ò°Ü.")
    end
    DelNpc(npcidx)
end;
   

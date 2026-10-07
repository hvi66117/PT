--description: ÌôÕ½ÊÞ
--author: xiaolei
--date: 2009/10/23

function OnDeath(npcidx)
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    local playername = GetName()
    if (GetTongName() == CityTongName) then
        Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> gi¶i tho¸t thµnh c«ng hån ph¸ch cña Thñ hé ThÇn thó, thËt lµ c«ng ®øc v« l­îng.</bc>")
        local OldPlayerIndex = PlayerIndex
        --		local w1,x1,y1,rv = 0,0,0,0
        local p = GetFirstPlayerInAll()
        while (p > 0) do
            PlayerIndex = p
            if (IsPlayerInDeath() == 0) and (GetTongName() == CityTongName) and (IsOwnerCity() == 1) and (HaveIBBuff(1010) == 1) then
                --ÊÇ·ñËÀÍö
                local w1, x1, y1 = GetWorldPos()
                local w2, x, y = GetNpcWorldPos(npcidx)
                rv = (x - x1) ^ 2 + (y - y1) ^ 2
                if (rv <= 800) then
                    RemoveIBBuff(1010)
                    AddIBBuff(1011)
                    Msg2Player("NhËn ®­îc Thñ Hé Nguyªn Linh-L«i, cã thÓ vÒ Phong ThÇn ®µi gÆp B¸ Gi¸m nhËn th­ëng.")
                end
            end

            p = GetNextPlayerInAll()
        end

        PlayerIndex = OldPlayerIndex
    else
        local nTongID = GetTongIDByName(CityTongName)

        Msg2TongMemberByTongName(CityTongName, "<bc=r>Thñ hé ThÇn thó bÞ " .. GetTongName() .. "_<RoleName=\"" .. playername .. "\"> ®¸nh b¹i, tiÕc lµ vÉn ch­a thÓ gióp nã ®é kiÕp thµnh c«ng.</bc>")
        ---×Ô¼º¹ú¼Ò
        Msg2TongMemberByTongName(GetTongName(), "<bc=r><RoleName=\"" .. playername .. "\"> thµnh c«ng ®¸nh b¹i " .. CityTongName .. "_Thñ hé ThÇn thó.</bc>")------µÐÈË¹ú¼Ò
    end
    DelNpc(npcidx)
end;
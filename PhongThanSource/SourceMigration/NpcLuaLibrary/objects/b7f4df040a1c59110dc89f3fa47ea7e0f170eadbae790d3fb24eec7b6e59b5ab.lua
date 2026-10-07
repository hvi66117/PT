gMaxValue = 10

function OnDeath(npcidx)
    local CityID = GetNpcMapCityID(npcidx)
    local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemp, CityTongName = GetCityInfoByID(CityID)
    DelNpc(npcidx)

    local oldplayer = PlayerIndex
    PlayerIndex = 1
    WriteLog(CityTongName .. "Thñ Hé ThÇn Thó ®· bŞ ®¸nh b¹i.")
    PlayerIndex = oldplayer

    if (PlayerIndex > 0) then
        local killTongName = GetTongName()
        Msg2TongMemberByTongName(CityTongName, "Thñ hé ThÇn thó bŞ " .. killTongName .. "L·nh ®Şa-" .. GetName() .. "NhÊt kiÕm h¹ thñ, phßng thñ thµnh thŞ v« cïng nguy ngËp.")
        Msg2TongMember(GetName() .. "Thµnh c«ng ®¸nh b¹i " .. CityTongName .. "Thñ Hé ThÇn Thó cña l·nh ®Şa nhÊt kiÕm h¹ thñ.")
    else
        Msg2TongMemberByTongName(CityTongName, "Thñ Hé ThÇn Thó cña l·nh ®Şa ng· xuèng Çm Çm, phßng thñ thµnh thŞ v« cïng nguy ngËp.")
    end
end;

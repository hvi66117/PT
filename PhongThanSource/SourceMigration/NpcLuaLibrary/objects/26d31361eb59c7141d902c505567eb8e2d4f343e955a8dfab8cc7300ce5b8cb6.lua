--description: ÊØ»¤ÉñÊŞ
--author: yaoxin£¬yangyankun
--date: 2009/09/24
gMaxValue = 10

function OnDeath(npcidx)
    local CityID = GetNpcMapCityID(npcidx)
    local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemp, CityTongName = GetCityInfoByID(CityID)
    DelNpc(npcidx)

    --> add by yangyankun for ¼ÇÂ¼¹úÕ½log at 09-12-27
    local oldplayer = PlayerIndex
    PlayerIndex = 1
    WriteLog(CityTongName .. "Thñ Hé ThÇn Thó ®· bŞ ®¸nh b¹i.")
    PlayerIndex = oldplayer
    --< add by yangyankun for ¼ÇÂ¼¹úÕ½log at 09-12-27

    --	local _,_,_,_,_,_,CityTongName = GetCityInfo()	-- ÊØ»¤ÊŞ¹ú¼ÒµÄÃû×Ö
    --	local sTong,sCity,nTime,nState = GetShortBattleByInfo(CityTongName)	-- ÊØ»¤ÊŞ¹ú¼ÒµÄÇÖÂÔ¹ú
    --	local killTongName = GetTongName()		-- É±ËÀÊØ»¤ÊŞ¹ú¼ÒµÄÃû×Ö
    --	local today = floor(LocalSystemTime()/86400)
    --	local fightday = floor(nTime/86400)

    -- ¸øÊØ»¤ÊŞ¹ú¼Ò¼õÈ¥1µã¹ú¼ÒÊÆÁ¦Öµ
    --local CityTongPower = GetShortBattleForcePower(CityTongName)
    --if (CityTongPower > 0) then
    --SetShortBattleForcePower(CityTongName,CityTongPower-1)
    --Msg2TongMemberByTongName(CityTongName, "Äú¹ú¼ÒµÄÊØ»¤ÉñÊŞËÀÍö£¬¹ú¼ÒÊÆÁ¦Öµ¼õÈ¥1µã")
    --else
    --SetShortBattleForcePower(CityTongName,0)
    --Msg2TongMemberByTongName(CityTongName, "Äú¹ú¼ÒµÄÊØ»¤ÉñÊŞËÀÍö£¬¹ú¼ÒÊÆÁ¦Öµ´ïµ½ÁË×îµÍÏŞ£¬Îª0µã")
    --end

    if (PlayerIndex > 0) then
        -- Èç¹ûÊÇ±»ÈËÉ±ËÀ
        local killTongName = GetTongName()        -- É±ËÀÊØ»¤ÊŞ¹ú¼ÒµÄÃû×Ö
        Msg2TongMemberByTongName(CityTongName, "Thñ hé ThÇn thó bŞ " .. killTongName .. "L·nh ®Şa-" .. GetName() .. "NhÊt kiÕm h¹ thñ, phßng thñ thµnh thŞ v« cïng nguy ngËp.")--×Ô¼º¹ú¼ÒµÄÊØ»¤ÊŞ
        Msg2TongMember(GetName() .. "Thµnh c«ng ®¸nh b¹i " .. CityTongName .. "Thñ Hé ThÇn Thó cña l·nh ®Şa nhÊt kiÕm h¹ thñ.") --µĞ¹ú
    else
        Msg2TongMemberByTongName(CityTongName, "Thñ Hé ThÇn Thó cña l·nh ®Şa ng· xuèng Çm Çm, phßng thñ thµnh thŞ v« cïng nguy ngËp.")
    end
end;

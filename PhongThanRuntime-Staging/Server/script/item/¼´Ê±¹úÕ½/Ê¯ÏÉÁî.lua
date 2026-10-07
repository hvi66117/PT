Task_storage = 1578
charmuse_uplimit = 2
CITY_build = 42
function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M <= 40) then
        if (IsInCity() == 1) then
            if (isWarsides() == 1) then
                local val1 = GetCityTask(CITY_build)
                if (GetByte(val1, 2) == 2) then
                    Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                    return 0
                end

                local TargetNpcIdx = GetPlayerTarget()
                local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
                if (npcTemplateID == 1418) or (npcTemplateID == 1419) then
                    if (HaveNormalItem(6, 1, 713, 0) > 0) then
                        DelNormalItem(6, 1, 713, 0)
                    else
                        DelNormalItemInQuick(6, 1, 713, 0)
                    end

                    NpcAddIBBuff(TargetNpcIdx, 1075)

                    local Y, M, D = GetYMD()
                    local H, M1, S = GetHMS()
                    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()

                    if (CityTongName ~= GetTongName()) then
                        Msg2TongMember(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " phót, <bc=r><RoleName=\"" .. GetName() .. "\"> t¹i" .. CityTongName .. " ®· sö dôngTh¹ch Tiªn LÖnh, g©y tæn thÊt cho l·nh ®Þa ®èi ®Þch.")
                        Msg2Player(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " ®iÓm, b¹n" .. CityTongName .. " ®· sö dôngTh¹ch Tiªn LÖnh, g©y tæn thÊt cho l·nh ®Þa ®èi ®Þch.")
                    elseif (CityTongName == GetTongName()) then
                        Msg2TongMember(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " phót<bc=r><RoleName=\"" .. GetName() .. "\"> ®· sö dôngTh¹ch Tiªn LÖnh trong l·nh ®Þa, sÜ khÝ l·nh ®Þa gia t¨ng.")
                        Msg2Player(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " ®iÓm, b¹n ®· sö dông Th¹ch Tiªn LÖnh trong l·nh ®Þa, sÜ khÝ l·nh ®Þa gia t¨ng.")
                    end

                    WriteLog(" ®· sö dông Th¹ch Tiªn LÖnh")
                else
                    Talk(1, "no", "Th¹ch Tiªn LÖnh chØ sö dông víi BÉy vµ Cù M·.")
                end


            else
                Talk(1, "no", "Th¹ch Tiªn LÖnh chØ sö dông lóc tÊn c«ng thµnh thÞ l·nh ®Þa kÎ ®Þch thêi gian Quèc ChiÕn.")
            end
        else
            Talk(1, "no", "Th¹ch Tiªn LÖnh chØ sö dông lóc tÊn c«ng thµnh thÞ l·nh ®Þa kÎ ®Þch thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "Th¹ch Tiªn LÖnh chØ sö dông lóc tÊn c«ng thµnh thÞ l·nh ®Þa kÎ ®Þch thêi gian Quèc ChiÕn.")
    end
end;

function no()
    CloseDialog()
end;

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 0
    elseif (IsTongMember() == 1) then
        local sTongName = GetTongName()
        local sTong, sCity, nTime, nState = GetShortBattleToInfo(sTongName)
        local CityName = GetCityInfo()
        if (CityName == sCity) then
            return 1
        end
    end
    return 0
end


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
                local playerCamp = GetCamp()

                local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
                local npcCamp = GetNpcCamp(TargetNpcIdx)
                local npcCurCamp = GetNpcCurrentCamp(TargetNpcIdx)
                local npcKind = GetNpcKind(TargetNpcIdx)

                if (npcCamp == playerCamp) or (npcCurCamp == playerCamp) then
                    Talk(1, "no", "Khæn Tiªn LÖnh chØ sö dông víi chiÕn xa vµ qu¸i vËt cña trËn doanh ®èi ®Þch.")
                    return
                end

                if (npcKind ~= 8) and (npcKind ~= 0) then
                    Talk(1, "no", "Khæn Tiªn LÖnh chØ cã thÓ sö dông ®èi víi ChiÕn xa vµ qu¸i vËt.")
                    return
                end

                if (npcTemplateID > 0) then
                    if (HaveNormalItem(6, 1, 718, 0) > 0) then
                        DelNormalItem(6, 1, 718, 0)
                    else
                        DelNormalItemInQuick(6, 1, 718, 0)
                    end

                    if (NpcHaveIBBuff(TargetNpcIdx, 1058) == 0) then
                        NpcAddIBBuff(TargetNpcIdx, 1060)
                    else
                        Msg2Player("Sö dông Khæn Tiªn LÖnh thÊt b¹i, ®èi ph­¬ng ®ang ë trong tr¹ng th¸i b¶o hé cña CÊp CÊp Nh­ LuËt LÖnh.")
                    end
                    Msg2Player("KhiÕn chiÕn xa hoÆc qu¸i vËt kh«ng thÓ di chuyÓn vµ tÊn c«ng. Duy tr× 45 gi©y.")
                    Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> ®· sö dông Khæn Tiªn LÖnh")
                    WriteLog(" ®· sö dông Khæn Tiªn LÖnh")
                else
                    Talk(1, "no", "Khæn Tiªn LÖnh chØ sö dông víi chiÕn xa vµ qu¸i vËt")
                end


            else
                Talk(1, "no", "Khæn Tiªn LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
            end
        else
            Talk(1, "no", "Khæn Tiªn LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
        end
    else
        Talk(1, "no", "Khæn Tiªn LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
    end
end;

function no()
    CloseDialog()
end;

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 1
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


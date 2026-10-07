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

            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                return 0
            end

            if (IsOwnerCity() == 0) and (isWarsides() == 0) then
                Talk(1, "no", "ChØ cã bªn c«ng thµnh vµ thñ thµnh cã thÓ sö dông ®¹o cô nµy.")
                return
            end

            local nTarget = GetPlayerTarget()
            local npcCamp = GetNpcCamp(nTarget)
            local npcCurCamp = GetNpcCurrentCamp(nTarget)

            if (nTarget <= 0) then
                Talk(1, "no", "B¹n ch­a chän tróng qu¸i nhiÖm vô")
                return
            end

            if (GetNpcTask(nTarget, 1) ~= 1) then
                Talk(1, "no", "Qu¸i vËt nµy kh«ng ph¶i do C«ng Thµnh cÇu hoÆc ThÊt s¾c Th¹ch CÇu th¶ ra, kh«ng thÓ sö dông ®¹o cô nµy víi nã.")
                return
            end

            if (npcCamp == GetCamp()) or (npcCurCamp == GetCamp()) then
                Talk(1, "no", "Kh«ng thÓ sö dông ®¹o cô nµy ®èi víi qu¸i vËt cña bªn m×nh.")
                return
            end

            NpcAddIBBuff(nTarget, 1059)

            if (HaveNormalItem(6, 1, 714, 0) > 0) then
                DelNormalItem(6, 1, 714, 0)
            else
                DelNormalItemInQuick(6, 1, 714, 0)
            end

            Msg2CurMapAnnounce(GetName() .. "§· sö dông ThÓ V©n LÖnh, khiÕn 1 ma vËt do ThÊt s¾c Th¹ch CÇu cña ®èi thñ th¶ ra tan tµnh m©y khãi.")
            WriteLog(" ®· sö dông ThÓ V©n LÖnh")


        else
            Talk(1, "no", "ThÓ V©n LÖnh chØ cã thÓ sö dông trong l·nh ®Þa tù x©y trong thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "ThÓ V©n LÖnh chØ cã thÓ sö dông trong l·nh ®Þa tù x©y trong thêi gian Quèc ChiÕn.")
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

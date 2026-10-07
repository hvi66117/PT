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
        if (IsOwnerCity() == 1) then
            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                return 0
            end

            local TargetNpcIdx = GetPlayerTarget()

            if (TargetNpcIdx <= 0) then
                Talk(1, "no", "Phong ThÇn LÖnh chØ cã thÓ sö dông víi vËt tæ, kiÕn tróc, Thñ Hé Thó cña l·nh ®Þa")
                return 0
            end

            local playerCamp = GetCamp()
            local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
            local npcCamp = GetNpcCamp(TargetNpcIdx)
            local npcCurCamp = GetNpcCurrentCamp(TargetNpcIdx)
            if (npcTemplateID == 1417) then
                if (npcCamp ~= playerCamp) and (npcCurCamp ~= playerCamp) then
                    Talk(1, "no", "Phong ThÇn LÖnh chØ cã thÓ sö dông nç xa cña phe h¶o h÷u.")
                    return 0
                end
            end

            local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
            if (GetCityGateNpcIdx() == TargetNpcIdx) or (GetCityTotemNpcIdxByNpc(TargetNpcIdx) == TargetNpcIdx) or ((npcTemplateID == 1417) and (NpcHaveIBBuff(TargetNpcIdx, 1060) == 1)) then
            elseif (npcTemplateID < 368) or (npcTemplateID >= 402 and npcTemplateID < 1407)
                    or (npcTemplateID >= 1420) or (GetNpcCamp(TargetNpcIdx) ~= GetCamp()) then
                Talk(1, "no", "Phong ThÇn LÖnh chØ cã thÓ sö dông nç xa cho tæ vËt, kiÕn tróc, b¶o hé thó, khæn tiªn l·nh ®Þa cña m×nh")
                return 0
            end

            if (HaveNormalItem(6, 1, 711, 0) > 0) then
                DelNormalItem(6, 1, 711, 0)
            else
                DelNormalItemInQuick(6, 1, 711, 0)
            end

            NpcAddIBBuff(TargetNpcIdx, 1080)
            Msg2Player("Cã thÓ nh©n ®«i Phßng ngù cña 1 ®¬n vÞ b¹n h÷u (gåm vËt tæ, kiÕn tróc, Thñ Hé Thó).")
            Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> ®· sö dông Phong ThÇn LÖnh")
            WriteLog(" ®· sö dông Phong ThÇn LÖnh")


        else
            Talk(1, "no", "Phong ThÇn LÖnh chØ ®­îc sö dông lóc b¶o vÖ thµnh thÞ l·nh ®Þa m×nh trong giai ®o¹n Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "Phong ThÇn LÖnh chØ ®­îc sö dông lóc b¶o vÖ thµnh thÞ l·nh ®Þa m×nh trong giai ®o¹n Quèc ChiÕn.")
    end
end;

function no()
    CloseDialog()
end;
















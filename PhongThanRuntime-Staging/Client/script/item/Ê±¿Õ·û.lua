require("common.luax")

function main(sel)
    local w, x, y = GetWorldPos()
    if (w == 70 or (w >= 79 and w <= 82)) and ((GetTask(1) == 84) or (GetTask(2) == 84) or (GetTask(3) == 84)) and (IsExistItem(4, 176, 0, 1) == 1) and (IsExistItem(4, 177, 0, 1) == 1) and (IsExistItem(4, 178, 0, 1) == 1) and (HaveEventItem(176) == 1) and (HaveEventItem(177) == 1) and (HaveEventItem(178) == 1) and (GetFightState() == 1) then


        if (HaveIBBuff(1508) > 0) then
            InfoBox("Anh hÔng Æ∑ ph„ng th›ch Thi™n HÂn, kh´ng th” tri÷u hÂi ti’p. ")
            return
        end

        local found = 0
        for i = 131, 140 do
            if GetGlobalValue(i) == 0 then
                found = i
            end
        end

        if (found ~= 0) then
            local m, x, y = GetWorldPos()
            local npcidx = AddNpc(541, 100, SubWorld, x * 32, y * 32)
            if (npcidx > 0) then
                SetGlobalValue(found, npcidx)

                TopMessage(13119)
                DelEventItem(176)
                DelEventItem(177)
                DelEventItem(178)

                AddIBBuff(1508, 30 * 60)

            end
        else
            TopMessage(13120)
        end


    elseif (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 4, "Vi‘n CÊ/v1", "Tri“u Ca sau nµy/v2", "Ng‰c H≠ cung sau nµy/v3", "Ng‰c H≠ cung lÛc tr≠Ìc/v4")
    end ;

end;

function v1()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
    elseif (GetPK() >= 88) then
        Msg2Player("Ng≠Íi ch¨i t™n ch˜ Æ· kh´ng th” chuy”n Æ’n Vi‘n CÊ")
    elseif (GetCamp() == 0) then
        Msg2Player("T©n thÒ kh´ng th” vµo Vi‘n CÊ")
    else
        NewWorld(64, 1546, 3244)
        SetFightState(0)
        SetRevPos(64, 216)
        Msg2Player("Bπn Æ∑ thi’t lÀp Æi”m trÔng sinh tπi Vi‘n CÊ")
    end ;
    CloseDialog()
end;

function v2()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
    else
        NewWorld(63, 1506, 3298)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v3()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
    else
        NewWorld(62, 1627, 3322)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v4()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
    else
        NewWorld(61, 1597, 3333)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function no()
    CloseDialog()
end;

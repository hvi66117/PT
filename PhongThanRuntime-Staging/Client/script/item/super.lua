require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 25, "Phong Th«n Æµi/v1", "Di™u Tr◊/v2", "T©y K˙/v3", "Tri“u Ca/v4", "SÔng Thµnh doanh/v5", "Ng‰c H≠ cung/v6", "Xi V≠u MÈ/v7", "SÔng thµnh/v8", "Bæc H∂i/v9", "Y’n S¨n/v10", "Ch©n nÛi C´n L´n/v11", "T©y C´n L´n/v12", "ThÒ D≠¨ng s¨n/v13", "Du HÂn/v14", "Mi™u C≠¨ng/v15", "C˘ LÈc/v16", "ßÂng quan/v17", "Mπnh T©n/v18", "Tam S¨n/v19", "K˙ S¨n/v20", "MÙc D∑/v21", "Tuy÷t Long l‹nh/v22", "Tr«n ß≠Íng/v37", "Chi’n tr≠Íng Vi‘n CÊ/v38", "Thanh ßÂng s¨n/v58")
    end ;
end;

function v1()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(1, 1536, 3254)
        end ;
        if (i == 2) then
            NewWorld(1, 1523, 3241)
        end ;
        if (i == 3) then
            NewWorld(1, 1549, 3269)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v2()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(52, 1541, 3190)
        end ;
        if (i == 2) then
            NewWorld(52, 1556, 3202)
        end ;
        if (i == 3) then
            NewWorld(52, 1540, 3205)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v3()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(20, 1452, 3086)
        end ;
        if (i == 2) then
            NewWorld(20, 1437, 3093)
        end ;
        if (i == 3) then
            NewWorld(20, 1470, 3106)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v4()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(21, 1723, 3075)
        end ;
        if (i == 2) then
            NewWorld(21, 1735, 3027)
        end ;
        if (i == 3) then
            NewWorld(21, 1725, 3106)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v5()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(2, 1608, 3196)
        end ;
        if (i == 2) then
            NewWorld(2, 1591, 3165)
        end ;
        if (i == 3) then
            NewWorld(2, 1623, 3213)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v6()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(3, 1692, 3138)
        end ;
        if (i == 2) then
            NewWorld(3, 1689, 3153)
        end ;
        if (i == 3) then
            NewWorld(3, 1710, 3110)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v7()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(4, 1573, 3229)
        end ;
        if (i == 2) then
            NewWorld(4, 1554, 3227)
        end ;
        if (i == 3) then
            NewWorld(4, 1573, 3262)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function v8()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(5, 1709, 3063)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v9()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(6, 1733, 3013)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v10()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(7, 1766, 3365)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v11()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else

        if (math.random(1, 2) == 1) then
            NewWorld(8, 1853, 2803)
        else
            NewWorld(8, 1554, 3407)
        end
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v12()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(9, 1706, 3452)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v13()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(10, 1436, 3124)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v14()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(11, 1810, 3133)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v15()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(12, 1720, 3319)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v16()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(13, 1835, 3002)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v17()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(14, 1575, 3378)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v18()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(15, 1539, 3403)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v19()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(16, 1633, 3192)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v20()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(17, 1747, 3380)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v21()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(18, 1620, 3150)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v22()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(19, 1645, 3137)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v37()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(65, 1628, 3008)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v38()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    elseif (GetPK() >= 88) then
        Msg2Player("Ng≠Íi ch¨i t™n ch˜ Æ· kh´ng th” chuy”n Æ’n Vi‘n CÊ")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    elseif (GetCamp() == 0) then
        Msg2Player("T©n thÒ kh´ng th” vµo Vi‘n CÊ")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        NewWorld(64, 1600, 3238)
        SetFightState(0)
        SetRevPos(64, 216)
        Msg2Player("Bπn Æ∑ thi’t lÀp Æi”m trÔng sinh tπi Vi‘n CÊ")
    end ;
    CloseDialog()
end;

function no()
    CloseDialog()
    AddNormalItem(6, 1, 6, 1, 0, 0)
end;

function v58()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 6, 1, 0, 0)
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(57, 1608, 3094)
        end ;
        if (i == 2) then
            NewWorld(57, 1609, 3075)
        end ;
        if (i == 3) then
            NewWorld(57, 1604, 3115)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

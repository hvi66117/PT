require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 34, "Phong Th«n Æµi/v1", "Di™u Tr◊/v2", "T©y K˙/v3", "Tri“u Ca/v4", "Hoang mπc/v9", "Sa Mπc ThÊ Thµnh/v10", "Sa Mπc Phong Th«n/v11", "Sa Mπc LÙc Ch©u/v12", "Sa Mπc ch’t/v13", "Hi™n Vi™n t«ng 1/v14", "Hi™n Vi™n t«ng 2/v15", "Hi™n Vi™n t«ng 3/v16", "Hi™n Vi™n t«ng 4/v17", "Hi™n Vi™n t«ng 5/v18", "Ng‰c Tuy“n/v19", "Tuy’t CËc/v20", "ßπi Phong/v21", "ßπi Trπch/v22", "B®ng Xuy™n C˘c/v23", "ThÒy V˘c/v24", "Long Cung/v25", "H∂i C©u/v26", "Long V˘c/v27", "Long Uy™n/v28", "B›ch Du t«ng 1/v29", "B›ch Du t«ng 2/v30", "B›ch Du t«ng 3/v31", "B›ch Du t«ng 4/v32", "B›ch Du t«ng 5/v33", "KhÊn Ti™n t«ng 1/v34", "KhÊn Ti™n t«ng 2/v35", "KhÊn Ti™n t«ng 3/v36", "KhÊn Ti™n t«ng 4/v37", "KhÊn Ti™n t«ng 5/v38", "Chi’n tr≠Íng Vi‘n CÊ/v39")
    end ;
end;

function v1()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
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
        AddNormalItem(6, 1, 33, 1, 0, 0)
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
        AddNormalItem(6, 1, 33, 1, 0, 0)
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
        AddNormalItem(6, 1, 33, 1, 0, 0)
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

function v9()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(22, 1627, 3267)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v10()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(23, 1623, 3355)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v11()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(24, 1630, 3183)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v12()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(25, 1610, 3127)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v13()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(26, 1660, 3182)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v14()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(27, 1577, 3203)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v15()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(28, 1623, 3240)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v16()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(29, 1503, 3303)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v17()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(30, 1562, 3341)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v18()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(31, 1603, 3263)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v19()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(32, 1850, 2915)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v20()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(33, 1750, 3041)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v21()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(34, 1451, 3170)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v22()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(35, 1760, 3385)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v23()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(36, 1422, 3460)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v24()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(37, 1333, 3182)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v25()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(38, 1334, 3181)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v26()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(39, 1703, 2877)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v27()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(40, 1336, 2860)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v28()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(41, 1548, 3150)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v29()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(42, 1330, 3160)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v30()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(43, 1618, 3238)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v31()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(44, 1908, 3099)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v32()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(45, 1530, 3267)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v33()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(46, 1903, 3003)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v34()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(47, 1599, 3139)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v35()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(48, 1581, 3154)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v36()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(49, 1556, 3154)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v37()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(50, 1600, 3159)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v38()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(51, 1503, 3164)
        SetFightState(1)
    end ;
    CloseDialog()
end;

function v39()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("Î trπng th∏i nµy kh´ng th” chuy”n ti’p")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    elseif (GetCamp() == 0) then
        Msg2Player("T©n thÒ kh´ng th” vµo Vi‘n CÊ")
        AddNormalItem(6, 1, 33, 1, 0, 0)
    else
        NewWorld(64, 1546, 3244)
        SetFightState(0)
        SetRevPos(64, 216)
        Msg2Player("Bπn Æ∑ thi’t lÀp Æi”m trÔng sinh tπi Vi‘n CÊ")
    end ;
    CloseDialog()
end;

function no()
    AddNormalItem(6, 1, 33, 1, 0, 0)
    CloseDialog()
end;

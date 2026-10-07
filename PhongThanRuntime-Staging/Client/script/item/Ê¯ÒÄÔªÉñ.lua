Task_Gernal = 1543
Task_PageIndex = 1544
Task_UsedTime = 1545
Task_HUOYUNSHOU_BindingIndex = 1546
Task_HUOYUNSHI_BindingID = 1547
Task_HUOYUNSHI_BindingIndex = 1548
Task_SHIYI_BingdingIndex = 1549
Task_MINGDENG_BingdingIndex = 1550
Task_YAOSHOULI_BindingIndex = 1551

function main()
    if (HaveIBBuff(793) == 0) then
        Talk(1, "no", GetName() .. "B¹n ®· kh«ng cßn [BÊt §éng Nh­ S¬n]")
    else
        index = GetTask(Task_SHIYI_BingdingIndex)
        DeleteSiegeWeapon(index)
        SetTaskByte(Task_Gernal, 3, 1)
        TaskNote(1101, 2)
    end
    DelNormalItem(6, 1, 578, 1)
end;

function no()

    CloseDialog()
end

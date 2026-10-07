function no()
    CloseDialog()
end

function main()
    Msg2Player("Ch‰n vÚ kh› c«n bÊ sung linh kh›")
    MouseSelect(1, 22, "AddAuraSelect", "no")
end

function AddAuraSelect(ItemID)

    if (HaveNormalItem(6, 1, 587, 1) <= 0) then

        return
    end

    local eqType = GetEqFormulaType(ItemID)
    local itemName = GetItemName(ItemID)
    if eqType ~= 3 then
        Msg2Player("VÀt ph»m nµy kh´ng th” bÊ sung linh kh›")
        return
    end

    if (ModifyEquipAuraByID(ItemID, 200) > 0) then
        DelNormalItem(6, 1, 587, 1)
        Msg2Player("<c=g>" .. itemName .. "<c> cÒa bπn Æ∑ t®ng 200 Æi”m linh kh›")
    else
        Msg2Player("<c=g>" .. itemName .. "<c>Linh kh› Æ∑ Æ«y, kh´ng c«n bÊ sung")

    end

end

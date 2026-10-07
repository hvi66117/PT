Task_epistle = 1651

function main()
    CloseDialog()
    local state = GetTaskByte(Task_epistle, 1)

    if (state >= 3) then
        ClearItem(6, 1, 790, 0)
        Talk(1, "no", "§· ®äc th­!")
        return 0
    end

    if (state == 0) and (IsExistItem(6, 1, 790, 0) == 1 or HaveNormalItemInQuick(6, 1, 790, 0) == 1) then
        Talk(2, "sel_renwu", "...Ta ®· bŞ bän Thõa Hoµng Yªu tÊn c«ng...Ta chÕt kh«ng tiÕc, nh­ng Long Xµ Th¶o th× kh«ng thÓ ®Ó r¬i vµo tay yªu ma ®­îc! Hy väng anh hïng cã thÓ gióp ta ®o¹t l¹i d­îc th¶o, giao cho téc tr­ëng téc Di Ph­¬ng...", GetName() .. ":Nh÷ng ch÷ viÕt phİa sau ®· bŞ mê nhße rÊt khã ®äc")
        Msg2Player("Ch÷ trong th­ ®· bŞ mê nhße rÊt khã ®äc")
    else
        Talk(1, "no", "...Ta ®· bŞ bän Thõa Hoµng Yªu tÊn c«ng...Ta chÕt kh«ng tiÕc, nh­ng Long Xµ Th¶o th× kh«ng thÓ ®Ó r¬i vµo tay yªu ma ®­îc! Hy väng anh hïng cã thÓ gióp ta ®o¹t l¹i d­îc th¶o, giao cho téc tr­ëng téc Di Ph­¬ng...")
    end
end;

function no()
    CloseDialog()
end;

function sel_renwu()
    CloseDialog()
    MsgBox(GetName() .. ": Xem ra ®©y lµ bót tİch cña mét ng­êi ®· hy sinh tİnh m¹ng cña m×nh ®Ó h¸i thuèc cøu ng­êi...Ta ph¶i gióp ng­êi nµy hoµn thµnh di nguyÖn!", "sel_renwu_yes", "no")
end

function sel_renwu_yes()
    CloseDialog()
    local state = GetTaskByte(Task_epistle, 1)
    if (state == 0) then
        SetTaskByte(Task_epistle, 1, 1)
        TaskNote(118, 0)
        Talk(1, "no", GetName() .. "Th× ra th¶o d­îc bŞ Thõa Hoµng c­íp ®i chİnh lµ <c=g>Long Xµ Th¶o<c>, ta ph¶i ®i diÖt chóng lÊy l¹i!")
        Msg2Player("ÏûÃğ³Ë»Æ»ñÈ¡ÁúÉß²İ")
    end
end

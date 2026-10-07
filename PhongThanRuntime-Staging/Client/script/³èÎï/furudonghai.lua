require("ÊôĞÔÁé³è.luax")

function main()
    if (PetIsAdd() == 0) then
        Msg2Player("B¹n ch­a cã Linh thó, h·y ®Õn ThÇy t­íng sè TriÒu Ca nhËn linh thó!")
        Talk(1, "no", "B¹n ch­a cã Linh thó, h·y ®Õn ThÇy t­íng sè TriÒu Ca nhËn linh thó!")

    else
        if (PetIsSleep() == 1) then
            Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
            Talk(1, "no", "Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
        elseif (PetGetType() == 9) then
            Talk(1, "no", "Linh thó ®· lµ <c=g>B¹ch Tr­<c>, kh«ng thÓ biÕn h×nh n÷a!")
        else
            Msg2Player("Linh thó biÕn thµnh B¹ch Tr­!")
            TopMessage("Linh thó biÕn thµnh <c=g>B¹ch Tr­<c>")
            Able_Pet.ChangePet()
            PetSetType(9)
            local strMsg = GetName() .. " nhËn ®­îc B¹ch Tr­."
            WriteLog(strMsg)
            SetTask(1167, SetBit(GetTask(1167), 9, 1))
            DelNormalItem(6, 1, 335, 0)
        end
    end

end

function no()
    CloseDialog()
end;


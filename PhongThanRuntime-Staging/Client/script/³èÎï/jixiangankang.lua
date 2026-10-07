require("ÊôĞÔÁé³è.luax")

function main()
    if (PetIsAdd() == 0) then
        Msg2Player("B¹n ch­a cã Linh thó, h·y ®Õn ThÇy t­íng sè TriÒu Ca nhËn linh thó.")
        Talk(1, "no", "B¹n ch­a cã Linh thó, h·y ®Õn ThÇy t­íng sè TriÒu Ca nhËn linh thó!")

    else
        if (PetIsSleep() == 1) then
            Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
            Talk(1, "no", "Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
        elseif (PetGetType() == 10) then
            Talk(1, "no", "Linh thó ®· lµ <c=g>Hång Tr­<c>, kh«ng thÓ biÕn h×nh n÷a!")
        else
            Msg2Player("Linh thó biÕn thµnh Hång Tr­!")
            TopMessage("Linh thó biÕn thµnh <c=g>Hång Tr­<c>")
            Able_Pet.ChangePet()
            PetSetType(10)
            local strMsg = GetName() .. " nhËn ®­îc Hång Tr­."
            WriteLog(strMsg)
            SetTask(1167, SetBit(GetTask(1167), 10, 1))
            DelNormalItem(6, 1, 336, 0)
        end
    end

end

function no()
    CloseDialog()
end;


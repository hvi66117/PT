require(" Ù–‘¡È≥Ë.luax")

PetName = "÷¡◊÷Ú…Ò"
PetId = 57
Item_Id1 = 6
Item_Id2 = 1
Item_Id3 = 1393

function main(nLevel, t, nNpcIdx, nItemId)
    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    if (PetIsAdd() == 0) then
        Talk(1, "no", "Ch≠a c„ Linh ThÛ, kh´ng th” bi’n th©n. ")
        return
    elseif (PetIsSleep() == 1) then
        Talk(1, "no", "Linh ThÛ trong trπng th∏i ngÒ, kh´ng th” bi’n th©n.")
        return
    elseif (PetGetTime() < (1 * 60 * 60)) then
        Talk(1, "no", "Linh ThÛ Æang trong trπng th∏i  p 24h, kh´ng th” bi’n th©n. ")
        return
    end

    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)
    if (nGen == Item_Id1 and nDetail == Item_Id2 and nParticular == Item_Id3) then
        Able_Pet.ChangePet()
        PetSetType(PetId)
        Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh " .. PetName .. ".")
    else
        Talk(1, "no", "«Î»∑∂®ŒÔ∆∑”––ß!")
        Msg2Player("«Î»∑∂®ŒÔ∆∑”––ß!")
    end
end

function no()
    CloseDialog()
end

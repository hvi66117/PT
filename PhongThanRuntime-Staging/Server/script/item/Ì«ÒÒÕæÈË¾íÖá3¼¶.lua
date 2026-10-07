require(" Ù–‘¡È≥Ë.luax")
require("º◊π«ŒƒªÓ∂Ø.luax")

CardName = "Th∏i  t Ch©n Nh©n"
Item_Id = { 6, 1, 1467, 1 }
TaskTable = Able_Pet.TaskTable_TaiYi
cardlevel = 3

function main(nLevel, t, nNpcIdx, nItemId)
    Able_Pet.JudgeAndDel(CardName, Item_Id[1], Item_Id[2], Item_Id[3], Item_Id[4])
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
    if (nGen == Item_Id[1] and nDetail == Item_Id[2] and nParticular == Item_Id[3]) then
        Able_Pet.ChangePet()
        SetTaskByte(Able_Pet.TaiYi_Pet, 1, 1)
        SetTaskByte(Able_Pet.TaiYi_Pet, 2, cardlevel)
        PetSetType(TaskTable[cardlevel].petid)
        Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh Th∏i  t Ch©n Nh©n.")
        AddIBBuff(TaskTable[cardlevel].buffid)
        ORACLEBONE.GetCardWayApply(38, 5)
        ORACLEBONE.GetCardWayApply(39, 5)
    else
        Talk(1, "no", "«Î»∑∂®ŒÔ∆∑”––ß!")
        Msg2Player("«Î»∑∂®ŒÔ∆∑”––ß!")
    end

end

function no()
    CloseDialog()
end;

require(" Ù–‘¡È≥Ë.luax")
require("º◊π«ŒƒªÓ∂Ø.luax")
CardName = "Thπch C¨ N≠¨ng N≠¨ng"
Item_Id = { 6, 1, 1453, 1 }
TaskTable = Able_Pet.TaskTable_ShiJi
cardlevel = 6

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
    if not (nGen == Item_Id[1] and nDetail == Item_Id[2] and nParticular == Item_Id[3]) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end
    local menu = {
        { "Bi’n h◊nh", "main_pet"; show = 1 },
        { "Ti÷m tu˙ th©n", "shop"; show = 1 },
    }
    SayTask("MÍi l˘a ch‰n:", menu)

end
function main_pet()
    Able_Pet.ChangePet()
    SetTaskByte(Able_Pet.ShiJi_Pet, 1, 1)
    SetTaskByte(Able_Pet.ShiJi_Pet, 2, cardlevel)
    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh Thπch C¨.")
    AddIBBuff(TaskTable[cardlevel].buffid)
    ORACLEBONE.GetCardWayApply(38, 4)
    ORACLEBONE.GetCardWayApply(39, 4)
    no()
end
function shop()
    no()
    Sale(1)
end

function no()
    CloseDialog()
end;

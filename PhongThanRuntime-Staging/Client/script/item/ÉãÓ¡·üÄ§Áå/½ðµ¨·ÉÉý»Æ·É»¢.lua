require(" Ù–‘¡È≥Ë.luax")
require("º◊π«ŒƒªÓ∂Ø.luax")
CardName = "Kim ß∂m Phi Th®ng-Hoµng Phi HÊ"
Item_Id = { 6, 1, 1859, 1 }
TaskTable = Able_Pet.TaskTable_NewAllPet[12].task
PetTask = Able_Pet.TaskTable_NewAllPet[12].taskvalue[1]
PetType = Able_Pet.TaskTable_NewAllPet[12].PetType
cardlevel = 11

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
    no()
    Able_Pet.ChangePet()
    Able_Pet.Xuanwu()
    SetTaskByte(PetTask, 1, 1)
    SetTaskByte(PetTask, 2, cardlevel)
    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh " .. CardName)
    ScrollMessage("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh " .. CardName)
    AddIBBuff(TaskTable[cardlevel].buffid)
    ORACLEBONE.GetCardWayApply(38, PetType)
    ORACLEBONE.GetCardWayApply(39, PetType)
end
function shop()
    no()
    Sale(1)
end

function no()
    CloseDialog()
end;

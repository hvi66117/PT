require(" Ù–‘¡È≥Ë.luax")
require("º◊π«ŒƒªÓ∂Ø.luax")

CardName = "LÙc ∏p ßπo Nh©n"

Cardidx = 1887
PetIndex = 1
TaskTable = Able_Pet.TaskTable_AllPet2New[PetIndex].task
PetTask = Able_Pet.TaskTable_AllPet2New[PetIndex].taskvalue[1]
PetType = Able_Pet.TaskTable_AllPet2New[PetIndex].PetType
Petid = Able_Pet.TaskTable_AllPet2New[PetIndex].petid

function main(nLevel, t, nNpcIdx, nItemId)
    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)
    if (nGen ~= 6) or (nDetail ~= 1) or (nParticular ~= Cardidx) then
        Talk(1, "no", "«Î»∑∂®ŒÔ∆∑”––ß!")
        Msg2Player("«Î»∑∂®ŒÔ∆∑”––ß!")
        return 0
    end

    Able_Pet.JudgeAndDel(CardName, 6, 1, nParticular, 1)
    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    if (GetLevel() < 121 and GetNewBirthTimes() < 1) then
        Talk(1, "no", "ThÀt xin lÁi, ngµi ch≠a Æπt 121, kh´ng th” bi’n th©n.")
        return 0
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

    local menu = {
        { "Bi’n h◊nh", "main_pet"; show = 1 },

    }
    SayTask(" «∑Òœ÷‘⁄æÕ±‰…Ì<c=g>" .. CardName .. "<c>: ", menu)
end

function shop()
    no()
    Sale(1)
end

function main_pet()
    CloseDialog()
    local Petlevel = GetTaskByte(PetTask, 2)
    if (Petlevel <= 0) or (Petlevel > 10) then
        Petlevel = 1
    end

    Able_Pet.ChangePet()
    PetSetType(Petid)
    SetTaskByte(PetTask, 1, 1)
    Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh " .. Petlevel .. " (c p)" .. CardName)
    ScrollMessage("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh " .. Petlevel .. " (c p)" .. CardName)
    AddIBBuff(TaskTable[Petlevel].buffid)

    ORACLEBONE.GetCardWayApply(38, PetType)
    ORACLEBONE.GetCardWayApply(39, PetType)
end

function no()
    CloseDialog()
end;

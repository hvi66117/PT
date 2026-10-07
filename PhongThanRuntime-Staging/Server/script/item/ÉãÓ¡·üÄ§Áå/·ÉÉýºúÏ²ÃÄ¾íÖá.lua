require("ÊôÐÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")

CardName = "Phi Th¨ng-Hå HØ MÞ"

CardMin = 1675
CardMax = 1684
TaskTable = Able_Pet.TaskTable_NewAllPet[5].task
PetTask = Able_Pet.TaskTable_NewAllPet[5].taskvalue[1]
PetType = Able_Pet.TaskTable_NewAllPet[5].PetType

function main(nLevel, t, nNpcIdx, nItemId)
    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)
    if (nGen ~= 6) or (nDetail ~= 1) or (nParticular < CardMin) or (nParticular > CardMax) then
        Talk(1, "no", "ÇëÈ·¶¨ÎïÆ·ÓÐÐ§!")
        Msg2Player("ÇëÈ·¶¨ÎïÆ·ÓÐÐ§!")
        return 0
    end

    Able_Pet.JudgeAndDel(CardName, 6, 1, nParticular, 1)
    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (PetIsAdd() == 0) then
        Talk(1, "no", "Ch­a cã Linh Thó, kh«ng thÓ biÕn th©n. ")
        return
    elseif (PetIsSleep() == 1) then
        Talk(1, "no", "Linh Thó trong tr¹ng th¸i ngñ, kh«ng thÓ biÕn th©n.")
        return
    elseif (PetGetTime() < (1 * 60 * 60)) then
        Talk(1, "no", "Linh Thó ®ang trong tr¹ng th¸i Êp 24h, kh«ng thÓ biÕn th©n. ")
        return
    end

    local cardlevel = nParticular - CardMin + 1
    SetTask(140, cardlevel)
    if (cardlevel < 5) then
        main_pet()
    else
        local menu = {
            { "BiÕn h×nh", "main_pet"; show = 1 },
            { "TiÖm tuú th©n", "shop"; show = 1 },
        }
        SayTask("Mêi lùa chän:", menu)
    end
end

function shop()
    no()
    Sale(1)
end

function main_pet()
    CloseDialog()
    local cardlevel = GetTask(140)
    if (cardlevel <= 0) or (cardlevel >= 11) then
        return 0
    end

    Able_Pet.ChangePet()
    if (cardlevel >= 8) then
        Able_Pet.Xuanwu()
    end

    SetTaskByte(PetTask, 1, 1)
    SetTaskByte(PetTask, 2, cardlevel)
    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. CardName)
    ScrollMessage("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. CardName)
    AddIBBuff(TaskTable[cardlevel].buffid)
    ORACLEBONE.GetCardWayApply(38, PetType)
    ORACLEBONE.GetCardWayApply(39, PetType)
end

function no()
    CloseDialog()
end;

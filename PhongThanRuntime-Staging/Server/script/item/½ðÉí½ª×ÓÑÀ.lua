require("ÊôĞÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")
CardName = "Kim Th©n Kh­¬ng Tö Nha"
Item_Id = { 6, 1, 1665, 1 }
TaskTable = Able_Pet.TaskTable_NewAllPet[3].task
PetTask = Able_Pet.TaskTable_NewAllPet[3].taskvalue[1]
cardlevel = 11

function main(nLevel, t, nNpcIdx, nItemId)
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
    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)
    if not (nGen == Item_Id[1] and nDetail == Item_Id[2] and nParticular == Item_Id[3]) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    local menu = {
        { "BiÕn h×nh", "main_pet"; show = 1 },
        { "TiÖm tuú th©n", "shop"; show = 1 },
    }
    SayTask("Mêi lùa chän:", menu)

end
function main_pet()
    no()
    Able_Pet.ChangePet()
    Able_Pet.Xuanwu()
    SetTaskByte(PetTask, 1, 1)
    SetTaskByte(PetTask, 2, cardlevel)
    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. CardName)
    ScrollMessage("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. CardName)
    AddIBBuff(TaskTable[cardlevel].buffid)
    ORACLEBONE.GetCardWayApply(38, 11)
    ORACLEBONE.GetCardWayApply(39, 11)
end
function shop()
    no()
    Sale(1)
end

function no()
    CloseDialog()
end;

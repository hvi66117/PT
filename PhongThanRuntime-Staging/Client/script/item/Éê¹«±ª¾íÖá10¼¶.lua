require("ÊôÐÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")
CardName = "Th©n C«ng B¸o"
Item_Id = { 6, 1, 1497, 1 }
TaskTable = Able_Pet.TaskTable_ShenGongBao
cardlevel = 10

function main(nLevel, t, nNpcIdx, nItemId)
    Able_Pet.JudgeAndDel(CardName, Item_Id[1], Item_Id[2], Item_Id[3], Item_Id[4])
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
    Able_Pet.ChangePet()
    SetTaskByte(Able_Pet.ShenGongBao_Pet, 1, 1)
    SetTaskByte(Able_Pet.ShenGongBao_Pet, 2, cardlevel)

    Able_Pet.Xuanwu()

    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh Th©n C«ng B¸o.")
    AddIBBuff(TaskTable[cardlevel].buffid)
    ORACLEBONE.GetCardWayApply(38, 7)
    ORACLEBONE.GetCardWayApply(39, 7)
    no()
end
function shop()
    no()
    Sale(1)
end

function no()
    CloseDialog()
end;

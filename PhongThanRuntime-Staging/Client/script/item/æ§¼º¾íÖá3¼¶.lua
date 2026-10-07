require("ÊôÐÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")

CardName = "§¾c Kû"
Item_Id = { 6, 1, 1480, 1 }
TaskTable = Able_Pet.TaskTable_DaJi
cardlevel = 3

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
    if (nGen == Item_Id[1] and nDetail == Item_Id[2] and nParticular == Item_Id[3]) then
        Able_Pet.ChangePet()
        SetTaskByte(Able_Pet.DaJi_Pet, 1, 1)
        SetTaskByte(Able_Pet.DaJi_Pet, 2, cardlevel)
        PetSetType(TaskTable[cardlevel].petid)
        Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh §¸t Kû.")
        AddIBBuff(TaskTable[cardlevel].buffid)
        ORACLEBONE.GetCardWayApply(38, 6)
        ORACLEBONE.GetCardWayApply(39, 6)
    else
        Talk(1, "no", "ÇëÈ·¶¨ÎïÆ·ÓÐÐ§!")
        Msg2Player("ÇëÈ·¶¨ÎïÆ·ÓÐÐ§!")
    end

end

function no()
    CloseDialog()
end;

require("ÊôÐÔÁé³è.luax")
L_PETCOMBOS = Able_Pet.L_PETCOMBOS[5]

CardName = L_PETCOMBOS.name
CardIndex = L_PETCOMBOS.itemID
G_Task = L_PETCOMBOS.taskIdx
G_buff = L_PETCOMBOS.buff
G_Pet = L_PETCOMBOS.petID
G_bit = L_PETCOMBOS.bit

PetRoleCombosTask = 2199

function main(nLevel, t, nNpcIdx, nItemId)
    if (GetTaskBit(PetRoleCombosTask, G_bit) == 1) or (GetTaskByte(G_Task[1], G_Task[2]) == G_Pet) then
        Talk(1, "no", "ÄãÒÑ¾­ÓµÓÐ×éºÏ¼¼" .. CardName .. ", ²»ÓÃÖØ¸´¼¤»î.")
        return 0
    end
    ClearItem(6, 1, CardIndex, 1)
    ClearItem(6, 1, CardIndex, 0)
    SetTaskByte(G_Task[1], G_Task[2], G_Pet)
    SetTaskBit(PetRoleCombosTask, G_bit, 1)
    Msg2Player("Chóc mõng ngµi thµnh c«ng kÝch ho¹t tæ hîp Linh Sñng " .. CardName .. ", cã thÓ dïng Hép Linh Sñng B¸ch BiÕn triÖu håi tæ hîp linh sñng.")
    WriteLog("[KÝch ho¹t Tæ hîp kü][¾íÖá¼¤»î]" .. CardName)
    Talk(1, "no", "Chóc mõng ngµi thµnh c«ng kÝch ho¹t tæ hîp Linh Sñng <c=y>" .. CardName .. "<c>, cã thÓ dïng Hép Linh Sñng B¸ch BiÕn triÖu håi tæ hîp linh sñng.")
    if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
        ClearItem(6, 1, 1594, 0)
        ClearItem(6, 1, 1594, 1)
        AddNormalItem(6, 1, 1594, 0, 0, 0)
    end
end

function no()
    CloseDialog()
end;

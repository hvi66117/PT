require("ÊôĞÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")
CardName = "Th¸i Êt Kim Tiªn"
Item_Id = { 6, 1, 1475, 1 }
TaskTable = Able_Pet.TaskTable_TaiYi
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
    Able_Pet.ChangePet()
    SetTaskByte(Able_Pet.TaiYi_Pet, 1, 1)
    SetTaskByte(Able_Pet.TaiYi_Pet, 2, cardlevel)

    Able_Pet.Xuanwu()

    PetSetType(70)
    Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh Th¸i Êt Ch©n Nh©n.")
    AddIBBuff(TaskTable[cardlevel].buffid)
    TaiYiSkill()
    ORACLEBONE.GetCardWayApply(38, 5)
    ORACLEBONE.GetCardWayApply(39, 5)
    no()
end
function shop()
    no()
    Sale(1)
end

function no()
    CloseDialog()
end;

function TaiYiSkill()
    local t_BuffList = {
        [1] = { buffname = "Ma Phong", buffid = 1871, pro = 10, tips = "Ma Phong, xuÊt chiªu Ma ph¸p +5%" },
        [2] = { buffname = "Vâ Vâ", buffid = 1872, pro = 10, tips = "Vâ Vâ, xuÊt chiªu Vò khİ +5%" },
        [3] = { buffname = "T¨ng lùc", buffid = 1873, pro = 10, tips = "T¨ng lùc, S¸t th­¬ng c¬ b¶n+35 ®iÓm" },
        [4] = { buffname = "Ho¶ Liªm", buffid = 1874, pro = 10, tips = "Ho¶ Liªm, Ho¶ S¸t +35 ®iÓm" },
        [5] = { buffname = "MÉn TËt", buffid = 1875, pro = 26, tips = "MÉn TËt, NĞ tr¸nh +50 ®iÓm" },
        [6] = { buffname = "Kim Ngù", buffid = 1876, pro = 26, tips = "Kim Ngù, lùc Phßng ngù +50 ®iÓm" },
        [7] = { buffname = "Ph¸p Chó", buffid = 1877, pro = 4, tips = "Ph¸p Chó, tû lÖ b¹o kİch Ph¸p thuËt +2%" },
        [8] = { buffname = "Vâ Chó", buffid = 1878, pro = 4, tips = "Vâ Chó, tû lÖ b¹o kİch +2%" },
    }
    local rannum = math.random(1, 100)
    local sumpro = 0
    for i = 1, table.getn(t_BuffList) do
        sumpro = sumpro + t_BuffList[i].pro
        if (rannum <= sumpro) then
            AddIBBuff(t_BuffList[i].buffid, 10)
            ScrollMessage(t_BuffList[i].tips)
            break
        end
    end
end

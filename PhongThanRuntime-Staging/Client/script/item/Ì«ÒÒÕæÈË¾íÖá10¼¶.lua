require(" Ù–‘¡È≥Ë.luax")
require("º◊π«ŒƒªÓ∂Ø.luax")
CardName = "Th∏i  t Ch©n Nh©n"
Item_Id = { 6, 1, 1474, 1 }
TaskTable = Able_Pet.TaskTable_TaiYi
cardlevel = 10

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
    SetTaskByte(Able_Pet.TaiYi_Pet, 1, 1)
    SetTaskByte(Able_Pet.TaiYi_Pet, 2, cardlevel)

    Able_Pet.Xuanwu()

    PetSetType(TaskTable[cardlevel].petid)
    Msg2Player("H◊nh t≠Óng Linh sÒng cÒa ngµi bi’n thµnh Th∏i  t Ch©n Nh©n.")
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
        [1] = { buffname = "Ma Phong", buffid = 1871, pro = 10, tips = "Ma Phong, xu t chi™u Ma ph∏p +5%" },
        [2] = { buffname = "V‚ V‚", buffid = 1872, pro = 10, tips = "V‚ V‚, xu t chi™u VÚ kh› +5%" },
        [3] = { buffname = "T®ng l˘c", buffid = 1873, pro = 10, tips = "T®ng l˘c, S∏t th≠¨ng c¨ b∂n+35 Æi”m" },
        [4] = { buffname = "Ho∂ Li™m", buffid = 1874, pro = 10, tips = "Ho∂ Li™m, Ho∂ S∏t +35 Æi”m" },
        [5] = { buffname = "M…n TÀt", buffid = 1875, pro = 26, tips = "M…n TÀt, N– tr∏nh +50 Æi”m" },
        [6] = { buffname = "Kim Ng˘", buffid = 1876, pro = 26, tips = "Kim Ng˘, l˘c Phﬂng ng˘ +50 Æi”m" },
        [7] = { buffname = "Ph∏p ChÛ", buffid = 1877, pro = 4, tips = "Ph∏p ChÛ, t˚ l÷ bπo k›ch Ph∏p thuÀt +2%" },
        [8] = { buffname = "V‚ ChÛ", buffid = 1878, pro = 4, tips = "V‚ ChÛ, t˚ l÷ bπo k›ch +2%" },
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

PetRoleCombosTask = 2199

require("ÊôÐÔÁé³è.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")
AllPetTable = Able_Pet.AllPetTable
L_PETCOMBOS = Able_Pet.L_PETCOMBOS
TaskTable_NewAllPet = Able_Pet.TaskTable_NewAllPet
TaskTable_AllPet2New = Able_Pet.TaskTable_AllPet2New

temp_boxidx = {
    [1] = { 140, 2 },
    [2] = { 140, 3 },
    [3] = { 140, 4 },
    [4] = { 141, 1 },
    [5] = { 141, 2 },
    [6] = { 141, 3 },
    [7] = { 141, 4 },
    [8] = { 142, 1 },
    [9] = { 142, 2 },
    [10] = { 142, 3 },
    [11] = { 142, 4 },
    [12] = { 143, 1 },
}

function no()
    CloseDialog()
end;

function main()
    local tasks = {
        { "<c=g>Danh s¸ch thó thuéc tÝnh<c>", "mainPetMain"; show = 1 },
        { "<c=y>Tæ hîp Kü n¨ng Linh thó<c>", "PetCombosList"; show = 1 },
        { "Göi BiÕn Th©n Phï", "PetBox"; show = 1 },
    }
    SayTask("Mçi thó c­ng thuéc tÝnh giíi h¹n ®Òu cã siªu kü n¨ng, cã thÓ gióp anh hïng chu du Tam Giíi trong Phong ThÇn thªm dÔ dµng.", tasks)
end

function mainPetMain()
    CloseDialog()
    local tasks = {
        { "Trang 1", "mainPet"; show = 1 },
        { "Trang 2", "mainPet2"; show = 1 },
        { "Tr­íc", "main"; show = 1 },
    }
    SayTask("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô dïng ®Ó l­u tr÷ tÊt c¶ c¸c lo¹i biÕn th©n phï Linh Sñng VÜnh viÔn, sau khi l­u biÕn th©n phï t¹i chç ta, cã thÓ dïng Hép B¸ch BiÕn ®Ó biÕn ho¸ Linh sñng thay cho biÕn th©n phï. LÇn ®Çu l­u biÕn th©n phï sÏ nhËn ®­îc 1 Hép B¸ch BiÕn..", tasks)
end

function mainPet()
    CloseDialog()
    local tSayTable = {}
    local nTask = {}
    local idx = 0
    local petboxlist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    tSayTable[1] = "<c=g>Trë l¹i<c>/mainPetMain"
    for i = 81, 88 do
        nTask = AllPetTable[i].useTask
        if (GetTaskBit(nTask[1], nTask[2]) == 1) then
            tSayTable[getn(tSayTable) + 1] = AllPetTable[i].itemname .. " (Hoµng Kim)/selPetBox"
            petboxlist[i - 80] = i
        end
    end

    for i = 0, 7 do
        for j = 10, 1, -1 do
            idx = j + i * 10
            nTask = AllPetTable[idx].useTask
            if (GetTaskBit(nTask[1], nTask[2]) == 1) then
                if (petboxlist[i + 1] >= 1) then
                    break
                else
                    petboxlist[i + 1] = idx
                    tSayTable[getn(tSayTable) + 1] = AllPetTable[idx].itemname .. "(" .. AllPetTable[idx].lvl .. " cÊp)/selPetBox"
                    break
                end
            end
        end
    end

    local petList = {}
    for i = 1, getn(TaskTable_NewAllPet) do
        petList = TaskTable_NewAllPet[i].task
        for j = getn(petList), 1, -1 do
            nTask = petList[j].useTask
            if (GetTaskBit(nTask[1], nTask[2]) == 1) then
                if (petList[j].lvl == 11) then
                    tSayTable[getn(tSayTable) + 1] = petList[j].itemname .. " (Hoµng Kim)/selPetBox"
                else
                    tSayTable[getn(tSayTable) + 1] = TaskTable_NewAllPet[i].petname .. "(" .. petList[j].lvl .. " cÊp)/selPetBox"
                end
                break
            end
        end
    end

    Say("Chän h×nh t­îng Linh sñng ngµi muèn biÕn th©n:", getn(tSayTable), tSayTable)
end

function selPetBox(nIndex)
    CloseDialog()
    if (nIndex <= 0) then
        return
    end

    local key = 0
    local nTask = {}
    local idx = 0
    local petboxlist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local nName = ""
    local lvl = 0

    for i = 81, 88 do
        nTask = AllPetTable[i].useTask
        if (GetTaskBit(nTask[1], nTask[2]) == 1) then
            key = key + 1
            petboxlist[i - 80] = i
        end

        if (key == nIndex) then
            idx = i
            nName = AllPetTable[idx].itemname
            break
        end
    end

    if (idx == 0) then
        for i = 0, 7 do
            for j = 10, 1, -1 do
                idx = j + i * 10
                nTask = AllPetTable[idx].useTask
                if (GetTaskBit(nTask[1], nTask[2]) == 1) then
                    if (petboxlist[i + 1] >= 1) then
                        break
                    else
                        petboxlist[i + 1] = idx
                        key = key + 1
                        break
                    end
                end
            end
            idx = 0

            if (key == nIndex) then
                idx = petboxlist[i + 1]
                break
            end
        end
    end

    if (idx == 0) then
        local petList = {}
        for i = 1, getn(TaskTable_NewAllPet) do
            lvl = 0
            petList = TaskTable_NewAllPet[i].task
            for j = getn(petList), 1, -1 do
                nTask = petList[j].useTask
                if (GetTaskBit(nTask[1], nTask[2]) == 1) then
                    key = key + 1
                    lvl = j
                    break
                end
            end

            if (key == nIndex) then
                idx = i * 100 + lvl
                nName = TaskTable_NewAllPet[i].petname
                if (lvl < 11) then
                    Able_Pet.JudgeAndDel(nName, nTask[1], nTask[2], 0, idx)
                    if (GetTaskBit(nTask[1], nTask[2]) == 0) then
                        Talk(1, "mainPet", "Xin lçi, ngµi kh«ng phï hîp ®iÒu kiÖn " .. nName .. ", biÕn th©n phï bÞ thu håi..")
                        WriteLog("[Linh Sñng Thuéc TÝnh][Sñng vËt trong hép " .. nName .. " kh«ng phï hîp ®iÒu kiÖn, bÞ thu håi]")
                        return
                    end
                end
                break
            end
        end
    elseif (idx <= 80) then
        nName = AllPetTable[idx].itemname
        nTask = AllPetTable[idx].useTask
        Able_Pet.JudgeAndDel(nName, nTask[1], nTask[2], 0, idx)
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
            Talk(1, "mainPet", "Xin lçi, ngµi kh«ng phï hîp ®iÒu kiÖn " .. nName .. ", biÕn th©n phï bÞ thu håi..")
            WriteLog("[Linh Sñng Thuéc TÝnh][Sñng vËt trong hép " .. nName .. " kh«ng phï hîp ®iÒu kiÖn, bÞ thu håi]")
            return
        end
    end

    SetTask(143, idx)
    local menu = {
        { "BiÕn h×nh", "main_pet"; show = 0 },
        { "BiÕn h×nh", "main_petNew"; show = 0 },
        { "TiÖm tuú th©n", "shop"; show = 0 },
        { "Quay l¹i", "mainPet"; show = 1 },
    }
    local petlvl = 0
    if (idx > 100) then
        petlvl = lvl
        menu[2].show = 1
    else
        petlvl = AllPetTable[idx].lvl
        menu[1].show = 1
    end

    if (petlvl >= 5) then
        menu[3].show = 1
    end
    SayTask("Ngµi cã muèn biÕn th©n Sñng vËt thµnh <c=y>" .. nName .. "<c>?\nMêi lùa chän:", menu)
end

function shop()
    no()
    Sale(1)
end

function main_pet()
    no()

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

    local idx = GetTask(143)
    local nName = AllPetTable[idx].itemname
    local petid = AllPetTable[idx].petid
    local cardlevel = AllPetTable[idx].lvl
    Able_Pet.ChangePet()

    SetTaskByte(AllPetTable[idx].taskvalue[1], 1, 1)
    SetTaskByte(AllPetTable[idx].taskvalue[1], 2, cardlevel)

    if (cardlevel >= 8) then
        Able_Pet.Xuanwu()
    end

    PetSetType(petid)
    AddIBBuff(AllPetTable[idx].buffid)
    if (petid == 69) or (petid == 70) then
        TaiYiSkill()
    elseif (petid == 53) or (petid == 84) then
        if (GetTaskByte(Able_Pet.Break_NeZhaPet, 2) == 0) then
            PetModifyProtect(1)
            SetTaskByte(Able_Pet.Break_NeZhaPet, 2, 1)
            Msg2Player("Áé³èNa Tra gióp ngµi t¨ng 1 lÇn Linh Sñng Hé Chñ.")
        end
    end

    Msg2Player("Linh sñng cña ngµi ®· biÕn th©n thµnh " .. nName .. "!")
    ScrollMessage("Linh sñng cña ngµi ®· biÕn th©n thµnh <c=g>" .. nName)
    WriteLog("[Hép Linh Sñng]" .. nName .. cardlevel)

    local petTypeIdx = 1
    if (idx > 80) then
        petTypeIdx = idx - 80
    else
        petTypeIdx = math.floor((idx + 9) / 10)
    end

    ORACLEBONE.GetCardWayApply(38, petTypeIdx)
    ORACLEBONE.GetCardWayApply(39, petTypeIdx)

end

function main_petNew()
    no()

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

    local idx = GetTask(143)
    local nIndex = math.floor(idx / 100)
    if (nIndex <= 0) or (nIndex > getn(TaskTable_NewAllPet)) then
        Talk(1, "no", "ThËt xin lçi, biÕn th©n thÊt b¹i, vui lßng chän l¹i!")
        return
    end

    local temp = TaskTable_NewAllPet[nIndex]
    local lvl = math.mod(idx, 100)
    if (lvl < 1) or (lvl > 11) then
        Talk(1, "no", "ThËt xin lçi, cÊp biÕn th©n kh«ng ®óng, vui lßng chän l¹i!")
        return
    end

    local nName = temp.petname
    Able_Pet.ChangePet()

    SetTaskByte(temp.taskvalue[1], 1, 1)
    SetTaskByte(temp.taskvalue[1], 2, lvl)

    if (lvl >= 8) then
        Able_Pet.Xuanwu()
    end

    PetSetType(temp.task[lvl].petid)
    AddIBBuff(temp.task[lvl].buffid)

    Msg2Player("Linh sñng cña ngµi ®· biÕn th©n thµnh " .. nName .. "!")
    ScrollMessage("Linh sñng cña ngµi ®· biÕn th©n thµnh <c=g>" .. nName)
    WriteLog("[Hép Linh Sñng]" .. nName .. lvl)

    local petTypeIdx = nIndex + 8

    ORACLEBONE.GetCardWayApply(38, petTypeIdx)
    ORACLEBONE.GetCardWayApply(39, petTypeIdx)

end

function TaiYiSkill()
    local t_BuffList = {
        [1] = { buffname = "Ma Phong", buffid = 1871, pro = 10, tips = "Ma Phong, xuÊt chiªu Ma ph¸p +5%" },
        [2] = { buffname = "Vâ Vâ", buffid = 1872, pro = 10, tips = "Vâ Vâ, xuÊt chiªu Vò khÝ +5%" },
        [3] = { buffname = "T¨ng lùc", buffid = 1873, pro = 10, tips = "T¨ng lùc, s¸t th­¬ng c¬ b¶n +35 ®iÓm" },
        [4] = { buffname = "Ho¶ Liªm", buffid = 1874, pro = 10, tips = "Ho¶ Liªm, Ho¶ S¸t +35 ®iÓm" },
        [5] = { buffname = "MÉn TËt", buffid = 1875, pro = 26, tips = "MÉn TËt, NÐ tr¸nh +50 ®iÓm" },
        [6] = { buffname = "Kim Ngù", buffid = 1876, pro = 26, tips = "Kim Ngù, lùc Phßng ngù +50 ®iÓm" },
        [7] = { buffname = "Ph¸p Chó", buffid = 1877, pro = 4, tips = "Ph¸p Chó, tû lÖ b¹o kÝch Ph¸p thuËt +2%" },
        [8] = { buffname = "Vâ Chó", buffid = 1878, pro = 4, tips = "Vâ Chó, tû lÖ b¹o kÝch +2%" },
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

function PetBox()
    local tasks = {
        { "<c=y>L­u tÊt c¶ vµo hép Linh Sñng<c>", "allinbox"; show = 1 },
        { "<c=g>L­u chØ ®Þnh<c>", "SavePetItemMain"; show = 1 },
        { "Tr­íc", "main"; show = 1 },
    }
    SayTask("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô dïng ®Ó l­u tr÷ tÊt c¶ c¸c lo¹i biÕn th©n phï Linh Sñng VÜnh viÔn, sau khi göi biÕn th©n phï t¹i ®©y, cã thÓ dïng Hép Linh Sñng B¸ch BiÕn ®Ó biÕn th©n Linh Sñng.", tasks)
end

function SavePetItemMain()
    local tasks = {
        { "Trang 1", "SavePetItem"; show = 1 },
        { "Trang 2", "SavePetItem2"; show = 1 },
        { "Tr­íc", "PetBox"; show = 1 },
    }
    SayTask("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô dïng ®Ó l­u tr÷ tÊt c¶ c¸c lo¹i biÕn th©n phï Linh Sñng VÜnh viÔn, sau khi l­u biÕn th©n phï t¹i chç ta, cã thÓ dïng Hép B¸ch BiÕn ®Ó biÕn ho¸ Linh sñng thay cho biÕn th©n phï. LÇn ®Çu l­u biÕn th©n phï sÏ nhËn ®­îc 1 Hép B¸ch BiÕn..", tasks)
end

function SavePetItem()
    local opra = {
        "Hå HØ MÞ/AblePetbox",
        "Na Tra/NeZhabox",
        "L«i ChÊn Tö/LeiZhenZibox",
        "Th¹ch C¬ N­¬ng N­¬ng/ShiJibox",
        "Th¸i Êt Ch©n Nh©n/TaiYibox",
        "§¸t Kû/DaJibox",
        "Th©n C«ng B¸o/ShenGongBaobox",
        "Hoµng Phi Hæ/HuangFeiHubox",
        "Hao Thiªn KhuyÓn/XiaoTianQuanbox",
        "D­¬ng TiÔn/YangJanbox",
        "Kh­¬ng Tö Nha/JiangZiYabox",
        "Lý TÞnh/LiJingbox",
        "Phi Th¨ng-Hå HØ MÞ/AblePetUpbox",
        "Phi Th¨ng-Na Tra/SuperNezhaUpbox",
        "Phi Th¨ng-L«i ChÊn Tö/SuperLeiZhenZi",
        "Phi Th¨ng-Th¹ch C¬/SuperShiJi",
        "Phi Th¨ng-Th¸i Êt/SuperTaiYi",
        "Phi Th¨ng-§¸t Kû/SuperDaJi",
        "Phi Th¨ng-Th©n C«ng B¸o/SuperShenGongBao",
        "Phi Th¨ng-Hoµng Phi Hæ/SuperHuangFeiHu",
        "Phi Th¨ng-Hao Thiªn KhuyÓn/SuperXiaoTianQuan",
        "Phi Th¨ng-D­¬ng TiÔn/SuperYangJanbox",
        "Phi Th¨ng-Kh­¬ng Tö Nha/SuperJiangZiYabox",
        "Phi Th¨ng-Lý TÞnh/SuperLiJingbox",
        "<c=y>Trë l¹i<c>/PetBox",
    }
    Say("Chän lo¹i BiÕn th©n phï ngµi muèn l­u:", table.getn(opra), opra)
end

function SavePetItemYes()
    local pettype = GetTaskByte(140, 1) - 1
    if (pettype < 0) then
        Talk(1, "SavePetItemMain", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    end

    local Lmin = 1 + pettype * 10
    local Lmax = 10 + pettype * 10
    local tempList = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local key = 0

    for i = 1, 11 do
        tempList[i] = GetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2])
        if (tempList[i] > 0) then
            key = key + 1
        end
    end
    SetTask(140, 0)
    SetTask(141, 0)
    SetTask(142, 0)
    if (key == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBox(Lmin, Lmax, pettype, tempList) == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end
end

function SavePetItem2()
    local opra = {
        "Lôc ¸p §¹o Nh©n/SuperNew2box",
        "<c=y>Trë l¹i<c>/SavePetItemMain",
    }
    Say("Chän lo¹i BiÕn th©n phï ngµi muèn l­u:", table.getn(opra), opra)
end

function SuperNew2box(nIndex)
    nIndex = nIndex + 25
    if (nIndex <= 24) or (nIndex > table.getn(Able_Pet.t_GetPetRight)) then
        no()
        return 0
    end
    local key, str = Able_Pet.PetBoxInfoNew2(nIndex)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem2", "no")
    else
        SetTask(140, nIndex)
        SetTaskByte(140, 2, key)

        MsgBox(str, "SavePetItem2YesNew", "SavePetItem2")
    end
end

function SavePetItem2YesNew()
    local pettype = GetTaskByte(140, 1)

    if (pettype < 0) then
        Talk(1, "no", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    elseif (pettype < 9) then
        SavePetItemYes()
        return 0
    elseif (pettype < 25) then
        SavePetItemYesNew()
        return 0
    end

    local idx = GetTaskByte(140, 2)
    SetTask(140, 0)

    if (idx == 0) then
        Talk(1, "SavePetItem2", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBoxNew2(idx, pettype) == 0) then
        Talk(1, "SavePetItem2", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem2", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end

end

function allinbox()
    local str = "Ngµi x¸c ®Þnh ®em tÊt c¶ biÕn th©n phï d­íi ®©y cho vµo Hép B¸ch BiÕn chø? <c=r>Huû bá sÏ quay l¹i lùa chän tr­íc<c>\n"
    local id = { 0, 0, 0, 0 }
    local petList = {}
    local key = 0
    for i = 81, 88 do
        id = AllPetTable[i].itemid
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=y>" .. AllPetTable[i].itemname .. "<c>  "
            key = key + 1
        end
    end

    for i = 1, 80 do
        id = AllPetTable[i].itemid
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=g>" .. AllPetTable[i].itemname .. "(" .. AllPetTable[i].lvl .. " cÊp)<c>  "
            key = key + 1
        end
    end

    for i = 1, getn(TaskTable_NewAllPet) do
        petList = TaskTable_NewAllPet[i].task
        for j = 1, getn(petList) do
            id = petList[j].id
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                if (petList[j].lvl == 11) then
                    str = str .. "<c=y>" .. petList[j].itemname .. "<c>  "
                else
                    str = str .. "<c=g>" .. TaskTable_NewAllPet[i].petname .. "(" .. petList[j].lvl .. " cÊp)<c>  "
                end
                key = key + 1
            end
        end
    end

    for i = 1, getn(TaskTable_AllPet2New) do
        id = TaskTable_AllPet2New[i].id
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            str = str .. "<c=g>" .. TaskTable_AllPet2New[i].petname .. "<c>  "
            key = key + 1
        end
    end

    if (key == 0) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "PetBox", "no")
    else
        MsgBox(str, "allinboxYes", "PetBox")
    end
end

function allinboxYes()
    local list = {}
    local str = ""
    local idx = 0
    local id = { 0, 0, 0, 0 }
    local name = ""
    local key = 0

    for i = 0, 7 do
        for j = 1, 10 do
            idx = j + i * 10
            id = AllPetTable[idx].itemid
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                name = AllPetTable[idx].itemname
                if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                    ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. name .. "(" .. AllPetTable[idx].lvl .. ")")
                    str = str .. name .. " (CÊp " .. AllPetTable[idx].lvl .. ")"
                    SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
                    key = 1
                end
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end

        if (i < 8) then
            idx = 81 + i
            id = AllPetTable[idx].itemid
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. AllPetTable[idx].itemname)
                str = str .. AllPetTable[idx].itemname .. ", "
                SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
                key = 1
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    local cstr = ""
    for i = 1, getn(TaskTable_NewAllPet) do
        petList = TaskTable_NewAllPet[i].task
        for j = 1, getn(petList) do
            id = petList[j].id
            if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
                if (petList[j].lvl == 11) then
                    cstr = petList[j].itemname
                    ScrollMessage("Thµnh c«ng thu n¹p <c=g>" .. cstr)
                    str = str .. cstr .. ", "
                    SetTaskBit(petList[j].useTask[1], petList[j].useTask[2], 1)
                    key = 1
                else
                    name = TaskTable_NewAllPet[i].petname
                    if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                        cstr = name .. " (" .. petList[j].lvl .. ")"
                        ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. cstr)
                        str = str .. cstr .. ", "
                        SetTaskBit(petList[j].useTask[1], petList[j].useTask[2], 1)
                        key = 1
                    end
                end
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    for i = 1, getn(TaskTable_AllPet2New) do
        id = TaskTable_AllPet2New[i].id
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
            name = TaskTable_AllPet2New[i].petname
            if (Able_Pet.JudgeAndDel(name, id[1], id[2], id[3], id[4]) == 0) then
                ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. name)
                str = str .. name .. ", "
                SetTaskBit(TaskTable_AllPet2New[i].useTask[1], TaskTable_AllPet2New[i].useTask[2], 1)
                key = 1
            end

            for k = 0, 1 do
                ClearItem(id[1], id[2], id[3], k)
            end
        end
    end

    if (key == 0) then
        Talk(1, "no", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
            AddNormalItem(6, 1, 1594, 0, 0, 0)
            Msg2Player("Ngµi thµnh c«ng thu n¹p " .. str .. " ®ång thêi nhËn ®­îc 1 Hép Linh Sñng B¸ch BiÕn.")
        else
            Msg2Player("Ngµi thµnh c«ng thu n¹p " .. str .. " ®Òu ®· ®­îc bá vµo bªn trong Hép Linh Sñng B¸ch BiÕn")
        end
        Talk(1, "no", "TÊt c¶ biÕn th©n phï cña ngµi ®Òu ®· ®­îc bá vµo bªn trong <c=g>Hép Linh Sñng B¸ch BiÕn<c>")
        WriteLog("[Hép Linh Sñng B¸ch BiÕn]" .. str)
    end
end

function AblePetbox()
    SetTask(140, 1)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(1, 10, 81, 0)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function NeZhabox()
    SetTask(140, 2)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(11, 20, 82, 1)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function LeiZhenZibox()
    SetTask(140, 3)
    SetTask(141, 0)
    SetTask(142, 0)

    local key, str, tempList = Able_Pet.PetBoxInfo(21, 30, 83, 2)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function ShiJibox()
    SetTask(140, 4)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(31, 40, 84, 3)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function TaiYibox()
    SetTask(140, 5)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(41, 50, 85, 4)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function DaJibox()
    SetTask(140, 6)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(51, 60, 86, 5)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function ShenGongBaobox()
    SetTask(140, 7)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(61, 70, 87, 6)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function HuangFeiHubox()
    SetTask(140, 8)
    SetTask(141, 0)
    SetTask(142, 0)
    local key, str, tempList = Able_Pet.PetBoxInfo(71, 80, 88, 7)

    if (key == 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                SetTaskByte(temp_boxidx[i][1], temp_boxidx[i][2], tempList[i])
            end
        end

        MsgBox(str, "SavePetItemYes", "SavePetItem")
    end
end

function SavePetItemYesNew()
    local pettype = GetTaskByte(140, 1)
    if (pettype < 0) then
        Talk(1, "PetBox", "ThËt xin lçi, d÷ liÖu bÊt th­êng, xin thö l¹i.")
        return 0
    elseif (pettype < 9) then
        SavePetItemYes()
        return 0
    elseif (pettype > 24) then
        SavePetItem2YesNew()
        return 0
    end

    local idx = GetTaskByte(140, 2)
    local tempList = GetTaskWord(140, 2)
    SetTask(140, 0)
    if (tempList == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
        return 0
    end

    if (Able_Pet.setSavePetBoxNew(idx, pettype, tempList) == 0) then
        Talk(1, "SavePetItem", "Xin lçi, ngµi kh«ng cã biÕn th©n phï cña Linh sñng lo¹i nµy, xin chän l¹i!")
    else
        Talk(1, "SavePetItem", "BiÕn th©n phï ngµi chän ®· ®­îc bá vµo Hép Linh Sñng B¸ch BiÕn råi!")
    end

end

function XiaoTianQuanbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(9)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 9)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function YangJanbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(10)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 10)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function JiangZiYabox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(11)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 11)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function LiJingbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(12)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 12)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function AblePetUpbox()
    local key, str, tempList = Able_Pet.PetBoxInfoNew(13)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 13)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperNezhaUpbox()

    local key, str, tempList = Able_Pet.PetBoxInfoNew(14)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 14)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperLeiZhenZi()

    local key, str, tempList = Able_Pet.PetBoxInfoNew(15)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, 15)
        SetTaskByte(140, 2, key)
        for i = 1, 12 do
            if (tempList[i] ~= nil and tempList[i] == i) then
                SetTaskBit(140, 16 + i, 1)
            end
        end
        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperShiJi()
    local nIdx = 16
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperTaiYi()
    local nIdx = 17
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperDaJi()
    local nIdx = 18
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperShenGongBao()
    local nIdx = 19
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperHuangFeiHu()
    local nIdx = 20
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperXiaoTianQuan()
    local nIdx = 21
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperYangJanbox()
    local nIdx = 22
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperJiangZiYabox()
    local nIdx = 23
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function SuperLiJingbox()
    local nIdx = 24
    local key, str, tempList = Able_Pet.PetBoxInfoNew(nIdx)

    if (key <= 0) or (str == "") or (str == nil) then
        MsgBox("Ngµi kh«ng cã Sñng vËt cã thÓ l­u tr÷, <c=r>NhÊn X¸c ®Þnh ®Ó trë l¹i, Huû bá ®Ó ®ãng<c>\n", "SavePetItem", "no")
    else
        SetTask(140, nIdx)
        SetTaskByte(140, 2, key)
        for i = 1, 11 do
            if (tempList[i] ~= nil) then
                if (tempList[i] == i) then
                    SetTaskBit(140, 16 + i, 1)
                end
            end
        end

        MsgBox(str, "SavePetItemYesNew", "SavePetItem")
    end
end

function PetCombosList()
    local tSayTable = {}
    local nTask = {}
    local idx = 0
    tSayTable[1] = "<c=g>Trë l¹i<c>/main"
    for i = 1, getn(L_PETCOMBOS) do
        nTask = L_PETCOMBOS[i].taskIdx
        if (GetTaskByte(nTask[1], nTask[2]) == L_PETCOMBOS[i].petID) then
            tSayTable[getn(tSayTable) + 1] = L_PETCOMBOS[i].name .. "/selPetCombos"
        end
    end

    Say("Hép Linh Sñng B¸ch BiÕn lµ ®¹o cô gióp l­u tr÷ c¸c biÕn th©n phï VÜnh viÔn cña Sñng vËt, hiÖn ngµi cã c¸c Linh thó ®· Tæ hîp Kü n¨ng d­íi ®©y. Chän h×nh t­îng Linh sñng ngµi muèn biÕn th©n:", getn(tSayTable), tSayTable)
end

function selPetCombos(nIndex)
    CloseDialog()
    if (nIndex <= 0) or (nIndex > getn(L_PETCOMBOS)) then
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

    local key = 0
    local nTask = {}
    local idx = 0
    for i = 1, getn(L_PETCOMBOS) do
        nTask = L_PETCOMBOS[i].taskIdx
        if (GetTaskByte(nTask[1], nTask[2]) == L_PETCOMBOS[i].petID) then
            key = key + 1
            if (nIndex == key) then
                idx = i
                break
            end
        end
    end

    if (idx <= 0) then
        return 0
    end

    if (Able_Pet.JudgeCombos(idx) == 0) then
        Talk(1, "PetCombosList", "Xin lçi, ngµi kh«ng cã ®ñ ®iÒu kiÖn cho " .. L_PETCOMBOS[idx].name .. ", tæ hîp kü bÞ thu håi.")
        return 0
    end

    SetTask(143, idx)
    local menu = {
        { "BiÕn h×nh", "main_PetCombos"; show = 1 },
        { "TiÖm tuú th©n", "shop"; show = 1 },
        { "Quay l¹i", "PetCombosList"; show = 1 },
    }
    SayTask("Ngµi cã muèn biÕn th©n Sñng vËt thµnh <c=y>" .. L_PETCOMBOS[idx].name .. "<c>?\n" .. L_PETCOMBOS[idx].info .. "\nMêi lùa chän:", menu)
end

function main_PetCombos()
    no()
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

    local nIndex = GetTask(143)
    if (nIndex <= 0) or (nIndex > getn(L_PETCOMBOS)) then
        return
    end

    local nName = L_PETCOMBOS[nIndex].name
    local petid = L_PETCOMBOS[nIndex].petID
    Able_Pet.JudgeCombos(nIndex)
    if (GetTaskByte(L_PETCOMBOS[nIndex].taskIdx[1], L_PETCOMBOS[nIndex].taskIdx[2]) ~= petid) then
        Talk(1, "no", "Linh sñng cña ngµi kh«ng phï hîp ®iÒu kiÖn, kh«ng thÓ kÝch ho¹t Tæ hîp kü.")
        return
    end

    Able_Pet.ChangePet()
    Able_Pet.Xuanwu()

    PetSetType(petid)
    AddIBBuff(L_PETCOMBOS[nIndex].buff)
    if (petid == 104) then
        TaiYiSkill()
        if (GetTaskByte(2215, 3) == 0) then
            PetModifyProtect(1)
            SetTaskByte(2215, 3, 1)
            Msg2Player("Tæ hîp kü " .. nName .. " gióp ngµi t¨ng 1 lÇn Linh Sñng Hé Chñ.")
        end

        if (GetTaskByte(Able_Pet.Break_NeZhaPet, 2) == 0) then
            PetModifyProtect(1)
            SetTaskByte(Able_Pet.Break_NeZhaPet, 2, 1)
            Msg2Player("Linh sñng Na Tra gióp ngµi t¨ng 1 lÇn Linh Sñng Hé Chñ.")
        end
    end

    Msg2Player("Linh sñng cña ngµi ®· biÕn th©n thµnh " .. nName .. "!")
    ScrollMessage("Linh sñng cña ngµi ®· biÕn th©n thµnh <c=y>" .. nName)
    WriteLog("[Hép Linh Sñng][Tæ hîp kü]" .. nName)
end

function mainPet2()
    CloseDialog()
    local tSayTable = {}
    local nTask = {}
    local idx = 0
    tSayTable[1] = "<c=g>Trë l¹i<c>/mainPetMain"

    for i = 1, getn(TaskTable_AllPet2New) do
        nTask = TaskTable_AllPet2New[i].useTask
        if (GetTaskBit(nTask[1], nTask[2]) == 1) then
            id = TaskTable_AllPet2New[i].id
            tSayTable[getn(tSayTable) + 1] = TaskTable_AllPet2New[i].petname .. "/selPetBox2"
        end
    end
    Say("Chän h×nh t­îng Linh sñng ngµi muèn biÕn th©n:", getn(tSayTable), tSayTable)
end

function selPetBox2(nIndex)
    CloseDialog()
    if (nIndex <= 0) or (nIndex > getn(TaskTable_AllPet2New)) then
        return
    end

    local key = 0
    local nTask = {}
    local idx = 0
    local nName = TaskTable_AllPet2New[nIndex].petname

    nTask = TaskTable_AllPet2New[nIndex].useTask
    idx = nIndex * 200
    Able_Pet.JudgeAndDel(nName, nTask[1], nTask[2], 0, idx)
    if (GetTaskBit(nTask[1], nTask[2]) == 0) then
        Talk(1, "mainPet", "Xin lçi, ngµi kh«ng phï hîp ®iÒu kiÖn " .. nName .. ", biÕn th©n phï bÞ thu håi..")
        WriteLog("[Linh Sñng Thuéc TÝnh][Sñng vËt trong hép " .. nName .. " kh«ng phï hîp ®iÒu kiÖn, bÞ thu håi]")
        return
    end

    local menu = {
        { "BiÕn h×nh", "main_pet2New"; show = 1 },
        { "Quay l¹i", "mainPetMain"; show = 1 },
    }

    SetTask(143, nIndex)
    SayTask("Ngµi cã muèn biÕn th©n Sñng vËt thµnh <c=y>" .. nName .. "<c>?\nMêi lùa chän:", menu)
end

function main_pet2New()
    no()
    if (GetLevel() < 121 and GetNewBirthTimes() < 1) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®¹t 121, kh«ng thÓ biÕn th©n.")
        return 0
    end

    if (PetIsAdd() == 0) then
        Talk(1, "no", "Ch­a cã Linh Thó, kh«ng thÓ biÕn th©n. ")
        return
    elseif (PetIsSleep() == 1) then
        Talk(1, "no", "Linh Thó trong tr¹ng th¸i ngñ, kh«ng thÓ biÕn th©n.")
        return
    elseif (PetGetTime() < (1 * 60 * 60)) then
        Talk(1, "no", "Linh Thó ®ang trong tr¹ng th¸i Êp, kh«ng thÓ biÕn th©n. ")
        return
    end

    local nIndex = GetTask(143)
    if (nIndex <= 0) or (nIndex > getn(TaskTable_AllPet2New)) then
        Talk(1, "no", "ThËt xin lçi, biÕn th©n thÊt b¹i, vui lßng chän l¹i!")
        return
    end

    local temp = TaskTable_AllPet2New[nIndex]
    local lvl = GetTaskByte(temp.taskvalue[1], 2)
    if (lvl < 1) or (lvl > 11) then
        lvl = 1
        return
    end

    local nName = temp.petname
    Able_Pet.ChangePet()

    PetSetType(temp.petid)
    AddIBBuff(temp.task[lvl].buffid)

    SetTaskByte(temp.taskvalue[1], 1, 1)
    Msg2Player("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. lvl .. " (cÊp)-" .. nName)
    ScrollMessage("H×nh t­îng Linh sñng cña ngµi biÕn thµnh " .. lvl .. " (cÊp)-" .. nName)
    WriteLog("[Hép Linh Sñng]" .. nName .. lvl)

    local petTypeIdx = TaskTable_AllPet2New[nIndex].PetType

    ORACLEBONE.GetCardWayApply(38, petTypeIdx)
    ORACLEBONE.GetCardWayApply(39, petTypeIdx)

end

Task_qianxin = 1104;
Task_jiangyao = 1105;
Task_jiangyaoGuai1 = 1106;
Task_jiangyaoGuai2 = 1107;
Task_jiangyaoGuai3 = 1108;
Task_jiangyaoGuai4 = 1109;

Task_water = 1237

Task_newer13 = 1416

YIBO_90_DESASTER_STATE = 1662
ELEVEN_DAY_BUFF = 1240

Task_EggTime = 1668

MonsterEgg = { name = "Trøng Th«ng Linh", Item = { 6, 1, 797, 1, 0, 0 } }

Shien = { name = "S­ ¢n LÖnh", Item = { 3, 1088, 0, 0, 0, 0 } }

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1104)

        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(Task_jiangyao)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 10) then
                state = 3
                subState = 0
            elseif (taskProcess == 11) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 10) then
                state = 3
                subState = 1
            elseif (taskProcess == 11) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess < 5) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 6) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess < 5) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 63
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(Task_water) == 2) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(Task_water) == 2) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main(sel)
    tasks = {
        { "<c=yel>Tu luyÖn<c>", "qianxin"; show = 0 },
        { "<c=yel>Trõ yªu<c>", "jiangyaochumo"; show = 0 },
        { "<c=yel>Hñy n/v Trõ yªu<c>", "giveup_mo"; show = 0 },
        { "Tam Quang", "Lwater"; show = 0 },
        { "<c=yel>CÇm Kú Th­ Häa<c>", "renwu13"; show = 0 },
        { "<c=yel>Th©m Nan §o¹t VËt<c>", "renwu18"; show = 0 },
        { "<c=yel>DiÖt ThÇn KiÕp<c>", "Do_DesaterTask"; show = 0 },
        { "<c=yel>DiÖt ThÇn KiÕp<c>", "Do_DesaterOver"; show = 0 },
        { "<c=yel>ĞÂµÄÆğµã<c>", "NewLifeMain"; show = 0 },
    }
    if (GetPlayerType() == 1) then
        local nTaskStatus = GetTask(Task_jiangyao)
        if ((GetLevel() >= 10 and nTaskStatus == 0 and GetPlayerType() == 1) or nTaskStatus == 10) then
            tasks[2].show = 1
        end
        if (GetTask(Task_qianxin) == 1 and GetLevel() >= 10) then
            tasks[1].show = 1
        end
        if (HaveIBBuff(333) == 0 and nTaskStatus > 0 and nTaskStatus <= 10) then
            tasks[3].show = 1
        end

        local state13 = GetTaskByte(Task_newer13, 1)
        if (GetLevel() >= 10) and (state13 == 0 or state13 == 5) then
            tasks[5].show = 1
        end
    end

    if (GetTask(Task_water) == 2) then
        tasks[4].show = 1
    end
    local nLevel = GetLevel()
    local state = GetTaskByte(YIBO_90_DESASTER_STATE, 1)
    local bGetReward = GetTaskByte(YIBO_90_DESASTER_STATE, 3)
    if (state <= 1 and HaveIBBuff(ELEVEN_DAY_BUFF) > 0) then
        tasks[7].show = 1
    elseif (state == 2 and bGetReward == 0) then
        tasks[8].show = 1
    end

    if (GetPlayerType() == 1 and GetNewBirthTimes() == 1) then
        tasks[9].show = 1
        if (GetTaskBit(2089, 18) == 1) then
            tasks[9].show = 0
        end
    end

    SayTask(10526, tasks)
end;

function Do_DesaterOver()
    CloseDialog()
    local str = ""
    if (IsMantleMaster(PlayerIndex) > 0) then
        str = "Ng­¬i gióp ®å ®Ö v­ît qua kiÕp n¹n, muèn nhËn th­ëng ngay kh«ng?"
    else
        str = "Ng­¬i gióp ®å ®Ö v­ît qua kiÕp n¹n, muèn nhËn th­ëng ngay kh«ng?"
    end
    MsgBox(str, "Get_Rewoards", "no")
end

function Get_TeamState()
    if (GetTeamSize() == 2) then
        local mateIdx = 0
        local selfIdx = PlayerIndex
        if (IsCaptain() == 0) then
            mateIdx = GetTeamMember(1)
        else
            mateIdx = GetTeamMember(2)
        end
        local str = GetMantleMasterName()

        PlayerIndex = mateIdx
        local mateName = GetName()
        PlayerIndex = selfIdx

        if (mateName == str) then
            return 1
        else
            return 0
        end
    end
    return 0
end

function Get_Rewoards()
    CloseDialog()
    if (IsMantleMaster(PlayerIndex) > 0) then
        local item = Shien.Item
        for i = 1, 2 do
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
        end
        local addPRValue = AddMasterPRValue(8)
        TopMessage("Chóc mõng ng­¬i nhËn ®­îc thªm 2 <color=green>S­ ¢n LÖnh<c> vµ <color=green>" .. addPRValue .. "<c> ®iÓm S­ ®å")

    else

        AddOwnExp(500000)
        Msg2Player("V­ît qua kiÕp n¹n, ng­¬i nhËn ®­îc 500000 kinh nghiÖm!")
        TaskNote(1517, -1)
    end
    SetTaskByte(YIBO_90_DESASTER_STATE, 3, 1)
end

function Do_DesaterTask()
    CloseDialog()
    local nState = GetTaskByte(YIBO_90_DESASTER_STATE, 1)
    if (HaveIBBuff(ELEVEN_DAY_BUFF) > 0) then
        if (nState == 0) then
            local tState = Get_TeamState()
            if (tState == 1) then
                local mateIdx = 0
                local selfIdx = PlayerIndex
                if (IsCaptain() == 0) then
                    mateIdx = GetTeamMember(1)
                else
                    mateIdx = GetTeamMember(2)
                end

                PlayerIndex = mateIdx

                SetTaskByte(YIBO_90_DESASTER_STATE, 1, 1)

                PlayerIndex = selfIdx
                SetTaskByte(YIBO_90_DESASTER_STATE, 1, 1)

                Msg2Team("§¸nh b¹i <c=red>Bµn Cæ<c>, tho¸t khái kiÕp n¹n!")
                TaskNote(1517, 0)
                Talk(2, "no", "Anh hïng chí lo l¾ng. Ma v­¬ng <c=red>Bµn Cæ<c> muèn diÖt trõ ng­¬i tr­íc khi ng­¬i tu luyÖn thµnh c«ng. Víi søc m¹nh cña ng­¬i hiÖn t¹i e vÉn cÇn sù gióp ®ì cña Y B¸t S­ Phô.", "C¸c ng­¬i cã thÓ hµng phôc ma v­¬ng ®Ó ®é kiÕp n¹n nµy, nh­ng bÇn ®¹o cã 1 Trøng Th«ng Linh, cã thÓ t¹o ra hãa th©n cña ma v­¬ng, chØ cÇn hµng phôc hãa th©n nµy còng cã thÓ ng¨n chÆn viÖc ma v­¬ng muèn diÖt trõ ng­¬i.")
                return
            else
                InfoBox("Víi søc m¹nh hiÖn t¹i cña anh hïng e kh«ng thÓ qua ®­îc kiÕp n¹n nµy, h·y tæ ®éi víi Y B¸t S­ Phô!")
            end
        elseif (nState == 1) then
            local tasks = {
                { "NhËn Trøng Th«ng Linh", "Get_MonsterEgg"; show = 1 }
            }
            SayTask("Trøng Th«ng Linh cã thÓ t¹o ra hãa th©n cña ma v­¬ng, nh­ng vËt nµy cÇn sö dông Tiªn Lé 3 lÇn míi thµnh c«ng!", tasks)
        end
    elseif (HaveIBBuff(ELEVEN_DAY_BUFF) == 0 and IsMantlePrentice(PlayerIndex) == 0) then
        local task1 = GetTaskWord(1660, 2)
        local task2 = GetTask(1664)
        for i = 1657, 1668 do
            SetTask(i, 0)
        end
        SetTaskWord(1660, 2, task1)
        SetTask(1664, task2)
        SetTask(1670, 0)
        SetTask(1671, 0)
        Msg2Player("Ng­¬i vµ s­ phô ®· hñy quan hÖ s­ ®å, kh«ng thÓ v­ît qua kiÕp n¹n! NhiÖm vô bŞ hñy!")
    end
end

function Get_MonsterEgg()
    CloseDialog()
    if (Get_EggTime() == 1) then
        if (Check_EggExistance() == 0) then
            if (GetCash() < 2750000) then
                InfoBox("NhËn <c=g>Trøng Th«ng Linh<c> cÇn <c=g>275 v¹n b¹c<c>, hiÖn ng­¬i kh«ng ®ñ b¹c!")
                return
            end
            Pay(2750000)
            local item = MonsterEgg.Item
            ClearItem(item[1], item[2], item[3], item[4])
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
            local curTime = LocalSystemTime()
            SetTaskWord(Task_EggTime, 2, math.floor(curTime / 86400))
            Msg2Player("Ng­¬i nhËn ®­îc Trøng Th«ng Linh!")
        else
            InfoBox("Ng­¬i ®· cã 1 Trøng Th«ng Linh, víi kh¶ n¨ng cña ng­¬i, thø lçi ta kh«ng thÓ ®­a thªm Trøng Th«ng Linh cho ng­¬i n÷a!")
        end
    else
        InfoBox("H«m nay ng­¬i ®· nhËn Trøng Th«ng Linh råi!")
    end
end

function Get_EggTime()
    local lastTime = GetTaskWord(Task_EggTime, 2)
    local curTime = LocalSystemTime()

    if (lastTime == math.floor(curTime / 86400)) then
        return 0
    else
        return 1
    end
end

function Check_EggExistance()
    local item = MonsterEgg.Item
    local nCount = HaveItemInAllRoom(item[1], item[2], item[3], item[4], 0, 0, 0)
    return nCount
end

function giveup_mo()
    SetTask(Task_jiangyao, 0)
    SetTask(Task_jiangyaoGuai1, 0)
    SetTask(Task_jiangyaoGuai2, 0)
    SetTask(Task_jiangyaoGuai3, 0)
    SetTask(Task_jiangyaoGuai4, 0)
    refreshNpcTaskState()
    TaskNote(912, -1)
    if (HaveNormalItem(6, 1, 275, 1) >= 1) then
        DelNormalItem(6, 1, 275, 1)
    end
    TopMessage(12142)
    CloseDialog()
end
function jiangyaochumo()
    local nTaskStatus = GetTask(Task_jiangyao)
    if (GetLevel() >= 10 and nTaskStatus == 0 and GetPlayerType() == 1) then
        MsgBox(12143, "AcceptJiangyao", "no")
    elseif (nTaskStatus == 10) then
        SetTask(Task_jiangyao, 11)
        refreshNpcTaskState()

        AddOwnExp(4600)

        SetSubTask(912, -1, 1)

        TaskNote(912, -1)
        AddNormalItem(0, 2, 1, 1, 0, 0)
        TopMessage("NhËn 4600 kinh nghiÖm vµ Thiªn QuyÒn §¹o Bµo. ")
        Msg2Player("NhËn 4600 kinh nghiÖm vµ Thiªn QuyÒn §¹o Bµo. ")

        Talk(1, "no", 12145)

        refreshNpcTaskState()

    end
end
function AcceptJiangyao()
    CloseDialog()
    local nTaskStatus = GetTask(Task_jiangyao)
    if (GetLevel() >= 10 and nTaskStatus == 0 and GetPlayerType() == 1) then
        AddNormalItem(6, 1, 275, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 R­¬ng chÊn hån.")
        SetTask(Task_jiangyao, 1)
        refreshNpcTaskState()

        SetSubTask(912, 1, 1)

        TaskNote(912, 0)
        Talk(1, "no", 12146)

        refreshNpcTaskState()

    end
end
function qianxin()
    AddOwnExp(500)
    AddNormalItem(0, 0, 2, 1, 0, 0)
    TopMessage(12147)
    Msg2Player("NhËn ®­îc 500 ®iÓm kinh nghiÖm vµ Tİch LŞch KiÕm!")
    SetTask(Task_qianxin, 2)
    refreshNpcTaskState()

    SetSubTask(911, -1, 1)

    TaskNote(911, -1)
    Talk(1, "no", 12148)

    refreshNpcTaskState()


end

function no()
    CloseDialog()
end;

function Lwater()
    SetTask(Task_water, 3)
    refreshNpcTaskState()
    TaskNote(82, 2)
    Talk(4, "no", 14594, GetName() .. ": Tiªn tr­ëng! Kh­¬ng Thõa t­íng ph¸i t¹i h¹ ®Õn hái vÒ tung tİch Tam Quang!", "Ta cã nghe nãi, Tam Quang lµ linh vËt cña Ng­ V­¬ng ë Long Cung, ng­¬i h·y thö ®Õn ®ã t×m xem!", GetName() .. ": §a t¹ tiªn tr­ëng!")
end

function renwu13()
    CloseDialog()
    if (GetLevel() < 13) then
        Talk(1, "no", "L·o phu vÉn cã viÖc cÇn nhê, anh hïng ®¹t cÊp 13 h·y quay l¹i.")
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 0) then
        MsgBox("GÇn ®©y trong thµnh th­êng næi giã tuyÕt, hÊp dÉn nhiÒu b¸ t¸nh ®Õn tham quan du l·m, rÊt nhiÒu ng­êi ®· tô tËp l¹i ®¸nh trËn tuyÕt, ®¾p ng­êi tuyÕt, khiÕn cho Ngäc H­ Cung phån hoa n¸o nhiÖt dŞ th­êng, v× thÕ v¨n nh©n nh· sÜ trªn ngäc H­ Cung tæ chøc ra 1 ho¹t ®éng, truy t×m <c=g>Minh ¢m CÇm, Ch©n Long Kú, Nam Hoa Kinh, Tiªn C¬ Häa<c>, ng­¬i cã muèn tham gia kh«ng?", "yes_picture", "no")
    elseif (state13 == 5) then
        Talk(1, "no", "Ta ®· hiÓu ®­îc t×nh huèng nµy råi, ®ång thêi ®· nhê HuyÒn §« gióp ta truy t×m <c=g>Tiªn C¬ Häa<c>, anh hïng ®¹t ®Õn cÊp 18 h·y ®i t×m <c=r>HuyÒn §«<c>, anh ta sÏ b¶o ng­¬i t×nh huèng cña<c=g>Tiªn C¬ Häa<c>, 3 vËt phÈm nµy h·y giao cho ta tr­íc! Cßn ®©y lµ phÇn th­ëng cña ng­¬i.")
        Msg2Player("CÊp 18 ®Õn t×m HuyÒn §« hái th¨m tung tİch Tiªn C¬ Häa.")
        SetTask(Task_newer13, 6)
        refreshNpcTaskState()

        AddOwnExp(4000)
        Msg2Player("PhÇn th­ëng 4000 kinh nghiÖm. ")

        for i = 238, 240 do
            DelEventItem(i)
        end

        SetSubTask(207, -1, 1)

        TaskNote(207, 6)

        refreshNpcTaskState()

    end
end

function yes_picture()
    Talk(1, "no", "Ng­¬i cã thÓ t×m <c=r>Phæ HiÒn<c> hái th¨m <c=g>Minh ¢m CÇm, Ch©n Long Kú, Nam Hoa Kinh, Tiªn C¬ Häa<c>.")
    SetTaskByte(Task_newer13, 1, 1)
    refreshNpcTaskState()
    Msg2Player("T×m Phæ HiÒn hái th¨m tinh tøc cña CÇm Kú Thi Häa.")

    SetSubTask(207, 1, 1)

    TaskNote(207, 0)

    refreshNpcTaskState()

end

function NewLifeMain()
    local menu = {
        { "ËÙÕ½ËÙ¾ö", "QuickOver"; show = 1 },
        { "Hoµn thµnh nhiÖm vô", "QuickOverComplete"; show = 0 },
        { "Rêi khái", "no"; show = 1 },
    }
    if (GetTaskByte(2089, 4) >= 20) then
        menu[1].show = 0
        menu[2].show = 1
    end
    local info = "×ªÑÛÒ»±ğÒÑÊÇÊıÄê, µ±ÄêÔÚ¹¬ÄÚ¿àĞŞµÄĞ¡µÀÊ¿¾ÓÈ»ÒÑ¾­³ÉÏÉ·âÉñ, nhËn ®­îc Èç´Ë³É¾Í, ÕæÊÇÁîÈËÔŞÌ¾.ÀÏ·òËäÃ»ÓĞÉñ±øÀûÆ÷, µ«Ò²Ô¸ÖúÄãÒ»±ÛÖ®Á¦.ÄãÏÈÈ¥T©y C«n L«nÏûÃğ 20 c¸i TuyÕt YªuÊÊÓ¦Ò»ÏÂ·âÉñºóµÄÉñÌå, ÎÒÈ¥°ïÄã×¼±¸Ò»Ğ©×°±¸µ¤Ò©, ÄãÎÒÉÔºóÔÚ´ËÏà¼û."
    SayTask(info, menu)
end
function QuickOver()
    SetTaskBit(2089, 17, 1)
    TaskNote(2045, 1)
    Talk(1, "no", "Ç°ÍùT©y C«n L«nÏûÃğ 20 c¸i TuyÕt YªuÊÊÓ¦Ò»ÏÂ·âÉñºóµÄÉñÌå")
end
function QuickOverComplete()
    if (GetTaskByte(2089, 4) >= 20) then
        TaskNote(2045, 3)
        local menu = {
            { "½ÓÊÜÀ¡Ôù", "AcceptItem"; show = 1 },
            { "Rêi khái", "no"; show = 1 },
        }
        local info = "Õâ¸ö°ü¹üÄÚÓĞCè Nguyªn §anÒ»Ã¶, ¿ÉÒÔ°ïÖúÄã»Ö¸´²¿·ÖÊµÁ¦, »¹ÓĞ¹¬ÄÚµÀÍ¯ÃÇ´ÕµÄÒ»Ğ©×°±¸, Äã¿ÉÔÚÇ°ÆÚÊ¹ÓÃ.ÁíÍâ»¹ÓĞ3±¾S¸ch kü n¨ng ChuyÓn sinh¸øÄã, ¹ØÓÚS¸ch kü n¨ng ChuyÓn sinh, Äã¿ÉÒÔÔÚÎÒÕâÀïÏêÏ¸ÁË½â»ñµÃ vµ Ê¹ÓÃ·½·¨."
        SayTask(info, menu)
    else
        Talk(1, "no", "Äú»¹Î´Hoµn thµnh nhiÖm vô ÏûÃğ 20 c¸i TuyÕt YªuµÄ.")
    end

end
function AcceptItem()
    if (IsHaveSpaceForTreasure(7) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, h·y s¾p xÕp l¹i hµnh trang.")
        return
    end
    SetTaskBit(2089, 18, 1)
    AddNormalItemBind(6, 1, 1412, 0, 0, 0, 1)
    AddNormalItemBind(6, 1, 1416, 0, 0, 0, 1)
    AddNormalItemBind(6, 1, 1420, 0, 0, 0, 1)

    AddNormalItemBind(8, 1831, 2, 1, 0, 0, 1)

    AddNormalItemBind(6, 1, 1424, 1, 0, 0, 1)

    local plr = GetPlayerType()
    if (plr == 0) then
        AddNormalItemBind(0, 0, 4 + plr, 5, 0, 0, 1)
    else
        AddNormalItemBind(0, 0, 5 + plr, 5, 0, 0, 1)
    end
    Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc ³õ¼¶¡¤°ÙÁ¶¶ÍÌå, ³õ¼¶¡¤Ò»ÎÅÇ§Îò, ³õ¼¶¡¤·âÉñÖ®Á¦¼¼ÄÜÊé, Cè Nguyªn §an*1, Trang bŞ lôc cÊp 40Àñ°ü vµ Vò khİ Hoµng Kim cÊp 50.")
    TaskNote(2045, -1)
end



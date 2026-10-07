Task_thatch = 1019;
Task_TrySkill = 1020;
Task_TryNum = 1021;
Task_Pangu = 1066;
task_juanzhoujing = 1115;
task_juanzhouhuan = 1116;
task_juanzhouxue = 1117;
task_juanzhoubigxue = 1118;
task_collect = 1119;
task_jingInfo = 1121;
task_huanInfo = 1122;
task_xueInfo = 1123;
task_bigxueInfo = 1124;
task_collectInfo = 1120;
Task_Monster = { { name = "TÜnh Nh©n", id = 0, num = 8 } }

Task_DzrRell = 1126
Task_CxppRell = 1127
Task_GoldWeapon = 1337

Task_GuiNu = 1208
Task_GuDiao = 1204
Task_XiaGenShi = 1205
Task_JiaKeRen = 1207
Task_HongSha = 1206
Task_HeiShaFeng = 1209
Task_HanGui = 1210

IBItemIndex = {
    { name = "Gi¸o huÊn", IBItemIndex = 64 }

}

function GetCostIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex[nIndex].IBItemIndex)
    return costIBNum
end

function GetCostDisIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(IBItemIndex[nIndex].IBItemIndex)
    return costDisNum
end

function RealCostIB(nIndex)
    local ret = CostCoinByIdx(IBItemIndex[nIndex].IBItemIndex)
    return ret
end

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

    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(Task_thatch) == 1) then
                state = 3
                subState = 0
            elseif (GetTask(Task_thatch) == 2) then
                state = 0
                subState = 0
            end
        else
            if (GetTask(Task_thatch) == 1) then
                state = 3
                subState = 1
            elseif (GetTask(Task_thatch) == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 15

    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local UTask_bianliang = GetTask(955);
        local nums = GetTask(956)

        if (GetLevel() - startLevel <= 6) then

            if ((UTask_bianliang == 0) and (GetLevel() >= 15) and (GetLevel() < 30) and (GetTask(960) < 3)) or ((UTask_bianliang == 0) and (GetLevel() >= 30) and (GetTask(960) <= 6)) then

                state = 1
                subState = 0
            elseif ((nums >= 20) and (UTask_bianliang >= 1) and (UTask_bianliang ~= 17) and (nums ~= 50)) or ((nums >= 40) and (UTask_bianliang == 17) and (GetTask(960) <= 6) and (nums ~= 50)) then
                state = 3
                subState = 0
            elseif (((UTask_bianliang >= 1) and (nums < 20) and (UTask_bianliang ~= 17)) or ((UTask_bianliang == 17) and (nums < 40) and (GetLevel() >= 30))) then
                state = 2
                subState = 0

            end
        else

            if ((UTask_bianliang == 0) and (GetLevel() >= 15) and (GetLevel() < 30) and (GetTask(960) < 3)) or ((UTask_bianliang == 0) and (GetLevel() >= 30) and (GetTask(960) <= 6)) then
                state = 1
                subState = 1

            elseif ((nums >= 20) and (UTask_bianliang >= 1) and (UTask_bianliang ~= 17) and (nums ~= 50)) or ((nums >= 40) and (UTask_bianliang == 17) and (GetTask(960) <= 6) and (nums ~= 50)) then
                state = 3
                subState = 1
            elseif (((UTask_bianliang >= 1) and (nums < 20) and (UTask_bianliang ~= 17)) or ((UTask_bianliang == 17) and (nums < 40) and (GetLevel() >= 30))) then
                state = 2
                subState = 0
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
    if (songxin() == 0) then
        local tasks = {
            { "<c=yel>Mao L­<c>", "rain"; show = 0 },
            { "<c=yel>ThÝ luyÖn T©n Thñ<c>", "AcceptTry"; show = 0 },
            { "<c=yel>Gi¸o huÊn<c>", "renwu"; show = 0 },
            { "<c=yel>Sinh Ho¹t S­<c>", "pangu"; show = 0 },
            { "<c=yel>NhiÖm vô mËt tÞch<c>", "juanzhou"; show = 0 },
            { "Mua t¹p hãa", "yes_1"; show = 1 }
        }

        if (math.floor(GetTask(972) / 86400) < math.floor(LocalSystemTime() / 86400)) and (GetTask(955) == 0) then
            SetTask(960, 0)
            SetTask(972, LocalSystemTime())
        elseif (HaveIBBuff(734) > 0) and (GetTask(960) >= 10) then
            RemoveIBBuff(734)
            Msg2Player("B¹n ®· tiªu diÖt thñ lÜnh yªu ma Thiªn Ng«, kh«ng cÇn mai phôc n÷a")
        end
        local nCollectInfo = GetTask(task_collectInfo)
        local nCollectType = GetByte(nCollectInfo, 1)
        local nCollectNum = GetByte(nCollectInfo, 2)
        if (GetTask(task_juanzhoujing) == 2 or GetTask(task_juanzhouhuan) == 2 or GetTask(task_juanzhouxue) == 2 or GetTask(task_juanzhoubigxue) == 2 or (GetPlayerType() == 0 and GetTask(task_collect) == 1)) then
            tasks[5].show = 1
        end

        if (GetByte(GetTask(Task_GuiNu), 1) == 2 or GetByte(GetTask(Task_GuDiao), 1) == 2 or GetByte(GetTask(Task_XiaGenShi), 1) == 2 or GetByte(GetTask(Task_JiaKeRen), 1) == 2 or GetByte(GetTask(Task_HongSha), 1) == 2 or GetByte(GetTask(Task_HeiShaFeng), 1) == 2 or GetByte(GetTask(Task_HanGui), 1) == 2) then
            tasks[5].show = 1
        end

        local L_CxppID = GetByte(GetTask(Task_CxppRell), 2)
        local L_CxppNum = GetByte(GetTask(Task_CxppRell), 3)
        local L_KillNum = GetByte(GetTask(Task_CxppRell), 4)
        if (GetByte(GetTask(Task_CxppRell), 1) == 2) then
            tasks[5].show = 1
        end

        local L_DzrKill = GetByte(GetTask(Task_DzrRell), 4)
        local L_DzrID = GetByte(GetTask(Task_DzrRell), 2)
        local L_DzrNum = GetByte(GetTask(Task_DzrRell), 3)
        if (GetByte(GetTask(Task_DzrRell), 1) == 2) then
            tasks[5].show = 1
        end

        if (GetPlayerType() == 0) then
            if (GetTask(Task_thatch) == 1) then
                tasks[1].show = 1
            end

            if (GetTask(960) <= 6) and (GetLevel() >= 15) then
                tasks[3].show = 1
            end

            if (GetTask(1043) == 10 and GetPlayerType() == 0) then
                TaskNote(902, -1)
            end

            if (GetLevel() >= 20) then
                local nTaskStatusPan = GetTask(Task_Pangu)
                if (nTaskStatusPan <= 12) then
                    tasks[4].show = 1
                end
            end
        end

        if (tasks[1].show == 1 or
                tasks[2].show == 1 or
                tasks[3].show == 1 or
                tasks[4].show == 1 or
                tasks[5].show == 1) then
            SayTask(12600, tasks)
        else
            MsgBox(10217, "yes_1", "no")
        end

    end
end;

function juanzhou()
    Task30 = {


        { "<c=yel>MËt tÞch Phôc Ma<c>", "liesha"; show = 0 },
        { "<c=yel>MËt tÞch Thu ThËp<c>", "collectjuanzhou"; show = 0 },
    }
    local nCollectInfo = GetTask(task_collectInfo)
    local nCollectNum = GetByte(nCollectInfo, 2)
    if (GetTask(task_juanzhoujing) == 2 or
            GetTask(task_juanzhouhuan) == 2 or
            GetTask(task_juanzhouxue) == 2 or
            GetTask(task_juanzhoubigxue) == 2 or
            GetByte(GetTask(Task_CxppRell), 1) == 2 or
            GetByte(GetTask(Task_DzrRell), 1) == 2 or

            GetByte(GetTask(Task_GuiNu), 1) == 2 or
            GetByte(GetTask(Task_GuDiao), 1) == 2 or
            GetByte(GetTask(Task_XiaGenShi), 1) == 2 or
            GetByte(GetTask(Task_JiaKeRen), 1) == 2 or
            GetByte(GetTask(Task_HongSha), 1) == 2 or
            GetByte(GetTask(Task_HeiShaFeng), 1) == 2 or
            GetByte(GetTask(Task_HanGui), 1) == 2) then

        Task30[1].show = 1
    end

    if (GetPlayerType() == 0 and GetTask(task_collect) == 1) then
        Task30[2].show = 1
    end
    SayTask(12218, Task30)
end

function liesha()
    Task40 = {
        { "<c=yel>TÜnh Nh©n mËt tÞch<c>", "jingjuanzhou"; show = 0 },
        { "<c=yel>Hoµn CÈu mËt tÞch<c>", "huanjuanzhou"; show = 0 },
        { "<c=yel>TuyÕt Yªui mËt tÞch<c>", "jingjuanxue"; show = 0 },
        { "<c=yel>TuyÕt Nguyªn Cù Thó mËt tÞch<c>", "bigxuejuanzhou"; show = 0 },
        { "<c=yel>§¹i Chñng Nh©n mËt tÞch<c>", "dzrRell"; show = 0 },
        { "<c=yel>Th¶o Tiªn mËt tÞch<c>", "cxppRell"; show = 0 },


        { "<c=yel>Quû Ngù mËt tÞch<c>", "PriceGuiNu"; show = 0 },
        { "<c=yel>Cæ §iªu mËt tÞch<c>", "PriceGuDiao"; show = 0 },
        { "<c=yel>Cèt Tinh mËt tÞch<c>", "PriceXiaGenShi"; show = 0 },
        { "<c=yel>Gi¸p Cèt mËt tÞch<c>", "PriceJiaKeRen"; show = 0 },
        { "<c=yel>Hång S¸t mËt tÞch<c>", "PriceHongSha"; show = 0 },
        { "<c=yel>H¾c Phong LÖnh<c>", "PriceHeiShaFeng"; show = 0 },
        { "<c=yel>H¹n Quy lÖnh<c>", "PriceHanGui"; show = 0 }

    }

    local nShowNum = 0;

    if (GetTask(task_juanzhoujing) == 2 and nShowNum < 6) then
        Task40[1].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetTask(task_juanzhouhuan) == 2 and nShowNum < 6) then
        Task40[2].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetTask(task_juanzhouxue) == 2 and nShowNum < 6) then
        Task40[3].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetTask(task_juanzhoubigxue) == 2 and nShowNum < 6) then
        Task40[4].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_DzrRell), 1) == 2 and nShowNum < 6) then
        Task40[5].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_CxppRell), 1) == 2 and nShowNum < 6) then
        Task40[6].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_GuiNu), 1) == 2 and nShowNum < 6) then
        Task40[7].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_GuDiao), 1) == 2 and nShowNum < 6) then
        Task40[8].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_XiaGenShi), 1) == 2 and nShowNum < 6) then
        Task40[9].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_JiaKeRen), 1) == 2 and nShowNum < 6) then
        Task40[10].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_HongSha), 1) == 2 and nShowNum < 6) then
        Task40[11].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_HeiShaFeng), 1) == 2 and nShowNum < 6) then
        Task40[12].show = 1
        nShowNum = nShowNum + 1
    end

    if (GetByte(GetTask(Task_HanGui), 1) == 2 and nShowNum < 6) then
        Task40[13].show = 1
        nShowNum = nShowNum + 1
    end

    SayTask(12218, Task40)

end

function PriceGuiNu()
    if (GetByte(GetTask(Task_GuiNu), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô Quû Ngù!")
        AddOwnExp(8000)
        TopMessage("B¹n nhËn ®­îc <c=g>8000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 8000 kinh nghiÖm")
        TaskNote(924, -1)
        SetTask(Task_GuiNu, 0)
    end
end

function PriceGuDiao()
    if (GetByte(GetTask(Task_GuDiao), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô Cæ §iªu!")
        AddOwnExp(4000)
        TopMessage("B¹n nhËn ®­îc <c=g>4000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 4000 kinh nghiÖm")
        TaskNote(925, -1)
        SetTask(Task_GuDiao, 0)
    end
end

function PriceXiaGenShi()
    if (GetByte(GetTask(Task_XiaGenShi), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô: Cèt Tinh")
        AddOwnExp(4000)
        TopMessage("B¹n nhËn ®­îc <c=g>4000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 4000 kinh nghiÖm")
        TaskNote(919, -1)
        SetTask(Task_XiaGenShi, 0)
    end
end

function PriceJiaKeRen()
    if (GetByte(GetTask(Task_JiaKeRen), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô: Gi¸p Cèt")
        AddOwnExp(6000)
        TopMessage("B¹n nhËn ®­îc <c=g>6000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 6000 kinh nghiÖm")
        TaskNote(920, -1)
        SetTask(Task_JiaKeRen, 0)
    end
end

function PriceHongSha()
    if (GetByte(GetTask(Task_HongSha), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô Hång S¸t")
        AddOwnExp(6000)
        TopMessage("B¹n nhËn ®­îc <c=g>6000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 6000 kinh nghiÖm")
        TaskNote(921, -1)
        SetTask(Task_HongSha, 0)
    end
end

function PriceHeiShaFeng()
    if (GetByte(GetTask(Task_HeiShaFeng), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô H¾c Phong")
        AddOwnExp(6000)
        TopMessage("B¹n nhËn ®­îc <c=g>6000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 6000 kinh nghiÖm")
        TaskNote(922, -1)
        SetTask(Task_HeiShaFeng, 0)
    end
end

function PriceHanGui()
    if (GetByte(GetTask(Task_HanGui), 1) == 2) then
        Talk(1, "no", "Chóc mõng b¹n hoµn thµnh NhiÖm vô H¹n Quy")
        AddOwnExp(8000)
        TopMessage("B¹n nhËn ®­îc <c=g>8000<c> kinh nghiÖm")
        Msg2Player("B¹n nhËn ®­îc 8000 kinh nghiÖm")
        TaskNote(923, -1)
        SetTask(Task_HanGui, 0)
    end
end

function dzrRell()
    if (GetByte(GetTask(Task_DzrRell), 1) == 2) then
        Talk(1, "no", 12219)
        AddOwnExp(1000)
        TopMessage(12220)
        Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        TaskNote(1009, -1)
        SetTask(Task_DzrRell, 0)
    end


end

function cxppRell()
    if (GetByte(GetTask(Task_CxppRell), 1) == 2) then
        Talk(1, "no", 12221)
        AddOwnExp(3500)
        TopMessage(12222)
        Msg2Player("B¹n nhËn ®­îc 3500 kinh nghiÖm")
        TaskNote(1010, -1)
        SetTask(Task_CxppRell, 0)
    end
end

function jingjuanxue()
    SetTask(task_juanzhouxue, 0)
    SetTask(task_xueInfo, 0)
    TaskNote(915, -1)
    AddOwnExp(1000)
    TopMessage(12223)
    Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm.")
    CloseDialog()
end
function bigxuejuanzhou()
    SetTask(task_juanzhoubigxue, 0)
    SetTask(task_bigxueInfo, 0)
    TaskNote(916, -1)
    AddOwnExp(3000)
    TopMessage(12224)
    Msg2Player("B¹n nhËn ®­îc 3000 ®iÓm kinh nghiÖm.")
    CloseDialog()
end
function jingjuanzhou()
    SetTask(task_juanzhoujing, 0)
    SetTask(task_jingInfo, 0)
    TaskNote(918, -1)
    AddOwnExp(1000)
    TopMessage(12223)
    Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm.")
    CloseDialog()
end
function huanjuanzhou()
    SetTask(task_juanzhouhuan, 0)
    SetTask(task_huanInfo, 0)
    TaskNote(914, -1)
    AddOwnExp(3000)
    TopMessage(12224)
    Msg2Player("B¹n nhËn ®­îc 3000 ®iÓm kinh nghiÖm.")
    CloseDialog()
end
function collectjuanzhou()
    CloseDialog()
    if (GetTask(task_collect) ~= 1) then
        return 0
    end

    local nCollectInfo = GetTask(task_collectInfo)
    local nCollectNum = GetByte(nCollectInfo, 2)
    if (HaveNormalItem(3, 11, 0, 0) >= nCollectNum) then
        for i = 1, nCollectNum do
            DelNormalItem(3, 11, 0, 0)
        end
        SetTask(task_collect, 0)
        SetTask(task_collectInfo, 0)
        TaskNote(917, -1)
        AddOwnExp(1500)
        TopMessage(12225)
        Msg2Player("B¹n nhËn ®­îc 1500 ®iÓm kinh nghiÖm.")
    elseif (HaveNormalItem(3, 10, 0, 0) >= nCollectNum) then
        for i = 1, nCollectNum do
            DelNormalItem(3, 10, 0, 0)
        end
        SetTask(task_collect, 0)
        SetTask(task_collectInfo, 0)
        TaskNote(917, -1)
        AddOwnExp(1500)
        TopMessage(12225)
        Msg2Player("B¹n nhËn ®­îc 1500 ®iÓm kinh nghiÖm.")
    else
        Msg2Player("Nguyªn liÖu cña ng­¬i vÉn ch­a ®ñ")
        Talk(1, "no", "Nguyªn liÖu cña ng­¬i vÉn ch­a ®ñ")
    end
end

function pangu()
    CloseDialog()
    local nTaskStatusPan = GetTask(Task_Pangu)
    if (nTaskStatusPan <= 12) then
        MsgBox("Khai kho¸ng, h¸i thuèc, c©u c¸, trång trät, luyÖn ®¬n, gia c«ng, chÕ t¹o? Ng­¬i muèn häc g×? H·y ®Õn chç <c=g>Sinh Ho¹t S­<c> t×m hiÓu râ h¬n! ¤ng ta sÏ d¹y cho ng­¬i c¸c kü n¨ng sinh ho¹t míi.", "AcceptPangu", "no")
    end
end
function AcceptPangu()
    CloseDialog()
    SetTask(Task_Pangu, 13)

    TaskNote(898, 3)
    SetSubTask(898, 1, 1)
    Talk(1, "no", "T¹p hãa th­¬ng: <c=g>Sinh Ho¹t S­<c> ë bªn c¹nh <c=g>Vâ s­<c>, mau ®Õn ®ã t×m hiÓu râ h¬n!")

    refreshNpcTaskState()

end

function rain()
    SetTask(Task_thatch, 2)
    AddOwnExp(45)

    TaskNote(909, 1)
    TopMessage(12151)
    MsgBox(12601, "no")

    refreshNpcTaskState()

end

function AcceptTry()
    if (GetTask(Task_TrySkill) == 0) then
        MsgBox("T¹p hãa th­¬ng: GÇn ®©y <c=r>Lç Hïng<c> ®ang huÊn luyÖn 1 ®éi tinh binh, nÕu cã t­ chÊt tèt ta sÏ tiÕn cö ng­¬i ®Õn gÆp «ng Êy. Giê h·y ®i tiªu diÖt <c=g>" .. Task_Monster[1].num .. "." .. Task_Monster[1].name .. "<c>, sau ®ã quay vÒ t×m ta phôc mÖnh!", "AcceptTry1", "no")

    else
        renwu2()
    end
end
function new()
    Talk(1, "no", 12602)
end;

function renwu2()
    AddOwnExp(150)
    AddNormalItem(0, 7, 0, 1, 0, 0)
    TopMessage(12603)

    SetSubTask(907, -1, 1)

    TaskNote(907, -1)
    SetTask(Task_TrySkill, 3)

    MsgBox(12604, "new")

    Msg2Player("§Õn gãc T©y B¾c cña b¶n ®å t×m Lç Hïng.")
    TopMessage(12605)
    if (GetTask(1020) == 3) then
        SyncBibleState(907, 0, 1)
    end ;

    refreshNpcTaskState()

end;

function AcceptTry1()
    SetTask(Task_TrySkill, 1)
    SetTask(Task_TryNum, 0)
    SetTask(Task_TryNum, SetByte(GetTask(Task_TryNum), 1, Task_Monster[1].id))
    MonsterName = "<c=r><NpcName=\"TÜnh Nh©n\",1><c>"

    SetSubTask(907, 1, 1)

    TaskNote(907, 0, MonsterName, Task_Monster[1].num)

    Talk(1, "no", 12606)

    refreshNpcTaskState()

end

function songxin()
    local task_id = 870
    local map_id = 1

    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local type2 = GetByte(task_val, 2)
    local finish = GetByte(task_val, 3)

    local setbit = 0
    if (type1 == map_id) then
        setbit = 7
    elseif (type2 == map_id) then
        setbit = 8
    end

    if (setbit ~= 0) then
        if (GetBit(finish, setbit) == 0) then
            Talk(1, "no", 12234)
            SetTask(task_id, SetByte(task_val, 3, SetBit(finish, setbit, 1)))
            return 1
        end
    end
    return 0
end

function yes_1()
    CloseDialog()
    Sale(5);
end;

function no()
    CloseDialog()
end;

npcname = {
    [1] = "TÜnh Nh©n",
    [2] = "TuyÕt Yªu",
    [3] = "§¹i Chñng Nh©n",
    [4] = "B¾c H¶i Ph¶n Qu©n",
    [5] = "B¨ng Kiªu Trïng",
    [6] = "§µi Yªu",
    [7] = "Cuång §iªu",
    [8] = "Hoµn CÈu",
    [9] = "TuyÕt Nguyªn Cù Thó",
    [10] = "Th¶o Tiªn",
    [11] = "Cæ §iªu",
    [12] = "Cèt Tinh",
    [13] = "Hång S¸t",
    [14] = "Gi¸p Cèt",
    [15] = "Thi Hoµng",
    [16] = "Quû Ngù",
    [17] = "Thiªn Ng«",
    [18] = "Sa Hån",
    [19] = "H¾c Phong",
    [20] = "Vâ Quy",
    [21] = "§ao CÇm",
    [22] = "Háa Ng­",
    [23] = "Ho¶ Ly TiÓu Yªu",
    [24] = "KhuÈn Nh©n",
    [25] = "H¹n Quy",

}

function renwu()

    TaskNote(902, -1)

    npclink = {


        [4] = "<NpcName=\"B¾c H¶i Ph¶n Qu©n\",4>",


        [8] = "<NpcName=\"Hoµn CÈu\",8>",


        [11] = "<NpcName=\"¹Æµñ\",11>",
        [12] = "<NpcName=\"ÏÄ¸ûÊ¬\",12>",
        [13] = "<NpcName=\"Hång S¸t\",13>",
        [14] = "<NpcName=\"Gi¸p Cèt\",14>",

        [16] = "<NpcName=\"Quû Ngù\",16>",


        [19] = "<NpcName=\"H¾c Phong\",19>",


    }
    local UTask_bianliang = GetTask(955);
    local nums = GetTask(956)

    if (HaveIBBuff(734) > 0) and (UTask_bianliang == 0) then
        MsgBox(12235, "yes_2", "no")
        return 1
    end

    if (UTask_bianliang == 0) and (GetLevel() >= 15) and (GetLevel() < 30) and (GetTask(960) < 6) then

        if (GetTask(960) < 3) then
            MsgBox(12235, "yes_2", "no")
            return 1
        else
            MsgBox(12236, "UseIB1", "no")
            return 1
        end
    elseif (UTask_bianliang == 0) and (GetLevel() >= 30) and (GetTask(960) < 6) then
        if ((GetTask(960) < 3)) then
            MsgBox(12237, "yes_2", "no")
            return 1
        else
            MsgBox(12236, "UseIB2", "no")
            return 1

        end
    elseif (UTask_bianliang ~= 17) and (GetTask(960) > 6) then
        Talk(1, "no", "NhiÖm vô gi¸o huÊn hoµn thµnh! H·y nhËn lÊy <c=g>" .. nExp .. " ®iÓm kinh nghiÖm<c>, vµ chót ng©n l­îng t¹ ¬n!")
    else
        if (nums >= 20) and (UTask_bianliang >= 1) and (UTask_bianliang ~= 17) then
            SetTask(956, 0)
            SetTask(955, 0)
            TaskNote(50, -1)
            refreshNpcTaskState()
            local nExp

            if (GetLevel() < 25) then


                nExp = GetLevel() * 500
                AddOwnExp(nExp)
                Earn(3000)
                Msg2Player("B¹n nh©n ®­îc " .. nExp .. " ®iÓm kinh nghiÖm, 3000 l­îng!")
            else

                nExp = GetLevel() * 500

                AddOwnExp(nExp)
                Earn(5000)
                Msg2Player("B¹n nh©n ®­îc " .. nExp .. " ®iÓm kinh nghiÖm, 5000 l­îng!")
            end

            if (GetTask(960) == 6) then
                SetTask(960, 7)
                refreshNpcTaskState()
            end
            Talk(1, "no", "NhiÖm vô gi¸o huÊn hoµn thµnh! H·y nhËn lÊy <c=g>" .. nExp .. " ®iÓm kinh nghiÖm<c>, vµ chót ng©n l­îng t¹ ¬n!")
        elseif (nums >= 40) and (UTask_bianliang == 17) then
            SetTask(956, 50)
            SetTask(960, 10)
            Msg2Player("B¹n nhËn ®­îc 30000 ®iÓm kinh nghiÖm, 30000 l­îng vµ 1 lÇn tr¹ng th¸i Thiªn H­¬ng")
            TaskNote(50, -1)
            AddOwnExp(30000)
            Earn(30000)
            SyncBibleState(50, 0, 1)
            AddIBBuff(334)
            refreshNpcTaskState()

            if (HaveIBBuff(734) > 0) then
                RemoveIBBuff(734)
                Msg2Player("B¹n ®· tiªu diÖt thñ lÜnh yªu ma Thiªn Ng«, kh«ng cÇn mai phôc n÷a")
            end
            Talk(1, "no", 12240)
        elseif (UTask_bianliang >= 1) and (nums < 20) and (UTask_bianliang ~= 17) then
            Talk(1, "no", "Cßn thiÕu <c=g>" .. (20 - nums) .. "." .. npcname[UTask_bianliang] .. "<c> n÷a míi cã thÓ nhËn phÇn th­ëng! Cè lªn nhÐ!")
        elseif (UTask_bianliang == 17) and (nums < 40) and (GetLevel() >= 30) then
            Talk(1, "no", "Cßn thiÕu <c=g>" .. (40 - nums) .. "." .. npcname[UTask_bianliang] .. "<c> n÷a míi cã thÓ nhËn phÇn th­ëng! Cè lªn nhÐ!")
        end ;
    end ;
end;
function UseIB1()
    for i = 8, 13 do
        if (HaveNormalItem(3, i, 0, 0) >= 10) then
            for j = 1, 10 do
                DelNormalItem(3, i, 0, 0)
            end
            TopMessage(12242)
            Msg2Player("KhÊu trõ 10 vËt liÖu thu thËp")
            yes_2()
            return 0
        end
    end

    if (HaveEventItem(39) >= 1) then
        DelEventItem(39)
        TopMessage(12243)
        Msg2Player("Trõ 1 LiÔu méc")
        yes_2()
        return 0
    end

    if (HaveNormalItem(8, 368, 2, 0) >= 1) then
        CostIBItem(FindAValidIBItem(8, 368, 2, 0))
        TopMessage(12244)
        Msg2Player("KhÊu trõ 1 TiÓu Yªu Th¹ch.")
        yes_2()
        return 0
    end

    if (GetCoin() >= GetCostIB(1)) then
        if (RealCostIB(1) == 0) then
            Talk(1, "no", 12245)
            return
        end
        TopMessage(12246)
        Msg2Player("KhÊu trõ 2 Th«ng B¶o")
        yes_2()
        return 0
    end
    Talk(1, "no", 12247)
end
function UseIB2()
    if (HaveEventItem(39) >= 1) then
        DelEventItem(39)
        TopMessage(12243)
        Msg2Player("Trõ 1 LiÔu méc")
        yes_2()
        return 0
    end

    for i = 8, 13 do
        if (HaveNormalItem(3, i, 0, 0) >= 10) then
            for j = 1, 10 do
                DelNormalItem(3, i, 0, 0)
            end
            TopMessage(12242)
            Msg2Player("KhÊu trõ 10 vËt liÖu thu thËp")
            yes_2()
            return 0
        end
    end
    if (HaveNormalItem(8, 368, 2, 0) >= 1) then
        CostIBItem(FindAValidIBItem(8, 368, 2, 0))
        TopMessage(12244)
        Msg2Player("KhÊu trõ 1 TiÓu Yªu Th¹ch.")
        yes_2()
        return
    end

    if (GetCoin() >= GetCostIB(1)) then
        if (RealCostIB(1) == 0) then
            Talk(1, "no", 12384)
            return
        end
        TopMessage(12246)
        Msg2Player("KhÊu trõ 2 Th«ng B¶o")
        yes_2()
        return 0
    end
    Talk(1, "no", 12248)

end
function yes_2()
    SetTask(956, 0)
    if (HaveIBBuff(734) == 0) then
        local times = GetTask(960) + 1
        SetTask(960, times)
        if (times > 5) then
            SyncBibleState(50, 3, 1)
        elseif (times > 2) then
            SyncBibleState(50, 2, 1)
        else
            SyncBibleState(50, 1, 1)
        end ;
    end
    SetTask(972, LocalSystemTime())
    if (GetLevel() >= 30) and (HaveIBBuff(734) == 0) then
        Msg2Player("Tiªu diÖt 40 Thiªn Ng«")
        SetTask(955, 17)
        TaskNote(50, 3)
        Talk(1, "no", 12241)
        refreshNpcTaskState()
    else
        local w = ""
        local ar = { 4, 8, 11, 12, 13, 14, 16, 19 }
        local r
        if (GetLevel() < 21) then
            r = math.random(1, 2)
        elseif (GetLevel() < 25) then
            r = math.random(1, 4)
        else
            r = math.random(5, 8)
        end
        local UTask_bianliang = ar[r]
        w = npcname[UTask_bianliang]
        local wlink = npclink[UTask_bianliang]
        SetTask(955, UTask_bianliang)
        TaskNote(50, 0, wlink)
        Msg2Player("Ng­¬i ph¶i tiªu diÖt 20 " .. w)
        refreshNpcTaskState()

        if (HaveIBBuff(734) > 0) then
            RemoveIBBuff(734)
            Msg2Player("Sö dông tr¹ng th¸i Gi¸o huÊn, nhËn thªm 1 lÇn gi¸o huÊn")
        end
        if (GetTask(Task_GoldWeapon) == 0) then
            SetTask(Task_GoldWeapon, 1)
            refreshNpcTaskState()
            AddNormalItem(0, 0, 27, 1, 0, 0)
            Talk(1, "no", "Gióp ta gi¸o huÊn <c=g>20 tªn" .. w .. "<color> yªu ma, ®Ó chóng hÕt d¸m h¹i ng­êi v« téi! Ta cã 1 thanh <c=yel>Hoµng Kim Tr¶m T­íng §ao<c>, hy väng cã thÓ gióp ng­¬i Trõ yªu!")
        else
            Talk(1, "no", "Gióp ta gi¸o huÊn <c=g>20 tªn" .. w .. "<color> yªu ma, ®Ó chóng hÕt d¸m h¹i ng­êi v« téi!")
        end
    end ;
end;

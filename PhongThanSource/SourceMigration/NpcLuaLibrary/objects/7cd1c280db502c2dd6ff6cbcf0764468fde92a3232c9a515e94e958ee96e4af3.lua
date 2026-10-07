--description: È¼µÆµÀÈË
--author: yichuan
--date: 2004/6/27
--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-28
Task_qianxin = 1104;
Task_jiangyao = 1105;
Task_jiangyaoGuai1 = 1106;
Task_jiangyaoGuai2 = 1107;
Task_jiangyaoGuai3 = 1108;
Task_jiangyaoGuai4 = 1109;

-- Added by yaoxin at 2008-7-23 begin
Task_water = 1237 -- Èý¹âÉñË® 1½ÓÁË,2È¼µÆ,3Ìú¿øÓãÍõ,4É±Óã,5É±Íê,6ÅÜÉÌ 10ÎªÈÎÎñÓÀ¾ÃÍê³É
-- Added by yaoxin at 2008-7-24 end

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓÐþ¶¼´ó·¨Ê¦ÕÒÏôÉý2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×ÈÝ³ÉÑ©Ô­¾ÞÊÞ5Ñ©Ô­¾ÞÊÞÏÖ³öÔ­ÐÎ6»ØÐþ¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)

-- AS GaoJingwei at 090728

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin

YIBO_90_DESASTER_STATE = 1662  -- 1Byte:ÈÎÎñÇé¿ö 1¡¢ÒÑ¾­½ÓÈÎÎñ  2¡¢Íê³É  3¡¢Ê§°Ü
ELEVEN_DAY_BUFF = 1240

Task_EggTime = 1668       --1Word:¼ÇÂ¼ÁìÈ¡µ°µÄÊ±¼ä
--2Word:¼ÇÂ¼90Áìµ°Ê±¼ä

MonsterEgg = { name = "Trøng Th«ng Linh", Item = { 6, 1, 797, 1, 0, 0 } }

Shien = { name = "S­ ¢n LÖnh", Item = { 3, 1088, 0, 0, 0, 0 } }

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 End

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --Ç±ÐÄÐÞÁ¶
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

    --½µÑý³ýÄ§
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

    --ÇÙÆåÊé»­
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

    --Èý¹âÉñË®
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

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
    SayTask(10526, tasks)
end;

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®80¼¶½ÙÄÑÈÎÎñ at 2009.12.24 Begin
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
    --·µ»ØÖµËµÃ÷£º1£ºOK 0:No
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
        WriteLog("NhËn ®­îc 2 S­ ¢n LÖnh")
    else
        WriteLog("V­ît qua kiÕp n¹n cÊp 90")
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
        --Ê¦¸¸½«µÜ×ÓÖð³öÊ¦ÃÅµÄÇé¿ö£¬ÔÚ´Ë¿ÉÈ¡ÏûÈÎÎñ,tasknoteÒ²ÒªÔÚÕâÀï´¦Àí
        local task1 = GetTaskWord(1660, 2)
        local task2 = GetTask(1664)
        for i = 1657, 1668 do
            SetTask(i, 0)
        end
        SetTaskWord(1660, 2, task1)
        SetTask(1664, task2)
        SetTask(1670, 0)
        SetTask(1671, 0)
        Msg2Player("Ng­¬i vµ s­ phô ®· hñy quan hÖ s­ ®å, kh«ng thÓ v­ît qua kiÕp n¹n! NhiÖm vô bÞ hñy!")
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
            ClearItem(item[1], item[2], item[3], item[4]) --Èç¹û±³°üÀïÃæ»¹ÓÐ¹ÖÎïµ°£¬ÔòÉ¾³ý
            AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
            local curTime = LocalSystemTime()
            SetTaskWord(Task_EggTime, 2, floor(curTime / 86400))
            Msg2Player("Ng­¬i nhËn ®­îc Trøng Th«ng Linh!")
        else
            InfoBox("Ng­¬i ®· cã 1 Trøng Th«ng Linh, víi kh¶ n¨ng cña ng­¬i, thø lçi ta kh«ng thÓ ®­a thªm Trøng Th«ng Linh cho ng­¬i n÷a!")
        end
    else
        InfoBox("H«m nay ng­¬i ®· nhËn Trøng Th«ng Linh råi!")
    end
end

function Get_EggTime()
    -- ·µ»ØÖµËµÃ÷£º1¿ÉÒÔÁìÈ¡ 0²»¿ÉÁìÈ¡
    local lastTime = GetTaskWord(Task_EggTime, 2)
    local curTime = LocalSystemTime()

    if (lastTime == floor(curTime / 86400)) then
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

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®80¼¶½ÙÄÑÈÎÎñ at 2009.12.24 End


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
        AddOwnExp(2000)
        --AS GaoJingwei 090730
        SetSubTask(912, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(912, -1)
        AddNormalItem(0, 2, 1, 1, 0, 0)
        TopMessage(12144)
        Msg2Player("NhËn ®­îc 2000 ®iÓm kinh nghiÖm vµ Thiªn QuyÒn §¹o Bµo")
        Talk(1, "no", 12145)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
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
        --AS GaoJingwei 090730
        SetSubTask(912, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(912, 0)
        Talk(1, "no", 12146)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end
function qianxin()
    AddOwnExp(500)
    AddNormalItem(0, 0, 2, 1, 0, 0)
    TopMessage(12147)
    Msg2Player("NhËn ®­îc 500 ®iÓm kinh nghiÖm vµ TÝch LÞch KiÕm!")
    SetTask(Task_qianxin, 2)
    refreshNpcTaskState()
    --AS GaoJingwei 090730
    SetSubTask(911, -1, 1)
    --AE GaoJingwei 090730
    TaskNote(911, -1)
    Talk(1, "no", 12148)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

end
--function  renwu1()
--
--		Talk(1,"no",10527)
--		AddEventItem(20)
--		SetTask(11,4)
--		TaskNote(2,3)
--		Msg2Player("´ÓÈ¼µÆµÀÈËÊÖÖÐµÃµ½¿ÕÖÐ»ðµÄ»ðÖÖ¡£")
--
--end;

--function  renwu2()
--	UTask_04 = GetTask(14);
--	if (UTask_04 == 1) and (HaveNormalItem(3,9,0,0)>=10) then
--				Talk(1,"no",10528)
--				for  i=1,10 do
--					DelNormalItem(3,9,0,0)
--				end;
--				AddNormalItem(7,58,62,1,0,0)
--				SetTask(14,2)
--				Msg2Player("µÃµ½²É¿óÉú»î¼¼ÄÜÊé¡¶ÅÌ¹Å¿ªÌì¡·£¬¶øÇÒÄã´Ó´ËÒ²²»ÔÙÊÇÐÂÊÖÁË¡£")
--				SetCamp(7)
--				TaskNote(4,1)
--	end;
--	if (UTask_04 == 0) and  (GetPlayerType()==1)and(GetLevel()>=12) then
--				Talk(2,"yuanyi",10529,10530)
--	end;
--end;
--
--function yuanyi()
--		MsgBox(10531,"yes_1","no")
--end;
--
--
--function yes_1()
--		CloseDialog()
--		SetTask(14,1)
--		Msg2Player("´ðÓ¦ÎªÈ¼µÆµÀÈËÈ¥ÕÒ10¸ùÓñ¹Ç¡£")
--		TaskNote(4,0)
--end;

function no()
    CloseDialog()
end;

-- Added by yaoxin at 2008-7-24 begin
--Èý¹âÉñË®
function Lwater()
    SetTask(Task_water, 3) -- ½ÓÁËÈÎÎñ
    refreshNpcTaskState()
    TaskNote(82, 2)
    Talk(4, "no", 14594, GetName() .. ": Tiªn tr­ëng! Kh­¬ng Thõa t­íng ph¸i t¹i h¹ ®Õn hái vÒ tung tÝch Tam Quang!", "Ta cã nghe nãi, Tam Quang lµ linh vËt cña Ng­ V­¬ng ë Long Cung, ng­¬i h·y thö ®Õn ®ã t×m xem!", GetName() .. ": §a t¹ tiªn tr­ëng!")
end
-- Added by yaoxin at 2008-7-24 end
----------------13,18ÐÂÊÖÈÎÎñ----yaoxin 09/04/28
function renwu13()
    CloseDialog()
    if (GetLevel() < 13) then
        Talk(1, "no", "L·o phu vÉn cã viÖc cÇn nhê, anh hïng ®¹t cÊp 13 h·y quay l¹i.")
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 0) then
        MsgBox("GÇn ®©y trong thµnh th­êng næi giã tuyÕt, hÊp dÉn nhiÒu b¸ t¸nh ®Õn tham quan du l·m, rÊt nhiÒu ng­êi ®· tô tËp l¹i ®¸nh trËn tuyÕt, ®¾p ng­êi tuyÕt, khiÕn cho Ngäc H­ Cung phån hoa n¸o nhiÖt dÞ th­êng, v× thÕ v¨n nh©n nh· sÜ trªn ngäc H­ Cung tæ chøc ra 1 ho¹t ®éng, truy t×m <c=g>Minh ¢m CÇm, Ch©n Long Kú, Nam Hoa Kinh, Tiªn C¬ Häa<c>, ng­¬i cã muèn tham gia kh«ng?", "yes_picture", "no")
    elseif (state13 == 5) then
        Talk(1, "no", "Ta ®· hiÓu ®­îc t×nh huèng nµy råi, ®ång thêi ®· nhê HuyÒn §« gióp ta truy t×m <c=g>Tiªn C¬ Häa<c>, anh hïng ®¹t ®Õn cÊp 18 h·y ®i t×m <c=r>HuyÒn §«<c>, anh ta sÏ b¶o ng­¬i t×nh huèng cña<c=g>Tiªn C¬ Häa<c>, 3 vËt phÈm nµy h·y giao cho ta tr­íc! Cßn ®©y lµ phÇn th­ëng cña ng­¬i.")
        Msg2Player("CÊp 18 ®Õn t×m HuyÒn §« hái th¨m tung tÝch Tiªn C¬ Häa.")
        SetTask(Task_newer13, 6)--log¸Ä°æ
        refreshNpcTaskState()
        AddOwnExp(2500)
        Msg2Player("PhÇn th­ëng 2500 kinh nghiÖm.")
        for i = 238, 240 do
            DelEventItem(i)
        end
        --AS GaoJingwei 090730
        SetSubTask(207, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(207, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

function yes_picture()
    Talk(1, "no", "Ng­¬i cã thÓ t×m <c=r>Phæ HiÒn<c> hái th¨m <c=g>Minh ¢m CÇm, Ch©n Long Kú, Nam Hoa Kinh, Tiªn C¬ Häa<c>.")
    SetTaskByte(Task_newer13, 1, 1)--log¸Ä°æ
    refreshNpcTaskState()
    Msg2Player("T×m Phæ HiÒn hái th¨m tinh tøc cña CÇm Kú Thi Häa.")
    --AS GaoJingwei 090730
    SetSubTask(207, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(207, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

---------end

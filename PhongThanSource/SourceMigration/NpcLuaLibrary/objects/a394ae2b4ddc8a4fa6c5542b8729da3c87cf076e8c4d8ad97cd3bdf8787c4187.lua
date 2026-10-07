--description:npc
--author: zhujialiang
--date:2005/4/13

Task_xianguo = 1211;
--·ÃÇóÏÉ¹ûÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ,2Bit±íÊ¾ÈÎÎñ´ı½»,3Bit±íÊ¾ËÕæ§¼º´¦Íê³É,4Bit±íÊ¾ÄÏ¼«ÏÉÎÌ´¦Íê³É,5Bit±íÊ¾¿ä¸¸Í¼ÌÚ´¦Íê³É,6Bit±íÊ¾ÍÁĞĞËï´¦Íê³É,7Bit±íÊ¾²®ÒØ¿¼´¦Íê³É,8Bit±íÊ¾ÈÎÎñ½áÊø

-- AS GaoJingwei at 090728 
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

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --·ÃÇóÏÊ¹û
    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 7) == 0) or (GetTaskBit(Task_xianguo, 7) == 1 and (HaveNormalItem(3, 223, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 7) == 1) and (HaveNormalItem(3, 223, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 7) == 0) or (GetTaskBit(Task_xianguo, 7) == 1 and (HaveNormalItem(3, 223, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 7) == 1) and (HaveNormalItem(3, 223, 0, 0) > 0) then
                state = 0
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    tasks = {
        { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 }
    }

    local ll = GetTask(Task_xianguo)

    if (GetBit(ll, 1) == 1 and GetBit(ll, 2) == 0 and GetBit(ll, 7) == 0) then
        tasks[1].show = 1
        -- modified by yaoxin for bug 2011-4
    elseif (GetBit(ll, 1) == 1 and GetBit(ll, 2) == 0 and GetBit(ll, 7) == 1 and IsExistItem(3, 223, 0, 0) == 0) then
        tasks[1].show = 1    --Èç¹ûÖ®Ç°µÄÈÎÎñÒÑ¾­Íê³É µ«ÊÇÈÎÎñÎïÆ·»¹ÏûÊ§ÁË.. ÄÇÃ´Ò»Ñù¿ÉÒÔÊ¹ÓÃÒ¹Ã÷ÖéÖØĞÂÁìÈ¡
    end

    SayTask(11213, tasks)
end;

function xianguo()
    local str = "Phô v­¬ng ta ®ang bŞ giam cÇm, nÕu ng­¬i cã thÓ gióp ta t×m mãn b¶o vËt nµo cã thÓ chuéc cha, ta sÏ tÆng ng­¬i viªn Tïng Lé, cã thÓ gióp ng­¬i tr­êng sinh bÊt l·o"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "Qu¶ nhiªn lµ b¶o vËt, H«n qu©n nhÊt ®Şnh sÏ rÊt thİch. Viªn Tïng Lé xin h·y nhËn lÊy!")
        --¼õµôÒ»¿Å
        DelNormalItem(3, 218, 0, 0)
        --Ôö¼ÓÒ»¿ÅËÉÂ¶
        AddNormalItem(3, 223, 0, 0, 0, 0)

        if (GetBit(GetTask(Task_xianguo), 7) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 7, 1))
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            TaskNote(73, 1)
            --AS by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
        else
            local count = 0
            local tb = GetTask(Task_xianguo)
            local tmp_t = {
                "Sïng Thµnh ®¹i doanh-T« §¾c Kû (192,198)", "Ngäc H­ Cung-Nam Cùc Tiªn ¤ng (209,191)", "Xi V­u mé-VËt tæ Khoa phô (199,204)", "TriÒu Ca-Thæ Hµnh T«n (214,184)", "T©y Kú-B¸ Êp Kh¶o (168,195)"
            }
            local tmp_num = {}

            for i = 3, 7 do
                if (GetBit(tb, i) == 0) then
                    count = count + 1
                    tmp_num[count] = i - 2
                end
            end

            --²âÊÔ
            --Msg2Player("count:"..count)
            --Msg2Player("tmp_num[count]:"..tmp_t[ tmp_num[count] ])

            if (count == 1) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]])
            elseif (count == 2) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]])
            elseif (count == 3) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]])
            elseif (count == 4) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]], tmp_t[tmp_num[4]])
            else
                TaskNote(73, 1)
                SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            end

            --AE by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
        end
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhĞ!")
    end
end;

function no()
    CloseDialog()
end;

--description: ¿ä¸¸Í¼ÌÚ
--author: yichaun
--date: 2004/6/29
--30Ç¿ÕßÖ®Â·ÈÎÎñ¿ØÖÆ±äÁ¿  

Task_xianguo = 1211;
--·ÃÇóÏÉ¹ûÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ,2Bit±íÊ¾ÈÎÎñ´ý½»,3Bit±íÊ¾ËÕæ§¼º´¦Íê³É,4Bit±íÊ¾ÄÏ¼«ÏÉÎÌ´¦Íê³É,5Bit±íÊ¾¿ä¸¸Í¼ÌÚ´¦Íê³É,6Bit±íÊ¾ÍÁÐÐËï´¦Íê³É,7Bit±íÊ¾²®ÒØ¿¼´¦Íê³É,8Bit±íÊ¾ÈÎÎñ½áÊø

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ýº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ý4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ý6ÕÒ·ç²®Í¼ÌÚ7»Ø¸´ÕÇÌì¾ý8Íê³É£©
--2byteÖØ»ñÏÉµ¤ÈÎÎñ²½Öè (1ÕÒ¿ä¸¸Í¼ÌÚ2±¸×ã²ÄÁÏ3Ãç½®Ò½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×ÈÝ³É²ÝÏÉ5²ÝÏÉÏÖ³öÔ­ÐÎ6»Ø·ç²®Í¼ÌÚ¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10

    --Ç¿ÕßÖ®Â·
    if (GetLevel() - 1 <= 5) then
        local taskProcess = GetTask(30)
        if (taskProcess == 2) or (taskProcess == 4) then
            state = 3
            subState = 0
        elseif (taskProcess == 3) or (taskProcess == 15) then
            state = 0
            subState = 0
        end
    else
        local taskProcess = GetTask(30)
        if (taskProcess == 2) or (taskProcess == 4) then
            state = 3
            subState = 1
        elseif (taskProcess == 3) or (taskProcess == 15) then
            state = 0
            subState = 0
        end
    end

    index = searchForIndex(state, subState, index)

    --ÖØ»ñÏÉµ¤
    startLevel = 18
    if (GetLevel() >= 10) and (GetPlayerType() == 2) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) and (HaveNormalItem(3, 8, 0, 0) >= 5) and (HaveNormalItem(3, 12, 0, 0) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) and (HaveNormalItem(3, 8, 0, 0) >= 5) and (HaveNormalItem(3, 12, 0, 0) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --·ÃÇóÏÊ¹û
    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 5) == 0) or (GetTaskBit(Task_xianguo, 5) == 1 and (HaveNormalItem(3, 221, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 5) == 1) and (HaveNormalItem(3, 221, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 5) == 0) or (GetTaskBit(Task_xianguo, 5) == 1 and (HaveNormalItem(3, 221, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 5) == 1) and (HaveNormalItem(3, 221, 0, 0) > 0) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        { "<c=yel>Khai TrÝ<c>", "renwu1"; show = 0 },
        { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },
        { "<c=yel>Trïng Ho¹ch Tiªn §¬n<c>", "renwu18"; show = 0 },
    }
    UTask_20 = GetTask(30);
    if (((UTask_20 == 2) or (UTask_20 >= 4 and UTask_20 < 15)) and GetPlayerType() == 2) then
        tasks[1].show = 1
    end ;

    local xg = GetTask(Task_xianguo)

    if (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 5) == 0) then
        tasks[2].show = 1
        -- modified by yaoxin for bug 2011-4
    elseif (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 5) == 1 and IsExistItem(3, 221, 0, 0) == 0) then
        tasks[2].show = 1    --Èç¹ûÖ®Ç°µÄÈÎÎñÒÑ¾­Íê³É µ«ÊÇÈÎÎñÎïÆ·»¹ÏûÊ§ÁË.. ÄÇÃ´Ò»Ñù¿ÉÒÔÊ¹ÓÃÒ¹Ã÷ÖéÖØÐÂÁìÈ¡
    end

    if (GetPlayerType() == 2) then
        local state18 = GetTaskByte(Task_newer13, 2)
        if (GetLevel() >= 18) and (state18 == 1 or state18 == 2 or state18 == 5) then
            tasks[3].show = 1
        end
    end
    SayTask(10160, tasks)
end;

--function   renwu1()
--	UTask_20 = GetTask(30);
--	if(UTask_20==1)then
--		Talk(1,"no",10161)
--		Msg2Player("Óë¿ä¸¸Í¼ÌÚ½»Ì¸£¬µÃµ½¿ä¸¸µÄÖ¸µã¡£")
--		TaskNote(13,3)
--		SetTask(30,UTask_20+4)
--	end;
--	if(UTask_20==3)then
--		Talk(1,"no",10161)
--		Msg2Player("Óë¿ä¸¸Í¼ÌÚ½»Ì¸£¬µÃµ½¿ä¸¸µÄÖ¸µã¡£")
--		TaskNote(13,5)
--		SetTask(30,UTask_20+4)
--	end;
--	if(UTask_20==9)then
--		Talk(1,"no",10161)
--		Msg2Player("Óë¿ä¸¸Í¼ÌÚ½»Ì¸£¬µÃµ½¿ä¸¸µÄÖ¸µã¡£")
--		TaskNote(13,4)
--		SetTask(30,UTask_20+4)
--	end;
--	if(UTask_20==11) then
--		Talk(1,"no",10161)
--		Msg2Player("Óë¿ä¸¸Í¼ÌÚ½»Ì¸£¬µÃµ½¿ä¸¸µÄÖ¸µã¡£")
--		TaskNote(13,7)
--		SetTask(30,UTask_20+4)
--	end;
--end;

function renwu1()
    UTask_20 = GetTask(30);

    if (UTask_20 == 2) then
        Talk(1, "no", 10161)
        TaskNote(13, 12)
        SetTask(30, UTask_20 + 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
    if (UTask_20 >= 4 and UTask_20 < 15) then
        Talk(1, "no", 12406)
        AddOwnExp(100)
        --AS GaoJingwei 090730
        SetSubTask(13, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(13, -1)
        SetTask(30, 15)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    AddOwnExp(100)
    TopMessage(12130)
    Msg2Player("T×m Khoa Phô nhê chØ ®iÓm, nhËn ®­îc 100 ®iÓm kinh nghiÖm")
end;

function no()
    CloseDialog()
end;

function xianguo()
    local str = "Ta cã 1 qu¶ Tiªn ®µo, cã thÓ gióp ng­êi tr­êng sinh bÊt l·o! Nh­ng ta kh«ng cÇn nã n÷a! NÕu ng­¬i cã b¸u vËt nµo t­¬ng xøng. Ta sÏ ®æi Tiªn ®µo nµy cho ng­¬i!"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "Hay qu¸! §©y chÝnh lµ thø ta cÇn! C¶m ¬n nhÐ!")
        --¼õµôÒ»¿Å
        DelNormalItem(3, 218, 0, 0)
        --Ôö¼ÓÒ»¿ÅÏÉÌÒ
        AddNormalItem(3, 221, 0, 0, 0, 0)

        if (GetBit(GetTask(Task_xianguo), 5) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 5, 1))
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            TaskNote(73, 1)
            --AS by hyz 090713 for ÐÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅÐ¶Ï)
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

            --AE by hyz 090713 for ÐÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅÐ¶Ï)
        end
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhÐ!")
    end
end;

----------------13,18ÐÂÊÖÈÎÎñ----yaoxin 09/04/28

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 1) then
        Talk(1, "renwu18", "<c=g>Tô Hån Th¸nh<c> lµ b¸u vËt cã thÓ trÊn gi÷ hån ph¸ch yªu ma, NÕu ng­¬i muèn dïng nã, tr­íc tiªn ph¶i t×m 5 <c=g>MÆt Quû<c>, 5 <c=g>Háa Vò<c> ®Ó t¨ng ph¸p lùc cho <c=g>Tô Hån Th¸nh<c>, anh hïng chuÈn bÞ ®ñ vËt liÖu th× ®Õn t×m ta.")
        SetTaskByte(Task_newer13, 2, 2)
        Msg2Player("Thu thËp 5 MÆt Quû, 5 Háa Vò cho VËt Tæ Khoa Phô, ®Ó t¨ng ph¸p lùc cho Tô Hån Th¸nh.")
        TaskNote(206, 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (state18 == 2) then
        MsgBox("Ta cÇn 5 <c=g>MÆt Quû<c>, 5 <c=g>Háa Vò<c>®Ó t¨ng ph¸p lùc cho <c=g>Tô Hån Th¸nh<c>. Ng­¬i b©y giê ®­a ta sao?", "yes_drug", "no")
    elseif (state18 == 5) then
        local key = GetTaskWord(Task_newer13, 2)
        local nowtime = mod(SystemTime(), 2 ^ 16)
        if (key + 3 * 60 >= nowtime) then
            Talk(1, "no", "Ta cÇn nghØ ng¬i 1 chót míi cã thÓ bæ sung ph¸p lùc tiÕp cho <c=g>Tô Hån Th¸nh<c>, anh hïng 1 l¸t h·y ghÐ l¹i.")
        else
            MsgBox("Ph¶n ®å TriÖt gi¸o ®· bá ®i, ta ph¶i bæ sung l¹i ph¸p lùc cho <c=g>Tô Hån Th¸nh<c>, lÇn nµy vÉn cÇn 5 <c=g>MÆt Quû<c>, 5 <c=g>Háa Vò<c>, ng­¬i b©y giê ®­a cho ta sao?", "yes_drug1", "no")
            TaskNote(206, 1)
        end
    end
end

function yes_drug()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ kho¶ng trèng!")
        return 0
    end

    if (HaveNormalItem(3, 8, 0, 0) >= 5) and (HaveNormalItem(3, 12, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 8, 0, 0)
            DelNormalItem(3, 12, 0, 0)
        end

        AddNormalItem(6, 1, 497, 0, 0, 0)--¾Û»êÏ»
        SetTaskByte(Task_newer13, 2, 3)
        SetTaskWord(Task_newer13, 2, 0)
        Msg2Player("T×m §¹i phu ë Miªu C­¬ng hái tung tÝch ph¶n ®å TriÖt gi¸o")
        TaskNote(206, 2)
        Talk(1, "no", "Ph¸p lùc cña <c=g>Tô Hån Th¸nh<c> ®· bæ sung hoµn thµnh, ng­¬i cã thÓ t×m <c=r>§¹i phu ë Miªu C­¬ng<c> hái tung tÝch ph¶n ®å TriÖt gi¸o.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", "Ta cÇn 5 <c=g>MÆt Quû<c>, 5 <c=g>Háa Vò<c>, vËt liÖu ng­¬i kh«ng cã ®ñ!")
    end
end

function yes_drug1()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ kho¶ng trèng!")
        return 0
    end

    if (HaveNormalItem(3, 8, 0, 0) >= 5) and (HaveNormalItem(3, 12, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 8, 0, 0)
            DelNormalItem(3, 12, 0, 0)
        end

        AddNormalItem(6, 1, 497, 0, 0, 0)--¾Û»êÏ»
        SetTaskByte(Task_newer13, 2, 4)
        SetTaskWord(Task_newer13, 2, 0)
        Msg2Player("Tô Hån Th¸nh míi ®· chuÈn bÞ xong, mau ®i thu phôc ph¶n ®å TriÖt gi¸o.")
        TaskNote(206, 3)
        Talk(1, "no", "Ph¸p lùc cña <c=g>Tô Hån Th¸nh<c> ®· bæ sung hoµn thµnh, mau ®i thu phôc ph¶n ®å TriÖt gi¸o.")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", "Ta cÇn 5 <c=g>MÆt Quû<c>, 5 <c=g>Háa Vò<c>, vËt liÖu ng­¬i kh«ng cã ®ñ!")
    end
end
---------end


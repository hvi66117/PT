Task_xianguo = 1211;

Task_wugu1 = 1352;

Task_wugu2 = 1353;

Task_count = 1349

Task_prepare = 1537

Task_anotherID = 1538
Task_item = 1539
Task_stage = 1540

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

    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 6) == 0) or (GetTaskBit(Task_xianguo, 6) == 1 and (HaveNormalItem(3, 222, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 6) == 1) and (HaveNormalItem(3, 222, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 6) == 0) or (GetTaskBit(Task_xianguo, 6) == 1 and (HaveNormalItem(3, 222, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 6) == 1) and (HaveNormalItem(3, 222, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 26
    if (GetLevel() >= startLevel) then
        local wg = GetTask(Task_wugu1)
        if (GetLevel() - startLevel <= 5) then
            if (wg == 0 and GetLevel() >= 26) then
                state = 1
                subState = 0


            elseif (wg == 5 and HaveEventItem(223) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 0


            end
        else
            if (wg == 0 and GetLevel() >= 26) then
                state = 1
                subState = 1


            elseif (wg == 5 and HaveEventItem(223) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 1


            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 28
    if (GetLevel() >= startLevel) then
        local wg = GetTask(Task_wugu1)
        local wg2 = GetTask(Task_wugu2)
        if (GetLevel() - startLevel <= 5) then
            if (wg == 6 and wg2 == 0 and GetLevel() >= 28) then
                state = 1
                subState = 0
            elseif (wg2 == 4 and GetLevel() >= 28) then
                state = 3
                subState = 0
            elseif (wg2 >= 1 and wg2 < 4 and GetLevel() >= 28) then
                state = 2
                subState = 0
            end
        else
            if (wg == 6 and wg2 == 0 and GetLevel() >= 28) then
                state = 1
                subState = 1
            elseif (wg2 == 4 and GetLevel() >= 28) then
                state = 3
                subState = 1
            elseif (wg2 >= 1 and wg2 < 4 and GetLevel() >= 28) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 35
    if (GetLevel() >= startLevel) then
        local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
        local lastday = GetByte(GetTask(build_renwu), 1)
        if (GetLevel() - startLevel <= 5) then
            if (today ~= lastday and GetLevel() >= 35) then
                state = 1
                subState = 0

            end
        else
            if (today ~= lastday and GetLevel() >= 35) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 23) and (HaveEventItem(1) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 23) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 23) and (HaveEventItem(1) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 23) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 30) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 30) then
                state = 1
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

function main()
    tasks = {
        { "ThÇn Oanh", "renwu2"; show = 0 },
        { "ThÇn Méc", "renwu3"; show = 0 },
        { "Hoang m¹c thÝ luyÖn", "shitu_1"; show = 0 },
        { "Hñy bá nhiÖm vô Sa M¹c ThÝ luyÖn", "shitu_1_cancel"; show = 0 },
        { "Hoµn thµnh nhiÖm vô Hoang M¹c ThÝ LuyÖn", "shitu_1"; show = 0 },
        { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },
        { "<c=g>§¹i H­ng Méc <c>", "construction"; show = 0 },
        { "<c=yel>§éc Cæ<c>", "wugu1"; show = 0 },
        { "<c=yel>§éc Cæ<c>", "wugu2"; show = 0 },


    }
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (UTask_Wizard == 23) and (HaveEventItem(1) >= 1) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 55) and (UTask_Wizard == 30) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() > 25) and (GetLevel() <= 50) and (GetTask(899) <= 7) then
        tasks[3].show = 1;
    end ;
    if (GetLevel() > 45) then
        if (GetTask(899) ~= 0) and (GetTask(899) < 6) then
            tasks[4].show = 1;
        elseif (GetTask(899) == 6) then
            tasks[5].show = 1;
        end ;
    end ;

    local xg = GetTask(Task_xianguo)

    if (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 6) == 0) then
        tasks[6].show = 1

    elseif (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 6) == 1 and IsExistItem(3, 222, 0, 0) == 0) then
        tasks[6].show = 1
    end

    if (GetLevel() >= 35) then
        tasks[7].show = 1
    end

    local wg = GetTask(Task_wugu1)
    local wg2 = GetTask(Task_wugu2)
    if (wg == 0 and GetLevel() >= 26) then
        tasks[8].show = 1
    end

    if (wg == 5) then
        tasks[8].show = 1
    end

    if (wg == 6 and GetLevel() >= 28) then
        tasks[9].show = 1
    end
    if (wg2 == 4 and GetLevel() >= 28) then
        tasks[9].show = 1
    end

    SayTask(10109, tasks)

end;

function wugu2()
    local wg2 = GetTask(Task_wugu2)
    if (wg2 == 0) then
        Talk(2, "no", "Anh hïng ®Õn ®óng hÑn, gióp ta b¸o thï, c¶m kÝch bÊt tËn. Ta ®· nghe ngãng ®­îc <c=g>Phong L©m<c> quanh n¨m trÊn thñ M¹nh T©n, ch¾c biÕt n¬i cña <c=r>B¸ch Niªn Gi¸p Cèt<c>, ng­êi cã thÓ ®Õn dß hái thö xem.", GetName() .. "Thæ ®¹i ca ®îi trong gi©y l¸t, ta ®i sÏ vÒ ngay.")
        SetTask(Task_wugu2, 1)
        SetTask(Task_wugu1, 7)
        TaskNote(200, -1)
        TaskNote(201, 0)
        SetSubTask(201, 1, 1)
        refreshNpcTaskState()
    elseif (wg2 == 4) then
        Talk(2, "no", GetName() .. "Thæ ®¹i ca, ta ®· d¹y cho <c=r>B¸ch Niªn Gi¸p Cèt<c> 1 bµi häc.", "§a t¹! §a t¹! Xin nhËn chót phÇn th­ëng nhá nµy!")
        AddOwnExp(40000)
        SetTask(Task_wugu2, 5)
        TaskNote(201, -1)
        SetSubTask(201, -1, 1)
        TopMessage("NhiÖm vô hoµn thµnh, nhËn ®­îc 40000 kinh nghiÖm")
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc 40000 kinh nghiÖm")
        refreshNpcTaskState()
    end
end

function wugu1()
    local wg = GetTask(Task_wugu1)
    if (wg == 0) then
        Talk(2, "no", "Ta vèn ®Þnh ®Õn Tam S¬n th¨m <c=g>§Æng ThiÒn Ngäc<c>, kh«ng ngê bÞ ng­êi m­u s¸t ë M¹nh T©n, ®· tróng cùc ®éc, mÊt hÕt ph¸p lùc. Kh«ng biÕt anh hïng cã b»ng lßng ®Õn Tam S¬n th¨m ThiÒn Ngäc thay ta.", GetName() .. "Xin cø yªn t©m, t¹i h¹ ®­¬ng næi träng tr¸ch nµy!")
        SetTask(Task_wugu1, 1)
        SetSubTask(200, 1, 1)
        TaskNote(200, 0)
        refreshNpcTaskState()
    end

    if (wg == 5 and HaveEventItem(223) == 1) then
        Talk(2, "no", "Thæ Hµnh T«n:ThiÕu hiÖp cøu m¹ng ta, sè ®iÓm kinh nghiÖm nµy xin tÆng ng­¬i.", GetName() .. "TiÒn bèi qu¸ khen, ta ®· th¸m thÝnh ®­îc kÎ m­u s¸t tiÒn bèi lµ <c=r>B¸ch Niªn Gi¸p Cèt<c> ë M¹nh T©n.")
        DelEventItem(223)
        DelEventItem(221)
        AddOwnExp(32000)
        TopMessage("NhËn ®­îc 32000 kinh nghiÖm.")
        SetTask(Task_wugu1, 6)
        SetSubTask(200, -1, 1)
        TaskNote(200, 5)
        refreshNpcTaskState()
        Talk(1, "no", "Qu©n tö b¸o thñ 10 n¨m ch­a muén, <c=r>B¸ch Niªn Gi¸p Cèt<c> ph¸p lùc cao c­êng. TiÓu anh hïng ®îi ®Õn cÊp 28 h·y ®Õn ®Ó gióp ta röa huyÕt hËn!")
    end ;
end;

function shitu_1()
    local mark = judge_relation()
    if (mark == 1) then
        if (GetTask(899) == 0) then
            MsgBox(14152, "shitu_1_begin", "no")
        elseif (GetTask(899) == 6) then
            MsgBox(14153, "shitu_1_end", "no")
        elseif (GetTask(899) >= 7) then
            Talk(1, "no", 14154)
        else
            MsgBox(14155, "shitu_1_cancel", "no")
        end
    else
        if (GetTask(899) == 0) then
            Talk(1, "no", 14156)
        elseif (GetTask(899) == 6) then
            Talk(1, "no", 14157)
        elseif (GetTask(899) >= 7) then
            Talk(1, "no", 14158)
        else
            MsgBox(14155, "shitu_1_cancel", "no")
        end
    end
end

function shitu_1_begin()
    local mark = judge_relation()
    if (mark == 1) then
        RemoveIBBuff(216)
        local done = AddIBBuff(216)
        if (done == 1) then
            SetTask(899, 1)
            TaskNote(43, 5)
            if (GetTask(900) < 7) then
                SetTask(900, 0)
                TaskNote(44, -1)
            end
            if (GetTask(901) < 7) then
                SetTask(901, 0)
                TaskNote(45, -1)
            end
            if (GetTask(902) < 7) then
                SetTask(902, 0)
                TaskNote(46, -1)
            end
            Talk(2, "no", 14159, "§õng ®Ó vßng s¸ng biÕn mÊt vµ ph¶i cïng ®i víi s­ phô cña m×nh. §¹i phu mçi tÇng sÏ gióp ng­¬i trÞ liÖu vÕt th­¬ng.")
        else
            Talk(1, "no", 14160)
        end
    else
        Talk(1, "no", 14157)
    end
end

function shitu_1_end()
    if (step_complete() == 0) and (GetTask(907) == 0) then
        Say("Chóc mõng ng­êi ®· hoµn thµnh luyÖn tËp th¸m hiÓm lµn nµy, hiÖn giê ma vËt hoµnh hµnh, ta tÆng ng­¬i 1 ThÇn Gi¸p hé thÓ, ng­¬i xin chän ®i.", 3, "§Çu kh«i/shitu_1_end_yes", "Yªu §¸i/shitu_1_end_yes", "Giµy/shitu_1_end_yes")
    else
        shitu_1_end_yes(10)
    end
end

function shitu_1_end_yes(nums)
    local mark = judge_relation()
    if (mark == 1) then
        local name = GetName()
        local masterid = -1
        local oldPlayer = PlayerIndex
        if (GetTeamSize() == 2) then
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            PlayerIndex = n
            shitu_1_end_M(name)
            masterid = GetPlayerID()
        end
        PlayerIndex = oldPlayer
        shitu_1_end_P(nums, masterid)
    else
        Talk(1, "no", 14157)
    end
end

function step_complete()
    local mark = 0
    for i = 1, 4 do
        if (GetTask(898 + i) > 6) then
            mark = mark + 1
        end
    end
    return mark
end

function shitu_1_end_P(nums, masterid)
    local exp1 = GetNextExp() - GetExp()
    local exp2 = 75000

    local y, m, d = GetYMD()
    local expStr = "Chóc mõng! B¹n nhËn ®­îc " .. exp2 .. " kinh nghiÖm"
    if (y == 2011 and ((m == 8 and d >= 26) or (m == 9 and d <= 30))) then
        exp2 = math.floor(exp2 * 3 / 2)
        expStr = "Chóc mõng! B¹n nhËn ®­îc " .. exp2 .. "Kinh nghiÖm (thêi gian ho¹t ®éng nhËn thªm" .. (exp2 - 75000) .. " kinh nghiÖm)"
    end
    if (exp1 < exp2) then
        AddOwnExp(exp1)
        AddOwnExp(exp2 - exp1)
    else
        AddOwnExp(exp2)
    end
    RemoveIBBuff(216)
    SetTask(899, 7)
    SetTask(1368, masterid)
    TaskNote(43, 6)

    TopMessage("Chóc mõng! B¹n nhËn ®­îc " .. exp2 .. " kinh nghiÖm")
    Msg2Player(expStr)

    Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    local mark = step_complete()
    if (mark == 1) and (GetTask(907) == 0) and (nums ~= 10) then
        local ty = GetPlayerType()
        AddNormalItem(0, 7 - nums, ty + 6, 4, 0, 0)
        SetTask(907, 1)
        Talk(1, "no", 14162)
        local item_name = { [0] = { "Vò Khóc Kh«i", "Vò Khóc Yªu §¸i", "Vò Khóc ChiÕn Ngoa" },
                            [1] = { "XÝch Tïng Qu¸n", "XÝch Tïng C©n", "XÝch Tïng Lý" },
                            [2] = { "B¸o ThÇn Trô", "B¸o ThÇn Yªu §¸i", "B¸o ThÇn Ngoa" },
        }
        TopMessage("NhËn ®­îc <c=g>" .. item_name[ty][nums + 1] .. "<c>")


    elseif (mark == 4) and (GetTask(904) == 0) then
        AddNormalItem2(0, 10, GetPlayerType() + 15, 9, 0, 0)
        SetTask(904, 1)
        Talk(1, "no", 14163)
    else
        Talk(1, "no", 14164)
    end
end

function shitu_1_end_M(pname)
    local step = GetTask(899)
    local key = GetFriendFellowShipValue(pname)
    if (step < 100) or (key >= 720 * 100) then

        local y, m, d = GetYMD()
        local prValue = 5
        local addPRValue = 0
        local prValueStr = ""
        if (y == 2011 and ((m == 8 and d >= 26) or (m == 9 and d <= 30))) then
            addPRValue = AddMasterPRValue(prValue * 2)
            if (addPRValue > prValue) then
                prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å (thêi gian ho¹t ®éng nhËn thªm" .. (addPRValue - prValue) .. " ®iÓm s­ ®å)"
            else
                prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å"
            end
        else
            addPRValue = AddMasterPRValue(prValue)
            prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å"
        end
        TopMessage("Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å")
        Msg2Player(prValueStr)

        SetTask(899, 100)

    else

        local y, m, d = GetYMD()
        local prValue = 2
        local addPRValue = 0
        local prValueStr = ""
        if (y == 2011 and ((m == 8 and d >= 26) or (m == 9 and d <= 30))) then
            addPRValue = AddMasterPRValue(prValue * 2)
            if (addPRValue > prValue) then
                prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å (thêi gian ho¹t ®éng nhËn thªm" .. (addPRValue - prValue) .. " ®iÓm s­ ®å)"
            else
                prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å"
            end
        else
            addPRValue = AddMasterPRValue(prValue)
            prValueStr = "Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å"
        end
        TopMessage("Chóc mõng! B¹n nhËn ®­îc " .. addPRValue .. " ®iÓm s­ ®å")
        Msg2Player(prValueStr)

        Talk(1, "no", 14165)
    end
    SetFriendFellowShipValue(pname, 50 * 100)
    Msg2Player("§é th©n mËt gi÷a b¹n vµ §å ®Ö t¨ng thªm")
end

function shitu_1_cancel()
    RemoveIBBuff(216)
    SetTask(899, 0)
    TaskNote(43, -1)
    Talk(1, "no", 14166)
end

function judge_relation()
    local mark = 0
    if (GetTeam() ~= 0) then
        if (GetTeamSize() == 2) then
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            mark = IsMasterPRRelation(n)

            if (mark == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = 0
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function fangchenmi()
    local state
    local mark

    state = GetWeakState()

    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu2()
    Talk(1, "no", 10114)
    DelEventItem(1)
    Msg2Player("ThÇn Oanh kh«ng cã t¸c dông. §Õn t×m Hoµng Thiªn Hãa!")
    SetTask(1, 24)
    TaskNote(28, 14)

    refreshNpcTaskState()

end;

function renwu3()
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(3, "no", 10115, 10116, 10117)
        Msg2Player("§Õn D­îc ®iÕm t×m Hå Hû MÞ nghÜ c¸ch.")
        SetTask(1, 31)
        TaskNote(28, 16)

        refreshNpcTaskState()

    else
        Talk(1, "no", 11718)
    end
end;

function no()
    CloseDialog()
end;

function xianguo()
    local str = "§Õn Hoµn s©m còng kh«ng thÓ lµm cho nµng vui vÎ! …NÕu ng­¬i cã b¸u vËt nµo khiÕn cho nµng cã thÓ në nô c­êi, ta sÏ tÆng Hoµn s©m cho ng­¬i!"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "ChÝnh lµ thø nµy! Thóy Hoa nhÊt ®Þnh sÏ rÊt thÝch! Nh­ng ng­¬i ®õng nãi chuyÖn nµy cho §Æng ThiÒn Ngäc tiÓu th­ biÕt nhÐ!")

        DelNormalItem(3, 218, 0, 0)

        AddNormalItem(3, 222, 0, 0, 0, 0)

        if (GetBit(GetTask(Task_xianguo), 6) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 6, 1))
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            TaskNote(73, 1)

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

            refreshNpcTaskState()

        end
    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhÐ!")
    end
end;

build_renwu = 1255
build_npcIdx = 1256
build_npcId = 1257
build_nums = 1258

function construction()
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local lastday = GetByte(GetTask(build_renwu), 1)
    if (today ~= lastday) then
        SetTask(build_renwu, today)
        SetTask(build_npcIdx, 0)
        SetTask(build_npcId, 0)
        SetTask(build_nums, 0)
        refreshNpcTaskState()
    end

    if (GetByte(GetTask(build_renwu), 2) == 0) then
        MsgBox(14495, "constr_yes", "no")
    else
        Talk(1, "no", 14496)
    end
end

function constr_yes()
    if (GetByte(GetTask(build_renwu), 2) == 0) then
        AddNormalItem(6, 1, 389, 0, 0, 0)
        TaskNote(83, 0)
        SetTask(build_renwu, SetByte(GetTask(build_renwu), 2, 1))
        SetTask(build_renwu, SetByte(GetTask(build_renwu), 4, 0))
        SetTask(build_npcIdx, 0)
        SetTask(build_npcId, 0)
        SetTask(build_nums, 0)
        SyncBibleState(83, 2, 1)
        refreshNpcTaskState()
        Talk(3, "no", 14497, GetName() .. ": Kh«ng vÊn ®Ò g×! Nh­ng sau nµy ®õng cã ®a t×nh phong l­u n÷a!", "Ta sÏ dïng ph©n th©n vµ Thiªn Lý TruyÒn ©m h­íng dÉn cho ng­¬i. Nhí kü: ng­¬i ph¶i lµ <c=r>®éi tr­ëng<c> th× míi cã thÓ ®èi tho¹i víi ph©n th©n cña ta, vµ còng chØ cã thÓ ®èi tho¹i víi 1 ph©n th©n mµ th«i!...")
    else
        Talk(1, "no", 14496)
    end
end
















































































































































































































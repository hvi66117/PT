--description:npc
--author: zhujialiang
--date:2005/4/13
Task_PrepareMaterNum = 1050
Task_PrepareMaterial = 1049
Task_PrepareMark = 1125

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ýº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ý4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ý6ÕÒ·ç²®Í¼ÌÚ£©

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
    local startLevel = 10



    --Â÷Ìì¹ýº£
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 3) or (taskProcess == 5) or (taskProcess == 7) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) or (taskProcess == 6) then
                state = 2
                subState = 0
            else
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 3) or (taskProcess == 5) or (taskProcess == 7) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) or (taskProcess == 6) then
                state = 2
                subState = 0
            else
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

function main()
    local L_Mark = GetByte(GetTask(Task_PrepareMark), 3)
    if (GetTask(Task_PrepareMaterial) == 1 and GetPlayerType() == 2 and L_Mark == 0) then

        Talk(1, "no", 12337)
        AddNormalItem(3, 147, 0, 0, 0, 0)
        SetTask(Task_PrepareMark, SetByte(GetTask(Task_PrepareMark), 3, 1))

        return 1
    end

    if (GetPlayerType() == 2) then
        local state13 = GetTaskByte(Task_newer13, 1)
        if (state13 == 3) then
            Talk(1, "no", "T¹i sao ta c¶m thÊy träng l­îng viªn ®¬n nµy bÊt th­êng? å, lµm phiÒn anh hïng gióp ®em thuèc nµy ®Õn cho <c=r>§¹i phu ë Xi V­u Mé<c> xem thËt gi¶?")
            SetTaskByte(Task_newer13, 1, 4)
            Msg2Player("§em Thiªn Niªn B¶o T©n §an cho §¹i phu ë Xi V­u Mé ph©n biÖt thËt gi¶")
            TaskNote(205, 3)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
            return 0
        elseif (state13 == 5) then
            Talk(1, "no", "VËt tæ Phong B¸ d¸m g¹t ta, anh hïng gióp ta t×m VËt tæ Phong B¸ hái cho ra lÏ.")
            SetTaskByte(Task_newer13, 1, 6)
            Msg2Player("T×m VËt tæ Phong B¸ hái cho ra lÏ.")
            TaskNote(205, 5)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
            return 0
        elseif (state13 == 7) then
            Talk(1, "no", "Ta cã thÓ cho h¾n thêi h¹n vµi ngµy ®Ó b¾t hung thñ, hy väng anh hïng khi ®Õn cÊp 18 ®i hái gióp ta lÇn n÷a <c=r>VËt tæ Phong B¸<c> sù viÖc cã tiÕn triÓn g× kh«ng. Anh hïng ®· vÊt v¶ nhiÒu, phÇn th­ëng nhá nµy tÆng ng­êi thay cho lêi c¶m t¹.")
            SetTaskByte(Task_newer13, 1, 8)
            Msg2Player("§Õn cÊp 18 ®i hái lÇn n÷a VËt tæ Phong B¸ sù viÖc cã tiÕn triÓn g× kh«ng")
            --AS GaoJingwei 090730
            SetSubTask(205, -1, 1)
            --AE GaoJingwei 090730
            TaskNote(205, -1)
            DelEventItem(237)
            AddOwnExp(2500)
            Msg2Player("PhÇn th­ëng 2500 kinh nghiÖm.")
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
            return 0
        end
    end
    Talk(1, "no", 11145)
end;

function no()
    CloseDialog()
end;

--Ω≤∑®Ω¯∂»œÏ”¶.lua
--author: Gaojingwei
--date:2009/3/12

Task_Process = 1345      --1byte: 1:“—”⁄–ﬁ–– ¶∂‘ª∞£ª2~8£∫”Î7∏ˆ…Ò∂‘ª∞£ª9£∫¡Ï»°¡ÀΩ±¿¯£¨µ⁄“ª≤Ω»ŒŒÒΩ· ¯£ª
--10£∫¡Ï»°¡‘…±∑Á—˝µƒ»ŒŒÒ£ª11£∫¡‘…±ÕÍ≥…£ª12£∫¡Ï»°Ω±¿¯£¨’˚∏ˆ»ŒŒÒΩ· ¯
--Add by Doubiao for Œ ∫≈Ã· æat 2009/12/30 begin
--Add by Doubiao for Œ ∫≈Ã· æat 2009/12/30 begin
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng mÎ" },
    [2] = { state = 3, subState = 1, str = "Lam mÎ" },
    [3] = { state = 1, subState = 0, str = "Vµng Æ„ng" },
    [4] = { state = 1, subState = 1, str = "Lam Æ„ng" },
    [5] = { state = 2, subState = 0, str = "X∏m mÎ" },
    [6] = { state = 0, subState = 0, str = "Kh´ng c„ nhi÷m vÙ" },
}

--À—À˜”≈œ»º∂◊Ó∏ﬂµƒ◊¥Ã¨
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

--Ω≈±æ≈–∂œÕÊº“µƒ◊¥Ã¨
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    local nTarget = GetPlayerTarget()
    local strName = GetNpcName(nTarget)
    if (strName == "Thi’t Qu∏n ßπo Nh©n") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 1) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 1) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "PhÔ BÀt ßπo Nh©n") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 2) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 2) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "V´ ¶¨ng Tˆ") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 3) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 3) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "Nam Minh Tˆ") then
        --“ı—Ù÷Æµ¿ µ⁄“ª≤Ω
        startLevel = 36
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local step = GetTaskByte(Task_Catch_Wolf, 1)
            local num = GetTaskByte(Task_Catch_Wolf, 2)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (step == 0) then
                    state = 1
                    subState = 0
                elseif (step == 1) and (num >= 30) then
                    state = 3
                    subState = 0
                elseif (step == 1) and (num < 30) then
                    state = 2
                    subState = 0
                end
            else
                if (step == 0) then
                    state = 1
                    subState = 1
                elseif (step == 1) and (num >= 30) then
                    state = 3
                    subState = 1
                elseif (step == 1) and (num < 30) then
                    state = 2
                    subState = 0
                end
            end

            index = searchForIndex(state, subState, index)
        end
        --“ı—Ù÷Æµ¿ µ⁄∂˛≤Ω
        startLevel = 37
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local step = GetTaskByte(Task_Catch_Wolf, 1)
            local num = GetTaskByte(Task_Catch_Wolf, 3)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (step == 2) then
                    state = 1
                    subState = 0
                elseif (step == 3) and (num >= 3) then
                    state = 3
                    subState = 0
                elseif (step == 3 and num < 3) then
                    state = 2
                    subState = 0
                end
            else
                if (step == 2) then
                    state = 1
                    subState = 1
                elseif (step == 3) and (num >= 3) then
                    state = 3
                    subState = 1
                elseif (step == 3) and (num < 3) then
                    state = 2
                    subState = 0
                end
            end

            index = searchForIndex(state, subState, index)
        end
        --¡Ï√¸πÈ’Ê
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 4) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 4) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "V©n Trung Tˆ") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 5) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 5) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "Hoµng Long") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 6) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 6) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "D≠¨ng NhÀm") then
        --∞Ÿ¥®ª„æ€
        startLevel = 46
        if (GetPlayerExtLevel() >= startLevel) then
            if (GetPlayerExtLevel() - startLevel <= 5) then
                --Ω…´
                if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                    state = 1
                    subState = 0
                end
            else
                --¿∂…´
                if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                    state = 1
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

        --¡Ï√¸πÈ’Ê
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 7) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 7) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "B«n Minh T´n gi∂") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 1) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 1) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "Ly Nh˘u T´n Gi∂") then
        --“ı—Ù÷Æµ¿ µ⁄“ª≤Ω
        startLevel = 36
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local step = GetTaskByte(Task_Catch_Wolf, 1)
            local num = GetTaskByte(Task_Catch_Wolf, 2)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (step == 0) then
                    state = 1
                    subState = 0
                elseif (step == 1) and (num >= 30) then
                    state = 3
                    subState = 0
                elseif (step == 1) and (num < 30) then
                    state = 2
                    subState = 0
                end
            else
                if (step == 0) then
                    state = 1
                    subState = 1
                elseif (step == 1) and (num >= 30) then
                    state = 3
                    subState = 1
                elseif (step == 1) and (num < 30) then
                    state = 2
                    subState = 0
                end
            end

            index = searchForIndex(state, subState, index)
        end
        --“ı—Ù÷Æµ¿ µ⁄∂˛≤Ω
        startLevel = 37
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local step = GetTaskByte(Task_Catch_Wolf, 1)
            local num = GetTaskByte(Task_Catch_Wolf, 3)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (step == 2) then
                    state = 1
                    subState = 0
                elseif (step == 3) and (num >= 3) then
                    state = 3
                    subState = 0
                elseif (step == 3) and (num < 3) then
                    state = 2
                    subState = 0
                end
            else
                if (step == 2) then
                    state = 1
                    subState = 1
                elseif (step == 3) and (num >= 3) then
                    state = 3
                    subState = 1
                elseif (step == 3) and (num < 3) then
                    state = 2
                    subState = 0
                end
            end

            index = searchForIndex(state, subState, index)
        end

        --¡Ï√¸πÈ’Ê
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 2) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 2) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "HÂng L≠ ß¨n Kh∏ch") then
        --∞Ÿ¥®ª„æ€
        startLevel = 46
        if (GetPlayerExtLevel() >= startLevel) then
            if (GetPlayerExtLevel() - startLevel <= 5) then
                --Ω…´
                if (GetJusticEvilCredit() < 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                    state = 1
                    subState = 0
                end
            else
                --¿∂…´
                if (GetJusticEvilCredit() < 0 and GetTaskByte(Task_baichuan, 1) == 0) then
                    state = 1
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

        --¡Ï√¸πÈ’Ê
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 3) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 3) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "ß¨n Ti™u Ti™n tˆ") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 4) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 4) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "V≠¨ng Ma") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 5) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 5) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "L˝ H≠ng B∏") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 6) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 6) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    elseif (strName == "Cao H˜u Cµn") then
        --¡Ï√¸πÈ’Ê µ⁄“ª≤Ω
        startLevel = 30
        if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
            local process = GetTaskByte(Task_Process, 1)
            if (GetPlayerExtLevel() - startLevel <= 5) then
                if (process == 7) then
                    state = 3
                    subState = 0
                end
            else
                if (process == 7) then
                    state = 3
                    subState = 1
                end
            end

            index = searchForIndex(state, subState, index)
        end

    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

--À¢–¬npcµƒ◊¥Ã¨
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
--Add by Doubiao for Œ ∫≈Ã· æat 2009/12/30 end 

Task_Npc = {
    [1] = { [1] = "Thi’t Qu∏n ßπo Nh©n", [2] = "PhÔ BÀt ßπo Nh©n", [3] = "V´ ¶¨ng Tˆ", [4] = "Nam Minh Tˆ", [5] = "V©n Trung Tˆ", [6] = "Hoµng Long", [7] = "D≠¨ng NhÀm" },
    [2] = { [1] = "B«n Minh T´n gi∂", [2] = "Ly Nh˘u T´n Gi∂", [3] = "HÂng L≠ ß¨n Kh∏ch", [4] = "ß¨n Ti™u Ti™n tˆ", [5] = "V≠¨ng Ma", [6] = "L˝ H≠ng B∏", [7] = "Cao H˜u Cµn" }
}

function EndMotion(motionID)
    local nType = 1
    local extCredit = GetJusticEvilCredit()
    local process = GetTaskByte(Task_Process, 1)
    if (extCredit < 0) then
        nType = 2
    end

    if (motionID == Task_Process) then
        if (HaveIBBuff(548) == 0 and process >= 2 and process <= 7) then
            Msg2Player("Nhi÷m vÙ L‹nh M÷nh Quy Ch©n th t bπi, c„ th” Æ’n chÁ Tu Hµnh S≠ nhÀn lπi nhi÷m vÙ")
            TopMessage("Nhi÷m vÙ <c=g>L‹nh M÷nh Quy Ch©n<c> th t bπi!")
            TaskNote(1031, 7)
            return
        end

        if (process == 7) then
            RemoveIBBuff(548)
            SetTaskByte(Task_Process, 1, 8)
            refreshNpcTaskState()   --Add by Doubiao for Œ ∫≈Ã· æat 2009/12/30 
            Msg2Player("Gi∂ng ph∏p hoµn t t, v“ phÙc m÷nh Tu Hµnh S≠!")
            TaskNote(1031, 3)
            return
        end

        RemoveIBBuff(548)
        AddIBBuff(548)
        process = process + 1
        SetTaskByte(Task_Process, 1, process)
        refreshNpcTaskState()   --Add by Doubiao for Œ ∫≈Ã· æat 2009/12/30 
        Msg2Player("tranh thÒ thÍi gian v…n cﬂn, mau Æi t◊m" .. Task_Npc[nType][process] .. ", nghe gi∂ng ph∏p Æπo!")
        TopMessage("ßi t◊m" .. Task_Npc[nType][process])
        TaskNote(1031, 2, Task_Npc[nType][process])
    end
end

--AS GaoJingwei 091118
--Ω¯∂»Ãı±ª¥Ú∂œ ±µ˜
function InteruptMotion(MotionID)
end
--AE GaoJingwei 091118
star_dream = 1419

fireKingidx = 1420

function no()
    CloseDialog()
end;

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

    startLevel = 54
    if (GetLevel() >= startLevel) then
        local PID = GetNpcTask(DialogNpcIdx, 1)
        local step = GetTaskByte(star_dream, 1)
        if (GetLevel() - startLevel <= 5) then
            if (step == 9 and PID == 0) then
                state = 3
                subState = 0
            elseif (step == 10 and HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
                state = 3
                subState = 0
            elseif (step == 9 and PID == GetPlayerID()) then
                state = 2
                subState = 0
            end
        else
            if (step == 9 and PID == 0) then
                state = 3
                subState = 1
            elseif (step == 10 and HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
                state = 3
                subState = 1
            elseif (step == 9 and PID == GetPlayerID()) then
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

function main()
    local step = GetTaskByte(star_dream, 1)
    if (step < 9) then
        Talk(2, "no", "Ho¶ Ly TiÓu Yªu: *&(^(^(*&*^*&*(&(*(&(*(&(.", GetName() .. " …… Yªu qu¸i nµy m¸u ch¶y loang læ, thËt kú l¹!")

    elseif (step == 9) then
        local PID = GetNpcTask(DialogNpcIdx, 1)
        if (PID ~= 0 and PID ~= GetPlayerID()) then
            Talk(2, "no", "Ho¶ Ly TiÓu Yªu: .......", GetName() .. " Yªu qu¸i nµy d­êng nh­ ®ang tô hån ph¸ch, ta nªn theo dâi tr­íc råi nghÜ c¸ch øng phã sau!")
            return
        end
        if (PID == GetPlayerID()) then
            local hunidx = GetNpcTask(DialogNpcIdx, 2)
            if (GetNpcID(hunidx) == GetNpcTask(DialogNpcIdx, 3)) then
                Talk(1, "no", "Ho¶ Ly TiÓu Yªu: &*^&*%**(^&*^*(^(&*(&*^&**(&**&&*&*^*.", GetName() .. " B¶o vÖ hån Ho¶ Ly TiÓu Yªu míi lµ th­îng s¸ch!")
            else
                Talk(2, "no", "Ho¶ Ly TiÓu Yªu: .......", GetName() .. " Yªu qu¸i nµy d­êng nh­ ®ang tô hån ph¸ch, ta nªn theo dâi tr­íc råi nghÜ c¸ch øng phã sau!")
            end
            return
        end
        Talk(3, "Helpme", "Ho¶ Ly TiÓu Yªu: &*^&*^&*^()*&(&*(^*&^*&^*^*&^&*!", GetName() .. "Ho¶ Ly TiÓu Yªu ®ang gÆp nguy, ta ph¶i b¶o vÖ hån ph¸ch cña h¾n chu toµn.")

    elseif (step == 10) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Hµnh trang ®· ®Çy, h·y s¾p xÕp l¹i hµnh trang.")

            return
        end

        if (HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
            ClearItem(4, 248, 0, 1)
            AddNormalItem(4, 248, 0, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc vÕt ch÷ nhuèm m¸u, vÕt ch÷ nhuèm m¸u, kh«ng nh×n râ ch÷, mau ®Õn thØnh gi¸o Tinh Quan ë T©y Kú.")
            TopMessage("B¹n nhËn ®­îc <c=g>vÕt ch÷ nhuèm m¸u<c>")
            Talk(2, "no", "Ho¶ Ly TiÓu Yªu: &*^&*%*&^*(&(&*(&(&(*&(!", GetName() .. " Yªu qu¸i nµy ®­a ta 1 bøc huyÕt th­, nh­ng h¾n nãi n¨ng khã hiÓu, ta ph¶i vÒ thØnh gi¸o Tinh Quan ë T©y Kú!")
            TaskNote(1052, 6)
            refreshNpcTaskState()
        else
            Talk(1, "no", "Ho¶ Ly TiÓu Yªu: &*^&*%*&^*(&(&*(&(&(*&(!")
        end

    else
        Talk(1, "no", "Ho¶ Ly TiÓu Yªu: *&(^(^(*&*^*&*(&(*(&(*(&(.")
    end
end;

function Helpme()
    CloseDialog()
    SetNpcTask(DialogNpcIdx, 1, GetPlayerID())
    SetTask(fireKingidx, DialogNpcIdx)

    local m, x, y = GetNpcWorldPos(DialogNpcIdx)
    local PID = GetPlayerID()

    local npcidx1 = AddNpc(993, 50, SubWorld, (x + 8) * 32, (y + 6) * 32)
    SetNpcTimer(npcidx1, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 50)
    SetNpcTask(npcidx1, 1, PID)
    SetNpcCamp(npcidx1, 0)

    local npcidx2 = AddNpc(994, 45, SubWorld, (x + 9) * 32, (y + 7) * 32)
    SetNpcTimer(npcidx2, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 30)
    SetNpcTask(npcidx2, 1, PID)
    SetNpcTarget(npcidx2, npcidx1)

    SetNpcTimer(DialogNpcIdx, "\\script\\ontimer\\ÊÍ·Å»ðÀëÑýÍõ.lua", 60)
    SetNpcTask(DialogNpcIdx, 2, npcidx1)
    SetNpcTask(DialogNpcIdx, 3, GetNpcID(npcidx1))

    AddIBBuff(659)
    TaskNote(1052, 11)

    Msg2Player("Hån Ho¶ Ly TiÓu Yªu ®· xuÊt hiÖn, ph¶i b¶o ®¶m an toµn cho nã kh«ng bÞ Hån Phi Ph¸ch T¸n.")
    ScrollMessage("Hån Ho¶ Ly TiÓu Yªu ®· xuÊt hiÖn, ph¶i b¶o vÖ nã an toµn.")
    refreshNpcTaskState()
end;

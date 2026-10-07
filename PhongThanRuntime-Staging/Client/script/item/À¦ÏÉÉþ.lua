Task_Partner = 1657
Task_YiboProcess = 1658

Debuff_ID = 1244

function main()
    if (GetTaskByte(Task_YiboProcess, 1) == 5) then
        local teamState = Get_TeamState()
        if (teamState == 1) then
            TeamAction("Remove_Debuff_T", 0, 0, 0)
        else
            if (HaveIBBuff(Debuff_ID) > 0) then
                RemoveIBBuff(Debuff_ID)
                Msg2Player("D©y Khæn Tiªn ph¸t ra mét luång Kim quang, triÖt tiªu o¸n khÝ Th­ Hån!")
            end
        end
    else
        Msg2Player("Tr¹ng th¸i hiÖn t¹i kh«ng thÓ dïng D©y Khæn Tiªn!")
    end

end

function Remove_Debuff_T()
    if (HaveIBBuff(Debuff_ID) > 0) then
        RemoveIBBuff(Debuff_ID)
        Msg2Player("D©y Khæn Tiªn ph¸t ra mét luång Kim quang, triÖt tiªu o¸n khÝ Th­ Hån!")
    end
end

function Get_TeamState()
    if (GetTeamSize() ~= 2) then
        return 2
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) == Get_MateUUID()) then
        return 3
    end
    if (GetMateTask(Task_Partner) ~= GetPlayerID() and GetTask(Task_Partner) ~= Get_MateUUID()) then
        return 4
    end

    local selfIdx = PlayerIndex
    local mateIdx = Get_MatePlayerIndex()
    local mapid1, x1, y1 = GetWorldPos()
    PlayerIndex = mateIdx
    local mapid2, x2, y2 = GetWorldPos()
    PlayerIndex = selfIdx

    if (mapid1 ~= mapid2) then
        return 5
    end

    return 1
end

function Get_MateUUID()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    PlayerIndex = mateIdx
    local mateUUID = GetPlayerID()
    PlayerIndex = selfIdx
    return mateUUID
end

function Get_MatePlayerIndex()
    local prindex = 0
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    return prindex
end

function no()
    CloseDialog()
end


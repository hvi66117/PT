Task_Partner = 1657
Task_YiboProcess = 1658

Hunt_Buff = 1243

Debuff_ID = 1244

ShiJing = { name = "S­ Kinh", Item = { 6, 1, 798, 1, 0, 0 } }

function main()
    if (GetTaskByte(Task_YiboProcess, 1) == 4) then
        local mapid, x, y = GetWorldPos()
        local item = ShiJing.Item
        if (mapid ~= 18) then
            Msg2Player("ChØ ë Môc D· míi cã thÓ th«ng qua S­ Kinh triÖu håi Th­ Hån!")
            TopMessage("Ph¶i ®Õn Môc D· ®Ó th¶ Th­ Hån!")
            return
        end
        local teamState = Get_TeamState()
        if (teamState == 2) then
            Talk(1, "no", "Ph¶i cã 2 ng­êi tæ ®éi míi cã thÓ tiÕn hµnh nhiÖm vô nµy!")
        elseif (teamState == 3) then
            DelNormalItem(item[1], item[2], item[3], item[4])
            Talk(1, "no", "§ång ®éi cña ng­¬i ®· hñy nhiÖm vô, nÕu ng­¬i vÉn muèn tiÕp tôc thùc hiÖn, xin hñy ®i sau ®ã nhËn l¹i!")
        elseif (teamState == 4) then
            Talk(1, "no", "Ph¶i cã ng­êi ®· cïng ng­¬i nhËn nhiÖm vô lÇn tr­íc ®Õn, míi cã thÓ tiÕp tôc tiÕn hµnh!")
        elseif (teamState == 5) then
            Talk(1, "no", "§ång ®éi kh«ng ë Môc D·, kh«ng thÓ th¶ Th­ Hån!")
        else
            local idx, x, y = GetWorldPos()
            local npcidx = AddNpc(1743, 50, SubWorldID2Idx(idx), x * 32, y * 32)
            local npcID = GetNpcID(npcidx)

            SetNpcScript(npcidx, "\\script\\npcdeath\\Êé»ê.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\Êé»êontimer.lua", 60 * 3)

            Msg2Team("<c=yel>Th­ Hån<c> ®· xuÊt hiÖn! ChØ cã 10 phót ®Ó tiªu diÖt nã!")
            Msg2Team("C¸c ng­¬i ®· tróng chó gi¶m tèc cña <c=yel>Th­ Hån<c>, ph¶i sö dông D©y Khæn Tiªn míi cã thÓ gi¶i trõ!")

            AddIBBuff(Debuff_ID)
            AddIBBuff(Hunt_Buff)

            SetTaskByte(Task_YiboProcess, 1, 5)
            SetNpcTask(npcidx, 1, GetPlayerID())
            SetNpcTask(npcidx, 2, Get_MateUUID())

            local selfIndex = PlayerIndex
            local mateIdx = 0
            if (IsCaptain() == 0) then
                mateIdx = GetTeamMember(1)
            else
                mateIdx = GetTeamMember(2)
            end
            PlayerIndex = mateIdx

            AddIBBuff(Debuff_ID)
            AddIBBuff(Hunt_Buff)

            SetTaskByte(Task_YiboProcess, 1, 5)

            PlayerIndex = selfIndex

            DelNormalItem(item[1], item[2], item[3], item[4])

            TeamAction()
        end
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

    local selfIndex = PlayerIndex
    local mateIdx = 0
    if (IsCaptain() == 0) then
        mateIdx = GetTeamMember(1)
    else
        mateIdx = GetTeamMember(2)
    end
    PlayerIndex = mateIdx
    local mapid, x, y = GetWorldPos()
    PlayerIndex = selfIndex

    if (mapid ~= 18) then
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

Global_Day = 368
Global_Tree_Count = 369

Task_Double_Tree = 1693
Task_Partner_ID = 1694
Task_Tree_ID = 1695

function main()

    if (GetSex() ~= 0) then
        Talk(1, "no", "Sao l¹i ®Ó mü nh©n ph¶i ®éng tay vËy, hay lµ nh­êng cho anh hïng trong c©y ®i!")
        return
    end

    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "Ta cÇn ®­îc hai ng­êi c¸c ng­¬i chóc phóc, ®­¬ng nhiªn ph¶i cã c¶ 2 ng­êi th× míi cã hiÖu qu¶!")
        return
    end

    local nPlayer1Index = GetTeamMember(1)
    local nPlayer2Index = GetTeamMember(2)

    local nOldIndex = PlayerIndex

    PlayerIndex = nPlayer1Index
    local nPlayer1Step = GetTaskByte(Task_Double_Tree, 3)
    local nPlayer1ID = GetPlayerID()
    local szPlayer1Name = GetName()
    local nPlayer1Sex = GetSex()
    local nPlayer1Partner = GetTask(Task_Partner_ID)
    local w1, x1, y1 = GetWorldPos()

    PlayerIndex = nPlayer2Index
    local nPlayer2Step = GetTaskByte(Task_Double_Tree, 3)
    local nPlayer2ID = GetPlayerID()
    local szPlayer2Name = GetName()
    local nPlayer2Sex = GetSex()
    local nPlayer2Partner = GetTask(Task_Partner_ID)
    local w2, x2, y2 = GetWorldPos()

    PlayerIndex = nOldIndex

    if (nPlayer1Partner ~= nPlayer2ID) or (nPlayer2Partner ~= nPlayer1ID) then
        Talk(1, "no", "ChØ cã ®«i uyªn ­¬ng nµo yªu nhau thËt lßng, cïng nhau mang ta ®i trång ë <c=g>Kú S¬n<c> th× ta míi cã thÓ ®©m chåi nÈy léc.")
        return
    end

    if (w1 ~= 17) or (w2 ~= 17) then
        Talk(1, "no", "Hai ng­êi ph¶i cïng cã mÆt ë Kú S¬n míi cã thÓ trång ®­îc MÇm c©y.")
        return
    end

    if (nPlayer1Step ~= 1) or (nPlayer2Step ~= 1) then
        Talk(1, "no", "Mçi lÇn chØ cã thÓ trång ®­îc 1 MÇm c©y!")
        return
    end

    local nTx = x1
    local nTy = y1
    if (nPlayer2Sex == 0) then
        nTx = x2
        nTy = y2
    end

    local nTreeIndex = AddNpc(1814, 1, SubWorldID2Idx(17), nTx * 32, nTy * 32)

    if (nTreeIndex > 0) then

        SetNpcScript(nTreeIndex, "\\script\\item\\ÎÞ¾øÁøÊ÷.lua")
        SetNpcTask(nTreeIndex, 1, nPlayer1ID)
        SetNpcTask(nTreeIndex, 2, nPlayer2ID)
        SetNpcTask(nTreeIndex, 3, 0)
        SetNpcTask(nTreeIndex, 4, 0)
        SetNpcTask(nTreeIndex, 5, LocalSystemTime())
        SetNpcTask(nTreeIndex, 6, 0)

        if ((string.len(szPlayer1Name) + string.len(szPlayer2Name)) <= 23) then
            SetNpcName(nTreeIndex, szPlayer1Name .. " vµ " .. szPlayer2Name .. "-MÇm c©y")
        else
            SetNpcName(nTreeIndex, szPlayer1Name .. "_" .. szPlayer2Name)
        end

        SetNpcTimer(nTreeIndex, "\\script\\ontimer\\ÎÞ¾øÁøÊ÷Ãç¶¨Ê±.lua", 60)
        DelNormalItem(6, 1, 826, 0)

        PlayerIndex = nPlayer1Index
        SetTaskByte(Task_Double_Tree, 3, 2)
        SetTask(Task_Tree_ID, GetNpcID(nTreeIndex))
        ScrollMessage("Trång thµnh c«ng MÇm c©y")

        PlayerIndex = nPlayer2Index
        SetTaskByte(Task_Double_Tree, 3, 2)
        SetTask(Task_Tree_ID, GetNpcID(nTreeIndex))
        ScrollMessage("Trång thµnh c«ng MÇm c©y")

        PlayerIndex = nOldIndex
    end


end

function no()
    CloseDialog()
end

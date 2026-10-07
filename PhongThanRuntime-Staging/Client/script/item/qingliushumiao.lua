Task_qingming1 = 1193
Task_tree = 1194
Task_tree1 = 1195

function main()
    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "B¹n hiÖn cã qu¸ nhiÒu tr¹ng tr¸i trong ng­êi, xin xãa bít vµi tr¹ng th¸i míi cã thÓ trång mÇm!")
        return 0
    end

    local renwu = GetTask(Task_qingming1)
    local w, x, y = GetWorldPos()
    if (w ~= 16) then
        Msg2Player("MÇm nµy chØ cã thÓ trång ë Tam S¬n mµ th«i!")
        return 0
    end

    if (renwu == 0) then
        if (HaveNormalItem(6, 1, 348, 0) == 0) then

            return 0
        end

        local Newlvl = 60
        local NewIdx = 682
        if (GetLevel() > 90) then
            Newlvl = 100
            NewIdx = 684
        elseif (GetLevel() > 70) then
            Newlvl = 80
            NewIdx = 683
        end

        local newnpcidx = AddNpc(681, Newlvl, SubWorld, (x + 1) * 32, (y + 1) * 32)
        if (newnpcidx <= 0) then
            return 0
        end
        DelNormalItem(6, 1, 348, 0)

        AddNpc(NewIdx, Newlvl, SubWorld, (x + 1 + 5) * 32, (y + 2) * 32)
        AddNpc(NewIdx, Newlvl, SubWorld, (x + 1 + 3) * 32, (y + 1) * 32)
        AddNpc(NewIdx, Newlvl, SubWorld, (x + 1 + 3) * 32, (y + 1 - 5) * 32)
        AddNpc(NewIdx, Newlvl, SubWorld, (x + 1 + 3) * 32, (y + 1 - 3) * 32)

        SetCamp(1)
        Msg2Player("B¹n chuyÓn thµnh phe mµu n©u!")
        SetNpcScript(newnpcidx, "\\script\\npcdeath\\qingshu.lua")
        SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 130)

        SetTask(Task_tree, GetNpcID(newnpcidx))
        SetTask(Task_tree1, newnpcidx)
        SetTask(Task_qingming1, 1)
        RemoveIBBuff(438)
        AddIBBuff(438)

        TopMessage("MÇm c©y 2 phót sau míi lín")
        Msg2Player("MÇm hai phót n÷a sÏ lín, xin chó ý b¶o hé!")
    elseif (renwu == 10) then
        Talk(1, "no", "B¹n ®· b¶o hé mÇm c©y thµnh c«ng!")
    else
        local npcidx = GetTask(Task_tree1)
        local npcid = GetNpcID(npcidx)

        if (npcid ~= GetTask(Task_tree)) or (HaveIBBuff(438) == 0) then
            MsgBox("B¹n ®· cã thÓ trång ®­îc mÇm c©y míi!", "yes", "no")
        else
            Talk(1, "no", "B¹n ®ang b¶o hé 1 mÇm c©y, kh«ng thÓ trång mÇm kh¸c")
        end
    end
end;

function no()
    CloseDialog()
end

function yes()
    CloseDialog()
    SetTask(Task_qingming1, 0)
    main()
end

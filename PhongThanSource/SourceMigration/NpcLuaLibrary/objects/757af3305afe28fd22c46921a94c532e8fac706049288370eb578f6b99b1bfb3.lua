Task_zhixian = 1471

Task_stone = 1472
Task_Total_Times = 1460

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTask(Task_Total_Times) >= 24 and GetTaskByte(Task_zhixian, 1) == 16 and GetPlayerExtLevel() >= 53 and HaveIBBuff(692) == 0) then
        SetTask(Task_stone, DialogNpcIdx)

        if (GetJusticEvilCredit() > 0) then
            Talk(2, "queren", GetName() .. " Xem ra chÝnh lµ m¶nh HuyÒn Th¹ch nµy ®©y, nh­ng lµm thÕ nµo ®Ó më nã ra?", GetName() .. " Hõ, m¶nh HuyÒn Th¹ch nµy h×nh nh­ cã søc m¹nh g× ®ã b¶o vÖ, ®µnh ®Õn t×m <c=r>MËt th¸m Tiªn Giíi<c> hái xem cã c¸ch nµo më nã ra ®o¹t lÊy Tµn PhiÕn")
        elseif (GetJusticEvilCredit() < 0) then
            Talk(2, "queren", GetName() .. " Xem ra chÝnh lµ m¶nh HuyÒn Th¹ch nµy ®©y, nh­ng lµm thÕ nµo ®Ó më nã ra?", GetName() .. " Hõ, m¶nh HuyÒn Th¹ch nµy h×nh nh­ cã søc m¹nh g× ®ã b¶o vÖ, ®µnh ®Õn t×m <c=r>MËt th¸m Ma Giíi<c> hái xem cã c¸ch nµo më nã ra ®o¹t lÊy Tµn PhiÕn.")
        end
    end
end

function queren()
    CloseDialog()

    MsgBox(GetName() .. " VËy th× b¾t ®Çu vËn chuyÓn th«i.", "moveStone", "no")
end

function moveStone()
    CloseDialog()

    AddIBBuff(692)
    CaptureNpc(GetTask(Task_stone))

    if (GetJusticEvilCredit() > 0) then
        Msg2Player("Trong vßng 20 phót mang HuyÒn Th¹ch ®Õn t×m MËt Th¸m Tiªn Giíi")
        TaskNote(106, 8)
    elseif (GetJusticEvilCredit() < 0) then
        Msg2Player("Trong vßng 20 phót mang HuyÒn Th¹ch ®Õn t×m MËt Th¸m Ma Giíi")
        TaskNote(106, 7)
    end

    local stoneIndex = AddNpc(1067, 1, SubWorld, 2069 * 32, 3268 * 32)

    local newNpcName = "<c=g>" .. GetName() .. " HuyÒn Th¹ch<c>"
    SetNpcName(stoneIndex, newNpcName)
    SetNpcScript(stoneIndex, "\\script\\Óü·¨É½\\¾ÞÊ¯ÒÆ¶¯.lua")
    SetNpcTimer(stoneIndex, "\\script\\ontimer\\¾ÞÊ¯É¾µô×Ô¼º.lua", 1200)
    SetNpcTask(stoneIndex, 1, GetPlayerID())
    SetNpcTask(stoneIndex, 2, PlayerIndex)
    SetTask(Task_stone, stoneIndex)
end

function no()
    CloseDialog()
end

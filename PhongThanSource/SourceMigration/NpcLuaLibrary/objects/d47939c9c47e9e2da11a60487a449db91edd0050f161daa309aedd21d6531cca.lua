--description: ¾ÞÊ¯
--author: liuzhiqiang
--date: 2009/05/27

-------------------------------Óü·¨É½Ö§Ïß-------------------------------
Task_zhixian = 1471 --1byte£º1½ÓÈÎÎñ£¬2ÕÒ¶¾À¼²Ý£¬3ÕÒÁúÉàÀ¼£¬4ÕÒµ½2¶ä»¨£¬5µ÷Åä£¬6Íê³ÉÖ§ÏßÒ»£»
-- 8½ÓÊ§ÂäÖ®Êé£¬9»ñµÃ¹ÅÍ¼²ÐÆ¬£¬10Íê³ÉÖ§Ïß¶þ
--11½ÓÒÔ¾Æ»áÓÑ£¬12µÚÒ»´ÎÓëÙÈ×ÓÃ÷¶Ô»°£¬13ÃÜÌ½¸æÖªÒÔ¾Æ»áÓÑ£¬14ÓëÙÈ×ÓÃ÷Æ´¾Æ£¬15Íæ¼ÒÊ§°Ü£¬16Íæ¼ÒÊ¤³ö£¬17Íê³ÉÖ§ÏßÈý
--2byte:´ðÌâ¶ÔµÄ´ÎÊý
--3byte:´ðÌâ´íµÄ´ÎÊý
Task_stone = 1472  --¼ÇÂ¼Íæ¼ÒËùÍÆ¾ÞÊ¯Ë÷Òý
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊý

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

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
    --modify by liyudong at 2009-11-10 begin ---
    local stoneIndex = AddNpc(1067, 1, SubWorld, 2069 * 32, 3268 * 32) --¾ÞÊ¯
    --modify by liyudong at 2009-11-10 end ---
    local newNpcName = "<c=g>" .. GetName() .. " HuyÒn Th¹ch<c>"
    SetNpcName(stoneIndex, newNpcName)
    SetNpcScript(stoneIndex, "\\script\\Óü·¨É½\\¾ÞÊ¯ÒÆ¶¯.lua")
    SetNpcTimer(stoneIndex, "\\script\\ontimer\\¾ÞÊ¯É¾µô×Ô¼º.lua", 1200) --20·ÖÖÓ
    SetNpcTask(stoneIndex, 1, GetPlayerID())
    SetNpcTask(stoneIndex, 2, PlayerIndex)
    SetTask(Task_stone, stoneIndex)
end

function no()
    CloseDialog()
end

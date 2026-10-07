--»½Ä§Ëþ.lua
--author: GaoJingwei
--date:2009/2/5

task_renwu = 1309        --1byte£ºÊÇ·ñ½ÓÈÎÎñ£¬0±íÊ¾ÒÑ½Ó£¬1±íÊ¾Ã»½Ó£»2byte£ºÒÑ½ÓÈÎÎñµÄ´ÎÊý£»
--3byte:Ê£ÓàµÄ¹ÖÎï¸öÊý£»4byte:ÊÇ·ñÍê³ÉÈÎÎñ
totleNumber = 1311        --Íæ¼ÒÀÛ¼Æ½ÓÈÎÎñµÄ´ÎÊý
killTimes = 1325        --1byte:É±ËÀÊôÓÚ×Ô¼º¹ÖµÄ´ÎÊý;2byte:ÊÇ·ñÁìÈ¡¹ýÓñÊ¯

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (HaveEventItem(210) > 0) then
        --ÈôÓÐÕòÄ§Æì
        MsgBox("B¹n x¸c ®Þnh th¶ ra Phi Thè Ma?", "yes", "no")
    else
        Talk(1, "no", "Muèn më H« Ma th¸p cÇn cã TrÊn ma ph­ín.")
    end
    SetTask(142, GetNpcID(DialogNpcIdx))
end

function yes()
    no()
    if (GetTask(142) ~= GetNpcID(DialogNpcIdx)) then
        Msg2Player("Th¸p nµy ch­a kÝch ho¹t. Xin thö l¹i lÇn n÷a!")
        return
    end

    if (HaveEventItem(210) > 0 and HaveIBBuff(515) == 0 and GetTaskByte(task_renwu, 1) == 1) then
        if (GetNpcTask(DialogNpcIdx, 0) == 0) then
            --ÈôËþÃ»±»¼¤»î                                        			
            SetNpcTask(DialogNpcIdx, 0, 1)                      --±íÊ¾ËþÒÑ¼¤»î
            SetNpcTask(DialogNpcIdx, 6, SystemTime())           --¼¤»îËþÊ±µÄÊ±¼ä
            SetNpcTask(DialogNpcIdx, 1, 0)                      --Ë¢¹ÖµÄÅú´Î
            SetNpcTask(DialogNpcIdx, 3, PlayerIndex)            --¼ÇÂ¼Íæ¼Òidx
            SetNpcTask(DialogNpcIdx, 4, GetPlayerID())          --¼ÇÂ¼Íæ¼Òid
            SetNpcTask(DialogNpcIdx, 5, 0)                      --Ê£Óà¹ÖÎï¸öÊý
            SetNpcTask(DialogNpcIdx, 9, 0)                      --Ê£Óà¹ÖÎï¸öÊý

            SetTaskByte(killTimes, 1, 0)                        --É±ËÀÊôÓÚ×Ô¼º¹ÖµÄ¸öÊýÇåÁã
            SetTaskByte(killTimes, 2, 0)                        --Ã»ÓÐÁìÈ¡¹ýÓñÊ¯

            DelEventItem(210)
            AddIBBuff(515)                                      --Ôö¼ÓÒ»¸ö3·ÖÖÓµÄbuff
            --------------------ÊÍ·Å³öµÚÒ»Ö»¹Ö-----------------------
            local id, x, y = GetNpcWorldPos(DialogNpcIdx)
            local monsterNpcIdx = AddNpc(810, 15, SubWorldID2Idx(id), x * 32, y * 32 + 200)       --?Ôö¼ÓÒ»Ö»¹Ö
            SetNpcScript(monsterNpcIdx, "\\script\\npcdeath\\ìåÄ§ËÀÍö.lua")
            SetNpcTimer(monsterNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)                --¹ÖÔÚ3·ÖÖÓºóÏûÊ§
            SetNpcName(monsterNpcIdx, GetName() .. "Phi Thè Ma")

            SetNpcTask(DialogNpcIdx, 1, 1)                                                --Ë¢¹ÖµÄÅú´Î
            SetNpcTask(DialogNpcIdx, 2, 1)                                                    --Ë¢¹ÖµÄµØµã
            SetNpcTask(DialogNpcIdx, 5, 1)                                                    --¹ÖÎï¸öÊý¼Ó1

            local playerCredit
            if (GetJusticEvilCredit() > 0) then
                playerCredit = 1                                                --1±íÊ¾ÏÉ£¬0±íÊ¾Ä§
            else
                playerCredit = 0
            end
            SetNpcTask(monsterNpcIdx, 0, GetPlayerID())                       --¹ÖµÄµÚÒ»¸ö¿Õ¼ä¼ÇÂ¼Íæ¼ÒID
            SetNpcTask(monsterNpcIdx, 1, playerCredit)                        --µÚ¶þ¸ö¿Õ¼ä¼ÇÂ¼Íæ¼ÒµÄÉùÍû 
            SetNpcTask(monsterNpcIdx, 2, DialogNpcIdx)                        --¼ÇÂ¼ËþµÄidx
            --------------------ÊÍ·Å³öµÚÒ»Ö»¹Ö-----------------------

            SetNpcTimer(DialogNpcIdx, "\\script\\ontimer\\»½Ä§Ëþ¶¨Ê±.lua", 9)    --Ã¿10Ãëµ÷ÓÃÒ»´Î
            Msg2Player("H« Ma th¸p®· ®­îc kÝch ho¹t, Phi Thè Ma sÏ liªn tôc xuÊt hiÖn! Xin h·y mau siªu ®é chóng!")
            Msg2Player("th¶ ra 1 Phi Thè Ma")
            TaskNote(1026, 2, "H« Ma th¸p", "Phi Thè Ma")
            --			ScrollMessage("Ëþ±»¼¤»î")
            CloseDialog()
            SetTaskByte(task_renwu, 1, 2)
        else
            Talk(1, "no", "Th¸p nµy ®· bÞ ng­êi kh¸c kÝch ho¹t, xin h·y ®îi l¸t n÷a thö l¹i!")
        end
    else
        if (GetTaskByte(task_renwu, 1) == 0) then
            Talk(1, "no", "B¹n ch­a l·nh nhËn nhiÖm vô!")
        else
            Talk(1, "no", "Muèn më H« Ma th¸p cÇn cã TrÊn ma ph­ín.")
        end
    end
end

function no()
    CloseDialog()
end

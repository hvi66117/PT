--²¶×½ºµ¹êÌìÎâ.lua
--author: Gaojingwei
--date: 2009/03/25
---------Àë¼äÖ®¼Æ-----------
Task_Mischief = 1357  --1byte:0Ã»ÁìÈÎÎñ£»1£ºÁìÈ¡ÁË²¶×½ÈÎÎñ£»2£ºÍê³É²¶×½£¬ÁìÈ¡ÁË½±Àø£»3£ºÁìÈ¡ÁËÁÔÉ±ºµ¹êÊ×ÁìµÄÈÎÎñ£»4:ÒÑ±ä³Éºµ¹ê×´Ì¬£»5£ºÍê³ÉÈÎÎñ
--2byte:²¶×½ºµ¹êµÄ¸öÊı;3byte:²¶×½ÌìÎâµÄ¸öÊı£»4£ºÁÔÉ±ÌìÎâµÄ¸öÊı
hanguiID = 24        --ºµ¹êID
tianwuID = 16        --ÌìÎâID
---------Àë¼äÖ®¼Æ-----------

function EndMotion(MotionID)
    local TargetNpcIdx = GetPlayerTarget()
    local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)
    local hanguiNum = GetTaskByte(Task_Mischief, 2)
    local tianwuNum = GetTaskByte(Task_Mischief, 3)

    if (MotionID == Task_Mischief) then
        if (GetTaskByte(Task_Mischief, 1) ~= 1 or (TargetNpcIdx == 0) or (npcTemplateID ~= 16 and npcTemplateID ~= 24)) then
            return
        else
            if (npcTemplateID == 24) then
                CaptureNpc(TargetNpcIdx)
                hanguiNum = hanguiNum + 1
                SetTaskByte(Task_Mischief, 2, hanguiNum)
                ScrollMessage("B¾t ®­îc 1 Giang Quy")
                Msg2Player("B¾t ®­îc 1 Giang Quy.")
                TaskNote(1035, 1, "<c=r>Giang Quy<c>", hanguiNum, "<c=r>Thiªn H¹o<c>", tianwuNum)
                if (hanguiNum == 5 and tianwuNum == 5) then
                    ScrollMessage("Hoµn thµnh nhiÖm vô b¾t Giang Quy vµ Thiªn H¹o")
                    Msg2Player("Hoµn thµnh nhiÖm vô b¾t Giang Quy vµ Thiªn H¹o")
                    TaskNote(1035, 2)
                end
            elseif (npcTemplateID == 16) then
                CaptureNpc(TargetNpcIdx)
                tianwuNum = tianwuNum + 1
                SetTaskByte(Task_Mischief, 3, tianwuNum)
                ScrollMessage("B¾t ®­îc 1 Thiªn H¹o")
                Msg2Player("B¾t ®­îc 1 Thiªn H¹o.")
                TaskNote(1035, 1, "<c=r>Giang Quy<c>", hanguiNum, "<c=r>Thiªn H¹o<c>", tianwuNum)
                if (tianwuNum == 5 and hanguiNum == 5) then
                    ScrollMessage("Hoµn thµnh nhiÖm vô b¾t Giang Quy vµ Thiªn H¹o")
                    Msg2Player("Hoµn thµnh nhiÖm vô b¾t Giang Quy vµ Thiªn H¹o")
                    TaskNote(1035, 2)
                end
            end
        end
    end
end

--AS GaoJingwei 091118
--½ø¶ÈÌõ±»´ò¶ÏÊ±µ÷
function InteruptMotion(MotionID)
end
--AE GaoJingwei 091118
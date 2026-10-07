Task_Mischief = 1357

hanguiID = 24
tianwuID = 16

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
                ScrollMessage("B¾t ®­îc 1 H¹n Quy")
                Msg2Player("B¾t ®­îc 1 H¹n Quy.")
                TaskNote(1035, 1, "<c=r>H¹n Quy<c>", hanguiNum, "<c=r>Thiªn Ng«<c>", tianwuNum)
                if (hanguiNum == 5 and tianwuNum == 5) then
                    ScrollMessage("Hoµn thµnh nhiÖm vô b¾t H¹n Quy vµ Thiªn Ng«")
                    Msg2Player("Hoµn thµnh nhiÖm vô b¾t H¹n Quy vµ Thiªn Ng«")
                    TaskNote(1035, 2)
                end
            elseif (npcTemplateID == 16) then
                CaptureNpc(TargetNpcIdx)
                tianwuNum = tianwuNum + 1
                SetTaskByte(Task_Mischief, 3, tianwuNum)
                ScrollMessage("B¾t ®­îc 1 Thiªn Ng«")
                Msg2Player("B¾t ®­îc 1 Thiªn Ng«.")
                TaskNote(1035, 1, "<c=r>H¹n Quy<c>", hanguiNum, "<c=r>Thiªn Ng«<c>", tianwuNum)
                if (tianwuNum == 5 and hanguiNum == 5) then
                    ScrollMessage("Hoµn thµnh nhiÖm vô b¾t H¹n Quy vµ Thiªn Ng«")
                    Msg2Player("Hoµn thµnh nhiÖm vô b¾t H¹n Quy vµ Thiªn Ng«")
                    TaskNote(1035, 2)
                end
            end
        end
    end
end

function InteruptMotion(MotionID)
end

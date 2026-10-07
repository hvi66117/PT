Destroy_Ani1 = 1039;
Destroy_Ani2 = 1040;
Destroy_Ani3 = 1041;
Destroy_Ani4 = 1042;
Task_Destroy = 1038;
Task_jiangyao = 1105;
Task_jiangyaoGuai1 = 1106;
Task_jiangyaoGuai2 = 1107;
Task_jiangyaoGuai3 = 1108;
Task_jiangyaoGuai4 = 1109;
--ÒìÈË½µÑý·üÄ§ÈÎÎñ±äÁ¿
Task_KillDevil = 1092;
Devil_Member1 = 1093;
Devil_Member2 = 1094;
Devil_Member3 = 1095;
Devil_Member4 = 1096;
--
function OnDeath(npcindex)
    local nPlayerType = GetPlayerType()
    if (nPlayerType == 0) then
        local nTaskNum = GetTask(Task_Destroy)
        if (nTaskNum >= 2 and nTaskNum <= 6) then
            if (GetTask(Destroy_Ani1) == npcindex or GetTask(Destroy_Ani2) == npcindex or GetTask(Destroy_Ani3) == npcindex or GetTask(Destroy_Ani4) == npcindex) then
                local nRealNum = nTaskNum - 1
                if (nRealNum >= 4) then

                    SetTask(Task_Destroy, 10)
                    TaskNote(903, 2)
                    TopMessage(11665)
                    Msg2Player("Hoµn thµnh nhiÖm vô Trõ yªu!")
                else
                    SetTask(Task_Destroy, (nTaskNum + 1))
                    TaskNote(903, 1, nRealNum, 4)
                end
            end
        end

    elseif (nPlayerType == 1) then
        local nTaskNum = GetTask(Task_jiangyao)
        if (nTaskNum >= 2 and nTaskNum <= 6) then
            if (GetTask(Task_jiangyaoGuai1) == npcindex or GetTask(Task_jiangyaoGuai2) == npcindex or GetTask(Task_jiangyaoGuai3) == npcindex or GetTask(Task_jiangyaoGuai4) == npcindex) then
                local nRealNum = nTaskNum - 1
                if (nRealNum >= 4) then
                    SetTask(Task_jiangyao, 10)
                    TaskNote(912, 2)
                    TopMessage(11665)
                    Msg2Player("Hoµn thµnh nhiÖm vô Trõ yªu!")
                else
                    SetTask(Task_jiangyao, (nTaskNum + 1))
                    TaskNote(912, 1, nRealNum, 4)
                end
            end
        end
    end

    local nTaskDevilNum = GetTask(Task_KillDevil)
    if (nTaskDevilNum >= 2 and nTaskDevilNum <= 6) then
        if (GetTask(Devil_Member1) == npcindex or GetTask(Devil_Member2) == npcindex or GetTask(Devil_Member3) == npcindex or GetTask(Devil_Member4) == npcindex) then
            local nRealNum = nTaskDevilNum - 1
            if (nRealNum >= 4) then
                SetTask(Task_KillDevil, 10)
                TaskNote(1004, 2)
                TopMessage(11665)
                Msg2Player("Hoµn thµnh nhiÖm vô Trõ yªu!")
            else
                SetTask(Task_KillDevil, (nTaskDevilNum + 1))
                TaskNote(1004, 1, nRealNum, 4)
            end
        end
    end ;
    DelNpc(npcindex)

end
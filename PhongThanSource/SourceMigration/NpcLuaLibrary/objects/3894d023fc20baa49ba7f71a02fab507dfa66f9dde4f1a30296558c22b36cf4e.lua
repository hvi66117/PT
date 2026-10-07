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

function main(sel)
    if (GetTask(Task_Destroy) == 1 and GetPlayerType() == 0) then
        if (GetFightState() == 0) then
            AddNormalItem(6, 1, 275, 1, 0, 0)
            TopMessage("Ph¶i ®Æt ë ngoµi thµnh")
            Msg2Player("Ngoµi thµnh míi cã thÓ sö dông!")
            return
        end
        AddIBBuff(333)
        local w, x, y = GetWorldPos()
        local newnpcidx = AddNpc(574, 10, SubWorld, (x + 1) * 32, (y) * 32)
        local newnpcidx1 = AddNpc(573, 20, SubWorld, (x + 1 + 5) * 32, (y) * 32)
        local newnpcidx2 = AddNpc(573, 20, SubWorld, (x + 1 - 5) * 32, (y) * 32)
        local newnpcidx3 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y + 5) * 32)
        local newnpcidx4 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y - 5) * 32)
        SetTask(Destroy_Ani1, newnpcidx1)
        SetTask(Destroy_Ani2, newnpcidx2)
        SetTask(Destroy_Ani3, newnpcidx3)
        SetTask(Destroy_Ani4, newnpcidx4)
        SetNpcCurCamp(newnpcidx, 8)
        --		SetCurCamp(8)
        SetTask(Task_Destroy, 2)
        return
    elseif (GetTask(Task_jiangyao) == 1 and GetPlayerType() == 1) then
        if (GetFightState() == 0) then
            AddNormalItem(6, 1, 275, 1, 0, 0)
            TopMessage("Ph¶i ®Æt ë ngoµi thµnh")
            Msg2Player("Ngoµi thµnh míi cã thÓ sö dông!")
            return
        end
        AddIBBuff(333)
        local w, x, y = GetWorldPos()
        local newnpcidx = AddNpc(574, 10, SubWorld, (x + 1) * 32, (y) * 32)
        local newnpcidx1 = AddNpc(573, 20, SubWorld, (x + 1 + 5) * 32, (y) * 32)
        local newnpcidx2 = AddNpc(573, 20, SubWorld, (x + 1 - 5) * 32, (y) * 32)
        local newnpcidx3 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y + 5) * 32)
        local newnpcidx4 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y - 5) * 32)
        SetTask(Task_jiangyaoGuai1, newnpcidx1)
        SetTask(Task_jiangyaoGuai2, newnpcidx2)
        SetTask(Task_jiangyaoGuai3, newnpcidx3)
        SetTask(Task_jiangyaoGuai4, newnpcidx4)
        SetNpcCurCamp(newnpcidx, 8)
        --		SetCurCamp(8)
        SetTask(Task_jiangyao, 2)
        return
        --	ÒìÈË½µÑý·üÄ§ÈÎÎñ
    elseif (GetTask(Task_KillDevil) == 1 and GetPlayerType() == 2) then
        if (GetFightState() == 0) then
            AddNormalItem(6, 1, 275, 1, 0, 0)
            TopMessage("Ph¶i ®Æt ë ngoµi thµnh")
            Msg2Player("Ngoµi thµnh míi cã thÓ sö dông!")
            return
        end
        AddIBBuff(333)
        local w, x, y = GetWorldPos()
        local newnpcidx = AddNpc(574, 10, SubWorld, (x + 1) * 32, (y) * 32)
        local newnpcidx1 = AddNpc(573, 20, SubWorld, (x + 1 + 5) * 32, (y) * 32)
        local newnpcidx2 = AddNpc(573, 20, SubWorld, (x + 1 - 5) * 32, (y) * 32)
        local newnpcidx3 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y + 5) * 32)
        local newnpcidx4 = AddNpc(573, 20, SubWorld, (x + 1) * 32, (y - 5) * 32)
        SetTask(Devil_Member1, newnpcidx1)
        SetTask(Devil_Member2, newnpcidx2)
        SetTask(Devil_Member3, newnpcidx3)
        SetTask(Devil_Member4, newnpcidx4)
        SetNpcCurCamp(newnpcidx, 8)
        SetTask(Task_KillDevil, 2)
        return
    end
    --  ÒìÈË½µÑý·üÄ§ÈÎÎñ
    AddNormalItem(6, 1, 275, 1, 0, 0)
end;

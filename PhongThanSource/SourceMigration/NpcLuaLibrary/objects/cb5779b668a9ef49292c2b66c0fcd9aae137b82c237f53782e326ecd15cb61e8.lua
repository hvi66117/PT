--偷取火离精魄.lua
--author:Laiyongcong
--date:2009-4-20

Task_Variety_Process = 1389        --1byte: 0没领任务，1领了任务 2在星官处领取了奖励 3领取了探知沙魂的任务 4成功与单纯沙魂对话 5在黄天化处领取了奖励
--6领取了杀三鱼的任务  7与医生对话 8与大头鱼对话 9与折罗鱼对话 10与巨骨舌鱼对话 11在黄天化处奖励

--12见完祝融，13杀完15个火离小妖，14得到魂帛，15祝融阅读记忆后，16领取黄天化奖励    -----火离精魄

--2byte: 1接到过初见端倪的通知 2接到过三鱼之乱的通知 3接到过火离精魄的通知 4 接到过背后主谋的通知
--3byte：本次杀死火离小妖的数目
--4Byte:本次杀死菌人的数目
function EndMotion(MotionID)
    if (MotionID == Task_Variety_Process) then

        local TargetNpcIdx = GetPlayerTarget()

        if (TargetNpcIdx ~= 0 and GetNpcTemplateID(TargetNpcIdx) == 22) then
            CaptureNpc(TargetNpcIdx)
            AddNormalItem(4, 234, 1, 0, 0, 0)
            TopMessage("B筺 nh薾 th祅h c玭g <c=g>H醓 Ly Tinh Ph竎h<c>")
            Msg2Player("B筺 nh薾 th祅h c玭g H醓 Ly Tinh Ph竎h")
            TaskNote(1046, 4)
            ClearItem(6, 1, 486, 1)--扣除魂帛
        end
    end
end;

--AS GaoJingwei 091118
--进度条被打断时调
function InteruptMotion(MotionID)
end
--AE GaoJingwei 091118

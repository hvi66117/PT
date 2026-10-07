--buff548.lua
Task_Process = 1345      --1byte: 1:已于修行师对话；2~8：与7个神对话；9：领取了奖励，第一步任务结束；
--10：领取猎杀风妖的任务；11：猎杀完成；12：领取奖励，整个任务结束
function main()
    local process = GetTaskByte(Task_Process, 1)
    if (process > 0 and process < 8) then
        InterruptMotion()
        SetTaskByte(Task_Process, 1, 0)
        Msg2Player("Х h襱 th阨 gian gi秐g ph竝, L躰h M謓h Quy Ch﹏ th蕋 b筰!")
        TopMessage("<c=g>L躰h M謓h Quy Ch﹏<c> th蕋 b筰!")
        TaskNote(1031, 7)
    end
end
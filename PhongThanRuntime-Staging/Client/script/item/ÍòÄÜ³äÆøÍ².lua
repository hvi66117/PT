Task_Challenge_Accept = 1396
Task_Challenge_Enter = 1397
Task_Challenge_Growth = 1398
Task_Challenge_Kill = 1399
Task_Challenge_Begin = 1400

Task_Info_Challenge = 204
Buff_Challenge = 649
Const_Kill_Burst = 10
Const_Kill_Interval = 3

function main()

    local w, x, y = GetWorldPos()
    if (w ~= 18) then
        Talk(1, "no", "ChØ cã thÓ sö dông t¹i Môc D·")
        return
    end

    local taskDate = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus = GetTaskByte(Task_Challenge_Enter, 4)

    local growth = GetTaskByte(Task_Challenge_Growth, 1)
    local useFill = GetTaskByte(Task_Challenge_Growth, 2)
    local useFillCount = GetTaskByte(Task_Challenge_Growth, 3)
    local preTime = GetTask(Task_Challenge_Kill)
    local localTime = LocalSystemTime()

    if (taskStatus == 0) then
        Talk(1, "no", "ChØ khi tham gia cuéc thi khiªu chiÕn giíi h¹n míi ®­îc sö dông .")
        return
    elseif (taskStatus == 3) then
        Talk(1, "no", "KhÝ cÇu cña b¹n ®· næ, mau ®i t×m ®¹i phu Môc D· nhËn phÇn th­ëng ®i.")
        return
    elseif (useFill == 1) then
        Talk(1, "no", "B¹n ®· sö dông 1 lÇn, kh«ng thÓ sö dông tiÕp.")
        return
    else
        ClearItem(6, 1, 492, 0)
        SetTaskByte(Task_Challenge_Growth, 2, 1)
        SetTaskByte(Task_Challenge_Growth, 3, 0)
        TopMessage("§· sö dông èng b¬m h¬i v¹n n¨ng")
        Msg2Player("§· sö dông èng b¬m h¬i v¹n n¨ng, gi÷ cho khÝ cÇu cña b¹n cã 10 c¸i c¨ng h¬i vµ kh«ng bÞ næ vì.")
        Talk(1, "no", "§· sö dông èng b¬m h¬i v¹n n¨ng, gi÷ cho khÝ cÇu cña b¹n cã 10 c¸i c¨ng h¬i vµ kh«ng bÞ næ vì.")
    end
end

function no()
    CloseDialog()
end;

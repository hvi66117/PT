task_renwu = 1309

totleNumber = 1311
killTimes = 1325

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (HaveEventItem(211) > 0) then
        MsgBox("B¹n x¸c ®Þnh th¶ ra Hung Tiªn?", "yes", "no")
    else
        Talk(1, "no", "Muèn më H« Tiªn th¸p cÇn cã To¶ Tiªn bµi.")
    end
    SetTask(142, GetNpcID(DialogNpcIdx))
end

function yes()
    no()
    if (GetTask(142) ~= GetNpcID(DialogNpcIdx)) then
        Msg2Player("Th¸p nµy ch­a kÝch ho¹t. Xin thö l¹i lÇn n÷a!")
        return
    end

    if (HaveEventItem(211) > 0 and HaveIBBuff(515) == 0 and GetTaskByte(task_renwu, 1) == 1) then
        if (GetNpcTask(DialogNpcIdx, 0) == 0) then
            SetNpcTask(DialogNpcIdx, 0, 1)
            SetNpcTask(DialogNpcIdx, 6, SystemTime())
            SetNpcTask(DialogNpcIdx, 1, 0)
            SetNpcTask(DialogNpcIdx, 3, PlayerIndex)
            SetNpcTask(DialogNpcIdx, 4, GetPlayerID())
            SetNpcTask(DialogNpcIdx, 5, 0)
            SetNpcTask(DialogNpcIdx, 9, 0)

            SetTaskByte(killTimes, 1, 0)
            SetTaskByte(killTimes, 2, 0)

            DelEventItem(211)
            AddIBBuff(515)

            local id, x, y = GetNpcWorldPos(DialogNpcIdx)
            local monsterNpcIdx = AddNpc(809, 15, SubWorldID2Idx(id), x * 32, y * 32 + 200)
            SetNpcScript(monsterNpcIdx, "\\script\\npcdeath\\Ð×ÏÉËÀÍö.lua")
            SetNpcTimer(monsterNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)
            SetNpcName(monsterNpcIdx, GetName() .. "_Hung Tiªn")

            SetNpcTask(DialogNpcIdx, 1, 1)
            SetNpcTask(DialogNpcIdx, 2, 1)
            SetNpcTask(DialogNpcIdx, 5, 1)

            local playerCredit
            if (GetJusticEvilCredit() > 0) then
                playerCredit = 1
            else
                playerCredit = 0
            end
            SetNpcTask(monsterNpcIdx, 0, GetPlayerID())
            SetNpcTask(monsterNpcIdx, 1, playerCredit)
            SetNpcTask(monsterNpcIdx, 2, DialogNpcIdx)

            SetNpcTimer(DialogNpcIdx, "\\script\\ontimer\\ºôÏÉËþ¶¨Ê±.lua", 9)
            Msg2Player("H« Tiªn th¸p ®· ®­îc kÝch ho¹t, Hung Tiªn sÏ liªn tôc xuÊt hiÖn! Xin h·y mau siªu ®é chóng!")
            Msg2Player("th¶ ra 1 Hung Tiªn")
            TaskNote(1026, 3, "H« Tiªn th¸p", "Hung Tiªn")

            CloseDialog()
            SetTaskByte(task_renwu, 1, 2)
        else
            Talk(1, "no", "Th¸p nµy ®· bÞ ng­êi kh¸c kÝch ho¹t, xin h·y ®îi l¸t n÷a thö l¹i!")
        end
    else
        if (GetTaskByte(task_renwu, 1) == 0) then
            Talk(1, "no", "B¹n ch­a l·nh nhËn nhiÖm vô!")
        else
            Talk(1, "no", "Muèn më H« Tiªn th¸p cÇn cã To¶ Tiªn bµi.")
        end
    end
end

function no()
    CloseDialog()
end

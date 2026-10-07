TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_NPCID = 1517
TASK_CRLH_G_COUNT = 241
TASK_CRLH_G_TOTAL = 242

function main()
    if (GetLevel() >= 100 and GetTaskByte(TASK_CRLH, 1) == 3 and GetTaskByte(TASK_CRLH, 2) == 2 and GetPlayerID() == GetNpcTask(DialogNpcIdx, 1)) then
        Talk(1, "attack", "Linh khÝ tø ph­¬ng b¾t ®Çu dao ®éng, ThÊt Ph¸ch ®ang ®Õn gÇn! CÈn thËn ®èi phã!")

    end
end;

function attack()
    CloseDialog()

    local loca_x = GetTaskWord(TASK_CRLH_LOCATION, 1)
    local loca_y = GetTaskWord(TASK_CRLH_LOCATION, 2)

    DelNpc(GetTask(TASK_CRLH_ROUSHEN_IDX))
    local newnpcidx = AddNpc(1209, 85, SubWorld, loca_x * 32, loca_y * 32)
    SetTask(TASK_CRLH_ROUSHEN_IDX, newnpcidx)
    SetTask(TASK_CRLH_NPCID, GetNpcID(newnpcidx))
    SetNpcTask(newnpcidx, 1, GetPlayerID())
    SetNpcTask(newnpcidx, 2, 0)
    SetNpcTask(newnpcidx, 3, PlayerIndex)
    SetNpcTask(newnpcidx, 4, 0)
    SetNpcTask(newnpcidx, 5, 0)
    SetNpcTask(newnpcidx, 6, loca_x)
    SetNpcTask(newnpcidx, 7, loca_y)
    SetNpcTask(newnpcidx, 8, 0)
    SetNpcTask(newnpcidx, 9, newnpcidx)
    SetNpcTask(newnpcidx, 10, GetNpcID(newnpcidx))
    SetNpcTimer(newnpcidx, "\\script\\ontimer\\¾øìÇÕÐ¹Ö.lua", 10)

    SetNpcTask(newnpcidx, 5, 3)

    for i = 1, 3, 1 do
        local newnpcidx1 = CallMonsterAttacker(GetTask(TASK_CRLH_ROUSHEN_IDX),
                1206,
                85,
                (loca_x + math.random(1, 5) - 3) * 32,
                (loca_y + math.random(1, 5) - 3) * 32,
                "\\script\\ontimer\\É¾µô×Ô¼º.lua",
                180,
                "\\script\\npcdeath\\ÆÇËÀÍö.lua",
                0,
                15)
        SetNpcTask(newnpcidx1, 1, GetPlayerID())
        SetNpcTask(newnpcidx1, 2, newnpcidx)
        SetNpcTask(newnpcidx1, 3, GetNpcID(newnpcidx))
    end

    SetNpcTask(newnpcidx, 4, 3)

end

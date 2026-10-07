--description:item
--author: huyuzhang
--date:2009/7/29


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
    local newnpcidx = AddNpc(1209, 85, SubWorld, loca_x * 32, loca_y * 32)    --Ìí¼Ó¿É±»¹¥»÷µÄ
    SetTask(TASK_CRLH_ROUSHEN_IDX, newnpcidx)    --ÓÃÓÚÏÂ´ÎÉ¾µô	
    SetTask(TASK_CRLH_NPCID, GetNpcID(newnpcidx))--¼ÇÂ¼NPCID ¼ì²éÊÇ·ñ´æÔÚ
    SetNpcTask(newnpcidx, 1, GetPlayerID())        --¼ÇÂ¼Íæ¼Ò¹éÊô
    SetNpcTask(newnpcidx, 2, 0)                    --µ÷ÓÃ¼ÆÊý
    SetNpcTask(newnpcidx, 3, PlayerIndex)        --¼ÇÂ¼Íæ¼ÒIDX
    SetNpcTask(newnpcidx, 4, 0)                    --¼ÇÂ¼µ±Ç°´æÔÚµÄÆÇÊýÁ¿
    SetNpcTask(newnpcidx, 5, 0)                    --¼ÇÂ¼Ò»¹²Ë¢ÐÂÁË¶àÉÙ¸ö
    SetNpcTask(newnpcidx, 6, loca_x)            --¼ÇÂ¼µ±Ç°X×ø±ê
    SetNpcTask(newnpcidx, 7, loca_y)            --¼ÇÂ¼µ±Ç°Y×ø±ê
    SetNpcTask(newnpcidx, 8, 0)                    --»÷É±ÊýÁ¿
    SetNpcTask(newnpcidx, 9, newnpcidx)
    SetNpcTask(newnpcidx, 10, GetNpcID(newnpcidx))
    SetNpcTimer(newnpcidx, "\\script\\ontimer\\¾øìÇÕÐ¹Ö.lua", 10)

    --³õÊ¼Ë¢ÐÂ3¸ö¹Ö
    SetNpcTask(newnpcidx, 5, 3)

    for i = 1, 3, 1 do
        local newnpcidx1 = CallMonsterAttacker(GetTask(TASK_CRLH_ROUSHEN_IDX),
                1206, --²é±í
                85,
                (loca_x + random(1, 5) - 3) * 32,
                (loca_y + random(1, 5) - 3) * 32,
                "\\script\\ontimer\\É¾µô×Ô¼º.lua",
                180,
                "\\script\\npcdeath\\ÆÇËÀÍö.lua",
                0,
                15)
        SetNpcTask(newnpcidx1, 1, GetPlayerID())    --¼ÇÂ¼Íæ¼Ò¹éÊô
        SetNpcTask(newnpcidx1, 2, newnpcidx)
        SetNpcTask(newnpcidx1, 3, GetNpcID(newnpcidx))
    end

    SetNpcTask(newnpcidx, 4, 3)                    --±£´æÐÂµÄµ±Ç°¹ÖÊýÁ¿

end
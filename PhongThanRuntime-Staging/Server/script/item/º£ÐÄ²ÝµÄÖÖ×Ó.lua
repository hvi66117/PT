Task_star = 1417

function main()
    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 1) then
        local mapid, x, y = GetWorldPos()
        if (mapid == 37) then
            ClearItem(6, 1, 512, 0)
            SetTaskByte(Task_star, 3, 2)

            local haixincao = AddNpc(996, 1, SubWorld, (x + 1) * 32, (y + 1) * 32)
            SetNpcName(haixincao, "H¶i T©m Th¶o")
            SetNpcTask(haixincao, 1, GetPlayerID())
            SetNpcTask(haixincao, 2, PlayerIndex)
            SetNpcScript(haixincao, "\\script\\item\\º£ÐÄ²Ý.lua")
            SetNpcTimer(haixincao, "\\script\\ontimer\\º£ÐÄ²ÝÉ¾³ý×Ô¼º.lua", 180)

            AddIBBuff(768)

        else
            Msg2Player("H¹t H¶i T©m Th¶o chØ ®­îc sö dông t¹i khu §«ng h¶i Thñy Vùc.")
        end
    end
end

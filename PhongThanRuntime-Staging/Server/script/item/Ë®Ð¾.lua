Task_star = 1417

Task_collect = 1418

Global_guixie = 199

function main()
    local mapid, x, y = GetWorldPos()
    if (mapid ~= 22) then
        Msg2Player("Thñy T©m chØ cã thÓ sö dông ë Hoang M¹c")
        return
    end

    if (GetTaskByte(Task_star, 1) == 10 and GetLevel() >= 39) then
        local mapid, x, y = GetWorldPos()

        local distance = math.floor(((1800 - x) ^ 2 + (3632 - y) ^ 2) ^ 0.5 * 32)
        if (mapid == 22 and distance > 300) then
            Msg2Player("B¹n c¸ch môc tiªu qu¸ xa, Thñy T©m kh«ng thÓ ph¸t huy t¸c dông!")
            return
        end

        if (GetGlobalValue(Global_guixie) ~= 0) then
            Msg2Player("Nguyªn ThÇn ®· xuÊt hiÖn, anh hïng h·y mau ®i diÖt trõ!")
            return
        end

        if (mapid == 22) then
            ClearItem(6, 1, 513, 0)
            SetTaskByte(Task_star, 1, 11)

            local id = SubWorldID2Idx(22)
            if (id ~= -1) then
                local guixie = AddNpc(989, 40, id, 1800 * 32, 3632 * 32)
                PlayerCastSkill(1, 226, 1)
                SetNpcName(guixie, "Nguyªn thÇn cña QuØ tµ yªu nh©n")
                SetNpcTask(guixie, 1, GetPlayerID())
                SetNpcTask(guixie, 2, PlayerIndex)
                SetTask(Task_collect, guixie)
                SetGlobalValue(Global_guixie, 1)
                SetNpcScript(guixie, "\\script\\¹ÖÎï\\¹íÐ°ÑýÈËµÄÔªÉñ.lua")
                SetNpcTimer(guixie, "\\script\\ontimer\\¹íÐ°ÑýÈËÉ¾³ý×Ô¼º.lua", 1200)
            end ;
        end

    end
end

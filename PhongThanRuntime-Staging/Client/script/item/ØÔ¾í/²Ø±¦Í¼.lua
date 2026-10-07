gua8_renwu = 1340
gua8_task = 1341

boss_task = 1342
boss_distance = 1343
boss_day = 176
baotu_times = 1563
boss_addrate = 260

function main()
    CloseDialog()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "§iÓm tu luyÖn cña b¹n ch­a ®Õn cÊp 15, ch­a thÓ tÇm b¶o!")
        return 0
    end

    if (GetTaskWord(boss_task, 1) == 0 or GetTaskWord(boss_task, 2) == 0) then
        if (DelNormalItem(6, 1, 463, 0) == 0) then
            DelNormalItemInQuick(6, 1, 463, 0)
        end
        Talk(1, "no", "<c=yel>Hoµng Kim Tµng b¶o ®å<c> nµy lµ gi¶i! §­a ta vøt nã ®i cho råi!")
        return 0
    end

    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= 73) then
        Talk(1, "no", "T¹i <c=g>BÊt Chu Thiªn quan<c> cã mét lo¹i Ma thó ©m hiÓm, lîi dông Tµng b¶o ®å ®Ó gäi chóng ra. Lµ hung hay kiÕt cßn ph¶i xem t¹o hãa n÷a!")
    else
        local px = GetTaskWord(boss_task, 1)
        local py = GetTaskWord(boss_task, 2)
        local distance = (x1 - px) ^ 2 + (y1 - py) ^ 2
        local lastdist = GetTask(boss_distance)
        SetTask(boss_distance, distance)

        local lightname = {
            [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
            [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
            [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
            [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
        }

        local light = 1
        if (distance <= 25) then
            light = 4
        elseif (distance <= 400) then
            light = 3
        elseif (distance <= 2500) then
            light = 2
        end
        local msg = "Tµng b¶o ®å ph¸t ra" .. lightname[light]

        if (lastdist == -1) then
            msg = msg .. ", B¶o tµng h×nh nh­ ë ngay trong khu vùc nµy!"
        else
            if (light == 4) then
                msg = msg .. ", B¶o tµng h×nh nh­ ®ang ë gÇn ®©y, h·y thö vËn may cña m×nh xem!"
                MsgBox(msg, "wabao", "no")
                return 0
            else
                if (lastdist < distance) then
                    msg = msg .. ", b¹n d­êng nh­ ®· ®i <c=r>c¸ch xa<c> kho b¸u."
                else
                    msg = msg .. ", b¹n d­êng nh­ ®· <c=g>tiÕp cËn<c> kho b¸u."
                end
            end
        end
        Talk(1, "no", msg)
    end ;
end;

function wabao()
    CloseDialog()
    if ((HaveNormalItem(6, 1, 463, 0) >= 1) or (HaveNormalItemInQuick(6, 1, 463, 0) >= 1)) then
        local r = math.random(1, 100)
        local bossidx = -1
        local px = GetTaskWord(boss_task, 1)
        local py = GetTaskWord(boss_task, 2)

        local today = math.floor(LocalSystemTime() / 86400)

        local lastday = math.floor(GetGlobalValue(boss_day) / 86400)

        local h, _, _ = GetHMS()
        local strlog = "Tµng b¶o ®å, tû lÖ:" .. r
        local times = GetTask(baotu_times)
        local rate = 0

        local n = GetGlobalValue(boss_addrate)
        SetGlobalValue(boss_addrate, n + 1)

        if (n >= 20) and (h >= 19) and (h < 23) and (today ~= lastday) then

            bossidx = AddNpc(884, 40, SubWorld, px * 32, py * 32)

            if (bossidx > 0) then
                SetNpcScript(bossidx, "\\script\\¹ÖÎï\\Ã÷ÒÄnpc.lua")
                SetNpcTimer(bossidx, "\\script\\ontimer\\Ã÷ÒÄnpc.lua", 60 * 3)
                if (DelNormalItem(6, 1, 463, 0) == 0) then
                    DelNormalItemInQuick(6, 1, 463, 0)
                end
                SetTask(boss_task, 0)
                SetTask(boss_distance, 0)

                SetGlobalValue(boss_day, LocalSystemTime())
                SetGlobalValue(boss_addrate, 0)

                TaskNote(98, -1)
                strlog = strlog .. ", Minh Di"

                WriteLog(strlog .. "Sè lÇn Tµng B¶o §å:" .. n)

                return
            end
        end

        if (times > 20) then
            rate = (times - 20) + 10
        elseif (times > 10) then
            rate = 5
        end
        if (r - rate <= 1) and (today ~= lastday) and (h >= 19) and (h < 23) then

            bossidx = AddNpc(884, 40, SubWorld, px * 32, py * 32)

            if (bossidx > 0) then
                SetNpcScript(bossidx, "\\script\\¹ÖÎï\\Ã÷ÒÄnpc.lua")
                SetNpcTimer(bossidx, "\\script\\ontimer\\Ã÷ÒÄnpc.lua", 60 * 3)
                SetTask(baotu_times, 0)
                if (DelNormalItem(6, 1, 463, 0) == 0) then
                    DelNormalItemInQuick(6, 1, 463, 0)
                end
                SetTask(boss_task, 0)
                SetTask(boss_distance, 0)

                SetGlobalValue(boss_day, LocalSystemTime())

                TaskNote(98, -1)
                strlog = strlog .. ", Minh Di"
            end
        else
            local npclvl = 20
            if (GetPlayerExtLevel() >= 26) then
                npclvl = 30
            end

            bossidx = AddNpc(882, npclvl, SubWorld, px * 32, py * 32)
            if (bossidx > 0) then
                SetNpcScript(bossidx, "\\script\\¹ÖÎï\\»Æ½ð³àÑÌÊÞnpc.lua")
                SetNpcTimer(bossidx, "\\script\\ontimer\\»Æ½ð³àÑÌÊÞnpc.lua", 60 * 3)
                SetTask(baotu_times, times + 1)
                if (DelNormalItem(6, 1, 463, 0) == 0) then
                    DelNormalItemInQuick(6, 1, 463, 0)
                end
                SetTask(boss_task, 0)
                SetTask(boss_distance, 0)
                TaskNote(98, -1)
                strlog = strlog .. ", XÝch Yªn Thó: CÊp" .. npclvl
            end
        end
        WriteLog(strlog)
    end
end

function no()
    CloseDialog()
end

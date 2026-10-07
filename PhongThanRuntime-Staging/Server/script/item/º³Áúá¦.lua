Task_zhixian = 1471

Task_time = 1474
Global_HanLongFan = 211

Task_hanlong = 1622

function main()
    local zhixian_step = GetTaskByte(Task_zhixian, 1)
    if (zhixian_step == 8 and GetPlayerExtLevel() >= 51) then
        local mapid, x, y = GetWorldPos()
        if (mapid ~= 75) then
            InfoBox("Tõ ®©y ®Õn Ph¸p trô qu¸ xa, Hµm Long Ph­ín kh«ng thÓ ph¸t huy hiÖu qu¶.")
            Msg2Player("Hµm Long Ph­ín chØ cã thÓ sö dông t¹i gÇn th¸p trô cña Ngôc Ph¸p s¬n.")
            return
        end

        local distance1 = math.floor(((1629 - x) ^ 2 + (3206 - y) ^ 2) ^ 0.5 * 32)
        local distance2 = math.floor(((1604 - x) ^ 2 + (3773 - y) ^ 2) ^ 0.5 * 32)
        local distance3 = math.floor(((2105 - x) ^ 2 + (3813 - y) ^ 2) ^ 0.5 * 32)
        local distance4 = math.floor(((2023 - x) ^ 2 + (3196 - y) ^ 2) ^ 0.5 * 32)

        if (mapid == 75 and distance1 > 300 and distance2 > 300 and distance3 > 300 and distance4 > 300) then
            InfoBox("Tõ ®©y ®Õn Ph¸p trô qu¸ xa, Hµm Long Ph­ín kh«ng thÓ ph¸t huy hiÖu qu¶.")
            Msg2Player("B¹c c¸ch th¸p trô qu¸ xa, Hµm Long Ph­ín kh«ng thÓ ph¸t huy t¸c dông.")
            return
        end

        local pretime = GetTaskWord(Task_time, 1)
        local nowtime = math.mod(SystemTime(), 2 ^ 16)
        if (nowtime - pretime <= 300) then
            Msg2Player("Søc lùc cña Hµm Long Ph­ín ch­a håi phôc, t¹m thêi  kh«ng thÓ sö dông.")
            return
        end
        local isExist = GetGlobalValue(Global_HanLongFan)
        if (mapid == 75 and distance1 <= 300) then
            if (GetByte(isExist, 1) ~= 0) then

                hanLongExistMsg()

                return
            else
                SetTaskByte(Task_zhixian, 4, 1)
                local hanLongIdx = AddNpc(1070, 1, SubWorld, 1638 * 32, 3209 * 32)
                hanLongFan(hanLongIdx)
                SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), 1, 1))
            end
        elseif (mapid == 75 and distance2 <= 300) then
            if (GetByte(isExist, 2) ~= 0) then

                hanLongExistMsg()

                return
            else
                SetTaskByte(Task_zhixian, 4, 2)
                local hanLongIdx = AddNpc(1070, 1, SubWorld, 1606 * 32, 3757 * 32)
                hanLongFan(hanLongIdx)
                SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), 2, 1))
            end
        elseif (mapid == 75 and distance3 <= 300) then
            if (GetByte(isExist, 3) ~= 0) then

                hanLongExistMsg()

                return
            else
                SetTaskByte(Task_zhixian, 4, 3)
                local hanLongIdx = AddNpc(1070, 1, SubWorld, 2096 * 32, 3809 * 32)
                hanLongFan(hanLongIdx)
                SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), 3, 1))
            end
        elseif (mapid == 75 and distance4 <= 300) then
            if (GetByte(isExist, 4) ~= 0) then

                hanLongExistMsg()

                return
            else
                SetTaskByte(Task_zhixian, 4, 4)
                local hanLongIdx = AddNpc(1070, 1, SubWorld, 2032 * 32, 3195 * 32)
                hanLongFan(hanLongIdx)
                SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), 4, 1))
            end
        end
    end
end

function hanLongExistMsg()
    if (GetTeam() ~= 0) then
        local oldindex = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            local playerId = GetPlayerID()
            local hanLongIdx = GetTask(Task_hanlong)
            if (playerId == GetNpcTask(hanLongIdx, 1)) then
                PlayerIndex = oldindex
                Msg2Player("§· cã ®ång ®éi c¾m Hµm Long Ph­ín ë ®©y, b¹n cã thÓ chän cïng b¶o vÖ c©y cê nµy!")
                return
            end
        end

        PlayerIndex = oldindex

    end
    Msg2Player("GÇn th¸p nµy ®· cã Hµm Long Ph­ín, xin ®æi n¬i kh¸c ®Ó c¾m Hµm Long Ph­ín.")
end

function hanLongFan(hanLongIdx)


    SetTask(Task_hanlong, hanLongIdx)
    Msg2Player("Trong thêi gian quy ®Þnh ®¸nh b¹i Thñ Hé Thó, vµ b¶o vÖ Hµm Long Ph­ín kh«ng bÞ ph¸ hñy!")

    SetNpcName(hanLongIdx, "Hµm Long Ph­ín")
    SetNpcTask(hanLongIdx, 1, GetPlayerID())
    SetNpcTask(hanLongIdx, 2, PlayerIndex)
    SetNpcTask(hanLongIdx, 3, GetTaskByte(Task_zhixian, 4))
    SetNpcTask(hanLongIdx, 4, 1)
    SetNpcCamp(hanLongIdx, 0)
    SetNpcScript(hanLongIdx, "\\script\\¹ÖÎï\\º³Áúá¦»ÙÃð.lua")
    SetNpcTimer(hanLongIdx, "\\script\\ontimer\\º³Áúá¦Ë¢¹Ö.lua", 120)

    local nowtime = math.mod(SystemTime(), 2 ^ 16)
    SetTaskWord(Task_time, 1, nowtime)
    AddIBBuff(694)
    TaskNote(105, 3)

    local npcMapid, x, y = GetNpcWorldPos(hanLongIdx)
    local monsterIdx1 = AddNpc(1058, 60, SubWorld, (x + 3) * 32, (y + 2) * 32)
    local monsterIdx2 = AddNpc(1058, 60, SubWorld, (x - 3) * 32, (y - 2) * 32)
    local monsterIdx3 = AddNpc(1058, 60, SubWorld, (x + 3) * 32, (y - 2) * 32)

    SetNpcName(monsterIdx1, "Thñ Hé thó")
    SetNpcTask(monsterIdx1, 1, GetPlayerID())
    SetNpcTask(monsterIdx1, 2, PlayerIndex)
    SetNpcTask(monsterIdx1, 3, GetTaskByte(Task_zhixian, 4))
    SetNpcScript(monsterIdx1, "\\script\\¹ÖÎï\\ÊØ»¤ÊÞ.lua")
    SetNpcTimer(monsterIdx1, "\\script\\ontimer\\ÊØ»¤ÊÞ×Ô¼ì.lua", 5)
    SetNpcTarget(monsterIdx1, hanLongIdx)
    SetNpcCamp(monsterIdx1, 5)
    NpcSay(monsterIdx1, "Chóng ta lµ ng­êi trÊn gi÷ cña Ph¸p trô Phôc Hy.")

    SetNpcName(monsterIdx2, "Thñ Hé thó")
    SetNpcTask(monsterIdx2, 1, GetPlayerID())
    SetNpcTask(monsterIdx2, 2, PlayerIndex)
    SetNpcTask(monsterIdx2, 3, GetTaskByte(Task_zhixian, 4))
    SetNpcScript(monsterIdx2, "\\script\\¹ÖÎï\\ÊØ»¤ÊÞ.lua")
    SetNpcTimer(monsterIdx2, "\\script\\ontimer\\ÊØ»¤ÊÞ×Ô¼ì.lua", 5)
    SetNpcTarget(monsterIdx2, hanLongIdx)
    SetNpcCamp(monsterIdx2, 5)
    NpcSay(monsterIdx2, "Lµ ai d¸m chÊn ®éng Ph¸p trô Phôc Hy?")

    SetNpcName(monsterIdx3, "Thñ Hé thó")
    SetNpcTask(monsterIdx3, 1, GetPlayerID())
    SetNpcTask(monsterIdx3, 2, PlayerIndex)
    SetNpcTask(monsterIdx3, 3, GetTaskByte(Task_zhixian, 4))
    SetNpcScript(monsterIdx3, "\\script\\¹ÖÎï\\ÊØ»¤ÊÞ.lua")
    SetNpcTimer(monsterIdx3, "\\script\\ontimer\\ÊØ»¤ÊÞ×Ô¼ì.lua", 5)
    SetNpcTarget(monsterIdx3, hanLongIdx)
    SetNpcCamp(monsterIdx3, 5)
    NpcSay(monsterIdx3, "Kh«ng cho phÐp ph¸ ho¹i Ph¸p trô Phôc Hy!")
end

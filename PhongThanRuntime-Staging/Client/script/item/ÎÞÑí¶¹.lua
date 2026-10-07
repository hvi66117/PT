Task_Thunder_Status = 1469
Task_Thunder_Time = 1470

Global_Thunder = 210
Task_Info_Thunder = 1079

Tower_Camp = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177, camp = 9, flagid = 890 },
    { desc = "Ma ph¸i", name = "", gtask = 178, camp = 10, flagid = 889 },
}

Thunder_Boss = {
    { desc = "Tr¸i trªn", name = "L«i M«n", x = 1714, y = 3475, x2 = 1718, y2 = 3472, small = 1054 },
    { desc = "Ph¶i d­íi", name = "Vò Hé", x = 1904, y = 3615, x2 = 1899, y2 = 3611, small = 1055 },
}

Thunder_Boss2 = {
    {
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1723, y = 3473 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1720, y = 3471 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1720, y = 3472 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1719, y = 3473 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1719, y = 3470 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1723, y = 3470 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1722, y = 3469 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1721, y = 3468 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1722, y = 3475 },
        { name = "L«i Bé Thiªn Binh", npcid = 1054, x = 1720, y = 3474 },
    },
    {
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1899, y = 3605 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1902, y = 3607 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1896, y = 3614 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1900, y = 3601 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1901, y = 3606 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1898, y = 3615 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1895, y = 3607 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1900, y = 3609 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1901, y = 3611 },
        { name = "Vò Bé Thiªn Binh", npcid = 1055, x = 1897, y = 3616 },
    },
}

function main()
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    local taskPos = GetTaskByte(Task_Thunder_Status, 2)
    local useCount = GetTaskByte(Task_Thunder_Status, 3)
    local useTime = GetTask(Task_Thunder_Time)
    local localTime = LocalSystemTime()
    local coolingTime = localTime - useTime
    local mapid, x, y = GetWorldPos()
    local distance = (Thunder_Boss[taskPos].x * 32 - x * 32) ^ 2 + (Thunder_Boss[taskPos].y * 32 - y * 32) ^ 2

    if (taskStatus ~= 3) then
        Talk(1, "no", GetName() .. " §å lo¹i nµy ®· kh«ng dïng ®­îc råi.")
    elseif (mapid ~= 74) then
        Talk(1, "no", "Kh«ng dÔ cã lo¹i b¸u vËt nµy, ®Õn BÊt Chu s¬n míi ®­îc sö dông.")
    elseif (coolingTime < 22) then
        Talk(1, "no", "Ph¸p lùc ch­a håi phôc," .. (22 - coolingTime) .. " gi©y sau míi sö dông ®­îc.")
    elseif (distance > (700) ^ 2) then
        Talk(1, "no", "B¹n c¸ch" .. Thunder_Boss[taskPos].name .. "ThÊt Nguyªn Tinh qu©n qu¸ xa, sau khi l¹i gÇn th× sö dông.")
    elseif (GetFreeNpcCount() <= 200) then
        Talk(1, "no", "Trong Thiªn quan qu¸ chËt, l¸t sau h½ng sö dông.")
    elseif (useCount >= 20) then
        Talk(1, "no", "Sè lÇn sö dông qu¸ nhiÒu.")
    else
        useCount = useCount + 1
        DelNormalItem(3, 373, 0, 0)
        SetTaskByte(Task_Thunder_Status, 3, useCount)
        SetTask(Task_Thunder_Time, localTime)
        ScrollMessage("Thiªn C­¬ng ¶nh thø" .. useCount .. "Mçi lÇn sö dông V« ¦¬ng §Ëu, triÖu ra 10 thiªn binh")
        for i = 1, 10 do
            local npcConf = Thunder_Boss2[taskPos][i]
            local npcIndex = AddNpc(npcConf.npcid, 50, SubWorld, npcConf.x * 32, npcConf.y * 32)
            if (npcIndex > 0) then
                SetNpcName(npcIndex, "<c=g>" .. npcConf.name .. "<c>")
                SetNpcTimer(npcIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 25)
            end
        end
        DelNormalItem(6, 1, 521, 1)
    end
end

function no()
    CloseDialog()
end

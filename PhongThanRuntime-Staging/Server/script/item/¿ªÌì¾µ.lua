Task_HeartEvil_Status = 1242
Task_HeartEvil_PrenticeID = 1243
Task_HeartEvil_SummonTime = 1244
Task_HeartEvil_BossID = 1245
Task_HeartEvil_BossIdx = 1392

Task_Info_HeartEvil = 1017

Buff_HE_Evil = 464
Buff_HE_Medicine = 465

Random_Maps = {
    [0] = { mapid = 0, name = "Khu vùc v« hiÖu" },
    [1] = { mapid = 2, name = "Sïng Thµnh doanh" },
    [2] = { mapid = 3, name = "Ngäc H­ cung" },
    [3] = { mapid = 4, name = "Xi V­u Mé" },
    [4] = { mapid = 20, name = "T©y Kú" },
    [5] = { mapid = 21, name = "TriÒu Ca" },
}

function checkMonster()

    local MonsterID = GetTask(Task_HeartEvil_BossID)
    local MonsterIdx = GetTask(Task_HeartEvil_BossIdx)

    if (MonsterIdx == 0) then
        return 0
    end

    if (GetNpcID(MonsterIdx) == MonsterID) then
        return 1
    end

    return 0

end

function main()
    local taskStatus = GetByte(GetTask(Task_HeartEvil_Status), 1)
    local masterFlag = GetByte(GetTask(Task_HeartEvil_Status), 3)
    local mapid, x, y = GetWorldPos()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14322)
    elseif (mapid ~= 9) then
        Talk(1, "no", 14323)
    elseif (GetFreeNpcCount() <= 200) then
        Talk(1, "no", 14324)
    elseif (taskStatus ~= 1) and ((HaveIBBuff(Buff_HE_Evil) == 0) and (taskStatus == 2)) then
        Talk(1, "no", 14325)
    elseif (masterFlag ~= 1) then
        Talk(1, "no", 14326)
    elseif (checkMonster() == 1) then
        Talk(1, "no", "H·y tiªu diÖt T©m Ma cña b¹n tr­íc!")
    else
        local playerLevel = GetLevel()
        local npcId = 0
        if (playerLevel >= 100) then
            npcId = 721 + 3 * GetSex() + GetPlayerType()
        elseif (playerLevel >= 90) then
            npcId = 715 + 3 * GetSex() + GetPlayerType()
        elseif (playerLevel >= 80) then
            npcId = 709 + 3 * GetSex() + GetPlayerType()
        elseif (playerLevel >= 70) then
            npcId = 703 + 3 * GetSex() + GetPlayerType()
        elseif (playerLevel >= 60) then
            npcId = 697 + 3 * GetSex() + GetPlayerType()
        elseif (playerLevel >= 50) then
            npcId = 691 + 3 * GetSex() + GetPlayerType()
        end

        local npcIndex = AddNpc(npcId, playerLevel, SubWorld, x * 32, y * 32)
        if (npcIndex > 0) then

            local NewNpcName = GetNpcName(npcIndex)
            NewNpcName = "<c=r>T©m Ma<c>"
            SetNpcName(npcIndex, NewNpcName)
            SetNpcScript(npcIndex, "\\script\\¹ÖÎï\\ÐÄÄ§.lua")
            SetNpcTimer(npcIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1200)
            SetTask(Task_HeartEvil_BossID, GetNpcID(npcIndex))
            SetTask(Task_HeartEvil_BossIdx, npcIndex)
            SetTaskByte(Task_HeartEvil_Status, 1, 2)

            if (HaveIBBuff(Buff_HE_Evil) == 0) then
                AddIBBuff(Buff_HE_Evil, 1201)
                SetTask(Task_HeartEvil_SummonTime, SystemTime())
            end

            local mapNum = GetByte(GetTask(Task_HeartEvil_Status), 4)
            TaskNote(Task_Info_HeartEvil, 1, Random_Maps[mapNum].name)
            Msg2Player("b¹n ®· bÞ v©y khèn, t×nh thÕ nguy cÊp., h·y mau nhê ®å ®Ò ®Õn" .. Random_Maps[mapNum].name .. "  ®¹i phu ®Ó nhËn thuèc gi¶i")
            Talk(1, "no", GetName() .. ": Tiªu råi! Kh«ng thÓ phôc håi néi c«ng, ph¶i mau trèn th«i!...NhÊt ®Þnh lµ ®· tróng ph¶i bïa chó cña T©m Ma råi…" .. Random_Maps[mapNum].name .. " ®¹i phu ch¾c ch¾n cã thuèc gi¶i. Mau b¶o ®å ®Ö ®Õn ®ã lÊy vÒ!")
        else
            Talk(1, "no", 14327)
        end
    end
end

function no()
    CloseDialog()
end

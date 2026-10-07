KillMonsterTask = 1938

KillMonsterMission = 666
KillMonsterMission1 = 667

BossTypeTab = {
    [1] = { NpcType = 2141, NpcWave = 1, NpcLvl = 95, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 1 },
    [2] = { NpcType = 2142, NpcWave = 1, NpcLvl = 115, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 2 },
    [3] = { NpcType = 2143, NpcWave = 1, NpcLvl = 135, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 3 },
    [4] = { NpcType = 2144, NpcWave = 1, NpcLvl = 155, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 4 },
    [5] = { NpcType = 2145, NpcWave = 1, NpcLvl = 175, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 5 },
    [6] = { NpcType = 2146, NpcWave = 2, NpcLvl = 100, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 1 },
    [7] = { NpcType = 2147, NpcWave = 2, NpcLvl = 120, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 2 },
    [8] = { NpcType = 2148, NpcWave = 2, NpcLvl = 140, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 3 },
    [9] = { NpcType = 2149, NpcWave = 2, NpcLvl = 160, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 4 },
    [10] = { NpcType = 2150, NpcWave = 2, NpcLvl = 200, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 5 },
    [11] = { NpcType = 2151, NpcWave = 3, NpcLvl = 105, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 1 },
    [12] = { NpcType = 2152, NpcWave = 3, NpcLvl = 125, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 2 },
    [13] = { NpcType = 2153, NpcWave = 3, NpcLvl = 145, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 3 },
    [14] = { NpcType = 2154, NpcWave = 3, NpcLvl = 165, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 4 },
    [15] = { NpcType = 2155, NpcWave = 3, NpcLvl = 200, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 5 },
    [16] = { NpcType = 2156, NpcWave = 4, NpcLvl = 110, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 1 },
    [17] = { NpcType = 2157, NpcWave = 4, NpcLvl = 130, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 2 },
    [18] = { NpcType = 2158, NpcWave = 4, NpcLvl = 150, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 3 },
    [19] = { NpcType = 2159, NpcWave = 4, NpcLvl = 170, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 4 },
    [20] = { NpcType = 2160, NpcWave = 4, NpcLvl = 200, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 5 },
}
function OnDeath(npcidx)

    if (HaveIBBuff(1676) == 0) then
        ScrollMessage("Ó¢ÐÛ²¢ÎÞPhóc §Þa TÝ Hé×´Ì¬, ÎÞ·¨»ñ ®iÓm tÝch lòy")
        return
    end

    local Mine
    local First = GetMissionV(20, 1)
    local IsMission = GetTaskByte(KillMonsterTask, 1)
    for i = 1, #(BossTypeTab) do
        if (GetNpcTemplateID(npcidx) == BossTypeTab[i].NpcType) then
            if (IsMission == BossTypeTab[i].NpcPosType) then
                Mine = GetTaskWord(KillMonsterTask, 2) + 100
                SetTaskWord(KillMonsterTask, 2, Mine)
                if (Mine > First) then
                    SetMissionV(20, 1, Mine)
                    First = Mine
                end
                TaskNote(1938, 1, BossTypeTab[i].NpcName, Mine, First)
                ScrollMessage("»÷°ÜÊ×Áì»ñµÃ<c=g>100<c> ®iÓm tÝch lòy")
                if (BossTypeTab[i].NpcPosType == 5) then
                    SetGlobalValueByte(KillMonsterMission, 4, GetGlobalValueByte(KillMonsterMission, 4) + 30)
                else
                    SetGlobalValueByte(KillMonsterMission1, BossTypeTab[i].NpcPosType, GetGlobalValueByte(KillMonsterMission1, BossTypeTab[i].NpcPosType) + 30)
                end
                break
            else
                ScrollMessage("·Ç´Ë¸£µØµÄÊØÎÀÕß½«ÎÞ·¨»ñ ®iÓm tÝch lòy")
            end
        end
    end
    DelNpc(npcidx)
end






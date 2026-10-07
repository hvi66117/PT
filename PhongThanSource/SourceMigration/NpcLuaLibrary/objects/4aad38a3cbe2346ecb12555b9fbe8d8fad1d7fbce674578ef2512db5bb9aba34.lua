KillMonsterTask = 1938

KillMonsterMission = 666
KillMonsterMission1 = 667

NpsTypeTab = {
    [1] = { NpcType = 2121, NpcWave = 1, NpcLvl = 85, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 1 },
    [2] = { NpcType = 2122, NpcWave = 1, NpcLvl = 105, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 2 },
    [3] = { NpcType = 2123, NpcWave = 1, NpcLvl = 125, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 3 },
    [4] = { NpcType = 2124, NpcWave = 1, NpcLvl = 145, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 4 },
    [5] = { NpcType = 2125, NpcWave = 1, NpcLvl = 165, NpcName = "ÎÞÏàÅ®³ó", NpcPosType = 5 },
    [6] = { NpcType = 2126, NpcWave = 2, NpcLvl = 90, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 1 },
    [7] = { NpcType = 2127, NpcWave = 2, NpcLvl = 110, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 2 },
    [8] = { NpcType = 2128, NpcWave = 2, NpcLvl = 130, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 3 },
    [9] = { NpcType = 2129, NpcWave = 2, NpcLvl = 150, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 4 },
    [10] = { NpcType = 2130, NpcWave = 2, NpcLvl = 175, NpcName = "DÞ Vùc CÈu Mang", NpcPosType = 5 },
    [11] = { NpcType = 2131, NpcWave = 3, NpcLvl = 95, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 1 },
    [12] = { NpcType = 2132, NpcWave = 3, NpcLvl = 115, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 2 },
    [13] = { NpcType = 2133, NpcWave = 3, NpcLvl = 135, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 3 },
    [14] = { NpcType = 2134, NpcWave = 3, NpcLvl = 155, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 4 },
    [15] = { NpcType = 2135, NpcWave = 3, NpcLvl = 185, NpcName = "ÂÖ»ØÖìÝC", NpcPosType = 5 },
    [16] = { NpcType = 2136, NpcWave = 4, NpcLvl = 100, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 1 },
    [17] = { NpcType = 2137, NpcWave = 4, NpcLvl = 120, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 2 },
    [18] = { NpcType = 2138, NpcWave = 4, NpcLvl = 140, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 3 },
    [19] = { NpcType = 2139, NpcWave = 4, NpcLvl = 160, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 4 },
    [20] = { NpcType = 2140, NpcWave = 4, NpcLvl = 200, NpcName = "·ÉÂÓ·çÑý", NpcPosType = 5 },

}
function OnDeath(npcidx)

    if (HaveIBBuff(1676) == 0) then
        ScrollMessage("Ó¢ÐÛ²¢ÎÞPhóc §Þa TÝ Hé×´Ì¬, ÎÞ·¨»ñ ®iÓm tÝch lòy")
        return
    end

    local IsMission = GetTaskByte(KillMonsterTask, 1)
    local Mine
    local First = GetMissionV(20, 1)
    for i = 1, table.getn(NpsTypeTab) do
        if (GetNpcTemplateID(npcidx) == NpsTypeTab[i].NpcType) then
            if (IsMission == NpsTypeTab[i].NpcPosType) then
                Mine = GetTaskWord(KillMonsterTask, 2) + 1
                SetTaskWord(KillMonsterTask, 2, Mine)
                if (Mine > First) then
                    SetMissionV(20, 1, Mine)
                    First = Mine
                end
                TaskNote(1938, 1, NpsTypeTab[i].NpcName, Mine, First)
                ScrollMessage("»÷°ÜÑýÄ§»ñµÃ<c=g>1<c> ®iÓm tÝch lòy")
                if (NpsTypeTab[i].NpcPosType == 5) then
                    SetGlobalValueByte(KillMonsterMission, 4, GetGlobalValueByte(KillMonsterMission, 4) + 1)
                else
                    SetGlobalValueByte(KillMonsterMission1, NpsTypeTab[i].NpcPosType, GetGlobalValueByte(KillMonsterMission1, NpsTypeTab[i].NpcPosType) + 1)
                end
                break
            else
                ScrollMessage("·Ç´Ë¸£µØµÄÊØÎÀÕß½«ÎÞ·¨»ñ ®iÓm tÝch lòy")
            end
        end
    end
    DelNpc(npcidx)
end






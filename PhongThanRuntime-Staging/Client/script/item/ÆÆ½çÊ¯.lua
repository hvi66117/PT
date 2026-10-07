g_HellGod = 1482
g_PowerStar = 1480

g_TrueNpcID = 224
g_SaveBuff = 225
g_Teammate = 226

g_BUFFSTARPOWER = 696
g_BUFFMOSTER = 698
g_BUFFDEFEND = 697

function main()

    local maps = {
        { mapid = 75, x = 260 * 8, y = 222 * 16 },
    }

    local px = maps[1].x
    local py = maps[1].y

    if (GetGlobalValue(g_SaveBuff) ~= 0) then
        InfoBox("Phong Ên cña Ngu C­¬ng ®· bÞ ph¸ bá, tiªu hao 1 <c=g>Ph¸ Giíi Th¹ch<c>.");
        return
    end
    if (HaveIBBuff(g_BUFFSTARPOWER) == 0) then
        InfoBox("N¨ng l­îng cña Ph¸ Giíi Th¹ch rÊt lîi h¹i, nÕu kh«ng cã søc m¹nh cña Tinh Qu©n kh«ng thÓ sö dông.")
        return
    end

    if (GetTaskByte(g_PowerStar, 1) == 5 and GetPlayerExtLevel() >= 65 and (GetTaskByte(g_HellGod, 1) == 1 or GetTaskByte(g_HellGod, 1) == 6)) then

        local nPWorldId, nPX, nPY = GetWorldPos()

        if (nPWorldId == 75) then

            local nDis = (px - nPX) ^ 2 + (py - nPY) ^ 2

            if (nDis < 625) then

                InfoBox("Phong Ên cña Ngu C­¬ng ®· bÞ ph¸ bá, tiªu hao 1 <c=g>Ph¸ Giíi Th¹ch<c>.")

                SummonMonster()

            else
                InfoBox("Ngu C­¬ng ®ang bÞ phong Ên t¹i Ngôc Ph¸p s¬n<c=g>(260,222)<c>, mau ®Õn ®ã ®i.")
                return 0;
            end
        else
            InfoBox("Ngu C­¬ng bÞ phong Ên t¹i <c=g>Ngôc Ph¸p s¬n<c>, mau ®Õn ®ã ®i.")
            return 0
        end
    else
        InfoBox("N¨ng l­îng cña Ph¸ Giíi Th¹ch rÊt lîi h¹i, nÕu kh«ng cã søc m¹nh cña Tinh Qu©n kh«ng thÓ sö dông.")
        return 0
    end
end

function no()
    CloseDialog()
end

function SummonMonster()
    CloseDialog()
    local nPWorldId, nPX, nPY = GetWorldPos()
    if (nPWorldId ~= 75) then
        InfoBox("Ngu C­¬ng bÞ phong Ên t¹i <c=g>Ngôc Ph¸p s¬n<c>, mau ®Õn ®ã ®i.")
        return
    end
    local npcTGIdx = AddNpc(1107, 65, SubWorld, (nPX + 2) * 32, (nPY + 2) * 32)
    if (npcTGIdx > 0) then

        local falseMonster = GetTaskByte(g_HellGod, 3, falseMonster);

        TaskNote(111, 2)
        TopMessage("Thiªn C­¬ng ¶nh thø" .. (falseMonster + 1) .. "Ngu C­¬ng hãa th©n xuÊt hiÖn")
        if (falseMonster == 0) then
            falseMonster = falseMonster + 1
            SetTaskByte(g_HellGod, 3, falseMonster)
        end

        SetNpcScript(npcTGIdx, "\\script\\¹ÖÎï\\ÉÏ¹ÅÖ®ÉñØ®½®»¯ÉíËÀÍö.lua")
        SetNpcTimer(npcTGIdx, "\\script\\ontimer\\ÉÏ¹ÅÖ®ÉñÏûÊ§.lua", 60 * 3)
        SetNpcTask(npcTGIdx, 0, GetPlayerID())
        SetGlobalValue(g_SaveBuff, GetPlayerID());


    end
end




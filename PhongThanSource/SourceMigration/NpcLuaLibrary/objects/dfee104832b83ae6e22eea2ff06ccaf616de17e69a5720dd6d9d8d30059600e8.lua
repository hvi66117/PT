NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

BanQuan = 1498

Curr_HeroNPC_idx = 1499
Curr_HeroNPC_ID = 1500

Task_eye_renwu = 1530

Task_xianmo_wdjx = 1542

Task_info_xian = 1097
Task_info_mo = 1098

function OnDeath(npcidx)

    local npcchr = GetHardNpcAttrib(npcidx)
    local mob_lvl = GetNpcLevel(npcidx)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcidx, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end
    end

    if (GetTaskByte(BanQuan, 1) == 1 and GetTaskByte(BanQuan, 2) < 31 and HaveIBBuff(749) == 0) then
        HeroSoul(npcidx)
    end

    if (GetTaskByte(BanQuan, 1) == 4 and GetTaskBit(BanQuan, 11) == 0) then
        LastWish()
    end

    if (GetTaskByte(Task_eye_renwu, 3) == 1) then
        sleepeye()
    end

    if (GetTaskByte(Task_xianmo_wdjx, 1) == 1) then
        if (HaveIBBuff(789) == 0) then
            Msg2Player("Bπn kh´ng mang theo <Ng‰c Thanh Ch©n Kh›>, Th∏nh ßﬁa B∏ch HÓp kh´ng th” nÎ ra.")
        else
            wendingjunxin(npcidx)
        end
    end


end;

function LastWish()
    if (math.random(1, 100) <= 15) then
        local mstr = "Kh≠¨ng Ngu T›ch"
        local idx = 262
        if (GetTaskByte(BanQuan, 3) == 2) then
            mstr = "C¨ Huy“n Phong"
            idx = 261
        end
        mstr = "T◊m th y " .. mstr .. "-Y Gi∏p"
        ClearItem(4, idx, 0, 1)
        AddNormalItem(4, idx, 0, 1, 0, 0)
        TopMessage(mstr)
        Msg2Player(mstr)
        SetTaskBit(BanQuan, 11, 1)

        SetTaskNote()
    end
end

function SetTaskNote()
    local otherMsg = ""
    local NpcName = "C¨ Huy“n Phong"
    local NpcName1 = "Y Gi∏p C¨ Huy“n Phong"
    local NpcName2 = "Y Gi∏p Kh≠¨ng Ngu T›ch"
    local Npc1Pos = "<c=g>[246,236]<c>"
    local Npc2Pos = "<c=g>[210,201]<c>"
    local strPos = "[76,238,237]\">"

    if (GetTaskByte(BanQuan, 1) == 4) then
        if (GetTaskByte(BanQuan, 3) == 2) then
            otherMsg = ", Y Gi∏p C¨ Huy“n Phong Æ∑ bﬁ m t, nh t Æﬁnh lµ do <c=g>ChÛc Th«n<c> Î g«n Æ©y l y Æi."
            strPos = "[76,212,204]\">"
        else
            otherMsg = ", Y Gi∏p Kh≠¨ng Ngu T›ch Æ∑ bﬁ m t, nh t Æﬁnh lµ do <c=g>ChÛc Th«n<c> Î g«n Æ©y l y Æi."
        end
    end

    if (GetTaskByte(BanQuan, 3) == 2) then

        NpcName1 = "Y Gi∏p Kh≠¨ng Ngu T›ch"
        NpcName2 = "Y Gi∏p C¨ Huy“n Phong"
        NpcName = "Kh≠¨ng Ngu T›ch"
        Npc2Pos = "<c=g>[246,236]<c>"
        Npc1Pos = "<c=g>[210,201]<c>"
    end

    local bit1 = GetTaskBit(BanQuan, 9)
    local bit2 = GetTaskBit(BanQuan, 10)
    local bit3 = GetTaskBit(BanQuan, 11)

    if (bit1 == 1 and bit2 == 1 and bit3 == 1) then
        TaskNote(1087, 3, "<HyperLinkWorldPos=\"" .. NpcName .. strPos)
        return
    end

    if (bit1 == 0 and bit2 == 0 and bit3 == 0) then
        TaskNote(1087, 4, NpcName2)
        return
    end

    local str1 = ""
    local str2 = ""

    if (bit1 == 1) then
        str1 = NpcName1
    end

    if (bit2 == 1) then
        if (str1 ~= "") then
            str1 = str1 .. ", TÙc CËt Sinh C¨ Li™n"
        else
            str1 = "TÙc CËt Sinh C¨ Li™n"
        end
    end

    if (bit3 == 1) then
        if (str1 ~= "") then
            str1 = str1 .. "," .. NpcName2
        else
            str1 = NpcName2
        end
        otherMsg = ""
    end

    if (bit1 == 0) then
        str2 = NpcName1 .. Npc1Pos
    end

    if (bit2 == 0) then
        if (str2 ~= "") then
            str2 = str2 .. ", TÙc CËt Sinh C¨ Li™n <c=g>[225,226]<c>"
        else
            str2 = "TÙc CËt Sinh C¨ Li™n <c=g>[225,226]<c>"
        end
    end

    if (bit3 == 0) then
        if (str2 ~= "") then
            str2 = str2 .. "," .. NpcName2 .. Npc2Pos
        else
            str2 = NpcName2 .. Npc2Pos
        end
    end

    TaskNote(1087, 2, str1, str2, otherMsg)
end

function HeroSoul(npcidx)
    local id, x, y = GetNpcWorldPos(npcidx)
    if (id ~= 76) then
        return
    end
    local heroNpc_idx = GetTask(Curr_HeroNPC_idx)
    local heroNpc_ID = GetTask(Curr_HeroNPC_ID)

    if (heroNpc_idx ~= 0 and GetNpcID(heroNpc_idx) == heroNpc_ID and GetNpcTask(heroNpc_idx, 1) == GetPlayerID()) then
        ScrollMessage("DÚng Gi∂ Trung HÂn cﬂn ch≠a Æ≠Óc si™u ÆÈ, h∑y Æi giÛp n„ hoµn thµnh t©m nguy÷n!")

        return
    end

    if (math.random(1, 5) ~= 2) then

        return
    end

    local status = GetTaskByte(BanQuan, 2)

    local k = 0

    if (status == 30) then
        k = 1
    elseif (status == 29) then
        k = 2
    elseif (status == 27) then
        k = 3
    elseif (status == 23) then
        k = 4
    elseif (status == 15) then
        k = 5
    end

    if (k ~= 0) then

        local nidx = AddNpc(1160, 1, SubWorld, x * 32, y * 32)

        SetNpcTimer(nidx, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 180)
        SetNpcScript(nidx, "\\script\\¡˙Ã◊\\∂‘ª∞”¬’ﬂ÷ÆªÍ.lua")
        SetNpcTask(nidx, 1, GetPlayerID())
        SetNpcTask(nidx, 2, k)

        SetTask(Curr_HeroNPC_idx, nidx)
        SetTask(Curr_HeroNPC_ID, GetNpcID(nidx))
        ScrollMessage("DÚng Gi∂ Trung HÂn Æ∑ xu t hi÷n!")
        Msg2Player("DÚng Gi∂ Trung Æ∑ xu t hi÷n!")
        return
    end

    repeat
        local i = math.random(1, 5)

        if (GetTaskBit(BanQuan, i + 8) == 0) then


            local nidx = AddNpc(1160, 1, SubWorld, x * 32, y * 32)

            SetNpcTimer(nidx, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 180)
            SetNpcScript(nidx, "\\script\\¡˙Ã◊\\∂‘ª∞”¬’ﬂ÷ÆªÍ.lua")
            SetNpcTask(nidx, 1, GetPlayerID())
            SetNpcTask(nidx, 2, i)

            SetTask(Curr_HeroNPC_idx, nidx)
            SetTask(Curr_HeroNPC_ID, GetNpcID(nidx))
            ScrollMessage("DÚng Gi∂ Trung HÂn Æ∑ xu t hi÷n!")
            Msg2Player("DÚng Gi∂ Trung HÂn Æ∑ xu t hi÷n!")
            break
        end

        k = k + 1
    until k >= 100

end;

function sleepeye()
    if (HaveIBBuff(764) > 0) then
        local nums = GetTaskByte(Task_eye_renwu, 4) + 8
        SetTaskByte(Task_eye_renwu, 4, nums)
        ScrollMessage("M¯c ch®m s„c To∏i phi’n t®ng 8%")
        if (nums >= 100) then
            SetTaskByte(Task_eye_renwu, 3, 2)
            ScrollMessage(" Æ∑ ch¯a Æ«y linh kh›!")
            SetTaskByte(Task_eye_renwu, 4, math.random(1, 5))
            RemoveIBBuff(764)
            if (GetJusticEvilCredit() < 0) then
                TaskNote(116, 1)
            else
                TaskNote(115, 1)
            end
        end
    else
        SetTaskByte(Task_eye_renwu, 3, 3)
        if (GetJusticEvilCredit() < 0) then
            TaskNote(116, 5)
        else
            TaskNote(115, 5)
        end
    end
end

function wendingjunxin(npcidx)
    local DragonNpcs = {
        [1] = { x = 1944, y = 3568, name = "Gﬂ ThÊ Long" },
        [2] = { x = 1904, y = 3376, name = "Gﬂ H·a Long" },
        [3] = { x = 1680, y = 3408, name = "Gﬂ B®ng Long" },
        [4] = { x = 1752, y = 3536, name = "Gﬂ L´i Long" },
    }
    if ((isrightarea(npcidx, 1) == 1) or (isrightarea(npcidx, 2) == 1) or (isrightarea(npcidx, 3) == 1) or (isrightarea(npcidx, 4) == 1)) then
        local dragonidx = GetTaskByte(Task_xianmo_wdjx, 3)
        if (isrightarea(npcidx, dragonidx) == 1) then
            local probability = math.random(1, 100)
            if (probability <= 20) then
                local w, x, y = GetNpcWorldPos(npcidx)
                local idx = AddNpc(1246, 1, SubWorld, x * 32, y * 32)

                if (idx ~= 0) then
                    SetNpcTask(idx, 1, GetPlayerID())
                    SetNpcName(idx, "Th∏nh ßﬁa B∏ch HÓp")
                    SetNpcScript(idx, "\\script\\⁄Ê»™ •µÿ\\ •µÿ∞Ÿ∫œ.lua")
                    SetNpcTimer(idx, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 30)
                    Msg2Player("Th∏nh ßﬁa B∏ch HÓp Æ∑ nÎ, xin h∑y nhanh ch„ng thu hoπch!")
                    ScrollMessage("Th∏nh ßﬁa B∏ch HÓp Æ∑ nÎ, xin h∑y nhanh ch„ng thu hoπch!")
                end
            else
                Msg2Player("DÔ Æ∑ Æ∏nh bπi y™u ma, nh≠ng B∏ch HÓp v…n ch≠a nÎ!")
            end
        else
            Msg2Player("N¨i Æ©y B∏ch HÓp ch≠a nÎ, h∑y sang n¨i kh∏c xem sao!" .. DragonNpcs[dragonidx].name .. "Thu thÀp B∏ch HÓp l©n cÀn.")
        end

    else
        Msg2Player("N¨i Æ©y linh kh› sung m∑n, c„ th” trÂng Æ≠Óc Th∏nh Hoa.")
    end
end

function isrightarea(npcidx, dragonidx)
    local DragonNpcs = {
        [1] = { x = 1944, y = 3568, name = "Gﬂ ThÊ Long" },
        [2] = { x = 1904, y = 3376, name = "Gﬂ H·a Long" },
        [3] = { x = 1680, y = 3408, name = "Gﬂ B®ng Long" },
        [4] = { x = 1752, y = 3536, name = "Gﬂ L´i Long" },
    }
    local w, x, y = GetNpcWorldPos(npcidx)
    local distance = math.floor((x - DragonNpcs[dragonidx].x) ^ 2 + (y - DragonNpcs[dragonidx].y) ^ 2)
    if (distance <= 400) then
        return 1
    end
    return 0
end

yanluo_renwu = 1333
yanluo_npc = 1334
yanluo_teamtask = 2

function main()
    CloseDialog()
    local state = GetTask(yanluo_renwu)
    if (state <= 3) then
        Msg2Player("§· nhËn ®­îc Ph¸p b¶o, mau vÒ phôc mÖnh Ph¸p trËn Hé ph¸p!")
        return 0
    end

    if (state >= 100) then
        ClearItem(6, 1, 444, 0)
        Msg2Player("VËt nµy ®· kh«ng cßn hiÖu nghiÖm n÷a!")
        return 0
    end

    if (IsCaptain() ~= 1) or (GetTeamSize() ~= 6) then
        Msg2Player("Ph¶i thµnh lËp tæ ®éi gåm 5 ng­êi, vµ tù m×nh lµm ®éi tr­ëng míi ®­îc!")
        return 0
    end

    if (IsPlayerInsideWeapon(PlayerIndex) <= 0) then
        Msg2Player("B¹n ch­a cã ThÇn Hån Phô ThÓ, kh«ng thÓ më trËn ph¸p!")
        return 0
    end

    if (GetTeamTask(yanluo_teamtask) >= 7) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            BeginMotion(yanluo_npc, 1, 60, "\\script\\motion\\Ò»Æø×ÏÔÆÉ´½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
        PlayerIndex = oldPlayer
    else
        Msg2Player("Toµn bé 6 ng­êi ®Òu ph¶i cã Hé Ph¸p Phô ThÓ mêi cã thÓ më trËn ph¸p")
    end
end;

function no()
    CloseDialog()
end;

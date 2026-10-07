function main()
    CloseDialog()
    local state = GetWorldEventValue(3, 18)
    if (state >= 2) or (HaveIBBuff(687) == 0) then
        ClearItem(6, 1, 519, 0)
        Msg2Player("Ph¸p b¶o nµy ®· hÕt hiÖu lùc.")
        return 0
    end

    if (IsCaptain() ~= 1) or (GetTeamSize() ~= 6) then
        Msg2Player(" cÇn ph¶i lËp nhãm 6 ng­êi gåm Tiªn, Ma. Trong ®ã Ýt nhÊt cã 1 Tiªn vµ 1 Ma, ®ång thêi ®éi tr­ëng sÏ nhËn nhiÖm vô")
        return 0
    end

    if (IsPlayerInsideWeapon(PlayerIndex) <= 0) then
        Msg2Player("TÊt c¶ thµnh viªn ®Òu trong tr¹ng th¸i hé th©n míi ®­îc më trËn ph¸p.")
        return 0
    end

    if (GetTeamTask(1) >= 6) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        local oldPlayer = PlayerIndex
        for i = 1, 6 do
            PlayerIndex = GetTeamMember(i)
            BeginMotion(18, 1, 60, "\\script\\motion\\Í¸µØÓñÁú¹Ä½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
        PlayerIndex = oldPlayer
    else
        Msg2Player("TÊt c¶ thµnh viªn ®Òu trong tr¹ng th¸i hé th©n míi ®­îc më trËn ph¸p.")
    end
end;

function no()
    CloseDialog()
end;

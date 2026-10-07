CITY_build = 42
TOTEM_POS_ARRAY = {
    [0] = { { nX = 1746, nY = 3252 }, { nX = 1659, nY = 3147 }, { nX = 1673, nY = 3158 } },
    [1] = { { nX = 1769, nY = 3287 }, { nX = 1652, nY = 3137 }, { nX = 1666, nY = 3153 } },
    [2] = { { nX = 1746, nY = 3278 }, { nX = 1648, nY = 3142 }, { nX = 1666, nY = 3166 } },
    [3] = { { nX = 1752, nY = 3284 }, { nX = 1659, nY = 3146 }, { nX = 1672, nY = 3161 } },
    [4] = { { nX = 1886, nY = 3179 }, { nX = 1791, nY = 3046 }, { nX = 1805, nY = 3063 } },
}
function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local nTongTask = GetTongTask(36)
    local nNum = GetByte(nTongTask, 4)
    if (nNum >= 3) then
        Talk(1, "no", "Trong 1 trËn Quèc ChiÕn 1 l·nh ®Þa tèi ®a chØ cã thÓ sö dông 3 lÇn Cù M·")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M < 40) then
        if (IsOwnerCity() == 1) and (GetFightState() == 1) then
            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                return 0
            end

            local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
            if (lvl ~= nil) and (typeIdx >= 0) and (typeIdx <= 4) then
                local w, x, y = GetWorldPos()
                local nx = TOTEM_POS_ARRAY[typeIdx][1].nX
                local ny = TOTEM_POS_ARRAY[typeIdx][1].nY
                local rv = (x - nx) ^ 2 + (y - ny) ^ 2
                if (rv < 1500) then
                    Msg2Player("N¬i nµy c¸ch xa thµnh thÞ, kh«ng thÓ thiÕt lËp Cù M·.")
                    return 0
                end
            else
                Msg2Player("Cù M· chØ ®­îc sö dông lóc b¶o vÖ thµnh thÞ l·nh ®Þa m×nh trong thêi gian Quèc ChiÕn.")
                return 0
            end

            if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                Talk(1, "no", "Trªn xe kh«ng thÓ sö dông ®¹o cô nµy.")
                return 0
            end

            startReadProcess()

        else
            Talk(1, "no", "Cù M· chØ ®­îc sö dông lóc b¶o vÖ thµnh thÞ l·nh ®Þa m×nh trong thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "Cù M· chØ ®­îc sö dông lóc b¶o vÖ thµnh thÞ l·nh ®Þa m×nh trong thêi gian Quèc ChiÕn.")
    end
end;

BLOCK_HORSE = 709
BAR_TIME = 3

function startReadProcess()
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)

    BeginMotion(BLOCK_HORSE, 0, BAR_TIME, "\\script\\motion\\Ê¹ÓÃ¾ÜÂí.lua", nInterrupt)
end

function no()
    CloseDialog()
end;










































































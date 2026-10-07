CITY_build = 42
function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local nTongTask = GetTongTask(36)
    local nNum = GetByte(nTongTask, 3)
    if (nNum >= 3) then
        Talk(1, "no", "Trong 1 trËn Quèc ChiÕn 1 l·nh ®Şa tèi ®a chØ cã thÓ sö dông 3 lÇn bÉy")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M <= 40) then
        if (IsOwnerCity() == 1) then
            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bŞ ®¸nh chiÕm.")
                return 0
            end

            if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                Talk(1, "no", "Trªn xe kh«ng thÓ sö dông ®¹o cô nµy.")
                return 0
            end

            startReadProcess()

        else
            Talk(1, "no", "BÉy chØ ®­îc sö dông lóc b¶o vÖ thµnh thŞ l·nh ®Şa m×nh thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "BÉy chØ ®­îc sö dông lóc b¶o vÖ thµnh thŞ l·nh ®Şa m×nh thêi gian Quèc ChiÕn.")
    end
end;

TRAP_TYPE = 708
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
    BeginMotion(TRAP_TYPE, 0, BAR_TIME, "\\script\\motion\\Ê¹ÓÃÏİÚå.lua", nInterrupt)
end

function no()
    CloseDialog()
end;














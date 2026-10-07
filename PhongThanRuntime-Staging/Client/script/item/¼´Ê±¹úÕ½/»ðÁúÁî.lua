Task_storage = 1578
charmuse_uplimit = 2
CITY_build = 42

function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M <= 40) then
        if (IsInCity() == 1) then
            if (isWarsides() == 1) then
                local val1 = GetCityTask(CITY_build)
                if (GetByte(val1, 2) == 2) then
                    Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                    return 0
                end

                startReadProcess()


            else
                Talk(1, "no", "Háa Long LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
            end
        else
            Talk(1, "no", "Háa Long LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
        end
    else
        Talk(1, "no", "Háa Long LÖnh chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
    end
end;

TOKEN_TYPE = 712
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

    BeginMotion(TOKEN_TYPE, 0, BAR_TIME, "\\script\\motion\\Ê¹ÓÃ»ðÁúÁî.lua", nInterrupt)
end

function no()
    CloseDialog()
end;

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 1
    elseif (IsTongMember() == 1) then
        local sTongName = GetTongName()
        local sTong, sCity, nTime, nState = GetShortBattleToInfo(sTongName)
        local CityName = GetCityInfo()
        if (CityName == sCity) then
            return 1
        end
    end
    return 0
end


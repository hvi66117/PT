CITY_build = 42

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 1
    elseif (IsTongMember() == 1) then
        local sTongName = GetTongName()
        local sTong, sCity, nTime, nState = GetShortBattleToInfo(sTongName)
        local CityName = GetCityInfo()
        if (CityName == sCity) then
            return 0
        end
    end
    return 0
end

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
                    Msg2Player("Thµnh thÞ ®· bÞ x©m chiÕm.")
                    return 0
                end

                if (GetFightState() == 0) then
                    Msg2Player("Tr¹ng th¸i phi chiÕn ®Êu kh«ng thÓ sö dông ®¹o cô.")
                    return 0
                end

                local nInterrupt = 0
                nInterrupt = SetBit(nInterrupt, 1, 1)
                nInterrupt = SetBit(nInterrupt, 2, 1)
                nInterrupt = SetBit(nInterrupt, 3, 1)
                nInterrupt = SetBit(nInterrupt, 4, 1)
                nInterrupt = SetBit(nInterrupt, 5, 1)
                nInterrupt = SetBit(nInterrupt, 6, 0)
                BeginMotion(1, 0, 3, "\\script\\item\\¼´Ê±¹úÕ½\\Ñ×ÁúÁî.lua", nInterrupt)
            else
                Talk(1, "no", "Viªm Long LÖnh chØ cã thÓ sö dông trong thµnh thÞ trong kho¶ng thêi gian Quèc ChiÕn diÔn ra.")
            end
        else
            Talk(1, "no", "Viªm Long LÖnh chØ cã thÓ sö dông trong thµnh thÞ trong kho¶ng thêi gian Quèc ChiÕn diÔn ra.")
        end
    else
        Talk(1, "no", "Viªm Long LÖnh chØ cã thÓ sö dông trong thµnh thÞ trong kho¶ng thêi gian Quèc ChiÕn diÔn ra.")
    end
end;

function EndMotion(n)
    if (HaveNormalItem(6, 1, 956, 0) > 0) then
        DelNormalItem(6, 1, 956, 0)
    else
        DelNormalItemInQuick(6, 1, 956, 0)
    end

    local H, M, S = GetHMS()
    local mapid, x, y = GetWorldPos()
    local idx = AddNpc(1954, 1, SubWorld, x * 32, y * 32)
    local nLeftTime = (40 - M) * 60 + 60
    if (idx > 0) then
        SetNpcScript(idx, "\\script\\¼´Ê±¹úÕ½\\Ñ×ÁúÏÝÚå.lua")
        SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nLeftTime)
        SetNpcCamp(idx, GetCamp())
        SetGuardLevel(idx, 2)
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Sö dông Viªm Long LÖnh.")
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\">Sö dông Viªm Long LÖnh.")
        WriteLog("Sö dông Viªm Long LÖnh.")
    end
end

function InteruptMotion(MotionID)
end

function no()
    CloseDialog()
end

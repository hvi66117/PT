CITY_build = 42
function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local nTongTask = GetTongTask(36)
    local nNum = GetByte(nTongTask, 2)
    if (nNum >= 5) then
        Talk(1, "no", "Trong 1 trËn Quèc ChiÕn 1 l·nh ®Þa tèi ®a chØ cã thÓ sö dông 5 nç xa")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M < 40) then
        if (IsInCity() == 1) then
            local key = isWarsides()
            if (key >= 1) then
                local val1 = GetCityTask(CITY_build)

                if (Is_Use_NoWar_Card() == 1) then
                    return
                end

                if (GetFightState() == 0) then
                    Msg2Player("Tr¹ng th¸i phi chiÕn ®Êu kh«ng thÓ sö dông ®¹o cô.")
                    return 0
                end

                if (GetByte(val1, 2) == 2) then
                    Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                    return 0
                end

                if (summonWeapon(M, key) == 1) then
                    if (HaveNormalItem(6, 1, 707, 0) > 0) then
                        DelNormalItem(6, 1, 707, 0)
                    else
                        DelNormalItemInQuick(6, 1, 707, 0)
                    end

                    nTongTask = SetByte(nTongTask, 2, nNum + 1)
                    SetTongTask(36, nTongTask)


                end
            else
                Talk(1, "no", "TriÖu håi chó: Nâ xa chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
            end
        else
            Talk(1, "no", "TriÖu håi chó: Nâ xa chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
        end
    else
        Talk(1, "no", "TriÖu håi chó: Nâ xa chØ ®­îc sö dông trong thêi gian Quèc ChiÕn, ë thµnh thÞ hai bªn giao chiÕn.")
    end
end;

function no()
    CloseDialog()
end;

CITY_NOWAR_CARD = 59

function Is_Use_NoWar_Card()
    local nCityTask = GetCityTask(CITY_NOWAR_CARD)
    local IsUseCard = GetByte(nCityTask, 2)

    if (IsUseCard == 1) then
        Talk(1, "no", "L·nh ®Þa ®ã muèn d­ìng binh, ®· sö dông miÔn chiÕn bµi, v× thÕ lÇn nµy kh«ng thÓ sö dung xung xa.")
        return 1
    end

    return 0
end

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 1
    elseif (IsTongMember() == 1) then
        local sTongName = GetTongName()
        local sTong, sCity, nTime, nState = GetShortBattleToInfo(sTongName)
        local CityName = GetCityInfo()
        if (CityName == sCity) then
            return 2
        end
    end
    return 0
end

function summonWeapon(min, camp)

    CloseDialog()
    local mapid, x, y = GetWorldPos()
    local carriageindex = NewSiegeWeapon(mapid, x * 32, y * 32, 1417, 3)

    if (carriageindex > 0) then
        local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
        SetNpcScript(carriagenpcindex, "\\script\\¼´Ê±¹úÕ½\\¼´Ê±¹úÕ½Õ½³µ.lua")

        local tongName = GetTongName()
        local npcId = GetNpcID(carriagenpcindex)
        local lefttime = (40 - min) * 60
        local guardindex = SendCarriage(carriageindex, GetName(), 1, lefttime, npcId, tongName, 3)

        if (camp == 1) then
            SetNpcCurCamp(carriagenpcindex, 2)
        else
            SetNpcCurCamp(carriagenpcindex, 4)
        end
        SetNpcTask(carriagenpcindex, 1, lefttime)
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> ®· gäi ra 1 Nâ xa")
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> ®· gäi ra 1 Nâ xa")
        SetGuardLevel(carriagenpcindex, 1)
        WriteLog(" ®· sö dông Nâ xa")

        if (camp == 1) then
            SetNpcName(carriagenpcindex, "<c=pk>Bªn phßng thñ*Nâ xa<c>")
        else
            SetNpcName(carriagenpcindex, "<c=yel>Bªn tÊn c«ng*Nâ xa<c>")
        end

        return 1
    else
        Talk(1, "no", "Ch­a triÖu håi ®­îc Nâ xa")
        return 0
    end ;
end

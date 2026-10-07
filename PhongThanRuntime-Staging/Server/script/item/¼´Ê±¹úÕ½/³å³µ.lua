CITY_build = 42

function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local nTongTask = GetTongTask(36)
    local nNum = GetByte(nTongTask, 1)
    if (nNum >= 3) then
        Talk(1, "no", "Trong 1 trËn Quèc ChiÕn 1 l·nh ®Þa chØ cã thÓ sö dông 3 lÇn xung xa")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M < 40) then
        if (IsInCity() == 1) then
            if (isWarsides() == 1) then


                if (Is_Use_NoWar_Card() == 1) then
                    return
                end

                local val1 = GetCityTask(CITY_build)
                if (GetByte(val1, 2) == 2) then
                    Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                    return 0
                end

                if (summonWeapon(M) == 1) then
                    if (HaveNormalItem(6, 1, 706, 0) > 0) then
                        DelNormalItem(6, 1, 706, 0)
                    else
                        DelNormalItemInQuick(6, 1, 706, 0)
                    end

                    nTongTask = SetByte(nTongTask, 1, nNum + 1)
                    SetTongTask(36, nTongTask)

                end


            else
                Talk(1, "no", "TriÖu håi chó: ChØ trong trong thêi gian quèc chiÕn, ng­êi ch¬i míi cã thÓ sö dông Xung Xa trong thµnh kÎ ®Þch.")
            end
        else
            Talk(1, "no", "TriÖu håi chó: ChØ trong trong thêi gian quèc chiÕn, ng­êi ch¬i míi cã thÓ sö dông Xung Xa trong thµnh kÎ ®Þch.")
        end
    else
        Talk(1, "no", "TriÖu håi chó: ChØ trong trong thêi gian quèc chiÕn, ng­êi ch¬i míi cã thÓ sö dông Xung Xa trong thµnh kÎ ®Þch.")
    end
end;

function no()
    CloseDialog()
end;

function isWarsides()
    if (IsOwnerCity() == 1) then
        return 0
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

function summonWeapon(min)

    CloseDialog()
    local mapid, x, y = GetWorldPos()
    local carriageindex = NewSiegeWeapon(mapid, x * 32, y * 32, 1416, 3)

    if (carriageindex > 0) then
        local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
        SetNpcScript(carriagenpcindex, "\\script\\¼´Ê±¹úÕ½\\¼´Ê±¹úÕ½Õ½³µ.lua")

        local tongName = GetTongName()
        local npcId = GetNpcID(carriagenpcindex)
        local lefttime = (40 - min) * 60
        local guardindex = SendCarriage(carriageindex, GetName(), 1, lefttime, npcId, tongName, 3)

        SetNpcCurCamp(carriagenpcindex, 4)
        SetNpcTask(carriagenpcindex, 1, lefttime)
        SetGuardLevel(carriagenpcindex, 1)
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> gäi 1 Xung Xa")
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> ®· gäi ra 1 Xung Xa")
        WriteLog("§· sö dông Xung Xa")

        SetNpcName(carriagenpcindex, "<c=yel>Bªn tÊn c«ng*Xung Xa<c>")

        return 1
    else
        Talk(1, "no", "Gäi Xung Xa thÊt b¹i")
        return 0
    end ;
end

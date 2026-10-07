CITY_build = 42
function main()
    CloseDialog()

    if (GetMorphType() == 411) then
        Talk(1, "no", "ë tr¹ng th¸i C¸t T­êng biÕn th©n kh«ng thÓ sö dông vËt phÈm nµy.")
        return
    end

    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) and (H == 20 and M < 40) then
        if (IsInCity() == 1) and (GetFightState() == 1) then
            local val1 = GetCityTask(CITY_build)
            if (GetByte(val1, 2) == 2) then
                Msg2Player("Thµnh nµy ®· bÞ ®¸nh chiÕm.")
                return 0
            end

            if (HaveNormalItem(6, 1, 715, 0) > 0) then
                DelNormalItem(6, 1, 715, 0)
            elseif (HaveNormalItemInQuick(6, 1, 715, 0) > 0) then
                DelNormalItemInQuick(6, 1, 715, 0)
            else
                return 0
            end

            local mapid, x, y = GetWorldPos()
            local r = math.random(1, 10)
            local idx = -1
            local id = 1423
            if (r >= 9) then
                id = 1427
            elseif (r >= 6) then
                id = 1425
            end

            local npcindex = PlayerIndexToNpcIndex(PlayerIndex)
            local GateNpcIdx = GetCityGateNpcIdxByNpc(npcindex)
            local TotemNpcIdx = GetCityTotemNpcIdxByNpc(npcindex)

            for i = 1, 10 do
                if (GetCamp() == 4) then
                    idx = CallMonsterAttacker(GateNpcIdx, id, 100, (x + math.random(-3, 3)) * 32, (y + math.random(-3, 3)) * 32,
                            "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua",
                            (40 - M) * 60,
                            "\\script\\¹ÖÎï\\¹¥³Çµ°.lua",
                            0,
                            15,
                            TotemNpcIdx)
                elseif (GetCamp() == 2) then
                    idx = AddNpc(id, 100, SubWorld, (x + math.random(-3, 3)) * 32, (y + math.random(-3, 3)) * 32)
                    SetNpcScript(idx, "\\script\\¹ÖÎï\\death.lua")
                    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", (40 - M) * 60)
                end

                if (idx > 0) then
                    SetNpcCamp(idx, GetCamp())
                end
            end

            local Y, M, D = GetYMD()
            local H, M1, S = GetHMS()
            local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()

            if (CityTongName ~= GetTongName()) then
                Msg2TongMember(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " phót<bc=r><RoleName=\"" .. GetName() .. "\"> t¹i" .. CityTongName .. " ®· sö dông V« Tù Thiªn Th­, g©y tæn thÊt cho l·nh ®Þa ®èi ®Þch.")
                Msg2Player(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " ®iÓm, b¹n" .. CityTongName .. " ®· sö dông V« Tù Thiªn Th­ trong thµnh, triÖu håi ra sinh vËt ch­a biÕt.")
            elseif (CityTongName == GetTongName()) then
                Msg2TongMember(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " phót<bc=r><RoleName=\"" .. GetName() .. "\"> ®· sö dông V« Tù Thiªn Th­ trong thµnh thÞ l·nh ®Þa, sÜ khÝ l·nh ®Þa gia t¨ng.")
                Msg2Player(M .. "Th¸ng" .. D .. "Ngµy" .. H .. "giê" .. M1 .. " ®iÓm, b¹n ®· sö dông V« Tù Thiªn Th­ trong l·nh ®Þa, triÖu håi ra sinh vËt ch­a biÕt.")
            end

            WriteLog(" ®· sö dông V« Tù Thiªn Th­")
        else
            Talk(1, "no", "V« Tù Thiªn Th­ chØ cã thÓ sö dông trong l·nh ®Þa tù x©y vµ trong thêi gian quèc chiÕn.")
        end
    else
        Talk(1, "no", "V« Tù Thiªn Th­ chØ cã thÓ sö dông trong l·nh ®Þa tù x©y vµ trong thêi gian quèc chiÕn.")
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

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
                    Msg2Player("Thµnh nµy ®· bŞ ®¸nh chiÕm.")
                    return 0
                end

                if (HaveNormalItem(6, 1, 710, 0) > 0) then
                    DelNormalItem(6, 1, 710, 0)
                else
                    DelNormalItemInQuick(6, 1, 710, 0)
                end

                local mapid, x, y = GetWorldPos()
                local idx = AddNpc(1479, 1, SubWorld, x * 32, y * 32)
                if (idx > 0) then
                    SetNpcScript(idx, "\\script\\¹ÖÎï\\death.lua")
                    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 6)
                    SetNpcCamp(idx, GetCamp())
                    NpcCastSkill(idx, 1, 419, 1)
                    SetGuardLevel(idx, 2)
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> ®· sö dông cÊp cÊp nh­ luËt lÖnh")
                    Msg2Player("Gi¶i trõ h¹n chÕ cho ®¬n vŞ phe b¹n trong ph¹m vi b¸n kİnh 200, trong 6S kh«ng chŞu sù h¹n chÕ. H÷u hiÖu víi m¸y mãc, qu¸i vËt. ChØ cã hiÖu qu¶ víi ®¹o cô t¸c dông ®Õn qu¸i vËt, m¸y mãc nh­: Khæn Tiªn LÖnh, BÉy, B¨ng §èng Hçn Lo¹n.")
                    Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> ®· sö dông cÊp cÊp nh­ luËt lÖnh")
                    WriteLog(" ®· sö dông cÊp cÊp nh­ luËt lÖnh")
                end


            else
                Talk(1, "no", "CÊp cÊp nh­ luËt lÖnh chØ ®­îc sö dông lóc tÊn c«ng thµnh thŞ l·nh ®Şa kÎ ®Şch trong thêi gian Quèc ChiÕn.")
            end
        else
            Talk(1, "no", "CÊp cÊp nh­ luËt lÖnh chØ ®­îc sö dông lóc tÊn c«ng thµnh thŞ l·nh ®Şa kÎ ®Şch trong thêi gian Quèc ChiÕn.")
        end
    else
        Talk(1, "no", "CÊp cÊp nh­ luËt lÖnh chØ ®­îc sö dông lóc tÊn c«ng thµnh thŞ l·nh ®Şa kÎ ®Şch trong thêi gian Quèc ChiÕn.")
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


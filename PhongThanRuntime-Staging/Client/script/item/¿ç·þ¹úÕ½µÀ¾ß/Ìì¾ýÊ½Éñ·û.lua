LTI = 1640

gCityHeavenTask = 53

function main()
    CloseDialog()
    local H, M, S = GetHMS()
    local mapid, x, y = GetWorldPos()
    local today = math.floor(LocalSystemTime() / 86400)
    if (IsMonsterAttackDay(today - 2) == 1) and (H == 20) then
        if (IsWarServer() == 1) then
            local key = isWarsides()
            if (key >= 1) then
                if (GetFightState() == 0) then
                    Msg2Player("ë tr¹ng th¸i phi chiÕn ®Êu kh«ng thÓ sö dông Thøc ThÇn Phï.")
                    return 0
                end

                if (LocalSystemTime() - GetTask(LTI) <= 180) then
                    Msg2Player("Thøc ThÇn Phï mçi 3 phót chØ ®­îc sö dông 1 lÇn.")
                    return
                end

                motion()


            else
                Talk(1, "no", "Thøc ThÇn Phï chØ sö dông ë §éng Thiªn t­¬ng øng trong thêi gian Tranh ®o¹t §éng Thiªn.")
            end
        else
            Talk(1, "no", "Thøc ThÇn Phï chØ sö dông ë §éng Thiªn t­¬ng øng trong thêi gian Tranh ®o¹t §éng Thiªn.")
        end
    else
        Talk(1, "no", "Thøc ThÇn Phï chØ sö dông ë §éng Thiªn t­¬ng øng trong thêi gian Tranh ®o¹t §éng Thiªn.")
    end
end;

function no()
    CloseDialog()
end;

function isWarsides()

    local CityName, CityMode, CityMoney, CityMat, CityLevel, CityTemplet, TongName = GetCityInfo()
    if (CityTemplet >= 5) and (CityTemplet <= 7) then
        local npcIndex = PlayerIndexToNpcIndex(PlayerIndex)
        local heavenType = CityTemplet - 4
        local cityWarDate = GetByte(GetCityTask(53), 1)
        local defendType = GetByte(GetCityTask(53), 2)
        local attackType = GetByte(GetCityTask(53), 3)
        local isWarOver = GetBit(GetByte(GetCityTask(53), 4), 8)
        local today = math.mod(math.floor(LocalSystemTime() / 86400), 255)
        local playerType = GetPosterityType()
        if (cityWarDate == today) then
            if ((playerType == defendType) or (playerType == attackType)) then
                if (isWarOver == 1) then
                    Talk(1, "no", "ChiÕn tranh ®· kÕt thóc.")
                    return 0
                end

                return 1
            else
                Talk(1, "no", "B¹n kh«ng ph¶i bªn tuyªn chiÕn §éng Thiªn còng kh«ng ph¶i bªn phßng thñ §éng Thiªn.")
                return 0
            end
        else
            Talk(1, "no", "§éng Thiªn nµy kh«ng ph¶i n¬i tuyªn chiÕn h«m nay.")
            return 0
        end

    else
        Talk(1, "no", "Dung Binh Phï chØ cã thÓ sö dông trong thµnh thÞ §éng Thiªn.")
        return 0
    end

    Talk(1, "no", "Dung Binh Phï sö dông h¹n chÕ xuÊt hiÖn dÞ th­êng.")
    return 0
end

function motion()
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)

    nInterrupt = SetBit(nInterrupt, 5, 1)

    nInterrupt = SetBit(nInterrupt, 7, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 11, 1)
    BeginMotion(LTI, 0, 5, "\\script\\motion\\µØÁéÊ½Éñ·û¶ÁÌõ.lua", nInterrupt)
end

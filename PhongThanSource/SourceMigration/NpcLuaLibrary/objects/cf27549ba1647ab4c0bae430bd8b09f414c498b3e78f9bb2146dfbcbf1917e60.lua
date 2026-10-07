module("Sentiment", package.seeall)

function PubFuncAddSentiment(npcIndex, Sentiment)
    if (npcIndex == nil) then
        return
    end
    if (Sentiment == nil) then
        Sentiment = 1
    end
    Sentiment = Sentiment * 2

    local bossname = GetNpcName(npcIndex)
    local oldPlayerIndex = _G.PlayerIndex
    _G.PlayerIndex = GetDropPlayer(npcIndex)
    if (_G.PlayerIndex > 0) then
        WriteLog(bossname .. " chÕt, quyÒn nhÆt thuéc vÒ " .. GetName())
    else
        _G.PlayerIndex = 1
        WriteLog(bossname .. " chÕt, nh­ng quyÒn nhÆt kh«ng thuéc vÒ ai!")
        _G.PlayerIndex = oldPlayerIndex
        return
    end

    local bossmap, bossx, bossy = GetNpcWorldPos(npcIndex)
    local w, x, y = 0, 0, 0

    if (GetTeam() > 0) then

        local nPeople = GetTeamSize()
        for i = 1, nPeople do
            _G.PlayerIndex = GetTeamMember(i)
            w, x, y = GetWorldPos()
            if (w == bossmap) then
                if (IsTongMember() > 0) then
                    AddTongAttr(0, Sentiment)
                    Msg2CurMapAnnounce("Anh hïng " .. GetName() .. " anh dòng phi phµm, kÝch s¸t " .. bossname .. " gióp Nh©n khÝ quèc gia t¨ng " .. Sentiment .. " ®iÓm!")
                    Msg2TongMember("<bc=r>Anh hïng " .. GetName() .. " anh dòng phi phµm, kÝch s¸t " .. bossname .. " gióp Nh©n khÝ quèc gia t¨ng " .. Sentiment .. " ®iÓm!</bc>")

                end
            end
        end


    else
        w, x, y = GetWorldPos()
        if (w == bossmap) then

            if (IsTongMember() > 0) then
                AddTongAttr(0, Sentiment)
                Msg2CurMapAnnounce("Anh hïng " .. GetName() .. " anh dòng phi phµm, kÝch s¸t " .. bossname .. " gióp Nh©n khÝ quèc gia t¨ng " .. Sentiment .. " ®iÓm!")
                Msg2TongMember("<bc=r>Anh hïng " .. GetName() .. " anh dòng phi phµm, kÝch s¸t " .. bossname .. " gióp Nh©n khÝ quèc gia t¨ng " .. Sentiment .. " ®iÓm!</bc>")

            end
        end
    end

    _G.PlayerIndex = oldPlayerIndex
end

function IsTongMemberInTeam(CityTongName)
    if (CityTongName == nil) then
        return
    end

    if not (GetTeam() > 0) then
        return
    end

    local temp1, temp2, temp3, temp4, temp5, temp6, TongName = "", "", "", "", "", "", ""

    local oldPlayer = _G.PlayerIndex

    local nPeople = GetTeamSize()

    for i = 2, nPeople do
        _G.PlayerIndex = GetTeamMember(i)

        if (IsTongMember() > 0) then
            temp1, temp2, temp3, temp4, temp5, temp6, TongName = GetCityInfo()
            if (TongName == CityTongName) then
                return 1
            end
        end
    end

    _G.PlayerIndex = oldPlayer
    return 0
end

function no()
    CloseDialog()
end


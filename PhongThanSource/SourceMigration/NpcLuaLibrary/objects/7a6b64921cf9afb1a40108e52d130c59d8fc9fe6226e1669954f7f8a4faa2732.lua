require("ĞÂ·ş»î¶¯.luax")

require("newserver.luax")

function OnDeath(npcidx)

    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            NewServerEx.Pet_GetPilesTask(5)
        end
        PlayerIndex = oldPlayer
    else
        NewServerEx.Pet_GetPilesTask(5)
    end

    DelNpc(npcidx)

    if (PlayerIndex > 0 and NewServer.Pub_IsNewServerOpen() > 0 and math.random(1, 100) <= 20) then
        SetTaskBit(2028, 18, 1)
        AddNormalItem(6, 1, 1285, 1, 0, 0)
        TopMessage("NhËn ®­îc <c=g>HuyÒn Vò Tµn Ph¸ch-N÷<c>")
        Msg2Player("NhËn ®­îc HuyÒn Vò Tµn Ph¸ch-N÷")
        WriteLog("[NhËn ®­îc HuyÒn Vò Tµn Ph¸ch-N÷ ²»°ó]")
    end

end;

function no()
    CloseDialog()
end;

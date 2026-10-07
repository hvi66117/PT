function no()
    CloseDialog();
end

function main()
    local mapid, x, y = GetWorldPos()

    if (mapid ~= 21) then
        Talk(1, "no", "H¹t gièng cÇu nguyÖn chØ cã thÓ sö dông t¹i TriÒu Ca")
        return
    end
    local targetIndex = GetPlayerTarget()
    local friendIndex = NpcIdx2PIdx(targetIndex)
    local oldPlayer = PlayerIndex
    local ownName = GetName()
    PlayerIndex = friendIndex

    if PlayerIndex > 0 then
        if GetRelation(ownName) == 1 then
            SetFriendFellowShipValue(ownName, 10)
            Msg2Player("H¶o h÷u" .. ownName .. " ®· sö dông H¹t gièng cÇu nguyÖn víi b¹n, ®é th©n mËt t¨ng thªm 10 ®iÓm.")
            local friendName = GetName()

            PlayerIndex = oldPlayer
            DelNormalItem(6, 1, 864, 0)
            local nExp = GetLevel() * 500
            AddOwnExp(nExp)
            AddNormalItemBind(8, 223, 2, 0, 0, 0, 1)
            Msg2Player("B¹n ®· sö dông H¹t gièng cÇu nguyÖn víi h¶o h÷u " .. friendName .. ", ®é th©n mËt t¨ng thªm 10 ®iÓm, ®ång thêi nhËn ®­îc " .. nExp .. " kinh nghiÖm")
            Msg2CurMapAnnounce(ownName .. "Göi lêi chóc gi¸ng sinh cho " .. friendName .. ", chóc cho t×nh b¹n cña hä m·i bÒn v÷ng!")
        else
            PlayerIndex = oldPlayer
            Msg2Player("§èi ph­¬ng kh«ng ph¶i h¶o h÷u cña b¹n!")
        end
    else
        PlayerIndex = oldPlayer

        Msg2Player("H·y chän h¶o h÷u vµ nhÊp chuét ph¶i ®Ó sö dông H¹t gièng cÇu nguyÖn.")
    end
    PlayerIndex = oldPlayer
end

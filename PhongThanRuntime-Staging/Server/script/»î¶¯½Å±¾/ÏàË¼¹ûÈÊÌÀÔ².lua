function main()

    if (HaveNormalItem(6, 1, 872, 0) <= 0) then
        return
    end

    local Exp = CheckExpLevel()

    DelNormalItem(6, 1, 872, 0)
    AddIBBuff(1360, 60 * 60)
    AddOwnExp(Exp)
    AddIBBuff(1357)
    AddEmoteBalloon(PlayerIndex, 17)
    Msg2Player("Ng­¬i ®· ¨n B¸nh tr«i n­íc h¹t t­¬ng t­, nhËn ®­îc " .. Exp .. " ®iÓm kinh nghiÖm vµ tèc ®é xuÊt chiªu t¨ng 5% hiÖu qu¶ trong vßng 1 giê.")
    if (math.random(1, 100) <= 20) then
        Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> nuèt 1 h¬i B¸nh tr«i n­íc h¹t t­¬ng t­, vç bông mét c¸ch s¶ng kho¸i, c¶m gi¸c tho¶i m¸i nh­ thÇn tiªn!")
    end
    WriteLog(GetName() .. "§· dïng B¸nh tr«i n­íc h¹t t­¬ng t­.")
end

function CheckExpLevel()
    no()
    local pLvl = GetLevel()
    if (pLvl <= 59) then
        return pLvl * 200
    elseif (pLvl > 59 and pLvl <= 89) then
        return pLvl * 400
    else
        return pLvl * 800
    end
end

function no()
    CloseDialog()
end

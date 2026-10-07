function main()

    if (HaveNormalItem(6, 1, 871, 0) <= 0) then
        return
    end

    local Exp = CheckExpLevel()

    DelNormalItem(6, 1, 871, 0)
    AddIBBuff(1359, 60 * 60)
    AddOwnExp(Exp)
    AddIBBuff(1357)
    AddEmoteBalloon(PlayerIndex, 17)
    Msg2Player("Ng­¬i ®· ¨n B¸nh tr«i n­íc h­¬ng r­îu, nhËn ®­îc " .. Exp .. " ®iÓm kinh nghiÖm vµ kh¸ng tÝnh tèi ®a t¨ng 5% hiÖu qu¶ trong vßng 1 giê.")
    if (math.random(1, 100) <= 20) then
        Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> nuèt 1 h¬i B¸nh tr«i n­íc h­¬ng r­îu, vç bông mét c¸ch s¶ng kho¸i, c¶m gi¸c tho¶i m¸i nh­ thÇn tiªn!")
    end
    WriteLog(GetName() .. "§· dïng B¸nh tr«i n­íc h­¬ng r­îu.")
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

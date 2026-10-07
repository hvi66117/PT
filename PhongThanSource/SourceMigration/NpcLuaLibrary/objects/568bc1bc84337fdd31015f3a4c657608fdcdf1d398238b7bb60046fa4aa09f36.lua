function OnDeath(c)
    local npcWSIdx = GetTask(1056)
    if (npcWSIdx == c) then
        local r = math.random(1, 200)
        SetTask(1056, 0)
        local str = ""
        local strM = ""
        local strW = ""
        local oldplayIdx = PlayerIndex

        if (GetSex() == 0) then
            strM = GetName()
            strW = GetMateName()
        else
            strM = GetMateName()
            strW = GetName()
        end

        local w = math.random(1, 10)
        if (w <= 9) then
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = ", r¬i mÊt 1 Hoa Hång."
        else
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = ", r¬i mÊt 2 Hoa H«ng."
        end

        if (r == 15) or (r == 70) or (r == 90) then
            local MIdx = GetPlayerIndexByName(strM)
            if (MIdx > 0) then
                PlayerIndex = MIdx
                SetTask(1056, 0)
                PlayerIndex = oldplayIdx
            end
            ThrowItem(c, MIdx, 6, 1, 160, 1, 0, 0)

            str = str .. " Víi 1 Méng NhiÔu Trang"
            WriteLog("Ngò Th«ng ThÇn Méng NhiÔu Trang")
            AddGlobalCountNews("phu<c=yel>" .. strM .. "<c>thª<c=r> bªn nhau" .. strW .. "<c>kh«ng sî ¸c thó hung tµn, phu thª ®ång t©m diÖt trõ ¸c thó trõ ho¹ cho nh©n gian, minh chøng cho t×nh yªu nång th¾m.", 5)
        elseif (r == 155) or (r == 180) or (r == 120) then
            local WIdx = GetPlayerIndexByName(strW)
            if (WIdx > 0) then
                PlayerIndex = WIdx
                SetTask(1056, 0)
                PlayerIndex = oldplayIdx
            end
            ThrowItem(c, WIdx, 6, 1, 162, 1, 0, 0)

            str = str .. "Víi 1 T×nh Khiªn Trang"
            WriteLog("Ngò Th«ng ThÇn T×nh Khiªn Trang")
            AddGlobalCountNews("<c=yel>" .. strM .. "<c> vµ <c=r>" .. strW .. "<c> phu thª ng­¬i ®ång t©m hiÖp lùc, cuèi cïng ®· chinh phôc ®­îc Ngò Th«ng ThÇn nhËn ®­îc 1 <c=yel>Th¸i V©n Trang<c> quý hiÕm!", 5)
        end
        Msg2Team("Ngò Th«ng ThÇn ë TuyÖt Long LÜnh bÞ gi¸ng phôc." .. str)
    end
    DelNpc(c)
end;

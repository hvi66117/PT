--description:ÎåÍ¨Éñ--³ÂÌÁ¹Ø
--author: yaoxin
--date: 2007/8/6


function OnDeath(c)
    local npcWSIdx = GetTask(1056)
    if (npcWSIdx == c) then
        local r = random(1, 100)
        SetTask(1056, 0)
        local oldplayIdx = PlayerIndex
        local MIdx = GetPlayerIndexByName(GetMateName())
        if (MIdx > 0) then
            PlayerIndex = MIdx
            SetTask(1056, 0)
            PlayerIndex = oldplayIdx
        end
        local str = ""
        local w = random(1, 10)
        if (w <= 9) then
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = ", huyÒn hãa thµnh 1 Hoa Hång."
        else
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = ", huyÒn hãa thµnh 2 Hoa Hång."
        end
        if (r <= 10) then
            local strM = ""
            local strW = ""

            if (GetSex() == 0) then
                strM = GetName()
                strW = GetMateName()
            else
                strM = GetMateName()
                strW = GetName()
            end

            ThrowItem(c, PlayerIndex, 0, 4, 35, 1, 0, 0)
            --TopMessage(11673)
            str = str .. " Cïng 1 Tam Sinh Th¹ch"
            WriteLog("Ngò Th«ng ThÇn Tam Sinh Th¹ch")
            AddGlobalCountNews("<c=yel>" .. strM .. "<c> vµ <c=r>" .. strW .. "<c> chinh phôc Ngò Th«ng ThÇn, mèi ch©n t×nh ®· c¶m ®éng lßng trêi, nhËn ®­îc  1 <c=yel>Tam Sinh Th¹ch<c>.", 5)
        end
        Msg2Team("Ngò Th«ng ThÇn ë TrÇn §­êng ®· bÞ thu phôc" .. str)
    end
    DelNpc(c)
end
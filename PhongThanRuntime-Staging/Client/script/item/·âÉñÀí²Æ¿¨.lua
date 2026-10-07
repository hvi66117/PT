TaskVariableID = 2219

gItem = { 6, 1, 1658, 1, 0, 0 }

function main()
    local button = {
        { "12ÔÂ·İ·µÀû", "DecemberEarnCoin"; show = 1 },
        { "1ÔÂ·İ·µÀû", "JanuaryEarnCoin"; show = 1 },
        { "2ÔÂ·İ·µÀû", "FebruaryEarnCoin"; show = 1 },
        { "3ÔÂ·İ·µÀû", "MarchEarnCoin"; show = 1 },
    }
    local CardsNum = GetTaskByte(2219, 2)
    local info = "Ó¢ĞÛÄúÏÖÓĞ·âÉñÀí²Æ¿¨" .. CardsNum .. "·İ, Äú¿ÉÒÔÔÚÒÔÏÂÊ±¼äÄÚÁìÈ¡Äú¶ÔÓ¦ÔÂ·İµÄÁé±¦·µÀû, Ã¿´ÎCã thÓ nhËn150*" .. CardsNum .. " Linh B¶o."
    SayTask(info, button)
end

function DecemberEarnCoin()
    local buytimes = GetTaskByte(TaskVariableID, 2)
    local coin = 150 * buytimes
    local flag = GetTaskBit(TaskVariableID, 25)
    local YY, MM, DD = GetYMD()
    local h, m, s = GetHMS()

    if (flag == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı12ÔÂµÄÁé±¦·µÀûÁË, ×£Äú²ÆÔ´¹ã½ø.")
        return
    end
    if ((YY == 2020 and MM == 12) and ((DD >= 8 and DD <= 31) or (DD == 7 and h >= 10))) then
        SetTaskBit(TaskVariableID, 25, 1)
        AddBindCoin(coin * 100)
    else
        Talk(1, "no", "ÄúĞèÒªÔÚ2020Äê12ÔÂ7ÈÕ 10 ®iÓm~12ÔÂ31ÈÕÆÚ¼ä²ÅÄÜÁìÈ¡µ½Ã¿ÕÅÀí²Æ¿¨150 Linh B¶o hoµn tr¶.")
        return
    end

    Talk(1, "no", "ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn <c=y>" .. coin .. "<c> Linh B¶o hoµn tr¶.")
    Msg2Player("ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn " .. coin .. " Linh B¶o hoµn tr¶.")
    WriteLog("[¹ú¼Ê°æ][·âÉñÀí²Æ¿¨][NhËn 12ÔÂµÄÁé±¦·µÀû:" .. coin .. "]")
end

function JanuaryEarnCoin()
    local buytimes = GetTaskByte(TaskVariableID, 2)
    local coin = 150 * buytimes
    local flag = GetTaskBit(TaskVariableID, 26)
    local YY, MM, DD = GetYMD()
    if (flag == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı1ÔÂµÄÁé±¦·µÀûÁË, ×£Äú²ÆÔ´¹ã½ø.")
        return
    end
    if (YY == 2021 and MM == 1) then
        SetTaskBit(TaskVariableID, 26, 1)
        AddBindCoin(coin * 100)
    else
        Talk(1, "no", "ÄúĞèÒªÔÚ2021Äê1ÔÂ·İ²ÅÄÜÁìÈ¡µ½Ã¿ÕÅÀí²Æ¿¨150 Linh B¶o hoµn tr¶.")
        return
    end

    Talk(1, "no", "ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn <c=y>" .. coin .. "<c> Linh B¶o hoµn tr¶.")
    Msg2Player("ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn " .. coin .. " Linh B¶o hoµn tr¶.")
    WriteLog("[¹ú¼Ê°æ][·âÉñÀí²Æ¿¨][NhËn 1ÔÂµÄÁé±¦·µÀû:" .. coin .. "]")
end

function FebruaryEarnCoin()
    local buytimes = GetTaskByte(TaskVariableID, 2)
    local coin = 150 * buytimes
    local flag = GetTaskBit(TaskVariableID, 27)
    local YY, MM, DD = GetYMD()
    if (flag == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı2ÔÂµÄÁé±¦·µÀûÁË, ×£Äú²ÆÔ´¹ã½ø.")
        return
    end
    if (YY == 2021 and MM == 2) then
        SetTaskBit(TaskVariableID, 27, 1)
        AddBindCoin(coin * 100)
    else
        Talk(1, "no", "ÄúĞèÒªÔÚ2021Äê2ÔÂ·İ²ÅÄÜÁìÈ¡µ½Ã¿ÕÅÀí²Æ¿¨150 Linh B¶o hoµn tr¶.")
        return
    end

    Talk(1, "no", "ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn <c=y>" .. coin .. "<c> Linh B¶o hoµn tr¶.")
    Msg2Player("ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn " .. coin .. " Linh B¶o hoµn tr¶.")
    WriteLog("[¹ú¼Ê°æ][·âÉñÀí²Æ¿¨][NhËn 2ÔÂµÄÁé±¦·µÀû:" .. coin .. "]")
end

function MarchEarnCoin()
    local buytimes = GetTaskByte(TaskVariableID, 2)
    local coin = 150 * buytimes
    local flag = GetTaskBit(TaskVariableID, 28)
    local YY, MM, DD = GetYMD()
    if (flag == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı3ÔÂµÄÁé±¦·µÀûÁË, ×£Äú²ÆÔ´¹ã½ø.")
        return
    end
    if (YY == 2021 and MM == 3) then
        SetTaskBit(TaskVariableID, 28, 1)
        AddBindCoin(coin * 100)
    else
        Talk(1, "no", "ÄúĞèÒªÔÚ2021Äê3ÔÂ·İ²ÅÄÜÁìÈ¡µ½Ã¿ÕÅÀí²Æ¿¨150 Linh B¶o hoµn tr¶.")
        return
    end

    Talk(1, "no", "ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn <c=y>" .. coin .. "<c> Linh B¶o hoµn tr¶.")
    Msg2Player("ÄúÍ¨¹ı·âÉñÀí²Æ¿¨ nhËn " .. coin .. " Linh B¶o hoµn tr¶.")
    WriteLog("[¹ú¼Ê°æ][·âÉñÀí²Æ¿¨][ nhËn 3ÔÂµÄÁé±¦·µÀû:" .. coin .. "]")
end

function no()
    CloseDialog()
end

G_MAX = 20

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (GetGlobalStoreValueByte(109, 1) == 0) then
        DelNormalItem(6, 1, 1650, 0)
        DelNormalItem(6, 1, 1650, 1)
        InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
        WriteLog("[¹éÔª¾µQuµ BÊt Ngê][»î¶¯¹Ø±Õ]")
        return 0
    else
        local y, m, d = GetYMD()
        local today = y * 10000 + m * 100 + d
        local StartStr = GetGlobalStoreValue(107)
        local EndDay = GetGlobalStoreValue(108)
        if (today < StartStr or today > EndDay) then
            DelNormalItem(6, 1, 1650, 0)
            DelNormalItem(6, 1, 1650, 1)
            InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
            WriteLog("[¹éÔª¾µQuµ BÊt Ngê][»î¶¯½áÊø]")
            return 0
        end
    end

    local tasks = {
        { "Mua ¹éÔª¾µ", "shop"; show = 1 },
    }
    SayTask("Í¨¹ý¸ÃµÀ¾ß¹ºÂò¹éÔª¾µÓÐ¼¸ÂÊnhËn ®­îc <c=y>Vi Quang Qu¸i Phï<c>(Kho¸).ÀÛ¼Æ¹ºÂò3/8/15/22/ 30 c¸i ¹éÔª¾µ, ±ØnhËn ®­îc 1/1/2/2/ 3 c¸i Vi Quang Qu¸i Phï.Ã¿¸ö½ÇÉ«×î¶à¿ÉnhËn ®­îc " .. G_MAX .. " c¸i Vi Quang Qu¸i Phï.", tasks)
end

function shop()
    MsgBox("±¾´Î»î¶¯ÄúÒÑ¾­ÀÛ¼Æmua <c=g>" .. GetTaskByte(2217, 4) .. "<c>´Î¹éÔª¾µ, ´Ë¹éÔª¾µÊÇ²»khãaµÄ, ÔùËÍµÄVi Quang Qu¸i PhïÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª»¨·Ñ<c=y>90 Th«ng B¶o<c>¹ºÂòÃ´?", "Yes_shop", "no")
end

function Yes_shop()
    no()
    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng ®ñ 2 « trèng, vui lßng s¾p xÕp l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(291)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, ¹éÔª¾µ cÇn <c=r>" .. Cfs .. " Th«ng B¶o<c>, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(291) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂò¹éÔª¾µÊ§°Ü!")
        return
    end

    local total = GetTaskByte(2217, 3)
    local cishu = GetTaskByte(2217, 4) + 1
    local str = "¹§Ï²ÄúÔÚ±¾´Î»î¶¯ÒÑ¾­ÀÛ¼Æ mua " .. cishu .. " c¸i ¹éÔª¾µ"
    local list = {
        { 3, 1 },
        { 8, 1 },
        { 15, 2 },
        { 22, 2 },
        { 30, 3 },
    }
    if (total < G_MAX) then
        local rand = math.random(1, 100)
        local num = 0
        local str1 = ""
        local rv = GetGlobalStoreValueByte(109, 2)
        if (rv <= 0) then
            rv = 1
        elseif (rv > 100) then
            rv = 100
        end

        for i = 1, getn(list) do
            if (list[i][1] == cishu) then
                num = list[i][2]
                if (i < getn(list)) then
                    str1 = "ÄúÔÚ±¾´Î»î¶¯ÖÐÔÙ mua " .. (list[i + 1][1] - list[i][1]) .. " c¸i ¹éÔª¾µ, ¼´¿ÉÖÁÉÙnhËn ®­îc " .. list[i + 1][2] .. " c¸i Vi Quang Qu¸i Phï."
                end
                break
            elseif (cishu < list[i][1]) then
                if (rand <= rv) then
                    num = 1
                end
                str1 = "ÄúÔÚ±¾´Î»î¶¯ÖÐÔÙ mua " .. (list[i][1] - cishu) .. " c¸i ¹éÔª¾µ, ¼´¿ÉÖÁÉÙnhËn ®­îc " .. list[i][2] .. " c¸i Vi Quang Qu¸i Phï."
                break
            elseif (cishu > list[getn(list)][1]) then
                if (rand <= rv) then
                    num = 1
                end
                str1 = "ÄúÔÚ±¾´Î»î¶¯ÖÐÀÛ¼Æ nhËn ®­îc " .. (total + num) .. " c¸i Vi Quang Qu¸i Phï."
                break
            end
        end

        if (num > 0) then
            if (total + num) > G_MAX then
                num = G_MAX - total
            end

            for i = 1, num do
                AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
            end
            total = total + num
            SetTaskByte(2217, 3, total)
            str = str .. ", nhËn ®­îc " .. num .. " c¸i Vi Quang Qu¸i Phï." .. str1
        else
            str = str .. "." .. str1
        end
        WriteLog("[¹éÔª¾µQuµ BÊt Ngê][X¸c suÊt" .. rv .. "%:" .. rand .. "][±¾´Î/ÀÛ¼ÆVi Quang Qu¸i Phï: " .. num .. "/" .. total .. "]ÀÛ¼Æ" .. cishu)
    else
        str = str .. "."
        WriteLog("[¹éÔª¾µQuµ BÊt Ngê][ÒÑÂú 20 c¸i Vi Quang Qu¸i Phï]ÀÛ¼Æ" .. cishu)
    end

    AddNormalItem(8, 1952, 5, 0, 0, 0)
    SetTaskByte(2217, 4, cishu)
    Talk(1, "main", str)
    Msg2Player(str)
end

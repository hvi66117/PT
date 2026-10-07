GLOBAL_V_XIQI = 274
GLOBAL_V_CHAOGE = 272
GLOBAL_V_YUXU = 273

function no()

    CloseDialog()
end

function main()

    local Year, Mon, Dat = GetYMD()

    if Year ~= 2009 or Mon ~= 12 or Dat < 25 or Dat > 27 then

        Talk(1, "no", "Hép Quµ Gi¸ng Sinh chØ ®­îc më trong thêi gian ho¹t ®éng Gi¸ng sinh vµ ë thµnh thÞ cã <c=yel>tuyÕt r¬i<c>, ng­¬i ®· lì mÊt thêi c¬ tèt ®Ó më nã råi!")

        return
    end

    local m, x, y = GetNpcWorldPos(PlayerIndexToNpcIndex(PlayerIndex))

    local CashGilf = 0

    if Dat == 25 and m ~= 21 then

        Talk(1, "no", "Hép Quµ Gi¸ng Sinh h«m nay chØ cã thÓ më t¹i <c=g>TriÒu Ca<c>, më ra sÏ cã nhiÒu bÊt ngê!")

        return

    elseif Dat == 26 and m ~= 20 then

        Talk(1, "no", "Hép Quµ Gi¸ng Sinh h«m nay chØ cã thÓ më t¹i <c=g>T©y Kú<c>, më ra sÏ cã nhiÒu bÊt ngê!")

        return

    elseif Dat == 27 and m ~= 3 then

        Talk(1, "no", "Hép Quµ Gi¸ng Sinh h«m nay chØ cã thÓ më t¹i <c=g>Ngäc H­ Cung<c>, më ra sÏ cã nhiÒu bÊt ngê!")

        return

    end

    local GValue = 0
    if m == 21 then

        CashGilf = GetGlobalValueWord(GLOBAL_V_CHAOGE, 2)
        GValue = GLOBAL_V_CHAOGE

    elseif m == 20 then

        CashGilf = GetGlobalValueWord(GLOBAL_V_XIQI, 2)
        GValue = GLOBAL_V_XIQI

    else

        CashGilf = GetGlobalValueWord(GLOBAL_V_YUXU, 2)
        GValue = GLOBAL_V_YUXU

    end

    local RandValue = math.random(1, 100)

    if RandValue <= 35 then

        AddNormalItem(6, 1, 782, 1, 0, 0)
        TopMessage("Ng­¬i ®· nhËn ®­îc Ph¸o Gi¸ng Sinh")
        Msg2Player("Ng­¬i ®· nhËn ®­îc Ph¸o Gi¸ng Sinh.")

    elseif RandValue <= 65 then

        AddNormalItem(6, 1, 783, 1, 0, 0)
        TopMessage("Ng­¬i ®· nhËn ®­îc KÑo Gi¸ng Sinh")
        Msg2Player("Ng­¬i ®· nhËn ®­îc KÑo Gi¸ng Sinh.")

    elseif RandValue <= 85 then


        AddNormalItem(8, 1224, 3, 0, 0, 0)
        TopMessage("Ng­¬i ®· nhËn ®­îc Thñy Tinh Gi¸ng Sinh")
        Msg2Player("Ng­¬i ®· nhËn ®­îc Thñy Tinh Gi¸ng Sinh.")

    elseif RandValue < 100 or CashGilf ~= 0 then

        AddNormalItem(6, 1, 781, 1, 0, 0)
        TopMessage("Ng­¬i ®· nhËn ®­îc MÆt n¹ ¤ng giµ Noel")
        Msg2Player("Ng­¬i ®· nhËn ®­îc MÆt n¹ ¤ng giµ Noel.")

    elseif CashGilf == 0 then

        EarnBind(3000000)
        Msg2Player("Ng­¬i ®· nhËn ®­îc phÇn th­ëng 3000000 b¹c khãa")
        TopMessage("Ng­¬i ®· nhËn ®­îc phÇn th­ëng 3000000 b¹c khãa")
        SetGlobalValueWord(GValue, 2, 1)

    end

    DelNormalItem(6, 1, 780, 1)

end

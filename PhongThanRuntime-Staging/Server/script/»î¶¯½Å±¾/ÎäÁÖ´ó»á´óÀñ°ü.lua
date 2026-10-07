Symposium_ID = 1702

G_RuYi = 372

function main(nLevel, nTime, nTNpcIdx, itemID)
    DelItemByID(itemID)
    local nRand = math.random(1, 1000)

    if (nRand >= 1 and nRand <= 300) then
        Earn(100000)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 100000 b¹c")
        WriteLog(GetName() .. " nhËn ®­îc 10 v¹n b¹c")
    elseif (nRand >= 301 and nRand <= 439) then
        AddNormalItem(8, 733, 2, 0, 0, 0)
        ScrollMessage("B¹n nhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá!")
        WriteLog(GetName() .. "NhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá")
    elseif (nRand >= 440 and nRand <= 539) then
        AddNormalItem(8, 35, 2, 1, 0, 0)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 1 Di Ngo¹i Phï")
        WriteLog(GetName() .. "NhËn ®­îc 1 Di Ngo¹i Phï")
    elseif (nRand >= 540 and nRand <= 639) then
        AddIBBuff(176)
        ScrollMessage("B¹n sÏ nhËn ®­îc tr¹ng th¸i nh©n 1.5 kinh nghiÖm trong 2 giê tíi. H·y tranh thñ tËn dông.")
    elseif (nRand >= 640 and nRand <= 739) then
        AddIBBuff(330)
        ScrollMessage("B¹n nhËn ®­îc 1 L©m Tiªn Lé")
        WriteLog(GetName() .. "NhËn ®­îc 1 L©m Tiªn Lé")
    elseif (nRand >= 740 and nRand <= 789) then
        Earn(1000000)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 1000000 l­îng!")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc <c=yel>100 v¹n<c> b¹c")
        WriteLog(GetName() .. "NhËn ®­îc 100 v¹n b¹c")
    elseif (nRand >= 790 and nRand <= 839) then
        AddIBBuff(228)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 1 Thiªn Gi¸ng!")
        WriteLog(GetName() .. "NhËn ®­îc 1 ThÇn Tµi")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 1 <c=yel>ThÇn Tµi<c>")
    elseif (nRand >= 840 and nRand <= 889) then
        AddNormalItemBind(8, 382, 4, 0, 0, 0, 1)
        ScrollMessage("B¹n nhËn ®­îc 1 Ch©n KhÝ (Nh­ ý)")
        WriteLog(GetName() .. "NhËn ®­îc 1 Ch©n KhÝ (Nh­ ý)")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 1 <c=yel>Ch©n KhÝ (Nh­ ý)<c>")
    elseif (nRand >= 890 and nRand <= 939) then
        AddNormalItemBind(8, 381, 3, 0, 0, 0, 1)
        ScrollMessage("B¹n nhËn ®­îc 1 Thanh Lé (Nh­ ý)")
        WriteLog(GetName() .. "NhËn ®­îc 1 Thanh Lé (Nh­ ý)")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 1 <c=yel>Thanh Lé (Nh­ ý)<c>")
    elseif (nRand >= 940 and nRand <= 989) then
        AddNormalItemBind(3, 138, 0, 0, 0, 0, 1)
        ScrollMessage("B¹n nhËn ®­îc 1 ThiÖp Nh­ ý")
        WriteLog(GetName() .. "NhËn ®­îc 1 ThiÖp Nh­ ý")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 1 <c=yel>ThiÖp Nh­ ý<c>")
    elseif (nRand >= 990 and nRand <= 999) then
        AddBindCoin(500)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 5 Ng©n B¶o!")
        WriteLog(GetName() .. "NhËn ®­îc 5 Ng©n B¶o")
        AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 5 <c=yel>Ng©n B¶o<c>")
    elseif (nRand == 1000) then
        local id, nX, nY = GetWorldPos()
        local nYear, nMonth, nDay = GetYMD()
        local today = GetGlobalValueByte(G_RuYi, 1)
        local nNums = GetGlobalValueByte(G_RuYi, 2)

        if (id == 21 and ((today ~= nDay) or (today == nDay and nNums < 3))) then
            if (today ~= nDay) then
                SetGlobalValueByte(G_RuYi, 1, nDay)
                SetGlobalValueByte(G_RuYi, 2, 0)
                nNums = 0
            end

            SetGlobalValueByte(G_RuYi, 2, nNums + 1)
            for i = 1, 100 do
                AddNormalItemBind(3, 138, 0, 0, 0, 0, 1)
            end
            ScrollMessage("B¹n nhËn ®­îc 100 ThiÖp Nh­ ý")
            WriteLog(GetName() .. "NhËn ®­îc 100 ThiÖp Nh­ ý")
            AddGlobalNews(GetName() .. "Më tói quµ §¹i héi Vâ L©m, nhËn ®­îc 100 <c=yel>ThiÖp Nh­ ý<c>")
        end
    end
end

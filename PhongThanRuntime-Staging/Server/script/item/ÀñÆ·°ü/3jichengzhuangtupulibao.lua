--description: ³È×°Èý¼¶ÆÆ¾ü¡¤ÏµÁÐÍ¼Æ×Àñ°ü
--author: yaoxin
--date: 2007/8/7

function main(itemID)

    local n = GetPlayerType()
    if (n == 0) then
        Say("H·y chän 1 ®å phæ trang bÞ cam cÊp 3 mµ b¹n thÝch:", 3, "Ph¸ Qu©n*Tr¶m Long Kh«i/pojuntou", "Ph¸ Qu©n*Tr¶m Long Phi Phong/pojunling", "Hñy bá/no")
    elseif (n == 1) then
        Say("H·y chän 1 ®å phæ trang bÞ cam cÊp 3 mµ b¹n thÝch:", 3, "Ph¸ Qu©n*Nguyªn Thuû Qu¸n/pojuntou", "Ph¸ Qu©n*Nguyªn Thuû LÖnh/pojunling", "Hñy bá/no")
    else
        Say("H·y chän 1 ®å phæ trang bÞ cam cÊp 3 mµ b¹n thÝch:", 3, "Ph¸ Qu©n*ThÇn ¦ng Gi¸p/pojuntou", "Ph¸ Qu©n*ThÇn ¦ng KÕt/pojunling", "Hñy bá/no")
    end
end;

function pojuntou()
    if (HaveNormalItem(6, 1, 298, 0) >= 1) then
        if (GetPlayerType() == 0) then
            AddNormalItem(6, 1, 278, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng  ®å phæ trang bÞ cam cÊp 3  Ph¸ Qu©n*Tr¶m Long Kh«i.")
            TopMessage("B¹n nhËn ®­îc <c=g>®å phæ Ph¸ Qu©n*Tr¶m Long Kh«i<c>")
        elseif (GetPlayerType() == 1) then
            AddNormalItem(6, 1, 279, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng  ®å phæ trang bÞ cam cÊp 3  Ph¸ Qu©n*Nguyªn Thñy Qu¸n.")
            TopMessage("B¹n nhËn ®­îc <c=g>®å phæ Ph¸ Qu©n*Nguyªn Thñy Qu¸n<c>")
        else
            AddNormalItem(6, 1, 280, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng  ®å phæ trang bÞ cam cÊp 3  Ph¸ Qu©n*ThÇn ¦ng Trô.")
            TopMessage("B¹n nhËn ®­îc <c=g>®å phæ Ph¸ Qu©n*ThÇn ¦ng Trô<c>")
        end
        DelNormalItem(6, 1, 298, 0)
        CloseDialog()
    end
end

function pojunling()
    if (HaveNormalItem(6, 1, 298, 0) >= 1) then
        if (GetPlayerType() == 0) then
            AddNormalItem(6, 1, 287, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng ®å phæ trang bÞ cam cÊp 3 Ph¸ Qu©n*Tr¶m Long Phi Phong")
            TopMessage("B¹n nhËn ®­îc <c=g>®å phæ Ph¸ Qu©n*Tr¶m Long Phi Phong<c>")
        elseif (GetPlayerType() == 1) then
            AddNormalItem(6, 1, 288, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng  ®å phæ trang bÞ cam cÊp 3 Ph¸ Qu©n*Nguyªn Thñy LÖnh")
            TopMessage("B¹n nhËn ®­îc <c=g>Ph¸ Qu©n*Nguyªn Thñy LÖnh<c>")
        else
            AddNormalItem(6, 1, 289, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng Ph¸ Qu©n*ThÇn ¦ng KÕt")
            TopMessage("B¹n nhËn ®­îc <c=g>Ph¸ Qu©n*ThÇn ¦ng KÕt<c>")
        end
        DelNormalItem(6, 1, 298, 0)
        CloseDialog()
    end
end

function no()
    CloseDialog()
end;

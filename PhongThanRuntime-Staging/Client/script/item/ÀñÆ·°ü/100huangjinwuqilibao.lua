--description: 100»Æ½ðÎäÆ÷Àñ°ü (°ó¶¨)
--author: yaoxin
--date: 2007/8/7

function main(itemID)

    local n = GetPlayerType()
    if (n == 0) then
        Say("H·y chän 1 vò khÝ mµ b¹n thÝch:", 3, "Tr¹m Kim phñ/changj1", "Viªm §Õ kiÕm/duanj1", "Hñy bá/no")
    elseif (n == 1) then
        AddNormalItem(0, 0, 29, 10, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th¸i Cùc KiÕm")
        TopMessage("NhËn ®­îc <c=g>Th¸i Cùc KiÕm<c>")
        DelNormalItem(6, 1, 296, 0)
        CloseDialog()
    else
        AddNormalItem(0, 0, 30, 10, 0, 0)
        Msg2Player("B¹n nhËn ®­îc DiÖt ThÇn phñ")
        TopMessage("B¹n nhËn ®­îc<c=g> DiÖt ThÇn phñ<c>")
        DelNormalItem(6, 1, 296, 0)
        CloseDialog()
    end

end;

function changj1()
    AddNormalItem(0, 0, 28, 10, 0, 0)
    Msg2Player("B¹n nhËn ®­îc Tr¹m Kim Phñ")
    TopMessage("NhËn ®­îc <c=g>Tr¹m Kim Phñ<c>")
    DelNormalItem(6, 1, 296, 0)
    CloseDialog()
end

function duanj1()
    AddNormalItem(0, 0, 27, 10, 0, 0)
    Msg2Player("B¹n nhËn ®­îc Viªm §Õ kiÕm")
    TopMessage("NhËn ®­îc <c=g>Viªm §Õ kiÕm<c>")
    DelNormalItem(6, 1, 296, 0)
    CloseDialog()
end

function no()
    CloseDialog()
end;

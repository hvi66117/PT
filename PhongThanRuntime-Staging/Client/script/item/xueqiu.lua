function main(sel)
    if (HaveIBBuff(408) > 0) or (HaveIBBuff(409) > 0) then
        Talk(1, "no", "B¹n ®· ch¹m ph¶i TuyÕt CÇu, t¹m thêi kh«ng thÓ bá nã!")
    else
        AddIBBuff(408)

        DelNormalItem(6, 1, 331, 0)
        TopMessage("B¹n ®· ch¹m ph¶i <c=g>TuyÕt CÇu<c>! Chóc vui vÎ!")
        Msg2Player("B¹n ®· ch¹m ph¶i TuyÕt CÇu! H·y kiªn nhÉn! B¹n sÏ nhËn ®­îc ®iÒu bÊt ngê!")
    end ;
end

function no()
    CloseDialog()
end;

function main()
    if (HaveNormalItem(6, 1, 402, 0) > 0) then
        AddNormalItem(6, 1, 403, 0, 0, 0)
        Earn(2000000)
        TopMessage("B¹n nhËn ®­îc <c=g>200 v¹n l­îng<c> vµ <c=g>ngo¹i trang sñi c¶o<c>")
        Msg2Player("B¹n nhËn ®­îc 200 v¹n l­îng vµ ngo¹i trang sñi c¶o")
        WriteLog("Tõ Cùu Nghinh T©n")
        DelNormalItem(6, 1, 402, 0)
    else
        WriteLog("Tõ Cùu Nghinh T©n (hñy)")
    end
end

function main()
    CloseDialog()
    if (GetPlayerType() == 0) then
        AddNormalItem(0, 10, 21, 6, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc <c=g>V« Cùc Phi TuyÕt XÝch DiÖm Kú L©n<c>!")
        TopMessage(13442)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 10, 22, 6, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc <c=g>V« Cùc Phi TuyÕt øng Long<c>!")
        TopMessage(13443)
    else
        AddNormalItem(0, 10, 23, 6, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc <c=g>V« Cùc Phi TuyÕt Xuyªn V©n Hå §iÖp<c>!")
        TopMessage(13444)
    end
end;

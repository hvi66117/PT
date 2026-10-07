function main(nLevel, nTime, nTNpcIdx, itemID)
    local i = math.random(1, 100)
    DelItemByID(itemID)

    if i <= 5 then
        for i = 1, 2 do
            AddNormalItemBind(3, 138, 0, 0, 0, 0, 1)
        end
        TopMessage("B¹n nhËn ®­îc 2 <c=yel>ThiÖp Nh­ ı<c>")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ´ò¿ªÌìÌÃÀñºĞÊ±»ñµÃ 2 c¸i <c=yel>ÈçÒâ¾í<c>")
    elseif i > 5 and i <= 35 then
        PlayerCastSkill(1, 212, 1)
        TopMessage("B¹n nhËn ®­îc <c=yel>Hoa Hång<c>")
    elseif i > 35 and i <= 45 then
        AddNormalItemBind(8, 381, 3, 0, 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=yel>Thanh Lé (Nh­ ı)<c>")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ´ò¿ªÌìÌÃÀñºĞÊ±»ñµÃ 1 c¸i <c=yel>ÈçÒâÉúÃüÇåÂ¶<c>")
    elseif i > 45 and i <= 55 then
        AddNormalItemBind(8, 382, 4, 0, 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=yel>Ch©n Khİ (Nh­ ı)<c>")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ´ò¿ªÌìÌÃÀñºĞÊ±»ñµÃ 1 c¸i <c=yel>ÈçÒâNhËt NguyÖt Ch©n Khİ<c>")
    elseif i > 55 and i <= 75 then
        AddNormalItemBind(8, 28, 3, 0, 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=yel>Thanh Lé (tiÓu)<c>")
    elseif i > 75 and i <= 95 then
        AddNormalItemBind(8, 29, 4, 0, 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=yel>Ch©n Khİ (tiÓu)<c>")
    else
        EarnBind(400000)
        TopMessage("B¹n nhËn ®­îc <c=yel>40 v¹n b¹c khãa<c>")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ´ò¿ªÌìÌÃÀñºĞÊ±»ñµÃ<c=yel>40 v¹n b¹c khãa<c>")
    end
end

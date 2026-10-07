--description: ÖÁ×ðÉñÐÐ¿¨
--author: lilingxu
--date: 2006/4/19
--modify: lilingxu

function main(itemid)

    AddNormalItemPile(8, 35, 2, 0, 0, 1)
    AddNormalItemPile(8, 258, 2, 0, 0, 1)
    AddNormalItemPile(8, 197, 2, 0, 0, 1)
    for i = 1, 50 do
        AddNormalItemPile(5, 0, 0, 1, 0, 0)
    end
    Msg2Player("B¹n nhËn ®­îc Di Ngo¹i phï, Bµo th­¬ng håi thµnh phï, Quy Hån Ch©u, Håi thµnh phï!")

    DelNormalItem(6, 1, 264, 0)
    CloseDialog()

end;

function no()
    CloseDialog()
end;

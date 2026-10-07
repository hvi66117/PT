--description: ³ÇÃÅ
--author: yichuan
--date: 2004/6/10

function  main(itemID)
	CostIBItem(itemID)
		for i=1,100 do
		AddNormalItemPile(3,6,0,0,0,0)
	end
	Msg2Player("B¹n nhËn ®­îc 100 ®ång thau.")
	CloseDialog()
end;

function  no()
	CloseDialog()
end;
--description: Áé·ûÓ¦Ç©
--author: liuying	
--date: 2006/7/12

function main(itemID)
	local i=random(1,5)
	if(i==1)then
		AddNormalItem(3,63,0,0,0,0)
		Talk(1,"no","Chóc mõng b¹n nhËn ®­îc 1  Thñy Linh Phï!")
	else
		AddNormalItem(3,64,0,0,0,0)
		Talk(1,"no","Chóc mõng b¹n nhËn ®­îc 1 Háa Linh Phï!")
	end
	CostIBItem(itemID)
end;

function no()
	CloseDialog()
end
--description: PolyMorph
--author: yichuan
--date: 2004/11/18

function  main(itemID)
		if ( GetMorphType()==364) or( GetMorphType()==19)or( GetMorphType()==420)or( GetMorphType()==419)then
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
		else	
				PolyMorph(19,1,0,-1,1800)
				CostIBItem(itemID)
		end;
		CloseDialog()
end;

function  no()
		CloseDialog()
end;

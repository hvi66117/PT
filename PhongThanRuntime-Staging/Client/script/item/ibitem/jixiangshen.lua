--description: PolyMorph-¼ªÏéÉñ
--author: liuying	
--date: 2006/3/23

function  main(itemID)
	local  w,x,y = GetWorldPos()
	SetExeState(0)
	if (w==71) then
		Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	--elseif (IsInWar()==1) then
	--	TopMessage("¹úÕ½µØÍ¼²»¿ÉÒÔÊ¹ÓÃ±äÉí·û")
	elseif (w==73) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	elseif (w==74) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	elseif (w==75) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	elseif (w==76) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	elseif (w==77) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	elseif (w==78) then
		TopMessage("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	else
		zhuzhu()
	end;
end;

function  zhuzhu()
		if ( GetMorphType()==364)then
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
		else
			local i=FindAValidIBItem(8,48,2,0)
			if(i~=0)then
				PolyMorph(411,0,2,10,3600)
				CloseDialog()
				CostIBItem(i)
				AddNormalItem(6,1,175,0,1,0)		--¸øÍæ¼Ò¿ÉÒÔ±ä»ØÔ­ÑùµÄ¿ÉÄÜ
			else
				Talk(1,"no","Xin x¸c nhËn b¹n cã vËt phÈm nµy vµ vÉn cßn hiÖu lùc!")
			end;
		end;
end;

function   no()
		CloseDialog()
end;

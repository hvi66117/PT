--GetIBItemGenTime(itemID)

function main(itemID)
	local  w,x,y = GetWorldPos()
	local t=GetIBItemGenTime(itemID)
	if (w==71) then
		Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
	else
		if(GetSex()==0)then
			Y1,M1,D1 = Time2LocalYMD(t+2592000) --30ÈÕ
			Y2,M2,D2 = GetYMD()
			local morphtype = GetMorphType()
			if ( morphtype==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
					Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
			elseif(morphtype==454)then
				MsgBox("Th¸i V©n Trang nµy dïng ®Õn "..Y1.."N¨m"..M1.."Th¸ng"..D1..".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?","yes1","no")
			else
				if(floor((SystemTime()-t)/86400)>=30)then
					CostIBItem(itemID)
					Talk(1,"no","Háa L«i Trang cña b¹n ®· qu¸ h¹n, mÊt ®i linh lùc!")
				else
					MsgBox("Th¸i V©n Trang nµy dïng ®Õn "..Y1.."N¨m"..M1.."Th¸ng"..D1..".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?","yes2","no")
				end
			end
		else
			Talk(1,"no","§©y lµ mét bé nam trang, b¹n kh«ng thÓ sö dông.")
		end
	end
	SetExeState(0)
end

function yes1()
	PolyMorph(-1,0,0,0,0)
	CloseDialog()
end

function yes2()
	local i=FindAValidIBItem(8,47,2,0)
	if(i~=0)then
		PolyMorph(454,1,0,-1,43200)
		CloseDialog()
	else
		Talk(1,"no","Xin x¸c nhËn b¹n cã vËt phÈm nµy vµ vÉn cßn hiÖu lùc!")
	end;
end

function no()
	CloseDialog()
end

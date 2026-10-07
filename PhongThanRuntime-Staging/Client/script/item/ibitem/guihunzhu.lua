--description: ¹é»êÖé£­»Øµ½ÉÏ´ÎËÀÍöµØµã
--author: liuying	
--date: 2006/£·/£²£´

function main(itemID)
	SetExeState(0)
	if(GetFightState()==0)then
		local m,x,y=GetTask(834),GetTask(835),GetTask(836)
		if(m>=100)then
			m=0
		end
		if(m==0)then
			Talk(1,"no","B¹n ch­a ghi nhí ®iÓm tö vong.")
		else
			if(IsPlayerInsideWeapon(PlayerIndex)<=0)and(GetMorphType()~=364)then
				local con=mark_judge()
				if(con==0)then
					Talk(1,"no","§Þa ®iÓm tö vong lÇn tr­íc cña b¹n bÞ mét mµng ch¾n kú qu¸i ng¨n c¸ch, Quy Hån Ch©u kh«ng thÓ ®Õn ®­îc ®Þa ®iÓm nµy!")
				else
					ExactNewWorld(m,x,y)
					SetTask(834,0)
					SetTask(835,0)
					SetTask(836,0)
					SetFightState(1)
					CostIBItem(itemID)
				end;
			else
				Talk(1,"no","Khi chuyÓn tiªu, giao dÞch, ngåi thuyÒn kh«ng thÓ sö dông Quy Hån Ch©u!")
			end;
		end
	else
		Talk(1,"no","Quy Hån Ch©u chØ sö dông ®­îc trong trang th¸i phi chiÕn ®Êu!")
	end
end;

function mark_judge()		--¤£¯à¨ì¹Fªº¦a¤è
	local mapid,x,y=GetTask(834),GetTask(835),GetTask(836)
	if(mapid>=60)and(mapid<=61)then
		return 0
	elseif(mapid>=66)and(mapid<=72)then
		return 0
	elseif(mapid>=53)and(mapid<=56)then
		return 0
	elseif(mapid>=97)and(mapid<=98)then			
		return 0
	elseif(mapid>99)then
		return 0
	else
		return 1
	end
end

function no()
	CloseDialog()
end


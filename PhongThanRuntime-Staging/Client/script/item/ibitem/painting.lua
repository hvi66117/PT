--°ÚÌ¯Í·¶¥±äÉ«
--GetIBItemGenTime(itemID)

function main(itemID)
	local color=GetTask(428)
	local sel
	if(GetTask(429)>=1)then	-- 429 ªí¥ÜÅu¦ìµ¥¯Å
		CostIBItem(itemID)
		local r = random(1,100)
		if(color==1)then
			sel = 2
		else
			sel = 1
		end
		if(r <= 10) then
			if(color==2)then
				sel = 3
			else
				sel = 2
			end
		elseif (r <= 30) then
			if(color==3)then
				sel = 4
			else
				sel = 3
			end
		elseif (r <= 60) then
			if(color==4)then
				sel = 1
			else
				sel = 4
			end
		end;
		SetTask(428, sel)
		Talk(1,"no","Chiªu bµi cña b¹n ®· thay ®æi.")
	else
		Talk(1,"no","ChØ cã ®¼ng cÊp b¸n hµng tõ 2 trë lªn míi cã thÓ ®æi mµu s¾c. ")
	end
	SetExeState(0)
end


function no()
	CloseDialog()
end

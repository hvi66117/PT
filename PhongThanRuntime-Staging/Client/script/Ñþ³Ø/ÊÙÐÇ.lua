--description: ÊÙÐÇ
--author: yichuan
--date: 2004/6/10

function main(sel)
	--tasks = {
	--		{"ÁÊ¶RÃdª«","buy";show=1},
	--		{"Ãdª«©ñ¥Í","seal";show=1}
	--	}
	Talk(1,"no",11239)
	--SayTask("¹Ø¬P¡GÆFÃ~ÅX¨Ï¡A¥»¬°¤Ñ¬É¤£¶Ç¤§±K.²{«Ê¯«­°¥@¡A¤Ñ¬É§Ä§Ä¡A¥É«Ò¤j³jÆFÃ~©ó¤H¶¡¡A§A¥iÄ@¥Î¹Ð¥@¤§°]´I¡A´«¨ú¤Ñ¬É°ª¶QªºÆFÃ~§_¡H",tasks)
end;

--Âò³èÎï
function buy()
	SaleEx(22)
	CloseDialog()
end

function seal()
	local petType = GetPetType()
	if(petType~=0)then -- ¿¼ÂÇÖÒ³Ï¶ÈÐèÒªÓÐ¸öÏÂÏÞ
		MsgBox("Ng­¬i thËt sù muèn phãng sinh nã chø?","seal_yes","no")
	else
		MsgBox("Ng­¬i kh«ng cã linh thó µ?","no")
	end
end

function seal_yes()
	local petType = GetPetType()
	if(petType~=0)then -- ¿¼ÂÇÖÒ³Ï¶ÈÐèÒªÓÐ¸öÏÂÏÞ
		if(DelNormalItem(6,1,145,0)~=0)then
			DelPet()
			MsgBox("Ta ®· thu håi l¹i sñng vËt cña ng­¬i","no")
		else
			MsgBox("Ng­¬i ph¶i ®em <color=green>Phôc Ma Linh<color> tr¶ l¹i.","no")
		end
	else
		MsgBox("Ng­¬i kh«ng cã linh thó µ?","no")
	end
end


function no()
	CloseDialog()
end;


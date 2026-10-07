--description:npc
--author: zhujialiang
--date:2005/4/13

function main()
	local tasks = {
		{"Rêi m¹ng luyÖn ®¬n","liandan";show=0},
		{"NhËn ®¬n d­îc","lingqu";show=0},
		{"B¾t ®Çu tu luyÖn","doublexp";show=0},
		{"Ng­ng tu luyÖn","tingzhi";show=0}
	}
	if(GetPlayerType()==1)then
		tasks[1].show=1;
	end;

	if((GetNewPills()>0)and(GetPlayerType()==1))then
		tasks[2].show=1;
	end;

	local state = GetPillsState();
	if(GetPlayerType()==1)then
		if(state==2)then
			tasks[4].show=1;
			tasks[3].show=0;
		else
			tasks[4].show=0;
			tasks[3].show=1;
		end;
	end;

	SayTask(10674,tasks)
end;

function no()
	CloseDialog()
end;

--ÀëÏßÁ¶µ¤
function liandan()
	if(GetNewPills()==12)then
		if(GetPillsCount()<84)then
			MsgBox(11429,"no")
		else
			MsgBox(11430,"no")
		end;
	else
		StartMakePills()
		if(GetCanMakePills()>0)then
			MsgBox(10675,"no")
			--ÉèÖÃÖ±½Óµ÷ÓÃalt+q
		else
			Talk(2,"no",10676,10677)			
		end;
	end;
end;

--ÁìÈ¡µ¤Ò©
function lingqu()
	local cantake = (84 - GetPillsCount())-GetNewPills();
	local take = 0
	local leave = 0
	local ndmoney=0
	if(GetPillsCount()==84)then
		MsgBox(10678,"no")
		return
	end;
	if(cantake>=0) then
		take=GetNewPills()
		leave=0
	else
		take=(84 - GetPillsCount())
		leave=GetNewPills()-(84 - GetPillsCount());
	end;
	ndmoney=10*GetLevel()*take
	if(GetCash()>=ndmoney)then
			Pay(ndmoney)
			GetAllPills();
			MsgBox("§©y lµ <color=red>"..take.."<color> viªn ®¬n d­îc, cßn d­ <color=red>"..leave.."<color> viªn, tæng céng ng­¬i ®· tèn <color=red>"..ndmoney.."<color>.","no")
	else
			MsgBox("Muèn lÊy linh d­îc cÇn tèn İt tiÒn, cÇn ph¶i tr¶ <color=red>"..ndmoney.."<color> l­îng, ng­¬i ch­a ®ñ tiÒn!","no")
	end;
end;

--¿ªÊ¼ĞŞÁ¶
function kaishi()
	if(GetPillsCount()>0) then
		if(HaveNormalItem(3,81,0,0)>=1)then
			MsgBox(10679,"shiyong","no")
		else
			StartUsePills(50)
			MsgBox(10680,"no")
		end;
	else
		if(GetNewPills()>0)then
			MsgBox(10681,"lingqu","no")
		else
			MsgBox(10682,"no")	
		end;
	end;
end;

--Í£Ö¹ĞŞÁ¶
function tingzhi()
	StopUsePills()
	MsgBox(10683,"no")
end;

function shiyong()
	if(HaveNormalItem(3,81,0,0)>=1)then
		DelNormalItem(3,81,0,0)
		StartUsePills(75)
		MsgBox(10684,"no")
	else
		MsgBox(10685,"no")	
	end;
end;

--ÅĞ¶ÏÊÇ·ñ´¦ÓÚË«±¶¾­ÑéÊ±¼äÄÚ
function doublexp()
	local time=SystemTime()-GetTask(379)      --È¡Ë«±¶¾­ÑéÊ±¼äÊ£ÓàÖµ
	if(time<7200) then
		MsgBox(11400,"no")
	else
		kaishi()
	end;
end;

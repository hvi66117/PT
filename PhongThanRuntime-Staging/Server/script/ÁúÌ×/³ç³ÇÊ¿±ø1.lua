--description:³ç³ÇÊ¿±ø
--author: yichuan
--date:2004/7/26

function main()
	local tasks = {
		{"Rêi m¹ng luyÖn ®¬n","liandan";show=0},
		{"NhËn ®¬n d­îc","lingqu";show=0},
		{"B¾t ®Çu tu luyÖn","kaishi";show=0},
		{"Ng­ng tu luyÖn","tingzhi";show=0}
	}
	if(GetPlayerType()==0)then
		tasks[1].show=1;
	end;

	if((GetNewPills()>0)and(GetPlayerType()==0))then
		tasks[2].show=1;
	end;

	local state = GetPillsState();
	if(GetPlayerType()==0)then
		if(state==2)then
			tasks[4].show=1;
			tasks[3].show=0;
		else
			tasks[4].show=0;
			tasks[3].show=1;
		end;
	end;

	SayTask(10337,tasks)
end;

function no()
	CloseDialog()
end;

--ÀëÏßÁ¶µ¤
function liandan()
	StartMakePills()
	MsgBox("Ng­¬i ®· cã thÓ b¾t ®Çu luyÖn ®¬n nh­ng ph¶i rêi m¹ng míi cã hiÖu nghiÖm! H·y yªn t©m rêi m¹ng!","no")
	--ÉèÖÃÖ±½Óµ÷ÓÃalt+q
end;

--ÁìÈ¡µ¤Ò©
function lingqu()
	local cantake = (84 - GetPillsCount())-GetNewPills();
	local take = 0
	local leave = 0
	local ndmoney=0
	if(GetPillsCount()==84)then
		MsgBox("§¬n d­îc cña ng­¬i cßn nhiÒu, sö dông bít mét Ýt råi quay l¹i!","no")
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
			MsgBox("NhËn sè linh ®¬n nµy cÇn tr¶ <color=red>"..ndmoney.."<color> l­îng, ng­¬i ch­a ®ñ tiÒn!","no")
	end;
end;

--¿ªÊ¼ÐÞÁ¶
function kaishi()
	if(GetPillsCount()>0) then
		if(HaveNormalItem(3,81,0,0)>=1)then
			MsgBox("NÕu dïng <color=red>qu¶ nh©n s©m<color> chung víi tiªn ®¬n th× hiÖu qu¶ tu luyÖn sÏ cµng cao h¬n. Muèn thö kh«ng?","shiyong","no")
		else
			StartUsePills(50)
			MsgBox("Lo¹i ®¬n d­îc nµy sÏ gióp ng­¬i nhËn thªm ®­îc <color=red>1.5<color> lÇn ®iÓm kinh nghiÖm.","no")
		end;
	else
		if(GetNewPills()>0)then
			MsgBox("Ng­¬i cã göi ta mét Ýt ®¬n d­îc. Muèn lÊy l¹i kh«ng?","lingqu","no")
		else
			MsgBox("Ng­¬i kh«ng cã ®¬n d­îc ®Ó sö dông!","no")	
		end;
	end;
end;

--Í£Ö¹ÐÞÁ¶
function tingzhi()
	StopUsePills()
	MsgBox("Tr¶i qua ®ît tu luyÖn võa råi c¶m thÊy n¨ng lùc tiÕn mét bËc ph¶i kh«ng? H·y cè g¾ng lªn!","no")
end;

function shiyong()
	if(HaveNormalItem(3,81,0,0)>=1)then
		DelNormalItem(3,81,0,0)
		StartUsePills(75)
		MsgBox("Lo¹i ®¬n d­îc nµy sÏ gióp ng­¬i nhËn thªm ®­îc <color=red>1.75<color> lÇn ®iÓm kinh nghiÖm.","no")
	else
		MsgBox("Xin lçi! Ng­¬i kh«ng ®em theo qu¶ nh©n s©m, khi nµo cã h·y quay l¹i.","no")	
	end;
end;



--description: 
--author: yichuan
--date: 2004/6/10

function main()
	local tasks = 
		{
			{"§æi Hång bao","duihuan";show=0},
			{"Mua biÕn th©n phï","renwu1";show=0},
			{"Mua hång bao","renwu2";show=0},
			{"NhËn hång bao","renwu";show=0}
		}
	if((IsMarried()==1)and(HaveEventItem(50)==0)and(GetTeamSize()==2))then
		tasks[2].show=1;
--		tasks[3].show=1;
	end;
	if((IsMarried()==1)and(HaveEventItem(50)==1)and(GetSex()==0))then
		tasks[4].show=1;
	end;
	if(IsMarried()==1) then
		tasks[1].show=1
	end
	SayTask(10654,tasks)
end;

function duihuan()
	local tasks = 
		{
			{"§æi 1 ","one";show=1},
			{"§æi 3 ","three";show=1}
		}
	SayTask("ChØ cÇn ®· kÕt h«n ®Òu cã thÓ dïng LÔ Hoa ®æi Hång bao. 1 LÔ Hoa ®æi 1 Hång bao. §ång ý chø#¿",tasks)
end

function one()
	if (IsMarried()==1) then
		if (HaveNormalItem(6,0,20,1)>0) then
			DelNormalItem(6,0,20,1)
			AddNormalItem(6,1,102,1,0,0)
			MsgBox("Xin nhËn Hång bao! Chóc hai ng­¬i m·i m·i h¹nh phóc. ","no")
		else
			MsgBox("Ph¶i cã LÔ Hoa míi cã thÓ ®æi Hång bao.","no")
		end
	else	
		if (GetSex()==0) then
			MsgBox("ChØ cÇn ®· kÕt h«n ®Òu cã thÓ dïng LÔ Hoa ®æi Hång bao. 1 LÔ Hoa ®æi 1 Hång bao!","no")
		else
			MsgBox("ChØ cÇn ®· kÕt h«n ®Òu cã thÓ dïng LÔ Hoa ®æi Hång bao. 1 LÔ Hoa ®æi 1 Hång bao!","no")
		end
	end

end

function three()
	if (IsMarried()==1) then
		if (HaveNormalItem(6,0,20,1)>=3) then
			DelNormalItem(6,0,20,1)
			DelNormalItem(6,0,20,1)
			DelNormalItem(6,0,20,1)
			AddNormalItem(6,1,102,1,0,0)
			AddNormalItem(6,1,102,1,0,0)
			AddNormalItem(6,1,102,1,0,0)
			MsgBox("Xin nhËn Hång bao! Chóc hai ng­¬i m·i m·i h¹nh phóc. ","no")
		else
			MsgBox("Ph¶i cã 3 LÔ Hoa míi ®æi ®­îc 3 Hång bao. ","no")
		end
	else	
		if (GetSex()==0) then
			MsgBox("ChØ cÇn ®· kÕt h«n ®Òu cã thÓ dïng LÔ Hoa ®æi Hång bao. 1 LÔ Hoa ®æi 1 Hång bao!","no")
		else
			MsgBox("ChØ cÇn ®· kÕt h«n ®Òu cã thÓ dïng LÔ Hoa ®æi Hång bao. 1 LÔ Hoa ®æi 1 Hång bao!","no")
		end
	end

end



function renwu()
	if ((GetTeamSize()==2)and(GetMateNameID()==GetTask(801))and(GetSex()==0)) then
		if(HaveEventItem(50)==1)then
			for i=1,10 do
				AddNormalItem(6,1,102,39,1,1)
			end;
			DelEventItem(50)
			local i=PlayerIndex
			local n=0
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			for i=1,10 do
				AddNormalItem(6,1,102,39,1,1)
			end;
			local name=GetName()
			PlayerIndex=i
			Talk(1,"no",10655)
			AddGlobalCountNews("Ngµy lµnh th¸ng tèt, T©n lang <color=green>"..GetName().."<color> vµ t©n n­¬ng <color=green>"..name.."<color> ®ang cö hµnh h«n lÔ, mäi ng­êi h·y cÇu chóc cho hä tr¨m n¨m h¹nh phóc!",20)
			CloseDialog()
		else
			MsgBox(10656,"no")
		end;
	else
		MsgBox(10657,"no")	
	end;
end;

function no()
		CloseDialog()
end;

--function renwu2()
--	if(GetCash()>=100000)then
--		Pay(100000)
--		for i=1,10 do
--			AddNormalItem(6,1,102,39,1,1)
--		end;
--		MsgBox(10658,"no")
--	else
--		MsgBox(10659,"no")
--	end;
--end;


function renwu1()
	MsgBox(10660,"yes_m","no")
end;

function yes_m()
	if(GetCash()>=100000)then
		Pay(100000)
		AddNormalItem(6,1,100,39,1,1)
		AddNormalItem(6,1,99,39,1,1)	
		MsgBox(10661,"no")
	else
		MsgBox(10659,"no")
	end;
end;




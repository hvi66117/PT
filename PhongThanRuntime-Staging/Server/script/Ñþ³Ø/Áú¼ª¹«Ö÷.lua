--description: Áú¼ª¹«Ö÷
--author: yichuan
--date: 2004/6/10

function main(sel)
			tasks =
			{
				 {"NhËp hån","renwu2";show=0}
			}
			if(GetLevel()>=49)then
					tasks[1].show=1
			end;
	SayTask(10502,tasks)
end;

function no()
		CloseDialog()
end;

function  renwu2()
		Say(10503,9,"NhËp vµo Tinh Cang Kh«i/tk1","NhËp vµo Tinh Cang Yªu §¸i/yd1","NhËp vµo Tinh Cang ChiÕn Ngoa/kj1","NhËp vµo Th¸i Êt Quan/tk2","NhËp vµo Th¸i Êt C©n/yd2","NhËp vµo Th¸i Êt Lý/kj2","NhËp vµo Gi¸c thó Trô/tk3","NhËp vµo Gi¸c thó Yªu §¸i/yd3","NhËp vµo Gi¸c thó Ngoa/kj3")
end;

function  tk1()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,7,0,6)>=1)and(HaveEventItem(39)==1)then
					for  i=1,15 do
						DelNormalItem(3,22,0,0)
						DelNormalItem(3,23,0,0)
						DelNormalItem(3,24,0,0)
						DelNormalItem(3,25,0,0)
					end;
					DelNormalItem(0,7,0,6)
					DelEventItem(39)
					local i=random(1,100000)
					local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
					local PlayerLevel=GetLevel()
					if (PlayerLevel>90) then
						PlayerLevel=90
					end
					if (i<=1500)then
						Talk(1,"no",10505)
						local n=random(10,13)
						AddNormalItem(0,4,n,1,0,0)
					elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
						 greentk1()
					elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
						 greentk1()
					elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
						 greentk1()
					elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
						 greentk1()
					else
						Talk(1,"no",10506)
						AddOwnExp(5000)
					end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greentk1()
	AddNormalItem2(0,7,3,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Tinh Cang Kh«i)",20)
end


function  tk2()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,7,1,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,7,1,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greentk2()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greentk2()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greentk2()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greentk2()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greentk2()
	AddNormalItem2(0,7,4,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Th¸i Êt Quan)",20)
end

function  tk3()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,7,2,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,7,2,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greentk3()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greentk3()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greentk3()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greentk3()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
			Talk(1,"no",10507)
	end;
end;

function  greentk3()
	AddNormalItem2(0,7,5,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Gi¸c Thó Trô)",20)
end


function  yd1()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,6,0,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,6,0,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenyd1()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenyd1()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenyd1()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenyd1()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greenyd1()
	AddNormalItem2(0,6,3,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Tinh Cang Yªu §¸i)",20)
end



function  yd2()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,6,1,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,6,1,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenyd2()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenyd2()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenyd2()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenyd2()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greenyd2()
	AddNormalItem2(0,6,4,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Th¸i Êt C©n)",20)
end

function  yd3()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,6,2,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,6,2,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenyd3()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenyd3()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenyd3()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenyd3()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greenyd3()
	AddNormalItem2(0,6,5,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Gi¸c Thó Yªu §¸i)",20)
end

function  kj1()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,5,0,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,5,0,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenkj1()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenkj1()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenkj1()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenkj1()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
			Talk(1,"no",10507)
	end;
end;

function  greenkj1()
	AddNormalItem2(0,5,3,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Tinh Cang ChiÕn Ngoa)",20)
end


function  kj2()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,5,1,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,5,1,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenkj2()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenkj2()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenkj2()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenkj2()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greenkj2()
	AddNormalItem2(0,5,4,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Th¸i Êt Lý)",20)
end

function  kj3()
	if(HaveNormalItem(3,22,0,0)>=15)and(HaveNormalItem(3,23,0,0)>=15)and(HaveNormalItem(3,24,0,0)>=15)and(HaveNormalItem(3,25,0,0)>=15)and(HaveNormalItem(0,5,2,6)>=1)and(HaveEventItem(39)==1)then
			for  i=1,15 do
				DelNormalItem(3,22,0,0)
				DelNormalItem(3,23,0,0)
				DelNormalItem(3,24,0,0)
				DelNormalItem(3,25,0,0)
			end;
			DelNormalItem(0,5,2,6)
			DelEventItem(39)
			local i=random(1,100000)
			local green60=GetTask(812)--°O¿ý60¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
			local PlayerLevel=GetLevel()
			if (PlayerLevel>90) then
				PlayerLevel=90
			end
			if (i<=1500)then
				Talk(1,"no",10505)
				local n=random(10,13)
				AddNormalItem(0,4,n,1,0,0)
			elseif (i>1500) and (i<=4500) and (green60==0) and (PlayerLevel<=70) then
				 greenkj3()
			elseif (i>4500) and (i<=5000) and (green60>=1) and (green60<=2) and (PlayerLevel<=70) then
				 greenkj3()
			elseif (i>5000) and (i<=5300) and (green60>=3)  and (PlayerLevel<=70) then
				 greenkj3()
			elseif (i>5300) and (i<=5500-PlayerLevel*PlayerLevel*17/810) and  (PlayerLevel>70)  then
				 greenkj3()
			else
				Talk(1,"no",10506)
				AddOwnExp(5000)
			end;
	else
					Talk(1,"no",10507)
	end;
end;

function  greenkj3()
	AddNormalItem2(0,5,5,6,1,0)
	SetTask(812,GetTask(812)+1)
	Talk(1,"no",10504)
	l=GetName()
	AddGlobalCountNews("Long C¸t c«ng chóa ®· truyÒn ph¸p lùc cho <color=green>"..l.."<color> (vµo Gi¸c Thó Ngoa)",20)
end
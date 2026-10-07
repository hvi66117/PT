--description: º¯Ö¥ÏÉ×Ó
--author: yichuan
--date: 2004/6/10

function main()
	tasks=
	{
		{"§¹o cô","renwu1";show=0},
		{"Tin tøc","renwu2";show=0},
		{"Chóc phóc","renwu3";show=1},
		{"KÕt h«n chóc phóc","renwu4";show=1}
		--{"ÉñÃØ?Ó°","renwu4";show=0}
	}
	--if(GetLevel()<=83)and(GetCredit()<=1003)then
	--				tasks[4].show=1
	--end;
	--if(GetTask(318)==2)and(HaveNormalItem(6,1,22,1))then
	--				tasks[4].show=1
	--end;
	SayTask(11270,tasks)
end;

function no()
		CloseDialog()
end;
------------------------------------------------------------------------------------------------------------
function  renwu1()
		local  renwu=GetTask(310)
		local  thistime=GetTask(311)
		local  cishu=GetTask(313)
		local thisday=floor(SystemTime()/86400)
		if(renwu>0)then
					tasks1 = 
					{
						{"Cung cÊp","wancheng";show=1},
						{"Hñy bá","esc";show=1}
					}
				SayTask(11271,tasks1)
		elseif(thisday<thistime)then					
				Talk(1,"no",11272)
		else
				MsgBox(11273,"check_1","no")
		end;
end;

function   check_1()	
		local  renwu=GetTask(310)
		local  thistime=GetTask(311)
		local  cishu=GetTask(313)
		local thisday=floor(SystemTime()/86400)
		if(cishu>=10)then
				if(thisday>thistime)then
						SetTask(310,0)
						SetTask(311,thisday)
						SetTask(312,0)
						SetTask(313,0)
						Talk(1,"no",11274)
				else
						SetTask(310,0)
						SetTask(311,thisday+1)
						SetTask(312,0)
						SetTask(313,0)
						Talk(1,"no",11275)
				end;
		else
				if(GetLevel()<=30)then
								local  i=random(1,620)
								if(i<=80)then
										Talk(1,"no",11276)
										SetTask(310,1)
										TaskNote(32,0)
								elseif(i<=160)then
										Talk(1,"no",11277)
										SetTask(310,2)
										TaskNote(32,1)
								elseif(i<=240)then
										Talk(1,"no",11278)
										SetTask(310,3)
										TaskNote(32,2)
								elseif(i<=320)then
										Talk(1,"no",11279)
										SetTask(310,4)
										TaskNote(32,3)
								elseif(i<=400)then
										Talk(1,"no",11280)
										SetTask(310,5)
										TaskNote(32,4)
								elseif(i<=480)then
										Talk(1,"no",11281)
										SetTask(310,6)
										TaskNote(32,5)
								elseif(i<=560)then
										Talk(1,"no",11282)
										SetTask(310,7)
										TaskNote(32,6)
								elseif(i<=570)then
										Talk(1,"no",11283)
										SetTask(310,8)
										TaskNote(32,7)
								elseif(i<=580)then
										Talk(1,"no",11284)
										SetTask(310,9)
										TaskNote(32,8)
								elseif(i<=590)then
										Talk(1,"no",11285)
										SetTask(310,10)
										TaskNote(32,9)
								elseif(i<=600)then
										Talk(1,"no",11286)
										SetTask(310,11)
										TaskNote(32,10)
								elseif(i<=610)then
										Talk(1,"no",11287)
										SetTask(310,12)
										TaskNote(32,11)
								elseif(i<=620)then
										Talk(1,"no",11288)
										SetTask(310,13)
										TaskNote(32,12)
								end;
			elseif(GetLevel()<=50)then
								local  i=random(1,1080)
								if(i<=80)then
										Talk(1,"no",11276)
										SetTask(310,1)
										TaskNote(32,0)
								elseif(i<=160)then
										Talk(1,"no",11277)
										SetTask(310,2)
										TaskNote(32,1)
								elseif(i<=240)then
										Talk(1,"no",11278)
										SetTask(310,3)
										TaskNote(32,2)
								elseif(i<=320)then
										Talk(1,"no",11279)
										SetTask(310,4)
										TaskNote(32,3)
								elseif(i<=400)then
										Talk(1,"no",11280)
										SetTask(310,5)
										TaskNote(32,4)
								elseif(i<=480)then
										Talk(1,"no",11281)
										SetTask(310,6)
										TaskNote(32,5)
								elseif(i<=560)then
										Talk(1,"no",11282)
										SetTask(310,7)
										TaskNote(32,6)
								elseif(i<=570)then
										Talk(1,"no",11283)
										SetTask(310,8)
										TaskNote(32,7)
								elseif(i<=580)then
										Talk(1,"no",11284)
										SetTask(310,9)
										TaskNote(32,8)
								elseif(i<=590)then
										Talk(1,"no",11285)
										SetTask(310,10)
										TaskNote(32,9)
								elseif(i<=600)then
										Talk(1,"no",11286)
										SetTask(310,11)
										TaskNote(32,10)
								elseif(i<=610)then
										Talk(1,"no",11287)
										SetTask(310,12)
										TaskNote(32,11)
								elseif(i<=620)then
										Talk(1,"no",11288)
										SetTask(310,13)
										TaskNote(32,12)
								elseif(i<=720)then
										Talk(1,"no",11289)
										SetTask(310,14)
										TaskNote(32,13)
								elseif(i<=820)then
										Talk(1,"no",11290)
										SetTask(310,15)
										TaskNote(32,14)
								elseif(i<=920)then
										Talk(1,"no",11291)
										SetTask(310,16)
										TaskNote(32,15)
								elseif(i<=1020)then
										Talk(1,"no",11292)
										SetTask(310,17)
										TaskNote(32,16)
								elseif(i<=1030)then
										Talk(1,"no",11293)
										SetTask(310,18)
										TaskNote(32,17)
								elseif(i<=1040)then
										Talk(1,"no",11294)
										SetTask(310,19)
										TaskNote(32,18)
								elseif(i<=1050)then
										Talk(1,"no",11295)
										SetTask(310,20)
										TaskNote(32,19)
								elseif(i<=1060)then
										Talk(1,"no",11296)
										SetTask(310,21)
										TaskNote(32,20)
								elseif(i<=1065)then
										Talk(1,"no",11297)
										SetTask(310,22)
										TaskNote(32,21)
								elseif(i<=1070)then
										Talk(1,"no",11298)
										SetTask(310,23)
										TaskNote(32,22)
								elseif(i<=1075)then
										Talk(1,"no",11299)
										SetTask(310,24)
										TaskNote(32,23)
								elseif(i<=1080)then
										Talk(1,"no",11300)
										SetTask(310,25)
										TaskNote(32,24)
								end;
			elseif(GetLevel()<=70)then
								local  i=random(1,1114)
								if(i<=80)then
										Talk(1,"no",11276)
										SetTask(310,1)
										TaskNote(32,0)
								elseif(i<=160)then
										Talk(1,"no",11277)
										SetTask(310,2)
										TaskNote(32,1)
								elseif(i<=240)then
										Talk(1,"no",11278)
										SetTask(310,3)
										TaskNote(32,2)
								elseif(i<=320)then
										Talk(1,"no",11279)
										SetTask(310,4)
										TaskNote(32,3)
								elseif(i<=400)then
										Talk(1,"no",11280)
										SetTask(310,5)
										TaskNote(32,4)
								elseif(i<=480)then
										Talk(1,"no",11281)
										SetTask(310,6)
										TaskNote(32,5)
								elseif(i<=560)then
										Talk(1,"no",11282)
										SetTask(310,7)
										TaskNote(32,6)
								elseif(i<=570)then
										Talk(1,"no",11283)
										SetTask(310,8)
										TaskNote(32,7)
								elseif(i<=580)then
										Talk(1,"no",11284)
										SetTask(310,9)
										TaskNote(32,8)
								elseif(i<=590)then
										Talk(1,"no",11285)
										SetTask(310,10)
										TaskNote(32,9)
								elseif(i<=600)then
										Talk(1,"no",11286)
										SetTask(310,11)
										TaskNote(32,10)
								elseif(i<=610)then
										Talk(1,"no",11287)
										SetTask(310,12)
										TaskNote(32,11)
								elseif(i<=620)then
										Talk(1,"no",11288)
										SetTask(310,13)
										TaskNote(32,12)
								elseif(i<=720)then
										Talk(1,"no",11289)
										SetTask(310,14)
										TaskNote(32,13)
								elseif(i<=820)then
										Talk(1,"no",11290)
										SetTask(310,15)
										TaskNote(32,14)
								elseif(i<=920)then
										Talk(1,"no",11291)
										SetTask(310,16)
										TaskNote(32,15)
								elseif(i<=1020)then
										Talk(1,"no",11292)
										SetTask(310,17)
										TaskNote(32,16)
								elseif(i<=1030)then
										Talk(1,"no",11293)
										SetTask(310,18)
										TaskNote(32,17)
								elseif(i<=1040)then
										Talk(1,"no",11294)
										SetTask(310,19)
										TaskNote(32,18)
								elseif(i<=1050)then
										Talk(1,"no",11295)
										SetTask(310,20)
										TaskNote(32,19)
								elseif(i<=1060)then
										Talk(1,"no",11296)
										SetTask(310,21)
										TaskNote(32,20)
								elseif(i<=1065)then
										Talk(1,"no",11297)
										SetTask(310,22)
										TaskNote(32,21)
								elseif(i<=1070)then
										Talk(1,"no",11298)
										SetTask(310,23)
										TaskNote(32,22)
								elseif(i<=1075)then
										Talk(1,"no",11299)
										SetTask(310,24)
										TaskNote(32,23)
								elseif(i<=1080)then
										Talk(1,"no",11300)
										SetTask(310,25)
										TaskNote(32,24)
								elseif(i<=1082)then
										Talk(1,"no",11301)
										SetTask(310,26)
										TaskNote(32,25)
								elseif(i<=1084)then
										Talk(1,"no",11302)
										SetTask(310,27)
										TaskNote(32,26)
								elseif(i<=1086)then
										Talk(1,"no",11303)
										SetTask(310,28)
										TaskNote(32,27)
								elseif(i<=1088)then
										Talk(1,"no",11304)
										SetTask(310,29)
										TaskNote(32,28)
								elseif(i<=1090)then
										Talk(1,"no",11305)
										SetTask(310,30)
										TaskNote(32,29)
								elseif(i<=1092)then
										Talk(1,"no",11306)
										SetTask(310,31)
										TaskNote(32,30)
								elseif(i<=1094)then
										Talk(1,"no",11307)
										SetTask(310,32)
										TaskNote(32,31)
								elseif(i<=1096)then
										Talk(1,"no",11308)
										SetTask(310,33)
										TaskNote(32,32)
								elseif(i<=1098)then
										Talk(1,"no",11309)
										SetTask(310,34)
										TaskNote(32,33)
								elseif(i<=1100)then
										Talk(1,"no",11310)
										SetTask(310,35)
										TaskNote(32,34)
								elseif(i<=1102)then
										Talk(1,"no",11311)
										SetTask(310,36)
										TaskNote(32,35)
								elseif(i<=1104)then
										Talk(1,"no",11312)
										SetTask(310,37)
										TaskNote(32,36)
								elseif(i<=1114)then
										Talk(1,"no",11313)
										SetTask(310,38)
										TaskNote(32,37)
								end;
			else
								local  i=random(1,1118)
								if(i<=80)then
										Talk(1,"no",11276)
										SetTask(310,1)
										TaskNote(32,0)
								elseif(i<=160)then
										Talk(1,"no",11277)
										SetTask(310,2)
										TaskNote(32,1)
								elseif(i<=240)then
										Talk(1,"no",11278)
										SetTask(310,3)
										TaskNote(32,2)
								elseif(i<=320)then
										Talk(1,"no",11279)
										SetTask(310,4)
										TaskNote(32,3)
								elseif(i<=400)then
										Talk(1,"no",11280)
										SetTask(310,5)
										TaskNote(32,4)
								elseif(i<=480)then
										Talk(1,"no",11281)
										SetTask(310,6)
										TaskNote(32,5)
								elseif(i<=560)then
										Talk(1,"no",11282)
										SetTask(310,7)
										TaskNote(32,6)
								elseif(i<=570)then
										Talk(1,"no",11283)
										SetTask(310,8)
										TaskNote(32,7)
								elseif(i<=580)then
										Talk(1,"no",11284)
										SetTask(310,9)
										TaskNote(32,8)
								elseif(i<=590)then
										Talk(1,"no",11285)
										SetTask(310,10)
										TaskNote(32,9)
								elseif(i<=600)then
										Talk(1,"no",11286)
										SetTask(310,11)
										TaskNote(32,10)
								elseif(i<=610)then
										Talk(1,"no",11287)
										SetTask(310,12)
										TaskNote(32,1)
								elseif(i<=620)then
										Talk(1,"no",11288)
										SetTask(310,13)
										TaskNote(32,12)
								elseif(i<=720)then
										Talk(1,"no",11289)
										SetTask(310,14)
										TaskNote(32,13)
								elseif(i<=820)then
										Talk(1,"no",11290)
										SetTask(310,15)
										TaskNote(32,14)
								elseif(i<=920)then
										Talk(1,"no",11291)
										SetTask(310,16)
										TaskNote(32,15)
								elseif(i<=1020)then
										Talk(1,"no",11292)
										SetTask(310,17)
										TaskNote(32,16)
								elseif(i<=1030)then
										Talk(1,"no",11293)
										SetTask(310,18)
										TaskNote(32,17)
								elseif(i<=1040)then
										Talk(1,"no",11294)
										SetTask(310,19)
										TaskNote(32,18)
								elseif(i<=1050)then
										Talk(1,"no",11295)
										SetTask(310,20)
										TaskNote(32,19)
								elseif(i<=1060)then
										Talk(1,"no",11296)
										SetTask(310,21)
										TaskNote(32,20)
								elseif(i<=1065)then
										Talk(1,"no",11297)
										SetTask(310,22)
										TaskNote(32,21)
								elseif(i<=1070)then
										Talk(1,"no",11298)
										SetTask(310,23)
										TaskNote(32,22)
								elseif(i<=1075)then
										Talk(1,"no",11299)
										SetTask(310,24)
										TaskNote(32,23)
								elseif(i<=1080)then
										Talk(1,"no",11300)
										SetTask(310,25)
										TaskNote(32,24)
								elseif(i<=1082)then
										Talk(1,"no",11301)
										SetTask(310,26)
										TaskNote(32,25)
								elseif(i<=1084)then
										Talk(1,"no",11302)
										SetTask(310,27)
										TaskNote(32,26)
								elseif(i<=1086)then
										Talk(1,"no",11303)
										SetTask(310,28)
										TaskNote(32,27)
								elseif(i<=1088)then
										Talk(1,"no",11304)
										SetTask(310,29)
										TaskNote(32,28)
								elseif(i<=1090)then
										Talk(1,"no",11305)
										SetTask(310,30)
										TaskNote(32,29)
								elseif(i<=1092)then
										Talk(1,"no",11306)
										SetTask(310,31)
										TaskNote(32,30)
								elseif(i<=1094)then
										Talk(1,"no",11307)
										SetTask(310,32)
										TaskNote(32,31)
								elseif(i<=1096)then
										Talk(1,"no",11308)
										SetTask(310,33)
										TaskNote(32,32)
								elseif(i<=1098)then
										Talk(1,"no",11309)
										SetTask(310,34)
										TaskNote(32,33)
								elseif(i<=1100)then
										Talk(1,"no",11310)
										SetTask(310,35)
										TaskNote(32,34)
								elseif(i<=1102)then
										Talk(1,"no",11311)
										SetTask(310,36)
										TaskNote(32,35)
								elseif(i<=1104)then
										Talk(1,"no",11312)
										SetTask(310,37)
										TaskNote(32,36)
								elseif(i<=1114)then
										Talk(1,"no",11313)
										SetTask(310,38)
										TaskNote(32,37)
								elseif(i<=1115)then
										Talk(1,"no",11314)
										SetTask(310,39)
										TaskNote(32,38)
								elseif(i<=1116)then
										Talk(1,"no",11315)
										SetTask(310,40)
										TaskNote(32,39)
								elseif(i<=1117)then
										Talk(1,"no",11316)
										SetTask(310,41)
										TaskNote(32,40)
								elseif(i<=1118)then
										Talk(1,"no",11317)
										SetTask(310,42)
										TaskNote(32,41)
								end;
			end;
			if(thisday-1>=thistime)then
					SetTask(313,1)
					SetTask(312,0)
					SetTask(311,thisday)
					Msg2Player("NhiÖm vô thu thËp ®¹o cô h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
			else
					SetTask(313,cishu+1)
					Msg2Player("B¹n nhËn ®­îc nhiÖm vô thu thËp ®¹o cô míi.")
			end;

		end;
end;

function   esc()
		MsgBox(11318,"quxiao_1","no")
end;

function   quxiao_1()
		local  cishu=GetTask(313)
		local  thistime=GetTask(311)
		local  shengyu=10-cishu
		Talk(1,"no","Ng­¬i ®· hñy bá nhiÖm vô lÇn nµy, h«m nay cßn <color=red>"..shengyu.."<color> lÇn")
		SetTask(312,1)
		SetTask(310,0)
end;

function   jiangli(renwu,thistime,cishu)
		local  cishu=GetTask(313)
		local  shengyu=10-cishu
		local thisday=floor(SystemTime()/86400)
		local    money=(GetLevel()*200)
		local    money_1=(GetLevel()*(20*GetLevel()-500))+(GetLevel()*100)
		local    money_2=(GetTask(313)*GetLevel()*10)
					if(GetTask(313)>=10)and(GetTask(312)<=0)then

								if(GetCash()>=money)and(GetLevel()<=30)then
										Talk(1,"no",11319)
										AddOwnExp(GetLevel()*100)
										Pay(GetLevel()*100)
										AddOwnExp(GetLevel()*100)
										Pay(GetLevel()*100)
										SetTask(311,thistime+1)
										SetTask(313,0)
										SetTask(310,0)
										if(thisday-1>=thistime)then
													SetTask(313,0)
													SetTask(311,thisday)
													SetTask(312,0)
													Msg2Player("NhiÖm vô thu thËp ®¹o cô h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
										else
													Msg2Player("Ng­¬i ®· hoµn thµnh nhiÖm vô lÇn nµy, cã thÓ nhËn nhiÖm vô tiÕp theo.")
										end;
								elseif(GetCash()>=money_1)and(GetLevel()>=30)then
									
										Talk(1,"no",11319)
										AddOwnExp(GetLevel()*100)
										Pay(GetLevel()*100)
										AddOwnExp(GetLevel()*(20*GetLevel()-500))
										Pay(GetLevel()*(20*GetLevel()-500))
										SetTask(311,thistime+1)
										SetTask(313,0)
										SetTask(310,0)
										if(thisday-1>=thistime)then
													SetTask(313,0)
													SetTask(311,thisday)
													SetTask(312,0)
													Msg2Player("NhiÖm vô thu thËp ®¹o cô h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
										else
													Msg2Player("Ng­¬i ®· hoµn thµnh nhiÖm vô lÇn nµy, cã thÓ nhËn nhiÖm vô tiÕp theo.")
										end;
								else
										Talk(1,"no",11320)
										return  0
								end;
					else
							if(GetCash()>=money_2)then
									Talk(1,"no","Lµm tèt l¾m! Xin nhËn phÇn th­ëng! H«m nay ng­¬i cßn <color=red>"..shengyu.."<color> lÇn")
									AddOwnExp(GetTask(313)*GetLevel()*10)
									Pay(GetTask(313)*GetLevel()*10)
									SetTask(310,0)
							else
									Talk(1,"no",11320)
									return  0
							end;
					end;
end;

function   wancheng()
		local  renwu=GetTask(310)
		local  thistime=GetTask(311)
		local  cishu=GetTask(313)
		if((renwu==1)and(HaveNormalItem(3,6,0,0)>=5))then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,5 do
								DelNormalItem(3,6,0,0)
						end;
				end;
				TaskNote(32,42)
		elseif(renwu==2)and(HaveNormalItem(3,8,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,8,0,0)
						end;
				end;
				TaskNote(32,42)
		elseif(renwu==3)and(HaveNormalItem(3,9,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,9,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==4)and(HaveNormalItem(3,10,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,10,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==5)and(HaveNormalItem(3,11,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,11,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==6)and(HaveNormalItem(3,12,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,12,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==7)and(HaveNormalItem(3,13,0,0)>=10)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,10 do
								DelNormalItem(3,13,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==8)and(GetItemLevel2(0,4,0)>=1)then
				local  nLevel=GetItemLevel2(0,4,0)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,0,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==9)and(GetItemLevel2(0,4,1)>=1)then
				local  nLevel=GetItemLevel2(0,4,1)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,1,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==10)and(GetItemLevel2(0,4,2)>=1)then
				local  nLevel=GetItemLevel2(0,4,2)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,2,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==11)and(GetItemLevel2(0,4,3)>=1)then
				local   nLevel=GetItemLevel2(0,4,3)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,3,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==12)and(GetItemLevel2(0,4,4)>=1)then
				local   nLevel=GetItemLevel2(0,4,4)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,4,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==13)and(GetItemLevel2(0,4,5)>=1)then
				local   nLevel=GetItemLevel2(0,4,5)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,5,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==14)and(HaveNormalItem(3,22,0,0)>=5)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,5 do
								DelNormalItem(3,22,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==15)and(HaveNormalItem(3,23,0,0)>=5)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,5 do
								DelNormalItem(3,23,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==16)and(HaveNormalItem(3,24,0,0)>=5)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,5 do
								DelNormalItem(3,24,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==17)and(HaveNormalItem(3,25,0,0)>=5)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						for i=1,5 do
								DelNormalItem(3,25,0,0)
						end;	
				end;
				TaskNote(32,42)
		elseif(renwu==18)and(GetItemLevel2(0,4,6)>=1)then
				local   nLevel=GetItemLevel2(0,4,6)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,6,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==19)and(GetItemLevel2(0,4,7)>=1)then
				local   nLevel=GetItemLevel2(0,4,7)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,7,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==20)and(GetItemLevel2(0,4,8)>=1)then
				local   nLevel=GetItemLevel2(0,4,8)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,8,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==21)and(GetItemLevel2(0,4,9)>=1)then
				local   nLevel=GetItemLevel2(0,4,9)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,9,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==22)and(GetItemLevel2(0,4,18)>=1)then
				local   nLevel=GetItemLevel2(0,4,18)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,18,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==23)and(GetItemLevel2(0,4,19)>=1)then
				local   nLevel=GetItemLevel2(0,4,19)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,19,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==24)and(GetItemLevel2(0,4,20)>=1)then
				local   nLevel=GetItemLevel2(0,4,20)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,20,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==25)and(GetItemLevel2(0,4,21)>=1)then
				local   nLevel=GetItemLevel2(0,4,21)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,21,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==26)and(GetItemLevel2(0,4,10)>=1)then
				local   nLevel=GetItemLevel2(0,4,10)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,10,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==27)and(GetItemLevel2(0,4,11)>=1)then
				local   nLevel=GetItemLevel2(0,4,11)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,11,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==28)and(GetItemLevel2(0,4,12)>=1)then
				local   nLevel=GetItemLevel2(0,4,12)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,12,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==29)and(GetItemLevel2(0,4,13)>=1)then
				local   nLevel=GetItemLevel2(0,4,13)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,13,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==30)and(GetItemLevel2(0,4,22)>=1)then
				local   nLevel=GetItemLevel2(0,4,22)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,22,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==31)and(GetItemLevel2(0,4,23)>=1)then
				local   nLevel=GetItemLevel2(0,4,23)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,23,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==32)and(GetItemLevel2(0,4,24)>=1)then
				local   nLevel=GetItemLevel2(0,4,24)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,24,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==33)and(GetItemLevel2(0,4,25)>=1)then
				local   nLevel=GetItemLevel2(0,4,25)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,25,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==34)and(GetItemLevel2(0,4,26)>=1)then
				local   nLevel=GetItemLevel2(0,4,26)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,26,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==35)and(GetItemLevel2(0,4,27)>=1)then
				local   nLevel=GetItemLevel2(0,4,27)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,27,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==36)and(GetItemLevel2(0,4,28)>=1)then
				local   nLevel=GetItemLevel2(0,4,28)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,28,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==37)and(GetItemLevel2(0,4,29)>=1)then
				local   nLevel=GetItemLevel2(0,4,29)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,29,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==38)and(HaveEventItem(39)==1)then
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelEventItem(39)
				end;
				TaskNote(32,42)
		elseif(renwu==39)and(GetItemLevel2(0,4,14)>=1)then
				local   nLevel=GetItemLevel2(0,4,14)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,14,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==40)and(GetItemLevel2(0,4,15)>=1)then
				local   nLevel=GetItemLevel2(0,4,15)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,15,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==41)and(GetItemLevel2(0,4,16)>=1)then
				local   nLevel=GetItemLevel2(0,4,16)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,16,nLevel)
				end;
				TaskNote(32,42)
		elseif(renwu==42)and(GetItemLevel2(0,4,17)>=1)then
				local   nLevel=GetItemLevel2(0,4,17)
				if(jiangli(renwu,thistime,cishu)~=0)then
						DelItem2(0,4,17,nLevel)
				end;
				TaskNote(32,42)
		else
				Talk(1,"no",11321)
		end;	
end;
------------------------------------------------------------------------------------------------------------------------------------------------------------
--function   renwu4()
--			if(GetTask(318)==2)then
--					Talk(1,"no","Ë÷¾¸À­£ºàÅ£¬Ğ»Ğ»ÄãµÄ°ïÖú£¬ÎÒÒ»¶¨¼ÛÆğÓÂÆø£¬ÏòÏÉ×Ó±í´ïÎÒµÄ¸ĞÇé¡£Îª³Ñ±íÊ¾¶ÔÄãµÄĞ»Òâ£¬ÎÒ½²Ò»¸öºÜÓĞÒâË¼µÄ¹ÊÊÂ¸øÄãÌı°É£ºÔÚºÜ¾ÃºÜ¾ÃÒÔÇ°......")
--					Msg2Player("Ìı³ÑË÷¾¸À­½²µÄ¹ÊÊÂ£¬ÄãµÄËùÓĞ»ù±¾ÊôĞÔ¶¼ÉÏÉı³ÑÒ»µã¡£")
--					DelNormalItem(6,1,22,1)
--					AddInt(1)
--					AddDex(1)
--					AddStrg(1)
--					AddCon(1)
--					SetTask(318,3)
--			elseif(GetGlobalValue(5)==999)and(GetTask(318)==0)then
--					SetGlobalValue(5,0)
--					Talk(3,"lovea","Íæ¼Ò£ºÎÒÖÕÓÚ¿´µ½Äã³Ñ£¬ÄãÊÇË­£¿¹í¹íËîËîµÄÔÚÕâÀï¸ÉÊ²¨t£¿","ÉñÃØ?£ºàÅ£¬ÎÒ......ÎÒ½ĞË÷¾¸À­£¬ÎÒÔÚÕâÀï¾ÍÊÇÏë......Ïë¿´¿´ÏÉ×Ó¡£","Íæ¼Ò£ºÔ­À´ÄãÏ²»¶º¯Ö¥ÏÉ×Ó°¡¡£")
--			elseif(GetGlobalValue(5)==999)then
--					SetGlobalValue(5,0)
--					Talk(1,"no","Íæ¼Ò£º¡¯¹Ö£¬ÎÒÃ÷Ã÷¿´µ½ÕâÀïÓĞ¸öÉñÃØµÄ?Ó°£¬Ôõ¨tÒ»ÉÁÖ®¼ä¾Í²»¼û³Ñ£¿")
--			else
--					local    i=(GetGlobalValue(5)+1)
--					SetGlobalValue(5,i)
--					Talk(1,"no","Íæ¼Ò£º¡¯¹Ö£¬ÎÒÃ÷Ã÷¿´µ½ÕâÀïÓĞ¸öÉñÃØµÄ?Ó°£¬Ôõ¨tÒ»ÉÁÖ®¼ä¾Í²»¼û³Ñ£¿")
--			end;
--end;

--function   lovea()
--		Talk(1,"loveb","Ë÷¾¸À­(Á³ºì)£ºàÅ£¬Ğ¡Éùµã£¬±ğ?ÏÉ×ÓÌıµ½³Ñ¡£ÏÉ×ÓËıÊÇÄÇ¨tµÄºÃ£¬ÎÒÃ¿ÌìÔçÉÏÍí¼ä£¬?§OÄÜ¹»¶à¿´ËıÒ»ÑÛ£¬¾Í¾õµÃºÃ¿ªĞÄ£»ÒªÊÇÄÜºÍËıËµ¼¸¾ú»°£¬¾Í¸üÊÇ»¶Ï²µÄ½ô£¬ÄÄÀï¸ÒÓĞÊ²¨tÌÆÍ»¼Ñ?µÄ­ã·ÖÖ®Ïë£¿")
--end;

--function   loveb()
--		Talk(1,"lovec","Íæ¼Ò£ºÄãÔõ¨tÕâ¨t±¿°¡£¬ÄĞ×Óºº´óÕÉ·ò£¬Ï²»¶¾ÍËµ³öÀ´Âï¡£ËÍ¶äÃµ¹å»¨¸øÏÉ×Ó£¬ËµÄãÏ²»¶Ëı°¡¡£")
--end;

--function   lovec()
--		MsgBox("Ë÷¾¸À­£ºàÅ¡£Õâ¿ÅºìË®¾§ÒÑ¾­ÊÇÎÒµÄËùÓĞ³Ñ£¬ÄãÄÜ°ïÎÒ°ÑËüù×¸ø³¯¸èµÄÅıÅÃ½ã½ã£¬»»Ò»¶äÃµ¹å»¨À´¸øÎÒÂğ£¿","heart","no")
--end;

--function   heart()
--		Talk(1,"no","Ë÷¾¸À­£ºàÅ£¬Ğ»Ğ»ÄãÅ¶¡£")
--		AddNormalItem(3,28,0,0,0,0)
--		SetTask(318,1)
--end;
------------------------------------------------------------------------------------------------------------------------------------------------------------
function   renwu2()
		local  renwu=GetTask(314)
		local  thistime=GetTask(315)
		local  cishu=GetTask(317)
		local thisday=floor(SystemTime()/86400)
		if(renwu>0)then
						tasks2 = 
						{
							{"T×nh b¸o","wancheng_1";show=1},
							{"Hñy bá","esc_1";show=1}
						}
					SayTask(11322,tasks2)
		elseif(thisday<thistime)then
				Talk(1,"no",11323)
		else
				MsgBox(11324,"check_2","no")
		end;
end;

function   check_2()
		local  renwu=GetTask(314)
		local  thistime=GetTask(315)
		local  cishu=GetTask(317)
		local  thisday=floor(SystemTime()/86400)
		if(cishu>=10)then
				if(thisday>thistime)then
						SetTask(314,0)
						SetTask(315,thisday)
						SetTask(316,0)
						SetTask(317,0)
						Talk(1,"no",11325)
				else
						SetTask(314,0)
						SetTask(315,thisday+1)
						SetTask(316,0)
						SetTask(317,0)
						Talk(1,"no",11326)
				end;
		else
				if(GetLevel()<=30)then
						local  i=random(1,15)
						if(i<=1)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=2)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=3)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=4)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=5)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=6)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=7)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=8)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=9)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=10)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=11)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=12)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=13)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=14)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=15)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						end;
				elseif(GetLevel()<=50)then
						local  i=random(1,27)
						if(i<=1)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=2)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=3)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=4)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=5)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=6)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=7)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=8)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=9)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=10)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=11)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=12)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=13)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=14)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=15)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=16)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=17)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=18)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=19)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=20)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=21)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=22)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=23)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=24)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=25)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=26)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=27)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						end;
			elseif(GetLevel()<=70)then
						local  i=random(1,36)
						if(i<=1)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=2)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=3)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=4)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=5)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=6)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=7)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=8)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=9)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=10)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=11)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=12)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=13)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=14)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=15)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=16)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=17)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=18)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=19)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=20)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=21)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=22)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=23)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=24)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=25)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=26)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=27)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						elseif(i<=28)then
								Talk(1,"no",11354)
								SetTask(314,21)
								TaskNote(33,21)
						elseif(i<=29)then
								Talk(1,"no",11355)
								SetTask(314,25)
								TaskNote(33,25)
						elseif(i<=30)then
								Talk(1,"no",11356)
								SetTask(314,26)
								TaskNote(33,26)
						elseif(i<=31)then
								Talk(1,"no",11357)
								SetTask(314,30)
								TaskNote(33,30)
						elseif(i<=32)then
								Talk(1,"no",11358)
								SetTask(314,31)
								TaskNote(33,31)
						elseif(i<=33)then
								Talk(1,"no",11359)
								SetTask(314,35)
								TaskNote(33,35)
						elseif(i<=34)then
								Talk(1,"no",11360)
								SetTask(314,36)
								TaskNote(33,36)
						elseif(i<=35)then
								Talk(1,"no",11361)
								SetTask(314,40)
								TaskNote(33,40)
						elseif(i<=36)then
								Talk(1,"no",11362)
								SetTask(314,41)
								TaskNote(33,41)
						end;
			else
						local  i=random(1,46)
						if(i<=1)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=2)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=3)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=4)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=5)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=6)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=7)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=8)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=9)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=10)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=11)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=12)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=13)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=14)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=15)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=16)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=17)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=18)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=19)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=20)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=21)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=22)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=23)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=24)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=25)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=26)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=27)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						elseif(i<=28)then
								Talk(1,"no",11354)
								SetTask(314,21)
								TaskNote(33,21)
						elseif(i<=29)then
								Talk(1,"no",11355)
								SetTask(314,25)
								TaskNote(33,25)
						elseif(i<=30)then
								Talk(1,"no",11356)
								SetTask(314,26)
								TaskNote(33,26)
						elseif(i<=31)then
								Talk(1,"no",11357)
								SetTask(314,30)
								TaskNote(33,30)
						elseif(i<=32)then
								Talk(1,"no",11358)
								SetTask(314,31)
								TaskNote(33,31)
						elseif(i<=33)then
								Talk(1,"no",11359)
								SetTask(314,35)
								TaskNote(33,35)
						elseif(i<=34)then
								Talk(1,"no",11360)
								SetTask(314,36)
								TaskNote(33,36)
						elseif(i<=35)then
								Talk(1,"no",11361)
								SetTask(314,40)
								TaskNote(33,40)
						elseif(i<=36)then
								Talk(1,"no",11362)
								SetTask(314,41)
								TaskNote(33,41)
						elseif(i<=37)then
								Talk(1,"no",11363)
								SetTask(314,42)
								TaskNote(33,42)
						elseif(i<=38)then
								Talk(1,"no",11364)
								SetTask(314,43)
								TaskNote(33,43)
						elseif(i<=39)then
								Talk(1,"no",11365)
								SetTask(314,44)
								TaskNote(33,44)
						elseif(i<=40)then
								Talk(1,"no",11366)
								SetTask(314,45)
								TaskNote(33,45)
						elseif(i<=41)then
								Talk(1,"no",11367)
								SetTask(314,46)
								TaskNote(33,46)
						elseif(i<=42)then
								Talk(1,"no",11368)
								SetTask(314,47)
								TaskNote(33,47)
						elseif(i<=43)then
								Talk(1,"no",11369)
								SetTask(314,48)
								TaskNote(33,48)
						elseif(i<=44)then
								Talk(1,"no",11370)
								SetTask(314,49)
								TaskNote(33,49)
						elseif(i<=45)then
								Talk(1,"no",11371)
								SetTask(314,50)
								TaskNote(33,50)
						elseif(i<=46)then
								Talk(1,"no",11372)
								SetTask(314,51)
								TaskNote(33,51)
						end;
			end;
			if(thisday-1>=thistime)then
					SetTask(317,1)
					SetTask(316,0)
					SetTask(315,thisday)
					Msg2Player("NhiÖm vô Th¸m qu©n h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
			else
					SetTask(317,cishu+1)
					Msg2Player("B¹n nhËn nhiÖm vô Th¸m qu©n míi")
			end;

		end;
end;

function   esc()
		MsgBox(11373,"quxiao","no")
end;

function   quxiao()
		local  cishu=GetTask(313)
		local  thistime=GetTask(311)
		local  shengyu=10-cishu
		Talk(1,"no","Ng­¬i ®· hñy bá nhiÖm vô lÇn nµy, h«m nay cßn <color=red>"..shengyu.."<color> lÇn")
		SetTask(312,1)
		SetTask(310,0)
end;

function   esc_1()
		MsgBox(11373,"quxiao_1","no")
end;

function   quxiao_1()
		local  cishu=GetTask(317)
		local  thistime=GetTask(315)	
		local  shengyu=10-cishu
		Talk(1,"no","Ng­¬i ®· hñy bá nhiÖm vô lÇn nµy, h«m nay cßn <color=red>"..shengyu.."<color> lÇn")
		SetTask(314,0)
		SetTask(316,1)
end;

function   wancheng_1()
		local  renwu=GetTask(314)
		local  thistime=GetTask(315)
		local  cishu=GetTask(317)
		local  shengyu=10-cishu
		local thisday=floor(SystemTime()/86400)
		local    money=(GetLevel()*200)
		local    money_1=(GetLevel()*(20*GetLevel()-500))+(GetLevel()*100)
		local    money_2=(GetTask(317)*GetLevel()*10)
					if(renwu==100)then								--Ò½Éú½«?Îñ±àºÅÉèÎª100
							if(cishu>=10)and(GetTask(316)<=0)then
									if(GetCash()>=money)and(GetLevel()<=30)then
											Talk(1,"no",11374)
											AddOwnExp(GetLevel()*100)
											Pay(GetLevel()*100)
											AddOwnExp(GetLevel()*100)
											Pay(GetLevel()*100)
											SetTask(315,thistime+1)
											SetTask(317,0)
											SetTask(314,0)
											if(thisday-1>=thistime)then
														SetTask(317,0)
														SetTask(315,thisday)
														SetTask(316,0)
														Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
											else
														Msg2Player("Ng­¬i ®· hoµn thµnh nhiÖm vô lÇn nµy, cã thÓ nhËn nhiÖm vô tiÕp theo.")
														TaskNote(33,1)
											end;
										
									elseif(GetCash()>=money_1)and(GetLevel()>=30)then
											Talk(1,"no",11374)
											AddOwnExp(GetLevel()*100)
											Pay(GetLevel()*100)
											AddOwnExp(GetLevel()*(20*GetLevel()-500))
											Pay(GetLevel()*(20*GetLevel()-500))
											SetTask(315,thistime+1)
											SetTask(317,0)
											SetTask(314,0)
											if(thisday-1>=thistime)then
														SetTask(317,0)
														SetTask(315,thisday)
														SetTask(316,0)
														Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
											else
														Msg2Player("Ng­¬i ®· hoµn thµnh nhiÖm vô lÇn nµy, cã thÓ nhËn nhiÖm vô tiÕp theo.")
														TaskNote(33,1)
											end;
									else
											Talk(1,"no",11375)
									end;
							else
									if(GetCash()>=money_2)then
											Talk(1,"no","Tin tøc rÊt kŞp thêi! Lµm tèt l¾m! H«m nay ng­¬i cßn cã thÓ <color=green>"..shengyu.."<color> lÇn")
											AddOwnExp(GetTask(317)*GetLevel()*10)
											Pay(GetTask(317)*GetLevel()*10)
											SetTask(314,0)
											if(thisday-1>=thistime)then
														SetTask(317,0)
														SetTask(315,thisday)
														SetTask(316,0)
														Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt hiÖu lùc, h«m nay ph¶i nhËn l¹i nhiÖm vô míi.")
											else
														Msg2Player("Ng­¬i ®· hoµn thµnh nhiÖm vô lÇn nµy, cã thÓ nhËn nhiÖm vô tiÕp theo.")
											end;
									else
											Talk(1,"no",11375)
									end;
							end;
				else
						Talk(1,"no",11376)
				end;
end;
--------------------------------------------------------------------------------------------------------------------------------
function   renwu3()
		MsgBox(11377,"gonggao","no")
end;

function    gonggao()
		local   j=random(0,9)
		local   I=GetName()
		if(GetCash()>=100000)then
				Pay(100000)
				if(j==0)then
						AddGlobalCountNews("C©y hoa t×nh nh©n <color=green>"..I.."<color>. Chóc mäi ng­êi v¹n sù nh­ ı, tiÒn v« nh­ n­íc!",20)
						CloseDialog()
				elseif(j<=2)then
						AddGlobalCountNews("<color=green>"..I.."<color> Chóc mäi ng­êi ®ang lµm nhiÖm vô ®¸nh qu¸i nhËn ®­îc trang bŞ Hoµng Kim, vËt phÈm nh­ ı!",20)
						CloseDialog()
				elseif(j<=5)then
						AddGlobalCountNews("<color=green>"..I.."<color> Chóc nh÷ng ai cã ngµy sinh nhËt h«m nay vui vÎ, v¹n sù nh­ ı!",20)
						CloseDialog()
				else
						AddGlobalCountNews("<color=green>"..I.."<color>Chóc mäi ng­êi ch¬i vui vÎ!",20)
						CloseDialog()
				end;
		else
				Talk(1,"no",11378)
		end;
end;



--------------------------------------------------------------------------------------------------------------------------------
function   renwu4()
		MsgBox("Göi lêi chóc kÕt h«n ch©n thµnh ®Õn tÊt c¶ ng­êi ch¬i? VËy ph¶i tèn 20w. ","marry","no")
end;

function    marry()
		local   j=random(0,9)
		local   I=GetName()
		if(GetCash()>=200000)then
				Pay(200000)
				AddGlobalCountNews("<color=green>"..I.."<color>Chóc nh÷ng ng­êi kÕt h«n h«m nay <color=green>b¸ch niªn h¶o hîp<color>, <color=green>m·i m·i h¹nh phóc<color>. ",20)
				CloseDialog()
		else
				Talk(1,"no","TiÒn cña ng­¬i vÉn ch­a ®ñ! ")
		end;
end;
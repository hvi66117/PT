-- Original VNG source payload; provenance in deployment report.
--description: ¶À¤Ñ¤Æ-¹D¤h¥D½u?°È
--author: yichuan
--date:2004/5/8
--901,®vªù°aÁÕ¸Õ½m

function main()
			tasks = 
			{
				{"ThÇn Oanh","renwu1";show=0},
				{"Th¸m qu©n","renwu2";show=0},
				{"Hiªn Viªn ThÝ luyÖn ","shitu_1";show=0}
			}
			UTask_Wizard = GetTask(1);
			if(GetPlayerType()==1)and(GetLevel()>=45)  and  (UTask_Wizard == 24)then
					tasks[1].show=1
			end;
			if(GetLevel()>=45)  and  (UTask_Wizard == 21)then
					tasks[1].show=1;
			end;
			if(GetLevel()>=30)  then
					tasks[2].show=1;
			end;
			if(GetLevel()>35)and(GetLevel()<=45)and(GetTask(901)<=7)then	--®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
				tasks[3].show=1;
			end;
			PTQ2_SayTask(10061,tasks)
end;

function  shitu_1()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		if(GetTask(901)==0)then		--±µ¥ô°È
			MsgBox("S­ phô ta th­êng b¶o muèn n©ng cao ph¸p thuËt c¸ch tèt nhÊt lµ m¹nh d¹n x«ng vµo chèn ma qu¸i, ng­¬i muèn thö kh«ng?","shitu_1_begin","no")
		elseif(GetTask(901)==6)then	--§¹¦¨¥ô°È
			MsgBox("Chóc mõng! Víi c¸ch tËp luyÖn nµy ng­¬i c¶m thÊy m×nh m¹nh h¬n råi ph¶i kh«ng?","shitu_1_end","no")
		elseif(GetTask(901)==7)then
			Talk(1,"no","Ng­¬i cã thÓ hoµn thµnh thÝ luyÖn Hiªn Viªn ®éng, kh«ng ph¶i tÇn th­êng. H·y ®Õn T©y Kú t×m D­¬ng TiÔn ®Ó ®­îc h­íng dÉn thªm!")
		else				--©ñ±ó¥ô°È
			MsgBox("Ng­¬i ch­a ®ñ kh¶ n¨ng hoµn thµnh nhiÖm vô, khi kh¸c h·y thö l¹i!","shitu_1_cancel","no")
		end
	else
		if(GetTask(901)==0)then
			Talk(1,"no","Muèn n©ng cao ph¸p thuËt c¸ch tèt nhÊt lµ m¹nh d¹n x«ng vµo chèn ma qu¸i, nÕu ng­¬i ®¹t cÊp 36 cã thÓ cïng s­ phô ®Õn chç ta nhËn thö th¸ch.")
		elseif(GetTask(901)==6)then
			Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
		elseif(GetTask(901)==7)then
			Talk(1,"no","Ng­¬i cã thÓ hoµn thµnh thÝ luyÖn Hiªn Viªn ®éng, kh«ng ph¶i tÇn th­êng. H·y ®Õn T©y Kú t×m D­¬ng TiÔn ®Ó ®­îc h­íng dÉn thªm!")
		else
			MsgBox("Ng­¬i ch­a ®ñ kh¶ n¨ng hoµn thµnh nhiÖm vô, khi kh¸c h·y thö l¹i!","shitu_1_cancel","no")
		end
	end
end

function shitu_1_begin()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		RemoveIBBuff(216)
		local done=AddIBBuff(216)
		if(done==1)then
			SetTask(901,1)
			TaskNote(45,5)
			if(GetTask(900)<7)then
				SetTask(900,0)
				TaskNote(44,-1)
			end
			if(GetTask(899)<7)then
				SetTask(899,0)
				TaskNote(43,-1)
			end
			if(GetTask(902)<7)then
				SetTask(902,0)
				TaskNote(46,-1)
			end
			Talk(2,"no","Ng­¬i ®ang ®øng trong vßng <color=yellow>Dòng gi¶<color>, tr­íc khi vßng s¸ng biÕn mÊt, theo thø tù ®èi tho¹i víi <color=green>c¸c ®¹i phu trong Hiªn Viªn ®éng<color>, hoµn thµnh xem nh­ thÝ luyÖn thµnh c«ng!","§õng ®Ó vßng s¸ng biÕn mÊt vµ ph¶i cïng ®i víi s­ phô cña m×nh. §¹i phu mçi tÇng sÏ gióp ng­¬i trÞ liÖu vÕt th­¬ng.")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i kh«ng phï hîp kh«ng thÓ nhËn nhiÖm vô s­ ®å, khi kh¸c h·y quay l¹i!")
		end
	else
		Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
	end
end

function shitu_1_end()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		shitu_1_end_P()
		local oldPlayer=PlayerIndex
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			shitu_1_end_M()
		end
		PlayerIndex=oldPlayer
	else
		Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
	end
end

function step_complete()
	local mark=0
	local step={}
	for i=1,4 do
		step[i]=8-GetTask(898+i)
		if(step[i]==1)then
			mark=mark+1
		end
	end
	return mark
end

function shitu_1_end_P()
	local exp1=GetNextExp()-GetExp()
	local exp2=2*GetNextExp()
	local exp=2*GetNextExp()
	AddOwnExp(exp1)
	exp2=exp2-exp1
	exp1=GetNextExp()-GetExp()
	if(exp1<exp2)then
		AddOwnExp(exp1)
		AddOwnExp(exp2-exp1)
	else
		AddOwnExp(exp2)
	end
	SetTask(901,7)
	TaskNote(45,6)
	TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>"..exp.."kinh nghiÖm")
	local mark=step_complete()
	if(mark==1)and(GetTask(907)==0)then	--§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
		AddNormalItem(0,7,GetPlayerType()+6,4,0,0)
		SetTask(907,1)
		Talk(1,"no","Lîi h¹i l¾m! Xin nhËn phÇn th­ëng!")
		AddGlobalCountNews("<color=green>"..GetName().."<color> vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>®Çu kh«i<color>",20)
--	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
--		AddNormalItem(3,14,0,0,0,0)
--		SetTask(903,1)
--		Talk(1,"no","¶À¤Ñ¤Æ¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
	elseif(mark==4)and(GetTask(904)==0)then		--§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
		AddNormalItem2(0,10,GetPlayerType()+15,9,0,0)
		SetTask(904,1)
		Talk(1,"no","Qu¶ nhiªn anh hïng xuÊt thiÕu niªn! Xin nhËn phÇn th­ëng!")
		AddGlobalCountNews("<color=green>"..GetName().."<color>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>thó c­ìi cÊp 50<color>",20)
	else
		Talk(1,"no","Kh«ng ngê ng­¬i vµ s­ phô cã thÓ hoµn thµnh tèt nhiÖm vô thö th¸ch khã kh¨n nµy!")
	end
end

function shitu_1_end_M()
	local step=GetTask(901)
	if(step<100)then
		AddMasterPRValue(7)
		SetTask(901,100)
		TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>7 ®iÓm s­ ®å")
	else
		AddMasterPRValue(3)
		TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>3 ®iÓm s­ ®å")
		Talk(1,"no","LÇn tr­íc ng­¬i ®· nhËn th­ëng, nªn phÇn th­ëng lÇn nµy kh«ng ®­îc nhiÒu.")
	end
end

function shitu_1_cancel()
	RemoveIBBuff(216)
	SetTask(901,0)
	TaskNote(45,-1)
	Talk(1,"no","NhiÖm vô Hiªn Viªn ®éng nguy hiÓm mu«n trïng, ng­¬i h·y luyÖn tËp thªm ®·!")
end

function judge_relation()		--º¡¨¬®v®{2¤H¶¤
	local mark=0
	if(GetTeam()~=0)then			-- ¦³¶¤¥î	
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			mark=IsMasterPRRelation(n)
		end
	end
	return mark
end

function   renwu1()
	UTask_Wizard = GetTask(1);
	if(GetPlayerType()==1)and(GetLevel()>=45)  and  (UTask_Wizard == 24)then
					Talk(1,"no",10062)
					Msg2Player("ThÇn Oanh tÊn c«ng §¾c Kû thÊt b¹i, nh­ng b¹n vÉn nhËn ®­îc Tö D­¬ng kiÕm.")				
					AddNormalItem(0,0,33,4,1,0)
					SetTask(1,30)
					TaskNote(28,15)
	end;
	if(GetLevel()>=45)  and  (UTask_Wizard == 21)then
					Talk(1,"no",10063)		
					Msg2Player("§Õn B¾c H¶i t×m ThÇn Oanh vÒ b¾t §¾c Kû hiÖn h×nh.")
					SetTask(1,22)
					TaskNote(28,12)
	end;
end;

function   renwu2()
		local  renwu=GetTask(314)
		local  thistime=GetTask(315)
		local  cishu=GetTask(317)
		local  thisday=floor(SystemTime()/86400)
		if(renwu>0)then
						tasks2 = 
						{
							{"T×nh b¸o","wancheng_1";show=1},
							{"Hñy bá","esc_1";show=1}
						}
					PTQ2_SayTask("NhiÖm vô lÇn nµy h¬i khã, nÕu hñy nhiÖm vô th× sè lÇn hoµn thµnh nhiÖm vô trong ngµy sÏ gi¶m xuèng, ng­¬i suy nghÜ kü ch­a?",tasks2)
		elseif(thisday<thistime)then
				Talk(1,"no",11323)
		else
				MsgBox("Ta ®ang thu thËp tin tøc cña c¸c §¹i phu vµ tÝch tr÷ l­¬ng thùc cho qu©n ®éi. Mçi ngµy ng­¬i cã thÓ hoµn thµnh <color=green>10<color> lÇn nhiÖm vô, ®ång thêi nép <color=green>"..(floor(GetLevel()/10-3)*2000+2000).."<color>. Ng­¬i còng cã thÓ hñy nhiÖm vô nh­ng sè lÇn hoµn thµnh nhiÖm vô trong ngµy sÏ gi¶m. Lµm chø?","check_2","no")
		end;
end;

function   esc_1()
		MsgBox(11373,"quxiao_1","no")
end;

function   wancheng_1()
		local  renwu=GetTask(314)
		local  thistime=GetTask(315)
		local  cishu=GetTask(317)
		local  shengyu=10-cishu
		local thisday=floor(SystemTime()/86400)
		local  money=floor(GetLevel()/10-3)*2000+2000
					if(renwu==100)then							
							if(cishu>=10)and(GetTask(316)<=0)then
											Talk(1,"no",11374)
											AddOwnExp(GetLevel()*1000)
											SetTask(315,thistime+1)
											SetTask(317,0)
											SetTask(314,0)
											TopMessage("B¹n nhËn ®­îc <color=green>"..(GetLevel()*1000).."<color> kinh nghiÖm")
											if(thisday-1>=thistime)then
														SetTask(317,0)
														SetTask(315,thisday)
														SetTask(316,0)
														Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê ng­¬i cã thÓ b¾t ®Çu nhiÖm vô míi.")
											else
														Msg2Player("Ng­¬i ®· hoµn thµnh 1 lÇn nhiÖm vô thu thËp tin tøc, cã thÓ tiÕp tôc lµm thªm.")
														TaskNote(33,1)
											end;
					else
									if(GetCash()>=money)then
											Talk(1,"no","Tin tøc rÊt kÞp thêi. Sè lÇn nhiÖm vô h«m nay cßn <color=green>"..shengyu.."<color> lÇn")
											AddOwnExp(GetLevel()*200)
											Pay(money)
											TopMessage("B¹n nhËn ®­îc <color=green>"..(GetLevel()*200).."<color> kinh nghiÖm")
											SetTask(314,0)
											if(thisday-1>=thistime)then
														SetTask(317,0)
														SetTask(315,thisday)
														SetTask(316,0)
														Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê ng­¬i cã thÓ b¾t ®Çu nhiÖm vô míi.")
											else
														Msg2Player("Ng­¬i ®· hoµn thµnh 1 lÇn nhiÖm vô thu thËp tin tøc, cã thÓ tiÕp tôc lµm thªm.")
											end;
									else
											Talk(1,"no",11375)
									end;
							end;
				else
						Talk(1,"no",11376)
				end;
end;

function   quxiao_1()
		local  cishu=GetTask(317)
		local  thistime=GetTask(315)	
		local  shengyu=10-cishu
		Talk(1,"no","Ng­¬i ®· bá nhiÖm vô lÇn nµy. H«m nay cßn <color=green>"..shengyu.."<color> lÇn")
		SetTask(314,0)
		SetTask(316,1)
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
						local  i=random(1,162)
						if(i<=10)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=20)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=30)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=40)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=50)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=60)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=70)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=80)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=90)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=100)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=110)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=120)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=130)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=140)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=150)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=151)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=152)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=153)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=154)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=155)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=156)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=157)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=158)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=159)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=160)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=161)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=162)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						end;
			elseif(GetLevel()<=70)then
						local  i=random(1,171)
						if(i<=10)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=20)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=30)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=40)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=50)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=60)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=70)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=80)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=90)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=100)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=110)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=120)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=130)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=140)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=150)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=151)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=152)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=153)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=154)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=155)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=156)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=157)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=158)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=159)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=160)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=161)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=162)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						elseif(i<=163)then
								Talk(1,"no",11354)
								SetTask(314,21)
								TaskNote(33,21)
						elseif(i<=164)then
								Talk(1,"no",11355)
								SetTask(314,25)
								TaskNote(33,25)
						elseif(i<=165)then
								Talk(1,"no",11356)
								SetTask(314,26)
								TaskNote(33,26)
						elseif(i<=166)then
								Talk(1,"no",11357)
								SetTask(314,30)
								TaskNote(33,30)
						elseif(i<=167)then
								Talk(1,"no",11358)
								SetTask(314,31)
								TaskNote(33,31)
						elseif(i<=168)then
								Talk(1,"no",11359)
								SetTask(314,35)
								TaskNote(33,35)
						elseif(i<=169)then
								Talk(1,"no",11360)
								SetTask(314,36)
								TaskNote(33,36)
						elseif(i<=170)then
								Talk(1,"no",11361)
								SetTask(314,40)
								TaskNote(33,40)
						elseif(i<=171)then
								Talk(1,"no",11362)
								SetTask(314,41)
								TaskNote(33,41)
						end;
			else
						local  i=random(1,181)
						if(i<=10)then
								Talk(1,"no",11327)
								SetTask(314,5)
								TaskNote(33,5)
						elseif(i<=20)then
								Talk(1,"no",11328)
								SetTask(314,6)
								TaskNote(33,6)
						elseif(i<=30)then
								Talk(1,"no",11329)
								SetTask(314,7)
								TaskNote(33,7)
						elseif(i<=40)then
								Talk(1,"no",11330)
								SetTask(314,8)
								TaskNote(33,8)
						elseif(i<=50)then
								Talk(1,"no",11331)
								SetTask(314,9)
								TaskNote(33,9)
						elseif(i<=60)then
								Talk(1,"no",11332)
								SetTask(314,10)
								TaskNote(33,10)
						elseif(i<=70)then
								Talk(1,"no",11333)
								SetTask(314,11)
								TaskNote(33,11)
						elseif(i<=80)then
								Talk(1,"no",11334)
								SetTask(314,12)
								TaskNote(33,12)
						elseif(i<=90)then
								Talk(1,"no",11335)
								SetTask(314,13)
								TaskNote(33,13)
						elseif(i<=100)then
								Talk(1,"no",11336)
								SetTask(314,14)
								TaskNote(33,14)
						elseif(i<=110)then
								Talk(1,"no",11337)
								SetTask(314,15)
								TaskNote(33,15)
						elseif(i<=120)then
								Talk(1,"no",11338)
								SetTask(314,16)
								TaskNote(33,16)
						elseif(i<=130)then
								Talk(1,"no",11339)
								SetTask(314,17)
								TaskNote(33,17)
						elseif(i<=140)then
								Talk(1,"no",11340)
								SetTask(314,18)
								TaskNote(33,18)
						elseif(i<=150)then
								Talk(1,"no",11341)
								SetTask(314,19)
								TaskNote(33,19)
						elseif(i<=151)then
								Talk(1,"no",11342)
								SetTask(314,22)
								TaskNote(33,22)
						elseif(i<=152)then
								Talk(1,"no",11343)
								SetTask(314,23)
								TaskNote(33,23)
						elseif(i<=153)then
								Talk(1,"no",11344)
								SetTask(314,24)
								TaskNote(33,24)
						elseif(i<=154)then
								Talk(1,"no",11345)
								SetTask(314,27)
								TaskNote(33,27)
						elseif(i<=155)then
								Talk(1,"no",11346)
								SetTask(314,28)
								TaskNote(33,28)
						elseif(i<=156)then
								Talk(1,"no",11347)
								SetTask(314,29)
								TaskNote(33,29)
						elseif(i<=157)then
								Talk(1,"no",11348)
								SetTask(314,32)
								TaskNote(33,32)
						elseif(i<=158)then
								Talk(1,"no",11349)
								SetTask(314,33)
								TaskNote(33,33)
						elseif(i<=159)then
								Talk(1,"no",11350)
								SetTask(314,34)
								TaskNote(33,34)
						elseif(i<=160)then
								Talk(1,"no",11351)
								SetTask(314,37)
								TaskNote(33,37)
						elseif(i<=161)then
								Talk(1,"no",11352)
								SetTask(314,38)
								TaskNote(33,38)
						elseif(i<=162)then
								Talk(1,"no",11353)
								SetTask(314,39)
								TaskNote(33,39)
						elseif(i<=163)then
								Talk(1,"no",11354)
								SetTask(314,21)
								TaskNote(33,21)
						elseif(i<=164)then
								Talk(1,"no",11355)
								SetTask(314,25)
								TaskNote(33,25)
						elseif(i<=165)then
								Talk(1,"no",11356)
								SetTask(314,26)
								TaskNote(33,26)
						elseif(i<=166)then
								Talk(1,"no",11357)
								SetTask(314,30)
								TaskNote(33,30)
						elseif(i<=167)then
								Talk(1,"no",11358)
								SetTask(314,31)
								TaskNote(33,31)
						elseif(i<=168)then
								Talk(1,"no",11359)
								SetTask(314,35)
								TaskNote(33,35)
						elseif(i<=169)then
								Talk(1,"no",11360)
								SetTask(314,36)
								TaskNote(33,36)
						elseif(i<=170)then
								Talk(1,"no",11361)
								SetTask(314,40)
								TaskNote(33,40)
						elseif(i<=171)then
								Talk(1,"no",11362)
								SetTask(314,41)
								TaskNote(33,41)
						elseif(i<=172)then
								Talk(1,"no",11363)
								SetTask(314,42)
								TaskNote(33,42)
						elseif(i<=173)then
								Talk(1,"no",11364)
								SetTask(314,43)
								TaskNote(33,43)
						elseif(i<=174)then
								Talk(1,"no",11365)
								SetTask(314,44)
								TaskNote(33,44)
						elseif(i<=175)then
								Talk(1,"no",11366)
								SetTask(314,45)
								TaskNote(33,45)
						elseif(i<=176)then
								Talk(1,"no",11367)
								SetTask(314,46)
								TaskNote(33,46)
						elseif(i<=177)then
								Talk(1,"no",11368)
								SetTask(314,47)
								TaskNote(33,47)
						elseif(i<=178)then
								Talk(1,"no",11369)
								SetTask(314,48)
								TaskNote(33,48)
						elseif(i<=179)then
								Talk(1,"no",11370)
								SetTask(314,49)
								TaskNote(33,49)
						elseif(i<=180)then
								Talk(1,"no",11371)
								SetTask(314,50)
								TaskNote(33,50)
						elseif(i<=181)then
								Talk(1,"no",11372)
								SetTask(314,51)
								TaskNote(33,51)
						end;
			end;
			if(thisday-1>=thistime)then
					SetTask(317,1)
					SetTask(316,0)
					SetTask(315,thisday)
					Msg2Player("NhiÖm vô thu thËp tin tøc h«m qua ®· hÕt h¹n, giê ng­¬i cã thÓ b¾t ®Çu nhiÖm vô míi.")
			else
					SetTask(317,cishu+1)
					Msg2Player("B¹n nhËn nhiÖm vô Th¸m qu©n míi")
			end;

		end;
end;

function no()	
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_16; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Hoang Thien Hoa - Trieu Ca (214/184)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat chinh tuyen tai Trieu Ca. Cung Tho Hanh Ton tham gia chuoi duoc Khuong Tu Nha chi dan.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tho Hanh Ton (213/184); A Tai (217/188); Chuyen Sinh Lao Lao (212/190); Dac Ky (220/179); Ho Hy Mi (205/184)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Co nhanh Lua VNG goc trong PAK. Cac dieu kien va giao dich do nhanh goc kiem tra; chua nghiem thu toan bo nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
function pt_original()
    if pt_guard() == 0 then return end
    pt_original_main()
end

-- questfix2 2026-10-03: the VNG menus above only list quest rows (show=0 until a quest is due), so a
-- player with no quest got a dialog without any row. PTQ2_SayTask adds a "Ket thuc doi thoai" row;
-- with no visible row it shows PTQ2_FLAV (when set) or the VNG greeting with that row only.
-- Quest rows, conditions and callbacks are unchanged.
PTQ2_EXIT = "K\213t th\243c \174\232i tho\185i"
PTQ2_IDLE = "Hi\214n ta kh\171ng c\227 vi\214c g\215 c\199n nh\234 \174\213n ng\173\172i."
PTQ2_FLAV = nil
function PTQ2_Close()
	CloseDialog()
end
function PTQ2_SayTask(id, tasks)
	local n = getn(tasks)
	local vis = 0
	local ex = 0
	local c = {}
	local i = 1
	while i <= n do
		local t = tasks[i]
		c[i] = t
		if type(t) == "table" and (t.show == nil or t.show ~= 0) then
			vis = vis + 1
			local f = t[2]
			if type(f) ~= "string" then f = "" end
			f = strlower(f)
			if f == "no" or f == "cancel" or f == "oncancel" or f == "ptq2_close" or strsub(f, 1, 3) == "no_" or strsub(f, 1, 4) == "exit" or strsub(f, 1, 3) == "end" or strsub(f, 1, 5) == "close" then ex = 1 end
			if type(t[1]) == "string" and strfind(t[1], PTQ2_EXIT, 1, 1) then ex = 1 end
		end
		i = i + 1
	end
	if (vis == 0 and PTQ2_FLAV) or id == nil then
		local s = PTQ2_FLAV
		if s == nil then s = PTQ2_IDLE end
		Say(s, 1, PTQ2_EXIT .. "/PTQ2_Close")
		return
	end
	if ex == 0 then c[n + 1] = { PTQ2_EXIT, "PTQ2_Close"; show = 1 } end
	SayTask(id, c)
end

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

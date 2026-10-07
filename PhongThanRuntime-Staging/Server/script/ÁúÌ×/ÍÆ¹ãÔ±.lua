--description:npc
--author: zhujialiang
--date:2005/4/13
--modify:liuying 2005/5/26

function  main()
	Talk(1,"no","Chµo mõng ®Õn víi thÕ giíi Phong ThÇn!")
--	tasks = 
--	{
--		{"·s¤â±À¼s­û","renwu1";show=0},
--		{"¤É¯Å§¤ÃM","renwu2";show=0},
--		{"±À¼s­û»¡©ú","renwu3";show=1},
--		{"¯«¯µÂ§ª«","renwu4";show=0},
--		{"­×§ï¤H¦W","changechar";show=1}
--	}
--	UTask=GetTask(384)
--	if(UTask==0)then
--		tasks[1].show=1;
--	end;
--	if(UTask==1)then
--		tasks[2].show=1;
--	end;
--	if(UTask==2)then
--		tasks[2].show=1;
--	end;
--	if(GetExtPoint(3)==1)then
--		tasks[4].show=1;
--	end;
--	
--	SayTask("±À¼s­û¡G°Ñ»P·s¤â±À¼s­û¬¡°Êªºª±®a¥i¥H¦b§Ú³o¸Ì¿E¬¡CD-KEY¨Ã¥ß§YÀò±o¥þ®M·s¤â¸Ë³Æ¡B¥²³ÆÃÄ«~¥H¤Î<color=green>¥i¦¨ªø§¤ÃM<color>¤@¤Ç¡C\n¸Ô±¡½Ð°Ñ¨£<color=green>http://tg.kingsoft.com/<color>¡C",tasks)
end;

function  changechar()
	ChangeName(0)
end;



function  no()
	CloseDialog()
end;

function renwu3()
	Talk(1,"t1","ChØ cÇn ®¼ng cÊp cña ng­êi ch¬i kh«ng qu¸ 20, cã thÓ tham gia ho¹t ®éng T©n thñ: c¸c thµnh t×m <color=green>Sø gi¶<color> kÝch ho¹t CD-KEY vµ nhËn th­ëng. \n\n Chó ý: 7 Thµnh thÞ bao gåm: TriÒu Ca, T©y Kú, Diªu Tr×, Phong ThÇn ®µi vµ 3 T©n thñ th«n Sïng Thµnh ®¹i doanh, Ngäc H­ cung, Xi V­u mé.")
end

function t1()
	Talk(1,"no","\n\t Gi¶i th­ëng cô thÓ gåm: \n\t\ta)Mét bé trang bÞ T©n thñ: y phôc, yªu ®¸i, giµy, nãn, n¬ vµ thó c­ìi cÊp 10. \n\t\tb)Khi nh©n vËt ®¹t cÊp 25 ®Õn gÆp <color=green>Sø gi¶<color> th¨ng cÊp thó c­ìi, cao nhÊt cã thÓ ®¹t ®Õn cÊp 50. (<color=red>C¬ héi n©ng cÊp chØ cã 1 lÇn<color>)")
end

function renwu1()
	MsgBox("Chµo mõng Quý kh¸ch ®Õn víi thÕ giíi Phong ThÇn, gÇn ®©y yªu ma hoµnh hµnh, sè trang bÞ vµ d­îc phÈm nµy xin gi÷ phßng khi h÷u dông!","libao","no")
end;

function libao()
	if (GetTask(384)==0)and(GetLevel()<=20)then
		CDKeyChangeBox()
	elseif(GetLevel()>20)then
		MsgBox("Quý kh¸ch ®· h¬n cÊp 20, kh«ng thÓ ®æi quµ T©n thñ!","no")
	elseif(GetTask(384)>0)then
		MsgBox("Quý kh¸ch ®· ®æi quµ tÆng T©n thñ råi!","no")
	end;
end;

function renwu2()
	if(GetTask(384)==1)then
		MsgBox("B¹n cã thÓ n©ng cÊp thó c­ìi cÊp 10 thµnh <color=green>thó c­ìi xanh<color> t­¬ng øng víi ®¼ng cÊp, ®¼ng cÊp cµng cao thuéc tÝnh cña thó c­ìi cµng tèt, cã thÓ n©ng cao nhÊt ®Õn <color=green>cÊp 50<color>. C¬ héi chØ cã 1 lÇn, muèn n©ng cÊp kh«ng?","huanma","no")
	elseif(GetTask(384)==2)then
		MsgBox("TÆng quý kh¸ch mét con <color=green>thó c­ìi xanh<color> t­¬ng øng víi ®¼ng cÊp, ®¼ng cÊp cµng cao thuéc tÝnh thó c­ìi cµng tèt, cã thÓ n©ng ®Õn <color=green>cÊp 50<color>. C¬ héi chØ cã 1 lÇn, muèn n©ng cÊp kh«ng? ","bianlan","no")
	end;
end;

function bianlan()
	if(GetTask(384)==2)then
		local t = GetPlayerType()
		local dengji=floor(GetLevel()/5)-1
		if(dengji>9)then
				dengji=9
		end;
		AddNormalItem(0,10,t+15,dengji,1,0,1)
		SetTask(384,3)
		MsgBox("Quý kh¸ch ®· nhËn mét thó c­ìi xanh t­¬ng øng víi ®¼ng cÊp. H·y tiÕp tôc kh¸m ph¸ thÕ giíi trß ch¬i nµy!","no")
	elseif(GetTask(384)==3)then
		MsgBox("Mçi ng­êi chØ cã mét c¬ héi, quý kh¸ch ®· nhËn thó c­ìi råi!","no")
	end;		
end;

function huanma()
	if(GetTask(384)==1)and(GetLevel()>=25)then
		local t = GetPlayerType()+15
		if(HaveNormalItem(0,10,t,1)>=1)then
			local dengji=floor(GetLevel()/5)-1
			if(dengji>9)then
				dengji=9
			end;
			DelNormalItem(0,10,t,1)
			AddNormalItem(0,10,t,dengji,1,0,1)
			SetTask(384,3)
			MsgBox("Thó c­ìi cña quý kh¸ch ®· th¨ng cÊp. H·y tiÕp tôc kh¸m ph¸ thÕ giíi trß ch¬i nµy!","no")
		else
			MsgBox("Quý kh¸ch kh«ng ®em thó c­ìi cÊp 10 ®Õn, ta kh«ng thÓ gióp ®­îc!","no")
		end;
	elseif(GetTask(384)==3)then
		MsgBox("Mçi ng­êi chØ cã 1 c¬ héi th¨ng cÊp, quý kh¸ch ®· cã thó c­ìi råi!","no")
	elseif(GetLevel()<25)then
		MsgBox("Lo¹i thó c­ìi nµy ®Õn lóc quý kh¸ch ®¹t cÊp 25 míi tr­ëng thµnh. Xin h·y quay l¹i sau!","no")
	end;		
end;

function renwu4()
		if(GetSeries()==0)then
			AddNormalItem(0,0,4,1,0,0)
			Msg2Player("B¹n nhËn ®­îc 1 Hoµng Kim Tr¶m T­íng ®ao")
		elseif(GetSeries()==1)then
			AddNormalItem(0,0,6,1,0,0)
			Msg2Player("B¹n nhËn ®­îc 1 Hoµng Kim TÝch LÞch kiÕm")
		elseif(GetSeries()==2)then
			AddNormalItem(0,0,7,1,0,0)
			Msg2Player("B¹n nhËn ®­îc 1 Hoµng Kim §é ThÕ phñ")
		end;
		Talk(1,"no","Chµo mõng quý kh¸ch ®Õn thÕ giíi Phong ThÇn. Xin  tÆng b¹n 1 vò khÝ Hoµng Kim cÊp 10. Chóc quý kh¸ch ch¬i vui vÎ!")
		PayExtPoint(3,1)
end;

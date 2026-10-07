--description: ½ª×ÓÑÀ-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27



function main()
	tasks = 
	{
		{"Khuyªn hµng","renwu1";show=0},
		{"Chinh §å","renwu2";show=0},
		{"ThÇn Oanh","renwu3";show=0},
		{"Tam s¸ch","renwu4";show=0},
		{"TÊn CÊp","renwu";show=0},
		{"§«ng Di","dongyi";show=0}
	}
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if(UTask_Wizard==61)  or  (UTask_Knight==61)  or  (UTask_Druid==61)then
			tasks[4].show=1;
	end;
	if(GetPlayerType()==1)and (UTask_Wizard == 1)and(HaveEventItem(0)>=1)then
			tasks[2].show=1;
	end;
	if(GetLevel()>=45)  and  (UTask_Wizard == 20)and (GetPlayerType()==1)then
			tasks[3].show=1;
	end;
	if(GetPlayerType()==0) and (UTask_Knight ==27)then				--Íê³É¼×Ê¿25¼¶?Îñ
			tasks[1].show=1;
	end;
	if(GetLevel()>=20) and (GetTask(330)==1)and (SystemTime()<1111917600)then
			tasks[5].show=1;
	end;
	if(28==GetTask(597))or(31==GetTask(597))then
		tasks[6].show=1;
	end;
		SayTask(10395,tasks)
end;

function   renwu4()
		Talk(1,"yes_4",10396)
end;

function  renwu2()
		Talk(3,"yes_1",10397,10398,10399)
end;

function  renwu3()
		Talk(3,"yes_2",10400,10401,10402)--½ÓµÀÊ¿25¼¶?Îñ

end;

function  renwu1()
		Talk(2,"yes_3",10403,10404)
end;

function func_leave()	
		MsgBox(10405,"yes","no")
end;

function yes()	
		Talk(1,"no",10406)
		Msg2Player("NhËn lÖnh cña Kh­¬ng Tö Nha ®Õn TriÒu Ca r­íc Hoµng Thiªn Hãa vµ Thæ Hµnh T«n lªn Phong ThÇn ®µi.")
		SetTask(1,21)
		TaskNote(28,11)
end;

function yes_1()	
		Talk(2,"no",10407,10408)
			DelEventItem(0)
			AddOwnExp(300)
			Earn(30000)
			Msg2Player(" Mang th­ giíi thiÖu ®Õn Kh­¬ng Tö Nha, nhËn 300 kinh nghiÖm vµ 30000 l­îng.")
			SetTask(1,2)	--Íê³ÉµÀÊ¿5¼¶?Îñ
			TaskNote(28,1)
end;

function yes_2()	
		Talk(2,"func_leave",10409,10410)	
end;

function yes_3()	
		Talk(1,"no",10411)
			local i=random(1,2)
			AddNormalItem(0,0,30+i,4,1,0)
			if(i==1)then  
			Msg2Player(" Kh­¬ng Tö Nha ban th­ëng Xİch §ång ®ao.")
			else 
                        Msg2Player(" Kh­¬ng Tö Nha ban th­ëng TiÕu Thiªn ®ao.")
			end 
			SetTask(3,30)
			TaskNote(27,12)
end;

function yes_4()	
		Talk(2,"yes_5",10412,10413)
end;

function yes_5()	
		Talk(2,"no",10414,10415)
			if(GetPlayerType()==1)then
					SetTask(1,62)
					TaskNote(28,28)
			end;
			if(GetPlayerType()==0)then
					SetTask(3,62)
					TaskNote(27,24)
			end;
			if(GetPlayerType()==2)then
					SetTask(2,62)
					TaskNote(29,23)
			end;
			Msg2Player("§· hiÓu ®­îc chİ lín cña Kh­¬ng Tö Nha, ®i t×m Vâ V­¬ng. B¹n ®· b¾t ®Çu sø mÖnh cña m×nh!")
end;


function no()	
		CloseDialog()
end;

function  renwu()	
		if(GetTask(330)==1)then
				if(GetSeries()==0)then
					local i=random(1,2)
						if (i==1) then
							AddNormalItem(0,0,4,2,0,0)
						elseif(i==2)then
							AddNormalItem(0,0,5,2,0,0)
						end;
				elseif(GetSeries()==1)then
					AddNormalItem(0,0,6,2,0,0)
				elseif(GetSeries()==2)then
					AddNormalItem(0,0,7,2,0,0)
				end;
			SetTask(330,2)
				Talk(2,"no","ThËt vinh h¹nh ®­îc dòng sÜ tham gia, ®©y lµ nh÷ng thÇn khİ ®­îc Vâ V­¬ng trang bŞ. Hy väng nã sÏ gióp c¸c chiÕn sÜ x«ng pha trËn ®Şa nh­ hæ thªm c¸nh.","<color=red>Vâ V­¬ng<color> ®ang ®iÓm danh t­íng sÜ. Nh÷ng ng­êi trªn cÊp 35 sÏ ®­îc ®i tiªn phong! H·y cè g¾ng nhiÒu h¬n n÷a nhĞ!")			
		else
				Talk(1,"no","Ng­¬i ®· ®­îc phong chøc, cè g¾ng ®Õn cÊp 35 ®Õn t×m <color=red>Vâ V­¬ng<color> ®Ó nhËn nhiÖm vô")
		end;
end;

function dongyi()
	if(28==GetTask(597))then
		Talk(2,"no","Cöu C«ng ®Çu Chu ®ã lµ ı trêi, nh­ng gÇn ®©y D«ng Di xuÊt hiÖn nhiÒu ma thó, ta thÊy cã g× ®ã bÊt th­êng. Tr¸ng sÜ h·y gióp ta ®Õn <color=yellow>§«ng Di téc<color> gÆp §«ng Di thñ lÜnh ®Ó ®iÒu tra xem t×nh h×nh ë ®ã thÕ nµo.","<color=green>"..GetName().."<color>: NhËn ñy th¸c cña Kh­¬ng thõa t­íng!")
		SetTask(597,29)
		TaskNote(35,36)
		Msg2Player("§Õn gÆp thñ lÜnh §«ng Di t×m hiÓu lai lŞch cña ma thó.")
	elseif(31==GetTask(597)) then
		if(GetItemCount(114)>=7)then
			for i=1,7 do
				DelEventItem(114)
			end;
			SetTask(597,32)
			TaskNote(35,39)
			TaskNote(36,0)
			AddCredit(35)--ÉùÍû½±Àø
			local exp=GetNextExp()-GetExp()
			if(exp>=150000)then
				AddOwnExp(150000) --¾­Ñé½±Àø
			else
				AddOwnExp(exp) 
				AddOwnExp(150000-exp)
			end;
			Msg2Player("NhËn ®­îc 150000 ®iÓm kinh nghiÖm vµ 35 ®iÓm danh väng!")
			TopMessage("PhÇn th­ëng: <color=green>150000 ®iÓm kinh nghiÖm<color> vµ <color=green>35 ®iÓm danh väng!<color>")
			Talk(2,"no","<color=green>"..GetName().."<color>: M¶nh Ph¸p khİ nµy t¹i h¹ ®em vÒ tõ D«ng Di, xin thõa t­íng xem!","M¶nh Ph¸p Khİ nµy ®· bŞ mÊt tİch sau V¹n Tiªn trËn, sao b©y giê l¹i xuÊt hiÖn ë ®©y. Ta ph¶i lËp tøc vÒ ®éng thØnh gi¸o s­ phô. <color=green>Ng­¬i ®îi ë ®©y!<color>")
		else
			Talk(1,"no","Thu ®­îc tin tin tøc g× kh«ng?")
		end;
	end;
end;

--
--function fabao1()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp) 
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,30,1,0,0)
--		Msg2Player("»ñµÃÀëµØÑæ¹âÆì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;

--function fabao2()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp) 
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,31,1,0,0)
--		Msg2Player("»ñµÃÇàÁ«±¦É«Æì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;
--
--]]

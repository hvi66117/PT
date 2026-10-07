--description: ´Èº½µÀÈË-À¥ÂØÉ½2¼¶ÈÎÎñ
--author:  yichuan
--date: 2004/6/27

function main(sel)
	tasks = 
	{
		{"B¸ch Lı","renwu1";show=0},
		{"V¹n Tiªn trËn","renwu2";show=0},
		{"T©n Thñ tÇm b¶o","renwu";show=0}
	}
	UTask_00 = GetTask(10);
	if (UTask_00==15)then
			tasks[1].show=1;
	end;
	if(UTask_00==0) then
			tasks[1].show=1;
	end;
	SayTask(10566,tasks)
end;

function  renwu1()
	UTask_00 = GetTask(10);
	if (UTask_00==15)then
				Talk(1,"no",10567)
				AddNormalItem(1,0,1,1,0,0)
				AddNormalItem(1,0,1,1,0,0)
				AddNormalItem(1,0,1,1,0,0)
				AddNormalItem(1,3,1,1,0,0)
				AddNormalItem(1,3,1,1,0,0)
				AddNormalItem(1,3,1,1,0,0)
				TaskNote(1,8)
				Msg2Player("NhËn ®­îc 3 TiÓu Hång ®¬n vµ TiÓu Hoµn ®¬n")
				SetTask(10,16)
	end;

	if(UTask_00==0) then
				MsgBox(10568,"yes_5","no")
	end;
end;

function yes_5()
		Talk(1,"no",10569)
		Msg2Player("GÆp Xİch Tinh Tö, Nam Cùc Tiªn ¤ng, Linh B¶o ®¹i ph¸p s­ tuyÓn chän ®Ö tö xuèng nói.")
		TaskNote(1,0)
		SetTask(10,1)
end;

function  no()
		CloseDialog()
end;


---------------------
function   renwu2()
	idx = SubWorldID2Idx(69); -- È·±£µØÍ¼ÔÚÕâÌ¨·şÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØĞèµÄ±äÁ¿
		if(GetLevel()<=70)or(GetLevel()>=91)then
				Talk(1,"no","§¼ng cÊp cña ng­¬i kh«ng thİch hîp vµo V¹n Tiªn trËn (háa) giao ®Êu víi Th«ng Thiªn gi¸o chñ, thö qua trËn kh¸c xem sao!")
		elseif(HaveNormalItem(3,64,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox("Ng­¬i muèn vµo V¹n Tiªn trËn (háa) giao ®Êu víi Th«ng Thiªn gi¸o chñ kh«ng?","yes_wxz","no")
		else
				Talk(1,"no","NÕu cã Háa Linh phï th× ta sÏ ®­a ng­¬i vµo V¹n Tiªn trËn (háa) giao ®Êu víi Th«ng Thiªn gi¸o chñ? ")
		end;
end;

function  yes_wxz()
	local idx = SubWorldID2Idx(69); -- È·±£µØÍ¼ÔÚÕâÌ¨·şÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØĞèµÄ±äÁ¿

	if(GetGlobalValue(3)==1)and(GetMSPlayerCount(3,1)<50)and(GetTask(421)~=GetMissionV(1))then
		DelNormalItem(3,64,0,0)
		for i=1,60 do
			if(HaveNormalItem(3,66,0,0)>=1)then
				DelNormalItem(3,66,0,0)
			elseif(HaveNormalItem(3,67,0,0)>=1)then
				DelNormalItem(3,67,0,0)	
			elseif(HaveNormalItem(3,68,0,0)>=1)then
				DelNormalItem(3,68,0,0)
			elseif(HaveNormalItem(3,69,0,0)>=1)then
				DelNormalItem(3,69,0,0)
			else
				break;
			end;
		end;
	
		SetFightState(0)
		AddMSPlayer(3,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(69,1650,3400)
		CloseDialog()
	elseif(GetGlobalValue(3)==1)and(GetMSPlayerCount(3,1)<55)and(GetTask(421)==GetMissionV(1))then

			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;
		SetFightState(0)
		AddMSPlayer(3,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(69,1650,3400)
		CloseDialog()
	elseif(GetGlobalValue(3)==2)and(GetMSPlayerCount(3,1)<55)and(GetTask(421)==GetMissionV(1))then

			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;
		SetFightState(1)
		AddMSPlayer(3,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(69,1650,3400)
		CloseDialog()
	elseif(GetGlobalValue(3)==2)then
		Talk(1,"no","ChiÕn trËn ®ang diÔn ra, xin ®îi lÇn sau!")
	elseif(GetMSPlayerCount(3,1)>=50)then
		Talk(1,"no","Sè ng­êi bªn trong ®· ®ñ 50 ng­êi, lÇn sau quay l¹i nhĞ!")
	else
		Talk(1,"no","HiÖn nay V¹n Tiªn trËn (háa) ®· ®ãng, lÇn sau quay l¹i nhĞ!")
	end;
end;

function renwu()
	if(GetLevel()<6)then
		if(GetTask(340)==0)then
			Talk(1,"no","Ta lµ ng­êi phô tr¸ch <color=red>c¸c ho¹t ®éng<color>, hiÖn nay ho¹t ®éng ®· ng­ng. Xin xem thªm th«ng tin trªn trang chñ.")
		else
			Talk(2,"no","Tõ ®©y ®i <color=red>Ch©n nói C«n L«n, Thñ D­¬ng s¬n, T©y C«n L«n<color> cã nhiÒu ma qu¸i s¬ cÊp, ng­¬i cã thÓ giÕt chóng ®Ó tu luyÖn ®ång thêi qua ®ã nhÆt mét sè trang bŞ. §¹t <color=red>cÊp 6<color> ®Õn ®©y ta sÏ h­íng dÉn tiÕp cho ng­¬i.","Cã thÓ nhÊn <color=red>F1<color> ®Ó xem c¸c phÇn h­íng dÉn")
		end;
	elseif(GetLevel()>=6)and(GetLevel()<10)then
		Talk(2,"no","Kh«ng ngê ng­¬i tr­ëng thµnh nhanh vËy! Cho ta xem thö c¸c trang bŞ nµo!","Nghe nãi <color=red>Thñ khè<color> cã thÓ gióp ng­¬i lµm <color=red>r­¬ng ch­a ®å<color>. §¹t <color=red>cÊp 10<color> ®Õn ®©y ta sÏ h­íng dÉn b­íc kÕ tiÕp")
		Msg2Player("Giao nguyªn liÖu cho Thñ khè, nhËn ®­îc r­¬ng chøa ®å.")
		SetTask(338,1)							--338ÎªÌìÈôÓĞÇé×ÊÁÏÆ¬¸üĞÂºóÁìÈ¡´óÀñºĞµÄÅĞ¶Ï±äÁ¿
	elseif(GetLevel()>=10)and(GetLevel()<12)then
		if(GetTask(341)==0)then					--339~345ÎªÅĞ¶Ïµ±Ç°²½Öè²»ÄÜÖØ¸´½øĞĞµÄÈÎÎñ±äÁ¿
			Talk(1,"no","Chóc mõng ng­¬i ®· tr­ëng thµnh. TÆng ng­¬i <color=red>s¸ch kü n¨ng<color> nµy! §¹t <color=red>cÊp 12<color> nhí quay l¹i ®©y nhĞ.")
				if(GetSeries()==0)then
					AddNormalItem(7,25,28,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - L¨ng Ba Vi Bé.")
				elseif(GetSeries()==1)then
					AddNormalItem(7,4,7,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Tinh Th«ng L«i HÖ.")
				elseif(GetSeries()==2)then
					AddNormalItem(7,50,451,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Tr­êng Cung tÕ.")
				end;
			SetTask(338,1)		
			SetTask(341,1)		
		else
			Talk(1,"no","Chóc mõng ng­¬i ®· tr­ëng thµnh. §¹t <color=red>cÊp 12<color> nhí quay l¹i nhĞ!")
		end;		
	elseif(GetLevel()>=12)and(GetLevel()<15)then	
			Talk(1,"shenghuo","Kh«ng cã tiÒn th× ®õng nãi chuyÖn hµnh hiÖp tr­îng nghÜa, ng­¬i cßn kh«ng mau tİch gãp tiÒn b¹c ®i!")
	elseif(GetLevel()>=15)and(GetLevel()<20)then
		if(GetTask(339)==0)then	
			MsgBox("Nhê ng­¬i gióp ta chuyÓn bøc th­ nµy ®Õn cho <color=red>§¹i phu ë §«ng H¶i H¶i C©u<color>!","song","no")
		elseif(GetTask(339)==1)then
			Talk(2,"chutou","Ng­¬i cßn ch­a giao th­ cho <color=red>§¹i phu ë §«ng H¶i H¶i C©u<color> µ?","Ng­¬i cã thÓ ®Õn ®¹i phu mua <color=red>biÕn th©n phï<color>, biÕn thµnh c¸c qu¸i ®Ó chóng kh«ng thÓ tÊn c«ng, ng­¬i còng kh«ng thÓ ®¸nh chóng")
		elseif(GetTask(339)==2)then
			Talk(1,"chutou","Ta cã mét sè <color=red>Th¹ch cÇu<color> tÆng ng­¬i, lªn <color=red>cÊp tiÕp theo<color> cø ®Õn ®©y ta sÏ tÆng ng­¬i thªm <color=red>2 qu¶<color>, tuyÖt ®èi kh«ng ®­îc ®Ó v­ît cÊp ®Êy! Sau nµy ta sÏ nãi cho ng­¬i biÕt c«ng dông cña nã")		
			AddNormalItem(3,72,0,0,0,0)
			AddNormalItem(3,72,0,0,0,0)
			Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
			SetTask(339,3)
		elseif(GetTask(339)==3)and(GetLevel()>=16)and(GetLevel()<20)then
			Talk(1,"chutou","Ta cã 2 <color=red>Th¹ch cÇu<color> tÆng ng­¬i, lªn <color=red>cÊp tiÕp theo<color> cø ®Õn ®©y ta sÏ tÆng ng­¬i thªm <color=red>2 qu¶<color>, tuyÖt ®èi kh«ng ®­îc ®Ó v­ît cÊp ®Êy! Sau nµy ta sÏ nãi cho ng­¬i biÕt c«ng dông cña nã")		
			AddNormalItem(3,72,0,0,0,0)
			AddNormalItem(3,72,0,0,0,0)
			Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
			SetTask(339,4)
		elseif(GetTask(339)==4)and(GetLevel()>=17)and(GetLevel()<20)then
			Talk(1,"chutou","Ta cã 2 <color=red>Th¹ch cÇu<color> tÆng ng­¬i, lªn <color=red>cÊp tiÕp theo<color> cø ®Õn ®©y ta sÏ tÆng ng­¬i thªm <color=red>2 qu¶<color>, tuyÖt ®èi kh«ng ®­îc ®Ó v­ît cÊp ®Êy! Sau nµy ta sÏ nãi cho ng­¬i biÕt c«ng dông cña nã")		
			AddNormalItem(3,72,0,0,0,0)
			AddNormalItem(3,72,0,0,0,0)
			Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
			SetTask(339,5)	
		elseif(GetTask(339)==5)and(GetLevel()>=18)and(GetLevel()<20)then
			Talk(1,"chutou","Ta cã 2 <color=red>Th¹ch cÇu<color> tÆng ng­¬i, lªn <color=red>cÊp tiÕp theo<color> cø ®Õn ®©y ta sÏ tÆng ng­¬i thªm <color=red>2 qu¶<color>, tuyÖt ®èi kh«ng ®­îc ®Ó v­ît cÊp ®Êy! Sau nµy ta sÏ nãi cho ng­¬i biÕt c«ng dông cña nã")		
			AddNormalItem(3,72,0,0,0,0)
			AddNormalItem(3,72,0,0,0,0)
			Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
			SetTask(339,6)
		elseif(GetTask(339)==6)and(GetLevel()==19)then
			Talk(2,"chutou","<color=red>Thî §ång<color> trong th«n cø bŞ c©u hái <color=red>trøng cã tr­íc hay gµ cã tr­íc<color> lµm cho sÇu khæ. Ng­¬i h·y t×m <color=red>10 Th¹ch cÇu<color> ®Õn cho «ng ta vui. SÏ nhËn l¹i ®­îc <color=red>ViÔn Cæ phï<color>","Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <color=red>cÊp 20<color> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")					
			AddNormalItem(3,72,0,0,0,0)
			AddNormalItem(3,72,0,0,0,0)
			Msg2Player("NhËn ®­îc 2 Th¹ch cÇu.")
			Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
			SetTask(339,7)
			SetTask(338,1)
		elseif(GetTask(339)==7)then	
			Talk(2,"chutou","<color=red>Thî §ång<color> trong th«n cø bŞ c©u hái <color=red>trøng cã tr­íc hay gµ cã tr­íc<color> lµm cho sÇu khæ. Ng­¬i h·y t×m <color=red>10 Th¹ch cÇu<color> ®Õn cho «ng ta vui. SÏ nhËn l¹i ®­îc <color=red>ViÔn Cæ phï<color>","Sau khi biÕn th©n ng­¬i vÉn cã thÓ luyÖn cÊp. §¹t <color=red>cÊp 20<color> ®Õn ®©y ta sÏ h­íng dÉn thªm mét sè kü n¨ng míi.")					
			Msg2Player("§em 10 Th¹ch cÇu t×m thî ®ång ®æi ViÔn Cæ phï.")
			SetTask(338,1)			
		else
			Talk(1,"chutou","VÒ c«ng dông cña Th¹ch cÇu ta sÏ nãi víi ng­¬i sau, giê mau ®i tu luyÖn ®i!")					
		end;		
	elseif(GetLevel()>=20)and(GetLevel()<25)then
		if(GetTask(343)==0)then
			Talk(2,"chutou","Ng­¬i tiÕn bé nhanh qu¸, giê cã thÓ ®Õn <color=red>§ång Quan, M¹nh T©n, Tam S¬n Quan, Kú S¬n, Môc D· hoÆc Tr­ Lung Thµnh tr¹i<color> luyÖn cÊp.","QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i giÕt nh÷ng qu¸i cÊp cao h¬n. §¹t <color=red>cÊp 25<color> nhí quay l¹i gÆp ta nhĞ!")	
			if(GetSeries()==0)then
				AddNormalItem(7,27,30,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - Håi Phong Tr¶m.")
			elseif(GetSeries()==1)then
				AddNormalItem(7,6,9,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - B¨ng C¬ TuyÕt Cèt.")
			elseif(GetSeries()==2)then
				AddNormalItem(7,51,452,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Thiªn Vò TÕ.")
			end;
			SetTask(343,1)
			SetTask(338,1)
		else
			Talk(1,"chutou","Giê ng­¬i cã thÓ ®Õn <color=red>§ång Quan, M¹nh T©n, Tam S¬n Quan, Kú S¬n, Môc D· hoÆc Tr­ Lung Thµnh tr¹i<color> luyÖn cÊp. §¹t <color=red>cÊp 25<color> nhí quay l¹i gÆp ta nhĞ!")	
		end;	
	elseif(GetLevel()>=25)and(GetLevel()<30)then
		if(GetTask(344)==0)then
			Talk(1,"chutou","H·y ®Õn gÆp c¸c <color=red>th­¬ng nh©n<color> ®Ó kiÕm tiÒn. Sau ®ã dÉn <color=red>l¹c ®µ<color> vÒ ®©y, ta sÏ tÆng ng­¬i <color=red>ThÇn c©u<color>. Nªn nhí ph¶i dÉn l¹c ®µ ®Õn ®©y!")
			SetTask(344,1)
		elseif(GetTask(344)==1)then
			if(GetMorphType()==364)then
				Talk(1,"chutou","§©y lµ <color=red>ThÇn c©u<color> ®· theo ta nhiÒu n¨m, tÆng nã cho ng­¬i! Muèn nã nghe lÖnh ph¶i ®Õn T©y Kú t×m <color=red>Ng­êi T©y Vùc<color> xin B¸ L¹c nh·n ®Ó hãa phĞp. §¹t <color=red>cÊp 30<color> h·y quay l¹i t×m ta!.")		
					if(GetSeries()==0)then
						AddNormalItem(0,10,0,4,0,0,0)
						Msg2Player("B¹n nhËn ®­îc §éc Gi¸c Thó vµ 1 B¸ L¹c nh·n cÊp 4.")
					elseif(GetSeries()==1)then
						AddNormalItem(0,10,1,4,0,0,0)
						Msg2Player("B¹n nhËn ®­îc Th­¬ng ¦ng vµ 1 B¸ L¹c nh·n cÊp 4.")
					elseif(GetSeries()==2)then
						AddNormalItem(0,10,2,4,0,0,0)
						Msg2Player("B¹n nhËn ®­îc B¹ch V©n hå ®iÖp vµ 1 B¸ L¹c nh·n cÊp 4.")
					end;				
					AddNormalItem(3,32,0,0,0,0)
					SetTask(344,2)
					SetTask(338,1)
			else
				Talk(1,"chutou","Mau ®em <color=red>l¹c ®µ<color> ®Õn ®©y t×m ta!")						
			end;
		else
			Talk(1,"chutou","Muèn <color=red>thÇn c©u nghe lÖnh<color>, ph¶i hoµn thµnh nhiÖm vô cña <color=red>Ng­êi T©y Vùc<color>. §¹t <color=red>cÊp 30<color> h·y quay l¹i t×m ta!.")
		end;		
	elseif(GetLevel()>=30)and(GetLevel()<35)then
		if(GetTask(345)==0)then
			Talk(1,"lihe","Bªn ngoµi <color=red>T©y Kú vµ TriÒu Ca<color> cã nhiÒu <color=red>Mª cung thÇn bİ<color>. QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i vµo ®ã luyÖn c«ng hiÖu qu¶!")	
				if(GetSeries()==0)then
					AddNormalItem(7,28,31,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - §iÖn Quang Tr¶m.")
				elseif(GetSeries()==1)then
					AddNormalItem(7,8,11,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - H¹n §Şa L«i.")
				elseif(GetSeries()==2)then
					AddNormalItem(7,42,45,0,0,1)
					Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Bæ T©m Chó.")
				end;
			SetTask(345,1)
			SetTask(338,1)
		else
			Talk(1,"chutou","<color=red>Phiªn b¶n míi<color> s¾p ra m¾t, tr­íc ®ã nÕu nh­ ng­¬i ®¹t <color=red>cÊp 35<color> ta sÏ tÆng riªng 1 <color=red>lÔ vËt bÊt ngê<color>. Xin xem thªm th«ng tin trªn trang chñ.")	
		end;
	elseif(GetLevel()>=35)then
		if(GetTask(338)==1)then
			Talk(1,"chutou","Chóc mõng ng­¬i ®· ®¹t ®Õn cÊp 35! Mãn <color=red>lÔ vËt<color> nµy chøa nhiÒu bÊt ngê, nh­ng hép quµ chØ cã më sau khi phiªn b¶n míi chİnh thøc c«ng bè.")	
		else
			Talk(1,"no","Xin lçi! Ng­¬i ®· v­ît qu¸ cÊp 35 kh«ng thÓ b¸o danh tham gia <color=red>ho¹t ®éng kú nµy<color>. Xin xem thªm th«ng tin trªn trang chñ.")	
		end;
	end;
end;


function canjia()
		Talk(2,"no","Hoan nghªnh ng­¬i gia nhËp, tÆng ng­¬i <color=red> s¸ch kü n¨ng thÇn bİ<color> nµy, hiÖn t¹i ng­¬i ch­a thÓ hiÓu hÕt néi dung bªn trong, ®¹t ®ñ ®¼ng cÊp míi cã thÓ sö dông.","Tõ ®©y ®i <color=red>Ch©n nói C«n L«n, Thñ D­¬ng s¬n, T©y C«n L«n<color> cã nhiÒu ma qu¸i s¬ cÊp, ng­¬i cã thÓ giÕt chóng ®Ó tu luyÖn ®ång thêi qua ®ã nhÆt mét sè trang bŞ. §¹t <color=red>cÊp 6<color> ®Õn ®©y ta sÏ h­íng dÉn tiÕp cho ng­¬i.")
			if(GetSeries()==0)then
				AddNormalItem(7,24,27,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng gi¸p sÜ - TÕ HuyÕt Tr¶m.")
			elseif(GetSeries()==1)then
				AddNormalItem(7,0,3,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng ®¹o sÜ - Ch­ëng T©m L«i.")
			elseif(GetSeries()==2)then
				AddNormalItem(7,49,450,0,0,1)
				Msg2Player("B¹n nhËn ®­îc s¸ch kü n¨ng dŞ nh©n - Lùc SÜ TÕ.")
			end;
		SetTask(338,1)
		SetTask(340,1)
end;

function song()
		Talk(1,"chutou","Ng­¬i cã thÓ ®Õn ®¹i phu mua <color=red>biÕn th©n phï<color>, biÕn thµnh c¸c qu¸i ®Ó chóng kh«ng thÓ tÊn c«ng, ng­¬i còng kh«ng thÓ ®¸nh chóng")
		Msg2Player("Gióp Tõ Hµng ®¹o nh©n ®em th­ cho §¹i phu ë §«ng H¶i H¶i C©u.")
		SetTask(339,1)
end;

function shenghuo()
			if(GetSeries()==0)then
				Talk(1,"chutou","Ta nghe nãi <color=red>Sïng øng Loan<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô cho ng­¬i.")
				Msg2Player("T×m Sïng øng Loan häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
			elseif(GetSeries()==1)then
				Talk(1,"chutou","Ta nghe nãi <color=red>Nhiªn §¨ng ®¹o nh©n<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô cho ng­¬i.")
				Msg2Player("T×m Nhiªn §¨ng ®¹o nh©n häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
			elseif(GetSeries()==2)then
				Talk(1,"chutou","<color=red>Phong B¸<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô cho ng­¬i.")
				Msg2Player("T×m Phong B¸ häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
			end;
			SetTask(346,1)		
			SetTask(338,1)
end;

function chutou()
			if(GetExtPoint(0)==1)and(GetTask(342)==0)then	
				AddNormalItem(0,0,8,1,0,0)
				Talk(1,"no","<color=red>cuèc chim<color> lµ b¶o vËt thÇn kú, chØ ai ®· n¹p thÎ míi cã thÓ sö dông. Chóc ng­¬i may m¾n!")
				SetTask(342,1)
			else
				CloseDialog()
			end;
end;

function lihe()
		Talk(2,"chutou","B¶n lÜnh cña ng­¬i ®· ®ñ hµnh hiÖp tr­îng nghÜa, kÕt giao b»ng h÷u, s¸ng lËp l·nh ®Şa cho riªng m×nh, cã thÓ cïng víi ng­êi m×nh yªu thİch ngao du kh¾p n¬i.","<color=red>Phiªn b¶n míi<color> s¾p ra m¾t, tr­íc ®ã nÕu nh­ ng­¬i ®¹t <color=red>cÊp 35<color> ta sÏ tÆng riªng 1 <color=red>phÇn quµ bÊt ngê<color>. Xin xem thªm th«ng tin trªn trang chñ.")
end;

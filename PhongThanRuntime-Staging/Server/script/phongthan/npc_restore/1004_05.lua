-- Original VNG source payload; provenance in deployment report.
--description: ĞÌÌì
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0},
		{"Cøu TÕ","renwu2";show=0},
		{"Mao L­","renwu3";show=0},
		{"T©n Thñ tÇm b¶o","renwu";show=0}
	}
	UTask_21 = GetTask(31);
	UTask_24 = GetTask(34);
	UTask_Druid = GetTask(2);
	if (UTask_21==3) and(HaveEventItem(29)>=1)then
				tasks[1].show=1;
	end;

	if (UTask_24==5)and(HaveEventItem(30)>=1) then
				tasks[2].show=1;
	end;
	if (UTask_24==1) then
				tasks[2].show=1;
	end;
	if  (UTask_Druid==2)  and  (HaveEventItem(15)>=1)then
				tasks[3].show=1;
	end;
	if(GetLevel()>=25)  and(GetPlayerType()==2) and (UTask_Druid==0)then
				tasks[3].show=1;
	end;
	PTQ2_SayTask(10178,tasks)
end;

function  renwu1()

			Talk(1,"no",10179)
			DelEventItem(29)
			Msg2Player("Quay vÒ gÆp Cao Minh")
			TaskNote(14,3)
			SetTask(31,4)

end;

function   renwu2()
	UTask_24 = GetTask(34);
	if (UTask_24==5)and(HaveEventItem(30)>=1) then
			Talk(1,"no",10180)
			DelEventItem(30)
			Msg2Player("T×m ®­îc thøc ¨n cña dŞ nh©n, vÒ gÆp Phong B¸ häc kü n¨ng sèng.")
			TaskNote(16,5)
			SetTask(34,6)
	end;

	if (UTask_24==1) then
			MsgBox(10181,"yes_1","no")
	end;
end;

function   renwu3()
	UTask_Druid = GetTask(2);
	if  (UTask_Druid==2)  and  (HaveEventItem(15)>=1)then
						Talk(1,"no",10182)
						DelEventItem(15)
						AddOwnExp(300)
						Earn(30000)
						Msg2Player("NhËn ®­îc 300 kinh nghiÖm vµ 3w l­îng.")
						SetTask(2,10)
						TaskNote(29,2)
	end;

	if(GetLevel()>=25)  and(GetPlayerType()==2) and (UTask_Druid==0)then
				MsgBox(10183,"yes","no")
	end;
end;

function yes_1()
		Talk(1,"no",10184)
		Msg2Player("§Õn Cù Léc t×m nh÷ng ng­êi mÊt tİch.")
		TaskNote(16,1)
		SetTask(34,2)
end;

function yes()
		Talk(1,"no",10185)
		Msg2Player("TiÕp nhËn sù ñy th¸c cña H×nh Thiªn ®Õn TriÒu Ca gÆp Hå Hû MŞ lÊy thiÕp mêi dù yÕn")
		SetTask(2,1)
		TaskNote(29,0)
end;

function no()
		CloseDialog()
end;

function renwu()
	if(GetLevel()<6)then
		if(GetTask(340)==0)then
			Talk(1,"no","Hoan nghªnh ng­¬i ®Õn víi thÕ giíi trß ch¬i. Ta lµ ng­êi phô tr¸ch c¸c ho¹t ®éng <color=red>trong trß ch¬i<color>. Ng­¬i còng cã thÓ xe thªm th«ng tin trªn trang chñ")
		else
			Talk(2,"no","Tõ ®©y ®i <color=red>Du Hån, Cù Léc, Miªu C­¬ng<color> cã nhiÒu ma qu¸i s¬ cÊp, ng­¬i cã thÓ giÕt chóng ®Ó tu luyÖn ®ång thêi qua ®ã nhÆt mét sè trang bŞ, ®¹t <color=red>cÊp 6<color> ®Õn ®©y ta sÏ h­íng dÉn tiÕp cho ng­¬i.","Cã g× kh«ng hiÓu, nhÊn <color=red>F1<color> ®Ó t×m hiÓu thªm!")
		end;
	elseif(GetLevel()>=6)and(GetLevel()<10)then
		Talk(2,"no","Kh«ng ngê ng­¬i tr­ëng thµnh nhanh nh­ vËy! Cho ta xem ng­¬i ®· trang bŞ ®­îc g× nµo!","Nghe nãi <color=red>Thñ khè<color> cÇn mét sè nguyªn liÖu, ng­¬i thö ®Õn ®ã xem, kh«ng biÕt chõng «ng ta sÏ tÆng ng­¬i <color=red>r­¬ng ch­a ®å<color>. Sau khi ®¹t <color=red>cÊp 10<color> ®Õn ®©y ta sÏ h­íng dÉn b­íc kÕ tiÕp sÏ lµm g×.")
		Msg2Player("Giao nguyªn liÖu cho Thñ khè, nhËn ®­îc r­¬ng chøa ®å.")
		SetTask(338,1)							--338ÎªÌì?ÓĞÇé×ÊÁÏ¢±¸üĞÂºóÁì?´óÀñºĞµÄÅĞ¶Ï±äÁ¿
	elseif(GetLevel()>=10)and(GetLevel()<12)then
		if(GetTask(341)==0)then					--339~345ÎªÅĞ¶Ïµ±Ç°²½Öè²»ÄÜÖØ¸´½øĞĞµÄ?Îñ±äÁ¿
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
			MsgBox("Xin gióp ta chuyÓn th­ nµy cho <color=red>§¹i phu ë §«ng H¶i H¶i C©u<color>!","song","no")
		elseif(GetTask(339)==1)then
			Talk(2,"chutou","Ng­¬i ch­a giao th­ cho <color=red>§¹i phu ë §«ng H¶i H¶i C©u<color> µ?","Ng­¬i cã thÓ ®Õn chç ®¹i phu mua <color=red>BiÕn th©n phï<color>, ®Ó kh«ng bŞ qu¸i thó tÊn c«ng, ng­îc l¹i còng kh«ng thÓ ®¸nh chóng!")
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
			Talk(1,"chutou","C«ng dông cña Th¹ch cÇu ta sÏ nãi víi ng­¬i sau, giê mau ®i tu luyÖn ®i!")					
		end;		
	elseif(GetLevel()>=20)and(GetLevel()<25)then
		if(GetTask(343)==0)then
			Talk(2,"chutou","Ng­¬i tiÕn bé nhanh qu¸, giê cã thÓ ®Õn <color=red>§ång Quan, M¹nh T©n, Tam S¬n Quan, Kú S¬n, Môc D· hoÆc Tr­ Lung Thµnh tr¹i<color> tu luyÖn","QuyÓn <color=red>s¸ch kü n¨ng<color> nµy sÏ gióp ng­¬i giÕt qu¸i cã cÊp cao h¬n. §¹t <color=red>cÊp 25<color> nhí quay l¹i gÆp ta nhĞ!")	
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
			Talk(1,"chutou","Ng­¬i tiÕn bé nhanh qu¸, giê cã thÓ ®Õn <color=red>§ång Quan, M¹nh T©n, Tam S¬n Quan, Kú S¬n, Môc D· hoÆc Tr­ Lung Thµnh tr¹i<color> luyÖn cÊp. Sau khi ®¹t <color=red>cÊp 25<color> nhí quay l¹i gÆp ta nhĞ!")	
		end;	
	elseif(GetLevel()>=25)and(GetLevel()<30)then
		if(GetTask(344)==0)then
			Talk(1,"chutou","H·y ®Õn gÆp c¸c <color=red>th­¬ng nh©n<color> ®Ó kiÕm tiÒn. Sau ®ã dÉn <color=red>l¹c ®µ<color> vÒ ®©y, ta sÏ tÆng ng­¬i <color=red>ThÇn c©u<color>. Nªn nhí ph¶i dÉn l¹c ®µ ®Õn ®©y!")
			SetTask(344,1)
		elseif(GetTask(344)==1)then
			if(GetMorphType()==364)then
				Talk(1,"chutou","<color=red>ThÇn c©u<color> ®· theo ta nhiÒu n¨m. Muèn nã nghe lÖnh ph¶i ®Õn T©y Kú t×m <color=red>Ng­êi T©y Vùc<color> nhê gióp ®ì. §¹t <color=red>cÊp 30<color> h·y quay l¹i t×m ta!.")		
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
				Talk(1,"chutou","H·y mang <color=red>l¹c ®µ<color> cña ng­¬i ®Õn ®©y!")						
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
		Talk(2,"no","Hoan nghªnh ng­¬i gia nhËp, tÆng ng­¬i <color=red> s¸ch kü n¨ng thÇn bİ<color> nµy, hiÖn t¹i ng­¬i ch­a thÓ hiÓu hÕt néi dung bªn trong, ®¹t ®ñ ®¼ng cÊp míi cã thÓ sö dông.","Tõ ®©y ®i <color=red>Du Hån, Cù Léc, Miªu C­¬ng<color> cã nhiÒu ma qu¸i s¬ cÊp, ng­¬i cã thÓ giÕt chóng ®Ó tu luyÖn ®ång thêi qua ®ã nhÆt mét sè trang bŞ, ®¹t <color=red>cÊp 6<color> ®Õn ®©y ta sÏ h­íng dÉn tiÕp cho ng­¬i.")
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
		Talk(1,"chutou","Ng­¬i cã thÓ ®Õn chç ®¹i phu mua <color=red>BiÕn th©n phï<color>, ®Ó kh«ng bŞ qu¸i thó tÊn c«ng, ng­îc l¹i còng kh«ng thÓ ®¸nh chóng!")
		Msg2Player("Gióp H×nh Thiªn ®em th­ cho §¹i phu ë §«ng H¶i H¶i C©u.")
		SetTask(339,1)
end;

function shenghuo()
			if(GetSeries()==0)then
				Talk(1,"chutou","<color=red>Sïng øng Loan<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô míi cho ng­¬i.")
				Msg2Player("T×m Sïng øng Loan häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
			elseif(GetSeries()==1)then
				Talk(1,"chutou","<color=red>Nhiªn §¨ng ®¹o nh©n<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô cho ng­¬i")
				Msg2Player("T×m Nhiªn §¨ng ®¹o nh©n häc kü n¨ng sèng Bµn Cæ Khai Thiªn.")
			elseif(GetSeries()==2)then
				Talk(1,"chutou","Nghe nãi <color=red>Phong B¸<color> ®ang truyÒn thô kü n¨ng sèng <color=red>Bµn Cæ Khai Thiªn<color>. H·y mau ®Õn ®ã häc. §¹t <color=red>cÊp 15<color> ®Õn ®©y ta sÏ cã nhiÖm vô cho ng­¬i.")
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

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Hinh Thien - Xi Vuu Mo (194/200)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Mao Lu: Di Nhan gap Hinh Thien, den Trieu Ca tim Ho Hy Mi, sau do quay lai phuc menh.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tan Thu Thi Luyen (192/200); Chuyen Sinh Lao Lao (196/202); Phong Ba (195/204); Chuc Dung (193/204); Cong Cong (192/204)", 2, "Quay lai/main", "Dong/pt_close")
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

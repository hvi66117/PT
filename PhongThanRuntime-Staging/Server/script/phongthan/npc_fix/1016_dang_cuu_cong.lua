-- Phong Than npc_fix 2026-09-28: Dang Cuu Cong (deng jiugong, map 1016); original script.pak \script\SanShanGuan\DengJiuGong.lua (pinyin of GBK PAK path, bound directly before this fix); changes: exit row in SayTask; queding 597 24->25 swaps event 109 for 110 via QuestExchange (exp/credit after success); phase guards on rightall (597 ==1), srdy (597 ==11), yes_9g (597 ==26).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description:µË¾Å¹«-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/12

function  main()
	tasks = 
	{
		{"Khuyªn hµng","renwu1";show=0},
		{"ThÕ Së","renwu2";show=0},
		{"§«ng Nguy","dongyi1";show=0},
		{"Gi¸n ®iÖp","srdy";show=0},
		{"Cöu Nghi","jgyl";show=0},
		{"Hµng Chu","jggz";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		UTask_Knight = GetTask(3);
		if  (UTask_Knight==21) or(UTask_Knight==22)then
					tasks[1].show=1;
		end;
		UTask_Wizard = GetTask(1);
		if (UTask_Wizard==10)or(UTask_Wizard==11)or(UTask_Wizard==12)or(UTask_Wizard==13) then
					tasks[2].show=1;
		end;
--------------------------------¶«ÒÄÎ£»ú------------------------------------------------------------------------------
		if (GetTask(597)==1) then
			tasks[3].show=1;
		end;
--------------------------------¶«ÒÄÎ£»ú-----------------------------------------------------------------------------
--------------------------------ÉîÈëÒÄ¾³-----------------------------------------------------------------------------
		if (GetTask(597)==11) then
			tasks[4].show=1;
		end;
--------------------------------ÉîÈëÒÄ¾³-----------------------------------------------------------------------------
		if (GetTask(597)==24)and(HaveEventItem(109)>=1)then
			tasks[5].show=1;
		end;
		if(GetTask(597)==26)then
			tasks[6].show=1;
		end;
		SayTask(10363,tasks)
end;

function   renwu1()
		UTask_Knight = GetTask(3);
		if(UTask_Knight==21)then
					Talk(3,"no",10364,10365,10366)
					Msg2Player("KŞp thêi b¸o tin cho §Æng Cöu C«ng.")
					SetTask(3,UTask_Knight+2)
					TaskNote(27,7)
		elseif(UTask_Knight==22)then
					Talk(3,"no",10364,10365,10366)
					Msg2Player("KŞp thêi b¸o tin cho §Æng Cöu C«ng.")
					SetTask(3,UTask_Knight+2)
					TaskNote(27,8)
		end;
end;

function   renwu2()
					Talk(2,"dengjiugong",10635,10634)
end;

function  dengjiugong()
		UTask_Wizard = GetTask(1);
		if(UTask_Wizard==10)then
				Talk(1,"no",10367)
				SetTask(1,UTask_Wizard+4)
				Msg2Player("Dô hµng §Æng Cöu C«ng thµnh c«ng")
				TaskNote(28,5)
		elseif(UTask_Wizard==11)then
				Talk(1,"no",10367)
				SetTask(1,UTask_Wizard+4)
				Msg2Player("Dô hµng §Æng Cöu C«ng thµnh c«ng")
				TaskNote(28,8)
		elseif(UTask_Wizard==12)then
				Talk(1,"no",10367)
				SetTask(1,UTask_Wizard+4)
				Msg2Player("Dô hµng §Æng Cöu C«ng thµnh c«ng")
				TaskNote(28,7)
		elseif(UTask_Wizard==13)then
				Talk(1,"no",10367)
				SetTask(1,UTask_Wizard+4)
				Msg2Player("Dô hµng §Æng Cöu C«ng thµnh c«ng")
				TaskNote(28,9)
		end;
end;

--------------------------------¶«ÒÄÎ£»ú------------------------------------------------------------------------------
function dongyi1()
	if (GetTask(597)==1) then
		MsgBox("Lµ ng­êi cña T«n Tö Vò µ? Ng­¬i cã lßng v× n­íc khiÕn ta thËt c¶m kİch. Nh­ng tr­íc khi giao nhiÖm vô, ta  muèn kiÓm tra chót kiÕn thøc cña ng­¬i!","wenti1","no")
		SetTask(594,1)
	end;
end;

function wenti1()
	local question = {
		{
			"Ngµy nay ch­ hÇu næi lo¹n, thªm téc Di th­êng xuyªn quÊy rèi biªn c­¬ng. Kh«ng biÕt ng­¬i cã kÕ s¸ch g× hay ®Ó ®Şnh quèc an bang!",
			{"1. Téc Di tuy nhá nh­ng hiÕu chiÕn, ta nªn cö ®¹i qu©n ®¸nh diÖt 1 trËn cho tËn gèc ®Ó trõ hËu häa vÒ sau","2. Tõ khi Thµnh Thang lËp nªn nhµ Th­¬ng, Di téc ®· hßa thuËn thµnh 1 nhµ! Kh«ng nªn g©y chiÕn tranh khiÕn thiªn h¹ cµng lÇm than./right"}
		},
		{
			"Ta trÊn ¶i nµy ®· l©u, kh«ng râ l¾m vÒ t×nh h×nh ë TriÒu Ca. Ng­¬i cã thÓ cho ta biÕt vÒ t×nh h×nh ë ®ã kh«ng?",
			{"1. NÕu Cöu C«ng thËt t©m, xin h·y quay vÒ TriÒu Ca tr×nh tÊu víi Hoµng th­îng./right","2. Trô v­¬ng anh minh! LÏ nµo ta Cöu C«ng ta l¹i nghe lêi giÌm pha. /wrong",}
		},
		{
			"T« Hé ph¶n Th­¬ng cã bµi th¬ r»ng: Qu©n ho¹i thÇn c­¬ng, H÷u b¹i ngò th­êng, Kı Ch©u T« ThŞ, VÜnh h¹ triÒu Th­¬ng. C¸c h¹ ®· nghe qua bµi th¬ nµy ch­a?",
			{"1. Kı Ch©u cã lı do chİnh ®¸ng ®Ó lµm ph¶n, nh­ng søc nhá ng­êi th­a. CÇn ph¶i suy tİnh kü l­ìng./right","2. T« Hé ®¹i nghŞch bÊt ®¹o, cÇn ph¶i cö ®¹i binh chinh ph¹t. /wrong"}
		},
		{
			"Thiªn h¹ thŞnh suy ®Òu cã nguyªn do, chİnh s¸ch trŞ quèc nµo d­íi ®©y ®­îc xem lµ v­¬ng ®¹o?",
			{"1. Ph¸p lÖnh bÊt hµnh, chİnh lÖnh bÊt th«ng, dïng h×nh ph¹t trŞ d©n míi lµ v­¬ng ®¹o./wrong","2. §­îc thiªn h¹ th× lµm vua! Dïng ®øc trŞ d©n míi lµ v­¬ng ®¹o. /rightall"}
		}
		}
	local	step=GetTask(594)
	local	rank=getn(question[step][2])
	Say(question[step][1],getn(question[step][2]),question[step][2])
end;

function wrong()
	MsgBox("Ta dïng t©m can ®Ó thØnh cÇu, nh­ng h×nh nh­ ng­¬i kh«ng thµnh t©m. Ch¾c ta kh«ng cã duyªn víi hiÒn tµi råi! Hu! Hu!","no")
	SetTask(594,1)
end;

function right()
	SetTask(594,GetTask(594)+1)
	wenti1()
end;

function rightall()
	if (GetTask(597)~=1) then	-- npc_fix: phase guard
		CloseDialog()
		return
	end;
	SetTask(597,2)
	TaskNote(35,1)
	AddCredit(20)--ÉùÍû½±Àø
	AddOwnExp(2000) --¾­Ñé½±Àø
	Msg2Player("§èi tho¹i víi §Æng ThiÒn Ngäc.")
	Msg2Player("NhËn ®­îc 2000 ®iÓm kinh nghiÖm vµ 20 ®iÓm danh väng!")
	TopMessage("PhÇn th­ëng: <color=green>2000 ®iÓm kinh nghiÖm<color> vµ <color=green>20 ®iÓm danh väng<color>")
	Talk(2,"no","Ng­¬i qu¶ nhiªn tµi trİ h¬n ng­êi!","Gióp ta ®Õn <color=red>¶i Giai Méng<color> ®iÒu tra tin tøc. Tr­íc tiªn h·y ®i gÆp <color=green>§Æng ThiÒn Ngäc<color> ®Ó nhËn <color=yellow>Binh phï<color>. Con g¸i ta sÏ cho ng­¬i biÕt nh÷ng viÖc cÇn lµm")
end;
--------------------------------¶«ÒÄÎ£»ú------------------------------------------------------------------------------

--------------------------------ÉîÈëÒÄ¾³-----------------------------------------------------------------------------
function srdy()
	if (GetTask(597)~=11) then	-- npc_fix: phase guard
		CloseDialog()
		return
	end;
	Talk(1,"no","Tr¸ng sÜ ®· vÒ råi? §«ng Di qu¶ ®· cã hµnh ®éng bÊt th­êng. Xin h·y ®i th¸m thİnh thªm 1 lÇn n÷a. H·y ®Õn nhê <color=green>Ma LÔ Thä<color> ®­a qua ¶i!")
	SetTask(597,12)
	TaskNote(35,12)
	AddCredit(15)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>15 ®iÓm danh väng<color>")
	Msg2Player("Quay l¹i ¶i Giai Méng")
end;

function jgyl()
	if(HaveEventItem(109)>=1)then
		MsgBox("§«ng Di ®· quy thuËn? Hay l¾m! LÇn nµy nhê ng­¬i ®em mËt th­ cña ta ®Õn cho <color=green>Vâ V­¬ng vµ Trô V­¬ng<color>, sau ®ã quay l¹i b¸o cho ta.","queding","no")
	end;
end;

function queding()
	if(HaveEventItem(109)>=1)then
		-- npc_fix: event 109 -> 110 and task 597 24->25 in one transaction
		if (QuestExchange(597,24,25,{{4,109,0,0,0,0,1}},{{4,110,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the nhan mat thu: hanh trang khong du cho trong.")
			CloseDialog()
			return
		end;
		Talk(1,"no","<color=green>"..GetName().."<color>: Tu©n lÖnh!")
		AddCredit(15)--ÉùÍû½±Àø
		AddOwnExp(4000) --¾­Ñé½±Àø
		Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
		TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>15 ®iÓm danh väng<color>")
		Msg2Player("NhËn ®­îc mËt th­ cña §Æng Cöu C«ng!")
		Msg2Player("Tr×nh tÊu víi Vâ V­¬ng vµ Trô V­¬ng t×nh h×nh cña §«ng Di!")
		TaskNote(35,32) 
	end;
end;

function jggz()
	MsgBox("Ta suèt ®êi tËn trung b¸o quèc! TiÕc thay Trô v­¬ng h«n qu©n v« ®¹o. Xin håi b¸o víi <color=green>Vâ V­¬ng<color>, t¹i h¹ cam thuËn quy hµng","yes_9g","no")
end;

function yes_9g()
	if (GetTask(597)~=26) then	-- npc_fix: phase guard
		CloseDialog()
		return
	end;
	SetTask(597,27)
	Talk(1,"no","<color=green>"..GetName().."<color>: Tu©n lÖnh!")
	TaskNote(35,34)
	AddCredit(30)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>30 ®iÓm danh väng<color>")
	Msg2Player("Phôc mÖnh Vâ V­¬ng.")
end;
--------------------------------ÉîÈëÒÄ¾³-----------------------------------------------------------------------------

function no()
	CloseDialog()
end;

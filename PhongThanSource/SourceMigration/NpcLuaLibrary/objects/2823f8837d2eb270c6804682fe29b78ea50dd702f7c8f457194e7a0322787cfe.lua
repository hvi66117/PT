--description: ÙÈ²®Òæ
--author: yangfeng
--date: 2005/10/21

function main()
	tasks = 
	{
		{"Gióp ®ì","help";show=0},
		{"Muèn hµng","yygx";show=0},
		{"Th¸nh ®Şa","eling";show=0}
	}
	if(GetTask(597)==16)then
		tasks[1].show=1;
	end;
	if(GetTask(597)==23)then
		tasks[2].show=1;
	end;
	if(GetTask(597)==29)or(GetTask(597)==30)then
		tasks[3].show=1;
	end;
	SayTask("Ma thó vïng nµy xuÊt hiÖn ngµy cµng nhiÒu, trai tr¸ng lÇn l­ît bŞ chÕt. Cø tiÕp tôc nh­ vÇy e r»ng §«ng Di bé téc chóng ta sÏ kh«ng cßn.",tasks)
end;

function help()
	MsgBox("Tr¸ng sÜ míi ®Õn vïng nµy ­? §a t¹ ®· cøu m¹ng con g¸i ta! §Ö ®Ö <color=green>Thóc Di<color> cña ta ®ang cã viÖc cÇn gióp ®ì, tr¸ng sÜ ®Õn ®ã xem sao.","yes_1","no")
end;

function yygx()
	MsgBox("Kú thùc ta biÕt ng­¬i tõ Trung Nguyªn ®Õn ®©y ®Ó lµm gi¸n ®iÖp, nh­ng víi ta ng­¬i lµ mét ©n nh©n. Tİnh mÖnh cña Di téc ®Òu trao vµo tay ng­¬i! Xin tïy ı quyÕt ®Şnh!","yes_2","no")
end;

function yes_2()
	MsgBox("§«ng Di vèn sèng yªn b×nh, nh­ng gÇn ®©y cã mét loµi qu¸i thó ch¼ng biÕt tõ ®©u xuÊt hiÖn léng hµnh.Nhê tr¸ng sÜ liªn kÕt c¸c <color=green>®Çu lÜnh cao thñ<color> ra tay cøu b¸ t¸nh vïng nµy!","pangmang","no")
end;

function eling()
	if(GetTask(597)==29)then
		MsgBox("Vâ V­¬ng lµ vŞ minh chñ! Kh«ng biÕt ta gióp g× ®­îc cho ng­¬i lÇn nµy?","shaeling","no")
	else
		if(GetItemCount(114)<7)then
			Talk(1,"no","<color=red>B¶n TuyÒn th¸nh §Şa<color> bçng nhiªn xuÊt hiÖn mét sè loµi ¸c thó, ng­¬i cã thÓ ®Õn ®ã xem thö. Cã ng­êi ®· tõng ®¸nh qu¸i ë ®ã lÊy ®­îc <color=yellow>m¶nh ph¸p khİ<color>, gåm <color=green>7 lo¹i<color>, nh­ng hiÖn nay bŞ mÊt råi.")
		elseif(GetItemCount(114)>=7) then
			MsgBox("T¹i h¹ kiÕn thøc hÑp hßi, ch¼ng biÕt g× vÒ lai lŞch cña <color=yellow>m¶nh Ph¸p Khİ<color>. Xin ®Õn gÆp<color=green>Kh­¬ng Tö Nha<color> hái xem sao!","yes_3","no")
		end;
	end;
end;

function shaeling()
	Talk(3,"no","<color=green>"..GetName().."<color>: Mêi téc tr­ëng nãi.","B¶n TuyÒn th¸nh ®Şa bçng nhiªn xuÊt hiÖn mét sè loµi ¸c thó. Cã ng­êi ®· ®¸nh qu¸i ë ®ã lÊy ®­îc <color=yellow>m¶nh ph¸p khİ<color>, gåm <color=green>7 lo¹i<color>. Ng­¬i cã thÓ ®Õn ®ã xem thö.","<color=green>"..GetName().."<color>: NÕu vËy ta ph¶i ®i mét chuyÕn.")
	SetTask(597,30)
	AddCredit(15)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>15 ®iÓm danh väng<color>")
	TaskNote(35,37)
	Msg2Player("§Õn B¶n TuyÒn t×m 7 m¶nh Ph¸p Khİ")
end;

function yes_3()
	SetTask(597,31)
	TaskNote(35,38)
	Talk(1,"no","<color=green>"..GetName().."<color>: T¹i h¹ ®i ngay!")
	Msg2Player("Hái th¨m Kh­¬ng Tö Nha vÒ lai lŞch Ph¸p khİ!")
end;

function pangmang()
	AddEventItem(109)
	Msg2Player("NhËn ®­îc th­ cña YÓn B¸ İch")
	SetTask(597,24)
	TaskNote(35,31)
	AddCredit(30)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>30 ®iÓm danh väng<color>")
	Msg2Player("Håi b¸o §Æng Cöu C«ng!")
	Talk(2,"no","<color=green>"..GetName().."<color>: Nghe téc tr­ëng nãi, t¹i h¹ lÊy lµm hæ thÑn! T¹i h¹ t×nh nguyÖn gãp chót søc khuyÓn m·","Tr«ng cËy vµo tr¸ng sÜ!")
end;

function yes_1()
	SetTask(597,299)		
	AddCredit(25)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>25 ®iÓm danh väng<color>")
	TaskNote(35,18)
	Msg2Player("§i trî gióp YÓn Thóc Di##")
	Talk(2,"no","<color=green>"..GetName().."<color>: Tr­íc nguy c¬ cña §«ng Di téc, kh«ng thÓ ®øng khoanh tay, ta ph¶i lªn ®­êng ngay ®©y.","Tr¸ng sÜ thËt träng t×nh träng nghÜa! H·y ®Õn chç <color=green>Thóc Di<color> mét chuyÕn!")
end;

function no()
	CloseDialog()
end;

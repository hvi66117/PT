--description: ÙÈÊåÒÄ
--author: yangfeng
--date: 2005/10/21

function main()
	tasks = 
	{
		{"Gióp ®ì","help";show=0},
		{"Di Tiªn T¸n","yixs";show=0},
		{"Gi¶i nguy","xiongdi";show=0}
	}
	if(GetTask(597)==299)then
		tasks[1].show=1;
	end;
	if(GetTask(597)>=17)and(GetTask(597)<=21)then
		tasks[2].show=1;
	end;
	if(GetTask(597)==22)then
		tasks[3].show=1;
	end;
	SayTask("GÇn ®©y qu¸i thó ë §«ng Di xuÊt hiÖn ngµy cµng nhiÒu, d­îc liÖu ngµy cµng khan hiÕm, thËt ch¼ng biÕt lµm sao!",tasks)
end;

function help()
	MsgBox("Di téc hiÖn cã 3 vŞ tr¸ng sÜ v× ®¸nh qu¸i thó mµ träng th­¬ng, kh«ng cã <color=yellow>Di Tiªn T¸n<color> th× v« ph­¬ng cøu ch÷a. Ng­¬i cã thÓ gióp ta t×m kh«ng?","yes","no")
end;

function  yixs()
	if(GetTask(597)<21)then
		Talk(1,"no","Cøu ng­êi ph¶i nhanh chãng, sao ng­¬i vÉn ch­a t×m c¸c d­îc liÖu vÒ?")
	else
		if(HaveEventItem(111)>=1)and(HaveEventItem(112)>=1)and(HaveNormalItem(3,22,0,0)>=100)and(HaveNormalItem(3,23,0,0)>=100)and(HaveNormalItem(3,24,0,0)>=100)and(HaveNormalItem(3,25,0,0)>=100) then
			hecheng()
		else
			Talk(1,"no","Cøu ng­êi ph¶i nhanh chãng, sao ng­¬i vÉn ch­a t×m c¸c d­îc liÖu vÒ?")
		end;
	end;
end;

function yes()
	SetTask(597,17)
	SetTask(588,1)
	TaskNote(35,19)
	Talk(1,"no","ThËt tèt qu¸! <color=yellow>Di Tiªn T¸n<color>, <color=yellow>Tiªn Th¶o Lé<color> vµ <color=yellow>Hoµn Linh §¬n<color>, ngoµi ra cßn cÇn <color=yellow>®Şa, háa, phong, thñy<color> tø linh mçi thø <color=green>100<color> ®Ó lµm thuèc dÉn. Ng­¬i ®Õn gÆp <color=green>LiÔu Nh©n<color> vµ <color=green>YÓn Phong<color>, nhê hä gióp ®ì.")
	AddCredit(15)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>15 ®iÓm danh väng<color>")
	Msg2Player("GÆp LiÔu Nh©n vµ YÓn Phong t×m d­îc liÖu")
end;

function hecheng()
	if(HaveEventItem(111)>=1)and(HaveEventItem(112)>=1)and(HaveNormalItem(3,22,0,0)>=100)and(HaveNormalItem(3,23,0,0)>=100)and(HaveNormalItem(3,24,0,0)>=100)and(HaveNormalItem(3,25,0,0)>=100) then
		SetTask(597,22)
		SetTask(589,1)
		SetTask(590,1)
		SetTask(591,1)
		TaskNote(35,23)
		Talk(2,"no","Nhanh vËy µ? Ta bµo chÕ thuèc ®©y!","Ng­¬i h·y ®em Di Tiªn T¸n ®Õn cho 3 vŞ huynh ®Ö cña ta <color=green>YÓn Long, YÓn Hæ, YÓn Lang<color>, h·y nhanh ch©n lªn!")
		for i=1,100 do
			DelNormalItem(3,22,0,0)
			DelNormalItem(3,23,0,0)
			DelNormalItem(3,24,0,0)
			DelNormalItem(3,25,0,0)
		end;
		DelEventItem(111)
		DelEventItem(112)
		for i=1,3 do
			AddEventItem(113)		--AddÒÄÏÉÉ¢
		end;
		Msg2Player("T×m huynh ®Ö YÓn thŞ")
		AddCredit(5)--ÉùÍû½±Àø
		local exp=GetNextExp()-GetExp()
			if(exp>=100000)then
			AddOwnExp(100000) --¾­Ñé½±Àø
		else
			AddOwnExp(exp) 
			AddOwnExp(100000-exp)
		end;
		Msg2Player("NhËn ®­îc 10w ®iÓm kinh nghiÖm vµ 5 ®iÓm danh väng!")
		TopMessage("PhÇn th­ëng: <color=green>10w ®iÓm kinh nghiÖm<color> vµ <color=green>5 ®iÓm danh väng<color>!")
	else
		Talk(1,"no","Cøu ng­êi ph¶i nhanh chãng, sao ng­¬i vÉn ch­a t×m c¸c d­îc liÖu vÒ?")
	end;
end;

function xiongdi()
	if(GetTask(589)==31)and(GetTask(590)==31)and(GetTask(591)==31)then
		Talk(1,"no","Ng­¬i lµ ©n nh©n cña bé téc chóng ta, cã thÓ ®i gÆp téc tr­ëng <color=green>YÓn B¸ İch<color>!")
		SetTask(597,23)
		TaskNote(35,27)
		AddCredit(5)--ÉùÍû½±Àø
		local exp=GetNextExp()-GetExp()
			if(exp>=20000)then
			AddOwnExp(20000) --¾­Ñé½±Àø
		else
			AddOwnExp(exp) 
			AddOwnExp(20000-exp)
		end;
		Msg2Player("NhËn ®­îc 20000 ®iÓm kinh nghiÖm vµ 5 ®iÓm danh väng!")
		TopMessage("PhÇn th­ëng: <color=green>20000 ®iÓm kinh nghiÖm<color> vµ <color=green>5®iÓm danh väng<color>")
		Msg2Player("§èi tho¹i víi YÓn B¸ İch!")
	else
		Talk(1,"no","VÉn ch­a t×m thÊy 3 vi huynh ®Ö Êy µ? LÏ nµo hä l¹i gÆp ph¶i bÊt tr¾c g× råi?")
	end;
end;

function no()
	CloseDialog()
end;

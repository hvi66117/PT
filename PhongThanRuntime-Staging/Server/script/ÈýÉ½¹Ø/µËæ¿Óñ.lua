--description:µËæ¿Óñ
--author: yangfeng
--date:2005/10/18


function  main()
	if (GetTask(597)==2) then
		MsgBox("Phô th©n sai ng­¬i ®Õn? Nh­ng ta kh«ng thÓ dÔ dµng giao binh phï cho ng­¬i ®­îc. H·y chøng minh b¶n lÜnh ®·! Ra ngoµi giÕt ®ñ <color=yellow>20 Lam Cèt<color> sau ®ã quay l¹i t×m ta.","siling","no")
	elseif (GetTask(597)==3)then
		if(GetTask(598)~=100)then
			Talk(1,"no","<color=yellow>20 Lam Cèt<color> cßn ch­a ®ñ, sao ®· quay l¹i råi?")
		elseif (GetTask(598)==100)then
			bingfu()
		end;
	else
		Talk(1,"no","Phô th©n ta suèt ®êi tËn trung, vµo sinh ra tö, nh­ng còng kh«ng ®­îc Trô V­¬ng tÝn nhiÖm! Lµm con ta chØ biÕt theo cha b¸o hiÕu th«i.")
	end;
end;

function siling()
	SetTask(597,3)
	SetTask(598,20)
	Msg2Player("B¹n cÇn ph¶i giÕt 20 Lam Cèt!")
	TaskNote(35,2)
	CloseDialog()
end;

function bingfu()
	if(GetTask(597)==3)and(GetTask(598)==100)then
		SetTask(597,4)
		TaskNote(35,4)
		AddEventItem(106)	--±ø·û
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
		Msg2Player("NhËn ®­îc binh phï")
		--TopMessage("»ñµÃ<color=green>±ø·û<color>")
		Msg2Player("§Õn TriÒu Ca t×m Hoµng Phi Hæ")
		Talk(1,"no","Kh¸ l¾m! H·y mang <color=yellow>Binh Phï<color> nµy ®Õn gÆp <color=green>Vâ Thµnh V­¬ng<color> nhËn <color=yellow>Th«ng Hµnh LÖnh<color>. §Õn ¶i Giai Méng gÆp <color=green>Ma LÔ Thä<color> n¾m tin tøc qu©n t×nh. ")
	end;
end;

function no()
		CloseDialog()
end;

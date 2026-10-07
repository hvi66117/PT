--description: Â»ÐÇ--³äÔª±¦ÒÔ¼°Ôª±¦¶Ò»»Ê±¼ä¶Ò»»Í­Ç®
--author: yichuan
--date: 2005/1/8

function main()
	tasks=
	{
		{"LÊy Nguyªn B¶o","renwu1";show=0},
		{"§æi Nguyªn B¶o","renwu2";show=0},
		{"§æi tiÒn ®ång","renwu3";show=0},
		{"KiÓm tra Nguyªn B¶o","renwu4";show=0},
		{"TiÒn ®ång","renwu5";show=0},
		{"NhËn hép quµ","renwu6";show=0}---------»î¶¯½áÊø
	}
----Point±àºÅÎª2
--	if(GetExtPoint(2)>=1)then
--				tasks[1].show=1
--	end;
----ÖÁÉÙÓµÓÐÒ»¸öÔª±¦
--	if(GetTreasureCount()>=1)then
--				tasks[2].show=1;
--				tasks[3].show=1;
--	end;
--	if(GetExtPoint(3)>=1)then
--				tasks[6].show=0;
--	end;
	SayTask(11243,tasks)
end;

function no()
		CloseDialog()
end;

----È¡³öÔª±¦
function renwu1()
	if(IsHaveSpaceForTreasure(1)<1)then
				Talk(1,"no",11244)
	elseif(GetExtPoint(2)>=1)then
				MsgBox(11245,"yes_qu","no")
	else
				Talk(1,"no",11246)
	end;
end;

function   yes_qu()
	if(GetExtPoint(2)>=1)then
				PayExtPoint(2,1)
				AddTreasure(1)
				Msg2Player("B¹n ®· lÊy ra 1 Nguyªn B¶o")
				Talk(1,"no",11247)
	else
				Talk(1,"no",11246)
	end;
end;

----Ôª±¦¶Ò»»Ê±¼ä
function  renwu2()
	if(GetTreasureCount()>=1)then
			tasks1=
			{
				{"§æi giê ch¬i","dian";show=1},
				{"§æi 7 ngµy ch¬i","bao";show=1}
			}
		SayTask(11248,tasks1)
	else
		Talk(1,"no",11246)
	end;
end;

function   dian()
		MsgBox(11249,"yes_dian","no")
end;

function   bao()
		MsgBox(11250,"yes_bao","no")
end;

function  yes_bao()
	if(GetTreasureCount()>=1)then
			WasteTreasure(1)
			UseSilver(0,1,1)
			Talk(1,"no",11251)
	else
			Talk(1,"no",11246)
	end;
end;

function  yes_dian()
	if(GetTreasureCount()>=1)then
			WasteTreasure(1)
			UseSilver(0,0,1)
			Talk(1,"no",11252)
	else
			Talk(1,"no",11246)
	end;
end;

----Ôª±¦¶Ò»»Í­Ç®
function  renwu3()
	if(GetTreasureCount()>=1)then
			MsgBox("Quý kh¸ch muèn ®æi Nguyªn B¶o ra tiÒn ®ång? <color=green>1 Nguyªn B¶o<color> ®æi ®­îc <color=green>15<color> tiÒn ®ång.","yes_tong","no")
	else
			Talk(1,"no","Tµi kho¶n cña quý kh¸ch ®ang bÞ lçi, t¹m thêi kh«ng thÓ thùc hiÖn.")
	end;
end;

function  yes_tong()
	if(IsHaveSpaceForCopperCash(15)<1)then
			Talk(1,"no","Kho¶ng trèng trong r­¬ng kh«ng ®ñ.")
	elseif(GetTreasureCount()>=1)then
			WasteTreasure(1)
			AddCopperCash(15)
			UseSilver(0,2,1)
			Talk(1,"no","§æi tiÒn ®ång thµnh c«ng! Xin kiÓm tra l¹i!")
	else
			Talk(1,"no","Tµi kho¶n cña quý kh¸ch ®ang bÞ lçi, t¹m thêi kh«ng thÓ thùc hiÖn.")
	end;
end;


function   renwu4()
----ÓµÓÐµÄÔª±¦µÄ¸öÊý
	local  i=GetExtPoint(2)
	Talk(1,"no","Quý kh¸ch hiÖn göi ë ®©y <color=green>"..i.."<color> Nguyªn B¶o.")
end;

function   renwu5()
	Talk(1,"no","TiÒn ®ång cã thÓ ®æi ë ®©y! <color=green>1 Nguyªn B¶o<color> ®æi ®­îc <color=green>15 ®ång<color>. Nguyªn B¶o ®· ®æi ra tiÒn ®ång th× kh«ng thÓ ®æi l¹i!")
end;

function   renwu6()
	if(GetExtPoint(3)>=1)and(GetExtPoint(4)==0)then
		Talk(1,"no","Nh©n dÞp c«ng bè <color=red>Phiªn b¶n míi<color>, cã chót quµ nµy tÆng quý kh¸ch. Chóc ch¬i vui vÎ!")
		AddNormalItem(6,1,106,0,0,0)
		AddExtPoint(4,1)
	else
		Talk(1,"no","TÆng quý kh¸ch lÔ vËt nh©n dÞp c«ng bè Phiªn b¶n  míi. Chóc ch¬i vui vÎ!")	
	end;
end;

function   no()
	CloseDialog()
end;

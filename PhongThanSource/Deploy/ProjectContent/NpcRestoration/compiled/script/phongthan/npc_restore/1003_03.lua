-- Original VNG source payload; provenance in deployment report.
--description: ÄÏ¼«ÏÉÎÌ
--author: yichuan
--date: 2004/4/9

function main(sel)
	tasks = 
	{
		{"B¸ch Lý","renwu1";show=0},
		{"Ngò ThÊt","renwu2";show=0}
	}
		UTask_00=GetTask(10);
		if (UTask_00 == 1) or (UTask_00 == 3)or (UTask_00 == 9) or (UTask_00 == 11)then	
			tasks[1].show=1;
		end;
		UTask_01=GetTask(11);
		if(UTask_01==4)and(HaveEventItem(20)>=1)then
					tasks[2].show=1;
		end;
		if(UTask_01==2)and(HaveNormalItem(3,13,0,0)>=10)then
					tasks[2].show=1;
		end;
		if(UTask_01==0)and(GetLevel()>=3)then
					tasks[2].show=1;
		end;

	SayTask(10532,tasks)
end;

function  renwu1()
		UTask_00=GetTask(10);
		if (UTask_00 == 1)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,2)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 3)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,4)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 9)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,5)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 11)then				
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,7)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
end;

function  renwu2()
	UTask_01=GetTask(11);
	if(UTask_01==4)and(HaveEventItem(20)>=1)then
			Talk(1,"no",10534)
			Earn(600)
			AddOwnExp(500)
			SetTask(11,5)
			DelEventItem(20)
			TaskNote(2,4)
			Msg2Player("LÊy ®­îc lo¹i löa thÝch hîp, nhËn phÇn th­ëng 600 l­îng + 500 ®iÓm kinh nghiÖm cña Nam Cùc Tiªn ¤ng.")
	end;
	if(UTask_01==2)and(HaveNormalItem(3,13,0,0)>=10)then
			Talk(1,"no",10535)
			for i=1,10 do
					DelNormalItem(3,13,0,0)
			end;
			TaskNote(2,2)
			Msg2Player("§Õn gÆp Nhiªn §¨ng ®¹o nhËn löa ®em vÒ cho Nam Cùc Tiªn ¤ng.")
			SetTask(11,3)
	end;
	if(UTask_01==0)and(GetLevel()>=3)then
			MsgBox(10536,"yes_2","no")
	end;

end;

function yes_2()
		Talk(1,"no",10537)
		SetTask(11,1)
		TaskNote(2,0)
		Msg2Player("§Õn gÆp Hoµng Long ch©n nh©n lÊy 10 B¨ng c¬ cho Nam Cùc Tiªn ¤ng.")
end;

function   no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1003_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1003 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Nam Cuc Tien Ong - Ngoc Hu cung (209/191)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tien ong cua Ngoc Hu Cung, lien quan chuoi tan thu Dao Si va cac doi thoai chinh tuyen.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Nhien Dang Dao Nhan (206/192); Khao Co Hoc (208/194); Tan Thu Thi Luyen (207/195); Linh Bao Dai Phap Su (206/195); Tu Hang Dao Nhan (206/196)", 2, "Quay lai/main", "Dong/pt_close")
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

-- Original VNG source payload; provenance in deployment report.
--description: ËÎÒìÈË
--author: yichuan
--date: 2004/7/13

function main(sel)
			tasks = 
			{
				 {"Yªn Phóc","renwu1";show=0}
			}

			UTask_world_1 = GetTask(91);
			if(UTask_world_1==2)then
					 tasks[1].show=1;
			end;
			if (UTask_world_1==0) and(GetLevel()>=23) then
					 tasks[1].show=1;
			end;

	SayTask(10065,tasks)
end;

function   renwu1()
	UTask_world_1 = GetTask(91);
	if(UTask_world_1==2)then
		Talk(2,"func_dafu",10066,10067)
	end;

	if (UTask_world_1==0) and(GetLevel()>=13) then
		Talk(2,"func_ask",10068,10087)
	end;
end;

function func_ask()
		MsgBox(10088,"yes_1","no")
end;
	
function func_dafu()
		MsgBox(10076,"fault","real")
end;

function  real()
		Talk(2,"no",10089,10090)
		Earn(5000)
		SetTask(91,5)
		Msg2Player("§em tin tèt lµnh ®Õn cho Tèng DÞ nh©n, nhËn ®­îc phÇn th­ëng.")
		TopMessage("B¹n nhËn ®­îc <color=green>5000 l­îng")
		TaskNote(25,-1)
end;

function  fault()
		if(GetCash()>=500)then
			Talk(5,"no",10091,10092,10093,10094,10095)
			Pay(500)
			AddNormalItem(6,1,12,0,0,0)
			SetTask(91,3)
			Msg2Player("B»ng mäi c¸ch lÊy tÊm phï tõ chç Tèng DÞ nh©n vÒ.")
			TaskNote(25,2)
		else
			Talk(5,"no",10091,10092,10093,10094,10096)
		end;
end;

function  yes_1()	
		CloseDialog()
		SetTask(91,1)
		Msg2Player("T×m ThÇy t­íng sè, kÓ l¹i l¸ th¨m cña Tèng DÞ nh©n.")
		TaskNote(25,0)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_06; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tong Di Nhan - Trieu Ca (191/189)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong cac nhiem vu Trieu Ca. Ban doi thoai tai dung giu ten va vi tri, nhanh goc duoc uu tien neu co.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Con Bac (204/196); Ho Hy Mi (205/184); Cu Luu Ton (206/197); Chu Tiem Cam Do (209/198); Chuyen Sinh Lao Lao (212/190)", 2, "Quay lai/main", "Dong/pt_close")
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

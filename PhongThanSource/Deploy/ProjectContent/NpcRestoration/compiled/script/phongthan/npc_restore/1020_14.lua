-- Original VNG source payload; provenance in deployment report.
--description
--author: yichuan
--date:2004/7/7

function  main()
	tasks = 
	{
		{"Vi Lao","renwu1";show=0}
	}
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==0)and(GetLevel()>=57)then
			tasks[1].show=1;
	end;


			SayTask(10461,tasks)
end;

function   renwu1()
				Talk(1,"next",10462)
end;

function  next()
		Talk(3,"next1",10463,10464,10465)
end;

function  next1()
		Talk(1,"no",10466)
		Msg2Player("§Õn gÆp Ng­êi h¸i thuèc hái th¨m vÒ Huyªn th¶o.")
		TaskNote(21,0)
		SetTask(50,1)
end;

function  no()
		CloseDialog()
end;


pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_14; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tieu Bao - Tay Ky (182/194)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Hoa Dia Vi Lao, chi dan ve Vo Cat dang dung trong vong Bach Khuyen.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Vo Cat (181/195); Chuyen Sinh Lao Lao (182/192); Chuan De Dao Nhan (185/193); Nguoi Tay Vuc (185/192); A Tai (178/189)", 2, "Quay lai/main", "Dong/pt_close")
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

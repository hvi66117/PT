-- Original VNG source payload; provenance in deployment report.
--description: µ±ÆÌÀÏ°å-Ã÷Öé°µÍ¶ÈÎÎñ
--author: chensong
--date: 2004/7/13

function main(sel)
			tasks = 
			{
				 {"Minh Ch©u","renwu1";show=0}
			}

			UTask_cg_1 = GetTask(41);
			if(UTask_cg_1==1) then
					tasks[1].show=1;
			end;
			if(UTask_cg_1==10) then
					tasks[1].show=1;
			end;
			SayTask(10029,tasks)
end;

function   renwu1()

	if(UTask_cg_1==10)  then
		Talk(3,"no",10030,10031,10032)
		AddEventItem(33)
		Msg2Player("Mang B¶o ch©u ®Õn Ngäc H­ Cung nhê Cï L­u T«n gi¸m ®Þnh.")
		TaskNote(20,2)
		SetTask(41,11)
	end;
	if (UTask_cg_1==1) then
		Talk(3,"no",10033,10034,10035)
		AddEventItem(33)
		SetTask(41,2)
		Msg2Player("§Õn §å Th­ Qu¸n ë Phong ThÇn ®µi t×m tung tÝch §Þnh H¶i B¶o Ch©u.")
		TaskNote(20,1)
	end;
end;

function   no()
		CloseDialog()
end;		

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chu Tiem Cam Do - Trieu Ca (209/198)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi tiem cam do tai Trieu Ca. Khong tu dinh gia, ban hay xoa do cua nguoi choi khi chua co quy tac goc.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Diem (211/198); Cu Luu Ton (206/197); Con Bac (204/196); Thay Tuong So (214/195); Chuyen Sinh Lao Lao (212/190)", 2, "Quay lai/main", "Dong/pt_close")
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

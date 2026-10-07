-- Original VNG source payload; provenance in deployment report.
--description:Ö£Â×-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/11

function main()
	tasks = 
	{
		{"Trung Thµnh","renwu1";show=0}
	}
	UTask_Knight = GetTask(3);
	if (GetPlayerType()==0) and (UTask_Knight==1) then        --¼×Ê¿5¼¶ÈÎÎñ
			tasks[1].show=1
	end;
		SayTask(10284,tasks)
end;

function   renwu1()
			Talk(1,"no",10285)
			AddEventItem(11)
			SetTask(3,2)
			Msg2Player("Mang huyÕt th­ cña TrÞnh Lu©n vÒ cho Sïng HÇu Hæ.")
			TaskNote(27,1)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_10; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Trinh Luan - Sung Thanh doanh (200/203)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat Sung Thanh da co ten va toa do trong danh muc. Lua tai dung cho phep tra cuu dia chi va cac NPC cung map.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("To Ho (200/204); Sinh Hoat Su (199/200); Tan Thu Thi Luyen (200/199); Thuong Nhan Tay Vuc (199/199); Chuyen Sinh Lao Lao (202/199)", 2, "Quay lai/main", "Dong/pt_close")
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

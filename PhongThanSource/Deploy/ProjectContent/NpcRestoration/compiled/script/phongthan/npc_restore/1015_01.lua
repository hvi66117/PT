-- Original VNG source payload; provenance in deployment report.
--description: ·çÁÖ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function main()
	tasks = 
	{
		{"BÊt Tóy ","renwu1";show=0},
		{"Vµo s¬n cèc ","come";show=1}
	}
	UTask_Druid = GetTask(2);
	if(GetPlayerType()==2)and(GetLevel()>=35)  and  (UTask_Druid ==10 )then
			tasks[1].show=1
	end;


	SayTask(10348,tasks)
end;

function   renwu1()
			Talk(3,"func_leave",10349,10350,10351)
end;

function  func_leave()
	MsgBox(10352,"yes","no")
end;

function  yes()
	CloseDialog()
	NewWorld(15,1687,3106)--´«ËÍ½ø?É½¹È
	SetTask(2,11)
	TaskNote(29,3)
	Msg2Player("Vµo s¬n cèc, cøu bän DÞ nh©n say r­îu.")
end;

function  no()
		CloseDialog()
end;

function  come()
		NewWorld(15,1687,3106)--´«ËÍ½ø?É½¹È
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1015_01; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1015 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Phong Lam - Manh Tan (192/212)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Bat Tuy o Manh Tan; huong dan tim Ngo Long trong coc. Con lien quan Van Luong, nhung khong tu khoi tao xe luong.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Dai Phu (192/212); Thuong Hao (206/195); Ngo Long (209/195)", 2, "Quay lai/main", "Dong/pt_close")
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

-- Original VNG source payload; provenance in deployment report.
--description: ³£ê»-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"Cæ §ao ","renwu1";show=0}
	}
			UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
					tasks[1].show=1;
		end;

		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
					tasks[1].show=1;
		end;
		SayTask(10343,tasks)
end;

function  renwu1()
		UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
						Talk(1,"no",10344)
						AddEventItem(17)			
						AddNormalItem(0,0,34,4,1,0)
						SetTask(2,30)
						TaskNote(29,9)
						Msg2Player("Cøu ®­îc dÞ nh©n, nhËn ®­îc Phôc ThÕ phñ!")
		end;
		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
						Talk(3,"no",10345,10346,10347)
						SetTask(2,21)
						TaskNote(29,7)
						Msg2Player("Cøu ®­îc DÞ nh©n.")
		end;
end;

function   no()
	CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1015_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1015 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thuong Hao - Manh Tan (206/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Co Dao cua Di Nhan tai Manh Tan. Co the hoi tien trinh trong nhanh Lua goc neu co du dieu kien.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Ngo Long (209/195); Dai Phu (192/212); Phong Lam (192/212)", 2, "Quay lai/main", "Dong/pt_close")
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

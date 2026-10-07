-- Original VNG source payload; provenance in deployment report.
--description: ¶ÄÍ½-Ã÷Öé°µÍ¶ÈÎÎñ
--author: chensong
--date: 2004/7/13

function main(sel)
			tasks = 
			{
			 {"Minh Ch©u","renwu1";show=0}
			}

	UTask_cg_1 = GetTask(41);
	if (UTask_cg_1==0)  and  (GetLevel()>=43) then
				 tasks[1].show=1;
	end;
	SayTask(10036,tasks)
end;

function   renwu1()
		Talk(2,"bujie",10037,10038)

end;

function bujie()
	Talk(2,"no",10039,10040)
	Msg2Player("T×m chñ tiÖm cÇm ®å dß la tin tøc §Þnh H¶i B¶o Ch©u.")
	TaskNote(20,0)
	SetTask(41,1)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Con Bac - Trieu Ca (204/196)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat nhiem vu tai Trieu Ca. Khong tao them tro ca cuoc hoac rut tien trong ban tai dung.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Cu Luu Ton (206/197); Chu Tiem Cam Do (209/198); Thuong Diem (211/198); Chuyen Sinh Lao Lao (212/190); Thay Tuong So (214/195)", 2, "Quay lai/main", "Dong/pt_close")
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

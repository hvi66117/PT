-- Original VNG source payload; provenance in deployment report.
--description: ºóÍÁÍ¼ÌÚ-×°±¸ÏúÊÛÉÌ-ò¿ÓÈÄ¹1¼¶ÈÎÎñ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0}
	}
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
				tasks[1].show=1;
	end;		
	if (UTask_21 == 0)and(GetLevel()>=3)  then
				tasks[1].show=1;
	end;		
	SayTask(10154,tasks)
end;

function   renwu1()
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
			Talk(1,"no",10155)
			for  i=1,10 do
				DelNormalItem(3,12,0,0)
			end;
			SetTask(31,6)
			Earn(600)
			AddOwnExp(500)
			Msg2Player("Gióp HËu Thæ t×m ®ñ nguyªn liÖu, nhËn ®­îc 600 l­îng + 500 ®iÓm kinh nghiÖm.")
			TaskNote(14,5)
	end;

	if (UTask_21 == 0)and(GetLevel()>=3)  then
			MsgBox(10156,"yes_1","no")		
	end;
end;

function yes_1()
		Talk(1,"no",10157)
		Msg2Player("T×m Cao Gi¸c hái vÒ nguyªn liÖu cã thÓ t¨ng tÝnh n¨ng cña trang bÞ.")
		TaskNote(14,0)
		SetTask(31,1)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_01; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Hau Tho - Xi Vuu Mo (202/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Totem trong chuoi nhap mon Di Nhan tai Xi Vuu Mo. Lien he Thieu Hao de kiem tra tien trinh tan thu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Lao Rua (200/202); Thieu Hao (198/204); Thuong Nhan Tay Vuc (200/200); Sinh Hoat Su (200/200); Chuyen Sinh Lao Lao (196/202)", 2, "Quay lai/main", "Dong/pt_close")
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

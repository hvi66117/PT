-- Original VNG source payload; provenance in deployment report.
--description: ËãÃüÏÈÉú
--author: yichuan
--date: 2004/7/13

function main()
	tasks = 
	{
		{"Phi Tiªn","renwu1";show=0}
	}
		UTask_xq_1=GetTask(51);
		if(UTask_xq_1==1)then
					tasks[1].show=1;
		end;
		SayTask(10467,tasks)
end;

function   renwu1()
		MsgBox(10468,"yes_1","no")
end;




function yes_1()
	if(GetCash()>=1000)then
		Talk(5,"no",10469,10470,10471,10472,10473)
		Msg2Player("T×m Cao Minh hái th¨m vÞ trÝ cô thÓ cña m¶nh L­u Tinh, nhËn ®­îc B¸ L¹c Nh·n.")
		AddNormalItem(3,29,0,0,0,0)
		Pay(1000)
		TaskNote(22,1)
		SetTask(51,2)
	else
		Talk(1,"no",10474)
	end;
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thay Tuong So - Tay Ky (174/188)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi tuong so va cac nhiem vu thu cuoi. Chuc nang phu thuoc map; khong lay Lua Tay Ky de thay cho Trieu Ca.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("A Tai (178/189); Nham Dai Ca (170/195); Nham Dai Tau (170/195); Chuyen Sinh Lao Lao (182/192); Duong Tien (165/185)", 2, "Quay lai/main", "Dong/pt_close")
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

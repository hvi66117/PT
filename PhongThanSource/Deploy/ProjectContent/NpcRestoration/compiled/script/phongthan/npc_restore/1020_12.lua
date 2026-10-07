-- Original VNG source payload; provenance in deployment report.
--description:?´ó¸ç
--author: yichuan
--date: 2004/7/19

function main(sel)
	tasks = 
	{
		{"Phu Thª","renwu1";show=0}
	}
	UTask_world_2=GetTask(92);
	if(GetMorphType()==50)then
				if(UTask_world_2==2)or(UTask_world_2==4)then
						tasks[1].show=1;
				end;
	end;
	if(GetMorphType()==34)then
				if(UTask_world_2==2)or(UTask_world_2==3)then
						tasks[1].show=1;
				end;
	end;
	SayTask(10433,tasks)
end;

function  renwu1()
	UTask_world_2=GetTask(92);
	if(GetMorphType()==50)then
				if(UTask_world_2==2)or(UTask_world_2==4)then
						Talk(1,"no",10434)
						Msg2Player("NhËm ®¹i ca ®· thÊy ®­îc Phi Thè. ")
						SetTask(92,UTask_world_2+1)
				end;
	end;
	if(GetMorphType()==34)then
				if(UTask_world_2==2)or(UTask_world_2==3)then
						Talk(1,"no",10435)
						Msg2Player("NhËm ®¹i ca ®· thÊy ®­îc Ngäc n÷. ")
						SetTask(92,UTask_world_2+2)
				end;
	end;
end;


function no()	
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_12; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Nham Dai Ca - Tay Ky (170/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong nhiem vu Phu The: Nham Dai Tau nho hoan thanh tam nguyen; Duong Tien tai Tay Ky la dau moi ho tro.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Nham Dai Tau (170/195); Phu An Su (173/198); Thay Tuong So (174/188); A Tai (178/189); Loi Chan Tu (163/187)", 2, "Quay lai/main", "Dong/pt_close")
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

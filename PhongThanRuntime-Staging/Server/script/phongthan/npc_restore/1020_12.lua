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
	PTQ2_SayTask(10433,tasks)
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

-- questfix2 2026-10-03: the VNG menus above only list quest rows (show=0 until a quest is due), so a
-- player with no quest got a dialog without any row. PTQ2_SayTask adds a "Ket thuc doi thoai" row;
-- with no visible row it shows PTQ2_FLAV (when set) or the VNG greeting with that row only.
-- Quest rows, conditions and callbacks are unchanged.
PTQ2_EXIT = "K\213t th\243c \174\232i tho\185i"
PTQ2_IDLE = "Hi\214n ta kh\171ng c\227 vi\214c g\215 c\199n nh\234 \174\213n ng\173\172i."
PTQ2_FLAV = nil
function PTQ2_Close()
	CloseDialog()
end
function PTQ2_SayTask(id, tasks)
	local n = getn(tasks)
	local vis = 0
	local ex = 0
	local c = {}
	local i = 1
	while i <= n do
		local t = tasks[i]
		c[i] = t
		if type(t) == "table" and (t.show == nil or t.show ~= 0) then
			vis = vis + 1
			local f = t[2]
			if type(f) ~= "string" then f = "" end
			f = strlower(f)
			if f == "no" or f == "cancel" or f == "oncancel" or f == "ptq2_close" or strsub(f, 1, 3) == "no_" or strsub(f, 1, 4) == "exit" or strsub(f, 1, 3) == "end" or strsub(f, 1, 5) == "close" then ex = 1 end
			if type(t[1]) == "string" and strfind(t[1], PTQ2_EXIT, 1, 1) then ex = 1 end
		end
		i = i + 1
	end
	if (vis == 0 and PTQ2_FLAV) or id == nil then
		local s = PTQ2_FLAV
		if s == nil then s = PTQ2_IDLE end
		Say(s, 1, PTQ2_EXIT .. "/PTQ2_Close")
		return
	end
	if ex == 0 then c[n + 1] = { PTQ2_EXIT, "PTQ2_Close"; show = 1 } end
	SayTask(id, c)
end

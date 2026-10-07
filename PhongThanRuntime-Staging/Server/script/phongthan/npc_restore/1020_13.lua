-- Original VNG source payload; provenance in deployment report.
--description:?´óÁr
--author: yichuan
--date: 2004/7/19

function main(sel)
	tasks = 
	{
		{"Phu Thª","renwu1";show=0}
	}
	UTask_world_2=GetTask(92);
	if (UTask_world_2==5)and(GetMorphType()==249)then
			tasks[1].show=1;
	end;
	if(UTask_world_2==0)and(GetLevel()>=27)then
			tasks[1].show=1;
	end;

		PTQ2_SayTask(10436,tasks)
end;

function  renwu1()
	UTask_world_2=GetTask(92);
	if (UTask_world_2==5)then
				if(GetMorphType()==249)then
						Talk(1,"no",10437)
						AddWeightMax(20)
						AddOwnExp(5000)
						Msg2Player("Hoµn thµnh nhiÖm vô. NhËn ®­îc 5000 ®iÓm kinh nghiÖm vµ 20 ®iÓm søc lùc")
						TopMessage("NhËn ®­îc <color=green>5000<color> ®iÓm kinh nghiÖm vµ <color=green>20<color> ®iÓm søc lùc")
						TaskNote(26,5)
						SetTask(92,6)
				end;
	end;
	if(UTask_world_2==0)and(GetLevel()>=17)then
				Talk(3,"func_check",10438,10439,10440)		
	end;
end;

function func_check()
		Talk(2,"func_check1",10441,10442)
end;


function func_check1()
		MsgBox(10443,"yes_1","no")
end;

function  yes_1()
		Talk(1,"no",10444)
		Msg2Player("§Õn t×m D­¬ng TiÔn nghÜ c¸ch t×m Ngäc N÷ vµ Phi Thè")
		TaskNote(26,0)
		SetTask(92,1)
end;

function  no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_13; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Nham Dai Tau - Tay Ky (170/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nguoi giao loi nho trong Phu The o Tay Ky. Tim Nham Dai Ca va Duong Tien de theo chuoi nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Nham Dai Ca (170/195); Phu An Su (173/198); Thay Tuong So (174/188); A Tai (178/189); Loi Chan Tu (163/187)", 2, "Quay lai/main", "Dong/pt_close")
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

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

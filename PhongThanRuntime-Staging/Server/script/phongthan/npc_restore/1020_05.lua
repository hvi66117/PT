-- Original VNG source payload; provenance in deployment report.
--description:Îä¼ª
--author: yichuan
--date: 2004/7/8

function main()
	tasks = 
	{
		{"Vi Lao","renwu1";show=0}
	}
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==8)then
			tasks[1].show=1;
	end;
	if(UTask_xq_0==6)and(HaveEventItem(39)>=1)and(HaveEventItem(40)>=1)and(HaveEventItemCount(41)>=2)then
			tasks[1].show=1;
	end;
	if(UTask_xq_0==3)and(HaveEventItem(38)>=1)then
			tasks[1].show=1;
	end;
	PTQ2_SayTask(10476,tasks)
end;

function   renwu1()
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==8)then
				MsgBox(10477,"yes","no")
	end;
	if(UTask_xq_0==6)and(HaveEventItem(39)>=1)and(HaveEventItem(40)>=1)and(HaveEventItemCount(41)>=2)then
				Talk(1,"no",10478)
				DelEventItem(39)
				DelEventItem(40)
				DelEventItem(41)
				Msg2Player("Cøu Vâ C¸t, quay vÒ phôc mÖnh XÝch Tinh Tö.")
				TaskNote(21,6)
				SetTask(50,7)
	end;
	if(UTask_xq_0==3)and(HaveEventItem(38)>=1)then
				Talk(2,"yes_1",10479,10480)
				DelEventItem(38)
				Msg2Player("BiÕt Vâ C¸t ®ang muèn vÒ th¨m mÑ. §Õn Ngäc H­ Cung thØnh gi¸o XÝch Tinh Tö")
				TaskNote(21,3)
				SetTask(50,4)
	end;
end;

function  yes()
		Msg2Player("§i t×m XÝch Tinh Tö")
		TaskNote(21,7)
		SetTask(50,4)
		CloseDialog()
end;

function  yes_1()
		Talk(3,"no",10481,10482,10483)
end;

function no()	
		CloseDialog()
end;



pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Vo Cat - Tay Ky (181/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat Hoa Dia Vi Lao o Tay Ky. Lien he Tieu Bao va Xich Tinh Tu tai Ngoc Hu Cung.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tieu Bao (182/194); Chuyen Sinh Lao Lao (182/192); Chuan De Dao Nhan (185/193); Nguoi Tay Vuc (185/192); A Tai (178/189)", 2, "Quay lai/main", "Dong/pt_close")
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
PTQ2_FLAV = "Hu! Hu!... B\222 nh\232t trong v\223ng tr\223n n\181y, ta ch\188ng c\223n l\223ng d\185 n\181o m\181 n\227i chuy\214n."
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

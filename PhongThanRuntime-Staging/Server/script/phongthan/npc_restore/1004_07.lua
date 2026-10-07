-- Original VNG source payload; provenance in deployment report.
--description: ¸ßÃ÷-Ç§ÀïÑÛ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"ThÇn KhÝ","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"Phi Tiªn","renwu3";show=0}
	}
	UTask_25 = GetTask(35);
	UTask_21 = GetTask(31);
	UTask_xq_1 = GetTask(51);
	if (UTask_25==2) then
			tasks[1].show=1;
	end;
	if (UTask_21==4) then
			tasks[2].show=1;
	end;
	if (UTask_21==2) then
			tasks[2].show=1;
	end;
	if(UTask_xq_1==2)then
			tasks[3].show=1;
	end;
	PTQ2_SayTask(10146,tasks)
end;

function  renwu1()

		Talk(1,"no",10147)
		Msg2Player("§Õn Miªu C­¬ng diÖt trõ Th¶o Tiªn bµ bµ, ®o¹t l¹i m¶nh ThÇn KhÝ. ")
		TaskNote(17,2)
		SetTask(35,3)
end;

function   renwu2()
	UTask_21 = GetTask(31);
	if (UTask_21==4) then
		Talk(1,"no",10148)
		Msg2Player("BiÕt ®­îc nguyªn liÖu cÇn t×m lµ MÆt Quû. T×m 10 MÆt Quû sau ®ã ®Õn HËu Thæ phôc mÖnh.")
		TaskNote(14,4)
		SetTask(31,5)
	end;
	if (UTask_21==2) then
		Talk(1,"no",10149)
		AddEventItem(29)
		Msg2Player("Tr­íc tiªn gióp Cao Minh chuyÓn th­ cho H×nh Thiªn.")
		TaskNote(14,2)
		SetTask(31,3)
	end;
end;

function   renwu3()

		Talk(1,"no",10150)
		Msg2Player("ChuÈn bÞ ®Õn sa m¹c t×m Tr­ Tinh ®Ó lÊy m¶nh L­u tinh")
		TaskNote(22,2)
		SetTask(51,3)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_07; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Cao Minh - Xi Vuu Mo (206/198)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat ho tro dieu tra trong chuoi Di Nhan va nhiem vu hop thanh thu cuoi; Cao Giac la dau moi lien quan.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Cao Giac (205/197); Thuong Nhan Tay Vuc (200/200); Sinh Hoat Su (200/200); Hau Tho (202/204); Lao Rua (200/202)", 2, "Quay lai/main", "Dong/pt_close")
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

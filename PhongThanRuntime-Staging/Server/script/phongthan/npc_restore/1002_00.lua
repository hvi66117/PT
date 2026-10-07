-- Original VNG source payload; provenance in deployment report.
--description: À’ª§
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"HÈp g m","renwu1";show=0}
	}
			UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			tasks[1].show=1;
		end;
		if(UTask_10==0) then
			tasks[1].show=1;
		end;
		PTQ2_SayTask(10271,tasks)
end;

function   renwu1()	
		UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			Talk(1,"no",10272)
			DelEventItem(26)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			Msg2Player("GiÛp T´ HÈ l y hÈp g m, nhÀn ph«n th≠Îng 3 Ti”u HÂng Æ¨n vµ 3 Ti”u Hoµn Æ¨n.")
			TaskNote(7,10)
			SetTask(20,19)
		end;
		if(UTask_10==0) then
			MsgBox(10273,"yes_1","no")
		end;	
end;

function yes_1()
		Talk(1,"no",10274)
		Msg2Player("ß’n ThÒ khË l y hÈp g m v“ cho T´ HÈ.")
		TaskNote(7,0)
		SetTask(20,1)
end;

function no()
		CloseDialog()
end;

-- Reviewed project quest transaction compatibility.
-- Project compatibility appendix; append AFTER the unchanged VNG Su Ho Lua.
-- Source: script.pak /script/Â¥áÂüéÂ§ßËê•/ËãèÊä§.lua
-- Original SHA256: c44b9f6b28692d77a4a4c6f51d35ebb6a509241e0be102d7b7c78eb4b026460c
-- Keeps task 20, EventItem 26, message IDs and all original reward tuples.
-- QuestExchange is a server API: reserve rewards, consume requirements and
-- advance the expected task phase together. A failed exchange changes nothing.
function renwu1()
    local phase = GetTask(20)
    if phase == 0 then
        MsgBox(10273, "yes_1", "no")
        return
    end
    if phase ~= 18 then
        CloseDialog()
        return
    end
    if QuestExchange(20, 18, 19,
        {{4, 26, 0, 0, 0, 0, 1}},
        {{1, 0, 1, 1, 0, 0, 3}, {1, 3, 1, 1, 0, 0, 3}}) ~= 1 then
        Msg2Player("Chua the nhan thuong: can Hop Gam va cho trong hanh trang.")
        CloseDialog()
        return
    end
    Talk(1, "no", 10272)
    Msg2Player("Giao Hop Gam cho To Ho: nhan 3 Tieu Hong don va 3 Tieu Hoan don.")
    TaskNote(7, 10)
end

function yes_1()
    if QuestExchange(20, 0, 1, {}, {}) ~= 1 then
        CloseDialog()
        return
    end
    Talk(1, "no", 10274)
    Msg2Player("Den Thu Kho lay Hop Gam ve cho To Ho.")
    TaskNote(7, 0)
end

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_00; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("To Ho - Sung Thanh doanh (200/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi nhiem vu tan thu Giap Si. Hop Gam bat dau tai To Ho, sau do den Thu Kho trong Sung Thanh Doanh.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Trinh Luan (200/203); Sinh Hoat Su (199/200); Tan Thu Thi Luyen (200/199); Thuong Nhan Tay Vuc (199/199); Chuyen Sinh Lao Lao (202/199)", 2, "Quay lai/main", "Dong/pt_close")
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

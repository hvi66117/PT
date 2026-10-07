-- Original VNG source payload; provenance in deployment report.
--description: ÍÀÃÔ
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"HÈp g m","renwu1";show=0},
		{"DÚng ßao","renwu2";show=0}
	}
	UTask_10 = GetTask(20);
	UTask_15=GetTask(25);

	if (UTask_10 == 10) or(UTask_10==11)or (UTask_10==12)or(UTask_10==13) then	
				tasks[1].show=1;
	end;

	if(HaveEventItem(24)>=1)and(UTask_15==3)then
				tasks[2].show=1;
	end;
	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==1)then
				tasks[2].show=1;
	end;
	if(UTask_15 ==0)and  (GetPlayerType()==0)and(GetLevel()>=7)then
				tasks[2].show=1;
	end;
	PTQ2_SayTask(10231,tasks)
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if (UTask_10 == 10)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,4)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==11)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,7)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==12)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,6)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==13) then				
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,8)
			SetTask(20,UTask_10+4)
	end;
end;

function    renwu2()
	UTask_15=GetTask(25);
	if(HaveEventItem(24)>=1)and(UTask_15==3)then
			Talk(1,"no",10233)
			DelEventItem(24)
			local n=random(0,5);				
			AddNormalItem(0,4,n,1,0,0)
			AddCredit(10)
			Msg2Player("NhÀn Æ≠Óc ph∏p b∂o c p 10")
			TaskNote(11,10)
			SetTask(25,4)
	end;
	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==1)then
			Talk(1,"no",10234)
			Msg2Player("NhÍ ¢u Thi™n H„a giÛp tu s˜a b∂o Æao.")
			TaskNote(11,8)
			SetTask(25,2)
	end;
	if(UTask_15 ==0)and  (GetPlayerType()==0)and(GetLevel()>=7)then
			MsgBox(10235,"yes_2","no")
	end;
end;

function yes_2()
		Talk(1,"no",10236)
		Msg2Player("ßi Y’n S¨n gi’t H∂i c»u v≠¨ng, l y m∂nh b∂o Æao.")
		TaskNote(11,0)
		SetTask(25,1)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_06; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Trieu Dien - Sung Thanh doanh (218/198)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tiep nhan cac bo phan dao trong chuoi Dung Dao, sau do huong dan toi tho ren.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Diem (218/197); Trieu Loi (216/197); Sung Hac Ho (213/200); Sung Ung Loan (212/198); Sung Ung Buu (211/198)", 2, "Quay lai/main", "Dong/pt_close")
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

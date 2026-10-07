-- Original VNG source payload; provenance in deployment report.
--description: ËÎÒìÈË
--author: yichuan
--date: 2004/7/13

function main(sel)
			tasks = 
			{
				 {"Yªn Phóc","renwu1";show=0}
			}

			UTask_world_1 = GetTask(91);
			if(UTask_world_1==2)then
					 tasks[1].show=1;
			end;
			if (UTask_world_1==0) and(GetLevel()>=23) then
					 tasks[1].show=1;
			end;

	PTQ2_SayTask(10065,tasks)
end;

function   renwu1()
	UTask_world_1 = GetTask(91);
	if(UTask_world_1==2)then
		Talk(2,"func_dafu",10066,10067)
	end;

	if (UTask_world_1==0) and(GetLevel()>=13) then
		Talk(2,"func_ask",10068,10087)
	end;
end;

function func_ask()
		MsgBox(10088,"yes_1","no")
end;
	
function func_dafu()
		MsgBox(10076,"fault","real")
end;

function  real()
		Talk(2,"no",10089,10090)
		Earn(5000)
		SetTask(91,5)
		Msg2Player("§em tin tèt lµnh ®Õn cho Tèng DÞ nh©n, nhËn ®­îc phÇn th­ëng.")
		TopMessage("B¹n nhËn ®­îc <color=green>5000 l­îng")
		TaskNote(25,-1)
end;

function  fault()
		if(GetCash()>=500)then
			Talk(5,"no",10091,10092,10093,10094,10095)
			Pay(500)
			AddNormalItem(6,1,12,0,0,0)
			SetTask(91,3)
			Msg2Player("B»ng mäi c¸ch lÊy tÊm phï tõ chç Tèng DÞ nh©n vÒ.")
			TaskNote(25,2)
		else
			Talk(5,"no",10091,10092,10093,10094,10096)
		end;
end;

function  yes_1()	
		CloseDialog()
		SetTask(91,1)
		Msg2Player("T×m ThÇy t­íng sè, kÓ l¹i l¸ th¨m cña Tèng DÞ nh©n.")
		TaskNote(25,0)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_06; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tong Di Nhan - Trieu Ca (191/189)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong cac nhiem vu Trieu Ca. Ban doi thoai tai dung giu ten va vi tri, nhanh goc duoc uu tien neu co.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Con Bac (204/196); Ho Hy Mi (205/184); Cu Luu Ton (206/197); Chu Tiem Cam Do (209/198); Chuyen Sinh Lao Lao (212/190)", 2, "Quay lai/main", "Dong/pt_close")
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
PTQ2_FLAV = "Duy\170n ph\203n ch\173a t\237i, ng\173\172i h\183y quay l\185i sau."
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

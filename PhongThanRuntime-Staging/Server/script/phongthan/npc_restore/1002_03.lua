-- Original VNG source payload; provenance in deployment report.
--description: ³ç¾üÍ­½³
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0},
		{"Kiªm ¸i","renwu2";show=0},
		{"Dòng §ao","renwu3";show=0}
	}
	UTask_11 = GetTask(21);
	UTask_14= GetTask(24);
	UTask_15=GetTask(25);
	if (UTask_11 == 7)  then		
			tasks[1].show=1;
	end;
	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
			tasks[1].show=1;
	end;
	if(UTask_11 == 1)  then
			tasks[1].show=1;
	end;

	if(UTask_14 ==1)then		
			tasks[2].show=1;
	end;

	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==2)then
			tasks[3].show=1;
	end;

	PTQ2_SayTask(10276,tasks)
end;

function   renwu1()
	UTask_11 = GetTask(21);
	if (UTask_11 == 7)  then		
				Talk(1,"no",10277)
				Msg2Player("VÒ gÆp Lç Hïng phôc mÖnh.")
				TaskNote(8,7)
				SetTask(21,8)
	end;
	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
				Talk(1,"no",10278)
				for i=1,10 do 
						DelNormalItem(3,10,0,0)
				end;
				Msg2Player("T×m Sïng HÇu Hæ ®æi nguyªn liÖu.")
				TaskNote(8,3)
				SetTask(21,4)
	end;
	if(UTask_11 == 1)  then
				Talk(1,"no",10279)
				Msg2Player("§ t×m Sïng øng B­u.")
				TaskNote(8,1)
				SetTask(21,2)	
	end;
end;

function   renwu2()
				Talk(1,"no",10280)
				Msg2Player("GiÕt H¶i cÈu tinh sÏ nhËn ®­îc cuèc.")
				TaskNote(10,1)
				SetTask(24,2)
end;

function   renwu3()

				Talk(1,"no",10281)
				DelEventItem(21)
				DelEventItem(22)
				DelEventItem(23)
				AddEventItem(24)
				Msg2Player("Dòng §ao t¸i xuÊt giang hå!")
				TaskNote(11,9)
				SetTask(25,3)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Au Thien Hoa - Sung Thanh doanh (206/196)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tho ren trong chuoi Tan Thuc, Dung Dao va Kiem Ai. Co lien quan den sua vu khi; khong tu tao cong thuc ren khi chua co du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tap Hoa Thuong Nhan (207/198); Lao Rua (202/197); Thu Kho (202/198); Chuyen Sinh Lao Lao (202/199); Sung Ung Buu (211/198)", 2, "Quay lai/main", "Dong/pt_close")
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

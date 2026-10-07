-- Original VNG source payload; provenance in deployment report.
--description: ×£ÈÚÍ¼ÌÚ-½ÌÁ·-ò¿ÓÈÄ¹10¼¶ÈÎÎñ
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"ThÇn KhÝ","renwu2";show=0}
	}

	UTask_20 = GetTask(30);
	UTask_25 = GetTask(35);
	if (UTask_20==1) or (UTask_20==3)or (UTask_20==5)or(UTask_20==7)then
			tasks[1].show=1;
	end;

	if (UTask_25==7) and (HaveEventItem(27)>=1) then
				tasks[2].show=1;
	end;

	if (UTask_25==0) and(GetPlayerType()==2)and(GetLevel()>=7) then
				tasks[2].show=1;
	end;

	PTQ2_SayTask(10218,tasks)
end;

function   renwu1()
	UTask_20 = GetTask(30);
	if(UTask_20==1)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,2)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==3)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,6)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==5)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,4)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==7)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,7)
			SetTask(30,UTask_20+8)
	end;
end;

function   renwu2()
	UTask_25 = GetTask(35);
	if (UTask_25==7) and (HaveEventItem(27)>=1) then
			Talk(1,"no",10220)
			DelEventItem(27)
			local n=random(0,5);				
			AddNormalItem(0,4,n,1,0,0)
			AddCredit(10)
			SetTask(35,8)
			Msg2Player("NhËn ®­îc mét ph¸p b¶o cÊp 10.")
			TaskNote(17,7)
	elseif (UTask_25==0) and(GetPlayerType()==2)and(GetLevel()>=7) then
			MsgBox(10221,"yes_1","no")
	end;
end;

function yes_1()
	Talk(1,"no",10222)
	SetTask(35,1)
	Msg2Player("§i t×m Céng C«ng hái tin tøc cña  ThÇn KhÝ.")
	TaskNote(17,0)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chuc Dung - Xi Vuu Mo (193/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Totem Chuc Dung tai Xi Vuu Mo. Dung Lua theo totem cua map nay, khong dung Lua Chuc Dung o Vien Co.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Cong Cong (192/204); Ho Tro Tan Thu (194/205); Phong Ba (195/204); Chuyen Sinh Lao Lao (196/202); Hinh Thien (194/200)", 2, "Quay lai/main", "Dong/pt_close")
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

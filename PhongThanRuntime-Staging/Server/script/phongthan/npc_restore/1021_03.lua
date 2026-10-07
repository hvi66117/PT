-- Original VNG source payload; provenance in deployment report.
--description: ËãÃüÏÈÉú-×°±¸Á¶»¯ÈÎÎñ
--author: chensong
--date: 2004/7/12

function main(sel)
			tasks = 
			{
				{"Yªn Phóc","renwu1";show=0},
				{"gäi Thó BiÕn Th©n","bs";show=0}
			}
			UTask_world_1 = GetTask(91)
			UTask_cg_0 = GetTask(40);

			if(UTask_world_1==3)and(HaveNormalItem(6,1,12,0)>=1)then
				tasks[1].show=1;
			end;
			if(UTask_world_1 ==1)then
				tasks[1].show=1;
			end;
			if(GetPlayerType()==2)then
				tasks[2].show=1;
			end;			
			PTQ2_SayTask(10097,tasks)
end;


function   renwu1()
	UTask_world_1 = GetTask(91)
	if(UTask_world_1==3)and(HaveNormalItem(6,1,12,0)>=1)then
		Talk(5,"no",10098,10099,10100,10101,10102)
		SetTask(91,4)
		DecCredit(1)
		Msg2Player("BÞ ThÇy t­íng sè ®uæi ®i, ®iÓm danh väng gi¶m xuèng.")
		TaskNote(25,3)
	end;
	if(UTask_world_1 ==1)then
		Talk(3,"no",10103,10104,10105)
		SetTask(91,2)
		Msg2Player("Th× ra Tèng DÞ nh©n ®ang ®­îc vËn may nµy, nãi cho «ng ta biÕt? Hay lµ......")
		TaskNote(25,1)
	end;
end;

function no()
		CloseDialog()
end;

function  bs()
		Say(10106,3,"Hoµng Kim Cù Nh©n/m1","ThiÕt Thè/m2","Anh Vò/m3")
end;

function  m1()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,359)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;

function  m2()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,408)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;

function  m3()
		local  skill,type = GetCreatureInfo()
		if(type<0)then
				Talk(1,"no",10107)
		else
				if(GetCash()>=9000)then
						Pay(9000)
						SetCreatureType(skill,409)
						CloseDialog()
				else
						Talk(1,"no",10108)
				end;
		end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thay Tuong So - Trieu Ca (214/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi tuong so va cac nhiem vu thu cuoi. Chuc nang phu thuoc map; khong lay Lua Tay Ky de thay cho Trieu Ca.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Diem (211/198); Chuyen Sinh Lao Lao (212/190); Chu Tiem Cam Do (209/198); A Tai (217/188); Cu Luu Ton (206/197)", 2, "Quay lai/main", "Dong/pt_close")
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

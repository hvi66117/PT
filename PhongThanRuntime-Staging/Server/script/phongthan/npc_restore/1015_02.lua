-- Original VNG source payload; provenance in deployment report.
--description: ÎâÁú-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"BÊt Tóy ","renwu1";show=0}
	}
			UTask_Druid = GetTask(2);
		if(GetPlayerType()==2)and (UTask_Druid==11)then
					tasks[1].show=1;
		end;
		if(GetLevel()>=35)  and  (UTask_Druid==13)  and  (HaveEventItem(16)>=1)then
					tasks[1].show=1;
		end;
		PTQ2_SayTask(10354,tasks)
end;

function   renwu1()
		UTask_Druid = GetTask(2);
		if(GetPlayerType()==2)and (UTask_Druid==11)then
						Talk(4,"no",10355,10356,10357,10358)
						SetTask(2,12)
						Msg2Player("Mau ®Õn töu ®iÕm trong TriÒu Ca ®Ó mua canh tØnh r­îu!")
						TaskNote(29,4)
		end;
		if(GetLevel()>=35)  and  (UTask_Druid==13)  and  (HaveEventItem(16)>=1)then
						Talk(3,"no",10359,10360,10361)
						DelEventItem(16)
						AddNormalItem(7,59,128,1,0,0)
						Msg2Player("Cøu ®­îc Ng« Long, nhËn ®­îc s¸ch kü n¨ng Ban M«n Léng Phñ. TiÕp tôc ®i cøu nh÷ng ng­êi kh¸c.")
						SetTask(2,20)
						TaskNote(29,6)
		end;
end;

function   no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1015_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1015 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ngo Long - Manh Tan (209/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong Bat Tuy. Tim chu tuu diem tai Trieu Ca theo loi chi dan, sau do quay lai Ngo Long.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Hao (206/195); Dai Phu (192/212); Phong Lam (192/212)", 2, "Quay lai/main", "Dong/pt_close")
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

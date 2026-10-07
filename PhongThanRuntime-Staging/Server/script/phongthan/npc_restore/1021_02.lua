-- Original VNG source payload; provenance in deployment report.
--description: ºúÏ²ÃÄ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/9

function main()
			UTask_Knight = GetTask(3);
			UTask_Wizard = GetTask(1);
			UTask_Druid = GetTask(2);
			tasks = 
			{
					 {"ThÇn Long","renwu1";show=0},
					 {"ThÇn Méc","renwu2";show=0},
					 {"Mao L­","renwu3";show=0},
					 {"Ma huyÕt","renwu4";show=0}
			}
			if(GetLevel()>=55)  and  (UTask_Knight ==32) and  (HaveEventItem(13)>=1)then
						 tasks[1].show=1;
			end;
			if(UTask_Wizard ==33)  and ( HaveEventItem(2)>=1)then
						 tasks[2].show=1;
			end;
			if(GetLevel()>=55)  and  (UTask_Wizard ==31 )then
						 tasks[2].show=1;
			end;
			if(GetLevel()>=25 ) and ( UTask_Druid==1)then
						 tasks[3].show=1;
			end;
			if(GetLevel()>=55)  and  (UTask_Druid==34)and  (HaveEventItem(19)>=1)then
						 tasks[4].show=1;
			end;
			PTQ2_SayTask(10041,tasks)
end;

function  renwu1()
		UTask_Knight = GetTask(3);
		if(GetLevel()>=55)  and  (UTask_Knight ==32) and  (HaveEventItem(13)>=1)then
					Talk(3,"no",10042,10043,10167)
					SetTask(3,40)				
					AddNormalItem(3,46,0,0,0,0)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10. Cã thÓ tù do ra vµo Léc ®µi.")
					TaskNote(27,15)
		end 
end;

function  renwu2()
		UTask_Wizard = GetTask(1);
		if(GetLevel()>=55)  and(UTask_Wizard ==33)  and ( HaveEventItem(2)>=1)then
					Talk(1,"no",10044)
					AddNormalItem(3,46,0,0,0,0)
					SetTask(1,40)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10. Cã thÓ tù do ra vµo Léc ®µi.")
					TaskNote(28,19)
		end;

		if(GetLevel()>=55)  and  (UTask_Wizard ==31 )then
					Talk(3,"no",10045,10046,10047)
					SetTask(1,32)
					Msg2Player("Muèn gÆp §¾c Kû cÇn ph¶i cã ThÇn Méc.")
					TaskNote(28,17)
		end;
end;


function  renwu3()
					Talk(1,"no",10048)
					AddEventItem(15)
					SetTask(2,2)
					Msg2Player("NhËn ®­îc thiÕp mêi dù tiÖc.")	
					TaskNote(29,1)
end;


function  renwu4()
		if(GetLevel()>=55)  and  (UTask_Druid==34)and  (HaveEventItem(19)>=1)then
					Talk(1,"no",10049)				
					AddNormalItem(3,46,0,0,0,0)
					SetTask(2,40)
					TaskNote(29,14)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10, cã thÓ tù do ra vµo Léc ®µi.")
		end 
end;

function   no()
		CloseDialog()
end;



pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ho Hy Mi - Trieu Ca (205/184)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat lien quan thiep moi trong chuoi Mao Lu cua Di Nhan. Hoan tat doi thoai roi ve Hinh Thien.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tho Hanh Ton (213/184); Hoang Thien Hoa (214/184); Chuyen Sinh Lao Lao (212/190); Con Bac (204/196); A Tai (217/188)", 2, "Quay lai/main", "Dong/pt_close")
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

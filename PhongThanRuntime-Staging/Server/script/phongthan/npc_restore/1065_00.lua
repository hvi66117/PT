-- Original VNG source payload; provenance in deployment report.
--description:Àî¾¸-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/11

sel=0


function  main()
	strings={
		"<color=green>"..GetName().."<color>: BÈm ®¹i nh©n, Cöu C«ng lÖnh ta ®Õn ¶i Giai Méng xem xÐt t×nh h×nh, ®©y lµ <color=yellow>Th«ng hµnh lÖnh<color>.",
		"MÊy h«m tr­íc x¶y ra ®Þa chÊn, con ®­êng dÉn ®Õn <color=yellow>¶i Giai Méng ®· bÞ ®¸ bÞt lÊp<color>, hiÖn giê ch­a thÓ ®i ®­îc!",
		"<color=green>"..GetName().."<color>: VËy sao ®©y? T¹i h¹ ®ang cã qu©n t×nh khÈn cÊp cÇn ®Õn ¶i Giai Méng.",
		"H·y ®Õn Phong ThÇn ®µi t×m <color=green>B¸ Gi¸m<color>, phÐp <color=green>Kh«ng Minh L­u ChuyÓn thuËt<color> cña «ng ta cã thÓ gióp ®­îc ng­¬i.",
		"<color=green>"..GetName().."<color>: §¹ t¹! T¹i h¹ lËp tøc ®i ngay."
		}
	if (GetTask(597)==5) and (HaveEventItem(107)>=1) then
		local sel=GetTask(596)+1
		tasks = 
		{
		 {"Trang kÕ","main";show=0},
		 {"Th«ng hµnh lÖnh","zusai";show=0}
		}
		if(sel<=4)then
			tasks[1].show=1;
		elseif(sel==5)then
			tasks[2].show=1;
		end;
		PTQ2_SayTask(strings[sel],tasks)
		if(sel<=4)then
				SetTask(596,sel)
		end;
	else
		main1()
	end;
end;

function  zusai()
	if (GetTask(597)==5) and (HaveEventItem(107)>=1) then
		SetTask(597,6)
		TaskNote(35,6)
		DelEventItem(107)
		AddCredit(10)--ÉùÍû½±Àø
		AddOwnExp(4000) --¾­Ñé½±Àø
		Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
		TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>10 ®iÓm danh väng<color>!")
		Msg2Player("§i Phong ThÇn ®µi t×m B¸ Gi¸m.")
		SetTask(596,0)
	end;
	CloseDialog()
end;

function  main1()
		tasks = 
		{
		 {"Khuyªn hµng","renwu1";show=0},
		 {"ThÕ Së","renwu2";show=0}
		}
		UTask_Knight = GetTask(3);
		UTask_Wizard= GetTask(1);
		if(UTask_Knight==21)or(UTask_Knight==23)then
			 tasks[1].show=1;
		end;
		if(UTask_Wizard==10)or( UTask_Wizard==11) or(UTask_Wizard==14) or(UTask_Wizard==15)then
			 tasks[2].show=1;
		end;
		PTQ2_SayTask(10125,tasks)

end;

function    renwu1()
		UTask_Knight = GetTask(3);
		if(UTask_Knight==21)then
				Talk(3,"no",10126,10127,10128)
				Msg2Player("KÞp thêi th«ng b¸o tin tøc cho Lý TÞnh.")
				SetTask(3,UTask_Knight+1)
				TaskNote(27,6)
		elseif(UTask_Knight==23)then
				Talk(3,"no",10126,10127,10128)
				Msg2Player("KÞp thêi th«ng b¸o tin tøc cho Lý TÞnh.")
				SetTask(3,UTask_Knight+1)
				TaskNote(27,8)
		end;
end;

function   renwu2()
		UTask_Wizard = GetTask(1);
		if(UTask_Wizard==10)then
				Talk(3,"no",10129,10130,10131)
				SetTask(1,UTask_Wizard+2)
				Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
				TaskNote(28,3)
		elseif(UTask_Wizard==11)then
				Talk(3,"no",10129,10130,10131)
				SetTask(1,UTask_Wizard+2)
				Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
				TaskNote(28,6)
		elseif(UTask_Wizard==14)then
				Talk(3,"no",10129,10130,10131)
				SetTask(1,UTask_Wizard+2)
				Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
				TaskNote(28,7)
		elseif(UTask_Wizard==15)then
				Talk(3,"no",10129,10130,10131)
				SetTask(1,UTask_Wizard+2)
				Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
				TaskNote(28,9)
		end;
end;

function   no()
	SetTask(596,0)
	CloseDialog()
end;


pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1065_00; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1065 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ly Tinh - Tran Duong (193/207)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Ly Tinh tai Tran Duong trong chuoi Giap Si. Khong thay the bang boss hay nhiem vu cua Phong Than Dai.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Khong co NPC khac trong danh muc map nay.", 2, "Quay lai/main", "Dong/pt_close")
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

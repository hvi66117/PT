-- Original VNG source payload; provenance in deployment report.
--description: Áé±¦´ó·¨Ê¦
--author: yichuan
--date: 2004/6/27

function main(sel)
	tasks =
	{
		{"Th¨m Dß","renwu2";show=0},
		{"B¸ch Lı","renwu1";show=0},
		{"T­íi n­íc","renwu";show=0}
	}
	UTask_00=GetTask(10);
	if (UTask_00 == 1) or (UTask_00 == 5)or (UTask_00 == 9)or (UTask_00 == 13) then
			tasks[2].show=1;
	end;
	UTask_05 = GetTask(15);
	if(UTask_05 == 1) then
			tasks[1].show=1;
	end;
	if(GetLevel()>=35)and(HaveEventItem(49)>=1)and(GetTask(322)==0)and(GetTask(323)==0) and (GetTask(804)==1) then
			tasks[3].show=1
			PTQ2_SayTask(11383,tasks)
	elseif(GetLevel()>=35)and(HaveEventItem(164)>=1)and(GetTask(322)==0)and(GetTask(323)==0) and (GetTask(804)==2) then
			tasks[3].show=1
			PTQ2_SayTask(11383,tasks)
	else
			PTQ2_SayTask(10538,tasks)
	end;
end;

function  renwu1()
	UTask_00=GetTask(10);
	if(UTask_00 == 1)then
			Talk(1,"no",10539)
			SetTask(10,UTask_00+2)
			TaskNote(1,3)
			Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
	end;
	if(UTask_00 == 5)then
			Talk(1,"no",10539)
			SetTask(10,UTask_00+2)
			TaskNote(1,4)
			Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
	end;
	if(UTask_00 == 9)then
			Talk(1,"no",10539)
			SetTask(10,UTask_00+2)
			TaskNote(1,6)
			Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
	end;
	if(UTask_00 == 13) then
			Talk(1,"no",10539)
			SetTask(10,UTask_00+2)
			TaskNote(1,7)
			Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thİch.")
	end;
end;

function  renwu2()
			Say(10540,3,"Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1","Thiªn h¹ chi chİ nhu, tr× s¸nh thiªn h¹ chi chİ kiªn/yes_1","Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")

end;

function yes_1()
		Say(10541,3,"§¹i ®¹o phÕ khİ liÔu, tµi hiÓn thŞ xuÊt nh©n nghÜa/yes_2","§¹i ®¹o phÕ khİ liÔu, tµi s¶n sinh liÔu nh©n nghÜa/no1","§¹i ®¹o phÕ khİ liÔu, hoµn h÷u nh©n nghÜa t¹i/no1")
end;

function yes_2()
		Say(10542,3,"s¸t chi bÊt tóc tİch/no1","dô chi ®Ò chuyÓn bÜ/no1","tÜnh ®·i m¹c tu cÊp/yes_3")
end;

function yes_3()
		Talk(1,"no",10543)
		TaskNote(5,1)
		Msg2Player("V¨n kh¶o ®· xong, vÒ gÆp V©n Trung Tö phôc mÖnh.")
		SetTask(15,2)
end;

function no1()
		Talk(1,"check",10544)
end;

function check()
		Say(10545,3,"Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1","Thiªn h¹ chi chİ nhu, tr× s¸nh thiªn h¹ chi chİ kiªn/yes_1","Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")
end;

function no()
		CloseDialog()
end;

function  renwu()
	if(GetTask(320)>=20)then
		Talk(1,"no",11384)
		return
	end;
	local j=GetTask(321)
	if(j==0)then
	    local i=random(1,6);
		local  w=""
					if (i==1) then
							w="Háa vò"
					elseif(i==2)then
							w="Ngäc cèt"
					elseif(i==3)then
							w="§o¶n KiÕm"
					elseif(i==4)then
							w="M¶nh Gi¸p"
					elseif(i==5)then
							w="MÆt Quû"
					elseif(i==6)then
							w="B¨ng c¬"
					end;
		Talk(2,"no","Tèt! Nguyªn liÖu lÇn nµy ta cÇn <color=Red>"..w.."<color>.","§Ó ta ®i t×m nguyªn liÖu vÒ.")
		SetTask(321,i+7)
		Msg2Player("Gióp Linh B¶o ®¹i ph¸p s­ t×m "..w.." ")
		SetTask(320,GetTask(320)+1)
	else
		if(HaveNormalItem(3,j,0,0)>=10)and(GetCash()>=1000)then
			for a=1,10 do
				DelNormalItem(3,j,0,0)
			end;
			Pay(1000)
			local k=GetTask(324)+10
			local l=random(1,100)
			if (l>k)and((GetGlobalValue(6)==0)or(GetTask(327)<=50))then
				SetTask(327,GetTask(327)+4)
				if (GetTask(813)==1) then
					AddOwnExp(50*GetLevel())
				else
					AddOwnExp(10*GetLevel())
				end
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","Tèt l¾m! MÇm non cña ng­¬i ®· ®­îc bãn thªm <color=green>"..floor(GetTask(320)/2).."<color> lÇn, nhËn ®­îc <color=green>4 ®iÓm tr­ëng thµnh<color>, ®é tr­ëng thµnh hiÖn lµ <color=green>"..GetTask(327).."<color>. Lo¹i c©y nµy chØ cÇn 10 lÇn ch¨m sãc, nÕu t­íi n­íc qu¸ nhiÒu sÏ kh«ng tèt")
			else
				SetTask(327,GetTask(327)+1)
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","Do ng­¬i t­íi n­íc qu¸ nhiÒu ¶nh h­ëng ®Õn sù sinh tr­ëng cña c©y. MÇm non cña ng­¬i hiÖn t¹i ®· ®­îc bãn <color=green>"..floor(GetTask(320)/2).."<color> lÇn, nhËn ®­îc <color=green>1 ®iÓm<color> tr­ëng thµnh, ®é tr­ëng thµnh hiÖn t¹i lµ <color=green>"..GetTask(327).."<color>.")
			end;
			SetTask(321,0)

			local m=GetTask(324)+10
			if m>90 then
			m=90
			end;
			SetTask(324,m)

			local n=GetTask(325)-5
			if n<0 then
			n=0
			end;
			SetTask(325,n)

			local o=GetTask(326)-5
			if o<0 then
			o=0
			end;
			SetTask(326,o)
		elseif(HaveNormalItem(3,j,0,0)<10)then
			local  w=""
			if (j==8) then
					w="Háa vò"
			elseif(j==9)then
					w="Ngäc cèt"
			elseif(j==10)then
					w="§o¶n KiÕm"
			elseif(j==11)then
					w="M¶nh Gi¸p"
			elseif(j==12)then
					w="MÆt Quû"
			elseif(j==13)then
					w="B¨ng c¬"
			end;
			Talk(1,"no","LÇn t­íi n­íc nµy cÇn <color=green>10 "..w.."<color>, ng­¬i mau ®i lÊy vÒ! NÕu kh«ng t­íi n­íc kŞp th× sÏ háng hÕt. ")
		elseif(GetCash()<1000)then
			Talk(1,"no","Ng­¬i kh«ng ®ñ 1000 l­îng. ")
		else
			Talk(1,"no",11385)
		end;
	end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1003_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1003 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Linh Bao Dai Phap Su - Ngoc Hu cung (206/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong chuoi nhap mon Dao Si tai Ngoc Hu Cung. Tim Tu Hang Dao Nhan de theo thu tu tan thu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tu Hang Dao Nhan (206/196); Tan Thu Thi Luyen (207/195); Hoang Long Chan Nhan (204/195); Khao Co Hoc (208/194); Ho Tro Tan Thu (205/197)", 2, "Quay lai/main", "Dong/pt_close")
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

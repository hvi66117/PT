-- Original VNG source payload; provenance in deployment report.
--description: ³çÓ¦±ë-³ç³Ç9¼¶?Îñ
--author: rongjiangfei
--date: 2004/5/14

function main(sel)
	tasks =
	{
		{"T©n Thøc","renwu1";show=0},
		{"Phôc håi nhiÖm vô","taskid";show=0},
		{"B¾t s©u","renwu";show=0}
	}
	UTask_11=GetTask(21);
	if (UTask_11==2)  then
				tasks[1].show=1;
	end;
--	if(GetPlayerType()==0)then
--				tasks[2].show=1;
--	end;
		if(GetLevel()>=35)and(HaveEventItem(49)>=1)and(GetTask(321)==0)and(GetTask(322)==0) and (GetTask(804)==1)then
			tasks[3].show=1
			PTQ2_SayTask(11168,tasks)
		elseif(GetLevel()>=35)and(HaveEventItem(164)>=1)and(GetTask(321)==0)and(GetTask(322)==0) and (GetTask(804)==2)then
			tasks[3].show=1
			PTQ2_SayTask(11168,tasks)
		else
			PTQ2_SayTask(10249,tasks)
		end;
end;

function   renwu1()
						Talk(1,"no",10250)
						Msg2Player("GiÕt KiÕm Nh©n, ®em 10 ®o¶n kiÕm vÒ cho ¢u Thiªn Hãa.")
						TaskNote(8,2)
						SetTask(21,3)
end;

function   taskid()
		MsgBox(11169,"yes_1","no")
end;

function   yes_1()
	RepairTaskValue()
	Talk(1,"no","Ng­¬i giê cã thÓ nhËn tiÕp nhiÖm vô chñ tuyÕn cña Gi¸p sÜ.")
end;

function   yes()
		local   i=GetTask(0)
		local   j=floor((GetLevel()+5)/10)*10
		if(i~=0)then
			if(i<=j)then
					SetTask(3,i)
					SetTask(4,1)
					Talk(1,"no",11170)
			else
					SetTask(3,0)
					SetTask(4,1)
					Talk(1,"no",11171)
					TaskNote(27,34)
			end;
		else
			Talk(1,"no",11172)
		end;
end;

function no()
		CloseDialog()
end;

function  renwu()
	if(GetTask(320)>=20)then
		Talk(1,"no",11173)
		return
	end;

	local j=GetTask(323)
	if(j==0)then
	    local i=random(1,7);
		local  w=""
					if (i==1) then
							w="Ngò Quang th¹ch"
					elseif(i==2)then
							w="H×nh Thiªn Èn"
					elseif(i==3)then
							w="Cµn Kh«n Xİch"
					elseif(i==4)then
							w="Hçn Thiªn L¨ng"
					elseif(i==5)then
							w="B×nh L­u Ly"
					elseif(i==6)then
							w="Háa Long Tiªu"
					elseif(i==7)then
							w="H×nh Thiªn Èn"
					end;
		Talk(2,"no","HiÖn ta cÇn: <color=Red>"..w.."<color>.","T¹i h¹ sÏ ®i t×m ngay.")
		if(i==7)then
			i=2
		end;
		SetTask(323,i)
		Msg2Player("Gióp Sïng øng B­u t×m vËt liÖu"..w..". ")
			SetTask(320,GetTask(320)+1)
	else
		if(GetItemLevel2(0,4,j-1)>0)and(GetCash()>=1000)then
			DelItem2(0,4,j-1,GetItemLevel2(0,4,j-1))
			Pay(1000)
			local k=GetTask(326)+10
			local l=random(1,100)
			if (l>k)and((GetGlobalValue(6)==0)or(GetTask(327)<=48))then
				local chengzhang=random(2,6)
				SetTask(327,GetTask(327)+chengzhang)
				if (GetTask(813)==1) then
					AddOwnExp(50*GetLevel())
				else
					AddOwnExp(10*GetLevel())
				end
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","MÇm c©y cña ng­¬i ®· ®­îc ch¨m sãc <color=green>"..floor(GetTask(320)/2).."<color> lÇn, nhËn ®­îc <color=green>"..chengzhang.."<color> ®iÓm tr­ëng thµnh, ®é tr­ëng thµnh hiÖn t¹i lµ <color=green>"..GetTask(327).."<color>. MÇm c©y nµy chØ cho phĞp ch¨m sãc10 lÇn, nÕu b¾t kh«ng cã s©u vÉn bŞ tİnh mét lÇn")
			else
				SetTask(327,GetTask(327)+1)
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","MÇm c©y nµy kh«ng cÇn b¾t s©u n÷a, ng­¬i ®· ch¨m sãc <color=green>"..floor(GetTask(320)/2).."<color> lÇn, nhËn ®­îc <color=green>1 ®iÓm<color> tr­ëng thµnh, ®é tr­ëng thµnh hiÖn t¹i lµ <color=green>"..GetTask(327).."<color>.")
			end;
			SetTask(323,0)

			local m=GetTask(326)+10
			if m>90 then
			m=90
			end;
			SetTask(326,m)

			local n=GetTask(324)-5
			if n<0 then
			n=0
			end;
			SetTask(324,n)

			local o=GetTask(325)-5
			if o<0 then
			o=0
			end;
			SetTask(325,o)
		elseif (GetItemLevel2(0,4,j-1)==0) then
			local w=""
			if (j==1) then
					w="Ngò Quang th¹ch"
			elseif(j==2)then
					w="H×nh Thiªn Èn"
			elseif(j==3)then
					w="Cµn Kh«n Xİch"
			elseif(j==4)then
					w="Hçn Thiªn L¨ng"
			elseif(j==5)then
					w="B×nh L­u Ly"
			elseif(j==6)then
					w="Háa Long Tiªu"
			elseif(j==7)then
					w="H×nh Thiªn Èn"
			end;
			Talk(1,"no","B¾t s©u lÇn nµy cÇn t×m <color=green>1 "..w.."<color>, mau gióp ta ®i t×m!")
		elseif (GetCash()<1000)then
			Talk(1,"no","Ng­¬i kh«ng ®ñ 1000 l­îng.")		
		else
			Talk(1,"no",11174)
		end;
	end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Sung Ung Buu - Sung Thanh doanh (211/198)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tuong Sung Thanh trong chuoi Tan Thuc; lien he Lo Hung va tho ren Au Thien Hoa.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Sung Ung Loan (212/198); Ho Tro Tan Thu (210/200); Pham Nghia (210/200); Sung Hac Ho (213/200); Tap Hoa Thuong Nhan (207/198)", 2, "Quay lai/main", "Dong/pt_close")
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

-- Original VNG source payload; provenance in deployment report.
--description: æûÍõ
--author: yichuan
--date: 2004/6/10



set_name = 
{
	{"Vò Khóc ","Tinh Cang "," Khai Thiªn ","ChÊn §an "},
	{"XÝch Tïng ","Th¸i Êt ","Th«ng Thiªn ","Hång Qu©n "},
	{"B¸o ThÇn ","Gi¸c thó ","Lam §iªu ","Kh¸ng Long "}
}
part_name =
{
	{" Gi¸p ","ChiÕn Ngoa ","Yªu §¸i ","Kh«i ","Phi Phong "},
	{"§¹o Bµo ","Lý ","C©n ","Qu¸n ","LÖnh "},
	{" Hé Gi¸p ","Ngoa ","Yªu §¸i ","Trô ","KÕt "}
}
task_lvl_2_sel_lvl={[3]=5,[9]=7}
task_lvl_2_sel_idx={[3]=2,[9]=3}

function main(sel)
	tasks = 
	{
		{"Hµnh thiÖn","pk";show=1},
		{"VÞ quèc lËp c«ng","renwu2";show=0},
		{"§¼ng cÊp","renwu3";show=1},
		{"Di b¸o","dongyi";show=0},
		{"Th­ Viªn Hång","kouxin";show=0}
	}
	if((1==GetTask(421))or(2==GetTask(421)))and(20<=GetTask(420)) then
		tasks[2].show=1;
	end;
	if(25==GetTask(597))and(HaveEventItem(110)>=1)and(GetTask(593)~=1)then
		tasks[4].show=1;
	end;
	PTQ2_SayTask(10121,tasks)
end;

function  pk()
	MsgBox("Ng­¬i nghiÖp ch­íng qu¸ nÆng, e r»ng ta kh«ng thÓ gióp ng­¬i! Khai Minh ®¶o ë §«ng H¶i cã thÓ gióp röa s¹ch ¸c t©m, thuyÒn phu cña TrÇn §­êng cã thÓ ®­a ng­¬i ®Õn ®ã.","yes_1","no")
end;

function yes_1()
	MsgBox("ChØ cÇn ë trªn ®¶o mét thêi gian sÏ tiªu trõ ®­îc s¸t khÝ.","no")
end

function renwu2()
	if(1==GetTask(421))or(2==GetTask(421))then--421=1Ê±Íê³ÉÈÎÎñ£¬=2Ê±Íê³ÉÈÎÎñÇÒ±¾³¡Ê¤Àû
		if ((23==GetTask(420))or(29==GetTask(420)))and(GetTask(373)==1)then
			reward_add()
		else
			Talk(1,"no","LÇn nµy ng­¬i ®· lËp ®¹i c«ng! Xin nhËn phÇn th­ëng!")
			reward_normal()
		end
	else
		CloseDialog()
	end
end

function   no()
		CloseDialog()
end;

function renwu3()
	local sz_level
	if (GetTask(420)>=20)then
		sz_level=GetTask(420)-20
	else
		sz_level=GetTask(420)
	end
	Talk(1,"no","§¼ng cÊp chiÕn tr­êng hiÖn t¹i cña ng­¬i lµ <color=green>"..sz_level.."<color>.")
end

function reward_normal()
	local sz_level=GetTask(420)-20
	if (10==sz_level)then
		AddOwnExp(GetLevel()*(1000+GetTask(421)*1000)*2);--½±Àø£¬°üÀ¨Ê¤Àû½±Àø
	else
		AddOwnExp(GetLevel()*(sz_level*100+GetTask(421)*1000)*2);--½±Àø£¬°üÀ¨Ê¤Àû½±Àø
		if (4==sz_level)and(60>GetLevel()) then
			Msg2Player("§¼ng cÊp cña b¹n ch­a ®Õn 60, kh«ng thÓ vµo chiÕn tr­êng Th­¬ng Chu.")
		else
			if (1==GetTask(373)) then--¾­ÑéÖµÒÑÂú£¬µÈ¼¶ÌáÉý
				SetTask(420,sz_level+1)
				SetTask(373,0)
				Msg2Player("§¼ng cÊp chiÕn tr­êng cña ng­¬i t¨ng "..GetTask(420))
			elseif (GetTask(373)<1)and(GetTask(373)>=0) then--¾­ÑéÖµÎ´Âú£¬¾­ÑéÖµ+1
				SetTask(373,GetTask(373)+1)
			else--¾­ÑéÖµÒç³ö»òÈ¡µÃ´íÎóÖµ£¬Ö±½ÓÖÃÎª1
				SetTask(373,1)
			end
		end
	end
	SetTask(421,0)
end

function reward_add()
	local sz_level=GetTask(420)-20
	local sel_idx=task_lvl_2_sel_idx[sz_level]
	if(sel_idx~=nil)then
		local sel_type=GetPlayerType()+1
		local item_list={}
		if(sz_level==9)then
			for i=2,4 do
				item_list[i-1]=set_name[sel_type][sel_idx]..part_name[sel_type][i].."/item_"..i
			end;
			Say("LÇn nµy ng­¬i ®· lËp ®¹i c«ng! Xin nhËn phÇn th­ëng!",3,item_list) 
                else
			for i=1,5 do
				item_list[i]=set_name[sel_type][sel_idx]..part_name[sel_type][i].."/item_"..i
			end
			Say("LÇn nµy ng­¬i ®· lËp ®¹i c«ng! Xin nhËn phÇn th­ëng!",5,item_list)
		end
	end
end

function item_1()
	CloseDialog()
	local sz_level=GetTask(420)-20
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green> ®­îc Trô V­¬ng<color> tÆng <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][1].."<color>.",20)
		AddNormalItem(0,2,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end
end

function item_2()
	CloseDialog()
	local sz_level=GetTask(420)-20
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green> ®­îc Trô V­¬ng<color> tÆng <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][2].."<color>.",20)
		AddNormalItem(0,5,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end

end

function item_3()
	CloseDialog()
	local sz_level=GetTask(420)-20
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green> ®­îc Trô V­¬ng<color> tÆng <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][3].."<color>.",20)
		AddNormalItem(0,6,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end
end
function item_4()
	CloseDialog()
	local sz_level=GetTask(420)-20
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green> ®­îc Trô V­¬ng<color> tÆng <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][4].."<color>.",20)
		AddNormalItem(0,7,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end
end
function item_5()
	CloseDialog()
	local sz_level=GetTask(420)-20
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green> ®­îc Trô V­¬ng<color> tÆng <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][5].."<color>.",20)
		AddNormalItem(0,9,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end
end

function dongyi()
	if(HaveEventItem(110)>=1)then
		if(GetTask(592)==0)then
			Talk(1,"no","Bän §«ng Di l¹i d¸m xua binh x©m ph¹m x· t¾c cña Thµnh Thang ta? Nghe lÖnh truyÒn, <color=yellow>Tiªu diÖt §«ng Di Man Nh©n<color>!")
			SetTask(593,1)
			AddOwnExp(4000) --¾­Ñé½±Àø
			Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
			TopMessage("PhÇn th­ëng: <color=green>4000<color> ®iÓm kinh nghiÖm!")
		elseif(GetTask(592)==1)then
			DelEventItem(110)
			SetTask(593,1)
			Talk(1,"no","Bän §«ng Di l¹i d¸m xua binh x©m ph¹m x· t¾c cña Thµnh Thang ta? Nghe lÖnh truyÒn, <color=yellow>Tiªu diÖt §«ng Di Man Nh©n<color>!")
			SetTask(597,26)
			TaskNote(35,33)
			AddOwnExp(4000) --¾­Ñé½±Àø
			Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm!")
			TopMessage("PhÇn th­ëng: <color=green>4000<color> ®iÓm kinh nghiÖm!")
			Msg2Player("Håi b¸o §Æng Cöu C«ng!")
		end;
	end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_14; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tru Vuong - Trieu Ca (237/180)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat Tru Vuong doi thoai tai Trieu Ca. Khong tu tao boss su kien hoac bang rot vat pham.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Hoang Phi Ho (231/185); Phu An Su (225/191); Dac Ky (220/179); Chu Tuu Diem (227/195); Thong That Tau (222/192)", 2, "Quay lai/main", "Dong/pt_close")
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

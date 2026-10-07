-- Phong Than npc_fix 2026-09-28 (+ktnfix 2026-10-05 guidance row ktn_hint): Khuong Tu Nha (jiang ziya, map 1020); original script.pak \script\XiQi\JiangZiYa.lua (pinyin of GBK PAK path, bound directly before this fix); changes: exit row in SayTask; yes_1 task 1 1->2 consumes event 0 via QuestExchange (exp/money only after success); yes_3 task 3 27->30 grants the saber (0,0,31|32,4,1,0) via QuestExchange; phase guards on yes (task 1 ==20), yes_5 (class task ==61); dongyi 597 31->32: GetItemCount(114) -> HaveEventItemCount(114) and 7x event 114 consumed via QuestExchange; wrapper-free (original menu).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ½ª×ÓÑÀ-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27



function main()
	tasks = 
	{
		{"Khuyªn hµng","renwu1";show=0},
		{"Chinh §å","renwu2";show=0},
		{"ThÇn Oanh","renwu3";show=0},
		{"Tam s¸ch","renwu4";show=0},
		{"TÊn CÊp","renwu";show=0},
		{"§«ng Di","dongyi";show=0},
		{"Ch\221nh tuy\213n - h\173\237ng d\201n","ktn_hint";show=0},	-- ktnfix 2026-10-05
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if(UTask_Wizard==61)  or  (UTask_Knight==61)  or  (UTask_Druid==61)then
			tasks[4].show=1;
	end;
	if(GetPlayerType()==1)and (UTask_Wizard == 1)and(HaveEventItem(0)>=1)then
			tasks[2].show=1;
	end;
	if(GetLevel()>=45)  and  (UTask_Wizard == 20)and (GetPlayerType()==1)then
			tasks[3].show=1;
	end;
	if(GetPlayerType()==0) and (UTask_Knight ==27)then				--Íê³É¼×Ê¿25¼¶?Îñ
			tasks[1].show=1;
	end;
	if(GetLevel()>=20) and (GetTask(330)==1)and (SystemTime()<1111917600)then
			tasks[5].show=1;
	end;
	if(28==GetTask(597))or(31==GetTask(597))then
		tasks[6].show=1;
	end;
	-- ktnfix 2026-10-05: VNG only greets a player whose main story is not at a Khuong Tu Nha step;
	-- show where it starts (or what is missing) instead of an empty dialog
	if (PTKTN_Hint()>0) then
		tasks[7].show=1;
	end;
		SayTask(10395,tasks)
end;

function   renwu4()
		Talk(1,"yes_4",10396)
end;

function  renwu2()
		Talk(3,"yes_1",10397,10398,10399)
end;

function  renwu3()
		Talk(3,"yes_2",10400,10401,10402)--½ÓµÀÊ¿25¼¶?Îñ

end;

function  renwu1()
		Talk(2,"yes_3",10403,10404)
end;

function func_leave()	
		MsgBox(10405,"yes","no")
end;

function yes()
		if (GetPlayerType()~=1) or (GetLevel()<45) or (GetTask(1)~=20) then	-- npc_fix: phase guard
			CloseDialog()
			return
		end;
		Talk(1,"no",10406)
		Msg2Player("NhËn lÖnh cña Kh­¬ng Tö Nha ®Õn TriÒu Ca r­íc Hoµng Thiªn Hãa vµ Thæ Hµnh T«n lªn Phong ThÇn ®µi.")
		SetTask(1,21)
		TaskNote(28,11)
end;

function yes_1()
		-- npc_fix: event 0 (thu tien cu) consumed + task 1 1->2 in one transaction, then exp/money
		if (GetPlayerType()~=1) or (QuestExchange(1,1,2,{{4,0,0,0,0,0,1}},{})~=1) then
			Msg2Player("Chua the hoan thanh: can Thu tien cu trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(2,"no",10407,10408)
			AddOwnExp(300)
			Earn(30000)
			Msg2Player(" Mang th­ giíi thiÖu ®Õn Kh­¬ng Tö Nha, nhËn 300 kinh nghiÖm vµ 30000 l­îng.")
			TaskNote(28,1)
end;

function yes_2()	
		Talk(2,"func_leave",10409,10410)	
end;

function yes_3()
			local i=random(1,2)
			-- npc_fix: saber + task 3 27->30 in one transaction
			if (GetPlayerType()~=0) or (QuestExchange(3,27,30,{},{{0,0,30+i,4,1,0,1}})~=1) then
				Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
		Talk(1,"no",10411)
			if(i==1)then  
			Msg2Player(" Kh­¬ng Tö Nha ban th­ëng Xİch §ång ®ao.")
			else 
                        Msg2Player(" Kh­¬ng Tö Nha ban th­ëng TiÕu Thiªn ®ao.")
			end
			TaskNote(27,12)
end;

function yes_4()	
		Talk(2,"yes_5",10412,10413)
end;

function yes_5()
		local pt_t=3	-- npc_fix: phase guard on the player's own class task (must be 61)
		if (GetPlayerType()==1) then pt_t=1 elseif (GetPlayerType()==2) then pt_t=2 end;
		if (GetTask(pt_t)~=61) then
			CloseDialog()
			return
		end;
		Talk(2,"no",10414,10415)
			if(GetPlayerType()==1)then
					SetTask(1,62)
					TaskNote(28,28)
			end;
			if(GetPlayerType()==0)then
					SetTask(3,62)
					TaskNote(27,24)
			end;
			if(GetPlayerType()==2)then
					SetTask(2,62)
					TaskNote(29,23)
			end;
			Msg2Player("§· hiÓu ®­îc chİ lín cña Kh­¬ng Tö Nha, ®i t×m Vâ V­¬ng. B¹n ®· b¾t ®Çu sø mÖnh cña m×nh!")
end;


function no()	
		CloseDialog()
end;

-- ktnfix 2026-10-05 (not VNG): guidance for a main-story state that Khuong Tu Nha does not serve.
-- 0 = none (VNG rows only); 1 Dao Si not accepted (task 1 = 0), 2 Dao Si step 1 without the letter (event 0),
-- 3 Dao Si step 20 below level 45, 4 Giap Si not accepted (task 3 = 0), 5 Di Nhan not accepted (task 2 = 0).
function PTKTN_Hint()
	local lv = GetLevel()
	if (lv < 25) then return 0 end;
	local pt = GetPlayerType()
	if (pt == 1) then
		local t = GetTask(1)
		if (t == 0) then return 1 end;
		if (t == 1) and (HaveEventItem(0) < 1) then return 2 end;
		if (t == 20) and (lv < 45) then return 3 end;
	elseif (pt == 0) then
		if (GetTask(3) == 0) then return 4 end;
	elseif (pt == 2) then
		if (GetTask(2) == 0) then return 5 end;
	end;
	return 0
end;

PTKTN_TXT = {
	"Ng\173\172i ch\173a nh\203n nhi\214m v\244 ch\221nh tuy\213n. \167\185o S\220 t\245 c\202p 25 h\183y v\210 <color=yellow>Ng\228c H\173 cung<color> g\198p <color=red>Ho\181ng Long Ch\169n Nh\169n<color> [204,195], ch\228n \34Chinh \167\229\34 \174\211 nh\203n <color=yellow>Th\173 ti\213n c\246<color>, r\229i mang th\173 t\237i T\169y K\250 g\198p ta.",
	"Ng\173\172i \174\183 nh\203n nhi\214m v\244 Chinh \167\229 nh\173ng kh\171ng mang theo <color=yellow>Th\173 ti\213n c\246<color> c\241a Ho\181ng Long Ch\169n Nh\169n. H\183y d\239ng <color=yellow>L\214nh B\181i Ti\213p T\213 Nhi\214m V\244<color> \174\211 nh\203n l\185i th\173 r\229i quay l\185i g\198p ta.",
	"\167\185t <color=yellow>c\202p 45<color> h\183y quay l\185i g\198p ta nh\203n nhi\214m v\244 Th\199n Oanh.",
	"Ng\173\172i ch\173a nh\203n nhi\214m v\244 ch\221nh tuy\213n. Gi\184p S\220 t\245 c\202p 25 h\183y v\210 <color=yellow>S\239ng Th\181nh doanh<color> g\198p <color=red>S\239ng H\199u H\230<color> [212,193], ch\228n \34Trung Th\181nh\34 \174\211 nh\203n nhi\214m v\244.",
	"Ng\173\172i ch\173a nh\203n nhi\214m v\244 ch\221nh tuy\213n. D\222 Nh\169n t\245 c\202p 25 h\183y v\210 <color=yellow>Xi V\173u m\233<color> g\198p <color=red>H\215nh Thi\170n<color> [194,200], ch\228n \34Mao L\173\34 \174\211 nh\203n nhi\214m v\244.",
}

function ktn_hint()
	local h = PTKTN_Hint()
	if (h < 1) then
		CloseDialog()
		return
	end;
	Talk(1,"no",PTKTN_TXT[h])
end;


function  renwu()	
		if(GetTask(330)==1)then
				if(GetSeries()==0)then
					local i=random(1,2)
						if (i==1) then
							AddNormalItem(0,0,4,2,0,0)
						elseif(i==2)then
							AddNormalItem(0,0,5,2,0,0)
						end;
				elseif(GetSeries()==1)then
					AddNormalItem(0,0,6,2,0,0)
				elseif(GetSeries()==2)then
					AddNormalItem(0,0,7,2,0,0)
				end;
			SetTask(330,2)
				Talk(2,"no","ThËt vinh h¹nh ®­îc dòng sÜ tham gia, ®©y lµ nh÷ng thÇn khİ ®­îc Vâ V­¬ng trang bŞ. Hy väng nã sÏ gióp c¸c chiÕn sÜ x«ng pha trËn ®Şa nh­ hæ thªm c¸nh.","<color=red>Vâ V­¬ng<color> ®ang ®iÓm danh t­íng sÜ. Nh÷ng ng­êi trªn cÊp 35 sÏ ®­îc ®i tiªn phong! H·y cè g¾ng nhiÒu h¬n n÷a nhĞ!")			
		else
				Talk(1,"no","Ng­¬i ®· ®­îc phong chøc, cè g¾ng ®Õn cÊp 35 ®Õn t×m <color=red>Vâ V­¬ng<color> ®Ó nhËn nhiÖm vô")
		end;
end;

function dongyi()
	if(28==GetTask(597))then
		Talk(2,"no","Cöu C«ng ®Çu Chu ®ã lµ ı trêi, nh­ng gÇn ®©y D«ng Di xuÊt hiÖn nhiÒu ma thó, ta thÊy cã g× ®ã bÊt th­êng. Tr¸ng sÜ h·y gióp ta ®Õn <color=yellow>§«ng Di téc<color> gÆp §«ng Di thñ lÜnh ®Ó ®iÒu tra xem t×nh h×nh ë ®ã thÕ nµo.","<color=green>"..GetName().."<color>: NhËn ñy th¸c cña Kh­¬ng thõa t­íng!")
		SetTask(597,29)
		TaskNote(35,36)
		Msg2Player("§Õn gÆp thñ lÜnh §«ng Di t×m hiÓu lai lŞch cña ma thó.")
	elseif(31==GetTask(597)) then
		if(HaveEventItemCount(114)>=7)then	-- npc_fix: was GetItemCount(114) (one-arg form is not the VNG event count here)
			-- npc_fix: 7x event 114 consumed + task 597 31->32 in one transaction
			if (QuestExchange(597,31,32,{{4,114,0,0,0,0,7}},{})~=1) then
				CloseDialog()
				return
			end;
			TaskNote(35,39)
			TaskNote(36,0)
			AddCredit(35)--ÉùÍû½±Àø
			local exp=GetNextExp()-GetExp()
			if(exp>=150000)then
				AddOwnExp(150000) --¾­Ñé½±Àø
			else
				AddOwnExp(exp) 
				AddOwnExp(150000-exp)
			end;
			Msg2Player("NhËn ®­îc 150000 ®iÓm kinh nghiÖm vµ 35 ®iÓm danh väng!")
			TopMessage("PhÇn th­ëng: <color=green>150000 ®iÓm kinh nghiÖm<color> vµ <color=green>35 ®iÓm danh väng!<color>")
			Talk(2,"no","<color=green>"..GetName().."<color>: M¶nh Ph¸p khİ nµy t¹i h¹ ®em vÒ tõ D«ng Di, xin thõa t­íng xem!","M¶nh Ph¸p Khİ nµy ®· bŞ mÊt tİch sau V¹n Tiªn trËn, sao b©y giê l¹i xuÊt hiÖn ë ®©y. Ta ph¶i lËp tøc vÒ ®éng thØnh gi¸o s­ phô. <color=green>Ng­¬i ®îi ë ®©y!<color>")
		else
			Talk(1,"no","Thu ®­îc tin tin tøc g× kh«ng?")
		end;
	end;
end;

--
--function fabao1()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp) 
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,30,1,0,0)
--		Msg2Player("»ñµÃÀëµØÑæ¹âÆì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;

--function fabao2()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp) 
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,31,1,0,0)
--		Msg2Player("»ñµÃÇàÁ«±¦É«Æì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;
--
--]]

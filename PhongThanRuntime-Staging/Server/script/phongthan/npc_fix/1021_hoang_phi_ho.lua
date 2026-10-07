-- Phong Than npc_fix 2026-09-28: Hoang Phi Ho (huang feihu, map 1021); original script.pak \script\ChaoGe\HuangFeiHu.lua (pinyin of GBK PAK path); changes: exit row on both SayTask menus; renwu1 task 3 11->20 (event 45 -> skill book 7,59,128) and lingpai task 597 4->5 (event 106 -> 107, exp/credit after success) via QuestExchange; renwu2 task 3 26->27 consumes event 12 (An tin) via QuestExchange; renwu1 re-checks Giap Si/level>=35; master-apprentice branches (renwu4/5/6, chushi, enhance) disabled while AddMasterPRValue/DoMasterPR/... are not registered; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description:»Æ·É»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11
--¥X®v¥ô°ÈÅÜ¶q905,Åv­È ¯«¹A1¡A°E¤×2¡A°aÁÕ5
--903¼Ð°O»â¨ú¹L¯S®íªkÄ_

function  main()
			tasks = 
			{
					 {"TrÇm H­¬ng","renwu1";show=0},
					 {"Khuyªn hµng","renwu2";show=0},
					 {"ThÕ Së","renwu3";show=0},
					 {"B¸i s­","renwu4";show=0},		--ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
					 {"NhËn ®iÓm s­ ®å","renwu5";show=0},	--ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
					 {"§æi ®iÓm s­ ®å","renwu6";show=0},	--ÔÝÊ±¹Ø±ÕÊ¦Í½ÏµÍ³
					 {"Th«ng hµnh lÖnh","lingpai";show=0},
					 {"XuÊt s­","chushi";show=1},
					 {"Quy Ch©n KÝnh","guizhenjing";show=1},
					 {"KÕt thóc ®èi tho¹i","no";show=1}
			}

			UTask_Knight = GetTask(3);
			UTask_Wizard = GetTask(1);
			UT_MPR = GetTask(333);	--1ÇëÇó½¨Á¢Ê¦Í½¹ØÏµ
					
			if(GetPlayerType()==0)and(GetLevel()>=35)  and  (UTask_Knight==11)and(HaveEventItem(45)>=1)then
					 tasks[1].show=1;
			end;
			if (UTask_Wizard==10)or(UTask_Wizard==12)or(UTask_Wizard==14)or(UTask_Wizard==16)then
					tasks[3].show=1;
			end;
			if(UTask_Knight==26)  and  (HaveEventItem(12)>=1)then
					tasks[2].show=1;
			end;
			if(GetLevel()>=45)  and  (UTask_Knight==24) then
					tasks[2].show=1;
			end;
			if(GetLevel()>=45)  and  (UTask_Knight==20)and (GetPlayerType()==0)then
					tasks[2].show=1;
			end;
--			if((CanMasterPR()==1)and(UT_MPR==0))then
--					tasks[4].show=1;
--			end;
--			if(CanChangeMasterPRValue()==1)then
--					tasks[5].show=1;
--			end;
--			if(GetMasterPRValue()>=1)then
--					tasks[6].show=1;
--			end;
			if (GetTask(597)==4) and (HaveEventItem(106)>=1) then
					tasks[7].show=1;
			end;
			SayTask(10050,tasks)
end;

function guizhenjing()
	tasks = 
			{
					{"Quy Ch©n KÝnh","enhance";show=0},				 
					{"Ph¸p M«n","intro";show=1},
					{"KÕt thóc ®èi tho¹i","no";show=1}
			}
	if(GetItemLevel2(0,4,33)>=1)then
		tasks[1].show=1;
	end
	SayTask("Quy Ch©n KÝnh lµ mét ph¸p b¶o thÇn kú. Cã thÓ dïng ®iÓm s­ ®å gióp nã m¹nh h¬n",tasks)
end

function intro()
	Talk(3,"no","70 ®iÓm s­ ®å cã thÓ lµm t¨ng søc phßng ngù cho Quy Ch©n KÝnh cÊp 1.","70 ®iÓm s­ ®å cã thÓ lµm t¨ng kh¸ng tÊt c¶ cho Quy Ch©n KÝnh cÊp 2.","100 ®iÓm s­ ®å cã thÓ lµm cho Quy Ch©n KÝnh ®¹t cùc ®Ønh biÕn thµnh Th¸i Cùc Quy Ch©n KÝnh.")
end

-- npc_fix: the master-apprentice API family (GetMasterPRValue, DecMasterPRValue,
-- AddMasterPRValue, CanMasterPR, DoMasterPR, IsMaster, UnMasterPREx, ...) is not
-- registered by this GameServer; every branch that needs it stops here instead
-- of raising a Lua error half-way through a reward.
function pt_fix_mpr()
	if (GetMasterPRValue==nil) or (DecMasterPRValue==nil) or (AddMasterPRValue==nil) or (CanMasterPR==nil) or (DoMasterPR==nil) or (IsMaster==nil) or (UnMasterPREx==nil) or (CanChangeMasterPRValue==nil) or (ChangeMasterPRValue==nil) then
		Talk(1,"no","He thong su do hien chua mo tren may chu nay.")
		return 0
	end;
	return 1
end;

function enhance()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	local lv=GetItemLevel2(0,4,33)
	local costvalue={70,70,100}
	if(lv>0)and(lv<4)then
		if(GetMasterPRValue()>=costvalue[lv])then
			MsgBox("<color=yellow>Quy Ch©n KÝnh<color> lµm m¹nh thªm cÇn tèn <color=green>"..costvalue[lv].."<color> ®iÓm s­ ®å","enhance_confirm","no")
		else
			Talk(1,"no","Quy Ch©n KÝnh lµm m¹nh thªm cÇn tèn <color=green>"..costvalue[lv].."<color> ®iÓm s­ ®å, ng­¬i kh«ng ®ñ ®iÓm th× ph¶i!")
		end
	elseif(lv==0)then
		Talk(1,"no","<color=yellow>Quy Ch©n KÝnh<color> cña ng­¬i kh«ng thÓ lµm m¹nh thªm.")
	else
		Talk(1,"no","<color=yellow>Quy Ch©n KÝnh<color> ®· ®¹t ®Õn møc cùc ®Ønh, nÕu truyÒn thªm ph¸p lùc vµo e r»ng sÏ lµm háng nã")
	end
end

function enhance_confirm()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	local lv=GetItemLevel2(0,4,33)
	local costvalue={70,70,100}
	if(lv==0)then
		Talk(1,"no","<color=yellow>Quy Ch©n KÝnh<color> cña ng­¬i kh«ng thÓ lµm m¹nh thªm.")
	elseif(lv==3)then
		DelItem2(0,4,33,lv)
		AddNormalItem(0,4,33,lv+1,0,0)
		DecMasterPRValue(costvalue[lv])
		Talk(1,"no","Chóc mõng! Ng­¬i nhËn ®­îc <color=yellow>Th¸i Cùc Quy Ch©n KÝnh<color>!")
		AddGlobalCountNews("ChØ thÊy Hoµng Phi Hæ ph¸t ra 1 luång s¸ng, <color=green>"..GetName().."<color> nhËn ®­îc <color=green>Th¸i Cùc Quy Ch©n KÝnh<color>",20)
	else
		DelItem2(0,4,33,lv)
		AddNormalItem(0,4,33,lv+1,0,0)
		DecMasterPRValue(costvalue[lv])
		Talk(1,"no","Chóc mõng! Quy Ch©n KÝnh cña ng­¬i ®· ®­îc t¨ng c­êng thªm mét sè thuéc tÝnh!")
	end
end

function judge_relation()		--º¡¨¬®v®{2¤H¶¤
	local mark=0
	if(GetTeam()~=0)then			-- ¦³¶¤¥î	
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			mark=IsMasterPRRelation(n)
		end
	end
	return mark
end

function step_complete()
	local mark=0
	local step={}
	for i=1,4 do
		step[i]=8-GetTask(898+i)
		if(step[i]==1)then
			mark=mark+1
		end
	end
	return mark
end

function  chushi()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	if(GetLevel()>=50)and(judge_relation()==1)and(step_complete()>=2)then
		if(GetTask(905)<9)and(HaveIBBuff(217)==0)then
			MsgBox("Nghe nãi cã ng­êi më ®­îc c¸nh cöa chiÕn tr­êng ViÔn Cæ. Ng­¬i gióp ta ®i hái xem!","PM_shengxian","no")
		elseif(GetTask(905)==9)then
			MsgBox("Ng­¬i ®óng lµ hËu sinh kh¶ óy! §· cã thÓ xuÊt s­!","PM_shengxian_end","no")
		else
			Talk(1,"no","Qu©n, d©n, x· t¾c rèt cuéc bªn nµo nÆng bªn nµo nhÑ, ng­¬i cã thÓ chØ gi¸o cho ta kh«ng?")
		end
	elseif(GetLevel()>50)and(judge_relation()==1)and(IsMaster()==0)then
		MsgBox("§¼ng cÊp cña ng­¬i ®· ®Õn lóc xuÊt s­, cã thÓ ra ngoµi häc hái thªm! Giê ta sÏ gióp ng­¬i hoµn thµnh nghi thøc xuÊt s­.","PM_wuming_end","no")
	else
		Talk(2,"no","Khi ®Ö tö ®¹t cÊp 50 vµ hoµn thµnh 2 lÇn nhiÖm vô ThÝ luyÖn mª cung, ta sÏ chñ tr× nghi lÔ xuÊt s­ cho 2 ng­¬i","§Ö tö lín h¬n cÊp 50 cã thÓ xuÊt s­, nÕu gÆp vÊn ®Ò trong nhiÖm vô s­ ®å ta cã thÓ lµm nghi thøc ®¬n gi¶n cho xuÊt s­.")
	end
end

function ratelevel()
		local level=0
		local oldPlayer=PlayerIndex
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			level=GetLevel()
		end
		PlayerIndex=oldPlayer
	return level
end

function getrateindex()
	local name
	local oldPlayer=PlayerIndex
	if(IsCaptain()==0)then
		n=GetTeamMember(1)
	else
		n=GetTeamMember(2)
	end;
	PlayerIndex=n
	name=GetName()
	PlayerIndex=oldPlayer
	return name
end

function PM_wuming_end()
	TaskNote(42,-1)
	TaskNote(43,-1)
	TaskNote(44,-1)
	TaskNote(45,-1)
	TaskNote(46,-1)
	UnMasterPREx(getrateindex())
	local oldPlayer=PlayerIndex
	for i=1,2 do
		PlayerIndex=GetTeamMember(i)
		SetTask(895,0)
		SetTask(896,0)
		SetTask(897,0)
		SetTask(898,0)
		SetTask(899,0)
		SetTask(900,0)
		SetTask(901,0)
		SetTask(902,0)
		SetTask(904,0)
		SetTask(905,0)
		SetTask(906,0)
		SetTask(907,0)
		AddMasterPRValue(5)
		Msg2Player("Hoµn tÊt nghi thøc xuÊt s­, b¹n nhËn ®­îc 5 ®iÓm s­ ®å!")
	end

	PlayerIndex=oldPlayer
	CloseDialog()
end

function PM_shengxian()
	RemoveIBBuff(217)
	local done=AddIBBuff(217)
	if(done==1)then
		SetTask(905,1)
		TaskNote(47,GetTask(905)-1)
		CloseDialog()
	else
		Talk(1,"no","HiÖn ng­¬i kh«ng thÓ tiÕp nhËn nhiÖm vô s­ ®å. §îi l¸t quay l¹i ®i!")
	end
end

function PM_shengxian_end()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		shengxian_end_P()
		local oldPlayer=PlayerIndex
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			shengxian_end_M()
		end
		PlayerIndex=oldPlayer
	else
		Talk(1,"no","NhiÖm vô s­ ®å cÇn s­ phô vµ ®Ö tö, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
	end
end

function shengxian_end_P()
	UnMasterPREx(getrateindex())
	local exp=GetNextExp()-GetExp()
	if(1000000>=exp)then
		AddOwnExp(exp)
		AddOwnExp(1000000-exp)
	else
		AddOwnExp(1000000)
	end
	if(GetTask(903)==0)then
		AddNormalItem(0,4,33,1,0,0)
		SetTask(903,1)
	end
	local i
	for i=895,907	do 
		SetTask(i,0)
	end
	SetTask(903,1)
	TaskNote(42,-1)
	TaskNote(43,-1)
	TaskNote(44,-1)
	TaskNote(45,-1)
	TaskNote(46,-1)
	TaskNote(47,-1)
	AddGlobalCountNews("<color=green>"..GetName().."<color> thuËn lîi xuÊt s­, Hoµng Phi Hæ tÆng <color=green>L­ìng Nghi Quy Ch©n KÝnh<color> cho 2 s­ ®å.",20)
	CloseDialog()
end

function shengxian_end_M()
	if(GetTask(903)==0)then
		AddNormalItem(0,4,33,1,0,0)
		SetTask(903,1)
	end
	AddMasterPRValue(15)
	local i
	for i=895,907	do 
		SetTask(i,0)
	end
	SetTask(903,1)
	TaskNote(47,-1)
end

function   lingpai()
		-- npc_fix: event 106 -> event 107 and task 597 4->5 in one transaction
		if (QuestExchange(597,4,5,{{4,106,0,0,0,0,1}},{{4,107,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the nhan Thong hanh lenh: can thu cua Cuu Cong va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(2,"no","<color=green>"..GetName().."<color>: Cöu C«ng lÖnh ta ®Õn ®©y xem xÐt t×nh h×nh! Ta muèn nhËn <color=yellow>Th«ng hµnh lÖnh<color>!","Ng­¬i mau ®Õn <color=red>TrÇn §­êng<color> t×m <color=green>Lý TÞnh<color>. ¤ng ta sÏ ®­a ®Õn <color=red>¶i Giai Méng<color>.")
		TaskNote(35,5)
		-- npc_fix: granted by QuestExchange above -- SetTask(597,5) DelEventItem(106) AddEventItem(107)
		AddCredit(10)--ÉùÍû½±Àø
		AddOwnExp(4000) --¾­Ñé½±Àø
		Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
		TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>10 ®iÓm danh väng<color>!")
		Msg2Player("NhËn ®­îc Th«ng hµnh lÖnh!")
		--TopMessage("»ñµÃ<color=green>Í¨¹ØÁîÅÆ<color>")
		Msg2Player("§Õn TrÇn §­êng t×m Lý TÞnh.")
end;

function   renwu1()
						if (GetPlayerType()~=0) or (GetLevel()<35) then	-- npc_fix: menu condition re-checked
							CloseDialog()
							return
						end;
						-- npc_fix: event 45 -> skill book (7,59,128) and task 3 11->20 in one transaction
						if (QuestExchange(3,11,20,{{4,45,0,0,0,0,1}},{{7,59,128,1,0,0,1}})~=1) then
							Msg2Player("Chua the hoan thanh: can Go tram huong va cho trong hanh trang.")
							CloseDialog()
							return
						end;
						Talk(3,"no",10051,10052,10053)
						Msg2Player("NhËn s¸ch kü n¨ng Ban M«n Léng Phñ.")
						TaskNote(27,4)

end;

function   renwu2()
		UTask_Knight = GetTask(3);
		if(UTask_Knight==26)  and  (HaveEventItem(12)>=1)then
						-- npc_fix: event 12 consumed + task 3 26->27 in one transaction
						if (QuestExchange(3,26,27,{{4,12,0,0,0,0,1}},{})~=1) then
							Msg2Player("Chua the hoan thanh: can An tin trong hanh trang.")
							CloseDialog()
							return
						end;
						Talk(1,"no",10054)
						Msg2Player("Th«ng b¸o Kh­¬ng Tö Nha thu nhËn Hoµng Phi Hæ.")
						TaskNote(27,11)
						return	-- npc_fix: one step per click (27 matches no other branch)
		end;
		if(GetLevel()>=45)  and  (UTask_Knight==24) then
						Talk(3,"no",10055,10056,10057)
						SetTask(3,25)
						Msg2Player("Gióp Hoµng Phi Hæ ®o¹t Ên tÝn.")
						TaskNote(27,9)
		end;
		if(GetLevel()>=45)  and  (UTask_Knight==20)and (GetPlayerType()==0)then
						Talk(1,"no",10058)
						SetTask(3,21)
						Msg2Player("§i th«ng b¸o cho §Æng Cöu C«ng vµ Lý TÞnh")
						TaskNote(27,5)
		end;
end;

function   renwu3()
			UTask_Wizard = GetTask(1);
		if(UTask_Wizard==10)then
			Talk(3,"no",10059,10060,10168)
			SetTask(1,UTask_Wizard+1)
			Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
			TaskNote(28,4)
		elseif(UTask_Wizard==12)then
			Talk(3,"no",10059,10060,10168)
			SetTask(1,UTask_Wizard+1)
			Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
			TaskNote(28,6)
		elseif(UTask_Wizard==14)then
			Talk(3,"no",10059,10060,10168)
			SetTask(1,UTask_Wizard+1)
			Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
			TaskNote(28,8)
		elseif(UTask_Wizard==16)then
			Talk(3,"no",10059,10060,10168)
			SetTask(1,UTask_Wizard+1)
			Msg2Player("Khuyªn Hoµng Phi Hæ ®Çu hµng thµnh c«ng.")
			TaskNote(28,9)
		end;

end;

function  renwu4()
		if (pt_fix_mpr()~=1) then return end;	-- npc_fix
		if(CanMasterPR()==1)then
			if(GetLevel()<30)then
				SetTask(333,1)
				local i=PlayerIndex
				local n=0
				if(IsCaptain()==0)then
					n=GetTeamMember(1)
				else
					n=GetTeamMember(2)
				end;
				PlayerIndex=n
				Msg2Player("Thµnh viªn trong nhãm muèn b¸i b¹n lµm su phô")
				PlayerIndex=i
				MsgBox(10698,"no")
			elseif((GetLevel()>=50)and(GetMateTask(333)==0))then
			MsgBox(10699,"no")
			elseif((GetLevel()>=50)and(GetMateTask(333)==1))then
			MsgBox(10700,"yes_PR","no_PR")
		end;
	else
		MsgBox(10701,"no")
	end;
end;

function  yes_PR()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	if(CanMasterPR()==1)then
		DoMasterPR()
		CloseDialog()
	else
		MsgBox(10701,"no")
	end;
end;

function  no_PR()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	if(CanMasterPR()==1)then
		SetMateTask(333,0)
		local i=PlayerIndex
		local n=0
		if(IsCaptain()==0)then
			n=GetTeamMember(1)
		else
			n=GetTeamMember(2)
		end;
		PlayerIndex=n
		Msg2Player("B¹n kh«ng ®­îc chÊp thuËn lµm s­ ®å!")
		PlayerIndex=i
		Msg2Player("B¹n tõ chèi nhËn s­ ®å")
		CloseDialog()
	else
		Msg2Player("§èi ph­¬ng ®· rêi khái ®éi ngò!")
		CloseDialog()
	end;
end;

function  renwu5()
		if (pt_fix_mpr()~=1) then return end;	-- npc_fix
		if(GetExtPoint(0)<=0)then
			MsgBox(11421,"no")
		else
			if(CanChangeMasterPRValue()==1)then
				if(GetLevel()<50)then
					ChangeMasterPRValue()
					MsgBox(10702,"no")
				else
					Msg2Player("S­ phô kh«ng thÓ nhËn ®iÓm s­ ®å!")
					CloseDialog()
				end;
			else
				Msg2Player("Kh«ng ®ñ ®iÒu kiÖn nhËn, lÇn sau quay l¹i!")
			end;
		end;
end;

function  no()
		CloseDialog()
end;


function renwu6()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	Say(10703,6,"§æi Lam b¶o th¹ch (tèn 50 ®iÓm)/lbs","§æi Hång b¶o th¹ch (tèn 20 ®iÓm)/hbs","§æi m¶nh Hoµng thñy tinh (tèn 5 ®iÓm)/hsj","§æi tiÒn/jq","§æi kinh nghiÖm/jy","Th«i! LÇn sau quay l¹i/no")
end;

function hsj()
	if(GetMasterPRValue()>=10)then
		DecMasterPRValue(5)
		AddNormalItem(3,88,0,0,1,0)
		MsgBox("Ng­¬i ®· ®æi 1 m¶nh Hoµng thñy tinh.","no")
	else
		MsgBox("§æi m¶nh Hoµng thñy tinh cÇn 10 ®iÓm s­ ®å, ng­¬i kh«ng ®ñ!","no")
	end;
end;

function lbs()
	if(GetMasterPRValue()>=50)then
		DecMasterPRValue(50)
		AddNormalItem(3,41,0,0,1,0)
		MsgBox(10704,"no")
	else
		MsgBox(10705,"no")
	end;
end;

function hbs()
	if(GetMasterPRValue()>=20)then
		DecMasterPRValue(20)
		AddNormalItem(3,79,0,0,1,0)
		MsgBox(10706,"no")
	else
		MsgBox(10707,"no")
	end;
end;

function jq()
	local money=1000*GetMasterPRValue()
	DecMasterPRValue(GetMasterPRValue())
	Earn(money)
	MsgBox("Ng­¬i nhËn ®­îc <color=red>"..money.."<color>!","no")
end;

function jy()
	local exp=1000*GetMasterPRValue()
	DecMasterPRValue(GetMasterPRValue())
	AddOwnExp(exp)
	MsgBox("Ng­¬i nhËn ®­îc <color=red>"..exp.."<color> ®iÓm kinh nghiÖm!","no")
end;

-- 2026-10-03 sudocpp: master-apprentice rows, Bai su / Doi diem / Quy Chan Kinh and solo Xuat su once the C++ API
-- (PhongThanLuaMasterPR.h) is deployed; until then sudocpp_hph.lua calls the functions above unchanged.
Include("\\script\\phongthan\\sudocpp\\sudocpp_hph.lua")

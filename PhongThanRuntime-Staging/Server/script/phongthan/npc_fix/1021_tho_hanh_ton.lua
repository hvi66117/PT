-- Phong Than npc_fix 2026-09-28: Tho Hanh Ton (tu xingsun, map 1021); original script.pak \script\ChaoGe\TuXingSun.lua (pinyin of GBK PAK path); changes: exit row in SayTask; renwu2 task 1 23->24 consumes event 1 via QuestExchange; renwu3 phase guard (task 1 ==30, level>=55); master-apprentice trial (shitu_1*) disabled while AddMasterPRValue is not registered; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÍÁÐÐËï-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/29
--899,ý®»b¨©¯Æ
function main()
			tasks = 
			{
			{"ThÇn Oanh","renwu2";show=0},
			{"ThÇn Méc","renwu3";show=0},
			{"Hoang m¹c thÝ luyÖn","shitu_1";show=0},
			{"KÕt thóc ®èi tho¹i","no";show=1}
			}
			UTask_Wizard = GetTask(1);
			if(GetPlayerType()==1) and  (UTask_Wizard == 23)  and (HaveEventItem(1)>=1)then
				 tasks[1].show=1;
			end;
			if(GetLevel()>=55)  and  (UTask_Wizard == 30)then	
				 tasks[2].show=1;
			end;
			if(GetLevel()>25)and(GetLevel()<=35)and(GetTask(899)<=7)then	--®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
				tasks[3].show=1;
			end;
			SayTask(10109,tasks)   
end;

-- npc_fix: AddMasterPRValue (master reward of this trial) is not registered;
-- stop before the apprentice part is rewarded and the master part errors.
function pt_fix_mpr()
	if (AddMasterPRValue==nil) then
		Talk(1,"no","He thong su do hien chua mo tren may chu nay.")
		return 0
	end;
	return 1
end;

function  shitu_1()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		if(GetTask(899)==0)then		--±µ¥ô°È
			MsgBox("S­ phô ta th­êng b¶o muèn n©ng cao ph¸p thuËt c¸ch tèt nhÊt lµ m¹nh d¹n x«ng vµo chèn ma qu¸, ng­¬i muèn thö kh«ng?","shitu_1_begin","no")
		elseif(GetTask(899)==6)then	--§¹¦¨¥ô°È
			MsgBox("Chóc mõng! Víi c¸ch tËp luyÖn nµy ng­¬i c¶m thÊy m×nh m¹nh h¬n råi ph¶i kh«ng?","shitu_1_end","no")
		elseif(GetTask(899)==7)then
			Talk(1,"no","Ng­¬i qu¶ nhiªn kh«ng tÇm th­êng! B©y giê h·y ®Õn T©y Kú t×m D­¬ng TiÔn, cã nhiÖm vô míi cho ng­¬i!")
		else				--©ñ±ó¥ô°È
			MsgBox("Ng­¬i ch­a ®ñ kh¶ n¨ng hoµn thùc hiÖn nhiÖm vô nµy, ®îi khi kh¸c h·y thö l¹i!","shitu_1_cancel","no")
		end
	else
		if(GetTask(899)==0)then
			Talk(1,"no","Muèn n©ng cao ph¸p thuËt c¸ch tèt nhÊt lµ m¹nh d¹n x«ng vµo chèn ma qu¸i. Ng­¬i ®¹t cÊp 26 cã thÓ cïng s­ phô ®Õn chç ta nhËn thö th¸ch.")
		elseif(GetTask(899)==6)then
			Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
		elseif(GetTask(899)==7)then
			Talk(1,"no","Ng­¬i qu¶ nhiªn kh«ng tÇm th­êng! B©y giê h·y ®Õn T©y Kú t×m Na Tra, cã nhiÖm vô míi cho ng­¬i!")
		else
			MsgBox("Ng­¬i ch­a ®ñ kh¶ n¨ng hoµn thùc hiÖn nhiÖm vô nµy, ®îi khi kh¸c h·y thö l¹i!","shitu_1_cancel","no")
		end
	end
end

function shitu_1_begin()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		RemoveIBBuff(216)
		local done=AddIBBuff(216)
		if(done==1)then
			SetTask(899,1)
			TaskNote(43,5)
			if(GetTask(900)<7)then
				SetTask(900,0)
				TaskNote(44,-1)
			end
			if(GetTask(901)<7)then
				SetTask(901,0)
				TaskNote(45,-1)
			end
			if(GetTask(902)<7)then
				SetTask(902,0)
				TaskNote(46,-1)
			end
			Talk(2,"no","Ng­¬i ®ang trong vßng <color=yellow>Dòng gi¶<color>, tr­íc khi vßng s¸ng biÕn mÊt theo thø tù ®èi tho¹i víi <color=green>c¸c ®¹i phu trong 5 tÇng sa m¹c<color>, hoµn thµnh xem nh­ thÝ luyÖn thµnh c«ng!","§õng ®Ó vßng s¸ng biÕn mÊt vµ ph¶i cïng ®i víi s­ phô cña m×nh. §¹i phu mçi tÇng sÏ gióp ng­¬i trÞ liÖu vÕt th­¬ng.")
		else
			Talk(1,"no","Tr¹ng th¸i hiÖn thêi cña ng­¬i kh«ng thÓ tiÕp nhËn nhiÖm vô s­ ®å, khi kh¸c h·y quay l¹i!")
		end
	else
		Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
	end
end

function shitu_1_end()
	if (pt_fix_mpr()~=1) then return end;	-- npc_fix
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		shitu_1_end_P()
		local oldPlayer=PlayerIndex
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			shitu_1_end_M()
		end
		PlayerIndex=oldPlayer
	else
		Talk(1,"no","NhiÖm vô thö th¸ch s­ ®å cÇn ph¶i 2 ng­êi, xin x¸c nhËn l¹i tæ ®éi cña m×nh!")
	end
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


function shitu_1_end_P()
	local exp1=GetNextExp()-GetExp()
	local exp2=2*GetNextExp()
	local exp=2*GetNextExp()
	AddOwnExp(exp1)
	exp2=exp2-exp1
	exp1=GetNextExp()-GetExp()
	if(exp1<exp2)then
		AddOwnExp(exp1)
		AddOwnExp(exp2-exp1)
	else
		AddOwnExp(exp2)
	end
	SetTask(899,7)
	TaskNote(43,6)
	TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>"..exp.."kinh nghiÖm")
	local mark=step_complete()
	if(mark==1)and(GetTask(907)==0)then	--§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
		AddNormalItem(0,7,GetPlayerType()+6,4,0,0)
		SetTask(907,1)
		Talk(1,"no","Ng­¬i thËt xuÊt s¾c! Xin nhËn phÇn th­ëng!")
		AddGlobalCountNews("<color=green>"..GetName().."<color> vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>®Çu kh«i<color>",20)
--	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
--		AddNormalItem(3,14,0,0,0,0)
--		SetTask(903,1)
--		Talk(1,"no","¤g¦æ®]¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
	elseif(mark==4)and(GetTask(904)==0)then		--§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
		AddNormalItem2(0,10,GetPlayerType()+15,9,0,0)
		SetTask(904,1)
		Talk(1,"no","Qu¶ nhiªn anh hïng xuÊt thiÕu niªn! Xin nhËn phÇn th­ëng!")
		AddGlobalCountNews("<color=green>"..GetName().."<color>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>thó c­ìi cÊp 50<color>",20)
	else
		Talk(1,"no","Kh«ng ngê ng­¬i vµ s­ phô cã thÓ hoµn thµnh tèt thö th¸ch khã kh¨n nµy!")
	end
end

function shitu_1_end_M()
	local step=GetTask(899)
	if(step<100)then
		AddMasterPRValue(5)
		SetTask(899,100)
		TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>5 ®iÓm s­ ®å")
	else
		AddMasterPRValue(2)
		TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>2 ®iÓm s­ ®å")
		Talk(1,"no","LÇn tr­íc ng­¬i ®· nhËn th­ëng, nªn phÇn th­ëng lÇn nµy kh«ng ®­îc nhiÒu.")
	end
end


function shitu_1_cancel()
	RemoveIBBuff(216)
	SetTask(899,0)
	TaskNote(43,-1)
	Talk(1,"no","Hoang m¹c nguy hiÓm mu«n trïng, ng­¬i vÒ luyÖn tËp thªm mét thêi gian råi h·y quay l¹i!")
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

function   renwu2()
					-- npc_fix: event 1 consumed + task 1 23->24 in one transaction
					if (GetPlayerType()~=1) or (QuestExchange(1,23,24,{{4,1,0,0,0,0,1}},{})~=1) then
						Msg2Player("Chua the hoan thanh: can Than Oanh trong hanh trang.")
						CloseDialog()
						return
					end;
			Talk(1,"no",10114)
					Msg2Player("ThÇn Oanh kh«ng cã t¸c dông. §Õn t×m Thæ Hµnh T«n ®Ó t×m nguyªn nh©n.")
					TaskNote(28,14)
end;

function   renwu3()
			if (GetLevel()<55) or (GetTask(1)~=30) then	-- npc_fix: phase guard
				CloseDialog()
				return
			end;
			Talk(3,"no",10115,10116,10117)
					Msg2Player("§Õn D­îc ®iÕm t×m Hå Hû MÞ nghÜ c¸ch.")
					SetTask(1,31)			--½ÓµÀÊ¿35¼¶?Îñ
					TaskNote(28,16)
end;


function no()
		CloseDialog()
end;

-- 2026-10-03 sudo_dongdi: master-apprentice trial reopened (pt_fix_mpr disabled it while AddMasterPRValue
-- was unregistered: sudo_dongdi_lib.lua gives a harmless fallback) and also open without a master: a player
-- outside any team takes it alone. Doc: docs\features\su-do-dong-di-phong-than-20261003.md
Include("\\script\\phongthan\\ext\\sudo_dongdi_lib.lua")
function pt_fix_mpr()
	return 1
end
function judge_relation()
	return PTSD_JudgeRelation()
end

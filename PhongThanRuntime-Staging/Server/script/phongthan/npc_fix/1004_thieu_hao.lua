-- Phong Than npc_fix 2026-09-28: Thieu Hao (shao hao totem, map 1004); original \script\ChiYouMu\ShaoHaoTuTeng.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 30 15->16 reward 3+3 small potions via QuestExchange; Van Tien branch (menu show=0 in original) explicitly gated by PT_NPCFIX_WXZ_ENABLE and unregistered DelHandItem replaced by ClearItem; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÉÙê»Í¼ÌÚ-Ò©Æ·ÏúÊÛÕß
--author:  chensong
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"V¹n Tiªn trËn","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
	if (UTask_20==15)then
			tasks[1].show=1;
	end;
	if(UTask_20==0)  then
			tasks[1].show=1;
	end;
	SayTask(10162,tasks)
end;

function   renwu1()
	UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
	if (UTask_20==15)then
		-- npc_fix: 3 x (1,0,1,1,0,0) + 3 x (1,3,1,1,0,0) + task 30 15->16 in one transaction
		if (QuestExchange(30,15,16,{},{{1,0,1,1,0,0,3},{1,3,1,1,0,0,3}})~=1) then
			Msg2Player("Chua the nhan thuong: hanh trang can 6 o trong.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10163)
		Msg2Player("NhËn ®­îc phÇn th­ëng cña ThiÕu H¹o gåm 3 TiÓu Hång ®¬n vµ 3 TiÓu Hoµn ®¬n.")
		TaskNote(13,8)
	end;
	if(UTask_20==0)  then
		Talk(3,"no",10164,10165,10166)
		SetTask(30,1)
		TaskNote(13,0)
		Msg2Player("§­îc sù chØ dÉn cña ThiÕu H¹o. §Õn t×m Khoa Phô, Chóc Dung, Phong B¸ nhê gióp ®ì.")
	end;
end;


function no()
		CloseDialog()
end;
---------------------------
function   renwu2()
	-- npc_fix: Van Tien entry stays disabled (menu row show=0 in the VNG original);
	-- set PT_NPCFIX_WXZ_ENABLE=1 only after the mission on map 68 is verified.
	if (PT_NPCFIX_WXZ_ENABLE~=1) then
		CloseDialog()
		return
	end;
	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
				Talk(1,"no","Tr¹ng th¸i hiÖn t¹i cña ng­¬i kh«ng thÓ vµo V¹n Tiªn trËn.")
		elseif(GetLevel()<=50)or(GetLevel()>=71)then
				Talk(1,"no","§¼ng cÊp cña ng­¬i ch­a thÓ vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ, thö qua trËn kh¸c xem sao!")
		elseif(HaveNormalItem(3,63,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox("Ng­¬i muèn vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ ph¶i kh«ng?","yes_wxz","no")
		else
				Talk(1,"no","NÕu ng­¬i ®­a ta mét tÊm Thñy Linh phï th× ta sÏ gióp ng­¬i vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ.")
		end;
end;

function  yes_wxz()
	if (PT_NPCFIX_WXZ_ENABLE~=1) then	-- npc_fix: see renwu2
		CloseDialog()
		return
	end;
	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
	if(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<50)and(GetTask(421)~=GetMissionV(1))then
	
		DelNormalItem(3,63,0,0)
		ClearItem(3,66,0,0)
		ClearItem(3,67,0,0)
		ClearItem(3,68,0,0)
		ClearItem(3,69,0,0)
		for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)	
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
		end;
		SetFightState(0)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(1))then
		ClearItem(3,66,0,0)
		ClearItem(3,67,0,0)
		ClearItem(3,68,0,0)
		ClearItem(3,69,0,0)
			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;

		SetFightState(0)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==2)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(1))then
		ClearItem(3,66,0,0)
		ClearItem(3,67,0,0)
		ClearItem(3,68,0,0)
		ClearItem(3,69,0,0)
			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;
		SetFightState(1)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==2)then
	    Talk(1,"no","TrËn ®Êu ®ang diÔn ra, xin ®îi gi©y l¸t!")
	elseif(GetMSPlayerCount(2,1)>=50)then
	    Talk(1,"no","§· ®ñ 50 ng­êi, lÇn sau quay l¹i nhÐ!")
	else
		Talk(1,"no","V¹n Tiªn trËn (thñy) ®· ®ãng, lÇn sau quay l¹i nhÐ!")
	end;
end;

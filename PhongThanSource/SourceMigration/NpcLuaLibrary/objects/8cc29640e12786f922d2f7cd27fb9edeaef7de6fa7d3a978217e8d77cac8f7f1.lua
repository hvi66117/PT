--description: ÉÙê»Í¼ÌÚ-Ò©Æ·ÏúÊÛÕß
--author:  chensong
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"V¹n Tiªn trËn","renwu2";show=0}
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
		Talk(1,"no",10163)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		Msg2Player("NhËn ®­îc phÇn th­ëng cña ThiÕu H¹o gåm 3 TiÓu Hång ®¬n vµ 3 TiÓu Hoµn ®¬n.")
		TaskNote(13,8)
		SetTask(30,16)
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
	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
	if(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<50)and(GetTask(421)~=GetMissionV(1))then
	
		DelNormalItem(3,63,0,0)
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
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
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
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
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
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

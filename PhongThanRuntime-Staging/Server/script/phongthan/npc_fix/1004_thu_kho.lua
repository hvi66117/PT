-- Phong Than npc_fix 2026-09-28: Thu Kho (warehouse keeper, map 1004); original script.pak \script\ChiYouMu\CangKuGuanLiYuan.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes (same pattern as npc_fix\1002_thu_kho.lua): exit row on both SayTask menus; renwu1 task 33 phase 1->2 consumes 5x(3,8,0,0) via QuestExchange; huan() task 36 phase 8|12->0 consumes 10 materials and grants the rolled item (EventItem 39 or green equip) in one QuestExchange, money/credit/news only after success.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
Include("\\script\\phongthan\\npc_fix\\ruong_mo_rong.lua")
--description: ²Ö¿â¹ÜÀí³¥
--author: yichuan
--date: 2004/6/28

function main(sel)
	tasks =
	{
		{"Më r­¬ng chøa ®å","mo_ruong";show=1},
		{"Thu thËp","renwu2";show=0},
		{"Sö dông Thñ khè","renwu1";show=0},
		{"Nguyªn liÖu","ma";show=1},
		{"Long Phông phï","longfeng";show=0},
		{"Më réng r­¬ng (R­¬ng 2-5)","mo_rong_ruong";show=1},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	-- npc_fix 2026-10-03 newbiefix: row mo_ruong was inserted at tasks[1], so every show index below is +1.
	UTask_xiangzi=GetTask(33);
	UTask_bianliang=GetTask(36); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
	if(UTask_xiangzi==1)and(HaveNormalItem(3,8,0,0)>=5)then
			tasks[3].show=1;
	end;
	if(UTask_xiangzi==0)then
			tasks[3].show=1;
	end;
	if (HaveNormalItem(3,UTask_bianliang,0,0)>=10) then
			tasks[2].show=1;
	end;
	if (UTask_bianliang==0)and(GetLevel()>=6) then
			tasks[2].show=1;
	end;
	---»î¶¯¹Ø±Õ
	---if(GetExtPoint(6)==1)then
	---			tasks[5].show=1
	---end;
		SayTask(10073,tasks)
end;

function  renwu1()
		UTask_xiangzi=GetTask(33);

		if(UTask_xiangzi==1)and(HaveNormalItem(3,8,0,0)>=5)then
				if(QuestExchange(33,1,2,{{3,8,0,0,0,0,5}},{})~=1)then	-- npc_fix: 5 Hoa vu + task 33 1->2 in one transaction
						Msg2Player("Can du 5 Hoa vu trong hanh trang.")
						CloseDialog()
						return
				end;
				Talk(1,"no",10074)
				Msg2Player("Cã thÓ sö dông r­¬ng chøa ®å ®Ó cÊt gi÷ vËt phÈm!")
				TaskNote(3,1)
				TaskNote(9,1)
				TaskNote(15,1)
				SetTask(13,2)
				SetTask(23,2)
		end;


		if(UTask_xiangzi==0)then
				MsgBox("Hµnh trang cña ng­¬i hÕt chç trèng råi! T×m gióp ta <color=red> 5 Háa vò<color>, ta sÏ lµm cho ng­¬i 1 chiÕc r­¬ng!","yes_1","no")
		end;
end;

function   longfeng()
	if(GetExtPoint(6)>=1)then
			MsgBox("N¨m x­a vÞ Èn sÜ cã tÆng ta mét tÊm Long Phông phï, nhê ta tÆng l¹i cho ng­êi cã duyªn. Xem ra ta ®· t×m ®óng ng­êi, ng­¬i muèn nhËn kh«ng?","lf","no")
	end;
end;

function   lf()
		PayExtPoint(6,1)
		AddNormalItem(6,1,32,1,0,0)
		CloseDialog()
		Msg2Player("B¹n nhËn ®­îc Long Phông phï.")
end;

function  renwu2()
		UTask_bianliang=GetTask(36); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
			local  w=""
			if (UTask_bianliang==8) then
					w="Háa vò"
			elseif (UTask_bianliang==12) then
					w="MÆt Quû"
			end;
			if (HaveNormalItem(3,UTask_bianliang,0,0)>=10) then
					MsgBox("Ng­¬i ®· vÒ råi µ? Cã ph¶i muèn ®­a "..w.." cho ta kh«ng?","huan","no")
			end;

			if (UTask_bianliang==0)and(GetLevel()>=6) then  --½Ó?ÎñÊ±µÄ¶Ô»°
					Talk(1,"yes_2",10075)
			end;
end;

function  yes_2()
	    local i=random(1,2);
		local  w="";
					if (i==1) then
							w="Háa vò"
							MsgBox("Nguyªn liÖu lÇn nµy cÇn 10 <color=Red>"..w.."<color>, kh«ng vÊn ®Ò chø?","qd1","no")
					else
							w="MÆt Quû"
							MsgBox("Nguyªn liÖu lÇn nµy cÇn 10 <color=Red>"..w.."<color>, kh«ng vÊn ®Ò chø?","qd2","no")
					end;

end;

function  qd1()
		SetTask(36,8)
		Msg2Player("§ång ý t×m 10 Háa vò cho Thñ khè Xi V­u mé.")
		TaskNote(18,0,"Háa vò")
		CloseDialog()
end;

function  qd2()
		SetTask(36,12)
		Msg2Player("§ång ý t×m 10 MÆt Quû cho Thñ khè Xi V­u mé.")
		TaskNote(18,0,"MÆt Quû")
		CloseDialog()
end;

function huan()     --Íê³É?Îñ£¬¸øÓè½±Àø¡£
	local UTask_bianliang=GetTask(36); --ÒÔ´ËÇø±ðÃ¿´Î?ÎñËùÐèµÄÔ­ÁÏÖÖ¯C
	if (HaveNormalItem(3,UTask_bianliang,0,0)>=10) then
		local k=random(1,100000)
		local green20=GetTask(810)--°O¿ý20¯Åºñ¸Ë¥ô°È¤¤ºñ¸ËªºÀò±o¦¸¼Æ
		local PlayerLevel=GetLevel()
		if (PlayerLevel>50) then
			PlayerLevel=50
		end
		local reward=0		-- npc_fix: 0 none, 1 EventItem 39, 2 green equipment
		if (k<=10000) then
			reward=1
		elseif (k>10000) and (k<=20000) and  (PlayerLevel<=25) and  (green20==0)  then
			reward=2
		elseif (k>20000) and (k<=21000) and  (PlayerLevel<=25) and  (green20>=1) and  (green20<=2)  then
			reward=2
		elseif (k>21000) and (k<=21500) and  (PlayerLevel<=25) and  (green20>=3) then
			reward=2
		elseif (k>21500)  and (k<21900-PlayerLevel*PlayerLevel*7/50) and (PlayerLevel>25) then
			reward=2
		end
		local rewards={}
		if (reward==1) then
			rewards={{4,39,0,0,0,0,1}}
		elseif (reward==2) then
			rewards={GreenEquipmentTuple()}
		end
		-- npc_fix: materials, reward item and task 36 -> 0 in one transaction
		if (QuestExchange(36,UTask_bianliang,0,{{3,UTask_bianliang,0,0,0,0,10}},rewards)~=1) then
			Msg2Player("Can du 10 nguyen lieu trong hanh trang va cho trong.")
			CloseDialog()
			return
		end
		if (reward==1) then
			Talk(1,"no",10077)
		elseif (reward==2) then
			GreenEquipment()
		else
			Talk(1,"no",10086)
		end
		Earn(600)
		Msg2Player("®· hoµn thµnh nhiÖm vô Thñ khè, danh väng t¨ng lªn, nhËn ®­îc 600 l­îng.")
		TaskNote(18,-1)
		AddCredit(1)
	end
end;

-- npc_fix: the random equipment roll of GreenEquipment(), as a QuestExchange tuple
-- (same identity AddNormalItem2(0,n,p,1,1,0) created).
function GreenEquipmentTuple()
	local n=random(0,2)--?¶¨»ñµÃ×°±¸µÄ¾ß·¥¯C±ð
	local p=random(3,5)
	if (n==0 )then --?¶¨p£¬¼´×°±¸µÄÏêÏ¸¯C±ð
			n=5
	elseif (n==1) then
			n=6
	elseif (n==2) then
			n=7
	end;
	return {0,n,p,1,1,0,1}--µÀ¾ßÖÖ¯C0£¬¾ß·¥¯C±ðn£¬ÏêÏ¸¯C±ðp£¬µÈ¼¶1
end

function GreenEquipment()
	Talk(1,"no",10007)
	SetTask(810,GetTask(810)+1)
	l=GetName()
	if(GetLevel()<30)then
		AddGlobalCountNews("<color=green>"..l.."<color> ®· thu thËp ®ñ nguyªn liÖu cho Thñ khè Xi V­u mé, ®­îc tÆng mét trang bÞ <color=green>"..l.."<color>.",20)
	end;
end




function no()
		CloseDialog()
end;


function   ma()
			tasks1 =
			{
				{"§o¶n KiÕm","dj";show=1},
				{"M¶nh Gi¸p","sj";show=1},
				{"B¨ng c¬","bj";show=1},
				{"Ngäc cèt","yg";show=1},
				{"MÆt Quû","gm";show=1},
				{"Háa vò","hy";show=1},
				{"KÕt thóc ®èi tho¹i","no";show=1}
			}
		SayTask(10085,tasks1)
end;

function   dj()
		MsgBox(10078,"ma")
end;

function  sj()
		MsgBox(10079,"ma")
end;

function   bj()
		MsgBox(10080,"ma")
end;

function   yg()
		MsgBox(10081,"ma")
end;

function   gm()
		MsgBox(10082,"ma")
end;

function   hy()
		MsgBox(10083,"ma")
end;


function yes_1()
		SetTask(33,1)
		Talk(1,"no",10084)
		Msg2Player("TiÕp nhËn nhiÖm vô, gióp Thñ khè t×m 5 Háa vò.")
		TaskNote(15,0)
end;


-- npc_fix 2026-10-02: no chest object exists on the city maps, so the keeper opens the storage box directly (VNG chest script did SetFightState(0) + OpenBox(2)).
function mo_ruong()
	SetFightState(0)
	OpenBox(2)
end;

-- ruong 2026-10-03: Ruong 2..5 = cac trang "Ruong mo rong" 1..4 (GetExpandBox/SetExpandBox), xem npc_fix\ruong_mo_rong.lua.
-- Dong menu nay nam ngay truoc dong ket thuc nen chi so tasks[] cu khong doi.
function mo_rong_ruong()
	PTRUONG_Menu()
end;

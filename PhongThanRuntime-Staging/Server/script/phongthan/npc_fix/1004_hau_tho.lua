-- Phong Than npc_fix 2026-09-28: Hau Tho (hou tu totem, map 1004); original \script\ChiYouMu\HouTuTuTeng.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 31 5->6 consumes 10 Mat Quy (3,12) via QuestExchange before Earn/exp; yes_1 guarded to phase 0; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ºóÍÁÍ¼ÌÚ-×°±¸ÏúÊÛÉÌ-ò¿ÓÈÄ¹1¼¶ÈÎÎñ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
				tasks[1].show=1;
	end;		
	if (UTask_21 == 0)and(GetLevel()>=3)  then
				tasks[1].show=1;
	end;		
	SayTask(10154,tasks)
end;

function   renwu1()
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
			-- npc_fix: 10 x (3,12) consumed + task 31 5->6 in one transaction
			if (QuestExchange(31,5,6,{{3,12,0,0,0,0,10}},{})~=1) then
				Msg2Player("Chua the hoan thanh: can du 10 Mat Quy trong hanh trang.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10155)
			Earn(600)
			AddOwnExp(500)
			Msg2Player("Gióp HËu Thæ t×m ®ñ nguyªn liÖu, nhËn ®­îc 600 l­îng + 500 ®iÓm kinh nghiÖm.")
			TaskNote(14,5)
	end;

	if (UTask_21 == 0)and(GetLevel()>=3)  then
			MsgBox(10156,"yes_1","no")		
	end;
end;

function yes_1()
		if (GetTask(31)~=0) then	-- npc_fix: never reset an accepted quest
			CloseDialog()
			return
		end;
		Talk(1,"no",10157)
		Msg2Player("T×m Cao Gi¸c hái vÒ nguyªn liÖu cã thÓ t¨ng tİnh n¨ng cña trang bŞ.")
		TaskNote(14,0)
		SetTask(31,1)
end;

function no()
		CloseDialog()
end;

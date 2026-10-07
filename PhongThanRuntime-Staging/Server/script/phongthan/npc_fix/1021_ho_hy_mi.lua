-- Phong Than npc_fix 2026-09-28: Ho Hy Mi (hu ximei, map 1021); original script.pak \script\ChaoGe\HuXiMei.lua (pinyin of GBK PAK path); changes: exit row in SayTask; Ba Lac nhan (3,46) grants via QuestExchange: task 3 32->40, task 1 33->40, task 2 34->40 (events 13/2/19 are kept, as in the original: Dac Ky 60->61 consumes them); renwu3 task 2 1->2 grants event 15 via QuestExchange (phase guard: Di Nhan, level>=25); renwu2 31->32 re-checked; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ºúÏ²ÃÄ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/9

function main()
			UTask_Knight = GetTask(3);
			UTask_Wizard = GetTask(1);
			UTask_Druid = GetTask(2);
			tasks = 
			{
					 {"ThÇn Long","renwu1";show=0},
					 {"ThÇn Méc","renwu2";show=0},
					 {"Mao L­","renwu3";show=0},
					 {"Ma huyÕt","renwu4";show=0},
					 {"KÕt thóc ®èi tho¹i","no";show=1}
			}
			if(GetLevel()>=55)  and  (UTask_Knight ==32) and  (HaveEventItem(13)>=1)then
						 tasks[1].show=1;
			end;
			if(UTask_Wizard ==33)  and ( HaveEventItem(2)>=1)then
						 tasks[2].show=1;
			end;
			if(GetLevel()>=55)  and  (UTask_Wizard ==31 )then
						 tasks[2].show=1;
			end;
			if(GetLevel()>=25 ) and ( UTask_Druid==1)then
						 tasks[3].show=1;
			end;
			if(GetLevel()>=55)  and  (UTask_Druid==34)and  (HaveEventItem(19)>=1)then
						 tasks[4].show=1;
			end;
			SayTask(10041,tasks)
end;

function  renwu1()
		UTask_Knight = GetTask(3);
		if(GetLevel()>=55)  and  (UTask_Knight ==32) and  (HaveEventItem(13)>=1)then
					-- npc_fix: Ba Lac nhan + task 3 32->40 in one transaction (event 13 kept)
					if (QuestExchange(3,32,40,{},{{3,46,0,0,0,0,1}})~=1) then
						Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
						CloseDialog()
						return
					end;
					Talk(3,"no",10042,10043,10167)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10. Cã thÓ tù do ra vµo Léc ®µi.")
					TaskNote(27,15)
		end 
end;

function  renwu2()
		UTask_Wizard = GetTask(1);
		if(GetLevel()>=55)  and(UTask_Wizard ==33)  and ( HaveEventItem(2)>=1)then
					-- npc_fix: Ba Lac nhan + task 1 33->40 in one transaction (event 2 kept)
					if (QuestExchange(1,33,40,{},{{3,46,0,0,0,0,1}})~=1) then
						Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
						CloseDialog()
						return
					end;
					Talk(1,"no",10044)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10. Cã thÓ tù do ra vµo Léc ®µi.")
					TaskNote(28,19)
		end;

		if(GetLevel()>=55)  and  (UTask_Wizard ==31 )then
					Talk(3,"no",10045,10046,10047)
					SetTask(1,32)
					Msg2Player("Muèn gÆp §¾c Kû cÇn ph¶i cã ThÇn Méc.")
					TaskNote(28,17)
		end;
end;


function  renwu3()
					if (GetLevel()<25) then	-- npc_fix: menu condition re-checked
						CloseDialog()
						return
					end;
					-- npc_fix: event 15 (thiep moi) + task 2 1->2 in one transaction
					if (QuestExchange(2,1,2,{},{{4,15,0,0,0,0,1}})~=1) then
						Msg2Player("Chua the nhan thiep moi: hanh trang khong du cho trong.")
						CloseDialog()
						return
					end;
					Talk(1,"no",10048)
					Msg2Player("NhËn ®­îc thiÕp mêi dù tiÖc.")	
					TaskNote(29,1)
end;


function  renwu4()
		UTask_Druid = GetTask(2);	-- npc_fix: re-read (original relied on the global from main)
		if(GetLevel()>=55)  and  (UTask_Druid==34)and  (HaveEventItem(19)>=1)then
					-- npc_fix: Ba Lac nhan + task 2 34->40 in one transaction (event 19 kept)
					if (QuestExchange(2,34,40,{},{{3,46,0,0,0,0,1}})~=1) then
						Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
						CloseDialog()
						return
					end;
					Talk(1,"no",10049)
					TaskNote(29,14)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10, cã thÓ tù do ra vµo Léc ®µi.")
		end 
end;

function   no()
		CloseDialog()
end;



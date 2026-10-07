-- Phong Than npc_fix 2026-09-28: Tay Vuong Mau (xi wangmu, map 1052); original script.pak \script\YaoChi\XiWangMu.lua (pinyin of GBK PAK path, bound directly before this fix); changes: exit row in SayTask; renwu1 43->50 swaps event 3 for the random skill book via QuestExchange on the player's own class task (3/1/2); renwu1 41->42 and renwu2 70->71 guarded on the player's own class task (renwu2 also level>=80); marriage branches unchanged.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: Î÷ÍõÄ¸-Ö÷Ïß?Îñ\½á»éÏµÍ³
--author: yichuan
--date:2004/5/11
--modify:liuying 2005/4/4

function main()	
	tasks = 
	{
		{"B×nh An","renwu1";show=0},
		{"Cæ Kim","renwu2";show=0},
		{"Nghe","story";show=1},
		{"§i ViÔn Cæ","old";show=1},
		{"§Õn T­¬ng lai","new";show=1},
		{"CÇu h«n","qiuhunm";show=0},
		{"KÕt h«n","jiehun";show=0},
		{"§Ýnh h«n","qiuhunf";show=0},
		{"Hñy bá cÇu h«n","qxqh";show=0},
		{"Hñy bá ®Ýnh h«n","qxqh";show=0},
		{"Ly h«n","lihun";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Knight = GetTask(3);
	UTask_Wizard = GetTask(1);
	UTask_Druid = GetTask(2);
	UT_Marry=GetTask(800); --¼ÇÂ¼Íæ¼ÒÇó»é¡¢¶©»é×´Ì¬0,1Çó»é£¬2¶©»é
	UT_MateId=GetTask(801); --¼ÇÂ¼¶¯×÷¶ÔÏóID
	if(GetLevel()>=80 )then
				if(UTask_Knight ==70) or  (UTask_Wizard ==70)  or  (UTask_Druid ==70 )then
						tasks[2].show=1;
				end;	
	end;
	if(GetLevel()>= 65)then
					if(UTask_Knight ==41) or  (UTask_Wizard ==41)  or  (UTask_Druid ==41 )then
							tasks[1].show=1;
					end;

					if(UTask_Knight ==43) or  (UTask_Wizard ==43)  or  (UTask_Druid ==43)then
							if(HaveEventItem(3)==1)then
								tasks[1].show=1;
							end;
					end;
	end;
	if(GetSex()==0)then--ÄÐÐÔÍæ¼Ò
				if((UT_Marry==0)and(CanMarry()==1))then
						tasks[6].show=1;--³öÏÖÇó»éµÄÌáÊ¾
				elseif((UT_Marry==2)and(CanMarry()==1))then
						tasks[7].show=1;--³öÏÖ½á»éµÄÌáÊ¾
				elseif((UT_Marry==1)and(CanMarry()==0))then
						tasks[9].show=1;--³öÏÖ?ÏûÇó»éÌáÊ¾
				elseif((UT_Marry==2)and(CanMarry()==0))then
						tasks[10].show=1;--³öÏÖ?Ïû¶©»éÌáÊ¾
				elseif(IsMarried()==1)then
						tasks[11].show=1;--³öÏÖÀë»éÌáÊ¾
				end;
	else--Å®ÐÔÍæ¼Ò
				if(UT_Marry==0)and(CanMarry()==1)and(GetMateTask(800)==1)then
						tasks[8].show=1; --³öÏÖÓÐ?ÏòÄãÇó»éµÄÌáÊ¾
				elseif((UT_Marry==2)and(CanMarry()==0))then
						tasks[10].show=1;--³öÏÖ?Ïû¶©»éÌáÊ¾
				elseif(IsMarried()==1)then
						tasks[11].show=1;--³öÏÖÀë»éÌáÊ¾
				end;
	end;
	SayTask(10509,tasks)
end;

-- npc_fix: main-quest task of the player's own class (0 Giap Si -> 3, 1 Dao Si -> 1, 2 Di Nhan -> 2)
function pt_fix_task()
		local t=GetPlayerType()
		if (t==0) then
			return 3
		elseif (t==1) then
			return 1
		end;
		return 2
end;

function   renwu2()
						if (GetLevel()<80) or (GetTask(pt_fix_task())~=70) then	-- npc_fix: phase guard
							CloseDialog()
							return
						end;
						Talk(1,"no",10510)
						Msg2Player("§Õn TriÒu Ca 10 n¨m sau ®Ó c¶m nhËn cuéc sèng lóc ®ã.")
						if(GetPlayerType()==0)then
							SetTask(3,71)
							TaskNote(27,27)
						end;
						if(GetPlayerType()==1)then
							SetTask(1,71)
							TaskNote(28,31)
						end;
						if(GetPlayerType()==2)then
							SetTask(2,71)
							TaskNote(29,26)
						end;

end;

function   renwu1()
		UTask_Knight = GetTask(3);
		UTask_Wizard = GetTask(1);
		UTask_Druid = GetTask(2);
		if(GetLevel()>= 65)then
					if (GetTask(pt_fix_task())==41) then	-- npc_fix: own class task only (original: any of the three ==41)
								Talk(1,"no",10511)
								Msg2Player("T×m An C­ ®å cho T©y V­¬ng MÉu")
								if(GetPlayerType()==0)then
									SetTask(3,42)
									TaskNote(27,17)
								end;
								if(GetPlayerType()==1)then
									SetTask(1,42)
									TaskNote(28,21)
								end;
								if(GetPlayerType()==2)then
									SetTask(2,42)
									TaskNote(29,16)
								end;
					end;
					if(UTask_Knight ==43) or  (UTask_Wizard ==43)  or  (UTask_Druid ==43)then
								if(HaveEventItem(3)==1)then
										-- npc_fix: event 3 -> random skill book and class task 43->50 in one transaction
										local  i=random(1,121)
										local  book={7,55,456,1,0,0,1}
										if(i<=11)then
											book={7,16,19,1,0,0,1}
										elseif(i<=22)then
											book={7,17,20,1,0,0,1}
										elseif(i<=33)then
											book={7,18,21,1,0,0,1}
										elseif(i<=44)then
											book={7,19,22,1,0,0,1}
										elseif(i<=55)then
											book={7,33,36,1,0,0,1}
										elseif(i<=66)then
											book={7,34,37,1,0,0,1}
										elseif(i<=77)then
											book={7,35,38,1,0,0,1}
										elseif(i<=88)then
											book={7,36,39,1,0,0,1}
										elseif(i<=99)then
											book={7,45,48,1,0,0,1}
										elseif(i<=110)then
											book={7,46,49,1,0,0,1}
										end;
										if (QuestExchange(pt_fix_task(),43,50,{{4,3,0,0,0,0,1}},{book})~=1) then
											Msg2Player("Chua the nhan thuong: can An Cu do va cho trong hanh trang.")
											CloseDialog()
											return
										end;
										Talk(1,"no",10512)
										Msg2Player(" T©y V­¬ng MÉu tÆng s¸ch kü n¨ng, b¹n cã thÓ ®Õn ViÔn Cæ m¹o hiÓm.")
										if(GetPlayerType()==0)then
											TaskNote(27,19)
										end;
										if(GetPlayerType()==1)then
											TaskNote(28,23)
										end;
										if(GetPlayerType()==2)then
											TaskNote(29,18)
										end;
								end;
					end;
		end;
end;

function  story()
		Talk(1,"story_1",10513)
end;

function  story_1()
		Talk(1,"story_2",10514)
end;

function  story_2()
		Talk(1,"story_3",10515)
end;

function  story_3()
		Talk(1,"no",10516)
end;


function  old()
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then          --Éæ¼°?Îñ£¬ÓÐµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿?Îñ½â³ý£¬¹ý³ÌÖÐ²»¿ÉÊ¹ÓÃ´«ËÍ
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
		elseif(GetPK()>=88)then
				Msg2Player("Ng­êi ch¬i tªn ch÷ ®á kh«ng thÓ chuyÓn ®Õn ViÔn Cæ")
		elseif(GetCamp()==0)then
				Msg2Player("T©n thñ kh«ng thÓ vµo ViÔn Cæ")
		else
				SetLogoutRV(1)
				NewWorld(64,1600,3238)
				SetFightState(0)
				SetRevPos(64,216)
				Msg2Player("B¹n ®· thiÕt lËp ®iÓm trïng sinh t¹i ViÔn Cæ")
		end;
		CloseDialog()
end;

function  new()
         if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then          --Éæ¼°?Îñ£¬ÓÐµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿?Îñ½â³ý£¬¹ý³ÌÖÐ²»¿ÉÊ¹ÓÃ´«ËÍ
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
		else
				NewWorld(63,1506,3298)
				SetFightState(1)
		end;
		CloseDialog()
end;

function  no()
		CloseDialog()
end;

function  qiuhunm()
		if((CanMarry()==1)and(GetTask(800)==0))then
			if(GetMateTask(800)==2)then																		--¶Ô·½Task800==2Ê±ÒÑ¾­ÓÐ³Ñ¶©»éµÄ?£¬²»ÄÜÏòÒÑ¾­¶©»éµÄÇó»é
				MsgBox(10636,"no")
			else
				local i=PlayerIndex
				local n=0
				if(IsCaptain()==0)then
					n=GetTeamMember(1)
				else
					n=GetTeamMember(2)
				end;
				PlayerIndex=n
				local w=GetName()			--?¶ÏÓÑµÄÃû×Ö
				PlayerIndex=i				--»¹Ô­PlayerIndex
				MsgBox("Ng­¬i muèn cÇu h«n <color=green>"..w.."<color> chø?","yes_qm","no")
			end;
		else
			if(CanMarry()==0)then
				MsgBox(10637,"no")
			else
				MsgBox(10638,"no")
			end;
		end;
end;

function  yes_qm()
	if((CanMarry()==1)and(GetMateTask(800)==0)and(GetTask(800)==0))then														--¶Ô·½Task800==2Ê±ÒÑ¾­ÓÐ³Ñ¶©»éµÄ?£¬²»ÄÜÏòÒÑ¾­¶©»éµÄÇó»é
		if(HaveNormalItem(3,79,0,0)>=1)then
			DelNormalItem(3,79,0,0)		--ÊÕÒ»ºì±¦Ê¯
			SetTask(800,1)				--UT_Marry==1½ø?Çó»é×´Ì¬
			UT_MateId=GetMateNameID()
			SetTask(801,UT_MateId)			--±ê¼ÇÇó»é¶ÔÏóµÄID
			local i=PlayerIndex
			local n=0
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			local w=GetName()				--?¶ÏÓÑµÄÃû×Ö
			PlayerIndex=i
			local myname=GetName()
			AddGlobalCountNews("<color=green>"..myname.."<color> ®· cÇu h«n <color=green>"..w.."<color> Chóng ta h·y cïng chóc mõng <color=green>"..GetName().."<color>",20)--		MsgBox("§Ú·|©M§A¤ß·Rªº¤H»¡³o¥ó¨Æ±¡ªº¡A§A´N©ñ¤ß¦n¤F","no")
			MsgBox(10639,"no")
		else
			MsgBox(10640,"no")
		end;
	else
		if(CanMarry()==0)then
			MsgBox(10637,"no")
		else
			MsgBox(10641,"no")
		end;
	end;		
end;

function  qiuhunf()
	if(CanMarry()==1)then
		if((GetMateTask(800)==1)and(GetMateTask(801)==GetNameID())and(GetTask(800)==0))then		--»¥ÏàID¢´Åä
			local i=PlayerIndex
			local n=0
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			local w=GetName()				--?¶ÏÓÑµÄÃû×Ö
			PlayerIndex=i
			MsgBox("<color=green>"..w.."<color> muèn cÇu h«n ng­¬i, ®ång ý chø?","yes_qf","no_qf")
		else
			MsgBox(10642,"no")
		end;
	else
		MsgBox(10643,"no")
	end;
end;


function  yes_qf()
	if(CanMarry()==1)then
		if((GetMateTask(800)==1)and(GetMateTask(801)==GetNameID())and(GetTask(800)==0))then		--»¥ÏàID¢´Åä
			SetTask(800,2)					--×Ô¼º½ø?¶©»é×´Ì¬
			SetMateTask(800,2)				--?¶ÏÓÑ½ø?¶©»é×´Ì¬
			UT_MateId=GetMateNameID()
			SetTask(801,UT_MateId)				--±ê¼ÇÄÐ·½ID
			Msg2Player("B¹n nhËn lêi cÇu h«n!")
			PolyMorph(367,0,0,10,1800)			--ÐÂÄï±äÉí
			local i=PlayerIndex
			local n=0
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			PolyMorph(412,0,0,10,1800)		--ÐÂÀÉ±äÉí
			PlayerIndex=i
			CloseDialog()
		else
			MsgBox(10642,"no")
		end;		
	else
		MsgBox(10643,"no")
	end;
end;

function  no_qf()
	if((CanMarry()==1)and(GetMateTask(801)==GetNameID()))then		--»¥ÏàID¢´Åä
		SetMateTask(800,0)				--Çå³ý¶ÏÓÑ±ê¼Ç
		SetMateTask(801,0)
		Msg2Player("B¹n tõ chèi lêi cÇu h«n!")
    	CloseDialog()
	else
		if(CanMarry()==0)then
			MsgBox(10643,"no")
		else
			MsgBox(10644,"no")
		end;
	end;
end;

function  jiehun()
		MsgBox(10645,"yes_j","no")
end;

function  yes_j()
	if(CanMarry()==1)then
		if((GetMateNameID()==GetTask(801))and(GetMateTask(800)==2)and(GetTask(801)==GetMateNameID())and(GetTask(800)==2))then   --»¥ÏàID¢´Åä
			if(GetCash()>=1314520)then
				DoMarry()				--½á»éº¯Êýµ÷ÓÃ
				CloseDialog()
			else
				MsgBox(10648,"no")
			end;
		else
				MsgBox(10649,"no")
		end;
	else
		MsgBox(10643,"no")
	end;
end;

function  qxqh()
	MsgBox(10650,"clear","no")
end;

function  clear()
	SetTask(800,0)
	SetTask(801,0)
	Msg2Player("B¹n ®· hñy bá h«n ­íc!")
	CloseDialog()
end;

function   lihun()
	MsgBox(10651,"yes_li","no")
end;


function   yes_li()
	if(IsMarried()==1)then
		if(GetCash()>=888888)then
			Pay(888888)
			UnMarry()
			MsgBox(10652,"no")
			CloseDialog()
		else
			MsgBox(10653,"no")
		end;
	else
		MsgBox(10652,"no")
	end;	
end;

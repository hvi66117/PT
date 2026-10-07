-- Phong Than npc_fix 2026-09-28: Vo Vuong (wu wang, map 1020); original script.pak \script\XiQi\WuWang.lua (pinyin of GBK PAK path); changes: exit row in SayTask; func_sun2 62->63 consumes event 4 and renwu1 63->70 consumes events 6+7+8 and grants the level-70 treasure (0,4,14..17,1) via QuestExchange on the player's own class task (3/1/2); dongyi (593==1) 597 25->26 consumes event 110 via QuestExchange; dongyi1 597 ==27 guard; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÎäÍõ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

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


function main()
	tasks = 
	{
		{"Tam s¸ch","renwu1";show=0},
		{"PhÇn th­ëng ","renwu";show=0},
		{"VÞ quèc lËp c«ng","renwu2";show=0},
		{"§¼ng cÊp","renwu3";show=1},
		{"Di b¸o","dongyi";show=0},
		{"§Æng Cöu C«ng hµng Chu","dongyi1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1)
	UTask_Knight = GetTask(3)
	UTask_Druid = GetTask(2)
	local UTask_num = GetTask(42);--42ºÅ±äÁ¿ÓÃÀ´¼ÇÂ¼65¼¶Ö÷Ïß?ÎñÏÂ£¬ÊÇ·ñ´òÍê3¸ö?Îñ¹Ö
	if(UTask_Knight ==62)  or  (UTask_Druid ==62) or  (UTask_Wizard ==62 )then
			if(HaveEventItem(4)>=1)then
					tasks[1].show=1;
			end;
	end;
	if(UTask_Knight ==63) or  (UTask_Druid ==63) or  (UTask_Wizard ==63 )then 
				if(HaveEventItem(6)>=1)  and  (HaveEventItem(7)>=1)  and  (HaveEventItem(8)>=1) and (UTask_num==7) then	 
							tasks[1].show=1;
				end;
	end;
	if(GetLevel()>=35) and (GetTask(330)==2)and (SystemTime()<1111917600)then
				tasks[2].show=1;
	end;
	if(1==GetTask(421))or(2==GetTask(421))then
		if (20>GetTask(420))then
			tasks[3].show=1;
		end;
	end;
	if(25==GetTask(597))and(HaveEventItem(110)>=1)and(GetTask(592)~=1)then
		tasks[5].show=1;
	end;
	if(27==GetTask(597))then
		tasks[6].show=1;
	end;
		SayTask(10484,tasks)
end;

function   renwu1()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	local UTask_num = GetTask(42);--42ºÅ±äÁ¿ÓÃÀ´¼ÇÂ¼65¼¶Ö÷Ïß?ÎñÏÂ£¬ÊÇ·ñ´òÍê3¸ö?Îñ¹Ö
	if(UTask_Knight ==62)  or  (UTask_Druid ==62) or  (UTask_Wizard ==62 )then
					Talk(2,"func_sun",10485,10486)
	end;

	if(UTask_Knight ==63) or  (UTask_Druid ==63) or  (UTask_Wizard ==63 )then 
					if(HaveEventItem(6)>=1)  and  (HaveEventItem(7)>=1)  and  (HaveEventItem(8)>=1) and (UTask_num==7) then
								-- npc_fix: events 6+7+8 -> treasure and class task 63->70 in one transaction
								local  i=random(14,17)
								if (QuestExchange(pt_fix_task(),63,70,{{4,6,0,0,0,0,1},{4,7,0,0,0,0,1},{4,8,0,0,0,0,1}},{{0,4,i,1,0,0,1}})~=1) then
									Msg2Player("Chua the nhan thuong: can du 3 bo sach va cho trong hanh trang.")
									CloseDialog()
									return
								end;
								Talk(1,"no",10487)
								Msg2Player(" NhËn ®­îc ph¸p b¶o cÊp 70.")
								if (GetPlayerType()==1)then
										TaskNote(28,30)
								end;
								if(GetPlayerType()==0)then
										TaskNote(27,26)
								end;
								if(GetPlayerType()==2)then
										TaskNote(29,25)
								end;
							
					end;
	end;
end;

function  func_sun()
		Talk(2,"func_sun1",10488,10623)
end;

function  func_sun1()
		Talk(2,"func_sun2",10489,10490)
end;

function  func_sun2()
		-- npc_fix: event 4 consumed + class task 62->63 in one transaction
		if (QuestExchange(pt_fix_task(),62,63,{{4,4,0,0,0,0,1}},{})~=1) then
			Msg2Player("Chua the hoan thanh: can Than Du Kinh trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10491)
		Msg2Player("NhËn sù ñy th¸c cña Vâ V­¬ng, ®i t×m 3 bé s¸ch HuyÒn N÷ Binh Ph¸p, Huúnh §Õ Néi Kinh, LuyÖn Kim thuËt ")
		if (GetPlayerType()==1)then
				TaskNote(28,29)
		end;
		if(GetPlayerType()==0)then
				TaskNote(27,25)
		end;
		if(GetPlayerType()==2)then
				TaskNote(29,24)
		end;
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

function  no()
		CloseDialog()
end;

function  renwu()	
		if(GetTask(330)==2)then
			local i=random(1,6)
					if (i==1) then
						AddNormalItem(3,41,0,0,1,0)
						Msg2Player("B¹n nhËn ®­îc 1 viªn Lam B¶o Th¹ch")
						AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: 1 Lam B¶o Th¹ch.",20)
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng lµ  <color=red>1 Lam B¶o Th¹ch<color>")			
					elseif(i==2)then
						if(GetSeries()==0)then
							AddNormalItem2(0,10,0,7,1,0)
							Msg2Player("B¹n nhËn ®­îc U Hån Lang")
							AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, nhËn ®­îc U Hån Lang.",20)
						elseif(GetSeries()==1)then
							AddNormalItem2(0,10,1,7,1,0)
							Msg2Player("B¹n nhËn ®­îc Phiªu TuyÕt H¹c")
							AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: Phiªu TuyÕt H¹c",20)
						elseif(GetSeries()==2)then
							AddNormalItem2(0,10,2,7,1,0)
							Msg2Player("B¹n nhËn ®­îc TrÇm H­¬ng hå ®iÖp.")
							AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: TrÇm H­¬ng hå ®iÖp.",20)
						end;
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ ph¹t Trô Tiªn Phong T­íng Qu©n vµ phÇn th­ëng lµ mét <color=red>con ngùa quý<color>")			
					elseif(i==3)then
						if(GetSeries()==0)then
							local j=random(1,5)
								if (j==1) then
									AddNormalItem2(0,2,3,4,1,0)
									Msg2Player("B¹n nhËn ®­îc Vò Khóc Gi¸p")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: Vò Khóc Gi¸p",20)
								elseif (j==2) then
									AddNormalItem2(0,5,3,4,1,0)
									Msg2Player("B¹n nhËn ®­îc Vò Khóc chiÕn ngoa ")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng:  Vò Khóc chiÕn ngoa.",20)
								elseif (j==3) then
									AddNormalItem2(0,6,3,4,1,0)
									Msg2Player("B¹n nhËn ®­îc Vò Khóc Yªu §¸i ")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: Vò Khóc Yªu §¸i ",20)
								elseif (j==4) then
									AddNormalItem2(0,7,3,4,1,0)
									Msg2Player("B¹n nhËn ®­îc Vò Khóc Kh«i ")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: Vò Khóc Kh«i.",20)
								elseif (j==5) then
									AddNormalItem2(0,9,3,4,1,0)
									Msg2Player("B¹n nhËn ®­îc Vò Khóc Phi Phong")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: Vò Khóc Phi Phong.",20)
								end;
						elseif(GetSeries()==1)then
							local k=random(1,5)
								if (k==1) then
									AddNormalItem2(0,2,4,4,1,0)
									Msg2Player("B¹n nhËn ®­îc XÝch Tïng §¹o Bµo.")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: XÝch Tïng §¹o Bµo",20)
								elseif (k==2) then
									AddNormalItem2(0,5,4,4,1,0)
									Msg2Player("B¹n nhËn ®­îc XÝch Tïng Lý")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: XÝch Tïng Lý",20)
								elseif (k==3) then
									AddNormalItem2(0,6,4,4,1,0)
									Msg2Player("B¹n nhËn ®­îc XÝch Tïng C©n")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: XÝch Tïng C©n",20)
								elseif (k==4) then
									AddNormalItem2(0,7,4,4,1,0)
									Msg2Player("B¹n nhËn ®­îc XÝch Tïng Qu¸n")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: XÝch Tïng Qu¸n",20)
								elseif (k==5) then
									AddNormalItem2(0,9,4,4,1,0)
									Msg2Player("B¹n nhËn ®­îc XÝch Tïng LÖnh")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: XÝch Tïng LÖnh",20)
								end;					
						elseif(GetSeries()==2)then
							local l=random(1,5)
								if (l==1) then
									AddNormalItem2(0,2,5,4,1,0)
									Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Hé Gi¸p")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: B¸o ThÇn Hé Gi¸p",20)
								elseif (l==2) then
									AddNormalItem2(0,5,5,4,1,0)
									Msg2Player("B¹n nhËn ®­îc B¸o ThÇn ngoa")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: B¸o ThÇn ngoa.",20)
								elseif (l==3) then
									AddNormalItem2(0,6,5,4,1,0)
									Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Yªu §¸i")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: B¸o ThÇn Yªu §¸i",20)
								elseif (l==4) then
									AddNormalItem2(0,7,5,4,1,0)
									Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Trô")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: B¸o ThÇn Trô",20)
								elseif (l==5) then
									AddNormalItem2(0,9,5,4,1,0)
									Msg2Player("B¹n nhËn ®­îc B¸o ThÇn KÕt")
									AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: B¸o ThÇn KÕt",20)
								end;					
						end;
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ ph¹t Trô Tiªn Phong T­íng Qu©n vµ phÇn th­ëng lµ mét sè <color=red>trang bÞ quý hiÕm<color>")			
					elseif(i==4)then
						Earn(100000)
						Msg2Player("B¹n nhËn ®­îc 10w")
						AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: 10w",20)
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ ph¹t Trô Tiªn Phong T­íng Qu©n, ®ång thêi th­ëng cho ng­¬i <color=red>10w<color>")			
					elseif(i==5)then
						AddOwnExp(200000)
						Msg2Player("B¹n ®­îc th¨ng lªn mét cÊp.")
						AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: th¨ng lªn mét cÊp.",20)
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng <color=red> th¨ng lªn mét cÊp<color>")			
					elseif(i==6)then
						UseSilver(1,1,1)
						Msg2Player("B¹n nhËn ®­îc mét ngµy ch¬i miÔn phÝ")
						AddGlobalCountNews("Chóc mõng <color=green>"..GetName().."<color> ®­îc Vâ V­¬ng phong lµm Ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng: 1 ngµy ch¬i miÔn phÝ.",20)
						Talk(1,"no","Kh«ng hæ danh lµ dòng sÜ. LÇn nµy ta phong ng­¬i lµ ph¹t Trô Tiªn Phong T­íng Qu©n, phÇn th­ëng <color=red>1 ngµy ch¬i miÔn phÝ<color>")			
					end;
			SetTask(330,3)
		else
				Talk(1,"no","Ng­¬i ®· lµ Tiªn Phong T­íng Qu©n, hy väng sau nµy sÏ lËp nhiÒu chiÕn c«ng hiÓn h¸ch")
		end;
end;

function renwu2()
	if(1==GetTask(421))or(2==GetTask(421))then--421=1Ê±Íê³É?Îñ£¬=2Ê±Íê³É?ÎñÇÒ±¾³¡¾·Àû
		if (3==GetTask(420))or(9==GetTask(420))and(GetTask(373)==1)then
			reward_add()
		else
			Talk(1,"no","LÇn nµy ng­¬i lËp nhiÒu c«ng tr¹ng, h·y nhËn lÊy phÇn th­ëng.")
			reward_normal()
		end;
	else
		CloseDialog()
	end;
end;

function renwu3()
	local sz_level
	if (GetTask(420)>=20)then
		sz_level=GetTask(420)-20
	else
		sz_level=GetTask(420)
	end;
	Talk(1,"no","§¼ng cÊp chiÕn tr­êng hiÖn t¹i cña ng­¬i lµ <color=green>"..sz_level.."<color>.")
end;

function reward_normal()
	local sz_level=GetTask(420)
	if (10==sz_level)then
		AddOwnExp(GetLevel()*(1000+GetTask(421)*1000)*2);--½±Àø£¬°üÀ¨¾·Àû½±Àø
	else
		AddOwnExp(GetLevel()*(sz_level*100+GetTask(421)*1000)*2);--½±Àø£¬°üÀ¨¾·Àû½±Àø
		if (4==sz_level)and(60>GetLevel()) then
			Msg2Player("§¼ng cÊp cña b¹n ch­a ®Õn 60, kh«ng thÓ vµo chiÕn tr­êng Th­¬ng Chu.")
		else
			if (1==GetTask(373)) then--¾­ÑéÖµÒÑÂú£¬µÈ¼¶ÌáÉý
				SetTask(420,sz_level+1)
				SetTask(373,0)
				Msg2Player("§¼ng cÊp chiÕn tr­êng cña ng­¬i t¨ng "..GetTask(420))
			elseif (GetTask(373)<1)and(GetTask(373)>=0) then--¾­ÑéÖµÎ´Âú£¬¾­ÑéÖµ+1
				SetTask(373,GetTask(373)+1)
			else--¾­ÑéÖµÒç³ö»ò?µÃ´íÎóÖµ£¬Ö±½ÓÂ÷Îª1
				SetTask(373,1)
			end;
		end;
	end;
	SetTask(421,0)
end;

function reward_add()
	local sz_level=GetTask(420)
	local sel_idx=task_lvl_2_sel_idx[sz_level]
	if(sel_idx~=nil)then
		local sel_type=GetPlayerType()+1
		local item_list={}
               if(sz_level==9)and(1==GetTask(373))then
                   for i=2,4 do
                     item_list[i-1]=set_name[sel_type][sel_idx]..part_name[sel_type][i].."/item_"..i
		    end;
                   Say("Ng­¬i thËt vÊt v¶! Xin  nhËn phÇn th­ëng!",3,item_list)  
                elseif(1==GetTask(373))then
		   for i=1,5 do
			item_list[i]=set_name[sel_type][sel_idx]..part_name[sel_type][i].."/item_"..i
		   end;
                   Say("Ng­¬i thËt vÊt v¶! Xin  nhËn phÇn th­ëng!",5,item_list)
               end;
	end;
end;

function item_1()
	CloseDialog()
	local sz_level=GetTask(420)
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green>Vâ V­¬ng<color> tÆng b¹n 1 <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][1].."<color>.",20)
		AddNormalItem(0,2,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end;
end;

function item_2()
	CloseDialog()
	local sz_level=GetTask(420)
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green>Vâ V­¬ng<color> tÆng b¹n 1 <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][2].."<color>.",20)
		AddNormalItem(0,5,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end;

end;

function item_3()
	CloseDialog()
	local sz_level=GetTask(420)
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green>Vâ V­¬ng<color> tÆng b¹n 1 <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][3].."<color>.",20)
		AddNormalItem(0,6,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end;
end;
function item_4()
	CloseDialog()
	local sz_level=GetTask(420)
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green>Vâ V­¬ng<color> tÆng b¹n 1 <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][4].."<color>.",20)
		AddNormalItem(0,7,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end;
end;
function item_5()
	CloseDialog()
	local sz_level=GetTask(420)
	local sel_lvl=task_lvl_2_sel_lvl[sz_level]
	if(sel_lvl~=nil)then
		local player_type=GetPlayerType()+1
		local sel_idx=task_lvl_2_sel_idx[sz_level]
		sz_level=sz_level+1
		AddGlobalCountNews("<color=green>"..GetName().."<color> ®¼ng cÊp chiÕn tr­êng t¨ng "..sz_level..", <color=green>Vâ V­¬ng<color> tÆng b¹n 1 <color=green>"..set_name[player_type][sel_idx]..part_name[player_type][5].."<color>.",20)
		AddNormalItem(0,9,player_type+5,sel_lvl,0,0,0)
		reward_normal()
	end;
end;

function dongyi()
	if(HaveEventItem(110)>=1)then
		if(GetTask(593)==0)then
			Talk(1,"no","Thñ lÜnh §«ng Di träng t×nh träng nghÜa, ng­êi nh­ vËy thËt lµ hiÕm cã! Ta ph¶i cho ng­êi ®Õn hç trî «ng Êy.")
			SetTask(592,1)
			AddCredit(25)--ÉùÍû½±Àø
			AddOwnExp(4000) --¾­Ñé½±Àø
			Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
			TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>25 ®iÓm danh väng<color>")
		elseif(GetTask(593)==1)then
			-- npc_fix: event 110 consumed + task 597 25->26 in one transaction
			if (QuestExchange(597,25,26,{{4,110,0,0,0,0,1}},{})~=1) then
				CloseDialog()
				return
			end;
			SetTask(592,1)
			Talk(1,"no","Thñ lÜnh §«ng Di träng t×nh träng nghÜa, ng­êi nh­ vËy thËt lµ hiÕm cã! Ta ph¶i cho ng­êi ®Õn hç trî «ng Êy.")
			TaskNote(35,33)
			AddCredit(25)--ÉùÍû½±Àø
			AddOwnExp(4000) --¾­Ñé½±Àø
			Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
			TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>25 ®iÓm danh väng<color>")
			Msg2Player("Phôc mÖnh §Æng Cöu C«ng")
		end;
	end;
end;

function dongyi1()
	if (GetTask(597)~=27) then	-- npc_fix: phase guard
		CloseDialog()
		return
	end;
	Talk(1,"no","Cöu C«ng ®øc cao väng träng, qu¶ nh©n sÏ ph¸i ng­êi ®Õn ®ã ®Ó thiÕt lËp bang giao. Ng­¬i h·y mau ®Õn b¸i kiÕn <color=green>Kh­¬ng thõa t­íng<color>!")
	SetTask(597,28)
	TaskNote(35,35)
	AddCredit(30)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>30 ®iÓm danh väng!<color>")
	Msg2Player("§èi tho¹i víi Kh­¬ng Tö Nha")
end;






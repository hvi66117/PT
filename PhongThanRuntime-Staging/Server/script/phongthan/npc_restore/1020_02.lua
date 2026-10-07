-- Original VNG source payload; provenance in deployment report.
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
		{"§Æng Cöu C«ng hµng Chu","dongyi1";show=0}
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
		PTQ2_SayTask(10484,tasks)
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
								Talk(1,"no",10487)
								DelEventItem(6)
								DelEventItem(7)
								DelEventItem(8)
								local  i=random(14,17)
								AddNormalItem(0,4,i,1,0,0)
								Msg2Player(" NhËn ®­îc ph¸p b¶o cÊp 70.")
								if (GetPlayerType()==1)then
										SetTask(1,70)
										TaskNote(28,30)
								end;
								if(GetPlayerType()==0)then
										SetTask(3,70)
										TaskNote(27,26)
								end;
								if(GetPlayerType()==2)then
										SetTask(2,70)
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
		Talk(1,"no",10491)
		Msg2Player("NhËn sù ñy th¸c cña Vâ V­¬ng, ®i t×m 3 bé s¸ch HuyÒn N÷ Binh Ph¸p, Huúnh §Õ Néi Kinh, LuyÖn Kim thuËt ")
		if (GetPlayerType()==1)then
				SetTask(1,63)
				TaskNote(28,29)
		end;
		if(GetPlayerType()==0)then
				SetTask(3,63)
				TaskNote(27,25)
		end;
		if(GetPlayerType()==2)then
				SetTask(2,63)
				TaskNote(29,24)
		end;
		DelEventItem(4)
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
			DelEventItem(110)
			SetTask(592,1)
			Talk(1,"no","Thñ lÜnh §«ng Di träng t×nh träng nghÜa, ng­êi nh­ vËy thËt lµ hiÕm cã! Ta ph¶i cho ng­êi ®Õn hç trî «ng Êy.")
			SetTask(597,26)
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
	Talk(1,"no","Cöu C«ng ®øc cao väng träng, qu¶ nh©n sÏ ph¸i ng­êi ®Õn ®ã ®Ó thiÕt lËp bang giao. Ng­¬i h·y mau ®Õn b¸i kiÕn <color=green>Kh­¬ng thõa t­íng<color>!")
	SetTask(597,28)
	TaskNote(35,35)
	AddCredit(30)--ÉùÍû½±Àø
	AddOwnExp(4000) --¾­Ñé½±Àø
	Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
	TopMessage("PhÇn th­ëng: <color=green>4000 ®iÓm kinh nghiÖm<color> vµ <color=green>30 ®iÓm danh väng!<color>")
	Msg2Player("§èi tho¹i víi Kh­¬ng Tö Nha")
end;






pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Vo Vuong - Tay Ky (159/189)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Chu soai Tay Ky, nhan vat cua chinh tuyen. Ban nay la NPC doi thoai, khong phai Vo Vuong chien dau trong phu ban.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Khuong Tu Nha (158/189); Loi Chan Tu (163/187); Duong Tien (165/185); Nham Dai Ca (170/195); Nham Dai Tau (170/195)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Co nhanh Lua VNG goc trong PAK. Cac dieu kien va giao dich do nhanh goc kiem tra; chua nghiem thu toan bo nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
function pt_original()
    if pt_guard() == 0 then return end
    pt_original_main()
end

-- questfix2 2026-10-03: the VNG menus above only list quest rows (show=0 until a quest is due), so a
-- player with no quest got a dialog without any row. PTQ2_SayTask adds a "Ket thuc doi thoai" row;
-- with no visible row it shows PTQ2_FLAV (when set) or the VNG greeting with that row only.
-- Quest rows, conditions and callbacks are unchanged.
PTQ2_EXIT = "K\213t th\243c \174\232i tho\185i"
PTQ2_IDLE = "Hi\214n ta kh\171ng c\227 vi\214c g\215 c\199n nh\234 \174\213n ng\173\172i."
PTQ2_FLAV = nil
function PTQ2_Close()
	CloseDialog()
end
function PTQ2_SayTask(id, tasks)
	local n = getn(tasks)
	local vis = 0
	local ex = 0
	local c = {}
	local i = 1
	while i <= n do
		local t = tasks[i]
		c[i] = t
		if type(t) == "table" and (t.show == nil or t.show ~= 0) then
			vis = vis + 1
			local f = t[2]
			if type(f) ~= "string" then f = "" end
			f = strlower(f)
			if f == "no" or f == "cancel" or f == "oncancel" or f == "ptq2_close" or strsub(f, 1, 3) == "no_" or strsub(f, 1, 4) == "exit" or strsub(f, 1, 3) == "end" or strsub(f, 1, 5) == "close" then ex = 1 end
			if type(t[1]) == "string" and strfind(t[1], PTQ2_EXIT, 1, 1) then ex = 1 end
		end
		i = i + 1
	end
	if (vis == 0 and PTQ2_FLAV) or id == nil then
		local s = PTQ2_FLAV
		if s == nil then s = PTQ2_IDLE end
		Say(s, 1, PTQ2_EXIT .. "/PTQ2_Close")
		return
	end
	if ex == 0 then c[n + 1] = { PTQ2_EXIT, "PTQ2_Close"; show = 1 } end
	SayTask(id, c)
end

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

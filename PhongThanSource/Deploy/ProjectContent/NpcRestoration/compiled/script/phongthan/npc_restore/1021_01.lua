-- Original VNG source payload; provenance in deployment report.
--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/9

function  main()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);

	tasks = 
	{
	 {"B×nh An","renwu1";show=0},
	 {"Tam s¸ch","renwu2";show=0},
	 {"Nghe","listen";show=1},
	 {"§Õn Diªu Tr×","go";show=0}
	}

	if (UTask_Knight ==40)  or  (UTask_Druid ==40) or  (UTask_Wizard ==40) then
			 if(GetLevel()>=65)then
				tasks[1].show=1;
			 end;
	end;
	if (UTask_Knight >40)  or  (UTask_Druid >40) or  (UTask_Wizard >40) then
			 tasks[4].show=1;
	end;
	if(UTask_Knight ==60)or (UTask_Druid ==60) or  (UTask_Wizard ==60)then
			 if(GetLevel()>=75)then
					tasks[2].show=1;			
			 end;
	end;
	SayTask(10013,tasks)
end;

function  renwu1()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
				Talk(4,"func_leave1",10014,10015,10016,10017)
				if(UTask_Wizard ==40)then
					SetTask(1,41)
					TaskNote(28,20)
				end;
				if(UTask_Knight ==40)then
					SetTask(3,41)
					TaskNote(27,16)
				end;
				if(UTask_Druid ==40)then
					SetTask(2,41)
					TaskNote(29,15)
				end;
end;

function   renwu2()
	if(GetPlayerType()==0)and (UTask_Knight ==60) and (GetLevel()>=75)then
		if(HaveEventItem(13)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i t×m gióp ta t×m r©u cña ThÇn Long.")
		end;
	elseif(GetPlayerType()==1)and (UTask_Wizard ==60)and (GetLevel()>=75)then
		if(HaveEventItem(2)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i gióp ta t×m ThÇn Méc.")
		end;
	elseif(GetPlayerType()==2)and (UTask_Druid ==60)and (GetLevel()>=75)then
		if (HaveEventItem(19)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i t×m gióp ta Ma HuyÕt")
		end;
	end;
end;
		

function  listen()
		Talk(1,"func_leave3",10019)
end;

function  go()
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then          --Éæ¼°?Îñ£¬ÓÐµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿?Îñ½â³ý£¬¹ý³ÌÖÐ²»¿ÉÊ¹ÓÃ´«ËÍ
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
		else
				local i=random(1,3)
				if ( i==1)then
						NewWorld(52,1541,3190)
				end;
				if(i==2)then
						NewWorld(52,1556,3202)
				end;
				if(i==3)then
						NewWorld(52,1540,3205)
				end;
				SetFightState(0)
		end;
		CloseDialog()
end;

function  func_leave1()
		Talk(1,"main",10020)
end;

function  func_leave2()
		UTask_Wizard = GetTask(1);
		UTask_Knight = GetTask(3);
		UTask_Druid = GetTask(2);
		Talk(2,"no",10021,10022)	
		if(UTask_Wizard ==60)and(HaveEventItem(2)>=1)and(GetPlayerType()==1)and (GetLevel()>=75)then
			DelEventItem(2)
			AddEventItem(9)
			SetTask(1,61)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao ThÇn Méc cho §¾c Kû.")
			TaskNote(28,27)
		elseif(UTask_Knight ==60)and(HaveEventItem(13)>=1)and (GetPlayerType()==0) and (GetLevel()>=75)then
			SetTask(3,61)
			DelEventItem(13)
			AddEventItem(9)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao r©u ThÇn Long cho §¾c Kû.")
			TaskNote(27,23)
		elseif(UTask_Druid ==60)and(HaveEventItem(19)>=1)and(GetPlayerType()==2)and (GetLevel()>=75)then
			SetTask(2,61)
			DelEventItem(19)
			AddEventItem(9)
			TaskNote(29,22)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao Ma HuyÕt cho §¾c Kû.")
		end;			
end;

function  func_leave3()
		Talk(1,"func_leave4",10023)
end;

function  func_leave4()
		Talk(2,"func_leave5",10024,10025)
end;

function  func_leave5()
		Talk(1,"func_leave6",10026)
end;

function  func_leave6()
		Talk(1,"func_leave7",10027)
end;

function  func_leave7()
		Talk(1,"no",10028)

end;

function  no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_01; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Dac Ky - Trieu Ca (220/179)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong cac chuoi nhiem vu cua Phong Than. Doi thoai duoc phan biet theo map, khong gan lai nhiem vu Trieu Ca cho Bat Chu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Hoang Thien Hoa (214/184); Tho Hanh Ton (213/184); A Tai (217/188); Hoang Phi Ho (231/185); Phu An Su (225/191)", 2, "Quay lai/main", "Dong/pt_close")
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

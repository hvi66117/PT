-- Original VNG source payload; provenance in deployment report.
--description: ·ç²®Í¼ÌÚ-ò¿ÓÈÄ¹
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"Cøu TÕ","renwu2";show=0}
	}
		UTask_20 = GetTask(30);
		UTask_24 = GetTask(34);
		if (UTask_20==1)   or (UTask_20==5) or(UTask_20==9)or(UTask_20==13)then
					tasks[1].show=1;
		end;		
		if (UTask_24 == 6)  then
					tasks[2].show=1;
		end;				
		if (UTask_24 == 0) and (GetPlayerType()==2) and(GetLevel()>=12)then
					tasks[2].show=1;
		end;	
		if (UTask_24 == 7)and (GetCamp()==0)then
						SetCamp(7)
						Talk(1,"no","Ng­¬i ®· nhËn s¸ch kü n¨ng sèng, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
						Msg2Player("B¹n ®· nhËn s¸ch kü n¨ng, tõ giê ®· kh«ng cßn lµ T©n Thñ n÷a!")
		end;
		SayTask(10138,tasks)
end;

function  renwu1()
	UTask_20 = GetTask(30);
	if (UTask_20==1) then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,1)
			SetTask(30,UTask_20+2)
	end;
	if (UTask_20==5) then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,5)
			SetTask(30,UTask_20+2)
	end;
	if(UTask_20==9)then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,6)
			SetTask(30,UTask_20+2)
	end;
	if(UTask_20==13)then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,7)
			SetTask(30,UTask_20+2)
	end;
end;

function  renwu2()
	UTask_24 = GetTask(34);
	if (UTask_24 == 6)  then
			Talk(1,"no",10139)
			AddNormalItem(7,58,62,1,0,0) 
				Msg2Player("nhËn ®­îc s¸ch kü n¨ng khai kho¸ng Bµn Cæ Khai Thiªn, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
				SetCamp(7)
			TaskNote(16,6)
			SetTask(34,7)
	end;
	if (UTask_24 == 0) and (GetPlayerType()==2) and(GetLevel()>=12)then
			MsgBox(10140,"yes_1","no")

	end;
end;

function yes_1()
		Talk(1,"no",10141)
		SetTask(34,1)
		Msg2Player("Muèn häc b¶n lÜnh ®Æc biÖt nªn t×m H×nh Thiªn.")
		TaskNote(16,0)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Phong Ba - Xi Vuu Mo (195/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Totem cua Xi Vuu Mo, mot dau moi trong chuoi huong dan Di Nhan.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Ho Tro Tan Thu (194/205); Chuc Dung (193/204); Chuyen Sinh Lao Lao (196/202); Thieu Hao (198/204); Cong Cong (192/204)", 2, "Quay lai/main", "Dong/pt_close")
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

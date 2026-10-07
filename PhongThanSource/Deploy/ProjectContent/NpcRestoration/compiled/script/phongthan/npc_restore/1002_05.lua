-- Original VNG source payload; provenance in deployment report.
--description: ³çÓ¦ð½
--author: yichuan
--date: 2004/6/28

function main(sel)
	tasks = 
	{
		{"Hép gÊm","renwu1";show=0},
		{"Kiªm ¸i","renwu2";show=0}
	}
	UTask_10 = GetTask(20);
	UTask_14= GetTask(24);
	if (UTask_10 == 10) or(UTask_10==12)or(UTask_10==14)or(UTask_10==16)then				
			tasks[1].show=1;
	end;
	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
			tasks[2].show=1;
	end;	
	if(UTask_14 ==0)  and (GetPlayerType()==0)and(GetLevel()>=12) then	
			tasks[2].show=1;
	end;	
	if (UTask_14 == 4)and (GetCamp()==0)then
						SetCamp(7)
						Talk(1,"no",11167)
						Msg2Player("B¹n ®· nhËn s¸ch kü n¨ng, tõ giê ®· kh«ng cßn lµ T©n Thñ n÷a!")
		end;

	SayTask(10251,tasks)
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if (UTask_10 == 10)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,2)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==12)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,5)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==14)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,7)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==16)then				
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,8)
					SetTask(20,UTask_10+1)
	end;
end;

function    renwu2()
	UTask_14= GetTask(24);

	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
					Talk(1,"no",10253)
					DelEventItem(25)
					AddNormalItem(7,58,62,1,0,0)      --Éú»î¼¼ÄÜÊé
				Msg2Player("nhËn ®­îc s¸ch kü n¨ng khai kho¸ng Bµn Cæ Khai Thiªn, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
				SetCamp(7)
					TaskNote(10,3)
					SetTask(24,4)
	end;
	if(UTask_14 ==0)  and (GetPlayerType()==0)and(GetLevel()>=12) then		
					Talk(3,"no",10254,10255,10256)
					Msg2Player("§Õn gÆp ¢u Thiªn Hãa m­în cuèc chim häc kü n¨ng khai kho¸ng.")
					TaskNote(10,0)
					SetTask(24,1)		
	end;
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Sung Ung Loan - Sung Thanh doanh (212/198)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Dung Dao va Kiem Ai. Nhiem vu dan nguoi choi toi Yen Son va quay lai Trieu Dien.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Sung Ung Buu (211/198); Sung Hac Ho (213/200); Ho Tro Tan Thu (210/200); Pham Nghia (210/200); Trieu Loi (216/197)", 2, "Quay lai/main", "Dong/pt_close")
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

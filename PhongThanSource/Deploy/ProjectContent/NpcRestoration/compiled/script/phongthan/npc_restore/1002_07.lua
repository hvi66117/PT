-- Original VNG source payload; provenance in deployment report.
--description: ³ç¾ü¾üÒ½
--author:  yichuan
--date: 2004/6/27

function main(sel)
	tasks = 
	{
	 {"Hép gÊm","renwu1";show=0},
	 {"B¸o danh","renwu";show=0}
	}
 	UTask_10 = GetTask(20);
	if (UTask_10 == 10) or  (UTask_10==11)or(UTask_10==14) or(UTask_10==15)then	
		 tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then		
		 tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®ang chiªu mé anh tµi, chuÈn bÞ ph¹t Th­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10229,tasks)
	end;
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if(UTask_10 == 10)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,3)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==11)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,5)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==14)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,6)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==15)then				
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,8)
				SetTask(20,UTask_10+2)
	end;
end;

function no()
		CloseDialog()
end;

function  renwu()
		if(GetTask(330)==0)then
			for a=1,3 do
				AddNormalItem(1,0,0,0,1,0)
				AddNormalItem(1,3,0,0,1,0)
			end;
			SetTask(330,1)
				Talk(1,"no","Hy väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ. ")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")
		end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_07; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Trieu Loi - Sung Thanh doanh (216/197)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("NPC can thong bao trong chuoi Hop Gam cua To Ho va Thu Kho.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Diem (218/197); Trieu Dien (218/198); Sung Ung Loan (212/198); Sung Hac Ho (213/200); Sung Ung Buu (211/198)", 2, "Quay lai/main", "Dong/pt_close")
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

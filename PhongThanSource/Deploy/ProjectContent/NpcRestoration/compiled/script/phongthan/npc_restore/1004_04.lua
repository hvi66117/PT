-- Original VNG source payload; provenance in deployment report.
--description: ¹²¹¤Í¼ÌÚ-ÎäÆ÷ÏúÊÛÉÌ
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"ThÇn KhÝ","renwu1";show=0},
		{"B¸o danh","renwu";show=0}
	}
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (GetItemCount(28)>=3) then
				tasks[1].show=1;
	end;
	if (UTask_25==1) then
				tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then	
		 tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®ang chiªu mé anh tµi, chuÈn bÞ ph¹t Th­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10151,tasks)
	end;
end;

function   renwu1()
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (GetItemCount(28)>=3) then
		Talk(1,"no",10152)
		DelEventItem(28)
		DelEventItem(28)
		DelEventItem(28)
		AddEventItem(27)
		SetTask(35,7)
		Msg2Player("NhËn ®­îc ThÇn KhÝ, ®em ®Õn ®­a cho Chóc Dung.")
		TaskNote(17,6)
	end;
	if (UTask_25==1) then
		Talk(1,"no",10153)
		Msg2Player("T×m Cao Minh hái tin tøc m¶nh ThÇn KhÝ.")
		TaskNote(17,1)
		SetTask(35,2)
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
				Talk(1,"no","Hy väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh tßng qu©n råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")
		end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Cong Cong - Xi Vuu Mo (192/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Totem Cong Cong tai Xi Vuu Mo. Lua cua totem thuoc map nay, khong thay bang nhan vat Cong Cong o Bat Chu Son.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Chuc Dung (193/204); Ho Tro Tan Thu (194/205); Phong Ba (195/204); Tan Thu Thi Luyen (192/200); Hinh Thien (194/200)", 2, "Quay lai/main", "Dong/pt_close")
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

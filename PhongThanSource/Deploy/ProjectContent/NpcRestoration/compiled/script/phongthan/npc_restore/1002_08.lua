-- Original VNG source payload; provenance in deployment report.
--description:³çºî»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11

function main()
	tasks = 
	{
		{"Trung Thµnh","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"Phôc håi nhiÖm vô","taskid";show=0}
	}
	UTask_Knight = GetTask(3);
	UTask_11 = GetTask(21);

				if(UTask_Knight==2)  and  (HaveEventItem(11)==1)then
						tasks[1].show=1;
				end;
				if(GetPlayerType()==0)and(GetLevel() >= 25)  and  (UTask_Knight==0) then
						tasks[1].show=1;
				end;
				if(UTask_11==4) then
							tasks[2].show=1;
				end;
	SayTask(10242,tasks)
end;

function   taskid()
			Talk(1,"no",11175)
end;


function   renwu1()
	UTask_Knight = GetTask(3);
	if(UTask_Knight==2)  and  (HaveEventItem(11)==1)then
							Talk(3,"no",10243,10244,10245)
							DelEventItem(11)
							AddOwnExp(300)
							Earn(30000)
							Msg2Player("NhËn ®­îc 300 ®iÓm kinh nghiÖm vµ 3w l­îng.")
							SetTask(3,10)
							TaskNote(27,2)
	end;
	if(GetPlayerType()==0)and(GetLevel() >= 25)  and  (UTask_Knight==0) then
							MsgBox(10246,"yes","no")
	end;
end;

function   renwu2()
			Talk(1,"no",10247)
			Msg2Player("Sïng HÇu Hæ kh«ng chÞu ®æi nguyªn liÖu, ®i t×m Lç Hïng nghÜ c¸ch.")
			TaskNote(8,4)
			SetTask(21,5)
end;

function yes()
		Talk(1,"no",10248)
		Msg2Player("§i gÆp TrÞnh Lu©n dä xÐt.")
		SetTask(3,1)
		TaskNote(27,0)
end;

function no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_08; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Sung Hau Ho - Sung Thanh doanh (212/193)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tuong chi huy cua Sung Thanh Doanh, xuat hien trong chuoi Tan Thuc cua Giap Si.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Sung Ung Loan (212/198); Sung Ung Buu (211/198); Trieu Loi (216/197); Au Thien Hoa (206/196); Sung Hac Ho (213/200)", 2, "Quay lai/main", "Dong/pt_close")
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

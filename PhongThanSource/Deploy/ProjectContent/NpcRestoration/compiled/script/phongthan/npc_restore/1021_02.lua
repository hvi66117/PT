-- Original VNG source payload; provenance in deployment report.
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
					 {"Ma huyÕt","renwu4";show=0}
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
					Talk(3,"no",10042,10043,10167)
					SetTask(3,40)				
					AddNormalItem(3,46,0,0,0,0)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10. Cã thÓ tù do ra vµo Léc ®µi.")
					TaskNote(27,15)
		end 
end;

function  renwu2()
		UTask_Wizard = GetTask(1);
		if(GetLevel()>=55)  and(UTask_Wizard ==33)  and ( HaveEventItem(2)>=1)then
					Talk(1,"no",10044)
					AddNormalItem(3,46,0,0,0,0)
					SetTask(1,40)
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
					Talk(1,"no",10048)
					AddEventItem(15)
					SetTask(2,2)
					Msg2Player("NhËn ®­îc thiÕp mêi dù tiÖc.")	
					TaskNote(29,1)
end;


function  renwu4()
		if(GetLevel()>=55)  and  (UTask_Druid==34)and  (HaveEventItem(19)>=1)then
					Talk(1,"no",10049)				
					AddNormalItem(3,46,0,0,0,0)
					SetTask(2,40)
					TaskNote(29,14)
					Msg2Player("NhËn ®­îc B¸ L¹c nh·n cÊp 10, cã thÓ tù do ra vµo Léc ®µi.")
		end 
end;

function   no()
		CloseDialog()
end;



pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ho Hy Mi - Trieu Ca (205/184)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat lien quan thiep moi trong chuoi Mao Lu cua Di Nhan. Hoan tat doi thoai roi ve Hinh Thien.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tho Hanh Ton (213/184); Hoang Thien Hoa (214/184); Chuyen Sinh Lao Lao (212/190); Con Bac (204/196); A Tai (217/188)", 2, "Quay lai/main", "Dong/pt_close")
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

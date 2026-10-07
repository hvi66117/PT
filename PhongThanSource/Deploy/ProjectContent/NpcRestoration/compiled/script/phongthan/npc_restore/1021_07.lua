-- Original VNG source payload; provenance in deployment report.
--description: 酒店老晃-异?主线?务
--author: yichuan
--date:2004/5/13

function  main()
			tasks = 
			{
				 {"B蕋 T髖 ","renwu1";show=0}
			}
			UTask_Druid = GetTask(2);
			if(GetLevel()>=35)  and  (UTask_Druid==12)  and  (HaveEventItem(16)==0)then
				 tasks[1].show=1;
			end;
			SayTask(11123,tasks)
end;

function  renwu1()

				Talk(1,"no",11124)
				AddEventItem(16)
				SetTask(2,13)
				TaskNote(29,5)
				Msg2Player("Nh薾 頲 1 ch衝 canh t豱h ru.")
end;

function   no()
		CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1021_07; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chu Tuu Diem - Trieu Ca (227/195)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Chu tuu diem lien quan binh ruou cua Ngo Long trong Bat Tuy. Nhan va tra vat pham theo Lua nhiem vu goc.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Phu An Su (225/191); Thong That Tau (222/192); Hoang Phi Ho (231/185); A Tai (217/188); Thay Tuong So (214/195)", 2, "Quay lai/main", "Dong/pt_close")
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

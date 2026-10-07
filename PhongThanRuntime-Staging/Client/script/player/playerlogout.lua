--hoangnhk
Include("\\script\\global\\npcchucnang\\dichquan.lua")
Include("\\script\\lib\\worldlibrary.lua");
Include("\\script\\header\\taskid.lua");




function main()
  w,x,y = GetWorldPos()
	if (w == 396) then
	NewWorld(53,1608,3207)
	end
        end


function OnLogout()
huyhamthu();
SetTask(TASK_LVGAMESEC,GetCurServerSec());
StopTimer();
print("======= [ "..GetName().." ] =======>> THOAT")
end;
----------------------------------------------------------------------------------------------------------------------------------------------------








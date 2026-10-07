--description: 远古战场
--author: 黄亮
--date: 2005/3/31

function main()

	if (6 == GetWeekDay())or(7 == GetWeekDay()) then --判断星期
		local idx = SubWorldID2Idx(71); -- 确保地图在这台服务器
		if (idx == -1) then 
			do return end;
		end;
		SubWorld = idx; -- 任务开启必需的变量
		OpenMission(5); -- 开启5号任务
	end
end;

function no()
	CloseDialog()
end;
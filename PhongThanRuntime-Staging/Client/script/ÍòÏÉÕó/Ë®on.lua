--description: 水
--author: yichuan
--date: 2005/3/10

function main()
	idx = SubWorldID2Idx(68); -- 确保地图在这台服务器
	if (idx == -1) then 
			return
	end;

	SubWorld = idx; -- 任务开启必需的变量
	OpenMission(2); -- 开启2号任务
	SetGlobalValue(62,0)
	SetGlobalValue(66,0)
end;

function no()
		CloseDialog()
end;
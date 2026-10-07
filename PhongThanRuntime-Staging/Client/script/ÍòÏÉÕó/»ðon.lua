--description: 火
--author: yichuan
--date: 2005/2/28

function main()
	idx = SubWorldID2Idx(69); -- 确保地图在这台服务器
	if (idx == -1) then 
			return
	end;

	SubWorld = idx; -- 任务开启必需的变量
	OpenMission(3); -- 开启3号任务
	SetGlobalValue(63,0)
	SetGlobalValue(67,0)
end;

function no()
		CloseDialog()
end;
--description: 风
--author: yichuan
--date: 2005/3/10

function main()
	idx = SubWorldID2Idx(70); -- 确保地图在这台服务器
	if (idx == -1) then 
			return
	end;

	SubWorld = idx; -- 任务开启必需的变量
	OpenMission(4); -- 开启4号任务
	SetGlobalValue(64,0)
	SetGlobalValue(68,0)
end;

function no()
		CloseDialog()
end;
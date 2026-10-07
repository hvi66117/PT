--description: 土
--author: yichuan
--date: 2005/2/28

function main()
	idx = SubWorldID2Idx(67); -- 确保地图在这台服务器
	if (idx == -1) then 
			return
	end;

	SubWorld = idx; -- 任务开启必需的变量
	OpenMission(1); -- 开启1号任务
	SetGlobalValue(61,0)
	SetGlobalValue(65,0)
end;

function no()
		CloseDialog()
end;
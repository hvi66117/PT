Include("\\script\\header\\taskid.lua");
Include("\\script\\header\\vuotai.lua");
Include("\\script\\header\\liendau.lua");
Include("\\script\\header\\loidai.lua");
Include("\\script\\header\\tongkim.lua");
function InitMission(nIndex)
end

function RunMission(nIndex)
end

function EndMission(nIndex)
end
--loai bo player ra khoi mission thi se chay ham nay, thoat ra cung la loai bo
function OnLeave(nPlayerIndex)
	if(SubWorld == SubWorldID2Idx(380)) then
		tongkim_out(nPlayerIndex)
	elseif(SubWorld == SubWorldID2Idx(337)) then
		phonglang_out(nPlayerIndex)
	elseif(SubWorld == SubWorldID2Idx(209)) then
		loidai_out(nPlayerIndex)
	else
		for i=1,getn(MAP_VUOTAI) do
			if(SubWorld == SubWorldID2Idx(MAP_VUOTAI[i])) then
			vuotai_out(nPlayerIndex)
			return end
		end
		for i=1,getn(MAP_LIENDAU) do
			if(SubWorld == SubWorldID2Idx(MAP_LIENDAU[i])) then
			liendau_out(nPlayerIndex)
			return end
		end
		for i=1,getn(BW_COMPETEMAP) do
			if(SubWorld == SubWorldID2Idx(BW_COMPETEMAP[i])) then
			loidai_out(nPlayerIndex)
			return end
		end		
	end
end;

function tongkim_out(nPlayerIndex)
	PlayerIndex = nPlayerIndex;
		local szName = GetName();
		local szLeaveRank = GetRankEx();
		RestoreCamp()
		RestoreRankEx();
		SetPunish(0)
		SetFightState(0)
		SetPKMode(0,0)
		SetDeathScript("")
		ForbidEnmity(0)
		Msg2MSAll(1, format("%s <color=yellow>%s<color> rêi khái chiÕn tr­êng", szLeaveRank,szName)); --thong bao roi khoi~
		local nPlayerDataIdx = PIdx2MSDIdx(1,PlayerIndex);
		if(nPlayerDataIdx > 0) then
			SetPMParam(1,nPlayerDataIdx,0,0)--setoffline
			SetPMParam(1,nPlayerDataIdx,9,0);--lien tram hien tai
			--SetPMParam(1,nPlayerDataIdx,10,0);--tich luy LT hien tai
		end
end;


function vuotai_out(nPlayerIndex)
	PlayerIndex = nPlayerIndex;
	local szName = GetName();
	SetDeathScript("");
	SetPunish(0);
	RestoreCamp();
	SetCreateTeam(1)
	ForbidEnmity(0)
	Msg2MSAll(1, format("<color=yellow>%s<color> rêi khái khu vùc khiªu chiÕn.",szName)); --thong bao roi khoi~
	local nPlayerDataIdx = PIdx2MSDIdx(1,PlayerIndex); --- KICK PlAYER khoi mission
	SetPMParam(1,nPlayerDataIdx,0,0);--- KICK PlAYER khoi mission
end;

function liendau_out(nPlayerIndex)
	local nP1 = MSDIdx2PIdx(1, 1);
	local nP2 = MSDIdx2PIdx(1, 2);
	local nRest = floor(GetMSRestTime(1,2)/18);
	if(nPlayerIndex == nP1) then
		nP1 = nP2;
		nP2 = nPlayerIndex;
	end
	PlayerIndex = nP1;
	local nGroup = GetTask(TASK_LIENDAU) - 1;
	local n1,n2,n3,n4,n5,Name1,Name2 = GetDataGr(nGroup);
	n2 = SetNumber(3,n2,1,GetNumber(3,n2,1)+1);
	n3 = n3 + LIENDAU_THANG;
	if(nRest > 0) then
		n4 = n4 + 480 - nRest;
	end
	local winname = Name1
	SetDataGr(nGroup, n1,n2,n3,n4,n5,Name1,Name2);
	AddHonor(LIENDAU_THANG);
	RestoreCamp()
	SetPunish(0)
	SetFightState(0)
	SetPKMode(0,0)
	LockMoveItem(0)
	SetReviveNow(0);
	ForbidEnmity(0);
	ForbidTrade(0);
	SetCreateTeam(1);
	NewWorld(396,1540,3050);
	Msg2Player(LIENDAU_MSGBOCUOC)
	----------------player thu 2-------------
	PlayerIndex = nP2;
	local DesID = GetUUID();
	DesID = FindDataId(DesID);
	if(DesID >= 0) then
		n1,n2,n3,n4,n5,Name1,Name2 = GetDataGr(DesID);
		n2 = SetNumber(3,n2,3,GetNumber(3,n2,3)+1);
		if(nRest > 0) then
		n4 = n4 + 480 - nRest;
		end
		local losename = Name1
		SetDataGr(DesID, n1,n2,n3,n4,n5,Name1,Name2);
	end
	Msg2MSAll(1,format("<color=cyan>Liªn ®Êu : [%s] chiÕn th¾ng [%s] trong trËn nµy !",winname, losename));
	SaveDataFile()
	CloseMission(1)
end;

function phonglang_out(nPlayerIndex)
	PlayerIndex = nPlayerIndex;
	local szName = GetName();
	Msg2MSAll(1, format("<color=yellow> %s<color> kh«ng may tö vong.",szName)); --thong bao roi khoi~
	SetPunish(0)
	SetPKMode(0,0)
	SetLogoutRV(0);
	SetDeathScript("")
	local nPlayerDataIdx = PIdx2MSDIdx(1,PlayerIndex); --- KICK PlAYER khoi mission
	SetPMParam(1,nPlayerDataIdx,0,0);--- KICK PlAYER khoi mission
end;

function loidai_out(nPlayerIndex)
  w,x,y = GetWorldPos()
	if (w == 209) then
	PlayerIndex = nPlayerIndex;
	local szName = GetName();
	Msg2MSAll(1, format("<color=yellow>%s<color> rêi khái l«i ®µi",szName)); --thong bao roi khoi~
	LeaveGame();
	NewWorld(GetTask(BW_SIGNPOSWORLD), GetTask(BW_SIGNPOSX), GetTask(BW_SIGNPOSY));
	end
end;














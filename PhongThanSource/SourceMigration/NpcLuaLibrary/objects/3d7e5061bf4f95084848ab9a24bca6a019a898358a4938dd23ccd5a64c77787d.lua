--图腾死亡.lua
--Rocker 2008.6.20

function OnDeath(npcidx)
    --	local CityID = GetNpcMapCityID(npcidx)
    --	if (CityID ~= 0) then
    --		local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemp, TongName = GetCityInfoByID(CityID)
    --		--> 即时国战 modified by yaoxin for 2009-10
    --		local sTong,sCity,nTime,nState = GetShortBattleByInfo(TongName)
    --		local today = floor(LocalSystemTime()/86400)
    --		if (today == floor(nTime/86400)) then
    --			Msg2TongMemberByTongName(TongName, "尽管众将士竭力抵抗，终究寡不敌众，被<bc=b>"..sTong.."</bc><bc=r>攻破，不过明天有此反击的机会！")
    --		else
    --			Msg2TongMemberByTongName(TongName, "尽管众将士竭力抵抗，终究寡不敌众，被怪物掠走了部分资源！")
    --		end
    --		ShortBattleState(TongName,1)
    --
    --		--< 即时国战 modified by yaoxin for 2009-10
    --	end
    --	
    DelNpc(npcidx)
end
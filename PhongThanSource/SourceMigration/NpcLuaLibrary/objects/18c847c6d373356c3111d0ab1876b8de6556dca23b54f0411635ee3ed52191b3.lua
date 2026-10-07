require("king/lib.luax")
require("king/events/event.luax")

--- Ksg Lib
Ksg = Ksg or {}
Ksg.nVersion = 1 -- Do not change this value
Ksg.nTaskId_Version = KsgTask.tbIds.Version

function Ksg:OnPlayerLogin()
  --KsgDebug:Print("Event: OnPlayerLogin")
  if KsgTask:Get(self.nTaskId_Version) ~= self.nVersion then
    -- Reset old task or do migration
    KsgTask:Set(self.nTaskId_Version, self.nVersion)
  end

  if KsgPlayer:IsGM() and KsgItem:Count(6, 1, 5901, 0) < 1 then
    local tbItems = {
      { tbProp = { 6, 1, 5901, 0 }, szName = "ThÎ GM" },
    }
    KsgAward:Give(tbItems, "[OnLogin] NhËn thÎ GM")
  end

  Event:OnPlayerLogin()
  KsgServer:OnPlayerLogin()
end

function Ksg:OnServerStartUp()
  Event:OnServerStartUp()
end

function Ksg:OnNpcPreDeath(nNpcId)
  Event:OnNpcPreDeath(nNpcId)
end

function Ksg:OnTaskFinish(nTaskId)
  Event:OnTaskFinish(nTaskId)
end

return Ksg

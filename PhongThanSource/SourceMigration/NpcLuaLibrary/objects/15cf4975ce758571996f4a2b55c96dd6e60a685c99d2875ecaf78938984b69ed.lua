require("king/events/midautumn/event_midautumn.luax")

Event = Event or {}

function Event:OnPlayerLogin()
  EventMidAutumn:OnPlayerLogin()
end

function Event:OnServerStartUp()
  EventMidAutumn:OnServerStartUp()
end

function Event:OnNpcPreDeath(nNpcIdx)
  EventMidAutumn:OnNpcPreDeath(nNpcIdx)
end

function Event:OnTaskFinish(nTaskId)
  EventMidAutumn:OnTaskFinish(nTaskId)
end

return Event

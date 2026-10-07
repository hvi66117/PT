Include("\\script\\gvn\\award_types\\award_base.lua")

AwardRepute = AwardBase:new("nRepute")

AwardRepute.pFunc = function(nPoint)
  KsgPlayer:AddRepute(nPoint)
end

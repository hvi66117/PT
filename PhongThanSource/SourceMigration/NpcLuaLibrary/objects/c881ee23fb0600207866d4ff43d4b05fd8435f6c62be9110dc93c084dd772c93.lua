Include("\\script\\gvn\\award_types\\award_base.lua")

AwardReputeTienMa = AwardBase:new("nReputeTienMa")

AwardReputeTienMa.pFunc = function(nPoint)
  KsgPlayer:AddReputeTienMa(nPoint)
end

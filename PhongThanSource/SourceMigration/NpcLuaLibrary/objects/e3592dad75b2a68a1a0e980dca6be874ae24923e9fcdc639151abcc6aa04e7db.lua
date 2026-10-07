Include("\\script\\gvn\\award_types\\award_base.lua")

AwardCopperCash = AwardBase:new("nCopperCash")

AwardCopperCash.pFunc = function(nAmount)
  KsgPlayer:AddCopperCash(nAmount)
end

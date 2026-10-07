Include("\\script\\gvn\\award_types\\award_base.lua")

AwardExp = AwardBase:new("nExp")

AwardExp.pFunc = function(nAmount)
  KsgPlayer:BigAddExp(nAmount)
end

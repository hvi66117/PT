Include("\\script\\gvn\\award_types\\award_base.lua")

AwardMoney = AwardBase:new("nMoney")

AwardMoney.pFunc = function(nAmount)
  KsgPlayer:EarnMoney(nAmount)
end

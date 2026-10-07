Include("\\script\\gvn\\award_types\\award_base.lua")

AwardExpTienMa =  AwardBase:new("nExpTienMa")

AwardExpTienMa.pFunc = AddOwnExtendExp

AwardExpTienMa.isValid = function(nAmount)
  return nAmount > 0 and GetPlayerExtLevel() > 0 and GetJusticEvilCredit() ~= 0
end

AwardExpTienMa.onInvalid = function(nAmount)
  return KsgPlayer:Msg(format("Ch­a ®ñ ®iÒu kiÖn, kh«ng thÓ nhËn %d ®iÓm tu luyÖn Tiªn Ma", nAmount))
end

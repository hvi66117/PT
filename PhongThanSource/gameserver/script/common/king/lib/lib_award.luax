require("king/award_types/award_copper_cash.luax")
require("king/award_types/award_exp.luax")
require("king/award_types/award_exp_tienma.luax")
require("king/award_types/award_money.luax")
require("king/award_types/award_bindcoin.luax")
require("king/award_types/award_bindmoney.luax")
require("king/award_types/award_repute.luax")
require("king/award_types/award_repute_tienma.luax")
require("king/award_types/award_item.luax")
require("king/award_types/award_green_item.luax")
require("king/award_types/award_orange_item.luax")
require("king/award_types/award_max_weight.luax")
require("king/award_types/award_func.luax")
require("king/award_types/award_dopho.luax")

KsgAward = KsgAward or {}

KsgAward.TYPES = {}

function KsgAward:RegType(szKey, pClass)
  if not self.TYPES[szKey] then
    self.TYPES[szKey] = pClass
  end
end

-- Register
KsgAward:RegType(AwardExp.szKey, AwardExp)
KsgAward:RegType(AwardExpTienMa.szKey, AwardExpTienMa)
KsgAward:RegType(AwardCopperCash.szKey, AwardCopperCash)
KsgAward:RegType(AwardRepute.szKey, AwardRepute)
KsgAward:RegType(AwardReputeTienMa.szKey, AwardReputeTienMa)
KsgAward:RegType(AwardBindCoin.szKey, AwardBindCoin)
KsgAward:RegType(AwardBindMoney.szKey, AwardBindMoney)
KsgAward:RegType(AwardMoney.szKey, AwardMoney)
KsgAward:RegType(AwardMaxWeight.szKey, AwardMaxWeight)
KsgAward:RegType(AwardItem.szKey, AwardItem)
KsgAward:RegType(AwardGreenItem.szKey, AwardGreenItem)
KsgAward:RegType(AwardOrangeItem.szKey, AwardOrangeItem)
KsgAward:RegType(AwardFunc.szKey, AwardFunc)
KsgAward:RegType(AwardDoPho.szKey, AwardDoPho)

function KsgAward:GiveByRandom(tbAward, szLogTitle, nAwardCount)
  if not tbAward then
    return
  end
  local nRateTotal = 10000000
  local nRandom = math.random(1, nRateTotal)
  local nStep = 0
  for i = 1, #tbAward do
    nStep = nStep + math.floor(tbAward[i].nRate * nRateTotal / 100);
    if nRandom <= nStep then
      return self:Give(tbAward[i], szLogTitle, nAwardCount)
    end
  end
end

--- Give awards to players
--- @param tbAward table: Award list settings
--- @param szLogTitle string: Log title
--- @param nAwardCount? number: Number of awards
--- Example of usage:
--- local tbAward = {
---   { nExp = 10000 },
---   { nCopperCash = 200 },
---   { nRepute = 1000 },
---   { nReputeTienMa = 10 },
---   { nMaxWeight = 2000 },
---   { nOrangeItem = KsgItem.NON, nLevel = 10, nFactionId = KsgPlayer.GIAP_SI },
---   { nGreenItem = KsgItem.NON, nFactionId = KsgPlayer.DAO_SI, nBind = 1, nLevel = 2, nTienMa = 1, nQuest = 1 },
---   { tbProp = {8, 159, 3, 0}, nBind = 1, nAmount = 2 } -- Di Ngo¹i phï siªu cÊp
--- }
--- KsgAward:Give(tbItem)
---
function KsgAward:Give(tbAward, szLogTitle, nAwardCount)
  if not tbAward then
    return
  end
  nAwardCount = nAwardCount or 1
  if type(tbAward[1]) == "table" then
    if tbAward[1].nRate then
      for _ = 1, nAwardCount do
        self:GiveByRandom(tbAward, szLogTitle, 1)
      end
      return 1
    end
    for i = 1, #tbAward do
      self:Give(tbAward[i], szLogTitle, nAwardCount)
    end
    return 1
  else
    for k, v in pairs(self.TYPES) do
      if tbAward[k] then
        return v:Give(tbAward, szLogTitle, nAwardCount)
      end
    end
  end
end

---Give golden weapon
---@param nLevel number
function KsgAward:GiveGoldenWeapon(nLevel)
  nLevel = nLevel or 10
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = math.random(4, 5),
    [KsgPlayer.DAO_SI] = 6,
    [KsgPlayer.DI_NHAN] = 7,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], nLevel, 0, 0)
  end
end

---Give golden horse
---@param nLevel number
function KsgAward:GiveGoldenHorse(nLevel)
  nLevel = nLevel or 10
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 24,
    [KsgPlayer.DAO_SI] = 25,
    [KsgPlayer.DI_NHAN] = 26,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 10, tbAwards[nFactionId], nLevel, 0, 0)
  end
end

function KsgAward:GivePlatinumHorse()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 27,
    [KsgPlayer.DAO_SI] = 28,
    [KsgPlayer.DI_NHAN] = 29,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 10, tbAwards[nFactionId], 10, 0, 0)
  end
end

function KsgAward:GiveVIPHorse()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 69,
    [KsgPlayer.DAO_SI] = 70,
    [KsgPlayer.DI_NHAN] = 71,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 10, tbAwards[nFactionId], 10, 0, 0)
  end
end

function KsgAward:GiveSkillBook90()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = { 7, 39, 42, 1 }, -- Khuynh Thµnh NhÊt KÝch
    [KsgPlayer.DAO_SI] = { 7, 23, 26, 1 }, -- Tam Muéi Ch©n Háa
    [KsgPlayer.DI_NHAN] = { 7, 48, 51, 1 }, -- V¹n Cèt Toµn Kh«
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    local tbProp = tbAwards[nFactionId]
    AddNormalItem(tbProp[1], tbProp[2], tbProp[3], tbProp[4], 0, 0)
  end
end

function KsgAward:GiveSignet()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = { 0, 13, 6, 10 },
    [KsgPlayer.DAO_SI] = { 0, 13, 7, 10 },
    [KsgPlayer.DI_NHAN] = { 0, 13, 8, 10 },
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    local tbProp = tbAwards[nFactionId]
    AddNormalItem(tbProp[1], tbProp[2], tbProp[3], tbProp[4], 0, 0)
  end
end

return KsgAward

Include("\\script\\gvn\\award_types\\award_copper_cash.lua")
Include("\\script\\gvn\\award_types\\award_exp.lua")
Include("\\script\\gvn\\award_types\\award_exp_tienma.lua")
Include("\\script\\gvn\\award_types\\award_money.lua")
Include("\\script\\gvn\\award_types\\award_repute.lua")
Include("\\script\\gvn\\award_types\\award_repute_tienma.lua")
Include("\\script\\gvn\\award_types\\award_item.lua")
Include("\\script\\gvn\\award_types\\award_green_item.lua")
Include("\\script\\gvn\\award_types\\award_orange_item.lua")
Include("\\script\\gvn\\award_types\\award_max_weight.lua")
Include("\\script\\gvn\\award_types\\award_func.lua")
Include("\\script\\gvn\\award_types\\award_dopho.lua")

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
  local nRandom = random(1, nRateTotal)
  local nStep = 0
  for i = 1, getn(tbAward) do
    nStep = nStep + floor(tbAward[i].nRate * nRateTotal / 100);
    if nRandom <= nStep then
      return self:Give(tbAward[i], szLogTitle, nAwardCount)
    end
  end
end

--- Give awards to players
--- @param tbAward table: Award list settings
--- @param szLogTitle string: Log title
--- @param nAwardCount number: Number of awards
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
    for i = 1, getn(tbAward) do
      self:Give(tbAward[i], szLogTitle, nAwardCount)
    end
    return 1
  else
    for k, v in self.TYPES do
      if tbAward[k] then
        return v:Give(tbAward, szLogTitle, nAwardCount)
      end
    end
  end
end

function KsgAward:GivePhapBaoThatTranTrai(nLevel)
  nLevel = nLevel or 10
  if (GetPlayerType() == 1) then
    AddNormalItem(0, 4, 67, nLevel, 0, 0)
  else
    AddNormalItem(0, 4, 66, nLevel, 0, 0)
  end
end

function KsgAward:GiveAwardTitleVIPTop1()
  if (GetTitleFunc() == 0) then
    ActiveTitleFunc(1)
  end
  ActiveTitleQualify(73) 
  SetCurTitle(73)
  Msg2Player("Chóc mõng b¹n ®· ®¹t ®­îc danh hiÖu Top 1 C«ng Lùc!")
end

function KsgAward:GiveAwardTitleVIPTop2()
  if (GetTitleFunc() == 0) then
    ActiveTitleFunc(1)
  end
  ActiveTitleQualify(74)
  SetCurTitle(74)
  Msg2Player("Chóc mõng b¹n ®· ®¹t ®­îc danh hiÖu Top 2 C«ng Lùc!")
end

function KsgAward:GiveAwardTitleVIPTopFaction()
  if (GetTitleFunc() == 0) then
    ActiveTitleFunc(1)
  end
  ActiveTitleQualify(75)
  SetCurTitle(75)
  Msg2Player("Chóc mõng b¹n ®· ®¹t ®­îc danh hiÖu Top 1 HÖ ph¸i 'Cöu Ngò ChÝ T«n'!")
end

function KsgAward:GiveAwardTitleVIPTopConsume()
  if (GetTitleFunc() == 0) then
    ActiveTitleFunc(1)
  end
  ActiveTitleQualify(85)
  SetCurTitle(85)
  Msg2Player("Chóc mõng b¹n ®· ®¹t ®­îc danh hiÖu Top 1 Tiªu PhÝ 'Hïng B¸ Mét Ph­¬ng'!")
end

function KsgAward:GetRandomGSVK120()
  local nRet = 0
  local nProb = random(1,100)
  if nProb <= 50 then
    nRet = 97
  else
    nRet = 98
  end
  return nRet
end

function KsgAward:Give120Weapon(nLevel)
  nLevel = nLevel or 10
  local nGSWP = KsgAward:GetRandomGSVK120()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = nGSWP,
    [KsgPlayer.DAO_SI] = 99,
    [KsgPlayer.DI_NHAN] = 100,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], nLevel, 0, 0)
  end
end

function KsgAward:Give120Horse()
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

function KsgAward:GiveGoldenWeapon(nLevel)
  nLevel = nLevel or 10
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = random(4, 5),
    [KsgPlayer.DAO_SI] = 6,
    [KsgPlayer.DI_NHAN] = 7,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], nLevel, 0, 0)
  end
end

function KsgAward:GetRandomGiapSiItemVK9x()
  local nRet = 0
  local nProb = random(1,100)
  if nProb <= 50 then
    nRet = 4
  else
    nRet = 5
  end
  return nRet
end

function KsgAward:GiveGoldenWeaponBind(nLevel)
  nLevel = nLevel or 10
  local nGSWP = KsgAward:GetRandomGiapSiItemVK9x()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = nGSWP,
    [KsgPlayer.DAO_SI] = 6,
    [KsgPlayer.DI_NHAN] = 7,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    local nItemID = AddNormalItem(0, 0, tbAwards[nFactionId], nLevel, 0, 0)
    if nItemID > 0 then
      SetItemBind(nItemID, 1)
    end
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

function KsgAward:GivePlatinumHorseBind()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 27,
    [KsgPlayer.DAO_SI] = 28,
    [KsgPlayer.DI_NHAN] = 29,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    local nItemID = AddNormalItem(0, 10, tbAwards[nFactionId], 10, 0, 0)
    if nItemID > 0 then
      SetItemBind(nItemID, 1)
    end
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

function KsgAward:GiveHorse6X()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 24,
    [KsgPlayer.DAO_SI] = 25,
    [KsgPlayer.DI_NHAN] = 26,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 10, tbAwards[nFactionId], 7, 0, 0)
  end
end

function KsgAward:GiveDoPhoTBKL()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = 890,
    [KsgPlayer.DAO_SI] = 891,
    [KsgPlayer.DI_NHAN] = 892,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(6, 1, tbAwards[nFactionId], 1, 0, 0)
  end
end

function KsgAward:RandomNgocTam(nNum)
  local tbAwards = {
    [1] = 258, 
    [2] = 265,
    [3] = 272,
  }
  local name_list = { "XÝch Viªm Danh Ngäc (Ch­a mµi)", "Thanh Minh Danh Ngäc (Ch­a mµi)", "Tö Hµ Danh Ngäc (Ch­a mµi)" }
  for i=1,nNum do
    local nIdx = random(1, getn(tbAwards))
    AddNormalItem(3, tbAwards[nIdx], 0, 0, 0, 0)
    Msg2Player(format("Chóc mõng b¹n ®· nhËn ®­îc %s tõ sù kiÖn tiªu phÝ",name_list[nIdx]))
  end
end

function KsgAward:RandomNgocHon(nNum)
  local tbAwards = {
    [1] = 259,
    [2] = 266,
    [3] = 273,
  }
  local name_list = { "XÝch Viªm Ngäc H«n (Ch­a mµi)", "Thanh Minh Ngäc H«n (Ch­a mµi)", "Tö Hµ Ngäc H«n (Ch­a mµi)" }
  for i=1,nNum do
    local nIdx = random(1, getn(tbAwards))
    AddNormalItem(3, tbAwards[nIdx], 0, 0, 0, 0)
    Msg2Player(format("Chóc mõng b¹n ®· nhËn ®­îc %s tõ sù kiÖn tiªu phÝ",name_list[nIdx]))
  end
end

function KsgAward:GetRandomGiapSiItem9x()
  local nRet = 0
  local nProb = random(1,100)
  if nProb <= 50 then
    nRet = 15
  else
    nRet = 18
  end
  return nRet
end

function KsgAward:GetRandomGiapSiItem8x()
  local nRet = 0
  local nProb = random(1,100)
  if nProb <= 50 then
    nRet = 14
  else
    nRet = 17
  end
  return nRet
end

function KsgAward:VuKhiTruyenThuyet9x()
  --local nLevel = nLevel or 10
  local nGiapSiItem = KsgAward:GetRandomGiapSiItem9x()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = nGiapSiItem,
    [KsgPlayer.DAO_SI] = 21,
    [KsgPlayer.DI_NHAN] = 24,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], 9, 0, 0)
  end
end

function KsgAward:VuKhiTruyenThuyet8x()
  --local nLevel = nLevel or 10
  local nGiapSiItem = KsgAward:GetRandomGiapSiItem8x()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = nGiapSiItem,
    [KsgPlayer.DAO_SI] = 20,
    [KsgPlayer.DI_NHAN] = 23,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], 8, 0, 0)
  end
end

function KsgAward:AddSucManh(nCount)
  AddStrg(nCount)
  Msg2Player("B¹n nhËn ®­îc "..nCount.." ®iÓm Søc M¹nh")
end

function KsgAward:AddThanPhap(nCount)
  AddDex(nCount)
  Msg2Player("B¹n nhËn ®­îc "..nCount.." ®iÓm Th©n Ph¸p")
end

function KsgAward:AddTheChat(nCount)
  AddCon(nCount)
  Msg2Player("B¹n nhËn ®­îc "..nCount.." ®iÓm ThÓ ChÊt")
end

function KsgAward:AddNgoTinh(nCount)
  AddInt(nCount)
  Msg2Player("B¹n nhËn ®­îc "..nCount.." ®iÓm Ngé TÝnh")
end

function KsgAward:PetChange(nType)
  local tbPet = {
    [1] = {9, "B¹ch S¾c Tr­"},
    [2] = {10, "PhÊn S¾c Tr­"},
    [3] = {11, "Kim S¾c Tr­"},
  }
  if (PetIsAdd() == 1) then
    if (PetGetType() == tbPet[nType][1]) then
      Msg2Player(format("Linh Thó cña b¹n ®· mang h×nh d¹ng <c=g>%s<c>, kh«ng cÇn ph¶i biÕn th©n", tbPet[nType][2]))
    elseif (PetIsSleep() == 1) then
      Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
    elseif (PetGetTime() < (24 * 60 * 60)) then
      Msg2Player("Linh Thó cña ng­¬i cßn trong thêi gian Êp, ch­a thÓ biÕn th©n.")
    else
      PetSetType(tbPet[nType][1])
      Msg2Player(format("Linh thó ®· biÕn thµnh %s", tbPet[nType][2]))
    end
  else
    Msg2Player("B¹n ch­a nu«i Thó c­ng")
  end
end

function KsgAward:AddBindMoney(nAmount)
  EarnBind(nAmount * 10000)
  Msg2Player(format("Chóc mõng b¹n ®· nhËn ®­îc %d v¹n b¹c khãa", nAmount))
end

function KsgAward:GiveRandomGreenEquip(nLevel)
  local tbAward = {
      { nGreenItem = KsgItem.NON, nLevel = nLevel, nRate = 20 }, -- Trang bÞ lôc 8x
      { nGreenItem = KsgItem.GIAY, nLevel = nLevel, nRate = 20 }, -- Trang bÞ lôc 8x
      { nGreenItem = KsgItem.DAILUNG, nLevel = nLevel, nRate = 20 }, -- Trang bÞ lôc 8x
      { nGreenItem = KsgItem.PHIPHONG, nLevel = nLevel, nRate = 20 }, -- Trang bÞ lôc 8x
      { nGreenItem = KsgItem.AO, nLevel = nLevel, nRate = 20 }, -- Trang bÞ lôc 8x
  }
  KsgAward:Give(tbAward, "[EventMonthly] Më Event 1", 1)
end

function KsgAward:AddReputeTienMa(nPoint)
  if nPoint <= 0 then
    return
  end
  local nCurRepute = GetJusticEvilCredit()
  if nCurRepute < 0 then
    ChangeJusticEvilCredit(-nPoint)
  else
    ChangeJusticEvilCredit(nPoint)
  end

  local szMsg = format("NhËn ®­îc %d ®iÓm danh väng Tiªn Ma", nPoint)
  self:Msg(szMsg)
  ScrollMessage(szMsg)  
end

function KsgAward:GetRandomGiapSiTienMa6x()
  local nRet = 0
  local nProb = random(1,100)
  if nProb <= 50 then
    nRet = 68
  else
    nRet = 67
  end
  return nRet
end

function KsgAward:GiveTienMaWeapon6X(nLevel)
  nLevel = nLevel or 10
  local nGSWP = KsgAward:GetRandomGiapSiTienMa6x()
  local tbAwards = {
    [KsgPlayer.GIAP_SI] = nGSWP,
    [KsgPlayer.DAO_SI] = 69,
    [KsgPlayer.DI_NHAN] = 70,
  }
  local nFactionId = KsgPlayer:GetFactionId()
  if tbAwards[nFactionId] then
    AddNormalItem(0, 0, tbAwards[nFactionId], nLevel, 0, 0)
  end
end

function KsgAward:NoThing(nAmount)
  
end 

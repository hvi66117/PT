require("king/events/midautumn/event_midautumn_def.luax")
require("king/events/midautumn/lantern/event_midautumn_lantern.luax")
require("king/events/midautumn/rabbit/event_midautumn_rabbit.luax")

function EventMidAutumn:MoonCakeMain()
  if not self:CanJoin() then
    return
  end

  local tbSay = {}
  for nIdx, tbExchange in ipairs(self.tbMoonCakes) do
    tbSay[nIdx] = { string.format("Lµm <c=y>%s<c>", tbExchange.szName), self.MoonCake, self, nIdx }
  end

  -- Event shop
  for nIdx, tbShop in ipairs(self.tbShops) do
    tbSay[#tbSay + 1] = { string.format("Ta ®Õn mua %s", tbShop.szName), self.MoonCake_Shop, self, nIdx }
  end

  if IsNewBirthComplete() > 0 and KsgPlayer:GetLevel() >= 120 then
    tbSay[#tbSay + 1] = { "Chän lo¹i kinh nghiÖm th­ëng", self.ChooseExpType, self }
  end

  tbSay[#tbSay + 1] = { "NhËn th­ëng mèc dïng b¸nh Trung Thu", self.MoonCake_GetAccumulateAward, self }

  if self.bTest and KsgPlayer:IsGM() then
    tbSay[#tbSay + 1] = { "[Test] NhËn hép nguyªn liÖu", self.DropEventBox, self, 1000 }
    tbSay[#tbSay + 1] = { "[Test] Xãa tÊt c¶ vËt phÈm sù kiÖn", self.Clean, self }
  end
  KsgNpc:Say("Anh hïng muèn ta gióp g×?", tbSay)
end

function EventMidAutumn:IsActive()
  local nNow = today()

  return nNow >= self.nStartDate and nNow <= self.nEndDate
end

function EventMidAutumn:CanJoin()
  if not self.bOpen then
    KsgNpc:Talk("H»ng Nga: Sù kiÖn Trung Thu ®· t¹m ®ãng. Xin anh hïng h·y quay l¹i sau!", true)
    return false
  end

  if not self:IsActive() then
    KsgNpc:Talk("H»ng Nga: Sù kiÖn Trung Thu ®· kÕt thóc, chóc c¸c anh hïng Trung thu vui vÎ b×nh an ~~~", 1)
    return false
  end

  if KsgPlayer:GetLevel() < self.nRequireLevel then
    KsgNpc:Talk(string.format("H»ng Nga: Anh hïng ch­a ®¹t cÊp %d, kh«ng thÓ tham gia sù kiÖn %s. H·y tu luyÖn thªm råi l¹i tíi!", self.nRequireLevel, self.szName))
    return false
  end

  if KsgTask:Get(self.nTaskId_Version) ~= self.nVersion then
    self:Clean()
    return false
  end

  return true
end

function EventMidAutumn:ChooseExpType(nType)
  local tbExpTypeCfg = self.tbExpTypeCfg
  if nType then
    local szType = "®iÓm kinh nghiÖm Nh©n giíi"
    if nType == tbExpTypeCfg.TIEN_MA then
      szType = "®iÓm tu luyÖn Tiªn Ma"
      if IsNewBirthComplete() ~= 1 or KsgPlayer:GetLevel() < 120 then
        return KsgNpc:Talk("Anh hïng ch­a v­ît qua kiÕp n¹n Nh©n giíi, kh«ng thÓ chän ®iÓm tu luyÖn Tiªn Ma!", true)
      end
    end
    KsgTask:SetBit(tbExpTypeCfg.nTaskId, tbExpTypeCfg.nTaskBit, nType)
    return KsgNpc:Talk(string.format("Kinh nghiÖm th­ëng sù kiÖn ®· ®­îc ®æi thµnh %s", szType), true)
  end
  local nCurrentType = KsgTask:GetBit(tbExpTypeCfg.nTaskId, tbExpTypeCfg.nTaskBit)
  local szType = "§iÓm kinh nghiÖm Nh©n giíi"
  if nCurrentType == tbExpTypeCfg.TIEN_MA then
    szType = "§iÓm tu luyÖn Tiªn Ma"
  end
  local tbSay = {
    { "§iÓm kinh nghiÖm Nh©n giíi (mÆc ®Þnh)", self.ChooseExpType, self, self.tbExpTypeCfg.NHAN_GIOI },
    { "§iÓm tu luyÖn Tiªn Ma", self.ChooseExpType, self, self.tbExpTypeCfg.TIEN_MA },
  }
  KsgNpc:Say(string.format("H»ng Nga: Chän lo¹i kinh nghiÖm anh hïng muèn nhËn:\nH×nh thøc nhËn hiÖn t¹i: <c=g>%s<c>", szType), tbSay)
end

function EventMidAutumn:MoonCake(nIdx)
  local tbExchange = self.tbMoonCakes[nIdx]

  KsgNpc:AskNumber(string.format("Anh hïng muèn lµm bao nhiªu %s?", tbExchange.szName), self.MoonCake_Make, { self, nIdx })
end

function EventMidAutumn:MoonCake_Make(nType, nAmount)
  local tbMoonCake = self.tbMoonCakes[nType]

  if not KsgPlayer:HaveEnoughBagSpaces(nAmount) then
    return KsgNpc:Talk("Hµnh trang kh«ng cßn ®ñ chç trèng, vui lßng s¾p xÕp l¹i!")
  end

  local tbConditions = KsgTable:Copy(tbMoonCake.tbConditions)
  local tbItems = {}
  for i, item in ipairs(tbConditions.tbItems) do
    local requireItem = KsgTable:Copy(item)

    requireItem.nAmount = requireItem.nAmount * nAmount
    tbItems[i] = requireItem
  end

  tbConditions.tbItems = tbItems

  if KsgLib:PayMaterial(tbConditions) then
    KsgAward:Give({ tbProp = tbMoonCake.tbProp, szName = tbMoonCake.szName, nAmount = nAmount }, string.format("Lµm %s", tbMoonCake.szName))
  end
end

function EventMidAutumn:MoonCake_Shop(nShopId, nItemIdx)
  local tbShop = self.tbShops[nShopId]
  if not tbShop then
    return KsgNpc:Talk("H»ng Nga: A~~~ Ngµi ®· chän thÕ nµo vËy...?")
  end
  if nItemIdx then
    local tbItem = tbShop.tbItems[nItemIdx]
    return KsgNpc:AskNumber(string.format("H»ng Nga: Anh hïng, ngµi muèn mua bao nhiªu %s?", tbItem.szName), self.MoonCake_ShopBuy, { self, nShopId, nItemIdx })
  end
  local tbSay = {}
  local szPriceDesc = ""
  local nItemsCount = #tbShop.tbItems
  local szSuffix = ""
  for nIdx, tbItem in ipairs(tbShop.tbItems) do
    tbSay[#tbSay + 1] = { string.format("Ta muèn mua <c=y>%s<c>", tbItem.szName), self.MoonCake_Shop, self, nShopId, nIdx }
    if nIdx ~= nItemsCount then
      if nItemsCount > 3 then
        szSuffix = ", "
      else
        szSuffix = "\n"
      end
    else
      szSuffix = ""
    end
    szPriceDesc = szPriceDesc .. KsgLib:MaterialDescription(tbItem.tbConditions, string.format("<c=g>%s<c>: ", tbItem.szName)) .. szSuffix
  end
  local szTitle = "H»ng Nga: Anh hïng, ngµi tíi mua <c=g>%s<c> sao?\n\n%s"
  return KsgNpc:Say(string.format(szTitle, tbShop.szName, szPriceDesc), tbSay)
end

function EventMidAutumn:MoonCake_ShopBuy(nShopId, nItemIdx, nAmount)
  local tbShop = self.tbShops[nShopId]
  if not tbShop or not nItemIdx or not nAmount then
    return KsgNpc:Talk("H»ng Nga: Chµ,,,Ngµi ®· chän nhÇm råi, xin mêi chän l¹i.")
  end
  if not KsgPlayer:HaveEnoughBagSpaces(nAmount) then
    return KsgNpc:Talk("H»ng Nga: Hµnh trang cña ngµi kh«ng cßn ®ñ chç trèng, h·u s¾p xÕp råi l¹i ®Õn t×m ta!")
  end
  local tbItem = tbShop.tbItems[nItemIdx]
  local tbConditions = KsgTable:Copy(tbItem.tbConditions)
  if tbConditions.nMoney then
    tbConditions.nMoney = tbConditions.nMoney * nAmount
  end
  if tbConditions.nCopperCash then
    tbConditions.nCopperCash = tbConditions.nCopperCash * nAmount
  end

  if KsgLib:PayMaterial(tbConditions) then
    KsgAward:Give({ tbProp = tbItem.tbProp, szName = tbItem.szName, nAmount = nAmount }, string.format("Mua %s-%s", tbShop.szName, tbItem.szName))
  end
end

function EventMidAutumn:MoonCake_GetAccumulateAward(nType, nAccumulateId)
  if not nType then
    local tbSay = {}
    for nIdx, tbExchange in ipairs(self.tbMoonCakes) do
      tbSay[nIdx] = { string.format("NhËn th­ëng mèc %s", tbExchange.szName), self.MoonCake_GetAccumulateAward, self, nIdx }
    end
    return KsgNpc:Say("H»ng Nga: H·y chän phÇn th­ëng Anh hïng muèn nhËn:", tbSay)
  end
  local tbMoonCake = self.tbMoonCakes[nType]
  local tbAwardCfg = self.tbAwards[nType]
  local nTaskId_Accumulate = tbAwardCfg.nTaskId_Accumulate
  local nTaskId_UsedCount = tbAwardCfg.nTaskId_UsedCount
  local tbAwardAccumulate = tbAwardCfg.tbAwardAccumulate
  local szName = tbMoonCake.szName
  if not nAccumulateId then
    local nCanGet = 0
    local tbSay = {}
    for nIdx, tbCfg in ipairs(tbAwardAccumulate) do
      if KsgTask:GetBit(nTaskId_Accumulate, nIdx) == 0 then
        tbSay[nIdx] = { string.format("Ta ®· dïng %d %s", tbCfg.nRequireUse, szName), self.MoonCake_GetAccumulateAward, self, nType, nIdx }
        nCanGet = nCanGet + 1
      end
    end
    if nCanGet == 0 then
      return KsgNpc:Talk("H»ng Nga: Anh hïng ®· nhËn hÕt tÊt c¶ mèc th­ëng råi!", true)
    end
    return KsgNpc:Say("H»ng Nga: H·y chän mèc phÇn th­ëng Anh hïng muèn nhËn:", tbSay)
  end
  -- B¾t ®Çu nhËn th­ëng
  if not KsgPlayer:HaveEnoughBagRoom(10) then
    return
  end
  if not tbAwardAccumulate[nAccumulateId] then
    return KsgPlayer:Msg("H»ng Nga: Ta kh«ng ph¸t phÇn th­ëng nµy! Ngµi ®· chän thÕ nµo vËy ~~~")
  end
  if KsgTask:GetBit(nTaskId_Accumulate, nAccumulateId) == 1 then
    return KsgNpc:Talk("H»ng Nga: Anh hïng, ngµi ®· nhËn phÇn th­ëng nµy råi!")
  end

  local nUseCount = KsgTask:Get(nTaskId_UsedCount)
  local nRequireUse = tbAwardAccumulate[nAccumulateId].nRequireUse
  if nUseCount < nRequireUse then
    return KsgNpc:Talk(string.format("H»ng Nga: Anh hïng cÇn dïng ®ñ <c=y>%d %s<c> míi cã thÓ nhËn phÇn th­ëng nµy!<enter><enter>HiÖn ®· dïng: <c=r>%d<c>/<c=g>%d<c> %s", nRequireUse, szName, nUseCount, nRequireUse, szName))
  end
  for _, tbAward in ipairs(tbAwardAccumulate[nAccumulateId].tbAwards) do
    KsgAward:Give(tbAward, string.format("NhËn quµ mèc dïng %d %s", nRequireUse, szName))
  end
  KsgTask:SetBit(nTaskId_Accumulate, nAccumulateId, 1)
  KsgNpc:Talk("H»ng Nga: Chóc mõng anh hïng ®· nhËn th­ëng thµnh c«ng, phÇn th­ëng ®· ®­îc ®­a vµo hµnh trang!")
end

function EventMidAutumn:DropEventBox(nAmount, bFromTask)
  nAmount = nAmount or 1
  local tbBox = self.tbDropMaterialCfg.tbBox
  tbBox.nAmount = nAmount
  local szFrom = "®¸nh qu¸i"
  if bFromTask then
    szFrom = "NhiÖm vô"
  end
  KsgAward:Give(tbBox, string.format("NhÆt ®­îc %s %s", tbBox.szName, szFrom))
end

function EventMidAutumn:OpenEventBox(nAmount)
  local tbBox = self.tbDropMaterialCfg.tbBox
  local tbMaterials = self.tbDropMaterialCfg.tbMaterials
  if KsgItem:Count(tbBox.tbProp) < nAmount then
    return KsgNpc:Talk(string.format("Sè l­îng %s trong hµnh trang kh«ng ®ñ %d", tbBox.szName, nAmount))
  end
  local nDeleted = KsgItem:Delete(tbBox.tbProp, nAmount)
  if nDeleted > 0 then
    KsgAward:Give(tbMaterials, string.format("Më %s", tbBox.szName), nDeleted)
  end
end

function EventMidAutumn:OpenAwardBox(nIdx, nAmount)
  nAmount = nAmount or 1
  local tbExchange = self.tbMoonCakes[nIdx]
  local tbAwardCfg = self.tbAwards[nIdx]

  local nMaxUse = tbAwardCfg.nMaxUse
  local szName = tbExchange.szName
  local tbAward = tbAwardCfg.tbAward
  local nExpRate = tbAwardCfg.nExpRate
  local nExpTienMaRate = tbAwardCfg.nExpTienMaRate

  if KsgServer:IsNewServer() and self.bPromotionNewServer then
    nExpRate = nExpRate * 2
    nExpTienMaRate = nExpTienMaRate * 2
    nMaxUse = nMaxUse * 2
  end

  local nTaskId_UsedCount = tbAwardCfg.nTaskId_UsedCount

  if KsgItem:Count(tbExchange.tbProp) < nAmount then
    return KsgNpc:Talk(string.format("Sè l­îng %s trong hµnh trang kh«ng ®ñ %d", szName, nAmount))
  end

  local nUseCount = KsgTask:Get(nTaskId_UsedCount)
  if nUseCount + nAmount > nMaxUse then
    local nRemaining = nMaxUse - nUseCount
    if nRemaining == 0 then
      return KsgNpc:Talk(string.format("Anh hïng ®· dïng tèi ®a %d %s, kh«ng thÓ dïng thªm", nMaxUse, szName))
    end
    return KsgNpc:Talk(string.format("ChØ cã thÓ dïng thªm tèi ®a %d %s", nRemaining, szName))
  end

  local nDeleted = KsgItem:Delete(tbExchange.tbProp, nAmount)
  if nDeleted > 0 then
    local tbExpTypeCfg = self.tbExpTypeCfg
    local nExpType = KsgTask:GetBit(tbExpTypeCfg.nTaskId, tbExpTypeCfg.nTaskBit)
    if nExpType == tbExpTypeCfg.TIEN_MA then
      local nExp = KsgPlayer:GetLevelEx() * nExpTienMaRate * nAmount
      AddOwnExtendExp(nExp)
    else
      local nExp = KsgPlayer:GetLevel() * nExpRate * nAmount
      KsgPlayer:BigAddExp(nExp)
    end

    KsgAward:Give(tbAward, string.format("Më %s", szName), nDeleted)
    KsgTask:Modify(nTaskId_UsedCount, nDeleted)
    KsgPlayer:Msg(string.format("§· dïng %d/%d %s", nUseCount + nDeleted, nMaxUse, szName))
  end
end

function EventMidAutumn:GiftMain()
  CloseDialog()

  local tbOptions = {}
  local tbTitles = {}
  for nIdx, gift in ipairs(self.tbGift) do
    table.insert(tbOptions, { gift.szName, self._ChooseGift, self, nIdx })
    table.insert(tbTitles, string.format("§æi <c=g>%s<c> cÇn <c=g>%d<c> tiÒn cÇu phóc", gift.szName, gift.nRequiredNum))
  end

  local szTitle = "H»ng Nga: " .. table.concat(tbTitles, ", ")
  KsgNpc:Say(szTitle, tbOptions)
end

function EventMidAutumn:_ChooseGift(nIdx)
  CloseDialog()
  KsgNpc:MsgBoxEx(string.format("H»ng Nga: B¹n muèn dïng <c=g>%d<c> tiÒn cÇu phóc ®æi %s?", self.tbGift[nIdx].nRequiredNum, self.tbGift[nIdx].szName),
      { self._GetGift, self, nIdx })
end

function EventMidAutumn:_GetGift(nIdx)
  CloseDialog()
  local gift = self.tbGift[nIdx];
  if (HaveNormalItem(3, 1128, 0, 0) < gift.nRequiredNum) then
    KsgNpc:Talk("H»ng Nga: TiÒn cÇu phóc cña b¹n kh«ng ®ñ, kh«ng thÓ ®æi" .. gift.szName .. ".")
    return
  end

  local nTaskTime = KsgTask:GetByte(self.nAwardTaskId, 4)
  local nUsedCoinNum = KsgTask:GetByte(self.nAwardTaskId, 3)
  local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1

  if (nTaskTime == nToday and nUsedCoinNum + gift.nRequiredNum > self.nMaxUseCoinPerDay) then
    KsgNpc:Talk("Sè lÇn ®æi h«m nay cña b¹n ®· qu¸ nhiÒu, hÕt c¬ héi ®æi <c=g>" .. gift.szName .. "<c> råi")
    return
  end

  for i = 1, gift.nRequiredNum do
    DelNormalItem(3, 1128, 0, 0)
  end

  KsgAward:Give(gift, "§· ®æi " .. gift.szName)
  KsgTask:SetByte(self.nAwardTaskId, 4, nToday)
  KsgTask:GetByte(self.nAwardTaskId, 3, nUsedCoinNum + gift.nRequiredNum)
end

function EventMidAutumn:OpenGift(nIdx)
  local tbGiftCfg = self.tbGift[nIdx]
  if not tbGiftCfg then
    return KsgNpc:Talk("Quµ Trung thu nµy kh«ng tån t¹i!")
  end

  if (HaveNormalItem(unpack(tbGiftCfg.tbProp)) == 0) then
    InfoBox("B¹n ch­a nhËn lÔ bao Trung Thu.")
    return
  end

  if not KsgPlayer:HaveEnoughBagRoom(#tbGiftCfg.tbAwards[1] + 1) then
    return
  end

  for _, tbAward in pairs(tbGiftCfg.tbAwards) do
    KsgAward:Give(tbAward, "Tui qua trung thu loai 1")
  end

  DelNormalItem(unpack(tbGiftCfg.tbProp))
end

function EventMidAutumn:Clean()
  if self.nVersion ~= KsgTask:Get(self.nTaskId_Version) then
    -- Reset task
    for _, v in ipairs(self.tbAwards) do
      KsgTask:Set(v.nTaskId_UsedCount, 0) -- Reset use count
      KsgTask:Set(v.nTaskId_Accumulate, 0) -- Reset award
    end
    KsgTask:Set(self.tbExpTypeCfg.nTaskId, 0) -- Reset exp type
  end
end

function EventMidAutumn:OnPlayerLogin()
  if KsgTask:Get(self.nTaskId_Version) ~= self.nVersion then
    self:Clean() -- Reset task and clean items
    KsgTask:Set(self.nTaskId_Version, self.nVersion)
  end
  if self:IsActive() then
    KsgPlayer:Msg(string.format("Sù kiÖn %s ®ang diÔn ra rÊt n¸o nhiÖt, h·y ®Õn H»ng Nga ë TriÒu Ca (219/188) ®Ó t×m hiÓu thªm!", self.szName))
  end
end

function EventMidAutumn:OnServerStartUp()
  if self:IsActive() then
    local nMapIdx = SubWorldID2Idx(21) -- TriÒu Ca
    if (nMapIdx ~= -1) then
      --local nHour, nMin, nSecond = GetHMS();
      --local nLeftTime = (23 - nHour) * 3600 + (59 - nMin) * 60 + (59 - nSecond) + 1 -- Thêi gian cßn l¹i cña ngµy
      local nNpcIdx = AddNpc(1831, 1, nMapIdx, 1758 * 32, 3014 * 32) -- 219/188
      SetNpcScript(nNpcIdx, "\\script\\common\\king\\events\\midautumn\\npc\\hang_nga.lua")
      SetNpcName(nNpcIdx, "H»ng Nga")
      --SetNpcTimer(nNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nLeftTime)

      EventMidAutumnLantern:Init()
      EventMidAutumnRabbit:Init()
    end
  end
end

function EventMidAutumn:OnNpcPreDeath(nNpcIdx)
  if self:IsActive() then
    local dropCfg = self.tbDropMaterialCfg
    local nNpcLevel = GetNpcLevel(nNpcIdx)
    if nNpcLevel >= dropCfg.nMinNpcLevel and KsgLib:IsRate(dropCfg.nRate) then
      if dropCfg.bTeam then
        KsgLib:TeamOperate(self.DropEventBox, self)
      else
        self:DropEventBox(dropCfg.nDropNum)
      end
    end
  end
end

function EventMidAutumn:LoadCfgForNewServer()
  if KsgServer:IsNewServer() and self.bPromotionNewServer then
    --self.tbShops = self.tbShops_NewServer
    --self.tbAwards = self.tbAwards_NewServer
  end
end

function EventMidAutumn:OnTaskFinish(nTaskId)
  local nTaskValue = KsgTask:Get(nTaskId)
  if nTaskValue <= 0 then
    return
  end
  if (nTaskId == KsgTask.tbIds.NguSacHon) then
    -- Ngò S¾c Hån
    local nTurn = KsgTask:GetByte(nTaskId, 2)
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.TrungQuyTienMa) then
    -- Trïng Quy Tiªn Ma
    local nTurn = KsgTask:GetByte(nTaskId, 2)
    if nTurn >= 2 then
      self:DropEventBox(nTurn * 2, true)
    end
  elseif (nTaskId == KsgTask.tbIds.CanKhonLuan) then
    -- Quay Cµn Kh«n
    local nTurn = nTaskValue
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.SieuDo) then
    -- Siªu §é
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn == 4 or nTurn == 7 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.ThamQuan) then
    -- Th¸m Qu©n
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn >= 3 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.ThuThapDaoCu) then
    -- Thu thËp §¹o Cô
    local nTurn = nTaskValue
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.VanTienTran) then
    -- V¹n Tiªn TrËn
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    self:DropEventBox(nTurn, true)
  elseif (nTaskId == KsgTask.tbIds.VanLuong) then
    -- VËn L­¬ng
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.BaoThuong) then
    -- Bµo Th­¬ng
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn >= 3 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.TongTuu) then
    -- Tèng Töu (B¸ch Niªn TrÇn Nh­ìng)
    local nTurn = KsgTask:GetByte(nTaskId, 2)
    if nTurn >= 2 then
      self:DropEventBox(nTurn * 2, true)
    end
  elseif (nTaskId == KsgTask.tbIds.XaoDoatThienCong) then
    --  X¶o §o¹t Thiªn C«ng (Thiªn Cèng)
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn >= 3 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.HoTienHoanMa) then
    -- H« Tiªn Ho¸n Ma
    local nTurn = KsgTask:GetByte(nTaskId, 2)
    local nMonsterNum = KsgTask:GetByte(nTaskId, 3)
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  elseif (nTaskId == KsgTask.tbIds.NamMinhLyHoa) then
    -- Nam Minh Ly Háa
    local nTurn = KsgTask:GetByte(nTaskId, 1)
    if nTurn >= 2 then
      self:DropEventBox(nTurn, true)
    end
  end
end

EventMidAutumn:LoadCfgForNewServer()

return EventMidAutumn

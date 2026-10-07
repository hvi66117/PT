--- @class KsgPlayer
KsgPlayer = KsgPlayer or {}

KsgPlayer.MAX_REPUTE = 2e9
KsgPlayer.MAX_EXP = 2e9

KsgPlayer.GIAP_SI = 0
KsgPlayer.DAO_SI = 1
KsgPlayer.DI_NHAN = 2

KsgPlayer.MALE = 0
KsgPlayer.FEMALE = 1

KsgPlayer.tbGMAccounts = {
  "gm", "gm001", "gm002", "gm003", "gm004", "gm005", "gm006", "gm007", "gm008", "gm009", "gm010",
}

KsgPlayer.tbAdminAccounts = {
  "jurasic",
  "jurasicvn",
  "jurasic1",
}

--- Get the player's health value
--- @param nType number: Heath type, 0 = Current, 1 = Max
function KsgPlayer:GetLife(nType)
  return GetLife(nType)
end

--- Get the player's current health value
function KsgPlayer:GetCurLife()
  return self:GetLife(0)
end

--- Get the player's max health value
function KsgPlayer:GetMaxLife()
  return self:GetLife(1)
end

--- Get the current player's mana value
--- @param nType number: Mana type, 0 = Current, 1 = Max
function KsgPlayer:GetMana(nType)
  return GetMana(nType)
end

--- Get the player's current mana value
function KsgPlayer:GetCurMana()
  return self:GetMana(0)
end

--- Get the player's max mana value
function KsgPlayer:GetMaxMana()
  return self:GetMana(1)
end

--- Restores player's health
function KsgPlayer:RestoreLife()
  RestoreLife()
end

--- Restores player's mana
function KsgPlayer:RestoreMana()
  RestoreMana()
end

--- Fully restores player's mana and health
function KsgPlayer:Restore()
  RestoreLife()
  RestoreMana()
end

--- Add silver for the current player
function KsgPlayer:Earn(nAmount)
  Earn(nAmount)
end

--- Add silver for the current player (in units of ten thousand)
function KsgPlayer:EarnMoney(nAmount)
  Earn(nAmount * 10000)
end

--- Pay player silver in units of ten thousand
function KsgPlayer:PayMoney(nAmount)
  Pay(nAmount * 10000)
end

--- Get the player's available silver in units of ten thousand
--- @return number Total cash in ten thousand
function KsgPlayer:GetMoney()
  return floor(GetCash() / 10000)
end

--- Get the player's current level
--- @return number Player level
function KsgPlayer:GetLevel()
  return GetLevel()
end
--- Get the player's current level Tien ma
--- @return number Player level
function KsgPlayer:GetLevelEx()
  return GetPlayerExtLevel()
end

--- Get the experience points needed to level up to the next level
--- @return number Total exp
function KsgPlayer:GetNextLevelExp()
  return GetNextExp()
end

--- Get the total exp of the current player
--- @return number: Total exp
function KsgPlayer:GetExp()
  return GetExp()
end

--- Add exp for current player
--- @param nValue number
function KsgPlayer:AddExp(nValue)
  return AddOwnExp(nValue)
end

--- Add large amount of exp for current player
--- @param nValue number
function KsgPlayer:BigAddExp(nValue)
  if nValue > self.MAX_EXP then
    self:AddExp(self.MAX_EXP)
    nValue = nValue - self.MAX_EXP

    local szMsg = format("NhËn ®­îc %d ®iÓm kinh nghiÖm", self.MAX_EXP)
    self:BigAddExp(nValue)
    self:Msg(szMsg)
    ScrollMessage(szMsg)
  else
    local szMsg = format("NhËn ®­îc %d ®iÓm kinh nghiÖm", nValue)
    self:AddExp(nValue)
    self:Msg(szMsg)
    ScrollMessage(szMsg)
  end
end
---


--- Get total repute of current player
--- @return number Number of reputation points available
function KsgPlayer:GetRepute()
  return GetCredit()
end

--- Get total repute Tien Ma of current player
--- @param bRaw boolean
--- @return number Number of reputation points available
function KsgPlayer:GetReputeTienMa(bRaw)
  if bRaw then
    return GetJusticEvilCredit()
  end
  return abs(GetJusticEvilCredit())
end

--- Add reputation for current player
--- @param nPoint number: Number of reputation want to add
function KsgPlayer:AddRepute(nPoint)
  local nMaxReputeCanAdd = self.MAX_REPUTE - self:GetRepute()
  if abs(nPoint) >= nMaxReputeCanAdd then
    return self:Msg("Danh väng ®· ®¹t tèi ®a, kh«ng thÓ t¨ng thªm")
  end

  AddCredit(nPoint)
  local szMsg = "NhËn ®­îc"
  if nPoint < 0 then
    szMsg = "MÊt"
  end

  szMsg = format("%s %d ®iÓm danh väng", szMsg, abs(nPoint))
  self:Msg(szMsg)
  ScrollMessage(szMsg)
end

--- Add reputation Tien Ma for current player
--- @param nPoint number: Number of reputation want to add
function KsgPlayer:AddReputeTienMa(nPoint)
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

--- Send message to player
--- @param szMessage string: Message to send
--- @param nType number: Type of sending: MSG|TALK|SAY, default is MSG
function KsgPlayer:Msg(szMessage, nType)
  szMessage = tostring(szMessage)
  nType = nType or MSG
  if nType == MSG then
    Msg2Player(szMessage)
  elseif nType == TALK then
    Talk(1, "_no", szMessage)
  elseif nType == SAY then
    Say(szMessage, 0)
  end
end

--- Get name of current player
--- @return string Player name
function KsgPlayer:GetName()
  return GetName()
end

--- Get sex id of current player
--- @return number: 0 = Male, 1 = Female
function KsgPlayer:Gender()
  return GetSex()
end

--- Get faction id of current player
--- @return number Faction Id
function KsgPlayer:GetFactionId()
  return GetPlayerType()
end

--- Get faction name of current player
--- @return string|nil
function KsgPlayer:GetFactionName(nFactionId)
  nFactionId = nFactionId or self:GetFactionId()
  local tbFactionNames = {
    [self.GIAP_SI] = "Gi¸p SÜ",
    [self.DAO_SI] = "§¹o SÜ",
    [self.DI_NHAN] = "DÞ Nh©n",
  }

  return tbFactionNames[nFactionId]
end

--- Get player's account name
--- @return string
function KsgPlayer:GetAccount()
  return GetAccount()
end

--- Get amount of copper cash currently in the bag
--- @return number
function KsgPlayer:GetCopperCash()
  return GetCopperCashCount()
end

--- Check the empty space in the bag
--- @param nRoom number Number of empty cells
--- @param bForCopperCash boolean
--- @return boolean
function KsgPlayer:HaveEnoughBagRoom(nRoom, bForCopperCash)
  local bCondition = IsHaveSpaceForTreasure(nRoom) == 1
  if bForCopperCash then
    bCondition = IsHaveSpaceForCopperCash(nRoom) == 1
    nRoom = ceil(nRoom / KsgItem.COPPER_CASH_MAX_STACK) + 1
  end
  if not bCondition then
    KsgPlayer:Msg(format("Hµnh trang kh«ng cßn ®ñ %d « trèng, vui lßng s¾p xÕp l¹i!", nRoom))
  end

  return bCondition
end

--- Check the empty space in the bag
--- @param nAmount number Number of items
--- @param nStackCount number Item max stacks
--- @return boolean
function KsgPlayer:HaveEnoughBagSpaces(nAmount, nStackCount)
  nStackCount = nStackCount or KsgItem.MAX_STACK
  local nRoom = ceil(nAmount / nStackCount)

  nRoom = nRoom + 1

  if IsHaveSpaceForTreasure(nRoom) == 1 then
    return 1
  end
  KsgPlayer:Msg(format("Hµnh trang kh«ng cßn ®ñ %d « trèng, vui lßng s¾p xÕp l¹i!", nRoom))

  return nil
end

--- Add copper cash for the current player
--- @param nAmount number Cash amount
function KsgPlayer:AddCopperCash(nAmount)
  if not KsgPlayer:HaveEnoughBagRoom(nAmount, 1) then
    return
  end

  AddCopperCash(nAmount)
end

--- Players pay copper cash
--- @param nAmount number Pay amount
function KsgPlayer:PayCopperCash(nAmount)
  if self:GetCopperCash() < nAmount then
    local szMsg = format("C¸c h¹ kh«ng cã ®ñ %d tiÒn ®ång!", nAmount)
    ScrollMessage(szMsg)

    return KsgPlayer:Msg(szMsg)
  end

  WasteCopperCash(nAmount)
end

function KsgPlayer:IsSpecialMorph()
  local nType = GetMorphType()
  if CanPolyMorph() == 0
    and GetCompeteFlag() ~= 1
    and (nType ~= 2491 and nType ~= 2490) --§¹o ®ång nam, n÷
    and not self:IsInCamel() --L¹c §µ
    and IsPlayerInsideWeapon(PlayerIndex) <= 0 --Tr¹ng th¸i vËn l­¬ng
    and not ((nType >= 1396 and nType <= 1398) or (nType >= 1401 and nType <= 1406)) then
    --1396~1398 kiÖu s¬, trung,cao  1401~1406 liªn quan ®Õn t©n lang
    return nil
  end
  return 1
end

function KsgPlayer:IsInCamel()
  local nType = GetMorphType()
  if (nType == 1231 or nType == 1232 or nType == 3056 or nType == 3057) then
    --L¹c §µ
    return 1
  end
  return nil
end

function KsgPlayer:IsGM(szAccount)
  szAccount = szAccount or self:GetAccount()
  return KsgTable:Contains(self.tbGMAccounts, szAccount) or self:IsAdmin(szAccount)
end

function KsgPlayer:IsAdmin(szAccount)
  szAccount = szAccount or self:GetAccount()
  return KsgTable:Contains(self.tbAdminAccounts, szAccount)
end

function KsgPlayer:GetLastLoginServerId()
  return KsgTask:GetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.LAST_LOGIN_SERVER_ID)
end

function KsgPlayer:SetLastLoginServerId(nValue)
  return KsgTask:SetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.LAST_LOGIN_SERVER_ID, nValue)
end

function KsgPlayer:SetLastServerId(nValue)
  return KsgTask:SetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.LAST_SERVER_ID, nValue)
end

function KsgPlayer:GetLastServerId()
  return KsgTask:GetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.LAST_SERVER_ID)
end

function KsgPlayer:SetRegisterServerId(nValue)
  return KsgTask:SetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.REGISTER_TRANSFER_SERVER_ID, nValue)
end

function KsgPlayer:GetRegisterServerId()
  return KsgTask:GetByte(KsgTask.tbIds.ServerId, KsgTask.tbBytes.REGISTER_TRANSFER_SERVER_ID)
end

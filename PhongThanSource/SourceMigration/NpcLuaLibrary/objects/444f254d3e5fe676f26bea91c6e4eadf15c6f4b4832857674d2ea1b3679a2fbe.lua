require("king/events/midautumn/rabbit/event_midautumn_rabbit_def.luax")
require("king/events/midautumn/event_midautumn_def.luax")

AI_STATE_NONE = 0
AI_STATE_FREE = 1
AI_STATE_ATTACK = 2
AI_STATE_FELLOW = 3
AI_STATE_ROUTE = 4
AI_STATE_DEFEND = 5

AI_CONDITION_TARGET = 1
AI_CONDITION_DAMAGE = 2
AI_CONDITION_ATTACK = 3
AI_CONDITION_TIME = 4
AI_CONDITION_ROUTE = 5

AI_TARGET_FIND_PLAYER = 0
AI_TARGET_LOSE_PLAYER = 1
AI_TARGET_NEAR_PLAYER = 2

AI_ACT_TIME_POINT = 0
AI_ACT_TIME_PERIOD = 1

AI_ACT_ATTACK_PLAYER = 0
AI_ACT_ATTACK_NPC = 1

AI_ACT_DAMAGE_VALUE_PLAYER = 0
AI_ACT_DAMAGE_LOW_BLOOD_PLAYER = 1

AI_ACT_ROUTE_DES = 0

function EventMidAutumnRabbit:Init()
  if not self:IsActive() or not self:CanJoin() then
    return
  end
  local nMapIdx = SubWorldID2Idx(self.nWorldID)
  if (nMapIdx > -1) then
    return self:_CreateManyRabbitAIBoxes(nMapIdx, 30)
  end
end

function EventMidAutumnRabbit:IsActive()
  local nToday = today()

  return nToday >= self.nStartDate and nToday <= self.nEndDate
end

function EventMidAutumnRabbit:CanJoin()
  local nHour, nMinute = GetHMS()
  return nHour >= self.nStartHour and nHour < self.nEndHour and nMinute > 10
end

-- Rabit
function EventMidAutumnRabbit:RabitNpcMain()
  self:ResetDailyTask()

  local nCurrentTaskStep = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_Step)
  if nCurrentTaskStep == self.nTaskStep_None and GetLevel() >= self.nRequiredLevel then
    return KsgNpc:Talk("Muèn b¾t ta kh«ng, vËy th× h·y ®Õn gÆp <c=g>H»ng Nga<c> tham gia ho¹t ®éng <c=g>T×m Ngäc Thè<c>.")
  end

  if nCurrentTaskStep == self.nTaskStep_Accepted and GetMorphType() == self.nMorphId_FindRabbit then
    local nCatchNum = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt)

    if nCatchNum >= self.nMaxCatchCount then
      return KsgNpc:Talk("Ng­¬i ®· t×m ®­îc rÊt nhiÒu thá, h·y vÒ gÆp <c=g>H»ng Nga<c> ®Ó nhËn th­ëng.")
    end
    KsgTask:Set(self.nTaskIdCaughtRabbitId, GetNpcID(DialogNpcIdx))

    local nRand = math.random(1, #self.tbRabbitCaughtTalk)
    local szTitle = self.tbRabbitCaughtTalk[nRand]
    KsgNpc:MsgBoxEx(szTitle, { self._Confirm_CatchRabbit, self })
  end
end

function EventMidAutumnRabbit:PlaceARabbit(nMapIdx, nX, nY, nLifeTime)
  local tbNpc = {
    nNpcId = 1834,
    szName = "Thá",
    nMapIdx = nMapIdx,
    nX = nX,
    nY = nY,
    szScript = "\\script\\common\\king\\events\\midautumn\\npc\\rabbit.lua",
    szDestroyScript = "\\script\\common\\king\\events\\midautumn\\npc\\rabbit_destroy.lua",
    nLifeTime = nLifeTime,
  }
  return KsgNpc:Add(tbNpc)
end

function EventMidAutumnRabbit:ResetDailyTask()
  local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
  local nLastCatchRabbitDay = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_CatchRabbitLastDate)
  local nLastUseBlessingCoinDay = KsgTask:GetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_UsedBlessingCoinLastDate)

  if (nLastCatchRabbitDay > 0 and nLastCatchRabbitDay ~= nToday) then
    KsgTask:Set(self.nTaskIdRabbit, 0)
    KsgTask:Set(self.nTaskIdCaughtRabbitId, 0)
    TaskNote(self.nTaskNoteId, -1)
  end

  if (nLastUseBlessingCoinDay > 0 and nLastUseBlessingCoinDay ~= nToday) then
    KsgTask:SetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_CanUseBlessingCoin, 0)
    KsgTask:SetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_UsedBlessingCoinLastDate, 0)
  end
end

-- Rabit Ai Boxes
function EventMidAutumnRabbit:RabbitAIMain()
  ClearAICondition(-1, -1)
  SetGuardLevel(AiNpcIdx, 2)
  SetNpcTask(AiNpcIdx, NPCTVID_Rabbit_RouteStep, 1)
  local m, x, y = GetNpcWorldPos(AiNpcIdx)
  local nRandomRouteIdx = math.random(1, #self.tbRoute)
  local route = self.tbRoute[nRandomRouteIdx]
  SetRouteCondition(AI_ACT_ROUTE_DES, "RabitAiBoxEventRouteStep", m, route[1].x * 32, route[1].y * 32, nRandomRouteIdx)
  SetTimeCondition(AI_ACT_TIME_PERIOD, "RabitAiBoxEventTimeout", 60 * 5)
  SetAIState(AI_STATE_ROUTE)
end

function EventMidAutumnRabbit:_Confirm_CatchRabbit()
  if (GetNpcID(DialogNpcIdx) ~= 0 and GetNpcID(DialogNpcIdx) == KsgTask:Get(self.nTaskIdCaughtRabbitId)) then

    local nCatchNum = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt)

    if nCatchNum + 1 < self.nMaxCatchCount then
      TaskNote(self.nTaskNoteId, 0, nCatchNum + 1)
      KsgTask:SetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt, nCatchNum + 1)
      ScrollMessage("Ng­¬i t×m ®­îc 1 con thá")
      Msg2Player("Ng­¬i t×m ®­îc 1 con thá.")
    else
      TaskNote(self.nTaskNoteId, 1)
      ScrollMessage("Ng­¬i ®· t×m ®­îc rÊt nhiÒu thá, h·y vÒ gÆp H»ng Nga ®Ó nhËn th­ëng.")
    end

    KsgNpc:Delete(DialogNpcIdx)
    local nLeftNum = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt) - 1
    SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt, nLeftNum)
    self:_RefreshRabbitAiBoxes()
  else
    KsgNpc:Talk("TiÕc qu¸, thá ®· bÞ ng­êi ch¬i kh¸c b¾t hÕt.")
  end
end

function EventMidAutumnRabbit:RemoveNpc(nNpcIdx)
  KsgNpc:Delete(nNpcIdx)

  local nLeftNum = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt) - 1
  SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt, nLeftNum)

  EventMidAutumnRabbit:_RefreshRabbitAiBoxes()
end

function EventMidAutumnRabbit:_RefreshRabbitAiBoxes()
  local nLeftNum = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt)
  local nMapIdx = SubWorldID2Idx(self.nWorldID)

  local nLeftTime = self:_LeftTime()
  if (nLeftNum < 10 and nLeftTime > 100) then
    self:_CreateManyRabbitAIBoxes(nMapIdx, 20)
  end
end

function EventMidAutumnRabbit:_LeftTime()
  local hour, minute, second = GetHMS()

  return (self.nEndHour - 1 - hour) * 3600 + (59 - minute) * 60 + (59 - second) + 1
end

function EventMidAutumnRabbit:_CreateManyRabbitAIBoxes(nMapIdx, nNeedCreateCount)
  local nTotal = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt)

  local rand = math.random(1, #self.tbPosDelta)
  local nRabbitIdx = 0
  for i = 1, nNeedCreateCount do
    local delta = self.tbPosDelta[rand]
    local nX = (self.nPosBaseX + delta[1]) * 32
    local nY = (self.nPosBaseY + delta[2]) * 32
    nRabbitIdx = self:_CreateRabbitAIBox(nMapIdx, nX, nY)
    if (nRabbitIdx > 0) then
      nTotal = nTotal + 1
    end
  end

  SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_RabbitCnt, nTotal)

  AddGlobalNews("Trong thµnh ®· xuÊt hiÖn rÊt nhiÒu thá con, Thá Ngäc cña H»ng Nga n»m trong sè ®ã, mäi ng­êi h·y ®Õn chç H»ng Nga ®Ó nhËn nhiÖm vô, gióp t×m Thá Ngäc!")

  return nTotal
end

function EventMidAutumnRabbit:_CreateRabbitAIBox(nMapIdx, nX, nY)
  local tbNpc = {
    nNpcId = 1833,
    szName = "Thá",
    nMapIdx = nMapIdx,
    nX = nX,
    nY = nY,
    szAIScript = "\\script\\common\\king\\events\\midautumn\\npc\\rabbit_ai.lua",
    nGuardLevel = 2,
  }
  return KsgNpc:Add(tbNpc)
end

function RabitAiBoxEventRouteStep(nRouteIdx)
  EventMidAutumnRabbit:_RabitAiBoxEventRouteStep(nRouteIdx)
end

function EventMidAutumnRabbit:_RabitAiBoxEventRouteStep(nRouteIdx)
  local nStep = GetNpcTask(AiNpcIdx, NPCTVID_Rabbit_RouteStep)
  local m, x, y = GetNpcWorldPos(AiNpcIdx)
  local route = self.tbRoute[nRouteIdx]

  if nStep < #route then

    ClearAICondition(AI_CONDITION_ROUTE, -1)

    local nWillTalkRandom = math.random(1, 30)
    if nWillTalkRandom <= 10 then
      local nTalkPatternIdx = math.random(1, #self.tbRabbitTalk)
      NpcSay(AiNpcIdx, self.tbRabbitTalk[nTalkPatternIdx])
    end
    SetNpcTask(AiNpcIdx, NPCTVID_Rabbit_RouteStep, nStep + 1)
    SetRouteCondition(AI_ACT_ROUTE_DES, "RabitAiBoxEventRouteStep", m, route[nStep + 1].x * 32, route[nStep + 1].y * 32, nRouteIdx)
    SetAIState(AI_STATE_ROUTE)
  elseif (nStep == #route) then
    KsgNpc:Delete(AiNpcIdx)

    local hour, minute, second = GetHMS()
    local nLeftTime = (self.nEndHour - 1 - hour) * 3600 + (59 - minute) * 60 + (59 - second) + 1
    local nLifeTime = math.min(10 * 60, nLeftTime)
    self:PlaceARabbit(SubWorld, x * 32, y * 32, nLifeTime)
  end
end

function RabitAiBoxEventTimeout()
  EventMidAutumnRabbit:RemoveNpc(AiNpcIdx)
end

-- Hang Nga
function EventMidAutumnRabbit:RabitTaskMain()
  CloseDialog()

  if not self:IsActive() then
    return KsgNpc:Talk(string.format("H»ng Nga: Sù kiÖn %s ®· kÕt thóc!", self.szName))
  end

  if not self:CanJoin() then
    return KsgNpc:Talk(string.format("H»ng Nga: Sù kiÖn %s ®· ch­a b¾t ®Çu!\nMçi ®ªm vµo lóc <c=g>20:10-22:00h<c> tõ ngµy 10/09 ®Õn ngµy 12/09, anh hïng cã thÓ tham gia ho¹t ®éng t×m Thá Ngäc. §Õn lóc ®ã trong thµnh <c=g>TriÒu Ca<c> sÏ xuÊt hiÖn rÊt nhiÒu thá...", self.szName))
  end

  if KsgPlayer:GetLevel() < self.nRequiredLevel then
    return KsgNpc:Talk(string.format("H»ng Nga: C¶m ¬n sù nhiÖt t×nh cña ng­¬i nh­ng b©y giê ng­¬i kh«ng thÓ gióp ta, chê khi b¹n ®¹t <c=g>cÊp %d<c> h·y quay l¹i nhÐ.", self.nRequiredLevel))
  end

  local nTaskStep = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_Step)
  if nTaskStep == self.nTaskStep_None then
    if GetMorphType() ~= -1 or IsPlayerInsideWeapon(PlayerIndex) > 0 then
      return KsgNpc:Talk("H»ng Nga: Tr¹ng th¸i cña b¹n hiÖn t¹i kh«ng thÓ tham gia ho¹t ®éng TÕt Trung Thu, h·y phôc håi l¹i tr¹ng th¸i nh­ cò.")
    end

    local nHour, nMinute = GetHMS()
    if (nHour >= (self.nEndHour - 1) and nMinute >= 50) then
      return KsgNpc:Talk("H»ng Nga: Qu¸ trÔ råi, xem ra h«m nay ta kh«ng thÓ t×m thÊy Thá Ngäc, anh hïng h·y trë vÒ ®i nhÐ.")
    end

    KsgNpc:MsgBoxEx("H»ng Nga: <c=g>Thá Ngäc<c> cña ta lÉn vµo bÇy thá cña nh©n gian, kh«ng biÕt trèn ë n¬i nµo trong Thµnh, ng­¬i ®ång ý gióp ta t×m nhÐ?", { self.Accept_MidAutumn_Rabbit, self })

  elseif (nTaskStep == self.nTaskStep_Accepted) then
    if (GetMorphType() == 1704 and KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt) < self.nMaxCatchCount) then
      KsgNpc:MsgBoxEx("H»ng Nga: Ng­¬i ®ång ý giao nhiÖm vô b©y giê kh«ng? Ng­¬i vÉn trong tr¹ng th¸i ho¹t ®éng, cã thÓ <c=g>tiÕp tôc t×m<c> Thá Ngäc.", { self.Award_MidAutumn_Rabbit, self })
    else
      self:Award_MidAutumn_Rabbit()
    end

  elseif (nTaskStep == self.nTaskStep_Finished) then
    local nToday = today()
    if nToday == self.nEndDate then
      KsgNpc:Talk("H»ng Nga: C¶m ¬n, nh­ng ng­¬i ®· tham gia ho¹t ®éng cuèi cïng cña TÕt Trung Thu nµy.")
    else
      KsgNpc:Talk("H»ng Nga: C¶m ¬n, nh­ng h«m nay anh hïng ®· gióp ta, ngµy mai quay l¹i nhÐ.")
    end
  end
end

function EventMidAutumnRabbit:Accept_MidAutumn_Rabbit()
  CloseDialog()

  local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
  local nLeftTime = self:_LeftTime();
  local nCatchRabbitTime = math.min(nLeftTime, 10 * 60)

  if HaveIBBuff(self.nBuffId_FindRabbit) == 0 then
    AddIBBuff(self.nBuffId_FindRabbit, nLeftTime)
  end

  KsgNpc:Talk(string.format("H»ng Nga: §Ó mäi ng­êi ®Òu cã thÓ tham gia, tèi ®a ng­¬i chØ cã thÓ t×m ®­îc <c=g>%d con<c> thá lµ ®­îc. Ngoµi ra, thêi gian t×m lµ <c=g>10 phót<c>, h·y chó ý thêi gian.", self.nMaxCatchCount))

  PolyMorph(self.nMorphId_FindRabbit, 1, 0, -1, nCatchRabbitTime)
  AddIBBuff(self.nBuffId_CatchRabbit, nCatchRabbitTime)
  ScrollMessage("T×m thÊy thá trèn trong Thµnh")
  Msg2Player("T×m thÊy thá trèn trong Thµnh.")

  KsgTask:SetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_Step, 1);
  KsgTask:SetByte(self.nTaskIdRabbit, self.nByte_CatchRabbitLastDate, nToday);
  KsgTask:SetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt, 0);

  KsgTask:Set(self.nTaskIdCaughtRabbitId, 0);

  TaskNote(self.nTaskNoteId, 0, 0)
  WriteLog("NhËn nhiÖm vô t×m Thá Ngäc")
end

function EventMidAutumnRabbit:Award_MidAutumn_Rabbit()
  CloseDialog()

  local nCatchNum = KsgTask:GetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_CatchCnt)
  local nFreeExp = self.nAward_BaseExp

  if (nCatchNum == 0) then
    KsgNpc:Talk("H»ng Nga: Tuy ch­a t×m thÊy Thá Ngäc nh­ng rÊt c¶m ¬n ng­¬i.")
    AddOwnExp(nFreeExp)
    TopMessage(string.format("NhËn ®­îc %d ®iÓm kinh nghiÖm.", nFreeExp))
    Msg2Player(string.format("NhËn ®­îc %d ®iÓm kinh nghiÖm.", nFreeExp))
  else

    if (IsHaveSpaceForTreasure(2) == 0) then
      KsgNpc:Talk("H»ng Nga: Tói cña ng­¬i ®· ®Çy kh«ng thÓ nhËn phÇn th­ëng, h·y s¾p xÕp l¹i tói råi ®Õn nhËn nhÐ.")
      return
    end

    KsgNpc:Talk("H»ng Nga: C¶m ¬n sù gióp ®ì cña ng­¬i, ®©y lµ chót tÊm lßng cña ta, tÆng ng­¬i Chóc phóc Trung Thu.")

    local nValidNum = math.min(nCatchNum, self.nMaxCatchCount)
    local exp = nFreeExp + GetLevel() * nValidNum * self.nAward_ExpRate
    AddOwnExp(exp)

    AddItemPileNum(3, 1128, 0, 0, nValidNum)

    TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. exp .. " kinh nghiÖm<c> vµ <c=g> " .. nValidNum .. " tiÒn cÇu phóc<c>")
    Msg2Player("NhËn ®­îc " .. exp .. " kinh nghiÖm vµ " .. nValidNum .. " TiÒn cÇu phóc")

  end

  if GetMorphType() == self.nMorphId_FindRabbit then
    PolyMorph(-1, 0, 0, 0, 0)
  end

  RemoveIBBuff(self.nBuffId_CatchRabbit)
  KsgTask:SetByte(self.nTaskIdRabbit, self.nByte_TaskRabbit_Step, self.nTaskStep_Finished);
  TaskNote(self.nTaskNoteId, -1)
  WriteLog("Hoµn thµnh nhiÖm vô t×m Thá Ngäc, b¾t ®­îc " .. nCatchNum .. " con thá")
end

return EventMidAutumnRabbit

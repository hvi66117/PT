require("king/events/midautumn/lantern/event_midautumn_lantern_def.luax")
require("king/events/midautumn/event_midautumn_def.luax")

function EventMidAutumnLantern:Init()
  if not self:IsActive() or not self:CanJoin() then
    return
  end

  AddGlobalNews("LÔ héi hoa ®¨ng ®· b¾t ®Çu, c¸c anh hïng h·y mau tíi TriÒu Ca ®Ó tham gia ho¹t ®éng ®è ®Ìn")

  local nMapIdx = SubWorldID2Idx(self.nWorldID)
  if (nMapIdx == -1) then
    return
  end

  local nLanternIdx = 0
  local nTotalCreated = 0
  local MapIdx = SubWorldID2Idx(self.nWorldID)

  for i = 1, #self.tbLanternPositions do
    for j = 1, #self.tbLanternPositionsDelta do
      local nX = (self.tbLanternPositions[i][1] + self.tbLanternPositionsDelta[j][1]) * 32
      local nY = (self.tbLanternPositions[i][2] + self.tbLanternPositionsDelta[j][2]) * 32
      local nLifeTime = (self.nEndHour - self.nStartHour) * 3600

      nLanternIdx = self:_CreateLantern(MapIdx, nX, nY, nLifeTime);

      if (nLanternIdx > 0) then
        nTotalCreated = nTotalCreated + 1
        if (nTotalCreated <= 25) then
          KsgNpc:SetTask(nLanternIdx, self.nNPCPosIdx, self.nGlobalLanternPos1)
          KsgNpc:SetTask(nLanternIdx, self.nNpcPosBitField, (i - 1) * 5 + j)
          SetGlobalValueBit(self.nGlobalLanternPos1, (i - 1) * 5 + j, 1)
        else
          KsgNpc:SetTask(nLanternIdx, self.nNPCPosIdx, self.nGlobalLanternPos2)
          KsgNpc:SetTask(nLanternIdx, self.nNpcPosBitField, (i - 1) * 5 + j - 25)
          SetGlobalValueBit(self.nGlobalLanternPos2, (i - 1) * 5 + j - 25, 1)
        end
      end
    end
  end

  SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternCnt, nTotalCreated)
end

function EventMidAutumnLantern:IsActive()
  local nNow = today()

  return nNow >= self.nStartDate and nNow <= self.nEndDate
end

function EventMidAutumnLantern:CanJoin()
  local nHour = GetHMS()
  return nHour >= self.nStartHour and nHour < self.nEndHour
end

function EventMidAutumnLantern:LanternNpcMain()
  if KsgPlayer:GetLevel() < self.nRequiredLevel then
    return KsgNpc:Talk(string.format("Xin lçi, b¹n ch­a ®¹t <c=g>cÊp %d<c>, kh«ng thÓ tham gia ho¹t ®éng héi hoa ®¨ng Trung thu.", self.nRequiredLevel))
  end
  
  if not self:IsActive() then
    return KsgNpc:Talk(string.format("Sù kiÖn %s ®· kÕt thóc!", self.szName))
  end
      
  if not self:CanJoin() then
    return KsgNpc:Talk(string.format("Sù kiÖn %s ®· ch­a b¾t ®Çu!", self.szName))
  end
  
  self:ResetDailyTask()

  local nTotalAnsweredNum = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_AnsweredQuestionCnt)
  --local RightNum = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_CorrectAnswerCnt)

  if nTotalAnsweredNum >= self.nMaxAnswerTime then
    return KsgNpc:Talk("H«m nay b¹n ®· ®o¸n nhiÒu råi, h·y nh­êng c¬ héi cho ng­êi kh¸c.")
  end

  if IsHaveSpaceForTreasure(3) == 0 then
    return KsgNpc:Talk("Tói kh«ng ®ñ chç trèng, kh«ng thÓ nhËn hÕt toµn bé phÇn th­ëng, cÇn cã 2 « trèng.")
  end

  local tbOptions = {}

  local nRandomQuestionIdx = math.random(1, #self.tbQuestions)
  local tbQuestion = self.tbQuestions[nRandomQuestionIdx]
  for nAnsIdx, szAnswer in ipairs(tbQuestion.tbAnswers) do
    table.insert(tbOptions, { szAnswer, self._SelectAnswer, self, nAnsIdx })
  end

  KsgTask:SetByte(self.nTaskIdQuestion, self.nByte_SelectedQuestionIdx, nRandomQuestionIdx)
  KsgTask:Set(self.nTaskId_SelectedLanternIdx, KsgNpc:CurrentNpcId())

  local hour, minute, second = GetHMS()
  local nLeftTime = (self.nEndHour - 1 - hour) * 3600 + (59 - minute) * 60 + (59 - second) + 1

  if HaveIBBuff(self.nIBBuffId) == 0 then
    AddIBBuff(self.nIBBuffId, nLeftTime)
  end

  local szTitle = "<c=g>§è Hoa §¨ng:<c>" .. tbQuestion.szName .. string.format("\nMçi ngµy chØ ®­îc ®o¸n tèi ®a %d lÇn, ®©y lµ lÇn ®o¸n thø <c=g> ", self.nMaxAnswerTime) .. (nTotalAnsweredNum + 1) .. "<c> cña b¹n."
  KsgNpc:Say(szTitle, tbOptions)
end

function EventMidAutumnLantern:_SelectAnswer(nAnswerIdx)
  local nQuestionId = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_SelectedQuestionIdx)
  local tbQuestion = self.tbQuestions[nQuestionId]
  local nTotalAnsweredNum = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_AnsweredQuestionCnt)
  local RightNum = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_CorrectAnswerCnt)
  local nSelectedLanternIdx = KsgTask:Get(self.nTaskId_SelectedLanternIdx)
  local nCurrentNpcId = KsgNpc:CurrentNpcId()

  if nCurrentNpcId ~= 0 and nSelectedLanternIdx == nCurrentNpcId then
    if tbQuestion.nCorrectAnswerIdx == nAnswerIdx then
      local nCoinNum = math.random(2, 3)
      local rand = math.random(1, 10)
      local str = "Chóc mõng b¹n ®· ®o¸n ®óng, nhËn ®­îc <c=g>" .. nCoinNum .. " TiÒn cÇu phóc<c>."

      AddEmoteBalloon(PlayerIndex, 15)
      AddItemPileNum(3, 1128, 0, 0, nCoinNum)
      Msg2Player("NhËn ®­îc " .. nCoinNum .. " TiÒn cÇu phóc")

      if rand == 1 then
        str = str .. " vµ 1 <c=g>MËt tÞch chóc phóc Trung Thu<c>."
        AddNormalItem(6, 1, 852, 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc mËt tÝch chóc phóc Trung thu")
      end

      local nExpRate = self.nAwardExpRate
      local nExp = KsgPlayer:GetLevel() * nExpRate
      KsgPlayer:BigAddExp(nExp)

      KsgNpc:Talk(str)

      KsgTask:SetByte(self.nTaskIdQuestion, self.nByte_CorrectAnswerCnt, RightNum + 1)

      local GlobalValueID = KsgNpc:GetCurrentNpcTask(self.nNPCPosIdx)
      local BitPos = KsgNpc:GetCurrentNpcTask(self.nNpcPosBitField)
      local LeftNum = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternCnt) - 1

      SetGlobalValueBit(GlobalValueID, BitPos, 0)
      SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternCnt, LeftNum)

      KsgNpc:DeleteCurrentTargetNpc()
      self:_RefreshLantern()

    else
      local nExpRate = math.floor(self.nAwardExpRate / 2)
      local nExp = KsgPlayer:GetLevel() * nExpRate
      KsgPlayer:BigAddExp(nExp)
      KsgNpc:Talk("B¹n ®o¸n sai råi, lÇn sau cè g¾ng h¬n!")
    end

    if nTotalAnsweredNum == 0 then
      local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
      KsgTask:SetByte(self.nTaskIdQuestion, self.nByte_AnsweredLastDate, today)
    end

    KsgTask:SetByte(self.nTaskIdQuestion, self.nByte_AnsweredQuestionCnt, nTotalAnsweredNum + 1)
  else
    KsgNpc:Talk("C©u ®è nµy ®· cã ng­êi giµnh ®o¸n tr­íc råi, h·y tiÕp tôc cè g¾ng!")
  end

end

function EventMidAutumnLantern:_RefreshLantern()
  local hour, minute, second = GetHMS()
  local nLeftTime = (self.nEndHour - 1 - hour) * 3600 + (59 - minute) * 60 + (59 - second) + 1
  local nLeftNum = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternCnt)

  if nLeftNum < 10 and nLeftTime > 0 then
    local seq = GetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternSeq)

    local VacantPosGVID = {}
    local VacantPosBitField = {}
    local num = 0
    local idx = 1
    local StartBit = 1
    local EndBit = 25
    local step = 1

    if seq == 1 then
      StartBit = 25
      EndBit = 1
      step = -1
    end

    for i = StartBit, EndBit, step do

      if (num >= 30) then
        break
      end

      if (GetGlobalValueBit(self.nGlobalLanternPos1, i) == 0) then
        VacantPosGVID[idx] = self.nGlobalLanternPos1
        VacantPosBitField[idx] = i
        num = num + 1
        idx = idx + 1
      end
      if (GetGlobalValueBit(self.nGlobalLanternPos2, i) == 0) then
        VacantPosGVID[idx] = self.nGlobalLanternPos2
        VacantPosBitField[idx] = i
        num = num + 1
        idx = idx + 1
      end

    end

    local nCreatedCount = 0

    for i = 1, 30 do

      local base = 0
      if (VacantPosGVID[i] == self.nGlobalLanternPos1) then
        base = 0
      else
        base = 1
      end

      local id = base * 25 + VacantPosBitField[i]
      local index1 = 0
      local index2 = 0

      if (math.mod(id, 5) == 0) then
        index1 = math.floor(id / 5)
        index2 = 5
      else
        index1 = math.floor(id / 5) + 1
        index2 = math.mod(id, 5)
      end

      local nLanternIdx = self:_CreateLantern(SubWorld, (self.tbLanternPositions[index1][1] + self.tbLanternPositionsDelta[index2][1]) * 32,
          (self.tbLanternPositions[index1][2] + self.tbLanternPositionsDelta[index2][2]) * 32, nLeftTime);

      if nLanternIdx > 0 then
        KsgNpc:SetTask(nLanternIdx, self.nNPCPosIdx, VacantPosGVID[i])
        KsgNpc:SetTask(nLanternIdx, self.nNpcPosBitField, VacantPosBitField[i])
        nCreatedCount = nCreatedCount + 1

        SetGlobalValueBit(VacantPosGVID[i], VacantPosBitField[i], 1)
      end

    end

    SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternSeq, math.mod(seq + 1, 2))
    SetGlobalValueByte(EventMidAutumn.nGlobalTaskId_NpcNum, EventMidAutumn.nGlobalByte_LanternCnt, nLeftNum + nCreatedCount)
    Msg2CurMapAnnounce("§Ìn Hoa §¨ng míi ®· xuÊt hiÖn.")
  end
end

function EventMidAutumnLantern:_CreateLantern(nMapIdx, nX, nY, nLifeTime)
  local tbNpc = {
    nNpcId = 1832,
    szName = "<c=g>Hoa §¨ng Trung Thu<c>",
    nMapIdx = nMapIdx,
    nX = nX,
    nY = nY,
    szScript = "\\script\\common\\king\\events\\midautumn\\npc\\lantern.lua",
    szDestroyScript = "\\script\\common\\king\\events\\midautumn\\npc\\lantern_destroy.lua",
    nLifeTime = nLifeTime,
  }
  return KsgNpc:Add(tbNpc)
end

function EventMidAutumnLantern:ResetDailyTask()
  local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
  local nLastAnsweredDate = KsgTask:GetByte(self.nTaskIdQuestion, self.nByte_AnsweredLastDate)
  local nLastReceivedFlourDate = KsgTask:GetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_ReceivedFlourLastDate)
  if (nLastAnsweredDate > 0 and nLastAnsweredDate ~= today) then
    KsgTask:Set(self.nTaskIdQuestion, 0)
    KsgTask:Set(self.nTaskId_SelectedLanternIdx, 0)
  end

  if (nLastReceivedFlourDate > 0 and nLastReceivedFlourDate ~= today) then
    KsgTask:SetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_CanReceiveFlour, 0)
    KsgTask:SetByte(EventMidAutumn.nAwardTaskId, EventMidAutumn.nByte_Award_ReceivedFlourLastDate, 0)
  end
end

return EventMidAutumnLantern

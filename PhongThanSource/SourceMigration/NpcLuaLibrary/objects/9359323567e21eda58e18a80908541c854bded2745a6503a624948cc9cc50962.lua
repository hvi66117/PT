Include("script\\gvn\\events\\top_consumecoin\\event_topconsume_def.lua")

function EventTopConsume:IsActive()
  local nNow = today()

  return nNow >= self.nStartDate and nNow <= self.nEndDate
end

function EventTopConsume:CanJoin()
  if self.bSwitch ~= 1 then
    KsgPlayer:Msg("Sù kiÖn ®· t¹m ®ãng.", TALK)
    return nil
  end

  if not self:IsActive() then
    KsgNpc:Talk("Sù kiÖn nµy ®· hÕt h¹n, kh«ng thÓ tham gia!", 1)
    return nil
  end

  if KsgPlayer:GetLevel() < self.nRequireLevel then
    KsgPlayer:Msg(format("C¸c h¹ ch­a ®¹t cÊp %d, kh«ng thÓ tham gia sù kiÖn nµy!", self.nRequireLevel), TALK)
    return nil
  end

  if KsgTask:Get(self.nTaskId_Version) ~= self.nVersion then
    self:Clean()
    return nil
  end

  return 1
end

function EventTopConsume:CanGetAward()
  local nNow = today()

  return nNow <= self.nAwardDate
end

function EventTopConsume:Main()
  if not self:CanGetAward() then
    return KsgNpc:Talk("§· qu¸ thêi h¹n nhËn th­ëng hoÆc m¸y chñ nµy kh«ng diÔn ra ho¹t ®éng ®ua TOP Tiªu PhÝ.")
  end

  local nCoin  = KsgTask:Get(self.nCoin)
  local tbSay = {}
  tbSay[getn(tbSay) + 1] = { "NhËn th­ëng TOP", self.GetAwardRank, self }
  tbSay[getn(tbSay) + 1] = { "B¶ng xÕp h¹ng", self.Ranking, self }

  if self.bTest == 1 and KsgPlayer:IsGM() then
    tbSay[getn(tbSay) + 1] = { "[Test] Thªm ®iÓm tÝch lòy", self.SetCoinValue, self }
    tbSay[getn(tbSay) + 1] = { "[Test] Clear Task", self.Clean, self }
  end
  if nCoin > 0 then
    self:addSortList(GetName(), nCoin)
  end
  KsgNpc:Say("Quý kú sÜ muèn ta gióp g× nµo ? ", tbSay)
end

function EventTopConsume:GetAwardRank()
  if not self:CanGetAward() then
    return KsgNpc:Talk("§· qu¸ thêi h¹n nhËn th­ëng hoÆc m¸y chñ nµy kh«ng diÔn ra ho¹t ®éng ®ua TOP Tiªu PhÝ.")
  end

  local nCoin  = KsgTask:Get(self.nCoin)
  if nCoin < self.nRequireMinCoin then
    return KsgNpc:Talk("Muèn nhËn th­ëng ph¶i ®¹t tèi thiÓu 40.000 ®iÓm tÝch lòy")
  end
  
  local bIsInTopList
  local tbSay = {}
  for _, tbPlayer in pairs(self.tbPlayers_Top) do
    if KsgPlayer:GetName() == tbPlayer.szName then
      bIsInTopList = 1
      tbSay[getn(tbSay) + 1] = { format("NhËn phÇn th­ëng TOP %d Tiªu PhÝ", tbPlayer.nRank), self.GetAwardTop, self, tbPlayer.nAwardRank }
    end
  end

  if not bIsInTopList then
    return KsgNpc:Talk("Xin lçi, ngµi kh«ng cã trong danh s¸ch nhËn th­ëng.")
  end
  KsgNpc:Say(format("Quý kú sÜ muèn nhËn phÇn th­ëng nµo?<enter><color=red>(H¹n cuèi ®Ó nhËn th­ëng lµ %s)", KsgDate:ToString(self.nAwardDate)), tbSay)
end

function EventTopConsume:SetCoinValue(nValue)
  local nCoin  = KsgTask:Get(self.nCoin)
  if not nValue then
    return KsgNpc:AskNumber(format("HiÖn ®ang cã <c=g>%d<c> ®iÓm tÝch lòy, C¸c h¹ muèn thªm bao nhiªu ®iÓm n÷a?",nCoin ), self.SetCoinValue, { self, nValue })
  end
  KsgTask:Set(self.nCoin, nCoin + nValue)
end

function EventTopConsume:GetAwardTop(nAwardRank)
  if not self:CanGetAward() then
    return KsgNpc:Talk("§· qu¸ thêi h¹n nhËn th­ëng hoÆc m¸y chñ nµy kh«ng diÔn ra ho¹t ®éng ®ua TOP Tiªu PhÝ.")
  end

  local bIsInTopList
  local nRealRank = 0
  for _, tbPlayer in pairs(self.tbPlayers_Top) do
    if KsgPlayer:GetName() == tbPlayer.szName then
      bIsInTopList = 1
      nAwardRank = tbPlayer.nAwardRank
      nRealRank = tbPlayer.nRank
    end
  end
  if not bIsInTopList then
    return KsgNpc:Talk("Xin lçi, ngµi kh«ng cã trong danh s¸ch nhËn th­ëng.")
  end
  if KsgTask:GetByte(self.nTaskId_Award, self.BYTE_TOP_AWARD) == 1 then
    return KsgNpc:Talk("Xin lçi, ngµi ®· nhËn phÇn th­ëng nµy råi!")
  end
  if not self.tbTopCfg[nAwardRank] then
    return
  end
  if not KsgPlayer:HaveEnoughBagRoom(30) then
    return
  end
  local tbAwardCfg = self.tbTopCfg[nAwardRank]
  if KsgLib:PayMaterial(tbAwardCfg.tbConditions) then
    KsgAward:Give(tbAwardCfg.tbAwards, format("Get award top fight rank = %d", nAwardRank))
    KsgTask:SetByte(self.nTaskId_Award, self.BYTE_TOP_AWARD, 1)
    KsgNpc:Talk("Chóc mõng ngµi ®· nhËn th­ëng thµnh c«ng!")
    local szMsg = format("Chóc mõng <c=g>%s<c> tham gia sù kiÖn ®ua TOP Tiªu PhÝ <c=yel>®¹t h¹ng %d<c>. NhËn ®­îc phÇn th­ëng tõ LÔ Quan! ", KsgPlayer:GetName(), nRealRank)
    AddGlobalNews(szMsg, 3)
    Msg2SubWorld(szMsg)
  end

end

function EventTopConsume:Clean()
  if self.nVersion ~= KsgTask:Get(self.nTaskId_Version) then
    -- Reset task
    KsgTask:Set(self.nCoin, 0) -- Reset coin consume
    KsgTask:Set(self.nTaskId_Award, 0) -- Reset use count
  end
end

function EventTopConsume:OnServerStartup()
  if not self:IsActive() then
    return
  end

  local nSubWorldIdx = SubWorldID2Idx(21)
  if ( nSubWorldIdx == -1 ) then
    return
  end

  --local H,M,S = GetHMS()
  local sortDate = LoadIniInteger(self.Save_Section_Rank_Date,1)
  --local lastday = GetGlobalValue(self.nGlobalNum)

  if (sortDate == 0 or sortDate == nil) then
    self:freshSortList()
  end
end

function EventTopConsume:OnPlayerLogin()
  if KsgTask:Get(self.nTaskId_Version) ~= self.nVersion then
    self:Clean()
    KsgTask:Set(self.nTaskId_Version, self.nVersion)
  end
  if self:IsActive() then
    KsgPlayer:Msg(format("Sù kiÖn %s ®ang diÔn ra rÊt n¸o nhiÖt, h·y ®Õn LÔ Quan ë TriÒu Ca ®Ó t×m hiÓu thªm!", self.szName))
  end
end

function EventTopConsume:AddConsumeValue(nCount, szLog)
  -- LÊy ngµy th¸ng hiÖn t¹i
  local nCurYear, nCurMonth, nCurDay = GetYMD();
  local nCurDate = nCurYear * 10000 + nCurMonth * 100 + nCurDay;
  local nOldPoint = KsgTask:Get(self.nCoin)

  nCount = tonumber(nCount)
  if nCount < 0 then
    nCount = 0
  end

  if (nCurDate <= self.nEndDate) and (nOldPoint < self.nMaxCoin) then
    local nNewPoint = nOldPoint + nCount
    if(nNewPoint > EventTopConsume.nMaxCoin) then
      nNewPoint = EventTopConsume.nMaxCoin
    end
    KsgTask:Set(self.nCoin,nNewPoint)
    self:addSortList(GetName(), nNewPoint)

    local szExtraInfo = format("Add success %d Point, OldPoint %d , NewPoint %d", nCount, nOldPoint, nNewPoint)

    self:WriteLog(szExtraInfo, szLog)

    Msg2Player("[Sù kiÖn Tiªu PhÝ] B¹n nhËn ®­îc <c=green>" .. nCount .. "<c> ®iÓm tÝch lòy.HiÖn cã: <c=yellow>".. KsgTask:Get(self.nCoin) .. "<c> ®iÓm.");
   end
end

function EventTopConsume:WriteLog(szExtraInfo, szLogTitle)
  local szAccount = GetAccount() or ""
  local szName = GetName() or ""
  local nLevel = GetLevel() or 0
  local nPlayerType = GetPlayerType() or ""
  if szLogTitle then
    WriteLog(szLogTitle .. "\t" .. szAccount .. "\t"..szName.. "\t" ..nLevel..  "\t" ..nPlayerType.."\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. szExtraInfo, "ConsumeCoin")
  end
end

function EventTopConsume:Ranking()
  CloseDialog()
  if( getn(self.arySortList) <= 0 ) then
    self:loadSortList()
  end

  if ( getn(self.arySortList) <= 0 ) then
    KsgNpc:Talk("LÔ Quan: HiÖn t¹i ch­a cËp nhËt BXH, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!")
  else
    local message = ""
    local count = 0

    for i = 1, 10 do
      if ( self.arySortList[i].name == "" ) then
        break
      end
      count = count + 1
    end

    for i=1, 5 do
      if ( self.arySortList[i].name == "" ) then
        break
      end
      local rankSec = self.arySortList[i].score
      local rankName = self.arySortList[i].name
      message = message.."H¹ng "..i.." <c=g>"..rankName.."<c> "..rankSec.." ®iÓm\n"
    end

    if ( message == "" ) then
      message = "LÔ Quan: HiÖn t¹i ch­a cËp nhËt BXH, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!"
    end

    if( count <= 5 ) then
      KsgNpc:Talk(message)
    else
      Talk(1,"changetopfive",message)
    end
  end
end

function changetopfive()
  CloseDialog()
  EventTopConsume:lastFiveRanking()
end

function EventTopConsume:lastFiveRanking()
  CloseDialog()
  local message = ""
  for i=6,10 do
    if ( self.arySortList[i].name == "" ) then
      break
    end

    local rankSec = self.arySortList[i].score
    local rankName = self.arySortList[i].name

    message = message.."H¹ng "..i.." <c=g>"..rankName.."<c> "..rankSec.." ®iÓm\n"
  end
  KsgNpc:Talk(message)
end

function EventTopConsume:loadSortList()
  local saveDate = LoadIniInteger(self.Save_Section_Rank_Date,1)

  for i = 1, 10 do
    self.arySortList[i] = { name = "", score = 0 }
  end

  local topName = {}
  local topSec = {}

  if ( saveDate ~= nil ) and ( saveDate ~= 0 ) then
    for i=1,getn(self.arySortList),1 do
      topName[i] = LoadIniString( self.Save_Section_Rank_Name, i )
      topSec[i] = LoadIniInteger( self.Save_Section_Rank_Score, i )
      self.arySortList[i] = { name = topName[i], score = topSec[i] }
    end
  end
end

function EventTopConsume:freshSortList()

  for i = 1, 10 do
    self.arySortList[i] = { name = "", score = 0 }
  end

  local nDate = 0
  nDate = floor(LocalSystemTime() / 86400)
  SaveIniInteger(self.Save_Section_Rank_Date, 1, nDate)
  --SetGlobalValue(self.nGlobalNum,nDate)

  for i=1,getn(self.arySortList),1 do
    SaveIniString(self.Save_Section_Rank_Name,i,self.arySortList[i].name)
    SaveIniInteger(self.Save_Section_Rank_Score,i,self.arySortList[i].score)
  end
end

function EventTopConsume:addSortList(Name, Score)

  if( getn(self.arySortList) <= 0 ) then
    self:loadSortList()
  end

  local isInList = 0
  isInList = self:isInSortList(Name,Score)

  local equal_mark = 0

  for i=getn(self.arySortList), 1, -1 do

    if( isInList == 0 ) then
      if ( self.arySortList[i].score < Score ) or ( self.arySortList[i].name == "" ) then
        if ( i < 10 ) then
          self.arySortList[i + 1].score = self.arySortList[i].score
          self.arySortList[i + 1].name = self.arySortList[i].name
        end

        if ( i == 1 ) then
          self.arySortList[i].score = Score
          self.arySortList[i].name = Name
        end
      else
        if ( i < 10 ) then
          self.arySortList[i + 1].score = Score
          self.arySortList[i + 1].name = Name
          break

        elseif ( i == 10 ) and ( self.arySortList[i].score >= Score ) and ( self.arySortList[i].name ~= "" ) then
          break
        end
      end
    else
      if ( self.arySortList[i].score <= Score ) then
        if( equal_mark == 1 ) then
          if ( i < 10 ) then
            if( self.arySortList[i].score < Score ) then
              self.arySortList[i + 1].score = self.arySortList[i].score
              self.arySortList[i + 1].name = self.arySortList[i].name
            else
              self.arySortList[i + 1].score = Score
              self.arySortList[i + 1].name = Name
              break
            end
          end
        end

        if( self.arySortList[i].name == Name ) then
          equal_mark = 1
        end

        if ( i == 1 ) then
          self.arySortList[i].score = Score
          self.arySortList[i].name = Name
        end
      else
        if ( i < 10 ) then
          self.arySortList[i + 1].score = Score
          self.arySortList[i + 1].name = Name
          break

        elseif ( i == 10 ) and ( self.arySortList[i].score >= Score ) and ( self.arySortList[i].name ~= "" ) then
          break
        end
      end
    end
  end
  self:saveSortList()
end

function EventTopConsume:isInSortList(Name,Score)
  if ( getn(self.arySortList) <= 0 ) then
    return 0
  end

  for i=getn(self.arySortList), 1, -1 do
    if( Name == self.arySortList[i].name ) then
      return 1
    end
  end

  return 0
end

function EventTopConsume:saveSortList()
  for i=1,getn(self.arySortList),1 do
    SaveIniString(self.Save_Section_Rank_Name,i,self.arySortList[i].name)
    SaveIniInteger(self.Save_Section_Rank_Score,i,self.arySortList[i].score)
  end
end


module("FOURBOSS", package.seeall)
require("common.luax")

TableCallFourBoss = {
  [1] = { BossName = "Ma LÔ Thanh", BossID = 2173, BossLevel = 60, },
  [2] = { BossName = "Ma LÔ H¶i", BossID = 2174, BossLevel = 90, },
  [3] = { BossName = "Ma LÔ Hång", BossID = 2175, BossLevel = 120, },
  [4] = { BossName = "Ma LÔ Thä", BossID = 2176, BossLevel = 150, },
}

TableCallBossList = {
  [1] = { ID = 87, Name = "Cïng Kú", ScriptName = "ÇîÆæ", GlobalID = 15, GlobalByte = 1, Percent = 1250, },
  [2] = { ID = 88, Name = "§µo Ngét", ScriptName = "—ƒè»", GlobalID = 15, GlobalByte = 1, Percent = 1250, },
  [3] = { ID = 89, Name = "Thao ThiÕt", ScriptName = "÷Ò÷Ñ", GlobalID = 15, GlobalByte = 1, Percent = 1250, },
  [4] = { ID = 90, Name = "Hçn §én", ScriptName = "»ìãç", GlobalID = 15, GlobalByte = 1, Percent = 1250, },

  [5] = { ID = 82, Name = "Bµn Cæ", ScriptName = "ÅÌ¹Å", GlobalID = 15, GlobalByte = 2, Percent = 3400, },
  [6] = { ID = 85, Name = "§¹i §iªu", ScriptName = "´óÅô", GlobalID = 15, GlobalByte = 2, Percent = 3400, },
  [7] = { ID = 96, Name = "D­¬ng TiÔn", ScriptName = "Ñîê¯", GlobalID = 15, GlobalByte = 2, Percent = 3400, },

  [8] = { ID = 97, Name = "Giao Long", ScriptName = "òÔÁú", GlobalID = 15, GlobalByte = 3, Percent = 2000, },
  [9] = { ID = 98, Name = "Ly Long", ScriptName = "ó¤Áú", GlobalID = 15, GlobalByte = 3, Percent = 2000, },
  [10] = { ID = 99, Name = "CÇu Long", ScriptName = "ò°Áú", GlobalID = 15, GlobalByte = 3, Percent = 2000, },

  [11] = { ID = 1288, Name = "VÞ Thæ TrÜ", ScriptName = "Î¸ÍÁïô", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [12] = { ID = 1289, Name = "§Ó Thæ H¹c", ScriptName = "ØµÍÁºÑ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [13] = { ID = 1290, Name = "LiÔu Thæ Ch­¬ng", ScriptName = "ÁøÍÁâ¯", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [14] = { ID = 1291, Name = "N÷ Thæ Bøc", ScriptName = "Å®ÍÁòð", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [15] = { ID = 1292, Name = "ChÈn Thñy DÉn", ScriptName = "éôË®ò¾", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [16] = { ID = 1293, Name = "BÝch Thuû Du", ScriptName = "±ÚË®òõ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [17] = { ID = 1294, Name = "To¸n Thñy B¸o", ScriptName = "»þË®±ª", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [18] = { ID = 1295, Name = "S©m Thñy Viªn", ScriptName = "²ÎË®Ô³", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [19] = { ID = 1296, Name = "Tuy Háa HÇu", ScriptName = "õþ»ðºï", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [20] = { ID = 1297, Name = "ThÊt Háa Tr­", ScriptName = "ÊÒ»ðÖí", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [21] = { ID = 1298, Name = "Dùc Háa Xµ", ScriptName = "Òí»ðÉß", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [22] = { ID = 1299, Name = "VÜ Háa Hæ", ScriptName = "Î²»ð»¢", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [23] = { ID = 1300, Name = "§Êu Méc Tr·i", ScriptName = "¶·Ä¾õô", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [24] = { ID = 1301, Name = "Gi¸c Méc Giao", ScriptName = "½ÇÄ¾òÔ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [25] = { ID = 1302, Name = "TÜnh Méc Ng¹n", ScriptName = "¾®Ä¾áí", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [26] = { ID = 1303, Name = "Khuª Méc Lang", Name = "¿üÄ¾ÀÇ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [27] = { ID = 1305, Name = "Tinh NhËt M·", ScriptName = "ÐÇÈÕÂí", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [28] = { ID = 1306, Name = "M·o NhËt Kª", ScriptName = "êÄÈÕ¼¦", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [29] = { ID = 1307, Name = "H­ NhËt Thö", ScriptName = "ÐéÈÕÊó", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [30] = { ID = 1308, Name = "Phßng NhËt Thè", ScriptName = "·¿ÈÕÍÃ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [31] = { ID = 1310, Name = "Nguy NguyÖt YÕn", ScriptName = "Î£ÔÂÑà", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [32] = { ID = 1311, Name = "Hoa NguyÖt ¤", ScriptName = "±ÏÔÂÎÚ", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [33] = { ID = 1312, Name = "Tr­¬ng NguyÖt Léc", ScriptName = "ÕÅÔÂÂ¹", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [34] = { ID = 1313, Name = "T©m NguyÖt Hå", ScriptName = "ÐÄÔÂºü", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [35] = { ID = 1314, Name = "Quû Kim D­¬ng", ScriptName = "¹í½ðÑò", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [36] = { ID = 1315, Name = "Kh¸ng Kim Long", ScriptName = "¿º½ðÁú", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [37] = { ID = 1316, Name = "L©u Kim CÈu", ScriptName = "Â¦½ð¹·", GlobalID = 15, GlobalByte = 4, Percent = 500, },
  [38] = { ID = 1317, Name = "Ng­u Kim Ng­u", ScriptName = "Å£½ðÅ£", GlobalID = 15, GlobalByte = 4, Percent = 500, },
}
GlobalWorldTaskFourBoss = 16
GlobalTableBossValue = {
  [1] = { mapid = 0, xpos = 0, ypos = 0 },
  [2] = { mapid = 0, xpos = 0, ypos = 0 },
  [3] = { mapid = 0, xpos = 0, ypos = 0 },
  [4] = { mapid = 0, xpos = 0, ypos = 0 },
}

function WorldBossDeath (nIndex)
  local nBossTemplateID = GetNpcTemplateID(nIndex)
  local nMapId, nPosX, nPosY = GetNpcWorldPos(nIndex)

  local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
  if (GetGlobalStoreValueByte(GlobalWorldTaskFourBoss, 4) ~= nToday) then
    SetGlobalStoreValue(TableCallBossList[1].GlobalID, 0, 1)
    SetGlobalStoreValueByte(GlobalWorldTaskFourBoss, 1, 0, 1)
    SetGlobalStoreValueByte(GlobalWorldTaskFourBoss, 4, nToday, 1)
  end

  for i = 1, #TableCallBossList do
    if (nBossTemplateID == TableCallBossList[i].ID) then
      local nGlobalTimes = GetGlobalStoreValueByte(TableCallBossList[1].GlobalID, TableCallBossList[i].GlobalByte) + 1
      if (nGlobalTimes >= 200) then
        WriteLog("[Ma Gia Tø T­íng triÖu håi BOSS][§· triÖu gäi][" .. nGlobalTimes .. "]")
        return
      end
      local nPercent = nGlobalTimes * TableCallBossList[i].Percent
      local nRandom = math.random(1, 10000)
      if (nRandom <= nPercent) then
        local nBossID = GetGlobalStoreValueByte(GlobalWorldTaskFourBoss, 1) + 1
        SetGlobalStoreValueByte(GlobalWorldTaskFourBoss, 1, nBossID, 1)
        if (nBossID < 1 or nBossID > 4) then
          WriteLog("BossID kh«ng ®óng")
          return
        end
        GlobalTableBossValue[nBossID].mapid = nMapId
        GlobalTableBossValue[nBossID].xpos = nPosX
        GlobalTableBossValue[nBossID].ypos = nPosY
        SetGlobalStoreValueByte(TableCallBossList[i].GlobalID, TableCallBossList[i].GlobalByte, 200, 1)
        local str = "\\script\\npcdeath\\" .. TableCallBossList[i].ScriptName .. ".lua"
        AddGlobalTimer(str, "CallBossTable", 30, 30, nBossID)
        AddGlobalNews("Mét luång khÝ ma quû bÝ Èn xuÊt hiÖn, Ma Gia Tø T­îng trong truyÒn thuyÕt s¾p xuÊt hiÖn t¹i " .. COMMON.GetMapNameByID(nMapId) .. "[" .. math.ceil(nPosX / 8) .. "," .. math.ceil(nPosY / 16) .. "]!")
        Msg2CurMapAnnounceEx(nMapId, "Mét luång khÝ ma quû bÝ Èn xuÊt hiÖn, Ma Gia Tø T­îng trong truyÒn thuyÕt s¾p xuÊt hiÖn t¹i " .. COMMON.GetMapNameByID(nMapId) .. "[" .. math.ceil(nPosX / 8) .. "," .. math.ceil(nPosY / 16) .. "]!")
        WriteLog("[Ma Gia Tø T­íng triÖu håi BOSS][TriÖu håi thµnh c«ng][" .. TableCallBossList[i].Name .. "][Random = " .. nRandom .. "][Tèi ®a " .. nPercent .. "]")
      else
        WriteLog("[Ma Gia Tø T­íng triÖu håi BOSS][ÕÙ»½Ê§°Ü][" .. TableCallBossList[i].Name .. "][Random = " .. nRandom .. "][Tèi ®a " .. nPercent .. "]")
        SetGlobalStoreValueByte(TableCallBossList[1].GlobalID, TableCallBossList[i].GlobalByte, nGlobalTimes + 1)
      end
      break
    end
  end
end

function CallBossTable(TimerIdx, LeftTime, nBossID)
  if (LeftTime <= 0) then
    DelGlobalTimer(TimerIdx)
  end
  if (nBossID < 1 or nBossID > 4) then
    WriteLog("BossID kh«ng ®óng")
    return
  end

  local nNpcIdx = AddNpc(TableCallFourBoss[nBossID].BossID, TableCallFourBoss[nBossID].BossLevel,
      SubWorldID2Idx(GlobalTableBossValue[nBossID].mapid), GlobalTableBossValue[nBossID].xpos * 32, GlobalTableBossValue[nBossID].ypos * 32)
  if (nNpcIdx > 0) then
    AddGlobalNews("T­¬ng truyÒn " .. TableCallFourBoss[nBossID].BossName .. " xuÊt hiÖn t¹i " .. COMMON.GetMapNameByID(GlobalTableBossValue[nBossID].mapid) .. "[" .. math.ceil(GlobalTableBossValue[nBossID].xpos / 8) .. "," .. math.ceil(GlobalTableBossValue[nBossID].ypos / 16) .. "], Tam Giíi l¹i s¾p gÆp mét trËn hµo kiÕp!!")
    Msg2CurMapAnnounceEx(GlobalTableBossValue[nBossID].mapid, "T­¬ng truyÒn " .. TableCallFourBoss[nBossID].BossName .. " xuÊt hiÖn t¹i " .. COMMON.GetMapNameByID(GlobalTableBossValue[nBossID].mapid) .. "[" .. math.ceil(GlobalTableBossValue[nBossID].xpos / 8) .. "," .. math.ceil(GlobalTableBossValue[nBossID].ypos / 16) .. "], Tam Giíi l¹i s¾p gÆp mét trËn hµo kiÕp!!")
    SetNpcTimer(nNpcIdx, "\\script\\ontimer\\Ä§¼ÒËÄ½«ÌÓÅÜ.lua", 1800)
  end
end

function OnBossRun(nIndex)
  if (nIndex < 0) then
    return
  end
  local nTempID = GetNpcTemplateID(nIndex)

  for i = 1, table.getn(TableCallFourBoss) do
    if (nTempID == TableCallFourBoss[i].BossID) then
      AddGlobalCountNews(TableCallFourBoss[i].BossName .. " cïng c¸c vÞ anh hïng ®¹i chiÕn 1 trËn, bÊt ph©n th¾ng b¹i, ngang nhiªn rêi ®i!", 1)
      local p = GetFirstPlayerInAll()
      if (p > 0) then
        local nTemp = _G.PlayerIndex
        _G.PlayerIndex = p
        WriteLog("[Ma Gia Tø T­íng triÖu håi BOSS][Bá ch¹y][" .. TableCallFourBoss[i].BossName .. "]")
        _G.PlayerIndex = nTemp
      end
      break
    end
  end
end

function OnBossDeath(nIndex)
  if (nIndex < 0) then
    return
  end
  local nTempID = GetNpcTemplateID(nIndex)
  for i = 1, table.getn(TableCallFourBoss) do
    if (nTempID == TableCallFourBoss[i].BossID) then
      AddGlobalCountNews(TableCallFourBoss[i].BossName .. " bÞ c¸c vÞ anh hïng ®¸nh b¹i, ®Ó l¹i mét l­îng lín b¶o vËt!!", 1)
      if (_G.PlayerIndex > 0) then
        Msg2CurMapAnnounce(TableCallFourBoss[i].BossName .. " bÞ c¸c vÞ anh hïng ®¸nh b¹i, ®Ó l¹i mét l­îng lín b¶o vËt!!")
      end
      WriteLog("[Ma Gia Tø T­íng triÖu håi BOSS][Tö vong][" .. TableCallFourBoss[i].BossName .. "]")
      break
    end
  end
end

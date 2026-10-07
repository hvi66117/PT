Include("\\script\\gvn\\lib.lua")

EventTopConsume = EventTopConsume or {}

local self = EventTopConsume

EventTopConsume.szName = "ßua Top Ti™u Ph›"
EventTopConsume.nVersion = 2
EventTopConsume.bSwitch = 1
EventTopConsume.bTest = 0
EventTopConsume.nRequireLevel = 20
EventTopConsume.nRequireMinCoin = 40000
EventTopConsume.nMaxCoin = 10000000

EventTopConsume.nStartDate = 20221022
EventTopConsume.nEndDate = 20221130
EventTopConsume.nAwardDate = 20221210

EventTopConsume.Save_Section_Rank_Date = "Save_Consume_Ranking_Data"
EventTopConsume.Save_Section_Rank_Score = "Save_Consume_Ranking_Score"
EventTopConsume.Save_Section_Rank_Name = "Save_Consume_Ranking_Name"

--EventTopConsume.nGlobalNum = 2099
EventTopConsume.nTaskId_Version = KsgTask.tbIds.TopConsume_Version
EventTopConsume.nCoin = KsgTask.tbIds.TopConsume_Coin
EventTopConsume.nTaskId_Award = KsgTask.tbIds.TopConsume_Award
EventTopConsume.BYTE_TOP_AWARD = 1

if KsgServer:CurrentId() == KsgServer.tbIds.Khai_Minh_Dien then
 EventTopConsume.tbPlayers_Top = {
    { szName = "DonaldïTrump", nRank = 1, nAwardRank = 1, },
    { szName = "ßπiTi’u", nRank = 2, nAwardRank = 2, },
    { szName = "Ph≠ÌcïThﬁnh", nRank = 3, nAwardRank = 3, },
    { szName = "H˚Tinh", nRank = 4, nAwardRank = 4, },
    { szName = "∞ïJennieï∞", nRank = 5, nAwardRank = 4, },
    { szName = "ùS∏tïT©mïQuanï¢m", nRank = 6, nAwardRank = 4, },
    { szName = "ßπiïT»u", nRank = 7, nAwardRank = 4, },
    { szName = "Si™uïßÈïXeïL≠¨ng", nRank = 8, nAwardRank = 4, },
    { szName = "ùïAnïNhi™nïù", nRank = 9, nAwardRank = 4, },
  }
end

if KsgServer:CurrentId() == KsgServer.tbIds.Kim_Quang_Dien then
  EventTopConsume.tbPlayers_Top = {
    --{ szName = "ùV÷ïTrangù", nRank = 1, nAwardRank = 1, },
  }
end

EventTopConsume.arySortList = {}

EventTopConsume.tbTopCfg = {
  [1] = {
    tbConditions = {
      nLevel = 20
    },
    tbAwards = {
      { fn = KsgAward.GiveAwardTitleVIPTopConsume, tbParam = { KsgAward } },
      --{ fn = KsgAward.Give120Weapon, tbParam = { KsgAward, 10 } },
      --{ fn = KsgAward.Give120Horse, tbParam = { KsgAward, 10 } },
      { fn = KsgAward.GiveTienMaWeapon6X, tbParam = { KsgAward, 10 } },
      { tbProp = { 3, 401, 0, 0 }, nAmount = 2, szName = "Kim § Qu∏i PhÔ (ch≠a mµi)" },
      { tbProp = { 6, 1, 5954, 1 }, nAmount = 30, szName = "TÛi ThuÈc T›nh" },
    }
  },
  [2] = {
    tbConditions = {
      nLevel = 20
    },
    tbAwards = {
      --{ fn = KsgAward.Give120Horse, tbParam = { KsgAward, 10 } },
      --{ tbProp = { 3, 1196, 0, 0 }, nAmount = 50, szName = "M∂nh VÚ Kh› Hi’m" },
      { fn = KsgAward.GiveTienMaWeapon6X, tbParam = { KsgAward, 10 } },
     -- { tbProp = { 3, 1196, 0, 0 }, nAmount = 50, szName = "M∂nh VÚ Kh› Hi’m" },
      { tbProp = { 3, 401, 0, 0 }, nAmount = 2, szName = "Kim § Qu∏i PhÔ (ch≠a mµi)" },
      { tbProp = { 6, 1, 5954, 1 }, nAmount = 20, szName = "TÛi ThuÈc T›nh" },
    }
  },
  [3] = {
    tbConditions = {
      nLevel = 20
    },
    tbAwards = {
      --{ tbProp = { 6, 1, 1190, 1 }, nAmount = 150, szName = "M∂nh Quang VÚ Chi D˘c" },
      --{ tbProp = { 3, 1196, 0, 0 }, nAmount = 30, szName = "M∂nh VÚ Kh› Hi’m" },
      --{ tbProp = { 3, 1196, 0, 0 }, nAmount = 50, szName = "M∂nh VÚ Kh› Hi’m" },
      --{ tbProp = { 3, 1196, 0, 0 }, nAmount = 50, szName = "M∂nh VÚ Kh› Hi’m" },
      { fn = KsgAward.GiveTienMaWeapon6X, tbParam = { KsgAward, 10 } },
      { tbProp = { 3, 401, 0, 0 }, nAmount = 1, szName = "Kim § Qu∏i PhÔ (ch≠a mµi)" },
      { tbProp = { 6, 1, 5954, 1 }, nAmount = 15, szName = "TÛi ThuÈc T›nh" },
    }
  },
  [4] = {
    tbConditions = {
      nLevel = 20
    },
    tbAwards = {
      --{ tbProp = { 6, 1, 1190, 1 }, nAmount = 50, szName = "M∂nh Quang VÚ Chi D˘c" },
      { tbProp = { 3, 477, 0, 0 }, nAmount = 50, szName = "B›ch Lπc" },
      { tbProp = { 3, 478, 0, 0 }, nAmount = 30, szName = "Hoµng Tuy“n" },
      { tbProp = { 3, 392, 0, 0 }, nAmount = 3, szName = "Nguy÷t Hoa Qu∏i PhÔ (ch≠a mµi)" },
      { tbProp = { 6, 1, 5954, 1 }, nAmount = 10, szName = "TÛi ThuÈc T›nh" },
    }
  },
}


require("king/lib.luax")
EventMidAutumn = EventMidAutumn or {}

local self = EventMidAutumn

EventMidAutumn.szName = "Trung Thu §oµn Viªn"
EventMidAutumn.nVersion = 1
EventMidAutumn.bOpen = true
EventMidAutumn.bTest = false
EventMidAutumn.bPromotionNewServer = false

EventMidAutumn.nStartDate = 20220822
EventMidAutumn.nEndDate = 20220912

EventMidAutumn.nAwardTaskId = 1737
EventMidAutumn.nByte_Award_CanReceiveFlour = 1
EventMidAutumn.nByte_Award_ReceivedFlourLastDate = 2
EventMidAutumn.nByte_Award_CanUseBlessingCoin = 3
EventMidAutumn.nByte_Award_UsedBlessingCoinLastDate = 4
EventMidAutumn.nMaxUseCoinPerDay = 100

EventMidAutumn.nGlobalTaskId_NpcNum = 375
EventMidAutumn.nGlobalByte_LanternCnt = 1
EventMidAutumn.nGlobalByte_RabbitCnt = 2
EventMidAutumn.nGlobalByte_LanternSeq = 3

EventMidAutumn.nRequireLevel = 25 -- Level required to join the event

EventMidAutumn.tbDropMaterialCfg = {
  nDropNum = 1,
  nRate = 0.15,
  nMinNpcLevel = 25,
  bTeam = true,
  tbBox = { -- Event box drop when npc death
    szName = "Tói nguyªn liÖu", tbProp = { 6, 1, 5903, 1 },
  },
  tbMaterials = { -- List materials in event box
    { szName = "Bét m×", tbProp = { 3, 1129, 0, 0 }, nRate = 60 },
    { szName = "§­êng", tbProp = { 3, 1130, 0, 0 }, nRate = 40 },
  },
}

EventMidAutumn.nTaskId_Version = KsgTask.tbIds.EventMidAutumn_Version

EventMidAutumn.tbExpTypeCfg = {
  nTaskId = KsgTask.tbIds.EventMidAutumn_ExpType,
  nTaskBit = 1,
  NHAN_GIOI = 0,
  TIEN_MA = 1,
}

-- Only support pay type = nMoney and nCopperCash
EventMidAutumn.tbShops = {
  [1] = {
    szName = "Nh©n b¸nh",
    tbItems = {
      { szName = "Tr¸i C©y", tbProp = { 3, 1131, 0, 0 }, tbConditions = { nMoney = 25 } }, -- v¹n
      { szName = "§Ëu", tbProp = { 3, 1133, 0, 0 }, tbConditions = { nMoney = 50 } }, -- v¹n
    }
  },
}

EventMidAutumn.tbMoonCakes = {
  [1] = {
    szName = "B¸nh Trung Thu tr¸i c©y",
    tbProp = { 6, 1, 5904, 1 },
    tbConditions = {
      tbItems = {
        { tbProp = { 3, 1129, 0, 0 }, nAmount = 1, szName = "Bét m×" },
        { tbProp = { 3, 1130, 0, 0 }, nAmount = 1, szName = "§­êng" },
        { tbProp = { 3, 1131, 0, 0 }, nAmount = 1, szName = "Tr¸i c©y" },
      }
    },
  },
  [2] = {
    szName = "B¸nh Trung Thu nh©n ®Ëu",
    tbProp = { 6, 1, 5905, 1 },
    tbConditions = {
      tbItems = {
        { tbProp = { 3, 1129, 0, 0 }, nAmount = 1, szName = "Bét m×" },
        { tbProp = { 3, 1130, 0, 0 }, nAmount = 1, szName = "§­êng" },
        { tbProp = { 3, 1133, 0, 0 }, nAmount = 1, szName = "§Ëu" },
      }
    },
  },
  [3] = {
    szName = "B¸nh Trung Thu h¹t sen",
    tbProp = { 6, 1, 5906, 1 },
    tbConditions = {
      tbItems = {
        { tbProp = { 3, 1129, 0, 0 }, nAmount = 1, szName = "Bét m×" },
        { tbProp = { 3, 1130, 0, 0 }, nAmount = 1, szName = "§­êng" },
        { tbProp = { 3, 1132, 0, 0 }, nAmount = 1, szName = "H¹t sen" },
      }
    },
  },
}

EventMidAutumn.tbAwardAccumulate_1 = {
  {
    nRequireUse = 1000,
    tbAwards = {
      [1] = {
        { szName = "ThÎ Kim DËt", tbProp = { 8, 1316, 6, 1 } },
        { szName = "Ngäc Thanh T¸n", tbProp = { 8, 375, 0, 0 } },
        { szName = "T­íng Qu©n LÖnh", tbProp = { 3, 100, 0, 0 }, },
      },
      [2] = {
        { nGreenItem = 1, nRandom = 1, nLevel = 6, nRate = 20 }, -- Trang bÞ lôc 6x
        { nGreenItem = 1, nRandom = 1, nLevel = 8, nRate = 10 }, -- Trang bÞ lôc 8x
        { tbProp = { 3, 1133, 0, 0 }, szName = "§Ëu", nAmount = 10, nRate = 50 },
        { tbProp = { 3, 1132, 0, 0 }, szName = "H¹t sen", nAmount = 10, nRate = 20 },
      },
    }
  }
}

EventMidAutumn.tbAwardAccumulate_2 = {
  { nRequireUse = 3000,
    tbAwards = {
      [1] = {
        { szName = "ThÎ Kim DËt", tbProp = { 8, 1316, 6, 1 } },
        { szName = "Ngäc Thanh T¸n", tbProp = { 8, 375, 0, 0 } },
        { szName = "T­íng Qu©n LÖnh", tbProp = { 3, 100, 0, 0 }, nAmount = 10 },
      },
      [2] = {
        { nGreenItem = 1, nRandom = 1, nLevel = 6, nRate = 10 }, -- Trang bÞ lôc 6x
        { nGreenItem = 1, nRandom = 1, nLevel = 8, nRate = 7 }, -- Trang bÞ lôc 8x

        { szName = "§¶ ThÇn Tiªn", tbProp = { 0, 0, 4, 7 }, nRate = 1 },
        { szName = "§iÓm T­íng KÝch", tbProp = { 0, 0, 5, 7 }, nRate = 1 },
        { szName = "Cù KhuyÕt KiÕm", tbProp = { 0, 0, 6, 7 }, nRate = 1 },
        { szName = "Tô Tiªn Phñ", tbProp = { 0, 0, 7, 7 }, nRate = 1 },

        { szName = "V¹n KiÕp", tbProp = { 0, 0, 13, 7 }, nRate = 0.25 },
        { szName = "B¹ch §iÓu", tbProp = { 0, 0, 16, 7 }, nRate = 0.25 },
        { szName = "Nh©n Gian", tbProp = { 0, 0, 19, 7 }, nRate = 0.25 },
        { szName = "NguyÖt ¶nh", tbProp = { 0, 0, 22, 7 }, nRate = 0.25 },

        { szName = "ChÝ L©n", tbProp = { 0, 10, 24, 7 }, nRate = 1 },
        { szName = "ChÝ Ph­îng", tbProp = { 0, 10, 25, 7 }, nRate = 1 },
        { szName = "ChÝ §iÖp", tbProp = { 0, 10, 26, 7 }, nRate = 1 },

        { szName = "LÔ bao ChÝ T«n", tbProp = { 8, 289, 2, 0 }, nRate = 50 },
        { szName = "§ång Nh©n", tbProp = { 8, 227, 2, 0 }, nRate = 25 },
      },
    }
  }
}

EventMidAutumn.tbAwardAccumulate_3 = {
  { nRequireUse = 500,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 50 },
        { szName = "§ång Nh©n", tbProp = { 8, 227, 2, 0 } },
        { szName = "Tö Thñy Tinh", tbProp = { 3, 1150, 0, 0 } },
      },
      [2] = {
        { nGreenItem = 1, nRandom = 1, nLevel = 10, nRate = 45 }, -- Trang bÞ lôc 10x
        { szName = "Thanh Minh L­¬ng Ngäc (Ch­a mµi)", tbProp = { 3, 262, 0, 0 }, nRate = 15 },
        { szName = "XÝch Viªm L­¬ng Ngäc (Ch­a mµi)", tbProp = { 3, 255, 0, 0 }, nRate = 20 },
        { szName = "Tö Hµ L­¬ng Ngäc (Ch­a mµi)", tbProp = { 3, 269, 0, 0 }, nRate = 20 },
      }
    },
  },
  { nRequireUse = 1000,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 100 },
        { szName = "Tinh Th¹ch Trung CÊp", tbProp = { 8, 507, 2, 0, } },
        { szName = "Hoµng B¶o Th¹ch", tbProp = { 3, 90, 0, 0 } },
      },
      [2] = {
        { szName = "Trôc NhËt KiÕm", tbProp = { 0, 0, 4, 9 }, nRate = 10 },
        { szName = "Khai Thiªn Phñ", tbProp = { 0, 0, 5, 9 }, nRate = 10 },
        { szName = "Kim Quang KiÕm", tbProp = { 0, 0, 6, 9 }, nRate = 10 },
        { szName = "Hçn Thiªn Phñ", tbProp = { 0, 0, 7, 9 }, nRate = 10 },
        { szName = "Trang bÞ Tinh Hån-Cao", tbProp = { 8, 1951, 2, 0 }, nRate = 60 },
      }
    },
  },
  { nRequireUse = 1500,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 150 },
        { szName = "Lôc B¶o Th¹ch", tbProp = { 3, 250, 0, 0 } },
        { szName = "Lß LuyÖn Tr©n Hùu", tbProp = { 8, 753, 2, 0 } },
      },
      [2] = {
        { szName = "ChÝ T«n", tbProp = { 0, 0, 15, 8 }, nRate = 6 },
        { szName = "Phiªu MiÓu", tbProp = { 0, 0, 18, 8 }, nRate = 6 },
        { szName = "Tam Giíi", tbProp = { 0, 0, 21, 8 }, nRate = 6 },
        { szName = "§a T×nh", tbProp = { 0, 0, 24, 8 }, nRate = 6 },

        { szName = "XÝch Viªm Danh Ngäc (Ch­a mµi)", tbProp = { 3, 256, 0, 0 }, nRate = 8 },
        { szName = "Thanh Minh Danh Ngäc (Ch­a mµi)", tbProp = { 3, 263, 0, 0 }, nRate = 9 },
        { szName = "Tö Hµ Danh Ngäc (Ch­a mµi)", tbProp = { 3, 270, 0, 0 }, nRate = 9 },

        { nGreenItem = 1, nRandom = 1, nLevel = 10, nRate = 50 }, -- Trang bÞ lôc 10x
      },
      [3] = {
        { szName = "XÝch Viªm Ngäc Tinh (Ch­a mµi)", tbProp = { 3, 257, 0, 0 }, nRate = 5 },
        { szName = "Thanh Minh Ngäc Tinh (Ch­a mµi)", tbProp = { 3, 264, 0, 0 }, nRate = 5 },
        { szName = "Tö Hµ Ngäc Tinh (Ch­a mµi)", tbProp = { 3, 271, 0, 0 }, nRate = 5 },

        { szName = "KhÝ Nguyªn Cao CÊp", tbProp = { 8, 283, 2, 0 }, nRate = 42.5 },
        { szName = "Trang Nguyªn Cao CÊp", tbProp = { 8, 284, 2, 0 }, nRate = 42.5 },
      },
    },
  },
  { nRequireUse = 2000,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 200 },
        { szName = "M¶nh Vò KhÝ HiÕm", tbProp = { 3, 1201, 0, 0, }, nAmount = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn ®¹t mèc phÇn th­ëng, nhËn ®­îc %d %s!!!" },
        { szName = "Tö B¶o Th¹ch", tbProp = { 3, 1151, 0, 0 } },
        { szName = "Quy Nguyªn KÝnh", tbProp = { 8, 1952, 5, 0 } },
        { szName = "Thanh Minh Danh Ngäc (Ch­a mµi)", tbProp = { 3, 263, 0, 0 } },
      },
      [2] = {
        { szName = "Viªm §Õ KiÕm", tbProp = { 0, 0, 4, 10 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "Tr¹m Kim Phñ", tbProp = { 0, 0, 5, 10 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "Th¸i Cùc KiÕm", tbProp = { 0, 0, 6, 10 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "DiÖt ThÇn Phñ", tbProp = { 0, 0, 7, 10 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },

        { szName = "Tinh chÕ HuyÒn S¾c Thñy Ng©n", tbProp = { 8, 1346, 2, 0 }, nRate = 45 },
        { szName = "Tinh th¹ch cao cÊp", tbProp = { 8, 508, 2, 0 }, nRate = 35 },
      },
      [3] = {
        { szName = "XÝch Viªm Ngäc T©m (Ch­a mµi)", tbProp = { 3, 258, 0, 0 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "Thanh Minh Ngäc T©m (Ch­a mµi)", tbProp = { 3, 265, 0, 0 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "Tö Hµ Ngäc T©m (Ch­a mµi)", tbProp = { 3, 272, 0, 0 }, nRate = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { szName = "Liªu NhËt L¨ng V©n Trang (30 ngµy)", tbProp = { 6, 1, 888, 1 }, nRate = 15 },
        { szName = "KhÝ Nguyªn Cao CÊp", tbProp = { 8, 283, 2, 0 }, nRate = 35 },
        { szName = "Trang Nguyªn Cao CÊp", tbProp = { 8, 284, 2, 0 }, nRate = 35 },
      },
    },
  },
  { nRequireUse = 3000,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 300 },
        { szName = "M¶nh Vò KhÝ HiÕm", tbProp = { 3, 1201, 0, 0, }, nAmount = 5, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn ®¹t mèc phÇn th­ëng, nhËn ®­îc %d %s!!!" },
        { szName = "Vi Quang Qu¸i Phï (ch­a mµi)", tbProp = { 3, 374, 0, 0 } },
        { szName = "Du Long Kim Phông Trang (30 ngµy)", tbProp = { 6, 1, 894, 1 } },
        { szName = "Trang bÞ Tinh Hån-Cao", tbProp = { 8, 1951, 2, 0 } },
        { szName = "Tói B¸ L¹c", tbProp = { 8, 1426, 2, 0 } },
      },
    },
  },
  { nRequireUse = 5000,
    tbAwards = {
      [1] = {
        { nReputeTienMa = 500 },
        { szName = "M¶nh Vò KhÝ HiÕm", tbProp = { 3, 1201, 0, 0, }, nAmount = 10, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn ®¹t mèc phÇn th­ëng, nhËn ®­îc %d %s!!!" },
      },
      [2] = {
        { szName = "Tinh Th¸i Qu¸i Phï (Ch­a mµi)", tbProp = { 3, 383, 0, 0 }, nRate = 20, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },
        { nDoPho = KsgItem.AO, nRandomFaction = 1, nLevel = 1, nRate = 10, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" }, -- §å phæ ph¸ qu©n
        { nDoPho = KsgItem.DAILUNG, nRandomFaction = 1, nLevel = 1, nRate = 10, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" }, -- §å phæ ph¸ qu©n
        { nDoPho = KsgItem.GIAY, nRandomFaction = 1, nLevel = 1, nRate = 8, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" }, -- §å phæ ph¸ qu©n

        { nDoPho = KsgItem.NON, nRandomFaction = 1, nLevel = 1, nRate = 25, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" }, -- §å phæ ph¸ qu©n
        { nDoPho = KsgItem.PHIPHONG, nRandomFaction = 1, nLevel = 1, nRate = 25, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" }, -- §å phæ ph¸ qu©n

        { szName = "Tói quµ §å phæ Ph¸ Qu©n", tbProp = { 6, 1, 1046, 1 }, nRate = 2 }, -- §å phæ ph¸ qu©n tù chän (theo hÖ ph¸i)
      },
    },
  },
}

EventMidAutumn.tbAwards = {
  [1] = {
    nTaskId_UsedCount = KsgTask.tbIds.EventMidAutumn_UseCount1,
    nTaskId_Accumulate = KsgTask.tbIds.EventMidAutumn_Accumulate1,
    nMaxUse = 1000,
    nExpRate = 500,
    nExpTienMaRate = 150,
    tbAwardAccumulate = self.tbAwardAccumulate_1
  },
  [2] = {
    nTaskId_UsedCount = KsgTask.tbIds.EventMidAutumn_UseCount2,
    nTaskId_Accumulate = KsgTask.tbIds.EventMidAutumn_Accumulate2,
    nMaxUse = 3000,
    nExpRate = 800,
    nExpTienMaRate = 300,

    tbAward = {
      { szName = "Ch©n KhÝ (TiÓu)", tbProp = { 8, 29, 4, 0 }, nRate = 15 },
      { szName = "Thanh Lé (TiÓu)", tbProp = { 8, 28, 3, 0 }, nRate = 15 },
      { szName = "B¶o T¸ Thanh Lé", tbProp = { 8, 198, 3, 0 }, nRate = 1.25 },
      { szName = "S¬n Thñy Ch©n KhÝ", tbProp = { 8, 199, 3, 0 }, nRate = 1.25 },
      { szName = "Di Ngo¹i Phï", tbProp = { 8, 35, 2, 0 }, nRate = 2 },
      { szName = "Håi Thµnh Phï (Siªu cÊp)", tbProp = { 8, 291, 2, 0 }, nRate = 2 },
      { szName = "Tói Hµng", tbProp = { 8, 137, 2, 0 }, nRate = 5 },
      { szName = "Tö Kim Hå L«", tbProp = { 8, 257, 2, 0 }, nRate = 5 },
      { szName = "ChØ Nh©n", tbProp = { 8, 135, 2, 0 }, nRate = 6 },
      { szName = "Méc Nh©n", tbProp = { 8, 174, 2, 0 }, nRate = 6 },
      { szName = "L©m Tiªn Lé", tbProp = { 8, 330, 0, 0 }, nRate = 0.1 },
      { szName = "TiÓu Thiªn H­¬ng Tôc MÖnh Lé", tbProp = { 8, 334, 0, 0 }, nRate = 0.1 },

      { nGreenItem = 1, nRandom = 1, nLevel = 4, nRate = 0.5 }, -- Trang bÞ lôc 4x
      { nGreenItem = 1, nRandom = 1, nLevel = 6, nRate = 0.25 }, -- Trang bÞ lôc 6x

      { szName = "ChÝ Hæ", tbProp = { 0, 10, 24, 4 }, nRate = 0.05 }, -- Thó c­ìi 4x
      { szName = "ChÝ §iªu", tbProp = { 0, 10, 25, 4 }, nRate = 0.05 },
      { szName = "ChÝ §iÖp", tbProp = { 0, 10, 26, 4 }, nRate = 0.05 },
    },
    tbAwardAccumulate = self.tbAwardAccumulate_2
  },

  [3] = {
    nTaskId_UsedCount = KsgTask.tbIds.EventMidAutumn_UseCount3,
    nTaskId_Accumulate = KsgTask.tbIds.EventMidAutumn_Accumulate3,
    nMaxUse = 5000,
    nExpRate = 1200,
    nExpTienMaRate = 500,
    tbAward = {
      -- B¶o th¹ch
      { szName = "M¶nh Hång Thñy Tinh", tbProp = { 3, 77, 0, 0 }, nRate = 15 },
      { szName = "M¶nh Lam Thñy Tinh", tbProp = { 3, 78, 0, 0 }, nRate = 15 },
      { szName = "M¶nh Lôc Thñy Tinh", tbProp = { 3, 248, 0, 0 }, nRate = 7 },
      { szName = "M¶nh Hoµng Thñy Tinh", tbProp = { 3, 88, 0, 0 }, nRate = 5 },
      { szName = "Lam B¶o Th¹ch", tbProp = { 3, 41, 0, 0 }, nRate = 3 },
      { szName = "Hång B¶o Th¹ch", tbProp = { 3, 79, 0, 0 }, nRate = 3 },
      { szName = "Hång Thñy Tinh", tbProp = { 3, 28, 0, 0 }, nRate = 5 },
      { szName = "Lam Thñy Tinh", tbProp = { 3, 80, 0, 0 }, nRate = 5 },

      -- VËt phÈm nhiÖm vô
      { szName = "Chuéc Hån §¨ng", tbProp = { 8, 196, 2, 0 }, nRate = 3 },
      { szName = "Lß LuyÖn §¬n", tbProp = { 8, 207, 5, 0 }, nRate = 3 },
      { szName = "Hoa Thanh Lé", tbProp = { 8, 266, 2, 0 }, nRate = 1 },
      { szName = "Khao Qu©n LÖnh", tbProp = { 8, 268, 2, 0 }, nRate = 2 },
      { szName = "L­u Ly B«i", tbProp = { 8, 378, 2, 0 }, nRate = 3 },
      { szName = "N÷ Oa Th¹ch", tbProp = { 8, 380, 2, 0 }, nRate = 3 },
      { szName = "Ch×a Khãa Linh Tª", tbProp = { 8, 329, 2, 0 }, nRate = 3 },
      { szName = "Cöu Tinh Tø §µn Ch©u", tbProp = { 8, 476, 2, 0 }, nRate = 3 },

      -- VËt phÈm chuyÓn tiÕp
      { szName = "§Þa Linh", tbProp = { 8, 119, 2, 0 }, nRate = 3 },
      { szName = "LiÖu Nguyªn", tbProp = { 8, 120, 2, 0 }, nRate = 3 },
      { szName = "Truy Phong", tbProp = { 8, 121, 2, 0 }, nRate = 3 },
      { szName = "H¶i Hån", tbProp = { 8, 122, 2, 0 }, nRate = 3 },
      { szName = "TËt §iÖn", tbProp = { 8, 123, 2, 0 }, nRate = 3 },
      { szName = "V¹n TÞch", tbProp = { 8, 124, 2, 0 }, nRate = 3 },

      -- VËt phÈm th«ng dông
      { szName = "Tô Linh Ch©u", tbProp = { 8, 417, 2, 0 }, nRate = 1.5 },
      { szName = "Lß tinh luyÖn cao cÊp", tbProp = { 8, 365, 2, 0 }, nRate = 0.25 },
      { szName = "Lß LuyÖn Tr©n Hùu", tbProp = { 8, 753, 2, 0 }, nRate = 0.15 },
      { szName = "M¶nh V¶i", tbProp = { 8, 269, 2, 0 }, nRate = 0.5 },
      { szName = "V¶i Dµy", tbProp = { 8, 270, 2, 0 }, nRate = 0.1 },
      { szName = "TrÇm §iÖn", tbProp = { 8, 191, 2, 0 }, nRate = 0.3 },
      { szName = "Trang bÞ Tinh Hån-Cao", tbProp = { 8, 1951, 2, 0 }, nRate = 0.04 },
      { szName = "S¸ch Ch­ HÇu (M¶nh)", tbProp = { 8, 193, 5, 0 }, nRate = 0.04 },
      { szName = "Quy Nguyªn KÝnh", tbProp = { 8, 1952, 5, 0 }, nRate = 0.05 },

      -- VËt phÈm hiÕm
      { szName = "KhÝ Nguyªn Cao CÊp", tbProp = { 8, 283, 2, 0 }, nRate = 0.015 },
      { szName = "Trang Nguyªn Cao CÊp", tbProp = { 8, 284, 2, 0 }, nRate = 0.015 },
      { szName = "KhÝ Tinh Cao CÊp", tbProp = { 8, 372, 2, 0 }, nRate = 0.01 },
      { szName = "Trang Tinh Cao CÊp", tbProp = { 8, 373, 2, 0 }, nRate = 0.01 },

      -- VËt phÈm cùc hiÕm
      { szName = "Tranh Qu¸i Phï s¬ cÊp", tbProp = { 3, 410, 0, 0 }, nRate = 0.01 },
      { szName = "Vi Quang Qu¸i Phï (ch­a mµi)", tbProp = { 3, 374, 0, 0 }, nRate = 0.005, nQuality = "%s tham gia ho¹t ®éng Trung Thu §oµn Viªn, may m¾n nhËn ®­îc %d %s!!!" },

      -- Th­ëng ®Æc biÖt
      { nDoPho = 1, nRandom = 1, nRate = 0.005 }, -- §å phæ ph¸ qu©n ngÉu nhiªn (theo hÖ ph¸i)
    },
    tbAwardAccumulate = self.tbAwardAccumulate_3
  }
}

EventMidAutumn.tbGift = {
  [1] = {
    szName = "Tói quµ Trung Thu",
    nRequiredNum = 10,
    tbProp = { 6, 1, 856, 0 },
    tbAwards = {
      [1] = {
        { szName = "MËt tÞch chóc phóc Trung Thu", nBind = 1, tbProp = { 6, 1, 852, 0 } },
        { szName = "§Ëu", nBind = 1, tbProp = { 3, 1133, 0, 0 }, nAmount = 10 },
      },
      [2] = {
        { szName = "Kinh NghiÖm §¬n", tbProp = { 6, 1, 1062, 1 }, nRate = 40, nBind = 1 },
        { szName = "§Ëu", tbProp = { 3, 1133, 0, 0 }, nRate = 25, nBind = 1 },
        { szName = "200 v¹n b¹c khãa", tbProp = { 6, 1, 1322, 1 }, nRate = 10, nBind = 1 },
        { szName = "H¹t sen", tbProp = { 3, 1132, 0, 0 }, nAmount = 5, nRate = 5, nBind = 1 },
        { szName = "Phï nhiÖm vô Chñ ®Ò", tbProp = { 6, 1, 1399, 1 }, nRate = 20, nBind = 1 },
      },
    }
  },
  [2] = {
    szName = "Tói quµ Trung Thu (lín)",
    nRequiredNum = 20,
    tbProp = { 6, 1, 857, 0 },
    tbAwards = {
      [1] = {
        { szName = "MËt tÞch chóc phóc Trung Thu", tbProp = { 6, 1, 852, 0 }, nBind = 1 },
        { szName = "§Ëu", tbProp = { 3, 1133, 0, 0 }, nAmount = 10, nBind = 1 },
        { szName = "H¹t sen", tbProp = { 3, 1132, 0, 0 }, nAmount = 5, nBind = 1 },
      },
      [2] = {
        { szName = "Tiªu Dao ThÇn Tiªn T¸n", tbProp = { 8, 374, 0, 0 }, nRate = 20, nBind = 1 },
        { szName = "400 v¹n b¹c khãa", tbProp = { 6, 1, 1323, 1 }, nRate = 10, nBind = 1 },
        { szName = "M¶nh S¸ch Ch­ HÇu", tbProp = { 8, 193, 5, 0 }, nRate = 20, nBind = 1 },
        { szName = "Kinh NghiÖm §¬n", tbProp = { 6, 1, 1062, 1 }, nRate = 20, nBind = 1 },
        { szName = "T­íng Qu©n LÖnh", tbProp = { 3, 100, 0, 0 }, nRate = 15, nBind = 1 },
        { szName = "Tói ThÊt Qu¶i", tbProp = { 8, 288, 2, 0 }, nRate = 8, nBind = 1 },
        { szName = "TrÇm §iÖn", tbProp = { 8, 191, 2, 0 }, nRate = 5, nBind = 1 },
        { szName = "Tói L­¬ng Ngäc", tbProp = { 8, 1668, 2, 0 }, nRate = 1, nBind = 1 },
        { szName = "ThÎ Kim DËt", tbProp = { 8, 1316, 6, 0 }, nRate = 1, nBind = 1 },
      },
    }
  },
  [3] = {
    szName = "Tói quµ Trung Thu hµo hoa",
    nRequiredNum = 30,
    tbProp = { 6, 1, 858, 0 },
    tbAwards = {
      [1] = {
        { szName = "MËt tÞch chóc phóc Trung Thu", tbProp = { 6, 1, 852, 0 }, nBind = 1 },
        { szName = "§Ëu", tbProp = { 3, 1133, 0, 0 }, nAmount = 20, nBind = 1 },
        { szName = "H¹t sen", tbProp = { 3, 1132, 0, 0 }, nAmount = 10, nBind = 1 },
      },
      [2] = {
        { szName = "Kinh NghiÖm §¬n-Siªu cÊp", tbProp = { 6, 1, 1355, 1 }, nRate = 40, nBind = 1 },
        { szName = "Ngäc Thanh ThÇn Tiªn T¸n", tbProp = { 8, 375, 0, 0 }, nRate = 25, nBind = 1 },
        { szName = "M¶nh S¸ch Ch­ HÇu", tbProp = { 8, 193, 5, 0 }, nRate = 15, nBind = 1 },
        { szName = "§ång Nh©n", tbProp = { 8, 227, 2, 0 }, nRate = 10, nBind = 1 },
        { szName = "M¶nh Tö thuû tinh", tbProp = { 3, 1149, 0, 0 }, nRate = 7, nBind = 1 },
        { szName = "M¶nh Hoµng thñy tinh", tbProp = { 3, 88, 0, 0 }, nRate = 2, nBind = 1 },
        { szName = "KhÝ Nguyªn Cao CÊp", tbProp = { 8, 283, 2, 0 }, nRate = 0.25, nBind = 1 },
        { szName = "Trang Nguyªn Cao CÊp", tbProp = { 8, 284, 2, 0 }, nRate = 0.25, nBind = 1 },
        { szName = "Vi Quang Qu¸i Phï (ch­a mµi)", tbProp = { 3, 374, 0, 0 }, nRate = 0.5, nBind = 1 },
      },
    }
  },
}

return EventMidAutumn

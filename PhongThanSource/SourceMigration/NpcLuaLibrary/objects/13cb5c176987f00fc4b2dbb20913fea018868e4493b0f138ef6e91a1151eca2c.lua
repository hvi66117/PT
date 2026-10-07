module("SUPERMAN", package.seeall)
require("common.luax")
require("¼×¹ÇÎÄ»î¶¯.luax")

Task_State = 2000
TaskSuperManFinish = 2007
G_BoxTimeTask = 2002
G_SuperManID = 627
G_SuperManCD = 628
G_ThemeTask = 0
G_CityTask = 1
G_BoxTask = 2
G_NONE_TASK = 0
G_CAN_DO_TASK = 1
G_DOING_TASK = 2
G_FINISH_TASK = 3

G_TaskRate = 1
G_TaskReward = 2
G_TaskTime = 3
G_ManMax = 24

Task_RecruitSuperMan = 2008
TaskNote_Recruit = 1949
TASK_33 = 884
TASK_34 = 885
CITY_Day = 39;
CITY_Rand = 40;

tbl_ThemeList = {
    { id = 1, name = "VËn chuyÓn", level = 25, time = 2, taskID = { 333, 1, 0 }, timeTask = { 1, 769, 1 }, countTask = { 766, 1, 7, 1 }, doubleTask = { 766, 4 }, freeTimes = 2, feeTimes = 5, useTask = { 2000, 1 }, costid = 4, costitem = { 8, 137, 2, 1, "Tói hµng" }, exp = 1200, item = {}, itemRate = { 5, 6, 1, 1253, 1, 1 }, itemName = "§å phæ Cam cÊp 2", themeday = 6, totalTask = 803, doubletype = 1, doubleLvl = { { 100, 600, 2.5 }, { 70, 200, 1.5 } }, bible = 61, skill = { 51, -1 }, skillcd = 50 },
    { id = 2, name = "Th¸m Qu©n", level = 30, time = 1, taskID = { 314, 1, 0 }, timeTask = { 2, 315, 1 }, countTask = { 916, 1, 5, 2, 2004, 1 }, doubleTask = { 317, 4 }, freeTimes = 1, feeTimes = 4, useTask = { 2000, 2 }, costid = 26, costitem = { 8, 206, 5, 1, "Thiªn Tiªn thñy" }, exp = 3000, item = {}, itemRate = { 10, 8, 35, 2, 0, 1 }, itemName = "Di ngo¹i phï", themeday = 1, totalTask = 1026, doubletype = 1, doubleLvl = { { 100, 400, 1 }, { 70, 150, 0.5 } }, bible = 33, skill = { 41, -1 }, skillcd = 40 },
    { id = 3, name = "Siªu §é", level = 40, time = 1, taskID = { 961, 1, 0 }, timeTask = { 1, 963, 1 }, countTask = { 962, 1, 5, 1 }, doubleTask = { 962, 4 }, freeTimes = 1, feeTimes = 4, useTask = { 2000, 3 }, costid = 47, costitem = { 8, 257, 2, 1, "Tö Kim hå l«" }, exp = 2500, item = {}, itemRate = { 5, 6, 1, 1252, 1, 1 }, itemName = "Tói quµ truyÒn tèng Tø TiÓu", themeday = 3, totalTask = 1028, doubletype = 1, doubleLvl = { { 110, 500, 1.5 }, { 75, 180, 0.75 } }, bible = 48, skill = { 43, -1 }, skillcd = 42 },
    { id = 4, name = "ThÊt Qu¶i", level = 45, time = 1, taskID = { 826, 1, 0 }, timeTask = { 2, 915, 1 }, countTask = { 976, 1, 5, 2, 2004, 2 }, doubleTask = { 976, 4 }, freeTimes = 1, feeTimes = 4, useTask = { 2000, 4 }, costid = 25, costitem = { 8, 196, 2, 1, "Chuéc Hån ®¨ng" }, exp = 4500, item = {}, itemRate = { 3, 8, 196, 2, 1, 1 }, itemName = "Chuéc Hån ®¨ng", themeday = 7, totalTask = 1029, doubletype = 1, doubleLvl = { { 120, 400, 1 }, { 80, 150, 0.5 } }, bible = 62, skill = { 37, -1 }, skillcd = 36 },
    { id = 5, name = "Tø Linh", level = 65, time = 1, taskID = { -1, -1, -1 }, timeTask = { 3, 1021, 1 }, countTask = { 1021, 2, 4, 2, 2004, 3 }, doubleTask = { -1, 1, 1696, 1023 }, freeTimes = 1, feeTimes = 3, useTask = { 2000, 5 }, costid = 59, costitem = { 8, 329, 2, 1, "Ch×a Kho¸ Linh Tª" }, exp = 3000, item = {}, itemRate = { 1, 8, 330, 0, 0, 1 }, itemName = "L©m Tiªn Lé", themeday = 2, totalTask = 1023, doubletype = 3, doublename = "Gi¶i Linh Ch©u", doubleLvl = { [1] = { 100, 300, 2 }, [2] = { 90, 100, 1.5 }, total = { 0, 170, 200, 260, 380, 620 } }, bible = 54, skill = { 33, 39, -1 }, skillcd = 32 },
    { id = 6, name = "Thiªn C­¬ng", level = 75, time = 1, taskID = { 1013, 3, 0 }, timeTask = { 6, 1013, 1 }, countTask = { 1013, 2, 4, 2, 2004, 4 }, doubleTask = { -1, 2, 1697, 1130 }, freeTimes = 1, feeTimes = 3, useTask = { 2000, 6 }, costid = 58, costitem = { 8, 303, 2, 1, "Dô Hån H­¬ng" }, exp = 0, item = { 3, 133, 0, 0, 1, "Hån" }, itemRate = { 12, 3, 134, 0, 0, 1 }, itemName = "Ph¸ch", themeday = 1, totalTask = 1130, doubletype = 2, doublename = "Hµnh §¹o Ch©u", doubleLvl = { 0, 270, 310, 390, 550, 870 }, bible = 53, skill = { -1 }, skillcd = -1 },
    { id = 7, name = "Tèng Töu", level = 95, time = 3, taskID = { 1139, 3, 0 }, timeTask = { 3, 1139, 1 }, countTask = { 1139, 2, 4, 1 }, doubleTask = { -1, 4, 1699, 1142 }, freeTimes = 1, feeTimes = 3, useTask = { 2000, 7 }, costid = 66, costitem = { 8, 378, 2, -1, "L­u Ly B«i" }, exp = 1000, item = {}, itemRate = {}, itemName = "", themeday = 5, totalTask = 1142, doubletype = 2, doublename = "§ç Khang Ch©u", doubleLvl = { 0, 180, 210, 270, 390, 630 }, bible = 55, skill = { 35, -1 }, skillcd = 34 },
    { id = 8, name = "Long Ch©u", level = 45, time = 1, taskID = { 981, 1, 0 }, timeTask = { 2, 980, 1 }, countTask = { 979, 1, 4, 1 }, doubleTask = { -2, -1 }, freeTimes = 0, feeTimes = 4, useTask = { 2000, 18 }, costid = 25, costitem = { 8, 196, 2, 3, "Chuéc Hån ®¨ng" }, exp = 0, item = {}, itemRate = { [1] = { 97, 194 }, [2] = { 96, 194 }, [3] = { 94, 194 }, [4] = { 90, 194 } }, itemName = "Long Ch©u", themeday = 7, totalTask = 1030, doubletype = 0, doubleLvl = { 201, 101, 51, 0 }, bible = 63, skill = { -1 }, skillcd = -1 },
    { id = 9, name = "Thiªn Thô", level = 35, time = 1, taskID = { 815, 1, 0 }, timeTask = { 1, 816, 1 }, countTask = { 977, 1, 4, 2, 2004, 5 }, doubleTask = { 813, 4 }, freeTimes = 1, feeTimes = 3, useTask = { 2000, 19 }, costid = 48, costitem = { 8, 266, 2, 1, "Hoa Thanh Lé" }, exp = 2250, item = {}, itemRate = { 100, 4, 48, 0, 0, 1 }, itemName = "H¹t Gièng", themeday = 5, totalTask = 1027, doubletype = 1, doubleLvl = { { 110, 400, 1 }, { 80, 150, 0.5 } }, bible = 60, skill = { 47, -1 }, skillcd = 46 },
}

tbl_CityList = {
    { id = 1, name = "NhiÖm vô Hµng phôc (CÊp 1)", level = 20, time = 1, cityLvl = 1, building = 5, Contri = 0, taskID = { 852, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 853, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 8 }, costid = 1, exp = 700, themeday = 1, citytask = 21, skill = { 49, -1 }, skillcd = 48 },
    { id = 2, name = "NhiÖm vô Hµng phôc (CÊp 2)", level = 40, time = 1, cityLvl = 2, building = 5, Contri = 30, taskID = { 854, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 855, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 9 }, costid = 1, exp = 800, themeday = 1, citytask = 22, skill = { 49, -1 }, skillcd = 48 },
    { id = 3, name = "NhiÖm vô Hµng phôc (CÊp 3)", level = 60, time = 1, cityLvl = 3, building = 5, Contri = 60, taskID = { 856, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 857, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 10 }, costid = 1, exp = 1000, themeday = 1, citytask = 23, skill = { 49, -1 }, skillcd = 48 },
    { id = 4, name = "NhiÖm vô Hµng phôc (CÊp 4)", level = 70, time = 1, cityLvl = 4, building = 5, Contri = 120, taskID = { 858, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 859, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 11 }, costid = 2, exp = 2400, themeday = 1, citytask = 24, skill = { 49, -1 }, skillcd = 48 },
    { id = 5, name = "NhiÖm vô TruyÒn Tin (CÊp 1)", level = 20, time = 1, cityLvl = 1, building = 5, Contri = 0, taskID = { 868, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 869, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 12 }, costid = 1, exp = 700, themeday = 5, citytask = 29, skill = { 49, -1 }, skillcd = 48 },
    { id = 6, name = "NhiÖm vô TruyÒn Tin (CÊp 2)", level = 20, time = 1, cityLvl = 2, building = 5, Contri = 30, taskID = { 870, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 871, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 13 }, costid = 1, exp = 800, themeday = 5, citytask = 30, skill = { 49, -1 }, skillcd = 48 },
    { id = 7, name = "NhiÖm vô TruyÒn Tin (CÊp 3)", level = 40, time = 1, cityLvl = 3, building = 5, Contri = 60, taskID = { 872, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 873, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 14 }, costid = 1, exp = 1000, themeday = 5, citytask = 31, skill = { 49, -1 }, skillcd = 48 },
    { id = 8, name = "NhiÖm vô TruyÒn Tin (CÊp 4)", level = 40, time = 1, cityLvl = 4, building = 5, Contri = 120, taskID = { 874, 1, 0 }, timeTask = { 4, 886, 1 }, countTask = { 875, 1, 8, 4 }, freeTimes = 3, feeTimes = 5, useTask = { 2000, 15 }, costid = 2, exp = 2400, themeday = 5, citytask = 32, skill = { 49, -1 }, skillcd = 48 },
    { id = 9, name = "Hoa thÇn bÝ", level = 30, time = 1, cityLvl = 1, building = 12, Contri = 0, taskID = { -2, -2, -2 }, timeTask = { 5, 890, 1 }, countTask = { 891, 1, 5, 1 }, freeTimes = 1, feeTimes = 4, useTask = { 2000, 16 }, costid = 26, costitem = { 8, 206, 5, 1, "Thiªn Tiªn thñy" }, exp = 3000, themeday = 4, citytask = -1, skill = { 45, -1 }, skillcd = 44 },
    { id = 10, name = "Thao tr­êng ThÝ luyÖn", level = 50, time = 2, cityLvl = 3, building = 3, Contri = 60, taskID = { 306, 1, 0 }, timeTask = { 5, 305, 1 }, countTask = { 307, 1, 4, 1 }, freeTimes = 1, feeTimes = 3, useTask = { 2000, 17 }, costid = 61, costitem = { 8, 366, 2, 1, "Hu©n Ma H­¬ng" }, exp = 3000, themeday = 7, citytask = -1, skill = { -1 }, skillcd = -1 },
}

tbl_BoxList = {
    { id = 1, name = "§«ng H¶i Di B¶o", level = 0, useTask = { 2003, 1 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 24, 0, 0, 50 }, itemName = "Thñy Hån", time = 1, validity = 20, successRate = 60, skill = { 3, 9, 16, 17, 23 }, skillReward = -1, bag = 1 },
    { id = 2, name = "B¨ng Xuyªn Di B¶o", level = 0, useTask = { 2003, 2 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 23, 0, 0, 50 }, itemName = "Phong LÖ", time = 1, validity = 20, successRate = 60, skill = { 4, 7, 16, 18, 21 }, skillReward = -1, bag = 1 },
    { id = 3, name = "Hoang M¹c Di B¶o", level = 0, useTask = { 2003, 3 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 22, 0, 0, 50 }, itemName = "§Þa T©m", time = 1, validity = 20, successRate = 60, skill = { 2, 5, 11, 16, 19, 25 }, skillReward = -1, bag = 1 },
    { id = 4, name = "Hiªn Viªn Di B¶o", level = 0, useTask = { 2003, 4 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 25, 0, 0, 50 }, itemName = "Háa Linh", time = 1, validity = 20, successRate = 60, skill = { 6, 10, 16, 20, 24 }, skillReward = -1, bag = 1 },
    { id = 5, name = "§«ng H¶i Tr©n B¶o", level = 120, useTask = { 2003, 5 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 24, 0, 0, 100 }, itemName = "Thñy Hån", time = 2, validity = 20, successRate = 40, skill = { 3, 9, 16, 17, 23 }, skillReward = -1, bag = 1 },
    { id = 6, name = "B¨ng Xuyªn Tr©n B¶o", level = 120, useTask = { 2003, 6 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 23, 0, 0, 100 }, itemName = "Phong LÖ", time = 2, validity = 20, successRate = 40, skill = { 4, 7, 16, 18, 21 }, skillReward = -1, bag = 1 },
    { id = 7, name = "Hoang M¹c Tr©n B¶o", level = 120, useTask = { 2003, 7 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 22, 0, 0, 100 }, itemName = "§Þa T©m", time = 2, validity = 20, successRate = 40, skill = { 2, 5, 11, 16, 19, 25 }, skillReward = -1, bag = 1 },
    { id = 8, name = "Hiªn Viªn Tr©n B¶o", level = 120, useTask = { 2003, 8 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 25, 0, 0, 100 }, itemName = "Háa Linh", time = 2, validity = 20, successRate = 40, skill = { 6, 10, 16, 20, 24 }, skillReward = -1, bag = 1 },
    { id = 9, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 9 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 0, 1, 3 }, itemName = "Ngò Quang th¹ch", time = 1, validity = 20, successRate = 60, skill = { 7, 16, 21 }, skillReward = 12, bag = 3 },
    { id = 10, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 10 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 1, 1, 3 }, itemName = "H×nh Thiªn Ên", time = 1, validity = 20, successRate = 60, skill = { 8, 16, 22 }, skillReward = 12, bag = 3 },
    { id = 11, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 11 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 2, 1, 3 }, itemName = "Cµn Kh«n XÝch", time = 1, validity = 20, successRate = 60, skill = { 10, 16, 24 }, skillReward = 12, bag = 3 },
    { id = 12, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 12 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 3, 1, 3 }, itemName = "Hçn Thiªn L¨ng", time = 1, validity = 20, successRate = 60, skill = { 2, 11, 16, 25 }, skillReward = 12, bag = 3 },
    { id = 13, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 13 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 4, 1, 3 }, itemName = "B×nh L­u Ly", time = 1, validity = 20, successRate = 60, skill = { 9, 16, 23 }, skillReward = 12, bag = 3 },
    { id = 14, name = "S­u tÇm Ph¸p B¶o", level = 60, useTask = { 2003, 14 }, needMan = 1, needFinish = 100, nType = 2, costid = -1, item = { 0, 4, 5, 1, 3 }, itemName = "Háa Long Tiªu", time = 1, validity = 20, successRate = 60, skill = { 10, 16, 24 }, skillReward = 12, bag = 3 },
    { id = 15, name = "T­íng Qu©n LÖnh", level = 120, useTask = { 2003, 15 }, needMan = 3, needFinish = 300, nType = 3, costid = -1, item = { 3, 100, 0, 0, 1 }, itemName = "T­íng Qu©n LÖnh", time = 8, validity = 60, successRate = 20, skill = { 10, 16, 24 }, skillReward = 26, bag = 1 },
    { id = 16, name = "Lôc §¹o Tinh Hoa", level = 60, useTask = { 2003, 16 }, needMan = 1, needFinish = 0, nType = 3, costid = -1, item = { 3, 114, 0, 0, 10 }, itemName = "Lôc §¹o Tinh Hoa", time = 1, validity = 40, successRate = 60, skill = { 8, 16, 22 }, skillReward = -1, bag = 1 },
    { id = 17, name = "NhiÒu Lôc §¹o Tinh Hoa", level = 120, useTask = { 2003, 17 }, needMan = 5, needFinish = 0, nType = 3, costid = -1, item = { 3, 114, 0, 0, 30 }, itemName = "Lôc §¹o Tinh Hoa", time = 2, validity = 40, successRate = 40, skill = { 8, 16, 22 }, skillReward = -1, bag = 1 },
    { id = 18, name = "Tø T­îng Tinh Hoa", level = 60, useTask = { 2003, 18 }, needMan = 1, needFinish = 0, nType = 3, costid = -1, item = { 3, 115, 0, 0, 5 }, itemName = "Tø T­îng Tinh Hoa", time = 2, validity = 40, successRate = 60, skill = { 8, 16, 22 }, skillReward = -1, bag = 1 },
    { id = 19, name = "NhiÒu Tø T­îng Tinh Hoa", level = 120, useTask = { 2003, 19 }, needMan = 5, needFinish = 0, nType = 3, costid = -1, item = { 3, 115, 0, 0, 15 }, itemName = "Tø T­îng Tinh Hoa", time = 4, validity = 40, successRate = 40, skill = { 8, 16, 22 }, skillReward = -1, bag = 1 },
    { id = 20, name = "S­u tÇm Th¶o D­îc", level = 90, useTask = { 2003, 20 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 910, 0, 0, 20 }, itemName = "B¹ch Trµ", time = 2, validity = 20, successRate = 60, skill = { 8, 16, 22 }, skillReward = 28, bag = 1 },
    { id = 21, name = "S­u tÇm Th¶o D­îc", level = 90, useTask = { 2003, 21 }, needMan = 2, needFinish = 50, nType = 1, costid = -1, item = { 3, 911, 0, 0, 20 }, itemName = "§Þa Hoµng", time = 2, validity = 20, successRate = 40, skill = { 8, 16, 22 }, skillReward = 28, bag = 1 },
    { id = 22, name = "S­u tÇm Th¶o D­îc", level = 90, useTask = { 2003, 22 }, needMan = 2, needFinish = 100, nType = 1, costid = -1, item = { 3, 912, 0, 0, 20 }, itemName = "Huyªn th¶o", time = 2, validity = 20, successRate = 20, skill = { 8, 16, 22 }, skillReward = 28, bag = 1 },
    { id = 23, name = "S­u tÇm Kho¸ng Th¹ch", level = 60, useTask = { 2003, 23 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 928, 0, 0, 20 }, itemName = "Hoµng ®ång", time = 1, validity = 20, successRate = 60, skill = { 2, 11, 16, 25 }, skillReward = 28, bag = 1 },
    { id = 24, name = "S­u tÇm Kho¸ng Th¹ch", level = 90, useTask = { 2003, 24 }, needMan = 2, needFinish = 50, nType = 1, costid = -1, item = { 3, 929, 0, 0, 20 }, itemName = "§ång ®á", time = 2, validity = 20, successRate = 40, skill = { 2, 11, 16, 25 }, skillReward = 28, bag = 1 },
    { id = 25, name = "S­u tÇm Kho¸ng Th¹ch", level = 90, useTask = { 2003, 25 }, needMan = 2, needFinish = 100, nType = 1, costid = -1, item = { 3, 930, 0, 0, 20 }, itemName = "XÝch ®ång", time = 3, validity = 20, successRate = 20, skill = { 10, 16, 24 }, skillReward = 28, bag = 1 },
    { id = 26, name = "S­u tÇm Nguyªn liÖu", level = 60, useTask = { 2003, 26 }, needMan = 1, needFinish = 0, nType = 1, costid = -1, item = { 3, 944, 0, 0, 20 }, itemName = "T«m xanh", time = 1, validity = 20, successRate = 60, skill = { 9, 16, 23 }, skillReward = 28, bag = 1 },
    { id = 27, name = "S­u tÇm Nguyªn liÖu", level = 90, useTask = { 2003, 27 }, needMan = 2, needFinish = 50, nType = 1, costid = -1, item = { 3, 945, 0, 0, 20 }, itemName = "T«m hïm", time = 2, validity = 20, successRate = 40, skill = { 9, 16, 23 }, skillReward = 28, bag = 1 },
    { id = 28, name = "S­u tÇm Nguyªn liÖu", level = 90, useTask = { 2003, 28 }, needMan = 2, needFinish = 100, nType = 1, costid = -1, item = { 3, 946, 0, 0, 20 }, itemName = "Ca diÕt", time = 3, validity = 20, successRate = 20, skill = { 9, 16, 23 }, skillReward = 28, bag = 1 },
    { id = 29, name = "S­u tÇm Muèi", level = 90, useTask = { 2003, 29 }, needMan = 2, needFinish = 0, nType = 1, costid = -1, item = { 3, 938, 0, 0, 10 }, itemName = "LÞch Diªm", time = 2, validity = 20, successRate = 60, skill = { 2, 11, 16, 25 }, skillReward = 28, bag = 1 },
    { id = 30, name = "S­u tÇm Muèi", level = 90, useTask = { 2003, 30 }, needMan = 2, needFinish = 50, nType = 1, costid = -1, item = { 3, 939, 0, 0, 10 }, itemName = "Th« Diªm", time = 3, validity = 20, successRate = 40, skill = { 9, 16, 23 }, skillReward = 28, bag = 1 },
    { id = 31, name = "Hång Thñy Tinh Nguyªn Th¹ch", level = 90, useTask = { 2003, 31 }, needMan = 2, needFinish = 0, nType = 3, costid = -1, item = { 3, 1001, 0, 0, 20 }, itemName = "Hång Thñy Tinh Nguyªn Th¹ch", time = 2, validity = 40, successRate = 40, skill = { 7, 16, 21 }, skillReward = -1, bag = 1 },
    { id = 32, name = "Lôc Thñy Tinh Nguyªn Th¹ch", level = 90, useTask = { 2005, 3 }, needMan = 2, needFinish = 0, nType = 3, costid = -1, item = { 3, 1002, 0, 0, 20 }, itemName = "Lôc Thñy Tinh Nguyªn Th¹ch", time = 2, validity = 40, successRate = 40, skill = { 7, 16, 21 }, skillReward = -1, bag = 1 },
    { id = 33, name = "Lam Thñy Tinh Nguyªn Th¹ch", level = 90, useTask = { 2005, 1 }, needMan = 2, needFinish = 100, nType = 3, costid = -1, item = { 3, 1003, 0, 0, 20 }, itemName = "Lam Thñy Tinh Nguyªn Th¹ch", time = 2, validity = 40, successRate = 40, skill = { 7, 16, 21 }, skillReward = -1, bag = 1 },
    { id = 34, name = "Hoµng thñy Tinh Nguyªn Th¹ch", level = 90, useTask = { 2005, 2 }, needMan = 2, needFinish = 300, nType = 3, costid = -1, item = { 3, 1004, 0, 0, 20 }, itemName = "Hoµng thñy Tinh Nguyªn Th¹ch", time = 2, validity = 40, successRate = 40, skill = { 7, 16, 21 }, skillReward = -1, bag = 1 },
    { id = 35, name = "Ma Vùc Tu LuyÖn Tr©n B¶o R­¬ng", level = 0, useTask = { 2005, 4 }, needMan = 1, needFinish = 0, nType = 4, costid = -1, item = { 6, 1, 1005, 0, 1 }, itemName = "Phï nhiÖm vô chñ ®Ò ngµy", time = 1, validity = 40, successRate = 10, skill = { 29, 30 }, skillReward = -1, bag = 1 },
    { id = 36, name = "Tiªn Phñ Tu LuyÖn Tr©n B¶o R­¬ng", level = 0, useTask = { 2005, 5 }, needMan = 1, needFinish = 0, nType = 4, costid = -1, item = { 6, 1, 1005, 0, 1 }, itemName = "Phï nhiÖm vô chñ ®Ò ngµy", time = 1, validity = 40, successRate = 10, skill = { 30, 31 }, skillReward = -1, bag = 1 },

}

function no()
    CloseDialog()
    UpdateSuperManTask()
end

function CheckThemeTaskDay(tblList)
    local local_day = math.floor(LocalSystemTime() / 86400)
    local taskDate = 0
    local nowday = 0
    if (tblList.timeTask[1] == 3) then
        taskDate = GetTaskByte(tblList.timeTask[2], tblList.timeTask[3])
        nowday = math.mod(local_day, 256)
    elseif (tblList.timeTask[1] == 6) then
        taskDate = GetTaskByte(tblList.timeTask[2], tblList.timeTask[3])
        nowday = math.mod(local_day, 247) + 1
    elseif (tblList.timeTask[1] == 2) then
        taskDate = GetTask(tblList.timeTask[2])
        nowday = local_day
    elseif (tblList.timeTask[1] == 1) then
        taskDate = math.floor(GetTask(tblList.timeTask[2]) / 86400)
        nowday = local_day
    end

    if (taskDate ~= nowday) then
        SetTaskByte(tblList.countTask[1], tblList.countTask[2], 0)
        if (tblList.countTask[4] == 2) then
            SetTaskBit(tblList.countTask[5], tblList.countTask[6], 0)
        end
        return 1
    elseif (tblList.countTask[4] == 2) then
        SetTaskBit(tblList.countTask[5], tblList.countTask[6], 1)
    end

    return 0
end

function setThemeTaskDay(nTaskID)
    local local_day = math.floor(LocalSystemTime() / 86400)
    local taskDate = 0
    local nowday = 0
    local tTask = tbl_ThemeList[nTaskID].timeTask
    if (tTask[1] == 3) then
        taskDate = GetTaskByte(tTask[2], tTask[3])
        nowday = math.mod(local_day, 256)
    elseif (tTask[1] == 6) then
        taskDate = GetTaskByte(tTask[2], tTask[3])
        nowday = math.mod(local_day, 247) + 1
    elseif (tTask[1] == 2) then
        taskDate = GetTask(tTask[2])
        nowday = local_day
    elseif (tTask[1] == 1) then
        taskDate = math.floor(GetTask(tTask[2]) / 86400)
        nowday = local_day
    end

    local tblList = tbl_ThemeList[nTaskID].countTask
    if (taskDate ~= nowday) then
        if (tTask[1] == 1) then
            SetTask(tTask[2], LocalSystemTime())
        else
            SetTask(tTask[2], nowday)
        end

        if (tblList[4] == 2) then
            SetTaskBit(tblList[5], tblList[6], 1)
            if (nTaskID == 4) then
                SyncBibleState(63, 1, 1)
                SetTask(978, local_day)
            elseif (nTaskID == 2) then
                SetTaskByte(317, 1, 4)
            end
        else
            SetTaskByte(tblList[1], tblList[2], 1)
        end
        return 1
    end

    return 0
end

function CheckCityTaskDay(tblList)
    local today = math.floor(LocalSystemTime() / 86400)
    if (tblList.id == 10) then
        if (GetCityTask(CITY_Day) ~= today) then
            SetCityTask(CITY_Day, today)
            SetCityTask(CITY_Rand, math.random(2147483647))
        end

        if (GetTask(tblList.timeTask[2]) ~= GetCityTask(CITY_Day)) then
            SetTask(tblList.timeTask[2], GetCityTask(CITY_Day))
            TaskNote(31, -1)
            SetTask(307, 0)
            SetTask(336, 0)

            if (GetTask(306) > 0) then
                Msg2Player("NhiÖm vô Thao tr­êng thµnh thÞ sÏ ®­îc t¸i lËp mçi ngµy!")
                TopMessage(13992)
                SetTask(306, 0)
            end
            return 1
        end
    elseif (tblList.id == 9) then
        if (GetTask(tblList.timeTask[2]) ~= today) then
            SetTask(tblList.timeTask[2], today)
            Msg2Player("§· qua ngµy míi, nhiÖm vô Hoa ThÇn BÝ ®­îc thiÕt lËp l¹i.")
            if (GetTaskByte(tblList.countTask[1], 2) > 0) then
                TopMessage(13958)
            end

            SetTask(tblList.countTask[1], 0)
            for i = 350, 364 do
                SetTask(i, 0)
            end
            TaskNote(34, -1)
            return 1
        end
    end
    return 0
end

function shenmihuahui()
    local sum = 0
    for i = 350, 364 do
        sum = sum + GetTask(i)
    end
    return sum + GetTaskByte(891, 2)
end

function CheckTaskStep(nType, tblList)
    local tempUse = tblList.useTask
    local stepList = tblList.taskID
    if (table.getn(tempUse) == 2) and (table.getn(stepList) == 3) then
        if (tblList.timeTask[1] ~= nil) then
            if (tblList.timeTask[1] == 4 and CheckTaskDay(tblList) == 1) then
                return G_CAN_DO_TASK
            elseif (tblList.timeTask[1] == 5 and CheckCityTaskDay(tblList) == 1) then
                return G_CAN_DO_TASK
            elseif (CheckThemeTaskDay(tblList) == 1) then
                return G_CAN_DO_TASK
            end
        else
            return G_NONE_TASK
        end

        if (stepList[1] == -1 and tongguanjiangli() == 1)
                or (stepList[1] == -2 and shenmihuahui() == 0)
                or (GetTaskByte(stepList[1], stepList[2]) == stepList[3]) then

            local countList = tblList.countTask
            if (countList[4] ~= 4) then
                local leftTask, a = todayfreetimes(GetTaskByte(countList[1], countList[2]))
                if (countList[4] == 2) then
                    leftTask = leftTask + GetTaskBit(countList[5], countList[6])
                end

                if (leftTask < countList[3]) then
                    return G_CAN_DO_TASK
                else
                    return G_NONE_TASK
                end
            elseif (GetCityTaskCount(4) < countList[3]) then
                return G_CAN_DO_TASK
            else
                return G_NONE_TASK
            end
        else
            return G_DOING_TASK
        end
    end
    return G_NONE_TASK
end

function CheckTaskDay(tblList)
    if (tblList.timeTask[1] == nil or tblList.timeTask[1] ~= 4) then
        return 0
    end
    local nToday = math.floor(LocalSystemTime() / 86400)
    if (GetTask(tblList.timeTask[2]) ~= nToday) then
        SetTask(tblList.timeTask[2], nToday)

        SetTaskWord(1259, 1, 0)
        SetTaskByte(1259, 3, 0)
        SetTask(1510, 0)

        SetTask(884, 3)
        SetTask(1858, 0)
        SetTask(1859, 0)
        DelNormalItem(6, 1, 955, 1)
        TaskNote(1630, -1)
        for i = 1, table.getn(tbl_CityList) do
            if (tbl_CityList[i].timeTask[1] == 4) then
                SetTask(tbl_CityList[i].taskID[1], 0)
                SetTask(tbl_CityList[i].countTask[1], 0)
                TaskNote(tbl_CityList[i].taskID[1], -1)
            end
        end
        for i = 860, 867 do
            SetTask(i, 0)
        end

        for i = 25, 27 do
            SetTaskBit(1259, i, 0)
        end
        return 1
    end
    return 0
end

function get_stamina()
    return GetTask(TASK_33) + GetTask(TASK_34)
end

function cost_stamina(v)
    for i = 1, v do
        local stamina = GetTask(TASK_33)
        if (stamina > 0) then
            SetTask(TASK_33, stamina - 1)
        else
            local stamina_ib = GetTask(TASK_34)
            if (stamina_ib > 0) then
                SetTask(TASK_34, stamina_ib - 1)
            end
        end
    end
    Msg2Player("KhÊu trõ " .. v .. " ®iÓm hµnh ®éng.")
end

function GetCityTaskCount(index)
    local nTemp = {}
    local nCount = 0
    for i = 1, table.getn(tbl_CityList) do
        nTemp = tbl_CityList[i].countTask
        if (nTemp[4] == index) then
            nCount = nCount + GetTask(nTemp[1])
        end
    end
    for i = 861, 867, 2 do
        nCount = nCount + GetTask(i)
    end

    nCount = nCount + GetTaskByte(1858, 2)
    return nCount
end

function CheckCityInfo(tblList)
    local nCityLvl = GetOwnCityLevel() + 1
    if (IsTongMember() > 0) then
        if (tblList.cityLvl ~= nil and nCityLvl >= tblList.cityLvl) then
            if (tblList.Contri ~= nil and GetTongContri() >= tblList.Contri) then
                if (tblList.building ~= nil) then
                    nBuildIdx = GetBuildingIdxByID(tblList.building)
                    if (nBuildIdx > 0 and GetBuildingState(nBuildIdx) == 1) then
                        return 1
                    elseif (IsOwnerCity() ~= 1) then
                        Msg2Player("HiÖn kh«ng thÓ lÊy tin tøc thµnh thÞ cña ngµi, mêi ®Õn Sø gi¶ ThÇn T­íng trong thµnh thÞ bæn Quèc nhËn nhiÖm vô!")
                    end
                end
            end
        end
    end

    return 0
end

function CheckCanStart(tblTemp)
    if (tblTemp.level ~= nil and GetLevel() >= tblTemp.level) then
        if (tblTemp.needMan ~= nil and GetSuperManNum() >= tblTemp.needMan) then
            if (tblTemp.needFinish ~= nil and GetTask(TaskSuperManFinish) >= tblTemp.needFinish) then
                return 1
            end
        end
    end
    return 0
end

function tongguanjiangli()
    for i = 1, 4 do
        for j = 1, 5 do
            if (GetIBBuffTimes(300 + i * 5 + j) > 0) then
                return 2
            end
        end
    end

    local nkey = 1
    if (HaveIBBuff(326) > 0) or (HaveIBBuff(327) > 0) or (HaveIBBuff(328) > 0) or (HaveIBBuff(331) > 0) then
        nkey = 2
    else
        for k = 1, 12 do
            if (HaveIBBuff(341 + k) > 0) then
                nkey = 2
                break ;
            end
        end
    end

    return nkey
end

function CheckThemeTaskItemAndMoney(nTaskID, nTaskCount)
    local nPlayerLevel = GetLevel()
    local nMoney = 0
    local idx = tbl_ThemeList[nTaskID].id
    if (idx == 4) then
        for i = 15, 21 do
            if (HaveNormalItem(3, i, 0, 0) < 1) then
                Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã §Þa Qu¸i, Thuû Qu¸i, Ho¶ Qu¸i, S¬n Qu¸i, Tr¹ch Qu¸i, Phong Qu¸i, L«i Qu¸i<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
                return 0
            end
        end
    elseif (idx == 5) then

        nMoney = 50000
        if (nPlayerLevel > 74) then
            nMoney = math.floor((nPlayerLevel - 65) / 10 * 50000)
        end
        if (GetCash() < nMoney or HaveNormalItem(3, 82, 0, 0) <= 0) then
            Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã Tha S¬n Th¹ch hoÆc b¹c kh«ng ®ñ " .. nMoney .. "<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
            return 0
        end
    elseif (idx == 6) then

        nMoney = 200000
        if (nPlayerLevel > 84) then
            nMoney = math.floor((nPlayerLevel - 75) / 10 * 100000)
        end
        if (GetCash() < nMoney or HaveNormalItem(3, 114, 0, 0) <= 0 or HaveNormalItem(3, 115, 0, 0) <= 0) then
            Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã Lôc §¹o, Tø T­îng tinh hoa hoÆc b¹c kh«ng ®ñ " .. nMoney .. "<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
            return 0
        end
    elseif (idx == 7) then

        local moneynumber = { 1, 1, 2, 3 }
        nMoney = 300000
        if (nPlayerLevel > 104) then
            nMoney = math.floor((nPlayerLevel - 95) / 10 * 200000)
        end
        if (nTaskCount < 1) then
            nTaskCount = 1
        elseif (nTaskCount > 4) then
            nTaskCount = 4
        end
        nMoney = nMoney * moneynumber[nTaskCount]
        if (GetCash() < nMoney or HaveNormalItem(3, 79, 0, 0) <= 0) then
            Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã Hång B¶o Th¹ch hoÆc b¹c kh«ng ®ñ " .. nMoney .. "<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
            return 0
        end
    elseif (idx == 8) then
        if (GetTask(978) ~= math.floor(LocalSystemTime() / 86400)) then
            Talk(1, "no", "ThËt xin lçi, <c=r>cÇn hoµn thµnh thÝ luyÖn ThÊt Qu¶i hµng ngµy<c> míi cã thÓ nhËn nhiÖm vô B¨ng Ho¶ Long Ch©u!")
            return 0
        end

        for i = 15, 21 do
            if (HaveNormalItem(3, i, 0, 0) < 1) then
                Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã §Þa Qu¸i, Thuû Qu¸i, Ho¶ Qu¸i, S¬n Qu¸i, Tr¹ch Qu¸i, Phong Qu¸i, L«i Qu¸i<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
                return 0
            end
        end
    elseif (idx == 9) then
        nMoney = 5000
        if (nPlayerLevel > 55) then
            nMoney = nMoney + math.floor((nPlayerLevel - 36) / 20) * 10000
        end
        if (GetCash() < nMoney or HaveEventItem(48) <= 0) then
            Talk(1, "no", "ThËt xin lçi, trong hµnh trang <c=r>kh«ng cã H¹t gièng hoÆc b¹c kh«ng ®ñ " .. nMoney .. "<c>, kh«ng thÓ ph¸i ThÇn T­íng ®i hoµn thµnh nhiÖm vô nµy gióp ngµi!")
            return 0
        end
    end
    return 1
end

function CostThemeTaskItemAndMoney(nTaskID, nTaskCount)
    local nPlayerLevel = GetLevel()
    local nMoney = 0
    local idx = tbl_ThemeList[nTaskID].id
    if (idx == 4) or (idx == 8) then
        for i = 15, 21 do
            DelNormalItem(3, i, 0, 0)
        end
    elseif (idx == 5) then

        nMoney = 50000
        if (nPlayerLevel > 74) then
            nMoney = math.floor((nPlayerLevel - 65) / 10 * 50000)
        end
        Pay(nMoney)
        DelNormalItem(3, 82, 0, 0)
    elseif (idx == 6) then

        nMoney = 200000
        if (nPlayerLevel > 84) then
            nMoney = math.floor((nPlayerLevel - 75) / 10 * 100000)
        end
        Pay(nMoney)
        DelNormalItem(3, 114, 0, 0)
        DelNormalItem(3, 115, 0, 0)
    elseif (idx == 7) then

        local moneynumber = { 1, 1, 2, 3 }
        nMoney = 300000
        if (nPlayerLevel > 104) then
            nMoney = math.floor((nPlayerLevel - 95) / 10 * 200000)
        end
        if (nTaskCount < 1) then
            nTaskCount = 1
        elseif (nTaskCount > 4) then
            nTaskCount = 4
        end

        nMoney = nMoney * moneynumber[nTaskCount]
        Pay(nMoney)
        DelNormalItem(3, 79, 0, 0)
    elseif (idx == 9) then

        nMoney = 5000
        if (nPlayerLevel > 55) then
            nMoney = nMoney + math.floor((nPlayerLevel - 36) / 20) * 10000
        end
        Pay(nMoney)
        DelEventItem(48)
    end
end

function AddThemeTask()
    local nStep = 0
    local nCount = 0
    local tblStart = {}
    local countTask = {}
    local leftTask = 0
    local tblList = {}
    local lvl = GetLevel()

    for i = 1, table.getn(tbl_ThemeList) do
        tblList = tbl_ThemeList[i]
        nStep = CheckThemeTaskDay(tblList)

        if (lvl >= tblList.level) then
            if (nStep == 1) then
                AddTaskToSuperManList(G_ThemeTask, tblList.id, G_CAN_DO_TASK, 0)
            else
                countTask = tblList.countTask
                leftTask, a = todayfreetimes(GetTaskByte(countTask[1], countTask[2]))
                if (countTask[4] == 2) then
                    leftTask = leftTask + GetTaskBit(countTask[5], countTask[6])
                end
                if (GetTaskStartTime(G_ThemeTask, tblList.id) > 0) then
                    AddTaskToSuperManList(G_ThemeTask, tblList.id, G_DOING_TASK, leftTask)
                elseif (leftTask < countTask[3]) then
                    nStep = CheckTaskStep(G_ThemeTask, tblList)
                    if (nStep == G_CAN_DO_TASK) then
                        AddTaskToSuperManList(G_ThemeTask, tblList.id, G_CAN_DO_TASK, leftTask)
                    end
                end
            end
        end
    end

    UpdateSuperManTask()
end

function AddCityTask()
    local nStep = 0
    local nCount = 0
    local tblStart = {}
    local countTask = {}
    local leftTask = 0
    local lvl = GetLevel()

    for i = 1, table.getn(tbl_CityList) do
        local nStratTime = GetTaskStartTime(G_CityTask, tbl_CityList[i].id)
        if (nStratTime > 0) or (lvl >= tbl_CityList[i].level and CheckCityInfo(tbl_CityList[i]) > 0) then
            nStep = CheckTaskStep(G_CityTask, tbl_CityList[i])
            if (nStep == G_CAN_DO_TASK or nStratTime > 0) then
                tblStart[table.getn(tblStart) + 1] = tbl_CityList[i].id
                nCount = nCount + 1
            end
        end
    end

    local temp = GetCityTaskCount(4)
    for i = 1, table.getn(tblStart) do
        countTask = tbl_CityList[tblStart[i]].countTask
        leftTask = 0
        if (countTask[4] == 1) then
            leftTask = GetTaskByte(countTask[1], countTask[2])
        elseif (countTask[4] == 4) then
            leftTask = temp
        end
        AddTaskToSuperManList(G_CityTask, tblStart[i], G_CAN_DO_TASK, leftTask)
    end
    UpdateSuperManTask()
end

function AddBoxTask()
    local nNum = 0
    local nTemp = 0
    local tblStart = {}
    local tblTemp = { {}, {}, {}, {} }
    local tblType = { 0, 0, 0, 0 }
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nStartTime = GetTaskByte(G_BoxTimeTask, 1)

    if (nToday ~= nStartTime) then
        ClearSuperBoxTask()
    end

    for i = 1, table.getn(tbl_BoxList) do
        if (GetTaskStartTime(G_BoxTask, tbl_BoxList[i].id) > 0) then
            AddTaskToSuperManList(G_BoxTask, tbl_BoxList[i].id, G_DOING_TASK, 0)
            nNum = nNum + 1
        end
    end

    if (nToday ~= nStartTime) and (nNum == 0) then
        for i = 1, table.getn(tbl_BoxList) do
            if (CheckCanStart(tbl_BoxList[i]) == 1) then
                nTemp = tbl_BoxList[i].nType
                tblType[nTemp] = tblType[nTemp] + 1
                tblTemp[nTemp][tblType[nTemp]] = i
                SetTaskBit(tbl_BoxList[i].useTask[1], tbl_BoxList[i].useTask[2], 0)
            end
        end

        nTemp = 0
        for i = 1, 3 do
            if (tblType[i] > 0) then
                COMMON.RndTable(tblTemp[i])
                for j = 1, math.min(3, tblType[i]) do
                    nTemp = nTemp + 1
                    tblStart[nTemp] = tblTemp[i][j]
                end
            end
        end

        if (nTemp < 8) then
            for i = 1, 3 do
                if (tblType[i] > 3) then
                    for j = 4, tblType[i] do
                        nTemp = nTemp + 1
                        tblStart[nTemp] = tblTemp[i][j]
                        break
                    end
                end
            end
        else
            nTemp = 8
        end
        COMMON.RndTable(tblStart)

        if (tblType[4] >= 1) then
            nTemp = nTemp + 1
            tblStart[nTemp] = tblTemp[4][1]
        end

        if (tblType[4] >= 2) then
            nTemp = nTemp + 1
            tblStart[nTemp] = tblTemp[4][2]
        end

        if (table.getn(tblStart) >= 1) then
            SetTaskByte(G_BoxTimeTask, 1, nToday)
            for i = 1, math.min(nTemp, table.getn(tblStart)) do
                AddTaskToSuperManList(G_BoxTask, tblStart[i], G_CAN_DO_TASK, 0)
            end
        end
    end

    UpdateSuperManTask()
end

function StartTaskTheme(nTaskID, bDoubleExp, nSuperManID1, nSuperManID2, nSuperManID3)
    local nLen = table.getn(tbl_ThemeList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    SetTask(140, nTaskID)
    SetTaskByte(G_BoxTimeTask, 2, nSuperManID1)
    SetTaskByte(G_BoxTimeTask, 3, nSuperManID2)
    SetTaskByte(G_BoxTimeTask, 4, nSuperManID3)
    local tCount = tbl_ThemeList[nTaskID].countTask
    local nTaskCount, a = todayfreetimes(GetTaskByte(tCount[1], tCount[2]))
    if (tCount[4] == 2) then
        nTaskCount = nTaskCount + GetTaskBit(tCount[5], tCount[6])
    end

    if (nTaskCount >= tbl_ThemeList[nTaskID].freeTimes) then
        if (nTaskCount >= tCount[3]) then
            AddTaskToSuperManList(G_ThemeTask, nTaskID, G_CAN_DO_TASK, nTaskCount)
            UpdateSuperManTask()
        end

        local Came, Cv, Cfs = GetCostCoinInfoByIdx(tbl_ThemeList[nTaskID].costid)
        local tempStr = ""
        if (tbl_ThemeList[nTaskID].costitem[5] ~= nil) then
            tempStr = "<c=g>" .. tbl_ThemeList[nTaskID].costitem[5] .. "<c>"
        end
        local costCount = tbl_ThemeList[nTaskID].costitem[4]
        if (costCount == -1) then
            local item_guard = { 1, 2, 4 }
            costCount = item_guard[nTaskCount]
        end

        local task = {
            { tempStr, "setTheme1"; show = 1 },
            { "Tu luyÖn nh©n ®«i", "setTheme2"; show = 0 },
        }
        Cfs = Cfs * costCount
        local str2 = ""
        if (tbl_ThemeList[nTaskID].doubleTask[1] > 0) then
            task[2].show = 1
            str2 = "Tu luyÖn nh©n ®«i lµ dïng l­îng ®¹o cô Th«ng B¶o gÊp ®«i ®Ó nhËn gÊp ®«i phÇn th­ëng"
        end

        SayTask("§©y lµ lÇn nhiÖm vô thø " .. (nTaskCount + 1) .. " h«m nay cña ng­¬i, b¾t ®Çu nhiÖm vô cÇn <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc " .. costCount .. " c¸i" .. tempStr .. ", " .. str2 .. ". Ng­¬i x¸c ®Þnh nhËn nhiÖm vô sao?", task)
    else
        if (tbl_ThemeList[nTaskID].doubletype >= 2) then
            local taskWDay = GetWeekDay()
            local ndoubleList = tbl_ThemeList[nTaskID].doubleTask
            if (GetGlobalValueByte(370, ndoubleList[2]) == 1) then
                if (taskWDay ~= GetTaskByte(ndoubleList[3], 4)) then
                    local nlvllist = tbl_ThemeList[nTaskID].doubleLvl
                    if (tbl_ThemeList[nTaskID].doubletype == 3) then
                        nlvllist = tbl_ThemeList[nTaskID].doubleLvl.total
                    end

                    for i = 1, 6 do
                        if (GetTask(ndoubleList[4]) <= nlvllist[i]) then
                            SetTaskByte(ndoubleList[3], 2, i - 1)
                            break
                        end
                    end
                    SetTaskByte(ndoubleList[3], 4, taskWDay)
                end

                if (taskWDay ~= GetTaskByte(ndoubleList[3], 3)) then
                    if GetTaskByte(ndoubleList[3], 1) < GetTaskByte(ndoubleList[3], 2) then
                        MsgBox("Ng­¬i tuÇn nµy cã <c=g>" .. GetTaskByte(ndoubleList[3], 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· dïng <c=g>" .. GetTaskByte(ndoubleList[3], 1) .. "<c> ngµy\n<c=r>X¸c ®Þnh nh©n ®«i th­ëng h«m nay sao?<c>", "Yes_AcceptDouble", "StartTaskThemeYes")
                        return 1
                    end
                end
            else
                SetTask(ndoubleList[3], 0)
            end
        end
        StartTaskThemeYes(1)
    end
end

function Yes_AcceptDouble()
    CloseDialog()
    local nTaskID = GetTask(140)
    local nLen = table.getn(tbl_ThemeList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    local taskWDay = GetWeekDay()
    local ndoubleList = tbl_ThemeList[nTaskID].doubleTask

    SetTaskByte(ndoubleList[3], 1, GetTaskByte(ndoubleList[3], 1) + 1)
    SetTaskByte(ndoubleList[3], 3, taskWDay)
    StartTaskThemeYes(1)
end

function setTheme1()
    StartTaskThemeYes(1)
end

function setTheme2()
    StartTaskThemeYes(2)
end

function StartTaskThemeYes(bDoubleExp)
    CloseDialog()
    local nTaskID = GetTask(140)
    local nSuperManID1 = GetTaskByte(G_BoxTimeTask, 2)
    local nSuperManID2 = GetTaskByte(G_BoxTimeTask, 3)
    local nSuperManID3 = GetTaskByte(G_BoxTimeTask, 4)

    local nLen = table.getn(tbl_ThemeList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    if ((nSuperManID1 == nil) or (nSuperManID1 <= 0) or (nSuperManID1 > G_ManMax) or (GetSuperManUseID(nSuperManID1) > 0) or (nSuperManID2 > 0 and GetSuperManUseID(nSuperManID2) > 0) or (nSuperManID3 > 0 and GetSuperManUseID(nSuperManID3) > 0)) then
        Talk(1, "no", "ThËt xin lçi, ThÇn T­íng ng­¬i chän ®ang lµm nhiÖm vô.")
        return
    end

    if (bDoubleExp == nil) or (bDoubleExp <= 0) or (bDoubleExp >= 3) then
        bDoubleExp = 1
    end

    local nPlayerLevel = GetLevel()
    if (nPlayerLevel < tbl_ThemeList[nTaskID].level) then
        Talk(1, "no", "CÊp ®é cña ng­¬i ch­a ®ñ.")
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][NhËn nhiÖm vô] cÊp ®é thÊp h¬n " .. tbl_ThemeList[nTaskID].level)
        return
    end

    local tCount = tbl_ThemeList[nTaskID].countTask
    local nTaskCount, nTempCha = todayfreetimes(GetTaskByte(tCount[1], tCount[2]))

    if (tCount[4] == 2) then
        nTaskCount = nTaskCount + GetTaskBit(tCount[5], tCount[6])
    end

    if (nTaskCount >= (tbl_ThemeList[nTaskID].freeTimes + tbl_ThemeList[nTaskID].feeTimes)) then
        Talk(1, "no", "ThËt xin lçi, toµn bé nhiÖm vô h«m nay ®· hoµn thµnh.")
        return
    end

    local nStep = CheckTaskStep(G_ThemeTask, tbl_ThemeList[nTaskID])
    if (nStep == G_DOING_TASK) then
        Talk(1, "no", "ThËt xin lçi, ®ang thùc hiÖn nhiÖm vô nµy, kh«ng thÓ nhËn!")
        return
    elseif (nStep == G_NONE_TASK) then
        Talk(1, "no", "ThËt xin lçi, kh«ng phï hîp ®iÒu kiÖn nhiÖm vô, kh«ng thÓ nhËn!")
        return
    end

    if (CheckThemeTaskItemAndMoney(nTaskID, nTaskCount) <= 0) then
        return
    end

    local nDoubleTask = tbl_ThemeList[nTaskID].doubleTask
    if (nTaskCount >= tbl_ThemeList[nTaskID].freeTimes) then
        local Came, Cv, Cfs = GetCostCoinInfoByIdx(tbl_ThemeList[nTaskID].costid)
        local CostItem = tbl_ThemeList[nTaskID].costitem
        local costCount = CostItem[4]
        if (costCount == -1) then
            local item_guard = { 1, 2, 4 }
            costCount = item_guard[nTaskCount]
        end

        if (nDoubleTask[1] > 0) then
            costCount = costCount * bDoubleExp
            SetTaskByte(nDoubleTask[1], nDoubleTask[2], bDoubleExp)
        end

        if (HaveNormalItem(CostItem[1], CostItem[2], CostItem[3], 0) + math.floor(GetCoin() / Cv) < costCount) then
            Talk(1, "no", "Ng­¬i kh«ng cã " .. costCount .. " c¸i " .. CostItem[5] .. ", Th«ng B¶o còng kh«ng ®ñ " .. (Cfs * costCount) .. ", kh«ng thÓ nhËn nhiÖm vô.")
            return
        end

        if (SetSuperTaskStart(G_ThemeTask, nTaskID, nSuperManID1, nSuperManID2, nSuperManID3) > 0) then
            if (nTaskCount == 0) then
                setThemeTaskDay(nTaskID)
            end

            CostThemeTaskItemAndMoney(nTaskID, nTaskCount)
            local nIdx = -1
            local coinNum = { 0, 0 }
            for i = 1, costCount do
                nIdx = FindAValidIBItem(CostItem[1], CostItem[2], CostItem[3], 0)
                if (nIdx ~= 0) then
                    CostIBItem(nIdx)
                    coinNum[1] = coinNum[1] + 1
                elseif (GetCoin() >= Cv) then
                    coinNum[2] = coinNum[2] + 1
                    CostCoinByIdx(tbl_ThemeList[nTaskID].costid)
                end
            end
            local nStr = "Ng­¬i tiªu phÝ "
            if (coinNum[1] > 0) then
                nStr = nStr .. coinNum[1] .. " c¸i " .. CostItem[5] .. ", "
            end
            if (coinNum[2] > 0) then
                nStr = nStr .. (coinNum[2] * Cfs) .. " Th«ng B¶o."
            end
            Msg2Player(nStr)

            local temp = tbl_ThemeList[nTaskID].useTask
            SetTaskBit(temp[1], temp[2], 1)
            if (tCount[4] == 2) then
                SetTaskByte(tCount[1], tCount[2], nTaskCount + nTempCha)
            else
                SetTaskByte(tCount[1], tCount[2], nTaskCount + 1 + nTempCha)
            end

            if (tbl_ThemeList[nTaskID].name == "VËn chuyÓn") then
                Talk(1, "no", nStr .. " .§ang b¾t ®Çu thùc hiÖn nhiÖm vô. Sö dông <c=y>ThÇn T­íng Dô LÖnh<c> cã thÓ nhanh chãng hoµn thµnh\nSö dông ThÇn T­íng mçi ngµy miÔn phÝ hoµn thµnh nhiÖm vô VËn chuyÓn, phÇn th­ëng b¹c nhËn ®­îc t¨ng 1.5 lÇn.!")
            else
                Talk(1, "no", nStr .. " .§ang b¾t ®Çu thùc hiÖn nhiÖm vô. Sö dông <c=y>ThÇn T­íng Dô LÖnh<c> cã thÓ nhanh chãng hoµn thµnh!")
            end
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_ThemeList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][Tr¶ phÝ]" .. nStr)
        else
            Talk(1, "no", "Kh«ng thÓ tiÕn hµnh nhiÖm vô!")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_ThemeList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][Tr¶ phÝ][ThÊt b¹i]")
        end
    else
        if (SetSuperTaskStart(G_ThemeTask, nTaskID, nSuperManID1, nSuperManID2, nSuperManID3) > 0) then
            setThemeTaskDay(nTaskID)
            CostThemeTaskItemAndMoney(nTaskID, nTaskCount)
            local temp = tbl_ThemeList[nTaskID].useTask
            SetTaskBit(temp[1], temp[2], 1)
            if (tCount[4] == 2) then
                SetTaskByte(tCount[1], tCount[2], nTaskCount + nTempCha)
            else
                SetTaskByte(tCount[1], tCount[2], nTaskCount + 1 + nTempCha)
            end

            if (nDoubleTask[1] ~= -1) then
                SetTaskByte(nDoubleTask[1], nDoubleTask[2], 1)
            end

            if (tbl_ThemeList[nTaskID].name == "VËn chuyÓn") then
                Talk(1, "no", "B¾t ®Çu tiÕn hµnh nhiÖm vô. Sö dông <c=y>ThÇn T­íng Dô LÖnh<c> cã thÓ nhanh chãng hoµn thµnh\nSö dông ThÇn T­íng mçi ngµy miÔn phÝ hoµn thµnh nhiÖm vô VËn chuyÓn, phÇn th­ëng b¹c nhËn ®­îc t¨ng 1.5 lÇn.!")
            else
                Talk(1, "no", "B¾t ®Çu tiÕn hµnh nhiÖm vô. Sö dông <c=y>ThÇn T­íng Dô LÖnh<c> cã thÓ nhanh chãng hoµn thµnh!")
            end
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_ThemeList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô] ID ThÇn T­íng " .. nSuperManID1)
        else
            Talk(1, "no", "Kh«ng thÓ tiÕn hµnh nhiÖm vô!")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_ThemeList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][ThÊt b¹i]")
        end
    end
end

function StartTaskCity(nTaskID, bDoubleExp, nSuperManID1, nSuperManID2, nSuperManID3)
    local nLen = table.getn(tbl_CityList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    SetTask(140, nTaskID)
    SetTask(141, bDoubleExp)
    SetTaskByte(G_BoxTimeTask, 2, nSuperManID1)
    SetTaskByte(G_BoxTimeTask, 3, nSuperManID2)
    SetTaskByte(G_BoxTimeTask, 4, nSuperManID3)
    local tCount = tbl_CityList[nTaskID].countTask
    local nTaskCount = GetTaskByte(tCount[1], tCount[2])
    if (table.getn(tCount) and nTaskCount >= tbl_CityList[nTaskID].freeTimes) then
        local Came, Cv, Cfs = GetCostCoinInfoByIdx(tbl_CityList[nTaskID].costid)

        if (tbl_CityList[nTaskID].costitem == nil or tbl_CityList[nTaskID].costitem[5] == nil) then
            MsgBox("§©y lµ lÇn thø " .. (nTaskCount + 1) .. " b¾t ®Çu nhiÖm vô, cÇn <c=g>" .. Cfs .. " Th«ng B¶o<c>. Ng­¬i x¸c ®Þnh nhËn nhiÖm vô sao?", "StartTaskCityYes", "StartTaskCityNo")
        else
            MsgBox("§©y lµ lÇn thø " .. (nTaskCount + 1) .. " b¾t ®Çu nhiÖm vô, cÇn <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc <c=g>" .. tbl_CityList[nTaskID].costitem[5] .. "<c>. Ng­¬i x¸c ®Þnh nhËn nhiÖm vô sao?", "StartTaskCityYes", "StartTaskCityNo")
        end

    else
        StartTaskCityYes()
    end
end

function StartTaskCityNo()
    CloseDialog()
    local nTaskID = GetTask(140)
    local nLen = table.getn(tbl_CityList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end
    Msg2Player("Huû tr¶ phÝ b¾t ®Çu nhiÖm vô lÇn nµy!")
end

function StartTaskCityYes()
    CloseDialog()
    local nTaskID = GetTask(140)
    local bDoubleExp = GetTask(141)
    local nSuperManID1 = GetTaskByte(G_BoxTimeTask, 2)
    local nSuperManID2 = GetTaskByte(G_BoxTimeTask, 3)
    local nSuperManID3 = GetTaskByte(G_BoxTimeTask, 4)
    local nLen = table.getn(tbl_CityList)
    local lvl = GetLevel()
    bDoubleExp = 0

    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    if (lvl < tbl_CityList[nTaskID].level or CheckCityInfo(tbl_CityList[nTaskID]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ng­êi kh«ng ®ñ ®iÒu kiÖn nhiÖm vô, kh«ng thÓ tiÕn hµnh lµm nhiÖm vô.")
        return
    end

    if ((nSuperManID1 == nil) or (nSuperManID1 <= 0) or (nSuperManID1 > G_ManMax) or (GetSuperManUseID(nSuperManID1) > 0) or (nSuperManID2 > 0 and GetSuperManUseID(nSuperManID2) > 0) or (nSuperManID3 > 0 and GetSuperManUseID(nSuperManID3) > 0)) then
        Talk(1, "no", "ThËt xin lçi, ThÇn T­íng ng­¬i chän ®ang lµm nhiÖm vô.")
        return
    end

    local tCount = tbl_CityList[nTaskID].countTask
    local nTaskCount = GetTaskByte(tCount[1], tCount[2])
    if (nTaskCount >= (tbl_CityList[nTaskID].freeTimes + tbl_CityList[nTaskID].feeTimes)) then
        Talk(1, "no", "ThËt xin lçi, toµn bé nhiÖm vô h«m nay ®· hoµn thµnh.")
        return
    end

    local nStep = CheckTaskStep(G_CityTask, tbl_CityList[nTaskID])
    if (nStep == G_DOING_TASK) then
        Talk(1, "no", "ThËt xin lçi, ®ang thùc hiÖn nhiÖm vô nµy, kh«ng thÓ nhËn!")
        return
    elseif (nStep == G_NONE_TASK) then
        Talk(1, "no", "ThËt xin lçi, kh«ng phï hîp ®iÒu kiÖn nhiÖm vô, kh«ng thÓ nhËn!")
        return
    end

    local nMoney = 0
    if (tbl_CityList[nTaskID].name == "Hoa thÇn bÝ") then
        nMoney = 20000
        if (GetLevel() > 50) then
            nMoney = nMoney + math.floor((GetLevel() - 31) / 20) * 40000
        end
        if (GetTask(888) >= 10) then
            nMoney = nMoney / 2
        end
        if (GetCash() < nMoney) then
            Talk(1, "no", "ThËt xin lçi, trong hµnh trang b¹c kh«ng ®ñ, kh«ng thÓ sai khiÕn ThÇn T­íng lµm nhiÖm vô nµy.")
            return
        end
    end

    if (tbl_CityList[nTaskID].id <= 8) then
        if (get_stamina() < tbl_CityList[nTaskID].costid) then
            Talk(1, "no", "ThËt xin lçi, ®iÓm hµnh ®éng hiÖn t¹i kh«ng ®ñ, kh«ng thÓ nhËn nhiÖm vô.")
            return
        end
    end

    if (nTaskCount >= tbl_CityList[nTaskID].freeTimes) and (tbl_CityList[nTaskID].id > 8) then
        local Came, Cv, Cfs = GetCostCoinInfoByIdx(tbl_CityList[nTaskID].costid)
        local CostItem = tbl_CityList[nTaskID].costitem
        local costCount = CostItem[4]

        if (bDoubleExp > 0) then
            Cv = Cv * 2
            costCount = costCount * 2
        end

        if (HaveNormalItem(CostItem[1], CostItem[2], CostItem[3], 0) + math.floor(GetCoin() / Cv) < costCount) then
            Talk(1, "no", "Ng­¬i kh«ng cã " .. CostItem[5] .. ", Th«ng B¶o còng kh«ng ®ñ " .. (Cfs * costCount) .. ", kh«ng thÓ nhËn nhiÖm vô.")
            return
        end

        if (SetSuperTaskStart(G_CityTask, nTaskID, nSuperManID1, nSuperManID2, nSuperManID3) > 0) then
            local nIdx = -1
            local coinNum = { 0, 0 }
            for i = 1, costCount do
                nIdx = FindAValidIBItem(CostItem[1], CostItem[2], CostItem[3], 0)
                if (nIdx ~= 0) then
                    CostIBItem(nIdx)
                    coinNum[1] = coinNum[1] + 1
                elseif (CostCoinByIdx(tbl_CityList[nTaskID].costid) > 0) then
                    coinNum[2] = coinNum[2] + 1
                end
            end

            local nStr = "Ng­¬i tiªu phÝ "
            if (coinNum[1] > 0) then
                nStr = nStr .. coinNum[1] .. "." .. CostItem[5] .. ","
            end
            if (coinNum[2] > 0) then
                nStr = nStr .. (coinNum[2] * Cfs) .. " Th«ng B¶o."
            end
            Msg2Player(nStr)

            local temp = tbl_CityList[nTaskID].useTask
            SetTaskBit(temp[1], temp[2], 1)
            SetTaskByte(tCount[1], tCount[2], nTaskCount + 1)

            if (nMoney > 0) then
                Pay(nMoney)
            end
            Talk(1, "no", nStr .. " nhiÖm vô ®ang ®­îc b¾t ®Çu thùc hiÖn.")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_CityList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][Tr¶ phÝ]" .. nStr)
        else
            Talk(1, "no", "Kh«ng thÓ tiÕn hµnh nhiÖm vô!")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_CityList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][Tr¶ phÝ][ThÊt b¹i]")
        end
    else
        if (SetSuperTaskStart(G_CityTask, nTaskID, nSuperManID1, nSuperManID2, nSuperManID3) > 0) then
            local temp = tbl_CityList[nTaskID].useTask
            SetTaskBit(temp[1], temp[2], 1)
            SetTaskByte(tCount[1], tCount[2], nTaskCount + 1)
            if (tbl_CityList[nTaskID].id <= 8) then
                cost_stamina(tbl_CityList[nTaskID].costid)
            else
                if (nMoney > 0) then
                    Pay(nMoney)
                end
            end
            Talk(1, "no", "NhiÖm vô ®ang ®­îc b¾t ®Çu thùc hiÖn.")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_CityList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô] ID ThÇn T­íng " .. nSuperManID1)
        else
            Talk(1, "no", "Kh«ng thÓ tiÕn hµnh nhiÖm vô!")
            WriteLog("[NhiÖm vô ThÇn T­íng][" .. tbl_CityList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô][ThÊt b¹i]")
        end
    end
end

function StartTaskBox(nTaskID, bDoubleExp, nSuperManID1, nSuperManID2, nSuperManID3)
    local nLen = table.getn(tbl_BoxList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    if ((nSuperManID1 == nil) or (nSuperManID1 <= 0) or (nSuperManID1 > G_ManMax) or (GetSuperManUseID(nSuperManID1) > 0) or (nSuperManID2 > 0 and GetSuperManUseID(nSuperManID2) > 0) or (nSuperManID3 > 0 and GetSuperManUseID(nSuperManID3) > 0)) then
        Talk(1, "no", "ThËt xin lçi, ThÇn T­íng ng­¬i chän ®ang lµm nhiÖm vô.")
        return
    end

    local useTask = tbl_BoxList[nTaskID].useTask
    if (GetTaskBit(useTask[1], useTask[2]) ~= 0) then
        Talk(1, "no", "NhiÖm vô ®· qu¸ h¹n, kh«ng thÓ nhËn!")
        return
    end

    if (SetSuperTaskStart(G_BoxTask, nTaskID, nSuperManID1, nSuperManID2, nSuperManID3) > 0) then
        SetTaskBit(useTask[1], useTask[2], 1)
        local nMan = { nSuperManID1, nSuperManID2, nSuperManID3 }
        local key = 0

        for i = 1, 3 do
            if (nMan[i] > 0) then
                if (IsActiveSkill(nTaskType, nTaskID, nMan[i], 13) > 0) then
                    key = key + tbl_BoxList[nTaskID].time * 3600 * 10 / 100
                end

                if (IsActiveSkill(nTaskType, nTaskID, nMan[i], 14) > 0) then
                    key = key + tbl_BoxList[nTaskID].time * 3600 * 30 / 100
                end
            end
        end

        if (key > 0) then
            local SuperTaskTime = GetTaskStartTime(G_BoxTask, nTaskID) - key
            SetTaskStartTime(G_BoxTask, nTaskID, SuperTaskTime)
        end

        Talk(1, "no", "NhiÖm vô ®ang ®­îc b¾t ®Çu thùc hiÖn.")
        WriteLog("[B¶o r­¬ng ThÇn T­íng][" .. tbl_BoxList[nTaskID].name .. "][B¾t ®Çu nhiÖm vô] ID ThÇn T­íng " .. nSuperManID1)
    else
        Talk(1, "no", "Kh«ng thÓ tiÕn hµnh nhiÖm vô!")
    end
end

function FinishTaskTheme(nTaskID)
    local nLen = table.getn(tbl_ThemeList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    local taskName = tbl_ThemeList[nTaskID].name
    local useTask = tbl_ThemeList[nTaskID].useTask

    if (GetTaskBit(useTask[1], useTask[2]) == 0) then
        Talk(1, "no", taskName .. " nhiÖm vô ph¸t sinh lçi.")
        SetTaskStartTime(G_ThemeTask, nTaskID, 0)
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Rµ so¸t nhiÖm vô]")
        return
    end

    local nPlayerLevel = GetLevel()
    if (nPlayerLevel < tbl_ThemeList[nTaskID].level) then
        Talk(1, "no", taskName .. " nhiÖm vô ph¸t sinh lçi.")
        SetTaskStartTime(G_ThemeTask, nTaskID, 0)
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Rµ so¸t nhiÖm vô] cÊp ®é thÊp h¬n " .. tbl_ThemeList[nTaskID].level)
        return
    end

    local nSuperManID, Man2, Man3 = GetTaskUseSuperMan(G_ThemeTask, nTaskID)
    if (SetSuperTaskEnd(G_ThemeTask, nTaskID, 0) <= 0) then
        Talk(1, "no", taskName .. " nhiÖm vô ch­a hoµn thµnh, kh«ng thÓ nhËn th­ëng!")
        return
    end

    local CDTime = SystemTime() - GetTask(G_SuperManCD)
    if (CDTime < 600) then
        local nMan = { nSuperManID, Man2, Man3 }
        for i = 1, 3 do
            if (nMan[i] > 0) and (GetTaskByte(G_SuperManID, i) == nMan[i]) then
                AddSuperManDelayTime(nMan[i], 600 + SystemTime())
            end
        end
        SetTask(G_SuperManCD, 0)
    end

    local nDouble = 1
    local logstr = ""
    local nDoubleTask = tbl_ThemeList[nTaskID].doubleTask
    if (nDoubleTask[1] > 0) then
        nDouble = GetTaskByte(nDoubleTask[1], nDoubleTask[2])
        logstr = "GÊp ®«i " .. nDouble
    end

    local skilllist = tbl_ThemeList[nTaskID].skill
    local nSuperDouble = 0
    local skillLvl = 0
    for i = 1, #skilllist do
        if (skilllist[i] > 1) then
            skillLvl = IsActiveSkill(G_ThemeTask, nTaskID, nSuperManID, skilllist[i])
            if (skillLvl > 0) then
                nSuperDouble = GetSkillValueByID(skilllist[i], G_TaskReward)
                if (nSuperDouble > 0) then
                    skillLvl = math.floor((GetSuperManLevel(nSuperManID) + 1) / 10) - skillLvl + 2
                    nSuperDouble = nSuperDouble / 100 * skillLvl
                    nDouble = nDouble + nSuperDouble
                    Msg2Player("Sö dông kü n¨ng ThÇn T­íng ®Æc thï, nhËn ®­îc nhiÒu phÇn th­ëng h¬n.")
                    logstr = logstr .. " ThÇn Kü " .. nSuperDouble
                end
            end
        end
    end

    local nWeekDay = GetWeekDay()
    if (tbl_ThemeList[nTaskID].doubleTask[1] == -1) then
        if (GetTaskByte(tbl_ThemeList[nTaskID].doubleTask[3], 3) == nWeekDay) then
            nDouble = nDouble + 1
            Msg2Player("TuÇn nµy lµ " .. tbl_ThemeList[nTaskID].doublename .. " ng­¬i ®· më h«m nay lµ ngµy nhËn th­ëng, hoµn thµnh nhiÖm vô nhËn gÊp ®«i kinh nghiÖm.")
            logstr = logstr .. " ®· më " .. tbl_ThemeList[nTaskID].doublename
        end
    end

    if (tbl_ThemeList[nTaskID].themeday == nWeekDay) then

        nDouble = nDouble + 1
        Msg2Player("H«m nay lµ " .. taskName .. "-Chñ ®Ò ngµy, th­ëng kinh nghiÖm gÊp ®«i.")
        logstr = logstr .. "Chñ ®Ò ngµy"

        if (HaveIBBuff(1523) > 0) then
            nDouble = nDouble + 1
            CostIBBuff(1523, 1)
            Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
            logstr = logstr .. "Chñ ®Ò phï"
        end
        local nBuffLevel = GetIBBuffLevel(1480) + 1
        if (HaveIBBuff(1480) > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
            nDouble = nDouble + nBuffLevel
            Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
            logstr = logstr .. "Ho¹t ®éng" .. nBuffLevel
        end

        if (IsActiveSkill(G_ThemeTask, nTaskID, nSuperManID, 1) > 0) then
            nSuperDouble = GetSkillValueByID(1, G_TaskReward)
            if (nSuperDouble > 0) then
                nSuperDouble = nSuperDouble / 100 * math.floor((GetSuperManLevel(nSuperManID) + 1) / 10)
                nDouble = nDouble + nSuperDouble
                Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, ThÇn T­íng nµy ®· kÝch ho¹t ThÇn T­íng Chi Lùc, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "ThÇn T­íng Chi Lùc" .. nSuperDouble
            end
        end
        if (IsActiveSkill(G_ThemeTask, nTaskID, nSuperManID, 15) > 0) then
            nSuperDouble = GetSkillValueByID(15, G_TaskReward)
            if (nSuperDouble > 0) then
                nSuperDouble = nSuperDouble / 100
                nDouble = nDouble + nSuperDouble
                Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, ThÇn T­íng nµy ®· kÝch ho¹t Hçn Nguyªn Ch©u T¸n, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "Hçn Nguyªn Ch©u T¸n" .. nSuperDouble
            end
        end
    end

    local totaltime = GetTask(tbl_ThemeList[nTaskID].totalTask)
    if (tbl_ThemeList[nTaskID].doubletype == 1) or (tbl_ThemeList[nTaskID].doubletype == 3) then
        local nTotal = {}
        for i = 1, 2 do
            nTotal = tbl_ThemeList[nTaskID].doubleLvl[i]
            if (nPlayerLevel >= nTotal[1] and totaltime >= nTotal[2]) then
                nDouble = nDouble + nTotal[3]
                Msg2Player("Tæng ®· hoµn thµnh " .. totaltime .. " lÇn, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "TÝch lòy hoµn thµnh " .. totaltime
                break
            end
        end
    end

    local nThisCount = GetTaskByte(tbl_ThemeList[nTaskID].countTask[1], tbl_ThemeList[nTaskID].countTask[2])
    nThisCount, a = todayfreetimes(nThisCount)
    local nExp = tbl_ThemeList[nTaskID].exp
    local nSuperManExp = tbl_ThemeList[nTaskID].time * 100
    local nStr = ""
    if (tbl_ThemeList[nTaskID].bible > 0) then

        local k = 2
        if (nThisCount == 0) then
            nThisCount = 1
        end

        if (nThisCount < tbl_ThemeList[nTaskID].freeTimes) then
            k = 1
        elseif (nThisCount >= tbl_ThemeList[nTaskID].feeTimes + tbl_ThemeList[nTaskID].freeTimes) then
            k = 3
        end
        SyncBibleState(tbl_ThemeList[nTaskID].bible, k, 1)

    end

    if (nExp > 0) then
        nExp = math.floor(GetLevel() * nExp * nDouble)
        if (taskName == "Tèng Töu") then
            local item_guard = { 7, 9, 19, 37 }
            nExp = nExp * item_guard[nThisCount]
        end
        AddOwnExp(nExp)
        nStr = nExp .. " ®iÓm kinh nghiÖm"
    end

    local nItem = tbl_ThemeList[nTaskID].item
    if (table.getn(nItem) >= 6) then
        local nItemNum = math.floor(nItem[5] * nDouble)
        for i = 1, nItemNum do
            AddNormalItemPile(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0)
        end
        nStr = nStr .. nItemNum .. " c¸i " .. nItem[6] .. ", "
    end

    local nMoney = 120
    if (nTaskID == 1) then
        if (nPlayerLevel < 40) then
            nMoney = nMoney * 300
        elseif (nPlayerLevel < 50) then
            nMoney = nMoney * 400
        elseif (nPlayerLevel < 60) then
            nMoney = nMoney * 500
        elseif (nPlayerLevel < 70) then
            nMoney = nMoney * 600
        else
            nMoney = nMoney * 700
        end
        if (nThisCount <= 2) then
            nMoney = math.floor(nMoney * 1.5)
            EarnBind(nMoney)
            nStr = nStr .. nMoney .. " b¹c kho¸, "
        else
            Earn(nMoney)
            nStr = nStr .. nMoney .. " b¹c, "
        end
    end

    local nItemRate = {}
    local rand = 0
    if (taskName == "Long Ch©u") then
        rand = math.random(1, 200)
        for i = 1, 4 do
            if (totaltime >= tbl_ThemeList[nTaskID].doubleLvl[i]) then
                nItemRate = tbl_ThemeList[nTaskID].itemRate[i]
                break
            end
        end

        local nItemidx1 = 124
        local nItemidx2 = 125
        nDouble = math.floor(nDouble)
        nStr = nStr .. nDouble .. " c¸i "
        if (rand <= nItemRate[1]) then
            nStr = nStr .. "B¨ng Long Ch©u, "
            nItemidx2 = 124
        elseif (rand <= nItemRate[2]) then
            nStr = nStr .. "Ho¶ Long Ch©u, "
            nItemidx1 = 125
        else
            nStr = nStr .. "B¨ng Ho¶ Long Ch©u, "
        end

        for j = nItemidx1, nItemidx2 do
            for i = 1, nDouble do
                AddNormalItemPile(3, j, 0, 0, 0, 0)
            end
        end
    else
        rand = math.random(1, 100)
        nItemRate = tbl_ThemeList[nTaskID].itemRate
        local eRate = 0
        if (nTaskID == 5) then
            skillLvl = IsActiveSkill(G_ThemeTask, nTaskID, nSuperManID, 39)
            if (skillLvl > 0) then
                skillLvl = math.floor((GetSuperManLevel(nSuperManID) + 1) / 10) - skillLvl + 2
                eRate = GetSkillValueByID(39, G_TaskRate) * skillLvl
                logstr = logstr .. "L©m Tiªn Lé" .. eRate
                if (eRate < 0) then
                    eRate = 0
                end
            end
        end
        logstr = logstr .. "§¹o cô ngÉu nhiªn " .. rand

        if (table.getn(nItemRate) >= 6 and rand <= nItemRate[1] + eRate) then
            for i = 1, nItemRate[6] do
                AddNormalItemPile(nItemRate[2], nItemRate[3], nItemRate[4], nItemRate[5], 0, 0)
            end
            if (tbl_ThemeList[nTaskID].itemName ~= nil and tbl_ThemeList[nTaskID].itemName ~= "") then
                nStr = nStr .. nItemRate[6] .. "." .. tbl_ThemeList[nTaskID].itemName
            end
        end

        if (tbl_ThemeList[nTaskID].totalTask ~= -1) then
            SetTask(tbl_ThemeList[nTaskID].totalTask, GetTask(tbl_ThemeList[nTaskID].totalTask) + 1)
        end
    end
    rand = math.random(1, 100)
    if (rand == 2) or (rand == 50) or (rand == 95) then
        ScrollMessage("NhËn ®­îc thªm 1 <c=y>ThÇn T­íng Dô LÖnh")
        AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
        Msg2Player("Chóc mõng ng­¬i nhËn ®­îc thªm 1 ThÇn T­íng Dô LÖnh")
        nStr = nStr .. "1 c¸i ThÇn T­íng Dô LÖnh"
    end

    SetTaskBit(useTask[1], useTask[2], 0)
    SetTask(TaskSuperManFinish, GetTask(TaskSuperManFinish) + 1)
    local nManLvl = GetSuperManLevel(nSuperManID)
    if (nManLvl >= 50) then
        Msg2Player("B¹n nh©n ®­îc " .. nStr .. ", thÇn t­íng ®· ®¹t cÊp tèi ®a, kh«ng thÓ nhËn kinh nghiÖm ThÇn T­íng.")
    else
        Msg2Player("B¹n nh©n ®­îc " .. nStr .. " vµ " .. nSuperManExp .. " ®iÓm kinh nghiÖm ThÇn T­íng.")
        AddSuperManExp(nSuperManID, nSuperManExp)
    end

    CloseDialog()
    WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Hoµn thµnh nhiÖm vô][phÇn th­ëng: " .. nStr .. "][Béi sè]" .. nDouble .. "[ ID ThÇn T­íng ]" .. nSuperManID .. logstr)

    if (GetActiveTaskIndex() == 60) then
        SetActiveSign();
    end
end

function FinishTaskCity(nTaskID)
    local nLen = table.getn(tbl_CityList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    local taskName = tbl_CityList[nTaskID].name
    local useTask = tbl_CityList[nTaskID].useTask
    if (GetTaskBit(useTask[1], useTask[2]) == 0) then
        Talk(1, "no", taskName .. " nhiÖm vô ph¸t sinh lçi.")
        SetTaskStartTime(G_CityTask, nTaskID, 0)
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Rµ so¸t nhiÖm vô][nTaskID:" .. nTaskID .. "]")
        return
    end

    local nSuperManID, Man2, Man3 = GetTaskUseSuperMan(G_CityTask, nTaskID)
    if (SetSuperTaskEnd(G_CityTask, nTaskID, 0) <= 0) then
        Talk(1, "no", taskName .. " nhiÖm vô ch­a hoµn thµnh, kh«ng thÓ nhËn th­ëng!")
        return
    end

    local tCount = tbl_CityList[nTaskID].countTask
    local nDouble = 1
    local logstr = ""

    local skilllist = tbl_CityList[nTaskID].skill
    local nSuperDouble = 0
    local skillLvl = 0
    for i = 1, #skilllist do
        if (skilllist[i] > 1) then
            skillLvl = IsActiveSkill(G_CityTask, nTaskID, nSuperManID, skilllist[i])
            if (skillLvl > 0) then
                nSuperDouble = GetSkillValueByID(skilllist[i], G_TaskReward)
                if (nSuperDouble > 0) then
                    skillLvl = math.floor((GetSuperManLevel(nSuperManID) + 1) / 10) - skillLvl + 2
                    nSuperDouble = nSuperDouble / 100 * skillLvl
                    nDouble = nDouble + nSuperDouble
                    Msg2Player("Sö dông kü n¨ng ThÇn T­íng ®Æc thï, nhËn ®­îc nhiÒu phÇn th­ëng h¬n.")
                    logstr = logstr .. " ThÇn Kü " .. nSuperDouble
                end
            end
        end
    end

    local nWeekDay = GetWeekDay()
    if (tbl_CityList[nTaskID].themeday ~= nil and tbl_CityList[nTaskID].themeday == nWeekDay) then
        nDouble = nDouble + 1
        Msg2Player("H«m nay lµ " .. taskName .. "-Chñ ®Ò ngµy, th­ëng kinh nghiÖm gÊp ®«i.")
        logstr = logstr .. "Chñ ®Ò ngµy"

        if (HaveIBBuff(1523) > 0) then
            nDouble = nDouble + 1
            CostIBBuff(1523, 1)
            Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
            logstr = logstr .. "Chñ ®Ò phï"
        end
        local nBuffLevel = GetIBBuffLevel(1480) + 1
        if (HaveIBBuff(1480) > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
            nDouble = nDouble + nBuffLevel
            Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
            logstr = logstr .. "Ho¹t ®éng" .. nBuffLevel
        end

        if (IsActiveSkill(G_CityTask, nTaskID, nSuperManID, 1) > 0) then
            nSuperDouble = GetSkillValueByID(1, G_TaskReward)
            if (nSuperDouble > 0) then
                nSuperDouble = nSuperDouble / 100 * math.floor((GetSuperManLevel(nSuperManID) + 1) / 10)
                nDouble = nDouble + nSuperDouble
                Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, ThÇn T­íng nµy ®· kÝch ho¹t ThÇn T­íng Chi Lùc, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "ThÇn T­íng Chi Lùc" .. nSuperDouble
            end
        end
        if (IsActiveSkill(G_CityTask, nTaskID, nSuperManID, 15) > 0) then
            nSuperDouble = GetSkillValueByID(15, G_TaskReward)
            if (nSuperDouble > 0) then
                nSuperDouble = nSuperDouble / 100
                nDouble = nDouble + nSuperDouble
                Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, ThÇn T­íng nµy ®· kÝch ho¹t Hçn Nguyªn Ch©u T¸n, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "Hçn Nguyªn Ch©u T¸n" .. nSuperDouble
            end
        end
    end

    local nExp = math.floor(GetLevel() * tbl_CityList[nTaskID].exp * nDouble)
    local nSuperManExp = tbl_CityList[nTaskID].time * 100
    SetTaskBit(useTask[1], useTask[2], 0)
    AddOwnExp(nExp)
    SetTask(TaskSuperManFinish, GetTask(TaskSuperManFinish) + 1)

    local nManLvl = GetSuperManLevel(nSuperManID)
    if (nManLvl >= 50) then
        Msg2Player("B¹n nh©n ®­îc " .. nExp .. ", thÇn t­íng ®· ®¹t cÊp tèi ®a, kh«ng thÓ nhËn kinh nghiÖm ThÇn T­íng.")
    else
        Msg2Player("B¹n nh©n ®­îc " .. nExp .. " ®iÓm kinh nghiÖm vµ " .. nSuperManExp .. " ®iÓm kinh nghiÖm ThÇn T­íng.")
        AddSuperManExp(nSuperManID, nSuperManExp)
    end

    Talk(1, "no", "NhiÖm vô ThÇn T­íng cña ng­¬i: <c=y>" .. taskName .. "<c> ®· hoµn thµnh, nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")

    local nCityTask = tbl_CityList[nTaskID].citytask
    if (nCityTask ~= -1) then
        SetCityTask(nCityTask, GetCityTask(nCityTask) + 1)
    end

    AddTongContri(1)
    Msg2Player("Hoµn thµnh nhiÖm vô thµnh thÞ nhËn ®­îc 1 ®iÓm cèng hiÕn")

    if (taskName == "Hoa thÇn bÝ") then
        AddCityIndexRes(1, 2)
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> Hoµn thµnh 1 vßng nhiÖm vô T×m hoa, H­¬ng liÖu cho thµnh thÞ +2</bc>")
    elseif (taskName == "Thao tr­êng ThÝ luyÖn") then
        AddCityIndexRes(3, 2)
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> Hoµn thµnh nhiÖm vô Thao tr­êng ThÝ luyÖn, huyÒn thiÕt +2</bc>")
    end

    local nRank = math.random(1, 100)
    if (nRank <= 30) then
        AddIBBuff(1013)
        Msg2Player("Chóc mõng b¹n may m¾n nhËn ®­îc 1 lÇn tr¹ng th¸i [Dòng Vâ]!")
        TopMessage("Chóc mõng b¹n nhËn ®­îc tr¹ng th¸i [Dòng Vâ]")
        logstr = logstr .. "Vò dòng"
    end

    if (math.random(1, 100) <= 15 and GetIBBuffTimes(1487) < 20) then
        AddIBBuff(1487)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc tr¹ng th¸i Tinh Anh.")
        TopMessage("Chóc mõng b¹n nhËn ®­îc tr¹ng th¸i Tinh Anh.")
        logstr = logstr .. "Tinh anh"
        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\"> hoµn thµnh NhiÖm vô ThÇn T­íng nhËn ®­îc 1 tr¹ng th¸i Tinh Anh!")
    end

    WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Hoµn thµnh nhiÖm vô][Kinh nghiÖm: " .. nExp .. "] ID ThÇn T­íng " .. nSuperManID .. logstr)
end

function FinishTaskBox(nTaskID)
    local nLen = table.getn(tbl_BoxList)
    if (nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        return
    end

    local taskName = tbl_BoxList[nTaskID].name
    local useTask = tbl_BoxList[nTaskID].useTask
    local nItem = tbl_BoxList[nTaskID].item
    if (table.getn(useTask) < 2 or table.getn(nItem) < 5) then
        Talk(1, "no", taskName .. " nhiÖm vô tr¹ng th¸i bÊt th­êng.")
        return
    end
    if (GetTaskBit(useTask[1], useTask[2]) == 0) then
        Talk(1, "no", taskName .. " nhiÖm vô ph¸t sinh lçi.")
        SetTaskStartTime(G_BoxTask, nTaskID, 0)
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][Rµ so¸t nhiÖm vô][nTaskID:" .. nTaskID .. "]")
        return
    end

    if (IsHaveSpaceForTreasure((tbl_BoxList[nTaskID].bag + 1)) <= 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng ®ñ " .. (tbl_BoxList[nTaskID].bag + 1) .. ", xin h·y s¾p xÕp l¹i.")
        return
    end

    local nRate = 0
    local skilllist = tbl_BoxList[nTaskID].skill
    local nSuperRate = 0
    local nMan1, nMan2, nMan3 = GetTaskUseSuperMan(G_BoxTask, nTaskID)
    local nMan = { nMan1, nMan2, nMan3 }
    local nNum = 0
    local nLvl = 0
    local logstr = ""
    for j = 1, 3 do
        if (nMan[j] > 0) then
            nNum = nNum + 1
            for i = 1, #skilllist do
                if (skilllist[i] > 0) then
                    nLvl = IsActiveSkill(G_BoxTask, nTaskID, nMan[j], skilllist[i])
                    if (nLvl > 0) then
                        nSuperRate = GetSkillValueByID(skilllist[i], G_TaskRate)
                        if (nSuperRate >= 40) then
                            nRate = nRate + nSuperRate
                            Msg2Player("Sö dông kü n¨ng ThÇn T­íng chØ ®Þnh, n©ng cao tû lÖ thµnh c«ng.")
                            logstr = logstr .. "Tr©n b¶o R­¬ng Tû lÖ thµnh c«ng " .. nSuperRate
                        elseif (nSuperRate > 0) then
                            nLvl = math.floor((GetSuperManLevel(nMan[j]) + 1) / 10) - nLvl + 2
                            if (nLvl > 0) then
                                nRate = nRate + nSuperRate * nLvl
                                Msg2Player("Sö dông kü n¨ng ThÇn T­íng chØ ®Þnh, n©ng cao tû lÖ thµnh c«ng.")
                                logstr = logstr .. "ThÇn kü tû lÖ thµnh c«ng " .. nSuperRate .. "* ®¼ng cÊp " .. nLvl
                            end
                        end
                    end
                end
            end
        end
    end
    nRate = math.floor(nRate / nNum) + tbl_BoxList[nTaskID].successRate

    local nStr = ""
    local randkey = math.random(1, 100)
    if (randkey <= nRate) then
        if (SetSuperTaskEnd(G_BoxTask, nTaskID, nSuperManExp) <= 0) then
            Talk(1, "no", taskName .. " nhiÖm vô ch­a hoµn thµnh, kh«ng thÓ nhËn th­ëng!")
            return
        end

        local nItemNum = 1
        for j = 1, 3 do
            if (nMan[j] > 0) then
                if (tbl_BoxList[nTaskID].skillReward > 0) then
                    if (IsActiveSkill(G_BoxTask, nTaskID, nMan[j], tbl_BoxList[nTaskID].skillReward) > 0) then
                        nSuperRate = GetSkillValueByID(tbl_BoxList[nTaskID].skillReward, G_TaskReward)
                        if (nSuperRate > 0) then
                            nSuperRate = math.floor(nSuperRate / 100)
                            nItemNum = nItemNum + nSuperRate
                            Msg2Player("Sö dông kü n¨ng ThÇn T­íng chØ ®Þnh, n©ng cao phÇn th­ëng.")
                            logstr = logstr .. "ThÇn kü th­ëng " .. nSuperRate
                        end
                    end
                end
            end
        end

        nItemNum = nItemNum * nItem[5]
        for i = 1, nItemNum do
            AddNormalItemPile(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0)
        end

        local nSuperManExp = tbl_BoxList[nTaskID].time * 100
        local nManLvl = 0
        local nManLvlKey = 0
        logstr = logstr .. "[ ID ThÇn T­íng :"
        for j = 1, 3 do
            if (nMan[j] > 0) then
                nManLvl = GetSuperManLevel(nMan[j])
                if (nManLvl >= 50) then
                    nManLvlKey = 1
                else
                    AddSuperManExp(nMan[j], nSuperManExp)
                end
                logstr = logstr .. nMan[j] .. "|"
            end
        end
        if (nManLvlKey == 1) then
            nStr = "B¹n nh©n ®­îc " .. nItemNum .. "." .. tbl_BoxList[nTaskID].itemName .. ", cïng " .. nSuperManExp .. " ®iÓm kinh nghiÖm ThÇn T­íng (ThÇn T­íng max cÊp kh«ng thÓ nhËn ®iÓm kinh nghiÖm)."
        else
            nStr = "B¹n nh©n ®­îc " .. nItemNum .. "." .. tbl_BoxList[nTaskID].itemName .. ", cïng " .. nSuperManExp .. " ®iÓm kinh nghiÖm ThÇn T­íng."
        end

        WriteLog("[B¶o r­¬ng ThÇn T­íng][" .. taskName .. "][Hoµn thµnh nhiÖm vô]" .. nStr .. logstr)
    else
        if (SetSuperTaskEnd(G_BoxTask, nTaskID, nSuperManExp) <= 0) then
            Talk(1, "no", taskName .. " nhiÖm vô ch­a hoµn thµnh, kh«ng thÓ nhËn th­ëng!")
            return
        end
        nStr = "ThËt xin lçi, nhiÖm vô thÊt b¹i, lÇn nµy kh«ng cã th­ëng."
        WriteLog("[B¶o r­¬ng ThÇn T­íng][" .. taskName .. "][Hoµn thµnh nhiÖm vô][ThÊt b¹i]" .. logstr .. "(" .. randkey .. "/" .. nRate .. ")")
    end

    SetTaskBit(useTask[1], useTask[2], 0)
    SetTask(TaskSuperManFinish, GetTask(TaskSuperManFinish) + 1)
    Msg2Player(nStr)
    Talk(1, "no", nStr)
end

function CheckTaskIsDoing(nTaskType, nTaskID)
    local tblTemp = {}
    local nFlag = 0
    if (nTaskType == 1 and nTaskID > 0 and nTaskID <= table.getn(tbl_ThemeList)) then
        tblTemp = tbl_ThemeList[nTaskID]
    elseif (nTaskType == 2 and nTaskID > 0 and nTaskID <= table.getn(tbl_CityList)) then
        tblTemp = tbl_CityList[nTaskID]
    else
        return nFlag
    end

    if (table.getn(tblTemp.useTask) >= 2) then
        nFlag = GetTaskBit(tblTemp.useTask[1], tblTemp.useTask[2])
    end

    return nFlag
end

function todayfreetimes(value)
    local nCha = value
    for i = 6, 8 do
        value = SetBit(value, i, 0)
    end

    nCha = nCha - value
    return value, nCha
end

function ImmediateFinishTask(nTaskType, nTaskID)
    local nLen = 0
    local list = {}

    if (nTaskType == 0) then
        list = tbl_ThemeList
    elseif (nTaskType == 1) then
        list = tbl_CityList
    elseif (nTaskType == 2) then
        list = tbl_BoxList
    end
    nLen = table.getn(list)

    if (nLen <= 0 or nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô nµy kh«ng thÓ hoµn thµnh nhanh!")
        return
    end

    if (GetTaskBit(list[nTaskID].useTask[1], list[nTaskID].useTask[2]) == 0) then
        Talk(1, "no", "NhiÖm vô ph¸t sinh lçi.")
        SetTaskStartTime(nTaskType, nTaskID, 0)
        WriteLog("[NhiÖm vô ThÇn T­íng][NhiÖm vô chñ ®Ò Ngµy][Rµ so¸t nhiÖm vô][nTaskID:" .. nTaskID .. "]")
        return
    end

    local SuperTaskTime = GetTaskStartTime(nTaskType, nTaskID)
    local tTimeCha = SystemTime() - SuperTaskTime
    if (tTimeCha >= list[nTaskID].time * 3600 - 1) then
        Talk(1, "no", "NhiÖm vô ®· hoµn thµnh råi, kh«ng cÇn dïng ThÇn T­íng Dô LÖnh ®Ó hoµn thµnh nhanh!")
        SetTaskStartTime(nTaskType, nTaskID, 100)
        return
    elseif (tTimeCha < 0) then
        if (tTimeCha < -1 * list[nTaskID].time * 3600) then
            Talk(1, "no", "NhiÖm vô ®· hoµn thµnh råi, kh«ng cÇn dïng ThÇn T­íng Dô LÖnh ®Ó hoµn thµnh nhanh!")
            SetTaskStartTime(nTaskType, nTaskID, 100)
            return
        end
        SetTaskStartTime(nTaskType, nTaskID, SystemTime())
        tTimeCha = 1
    end

    if (nTaskType > 1) then
        Talk(1, "no", "NhiÖm vô B¶o r­¬ng kh«ng thÓ hoµn thµnh nhanh!")
        UpdateSuperManTask()
        return
    end

    SetTask(140, nTaskID)
    SetTask(141, nTaskType)
    SetTask(142, 1)
    local nTime = list[nTaskID].time * 3600 - tTimeCha
    local sTime = COMMON.FormatTime(nTime)
    local num = math.floor(nTime / 3600) + 1
    local q, q, Cfs = GetCostCoinInfoByIdx(283)
    Cfs = num * Cfs
    local task = {
        { "LËp tøc hoµn thµnh", "saodangYes"; show = 1 },
        { "Hoµn thµnh mµ kh«ng cÇn chê", "saodangYesCd"; show = 1 },
    }
    local Man1, Man2, Man3 = GetTaskUseSuperMan(nTaskType, nTaskID)
    local nMan = { Man1, Man2, Man3 }
    local str = "\n<c=r>Hoµn thµnh nhanh th«ng th­êng ThÇn T­íng nµy sÏ cã 10 phót chê håi phôc kü n¨ng, kh«ng thÓ lËp tøc sö dông; nÕu nh­ tr¶ phÝ gÊp ®«i cã thÓ xo¸ bá thêi gian chê<c>\n"
    for i = 1, 3 do
        if (nMan[i] > 0) then
            if (list[nTaskID].skillcd > 0) then
                if (IsActiveSkill(nTaskType, nTaskID, nMan[i], list[nTaskID].skillcd) > 0) then
                    task[2].show = 0
                    SetTask(142, 3)
                    str = "\n<c=r>ThÇn kü cña ThÇn t­íng nµy ®· ®­îc xo¸ thêi gian håi phôc, kh«ng cÇn chê ®îi, lËp tøc hoµn thµnh<c>\n"
                    break
                end
            end
        end
    end
    SayTask("NhiÖm vô <c=y>" .. list[nTaskID].name .. "<c> cña ng­¬i cßn <c=g>" .. sTime .. "<c>, cÇn " .. num .. " c¸i <c=g>ThÇn T­íng Dô LÖnh<c> hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, " .. str .. " ng­¬i muèn lËp tøc hoµn thµnh sao?", task)
end

function saodangYesCd()
    SetTask(142, 2)
    saodangYes()
end

function saodangYes()
    CloseDialog()
    local nTaskID = GetTask(140)
    local nTaskType = GetTask(141)
    local key = GetTask(142)
    local nLen = 0
    local list = {}
    if (nTaskType == 0) then
        list = tbl_ThemeList
    elseif (nTaskType == 1) then
        list = tbl_CityList
    elseif (nTaskType == 2) then

    end
    nLen = table.getn(list)

    if (nLen <= 0 or nTaskID <= 0 or nTaskID > nLen) then
        Talk(1, "no", "NhiÖm vô nµy kh«ng thÓ hoµn thµnh nhanh!")
        UpdateSuperManTask()
        return
    end

    local SuperTaskTime = GetTaskStartTime(nTaskType, nTaskID)
    local tTimeCha = math.abs(SystemTime() - SuperTaskTime)
    if (tTimeCha > list[nTaskID].time * 3600) then
        SetTaskStartTime(nTaskType, nTaskID, SystemTime())
        tTimeCha = 1
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(283)
    local taskName = list[nTaskID].name
    local nTime = list[nTaskID].time * 3600 - tTimeCha
    local num = math.floor(nTime / 3600) + 1
    local nItem = HaveNormalItem(3, 1637, 0, 0)
    if (key == 2) then
        num = num * 2
    end
    Cv = (num - nItem) * Cv

    if (GetCoin() >= Cv) or (nItem >= num) then
        local coinNum = { 0, 0 }
        for i = 1, num do
            if (DelNormalItem(3, 1637, 0, 0) > 0) then
                coinNum[1] = coinNum[1] + 1
            elseif (CostCoinByIdx(283) > 0) then
                coinNum[2] = coinNum[2] + 1
            end
        end

        local nStr = "Ng­¬i tiªu phÝ "
        if (coinNum[1] > 0) then
            nStr = nStr .. coinNum[1] .. "c¸i ThÇn T­íng Dô LÖnh, "
        end
        if (coinNum[2] > 0) then
            nStr = nStr .. (coinNum[2] * Cfs) .. " Th«ng B¶o."
        end
        Msg2Player(nStr)

        SetTaskStartTime(nTaskType, nTaskID, 100)

        local Man1, Man2, Man3 = GetTaskUseSuperMan(nTaskType, nTaskID)
        local nMan = { Man1, Man2, Man3 }
        local countTask = list[nTaskID].countTask
        local leftTask, a = todayfreetimes(GetTaskByte(countTask[1], countTask[2]))
        if (countTask[4] == 2) then
            leftTask = leftTask + GetTaskBit(countTask[5], countTask[6])
        elseif (countTask[4] == 4) then
            leftTask = GetCityTaskCount(4)
        end

        if (key == 1) then
            for i = 1, 3 do
                if (nMan[i] > 0) then
                    SetTaskByte(G_SuperManID, i, nMan[i])
                end
            end
            SetTask(G_SuperManCD, SystemTime())
            InfoBox(nStr .. "NhiÖm vô ThÇn T­íng cña ng­¬i: <c=y>" .. taskName .. "<c> lÇn thø " .. leftTask .. " ®· hoµn thµnh. §¸ng tiÕc lËp tøc hoµn thµnh tiªu hao qu¸ lín, thÇn t­íng cÇn nghØ ng¬i 10 phót míi cã thÓ tiÕp tôc nhËn nhiÖm vô.")
        else
            InfoBox(nStr .. "NhiÖm vô ThÇn T­íng cña ng­¬i: <c=y>" .. taskName .. "<c> lÇn thø " .. leftTask .. " ®· hoµn thµnh.")
        end

        if (nTaskType == 0) then
            AddTaskToSuperManList(G_ThemeTask, nTaskID, G_FINISH_TASK, leftTask)
            FinishTaskTheme(nTaskID)
        elseif (nTaskType == 1) then
            AddTaskToSuperManList(G_CityTask, nTaskID, G_FINISH_TASK, leftTask)
            FinishTaskCity(nTaskID)
        elseif (nTaskType == 2) then


        end
        WriteLog("[NhiÖm vô ThÇn T­íng][" .. taskName .. "][LËp tøc hoµn thµnh][KiÓu tr¶ tiÒn]" .. key .. "[ ID ThÇn T­íng ]" .. Man1 .. "/" .. Man2 .. "/" .. Man3 .. nStr)
        ORACLEBONE.GetCardWayApply(40, 0)
        ORACLEBONE.GetCardWayApply(41, 0)

        if (GetActiveTaskIndex() == 60) then
            SetActiveSign();
        end
    else
        InfoBox("ThËt xin lçi, nhiÖm vô <c=y>" .. taskName .. "<c> cña ng­¬i, cÇn " .. num .. " <c=g>ThÇn T­íng Dô LÖnh<c> hoÆc <c=g>" .. (num * Cfs) .. "<c> Th«ng B¶o. \nThÇn T­íng Dô LÖnh cã thÓ mua t¹i B¸t B¶o C¸c-LÔ bao, hoÆc §Æc QuyÒn Chu T­íc, B¹ch Hæ hµng ngµy cã tÆng!")
        UpdateSuperManTask()
    end
end

function IsActiveSkill(nTaskType, nTaskID, nManID, nSkillID)
    if (nManID <= 0) or (nSkillID <= 0) or (nManID > 24) or (nTaskID <= 0) then
        return 0
    end

    manlist = {
        [1] = { 0, 1, 11, 15 },
        [2] = { 44, 1, 45, 0 },
        [3] = { 48, 1, 49, 0 },
        [4] = { 50, 1, 51, 0 },
        [5] = { 46, 1, 47, 0 },
        [6] = { 0, 1, 6, 13 },
        [7] = { 0, 1, 8, 3 },
        [8] = { 0, 1, 11, 12 },
        [9] = { 0, 1, 10, 12 },
        [10] = { 0, 1, 7, 27 },
        [11] = { 0, 1, 8, 27 },
        [12] = { 0, 1, 4, 28 },
        [13] = { 31, 1, 30, 0 },
        [14] = { 32, 1, 33, 0 },
        [15] = { 0, 1, 6, 28 },
        [16] = { 0, 1, 4, 26 },
        [17] = { 42, 1, 43, 0 },
        [18] = { 0, 1, 14, 25 },
        [19] = { 0, 1, 5, 14 },
        [20] = { 29, 1, 30, 0 },
        [21] = { 34, 1, 35, 0 },
        [22] = { 36, 1, 37, 0 },
        [23] = { 32, 1, 38, 39 },
        [24] = { 40, 1, 41, 0 },
    }
    local manLvl = math.floor((GetSuperManLevel(nManID) + 1) / 10) + 1
    if (manLvl > 4) then
        manLvl = 4
    end
    for i = 1, manLvl do
        if (manlist[nManID][i] == nSkillID) then
            return i
        end
    end

    return 0
end

function resetSupermanCD()
    for i = 1, 24 do

        local nTID = GetSuperManUseID(i)
        if (nTID <= 0) then
            if (IsSuperManDelayTime(i, SystemTime()) == 0) then

            end
        end

    end
end

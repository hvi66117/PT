module("Able_Pet", package.seeall)
require("newserver.luax")

PetRoleTask = 2109

Value_AblePet = 2071

Task_AblePet = 2072
Break_AblePet = 2073

NeZha_Pet = 2078

Task_NeZhaPet = 2079
Break_NeZhaPet = 2080

LeiZhenZi_Pet = 2091

Task_LeiZhenZiPet = 2092
Break_LeiZhenZiPet = 2093

ShiJi_Pet = 2106

Task_ShiJiPet = 2107
Break_ShiJiPet = 2108

TaiYi_Pet = 2114

Task_TaiYiPet = 2115
Break_TaiYiPet = 2116

DaJi_Pet = 2117

Task_DaJiPet = 2118
Break_DaJiPet = 2119

ShenGongBao_Pet = 2120

Task_ShenGongBaoPet = 2121
Break_ShenGongBaoPet = 2122

HuangFeiHu_Pet = 2123

Task_HuangFeiHuPet = 2124
Break_HuangFeiHuPet = 2125

TaskTable = {
  [1] = { num = 10000, id = { 6, 1, 1339, 1 }, monster = 90, spe = 0, buffid = 1784, petid = 46, petexp = 0.3, petmoney = 3000 * 0.15, useTask = { 2188, 1 }, },
  [2] = { num = 20000, id = { 6, 1, 1340, 1 }, monster = 90, spe = 0, buffid = 1785, petid = 46, petexp = 0.4, petmoney = 3000 * 0.2, useTask = { 2188, 2 }, },
  [3] = { num = 30000, id = { 6, 1, 1341, 1 }, monster = 90, spe = 1, buffid = 1786, petid = 46, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 3 }, },
  [4] = { num = 40000, id = { 6, 1, 1342, 1 }, monster = 100, spe = 0, buffid = 1787, petid = 47, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 4 }, },
  [5] = { num = 50000, id = { 6, 1, 1343, 1 }, monster = 100, spe = 0, buffid = 1788, petid = 47, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 5 }, },
  [6] = { num = 60000, id = { 6, 1, 1344, 1 }, monster = 100, spe = 1, buffid = 1789, petid = 47, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 6 }, },
  [7] = { num = 70000, id = { 6, 1, 1345, 1 }, monster = 110, spe = 0, buffid = 1790, petid = 48, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 7 }, },
  [8] = { num = 80000, id = { 6, 1, 1346, 1 }, monster = 110, spe = 0, buffid = 1791, petid = 48, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 8 }, },
  [9] = { num = 90000, id = { 6, 1, 1347, 1 }, monster = 110, spe = 1, buffid = 1792, petid = 48, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 9 }, },
  [10] = { num = 90000, id = { 6, 1, 1348, 1 }, monster = 110, spe = 0, buffid = 1793, petid = 49, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 10 }, },
  [11] = { num = 90000, id = { 6, 1, 1541, 1 }, monster = 110, spe = 0, buffid = 1936, petid = 83, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2191, 1 }, },
}

TaskTable_NeZha = {
  [1] = { num = 10000, id = { 6, 1, 1359, 1 }, monster = 90, spe = 0, buffid = 1808, petid = 50, petexp = 0.3, petmoney = 3000 * 0.15, useTask = { 2188, 11 }, },
  [2] = { num = 20000, id = { 6, 1, 1360, 1 }, monster = 90, spe = 0, buffid = 1809, petid = 50, petexp = 0.4, petmoney = 3000 * 0.2, useTask = { 2188, 12 }, },
  [3] = { num = 30000, id = { 6, 1, 1361, 1 }, monster = 90, spe = 1, buffid = 1810, petid = 50, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 13 }, },
  [4] = { num = 40000, id = { 6, 1, 1362, 1 }, monster = 100, spe = 0, buffid = 1811, petid = 51, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 14 }, },
  [5] = { num = 50000, id = { 6, 1, 1363, 1 }, monster = 100, spe = 0, buffid = 1812, petid = 51, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 15 }, },
  [6] = { num = 60000, id = { 6, 1, 1364, 1 }, monster = 100, spe = 1, buffid = 1813, petid = 51, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 16 }, },
  [7] = { num = 70000, id = { 6, 1, 1365, 1 }, monster = 110, spe = 0, buffid = 1814, petid = 52, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 17 }, },
  [8] = { num = 80000, id = { 6, 1, 1366, 1 }, monster = 110, spe = 0, buffid = 1815, petid = 52, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 18 }, },
  [9] = { num = 90000, id = { 6, 1, 1367, 1 }, monster = 110, spe = 1, buffid = 1816, petid = 52, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 19 }, },
  [10] = { num = 90000, id = { 6, 1, 1368, 1 }, monster = 110, spe = 0, buffid = 1817, petid = 53, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 20 }, },
  [11] = { num = 90000, id = { 6, 1, 1542, 1 }, monster = 110, spe = 0, buffid = 1937, petid = 84, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2191, 2 }, },
}

TaskTable_LeiZhenZi = {
  [1] = { num = 10000, id = { 6, 1, 1426, 1 }, monster = 90, spe = 0, buffid = 1833, petid = 58, petexp = 0.3, petmoney = 3000 * 0.15, useTask = { 2188, 21 }, },
  [2] = { num = 20000, id = { 6, 1, 1427, 1 }, monster = 90, spe = 0, buffid = 1834, petid = 58, petexp = 0.4, petmoney = 3000 * 0.2, useTask = { 2188, 22 }, },
  [3] = { num = 30000, id = { 6, 1, 1428, 1 }, monster = 90, spe = 1, buffid = 1835, petid = 58, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 23 }, },
  [4] = { num = 40000, id = { 6, 1, 1429, 1 }, monster = 100, spe = 0, buffid = 1836, petid = 59, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 24 }, },
  [5] = { num = 50000, id = { 6, 1, 1430, 1 }, monster = 100, spe = 0, buffid = 1837, petid = 59, petexp = 0.5, petmoney = 3000 * 0.25, useTask = { 2188, 25 }, },
  [6] = { num = 60000, id = { 6, 1, 1431, 1 }, monster = 100, spe = 1, buffid = 1838, petid = 59, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 26 }, },
  [7] = { num = 70000, id = { 6, 1, 1432, 1 }, monster = 110, spe = 0, buffid = 1839, petid = 60, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 27 }, },
  [8] = { num = 80000, id = { 6, 1, 1433, 1 }, monster = 110, spe = 0, buffid = 1840, petid = 60, petexp = 0.8, petmoney = 3000 * 0.4, useTask = { 2188, 28 }, },
  [9] = { num = 90000, id = { 6, 1, 1434, 1 }, monster = 110, spe = 1, buffid = 1841, petid = 60, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 29 }, },
  [10] = { num = 90000, id = { 6, 1, 1435, 1 }, monster = 110, spe = 0, buffid = 1842, petid = 61, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2188, 30 }, },
  [11] = { num = 90000, id = { 6, 1, 1543, 1 }, monster = 110, spe = 0, buffid = 1938, petid = 85, petexp = 1, petmoney = 3000 * 0.5, useTask = { 2191, 3 }, },
}

TaskTable_ShiJi = {
  [1] = { num = 10000, id = { 6, 1, 1448, 1 }, monster = 90, spe = 0, buffid = 1847, petid = 62, petexp = 0.3, petmoney = 0, useTask = { 2188, 31 }, },
  [2] = { num = 20000, id = { 6, 1, 1449, 1 }, monster = 90, spe = 0, buffid = 1848, petid = 62, petexp = 0.4, petmoney = 0, useTask = { 2189, 1 }, },
  [3] = { num = 30000, id = { 6, 1, 1450, 1 }, monster = 90, spe = 1, buffid = 1849, petid = 62, petexp = 0.5, petmoney = 0, useTask = { 2189, 2 }, },
  [4] = { num = 40000, id = { 6, 1, 1451, 1 }, monster = 100, spe = 0, buffid = 1850, petid = 63, petexp = 0.5, petmoney = 0, useTask = { 2189, 3 }, },
  [5] = { num = 50000, id = { 6, 1, 1452, 1 }, monster = 100, spe = 0, buffid = 1851, petid = 63, petexp = 0.5, petmoney = 0, useTask = { 2189, 4 }, },
  [6] = { num = 60000, id = { 6, 1, 1453, 1 }, monster = 100, spe = 1, buffid = 1852, petid = 63, petexp = 0.8, petmoney = 0, useTask = { 2189, 5 }, },
  [7] = { num = 70000, id = { 6, 1, 1454, 1 }, monster = 110, spe = 0, buffid = 1853, petid = 64, petexp = 0.8, petmoney = 0, useTask = { 2189, 6 }, },
  [8] = { num = 80000, id = { 6, 1, 1455, 1 }, monster = 110, spe = 0, buffid = 1854, petid = 64, petexp = 0.8, petmoney = 0, useTask = { 2189, 7 }, },
  [9] = { num = 90000, id = { 6, 1, 1456, 1 }, monster = 110, spe = 1, buffid = 1855, petid = 64, petexp = 1, petmoney = 0, useTask = { 2189, 8 }, },
  [10] = { num = 90000, id = { 6, 1, 1457, 1 }, monster = 110, spe = 0, buffid = 1856, petid = 65, petexp = 1, petmoney = 0, useTask = { 2189, 9 }, },
  [11] = { num = 90000, id = { 6, 1, 1544, 1 }, monster = 110, spe = 0, buffid = 1939, petid = 86, petexp = 1, petmoney = 0, useTask = { 2191, 4 }, },
}

TaskTable_TaiYi = {
  [1] = { num = 10000, id = { 6, 1, 1465, 1 }, monster = 90, spe = 0, buffid = 1861, petid = 66, petexp = 0.3, petmoney = 0, useTask = { 2189, 10 }, },
  [2] = { num = 20000, id = { 6, 1, 1466, 1 }, monster = 90, spe = 0, buffid = 1862, petid = 66, petexp = 0.4, petmoney = 0, useTask = { 2189, 11 }, },
  [3] = { num = 30000, id = { 6, 1, 1467, 1 }, monster = 90, spe = 1, buffid = 1863, petid = 66, petexp = 0.5, petmoney = 0, useTask = { 2189, 12 }, },
  [4] = { num = 40000, id = { 6, 1, 1468, 1 }, monster = 100, spe = 0, buffid = 1864, petid = 67, petexp = 0.5, petmoney = 0, useTask = { 2189, 13 }, },
  [5] = { num = 50000, id = { 6, 1, 1469, 1 }, monster = 100, spe = 0, buffid = 1865, petid = 67, petexp = 0.5, petmoney = 0, useTask = { 2189, 14 }, },
  [6] = { num = 60000, id = { 6, 1, 1470, 1 }, monster = 100, spe = 1, buffid = 1866, petid = 67, petexp = 0.8, petmoney = 0, useTask = { 2189, 15 }, },
  [7] = { num = 70000, id = { 6, 1, 1471, 1 }, monster = 110, spe = 0, buffid = 1867, petid = 68, petexp = 0.8, petmoney = 0, useTask = { 2189, 16 }, },
  [8] = { num = 80000, id = { 6, 1, 1472, 1 }, monster = 110, spe = 0, buffid = 1868, petid = 68, petexp = 0.8, petmoney = 0, useTask = { 2189, 17 }, },
  [9] = { num = 90000, id = { 6, 1, 1473, 1 }, monster = 110, spe = 1, buffid = 1869, petid = 68, petexp = 1, petmoney = 0, useTask = { 2189, 18 }, },
  [10] = { num = 90000, id = { 6, 1, 1474, 1 }, monster = 110, spe = 0, buffid = 1870, petid = 69, petexp = 1, petmoney = 0, useTask = { 2189, 19 }, },
  [11] = { num = 90000, id = { 6, 1, 1475, 1 }, monster = 110, spe = 0, buffid = 1940, petid = 70, petexp = 1, petmoney = 0, useTask = { 2191, 5 }, },
}

TaskTable_DaJi = {
  [1] = { num = 10000, id = { 6, 1, 1478, 1 }, monster = 90, spe = 0, buffid = 1879, petid = 71, petexp = 0.3, petmoney = 0, useTask = { 2189, 20 }, },
  [2] = { num = 20000, id = { 6, 1, 1479, 1 }, monster = 90, spe = 0, buffid = 1880, petid = 71, petexp = 0.4, petmoney = 0, useTask = { 2189, 21 }, },
  [3] = { num = 30000, id = { 6, 1, 1480, 1 }, monster = 90, spe = 1, buffid = 1881, petid = 71, petexp = 0.5, petmoney = 0, useTask = { 2189, 22 }, },
  [4] = { num = 40000, id = { 6, 1, 1481, 1 }, monster = 100, spe = 0, buffid = 1882, petid = 72, petexp = 0.5, petmoney = 0, useTask = { 2189, 23 }, },
  [5] = { num = 50000, id = { 6, 1, 1482, 1 }, monster = 100, spe = 0, buffid = 1883, petid = 72, petexp = 0.5, petmoney = 0, useTask = { 2189, 24 }, },
  [6] = { num = 60000, id = { 6, 1, 1483, 1 }, monster = 100, spe = 1, buffid = 1884, petid = 72, petexp = 0.8, petmoney = 0, useTask = { 2189, 25 }, },
  [7] = { num = 70000, id = { 6, 1, 1484, 1 }, monster = 110, spe = 0, buffid = 1885, petid = 73, petexp = 0.8, petmoney = 0, useTask = { 2189, 26 }, },
  [8] = { num = 80000, id = { 6, 1, 1485, 1 }, monster = 110, spe = 0, buffid = 1886, petid = 73, petexp = 0.8, petmoney = 0, useTask = { 2189, 27 }, },
  [9] = { num = 90000, id = { 6, 1, 1486, 1 }, monster = 110, spe = 1, buffid = 1887, petid = 73, petexp = 1, petmoney = 0, useTask = { 2189, 28 }, },
  [10] = { num = 90000, id = { 6, 1, 1487, 1 }, monster = 110, spe = 0, buffid = 1888, petid = 74, petexp = 1, petmoney = 0, useTask = { 2189, 29 }, },
  [11] = { num = 90000, id = { 6, 1, 1659, 1 }, monster = 110, spe = 0, buffid = 2007, petid = 109, petexp = 1, petmoney = 0, useTask = { 2191, 6 }, },
}

TaskTable_ShenGongBao = {
  [1] = { num = 10000, id = { 6, 1, 1488, 1 }, monster = 90, spe = 0, buffid = 1889, petid = 75, petexp = 0.3, petmoney = 0, useTask = { 2189, 30 }, },
  [2] = { num = 20000, id = { 6, 1, 1489, 1 }, monster = 90, spe = 0, buffid = 1890, petid = 75, petexp = 0.4, petmoney = 0, useTask = { 2189, 31 }, },
  [3] = { num = 30000, id = { 6, 1, 1490, 1 }, monster = 90, spe = 1, buffid = 1891, petid = 75, petexp = 0.5, petmoney = 0, useTask = { 2190, 1 }, },
  [4] = { num = 40000, id = { 6, 1, 1491, 1 }, monster = 100, spe = 0, buffid = 1892, petid = 76, petexp = 0.5, petmoney = 0, useTask = { 2190, 2 }, },
  [5] = { num = 50000, id = { 6, 1, 1492, 1 }, monster = 100, spe = 0, buffid = 1893, petid = 76, petexp = 0.5, petmoney = 0, useTask = { 2190, 3 }, },
  [6] = { num = 60000, id = { 6, 1, 1493, 1 }, monster = 100, spe = 1, buffid = 1894, petid = 76, petexp = 0.8, petmoney = 0, useTask = { 2190, 4 }, },
  [7] = { num = 70000, id = { 6, 1, 1494, 1 }, monster = 110, spe = 0, buffid = 1895, petid = 77, petexp = 0.8, petmoney = 0, useTask = { 2190, 5 }, },
  [8] = { num = 80000, id = { 6, 1, 1495, 1 }, monster = 110, spe = 0, buffid = 1896, petid = 77, petexp = 0.8, petmoney = 0, useTask = { 2190, 6 }, },
  [9] = { num = 90000, id = { 6, 1, 1496, 1 }, monster = 110, spe = 1, buffid = 1897, petid = 77, petexp = 1, petmoney = 0, useTask = { 2190, 7 }, },
  [10] = { num = 90000, id = { 6, 1, 1497, 1 }, monster = 110, spe = 0, buffid = 1898, petid = 78, petexp = 1, petmoney = 0, useTask = { 2190, 8 }, },
  [11] = { num = 90000, id = { 6, 1, 1660, 1 }, monster = 110, spe = 0, buffid = 2008, petid = 110, petexp = 1, petmoney = 0, useTask = { 2191, 7 }, },
}

TaskTable_HuangFeiHu = {
  [1] = { num = 10000, id = { 6, 1, 1498, 1 }, monster = 90, spe = 0, buffid = 1899, petid = 79, petexp = 0.3, petmoney = 0, useTask = { 2190, 9 }, },
  [2] = { num = 20000, id = { 6, 1, 1499, 1 }, monster = 90, spe = 0, buffid = 1900, petid = 79, petexp = 0.4, petmoney = 0, useTask = { 2190, 10 }, },
  [3] = { num = 30000, id = { 6, 1, 1500, 1 }, monster = 90, spe = 1, buffid = 1901, petid = 79, petexp = 0.5, petmoney = 0, useTask = { 2190, 11 }, },
  [4] = { num = 40000, id = { 6, 1, 1501, 1 }, monster = 100, spe = 0, buffid = 1902, petid = 80, petexp = 0.5, petmoney = 0, useTask = { 2190, 12 }, },
  [5] = { num = 50000, id = { 6, 1, 1502, 1 }, monster = 100, spe = 0, buffid = 1903, petid = 80, petexp = 0.5, petmoney = 0, useTask = { 2190, 13 }, },
  [6] = { num = 60000, id = { 6, 1, 1503, 1 }, monster = 100, spe = 1, buffid = 1904, petid = 80, petexp = 0.8, petmoney = 0, useTask = { 2190, 14 }, },
  [7] = { num = 70000, id = { 6, 1, 1504, 1 }, monster = 110, spe = 0, buffid = 1905, petid = 81, petexp = 0.8, petmoney = 0, useTask = { 2190, 15 }, },
  [8] = { num = 80000, id = { 6, 1, 1505, 1 }, monster = 110, spe = 0, buffid = 1906, petid = 81, petexp = 0.8, petmoney = 0, useTask = { 2190, 16 }, },
  [9] = { num = 90000, id = { 6, 1, 1506, 1 }, monster = 110, spe = 1, buffid = 1907, petid = 81, petexp = 1, petmoney = 0, useTask = { 2190, 17 }, },
  [10] = { num = 90000, id = { 6, 1, 1507, 1 }, monster = 110, spe = 0, buffid = 1908, petid = 82, petexp = 1, petmoney = 0, useTask = { 2190, 18 }, },
  [11] = { num = 90000, id = { 6, 1, 1661, 1 }, monster = 110, spe = 0, buffid = 2009, petid = 111, petexp = 1, petmoney = 0, useTask = { 2191, 8 }, },
}

PetRoleCombosTask = 2199

L_PETCOMBOS = {

  { name = "Trung KhuyÓn Tuú Chñ: D­¬ng TiÔn+Hao Thiªn KhuyÓn", itemID = 1643, bit = 1, buff = 1999, taskIdx = { 2195, 1 }, petID = 107, pet1 = { 2190, 28, 2191, 9 }, pet2 = { 2212, 7, 2191, 10 }, petname1 = "H¹o Thiªn KhuyÓn", petname2 = "D­¬ng TiÔn", info = "Cã kü n¨ng Tu luyÖn Thiªn Giíi: Treo m¸y t¹i Thiªn th­îng cã x¸c suÊt nhËn ®­îc Minh Quang Ng­ng Lé, giíi h¹n mçi ngµy nhËn 1\nMinh Quang Ng­ng Lé t¨ng 1.5 lÇn kinh nghiÖm khi treo m¸y t¹i thiªn th­îng" },
  { name = "TuyÖt §¹i Song KiÒu: §¸t Kû+Hå HØ MÞ", itemID = 1639, bit = 6, buff = 1995, taskIdx = { 2194, 1 }, petID = 103, pet1 = { 2188, 10, 2191, 1 }, pet2 = { 2189, 29, 2191, 6 }, petname1 = "Hå Hû MÞ", petname2 = "§¾c Kû", info = "Cã kü n¨ng Lo¹n Hoa Mª Nh·n: Gi¶m x¸c suÊt bÞ b¹o kÝch vËt lý, ph¸p thuËt 5%" },
  { name = "Y B¸t T­¬ng TruyÒn: Th¸i Êt+Na Tra", itemID = 1640, bit = 2, buff = 1996, taskIdx = { 2194, 2 }, petID = 104, pet1 = { 2188, 20, 2191, 2 }, pet2 = { 2189, 19, 2191, 5 }, petname1 = "Na Tra", petname2 = "Th¸i Êt Ch©n Nh©n", info = "Cã kü n¨ng S­ §å T­¬ng Hç: Sè lÇn Hé chñ +1, t¨ng tèc ®é xuÊt chiªu vò khÝ, ma ph¸p 2%" },
  { name = "§øc Cao Väng Träng: Kh­¬ng Tö Nha+Lý TÞnh", itemID = 1644, bit = 5, buff = 2000, taskIdx = { 2195, 2 }, petID = 108, pet1 = { 2212, 17, 2191, 11 }, pet2 = { 2212, 27, 2191, 12 }, petname1 = "Kh­¬ng Tö Nha", petname2 = "Lý TÞnh", info = "Cã kü n¨ng HiÒn Gi¶ trî uy, t¨ng thêi gian thä th­¬ng 10, s¸t th­¬ng c¬ b¶n +30 ®iÓm" },
  { name = "TuyÖt Gi¸o Tinh NhuÖ: Th¹ch C¬+Th©n C«ng B¸o", itemID = 1641, bit = 3, buff = 1997, taskIdx = { 2194, 3 }, petID = 105, pet1 = { 2189, 9, 2191, 4 }, pet2 = { 2190, 8, 2191, 7 }, petname1 = "Th¹ch C¬ N­¬ng N­¬ng", petname2 = "Th©n C«ng B¸o", info = "Cã kü n¨ng ThuËt ch¹y trèn: TÊt c¶ kh¸ng tÝnh +5%, Gi¶m thêi gian thä th­¬ng 25 ®iÓm" },
  { name = "ChÝnh NghÜa Chi §¹o: Hoµng Phi Hæ+L«i ChÊn Tö", itemID = 1642, bit = 4, buff = 1998, taskIdx = { 2194, 4 }, petID = 106, pet1 = { 2188, 30, 2191, 3 }, pet2 = { 2190, 18, 2191, 8 }, petname1 = "L«i ChÊn Tö", petname2 = "Hoµng Phi Hæ", info = "Cã kü n¨ng NhÊt Th©n ChÝnh KhÝ: ChÞu S¸t th­¬ng c¬ b¶n, s¸t th­¬ng PhÊp thuËt gi¶m 5%" },

}

TaskTable_NewAllPet = {
  [1] = { petname = "H¹o Thiªn KhuyÓn", taskvalue = { 2200, 2201, 2202 }, PetType = 9, taskNoteIdx = { 2072, 2073, 2074, 2075 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Hao Thiªn KhuyÓn<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn CÈu TÇm VËt]<c> kinh nghiÖm nhiÖm vô Hoa ThÇn bÝ t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Trung KhuyÓn Trî ChiÕn]<c> cã x¸c suÊt t¨ng 30% s¸t th­¬ng lªn qu¸i, duy tr× 5s", onlineday = 201709,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1599, 1 }, monster = 90, spe = 0, buffid = 1955, petid = 87, petexp = 0.3, petmoney = 0, useTask = { 2190, 19 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1600, 1 }, monster = 90, spe = 0, buffid = 1956, petid = 87, petexp = 0.4, petmoney = 0, useTask = { 2190, 20 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1601, 1 }, monster = 90, spe = 1, buffid = 1957, petid = 87, petexp = 0.5, petmoney = 0, useTask = { 2190, 21 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1602, 1 }, monster = 100, spe = 0, buffid = 1958, petid = 88, petexp = 0.5, petmoney = 0, useTask = { 2190, 22 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1603, 1 }, monster = 100, spe = 0, buffid = 1959, petid = 88, petexp = 0.5, petmoney = 0, useTask = { 2190, 23 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1604, 1 }, monster = 100, spe = 1, buffid = 1960, petid = 88, petexp = 0.8, petmoney = 0, useTask = { 2190, 24 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1605, 1 }, monster = 110, spe = 0, buffid = 1961, petid = 89, petexp = 0.8, petmoney = 0, useTask = { 2190, 25 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1606, 1 }, monster = 110, spe = 0, buffid = 1962, petid = 89, petexp = 0.8, petmoney = 0, useTask = { 2190, 26 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1607, 1 }, monster = 110, spe = 1, buffid = 1963, petid = 89, petexp = 1, petmoney = 0, useTask = { 2190, 27 }, lvl = 9, },
            [10] = { num = 90000, id = { 6, 1, 1608, 1 }, monster = 110, spe = 0, buffid = 1964, petid = 90, petexp = 1, petmoney = 0, useTask = { 2190, 28 }, lvl = 10, },
            [11] = { num = 90000, id = { 6, 1, 1663, 1 }, monster = 110, spe = 0, buffid = 2010, petid = 112, petexp = 1, petmoney = 0, useTask = { 2191, 9 }, lvl = 11, itemname = "Kim Th©n Hao Thiªn KhuyÓn" },
          },
  },
  [2] = { petname = "D­¬ng TiÔn", taskvalue = { 2203, 2204, 2205 }, PetType = 10, taskNoteIdx = { 2076, 2077, 2078, 2079 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>D­¬ng TiÔn<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Uy Phong LÉm LiÖt]<c> kinh nghiÖm nhiÖm vô dÑp lo¹n V¹n Tiªn TrËn t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Thiªn Nh·n Phóc X¹]<c> tu vi nhiÖm vô H« Tiªn Ho¸n Ma t¨ng 100%", onlineday = 201709,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1609, 1 }, monster = 90, spe = 0, buffid = 1965, petid = 91, petexp = 0.3, petmoney = 0, useTask = { 2190, 29 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1610, 1 }, monster = 90, spe = 0, buffid = 1966, petid = 91, petexp = 0.4, petmoney = 0, useTask = { 2190, 30 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1611, 1 }, monster = 90, spe = 1, buffid = 1967, petid = 91, petexp = 0.5, petmoney = 0, useTask = { 2190, 31 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1612, 1 }, monster = 100, spe = 0, buffid = 1968, petid = 92, petexp = 0.5, petmoney = 0, useTask = { 2212, 1 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1613, 1 }, monster = 100, spe = 0, buffid = 1969, petid = 92, petexp = 0.5, petmoney = 0, useTask = { 2212, 2 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1614, 1 }, monster = 100, spe = 1, buffid = 1970, petid = 92, petexp = 0.8, petmoney = 0, useTask = { 2212, 3 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1615, 1 }, monster = 110, spe = 0, buffid = 1971, petid = 93, petexp = 0.8, petmoney = 0, useTask = { 2212, 4 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1616, 1 }, monster = 110, spe = 0, buffid = 1972, petid = 93, petexp = 0.8, petmoney = 0, useTask = { 2212, 5 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1617, 1 }, monster = 110, spe = 1, buffid = 1973, petid = 93, petexp = 1, petmoney = 0, useTask = { 2212, 6 }, lvl = 9, },
            [10] = { num = 90000, id = { 6, 1, 1618, 1 }, monster = 110, spe = 0, buffid = 1974, petid = 94, petexp = 1, petmoney = 0, useTask = { 2212, 7 }, lvl = 10, },
            [11] = { num = 90000, id = { 6, 1, 1664, 1 }, monster = 110, spe = 0, buffid = 2011, petid = 113, petexp = 1, petmoney = 0, useTask = { 2191, 10 }, lvl = 11, itemname = "Kim ThÇn D­¬ng TiÔn" },
          },
  },
  [3] = { petname = "Kh­¬ng Tö Nha", taskvalue = { 2206, 2207, 2208 }, PetType = 11, taskNoteIdx = { 2080, 2081, 2082, 2083 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Kh­¬ng Tö Nha<c> cã nh÷ng kü n¨ng sau:\n<c=y>[NguyÖn Gi¶ Th­îng C©u]<c> kinh nghiÖm nhiÖm vô LÝnh §¸nh Thuª t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Tiªn Nh©n ChØ Lé]<c> lóc hµng phôc ThËp TuyÖt Thiªn Qu©n vµ Th«ng Thiªn Gi¸o Chñ cã x¸c suÊt ®¸nh r¬i ra qu¸i phï", onlineday = 201712,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1619, 1 }, monster = 90, spe = 0, buffid = 1975, petid = 95, petexp = 0.3, petmoney = 0, useTask = { 2212, 8 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1620, 1 }, monster = 90, spe = 0, buffid = 1976, petid = 95, petexp = 0.4, petmoney = 0, useTask = { 2212, 9 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1621, 1 }, monster = 90, spe = 1, buffid = 1977, petid = 95, petexp = 0.5, petmoney = 0, useTask = { 2212, 10 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1622, 1 }, monster = 100, spe = 0, buffid = 1978, petid = 96, petexp = 0.5, petmoney = 0, useTask = { 2212, 11 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1623, 1 }, monster = 100, spe = 0, buffid = 1979, petid = 96, petexp = 0.5, petmoney = 0, useTask = { 2212, 12 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1624, 1 }, monster = 100, spe = 1, buffid = 1980, petid = 96, petexp = 0.8, petmoney = 0, useTask = { 2212, 13 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1625, 1 }, monster = 110, spe = 0, buffid = 1981, petid = 97, petexp = 0.8, petmoney = 0, useTask = { 2212, 14 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1626, 1 }, monster = 110, spe = 0, buffid = 1982, petid = 97, petexp = 0.8, petmoney = 0, useTask = { 2212, 15 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1627, 1 }, monster = 110, spe = 1, buffid = 1983, petid = 97, petexp = 1, petmoney = 0, useTask = { 2212, 16 }, lvl = 9, },
            [10] = { num = 90000, id = { 6, 1, 1628, 1 }, monster = 110, spe = 0, buffid = 1984, petid = 98, petexp = 1, petmoney = 0, useTask = { 2212, 17 }, lvl = 10, },
            [11] = { num = 90000, id = { 6, 1, 1665, 1 }, monster = 110, spe = 0, buffid = 2012, petid = 114, petexp = 1, petmoney = 0, useTask = { 2191, 11 }, lvl = 11, itemname = "Kim Th©n Kh­¬ng Tö Nha" },
          },
  },
  [4] = { petname = "Lý TÞnh", taskvalue = { 2209, 2210, 2211 }, PetType = 12, taskNoteIdx = { 2084, 2085, 2086, 2087 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Lý TÞnh<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn V­¬ng Chi Né]<c> kinh nghiÖm nhiÖm vô HÊp Hån ¢m S¸t t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[B¶o Th¸p TrÊn §Þch]<c> cã x¸c suÊt g©y ®Þnh th©n 2s", onlineday = 201803,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1629, 1 }, monster = 90, spe = 0, buffid = 1985, petid = 99, petexp = 0.3, petmoney = 0, useTask = { 2212, 18 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1630, 1 }, monster = 90, spe = 0, buffid = 1986, petid = 99, petexp = 0.4, petmoney = 0, useTask = { 2212, 19 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1631, 1 }, monster = 90, spe = 1, buffid = 1987, petid = 99, petexp = 0.5, petmoney = 0, useTask = { 2212, 20 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1632, 1 }, monster = 100, spe = 0, buffid = 1988, petid = 100, petexp = 0.5, petmoney = 0, useTask = { 2212, 21 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1633, 1 }, monster = 100, spe = 0, buffid = 1989, petid = 100, petexp = 0.5, petmoney = 0, useTask = { 2212, 22 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1634, 1 }, monster = 100, spe = 1, buffid = 1990, petid = 100, petexp = 0.8, petmoney = 0, useTask = { 2212, 23 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1635, 1 }, monster = 110, spe = 0, buffid = 1991, petid = 101, petexp = 0.8, petmoney = 0, useTask = { 2212, 24 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1636, 1 }, monster = 110, spe = 0, buffid = 1992, petid = 101, petexp = 0.8, petmoney = 0, useTask = { 2212, 25 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1637, 1 }, monster = 110, spe = 1, buffid = 1993, petid = 101, petexp = 1, petmoney = 0, useTask = { 2212, 26 }, lvl = 9, },
            [10] = { num = 90000, id = { 6, 1, 1638, 1 }, monster = 110, spe = 0, buffid = 1994, petid = 102, petexp = 1, petmoney = 0, useTask = { 2212, 27 }, lvl = 10, },
            [11] = { num = 90000, id = { 6, 1, 1735, 1 }, monster = 110, spe = 0, buffid = 2058, petid = 127, petexp = 1, petmoney = 0, useTask = { 2191, 12 }, lvl = 11, itemname = "Kim Th¸p Lý TÞnh" },
          },
  },
  [5] = { petname = "Phi Th¨ng-Hå HØ MÞ", taskvalue = { 2230, 2231, 2232 }, PetType = 13, taskNoteIdx = { 2088, 2089, 2090, 2091 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Hå HØ MÞ<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Phi Tö TiÕu]<c>: kinh nghiÖm nhiÖm vô VËn L­¬ng t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ dïng ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Hång Nhan Tuý<c>: cã x¸c suÊt khiÕn kÎ ®Þch trong 5 gi©y gi¶m kh¶ n¨ng håi phôc ®i 30%", onlineday = 201806,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1675, 1 }, monster = 90, spe = 0, buffid = 2019, petid = 115, petexp = 0.3, petmoney = 0, useTask = { 2212, 28 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1676, 1 }, monster = 90, spe = 0, buffid = 2020, petid = 115, petexp = 0.4, petmoney = 0, useTask = { 2212, 29 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1677, 1 }, monster = 90, spe = 1, buffid = 2021, petid = 115, petexp = 0.5, petmoney = 0, useTask = { 2212, 30 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1678, 1 }, monster = 100, spe = 0, buffid = 2022, petid = 116, petexp = 0.5, petmoney = 0, useTask = { 2212, 31 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1679, 1 }, monster = 100, spe = 0, buffid = 2023, petid = 116, petexp = 0.5, petmoney = 0, useTask = { 2233, 1 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1680, 1 }, monster = 100, spe = 1, buffid = 2024, petid = 116, petexp = 0.8, petmoney = 0, useTask = { 2233, 2 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1681, 1 }, monster = 110, spe = 0, buffid = 2025, petid = 117, petexp = 0.8, petmoney = 0, useTask = { 2233, 3 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1682, 1 }, monster = 110, spe = 0, buffid = 2026, petid = 117, petexp = 0.8, petmoney = 0, useTask = { 2233, 4 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1683, 1 }, monster = 110, spe = 1, buffid = 2027, petid = 117, petexp = 1, petmoney = 0, useTask = { 2233, 5 }, lvl = 9, },
            [10] = { num = 90000, id = { 6, 1, 1684, 1 }, monster = 110, spe = 0, buffid = 2028, petid = 118, petexp = 1, petmoney = 0, useTask = { 2233, 6 }, lvl = 10, },
            [11] = { num = 90000, id = { 6, 1, 1736, 1 }, monster = 110, spe = 0, buffid = 2059, petid = 128, petexp = 1, petmoney = 0, useTask = { 2191, 13 }, lvl = 11, itemname = "Kim Kª Phi Th¨ng Hå HØ MÞ" },
          },
  },
  [6] = { petname = "Phi Th¨ng-Na Tra", taskvalue = { 2234, 2235, 2236 }, PetType = 14, taskNoteIdx = { 2092, 2093, 2094, 2095 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Na Tra<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Linh Ch©u Tö]<c>: kinh nghiÖm nhiÖm vô Thiªn Tµi §Þa B¶o t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ dïng ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Lùc Cµn Kh«n]<c> x¸c suÊt khiÕn kÎ ®Þch chÞu lùc Cµn Kh«n, gióp b¶n th©n vµ tæ ®éi t¨ng b¹o kÝch.", onlineday = 201809,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1687, 1 }, monster = 90, spe = 0, buffid = 2034, petid = 119, petexp = 0.3, petmoney = 0, useTask = { 2233, 7 }, lvl = 1 },
            [2] = { num = 20000, id = { 6, 1, 1688, 1 }, monster = 90, spe = 0, buffid = 2035, petid = 119, petexp = 0.4, petmoney = 0, useTask = { 2233, 8 }, lvl = 2 },
            [3] = { num = 30000, id = { 6, 1, 1689, 1 }, monster = 90, spe = 1, buffid = 2036, petid = 119, petexp = 0.5, petmoney = 0, useTask = { 2233, 9 }, lvl = 3 },
            [4] = { num = 40000, id = { 6, 1, 1690, 1 }, monster = 100, spe = 0, buffid = 2037, petid = 120, petexp = 0.5, petmoney = 0, useTask = { 2233, 10 }, lvl = 4 },
            [5] = { num = 50000, id = { 6, 1, 1691, 1 }, monster = 100, spe = 0, buffid = 2038, petid = 120, petexp = 0.5, petmoney = 0, useTask = { 2233, 11 }, lvl = 5 },
            [6] = { num = 60000, id = { 6, 1, 1692, 1 }, monster = 100, spe = 1, buffid = 2039, petid = 120, petexp = 0.8, petmoney = 0, useTask = { 2233, 12 }, lvl = 6 },
            [7] = { num = 70000, id = { 6, 1, 1693, 1 }, monster = 110, spe = 0, buffid = 2040, petid = 121, petexp = 0.8, petmoney = 0, useTask = { 2233, 13 }, lvl = 7 },
            [8] = { num = 80000, id = { 6, 1, 1694, 1 }, monster = 110, spe = 0, buffid = 2041, petid = 121, petexp = 0.8, petmoney = 0, useTask = { 2233, 14 }, lvl = 8 },
            [9] = { num = 90000, id = { 6, 1, 1695, 1 }, monster = 110, spe = 1, buffid = 2042, petid = 121, petexp = 1, petmoney = 0, useTask = { 2233, 15 }, lvl = 9 },
            [10] = { num = 90000, id = { 6, 1, 1696, 1 }, monster = 110, spe = 0, buffid = 2043, petid = 122, petexp = 1, petmoney = 0, useTask = { 2233, 16 }, lvl = 10 },
            [11] = { num = 90000, id = { 6, 1, 1737, 1 }, monster = 110, spe = 0, buffid = 2060, petid = 129, petexp = 1, petmoney = 0, useTask = { 2191, 14 }, lvl = 11, itemname = "Kim Th©n Phi Th¨ng Na Tra" },
          }
  },
  [7] = { petname = "Phi Th¨ng-L«i ChÊn Tö", taskvalue = { 2238, 2239, 2240 }, PetType = 15, taskNoteIdx = { 2096, 2097, 2098, 2099 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>L«i ChÊn Tö<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn §Þa Linh KhÝ]<c>: kinh nghiÖm nhiÖm vô Tø T­îng Linh Tª t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ dïng ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[L«i §×nh Chóc Phóc]<c> bÞ tÊn c«ng cã x¸c suÊt gióp toµn tæ ®éi (trªn cïng b¶n ®å) t¨ng sinh lùc tèi ®a = sinh lùc tèi ®a cña ng­êi ch¬i mang theo Phi th¨ng-L«i ChÊn Tö!", onlineday = 201812,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1724, 1 }, monster = 90, spe = 0, buffid = 2048, petid = 123, petexp = 0.3, petmoney = 0, useTask = { 2233, 17 }, lvl = 1 },
            [2] = { num = 20000, id = { 6, 1, 1725, 1 }, monster = 90, spe = 0, buffid = 2049, petid = 123, petexp = 0.4, petmoney = 0, useTask = { 2233, 18 }, lvl = 2 },
            [3] = { num = 30000, id = { 6, 1, 1726, 1 }, monster = 90, spe = 1, buffid = 2050, petid = 123, petexp = 0.5, petmoney = 0, useTask = { 2233, 19 }, lvl = 3 },
            [4] = { num = 40000, id = { 6, 1, 1727, 1 }, monster = 100, spe = 0, buffid = 2051, petid = 124, petexp = 0.5, petmoney = 0, useTask = { 2233, 20 }, lvl = 4 },
            [5] = { num = 50000, id = { 6, 1, 1728, 1 }, monster = 100, spe = 0, buffid = 2052, petid = 124, petexp = 0.5, petmoney = 0, useTask = { 2233, 21 }, lvl = 5 },
            [6] = { num = 60000, id = { 6, 1, 1729, 1 }, monster = 100, spe = 1, buffid = 2053, petid = 124, petexp = 0.8, petmoney = 0, useTask = { 2233, 22 }, lvl = 6 },
            [7] = { num = 70000, id = { 6, 1, 1730, 1 }, monster = 110, spe = 0, buffid = 2054, petid = 125, petexp = 0.8, petmoney = 0, useTask = { 2233, 23 }, lvl = 7 },
            [8] = { num = 80000, id = { 6, 1, 1731, 1 }, monster = 110, spe = 0, buffid = 2055, petid = 125, petexp = 0.8, petmoney = 0, useTask = { 2233, 24 }, lvl = 8 },
            [9] = { num = 90000, id = { 6, 1, 1732, 1 }, monster = 110, spe = 1, buffid = 2056, petid = 125, petexp = 1, petmoney = 0, useTask = { 2233, 25 }, lvl = 9 },
            [10] = { num = 90000, id = { 6, 1, 1733, 1 }, monster = 110, spe = 0, buffid = 2057, petid = 126, petexp = 1, petmoney = 0, useTask = { 2233, 26 }, lvl = 10 },
            [11] = { num = 90000, id = { 6, 1, 1738, 1 }, monster = 110, spe = 0, buffid = 2061, petid = 130, petexp = 1, petmoney = 0, useTask = { 2191, 15 }, lvl = 11, itemname = "Kim Vò Phi Th¨ng L«i ChÊn Tö" },
          },
  },
  [8] = { petname = "Phi Th¨ng-Th¹ch C¬", taskvalue = { 2246, 2247, 2248 }, PetType = 16, taskNoteIdx = { 2100, 2101, 2102, 2103 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Th¹ch C¬<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn Nhiªn Chi Lùc]<c> kinh nghiÖm nhiÖm vô Thiªn §×nh ThÇn Thô t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ dïng ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[V©n Quang Tr¸o<c> lóc tÊn c«ng cã tØ lÖ toµn tæ ®éi (cïng b¶n ®å) nhËn ®­îc tr¹ng th¸i [V©n Quang Tr¸o]: Ph¶n ®ßn tÇm xa 7%, Ph¶n ®ßn cËn chiÕn 7%, tr¹ng th¸i kÐo dµi 3s, håi khÝ 15s!", onlineday = 201903,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1747, 1 }, monster = 90, spe = 0, buffid = 2069, petid = 131, petexp = 0.3, petmoney = 0, useTask = { 2233, 27 }, lvl = 1 },
            [2] = { num = 20000, id = { 6, 1, 1748, 1 }, monster = 90, spe = 0, buffid = 2070, petid = 131, petexp = 0.4, petmoney = 0, useTask = { 2233, 28 }, lvl = 2 },
            [3] = { num = 30000, id = { 6, 1, 1749, 1 }, monster = 90, spe = 1, buffid = 2071, petid = 131, petexp = 0.5, petmoney = 0, useTask = { 2233, 29 }, lvl = 3 },
            [4] = { num = 40000, id = { 6, 1, 1750, 1 }, monster = 100, spe = 0, buffid = 2072, petid = 132, petexp = 0.5, petmoney = 0, useTask = { 2233, 30 }, lvl = 4 },
            [5] = { num = 50000, id = { 6, 1, 1751, 1 }, monster = 100, spe = 0, buffid = 2073, petid = 132, petexp = 0.5, petmoney = 0, useTask = { 2233, 31 }, lvl = 5 },
            [6] = { num = 60000, id = { 6, 1, 1752, 1 }, monster = 100, spe = 1, buffid = 2074, petid = 132, petexp = 0.8, petmoney = 0, useTask = { 2213, 1 }, lvl = 6 },
            [7] = { num = 70000, id = { 6, 1, 1753, 1 }, monster = 110, spe = 0, buffid = 2075, petid = 133, petexp = 0.8, petmoney = 0, useTask = { 2213, 2 }, lvl = 7 },
            [8] = { num = 80000, id = { 6, 1, 1754, 1 }, monster = 110, spe = 0, buffid = 2076, petid = 133, petexp = 0.8, petmoney = 0, useTask = { 2213, 3 }, lvl = 8 },
            [9] = { num = 90000, id = { 6, 1, 1755, 1 }, monster = 110, spe = 1, buffid = 2077, petid = 133, petexp = 1, petmoney = 0, useTask = { 2213, 4 }, lvl = 9 },
            [10] = { num = 90000, id = { 6, 1, 1756, 1 }, monster = 110, spe = 0, buffid = 2078, petid = 134, petexp = 1, petmoney = 0, useTask = { 2213, 5 }, lvl = 10 },
            [11] = { num = 90000, id = { 6, 1, 1807, 1 }, monster = 110, spe = 0, buffid = 2124, petid = 147, petexp = 1, petmoney = 0, useTask = { 2191, 16 }, lvl = 11, itemname = "Kim Quan Phi Th¨ng Th¹ch C¬" },
          },
  },

  [9] = { petname = "Phi Th¨ng-Th¸i Êt", taskvalue = { 2249, 2250, 2251 }, PetType = 17, taskNoteIdx = { 2104, 2105, 2106, 2107 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Th¸i Êt<c>: \n<c=y>[Tu luyÖn §¾c §¹o]<c>kinh nghiÖm nhiÖm vô thÝ luyÖn ThÊt Qu¶i t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Tô Lý Cµn Kh«n]<c> hoµn thµnh nhiÖm vô Tiªn Ma danh väng nhËn ®­îc t¨ng 100%.", onlineday = 201906,
          task = {
            [1] = { num = 10000, id = { 6, 1, 1758, 1 }, monster = 90, spe = 0, buffid = 2081, petid = 135, petexp = 0.3, petmoney = 0, useTask = { 2213, 6 }, lvl = 1 },
            [2] = { num = 20000, id = { 6, 1, 1759, 1 }, monster = 90, spe = 0, buffid = 2082, petid = 135, petexp = 0.4, petmoney = 0, useTask = { 2213, 7 }, lvl = 2 },
            [3] = { num = 30000, id = { 6, 1, 1760, 1 }, monster = 90, spe = 1, buffid = 2083, petid = 135, petexp = 0.5, petmoney = 0, useTask = { 2213, 8 }, lvl = 3 },
            [4] = { num = 40000, id = { 6, 1, 1761, 1 }, monster = 100, spe = 0, buffid = 2084, petid = 136, petexp = 0.5, petmoney = 0, useTask = { 2213, 9 }, lvl = 4 },
            [5] = { num = 50000, id = { 6, 1, 1762, 1 }, monster = 100, spe = 0, buffid = 2085, petid = 136, petexp = 0.5, petmoney = 0, useTask = { 2213, 10 }, lvl = 5 },
            [6] = { num = 60000, id = { 6, 1, 1763, 1 }, monster = 100, spe = 1, buffid = 2086, petid = 136, petexp = 0.8, petmoney = 0, useTask = { 2213, 11 }, lvl = 6 },
            [7] = { num = 70000, id = { 6, 1, 1764, 1 }, monster = 110, spe = 0, buffid = 2087, petid = 137, petexp = 0.8, petmoney = 0, useTask = { 2213, 12 }, lvl = 7 },
            [8] = { num = 80000, id = { 6, 1, 1765, 1 }, monster = 110, spe = 0, buffid = 2088, petid = 137, petexp = 0.8, petmoney = 0, useTask = { 2213, 13 }, lvl = 8 },
            [9] = { num = 90000, id = { 6, 1, 1766, 1 }, monster = 110, spe = 1, buffid = 2089, petid = 137, petexp = 1, petmoney = 0, useTask = { 2213, 14 }, lvl = 9 },
            [10] = { num = 90000, id = { 6, 1, 1767, 1 }, monster = 110, spe = 0, buffid = 2090, petid = 138, petexp = 1, petmoney = 0, useTask = { 2213, 15 }, lvl = 10 },
            [11] = { num = 90000, id = { 6, 1, 1808, 1 }, monster = 110, spe = 0, buffid = 2125, petid = 148, petexp = 1, petmoney = 0, useTask = { 2191, 17 }, lvl = 11, itemname = "Kim Tiªn Phi Th¨ng Th¸i Êt" },
          },
  },

  [10] = { petname = "Phi Th¨ng-§¸t Kû", taskvalue = { 2260, 2261, 2262 }, PetType = 18, taskNoteIdx = { 2108, 2109, 2110, 2111 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>§¸t Kû<c>: \n<c=y>[Tu luyÖn §¾c §¹o]<c> kinh nghiÖm nhiÖm vô thu thËp ®¹o cô t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[MÞ HoÆc]<c> lóc chiÕn ®Êu cã x¸c suÊt khiÕn ®Þch bÞ hçn lo¹n 5 gi©y, b¶n th©n vµ ®ång ®éi nhËn 1% b¹o kÝch, duy tr× 5 gi©y, håi khÝ 30 gi©y.", onlineday = 201909,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1776, 1 }, monster = 90, spe = 0, buffid = 2097, petid = 139, petexp = 0.3, petmoney = 0, useTask = { 2213, 16 }, lvl = 1 },
             [2] = { num = 20000, id = { 6, 1, 1777, 1 }, monster = 90, spe = 0, buffid = 2098, petid = 139, petexp = 0.4, petmoney = 0, useTask = { 2213, 17 }, lvl = 2 },
             [3] = { num = 30000, id = { 6, 1, 1778, 1 }, monster = 90, spe = 1, buffid = 2099, petid = 139, petexp = 0.5, petmoney = 0, useTask = { 2213, 18 }, lvl = 3 },
             [4] = { num = 40000, id = { 6, 1, 1779, 1 }, monster = 100, spe = 0, buffid = 2100, petid = 140, petexp = 0.5, petmoney = 0, useTask = { 2213, 19 }, lvl = 4 },
             [5] = { num = 50000, id = { 6, 1, 1780, 1 }, monster = 100, spe = 0, buffid = 2101, petid = 140, petexp = 0.5, petmoney = 0, useTask = { 2213, 20 }, lvl = 5 },
             [6] = { num = 60000, id = { 6, 1, 1781, 1 }, monster = 100, spe = 1, buffid = 2102, petid = 140, petexp = 0.8, petmoney = 0, useTask = { 2213, 21 }, lvl = 6 },
             [7] = { num = 70000, id = { 6, 1, 1782, 1 }, monster = 110, spe = 0, buffid = 2103, petid = 141, petexp = 0.8, petmoney = 0, useTask = { 2213, 22 }, lvl = 7 },
             [8] = { num = 80000, id = { 6, 1, 1783, 1 }, monster = 110, spe = 0, buffid = 2104, petid = 141, petexp = 0.8, petmoney = 0, useTask = { 2213, 23 }, lvl = 8 },
             [9] = { num = 90000, id = { 6, 1, 1784, 1 }, monster = 110, spe = 1, buffid = 2105, petid = 141, petexp = 1, petmoney = 0, useTask = { 2213, 24 }, lvl = 9 },
             [10] = { num = 90000, id = { 6, 1, 1785, 1 }, monster = 110, spe = 0, buffid = 2106, petid = 142, petexp = 1, petmoney = 0, useTask = { 2213, 25 }, lvl = 10 },
             [11] = { num = 90000, id = { 6, 1, 1809, 1 }, monster = 110, spe = 0, buffid = 2126, petid = 149, petexp = 1, petmoney = 0, useTask = { 2191, 18 }, lvl = 11, itemname = "Kim Tiªn Phi Th¨ng §¸t Kû" },
           },
  },

  [11] = { petname = "Phi Th¨ng-Th©n C«ng B¸o", taskvalue = { 2264, 2265, 2266 }, PetType = 19, taskNoteIdx = { 2112, 2113, 2114, 2115 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Th©n C«ng B¸o<c>: \n<c=y>[B¸t DiÖn Linh Lung]<c> kinh nghiÖm nhiÖm vô th¨m dß t×nh b¸o t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[X¶o ThiÖt Nh­ Hoµng]<c> hoµn thµnh nhiÖm vô LiÖp M· Th­ëng Kim nhËn ®­îc thªm 5~ 8 c¸i M¶nh Phï Th¹ch(Kho¸).", onlineday = 201912,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1789, 1 }, monster = 90, spe = 0, buffid = 2108, petid = 143, petexp = 0.3, petmoney = 0, useTask = { 2213, 26 }, lvl = 1 },
             [2] = { num = 20000, id = { 6, 1, 1790, 1 }, monster = 90, spe = 0, buffid = 2109, petid = 143, petexp = 0.4, petmoney = 0, useTask = { 2213, 27 }, lvl = 2 },
             [3] = { num = 30000, id = { 6, 1, 1791, 1 }, monster = 90, spe = 1, buffid = 2110, petid = 143, petexp = 0.5, petmoney = 0, useTask = { 2213, 28 }, lvl = 3 },
             [4] = { num = 40000, id = { 6, 1, 1792, 1 }, monster = 100, spe = 0, buffid = 2111, petid = 144, petexp = 0.5, petmoney = 0, useTask = { 2213, 29 }, lvl = 4 },
             [5] = { num = 50000, id = { 6, 1, 1793, 1 }, monster = 100, spe = 0, buffid = 2112, petid = 144, petexp = 0.5, petmoney = 0, useTask = { 2213, 30 }, lvl = 5 },
             [6] = { num = 60000, id = { 6, 1, 1794, 1 }, monster = 100, spe = 1, buffid = 2113, petid = 144, petexp = 0.8, petmoney = 0, useTask = { 2213, 31 }, lvl = 6 },
             [7] = { num = 70000, id = { 6, 1, 1795, 1 }, monster = 110, spe = 0, buffid = 2114, petid = 145, petexp = 0.8, petmoney = 0, useTask = { 2214, 1 }, lvl = 7 },
             [8] = { num = 80000, id = { 6, 1, 1796, 1 }, monster = 110, spe = 0, buffid = 2115, petid = 145, petexp = 0.8, petmoney = 0, useTask = { 2214, 2 }, lvl = 8 },
             [9] = { num = 90000, id = { 6, 1, 1797, 1 }, monster = 110, spe = 1, buffid = 2116, petid = 145, petexp = 1, petmoney = 0, useTask = { 2214, 3 }, lvl = 9 },
             [10] = { num = 90000, id = { 6, 1, 1798, 1 }, monster = 110, spe = 0, buffid = 2117, petid = 146, petexp = 1, petmoney = 0, useTask = { 2214, 4 }, lvl = 10 },
             [11] = { num = 90000, id = { 6, 1, 1810, 1 }, monster = 110, spe = 0, buffid = 2127, petid = 150, petexp = 1, petmoney = 0, useTask = { 2191, 19 }, lvl = 11, itemname = "Kim B¸o Phi Th¨ng Th©n C«ng B¸o" },
           },
  },

  [12] = { petname = "Phi Th¨ng-Hoµng Phi Hæ", taskvalue = { 2267, 2268, 2269 }, PetType = 20, taskNoteIdx = { 2116, 2117, 2118, 2119 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Hoµng Phi Hæ<c>: \n<c=y>[H¹o Nhiªn ChÝnh KhÝ]<c> kinh nghiÖm nhiÖm vô Siªu ®é t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Vò Thµnh V­¬ng Tø Phóc]<c> x2 phÇn th­ëng lÔ tói b¸o danh ngµy", onlineday = 202003,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1811, 1 }, monster = 90, spe = 0, buffid = 2128, petid = 151, petexp = 0.3, petmoney = 0, useTask = { 2214, 5 }, lvl = 1 },
             [2] = { num = 20000, id = { 6, 1, 1812, 1 }, monster = 90, spe = 0, buffid = 2129, petid = 151, petexp = 0.4, petmoney = 0, useTask = { 2214, 6 }, lvl = 2 },
             [3] = { num = 30000, id = { 6, 1, 1813, 1 }, monster = 90, spe = 1, buffid = 2130, petid = 151, petexp = 0.5, petmoney = 0, useTask = { 2214, 7 }, lvl = 3 },
             [4] = { num = 40000, id = { 6, 1, 1814, 1 }, monster = 100, spe = 0, buffid = 2131, petid = 152, petexp = 0.5, petmoney = 0, useTask = { 2214, 8 }, lvl = 4 },
             [5] = { num = 50000, id = { 6, 1, 1815, 1 }, monster = 100, spe = 0, buffid = 2132, petid = 152, petexp = 0.5, petmoney = 0, useTask = { 2214, 9 }, lvl = 5 },
             [6] = { num = 60000, id = { 6, 1, 1816, 1 }, monster = 100, spe = 1, buffid = 2133, petid = 152, petexp = 0.8, petmoney = 0, useTask = { 2214, 10 }, lvl = 6 },
             [7] = { num = 70000, id = { 6, 1, 1817, 1 }, monster = 110, spe = 0, buffid = 2134, petid = 153, petexp = 0.8, petmoney = 0, useTask = { 2214, 11 }, lvl = 7 },
             [8] = { num = 80000, id = { 6, 1, 1818, 1 }, monster = 110, spe = 0, buffid = 2135, petid = 153, petexp = 0.8, petmoney = 0, useTask = { 2214, 12 }, lvl = 8 },
             [9] = { num = 90000, id = { 6, 1, 1819, 1 }, monster = 110, spe = 1, buffid = 2136, petid = 153, petexp = 1, petmoney = 0, useTask = { 2214, 13 }, lvl = 9 },
             [10] = { num = 90000, id = { 6, 1, 1820, 1 }, monster = 110, spe = 0, buffid = 2137, petid = 154, petexp = 1, petmoney = 0, useTask = { 2214, 14 }, lvl = 10 },
             [11] = { num = 90000, id = { 6, 1, 1859, 1 }, monster = 110, spe = 0, buffid = 2177, petid = 167, petexp = 1, petmoney = 0, useTask = { 2191, 20 }, lvl = 11, itemname = "Kim §¶m Phi Th¨ng Hoµng Phi Hæ" },
           },
  },
  [13] = { petname = "Phi Th¨ng-Hao Thiªn KhuyÓn", taskvalue = { 2270, 2271, 2272 }, PetType = 21, taskNoteIdx = { 2072, 2073, 2074, 2120 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Hao Thiªn KhuyÓn<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn CÈu TÇm VËt]<c> kinh nghiÖm nhiÖm vô Hoa ThÇn bÝ t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[D· Ngo¹i TÇm B¶o]<c> ®em theo Hao Thiªn KhuyÓn khi dïng Di Ngo¹i Phï cã x¸c suÊt nhËn ®­îc phÇn th­ëng bÊt ngê.", onlineday = 202006,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1822, 1 }, monster = 90, spe = 0, buffid = 2138, petid = 155, petexp = 0.3, petmoney = 0, useTask = { 2214, 15 }, lvl = 1, },
             [2] = { num = 20000, id = { 6, 1, 1823, 1 }, monster = 90, spe = 0, buffid = 2139, petid = 155, petexp = 0.4, petmoney = 0, useTask = { 2214, 16 }, lvl = 2, },
             [3] = { num = 30000, id = { 6, 1, 1824, 1 }, monster = 90, spe = 1, buffid = 2140, petid = 155, petexp = 0.5, petmoney = 0, useTask = { 2214, 17 }, lvl = 3, },
             [4] = { num = 40000, id = { 6, 1, 1825, 1 }, monster = 100, spe = 0, buffid = 2141, petid = 156, petexp = 0.5, petmoney = 0, useTask = { 2214, 18 }, lvl = 4, },
             [5] = { num = 50000, id = { 6, 1, 1826, 1 }, monster = 100, spe = 0, buffid = 2142, petid = 156, petexp = 0.5, petmoney = 0, useTask = { 2214, 19 }, lvl = 5, },
             [6] = { num = 60000, id = { 6, 1, 1827, 1 }, monster = 100, spe = 1, buffid = 2143, petid = 156, petexp = 0.8, petmoney = 0, useTask = { 2214, 20 }, lvl = 6, },
             [7] = { num = 70000, id = { 6, 1, 1828, 1 }, monster = 110, spe = 0, buffid = 2144, petid = 157, petexp = 0.8, petmoney = 0, useTask = { 2214, 21 }, lvl = 7, },
             [8] = { num = 80000, id = { 6, 1, 1829, 1 }, monster = 110, spe = 0, buffid = 2145, petid = 157, petexp = 0.8, petmoney = 0, useTask = { 2214, 22 }, lvl = 8, },
             [9] = { num = 90000, id = { 6, 1, 1830, 1 }, monster = 110, spe = 1, buffid = 2146, petid = 157, petexp = 1, petmoney = 0, useTask = { 2214, 23 }, lvl = 9, },
             [10] = { num = 90000, id = { 6, 1, 1831, 1 }, monster = 110, spe = 0, buffid = 2147, petid = 158, petexp = 1, petmoney = 0, useTask = { 2214, 24 }, lvl = 10, },
             [11] = { num = 90000, id = { 6, 1, 1860, 1 }, monster = 110, spe = 0, buffid = 2178, petid = 168, petexp = 1, petmoney = 0, useTask = { 2191, 21 }, lvl = 11, itemname = "Kim Th©n Phi Th¨ng Hao Thiªn KhuyÓn" },
           },
  },
  [14] = { petname = "Phi Th¨ng-D­¬ng TiÔn", taskvalue = { 2274, 2275, 2276 }, PetType = 22, taskNoteIdx = { 2076, 2077, 2078, 2121 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>D­¬ng TiÔn<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Uy Phong LÉm LiÖt]<c> kinh nghiÖm nhiÖm vô dÑp lo¹n V¹n Tiªn TrËn t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Thiªn Nh·n Th¸c §å]<c> khi cã D­¬ng TiÔn theo sau lóc diÖt Bµn Cæ hoÆc §¹i §iªu, cã x¸c suÊt nhËn ®­îc ®å phæ Cam hoÆc s¸ch phèi ph­¬ng kü n¨ng sèng.", onlineday = 202009,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1836, 1 }, monster = 90, spe = 0, buffid = 2149, petid = 159, petexp = 0.3, petmoney = 0, useTask = { 2214, 25 }, lvl = 1, },
             [2] = { num = 20000, id = { 6, 1, 1837, 1 }, monster = 90, spe = 0, buffid = 2150, petid = 159, petexp = 0.4, petmoney = 0, useTask = { 2214, 26 }, lvl = 2, },
             [3] = { num = 30000, id = { 6, 1, 1838, 1 }, monster = 90, spe = 1, buffid = 2151, petid = 159, petexp = 0.5, petmoney = 0, useTask = { 2214, 27 }, lvl = 3, },
             [4] = { num = 40000, id = { 6, 1, 1839, 1 }, monster = 100, spe = 0, buffid = 2152, petid = 160, petexp = 0.5, petmoney = 0, useTask = { 2214, 28 }, lvl = 4, },
             [5] = { num = 50000, id = { 6, 1, 1840, 1 }, monster = 100, spe = 0, buffid = 2153, petid = 160, petexp = 0.5, petmoney = 0, useTask = { 2214, 29 }, lvl = 5, },
             [6] = { num = 60000, id = { 6, 1, 1841, 1 }, monster = 100, spe = 1, buffid = 2154, petid = 160, petexp = 0.8, petmoney = 0, useTask = { 2214, 30 }, lvl = 6, },
             [7] = { num = 70000, id = { 6, 1, 1842, 1 }, monster = 110, spe = 0, buffid = 2155, petid = 161, petexp = 0.8, petmoney = 0, useTask = { 2214, 31 }, lvl = 7, },
             [8] = { num = 80000, id = { 6, 1, 1843, 1 }, monster = 110, spe = 0, buffid = 2156, petid = 161, petexp = 0.8, petmoney = 0, useTask = { 2215, 1 }, lvl = 8, },
             [9] = { num = 90000, id = { 6, 1, 1844, 1 }, monster = 110, spe = 1, buffid = 2157, petid = 161, petexp = 1, petmoney = 0, useTask = { 2215, 2 }, lvl = 9, },
             [10] = { num = 90000, id = { 6, 1, 1845, 1 }, monster = 110, spe = 0, buffid = 2158, petid = 162, petexp = 1, petmoney = 0, useTask = { 2215, 3 }, lvl = 10, },
             [11] = { num = 90000, id = { 6, 1, 1861, 1 }, monster = 110, spe = 0, buffid = 2179, petid = 169, petexp = 1, petmoney = 0, useTask = { 2191, 22 }, lvl = 11, itemname = "Kim ThÇn Phi Th¨ng D­¬ng TiÔn" },
           },
  },
  [15] = { petname = "Phi Th¨ng-Kh­¬ng Tö Nha", taskvalue = { 2279, 2280, 2281 }, PetType = 23, taskNoteIdx = { 2080, 2081, 2082, 2122 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Kh­¬ng Tö Nha<c> cã nh÷ng kü n¨ng sau:\n<c=y>[NguyÖn Gi¶ Th­îng C©u]<c> kinh nghiÖm nhiÖm vô LÝnh §¸nh Thuª t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[Th¸i C«ng Tø Phóc]<c> trong chiÕn ®Êu cã x¸c suÊt nhËn ®­îc tr¹ng th¸i Ban phóc, gi¶m s¸t th­¬ng b¹o kÝch g¸nh chÞu ®i 10%.", onlineday = 202012,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1848, 1 }, monster = 90, spe = 0, buffid = 2159, petid = 163, petexp = 0.3, petmoney = 0, useTask = { 2282, 1 }, lvl = 1, },
             [2] = { num = 20000, id = { 6, 1, 1849, 1 }, monster = 90, spe = 0, buffid = 2160, petid = 163, petexp = 0.4, petmoney = 0, useTask = { 2282, 2 }, lvl = 2, },
             [3] = { num = 30000, id = { 6, 1, 1850, 1 }, monster = 90, spe = 1, buffid = 2161, petid = 163, petexp = 0.5, petmoney = 0, useTask = { 2282, 3 }, lvl = 3, },
             [4] = { num = 40000, id = { 6, 1, 1851, 1 }, monster = 100, spe = 0, buffid = 2162, petid = 164, petexp = 0.5, petmoney = 0, useTask = { 2282, 4 }, lvl = 4, },
             [5] = { num = 50000, id = { 6, 1, 1852, 1 }, monster = 100, spe = 0, buffid = 2163, petid = 164, petexp = 0.5, petmoney = 0, useTask = { 2282, 5 }, lvl = 5, },
             [6] = { num = 60000, id = { 6, 1, 1853, 1 }, monster = 100, spe = 1, buffid = 2164, petid = 164, petexp = 0.8, petmoney = 0, useTask = { 2282, 6 }, lvl = 6, },
             [7] = { num = 70000, id = { 6, 1, 1854, 1 }, monster = 110, spe = 0, buffid = 2165, petid = 165, petexp = 0.8, petmoney = 0, useTask = { 2282, 7 }, lvl = 7, },
             [8] = { num = 80000, id = { 6, 1, 1855, 1 }, monster = 110, spe = 0, buffid = 2166, petid = 165, petexp = 0.8, petmoney = 0, useTask = { 2282, 8 }, lvl = 8, },
             [9] = { num = 90000, id = { 6, 1, 1856, 1 }, monster = 110, spe = 1, buffid = 2167, petid = 165, petexp = 1, petmoney = 0, useTask = { 2282, 9 }, lvl = 9, },
             [10] = { num = 90000, id = { 6, 1, 1857, 1 }, monster = 110, spe = 0, buffid = 2168, petid = 166, petexp = 1, petmoney = 0, useTask = { 2282, 10 }, lvl = 10, },
             [11] = { num = 90000, id = { 6, 1, 1862, 1 }, monster = 110, spe = 0, buffid = 2180, petid = 170, petexp = 1, petmoney = 0, useTask = { 2191, 23 }, lvl = 11, itemname = "Kim Th©n Phi Th¨ng Kh­¬ng Tö Nha" },
           },
  },
  [16] = { petname = "Phi Th¨ng-Lý TÞnh", taskvalue = { 2289, 2290, 2291 }, PetType = 24, taskNoteIdx = { 2084, 2085, 2086, 2123 }, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Lý TÞnh<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Thiªn V­¬ng Chi Né]<c> kinh nghiÖm nhiÖm vô HÊp Hån ¢m S¸t t¨ng 100%\n<c=y>[Phó Quý Chi Th©n]<c> cã thÓ sö dông ®Æc quyÒn HuyÒn Vò miÔn phÝ\n<c=y>[B¶o Th¸p Phô Trî]<c> nhËn tr¹ng th¸i hót sinh lùc 2%, hót néi lùc 2%.", onlineday = 202012,
           task = {
             [1] = { num = 10000, id = { 6, 1, 1874, 1 }, monster = 90, spe = 0, buffid = 2185, petid = 171, petexp = 0.3, petmoney = 0, useTask = { 2282, 11 }, lvl = 1, },
             [2] = { num = 20000, id = { 6, 1, 1875, 1 }, monster = 90, spe = 0, buffid = 2186, petid = 171, petexp = 0.4, petmoney = 0, useTask = { 2282, 12 }, lvl = 2, },
             [3] = { num = 30000, id = { 6, 1, 1876, 1 }, monster = 90, spe = 1, buffid = 2187, petid = 171, petexp = 0.5, petmoney = 0, useTask = { 2282, 13 }, lvl = 3, },
             [4] = { num = 40000, id = { 6, 1, 1877, 1 }, monster = 100, spe = 0, buffid = 2188, petid = 172, petexp = 0.5, petmoney = 0, useTask = { 2282, 14 }, lvl = 4, },
             [5] = { num = 50000, id = { 6, 1, 1878, 1 }, monster = 100, spe = 0, buffid = 2189, petid = 172, petexp = 0.5, petmoney = 0, useTask = { 2282, 15 }, lvl = 5, },
             [6] = { num = 60000, id = { 6, 1, 1879, 1 }, monster = 100, spe = 1, buffid = 2190, petid = 172, petexp = 0.8, petmoney = 0, useTask = { 2282, 16 }, lvl = 6, },
             [7] = { num = 70000, id = { 6, 1, 1880, 1 }, monster = 110, spe = 0, buffid = 2191, petid = 173, petexp = 0.8, petmoney = 0, useTask = { 2282, 17 }, lvl = 7, },
             [8] = { num = 80000, id = { 6, 1, 1881, 1 }, monster = 110, spe = 0, buffid = 2192, petid = 173, petexp = 0.8, petmoney = 0, useTask = { 2282, 18 }, lvl = 8, },
             [9] = { num = 90000, id = { 6, 1, 1882, 1 }, monster = 110, spe = 1, buffid = 2193, petid = 173, petexp = 1, petmoney = 0, useTask = { 2282, 19 }, lvl = 9, },
             [10] = { num = 90000, id = { 6, 1, 1883, 1 }, monster = 110, spe = 0, buffid = 2194, petid = 174, petexp = 1, petmoney = 0, useTask = { 2282, 20 }, lvl = 10, },
           },
  },
}

TaskTable_AllPet2New = {
  [1] = { petname = "Lôc ¸p §¹o Nh©n", taskvalue = { 2293, 2294 }, PetType = 25, taskNoteIdx = 2124, wenzi = "Khi ®¹t cÊp tèi ®a <c=g>Lôc ¸p §¹o Nh©n<c> cã nh÷ng kü n¨ng sau:\n<c=y>[Tam Tóc Kim ¤]<c> Sinh lùc tèi ®a t¨ng 500 ®iÓm\n<c=y>[Ly Ho¶ Chi Tinh]<c> NÐ tr¸nh t¨ng 100 ®iÓm\n<c=y>[Tr¶m Tiªn Phi §ao]<c>S¸t th­¬ng c¬ b¶n +50, Ho¶ S¸t +30 ®iÓm.", onlineday = 202110, petid = 175, id = { 6, 1, 1887, 1 }, useTask = { 2282, 21 },
          task = {
            [1] = { num = 10000, id = { 6, 1, 1887, 1 }, monster = 90, spe = 0, buffid = 2195, useTask = { 2282, 21 }, lvl = 1, },
            [2] = { num = 20000, id = { 6, 1, 1887, 1 }, monster = 90, spe = 0, buffid = 2195, useTask = { 2282, 21 }, lvl = 2, },
            [3] = { num = 30000, id = { 6, 1, 1887, 1 }, monster = 90, spe = 0, buffid = 2195, useTask = { 2282, 21 }, lvl = 3, },
            [4] = { num = 40000, id = { 6, 1, 1887, 1 }, monster = 90, spe = 0, buffid = 2195, useTask = { 2282, 21 }, lvl = 4, },
            [5] = { num = 50000, id = { 6, 1, 1887, 1 }, monster = 90, spe = 0, buffid = 2195, useTask = { 2282, 21 }, lvl = 5, },
            [6] = { num = 60000, id = { 6, 1, 1887, 1 }, monster = 5, spe = 1, buffid = 2196, useTask = { 2282, 21 }, lvl = 6, },
            [7] = { num = 70000, id = { 6, 1, 1887, 1 }, monster = 5, spe = 1, buffid = 2196, useTask = { 2282, 21 }, lvl = 7, },
            [8] = { num = 80000, id = { 6, 1, 1887, 1 }, monster = 5, spe = 1, buffid = 2196, useTask = { 2282, 21 }, lvl = 8, },
            [9] = { num = 90000, id = { 6, 1, 1887, 1 }, monster = 5, spe = 1, buffid = 2196, useTask = { 2282, 21 }, lvl = 9, },
            [10] = { num = 100000, id = { 6, 1, 1887, 1 }, monster = 5, spe = 1, buffid = 2197, useTask = { 2282, 21 }, lvl = 10, },
          },
  }, }

AllPetTable = {
  [1] = { itemid = { 6, 1, 1339, 1 }, buffid = 1784, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 1 }, petid = 46, lvl = 1 },
  [2] = { itemid = { 6, 1, 1340, 1 }, buffid = 1785, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 2 }, petid = 46, lvl = 2 },
  [3] = { itemid = { 6, 1, 1341, 1 }, buffid = 1786, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 3 }, petid = 46, lvl = 3 },
  [4] = { itemid = { 6, 1, 1342, 1 }, buffid = 1787, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 4 }, petid = 47, lvl = 4 },
  [5] = { itemid = { 6, 1, 1343, 1 }, buffid = 1788, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 5 }, petid = 47, lvl = 5 },
  [6] = { itemid = { 6, 1, 1344, 1 }, buffid = 1789, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 6 }, petid = 47, lvl = 6 },
  [7] = { itemid = { 6, 1, 1345, 1 }, buffid = 1790, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 7 }, petid = 48, lvl = 7 },
  [8] = { itemid = { 6, 1, 1346, 1 }, buffid = 1791, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 8 }, petid = 48, lvl = 8 },
  [9] = { itemid = { 6, 1, 1347, 1 }, buffid = 1792, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 9 }, petid = 48, lvl = 9 },
  [10] = { itemid = { 6, 1, 1348, 1 }, buffid = 1793, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Hå Hû MÞ", useTask = { 2188, 10 }, petid = 49, lvl = 10 },


  [11] = { itemid = { 6, 1, 1359, 1 }, buffid = 1808, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 11 }, petid = 50, lvl = 1 },
  [12] = { itemid = { 6, 1, 1360, 1 }, buffid = 1809, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 12 }, petid = 50, lvl = 2 },
  [13] = { itemid = { 6, 1, 1361, 1 }, buffid = 1810, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 13 }, petid = 50, lvl = 3 },
  [14] = { itemid = { 6, 1, 1362, 1 }, buffid = 1811, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 14 }, petid = 51, lvl = 4 },
  [15] = { itemid = { 6, 1, 1363, 1 }, buffid = 1812, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 15 }, petid = 51, lvl = 5 },
  [16] = { itemid = { 6, 1, 1364, 1 }, buffid = 1813, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 16 }, petid = 51, lvl = 6 },
  [17] = { itemid = { 6, 1, 1365, 1 }, buffid = 1814, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 17 }, petid = 52, lvl = 7 },
  [18] = { itemid = { 6, 1, 1366, 1 }, buffid = 1815, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 18 }, petid = 52, lvl = 8 },
  [19] = { itemid = { 6, 1, 1367, 1 }, buffid = 1816, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 19 }, petid = 52, lvl = 9 },
  [20] = { itemid = { 6, 1, 1368, 1 }, buffid = 1817, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Na Tra", useTask = { 2188, 20 }, petid = 53, lvl = 10 },


  [21] = { itemid = { 6, 1, 1426, 1 }, buffid = 1833, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 21 }, petid = 58, lvl = 1 },
  [22] = { itemid = { 6, 1, 1427, 1 }, buffid = 1834, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 22 }, petid = 58, lvl = 2 },
  [23] = { itemid = { 6, 1, 1428, 1 }, buffid = 1835, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 23 }, petid = 58, lvl = 3 },
  [24] = { itemid = { 6, 1, 1429, 1 }, buffid = 1836, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 24 }, petid = 59, lvl = 4 },
  [25] = { itemid = { 6, 1, 1430, 1 }, buffid = 1837, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 25 }, petid = 59, lvl = 5 },
  [26] = { itemid = { 6, 1, 1431, 1 }, buffid = 1838, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 26 }, petid = 59, lvl = 6 },
  [27] = { itemid = { 6, 1, 1432, 1 }, buffid = 1839, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 27 }, petid = 60, lvl = 7 },
  [28] = { itemid = { 6, 1, 1433, 1 }, buffid = 1840, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 28 }, petid = 60, lvl = 8 },
  [29] = { itemid = { 6, 1, 1434, 1 }, buffid = 1841, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 29 }, petid = 60, lvl = 9 },
  [30] = { itemid = { 6, 1, 1435, 1 }, buffid = 1842, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "L«i ChÊn Tö", useTask = { 2188, 30 }, petid = 61, lvl = 10 },


  [31] = { itemid = { 6, 1, 1448, 1 }, buffid = 1847, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2188, 31 }, petid = 62, lvl = 1 },
  [32] = { itemid = { 6, 1, 1449, 1 }, buffid = 1848, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 1 }, petid = 62, lvl = 2 },
  [33] = { itemid = { 6, 1, 1450, 1 }, buffid = 1849, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 2 }, petid = 62, lvl = 3 },
  [34] = { itemid = { 6, 1, 1451, 1 }, buffid = 1850, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 3 }, petid = 63, lvl = 4 },
  [35] = { itemid = { 6, 1, 1452, 1 }, buffid = 1851, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 4 }, petid = 63, lvl = 5 },
  [36] = { itemid = { 6, 1, 1453, 1 }, buffid = 1852, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 5 }, petid = 63, lvl = 6 },
  [37] = { itemid = { 6, 1, 1454, 1 }, buffid = 1853, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 6 }, petid = 64, lvl = 7 },
  [38] = { itemid = { 6, 1, 1455, 1 }, buffid = 1854, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 7 }, petid = 64, lvl = 8 },
  [39] = { itemid = { 6, 1, 1456, 1 }, buffid = 1855, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 8 }, petid = 64, lvl = 9 },
  [40] = { itemid = { 6, 1, 1457, 1 }, buffid = 1856, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Th¹ch C¬ N­¬ng N­¬ng", useTask = { 2189, 9 }, petid = 65, lvl = 10 },


  [41] = { itemid = { 6, 1, 1465, 1 }, buffid = 1861, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 10 }, petid = 66, lvl = 1 },
  [42] = { itemid = { 6, 1, 1466, 1 }, buffid = 1862, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 11 }, petid = 66, lvl = 2 },
  [43] = { itemid = { 6, 1, 1467, 1 }, buffid = 1863, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 12 }, petid = 66, lvl = 3 },
  [44] = { itemid = { 6, 1, 1468, 1 }, buffid = 1864, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 13 }, petid = 67, lvl = 4 },
  [45] = { itemid = { 6, 1, 1469, 1 }, buffid = 1865, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 14 }, petid = 67, lvl = 5 },
  [46] = { itemid = { 6, 1, 1470, 1 }, buffid = 1866, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 15 }, petid = 67, lvl = 6 },
  [47] = { itemid = { 6, 1, 1471, 1 }, buffid = 1867, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 16 }, petid = 68, lvl = 7 },
  [48] = { itemid = { 6, 1, 1472, 1 }, buffid = 1868, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 17 }, petid = 68, lvl = 8 },
  [49] = { itemid = { 6, 1, 1473, 1 }, buffid = 1869, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 18 }, petid = 68, lvl = 9 },
  [50] = { itemid = { 6, 1, 1474, 1 }, buffid = 1870, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Th¸i Êt Ch©n Nh©n", useTask = { 2189, 19 }, petid = 69, lvl = 10 },


  [51] = { itemid = { 6, 1, 1478, 1 }, buffid = 1879, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 20 }, petid = 71, lvl = 1 },
  [52] = { itemid = { 6, 1, 1479, 1 }, buffid = 1880, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 21 }, petid = 71, lvl = 2 },
  [53] = { itemid = { 6, 1, 1480, 1 }, buffid = 1881, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 22 }, petid = 71, lvl = 3 },
  [54] = { itemid = { 6, 1, 1481, 1 }, buffid = 1882, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 23 }, petid = 72, lvl = 4 },
  [55] = { itemid = { 6, 1, 1482, 1 }, buffid = 1883, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 24 }, petid = 72, lvl = 5 },
  [56] = { itemid = { 6, 1, 1483, 1 }, buffid = 1884, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 25 }, petid = 72, lvl = 6 },
  [57] = { itemid = { 6, 1, 1484, 1 }, buffid = 1885, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 26 }, petid = 73, lvl = 7 },
  [58] = { itemid = { 6, 1, 1485, 1 }, buffid = 1886, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 27 }, petid = 73, lvl = 8 },
  [59] = { itemid = { 6, 1, 1486, 1 }, buffid = 1887, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 28 }, petid = 73, lvl = 9 },
  [60] = { itemid = { 6, 1, 1487, 1 }, buffid = 1888, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "§¾c Kû", useTask = { 2189, 29 }, petid = 74, lvl = 10 },


  [61] = { itemid = { 6, 1, 1488, 1 }, buffid = 1889, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2189, 30 }, petid = 75, lvl = 1 },
  [62] = { itemid = { 6, 1, 1489, 1 }, buffid = 1890, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2189, 31 }, petid = 75, lvl = 2 },
  [63] = { itemid = { 6, 1, 1490, 1 }, buffid = 1891, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 1 }, petid = 75, lvl = 3 },
  [64] = { itemid = { 6, 1, 1491, 1 }, buffid = 1892, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 2 }, petid = 76, lvl = 4 },
  [65] = { itemid = { 6, 1, 1492, 1 }, buffid = 1893, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 3 }, petid = 76, lvl = 5 },
  [66] = { itemid = { 6, 1, 1493, 1 }, buffid = 1894, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 4 }, petid = 76, lvl = 6 },
  [67] = { itemid = { 6, 1, 1494, 1 }, buffid = 1895, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 5 }, petid = 77, lvl = 7 },
  [68] = { itemid = { 6, 1, 1495, 1 }, buffid = 1896, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 6 }, petid = 77, lvl = 8 },
  [69] = { itemid = { 6, 1, 1496, 1 }, buffid = 1897, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 7 }, petid = 77, lvl = 9 },
  [70] = { itemid = { 6, 1, 1497, 1 }, buffid = 1898, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Th©n C«ng B¸o", useTask = { 2190, 8 }, petid = 78, lvl = 10 },


  [71] = { itemid = { 6, 1, 1498, 1 }, buffid = 1899, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 9 }, petid = 79, lvl = 1 },
  [72] = { itemid = { 6, 1, 1499, 1 }, buffid = 1900, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 10 }, petid = 79, lvl = 2 },
  [73] = { itemid = { 6, 1, 1500, 1 }, buffid = 1901, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 11 }, petid = 79, lvl = 3 },
  [74] = { itemid = { 6, 1, 1501, 1 }, buffid = 1902, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 12 }, petid = 80, lvl = 4 },
  [75] = { itemid = { 6, 1, 1502, 1 }, buffid = 1903, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 13 }, petid = 80, lvl = 5 },
  [76] = { itemid = { 6, 1, 1503, 1 }, buffid = 1904, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 14 }, petid = 80, lvl = 6 },
  [77] = { itemid = { 6, 1, 1504, 1 }, buffid = 1905, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 15 }, petid = 81, lvl = 7 },
  [78] = { itemid = { 6, 1, 1505, 1 }, buffid = 1906, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 16 }, petid = 81, lvl = 8 },
  [79] = { itemid = { 6, 1, 1506, 1 }, buffid = 1907, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 17 }, petid = 81, lvl = 9 },
  [80] = { itemid = { 6, 1, 1507, 1 }, buffid = 1908, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Hoµng Phi Hæ", useTask = { 2190, 18 }, petid = 82, lvl = 10 },

  [81] = { itemid = { 6, 1, 1541, 1 }, buffid = 1936, taskvalue = { 2071, 2072, 2073 }, PetType = 1, itemname = "Kim Kª Hå HØ MÞ", useTask = { 2191, 1 }, petid = 83, lvl = 11 },
  [82] = { itemid = { 6, 1, 1542, 1 }, buffid = 1937, taskvalue = { 2078, 2079, 2080 }, PetType = 2, itemname = "Kim Th©n Na Tra", useTask = { 2191, 2 }, petid = 84, lvl = 11 },
  [83] = { itemid = { 6, 1, 1543, 1 }, buffid = 1938, taskvalue = { 2091, 2092, 2093 }, PetType = 3, itemname = "Kim Vò L«i ChÊn Tö", useTask = { 2191, 3 }, petid = 85, lvl = 11 },
  [84] = { itemid = { 6, 1, 1544, 1 }, buffid = 1939, taskvalue = { 2106, 2107, 2108 }, PetType = 4, itemname = "Kim Quan Th¹ch C¬", useTask = { 2191, 4 }, petid = 86, lvl = 11 },
  [85] = { itemid = { 6, 1, 1475, 1 }, buffid = 1940, taskvalue = { 2114, 2115, 2116 }, PetType = 5, itemname = "Kim Tiªn Th¸i Êt", useTask = { 2191, 5 }, petid = 70, lvl = 11 },
  [86] = { itemid = { 6, 1, 1660, 1 }, buffid = 2007, taskvalue = { 2117, 2118, 2119 }, PetType = 6, itemname = "Kim Hå §¸t Kû", useTask = { 2191, 6 }, petid = 109, lvl = 11 },
  [87] = { itemid = { 6, 1, 1661, 1 }, buffid = 2008, taskvalue = { 2120, 2121, 2122 }, PetType = 7, itemname = "Kim B¸o Th©n C«ng B¸o", useTask = { 2191, 7 }, petid = 110, lvl = 11 },
  [88] = { itemid = { 6, 1, 1662, 1 }, buffid = 2009, taskvalue = { 2123, 2124, 2125 }, PetType = 8, itemname = "Kim §¶m Hoµng Phi Hæ", useTask = { 2191, 8 }, petid = 111, lvl = 11 },


}

function FosterPet()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(Value_AblePet, 1) == 0 or GetTaskByte(Value_AblePet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Hå HØ MÞ råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(Value_AblePet, 2)
  local step = GetTaskByte(Value_AblePet, 3)
  local killnum = GetTask(Task_AblePet)
  local id = TaskTable[level].id
  local id1 = TaskTable[level + 1].id
  local buffid = TaskTable[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(Value_AblePet, 3, level + 1)
    TaskNote(2035, 0, TaskTable[level].monster, 0, TaskTable[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable[level].num) then

    local nTask = TaskTable[level].useTask
    local nTask1 = TaskTable[level + 1].useTask
    if (TaskTable[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompletePetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask(level, id, id1, buffid, nTask, nTask1)

    end
  end
end

function Check4boss()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_AblePet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_AblePet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_AblePet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_AblePet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_1()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_NeZhaPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_NeZhaPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_NeZhaPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_NeZhaPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_2()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_LeiZhenZiPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_LeiZhenZiPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_LeiZhenZiPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_LeiZhenZiPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_3()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_ShiJiPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_ShiJiPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_ShiJiPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_ShiJiPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_4()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_TaiYiPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_TaiYiPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_TaiYiPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_TaiYiPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_5()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_DaJiPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_DaJiPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_DaJiPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_DaJiPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_6()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_ShenGongBaoPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_ShenGongBaoPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_ShenGongBaoPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_ShenGongBaoPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end
function Check4boss_7()
  local t_boss = {
    [1] = { v = GetTaskBit(Break_HuangFeiHuPet, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(Break_HuangFeiHuPet, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(Break_HuangFeiHuPet, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(Break_HuangFeiHuPet, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end

function BreakTask(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_AblePet, 1) == 1) then
      CompletePetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Hå HØ MÞ khi ®¸nh b¹i §¹i §iªu!")
      Msg2Player("H·y dÉn theo Hå HØ MÞ khi ®¸nh b¹i §¹i §iªu!")
      TaskNote(2036, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss()
    local str2 = "H·y dÉn theo Hå HØ MÞ lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompletePetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2037, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_AblePet, 7) == 0 and GetTaskBit(Break_AblePet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Hå HØ MÞ.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Hå HØ MÞ.")
      TaskNote(2038, 0)
      SetTaskBit(Break_AblePet, 8, 1)
      return
    end
    if (GetTaskBit(Break_AblePet, 7) == 0 and GetTaskBit(Break_AblePet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_AblePet, 7, 1)
        Talk(1, "no", "BÞ <c=g>D­¬ng TiÔn<c> ®¶ th­¬ng, Hå HØ MÞ rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Hå HØ MÞ ®¸nh b¹i <c=g>D­¬ng TiÔn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2038, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_AblePet, 2) == 1 and GetTaskBit(Break_AblePet, 7) == 1) then
      CompletePetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i D­¬ng TiÔn.")
    end
  end
end

function CompletePetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(Value_AblePet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo QuyÓn Trôc Hå HØ MÞ hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo QuyÓn Trôc Hå HØ MÞ hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end

  SetTaskByte(Value_AblePet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_AblePet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2035, -1)
  TaskNote(2036, -1)
  TaskNote(2037, -1)
  TaskNote(2038, -1)
end

function Xuanwu()
  local viplevel = GetPlayerVipLevel()
  if (viplevel == 3 or viplevel == 2) then
    return
  end
  ClearPlayerVipTime()
  SetPlayerVipLevel(1, 30 * 86400)
  Msg2Player("Linh sñng Thuéc TÝnh gióp ngµi t¨ng 30 ngµy ®Æc quyÒn HuyÒn Vò.")
end

function ChangePet()
  local PetTyte = PetGetType()
  if ((PetTyte >= 46 and PetTyte <= 49) or (PetTyte == 83)) then
    SetTaskByte(Value_AblePet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 49 or (PetTyte == 48 and GetTaskByte(Value_AblePet, 2) ~= 7) or PetTyte == 83) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 50 and PetTyte <= 53) or (PetTyte == 84) then
    SetTaskByte(NeZha_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 53 or (PetTyte == 52 and GetTaskByte(NeZha_Pet, 2) ~= 7) or PetTyte == 84) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
    if (PetTyte == 53 and GetTaskByte(Break_NeZhaPet, 2) == 1) or (PetTyte == 84) then
      PetModifyProtect(-1)
      SetTaskByte(Break_NeZhaPet, 2, 0)
    end
  end
  if (PetTyte >= 58 and PetTyte <= 61) or (PetTyte == 85) then
    SetTaskByte(LeiZhenZi_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 61 or (PetTyte == 60 and GetTaskByte(LeiZhenZi_Pet, 2) ~= 7) or PetTyte == 85) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 62 and PetTyte <= 65) or (PetTyte == 86) then
    SetTaskByte(ShiJi_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 65 or (PetTyte == 64 and GetTaskByte(ShiJi_Pet, 2) ~= 7) or PetTyte == 86) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 66 and PetTyte <= 70) then
    SetTaskByte(TaiYi_Pet, 1, 0)
    Removeallpetbuff()
    RemoveTaiYiSkillBuff()
    if (PetTyte == 69 or PetTyte == 70 or (PetTyte == 68 and GetTaskByte(TaiYi_Pet, 2) ~= 7)) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 71 and PetTyte <= 74) or (PetTyte == 109) then
    SetTaskByte(DaJi_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 74 or (PetTyte == 73 and GetTaskByte(DaJi_Pet, 2) ~= 7) or PetTyte == 109) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 75 and PetTyte <= 78) or (PetTyte == 110) then
    SetTaskByte(ShenGongBao_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 78 or (PetTyte == 77 and GetTaskByte(ShenGongBao_Pet, 2) ~= 7) or PetTyte == 110) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end
  if (PetTyte >= 79 and PetTyte <= 82) or (PetTyte == 111) then
    SetTaskByte(HuangFeiHu_Pet, 1, 0)
    Removeallpetbuff()
    if (PetTyte == 82 or (PetTyte == 81 and GetTaskByte(HuangFeiHu_Pet, 2) ~= 7) or PetTyte == 111) then
      local viplevel = GetPlayerVipLevel()
      if (viplevel == 1) then
        ClearPlayerVipTime()
      end
    end
  end

  local nPetTask = 0
  if (PetTyte >= 87 and PetTyte <= 90) or (PetTyte == 112) then
    nPetTask = TaskTable_NewAllPet[1].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1) and (GetTaskByte(nPetTask, 2) >= 8) then

      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 91 and PetTyte <= 94) or (PetTyte == 113) then
    nPetTask = TaskTable_NewAllPet[2].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1) and (GetTaskByte(nPetTask, 2) >= 8) then

      ClearPlayerVipTime()
    end
  end
  if (PetTyte >= 95 and PetTyte <= 98) or (PetTyte == 114) then
    nPetTask = TaskTable_NewAllPet[3].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1) and (GetTaskByte(nPetTask, 2) >= 8) then

      ClearPlayerVipTime()
    end
  end
  if (PetTyte >= 99 and PetTyte <= 102) or (PetTyte == 127) then
    nPetTask = TaskTable_NewAllPet[4].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1) and (GetTaskByte(nPetTask, 2) >= 8) then

      ClearPlayerVipTime()
    end
  end
  if (PetTyte >= 115 and PetTyte <= 118) or (PetTyte == 128) then
    nPetTask = TaskTable_NewAllPet[5].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1) and (GetTaskByte(nPetTask, 2) >= 8) then

      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 119 and PetTyte <= 122) or (PetTyte == 129) then
    nPetTask = TaskTable_NewAllPet[6].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 123 and PetTyte <= 126) or (PetTyte == 130) then
    nPetTask = TaskTable_NewAllPet[7].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 131 and PetTyte <= 134) or (PetTyte == 147) then
    nPetTask = TaskTable_NewAllPet[8].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 135 and PetTyte <= 138) or (PetTyte == 148) then
    nPetTask = TaskTable_NewAllPet[9].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 139 and PetTyte <= 142) or (PetTyte == 149) then
    nPetTask = TaskTable_NewAllPet[10].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 143 and PetTyte <= 146) or (PetTyte == 150) then
    nPetTask = TaskTable_NewAllPet[11].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 151 and PetTyte <= 154) or (PetTyte == 167) then
    nPetTask = TaskTable_NewAllPet[12].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 155 and PetTyte <= 158) or (PetTyte == 168) then
    nPetTask = TaskTable_NewAllPet[13].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 159 and PetTyte <= 162) or (PetTyte == 169) then
    nPetTask = TaskTable_NewAllPet[14].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 163 and PetTyte <= 166) or (PetTyte == 170) then
    nPetTask = TaskTable_NewAllPet[15].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte >= 171 and PetTyte <= 174) or (PetTyte == 171) then
    nPetTask = TaskTable_NewAllPet[16].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
    if (GetPlayerVipLevel() == 1 and GetTaskByte(nPetTask, 2) >= 8) then
      ClearPlayerVipTime()
    end
  end

  if (PetTyte == 175) then
    nPetTask = TaskTable_AllPet2New[1].taskvalue[1]
    SetTaskByte(nPetTask, 1, 0)
    Removeallpetbuff()
  end

  if (PetTyte >= 103 and PetTyte <= 114) then
    Removeallpetbuff()
    if (GetTaskByte(2215, 3) == 1) then
      PetModifyProtect(-1)
      SetTaskByte(2215, 3, 0)
    end
    if (GetPlayerVipLevel() == 1) then

      ClearPlayerVipTime()
    end
  end

end
function Removeallpetbuff()
  for i = 1, table.getn(AllPetTable) do
    RemoveIBBuff(AllPetTable[i].buffid)
  end

  for i = 1, #TaskTable_NewAllPet do
    for j = 1, table.getn(TaskTable_NewAllPet[i].task) do
      RemoveIBBuff(TaskTable_NewAllPet[i].task[j].buffid)
    end
  end

  for i = 1, #TaskTable_AllPet2New do
    for j = 1, table.getn(TaskTable_AllPet2New[i].task) do
      RemoveIBBuff(TaskTable_AllPet2New[i].task[j].buffid)
    end
  end
  RemoveTaiYiSkillBuff()

  for i = 1, #L_PETCOMBOS do
    RemoveIBBuff(L_PETCOMBOS[i].buff)
  end


end
function RemoveTaiYiSkillBuff()
  for i = 1871, 1878 do
    RemoveIBBuff(i)
  end
end
function AblePetExp(flag, basenum)
  local PetTyte = PetGetType()
  if (((PetTyte >= 46 and PetTyte <= 49) or PetTyte == 83) and flag == 1) then
    for i = 1, table.getn(TaskTable) do
      if (HaveIBBuff(TaskTable[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hå HØ MÞ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 50 and PetTyte <= 53) or PetTyte == 84) and flag == 2) then
    for i = 1, table.getn(TaskTable_NeZha) do
      if (HaveIBBuff(TaskTable_NeZha[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable_NeZha[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh X¶o §o¹t Thiªn C«ng Na Tra gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 58 and PetTyte <= 61) or PetTyte == 85) and flag == 3) then
    for i = 1, table.getn(TaskTable_LeiZhenZi) do
      if (HaveIBBuff(TaskTable_LeiZhenZi[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable_LeiZhenZi[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Tø T­îng Linh Tª, L«i ChÊn Tö gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 62 and PetTyte <= 65) or PetTyte == 86) and flag == 4) then
    for i = 1, table.getn(TaskTable_ShiJi) do
      if (HaveIBBuff(TaskTable_ShiJi[i].buffid) > 0) then
        local exp1 = TaskTable_ShiJi[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Thiªn §×nh ThÇn Thô, Th¹ch C¬ N­¬ng N­¬ng gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (PetTyte >= 66 and PetTyte <= 70 and flag == 5) then
    for i = 1, table.getn(TaskTable_TaiYi) do
      if (HaveIBBuff(TaskTable_TaiYi[i].buffid) > 0) then
        local exp1 = TaskTable_TaiYi[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh ThÝ luyÖn ThÊt Qu¶i, Th¸i Êt Ch©n Nh©n gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 71 and PetTyte <= 74) or PetTyte == 109) and flag == 6) then
    for i = 1, table.getn(TaskTable_DaJi) do
      if (HaveIBBuff(TaskTable_DaJi[i].buffid) > 0) then
        local exp1 = TaskTable_DaJi[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Thu thËp §¹o cô, §¸t Kû gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 75 and PetTyte <= 78) or PetTyte == 110) and flag == 7) then
    for i = 1, table.getn(TaskTable_ShenGongBao) do
      if (HaveIBBuff(TaskTable_ShenGongBao[i].buffid) > 0) then
        local exp1 = TaskTable_ShenGongBao[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Th¨m dß t×nh b¸o, Th©n C«ng B¸o gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end
  if (((PetTyte >= 79 and PetTyte <= 82) or PetTyte == 111) and flag == 8) then
    for i = 1, table.getn(TaskTable_HuangFeiHu) do
      if (HaveIBBuff(TaskTable_HuangFeiHu[i].buffid) > 0) then
        local exp1 = TaskTable_HuangFeiHu[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Siªu ®é, Hoµng Phi Hæ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  local TaskTable_list = {}
  local exp1 = 0
  if (((PetTyte >= 87 and PetTyte <= 90) or PetTyte == 112) and flag == 9) then
    TaskTable_list = TaskTable_NewAllPet[1].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm vô Hoa ThÇn BÝ, Hao Thiªn KhuyÓn gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        return
      end
    end
  end
  if (((PetTyte >= 91 and PetTyte <= 94) or PetTyte == 113) and flag == 10) then
    TaskTable_list = TaskTable_NewAllPet[2].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm vô dÑp lo¹n V¹n Tiªn TrËn, D­¬ng TiÔn gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        return
      end
    end
  end

  if (flag == 11) then
    TaskTable_list = TaskTable_NewAllPet[2].task
    if ((PetTyte == 94) and HaveIBBuff(TaskTable_list[10].buffid) > 0) or ((PetTyte == 113) and HaveIBBuff(TaskTable_list[11].buffid) > 0) then
      exp1 = AddOwnExtendExp(basenum)
      Msg2Player("Hoµn thµnh nhiÖm vô H« Tiªn Ho¸n Ma, D­¬ng TiÔn gióp ngµi nhËn thªm tu vi " .. exp1)
      return
    end
  end

  if (((PetTyte >= 95 and PetTyte <= 98) or PetTyte == 114) and flag == 12) then
    TaskTable_list = TaskTable_NewAllPet[3].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm vô lÝnh ®¸nh thuª, Kh­¬ng Tö Nha gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        return
      end
    end
  end
  if (((PetTyte >= 99 and PetTyte <= 102) or PetTyte == 127) and flag == 13) then
    TaskTable_list = TaskTable_NewAllPet[4].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm HÊp Hån ¢m S¸t, Lý TÞnh gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        return
      end
    end
  end

  if (((PetTyte >= 115 and PetTyte <= 118) or PetTyte == 128) and flag == 14) then
    TaskTable_list = TaskTable_NewAllPet[5].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hå HØ MÞ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 119 and PetTyte <= 122) or PetTyte == 129) and flag == 15) then
    TaskTable_list = TaskTable_NewAllPet[6].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh X¶o §o¹t Thiªn C«ng Na Tra gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 123 and PetTyte <= 126) or PetTyte == 130) and flag == 16) then
    TaskTable_list = TaskTable_NewAllPet[7].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = GetLevel() * TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm Tø T­îng Linh Tª, L«i ChÊn Tö gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 131 and PetTyte <= 134) or PetTyte == 147) and flag == 17) then
    TaskTable_list = TaskTable_NewAllPet[8].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm Thiªn §×nh ThÇn Thô, Th¹ch C¬ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 135 and PetTyte <= 138) or PetTyte == 148) and flag == 18) then
    TaskTable_list = TaskTable_NewAllPet[9].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh ThÝ luyÖn ThÊt Qu¶i, Th¸i Êt gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 139 and PetTyte <= 142) or PetTyte == 149) and flag == 19) then
    TaskTable_list = TaskTable_NewAllPet[10].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Thu thËp §¹o cô, §¸t Kû gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 143 and PetTyte <= 146) or PetTyte == 150) and flag == 20) then
    TaskTable_list = TaskTable_NewAllPet[11].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Th¨m dß t×nh b¸o, Th©n C«ng B¸o gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 151 and PetTyte <= 154) or PetTyte == 167) and flag == 21) then
    TaskTable_list = TaskTable_NewAllPet[12].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh Siªu ®é, Hoµng Phi Hæ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 155 and PetTyte <= 158) or PetTyte == 168) and flag == 22) then
    TaskTable_list = TaskTable_NewAllPet[13].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm Hoa ThÇn BÝ, Hao Thiªn KhuyÓn gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 159 and PetTyte <= 162) or PetTyte == 169) and flag == 23) then
    TaskTable_list = TaskTable_NewAllPet[14].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm vô dÑp lo¹n V¹n Tiªn TrËn, D­¬ng TiÔn gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 163 and PetTyte <= 166) or PetTyte == 170) and flag == 24) then
    TaskTable_list = TaskTable_NewAllPet[15].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm vô lÝnh ®¸nh thuª, Kh­¬ng Tö Nha gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (((PetTyte >= 171 and PetTyte <= 174) or PetTyte == 171) and flag == 25) then
    TaskTable_list = TaskTable_NewAllPet[16].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        exp1 = TaskTable_list[i].petexp * basenum
        AddOwnExp(exp1)
        Msg2Player("Hoµn thµnh nhiÖm HÊp Hån ¢m S¸t, Lý TÞnh gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
        break
      end
    end
  end

  if (PetTyte == 103 and HaveIBBuff(L_PETCOMBOS[2].buff) > 0) then
    if (flag == 6) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh Thu thËp §¹o cô, §¸t Kû gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 1) then
      exp1 = GetLevel() * basenum
      AddOwnExp(exp1)
      Msg2Player("Hå HØ MÞ gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
    end
  end

  if (PetTyte == 104 and HaveIBBuff(L_PETCOMBOS[3].buff) > 0) then
    if (flag == 5) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh ThÝ luyÖn ThÊt Qu¶i, Th¸i Êt Ch©n Nh©n gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 2) then
      exp1 = GetLevel() * basenum
      AddOwnExp(exp1)
      Msg2Player("Hoµn thµnh X¶o §o¹t Thiªn C«ng Na Tra gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
    end
  end
  if (PetTyte == 105 and HaveIBBuff(L_PETCOMBOS[5].buff) > 0) then
    if (flag == 7) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh Th¨m dß t×nh b¸o, Th©n C«ng B¸o gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 4) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh Thiªn §×nh ThÇn Thô, Th¹ch C¬ N­¬ng N­¬ng gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    end
  end
  if (PetTyte == 106 and HaveIBBuff(L_PETCOMBOS[6].buff) > 0) then
    if (flag == 8) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh Siªu ®é, Hoµng Phi Hæ gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 3) then
      exp1 = GetLevel() * basenum
      AddOwnExp(exp1)
      Msg2Player("Hoµn thµnh Tø T­îng Linh Tª, L«i ChÊn Tö gióp ngµi nhËn thªm kinh nghiÖm: " .. exp1)
    end
  end
  if (PetTyte == 107 and HaveIBBuff(L_PETCOMBOS[1].buff) > 0) then
    if (flag == 9) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh nhiÖm vô Hoa ThÇn BÝ, Hao Thiªn KhuyÓn gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 10) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh nhiÖm vô dÑp lo¹n V¹n Tiªn TrËn, D­¬ng TiÔn gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 11) then
      Msg2Player("Hoµn thµnh nhiÖm vô H« Tiªn Ho¸n Ma, D­¬ng TiÔn gióp ngµi nhËn thªm tu vi " .. basenum)
      AddOwnExtendExp(basenum)
    end
  end
  if (PetTyte == 108 and HaveIBBuff(L_PETCOMBOS[4].buff) > 0) then
    if (flag == 13) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh nhiÖm HÊp Hån ¢m S¸t, Lý TÞnh gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    elseif (flag == 12) then
      AddOwnExp(basenum)
      Msg2Player("Hoµn thµnh nhiÖm vô lÝnh ®¸nh thuª, Kh­¬ng Tö Nha gióp ngµi nhËn thªm kinh nghiÖm: " .. basenum)
    end
  end


end

function AblePetMoney()
  local playerlevel = GetLevel()
  if (playerlevel < 200) then
    return
  end
  local PetTyte = PetGetType()

  if (PetTyte >= 46 and PetTyte <= 49) then
    for i = 1, table.getn(TaskTable) do
      if (HaveIBBuff(TaskTable[i].buffid) > 0) then
        local money = GetLevel() * TaskTable[i].petmoney
        Earn(money)
        Msg2Player("Hå HØ MÞ gióp ngµi nhËn ®­îc thªm b¹c: " .. money)
      end
    end
  elseif (PetType >= 115 and PetType <= 118) then
    TaskTable_list = TaskTable_NewAllPet[5].task
    for i = 1, table.getn(TaskTable_list) do
      if (HaveIBBuff(TaskTable_list[i].buffid) > 0) then
        local money = GetLevel() * TaskTable_list[i].petmoney
        Earn(money)
        Msg2Player("Hå HØ MÞ gióp ngµi nhËn ®­îc thªm b¹c: " .. money)
      end
    end
  elseif (PetTyte == 83 and HaveIBBuff(TaskTable[11].buffid) > 0) or (PetTyte == 103) then
    local money = GetLevel() * TaskTable[11].petmoney
    Earn(money)
    Msg2Player("Hå HØ MÞ gióp ngµi nhËn ®­îc thªm b¹c: " .. money)
  end

end

function DropBowlder(NpcIndex, mapidx, nNpcx, nNpcy)
  if (NpcIndex == nil) then
    WriteLog("Linh sñng thuéc tÝnh ®¸nh mÊt ngäc th¹ch (Lçi tham sè) NpcIndex=nil")
    return
  end
  local npcname = GetNpcName(NpcIndex)

  local oldPlayerIndex = _G.PlayerIndex
  _G.PlayerIndex = GetDropPlayer(NpcIndex)
  if (_G.PlayerIndex <= 0) then
    _G.PlayerIndex = oldPlayerIndex
    WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. " tö vong, kh«ng biÕt quyÒn nhÆt lµ cña ai")
    return
  end

  if (GetTeam() > 0) then

    local nPeople = GetTeamSize()
    for i = 1, nPeople do
      _G.PlayerIndex = GetTeamMember(i)
      if (Check_Distance(mapidx, nNpcx, nNpcy) == 1) then
        local PetTyte = PetGetType()
        local str1 = "<c=g>" .. GetName() .. "<c> gia - Hå HØ MÞ trong lßng c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra ®­îc 1 LÔ bao Ngäc Tinh, mõng rì ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
        local str2 = "<c=g>" .. GetName() .. "<c> gia - Hå HØ MÞ trong lßng c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra ®­îc 1 LÔ bao Ngäc T©m, mõng rì ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
        if (PetTyte == 49 and GetTaskByte(Value_AblePet, 2) == 10) or (PetTyte == 83 and GetTaskByte(Value_AblePet, 2) == 11) or (PetTyte == 103) then
          local another = math.random(100)
          if (another > 95) then
            local pro = math.random(100)
            if (pro <= 80) then
              AddNormalItemBind(8, 1668, 2, 0, 0, 0, 1)
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhÆt ®­îc LÔ bao L­¬ng Ngäc r¬i ra]")
              Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao L­¬ng Ngäc.")
            elseif (pro <= 95) then
              AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Danh Ngäc.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Danh Ngäc]")
            elseif (pro <= 99) then
              AddNormalItemBind(8, 1670, 2, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Ngäc Tinh.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Ngäc Tinh]")
              Msg2CurMapAnnounce(str1)
            else
              AddNormalItemBind(6, 1, 1314, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Ngäc T©m.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Ngäc T©m]")
              Msg2CurMapAnnounce(str2)
              AddGlobalNews(str2)
            end
          else
            WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][Kh«ng cã lÔ bao ngÉu nhiªn]")
          end
        end
      end
    end

  else
    local PetTyte = PetGetType()
    local str1 = "<c=g>" .. GetName() .. "<c> gia - Hå HØ MÞ trong lßng c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra ®­îc 1 LÔ bao Ngäc Tinh, mõng rì ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
    local str2 = "<c=g>" .. GetName() .. "<c> gia - Hå HØ MÞ trong lßng c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra ®­îc 1 LÔ bao Ngäc T©m, mõng rì ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
    if (PetTyte == 49 and GetTaskByte(Value_AblePet, 2) == 10) or (PetTyte == 83 and GetTaskByte(Value_AblePet, 2) == 11) or (PetTyte == 103) then
      local another = math.random(100)
      if (another > 95) then
        local pro = math.random(100)
        if (pro <= 80) then
          AddNormalItemBind(8, 1668, 2, 0, 0, 0, 1)
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhÆt ®­îc LÔ bao L­¬ng Ngäc r¬i ra]")
          Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao L­¬ng Ngäc.")
        elseif (pro <= 95) then
          AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Danh Ngäc.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Danh Ngäc]")
        elseif (pro <= 99) then
          AddNormalItemBind(8, 1670, 2, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Ngäc Tinh.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Ngäc Tinh]")
          Msg2CurMapAnnounce(str1)
        else
          AddNormalItemBind(6, 1, 1314, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, Hå HØ MÞ mang ®Õn cho ngµi LÔ bao Ngäc T©m.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ bao Ngäc T©m]")
          Msg2CurMapAnnounce(str2)
          AddGlobalNews(str2)
        end
      else
        WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][Kh«ng cã lÔ bao ngÉu nhiªn]")
      end
    end
  end

  _G.PlayerIndex = oldPlayerIndex
end
function KillMonster(npcidx)
  local OldPlayer = _G.PlayerIndex
  if (GetTeam() > 0) then
    local nPeople = GetTeamSize()
    for i = 1, nPeople do
      _G.PlayerIndex = GetTeamMember(i)
      KillMonsterYes(npcidx)
    end
  else
    KillMonsterYes(npcidx)
  end
  _G.PlayerIndex = OldPlayer
end
function KillMonsterYes(npcidx)
  if (GetTaskByte(Value_AblePet, 1) == 1) then
    local level = GetTaskByte(Value_AblePet, 2)
    local step = GetTaskByte(Value_AblePet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if ((level <= 3 and npclevel >= 90) or (3 < level and level <= 6 and npclevel >= 100) or (level > 6 and npclevel >= 110)) then
        local num = GetTask(Task_AblePet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_AblePet, num)
          local monster = TaskTable[level].monster
          TaskNote(2035, 0, monster, num, level * 10000)
        end
        if (num >= level * 10000) then
          TaskNote(2035, 1)
        end
      end
    end
  end
  if (GetTaskByte(NeZha_Pet, 1) == 1) then
    local level = GetTaskByte(NeZha_Pet, 2)
    local step = GetTaskByte(NeZha_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_NeZha[level].monster) then
        local num = GetTask(Task_NeZhaPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_NeZhaPet, num)
          local monster = TaskTable_NeZha[level].monster
          TaskNote(2039, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_NeZha[level].num) then
          TaskNote(2039, 1)
        end
      end
    end
  end
  if (GetTaskByte(LeiZhenZi_Pet, 1) == 1) then
    local level = GetTaskByte(LeiZhenZi_Pet, 2)
    local step = GetTaskByte(LeiZhenZi_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_LeiZhenZi[level].monster) then
        local num = GetTask(Task_LeiZhenZiPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_LeiZhenZiPet, num)
          local monster = TaskTable_LeiZhenZi[level].monster
          TaskNote(2047, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_LeiZhenZi[level].num) then
          TaskNote(2047, 1)
        end
      end
    end
  end
  if (GetTaskByte(ShiJi_Pet, 1) == 1) then
    local level = GetTaskByte(ShiJi_Pet, 2)
    local step = GetTaskByte(ShiJi_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_ShiJi[level].monster) then
        local num = GetTask(Task_ShiJiPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_ShiJiPet, num)
          local monster = TaskTable_ShiJi[level].monster
          TaskNote(2051, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_ShiJi[level].num) then
          TaskNote(2051, 1)
        end
      end
    end
  end
  if (GetTaskByte(TaiYi_Pet, 1) == 1) then
    local level = GetTaskByte(TaiYi_Pet, 2)
    local step = GetTaskByte(TaiYi_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_TaiYi[level].monster) then
        local num = GetTask(Task_TaiYiPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_TaiYiPet, num)
          local monster = TaskTable_TaiYi[level].monster
          TaskNote(2055, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_TaiYi[level].num) then
          TaskNote(2055, 1)
        end
      end
    end
  end
  if (GetTaskByte(DaJi_Pet, 1) == 1) then
    local level = GetTaskByte(DaJi_Pet, 2)
    local step = GetTaskByte(DaJi_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_DaJi[level].monster) then
        local num = GetTask(Task_DaJiPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_DaJiPet, num)
          local monster = TaskTable_DaJi[level].monster
          TaskNote(2059, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_DaJi[level].num) then
          TaskNote(2059, 1)
        end
      end
    end
  end
  if (GetTaskByte(ShenGongBao_Pet, 1) == 1) then
    local level = GetTaskByte(ShenGongBao_Pet, 2)
    local step = GetTaskByte(ShenGongBao_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_ShenGongBao[level].monster) then
        local num = GetTask(Task_ShenGongBaoPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_ShenGongBaoPet, num)
          local monster = TaskTable_ShenGongBao[level].monster
          TaskNote(2063, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_ShenGongBao[level].num) then
          TaskNote(2063, 1)
        end
      end
    end
  end
  if (GetTaskByte(HuangFeiHu_Pet, 1) == 1) then
    local level = GetTaskByte(HuangFeiHu_Pet, 2)
    local step = GetTaskByte(HuangFeiHu_Pet, 3)
    local npclevel = GetNpcLevel(npcidx)
    if (step == level + 1) then
      if (npclevel >= TaskTable_HuangFeiHu[level].monster) then
        local num = GetTask(Task_HuangFeiHuPet)
        if (num < 110000) then
          num = num + 1
          SetTask(Task_HuangFeiHuPet, num)
          local monster = TaskTable_HuangFeiHu[level].monster
          TaskNote(2067, 0, monster, num, level * 10000)
        end
        if (num >= TaskTable_HuangFeiHu[level].num) then
          TaskNote(2067, 1)
        end
      end
    end
  end

  local task_pet, level, step, num, monster = 0, 0, 0, 0, 0
  local monsterMax = 0
  for i = 1, #TaskTable_NewAllPet do
    task_pet = TaskTable_NewAllPet[i].taskvalue[1]
    if (GetTaskByte(task_pet, 1) == 1) then
      level = GetTaskByte(task_pet, 2)
      step = GetTaskByte(task_pet, 3)
      num = GetTask(TaskTable_NewAllPet[i].taskvalue[2]) + 1
      monsterMax = TaskTable_NewAllPet[i].task[level].num
      if (step == level + 1) and (num <= monsterMax + 1) then
        monster = TaskTable_NewAllPet[i].task[level].monster
        if (GetNpcLevel(npcidx) >= monster) then
          SetTask(TaskTable_NewAllPet[i].taskvalue[2], num)
          if (num >= monsterMax) then
            TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[1], 1)
          else
            TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[1], 0, monster, num, level * 10000)
          end
        end
      end
    end
  end

  local w, x, y = GetWorldPos()
  for i = 1, #TaskTable_AllPet2New do
    task_pet = TaskTable_AllPet2New[i].taskvalue[1]
    if (GetTaskByte(task_pet, 1) == 1) then
      level = GetTaskByte(task_pet, 2)
      step = GetTaskByte(task_pet, 3)
      num = GetTask(TaskTable_AllPet2New[i].taskvalue[2]) + 1
      monsterMax = TaskTable_AllPet2New[i].task[level].num
      if (step == level + 1) and (num <= monsterMax + 1) then
        local key = 1
        if (TaskTable_AllPet2New[i].task[level].spe == 1) then
          if (w < 73) or (w > 78) then
            key = 0
          end
        end

        monster = TaskTable_AllPet2New[i].task[level].monster
        if (GetNpcLevel(npcidx) >= monster) and (key == 1) then
          SetTask(TaskTable_AllPet2New[i].taskvalue[2], num)
          if (num >= monsterMax) then
            TaskNote(TaskTable_AllPet2New[i].taskNoteIdx, 1)
          else
            TaskNote(TaskTable_AllPet2New[i].taskNoteIdx, 0, monster, num, monsterMax)
          end
        end
      end
    end
  end
end

function no()

  CloseDialog()
end

function FosterNeZha()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(NeZha_Pet, 1) == 0 or GetTaskByte(NeZha_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Na Tra råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(NeZha_Pet, 2)
  local step = GetTaskByte(NeZha_Pet, 3)
  local killnum = GetTask(Task_NeZhaPet)
  local id = TaskTable_NeZha[level].id
  local id1 = TaskTable_NeZha[level + 1].id
  local buffid = TaskTable_NeZha[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(NeZha_Pet, 3, level + 1)
    TaskNote(2039, 0, TaskTable_NeZha[level].monster, 0, TaskTable_NeZha[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_NeZha[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_NeZha[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_NeZha[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_NeZha[level].num) then

    local nTask = TaskTable_NeZha[level].useTask
    local nTask1 = TaskTable_NeZha[level + 1].useTask
    if (TaskTable_NeZha[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteNezhaPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_NeZha[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_NeZha(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_NeZha(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_NeZhaPet, 1) == 1) then
      CompleteNezhaPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Na Tra khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo Na Tra khi ®¸nh b¹i Giao Long!")
      TaskNote(2040, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_1()
    local str2 = "H·y dÉn theo Na Tra lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteNezhaPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2041, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_NeZhaPet, 7) == 0 and GetTaskBit(Break_NeZhaPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Na Tra.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Na Tra.")
      TaskNote(2042, 0)
      SetTaskBit(Break_NeZhaPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_NeZhaPet, 7) == 0 and GetTaskBit(Break_NeZhaPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_NeZhaPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, Na Tra rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Na Tra ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2042, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_NeZhaPet, 2) == 1 and GetTaskBit(Break_NeZhaPet, 7) == 1) then
      CompleteNezhaPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteNezhaPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(NeZha_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo Na Tra hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo Na Tra hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(NeZha_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_NeZhaPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2039, -1)
  TaskNote(2040, -1)
  TaskNote(2041, -1)
  TaskNote(2042, -1)
end

function FosterLeiZhenZi()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(LeiZhenZi_Pet, 1) == 0 or GetTaskByte(LeiZhenZi_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo L«i ChÊn Tö råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(LeiZhenZi_Pet, 2)
  local step = GetTaskByte(LeiZhenZi_Pet, 3)
  local killnum = GetTask(Task_LeiZhenZiPet)
  local id = TaskTable_LeiZhenZi[level].id
  local id1 = TaskTable_LeiZhenZi[level + 1].id
  local buffid = TaskTable_LeiZhenZi[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(LeiZhenZi_Pet, 3, level + 1)
    TaskNote(2047, 0, TaskTable_LeiZhenZi[level].monster, 0, TaskTable_LeiZhenZi[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_LeiZhenZi[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_LeiZhenZi[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_LeiZhenZi[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_LeiZhenZi[level].num) then

    local nTask = TaskTable_LeiZhenZi[level].useTask
    local nTask1 = TaskTable_LeiZhenZi[level + 1].useTask
    if (TaskTable_LeiZhenZi[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteLeiZhenZiPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_LeiZhenZi[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_LeiZhenZi(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_LeiZhenZi(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_LeiZhenZiPet, 1) == 1) then
      CompleteLeiZhenZiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo L«i ChÊn Tö khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo L«i ChÊn Tö khi ®¸nh b¹i Giao Long!")
      TaskNote(2048, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_2()
    local str2 = "H·y dÉn theo L«i ChÊn Tö lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteLeiZhenZiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2049, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_LeiZhenZiPet, 7) == 0 and GetTaskBit(Break_LeiZhenZiPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho L«i ChÊn Tö.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho L«i ChÊn Tö.")
      TaskNote(2050, 0)
      SetTaskBit(Break_LeiZhenZiPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_LeiZhenZiPet, 7) == 0 and GetTaskBit(Break_LeiZhenZiPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_LeiZhenZiPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, L«i ChÊn Tö rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn L«i ChÊn Tö ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2050, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_LeiZhenZiPet, 2) == 1 and GetTaskBit(Break_LeiZhenZiPet, 7) == 1) then
      CompleteLeiZhenZiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteLeiZhenZiPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(LeiZhenZi_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo L«i ChÊn Tö hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo L«i ChÊn Tö hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(LeiZhenZi_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_LeiZhenZiPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2047, -1)
  TaskNote(2048, -1)
  TaskNote(2049, -1)
  TaskNote(2050, -1)
end

function DropFuShi(NpcIndex, mapidx, nNpcx, nNpcy)
  if (NpcIndex == nil) then
    WriteLog("Linh sñng thuéc tÝnh ®¸nh mÊt phï th¹ch (Lçi tham sè) NpcIndex=nil")
    return
  end
  local npcname = GetNpcName(NpcIndex)

  local oldPlayerIndex = _G.PlayerIndex
  _G.PlayerIndex = GetDropPlayer(NpcIndex)
  if (_G.PlayerIndex <= 0) then
    _G.PlayerIndex = oldPlayerIndex
    WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. " tö vong, kh«ng biÕt quyÒn nhÆt lµ cña ai")
    return
  end

  if (GetTeam() > 0) then

    local nPeople = GetTeamSize()
    for i = 1, nPeople do
      _G.PlayerIndex = GetTeamMember(i)
      if (Check_Distance(mapidx, nNpcx, nNpcy) == 1) then
        local PetTyte = PetGetType()
        local str1 = "<c=g>" .. GetName() .. "<c> gia - L«i ChÊn Tö trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 1 LÔ hép Phï Th¹ch cÊp 2, vui mõng ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
        local str2 = "<c=g>" .. GetName() .. "<c> gia - L«i ChÊn Tö trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 2 LÔ hép Phï Th¹ch cÊp 2, vui mõng ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."

        if (PetTyte == 61 and GetTaskByte(LeiZhenZi_Pet, 2) == 10) or (PetTyte == 85 and GetTaskByte(LeiZhenZi_Pet) == 11) or (PetTyte == 106) then
          local another = math.random(100)
          if (another > 95) then
            local pro = math.random(100)
            if (pro <= 80) then
              AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch]")
              Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch.")
            elseif (pro <= 95) then
              AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
              AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch*2.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch*2]")
            elseif (pro <= 99) then
              AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch cÊp 2.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch cÊp 2]")
              Msg2CurMapAnnounce(str1)
            else
              AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
              AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
              Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch cÊp 2*2.")
              WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch cÊp 2*2]")
              Msg2CurMapAnnounce(str2)
              AddGlobalNews(str2)
            end
          else
            WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][Kh«ng cã LÔ hép NgÉu nhiªn]")
          end
        elseif ((PetTyte == 98 or PetTyte == 114) and GetTaskByte(TaskTable_NewAllPet[3].taskvalue[1], 2) >= 10) or (PetTyte == 108) then
          local another = math.random(100)
          if (another > 95) then
            another = math.random(100)
            if (another <= 95) then
              AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
              str2 = "Vi Quang Qu¸i Phï (ch­a mµi)"
            else
              AddNormalItemBind(3, 383, 0, 0, 0, 0, 1)
              str2 = "Tinh Th¸i Qu¸i Phï (ch­a mµi)"
            end

            WriteLog("[Linh Sñng Thuéc TÝnh][Kh­¬ng Tö Nha nhËn ®­îc thªm " .. str2 .. "]")
            Msg2Player("Chóc mõng, Kh­¬ng Tö Nha mang ®Õn cho ngµi " .. str2 .. ".")
            str1 = "<c=g>" .. GetName() .. "<c> gia - Kh­¬ng Tö Nha trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 1 c¸i " .. str2 .. ", vui mõng ®em ®Õn tr­íc mÆt h¾n."
            Msg2CurMapAnnounce(str1)
            AddGlobalNews(str1)
          else
            WriteLog("[Linh Sñng Thuéc TÝnh][Kh­¬ng Tö Nha kh«ng nhËn ®­îc qu¸i phï ngÉu nhiªn]")
          end
        end
      end
    end

  else
    local PetTyte = PetGetType()
    local str1 = "<c=g>" .. GetName() .. "<c> gia - L«i ChÊn Tö trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 1 LÔ hép Phï Th¹ch cÊp 2, vui mõng ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
    local str2 = "<c=g>" .. GetName() .. "<c> gia - L«i ChÊn Tö trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 2 LÔ hép Phï Th¹ch cÊp 2, vui mõng ®em ®Õn tr­íc mÆt <c=g>" .. GetName() .. "<c>."
    if (PetTyte == 61 and GetTaskByte(LeiZhenZi_Pet, 2) == 10) or (PetTyte == 85 and GetTaskByte(LeiZhenZi_Pet, 2) == 11) or (PetTyte == 106) then
      local another = math.random(100)
      if (another > 95) then
        local pro = math.random(100)
        if (pro <= 80) then
          AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch]")
          Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch.")
        elseif (pro <= 95) then
          AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
          AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch*2.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch*2]")
        elseif (pro <= 99) then
          AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch cÊp 2.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch cÊp 2]")
          Msg2CurMapAnnounce(str1)
        else
          AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
          AddNormalItemBind(8, 1818, 2, 0, 0, 0, 1)
          Msg2Player("Chóc mõng, L«i ChÊn Tö mang ®Õn cho ngµi LÔ hép Phï Th¹ch cÊp 2*2.")
          WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][NhËn ®­îc thªm vËt phÈm r¬i ra: LÔ hép Phï Th¹ch cÊp 2*2]")
          Msg2CurMapAnnounce(str2)
          AddGlobalNews(str2)
        end
      else
        WriteLog("[" .. GetName() .. "][Linh Sñng Thuéc TÝnh][Kh«ng cã LÔ hép NgÉu nhiªn]")
      end
    elseif ((PetTyte == 98 or PetTyte == 114) and GetTaskByte(TaskTable_NewAllPet[3].taskvalue[1], 2) >= 10) or (PetTyte == 108) then
      local another = math.random(100)
      if (another > 95) then
        another = math.random(100)
        if (another <= 95) then
          AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
          str2 = "Vi Quang Qu¸i Phï (ch­a mµi)"
        else
          AddNormalItemBind(3, 383, 0, 0, 0, 0, 1)
          str2 = "Tinh Th¸i Qu¸i Phï (ch­a mµi)"
        end

        WriteLog("[Linh Sñng Thuéc TÝnh][Kh­¬ng Tö Nha nhËn ®­îc thªm " .. str2 .. "]")
        Msg2Player("Chóc mõng, Kh­¬ng Tö Nha mang ®Õn cho ngµi " .. str2 .. ".")
        str1 = "<c=g>" .. GetName() .. "<c> gia - Kh­¬ng Tö Nha trong lßng thÊy c¶m ®éng, tõ <c=g>" .. npcname .. "<c> mß ra 1 c¸i " .. str2 .. ", vui mõng ®em ®Õn tr­íc mÆt h¾n."
        Msg2CurMapAnnounce(str1)
        AddGlobalNews(str1)
      else
        WriteLog("[Linh Sñng Thuéc TÝnh][Kh­¬ng Tö Nha kh«ng nhËn ®­îc qu¸i phï ngÉu nhiªn]")
      end

    end
  end

  _G.PlayerIndex = oldPlayerIndex
end

function FosterShiJi()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(ShiJi_Pet, 1) == 0 or GetTaskByte(ShiJi_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Th¹ch C¬ N­¬ng N­¬ng råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(ShiJi_Pet, 2)
  local step = GetTaskByte(ShiJi_Pet, 3)
  local killnum = GetTask(Task_ShiJiPet)
  local id = TaskTable_ShiJi[level].id
  local id1 = TaskTable_ShiJi[level + 1].id
  local buffid = TaskTable_ShiJi[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(ShiJi_Pet, 3, level + 1)
    TaskNote(2051, 0, TaskTable_ShiJi[level].monster, 0, TaskTable_ShiJi[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_ShiJi[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_ShiJi[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_ShiJi[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_ShiJi[level].num) then

    local nTask = TaskTable_ShiJi[level].useTask
    local nTask1 = TaskTable_ShiJi[level + 1].useTask
    if (TaskTable_ShiJi[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteShiJiPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_ShiJi[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_ShiJi(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_ShiJi(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_ShiJiPet, 1) == 1) then
      CompleteShiJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Th¹ch C¬ N­¬ng N­¬ng khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo Th¹ch C¬ N­¬ng N­¬ng khi ®¸nh b¹i Giao Long!")
      TaskNote(2052, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_3()
    local str2 = "H·y dÉn theo Th¹ch C¬ N­¬ng N­¬ng lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteShiJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2053, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_ShiJiPet, 7) == 0 and GetTaskBit(Break_ShiJiPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th¹ch C¬ N­¬ng N­¬ng.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th¹ch C¬ N­¬ng N­¬ng.")
      TaskNote(2054, 0)
      SetTaskBit(Break_ShiJiPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_ShiJiPet, 7) == 0 and GetTaskBit(Break_ShiJiPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_ShiJiPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, Th¹ch C¬ N­¬ng N­¬ng rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Th¹ch C¬ N­¬ng N­¬ng ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2054, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_ShiJiPet, 2) == 1 and GetTaskBit(Break_ShiJiPet, 7) == 1) then
      CompleteShiJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteShiJiPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(ShiJi_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo Th¹ch C¬ N­¬ng N­¬ng hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo Th¹ch C¬ N­¬ng N­¬ng hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(ShiJi_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_ShiJiPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2051, -1)
  TaskNote(2052, -1)
  TaskNote(2053, -1)
  TaskNote(2054, -1)
end

function FosterTaiYi()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(TaiYi_Pet, 1) == 0 or GetTaskByte(TaiYi_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Th¸i Êt Ch©n Nh©n råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(TaiYi_Pet, 2)
  local step = GetTaskByte(TaiYi_Pet, 3)
  local killnum = GetTask(Task_TaiYiPet)
  local id = TaskTable_TaiYi[level].id
  local id1 = TaskTable_TaiYi[level + 1].id
  local buffid = TaskTable_TaiYi[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(TaiYi_Pet, 3, level + 1)
    TaskNote(2055, 0, TaskTable_TaiYi[level].monster, 0, TaskTable_TaiYi[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_TaiYi[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_TaiYi[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_TaiYi[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_TaiYi[level].num) then

    local nTask = TaskTable_TaiYi[level].useTask
    local nTask1 = TaskTable_TaiYi[level + 1].useTask
    if (TaskTable_TaiYi[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteTaiYiPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_TaiYi[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_TaiYi(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_TaiYi(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_TaiYiPet, 1) == 1) then
      CompleteTaiYiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Th¸i Êt Ch©n Nh©n khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo Th¸i Êt Ch©n Nh©n khi ®¸nh b¹i Giao Long!")
      TaskNote(2056, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_4()
    local str2 = "H·y dÉn theo Th¸i Êt Ch©n Nh©n lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteTaiYiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2057, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_TaiYiPet, 7) == 0 and GetTaskBit(Break_TaiYiPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th¸i Êt Ch©n Nh©n.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th¸i Êt Ch©n Nh©n.")
      TaskNote(2058, 0)
      SetTaskBit(Break_TaiYiPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_TaiYiPet, 7) == 0 and GetTaskBit(Break_TaiYiPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_TaiYiPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, Th¸i Êt Ch©n Nh©n rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Th¸i Êt Ch©n Nh©n ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2058, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_TaiYiPet, 2) == 1 and GetTaskBit(Break_TaiYiPet, 7) == 1) then
      CompleteTaiYiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteTaiYiPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(TaiYi_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo Th¸i Êt Ch©n Nh©n hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo Th¸i Êt Ch©n Nh©n hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(TaiYi_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_TaiYiPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2055, -1)
  TaskNote(2056, -1)
  TaskNote(2057, -1)
  TaskNote(2058, -1)
end

function FosterDaJi()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(DaJi_Pet, 1) == 0 or GetTaskByte(DaJi_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo §¸t Kû råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(DaJi_Pet, 2)
  local step = GetTaskByte(DaJi_Pet, 3)
  local killnum = GetTask(Task_DaJiPet)
  local id = TaskTable_DaJi[level].id
  local id1 = TaskTable_DaJi[level + 1].id
  local buffid = TaskTable_DaJi[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(DaJi_Pet, 3, level + 1)
    TaskNote(2059, 0, TaskTable_DaJi[level].monster, 0, TaskTable_DaJi[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_DaJi[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_DaJi[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_DaJi[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_DaJi[level].num) then

    local nTask = TaskTable_DaJi[level].useTask
    local nTask1 = TaskTable_DaJi[level + 1].useTask
    if (TaskTable_DaJi[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteDaJiPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_DaJi[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_DaJi(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_DaJi(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_DaJiPet, 1) == 1) then
      CompleteDaJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo §¸t Kû khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo §¸t Kû khi ®¸nh b¹i Giao Long!")
      TaskNote(2060, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_5()
    local str2 = "H·y dÉn theo §¸t Kû lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteDaJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2061, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_DaJiPet, 7) == 0 and GetTaskBit(Break_DaJiPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho §¸t Kû.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho §¸t Kû.")
      TaskNote(2062, 0)
      SetTaskBit(Break_DaJiPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_DaJiPet, 7) == 0 and GetTaskBit(Break_DaJiPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_DaJiPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, §¸t Kû rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn §¸t Kû ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2062, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_DaJiPet, 2) == 1 and GetTaskBit(Break_DaJiPet, 7) == 1) then
      CompleteDaJiPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteDaJiPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(DaJi_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo §¸t Kû hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo §¸t Kû hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(DaJi_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_DaJiPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2059, -1)
  TaskNote(2060, -1)
  TaskNote(2061, -1)
  TaskNote(2062, -1)
end

function DaJiSkill(growvalue)

  local PetTyte = PetGetType()
  if (PetTyte ~= 74 and PetTyte ~= 103 and PetTyte ~= 109) then

    return 0
  end
  local extravalue = 1
  if (growvalue <= 42) then
    local rannum = math.random(1, 100)
    if (rannum <= 30) then
      extravalue = 1
    elseif (rannum <= 75) then
      extravalue = 2
    elseif (rannum <= 95) then
      extravalue = 3
    else
      extravalue = 5
    end
  else
    local rannum = math.random(1, 100)
    if (rannum <= 45) then
      extravalue = 1
    elseif (rannum <= 93) then
      extravalue = 2
    elseif (rannum <= 98) then
      extravalue = 3
    else
      extravalue = 5
    end
  end
  return extravalue
end

function FosterShenGongBao()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(ShenGongBao_Pet, 1) == 0 or GetTaskByte(ShenGongBao_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Th©n C«ng B¸o råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(ShenGongBao_Pet, 2)
  local step = GetTaskByte(ShenGongBao_Pet, 3)
  local killnum = GetTask(Task_ShenGongBaoPet)
  local id = TaskTable_ShenGongBao[level].id
  local id1 = TaskTable_ShenGongBao[level + 1].id
  local buffid = TaskTable_ShenGongBao[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(ShenGongBao_Pet, 3, level + 1)
    TaskNote(2063, 0, TaskTable_ShenGongBao[level].monster, 0, TaskTable_ShenGongBao[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_ShenGongBao[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_ShenGongBao[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_ShenGongBao[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_ShenGongBao[level].num) then

    local nTask = TaskTable_ShenGongBao[level].useTask
    local nTask1 = TaskTable_ShenGongBao[level + 1].useTask
    if (TaskTable_ShenGongBao[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteShenGongBaoPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_ShenGongBao[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_ShenGongBao(level, id, id1, buffid, nTask, nTask1)
    end
  end
end

function BreakTask_ShenGongBao(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_ShenGongBaoPet, 1) == 1) then
      CompleteShenGongBaoPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Th©n C«ng B¸o khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo Th©n C«ng B¸o khi ®¸nh b¹i Giao Long!")
      TaskNote(2064, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_6()
    local str2 = "H·y dÉn theo Th©n C«ng B¸o lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteShenGongBaoPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2065, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_ShenGongBaoPet, 7) == 0 and GetTaskBit(Break_ShenGongBaoPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th©n C«ng B¸o.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Th©n C«ng B¸o.")
      TaskNote(2066, 0)
      SetTaskBit(Break_ShenGongBaoPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_ShenGongBaoPet, 7) == 0 and GetTaskBit(Break_ShenGongBaoPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_ShenGongBaoPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, Th©n C«ng B¸o rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Th©n C«ng B¸o ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2066, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_ShenGongBaoPet, 2) == 1 and GetTaskBit(Break_ShenGongBaoPet, 7) == 1) then
      CompleteShenGongBaoPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteShenGongBaoPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(ShenGongBao_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo Th©n C«ng B¸o hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo Th©n C«ng B¸o hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(ShenGongBao_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_ShenGongBaoPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2063, -1)
  TaskNote(2064, -1)
  TaskNote(2065, -1)
  TaskNote(2066, -1)
end

function FosterHuangFeiHu()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end
  if (GetTaskByte(HuangFeiHu_Pet, 1) == 0 or GetTaskByte(HuangFeiHu_Pet, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo Hoµng Phi Hæ råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(HuangFeiHu_Pet, 2)
  local step = GetTaskByte(HuangFeiHu_Pet, 3)
  local killnum = GetTask(Task_HuangFeiHuPet)
  local id = TaskTable_HuangFeiHu[level].id
  local id1 = TaskTable_HuangFeiHu[level + 1].id
  local buffid = TaskTable_HuangFeiHu[level].buffid

  if ((step == 0 or step == level) and killnum == 0) then
    SetTaskByte(HuangFeiHu_Pet, 3, level + 1)
    TaskNote(2067, 0, TaskTable_HuangFeiHu[level].monster, 0, TaskTable_HuangFeiHu[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_HuangFeiHu[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_HuangFeiHu[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_HuangFeiHu[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_HuangFeiHu[level].num) then

    local nTask = TaskTable_HuangFeiHu[level].useTask
    local nTask1 = TaskTable_HuangFeiHu[level + 1].useTask
    if (TaskTable_HuangFeiHu[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteHuangFeiHuPetTask(id, id1, buffid, nTask, nTask1)
    end

    if (TaskTable_HuangFeiHu[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_HuangFeiHu(level, id, id1, buffid, nTask, nTask1)

    end
  end
end

function BreakTask_HuangFeiHu(level, id, id1, buffid, nTask, nTask1)
  if (level == 3) then
    if (GetTaskBit(Break_HuangFeiHuPet, 1) == 1) then
      CompleteHuangFeiHuPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "H·y dÉn theo Hoµng Phi Hæ khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo Hoµng Phi Hæ khi ®¸nh b¹i Giao Long!")
      TaskNote(2068, 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_7()
    local str2 = "H·y dÉn theo Hoµng Phi Hæ lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteHuangFeiHuPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(2069, 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(Break_HuangFeiHuPet, 7) == 0 and GetTaskBit(Break_HuangFeiHuPet, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Hoµng Phi Hæ.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Hoµng Phi Hæ.")
      TaskNote(2070, 0)
      SetTaskBit(Break_HuangFeiHuPet, 8, 1)
      return
    end
    if (GetTaskBit(Break_HuangFeiHuPet, 7) == 0 and GetTaskBit(Break_HuangFeiHuPet, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(Break_HuangFeiHuPet, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, Hoµng Phi Hæ rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn Hoµng Phi Hæ ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(2070, 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(Break_HuangFeiHuPet, 2) == 1 and GetTaskBit(Break_HuangFeiHuPet, 7) == 1) then
      CompleteHuangFeiHuPetTask(id, id1, buffid, nTask, nTask1)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteHuangFeiHuPetTask(id, id1, buffid, nTask, nTask1)
  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(HuangFeiHu_Pet, 2)
  local loglevel = level + 1
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then

    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. GetName() .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo Hoµng Phi Hæ hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo Hoµng Phi Hæ hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end
  SetTaskByte(HuangFeiHu_Pet, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(Task_HuangFeiHuPet, 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. GetName() .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. loglevel .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  TaskNote(2067, -1)
  TaskNote(2068, -1)
  TaskNote(2069, -1)
  TaskNote(2070, -1)
end

function FosterNewAllPet(nIndex)

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end

  if (nIndex <= 0) or (nIndex > #TaskTable_NewAllPet) then
    return
  end

  local TaskTable_list = TaskTable_NewAllPet[nIndex].task
  local nPetTask = TaskTable_NewAllPet[nIndex].taskvalue[1]
  local sPetName = TaskTable_NewAllPet[nIndex].petname
  if (GetTaskByte(nPetTask, 1) == 0 or GetTaskByte(nPetTask, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo " .. sPetName .. " råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(nPetTask, 2)
  local step = GetTaskByte(nPetTask, 3)
  local killnum = GetTask(TaskTable_NewAllPet[nIndex].taskvalue[2])
  local id = TaskTable_list[level].id
  local id1 = TaskTable_list[level + 1].id
  local buffid = TaskTable_list[level].buffid

  if ((step == 0 or step <= level) and killnum == 0) then
    SetTaskByte(nPetTask, 3, level + 1)
    TaskNote(TaskTable_NewAllPet[nIndex].taskNoteIdx[1], 0, TaskTable_list[level].monster, 0, TaskTable_list[level].num)
    Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_list[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_list[level].num .. ".")
    return
  end

  if (step == level + 1 and killnum < TaskTable_list[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_list[level].num) then
    local nTask = TaskTable_list[level].useTask
    local nTask1 = TaskTable_list[level + 1].useTask
    if (TaskTable_list[level].spe == 0) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      CompleteNewAllPetTask(id, id1, buffid, nTask, nTask1, nIndex)
    end

    if (TaskTable_list[level].spe == 1) then
      if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
        if (GetTaskBit(nTask[1], nTask[2]) == 0) then
          Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
          return
        end
      end
      BreakTask_NewAllPet(level, id, id1, buffid, nTask, nTask1, nIndex)

    end
  end
end

function Check4boss_NewAllPet(nIndex)
  local nPetTask = TaskTable_NewAllPet[nIndex].taskvalue[3]
  local t_boss = {
    [1] = { v = GetTaskBit(nPetTask, 3), name = "§µo Ngét " },
    [2] = { v = GetTaskBit(nPetTask, 4), name = "Cïng Kú " },
    [3] = { v = GetTaskBit(nPetTask, 5), name = "Hçn §én " },
    [4] = { v = GetTaskBit(nPetTask, 6), name = "Thao ThiÕt " },
  }
  local str = ""
  for i = 1, table.getn(t_boss) do
    if (t_boss[i].v == 0) then
      str = str .. t_boss[i].name
    end
  end
  return str
end

function BreakTask_NewAllPet(level, id, id1, buffid, nTask, nTask1, nIndex)
  local nPetTask = TaskTable_NewAllPet[nIndex].taskvalue[3]
  local sPetName = TaskTable_NewAllPet[nIndex].petname
  local notelist = TaskTable_NewAllPet[nIndex].taskNoteIdx
  if (level == 3) then
    if (GetTaskBit(nPetTask, 1) == 1) then
      CompleteNewAllPetTask(id, id1, buffid, nTask, nTask1, nIndex)
    else
      Talk(1, "no", "H·y dÉn theo " .. sPetName .. " khi ®¸nh b¹i Giao Long!")
      Msg2Player("H·y dÉn theo " .. sPetName .. " khi ®¸nh b¹i Giao Long!")
      TaskNote(notelist[2], 0)
      return
    end
  end
  if (level == 6) then
    local str1 = Check4boss_NewAllPet(nIndex)
    local str2 = "H·y dÉn theo " .. sPetName .. " lóc ®¸nh b¹i §µo Ngét, Cïng Kú, Hçn §én, Thao ThiÕt."
    if (str1 == "") then
      CompleteNewAllPetTask(id, id1, buffid, nTask, nTask1, nIndex)
    else
      Talk(1, "no", str2)
      Msg2Player("Cßn cÇn ®¸nh b¹i: " .. str1)
      TaskNote(notelist[3], 0, str1)
      return
    end
  end
  if (level == 9) then
    if (GetTaskBit(nPetTask, 7) == 0 and GetTaskBit(nPetTask, 8) == 0) then
      Talk(1, "no", "H·y thu thËp <c=g>Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån<c>, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Linh Sñng Thuéc TÝnh.")
      Msg2Player("H·y thu thËp Hçn §én T©m, Cïng Kú §Çu, Thao ThiÕt Gi¸c, §µo Ngét Hån, linh lùc Èn hµm trong ®ã cã thÓ ch÷a néi th­¬ng cho Linh Sñng Thuéc TÝnh.")
      TaskNote(notelist[4], 0)
      SetTaskBit(nPetTask, 8, 1)
      return
    end
    if (GetTaskBit(nPetTask, 7) == 0 and GetTaskBit(nPetTask, 8) == 1) then
      local taowu_h = HaveNormalItem(3, 123, 0, 0)
      local qiongqi_h = HaveNormalItem(3, 121, 0, 0)
      local hundun_h = HaveNormalItem(3, 120, 0, 0)
      local taotie_h = HaveNormalItem(3, 122, 0, 0)
      if taowu_h > 0 and qiongqi_h > 0 and hundun_h > 0 and taotie_h > 0 then
        DelNormalItem(3, 123, 0, 0)
        DelNormalItem(3, 121, 0, 0)
        DelNormalItem(3, 120, 0, 0)
        DelNormalItem(3, 122, 0, 0)
        SetTaskBit(nPetTask, 7, 1)
        Talk(1, "no", "BÞ <c=g>Gi¸o chñ HuyÔn TrËn<c> ®¶ th­¬ng, " .. sPetName .. " rÊt ®au lßng, ®· biÕn thµnh T©m Ma, dÉn " .. sPetName .. " ®¸nh b¹i <c=g>Gi¸o chñ HuyÔn TrËn<c> míi cã thÓ ph¸ t©m ma, ®¹i thµnh th¨ng cÊp.")
        TaskNote(notelist[4], 2)
        return
      else
        Talk(1, "no", "Ch­a hoµn thµnh thu thËp ®Çu BOSS, h·y hoµn thµnh råi tíi t×m ta..")
        return
      end

    end
    if (GetTaskBit(nPetTask, 2) == 1 and GetTaskBit(nPetTask, 7) == 1) then
      CompleteNewAllPetTask(id, id1, buffid, nTask, nTask1, nIndex)
    else
      Talk(1, "no", "Ch­a hoµn thµnh nhiÖm vô ®¸nh b¹i gi¸o chñ HuyÔn trËn.")
    end
  end
end

function CompleteNewAllPetTask(id, id1, buffid, nTask, nTask1, nIndex)
  local nPetTask = TaskTable_NewAllPet[nIndex].taskvalue[1]
  local sPetName = TaskTable_NewAllPet[nIndex].petname
  local notelist = TaskTable_NewAllPet[nIndex].taskNoteIdx

  local str = "Chóc mõng, cÊp ®é linh sñng ®· ®­îc t¨ng lªn, h·y dïng Hép Linh Sñng B¸ch BiÕn hoÆc quyÓn trôc sau khi th¨ng cÊp."
  local level = GetTaskByte(nPetTask, 2)
  if (GetTaskBit(nTask[1], nTask[2]) == 1) then
    SetTaskBit(nTask1[1], nTask1[2], 1)
  elseif (DelNormalItem(id[1], id[2], id[3], id[4]) > 0) then
    AddNormalItemBind(id1[1], id1[2], id1[3], id1[4], 0, 0, 1)
  else
    WriteLog("[" .. sPetName .. "][Th¨ng cÊp linh sñng thÊt b¹i][KhÊu trõ ®¹o cô thÊt b¹i][ID:" .. id[1] .. " " .. id[2] .. " " .. id[3] .. " " .. id[4] .. "]")
    Msg2Player("Xin anh hïng h·y mang theo " .. sPetName .. " hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    Talk(1, "no", "Xin anh hïng h·y mang theo " .. sPetName .. " hoÆc Hép Linh Sñng B¸ch BiÕn ®Õn ®©y.")
    return
  end

  SetTaskByte(nPetTask, 1, 0)
  PetSetType(1)
  RemoveIBBuff(buffid)
  SetTask(TaskTable_NewAllPet[nIndex].taskvalue[2], 0)
  Talk(1, "no", str)
  Msg2Player(str)
  WriteLog("[" .. sPetName .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][NhËn ®­îc:" .. (level + 1) .. " cÊp QuyÓn Trôc hoÆc Hép Linh Sñng B¸ch BiÕn]")
  for i = 1, 5 do
    TaskNote(notelist[i], -1)
  end
end

function FosterAllPet2New(nIndex)
  no()

  if (NewServerEx.Pub_IsNewServer() > 0) then
    Talk(1, "no", "HiÖn ®ang trong thêi gian ho¹t ®éng m¸y chñ míi, ®Ó gi÷ c©n b»ng, thêi gian nµy t¹m thêi kh«ng thÓ tu luyÖn linh sñng thuéc tÝnh.")
    return
  end

  if (nIndex <= 0) or (nIndex > #TaskTable_AllPet2New) then
    Msg2Player("Sai th«ng tin, vui lßng chän l¹i")
    return
  end

  local TaskTable_list = TaskTable_AllPet2New[nIndex].task
  local nPetTask = TaskTable_AllPet2New[nIndex].taskvalue[1]
  local sPetName = TaskTable_AllPet2New[nIndex].petname
  if (GetTaskByte(nPetTask, 1) == 0 or GetTaskByte(nPetTask, 2) == 0) then
    Talk(1, "no", "Xin anh hïng h·y mang theo " .. sPetName .. " råi ®Õn t×m ta.")
    return
  end
  local level = GetTaskByte(nPetTask, 2)
  local step = GetTaskByte(nPetTask, 3)
  local killnum = GetTask(TaskTable_AllPet2New[nIndex].taskvalue[2])
  local id = TaskTable_AllPet2New[nIndex].id
  local buffid = TaskTable_list[level].buffid

  if ((step == 0 or step <= level) and killnum == 0) then
    SetTaskByte(nPetTask, 3, level + 1)
    if (TaskTable_list[level].spe == 0) then
      Talk(1, "no", "Xin h·y ®¸nh b¹i qu¸i vËt cÊp " .. TaskTable_list[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_list[level].num .. ".")
      TaskNote(TaskTable_AllPet2New[nIndex].taskNoteIdx, 0, TaskTable_list[level].monster, 0, TaskTable_list[level].num)
    else
      Talk(1, "no", "ÇëÈ¥[Tiªn Ma Giíi]´ò°ÜµÈ¼¶²»Ð¡ÓÚ" .. TaskTable_list[level].monster .. " trë lªn, sè l­îng qu¸i cÇn tiªu diÖt: " .. TaskTable_list[level].num .. ".")
      TaskNote(TaskTable_AllPet2New[nIndex].taskNoteIdx, 2, TaskTable_list[level].monster, 0, TaskTable_list[level].num)
    end
    return
  end

  if (step == level + 1 and killnum < TaskTable_list[level].num) then
    Talk(1, "no", "Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    Msg2Player("Ch­a tiªu diÖt ®ñ sè qu¸i vËt yªu cÇu, h·y mau ®i tiªu diÖt thªm!")
    return
  end

  if (step == level + 1 and killnum >= TaskTable_list[level].num) then
    local nTask = TaskTable_AllPet2New[nIndex].useTask
    if (HaveNormalItem(id[1], id[2], id[3], id[4]) <= 0) then
      if (GetTaskBit(nTask[1], nTask[2]) == 0) then
        Talk(1, "no", "Xin h·y mang theo QuyÓn Trôc cña linh sñng hoÆc Hép Linh Sñng B¸ch BiÕn tíi giao nhiÖm vô")
        return
      end
    end

    SetTaskByte(nPetTask, 1, 0)
    PetSetType(1)
    RemoveIBBuff(buffid)
    SetTask(TaskTable_AllPet2New[nIndex].taskvalue[2], 0)
    SetTaskByte(nPetTask, 2, level + 1)
    Talk(1, "no", "Chóc mõng ngµi, cÊp ®é cña Linh sñng ®· t¨ng lªn, h·y dïng quyÓn trôc ®Ó kÝch ho¹t Linh sñng cÊp ®é míi")
    Msg2Player("Chóc mõng ngµi, cÊp ®é cña Linh sñng ®· t¨ng lªn, h·y dïng quyÓn trôc ®Ó kÝch ho¹t Linh sñng cÊp ®é míi")
    WriteLog("[" .. sPetName .. "][Th¨ng cÊp Linh Sñng Thuéc TÝnh][§¹t ®Õn: CÊp " .. (level + 1) .. "]")
    TaskNote(TaskTable_AllPet2New[nIndex].taskNoteIdx, -1)
  end
end

t_GetPetRight = {
  [1] = {
    petname = "Hå Hû MÞ",
    Acoountlist = {},
  },

  [2] = {
    petname = "Na Tra",
    Acoountlist = {},
  },

  [3] = {
    petname = "L«i ChÊn Tö",
    Acoountlist = {},
  },

  [4] = {
    petname = "Th¹ch C¬ N­¬ng N­¬ng",
    Acoountlist = {},
  },

  [5] = {
    petname = "Th¸i Êt Ch©n Nh©n",
    Acoountlist = {},
  },

  [6] = {
    petname = "§¾c Kû",
    Acoountlist = {},
  },

  [7] = {
    petname = "Th©n C«ng B¸o",
    Acoountlist = {},
  },

  [8] = {
    petname = "Hoµng Phi Hæ",
    Acoountlist = {},
  },

  [9] = {
    petname = "H¹o Thiªn KhuyÓn",
    Acoountlist = {},
  },

  [10] = {
    petname = "D­¬ng TiÔn",
    Acoountlist = {},
  },

  [11] = {
    petname = "Kh­¬ng Tö Nha",
    Acoountlist = {},
  },

  [12] = {
    petname = "Lý TÞnh",
    Acoountlist = {},
  },

  [13] = {
    petname = "Phi Th¨ng-Hå HØ MÞ",
    Acoountlist = {},
  },

  [14] = {
    petname = "Phi Th¨ng-Na Tra",
    Acoountlist = {},
  },

  [15] = {
    petname = "Phi Th¨ng-L«i ChÊn Tö",
    Acoountlist = {},
  },

  [16] = {
    petname = "Phi Th¨ng-Th¹ch C¬",
    Acoountlist = {},
  },

  [17] = {
    petname = "Phi Th¨ng-Th¸i Êt",
    Acoountlist = {},
  },

  [18] = {
    petname = "Phi Th¨ng-§¸t Kû",
    Acoountlist = {},
  },

  [19] = {
    petname = "Phi Th¨ng-Th©n C«ng B¸o",
    Acoountlist = {},
  },
  [20] = {
    petname = "Phi Th¨ng-Hoµng Phi Hæ",
    Acoountlist = {},
  },

  [21] = {
    petname = "Phi Th¨ng-Hao Thiªn KhuyÓn",
    Acoountlist = {},
  },

  [22] = {
    petname = "Phi Th¨ng-D­¬ng TiÔn",
    Acoountlist = {},
  },

  [23] = {
    petname = "Phi Th¨ng-Kh­¬ng Tö Nha",
    Acoountlist = {},
  },

  [24] = {
    petname = "Phi Th¨ng-Lý TÞnh",
    Acoountlist = {},
  },
  [25] = {
    petname = "Lôc ¸p §¹o Nh©n",
    Acoountlist = {},
  },
}

function JudgeAndDel(name, id1, id2, id3, id4)
  local idx = 0
  for i = 1, table.getn(t_GetPetRight) do
    if (name == t_GetPetRight[i].petname) then
      idx = i
      break
    end
  end

  if (idx < 1) then
    return 1
  end

  local acoountlist = t_GetPetRight[idx].Acoountlist
  local result = 0
  for j = 1, table.getn(acoountlist) do
    if (GetAccount() == acoountlist[j]) then
      result = 1
      return 0
    end
  end
  if (result == 0 and GetTaskBit(PetRoleTask, idx) == 0) then

    if (id3 == 0) and (id4 > 0) then
      if (idx >= 9) then
        if (math.floor(id4 / 100) + 8 == idx) then
          local temp = TaskTable_NewAllPet[idx - 8].task
          for i = 1, 10 do
            SetTaskBit(temp[i].useTask[1], temp[i].useTask[2], 0)
          end
        elseif (math.floor(id4 / 200) + 24 == idx) then
          local temp = TaskTable_AllPet2New[idx - 24].useTask
          SetTaskBit(temp[1], temp[2], 0)
        else
          SetTaskBit(id1, id2, 0)
        end
      else
        if (AllPetTable[id4].useTask[1] == id1) and (AllPetTable[id4].useTask[2] == id2) then
          for i = (idx * 10 - 9), id4 do
            if (t_GetPetRight[idx].petname == AllPetTable[id4].itemname) then
              SetTaskBit(AllPetTable[i].useTask[1], AllPetTable[i].useTask[2], 0)
            end
          end
        else
          SetTaskBit(id1, id2, 0)
        end
      end
    else
      DelNormalItem(id1, id2, id3, id4)
      DelNormalItem(id1, id2, id3, 0)
    end

    Removeallpetbuff()
    ChangePet()

    for i = 1, table.getn(AllPetTable) do
      if (idx == AllPetTable[i].PetType) then
        SetTask(AllPetTable[i].taskvalue[1], 0)
        SetTask(AllPetTable[i].taskvalue[2], 0)
        SetTask(AllPetTable[i].taskvalue[3], 0)
        break
      end
    end

    for i = 1, #TaskTable_NewAllPet do
      if (idx == TaskTable_NewAllPet[i].PetType) then
        SetTask(TaskTable_NewAllPet[i].taskvalue[1], 0)
        SetTask(TaskTable_NewAllPet[i].taskvalue[2], 0)
        SetTask(TaskTable_NewAllPet[i].taskvalue[3], 0)
        for j = 1, 4 do
          TaskNote(TaskTable_NewAllPet[i].taskNoteIdx[j], -1)
        end
        break
      end
    end

    for i = 1, #TaskTable_AllPet2New do
      if (idx == TaskTable_AllPet2New[i].PetType) then
        SetTask(TaskTable_AllPet2New[i].taskvalue[1], 0)
        SetTask(TaskTable_AllPet2New[i].taskvalue[2], 0)
        TaskNote(TaskTable_AllPet2New[i].taskNoteIdx, -1)
        break
      end
    end

    local tp = PetGetType()
    if (tp > 45) then
      PetSetType(1)
      Msg2Player("Xin lçi, ngµi kh«ng ®ñ ®iÒu kiÖn " .. name .. ", bÞ thu håi biÕn th©n phï hiÖn t¹i, h×nh t­îng linh sñng thuéc tÝnh trë thµnh Lôc Phi Phi.")
    else
      Msg2Player("Xin lçi, ngµi kh«ng ®ñ ®iÒu kiÖn " .. name .. ", bÞ thu håi biÕn th©n phï hiÖn t¹i.")
    end
    if (id3 == 0) then
      WriteLog("[Linh Sñng Thuéc TÝnh][Huû thÎ Linh Sñng kh«ng hîp lÖ:" .. name .. "][H×nh t­îng " .. tp .. "][id4:" .. id4)
    else
      WriteLog("[Linh Sñng Thuéc TÝnh][Huû thÎ Linh Sñng kh«ng hîp lÖ:" .. name .. "][H×nh t­îng " .. tp .. "][id3:" .. id3)
    end

    return 1
  end
  return 0
end

function PetBoxInfo(Lmin, Lmax, Lgold, Ntype)
  local str = "Ngµi x¸c ®Þnh ®em tÊt c¶ biÕn th©n phï d­íi ®©y cho vµo Hép B¸ch BiÕn chø? <c=r>Huû bá sÏ quay l¹i lùa chän tr­íc<c>\n"
  local id = { 0, 0, 0, 0 }
  local k = 0
  local petboxlist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

  for i = Lmin, Lmax do
    id = AllPetTable[i].itemid
    if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
      str = str .. "<c=g>" .. AllPetTable[i].itemname .. " (CÊp " .. AllPetTable[i].lvl .. ")<c>\n"
      k = i - Ntype * 10
      petboxlist[k] = i
    end
  end

  if (Lgold > 0) then
    id = AllPetTable[Lgold].itemid
    if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
      k = 11
      str = str .. "<c=y>" .. AllPetTable[Lgold].itemname .. "<c>"
      petboxlist[k] = Lgold
    end
  end

  return k, str, petboxlist
end

function setSavePetBox(Lmin, Lmax, Ntype, petboxlist)
  local nName = ""
  local id = { 0, 0, 0, 0 }
  local str = "Ngµi thµnh c«ng thu n¹p "
  local idx = 0
  local key = 0

  if (Ntype < 8) then
    id = AllPetTable[81 + Ntype].itemid
    for j = 0, 1 do
      ClearItem(id[1], id[2], id[3], j)
    end

    idx = petboxlist[11]
    if (idx > 0) then
      key = 1
      nName = AllPetTable[idx].itemname
      ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. nName)
      str = str .. nName .. ","
      SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
    end
  end

  for k = 1, 10 do
    idx = petboxlist[k]
    if (idx > 0) then
      nName = AllPetTable[idx].itemname
      id = AllPetTable[idx].itemid
      if (JudgeAndDel(nName, id[1], id[2], id[3], id[4]) == 0) then
        ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. nName)
        str = str .. nName .. " (" .. AllPetTable[idx].lvl .. " cÊp)"
        SetTaskBit(AllPetTable[idx].useTask[1], AllPetTable[idx].useTask[2], 1)
        key = 1
      end
    end
  end

  for i = Lmin, Lmax do
    id = AllPetTable[i].itemid
    for j = 0, 1 do
      ClearItem(id[1], id[2], id[3], j)
    end
  end

  if (key == 1) then
    if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
      ClearItem(6, 1, 1594, 0)
      ClearItem(6, 1, 1594, 1)
      AddNormalItem(6, 1, 1594, 0, 0, 0)
      Msg2Player(str .. " ®ång thêi nhËn ®­îc 1 Hép Linh Sñng B¸ch BiÕn.")
    else
      Msg2Player(str .. " ®Òu ®· ®­îc bá vµo bªn trong Hép Linh Sñng B¸ch BiÕn")
    end
    WriteLog("[Hép Linh Sñng B¸ch BiÕn]" .. str)
  end
  return key
end

function PetBoxInfoNew(Ntype)
  local str = "Ngµi x¸c ®Þnh ®em tÊt c¶ biÕn th©n phï d­íi ®©y cho vµo Hép B¸ch BiÕn chø? <c=r>Huû bá sÏ quay l¹i lùa chän tr­íc<c>\n"
  local id = { 0, 0, 0, 0 }
  local k = 0
  local petboxlist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
  local temp = {}

  for i = 1, #TaskTable_NewAllPet do
    if (TaskTable_NewAllPet[i].PetType == Ntype) then
      temp = TaskTable_NewAllPet[i].task
      for j = 1, #temp do
        id = temp[j].id
        if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
          if (temp[j].lvl == 11) then
            str = str .. "<c=y>" .. temp[j].itemname .. "<c>\n"
          else
            str = str .. "<c=g>" .. TaskTable_NewAllPet[i].petname .. " (CÊp " .. temp[j].lvl .. ")<c>\n"
          end
          k = i
          petboxlist[j] = j
        end
      end
      break
    end
  end
  return k, str, petboxlist
end

function setSavePetBoxNew(idx, Ntype, petboxlist)
  if (idx <= 0) then
    return 0
  end

  if (TaskTable_NewAllPet[idx].PetType ~= Ntype) then
    return 0
  end

  local nName = TaskTable_NewAllPet[idx].petname
  local temp = TaskTable_NewAllPet[idx].task
  local id = { 0, 0, 0, 0 }

  local str = "Ngµi thµnh c«ng thu n¹p "
  local cstr = ""
  local Lmax = 1
  local key = 0

  for i = 11, 1, -1 do
    if (GetBit(petboxlist, i) == 1) then
      Lmax = math.min(i, #temp)
      break
    end
  end

  for i = 1, Lmax do
    id = temp[i].id
    for j = 0, 1 do
      ClearItem(id[1], id[2], id[3], j)
    end
    if (GetBit(petboxlist, i) == 1) then
      if (temp[i].lvl == 11) then
        cstr = temp[i].itemname
        ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. cstr)
        str = str .. cstr .. ","
        SetTaskBit(temp[i].useTask[1], temp[i].useTask[2], 1)
        key = 1
      else
        if (JudgeAndDel(nName, id[1], id[2], id[3], id[4]) == 0) then
          cstr = nName .. "(" .. temp[i].lvl .. ")"
          ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. cstr)
          str = str .. cstr .. ","
          SetTaskBit(temp[i].useTask[1], temp[i].useTask[2], 1)
          key = 1
        end
      end
    end
  end
  if (key == 1) then
    if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
      ClearItem(6, 1, 1594, 0)
      ClearItem(6, 1, 1594, 1)
      AddNormalItem(6, 1, 1594, 0, 0, 0)
      Msg2Player(str .. " ®ång thêi nhËn ®­îc 1 Hép Linh Sñng B¸ch BiÕn.")
    else
      Msg2Player(str .. " ®Òu ®· ®­îc bá vµo bªn trong Hép Linh Sñng B¸ch BiÕn")
    end
    WriteLog("[Hép Linh Sñng B¸ch BiÕn]" .. str)
  end
  return key
end

function PetBoxInfoNew2(Ntype)
  local str = "Ngµi x¸c ®Þnh ®em tÊt c¶ biÕn th©n phï d­íi ®©y cho vµo Hép B¸ch BiÕn chø? <c=r>Huû bá sÏ quay l¹i lùa chän tr­íc<c>\n"
  local id = { 0, 0, 0, 0 }
  local k = 0

  for i = 1, #TaskTable_AllPet2New do
    if (TaskTable_AllPet2New[i].PetType == Ntype) then
      id = TaskTable_AllPet2New[i].id
      if (HaveItemInAllRoom(id[1], id[2], id[3], id[4], 0, 0, 0) > 0) then
        str = str .. "<c=g>" .. TaskTable_AllPet2New[i].petname .. "<c>\n"
        k = i
        break
      end
    end
  end
  return k, str
end

function setSavePetBoxNew2(idx, Ntype)
  if (idx <= 0) then
    return 0
  end

  if (TaskTable_AllPet2New[idx].PetType ~= Ntype) then
    return 0
  end

  local nName = TaskTable_AllPet2New[idx].petname
  local temp = TaskTable_AllPet2New[idx]
  local id = { 0, 0, 0, 0 }
  id = TaskTable_AllPet2New[idx].id

  for j = 0, 1 do
    ClearItem(id[1], id[2], id[3], j)
  end

  ScrollMessage("Thµnh c«ng thu n¹p <c=y>" .. nName)
  SetTaskBit(temp.useTask[1], temp.useTask[2], 1)
  if (HaveItemInAllRoom(6, 1, 1594, 0, 0, 0, 0) == 0) then
    ClearItem(6, 1, 1594, 0)
    ClearItem(6, 1, 1594, 1)
    AddNormalItem(6, 1, 1594, 0, 0, 0)
    Msg2Player("Ngµi thµnh c«ng thu n¹p " .. nName .. ", ®ång thêi nhËn ®­îc 1 Hép Linh Sñng B¸ch BiÕn.")
  else
    Msg2Player("Ngµi thµnh c«ng thu n¹p " .. nName .. ", ®· ®­a vµo bªn trong Hép Linh Sñng B¸ch BiÕn")
  end
  WriteLog("[Hép Linh Sñng B¸ch BiÕn]" .. nName)
  return 1
end

function JudgeCombos(nIndex)
  if (nIndex < 1) or (nIndex > #L_PETCOMBOS) then
    return 0
  end

  if (GetTaskBit(PetRoleCombosTask, L_PETCOMBOS[nIndex].bit) == 1) then
    SetTaskByte(L_PETCOMBOS[nIndex].taskIdx[1], L_PETCOMBOS[nIndex].taskIdx[2], L_PETCOMBOS[nIndex].petID)
    return 1
  end

  local temp = {}
  local name = L_PETCOMBOS[nIndex].name
  temp = L_PETCOMBOS[nIndex].pet1
  if (GetTaskBit(temp[3], temp[4]) == 0) then
    JudgeAndDel(L_PETCOMBOS[nIndex].petname1, temp[1], temp[2], 0, 1)
    if (GetTaskBit(temp[1], temp[2]) == 0) then
      SetTaskByte(L_PETCOMBOS[nIndex].taskIdx[1], L_PETCOMBOS[nIndex].taskIdx[2], 0)
      WriteLog("[Linh Sñng Thuéc TÝnh][Huû tæ hîp kü:" .. name .. "] v× " .. L_PETCOMBOS[nIndex].petname1)
      return 0
    end
  end

  temp = L_PETCOMBOS[nIndex].pet2
  if (GetTaskBit(temp[3], temp[4]) == 0) then
    JudgeAndDel(L_PETCOMBOS[nIndex].petname2, temp[1], temp[2], 0, 1)
    if (GetTaskBit(temp[1], temp[2]) == 0) then
      SetTaskByte(L_PETCOMBOS[nIndex].taskIdx[1], L_PETCOMBOS[nIndex].taskIdx[2], 0)
      WriteLog("[Linh Sñng Thuéc TÝnh][Huû tæ hîp kü:" .. name .. "] v× " .. L_PETCOMBOS[nIndex].petname2)
      return 0
    end
  end
end

function JudgePetItem(name)
  local idx = 0
  for i = 1, table.getn(t_GetPetRight) do
    if (name == t_GetPetRight[i].petname) then
      idx = i
      break
    end
  end
  if (idx < 1) then
    return 1
  end
  local acoountlist = t_GetPetRight[idx].Acoountlist
  local result = 0
  for j = 1, table.getn(acoountlist) do
    if (GetAccount() == acoountlist[j]) then
      result = 1
      return 0
    end
  end
  if (result == 0 and GetTaskBit(PetRoleTask, idx) == 0) then
    return 1
  end
  return 0
end

function Check_Distance(mapidx, nNpcx, nNpcy)
  local w, x, y = GetWorldPos()
  if w == mapidx then
    local nDis = math.sqrt((x - nNpcx) ^ 2 + ((y - nNpcy) ^ 2)) * 32
    if nDis < 400 then
      return 1
    end
  end
  return 0
end

function DropBook(NpcIndex, mapidx, nNpcx, nNpcy)
  if (NpcIndex == nil) then
    return
  end

  local npcname = GetNpcName(NpcIndex)

  local oldPlayerIndex = _G.PlayerIndex
  local logP = GetDropPlayer(NpcIndex)
  local oldName = GetName()

  if (oldPlayerIndex <= 0) then
    if (logP <= 0) then
      WriteLog(npcname .. " tö väng, Phi Th¨ng D­¬ng TiÔn kh«ng biÕt quyÒn nhÆt lµ cña ai")
      return
    else
      _G.PlayerIndex = logP
      WriteLog(npcname .. " tö väng, Phi Th¨ng D­¬ng TiÔn quyÒn nhÆt ®æi thµnh: " .. GetName())
    end
  else
    _G.PlayerIndex = logP
    WriteLog(npcname .. " tö väng, Phi Th¨ng D­¬ng TiÔn quyÒn nhÆt lµ " .. oldName)
    _G.PlayerIndex = oldPlayerIndex
  end

  local another = 0
  if (GetTeam() > 0) then

    local nPeople = GetTeamSize()
    for i = 1, nPeople do
      _G.PlayerIndex = GetTeamMember(i)
      if (Check_Distance(mapidx, nNpcx, nNpcy) == 1) then
        local PetTyte = PetGetType()
        if ((PetTyte == 162 or PetTyte == 169) and GetTaskByte(TaskTable_NewAllPet[14].taskvalue[1], 2) >= 10) then
          another = math.random(100)
          if (another > 97) then
            getDropBook(0, npcname, "boss")
          else
            WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. "]Phi Th¨ng D­¬ng TiÔn: boss thÊt b¹i " .. another)
          end
        end
      end
    end

  else
    local PetTyte = PetGetType()
    if ((PetTyte == 162 or PetTyte == 169) and GetTaskByte(TaskTable_NewAllPet[14].taskvalue[1], 2) >= 10) then
      another = math.random(100)
      if (another > 97) then
        getDropBook(0, npcname, "boss")
      else
        WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. "]Phi Th¨ng D­¬ng TiÔn: boss thÊt b¹i " .. another)
      end
    end
  end

  _G.PlayerIndex = oldPlayerIndex
end

function getDropBook(key, npcname, strType)
  local today = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
  if (GetTaskByte(2277, 1) ~= today) then
    SetTask(2277, today)
  end

  if (GetTaskByte(2277, 2) > 0) then
    WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. "]Phi Th¨ng D­¬ng TiÔn: boss ®· ®¹t giíi h¹n")
    return
  end

  if (key == nil) or (key < 0) or (key > 1) then
    key = 1
  end
  local tItemlist = {
    { itemname = "§å phæ trang bÞ cam", itemid = { 2, 188, 262 }, pro = 400, annouce = 0, },
    { itemname = "Phèi ph­¬ng LuyÖn §an", itemid = { 2, 719, 722 }, pro = 125, annouce = 0 },
    { itemname = "Phèi ph­¬ng LuyÖn §an cao cÊp", itemid = { 2, 694, 698 }, pro = 0, annouce = 1 },
    { itemname = "Phèi ph­¬ng LuyÖn §an", itemid = { 1, 692 }, pro = 75, annouce = 0 },
    { itemname = "Phèi ph­¬ng nÊu ¨n Cao cÊp", itemid = { 2, 699, 702 }, pro = 0, annouce = 1 },
    { itemname = "§å phæ trang bÞ cam", itemid = { 2, 366, 380 }, pro = 100, annouce = 0 },
    { itemname = "Phèi ph­¬ng LuyÖn §an", itemid = { 1, 693 }, pro = 45, annouce = 0 },
    { itemname = "Phèi ph­¬ng LuyÖn chÕ cao cÊp", itemid = { 1, 703 }, pro = 30, annouce = 1 },
    { itemname = "Phèi ph­¬ng NÊu ¨n", itemid = { 2, 1050, 1051 }, pro = 75, annouce = 0 },
    { itemname = "Phèi ph­¬ng LuyÖn §an cao cÊp", itemid = { 1, 1049 }, pro = 35, annouce = 1 },
    { itemname = "Phèi ph­¬ng LuyÖn §an", itemid = { 1, 1048 }, pro = 65, annouce = 0 },
    { itemname = "§å phæ Ph¸ Qu©n", itemid = { 2, 278, 292 }, pro = 50, annouce = 1 },
  }

  local log_str = "Kh«ng nhËn ®­îc §å phæ, phèi ph­¬ng"
  local rannum = math.random(1, 1000)
  local itemR = 0
  local prob = 0

  for i = 1, table.getn(tItemlist) do
    prob = prob + tItemlist[i].pro
    if (rannum <= prob) then
      SetTaskByte(2277, 2, 1)
      if (tItemlist[i].itemid[1] == 2) then
        itemR = math.random(tItemlist[i].itemid[2], tItemlist[i].itemid[3])
        AddNormalItemBind(6, 1, itemR, 0, 0, 0, key)
        log_str = tItemlist[i].itemname .. itemR
      else
        AddNormalItemBind(6, 1, tItemlist[i].itemid[2], 0, 0, 0, key)
        log_str = tItemlist[i].itemname .. tItemlist[i].itemid[2]
      end

      if (tItemlist[i].annouce == 1) then
        AddGlobalNews("Anh hïng " .. GetName() .. "-Phi Th¨ng D­¬ng TiÔn më thiªn nh·n, tõ <c=g>" .. npcname .. "<c> thµnh c«ng th¸c Ên ra 1 b¶n " .. tItemlist[i].itemname .. " hoµn chØnh!")
      end
      Msg2Player("Phi Th¨ng D­¬ng TiÔn mang ®Õn cho ngµi 1 b¶n hoµn chØnh-" .. tItemlist[i].itemname)
      Msg2CurMapAnnounce("Phi Th¨ng D­¬ng TiÔn v× <RoleName=\"" .. GetName() .. "\"> thµnh c«ng th¸c Ên 1 b¶n hoµn chØnh - " .. tItemlist[i].itemname .. "!")
      break
    end
  end
  if (key == 0) then
    WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. "]Phi Th¨ng D­¬ng TiÔn: " .. log_str .. strType)
  else
    WriteLog("[Linh Sñng Thuéc TÝnh][" .. npcname .. "]Phi Th¨ng D­¬ng TiÔn: (Kho¸)" .. log_str .. strType)
  end
end



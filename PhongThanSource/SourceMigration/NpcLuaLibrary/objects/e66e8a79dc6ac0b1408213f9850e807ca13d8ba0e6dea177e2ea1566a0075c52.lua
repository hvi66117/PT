require("king/lib.luax")

EventMidAutumnRabbit = EventMidAutumnRabbit or {}

EventMidAutumnRabbit.nTaskNoteId = 1613

EventMidAutumnRabbit.szName = "<c=g>T×m thá ngäc<c>"
EventMidAutumnRabbit.nRequiredLevel = 25
EventMidAutumnRabbit.nMaxCatchCount = 30
EventMidAutumnRabbit.nStartDate = 20220910
EventMidAutumnRabbit.nEndDate = 20220912
EventMidAutumnRabbit.nStartHour = 20
EventMidAutumnRabbit.nEndHour = 22

EventMidAutumnRabbit.nWorldID = 21 -- trieu ca

EventMidAutumnRabbit.nTaskIdRabbit = 1735
EventMidAutumnRabbit.nByte_TaskRabbit_Step = 1 -- 0: missed, 1: joined, 2: done
EventMidAutumnRabbit.nByte_CatchRabbitLastDate = 2
EventMidAutumnRabbit.nByte_TaskRabbit_CatchCnt = 3
EventMidAutumnRabbit.nTaskStep_None = 0
EventMidAutumnRabbit.nTaskStep_Accepted = 1
EventMidAutumnRabbit.nTaskStep_Finished = 2
EventMidAutumnRabbit.nMorphId_FindRabbit = 1704 -- bien than tim tho
EventMidAutumnRabbit.nBuffId_FindRabbit = 1331 -- buff tim tho

EventMidAutumnRabbit.nAward_BaseExp = 50000
EventMidAutumnRabbit.nAward_ExpRate = 500

EventMidAutumnRabbit.nTaskIdCaughtRabbitId = 1736 -- everytime rabbit was catch
EventMidAutumnRabbit.NPCTVID_RouteStep = 0
EventMidAutumnRabbit.nBuffId_CatchRabbit = 1326

EventMidAutumnRabbit.nPosBaseX = 1769;
EventMidAutumnRabbit.nPosBaseY = 3029;

EventMidAutumnRabbit.tbPosDelta = {
  [1] = { 0, 0 },
  [2] = { 3, 0 },
  [3] = { 0, 3 },
  [4] = { -3, 0 },
  [5] = { 0, -3 },
  [6] = { 2, 2 },
  [7] = { -2, 2 },
  [8] = { -2, -2 },
  [9] = { 2, -2 },
}

EventMidAutumnRabbit.tbRoute = {
  [1] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1770, y = 3001, }, },
  [2] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1750, y = 2981, }, },
  [3] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1723, y = 2953, }, },
  [4] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1723, y = 2953, }, [3] = { x = 1705, y = 2959, }, },
  [5] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1795, y = 3022, }, },
  [6] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1809, y = 3039, }, },
  [7] = { [1] = { x = 1782, y = 3013, }, [2] = { x = 1846, y = 3079, }, },
  [8] = { [1] = { x = 1810, y = 2980, }, [2] = { x = 1794, y = 2966, }, },
  [9] = { [1] = { x = 1810, y = 2980, }, [2] = { x = 1826, y = 2997, }, },
  [10] = { [1] = { x = 1841, y = 2952, }, [2] = { x = 1821, y = 2933, }, },
  [11] = { [1] = { x = 1841, y = 2952, }, [2] = { x = 1782, y = 2871, }, },
  [12] = { [1] = { x = 1841, y = 2952, }, [2] = { x = 1863, y = 2963, }, },
  [13] = { [1] = { x = 1874, y = 2919, }, },
  [14] = { [1] = { x = 1896, y = 2896, }, [2] = { x = 1909, y = 2889, }, },
  [15] = { [1] = { x = 1811, y = 3083, }, },
  [16] = { [1] = { x = 1830, y = 3079, }, },
  [17] = { [1] = { x = 1798, y = 3095, }, },
  [18] = { [1] = { x = 1712, y = 3023, }, },
  [19] = { [1] = { x = 1730, y = 2991, }, [2] = { x = 1706, y = 2997, }, },
  [20] = { [1] = { x = 1730, y = 2991, }, [2] = { x = 1706, y = 2997, }, [3] = { x = 1695, y = 3010, }, },
  [21] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1758, y = 3120, }, },
  [22] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1760, y = 3124, }, [3] = { x = 1750, y = 3131, }, },
  [23] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1707, y = 3123, }, },
  [24] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1760, y = 3124, }, [3] = { x = 1734, y = 3145, }, },
  [25] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1680, y = 3055, }, },
  [26] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1680, y = 3055, }, [3] = { x = 1660, y = 3045, }, },
  [27] = { [1] = { x = 1723, y = 3077, }, [2] = { x = 1680, y = 3055, }, [3] = { x = 1649, y = 3056, }, },
  [28] = { [1] = { x = 1705, y = 3093, }, [2] = { x = 1682, y = 3095, }, },
  [29] = { [1] = { x = 1705, y = 3093, }, [2] = { x = 1671, y = 3090, }, },
  [30] = { [1] = { x = 1758, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1677, y = 2997, }, },
  [31] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1660, y = 3010, }, },
  [32] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1630, y = 2969, }, [4] = { x = 1635, y = 2990, }, },
  [33] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1630, y = 2969, }, [4] = { x = 1657, y = 2965, }, },
  [34] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1630, y = 2969, }, [4] = { x = 1634, y = 2949, }, },
  [35] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1630, y = 2969, }, [4] = { x = 1604, y = 2962, }, },
  [36] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1630, y = 2969, }, [4] = { x = 1603, y = 2995, }, [5] = { x = 1586, y = 2994, }, },
  [37] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1603, y = 2939, }, [4] = { x = 1590, y = 2955, }, },
  [38] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1671, y = 3013, }, [3] = { x = 1603, y = 2939, }, [4] = { x = 1612, y = 2936, }, },
  [39] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1779, y = 3132, }, [3] = { x = 1775, y = 3143, }, },
  [40] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1779, y = 3132, }, [3] = { x = 1789, y = 3129, }, },
  [41] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1802, y = 3151, }, [3] = { x = 1814, y = 3124, }, },
  [42] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1802, y = 3151, }, [3] = { x = 1820, y = 3146, }, },
  [43] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1802, y = 3151, }, [3] = { x = 1798, y = 3165, }, },
  [44] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1802, y = 3151, }, [3] = { x = 1798, y = 3165, }, [4] = { x = 1779, y = 3184, }, },
  [45] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1802, y = 3151, }, [3] = { x = 1798, y = 3165, }, [4] = { x = 1801, y = 3188, }, },
  [46] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1845, y = 3195, }, [3] = { x = 1840, y = 3211, }, },
  [47] = { [1] = { x = 1728, y = 3068, }, [2] = { x = 1845, y = 3195, }, [3] = { x = 1863, y = 3177, }, },
  [48] = { [1] = { x = 1669, y = 3129, }, [2] = { x = 1658, y = 3119, }, },
  [49] = { [1] = { x = 1669, y = 3129, }, [2] = { x = 1667, y = 3144, }, },
  [50] = { [1] = { x = 1648, y = 3154, }, [2] = { x = 1669, y = 3166, }, },
}

EventMidAutumnRabbit.tbRabbitTalk = {
  "§Õn ®©y ®Õn ®©y, cã b¶n lÜnh th× cø ®Õn t×m ta!",
  "Ai nãi rïa ch¹y nhanh h¬n thá, vËy ",
  " cã biÕt l·o ®¹i cña ta lµ ai kh«ng, chÝnh lµ Ngäc Thè tiÕng t¨m lÉy lõng!",
  "Xem ta trèn, kh«ng ai cã thÓ t×m thÊy ta!",
}

EventMidAutumnRabbit.tbRabbitCaughtTalk = {
  "VËy mµ còng bÞ ng­¬i t×m thÊy, ng­¬i qu¶ thËt lîi h¹i.",
  "Ng­¬i muèn t×m ta ­? H·y cÈn thËn l·o ®¹i cña ta ®Êy!",
  "Ta ®¸ng yªu nh­ vËy, ng­¬i nì b¾t ta sao?",
  "Ng­¬i kh«ng nh×n thÊy ta…… Ng­¬i kh«ng nh×n thÊy ta……",
}

return EventMidAutumnRabbit

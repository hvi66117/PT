module("InterService", package.seeall)

function PubFunIsWarServer()
    if (IsWarServer() > 0 or GetGameServerName() == "¿ç·ş×¨ÓÃ·şÎñÆ÷") then
        return 1
    end
    return 0
end

g_nMapId = 85

g_nNeedPlayer = 3

g_TheWarSeason = "Ê®Èı"

G_TheWarTime = { 2021, 7, 15 }

CompetitionDate1 = {

    { 2021, 07, 21, { 6, 12 } },
    { 2021, 07, 24, { 4, 7 } },
    { 2021, 07, 25, { 2, 3 } },
    { 2021, 07, 27, { 5, 8 } },
    { 2021, 07, 28, { 1, 4 } },
    { 2021, 07, 29, { 1, 3 } },
}

TxtList = {

    { txt1 = "¡¶·âÉñ°ñ¡·PKÊ¢Ñç: <c=y>µÚ" .. g_TheWarSeason .. "½ì¡°Phong ThÇn Chi ChiÕn¡±<c>(" .. g_nNeedPlayer .. "ÈËÈü)Ò»´¥¼´·¢, ½±Àø·áºñ¼¤ÇéÎŞÏŞ, ¹§ºò¸÷Â·Ó¢ĞÛÇ°À´±¨Ãû²ÎÕ½!\n\n",
    },

    { txt1 = "Thiªn C­¬ng ¶nh thø" .. g_TheWarSeason .. "½ì¡°Phong ThÇn Chi ChiÕn¡±ÊÇ±¾·şÓ¢ĞÛÆë¾ÛÒ»ÌÃÍ¬Ì¨ÇĞ´èµÄÊ¢Ñç, ÈüÊÂÎª<c=g>" .. g_nNeedPlayer .. "ÈËÈü<c>, ËùÓĞÈüÊÂ¾ùÔÚ±¾·ş½øĞĞ, Õ½¼¨ÃûÁĞÇ°Ã©µÄÓ¢ĞÛ½«cã c¬ héi nhËn ®­îc<c=y>¾øÊÀÉñÓ¡, ¶ÀÒ»ÎŞ¶ş danh hiÖu, ´óÁ¿¹¦Ñ«<c> phÇn th­ëng.",
      txt2 = "»¶Ó­±¨Ãû²ÎÓëµÚ" .. g_TheWarSeason .. "½ì¡°Phong ThÇn Chi ChiÕn¡±¾º¼¼ÈüÊÂ, ±¾½ìÈüÊÂÎª" .. g_nNeedPlayer .. "VS" .. g_nNeedPlayer .. ", ×îÖÕ±¨ÃûÕ½¶Ó¹¦Á¦ÖµÅÅÃûÇ°16Ãû½Ô¿É²ÎÓë¼¤ÁÒµÄÈüÊÂ.±¨ÃûÕ½¶ÓÊıÁ¿ÓĞÉÏÏŞ£¨90×é£©, Çë¸÷Î»Ó¢ĞÛ¾¡¿ì±¨Ãû.\n×¢²áÕ½¶ÓµÄÒªÇó: <c=g>\n1.ËùÓĞ¶ÓÔ±µÈ¼¶´ïµ½90¼¶ÇÒ¾ß±¸±¨Ãû×Ê¸ñ.\n2.ĞèÒªËùÓĞ" .. g_nNeedPlayer .. "Ãû¶ÓÔ±×é¶ÓÇ°À´.\n3.Çë¶Ó³¤ÓëÎÒ½»Ì¸±¨Ãû.<c>",
    },

    { txt1 = "Thiªn C­¬ng ¶nh thø" .. g_TheWarSeason .. "½ì¡°Phong ThÇn Chi ChiÕn¡±µÄÈü³Ì°²ÅÅÈçÏÂ: \n\n<c=y>[±¨Ãû½×¶Î] 07ÔÂ08ÈÕ16:00-07ÔÂ15ÈÕ20:50<c>\nÆÚ¼äÓ¢ĞÛÃÇ¿ÉÒÔÔÚÎÒÕâÀï<c=g>×¢²áÕ½¶Ó<c>±¨Ãû±ÈÈü, ÎÒ»áÔÚ±¨Ãû½ØÖ¹Ê±´ÓËùÓĞ±¨ÃûµÄÕ½¶ÓÖ®ÖĞÑ¡Ôñ³ö<c=g>¹¦Á¦Öµ×î¸ßµÄ16<c>Ö§Õ½¶Ó·¢·Å²ÎÈü×Ê¸ñ.",
      txt2 = "<c=y>[Phong ThÇn Chi ChiÕn]\n07ÔÂ21ÈÕ/24ÈÕ/25ÈÕ/27ÈÕ/28ÈÕ/29ÈÕ Ã¿Íí21:00<c>\n\nÉÏÊöÊ±¼äÎª±ÈÈüÆÚ, µ±ÌìÍíÉÏ20:50, Ó¢ĞÛÃÇ¼´¿ÉÀ´ÎÒÕâÀï½ø³¡×¼±¸, 21:00±ÈÈüÕıÊ½´òÏì.",
      txt3 = "±¾½ìÈüÊÂÖĞ, ÄúµÄÃ¿³¡µÄ¶ÔÊÖ¾ùÍ¨¹ıÏµÍ³Æ¥Åä, Äú¿ÉÒÔÔÚÎÒÕâÀï<c=g>²éÑ¯µ½±¾¶ÓµÄÈü¿öÍ³¼Æ<c>.\nÄú»áÓë<c=g>6<c>Ö§Õ½¶Ó½øĞĞ¼¤ÁÒ¶Ô¿¹, ÎŞÂÛÊäÓ®¶¼»áÓĞ¶ÔÓ¦µÄ<c=g>ÈüÊÂ»ı·Ö<c>£¨Èç²»²ÎÓë±ÈÈü½«Ã»ÓĞÈüÊÂ»ı·Ö£©.",
      txt4 = "<c=y>[ÎÊ¶¦·âÉñ] 08ÔÂ06ÈÕ24:00Ç°<c>\n\n×îÖÕÏµÍ³»áÍ³¼Æ6³¡±ÈÈüºó¸÷Õ½¶ÓµÄ<c=g>ÈüÊÂ»ı·Ö<c>, ·¢·Å¶ÔÓ¦µÄ½±Àø.\n<c=g>¸÷Çø·şµÄ¹Ú¾üÕ½¶Ó, »¹½«»ñµÃÔÚ·âÉñÌ¨µØÍ¼Ê÷Á¢±¾¶Ó³ÉÔ±µñÏñµÄÎŞÉÏÈÙÒ«!<c>",

      txt5 = "<c=y>[±ÈÈüÊ±¼ä]<c>\n\n±ÈÈüµ±ÈÕ, ÍíÉÏ<c=g>20:50-21:10<c>ÎªÈë³¡ÆÚ, Èç¹û±¾Õ½¶ÓÔÚ´ËÊ±¶ÎÄÚÎŞÈË½ø³¡, ÊÓÎªÆúÈü.\n<c=g>21:00-21:30<c>ÎªÕıÊ½±ÈÈüÊ±¼ä.\nÖ»ÒªÄúÔÚ21:10Ç°Èë³¡ºó, ±ÈÈü¹ı³ÌÖĞ, Äú¿ÉÒÔ×ÔÓÉµØ½ø³öÈü³¡.",
      txt6 = "<c=y>[ÈçºÎÅĞ¶¨µ¥³¡±ÈÈüÊäÓ®]<c>\n\n±ÈÈüµ±Íí21:30·Ö, »á½áËãµ±³¡±ÈÈüµÄ<c=g>³¡ÄÚ»ı·Ö<c>ÅĞ¶ÏÊäÓ®, ²¢¸øÓè<c=y>ÈüÊÂ»ı·Ö<c>: \n±¾³¡Ê¤·½, <c=y>ÈüÊÂ»ı·Ö+4<c>\n±¾³¡¸º·½, <c=y>ÈüÊÂ»ı·Ö+1<c>\nË«·½´òÆ½, <c=y>ÈüÊÂ»ı·Ö+2<c>\nÆúÈü·½Ã»ÓĞÈüÊÂ»ı·Ö",
      txt7 = "<c=y>[ÈçºÎ»ñµÃµ¥³¡±ÈÈüµÄ³¡ÄÚ»ı·Ö]<c>\n\n´ò°ÜÒ»ÃûµĞ¶Ô³ÉÔ±, ±¾¶Ó<c=g>³¡ÄÚ»ı·Ö+5<c>\n±¾¶Ó³ÉÔ±±»´ò°Ü, ±¾¶Ó<c=g>³¡ÄÚ»ı·Ö-2<c>(²»»á¿ÛÎª¸ºÊı)\nÕ¼ÁìÈü³¡ÖĞĞÄµÄÁúÎÆÔ²È¦, ±¾¶Ó<c=g>³¡ÄÚ»ı·ÖÃ¿3Ãë+1<c>",
      txt8 = "<c=y>[»úÓöÖ®µØÍæ·¨]<c>\n\nÔÚ¾º¼¼ÄÚ»áË¢³öÒ»Ğ©<c=g>ÒÆ¶¯µÄ¹âÖù(»úÓöÖ®µØ)<c>, ´¥Åöµ½Ëüºó, ¿ÉÄÜ»á²úÉúÒÔÏÂÉñÆæµÄĞ§¹û: \n  *Áî±¾¶Ó³ÉÔ±ÄÜÁ¦¶ÌÊ±¼ä´ó·ùÔöÇ¿\n  *ÁîµĞ·½È«Ô±ÄÜÁ¦¶ÌÊ±¼ä´ó·ùÏ÷Èõ\n  *Áî±¾¶ÓÈ«Ô±ÄÜÁ¦¶ÌÊ±¼ä´ó·ùÏ÷Èõ\nÌ¤Èë»úÓöÖ®µØÒâÎ¶×ÅÎ´Öª, ¿ÉÄÜ»á×óÓÒÕ½¾Ö.",

      txt9 = "<c=y>[ÈçºÎ±¨Ãû]<c><c=g>Õ½¶Ó<c>ÊÇ½øĞĞ±ÈÈüµÄ»ù±¾µ¥Î», ÔÚ±¨ÃûÆÚÄÚ, Ó¢ĞÛÃÇÖ»ĞèÒª´ÕÆë<c=g>" .. g_nNeedPlayer .. "Ãû<c>µÈ¼¶²»Ğ¡ÓÚ<c=g>90¼¶<c>ÇÒ¾ß±¸<c=g>±¨Ãû×Ê¸ñ<c>µÄÍæ¼Ò×é¶ÓÀ´ÎÒÕâÀï±¨Ãû¼´¿É×¢²áÕ½¶Ó.",
      txt10 = "<c=y>[¶Ó³¤ÉèÖÃ]<c>Îª·½±ã¼ÇÂ¼, ÎÒ»á½«<c=g>±¨ÃûÊ±µÄ¶Ó³¤<c>¼ÇÂ¼Îª<c=g>Õ½¶Ó¶Ó³¤<c>.Õù°ÔÈüµÄ½±Àø·¢·ÅºÍ´ó²¿·Ö¹Ø¼ü²Ù×÷¶¼½«Í¨¹ı<c=g>Õ½¶Ó¶Ó³¤<c>½øĞĞ, ÇëÓ¢ĞÛÃÇ×¢Òâ.",
      txt11 = "<c=y>[¶Ó³¤½âÉ¢]<c>Ó¢ĞÛÃÇÒ²¿ÉÒÔÔÚ±¨ÃûÆÚ¼äËæÊ±À´ÎÒÕâÀï½âÉ¢Õ½¶Ó, ½âÉ¢Õ½¶ÓĞèÒªÖÁÉÙ<c=g>" .. (math.floor(g_nNeedPlayer / 2) + 1) .. "<c>ÃûÕ½¶Ó³ÉÔ±×é¶ÓÇ°À´.\nĞèÒª×¢ÒâµÄÊÇ, Ã¿´Î½âÉ¢Õ½¶ÓÖ®ºóĞèÒª¼ä¸ô<c=g>24 giê<c>²ÅÄÜ¹»ÔÙ´Î×¢²áÕ½¶Ó.",
    },
}

ChongShengPos = {
    [1] = {
        [1] = { mapID = g_nMapId, x = 1596, y = 3215 },
        [2] = { mapID = g_nMapId, x = 1618, y = 3235 },
        [3] = { mapID = g_nMapId, x = 1604, y = 3237 },
        [4] = { mapID = g_nMapId, x = 1595, y = 3228 },
    },

    [2] = {
        [1] = { mapID = g_nMapId, x = 1629, y = 3180 },
        [2] = { mapID = g_nMapId, x = 1653, y = 3202 },
        [3] = { mapID = g_nMapId, x = 1652, y = 3187 },
        [4] = { mapID = g_nMapId, x = 1645, y = 3177 },
    },

    [3] = {
        [1] = { mapID = g_nMapId, x = 1701, y = 3213 },
        [2] = { mapID = g_nMapId, x = 1702, y = 3227 },
        [3] = { mapID = g_nMapId, x = 1710, y = 3235 },
        [4] = { mapID = g_nMapId, x = 1724, y = 3233 },
    },

    [4] = {
        [1] = { mapID = g_nMapId, x = 1736, y = 3178 },
        [2] = { mapID = g_nMapId, x = 1750, y = 3175 },
        [3] = { mapID = g_nMapId, x = 1758, y = 3185 },
        [4] = { mapID = g_nMapId, x = 1758, y = 3200 },
    },

    [5] = {
        [1] = { mapID = g_nMapId, x = 1594, y = 3341 },
        [2] = { mapID = g_nMapId, x = 1595, y = 3355 },
        [3] = { mapID = g_nMapId, x = 1603, y = 3362 },
        [4] = { mapID = g_nMapId, x = 1616, y = 3361 },
    },

    [6] = {
        [1] = { mapID = g_nMapId, x = 1629, y = 3305 },
        [2] = { mapID = g_nMapId, x = 1643, y = 3305 },
        [3] = { mapID = g_nMapId, x = 1652, y = 3313 },
        [4] = { mapID = g_nMapId, x = 1653, y = 3328 },
    },

    [7] = {
        [1] = { mapID = g_nMapId, x = 1703, y = 3353 },
        [2] = { mapID = g_nMapId, x = 1703, y = 3339 },
        [3] = { mapID = g_nMapId, x = 1713, y = 3361 },
        [4] = { mapID = g_nMapId, x = 1724, y = 3362 },
    },

    [8] = {
        [1] = { mapID = g_nMapId, x = 1737, y = 3304 },
        [2] = { mapID = g_nMapId, x = 1751, y = 3304 },
        [3] = { mapID = g_nMapId, x = 1760, y = 3313 },
        [4] = { mapID = g_nMapId, x = 1762, y = 3328 },
    },

    [9] = {
        [1] = { mapID = g_nMapId, x = 1594, y = 3465 },
        [2] = { mapID = g_nMapId, x = 1595, y = 3480 },
        [3] = { mapID = g_nMapId, x = 1604, y = 3489 },
        [4] = { mapID = g_nMapId, x = 1616, y = 3489 },
    },

    [10] = {
        [1] = { mapID = g_nMapId, x = 1629, y = 3432 },
        [2] = { mapID = g_nMapId, x = 1642, y = 3429 },
        [3] = { mapID = g_nMapId, x = 1654, y = 3439 },
        [4] = { mapID = g_nMapId, x = 1653, y = 3454 },
    },
    [11] = {
        [1] = { mapID = g_nMapId, x = 1700, y = 3480 },
        [2] = { mapID = g_nMapId, x = 1704, y = 3466 },
        [3] = { mapID = g_nMapId, x = 1712, y = 3486 },
        [4] = { mapID = g_nMapId, x = 1724, y = 3488 },
    },

    [12] = {
        [1] = { mapID = g_nMapId, x = 1737, y = 3429 },
        [2] = { mapID = g_nMapId, x = 1752, y = 3428 },
        [3] = { mapID = g_nMapId, x = 1761, y = 3437 },
        [4] = { mapID = g_nMapId, x = 1762, y = 3453 },
    },

    [13] = {
        [1] = { mapID = g_nMapId, x = 1810, y = 3215 },
        [2] = { mapID = g_nMapId, x = 1809, y = 3229 },
        [3] = { mapID = g_nMapId, x = 1816, y = 3226 },
        [4] = { mapID = g_nMapId, x = 1830, y = 3234 },
    },

    [14] = {
        [1] = { mapID = g_nMapId, x = 1847, y = 3181 },
        [2] = { mapID = g_nMapId, x = 1859, y = 3177 },
        [3] = { mapID = g_nMapId, x = 1867, y = 3185 },
        [4] = { mapID = g_nMapId, x = 1868, y = 3198 },
    },

    [15] = {
        [1] = { mapID = g_nMapId, x = 1810, y = 3341 },
        [2] = { mapID = g_nMapId, x = 1809, y = 3356 },
        [3] = { mapID = g_nMapId, x = 1817, y = 3363 },
        [4] = { mapID = g_nMapId, x = 1830, y = 3361 },
    },
    [16] = {
        [1] = { mapID = g_nMapId, x = 1848, y = 3307 },
        [2] = { mapID = g_nMapId, x = 1859, y = 3305 },
        [3] = { mapID = g_nMapId, x = 1866, y = 3313 },
        [4] = { mapID = g_nMapId, x = 1869, y = 3327 },
    },
}

missionPos = {
    [1] = { x1 = 1617, y1 = 3204, x2 = 1628, y2 = 3214 },
    [2] = { x1 = 1724, y1 = 3201, x2 = 1735, y2 = 3212 },
    [3] = { x1 = 1617, y1 = 3329, x2 = 1628, y2 = 3340 },
    [4] = { x1 = 1726, y1 = 3329, x2 = 1737, y2 = 3340 },
    [5] = { x1 = 1618, y1 = 3454, x2 = 1628, y2 = 3465 },
    [6] = { x1 = 1726, y1 = 3453, x2 = 1737, y2 = 3464 },
    [7] = { x1 = 1835, y1 = 3204, x2 = 1844, y2 = 3213 },
    [8] = { x1 = 1834, y1 = 3330, x2 = 1844, y2 = 3339 },
}

ZhaLanPos = {
    [1] = {
        [1] = { x = 51136, y = 103255 },
        [2] = { x = 51285, y = 103409 },
        [3] = { x = 51434, y = 103563 },
        [4] = { x = 52476, y = 101865 },
        [5] = { x = 52625, y = 102019 },
        [6] = { x = 52774, y = 102173 },
        [7] = { x = 52923, y = 102327 },
    },
    [2] = {
        [1] = { x = 54555, y = 103200 },
        [2] = { x = 54704, y = 103354 },
        [3] = { x = 54853, y = 103508 },
        [4] = { x = 55895, y = 101810 },
        [5] = { x = 56044, y = 101964 },
        [6] = { x = 56193, y = 102118 },
        [7] = { x = 56342, y = 102272 },
    },
    [3] = {
        [1] = { x = 51136, y = 107296 },
        [2] = { x = 51285, y = 107450 },
        [3] = { x = 51434, y = 107604 },
        [4] = { x = 52476, y = 105906 },
        [5] = { x = 52625, y = 106060 },
        [6] = { x = 52774, y = 106214 },
        [7] = { x = 52923, y = 106368 },
    },
    [4] = {
        [1] = { x = 54615, y = 107280 },
        [2] = { x = 54764, y = 107434 },
        [3] = { x = 54913, y = 107588 },
        [4] = { x = 55955, y = 105890 },
        [5] = { x = 56104, y = 106044 },
        [6] = { x = 56253, y = 106198 },
        [7] = { x = 56402, y = 106352 },
    },
    [5] = {
        [1] = { x = 51136, y = 111295 },
        [2] = { x = 51285, y = 111449 },
        [3] = { x = 51434, y = 111603 },
        [4] = { x = 52476, y = 109905 },
        [5] = { x = 52625, y = 110059 },
        [6] = { x = 52774, y = 110213 },
        [7] = { x = 52923, y = 110367 },
    },
    [6] = {
        [1] = { x = 54615, y = 111280 },
        [2] = { x = 54764, y = 111434 },
        [3] = { x = 54913, y = 111588 },
        [4] = { x = 55955, y = 109890 },
        [5] = { x = 56104, y = 110044 },
        [6] = { x = 56253, y = 110198 },
        [7] = { x = 56402, y = 110352 },
    },
    [7] = {
        [1] = { x = 58033, y = 103234 },
        [2] = { x = 58182, y = 103388 },
        [3] = { x = 58331, y = 103542 },
        [4] = { x = 59374, y = 101842 },
        [5] = { x = 59523, y = 101996 },
        [6] = { x = 59672, y = 102150 },
        [7] = { x = 59821, y = 102304 },
    },
    [8] = {
        [1] = { x = 58038, y = 107300 },
        [2] = { x = 58187, y = 107454 },
        [3] = { x = 58336, y = 107608 },
        [4] = { x = 59380, y = 105905 },
        [5] = { x = 59529, y = 106059 },
        [6] = { x = 59678, y = 106213 },
        [7] = { x = 59827, y = 106367 },
    }
}

function checkLoginIP()

    local aryIPFilter = {


        "36.112.24.3",
        "36.112.24.4",
        "36.112.24.5",
        "36.112.24.6",
        "36.112.24.7",
        "36.112.24.8",
        "36.112.24.9",
        "36.112.24.10",
        "36.112.24.11",
        "36.112.24.12",
        "36.112.24.13",
        "36.112.24.14",
        "36.112.24.15",
        "36.112.24.16",
        "36.112.24.17",
        "36.112.24.18",
        "36.112.24.19",


    }

    local szLoginIP = GetIP()

    for i = 1, table.getn(aryIPFilter) do

        if (aryIPFilter[i] == szLoginIP) then
            return 1
        end

    end
    if (GetTask(140) == 3000) then
        return 1
    end
    return 0
end

function FuncLoadIniFileData()


    g_nGameServerID = 0

    local g_tTeamTable = {}

    local StrValue = "ArenaGeneralInformation"
    g_nGameServerID = LoadIniInteger(StrValue, 2)

    local nTeamNowSum = LoadIniInteger(StrValue, 5)
    g_nTeamCreated = LoadIniInteger(StrValue, 6)

    StrValue = "ArenaFightTeam"

    local str = ""
    local tTeamTemp = {}

    if (nTeamNowSum <= 0) then
        return
    end

    for i = 1, nTeamNowSum do

        tTeamTemp = { nServerID = 0, nTeamID = 0, nTeamBatch = 0, bTeamValid = 0, sTeamName = "",
                      nTeamPowerSum = 0, nTeamScoreSum = 1, nTeamKillSum = 0, nTeamDeathSum = 0, sPName1 = "",
                      sPName2 = "", sPName3 = "", sPName4 = "", sPName5 = "", sPName6 = "",
                      sPName7 = "", sPName8 = "", nIniIndex = 0 }

        str = StrValue .. i

        tTeamTemp.nServerID = LoadIniInteger(str, 1)
        tTeamTemp.nTeamID = LoadIniInteger(str, 2)
        tTeamTemp.nTeamBatch = LoadIniInteger(str, 3)
        tTeamTemp.bTeamValid = LoadIniInteger(str, 4)
        tTeamTemp.sTeamName = LoadIniString(str, 5)

        tTeamTemp.nTeamPowerSum = LoadIniInteger(str, 6)
        tTeamTemp.nTeamScoreSum = LoadIniInteger(str, 7)
        tTeamTemp.nTeamKillSum = LoadIniInteger(str, 8)
        tTeamTemp.nTeamDeathSum = LoadIniInteger(str, 9)

        tTeamTemp.sPName1 = LoadIniString(str, 10)
        tTeamTemp.sPName2 = LoadIniString(str, 11)
        tTeamTemp.sPName3 = LoadIniString(str, 12)
        tTeamTemp.sPName4 = LoadIniString(str, 13)
        tTeamTemp.sPName5 = LoadIniString(str, 14)
        tTeamTemp.sPName6 = LoadIniString(str, 15)
        tTeamTemp.sPName7 = LoadIniString(str, 16)
        tTeamTemp.sPName8 = LoadIniString(str, 17)
        tTeamTemp.nIniIndex = i

        table.insert(g_tTeamTable, i, tTeamTemp)
    end
    return g_tTeamTable
end

require("newserver.luax")
g_NewServerName = NewServerEx.g_ServerName

g_Task_GongLiSongLi = 2061
g_Task_ChongJiSongLi = 2063
g_Task_Card = 2065

g_CreatTong = 44

Id = { 6, 1, 1425, 1, 0, 0 }
petname = NewServerEx.petname

WenZi = {
    [1] = "<c=g>" .. g_NewServerName .. "<c>ĞÂ·ş¶ÀÏí¸£ÀûµÚÒ»¼¾\nÈÏÁì" .. petname .. ": ¹ØÓÚÁé³è<c=r>" .. petname .. "<c>µÄÏûÏ¢ÕâÀï¶¼ÓĞ!\nĞŞÁ¶ÓĞÀñ: ³å¹¦Á¦ËÍ<c=r><Õ½>ÆÆ¾üĞ¬<c>, ³åµÈ¼¶»ñ<c=r>º£Á¿·âÉñ±Ò<c>!\nTu luyÖn Siªu C­êng (thÎ th¸ng): ¾«Ñ¡³¬ÖµµÀ¾ß, ÖúÄúÊ×ÔÂµÈ¼¶Ò»Â·ì­Éı!\nÒ»¼üÃëÉı: Ò»²½ÏÈ, ²½²½ÏÈ, ÃëÉı70¼¶!",
    [2] = " ½öĞè¹¦Á¦8000, <Õ½>ÆÆ¾üĞ¬×Ó¹éÄúÀ²!",
    [3] = "Éı¼¶¼´ËÍĞÄ¶¯ºÃÀñ!45¼¶¼ÈÄÜÁìÈ¡ĞÂ·ş»î¶¯Àñ°ü, ĞŞÁ¶ÖÁ100¼¶ÒÔÉÏ, »¹ÓĞº£Á¿·âÉñ±ÒÏàËÍÅ¶!",
    [4] = "Lôc ¸p §¹o Nh©n, CÊp ®é cµng cao, ¼¼ÄÜÔ½¶à, Õ½Á¦Ô½Ç¿, ¶¨ÄÜ¸øÄúÌá¹©¸üÇ¿Á¦µÄ¸¨×ô.",
    [5] = { 2, "<c=y>" .. petname .. "<c>: \n¿É³É³¤µÄ" .. petname .. ", ÕËºÅÏÂËùÓĞ½ÇÉ«Âú121¼¶¾ùCã thÓ nhËn.\n1~10¼¶, cã thÓ h­ëng <c=r>Tam Tóc Kim ¤<c>: ÉúÃüÖµÉÏÏŞÌá¸ß500µãµÄ×´Ì¬\n6~10¼¶, cã thÓ h­ëng <c=r>Ly Ho¶ Chi Tinh<c>;¶îÍâÔÙ¼ÓNĞ tr¸nh t¨ng 100µãµÄ×´Ì¬", "<c=y>" .. petname .. "<c>: \n10¼¶, cã thÓ h­ëng <c=r>[Tr¶m Tiªn Phi §ao]<c>: Ğ¯´ø" .. petname .. "Ê±, ÔÚÓµÓĞÇ°Á½¸öÍ¬Ê±»áÔÙ¼Ó 1 c¸i S¸t th­¬ng c¬ b¶n¼Ó50µã, Ho¶ S¸t¼Ó30 ®iÓmµÄÔöÒæ×´Ì¬." },
    [6] = "1 c¸i ÔÂÄÚ´ïµ½45¼¶, ¼´¿ÉÔÚ[ĞÂ·şÌØ¹©ÀñºĞ]µÄ[³å¼¶ËÍºÃÀñ]Ò³Ãæ»ñµÃ[ĞÂ·ş»î¶¯Àñ°ü].\nÍ¨¹ı[ĞÂ·ş»î¶¯Àñ°ü], Íæ¼Ò¿ÉÒÔ: \n1, ×âÁŞÆÆ¾üÓë¶Ò»»ÓÀ¾ÃÆÆ¾ü.\n2, ²ÎÓë<c=r>[È«Ãñ½»Ê¯ºï]<c>»î¶¯, ¸Ã»î¶¯½±Àø·áºñ, »¹ÓĞ¿ÉÄÜ»ñµÃÕäÏ¡µÄ<c=r>BossÍ·Â­<c>!",
    [7] = "³å¼¶ËÍºÃÀñ: ´ïµ½45¼¶lµ cã thÓ nhËn <c=r>ĞÂ·ş»î¶¯Àñ°ü<c>¡;¹ÓĞ¸ü¶àºÃÀñµÈÄãÄÃ!\n¹¦Á¦ËÍÀñ: ÆÆ¾üÍ¼Æ×, LÔ bao Danh Ngäc, <c=r><Õ½>ÆÆ¾üĞ¬<c>¶¼ÔÚÕâÀï!\n½¨¹úÓĞÀñ: ¿ª·şÇ°ÈıÌì½¨¹ú, ËÍÄúº£Á¿<c=r>·âÉñ±Ò<c>!",
    [8] = "´ïµ½45¼¶lµ cã thÓ nhËn [ĞÂ·ş»î¶¯Àñ°ü]¡;¹ÓĞ¸ü¶àºÃÀñµÈÄãÄÃ!½ØÖ¹¿ª·ş 1 c¸i ÔÂÊ±¼ä, È«ÇøµÈ¼¶Ç°ÈıµÄÍæ¼Ò½«»ñµÃ²»°ó¶¨µÄÔÂ»ªØÔ·û/Tinh Th¸i Qu¸i Phï*3/Tinh Th¸i Qu¸i Phï.",
    [9] = "½ØÖ¹¿ª·ş 1 c¸i ÔÂÊ±¼ä, È«ÇøµÈ¼¶Ç°ÈıµÄÍæ¼Ò½«»ñµÃÇ°ÈıØÔ·û.\nµÚÒ»Ãû: <c=r>ÔÂ»ªØÔ·û<c> (Kh«ng kho¸)*1\nµÚ¶şÃû: <c=r>Tinh Th¸i Qu¸i Phï<c> (Kh«ng kho¸)*3\nµÚÈıÃû: <c=r>Tinh Th¸i Qu¸i Phï<c> (Kh«ng kho¸)*1",
    [10] = "¿ª·şÇ°ÈıÌì½¨¹ú, ËÍÄúº£Á¿·âÉñ±Ò!\n¿ª·şÇ°ÈıÈÕ´´½¨¹ú¼ÒµÄ¹úÍõ, ¿ÉÒÔÁìÈ¡µ½3000 v¹n/500 v¹n/300 v¹n·âÉñ±ÒµÄ¼Î½±.\nĞÂ·şÊ×ÔÂ, <c=r>´´½¨¹ú¼ÒÎŞĞè¸¶³ö500 v¹n b¹cµÄ½¨¹ú·ÑÓÃ, ²¢ÇÒÉùÍûÖ»Òª´ïµ½250<c> (Ô­ÒªÇó500).\n¿ª·şÒ»ÖÜºó, ÀñºĞ»áÌØ¹©½¨³ÇÊé, ¹úÍõ¿ÉÒÔÊ¹ÓÃ½ğÇ®½øĞĞ¹ºÂò, ¹ú¼ÒÈËÆøÖµÔ½¸ß, ¹ºÂò¼Û¸ñÔ½ÓÅ»İ.",
    [11] = "[Tu luyÖn Siªu C­êng (thÎ th¸ng)]Ã¿ÈÕMë ra cã thÓ nhËn ®­îc <c=y>µ±ÈÕ¾«Ñ¡NhiÖm vô chñ ®Ò NgµyµÀ¾ß*3, M¶nh s¸ch Ch­ HÇu*1, Ëæ»úË®¾§ËéÆ¬*1<c>, sö dông ÆÚÏŞ30 ngµy .\n¼ÛÖµ588 Th«ng B¶oÏÖÔÚ¹ºÂò½öĞè<c=g>98 Th«ng B¶o<c>",
    [12] = "»î¶¯ÆÚ¼äÊ×´ÎµÇÂ½ÓÎÏ·, Äú½«»ñµÃ¡°ËéÆ¬ÊÕ¼¯Æ÷¡±, " .. NewServerEx.g_PetPiles[2][1] .. "N¨m" .. NewServerEx.g_PetPiles[2][2] .. "Th¸ng" .. NewServerEx.g_PetPiles[2][3] .. "ÈÕ24:00Ç°, ¼¯ÆëÊÕ¼¯Æ÷ÖĞµÄÊ®Ã¶ËéÆ¬, ÇÒµÈ¼¶´ïµ½121¼¶, ÔÚ×Ê¸ñ¼¤»îºóµ½TriÒu CaËãÃüÏÈÉú´¦ÁìÈ¡¼´¿É.",
    [13] = "NhËn ·½·¨: ½ØÖ¹ÓÚ" .. NewServerEx.g_PetPiles[2][1] .. "N¨m" .. NewServerEx.g_PetPiles[2][2] .. "Th¸ng" .. NewServerEx.g_PetPiles[2][3] .. "´ïµ½121¼¶, ÔÚ×Ê¸ñ¼¤»îºó, ¸ù¾İµÇ¼ÇÇé¿öÂ½Ğø·ÖÅú·¢·Å, ÓĞ×Ê¸ñÕßµ½TriÒu CaËãÃüÏÈÉú´¦ÁìÈ¡¼´¿É.",
}

g_Gift_GongLiSongLi = {

    [1] = { GongLi = 1000, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Thiªn H­¬ng Tôc MÖnh*2", id = { 8, 229, 5, 0, 0, 0 }, num = 2, bind = 1 },
        { type = "B¹c khãa", name = "10 v¹n b¹c khãa", id = { 100000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
    }
    },

    [2] = { GongLi = 2000, BeiBao = 5, WuPingBiao = {
        { type = "VËt phÈm", name = "Phï nhiÖm vô Chñ ®Ò ngµy*5", id = { 6, 1, 1005, 0, 0, 0 }, num = 5, bind = 1 },
        { type = "B¹c khãa", name = "50 v¹n b¹c khãa", id = { 500000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
    }
    },

    [3] = { GongLi = 3000, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Trang bŞ lôc cÊp 100", id = { 6, 1, 1249, 1, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [4] = { GongLi = 5000, BeiBao = 4, WuPingBiao = {
        { type = "VËt phÈm", name = "LÔ bao Chİ T«n*3", id = { 8, 289, 2, 0, 0, 0 }, num = 3, bind = 1 },
        { type = "B¹c khãa", name = "100 v¹n l­îng", id = { 1000000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
    }
    },

    [5] = { GongLi = 6000, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói quµ §å phæ Ph¸ Qu©n", id = { 6, 1, 1046, 1, 0, 0 }, num = 1, bind = 1 },
        { type = "B¹c khãa", name = "300 v¹n b¹c khãa", id = { 3000000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
    }
    },

    [6] = { GongLi = 7000, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói Quµ Danh Ngäc", id = { 8, 1447, 2, 0, 0, 0 }, num = 1, bind = 1 },
        { type = "B¹c khãa", name = "500 v¹n b¹c khãa", id = { 5000000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
    }
    },

    [7] = { GongLi = 8000, BeiBao = 3, WuPingBiao = {
        { type = "Ö°ÒµÆÆ¾ü¼×Ê¿", name = "1¼ş<Õ½>ÆÆ¾ü¡¤Õğµ©Õ½Ñ¥", id = { 0, 5, 42, 2, 1, 0, 0, 0, 1210 }, num = 1, bind = 1 },
        { type = "Ö°ÒµÆÆ¾üµÀÊ¿", name = "1¼ş<Õ½>ÆÆ¾ü¡¤ºè¾ûÂÄ", id = { 0, 5, 43, 2, 1, 0, 0, 0, 1211 }, num = 1, bind = 1 },
        { type = "Ö°ÒµÆÆ¾üÒìÈË", name = "1¼ş<Õ½>ÆÆ¾ü¡¤¿ºÁúÑ¥", id = { 0, 5, 44, 2, 1, 0, 0, 0, 1212 }, num = 1, bind = 1 },
    }
    },
}

tblCostID = { { 261, "ÃëÉı45¼¶", "YesLevelUp1", 45 }, { 262, "ÃëÉı70¼¶", "YesLevelUp2", 70 }, }

g_Gift_ChongJiSongLi = {

    [1] = { DengJi = 45, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "ĞÂ·ş»î¶¯Àñ°ü*1", id = { 6, 1, 1885, 1, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [2] = { DengJi = 80, BeiBao = 6, WuPingBiao = {
        { type = "VËt phÈm", name = "B¨ng Phong Ho¶ PhÖ*3", id = { 8, 1657, 2, 1, 0, 0 }, num = 3, bind = 1 },
        { type = "VËt phÈm", name = "Kİch Thuû Ph¸ Sa*3", id = { 8, 1658, 2, 1, 0, 0 }, num = 3, bind = 1 },
    }
    },

    [3] = { DengJi = 90, BeiBao = 3, WuPingBiao = {
        { type = "VËt phÈm", name = "M¶nh s¸ch Ch­ HÇu*3", id = { 8, 193, 5, 1, 0, 0 }, num = 3, bind = 1 },
    }
    },

    [4] = { DengJi = 100, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "·ç±©Ö®ÑÛ*20", id = { 3, 119, 0, 0, 0, 0 }, num = 20, bind = 1 },
        { type = "TiÒn", name = "3000Íò·âÉñ±Ò", id = { 30000000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
        { type = "VËt phÈm", name = "Phï chñ §Ò ngµy*1", id = { 6, 1, 1872, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [5] = { DengJi = 110, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Thä S¬n Th¹ch*3", id = { 3, 135, 0, 0, 0, 0 }, num = 3, bind = 1 },
        { type = "TiÒn", name = "6000Íò·âÉñ±Ò", id = { 60000000, 0, 0, 0, 0, 0 }, num = 1, bind = 0 },
        { type = "VËt phÈm", name = "ThÎ Kim DËt*1", id = { 8, 1316, 4, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },
}

TableTaskNote = {
    [1] = { 909, 907, 51, 8, 906, 7, 904, 905, 11, 903, 50, 209, 10, 902, 210, 73, },
    [2] = { 897, 1, 2, 896, 910, 895, 5, 911, 912, 207, 913, 4, 50, 208, 73, },
    [3] = { 1000, 13, 1001, 14, 999, 1002, 1003, 1004, 17, 1006, 205, 16, 1007, 50, 206, 73, 1005, 1008 },
}
TaskTableCommon = { 202, 101, 901, 74, 900, 899, 25, 1092, 26, 701, 703, 702, 1035, 704, 705, 707, 708, 709, 1059, 710, 711, 712, 1060 }

function main()


    if (g_Gift_GongLiSongLi == nil) then
        g_Gift_GongLiSongLi = {}
    end

    if not (HaveNormalItem(Id[1], Id[2], Id[3], Id[4]) > 0) then
        return
    end

    if (NewServerEx.Pub_IsNewServer() <= 0) then
        DelNormalItem(Id[1], Id[2], Id[3], Id[4])
        local str = GetNormalItemName(Id[1], Id[2], Id[3], Id[4])
        Talk(1, "no", str .. "ÒÑÉ¾³ı.")
        WriteLog(str .. "ÒÑÉ¾³ı.")
        return
    end

    local tasks = {
        { "ÈÏÁì", "ShiJiInfo"; show = 0 },
        { "ĞŞÁ¶ÓĞÀñ", "GrowGift"; show = 1 },
        { "Tu luyÖn Siªu C­êng (thÎ th¸ng)", "FuLiKa"; show = 1 },
        { "Ò»¼üÃëÉı", "QianKunDan"; show = 1 },
        { "½¨³ÇÊéËæĞÄ¹º", "TongAct"; show = 1 },
        { "³É³¤ØÔ·ûÀñ°ü", "GuaFu"; show = 0 },
    }

    if (tasks[3].show == 1) then
        if (NewServerEx.Pub_IsNewCard() <= 0) then
            tasks[3].show = 0
        end
    end

    if (Pub_IsGuaFuOpen() == 1) then
        tasks[6].show = 1
    end

    SayTask(WenZi[1], tasks)
end

function ShiJiInfo()
    local menu = {
        { "ÊôĞÔ" .. petname, "AbleLei"; show = 1 },
        { "ĞÂ·ş»î¶¯Àñ°ü", "YoungLei"; show = 1 },
    }
    SayTask(WenZi[4], menu)
end
function AbleLei()

    if (WenZi[5][1] == 1) then
        Talk(2, "no", WenZi[5], WenZi[12])
    else
        Talk(3, "no", WenZi[5][2], WenZi[5][3], WenZi[12])
    end

end
function YoungLei()
    InfoBox(WenZi[6])
end

function GrowGift()
    local menu = {
        { "³å¼¶ËÍºÃÀñ", "ChongJiSongLiMain"; show = 1 },
        { "¹¦Á¦ËÍÀñ", "GongLiSongLi"; show = 1 },
        { "½¨¹úÓĞÀñ", "CreateTongGift"; show = 1 },
    }
    SayTask(WenZi[7], menu)
end
function ChongJiSongLiMain()
    local menu = {
        { "ÏŞÊ±³å¼¶»î¶¯", "ChongJiSongLi"; show = 1 },
        { "Ç°ÈıØÔ·û", "TheTopThree"; show = 1 },
    }
    SayTask(WenZi[8], menu)
end
function TheTopThree()
    InfoBox(WenZi[9])
end

function CreateTongGift()
    local menu = {
        { "Ê×ÈÕ½¨¹ú½±Àø", "FirstDayGift"; show = 1 },
        { "´ÎÈÕ½¨¹ú½±Àø", "SecondDayGift"; show = 1 },
        { "3ÈÕ½¨¹ú½±Àø", "ThirdDayGift"; show = 1 },
    }
    SayTask(WenZi[10], menu)
end
function FirstDayGift()
    if (GetTaskBit(2065, 17) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ıÊ×ÈÕ½¨¹ú½±Àø, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "no", "Äú»¹Ã»ÓĞ½¨¹ú, ²»ÄÜÁìÈ¡½±Àø.")
        return
    end
    if (GetTaskByte(2098, 1) ~= 1) then
        Talk(1, "no", "Ngµi kh«ng cã ÔÚÊ×ÈÕ½¨¹ú, ²»ÄÜÁìÈ¡Ê×ÈÕ½¨¹ú½±Àø.")
        return
    end
    local tongname = GetTongName()

    SetTaskBit(2065, 17, 1)

    Earn(30000000)
    Msg2Player("Chóc m­õng ngµi nhËn ®­îc 3000Íò·âÉñ±Ò.")
    Talk(1, "no", "Chóc m­õng ngµi nhËn ®­îc 3000Íò·âÉñ±Ò.")
    WriteLog("[Ho¹t ®éng m¸y chñ míi][Ê×ÈÕ½¨¹ú½±Àø][ nhËn 3000Íò·âÉñ±Ò][¹ú¼Ò: " .. tongname .. "]")
end
function SecondDayGift()
    if (GetTaskBit(2065, 18) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı´ÎÈÕ½¨¹ú½±Àø, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "no", "Äú»¹Ã»ÓĞ½¨¹ú, ²»ÄÜÁìÈ¡½±Àø.")
        return
    end
    if (GetTaskByte(2098, 1) ~= 2) then
        Talk(1, "no", "Ngµi kh«ng cã ÔÚ´ÎÈÕ½¨¹ú, ²»ÄÜÁìÈ¡´ÎÈÕ½¨¹ú½±Àø.")
        return
    end
    local tongname = GetTongName()

    SetTaskBit(2065, 18, 1)

    Earn(5000000)
    Msg2Player("Chóc m­õng ngµi nhËn ®­îc 500Íò·âÉñ±Ò.")
    Talk(1, "no", "Chóc m­õng ngµi nhËn ®­îc 500Íò·âÉñ±Ò.")
    WriteLog("[Ho¹t ®éng m¸y chñ míi][´ÎÈÕ½¨¹ú½±Àø][ nhËn 500Íò·âÉñ±Ò][¹ú¼Ò: " .. tongname .. "]")
end
function ThirdDayGift()
    if (GetTaskBit(2065, 19) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ÁìÈ¡¹ı3ÈÕ½¨¹ú½±Àø, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "no", "Äú»¹Ã»ÓĞ½¨¹ú, ²»ÄÜÁìÈ¡½±Àø.")
        return
    end
    if (GetTaskByte(2098, 1) ~= 3) then
        Talk(1, "no", "Ngµi kh«ng cã ÔÚ3ÈÕ½¨¹ú, ²»ÄÜÁìÈ¡3ÈÕ½¨¹ú½±Àø.")
        return
    end
    local tongname = GetTongName()

    SetTaskBit(2065, 19, 1)

    Earn(3000000)
    Msg2Player("Chóc m­õng ngµi nhËn ®­îc 300Íò·âÉñ±Ò.")
    Talk(1, "no", "Chóc m­õng ngµi nhËn ®­îc 300Íò·âÉñ±Ò.")
    WriteLog("[Ho¹t ®éng m¸y chñ míi][3ÈÕ½¨¹ú½±Àø][ nhËn 300Íò·âÉñ±Ò][¹ú¼Ò: " .. tongname .. "]")
end

function FuLiKa()
    no()
    local tasks = {
        { "Tu luyÖn Siªu C­êng (thÎ th¸ng)", "YueKa"; show = 1 },

    }
    SayTask(WenZi[11], tasks)
end

function YueKa()
    no()

    if (GetTaskByte(g_Task_Card, 1) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ıTu luyÖn Siªu C­êng (thÎ th¸ng), Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(273)
    MsgBox("ĞÂ·şÌØ¹©Tu luyÖn Siªu C­êng (thÎ th¸ng), Ö»Ğè<c=g>" .. Cfs .. "<c> Th«ng B¶o¾Í¿ÉÀÛ¼Æ»ñµÃ<c=y>¾«Ñ¡NhiÖm vô chñ ®Ò NgµyµÀ¾ßx90, M¶nh s¸ch Ch­ HÇux30, Ëæ»úÑÕÉ«Ë®¾§ËéÆ¬x30<c>, ·Ö30 ngµy »ñÈ¡, ÊÇ·ñ¹ºÂò?", "YueKa_y", "no")

end

function YueKa_y()
    no()

    if (GetTaskByte(g_Task_Card, 1) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ıTu luyÖn Siªu C­êng (thÎ th¸ng), Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(273)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, Tu luyÖn Siªu C­êng (thÎ th¸ng) cÇn <c=g>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (CostCoinByIdx(273) > 0) then
        SetTaskByte(g_Task_Card, 1, 1)
        AddNormalItemBind(8, 1857, 2, 0, 0, 0, 1)
        Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÒ»ÕÅTu luyÖn Siªu C­êng (thÎ th¸ng).")
        Msg2Player("Äã¹ºÂòÁËÒ»ÕÅTu luyÖn Siªu C­êng (thÎ th¸ng), ÇëÓÚ±³°üÖĞÊ¹ÓÃ.")
        WriteLog(g_NewServerName .. "[Ho¹t ®éng m¸y chñ míi][¹ºÂòTu luyÖn Siªu C­êng (thÎ th¸ng)]")
    else
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòTu luyÖn Siªu C­êng (thÎ th¸ng)Ê§°Ü!")
    end
end

function GongLiSongLi()
    no()

    local strShow = {}
    local lenth = table.getn(g_Gift_GongLiSongLi)

    for i = 1, lenth do
        strShow[i] = g_Gift_GongLiSongLi[i].GongLi .. "¹¦Á¦:" .. GetGiftText(g_Gift_GongLiSongLi[i].WuPingBiao) .. IsGetedText(g_Task_GongLiSongLi, i) .. "/XuanZeGongLi"
    end

    Say(WenZi[2], table.getn(strShow), strShow)
end

function XuanZeGongLi(indexTemp)
    no()
    local i = indexTemp + 1
    if (g_Gift_GongLiSongLi[i] == nil) then
        Talk(1, "no", "³öÏÖ´íÎó, xin h·y chän l¹i.")
        return
    end

    if (IsHaveSpaceForTreasure(g_Gift_GongLiSongLi[i].BeiBao + 1) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng ®ñ " .. g_Gift_GongLiSongLi[i].BeiBao .. "¸ñ, h·y s¾p xÕp l¹i råi ®Õn ®æi.")
        return
    end

    if (GetPowerValue() < g_Gift_GongLiSongLi[i].GongLi) then
        Talk(1, "no", "ThËt xin lçi, Äãµ±Ç°µÄ¹¦Á¦Öµ²»×ã" .. g_Gift_GongLiSongLi[i].GongLi .. ", ÇëÔÙ½ÓÔÙÀ÷.")
        return
    end

    if (GetTaskBit(g_Task_GongLiSongLi, i) > 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­ÁìÈ¡¹ıµ±Ç°½±Àø.")
        return
    end

    local str = "Äú½«»ñµÃ<c=g>" .. GetGiftText(g_Gift_GongLiSongLi[i].WuPingBiao) .. "<c>, ÇëÈ·ÈÏÊÇ·ñÏÖÔÚÁìÈ.¿"
    SetTask(141, i)
    MsgBox(str, "XuanZeGongLi_y", "no")
end

function XuanZeGongLi_y()
    no()
    local i = GetTask(141)
    if (g_Gift_GongLiSongLi[i] == nil) then
        Talk(1, "no", "³öÏÖ´íÎó, xin h·y chän l¹i.")
        return
    end
    SetTaskBit(g_Task_GongLiSongLi, i, 1)
    local boxName = GetNormalItemName(Id[1], Id[2], Id[3], Id[4])
    if (AddGift(g_Gift_GongLiSongLi[i].WuPingBiao) == "") then
        WriteLog("[" .. boxName .. " ¹¦Á¦ËÍÀñ µÚ" .. i .. "µµ, ÁìÈ¡Ê§°Ü.]")
        return
    end
    local str = GetGiftText(g_Gift_GongLiSongLi[i].WuPingBiao)

    Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc <c=g>" .. str .. "<c>.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. str .. ".")
    WriteLog("[" .. boxName .. " ¹¦Á¦ËÍÀñ µÚ" .. i .. "µµ, ÁìÈ¡l " .. str .. ".]")
end

function QianKunDan()
    no()
    if (GetNewBirthTimes() == 1) then
        Talk(1, "no", "§· chuyÓn sinh, kh«ng thÓ dïng thÇn ®an nµy ®Ó th¨ng cÊp.")
        return
    end
    local nTask = {
        tblCostID[1][2] .. "/LevelUp",
        tblCostID[2][2] .. "/LevelUp",
    }
    Say("×£Äú²½²½ÕùÏÈ, Ò²¿ÉÇ°Íù°Ë±¦¸óÑ¡¹º!", table.getn(nTask), nTask)
end

function LevelUp(nIndex)
    no()
    if (nIndex < 0 or nIndex > 1) then
        Talk(1, "no", "Ñ¡Ôñ³ö´í, xin h·y chän l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(tblCostID[nIndex + 1][1])
    if (GetCoin() >= Cv) then
        MsgBox(tblCostID[nIndex + 1][2] .. " cÇn " .. Cfs .. " Th«ng B¶o, ÄãÈ·¶¨ÒªÃëÉı sao?", tblCostID[nIndex + 1][3], "no")
    else
        Talk(1, "no", "Xin lçi, " .. tblCostID[nIndex + 1][2] .. "CÇn" .. Cfs .. " Th«ng B¶o, ÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
    end
end

function YesLevelUp1()
    if (GetLevel() < 10) then
        Talk(1, "no", "Cµn Kh«n §¬n <c=r>cÊp 10<c> míi cã thÓ sö dông. ")
        return
    end

    local nMap, nX, nY = GetWorldPos()
    if (nMap == 66) then
        Talk(1, "no", "Chç nµy kh«ng thÓ sö dông Cµn Kh«n §¬n. ")
        return
    end

    local nGetLevel = tblCostID[1][4]
    local nLevel = nGetLevel - GetLevel()
    local nFstate = GetFightState()
    if (nLevel <= 0) then
        Talk(1, "no", 13532)
    else
        if (IsHaveSpaceForTreasure(4) == 0) then
            Talk(1, "no", "H·y kiÓm tra tói ph¶i cã tèi thiÓu 3 «.")
            return
        end

        local Cname, Cv, Cfs = GetCostCoinInfoByIdx(tblCostID[1][1])
        if (GetCoin() < Cv) then
            Talk(1, "no", "Xin lçi, " .. tblCostID[1][2] .. "CÇn" .. Cfs .. " Th«ng B¶o, ÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
            return
        end
        CostCoinByIdx(tblCostID[1][1])

        SetTaskWord(54, 1, math.floor(LocalSystemTime() / 86400))
        SetTaskByte(54, 3, 9)
        SetTaskByte(54, 4, nGetLevel)

        TaskNote(1044, -1)
        SetSubTask(1044, -1, 1)
        TaskNote(1045, -1)
        SetSubTask(1045, -1, 1)
        SetTaskByte(1389, 1, 11)
        SetTaskByte(1389, 2, 3)

        if (GetTaskByte(1426, 1) == 0 and GetTaskByte(1427, 1) == 0) then
            SetTaskByte(1427, 1, 1)
            AddNormalItem(4, 243, 0, 0, 0, 0)
            TaskNote(1053, 0)
            TopMessage("NhËn <c=yel>Bót Kı 1")
            Msg2Player("NhËn Bót Kı 1, xem trªn ®ã viÕt g×.")
        end

        if (PetIsAdd() == 0) then
            for i = 1, 5 do
                AddIBBuff(418)
            end
            Talk(1, "no", "Chøc mõng sö dông thµnh c«ng Cµn Kh«n §¬n! T¨ng ®Õn <c=g>cÊp 45<c>! TÊt c¶ kü n¨ng ch­a ®¹t cÊp 40 ®Òu t¨ng 4 cÊp!\n Do ch­a cã thó c­ng, tÆng thªm 5 Linh Thó Chi NguyÖn! H·y ®Õn<c=g>TriÒu Ca<c> t×m Hoµng Phi Hæ, Tú Bµ lµm nhiÖm vô lªn cÊp!")
        else
            Talk(1, "no", "Chøc mõng sö dông thµnh c«ng Cµn Kh«n §¬n! T¨ng ®Õn <c=g>cÊp 45<c>! TÊt c¶ kü n¨ng ch­a ®¹t cÊp 40 ®Òu t¨ng 4 cÊp! H·y ®Õn <c=g>TriÒu Ca<c> t×m Hoµng Phi Hæ, Tú Bµ lµm nhiÖm vô lªn cÊp!")
        end
        SetFightState(1)
        for i = 1, nLevel do
            nNextLevelExp = GetNextExp()
            AddExp(nNextLevelExp, 0, 0)
        end

        local nKind = GetPlayerType()

        if (nKind == 0) then
            for i = 27, 32 do
                ActiveSkill(i)
                local j1 = 4 - GetSkillLevel(i)
                if (i ~= 28) and (i ~= 33) and (i ~= 34) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            if (GetTask(3) == 0) then
                Msg2Player("§i gÆp TrŞnh Lu©n ®Ó th¨m dß t©m ı.")
                SetTask(3, 1)
                TaskNote(27, 0)
            end
        elseif (nKind == 1) then
            for i = 3, 13 do
                ActiveSkill(i)
                local j1 = 4 - GetSkillLevel(i)
                if (i ~= 7) and (i ~= 12) and (i ~= 14) and (i ~= 17) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            if (GetTask(1) == 0) then
                AddEventItem(0)
                Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bŞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
                SetTask(1, 1)
                TaskNote(28, 0)
            end
        elseif (nKind == 2) then
            for i = 43, 46 do
                ActiveSkill(i)
                local j1 = 4 - GetSkillLevel(i)
                if (i ~= 43) and (i ~= 46) and (i ~= 48) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            for i = 450, 453 do
                ActiveSkill(i)
                local j1 = 4 - GetSkillLevel(i)
                if (j1 > 0) then
                    AddSkillLevel(i, j1)
                end
            end
            if (GetTask(2) == 0) then
                Msg2Player("TiÕp nhËn sù ñy th¸c cña H×nh Thiªn, ®Õn TriÒu Ca gÆp Hå Hû MŞ lÊy thiÕp mêi dù yÕn")
                SetTask(2, 1)
                TaskNote(29, 0)
            end
        end

        WriteLog(g_NewServerName .. "[ĞÂ·ş][Ê¹ÓÃÇ¬À¤µ¤]")
        ClearTaskNote()
        FunAddExtItem(1)
        SendTextMailToSelf(4, "Hép th­", "Sau khi dïng Cµn Kh«n §¬n t¨ng ®Õn cÊp 45, t×m Hoµng Phi Hæ t¹i TriÒu Ca b¾t ®Çu lµm nhiÖm vô t×nh b¸o, t×m Tú Bµ lµm nhiÖm vô C©y ThÇn Thiªn §×nh; Còng cã thÓ ®Õn T©y Kú t×m ThÇy Bãi To¸n b¾t ®Çu lµm nhiÖm vô bãi quÎ. ")
        SetFightState(nFstate)
        Earn(200000)
        local DiaStr = "<c=g><RoleName=\"" .. GetName() .. "\"><c> uèng Cµn Kh«n §¬n, trong nh¸y m¾t th¨ng tíi cÊp 45, tu hµnh t¨ng tiÕn cùc lín. Anh hïng cã thÓ bÊm B¸t B¶o C¸c ®Ó t×m hiÓu."
        Msg2CurMapAnnounce(DiaStr)
        if (IsTongMember()) then
            Msg2TongMember(DiaStr)
        end
    end
end

function YesLevelUp2()
    CloseDialog()
    local itemID = GetTask(140)
    local nGetLevel = tblCostID[2][4]
    local nLevel = nGetLevel - GetLevel()
    local nFstate = GetFightState()
    if (nLevel <= 0) then
        Talk(1, "no", 13532)
    else
        if (IsHaveSpaceForTreasure(4) == 0) then
            Talk(1, "no", "H·y kiÓm tra tói ph¶i cã tèi thiÓu 3 «.")
            return
        end

        local Cname, Cv, Cfs = GetCostCoinInfoByIdx(tblCostID[2][1])
        if (GetCoin() < Cv) then
            Talk(1, "no", "Xin lçi, " .. tblCostID[2][2] .. "CÇn" .. Cfs .. " Th«ng B¶o, ÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
            return
        end
        CostCoinByIdx(tblCostID[2][1])

        SetTaskWord(54, 1, math.floor(LocalSystemTime() / 86400))
        SetTaskByte(54, 3, 9)
        SetTaskByte(54, 4, nGetLevel)

        SetFightState(1)
        if (PetIsAdd() == 0) then
            for i = 1, 25 do
                AddIBBuff(418)
            end
            Talk(1, "no", "Chøc mõng sö dông thµnh c«ng Cöu ChuyÓn Cµn Kh«n §¬n! T¨ng ®Õn cÊp <c=g>" .. nGetLevel .. "<c>! TÊt c¶ kü n¨ng ch­a ®¹t cÊp 60 ®Òu t¨ng ®Õn cÊp 8!\n Do ch­a cã thó c­ng, tÆng thªm 25 Linh Thó Chi NguyÖn! H·y ®Õn<c=g>Tr­êng Ca hoÆc T©y Kú<c> gÆp thÇy bãi lµm nhiÖm vô Tø T­îng Linh Tª")
        else
            Talk(1, "no", "Chøc mõng sö dông thµnh c«ng Cöu ChuyÓn Cµn Kh«n §¬n! T¨ng ®Õn cÊp <c=g>" .. nGetLevel .. " <c>! TÊt c¶ kü n¨ng ch­a ®¹t cÊp 60 ®Òu t¨ng ®Õn cÊp 8! H·y ®Õn <c=g>TriÒu Ca hoÆc T©y Kú<c> t×m thÇy bãi lµm nhiÖm vô Tø T­¬ng Linh Tª!")
        end
        for i = 1, nLevel do
            nNextLevelExp = GetNextExp()
            AddExp(nNextLevelExp, 0, 0)
        end
        local nKind = GetPlayerType()

        if (nKind == 0) then
            for i = 27, 37 do
                ActiveSkill(i)
                local j1 = 8 - GetSkillLevel(i)
                if (i ~= 28) and (i ~= 33) and (i ~= 34) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            if (GetTask(3) == 0) then
                Msg2Player("§i gÆp TrŞnh Lu©n ®Ó th¨m dß t©m ı.")
                SetTask(3, 1)
                TaskNote(27, 0)
            end
        elseif (nKind == 1) then
            for i = 3, 18 do
                ActiveSkill(i)
                local j1 = 8 - GetSkillLevel(i)
                if (i ~= 7) and (i ~= 12) and (i ~= 14) and (i ~= 17) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            if (GetTask(1) == 0) then
                AddEventItem(0)
                Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bŞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
                SetTask(1, 1)
                TaskNote(28, 0)
            end
        elseif (nKind == 2) then
            for i = 43, 48 do
                ActiveSkill(i)
                local j1 = 8 - GetSkillLevel(i)
                if (i ~= 43) and (i ~= 46) and (i ~= 48) then
                    if (j1 > 0) then
                        AddSkillLevel(i, j1)
                    end
                end
            end
            for i = 450, 455 do
                ActiveSkill(i)
                local j1 = 8 - GetSkillLevel(i)
                if (j1 > 0) then
                    AddSkillLevel(i, j1)
                end
            end
            if (GetTask(2) == 0) then
                Msg2Player("TiÕp nhËn sù ñy th¸c cña H×nh Thiªn, ®Õn TriÒu Ca gÆp Hå Hû MŞ lÊy thiÕp mêi dù yÕn")
                SetTask(2, 1)
                TaskNote(29, 0)
            end
        end

        if (GetTaskByte(1426, 1) == 0 and GetTaskByte(1427, 1) == 0) then
            SetTaskByte(1427, 1, 1)
            AddNormalItem(4, 243, 0, 0, 0, 0)
            TaskNote(1053, 0)
            TopMessage("NhËn <c=yel>Bót Kı 1")
            Msg2Player("NhËn Bót Kı 1, xem trªn ®ã viÕt g×.")
        end

        WriteLog(g_NewServerName .. "[ĞÂ·ş][Ê¹ÓÃ¾Å×ªÇ¬À¤µ¤]")
        SetFightState(nFstate)
        ClearTaskNote()
        FunAddExtItem(2)
        SendTextMailToSelf(4, "Hép th­", "Sö dông Cöu ChuyÓn Cµn Kh«n §¬n t¨ng ®Õn cÊp " .. nGetLevel .. ", t×m thÇy bãi t¹i Tr­êng Ca hoÆc T©y Kú lµm nhiÖm vô Tø T­îng Linh Tª. Cßn cã thÓ gia nhËp vµo 1 quèc gia, cïng h¶o h÷u x­ng b¸ Phong ThÇn!")
        Earn(500000)
        local DiaStr = "<c=g><RoleName=\"" .. GetName() .. "\"><c> uèng Cöu ChuyÓn Cµn Kh«n §¬n, trong nh¸y m¾t th¨ng tíi cÊp " .. nGetLevel .. ", kü n¨ng th¨ng tiÕn v­ît bËc, ®¹t ®Õn c¶nh giíi tu vi cùc ®¹i. Anh hïng cã thÓ më B¸t B¶o C¸c ®Ó xem thö."
        Msg2CurMapAnnounce(DiaStr)
        AddGlobalNews(DiaStr)
        if (IsTongMember()) then
            Msg2TongMember(DiaStr)
        end
    end
end

function FunAddExtItem(index)
    if (index == nil) then
        index = 1
    end

    if (NewServerEx.Pub_IsNewLevel() >= 1) then
        if (index == 1) then
            AddNormalItemBind(4, 48, 0, 0, 0, 0, 1)
            AddNormalItemBind(4, 48, 0, 0, 0, 0, 1)
            Msg2CurMapAnnounce("<bc=b><RoleName=\"" .. GetName() .. "\"></bc>³É¹¦Ê¹ÓÃÁËÇ¬À¤µ¤, ¶îÍâ nhËn ®­îc Á½¸ö<c=g>ÉñÃØµÄÖÖ×Ó<c>.")
            Msg2Player("Anh hïng nhËn thªm 2 H¹t ThÇn Bİ. ")
            WriteLog("[Ê¹ÓÃÁËÇ¬À¤µ¤»ñµÃÖÖ×Ó*2]")
        elseif (index == 2) then
            AddEventItem(48)
            AddEventItem(48)
            Msg2CurMapAnnounce("<bc=b><RoleName=\"" .. GetName() .. "\"></bc>§· sö dông thµnh c«ng Cöu ChuyÓn Cµn Kh«n §¬n, nhËn thªm 2 <c=g>H¹t ThÇn Bİ<c>. ")
            Msg2Player("Anh hïng nhËn thªm 2 H¹t ThÇn Bİ. ")
            WriteLog("[Ê¹ÓÃÁË¾Å×ªÇ¬À¤µ¤»ñµÃÖÖ×Ó*2]")
        end
    end
end

function ChongJiSongLi()
    no()

    local strShow = {}
    local lenth = table.getn(g_Gift_ChongJiSongLi)

    for i = 1, lenth do
        strShow[i] = g_Gift_ChongJiSongLi[i].DengJi .. "µÈ¼¶:" .. GetGiftText(g_Gift_ChongJiSongLi[i].WuPingBiao) .. IsGetedText(g_Task_ChongJiSongLi, i) .. "/XuanZeChongJi"
    end

    Say(WenZi[3], table.getn(strShow), strShow)
end

function XuanZeChongJi(indexTemp)
    no()
    local i = indexTemp + 1
    if (g_Gift_ChongJiSongLi[i] == nil) then
        Talk(1, "no", "³öÏÖ´íÎó, xin h·y chän l¹i.")
        return
    end

    if (IsHaveSpaceForTreasure(g_Gift_ChongJiSongLi[i].BeiBao + 1) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng ®ñ " .. g_Gift_ChongJiSongLi[i].BeiBao .. "¸ñ, h·y s¾p xÕp l¹i råi ®Õn ®æi.")
        return
    end

    if (GetLevel() < g_Gift_ChongJiSongLi[i].DengJi) then
        Talk(1, "no", "ThËt xin lçi, Äãµ±Ç°µÄµÈ¼¶²»×ã" .. g_Gift_ChongJiSongLi[i].DengJi .. ", ÇëÔÙ½ÓÔÙÀ÷.")
        return
    end

    if (GetTaskBit(g_Task_ChongJiSongLi, i) > 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­ÁìÈ¡¹ıµ±Ç°½±Àø.")
        return
    end

    local str = "Äú½«»ñµÃ<c=g>" .. GetGiftText(g_Gift_ChongJiSongLi[i].WuPingBiao) .. "<c>, ÇëÈ·ÈÏÊÇ·ñÏÖÔÚÁìÈ.¿"
    SetTask(141, i)
    MsgBox(str, "XuanZeChongJi_y", "no")
end

function XuanZeChongJi_y()
    no()
    local i = GetTask(141)
    if (g_Gift_ChongJiSongLi[i] == nil) then
        Talk(1, "no", "³öÏÖ´íÎó, xin h·y chän l¹i.")
        return
    end
    SetTaskBit(g_Task_ChongJiSongLi, i, 1)
    local boxName = GetNormalItemName(Id[1], Id[2], Id[3], Id[4])
    if (AddGift(g_Gift_ChongJiSongLi[i].WuPingBiao) == "") then
        WriteLog("[" .. boxName .. " ³å¼¶ËÍÀñ µÚ" .. i .. "µµ, ÁìÈ¡Ê§°Ü.]")
        return
    end
    local str = GetGiftText(g_Gift_ChongJiSongLi[i].WuPingBiao)

    Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc <c=g>" .. str .. "<c>.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. str .. ".")
    WriteLog("[" .. boxName .. " ³å¼¶ËÍÀñ µÚ" .. i .. "µµ, ÁìÈ¡l " .. str .. ".]")
end

function AddGift(list)
    if (list == nil or table.getn(list) <= 0) then
        return
    end
    local str = ""
    local playerType = GetPlayerType()
    local lenth = table.getn(list)

    for i = 1, lenth do
        local t = list[i]
        for j = 1, t.num do
            if (t.type == "VËt phÈm") then
                AddNormalItemBind(t.id[1], t.id[2], t.id[3], t.id[4], t.id[5], t.id[6], t.bind)
            elseif (t.type == "TiÒn") then
                Earn(t.id[1])
            elseif (t.type == "B¹c khãa") then
                EarnBind(t.id[1])
            elseif (t.type == "IBBUFF") then
                if (t.id[1] == nil or t.id[1] <= 0) then
                    break ;
                end
                if (t.id[2] == nil or t.id[2] <= 0) then
                    t.id[2] = 0
                end
                if (t.id[3] == nil or t.id[3] <= 1) then
                    t.id[3] = 1
                end
                local nLeftTime = 0
                if (HaveIBBuff(t.id[1]) > 0) then
                    nLeftTime = GetIBBuffLeftTimes(t.id[1])
                    if (nLeftTime < 0) then
                        nLeftTime = 0
                    end
                    RemoveIBBuff(t.id[1])
                end
                AddIBBuff(t.id[1], t.id[2] + nLeftTime, t.id[3] - 1)

            elseif ((t.type == "Ö°ÒµÆÆ¾ü¼×Ê¿" and playerType == 0) or (t.type == "Ö°ÒµÆÆ¾üµÀÊ¿" and playerType == 1) or (t.type == "Ö°ÒµÆÆ¾üÒìÈË" and playerType == 2)) then

                for i = 1, 10 do
                    if (t.id[i] == nil or t.id[i] <= 1) then
                        t.id[i] = 0
                    end
                end
                local nItemIndex = AddNormalItem4(t.id[1], t.id[2], t.id[3], t.id[4], t.id[5], t.id[6], t.id[7], t.id[8], t.id[9])
                if (t.bind > 0) then
                    SetItemBind(nItemIndex, 1)
                end
            end

        end

        if (str == "") then
            str = list[i].name
        else
            str = str .. "," .. list[i].name
        end
    end
    return str
end

function GetGiftText(t)
    if (t == nil) then
        return ""
    end
    local lenth = table.getn(t)
    local str = ""
    local playerType = GetPlayerType()
    for i = 1, lenth do
        if not ((t[i].type == "Ö°ÒµÆÆ¾ü¼×Ê¿" and playerType ~= 0) or (t[i].type == "Ö°ÒµÆÆ¾üµÀÊ¿" and playerType ~= 1) or (t[i].type == "Ö°ÒµÆÆ¾üÒìÈË" and playerType ~= 2)) then
            if (str == "") then
                str = t[i].name
            else
                str = str .. "+" .. t[i].name
            end
        end

    end
    return str
end

function IsGetedText(task, index)


    if (task == nil or index == nil or index < 1 or index > 16) then
        return 0
    end

    if (GetTaskBit(task, index) <= 0) then
        return "<c=g> Î´ÁìÈ¡<c>"
    else
        return "<c=r> §· nhËn<c>"
    end
end

function no()
    CloseDialog()
end

function ClearTaskNote()
    local nType = GetPlayerType() + 1
    if (nType < 1 or nType > 3) then
        return
    end

    for j = 1, table.getn(TableTaskNote[nType]) do
        TaskNote(TableTaskNote[nType][j], -1)
    end
    for j = 1, table.getn(TaskTableCommon) do
        TaskNote(TaskTableCommon[j], -1)
    end
end

function TongAct()
    if (NewServerEx.Pub_IsCreateTongBookTime() == 0) then
        Talk(1, "no", "ThËt xin lçi, »¹Ã»µ½Ê±¼ä, ½¨³ÇÊé½«ÔÚ¿ª·şºó7 ngµy ¿É¹ºÂò..")
        return
    end

    if (GetCityName() ~= "") then
        Talk(1, "no", "ÄúµÄ¹ú¼ÒÒÑ¾­´´½¨³ÇÊĞ.")
        return
    end
    local tasks = {
        { "Mua ½¨³ÇÊé", "BuyCreateTongBook"; show = 1 },
        { "Quay l¹i", "main"; show = 1 },
    }
    SayTask("Mua ½¨³ÇÊé: ÎªÖú¹ú¸»°²¿µ, ÀèÃñ°²ÎÈ, ÌØµØÎª¸÷Î»´øÀ´½¨³ÇÊéÒ»Ì×.Ö»ÓĞ¹úÍõ²ÅÄÜ¹ºÂò.", tasks)
end
function BuyCreateTongBook()
    local tasks = {
        { "½¨³ÇÊé-Æğ", "BuyItem1"; show = 1 },
        { "½¨³ÇÊé-³Ğ", "BuyItem2"; show = 1 },
        { "½¨³ÇÊé-×ª", "BuyItem3"; show = 1 },
        { "½¨³ÇÊé-ºÏ", "BuyItem4"; show = 1 },
        { "Quay l¹i", "TongAct"; show = 1 },
    }
    SayTask("Mua ½¨³ÇÊéĞèÒª»¨·Ñ½ğÇ®:  (8000Íò-¹ú¼ÒÈËÆø*1Íò),½¨³ÇÊé¹ºÂòºó°ó¶¨.", tasks)
end

function BuyItem1()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    local info = "Mua ½¨³ÇÊé-ÆğĞèÒª»¨·Ñ<c=y>" .. price .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem1_yes", "no")
end
function BuyItem1_yes()
    no()
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    if (GetCash() >= price) then
        Pay(price)
        AddNormalItemBind(3, 58, 0, 0, 0, 0, 1)
        WriteLog("[¹ºÂò½¨³ÇÊé-Æğ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. price .. ".")
    end
end

function BuyItem2()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    local info = "Mua ½¨³ÇÊé-³ĞĞèÒª»¨·Ñ<c=y>" .. price .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem2_yes", "no")
end
function BuyItem2_yes()
    no()
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    if (GetCash() >= price) then
        Pay(price)
        AddNormalItemBind(3, 59, 0, 0, 0, 0, 1)
        WriteLog("[¹ºÂò½¨³ÇÊé-³Ğ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. price .. ".")
    end
end

function BuyItem3()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    local info = "Mua ½¨³ÇÊé-×ªĞèÒª»¨·Ñ<c=y>" .. price .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem3_yes", "no")
end
function BuyItem3_yes()
    no()
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    if (GetCash() >= price) then
        Pay(price)
        AddNormalItemBind(3, 60, 0, 0, 0, 0, 1)
        WriteLog("[¹ºÂò½¨³ÇÊé-×ª]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. price .. ".")
    end
end

function BuyItem4()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    local info = "Mua ½¨³ÇÊé-ºÏĞèÒª»¨·Ñ<c=y>" .. price .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem4_yes", "no")
end
function BuyItem4_yes()
    no()
    local TongName = GetTongName()
    local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
    local price = 80000000 - A_atta * 10000
    if (price < 0) then
        price = 0
    end
    if (GetCash() >= price) then
        Pay(price)
        AddNormalItemBind(3, 61, 0, 0, 0, 0, 1)
        WriteLog("[¹ºÂò½¨³ÇÊé-ºÏ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. price .. ".")
    end
end

g_GuaFuBoxTime = NewServerEx.g_GuaFuBox
function GuaFu()
    if (Pub_IsGuaFuOpen == 0) then
        Talk(1, "no", "ThËt xin lçi, ²»ÊÇ»î¶¯Ê±¼ä, [³É³¤ØÔ·ûÀñ°ü]ÔÚ¿ª·şÇ°7 ngµy ¿É¹ºÂò.")
        return
    end

    local tasks = {
        { "Mua ØÔ·ûÀñ°ü", "BuyGuaFuBox"; show = 1 },
        { "Quay l¹i", "main"; show = 1 },
    }
    SayTask("[³É³¤ØÔ·ûÀñ°ü]½öÏŞĞÂ·şÊ×ÖÜ¹ºÂò, Äú½«¿ÉÒÔ<c=y>ÒÔ688 Th«ng B¶oµÄ³¬Öµ¼Û¸ñ¹ºÂòµ½¼ÛÖµ1899 Th«ng B¶oµÄ³É³¤ØÔ·ûÀñ°ü<c>, ÈÃÄúµÄ¹¦Á¦Ó®ÔÚÆğÅÜÏß.\n¹ºÂòºó, Äú½«ÔÚcÊp 70-120ÖĞ, Ã¿Ôö³¤10¼¶¿É»ñµÃØÔ·û, <c=g>¹²¿É»ñµÃ4 c¸i Vi Quang Qu¸i Phï vµ 5 c¸i Tinh Th¸i Qu¸i Phï, ØÔ·û¾ùÎª°ó¶¨µÄ<c>.\n»î¶¯½ØÖ¹Ê±¼äÎª: " .. g_GuaFuBoxTime[2][1] .. "N¨m" .. g_GuaFuBoxTime[2][2] .. "Th¸ng" .. g_GuaFuBoxTime[2][3] .. "ÈÕ24:00Ç°", tasks)
end

function Pub_IsGuaFuOpen()
    if (GetGameServerName() ~= g_NewServerName) then
        return
    end

    local y, m, d = GetYMD()
    local OpenTime = g_GuaFuBoxTime[1][1] * 10000 + g_GuaFuBoxTime[1][2] * 100 + g_GuaFuBoxTime[1][3]
    local CloseTime = g_GuaFuBoxTime[2][1] * 10000 + g_GuaFuBoxTime[2][2] * 100 + g_GuaFuBoxTime[2][3]
    local today = y * 10000 + m * 100 + d
    if (today >= OpenTime) and (today <= CloseTime) then
        return 1
    end
    return 0
end

function BuyGuaFuBox()
    no()

    if (GetTaskByte(g_Task_Card, 4) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı[³É³¤ØÔ·ûÀñ°ü], Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(294)
    MsgBox("[³É³¤ØÔ·ûÀñ°ü], Ö»ĞèÒÔ<c=g>" .. Cfs .. "<c> Th«ng B¶oµÄ³¬Öµ¼Û¸ñ¹ºÂòµ½¼ÛÖµ1899 Th«ng B¶oµÄØÔ·ûÀñ°ü, ÈÃÄúµÄ¹¦Á¦Ó®ÔÚÆğÅÜÏß¡;î¶¯½öÏŞ¿ª·şÇ°ÆßÌì, ÊÇ·ñ¹ºÂò?", "BuyGuaFuBox_yes", "no")

end

function BuyGuaFuBox_yes()
    no()

    if (GetTaskByte(g_Task_Card, 4) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı[³É³¤ØÔ·ûÀñ°ü], Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(294)
    if (GetCoin() < Cv) then
        Talk(1, "no", "Mua [³É³¤ØÔ·ûÀñ°ü], cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
        return
    end

    if (CostCoinByIdx(294) > 0) then
        SetTaskByte(g_Task_Card, 4, 1)
        AddNormalItemBind(6, 1, 1674, 1, 0, 0, 1)
        Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc <c=g>³É³¤ØÔ·ûÀñ°ü<c>.")
        Msg2Player("Chóc mõng ngµi nhËn ®­îc ³É³¤ØÔ·ûÀñ°ü.")
        WriteLog("[ĞÂ·şÌØ¹©ÀñºĞ][³É³¤ØÔ·ûÀñ°ü]" .. Cfs)
    else
        BuyGuaFuBox_yes()
    end
end



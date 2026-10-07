require("newserver.luax")
g_NewServerName = NewServerEx.g_ServerName

g_Task_GongLiSongLi = 2074
g_Task_ChongJiSongLi = 2075

Id = NewServerEx.g_Id2

BookPrice = 60000000

WenZi = {

    [1] = "<c=g>" .. g_NewServerName .. "<c>ĞÂ·ş»î¶¯µÚ¶ş¼¾ÀñºĞ\n¹¦Á¦ËÍÀñ: ÕÇ¹¦Á¦, ÁìºÃÀñ, <ÁÒ>ÆÆÍ¼Æ×, Óñ¾§, ĞÇ²Ê¶¼ËÍÄã!\n§éc b¸ V¹n Tiªn: ÇÀ±¦Ïä, ¶áØÔ·û!ÏêÇéÇë¿´§éc b¸ V¹n Tiªn»î¶¯½éÉÜ.´ËºĞ×Ó½«ÓÚ" .. NewServerEx.g_Time2[2][1] .. "N¨m" .. NewServerEx.g_Time2[2][2] .. "Th¸ng" .. NewServerEx.g_Time2[2][3] .. "ÈÕÉ¾³ı.",
    [2] = "Çë¸ù¾İÄúµÄ¹¦Á¦ÁìÈ¡¶ÔÓ¦½±Àø, °´Ë³ĞòÁìÈ¡.",
    [3] = "Çë¸ù¾İÄúµÄµÈ¼¶ÁìÈ¡¶ÔÓ¦½±Àø, °´Ë³ĞòÁìÈ¡.\nµÚ 1 c¸i µ½´ï160¼¶µÄÓ¢ĞÛ½«»ñµÃ±¾ÇøÌØÓĞ³ÆºÅ.",
    [4] = "°Ë¾°¹¬±¾ÍÁÑø³ÉHå HØ MŞ, ¼´ËÍÓñ¾§, »¹ÔÚµÈÊ²Ã´£¿.",
    [5] = "ÎªÖú¹ú¸»°²¿µ, ÀèÃñ°²ÎÈ, <" .. g_NewServerName .. ">µÚ¶ş¼¾ÌØ¹©ÀñºĞÌØµØÎª¸÷Î»Ó¢ĞÛ´øÀ´½¨³ÇÊéÒ»Ì×, Çë°´Ğè mua",
    [6] = "§éc b¸ V¹n Tiªn: ÍòÏÉÕóÖĞ¶á±¦Ïä, µÃÊôĞÔ³ÆºÅ vµ ØÔ·û." .. NewServerEx.g_DuBaWanXian[1][2] .. "Th¸ng" .. NewServerEx.g_DuBaWanXian[1][3] .. "ÈÕÖÁ" .. NewServerEx.g_DuBaWanXian[2][2] .. "Th¸ng" .. NewServerEx.g_DuBaWanXian[2][3] .. "ÈÕ21:00µÄÍòÏÉÕó (ÍÁ, Ë®, »ğ, ·ç, »Ã)ÖĞ, ÍòÏÉÕó½ÌÖ÷ËÀºó, ½«µôÂä 1 c¸i ¡°ÉÁÉÁ·¢¹âµÄ±¦Ïä¡±, <c=r>ĞèÒª¿ªÉ«²ÅÄÜ¿ªÆô<c>, ±¦Ïä¿ªÆôÊ±¼ä<c=r>30<c>ÃëÖÓ, ÇÒ»á±»¹ÖÎï»òÆäËûÕóÓªÍæ¼Ò´ò¶Ï.",
    [7] = "´ò¿ªÍÁÕóÖĞµÄ±¦Ïä, ½«»ñµÃ<c=g>M¶nh tranh Qu¸i Phï s¬ cÊp*1<c>, ´ò¿ªË®, »ğÕóÖĞµÄ±¦Ïä, ½«»ñµÃ<c=g>M¶nh tranh Qu¸i Phï s¬ cÊp*2<c>, ´ò¿ª·ç, »ÃÕóÖĞ±¦Ïä, ½«»ñµÃ<c=g>M¶nh tranh Qu¸i Phï s¬ cÊp*3<c>, ÇÒËùÔÚ¶ÓÎéµÄËùÓĞÍæ¼Ò, ¶¼½«»ñµÃ¶ÔÓ¦µÄ¡°<c=g>§éc b¸ V¹n Tiªn<c>¡±´øÊôĞÔ³ÆºÅ (<c=g>ÃüÖĞ+100, ·ÀÓù+50<c>, ÓĞĞ§ÆÚÎª2 ngµy ).",
}

g_Gift_GongLiSongLi = {

    [1] = { GongLi = 8500, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói Danh Ngäc", id = { 8, 1669, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },


    [2] = { GongLi = 9000, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Thä S¬n Th¹ch", id = { 3, 135, 0, 0, 0, 0 }, num = 5, bind = 1 },
        { type = "VËt phÈm", name = "T­íng Qu©n LÖnh", id = { 3, 100, 0, 0, 0, 0 }, num = 5, bind = 1 },
    }
    },

    [3] = { GongLi = 10000, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Lß tinh luyÖn s¬ cÊp", id = { 3, 155, 0, 0, 0, 0 }, num = 3, bind = 1 },
        { type = "VËt phÈm", name = "Lß tinh luyÖn trung cÊp", id = { 3, 156, 0, 0, 0, 0 }, num = 3, bind = 1 },
    }
    },

    [4] = { GongLi = 12000, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói quµ ®å phæ Ph¸ qu©n <LiÖt>", id = { 8, 1456, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [5] = { GongLi = 14000, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói Ngäc Tinh", id = { 8, 1670, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [6] = { GongLi = 16000, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tinh Th¸i Qu¸i Phï (ch­a mµi)", id = { 3, 383, 0, 0, 0, 0 }, num = 1, bind = 1 },

    }
    },

    [7] = { GongLi = 18000, BeiBao = 1, WuPingBiao = {
        { type = "Gi¸p sÜ", name = "Thu Cao Khİ S¶ng-Thu ı Chİnh Nïng Trang", id = { 8, 1554, 2, 0, 0, 0 }, num = 1, bind = 1 },
        { type = "§¹o sÜ", name = "H¹ NhËt Viªm Viªm-Kiªu D­¬ng Tù Háa Trang", id = { 8, 1516, 2, 0, 0, 0 }, num = 1, bind = 1 },
        { type = "DŞ nh©n", name = "Cöu Ngò Chi T«n*Cöu Tiªu Long Ng©m Trang", id = { 8, 1504, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },
}

g_Gift_ChongJiSongLi = {

    [1] = { DengJi = 105, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "T­íng Qu©n LÖnh*5", id = { 3, 100, 0, 0, 0, 0 }, num = 5, bind = 1 },
    }
    },

    [2] = { DengJi = 110, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "LÔ bao Danh Ngäc*2", id = { 8, 1447, 2, 0, 0, 0 }, num = 2, bind = 1 },
    }
    },

    [3] = { DengJi = 120, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Ùã·ç°ËÔËÍè*30", id = { 3, 551, 0, 0, 0, 0 }, num = 30, bind = 1 },
    }
    },

    [4] = { DengJi = 125, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Thä S¬n Th¹ch*5", id = { 3, 135, 0, 0, 0, 0 }, num = 5, bind = 1 },
    }
    },

    [5] = { DengJi = 130, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói quµ ®å phæ Ph¸ qu©n <LiÖt>", id = { 8, 1456, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [6] = { DengJi = 135, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "ÌìÅ­¹‚*3", id = { 3, 563, 0, 0, 0, 0 }, num = 3, bind = 1 },
        { type = "VËt phÈm", name = "§Şnh Hån Th¹ch*2", id = { 3, 557, 0, 0, 0, 0 }, num = 2, bind = 1 },
    }
    },

    [7] = { DengJi = 140, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Tói Ngäc Tinh", id = { 8, 1670, 2, 0, 0, 0 }, num = 1, bind = 1 },
    }
    },

    [8] = { DengJi = 145, BeiBao = 2, WuPingBiao = {
        { type = "VËt phÈm", name = "Lß Tinh LuyÖn S¬ cÊp*3", id = { 3, 155, 0, 0, 0, 0 }, num = 3, bind = 1 },
        { type = "VËt phÈm", name = "Lß Tinh LuyÖn Trung cÊp*3", id = { 3, 156, 0, 0, 0, 0 }, num = 3, bind = 1 },
    }
    },

    [9] = { DengJi = 150, BeiBao = 1, WuPingBiao = {
        { type = "VËt phÈm", name = "Khİ Nguyªn (cao cÊp)", id = { 8, 283, 2, 0, 0, 0 }, num = 1, bind = 1 },
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

    if (NewServerEx.Pub_IsNewServerTime2() <= 0) then
        DelNormalItem(Id[1], Id[2], Id[3], Id[4])
        local str = GetNormalItemName(Id[1], Id[2], Id[3], Id[4])
        Talk(1, "no", str .. "ÒÑÉ¾³ı.")
        WriteLog(str .. "ÒÑÉ¾³ı.")
        return
    end

    local tasks = {
        { "¹¦Á¦ËÍÀñ", "GongLiSongLi"; show = 0 },
        { "¹ú¼Ò»î¶¯", "TongAct"; show = 0 },
        { "³å¼¶ºÃÀñ", "ChongJiSongLi"; show = 0 },
        { "§éc b¸ V¹n Tiªn", "WanXianZhen"; show = 0 },
        { "Hå HØ MŞÑø³É", "HuXimeiYangcheng"; show = 0 },
        { "Hµo LÔ", "GongLiHaoli"; show = 0 },
    }

    if (GetTaskByte(2073, 3) == 1 and GetTaskByte(2073, 4) == 1) then
        tasks[5].show = 0
    end
    if (NewServerEx.Pub_IsWanXianTime() > 0) then
        tasks[4].show = 1
    end
    tasks[1].show = NewServerEx.IsOpenGongLiSongLi
    tasks[2].show = NewServerEx.IsOpenBuyCreatTongBook
    tasks[3].show = NewServerEx.IsOpenChongJiSongLi
    tasks[6].show = NewServerEx.IsOpenGongLiHaoLiAll

    SayTask(WenZi[1], tasks)
end

function TongAct()
    local tasks = {
        { "Mua ½¨³ÇÊé", "BuyCreateTongBook"; show = 1 },
        { "NhËn ¹ú¼Ò½ğÇ®", "GetTongMoney"; show = 1 },
        { "Quay l¹i", "main"; show = 1 },
    }
    SayTask("Mua ½¨³ÇÊé: ÎªÖú¹ú¸»°²¿µ, ÀèÃñ°²ÎÈ, ÌØµØÎª¸÷Î»´øÀ´½¨³ÇÊéÒ»Ì×.Ö»ÓĞ¹úÍõ²ÅÄÜ¹ºÂò.\nÁìÈ¡¹ú¼Ò½ğÇ®: ÒÑ½¨³ÇµÄ¹ú¼Ò¹úÍõÃ¿ÈÕ¿ÉÒÔÔÚÕâÀïÁìÈ¡¹ú¼ÒÈËÆøÖµ°Ù±¶µÄ¹ú¼Ò½ğÇ®.", tasks)
end
function BuyCreateTongBook()
    local tasks = {
        { "½¨³ÇÊé-Æğ", "BuyItem1"; show = 1 },
        { "½¨³ÇÊé-³Ğ", "BuyItem2"; show = 1 },
        { "½¨³ÇÊé-×ª", "BuyItem3"; show = 1 },
        { "½¨³ÇÊé-ºÏ", "BuyItem4"; show = 1 },
        { "Quay l¹i", "TongAct"; show = 1 },
    }
    SayTask(WenZi[5], tasks)
end

function BuyItem1()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local info = "Mua ½¨³ÇÊé-ÆğĞèÒª»¨·Ñ<c=y>" .. BookPrice .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem1_yes", "no")
end
function BuyItem1_yes()
    no()
    if (GetCash() >= BookPrice) then
        Pay(BookPrice)
        AddNormalItem(3, 58, 0, 0, 0, 0)
        WriteLog("[¹ºÂò½¨³ÇÊé-Æğ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. BookPrice .. ".")
    end
end

function BuyItem2()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local info = "Mua ½¨³ÇÊé-³ĞĞèÒª»¨·Ñ<c=y>" .. BookPrice .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem2_yes", "no")
end
function BuyItem2_yes()
    no()
    if (GetCash() >= BookPrice) then
        Pay(BookPrice)
        AddNormalItem(3, 59, 0, 0, 0, 0)
        WriteLog("[¹ºÂò½¨³ÇÊé-³Ğ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. BookPrice .. ".")
    end
end

function BuyItem3()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local info = "Mua ½¨³ÇÊé-×ªĞèÒª»¨·Ñ<c=y>" .. BookPrice .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem3_yes", "no")
end
function BuyItem3_yes()
    no()
    if (GetCash() >= BookPrice) then
        Pay(BookPrice)
        AddNormalItem(3, 60, 0, 0, 0, 0)
        WriteLog("[¹ºÂò½¨³ÇÊé-×ª]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. BookPrice .. ".")
    end
end

function BuyItem4()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔ¹ºÂò½¨³ÇÊé")
        return
    end
    local info = "Mua ½¨³ÇÊé-ºÏĞèÒª»¨·Ñ<c=y>" .. BookPrice .. "<c>½ğ\nÊÇ·ñÈ·¶¨¹ºÂò?"
    MsgBox(info, "BuyItem4_yes", "no")
end
function BuyItem4_yes()
    no()
    if (GetCash() >= BookPrice) then
        Pay(BookPrice)
        AddNormalItem(3, 61, 0, 0, 0, 0)
        WriteLog("[¹ºÂò½¨³ÇÊé-ºÏ]")
    else
        Talk(1, "TongAct", "ÄúµÄµÄb¹c kh«ng ®ñ " .. BookPrice .. ".")
    end
end

function GetTongMoney()
    if (GetTongMemberDuty() ~= 1) then
        Talk(1, "TongAct", "Ö»ÓĞ¹úÍõ²Å¿ÉÒÔÁìÈ¡¹ú¼Ò½ğÇ®.")
        return
    end
    if (GetCityName() == "") then
        Talk(1, "TongAct", "ÄúµÄ¹ú¼ÒÃ»ÓĞ³ÇÊĞ, ½¨³Çºó¿ÉÒÔÃ¿ÈÕÁìÈ¡¹ú¼Ò½ğÇ®.")
        return
    end
    local Y, M, D = GetYMD()
    if (GetTaskByte(2101, 2) ~= D) then
        SetTaskByte(2101, 2, D)
        local TongName = GetTongName()
        local A_Member, A_atta = GetTongAttrByID(GetTongIDByName(TongName))
        if (A_atta > 0) then
            local money = A_atta * 100
            AddTongRes(0, money)
            Talk(1, "no", "ÒòÎª¹ú¼ÒÈËÆøÎª<c=g>" .. A_atta .. "µã, ËùÒÔÁìÈ¡µ½¹ú¼Ò½ğÇ®" .. money .. "½ğ.")
            Msg2Player("ÒòÎª¹ú¼ÒÈËÆøÎª<c=g>" .. A_atta .. "µã, ËùÒÔÁìÈ¡µ½¹ú¼Ò½ğÇ®" .. money .. "½ğ.")
            Msg2TongMember("ÎÒ¹ú¹úÍõ" .. GetName() .. "ÔÚ[ÓñÖù¶´]ĞÂ·şµÚ¶ş¼¾ÀñºĞÖĞÎª¹ú¼Ò nhËn " .. money .. "¹ú¼Ò½ğÇ®.Çë¹ú¼Ò³ÉÔ±Îª¹ú¼Ò¶à»ıÀÛÈËÆøÖµ, ¹ú¼Ò½«ÄÜ»ñµÃ¸ü¶à¹ú¼Ò½ğÇ®!")
            WriteLog("[ÁìÈ¡¹ú¼Ò½ğÇ®" .. money .. "]")
        else
            Talk(1, "TongAct", "ÓÉÓÚ¹ú¼ÒÈËÆø²»×ã, ²»ÄÜÁìÈ¡¹ú¼Ò½ğÇ®")
        end
    else
        Talk(1, "TongAct", "ThËt xin lçi, Ã¿ÈÕÖ»ÄÜÁìÈ¡Ò»´Î.")
    end

end

function WanXianZhen()
    Talk(2, "main", WenZi[6], WenZi[7])
end

function FuLiKa()
    no()
    local tasks = {
        { "Kinh nghiÖm¸£ÀûÔÂ¿¨", "YueKa"; show = 1 },
        { "Ö÷Ìâ¸£ÀûÖÜ¿¨", "ZhouKa"; show = 1 },
    }
    SayTask("¸÷ÖÖ³¬Öµ¸£Àû¿¨, ¾¡ÔÚÓÚ´Ë.", tasks)
end

function YueKa()
    no()

    if (GetTaskByte(g_Task_Card, 1) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı¸£ÀûÔÂ¿¨, Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(103)
    if (GetCoin() >= Cv) then
        MsgBox("ThÎ phóc lîi kinh nghiÖm M¸y chñ míi (th¸ng), Ö»Ğè<c=g>" .. Cfs .. "<c> Th«ng B¶o¾Í¿É»ñµÃ 30 c¸i M¶nh s¸ch Ch­ HÇu¼° 30 c¸i Ëæ»úÑÕÉ«Ë®¾§ËéÆ¬Å¶, ÊÇ·ñ¹ºÂò?", "YueKa_y", "no")
    else
        Talk(1, "no", "Mua ThÎ phóc lîi kinh nghiÖm M¸y chñ míi (th¸ng) cÇn <c=g>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
    end
end

function YueKa_y()
    no()

    if (GetTaskByte(g_Task_Card, 1) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı¸£ÀûÔÂ¿¨, Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(103)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, ¸£ÀûÔÂ¿¨ cÇn <c=g>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (CostCoinByIdx(103) > 0) then
        SetTaskByte(g_Task_Card, 1, 1)
        AddNormalItemBind(8, 1736, 2, 0, 0, 0, 1)
        Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÒ»ÕÅ¸£ÀûÔÂ¿¨.")
        Msg2Player("Ngµi nhËn ®­îc Ò»ÕÅ¸£ÀûÔÂ¿¨.")
        WriteLog(g_NewServerName .. "[Ho¹t ®éng m¸y chñ míi][¹ºÂò¸£ÀûÔÂ¿¨]")
    else
        Talk(1, "no", "ThËt xin lçi, ¹ºÂò¸£ÀûÔÂ¿¨Ê§°Ü!")
    end
end

function ZhouKa()
    no()

    if (GetTaskByte(g_Task_Card, 2) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı¸£ÀûÔÂ¿¨, Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(266)
    if (GetCoin() >= Cv) then
        MsgBox("ThÎ phóc lîi Chñ §Ò Ngµy, Ö»Ğè<c=g>" .. Cfs .. "<c> Th«ng B¶oÊÇ·ñ¹ºÂò?", "ZhouKa_y", "no")
    else
        Talk(1, "no", "Mua <c=g>ThÎ phóc lîi Chñ §Ò Ngµy<c>, cÇn <c=g>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
    end
end

function ZhouKa_y()
    no()

    if (GetTaskByte(g_Task_Card, 2) ~= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­¹ºÂò¹ı¸£ÀûÔÂ¿¨, Ã¿ÈËÖ»ÄÜ¹ºÂòÒ»´Î.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(266)
    if (GetCoin() < Cv) then
        Talk(1, "no", "Mua <c=g>ThÎ phóc lîi Chñ §Ò Ngµy<c>, cÇn <c=g>" .. Cfs .. "<c> Th«ng B¶oÄãÏÖÔÚÍ¨±¦ sè l­îng kh«ng ®ñ.")
        return
    end

    if (CostCoinByIdx(266) > 0) then
        SetTaskByte(g_Task_Card, 2, 1)
        AddNormalItemBind(8, 1777, 2, 0, 0, 0, 1)
        Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc <c=g>ThÎ phóc lîi Chñ §Ò Ngµy<c>.")
        Msg2Player("Chóc mõng ngµi nhËn ®­îc ThÎ phóc lîi Chñ §Ò Ngµy.")
        WriteLog("[NhËn ®­îc ThÎ phóc lîi Chñ §Ò Ngµy]")
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

    Talk(1, "GongLiSongLi", "Chóc mõng b¹n nhËn ®­îc <c=g>" .. str .. "<c>.")
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. str .. ".")
    WriteLog("[" .. boxName .. " ¹¦Á¦ËÍÀñ µÚ" .. i .. "µµ, ÁìÈ¡l " .. str .. ".]")
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

            elseif ((t.type == "Gi¸p sÜ" and playerType == 0) or (t.type == "§¹o sÜ" and playerType == 1) or (t.type == "DŞ nh©n" and playerType == 2)) then

                for i = 1, table.getn(t.id) do
                    if (t.id[i] == nil or t.id[i] < 0) then
                        t.id[i] = 0
                    end
                end

                local nItemIndex = AddNormalItem(t.id[1], t.id[2], t.id[3], t.id[4], t.id[5], t.id[6])
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
        if not ((t[i].type == "Gi¸p sÜ" and "Ö°ÒµÆÆ¾ü¼×Ê¿" and playerType ~= 0) or (t[i].type == "§¹o sÜ" and "Ö°ÒµÆÆ¾üµÀÊ¿" and playerType ~= 1) or (t[i].type == "DŞ nh©n" and "Ö°ÒµÆÆ¾üÒìÈË" and playerType ~= 2)) then
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

function HuXimeiYangcheng()
    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng cã ®ñ 3 « trèng, xin s¾p xÕp l¹i")
        return
    end
    local huximei_level = GetTaskByte(2071, 2)
    if (huximei_level < 7) then
        Talk(1, "no", "ĞèÒªÓ¢ĞÛ½«Áé³èHå HØ MŞĞŞÁ¶µ½7¼¶Ê±²Å¿ÉÒÔÁìÈ¡.")
        return
    end
    if (huximei_level >= 7 and huximei_level < 10) then
        if (GetTaskByte(2073, 3) == 1) then
            Talk(1, "no", "ĞèÒªÓ¢ĞÛ½«Áé³èHå HØ MŞĞŞÁ¶µ½10¼¶Ê±²Å¿ÉÒÔÁìÈ¡.")
            return
        else
            SetTaskByte(2073, 3, 1)

            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)

            Msg2Player("Chóc mõng ngµi nhËn ®­îc LÔ bao Danh Ngäc*3.")
            Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc LÔ bao Danh Ngäc*3.")
            WriteLog("[" .. GetName() .. "][ĞÂ·ş»î¶¯µÚ¶ş¼¾][NhËn ®­îc7¼¶Hå HØ MŞLÔ bao Danh Ngäc]")
        end
    end
    if (huximei_level == 10) then
        if (GetTaskByte(2073, 3) == 0) then
            SetTaskByte(2073, 3, 1)

            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)

            Msg2Player("Chóc mõng ngµi nhËn ®­îc LÔ bao Danh Ngäc*3.")
            Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc LÔ bao Danh Ngäc*3.")
            WriteLog("[" .. GetName() .. "][ĞÂ·ş»î¶¯µÚ¶ş¼¾][NhËn ®­îc7¼¶Hå HØ MŞLÔ bao Danh Ngäc]")
            return
        end
        if (GetTaskByte(2073, 4) == 1) then
            Talk(1, "no", "ÄúÒÑ¾­ nhËn ´Îµµ½±Àø, ²»¿ÉÖØ¸´ÁìÈ¡.")
            return
        else
            SetTaskByte(2073, 4, 1)
            AddNormalItemBind(8, 1670, 2, 0, 0, 0, 1)
            Msg2Player("Chóc mõng ngµi nhËn ®­îc LÔ bao Ngäc Tinh.")
            Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc LÔ bao Ngäc Tinh.")
            WriteLog("[" .. GetName() .. "][ĞÂ·ş»î¶¯µÚ¶ş¼¾][NhËn ®­îc10¼¶Hå HØ MŞLÔ bao Ngäc Tinh]")
        end
    end
end

function GongLiHaoli()
    no()
    Talk(2, "GongLiHaoli1", "ÈôÄúÔÚĞÂÇø½ÇÉ«¹¦Á¦Öµ´ïµ½ÈçÏÂ½×¶Î, lµ cã thÓ nhËn ¶ÔÓ¦µÄ½±Àø.<c=y>´Ë½±Àø²»ÏŞÖÆÁìÈ¡Çø·ş<c>, Äú¿ÉÒÔÑ¡ÔñÔÚĞÂÇøÁìÈ¡, Ò²¿ÉÒÔÑ¡ÔñÔÚÀÏÇøÁìÈ¡.", "<c=g>ºÀÀñ¡¤Ò»<c>: ĞèÒª¹¦Á¦Öµ´ïµ½8000-10000 c¸iÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1\n<c=g>ºÀÀñ¡¤¶ş<c>: ĞèÒª¹¦Á¦Öµ´ïµ½10001-12000 c¸iÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1, Vi Quang Qu¸i Phï*3")
end

function GongLiHaoli1()
    no()
    Talk(3, "GongLiHaoli2", "<c=g>ºÀÀñ¡¤Èı<c>: ĞèÒª¹¦Á¦Öµ´ïµ½12001-14000 c¸iÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1, Vi Quang Qu¸i Phï*3, Tói Ngäc Tinh*1", "<c=g>ºÀÀñ¡¤ËÄ<c>: ĞèÒª¹¦Á¦Öµ´ïµ½14001-16000 c¸iÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1, Vi Quang Qu¸i Phï*3, Tói Ngäc Tinh*1, ¸ß¼¶×°±¸¾«»ê*1", "<c=g>ºÀÀñ¡¤Îå<c>: ĞèÒª¹¦Á¦Öµ´ïµ½16001-18000 c¸iÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1, Vi Quang Qu¸i Phï*3, Tói Ngäc Tinh*1, ¸ß¼¶×°±¸¾«»ê*1, Tinh Th¸i Qu¸i Phï*1")
end

function GongLiHaoli2()
    no()
    local nT = NewServerEx.g_GongLiTime
    Talk(2, "GongLiHaoli3", "<c=g>ºÀÀñ¡¤Áù<c>: ĞèÒª¹¦Á¦Öµ´ïµ½18001ÒÔÉÏ¿ÉÁì.\n×éºÏºÏ³ÉµÖ¿ÛÈ¯*1/Tinh Hoa Tiªn Sñng*1(¶şÑ¡Ò»), Tói Danh Ngäc*1, Vi Quang Qu¸i Phï*3, Tói Ngäc Tinh*1, ¸ß¼¶×°±¸¾«»ê*1, Tinh Th¸i Qu¸i Phï*1, ÔÂ»ªØÔ·û*1", "<c=y>" .. nT[1][1] .. "N¨m" .. nT[1][2] .. "Th¸ng" .. nT[1][3] .. "ÈÕ24:00--" .. nT[2][1] .. "N¨m" .. nT[2][2] .. "Th¸ng" .. nT[2][3] .. "ÈÕ24: 00<c>, ÄúµÚÒ»´ÎµÇÂ½ĞÂÇø½ÇÉ«Ê±, ÏµÍ³½«×Ô¶¯¼ÆËã³öÄúµÄ¹¦Á¦ÖµCã thÓ nhËnµÄ½±ÀøÄÚÈİ, ²¢ÎªÄú·¢ÓÊ¼şÌáĞÑ.ÊÕµ½ÓÊ¼şºó, Äú¼´¿ÉÔÚÈÎÒ»Çø·ş½øĞĞÁì½±.")
end

function GongLiHaoli3()
    no()
    local nT = NewServerEx.g_GongLiTime
    Talk(2, "no", "<c=g>ÁìÈ¡·½Ê½<c>: " .. nT[1][1] .. "N¨m" .. nT[1][2] .. "Th¸ng" .. nT[1][3] .. "ÈÕ24:00--" .. nT[2][1] .. "N¨m" .. nT[2][2] .. "Th¸ng" .. nT[2][3] .. "ÈÕ24:00, ´ïµ½»ñ½±Ìõ¼şµÄÍæ¼Ò, ¿ÉÊ¹ÓÃÕËºÅÏÂÈÎÒ»Çø·şµÄÈÎÒ»½ÇÉ«Ç°ÍùÑş³Ø[LÔ Quan]´¦ÁìÈ¡.", "<c=r>ÎÂÜ°ÌáÊ¾<c>: 1, ´Ë´Î»î¶¯ÖĞ, 1 c¸i ÕËºÅ½öÓĞÒ»´Î»ñ½±»ú»á, ½öÏŞÕËºÅÏÂ 1 c¸i ½ÇÉ«ÁìÈ¡.²»¿ÉÖØ¸´ÁìÈ¡.\n2, ÓÉÓÚÊÇ°´ÕÕÁì½±ÆÚ¼äÄúµÚÒ»´ÎµÇÂ½Ê±×Ô¶¯¼ÆËãµÄ¹¦Á¦ÖµÆ¥Åä½±Àø, ÎªÁË±ÜÃâÓÉÓÚ×°±¸Ã»´©ÔÚÉíÉÏ¶øµ¼ÖÂ½±Àøµµ´Î½µµÍ, ÇëÄúÔÚ" .. nT[1][2] .. "Th¸ng" .. nT[1][3] .. "ÈÕ24:00Ö®Ç°´©ÉÏÄú¹¦Á¦×î¸ßµÄ×°±¸.")
end


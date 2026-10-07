Ibitem_max = 20
Ibitem_list = { 416, 417, 1317, 1393, 1454, 1827 }
Magicscript_max = 50
Magicscript_list = { 272, 293, 294, 393, 394, 395, 396, 1028, 1029, 1053, 1054, 1062, 1127, 1190, 1331, 1332, 1355, 1356, 1357, 1400, 1438, 1439, 1446, 1460, 1477, 1529, 1564, 1565, 1571, 1572, 1573, 1574, 1575, 1576, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1585,
                     1586, 1587, 1588, 1589, 1590, 1591, 1592, 1652, 1653, 1654, 1655, 1703, 1704, 1705, 1706, 1833, 1834, 1835, 1872, 1873 }
Material_max = 10
Material_list = { 278, 279, 280, 374, 383, 392, 401, 1108 }

g_ItemIDLimit = {
    [1] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕskillbook", item = { 7, 68, 1489, 1 } },
    [2] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕIbitem", item = { 8, 2194, 7, 1 } },
    [3] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕMagicscript", item = { 6, 1, 1884, 1 } },
    [4] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕmaterial", item = { 3, 1647, 0, 0 } },
    [5] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕamulet", item = { 0, 4, 133, 10 } },
    [6] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕarmor", item = { 0, 2, 50, 10 } },
    [7] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕboot", item = { 0, 5, 51, 10 } },
    [8] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕhorse", item = { 0, 10, 71, 10 } },
    [9] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕinstrument", item = { 0, 11, 13, 10 } },
    [10] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕweapon", item = { 0, 0, 104, 10 } },
    [11] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕpotion", item = { 1, 30, 0, 0 } },
    [12] = { idx = 1, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕquestkey", item = { 4, 314, 1, 1 } },
    [13] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕbelt", item = { 0, 6, 50, 10 } },
    [14] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕhelm", item = { 0, 7, 50, 10 } },
    [15] = { idx = 12, str = "Äã³¬³öÈ¡Öµ·¶Î§µÄÊıÖµÉÏÏŞ, ÏêÇéÇë²ÎÕÕpendant", item = { 0, 9, 50, 10 } },
}
LockedIP_list = { "", "" }

g_RecipientsPlayerName = ""

g_ItemId = { 1, 0, 0, 0, 0, 0 }

g_ItemCount = 1

g_IsBind = 1

g_MoneyAmount = 0

function main()

    local key = checkLoginIP()
    if (key <= 0) then
        clear_stone("ip")
        return
    elseif (key == 2) then
        clear_stone("¼ÓµÀ¾ß´íÎó")
        return
    end

    local tasks = {
        { "ThiÕt lËp ph¸t th­ëng", "SetParameter"; show = 1 },

        { "³£ÓÃ²¹³¥", "sendNormal"; show = 1 },
        { "Ö÷Ïß¼¼ÄÜÁé³è", "mainLine"; show = 1 },
        { "¸ü¸ÄÈÎÎñÌáÊ¾", "renwuMain"; show = 1 },
        { "Xo¸ ®¹o cô", "clear"; show = 1 },
        { "Båi th­êng Buff", "add_buff"; show = 1 },
    }

    SayTask("´ËµÀ¾ß¿ÉÒÔ½»Ò×¸øÍæ¼ÒÊ¹ÓÃ, Èç¹û²»¶®µÄÕÒ[Öéº£¹«Ë¾\XSJÎ÷É½¾ÓÓÎÏ·\±±¾©\·âÉñ°ñ]ÏîÄ¿×éÈËÑ¯ÎÊ.<c=r>Èç¹ûÔÚÍâÍøÍæ¼Ò½ÇÉ«ÉÏÊ¹ÓÃ, sö dông ºóÇëÎñ±Øµã[Xo¸ ®¹o cô]ÀïµÄ¡°Huû ®¸¡±<c>, ÏÖÔÚÈÃÎÒÃÇ¿´¿´ÄãÏë¸ÉĞ©Ê²Ã´°É: ", tasks)

end

function clear()
    local tasks = {
        { "Ò»¼ü´«ËÍ", "Trap"; show = 1 },
        { "Huû ®¸", "clear_stone"; show = 1 },
        { "Xo¸ ®¹o cô", "clear_Item"; show = 1 },
        { "Më kho¸ vËt phÈm|°ó¶¨", "Item_UnBindmain"; show = 1 },
        { "³ÆºÅÊÕ»Ø", "Item_UnTitle"; show = 1 },
    }
    SayTask("[Xo¸ ®¹o cô]¿ÉÒÔÏú»ÙÄã×ó¼üµã»÷µÄµÀ¾ß: ", tasks)

end

function clear_Item()
    no()
    MsgBox("H·y nhÊp chuét tr¸i vµo ®¹o cô cÇn <c=r>Ïú»Ù<c>µÄµÀ¾ß!", "Yes_clearItem", "clear")
end

function Yes_clearItem()
    no()
    MouseSelect(1, 22, "Itemclear", "clear")
end

function Itemclear(ItemID)
    SetTask(142, ItemID)
    MsgBox("X¸c ®Şnh muèn huû vËt phÈm: <c=r>" .. GetItemName(ItemID) .. "<c>\n[È·¶¨]É¾³ı, [È¡Ïû]Trë l¹i Trang tr­íc", "yes_itemclear", "clear")
end

function yes_itemclear()
    local ItemID = GetTask(142)
    local str = GetItemName(ItemID)
    if (str == nil) or (str == "") then
        Talk(1, "clear", "Huû ®¹o cô thÊt b¹i!")
        return
    end

    local nCount = DelItemByID(ItemID, 1)
    if (nCount > 0) then
        WriteLog("[Ğ¡Ê¯Í·][Xo¸ ®¹o cô:" .. nCount .. "." .. str)
        Talk(1, "clear", "Huû ®¹o cô thµnh c«ng:" .. nCount .. "." .. str)
    else
        Talk(1, "clear", "Huû ®¹o cô thÊt b¹i!")
    end
end

function clear_stone(keystr)
    no()
    InfoBox("Mét con khØ chui ra tõ t¶ng ®¸ vµ bá ch¹y!")
    for i = 0, 1 do
        ClearItem(6, 1, 1787, i)
    end

    WriteLog("[Ğ¡Ê¯Í·][Huû ®¸]" .. keystr)
end

function Item_UnBindmain()
    no()
    MsgBox("H·y nhÊp chuét tr¸i vµo ®¹o cô cÇn <c=r>°ó¶¨»òÕß½â°ó<c>µÄµÀ¾ß!", "Yes_bindSel", "clear")
end

function Yes_bindSel()
    no()
    MouseSelect(1, 22, "bindSelItem", "clear")
end

function bindSelItem(ItemID)
    no()
    SetTask(142, ItemID)

    local tasks = {
        { "µÀ¾ß°ó¶¨", "Item_Bindyes"; show = 1 },
        { "Më kho¸ vËt phÈm", "Item_UnBindyes"; show = 1 },
        { "Xo¸ ®¹o cô", "yes_itemclear"; show = 1 },
    }
    SayTask("ÄãÊÇ²»ÊÇ´òËã´¦ÀíµÄÎïÆ·: <c=r>" .. GetItemName(ItemID) .. "<c>\nMêi lùa chän:", tasks)
end

function Item_UnBindyes()
    local ItemID = GetTask(142)
    if (IsItemBind(ItemID) <= 0) then
        Talk(1, "clear", "´ËµÀ¾ßÎŞĞè½â°ó!")
        return
    end

    local str = GetItemName(ItemID)
    if (str == nil) or (str == "") then
        Talk(1, "clear", "Sè liÖu bÊt th­êng, ÖØĞÂÑ¡!")
        return
    end

    if (SetItemBind(ItemID, 0) > 0) then
        Talk(1, "clear", "VËt phÈm" .. str .. "ÒÑ¾­Íê³É[½â°ó]²Ù×÷, Çë²é¿´!")
        Msg2Player("VËt phÈm" .. str .. "ÒÑ¾­Íê³É[½â°ó]²Ù×÷, Çë²é¿´!")

    else
        Talk(1, "clear", "Më kho¸ vËt phÈmÊ§°Ü!Çë²é¿´µÀ¾ßÀàĞÍ»òµÀ¾ß°ó¶¨·½Ê½!")
    end
end

function Item_Bindyes()
    local ItemID = GetTask(142)
    if (IsItemBind(ItemID) >= 1) then
        Talk(1, "clear", "´ËµÀ¾ßÎŞĞè°ó¶¨!")
        return
    end

    local str = GetItemName(ItemID)
    if (str == nil) or (str == "") then
        Talk(1, "clear", "Sè liÖu bÊt th­êng, ÖØĞÂÑ¡!")
        return
    end

    if (SetItemBind(ItemID, 1) > 0) then
        Talk(1, "clear", "VËt phÈm" .. str .. "ÒÑ¾­Íê³É[°ó¶¨]²Ù×÷, Çë²é¿´!")
        Msg2Player("VËt phÈm" .. str .. "ÒÑ¾­Íê³É[°ó¶¨]²Ù×÷, Çë²é¿´!")

    else
        Talk(1, "clear", "µÀ¾ß°ó¶¨Ê§°Ü!Çë²é¿´µÀ¾ßÀàĞÍ»òµÀ¾ß°ó¶¨·½Ê½!")
    end
end

function CheckKey(strValue)
    no()

    if (strValue == nil or strValue == "") then
        clear_stone("MËt m· v« hiÖu")
        InfoBox("ThËt xin lçi, sai mËt m·, vËt phÈm bŞ thu håi")
        return
    end

    if (strValue == "Kinal@GMXFS") then
        local szLoginIP = GetIP()
        for j = 1, getn(LockedIP_list) do
            if (LockedIP_list[j] == szLoginIP) then
                LockedIP_list[j] = ""
                InfoBox("Më kho¸ thµnh c«ng")
                return
            end
        end
    else
        clear_stone("Sai mËt khÈu")
        InfoBox("ThËt xin lçi, sai mËt m·, vËt phÈm bŞ thu håi")
    end
end

function NewServer()
    InfoBox("Tªn m¸y chñ:<c=g>" .. GetGameServerName() .. "<c>\nThêi gian më:<c=g>" .. GetServerStartTime() .. "<c>")
end

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

    for j = 1, getn(LockedIP_list) do
        if (LockedIP_list[j] == szLoginIP) then
            return 2
        end
    end

    for i = 1, table.getn(aryIPFilter) do
        if (aryIPFilter[i] == szLoginIP) then
            return 1
        end
    end

    return 0
end

function SetParameter()
    no()

    local tasks = {
        { "ĞŞ¸ÄÎïÆ·ID", "AmendItemId"; show = 1 },
        { "ĞŞ¸ÄÎïÆ·ÊıÁ¿", "AmendItemCount"; show = 1 },
        { "ĞŞ¸Ä½ğÇ®ÊıÁ¿", "AmendMoney"; show = 1 },
        { "ĞŞ¸ÄÊÇ·ñ°ó¶¨", "AmendItemBind"; show = 1 },
        { "²âÊÔ¼°·¢½±", "Test"; show = 1 },
        { "¸ø×Ô¼º¼Ó", "TestAddItem"; show = 1 },
    }

    SayTask(GetParameter(), tasks)

end

function AmendRecipientsPlayerName()
    no()

    local strShow = "<c=g>ÇëÇ×ÊäÈëÊÕ¼şÈËĞÕÃû:<c>"
    OpenInputStrDialog(strShow, 2, "ok/AmendRecipientsPlayerName_yes", "Trë l¹i/SetParameter")
end

function AmendRecipientsPlayerName_yes(name)

    if (name == nil) then
        name = ""
    end
    g_RecipientsPlayerName = name
    SetParameter()
end

function AmendItemId()
    no()

    local tasks = {
        { "ĞŞ¸ÄµÚ1Î»", "ReSetItemId_1"; show = 1 },
        { "ĞŞ¸ÄµÚ2Î»", "ReSetItemId_2"; show = 1 },
        { "ĞŞ¸ÄµÚ3Î»", "ReSetItemId_3"; show = 1 },
        { "ĞŞ¸ÄµÚ4Î»", "ReSetItemId_4"; show = 1 },
        { "ĞŞ¸ÄÊÇ·ñ°ó¶¨", "AmendItemBind"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "SetParameter"; show = 1 },
    }
    SayTask(GetParameter(), tasks)
end

function ReSetItemId_1()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_1_Yes", "Trë l¹i/AmendItemId")
end

function ReSetItemId_1_Yes(num)

    no()
    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_1_Yes", "Trë l¹i/AmendItemId")
        return
    end

    if (num > 8) then
        WriteLog("[Ğ¡Ê¯Í·][ÉèÖÃÎïÆ·²ÎÊı]ÊäÈëÖ¸ÁîÒì³£")
        MsgBox("ÄãÊäÈëÊı×ÖÒì³£, ¿´Çå³şµÄÔÙÊäÈë.", "AmendItemId", "no")

        return
    end

    g_ItemId[1] = num
    g_ItemId[2] = 0
    g_ItemId[3] = 0
    g_ItemId[4] = 0
    g_ItemCount = 1
    AmendItemId()
end

function ReSetItemId_2()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_2_Yes", "esc/AmendItemId")
end

function ReSetItemId_2_Yes(num)
    no()

    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_2_Yes", "Trë l¹i/AmendItemId")
        return
    end
    g_ItemId[2] = num
    g_ItemCount = 1
    AmendItemId()
end

function ReSetItemId_3()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_3_Yes", "esc/AmendItemId")
end

function ReSetItemId_3_Yes(num)


    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_3_Yes", "Trë l¹i/AmendItemId")
        return
    end
    g_ItemId[3] = num
    AmendItemId()
end

function ReSetItemId_4()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_4_Yes", "esc/AmendItemId")
end

function ReSetItemId_4_Yes(num)


    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_4_Yes", "Trë l¹i/AmendItemId")
        return
    end
    g_ItemId[4] = num
    AmendItemId()
end

function ReSetItemId_5()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_5_Yes", "esc/AmendItemId")
end

function ReSetItemId_5_Yes(num)


    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_5_Yes", "Trë l¹i/AmendItemId")
        return
    end
    g_ItemId[5] = num
    AmendItemId()
end

function ReSetItemId_6()
    no()

    local strShow = "ÇëÊäÈëĞÂµÄIDÊı×Ö:"
    InputDialog(strShow, 2, "ok/ReSetItemId_6_Yes", "esc/AmendItemId")
end

function ReSetItemId_6_Yes(num)


    if (num == nil) then
        InputDialog("ÄãÊäÈëÊÇ¿ÕÖµ, ÖØĞÂÊäÈë", 2, "ok/ReSetItemId_6_Yes", "Trë l¹i/AmendItemId")
        return
    end
    g_ItemId[6] = num
    AmendItemId()
end

function AmendItemCount()
    no()
    local strShow = "<c=g>ÓÊ¼şÖ»ÄÜ¸½ 1 c¸i µÀ¾ß, ¶øÇÒµÀ¾ßÄÜµş¼ÓµÄ²ÅÄÜ·¢¶à¸ö, ²»È»Ö»ÄÜ·¢ËÍ 1 c¸i µÀ¾ß, Çë×¢ÒâµÀ¾ßÊÇ·ñµş¼Ó, »¹Òª×¢Òâµş¼ÓµÄÉÏÏŞ, ÇëÇ×ÊäÈëÎïÆ·ÊıÁ¿:<c>"
    InputDialog(strShow, 2, "ok/AmendItemCount_Yes", "esc/SetParameter")
end

function AmendItemCount_Yes(num)

    if (num == nil) or (num <= 0) then
        num = 1
    end
    if (num > 1) then
        local key = isNumPilelimit(num)
        if (key == 0) then
            g_ItemCount = 1
            Msg2Player("´ËÎïÆ·Ö»ÄÜ 1 c¸i 1 c¸i ·¢ËÍ.Èç¹û¿ÉÒÔµş¼ÓµÄÎïÆ·, ¿ÉÒÔĞŞ¸Ä½Å±¾Ôö¼Óµ½ÌØÀı±íÀïÃæ")
            SetParameter()
            return
        elseif (key == 1) then
            g_ItemCount = num
            MsgBox("´ËÎïÆ·¿ÉÄÜ²»ÄÜµş¼Ó»òÕß³¬¹ıµş¼ÓÉÏÏŞ, ½¨Òé×Ô²âÒ»·âÓÊ¼ş¿´¿´ÄÜ·ñÊÕµ½, È·¶¨ÊÇ×Ô·¢ÓÊ¼ş, È¡ÏûÊÇ»Øµ½²ÎÊıÉèÖÃ½çÃæ", "TestSendMail", "SetParameter")
            return
        end
    end

    g_ItemCount = num
    SetParameter()
end

function isNumPilelimit(num)
    local key = 0
    if (g_ItemId[1] == 8) then
        for i = 1, getn(Ibitem_list) do
            if (g_ItemId[2] == Ibitem_list[i]) then
                if (num > Ibitem_max) then
                    return 1
                else
                    return num
                end
            end
        end
    elseif (g_ItemId[1] == 6) then
        for i = 1, getn(Magicscript_list) do
            if (g_ItemId[3] == Magicscript_list[i]) then
                if (num > Magicscript_max) then
                    return 1
                else
                    return num
                end
            end
        end
    elseif (g_ItemId[1] == 3) then
        for i = 1, getn(Material_list) do
            if (g_ItemId[2] == Material_list[i]) then
                return 0
            end
        end

        if (num > Material_max) then
            return 1
        else
            return num
        end
    elseif (g_ItemId[1] == 1) then
        if (num > 100) then
            return 1
        end
    end
    return key
end

function AmendMoney()
    no()
    local strShow = "<c=g>ÇëÇ×ÊäÈë½ğÇ®ÊıÁ¿:<c>"
    InputDialog(strShow, 2, "ok/AmendMoney_Yes", "esc/SetParameter")
end

function AmendMoney_Yes(num)
    if (num == nil) or (num <= 0) then
        num = 0
    end
    g_MoneyAmount = num
    SetParameter()
end

function AmendItemBind()
    MsgBox("ÄúÏ£ÍûµÀ¾ßÊÇ°ó¶¨µÄ sao?", "AmendItemBind_Yes", "AmendItemBind_No")
end

function AmendItemBind_Yes()
    g_IsBind = 1
    SetParameter()
end

function AmendItemBind_No()
    g_IsBind = 0
    SetParameter()
end

function GetParameter()


    local strShow = "ÊÕ¼şÈË:<c=g>" .. g_RecipientsPlayerName .. "<c>\n"

    strShow = strShow .. CheckItemId()

    strShow = strShow .. "ÎïÆ·Ãû³Æ:<c=pk>" .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "<c>\n"

    if (g_IsBind == 1) then
        strShow = strShow .. "ÊÇ·ñ°ó¶¨:<c=g>ÊÇ<c>\n"
    elseif (g_IsBind == 0) then
        strShow = strShow .. "ÊÇ·ñ°ó¶¨:<c=pk>·ñ<c>\n"
    else
        strShow = strShow .. "ÊÇ·ñ°ó¶¨:<c=pk>²»Ôì<c>\n"
    end

    if (g_ItemCount == 1) then
        strShow = strShow .. "µÀ¾ßÊıÁ¿:<c=g>" .. g_ItemCount .. "<c>\n"
    else
        strShow = strShow .. "µÀ¾ßÊıÁ¿(Çë·¢×Ô²âÓÊ¼şÈ·ÈÏµÀ¾ß¸öÊıÏà·ûºóÔÙ·¢²¹³¥):<c=y>" .. g_ItemCount .. "<c>\n"
    end

    strShow = strShow .. "½ğÇ®ÊıÁ¿:<c=g>" .. g_MoneyAmount .. "<c>\n"

    return strShow
end

function CheckItemId()
    no()

    for i = 1, getn(g_ItemId) do
        if (g_ItemId[i] == nil) then
            return "<c=r>Êı¾İ´íÎó<c>"
        end
    end

    local strShow = ""
    local result = 0

    strShow = strShow .. "ÎïÆ·ID:<c=g>" .. g_ItemId[1] .. "<c>\t"

    for i = 1, getn(g_ItemIDLimit) do
        if (g_ItemId[1] == g_ItemIDLimit[i].item[1]) then
            if (g_ItemIDLimit[i].idx == 1) then
                strShow = strShow .. GetCheckItemIdString(2, 0, g_ItemIDLimit[i].item[2])
                strShow = strShow .. GetCheckItemIdString(3, 0, g_ItemIDLimit[i].item[3])
                strShow = strShow .. GetCheckItemIdString(4, 0, g_ItemIDLimit[i].item[4])
                break
            elseif (g_ItemIDLimit[i].idx == 12) then
                if (g_ItemId[2] == g_ItemIDLimit[i].item[2]) then
                    strShow = strShow .. GetCheckItemIdString(2, g_ItemId[2], g_ItemId[2])
                    strShow = strShow .. GetCheckItemIdString(3, 0, g_ItemIDLimit[i].item[3])
                    strShow = strShow .. GetCheckItemIdString(4, 1, g_ItemIDLimit[i].item[4])
                    break
                end
            end
        end
    end

    strShow = strShow .. GetCheckItemIdString(5, 0, 0)
    strShow = strShow .. GetCheckItemIdString(6, 0, 1)

    return strShow .. "\n"
end

function GetCheckItemIdString(idIndex, minValue, maxValue)


    if (idIndex == nil or minValue == nil or maxValue == nil or type(idIndex) ~= "number" or type(minValue) ~= "number" or type(maxValue) ~= "number" or idIndex == nil or g_ItemId[idIndex] == nil) then

        return "<c=r>Êı¾İ´íÎó<c>\t"
    end

    if (g_ItemId[idIndex] < minValue) then
        g_ItemId[idIndex] = minValue
        return "<c=r>" .. g_ItemId[idIndex] .. "<c>\t"

    elseif (g_ItemId[idIndex] > maxValue) then

        return "<c=r>" .. g_ItemId[idIndex] .. "<c>\t"

    else
        return "<c=g>" .. g_ItemId[idIndex] .. "<c>\t"
    end
end

function Test()
    no()

    local tasks = {
        { "¸ø×Ô¼º¼Ó", "TestAddItem"; show = 1 },
        { "¸ø×Ô¼º·¢ÓÊ¼ş", "TestSendMail"; show = 1 },


        { "Trë l¹i²ÎÊıÉèÖÃ", "SetParameter"; show = 1 },
    }
    SayTask("         <bclr=b> ·âÉñ°ñThËp Chu NiªnÔËÓª¶¨ÖÆ°æ<bclr>\n" .. GetParameter(), tasks)

end

function TestAddItem()
    no()

    for i = 1, getn(g_ItemId) do
        if (g_ItemId[i] == nil) then
            Msg2Player("<c=r>Êı¾İ´íÎó<c>")
            return
        end
    end

    if (IsHaveSpaceForTreasure(g_ItemCount + 1) == 0) then
        Talk(1, "Test", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
        return
    end

    for i = 1, g_ItemCount do
        AddNormalItemBind(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4], g_ItemId[5], g_ItemId[6], g_IsBind)
    end

    local strName = GetName()
    local strLog = "[Ğ¡Ê¯Í·][Ö±½Ó¼ÓµÀ¾ß][ÊÕ¼şÈË:" .. strName .. "][µÀ¾ßÃû³Æ: " .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "][µÀ¾ßID:" .. g_ItemId[1] .. "," .. g_ItemId[2] .. "," .. g_ItemId[3] .. "," .. g_ItemId[4] .. "," .. g_ItemId[5] .. "," .. g_ItemId[6] .. "][¸öÊı:" .. g_ItemCount
    if (g_IsBind > 0) then
        strLog = strLog .. "][°ó¶¨]"
    else
        strLog = strLog .. "][·Ç°ó¶¨]"
    end
    Msg2Player(strLog)

    Test()
end

function TestSendMail()
    no()

    for i = 1, getn(g_ItemId) do
        if (g_ItemId[i] == nil) then
            Msg2Player("<c=r>Êı¾İ´íÎó<c>")
            return
        end
    end

    local strName = GetName()

    SendSysItemMailToTarget("Hép th­", strName, "GM", "Ç×°®µÄÍæ¼Ò:ÄúºÃ!¸½¼şÖĞÊÇÎªÄú·¢·ÅµÄµÀ¾ß, Çë×¢Òâ²éÊÕ.", g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4], g_ItemId[5], g_ItemId[6], g_MoneyAmount, g_ItemCount, g_IsBind)

    local strLog = ""
    if (g_IsBind > 0) then
        strLog = "[Ğ¡Ê¯Í·][ÊÕ¼şÈË:" .. strName .. "][µÀ¾ßÃû³Æ: " .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "][µÀ¾ßID:" .. g_ItemId[1] .. "," .. g_ItemId[2] .. "," .. g_ItemId[3] .. "," .. g_ItemId[4] .. "," .. g_ItemId[5] .. "," .. g_ItemId[6] .. "][¸öÊı:" .. g_ItemCount .. "][°ó¶¨][½ğÇ®ÊıÁ¿:" .. g_MoneyAmount .. "][×Ô²âÓÊ¼ş]"
    else
        strLog = "[Ğ¡Ê¯Í·][ÊÕ¼şÈË:" .. strName .. "][µÀ¾ßÃû³Æ: " .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "][µÀ¾ßID:" .. g_ItemId[1] .. "," .. g_ItemId[2] .. "," .. g_ItemId[3] .. "," .. g_ItemId[4] .. "," .. g_ItemId[5] .. "," .. g_ItemId[6] .. "][¸öÊı:" .. g_ItemCount .. "][·Ç°ó¶¨][½ğÇ®ÊıÁ¿:" .. g_MoneyAmount .. "][×Ô²âÓÊ¼ş]"
    end
    Msg2Player(strLog)

    Test()
end

function Send()
    no()

    MsgBox(GetParameter(), "Send_yes", "Test")
end

function Send_yes()
    no()

    if (g_RecipientsPlayerName == nil or g_RecipientsPlayerName == "") then
        MsgBox("Tªn ng­êi ch¬iÎª¿Õ, ÎŞ·¨·¢ËÍ.", "AmendRecipientsPlayerName", "Test")
        return
    end

    for i = 1, getn(g_ItemId) do
        if (g_ItemId[i] == nil) then
            Msg2Player("<c=r>Êı¾İ´íÎó<c>")
            return
        end
    end

    SendSysItemMailToTarget("Hép th­", g_RecipientsPlayerName, "GM", "Ç×°®µÄÍæ¼Ò:ÄúºÃ!¸½¼şÖĞÊÇÎªÄú·¢·ÅµÄµÀ¾ß, Çë×¢Òâ²éÊÕ.", g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4], g_ItemId[5], g_ItemId[6], g_MoneyAmount, g_ItemCount, g_IsBind)

    local strLog = ""
    if (g_IsBind > 0) then
        strLog = "[Ğ¡Ê¯Í·][ÊÕ¼şÈË:" .. g_RecipientsPlayerName .. "][µÀ¾ßÃû³Æ: " .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "][µÀ¾ßID:" .. g_ItemId[1] .. "," .. g_ItemId[2] .. "," .. g_ItemId[3] .. "," .. g_ItemId[4] .. "," .. g_ItemId[5] .. "," .. g_ItemId[6] .. "][¸öÊı:" .. g_ItemCount .. "][°ó¶¨][½ğÇ®ÊıÁ¿:" .. g_MoneyAmount .. "][·¢ËÍÓÊ¼ş]"
    else
        strLog = "[Ğ¡Ê¯Í·][ÊÕ¼şÈË:" .. g_RecipientsPlayerName .. "][µÀ¾ßÃû³Æ: " .. GetNormalItemName(g_ItemId[1], g_ItemId[2], g_ItemId[3], g_ItemId[4]) .. "][µÀ¾ßID:" .. g_ItemId[1] .. "," .. g_ItemId[2] .. "," .. g_ItemId[3] .. "," .. g_ItemId[4] .. "," .. g_ItemId[5] .. "," .. g_ItemId[6] .. "][¸öÊı:" .. g_ItemCount .. "][·Ç°ó¶¨][½ğÇ®ÊıÁ¿:" .. g_MoneyAmount .. "][·¢ËÍÓÊ¼ş]"
    end
    Msg2Player(strLog)
    WriteLog(strLog)
    Test()
end

function no()
    CloseDialog()
end;

t_maplist = {
    { mapname = "§¹i H¶i", mapid = { 53, 1450, 3645 }, ntype = 1 },
    { mapname = "Bång Lai", mapid = { 54, 1760, 3168 }, ntype = 1 },
    { mapname = "§«ng Doanh", mapid = { 55, 1780, 3166 }, ntype = 1 },
    { mapname = "Ph­¬ng Tr­îng", mapid = { 56, 1807, 3188 }, ntype = 1 },
    { mapname = "Khai Minh ®¶o", mapid = { 72, 1604, 3240 }, ntype = 4 },
    { mapname = "²»ÖÜÌì¹ØÏÉ", mapid = { 73, 1980, 3780 }, ntype = 2 },
    { mapname = "²»ÖÜÌì¹ØÄ§", mapid = { 73, 1607, 3212 }, ntype = 2 },
    { mapname = "²»ÖÜÌì¹Ø´«ËÍ", mapid = { 73, 2035, 3211 }, ntype = 3 },
}
function Trap()
    local tasks = {
        { "TruyÒn phï", "button1"; show = 1 },
        { "ËÄÃÔ¹¬", "button2"; show = 1 },
        { "±ÌÓÎÀ¦ÏÉ", "button3"; show = 1 },
        { "B«n L«i Chó", "button4"; show = 1 },
        { "ÌØÊâÖ±·É", "button5"; show = 1 },
    }
    SayTask("¸ø´«ËÍ·ûµÄ, ²»ÄÜÓÃ´«ËÍ·ûµÄÑ¡ÌØÊâ´«ËÍ, ´ËÊÇ¼ò°æÖ±·É, Ò»Ğ©ÌØÊâµØÍ¼, Ö»ÄÜÏÉ×ÓºÅ·É.", tasks)
end

function button1()
    no()
    AddNormalItem(6, 1, 6, 1, 0, 0)
    MsgBox("¸øÄã 1 c¸i ´«ËÍ·û", "Trap", "no")
end

function button2()
    no()
    AddNormalItemBind(8, 1708, 2, 0, 0, 0, 1)
    WriteLog("[Ğ¡Ê¯Í·][Ò»¼ü´«ËÍ]ËÄĞ¡ÃÔ¹¬")
    MsgBox("¸øÄã 1 c¸i ËÄĞ¡ÃÔ¹¬", "Trap", "no")
end
function button3()
    no()
    AddNormalItemBind(8, 1709, 2, 0, 0, 0, 1)
    WriteLog("[Ğ¡Ê¯Í·][Ò»¼ü´«ËÍ]±ÌÓÎÀ¦ÏÉ´«ËÍ·û")
    MsgBox("¸øÄã 1 c¸i ±ÌÓÎÀ¦ÏÉ´«ËÍ·û", "Trap", "no")
end
function button4()
    no()
    AddNormalItemBind(6, 1, 576, 0, 0, 0, 1)
    WriteLog("[Ğ¡Ê¯Í·][Ò»¼ü´«ËÍ]±¼À×Öä")
    MsgBox("¸øÄã 1 c¸i ±¼À×Öä,±ØĞëÈËÒÑ¾­Õ¾ÔÚÌìÉÏµØÍ¼, ²ÅÄÜÊ¹ÓÃÅ¶", "Trap", "no")
end
function button5()
    local list = {}
    for i = 1, getn(t_maplist) do
        list[i] = t_maplist[i].mapname .. "/TrapSel"
    end
    Say("<c=g>ÄÇÃ´, ¿´¿´ÄãÈ¥ÄÄÀï°É, ÕâÀï¶¼ÊÇDi Ngo¹i Phï²»ÄÜµ½´ïµÄµØ·½.ÌìÉÏ´«ËÍ, ¸±±¾, §Êu Tr­êng, Õ½³¡¶¼ÊÇ·ÇÕ½Õù×´Ì¬<c>", getn(list), list)
end

function TrapSel(idx)
    no()
    idx = idx + 1
    local result = NewWorld(t_maplist[idx].mapid[1], t_maplist[idx].mapid[2], t_maplist[idx].mapid[3])

    if (result == 0) then
        Msg2Player("[" .. t_maplist[idx].mapname .. "][´«ËÍÊ§°Ü]")
        return 0
    elseif (t_maplist[idx].ntype <= 2) then
        SetFightState(1)
        Msg2Player("Ë²ÒÆ³É¹¦, Õ½¶·×´Ì¬")
    elseif (t_maplist[idx].ntype == 4) then
        SetFightState(0)
        PolyMorph(1889, 1, 2, 23, 3600, 1, 1)
        Msg2Player("Ë²ÒÆ³É¹¦, ·ÇÕ½¶·×´Ì¬")
    else
        SetFightState(0)
        Msg2Player("Ë²ÒÆ³É¹¦, ·ÇÕ½¶·×´Ì¬")
    end
    WriteLog("[Ğ¡Ê¯Í·][Ò»¼ü´«ËÍ]" .. t_maplist[idx].mapname)
end

G_BuffList = {
    { name = "M«n bµi Thµnh thŞ", buffid = 192, unit = 72 },
    { name = "ÁÙÏÉÂ¶»òË«±¶¼¼ÄÜ", buffid = 330, unit = 3 },
    { name = "ThÇn Tµi", buffid = 228, unit = 6 },
    { name = "Thiªn H­¬ng", buffid = 229, unit = 6 },
    { name = "Bïa khai kho¸ng", buffid = 251, unit = 72 },
    { name = "La H¸n hiÖu gi¸c", buffid = 233, unit = 144 },
    { name = "Ì«ËêË«±¶¾­Ñé", buffid = 175, unit = 3 },
    { name = "Ì«Ëê1.5±¶¾­Ñé", buffid = 176, unit = 3 },
    { name = "Dao Tiªn t¸n", buffid = 374, unit = 1 },
    { name = "Ngäc Thanh ThÇn Tiªn T¸n", buffid = 375, unit = 1 },
    { name = "Dao Tiªn t¸n (Nh­ ı)", buffid = 385, unit = 2 },
    { name = "Ngäc Thanh ThÇn Tiªn T¸n (Nh­ ı)", buffid = 386, unit = 2 },
    { name = "ThÇn Tµi (Nh­ ı)", buffid = 387, unit = 6 },
    { name = "Thiªn H­¬ng (Nh­ ı)", buffid = 388, unit = 6 },
    { name = "La H¸n HiÖu Gi¸c (Nh­ ı)", buffid = 390, unit = 144 },
    { name = "Bïa khai kho¸ng (Nh­ ı)", buffid = 393, unit = 72 },
    { name = "M«n bµi thµnh thŞ (Nh­ ı)", buffid = 394, unit = 72 },
    { name = "ÈË¼äÖ÷ÌâÈÕË«±¶", buffid = 1480, unit = 144 },
    { name = "Kim bµi ®Êu gi¸", buffid = 441, unit = 144 },
    { name = "Ng©n bµi ®Êu gi¸", buffid = 442, unit = 144 },
    { name = "ThÇn CÈu phï", buffid = 133, unit = 3 },
    { name = "TiÓu Thiªn H­¬ng Tôc MÖnh Lé", buffid = 334, unit = 12 },
    { name = "Sñi c¶o Toµn Gia Phóc", buffid = 1307, unit = 1 },
    { name = "Sñi c¶o thŞt bß", buffid = 242, unit = 1 },
    { name = "Sñi c¶o hµnh thŞt", buffid = 243, unit = 1 },
    { name = "Sñi c¶o thŞt heo", buffid = 244, unit = 1 },
    { name = "Sñi c¶o tái thŞt", buffid = 245, unit = 1 },
    { name = "Sñi c¶o h¹nh nh©n", buffid = 246, unit = 1 },
    { name = "Sñi c¶o t«m", buffid = 247, unit = 1 },
    { name = "Sñi c¶o b¾p th¶o", buffid = 248, unit = 1 },
    { name = "Sñi c¶o thŞt dª", buffid = 249, unit = 1 },
    { name = "Chiªu bµi *TiÒn tµi nh­ n­íc", buffid = 151, unit = 144 },
    { name = "Ho¸ Th©n To¶", buffid = 1573, unit = 72 },
}
function add_buff()
    no()
    local list = {}
    list[1] = "×Ô¶¨Òåbuff/buff_remove"
    for i = 1, getn(G_BuffList) do
        list[i + 1] = G_BuffList[i].name .. "/BuffListV"
    end
    list[getn(list) + 1] = "Xo¸ ®¹o cô/clear"

    Say("ÇëÑ¡ÔñÒª¼ÓµÄbuff×´Ì¬", getn(list), list)
end

function BuffListV(idx)
    no()
    if (idx > getn(G_BuffList)) or (idx < 1) then
        add_buff()
        ScrollMessage("´íÎóÖØĞÂÑ¡")
        return 0
    end
    SetTask(140, idx)
    InputDialog("ÇëÊäÈëÄãÒª¼Ó" .. G_BuffList[idx].name .. "µÄÊ±¼ä\nµ¥Î»Îª: Ãë", 2, "X¸c nhËn/buff_yes", "Trë l¹i/add_buff")
end

function buff_yes(nID)
    no()

    local idx = GetTask(140)

    AddIBBuff(G_BuffList[idx].buffid, nID)
    Msg2Player("[Ğ¡Ê¯Í·][¼Ó" .. G_BuffList[idx].name .. "×´Ì¬:" .. nID .. "Ô­: " .. GetIBBuffLeftTimes(G_BuffList[idx].buffid))
    Talk(1, "add_buff", "³É¹¦¼Ó" .. G_BuffList[idx].name .. "Tr¹ng th¸i" .. nID .. "s")
end

function buff_remove()
    local tasks = {
        { "¼Óbuff", "buff_RMold"; show = 1 },
        { "ÒÆ³ıbuff", "buff_RMnew"; show = 1 },
        { "Ò»¼ü¸üÃû", "buff_gengming"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "add_buff"; show = 1 },
    }
    SayTask("×Ô¼ºĞ´IDºÅ, ÃëÎªµ¥Î», ÒÆ»êÊÇÈ¥628, ¼Ó629,  §æi tªn nh©n vËtÊÇ680, ·ûÓ¡Ê¦ÄÇÀïÈ·ÈÏ", tasks)
end

function buff_RMold()
    InputDialog("´ËÊÇ¼Óbuff, ²Î¿¼ibitem±í, ÇëÊäÈëÄãÒª¼ÓĞòºÅ", 2, "X¸c nhËn/buff_new_idx", "Trë l¹i/add_buff")
end

function buff_new_idx(nIndex)
    SetTask(140, nIndex)
    InputDialog("IBbuff: ÄãÒª¼ÓĞÂ°æĞòºÅÊÇ: " .. nIndex .. ", ÇëÊäÈëÄãÒª¼ÓµÄÊ±¼ä\nµ¥Î»Îª: ¡°Ãë¡±", 2, "X¸c nhËn/buff_new_yes", "Trë l¹i/buff_remove")
end

function buff_new_yes(nID)
    no()
    local nIndex = GetTask(140)

    Msg2Player("³É¹¦¼ÓĞòºÅ" .. nIndex .. ":" .. nID .. "Ãë.Ô­: " .. GetIBBuffLeftTimes(nIndex))
    AddIBBuff(nIndex, nID)
    Talk(1, "buff_remove", "³É¹¦¼ÓĞòºÅ" .. nIndex .. ":" .. nID .. "s")
end

function buff_RMnew()
    InputDialog("´ËÊÇ[ÒÆ³ıbuff], ÇëÊäÈëÄãÒªÉ¾µôµÄĞòºÅ", 2, "X¸c nhËn/buff_new_remove", "Trë l¹i/buff_remove")
end

function buff_new_remove(nIndex)
    no()
    if (HaveIBBuff(nIndex) > 0) then
        local n = GetIBBuffLeftTimes(nIndex)
        RemoveIBBuff(nIndex)

        Msg2Player("³É¹¦É¾µôĞòºÅÎª" .. nIndex .. "µÄ×´Ì¬.Ô­: " .. n)
        Talk(1, "buff_remove", "³É¹¦É¾µôĞòºÅÎª" .. nIndex .. "µÄ×´Ì¬.Ô­: " .. n)
    else
        Msg2Player("É¾µôĞòºÅ" .. nIndex .. "µÄ×´Ì¬[ThÊt b¹i].")
        Talk(1, "buff_remove", "É¾µôĞòºÅ" .. nIndex .. "µÄ×´Ì¬<c=r>[ThÊt b¹i]<c>")
    end
end

function buff_gengming()
    SetTaskByte(1457, 1, 1)
    SetTaskByte(1457, 2, 1)
    RemoveIBBuff(680)
    AddIBBuff(680, 10)

    local currentDay = math.floor(LocalSystemTime() / 86400)
    SetTaskWord(1457, 2, currentDay)

    GetChangeRoleName()
    Msg2Player("ÕÒ·ûÓ¡Ê¦È·ÈÏÒ»ÏÂ¾ÍĞĞÁË, 10Ãëºó")
    Talk(1, "no", "ÕÒ·ûÓ¡Ê¦È·ÈÏÒ»ÏÂ¾ÍĞĞÁË, 10Ãëºó")
end

function renwuMain()
    local tasks = {
        { "È¡ÏûÈÎÎñÌáÊ¾", "taskNote_del"; show = 1 },
        { "¸ü¸ÄÈÎÎñÌáÊ¾", "change_taskNote"; show = 1 },
        { "²éÑ¯ÈÎÎñ±äÁ¿", "taskNote_seeTask"; show = 1 },
        { "¸ü¸ÄÈÎÎñ±äÁ¿", "taskNote_setTask"; show = 1 },
    }
    SayTask("[Ö÷ÏßÎÊÌâ]·²ÊÇÈÎÎñÀïÃæĞ´×Å**Ö÷ÏßµÄ½øÕâÀï, [È¡ÏûÈÎÎñÌáÊ¾](ÄÑ¶È3ĞÇ)ÊÇÖ»É¾³ıF11ÀïÃæµÄÌáÊ¾, ÈÎÎñ±äÁ¿²»»á¸Ä±ä, Èç¹ûĞèÒªÉ¾³ıÈÎÎñµÀ¾ß, ÇëÓÃÈÎÎñÉ¾³ı¹¦ÄÜ, [¸ü¸ÄÈÎÎñÌáÊ¾](ÄÑ¶È5ĞÇ)¿ÉÒÔÈÃÄã²éÑ¯±¾ÕËºÅµ±Ç°ÈÎÎñ±äÁ¿Öµ, ÉèÖÃÈÎÎñ±¦µätasknoteÏÔÊ¾Öµ, ÏÖÔÚÈÃÎÒÃÇ¿´¿´ÄãÏë¸ÉĞ©Ê²Ã´°É: ", tasks)
end

function change_taskNote()
    local tasks = {
        { "ÉèÖÃÈÎÎñÌáÊ¾", "taskNote_set"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "renwuMain"; show = 1 },
    }
    SayTask("[ÉèÖÃÈÎÎñÌáÊ¾]¸ù¾İÈÎÎñ±äÁ¿Öµ, Éè¶¨F11ÌáÊ¾²½Öè, [²éÑ¯ÈÎÎñ±äÁ¿]²éÑ¯ÄãÊäÈëµÄÈÎÎñ±äÁ¿ĞòºÅËù¶ÔÓ¦µÄÖµ", tasks)
end

function taskNote_del()
    no()
    MsgBox("ÇëÏÈÈ¥<c=y>T©y Kú-->ÊÕ²Ø¼Ò<c>¿´ÓĞÃ»ÓĞÄãÒªÈ¡ÏûµÄÈÎÎñÌáÊ¾Ãû³Æ, Ã»ÓĞÔÚÕÒÑĞ·¢È·ÈÏidx, ²»½¨Òé×Ô¼º²Ù×÷", "taskNote_del1", "no")
end
function taskNote_del1()
    InputDialog("ÇëÊäÈëÄãÒªÈ¡ÏûµÄF11µÄTaskNoteĞòºÅ", 2, "X¸c nhËn/taskNoteDel_yes", "Trë l¹i/renwuMain")
end

function taskNoteDel_yes(nID)
    no()
    TaskNote(nID, -1)
    Msg2Player("TaskNote" .. nID .. "ÒÑ¾­È¡Ïû")
    WriteLog("[Ğ¡Ê¯Í·][È¡Ïû]TaskNote: " .. nID)
end

function taskNote_set()
    InputDialog("ÇëÊäÈëÄãÒªÉèÖÃµÄF11µÄTaskNoteĞòºÅ", 2, "X¸c nhËn/taskNoteSet_yes", "Trë l¹i/change_taskNote")
end

function taskNoteSet_yes(nID)
    no()
    SetTask(140, nID)
    InputDialog("ÇëÊäÈëTaskNote" .. nID .. "µÄÖµ", 2, "X¸c nhËn/taskNoteSet_yes1", "Trë l¹i/change_taskNote")
end

function taskNoteSet_yes1(Value)
    no()
    local nID = GetTask(140)
    TaskNote(nID, Value)
    Msg2Player("TaskNote" .. nID .. "ÒÑ¾­¸³Öµ: " .. Value)
    WriteLog("[Ğ¡Ê¯Í·][Ôö¼Ó]TaskNote: " .. nID .. "/¸³Öµ" .. Value)
end

function taskNote_seeTask()
    InputDialog("ÇëÊäÈëÄãÒª²éÑ¯µÄTaskµÄĞòºÅ", 2, "X¸c nhËn/taskNote_seeTask_yes", "Trë l¹i/renwuMain")
end

function taskNote_seeTask_yes(nID)
    no()
    local Value = GetTask(nID)

    Msg2Player("Task" .. nID .. "µÄÖµÎª: " .. Value)
    Msg2Player("Task" .. nID .. "µÄÖµword1Îª: " .. GetWord(Value, 1))
    Msg2Player("Task" .. nID .. "µÄÖµword2Îª: " .. GetWord(Value, 2))
    MsgBox("Task" .. nID .. "µÄÖµÎª: " .. Value .. "\n1byte: " .. GetByte(Value, 1) .. "\n2byte: " .. GetByte(Value, 2) .. "\n3byte: " .. GetByte(Value, 3) .. "\n4byte: " .. GetByte(Value, 4), "change_taskNote")
end

function mainLine()
    no()

    local tasks = {
        { "³£¼ûÖ÷Ïß", "mainLinelist"; show = 1 },
        { "×Ô¼ºÉèÖÃÖ÷Ïß", "mainLineset"; show = 1 },
        { "Áé³è×Ê¸ñÈ¡Ïû", "main_petclear"; show = 1 },
        { "Áé³èÖØĞÂÑ¡", "main_petsel"; show = 1 },
        { "Éè¶¨¼¼ÄÜµÈ¼¶", "main_skill"; show = 1 },
    }

    if (GetLevel() < 25) and (GetNewBirthTimes() < 1) then
        tasks[1].show = 0
    end
    SayTask("[³£¼ûÖ÷Ïß]»á¼ÇÂ¼¼¸¸ö³£¼ûÌìÉÏÖ÷ÏßÈÎÎñÃû³Æ, µã½øÈ¥×Ô¶¯ÉèÖÃ³É<c=y>¿É½ÓÈÎÎñ×´Ì¬<c>, [×Ô¼ºÉèÖÃÖ÷Ïß](ÄÑ¶È5ĞÇ)ÒÀ¾İ±¦µätasknoteÏÔÊ¾Öµ, ×Ô¼ºÉèÖÃÈÎÎñ±äÁ¿Öµ, \nÁé³è×Ê¸ñÊÇÔÚºó»ÚÒÑµÇ¼ÇµÄÕËºÅ, ÔÚ»î¶¯½áÊøÇ°½»Thuèc hèi hËn½áÊøÇ°¿ÉÒÔÈ¡Ïû, ¼¼ÄÜ¿ÉÒÔÉèÖÃÖ¸¶¨µÈ¼¶", tasks)
end

G_mainList = {
    { name = "CÊp 15 ²»ÆÚ¶øÓö", task = 130, id = 1, key = "½ÓÊÜ½±Àø, nhËn ®­îc Tiªn Ma GiíiÎäÆ÷Ò»°Ñ, ÏÉÄ§µÈ¼¶ cÊp 15 ºóÕÒµ½<c=g>²»ÖÜÌì¹Ø<c>µÄ<c=g>ĞŞĞĞÊ¦<c>" },
    { name = "CÊp 30 Á«»¨ÉñµÆ", task = 140, id = 7, key = "ÓÃÉßÁÛÖÎÓú§¸t Kû, nhËn ®­îc §¸t Kû¸øÓèµÄ<c=g>×øÆï<c>Ò»Æ¥¼°Tiªn Ma GiíiĞŞÎª<c=g>12 v¹n<c>µã.ÏÉÄ§µÈ¼¶30¼¶ºóÔÙÓë§¸t Kû¶Ô»°." },
    { name = "CÊp 45 Ë®»ğÖ®Õù", task = 150, id = 14, key = "ÒÑÍê³É[Á«»¨ÉñµÆ], <c=g>CÊp 45<c>ÒÔºó¿ÉÒÔÇ°Íù<c=g>²»ÖÜÉ½<c>ÕÒÑ°<c=g>ĞŞĞĞÊ¦<c>´òÌı·âÉñ°ñµÄÏûÏ¢." },
    { name = "CÊp 55 ÂŞÅÌ·¨Õó", task = 160, id = 26, key = "³É¹¦»ñµÃ·âÉñ°ñµÄÏûÏ¢, <c=g>CÊp 55<c>ÒÔºó¿ÉÒÔÇ°Íù<c=g>Óü·¨É½<c>ÕÒÑ°<c=g>ĞŞĞĞÊ¦<c>´òÌı·âÉñ°ñµÄÏûÏ¢." },
    { name = "CÊp 65 ²»ÆÚ¶øÓö", task = 160, id = 50, key = "<c=g>CÊp 65<c>ÒÔºó¿ÉÒÔÇ°Íù<c=g>ĞŞĞĞÊ¦<c>´¦´òÌ½ÏûÏ¢" },
    { name = "CÊp 75 ÎóÈëÆçÍ¾", task = 165, id = 46, key = "°İ±ğĞŞĞĞÊ¦, ÔÙ´ÎÌ¤ÉÏÑ°·Ã·âÉñ°ñÖ®Â·!75¼¶Ê±, ¿ÉÑ°·ÃÚæÈªÊ¥µØĞŞĞĞÊ¦." },
}
function mainLinelist()
    no()
    SetTask(140, 0)
    local list = {}
    list[1] = "·µ»ØÉÏÒ»¼¶/mainLine"
    for i = 1, getn(G_mainList) do
        list[i + 1] = G_mainList[i].name .. "/mainLineV"
    end

    Say("ÇëÑ¡ÔñÄãÒª½ÓµÄÈÎÎñÃû³Æ, ", getn(list), list)
end

function mainLineV(idx)
    no()
    if (idx > getn(G_mainList)) or (idx < 1) then
        mainLinelist()
        ScrollMessage("´íÎóÖØĞÂÑ¡")
        return 0
    end
    SetTask(140, idx)
    local tasks = {
        { "È·¶¨ÉèÖÃ", "mainLineVyes"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "mainLinelist"; show = 1 },
    }

    SayTask("ÇëºËÊµÒ»ÏÂ, Íæ¼ÒF11ÉÏµÄÌáÊ¾ÊÇ²»ÊÇÕâ¸ö: \n<c=y>" .. G_mainList[idx].key .. "<c>", tasks)
end

function mainLineVyes()
    no()
    local idx = GetTask(140)
    if (idx > getn(G_mainList)) or (idx < 1) then
        mainLinelist()
        TopMessage("´íÎóÖØĞÂÑ¡")
        return 0
    end

    local n = G_mainList[idx]
    local pt = GetPlayerType()
    local num = n.task
    if (pt == 0) then
        SetTask(3, num)
    else
        SetTask(pt, num)
    end
    TaskNote(27 + pt, -1)
    TaskNote(86 + pt, n.id)
    if (idx == 5) then
        SetTaskByte(1465, 1, 9)
    end

    MsgBox("ĞŞ¸Ä³É¹¦!Ö÷ÏßÖµ±äÎª<c=g>" .. num, "clear")
    Msg2Player("ÉèÖÃÖ÷ÏßÈÎÎñ±äÁ¿ÖµÎª: " .. num)
    WriteLog("[Ğ¡Ê¯Í·][ÉèÖÃÖ÷ÏßÈÎÎñ][Ö°Òµ: " .. pt .. "][ÖµÎª: " .. num)
end

function mainLineset()
    no()
    InputDialog("ÇëÊäÈëÄãÒªÉèÖÃµÄÖµ[1,166]: ", 2, "ok/mainLineset_Yes", "Trë l¹i/mainLine")
end

function mainLineset_Yes(num)
    no()
    if (num < 1 or num > 166) then
        Msg2Player("Õâ¸öÊı×ÖÌ«¸¡¿äÁË, »¹ÊÇÊäÈë1-166Ö®¼äµÄÊı×Ö°É")
        mainLine()
        return
    end
    local pt = GetPlayerType()
    if (pt == 0) then
        SetTask(3, num)
    else
        SetTask(pt, num)
    end
    MsgBox("ĞŞ¸Ä³É¹¦!Ö÷ÏßÖµ±äÎª<c=g>" .. num, "clear")
    Msg2Player("ÉèÖÃÖ÷ÏßÈÎÎñ±äÁ¿ÖµÎª: " .. num)
    WriteLog("[Ğ¡Ê¯Í·][ÉèÖÃÖ÷ÏßÈÎÎñ][Ö°Òµ: " .. pt .. "][ÖµÎª: " .. num)
end

G_NormalList = {
    { name = "Tói Nh­ ı(Áé±¦)", item = { 8, 1454, 2, 0 }, key = "item", limit = 100 },
    { name = "¼ÓÊ¦Í½µã", item = 1, key = "prvalue", limit = 100 },
    { name = "Ê¦ÃÅÍşÍûµÀ¾ß", item = { 6, 1, 1651, 0 }, key = "item", limit = 100 },
    { name = "¼ÓÁé±¦(·ÖÎªµ¥Î»)", item = { 8, 1454, 2, 0 }, key = "coin", limit = 100000 },
    { name = "Ç©µ½(µÇÂ½Öµ)", item = 1, key = "sign", limit = 31 },
    { name = "Ç©µ½ (»îÔ¾Öµ)", item = 1, key = "active", limit = 31 },
    { name = "Ç©µ½ (Ïû·ÑÖµ)", item = 1, key = "expense", limit = 31 },
    { name = "¼Ó¸ºÖØ", item = 1, key = "Weight", limit = 5000 },
    { name = "¼Ó½ğÇ®", item = 1, key = "money", limit = 1000000000 },
    { name = "¼ÓÏû·Ñ»ı·Ö", item = 1, key = "costExt", limit = 100000000 },
    { name = "¼ÓÉùÍû", item = 1, key = "Credit", limit = 10000 },
    { name = "¼ÓÈÊÒåÖµ", item = 1, key = "Help", limit = 1000 },
    { name = "¼ÓcoinÖµ", item = 1, key = "coin1", limit = 100000 },
    { name = "¼ÓrecoinÖµ", item = 1, key = "recoin", limit = 1000000 },
    { name = "¼Ó³ä¿¨»ı·Ö", item = 1, key = "ExpP4", limit = 1000000 },
}

function sendNormal()
    no()
    SetTask(140, 0)
    local list = {}
    list[1] = "·µ»ØÉÏÒ»¼¶/main"
    for i = 1, getn(G_NormalList) do
        list[i + 1] = G_NormalList[i].name .. "/NormalListV"
    end

    Say("ÇëÑ¡ÔñÒª¼ÓµÄ, ÊÇµÀ¾ßµÄÈ«²¿¶¼ÊÇ°ó¶¨µÄ, ¼ÓµãÊıµÄ¶¼ÊÇÖ±½Ó¼Óµ½ÉíÉÏµÄ", getn(list), list)
end

function NormalListV(idx)
    no()
    if (idx > getn(G_NormalList)) or (idx < 1) then
        sendNormal()
        TopMessage("´íÎóÖØĞÂÑ¡")
        return 0
    end
    SetTask(140, idx)
    InputDialog("´ó²¿·Ö¶¼ÊÇÖ±½Ó¼ÓÔÚ½ÇÉ«ÉÏ, µÀ¾ßµÄÇë×¢Òâ±³°ü, ÇëÊäÈëĞèÒªµÄ¸öÊı, Ã¿´Î·¶Î§[0, " .. G_NormalList[idx].limit .. "]: ", 2, "ok/Normal_yes1", "Trë l¹i/sendNormal")
end

function Normal_yes1(nums)
    no()
    local idx = GetTask(140)
    if (idx > getn(G_NormalList)) or (idx < 1) then
        sendNormal()
        TopMessage("´íÎóÖØĞÂÑ¡")
        return 0
    end

    if (IsHaveSpaceForTreasure(2) <= 0) then
        InfoBox("Hµnh trang cña Anh hïng ®· ®Çy, cÇn chõa l¹i İt nhÊt 1 « trèng, h·y s¾p xÕp hµnh trang råi quay l¹i!")
        return
    end
    local n = G_NormalList[idx]

    if (nums > n.limit) then
        Talk(1, "sendNormal", "¸öÊıÓĞÎó, ÉÏÏŞÎª" .. n.limit)
        TopMessage("¸öÊıÓĞÎó, ÉÏÏŞÎª" .. n.limit)
        return 0
    end
    if (n.key == "item") then
        for i = 1, nums do
            AddNormalItemBind(n.item[1], n.item[2], n.item[3], n.item[4], 0, 0, 1)
        end
    elseif (n.key == "prvalue") then
        Msg2Player("Ê¦Í½µãÔ­À´ÓĞ: " .. GetMasterPRValue())
        AddMasterPRValue(nums)
    elseif (n.key == "coin") then
        AddBindCoin(nums)
    elseif (n.key == "sign") then
        SetSignValue(nums)
    elseif (n.key == "active") then
        SetActiveValue(nums)
    elseif (n.key == "expense") then
        SetExpenseValue(nums)
    elseif (n.key == "Weight") then
        AddWeightMax(nums)
    elseif (n.key == "money") then
        Earn(nums)
    elseif (n.key == "costExt") then
        AddCostExtPoint(nums)
    elseif (n.key == "Credit") then
        AddCredit(nums)
    elseif (n.key == "Help") then
        AddHelpScore(nums)
    elseif (n.key == "coin1") then
        AddCoin(nums)
        Msg2Player("ÓĞÁé±¦¿ÉÓÃ, ÏÂÏßÊ§Ğ§.")
    elseif (n.key == "recoin") then
        SetTask(1893, GetTask(1893) + nums)
        AddReCoin(nums)
    elseif (n.key == "ExpP4") then
        AddExtPoint(4, nums)
    end

    ScrollMessage("B¹n nhËn ®­îc " .. nums .. " <c=g>" .. n.name)
    Msg2Player("B¹n nhËn ®­îc " .. nums .. "." .. n.name)

    MsgBox("ÊÇ·ñ»¹Òª¼ÌĞø¼Ó¶«Î÷", "sendNormal", "clear")
end

function main_petclear()
    no()
    MsgBox("Ö»ÄÜÔÚÁé³èËéÆ¬ÊÕ¼¯ÆÚ¼ä²Ù×÷, °ÑÒÑ¾­µÈ¼¶µÄ±äÁ¿¸Ä³ÉÃ»µÇ¼Ç×´Ì¬, ¼ÇÂ¼log, ÊÕÈ¡Thuèc hèi hËn, ÊÇ²»ÊÇÒªÏÖÔÚ²Ù×÷", "main_petclearY", "no")
end

function main_petclearY()
    no()
    SetTaskBit(2196, 1, 0)
    WriteLog("[Ho¹t ®éng m¸y chñ míi][Ğ¡Ê¯Í·][Thuèc hèi hËn]ÁìÈ¡×Ê¸ñÈ¡Ïû")
    MsgBox("ÇëÊÕÈ¡Thuèc hèi hËn 6 c¸i, ×Ê¸ñ¿ÉÒÔÑéÖ¤Ò»ÏÂ", "clear_Item")
end

function main_skill()
    no()
    SetTask(140, 0)
    InputDialog("ÉèÖÃ¼¼ÄÜµÈ¼¶µÄ¹¦ÄÜ: ÏÈÊäÈë¼¼ÄÜ[ID]", 2, "ok/main_skillid", "Trë l¹i/no")
end

function main_skillid(id)
    no()
    if (id < 0) or (id >= 1500) then
        main_skill()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(140, id)
    InputDialog("ÉèÖÃ¼¼ÄÜµÈ¼¶µÄ¹¦ÄÜ: ¼¼ÄÜ[ID]Îª" .. id .. ", ÇëÊäÈëÒªÉèÖÃµÄµÈ¼¶[lvl]", 2, "ok/main_skillLvl", "Trë l¹i/no")
end

function main_skillLvl(lvl)
    no()
    local id = GetTask(140)
    if (lvl < 0) or (lvl >= 17) or (id < 0) then
        main_skill()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end

    SetSkillLevel(id, lvl)
    Msg2Player("[Ğ¡Ê¯Í·][ÉèÖÃ¼¼ÄÜ][ID]Îª" .. id .. "CÊp" .. lvl)
    WriteLog("[Ğ¡Ê¯Í·][ÉèÖÃ¼¼ÄÜ][ID]Îª" .. id .. "CÊp" .. lvl)
    MsgBox("¼¼ÄÜÒÑ¾­ÉèºÃ, ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item")
end

G_petName = {
    [1] = { Name = "Hå Hû MŞ", Id1 = 1339, Id2 = 1348, useTask = { 2188, 1, 2188, 10 }, },
    [2] = { Name = "Na Tra", Id1 = 1359, Id2 = 1368, useTask = { 2188, 11, 2188, 20 }, },
    [3] = { Name = "L«i ChÊn Tö", Id1 = 1426, Id2 = 1435, useTask = { 2188, 21, 2188, 30 }, },
    [4] = { Name = "Th¹ch C¬ N­¬ng N­¬ng", Id1 = 1448, Id2 = 1457, useTask = { 2188, 31, 2189, 9 }, },
    [5] = { Name = "Th¸i Êt Ch©n Nh©n", Id1 = 1465, Id2 = 1474, useTask = { 2189, 10, 2189, 19 }, },
    [6] = { Name = "§¾c Kû", Id1 = 1478, Id2 = 1487, useTask = { 2189, 20, 2189, 29 }, },
    [7] = { Name = "Th©n C«ng B¸o", Id1 = 1488, Id2 = 1497, useTask = { 2189, 30, 2190, 8 }, },
    [8] = { Name = "Hoµng Phi Hæ", Id1 = 1498, Id2 = 1507, useTask = { 2190, 9, 2190, 18 }, },
    [9] = { Name = "H¹o Thiªn KhuyÓn", Id1 = 1599, Id2 = 1608, useTask = { 2190, 19, 2190, 28 }, },
    [10] = { Name = "D­¬ng TiÔn", Id1 = 1609, Id2 = 1618, useTask = { 2190, 29, 2212, 7 }, },
    [11] = { Name = "Kh­¬ng Tö Nha", Id1 = 1619, Id2 = 1628, useTask = { 2212, 8, 2212, 17 }, },
    [12] = { Name = "Lı TŞnh", Id1 = 1629, Id2 = 1638, useTask = { 2212, 18, 2212, 27 }, },
    [13] = { Name = "Phi Th¨ng-Hå HØ MŞ", Id1 = 1675, Id2 = 1684, useTask = { 2212, 28, 2233, 6 }, },
    [14] = { Name = "Phi Th¨ng-Na Tra", Id1 = 1687, Id2 = 1696, useTask = { 2233, 7, 2233, 16 }, },
    [15] = { Name = "Phi Th¨ng-L«i ChÊn Tö", Id1 = 1724, Id2 = 1733, useTask = { 2233, 17, 2233, 26 }, },
    [16] = { Name = "Phi Th¨ng-Th¹ch C¬", Id1 = 1747, Id2 = 1756, useTask = { 2233, 27, 2213, 5 }, },
    [17] = { Name = "Phi Th¨ng-Th¸i Êt", Id1 = 1758, Id2 = 1767, useTask = { 2213, 6, 2213, 15 }, },
    [18] = { Name = "Phi Th¨ng-§¸t Kû", Id1 = 1776, Id2 = 1785, useTask = { 2213, 16, 2213, 25 }, },
    [19] = { Name = "Phi Th¨ng-Th©n C«ng B¸o", Id1 = 1789, Id2 = 1798, useTask = { 2213, 26, 2214, 4 }, },
    [20] = { Name = "Phi Th¨ng-Hoµng Phi Hæ", Id1 = 1811, Id2 = 1820, useTask = { 2214, 5, 2214, 14 }, },
    [21] = { Name = "Phi Th¨ng-Hao Thiªn KhuyÓn", Id1 = 1822, Id2 = 1831, useTask = { 2214, 15, 2214, 24 }, },
    [22] = { Name = "Phi Th¨ng-D­¬ng TiÔn", Id1 = 1836, Id2 = 1845, useTask = { 2214, 25, 2215, 3 }, },
    [23] = { Name = "Phi Th¨ng-Kh­¬ng Tö Nha", Id1 = 1848, Id2 = 1857, useTask = { 2282, 1, 2282, 10 }, },
    [24] = { Name = "Phi Th¨ng-Lı TŞnh", Id1 = 1874, Id2 = 1883, useTask = { 2282, 11, 2282, 20 }, },

}
PetRoleTask = 2109
function main_petsel()
    no()
    SetTask(140, 0)
    InputDialog("[§å phæ Tiªn Sñng]Ñ¡´íÁé³èºó»ÚµÄ¹¦ÄÜ: ÏÈÊäÈë¼¼ÄÜĞòºÅ, ÊÇµÚ¼¸¸öÁé³è: ¡¾1," .. table.getn(G_petName) .. "]", 2, "ok/main_petselidx", "Trë l¹i/no")
end

function main_petselidx(idx)
    no()
    if (idx <= 0) or (idx > table.getn(G_petName)) then
        main_petsel()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(140, idx)
    local tasks = {
        { "È¡Ïû´ËÁé³è", "main_petSelClear"; show = 1 },
        { "¼Ó´ËÁé³è", "main_petSelYes"; show = 1 },
        { "Ìø×ªÉ¾µÀ¾ß´¦", "clear_Item"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "main_petsel"; show = 1 },
    }

    SayTask("ÇëºËÊµÒ»ÏÂ, ÊÇ²»ÊÇÕâ¸ö: \n<c=y>" .. G_petName[idx].Name .. "<c> Áé³è, [È¡Ïû]ÎªÈ¥µô´Ë×Ê¸ñ.È¡ÏûµÄÍ¬Ê±»á¼Ó§å phæ Tiªn Sñng vµ Tinh Hoa Tiªn Sñng, ¿ÉÒÔÖØĞÂ°ïÍæ¼ÒµãÑ¡ĞÂµÄÁé³è.", tasks)
end

function main_petSelClear()
    no()
    local idx = GetTask(140)
    if (idx <= 0) or (idx > table.getn(G_petName)) then
        main_petsel()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end

    SetTaskBit(PetRoleTask, idx, 0)
    for i = G_petName[idx].Id1, G_petName[idx].Id2 do
        ClearItem(6, 1, i, 1)
        ClearItem(6, 1, i, 0)
    end

    local temp = G_petName[idx].useTask
    if (temp[1] == temp[3]) then
        for i = temp[2], temp[4] do
            SetTaskBit(temp[1], i, 0)
        end
    else
        for i = temp[2], 31 do
            SetTaskBit(temp[1], i, 0)
        end

        for i = 1, temp[4] do
            SetTaskBit(temp[3], i, 0)
        end
    end

    WriteLog("[Ğ¡Ê¯Í·][§å phæ Tiªn SñngÑ¡´íÁé³è]idx" .. idx .. "Tõ chèi" .. G_petName[idx].Name)
    MsgBox("Áé³è<c=y>" .. G_petName[idx].Name .. "ÒÑ¾­ÊÕ»Ø, ²»ÒªÍüÁËÊÕ»ØÊ¯Í·,Xo¸ Thuèc hèi hËn, ¼ì²éHép Linh Sñng", "main_petsel")
end

function main_petSelYes()
    no()
    local idx = GetTask(140)
    if (idx <= 0) or (idx > table.getn(G_petName)) then
        main_petsel()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end

    SetTaskBit(PetRoleTask, idx, 1)
    AddNormalItemBind(6, 1, G_petName[idx].Id1, 1, 0, 0, 1)
    WriteLog("[Ğ¡Ê¯Í·][§å phæ Tiªn SñngÑ¡´íÁé³è]idx" .. idx .. "¼Ó" .. G_petName[idx].Name)
    MsgBox("Áé³è<c=y>" .. G_petName[idx].Name .. "ÒÑ¾­¼ÓÉÏ, ²»ÒªÍüÁËÊÕ»ØÊ¯Í·,É¾³ıµÀ¾ß, ¼ì²éHép Linh Sñng", "clear_Item")
end

function taskNote_setTask()

    SetTask(140, 0)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: ÏÈÊäÈëÈÎÎñtask[ID]", 2, "ok/taskNote_setTaskid", "Trë l¹i/no")
end

function taskNote_setTaskid(id)
    no()
    if (id <= 0) then
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(140, id)

    local tasks = {
        { "task", "taskNote_setTaskVal"; show = 1 },
        { "byte", "taskNote_setTaskByte"; show = 1 },
        { "word", "taskNote_setTaskword"; show = 1 },
        { "bit", "taskNote_setTaskbit"; show = 1 },
        { "·µ»ØÉÏÒ»¼¶", "taskNote_setTask"; show = 1 },
    }
    local str = "byteµÄÖµÎª"
    for i = 1, 4 do
        str = str .. GetTaskByte(id, i) .. "|"
    end
    str = str .. "WordµÄÖµÎª"
    for i = 1, 2 do
        str = str .. GetTaskWord(id, i) .. "|"
    end
    str = str .. "bitµÄÖµÎª"
    for i = 1, 32 do
        str = str .. GetTaskBit(id, i) .. "|"
    end

    Msg2Player("task[ID]" .. id .. "Ä¿Ç°" .. str)
    SayTask("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄÖµÎª" .. GetTask(id) .. ", ÇëÑ¡ÔñÒªÉèÖÃµÄ·½Ê½: ", tasks)
end

function taskNote_setTaskVal()
    local id = GetTask(140)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄÖµÎª" .. GetTask(id) .. ", ÇëÊäÈëÒªÉèÖÃÖµ", 2, "ok/taskNote_setTaskValY", "Trë l¹i/no")
end

function taskNote_setTaskValY(val)
    no()
    local id = GetTask(140)
    if (val >= 2 ^ 32) or (id <= 0) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    local old = GetTask(id)
    SetTask(id, val)

    Msg2Player("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Öµ" .. val .. "Ô­Öµ: " .. old)
    MsgBox("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Öµ" .. val .. "Ô­Öµ: " .. old .. ", ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item", "taskNote_setTask")
end

function taskNote_setTaskByte()
    local id = GetTask(140)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄÖµÎª" .. GetTask(id) .. ", ÇëÊäÈëÒªÉèÖÃbyteÎ»[1,4]", 2, "ok/taskNote_setTaskByte1", "Trë l¹i/no")
end

function taskNote_setTaskByte1(idx)
    no()
    local id = GetTask(140)
    if (idx > 4) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(142, idx)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄ[byte" .. idx .. "]Î»ÖµÎª" .. GetTaskByte(id, idx) .. ", ÇëÊäÈëÒªÉèÖÃÖµ", 2, "ok/taskNote_setTaskByteY", "Trë l¹i/no")
end

function taskNote_setTaskByteY(val)
    no()
    local id = GetTask(140)
    local idx = GetTask(142)
    if (val >= 2 ^ 8) or (idx > 4) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    local old = GetTaskByte(id, idx)
    SetTaskByte(id, idx, val)

    Msg2Player("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Byte" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old)
    MsgBox("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Byte" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old .. ", ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item", "taskNote_setTask")
end

function taskNote_setTaskword()
    local id = GetTask(140)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄÖµÎª" .. GetTask(id) .. ", ÇëÊäÈëÒªÉèÖÃwordÎ»[1,2]", 2, "ok/taskNote_setTaskword1", "Trë l¹i/no")
end

function taskNote_setTaskword1(idx)
    no()
    local id = GetTask(140)
    if (idx > 2) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(142, idx)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄ[word" .. idx .. "]Î»ÖµÎª" .. GetTaskWord(id, idx) .. ", ÇëÊäÈëÒªÉèÖÃÖµ", 2, "ok/taskNote_setTaskwordY", "Trë l¹i/no")
end

function taskNote_setTaskwordY(val)
    no()
    local id = GetTask(140)
    local idx = GetTask(142)
    if (val >= 2 ^ 8) or (idx > 2) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    local old = GetTaskWord(id, idx)
    SetTaskWord(id, idx, val)

    Msg2Player("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Word" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old)
    MsgBox("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Word" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old .. ", ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item", "taskNote_setTask")
end

function taskNote_setTaskbit()
    local id = GetTask(140)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄÖµÎª" .. GetTask(id) .. ", ÇëÊäÈëÒªÉèÖÃbitÎ»[1,4]", 2, "ok/taskNote_setTaskbit1", "Trë l¹i/no")
end

function taskNote_setTaskbit1(idx)
    no()
    local id = GetTask(140)
    if (idx > 31) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    SetTask(142, idx)
    InputDialog("ÉèÖÃÈÎÎñ±äÁ¿µÄ¹¦ÄÜ: task[ID]" .. id .. "Ä¿Ç°µÄ[Bit" .. idx .. "]Î»ÖµÎª" .. GetTaskBit(id, idx) .. ", ÇëÊäÈëÒªÉèÖÃÖµ", 2, "ok/taskNote_setTaskbitY", "Trë l¹i/no")
end

function taskNote_setTaskbitY(val)
    no()
    local id = GetTask(140)
    local idx = GetTask(142)
    if (val >= 2 ^ 8) or (idx > 31) then
        taskNote_setTask()
        TopMessage("´íÎóÖØĞÂÊä")
        return 0
    end
    local old = GetTaskBit(id, idx)
    SetTaskBit(id, idx, val)

    Msg2Player("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Bit" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old)
    MsgBox("ÉèÖÃÈÎÎñ±äÁ¿][ID]Îª" .. id .. "Bit" .. idx .. "Öµ" .. val .. "Ô­Öµ: " .. old .. ", ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item", "taskNote_setTask")
end

function Item_UnTitle()
    no()
    InputDialog("ÄãÒªÊÕ»Ø danh hiÖu: ÏÈÊäÈë³ÆºÅ[ID]", 2, "ok/main_UnTitle", "Trë l¹i/no")
end

function main_UnTitle(id)
    no()
    UnActiveTitleQualify(id)
    Msg2Player("[Ğ¡Ê¯Í·][ÊÕ»Ø³ÆºÅ][ID]Îª" .. id)
    WriteLog("[Ğ¡Ê¯Í·][ÊÕ»Ø³ÆºÅ][ID]Îª" .. id)
    MsgBox("ÊÕ»Ø³ÆºÅÒÑ¾­ÉèºÃ, ²»ÒªÍüÁËÊÕ»ØÊ¯Í·", "clear_Item")
end

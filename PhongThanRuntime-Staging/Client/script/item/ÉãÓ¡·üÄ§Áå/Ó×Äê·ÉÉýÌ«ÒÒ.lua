require("ÊôĞÔÁé³è.luax")
require("newserver.luax")
CardName = "Ó×ÄêPhi Th¨ng-Th¸i Êt"
Item_Id = { 6, 1, 1768, 1 }
petType = 135
wenzi = {
    [1] = "ÔÚÏÂPhi Th¨ng-Th¸i Êt, Èç½ñÓëÓ¢ĞÛÏà¾Û, ÎÒ½«ÎªÄúµÄPhong ThÇn Chi LéÖúÁ¦.\nÄú¿ÉÔÚÎÒÕâÀï²ÎÓë<c=r>[Quèc VËn Th¹ch HÇu]<c>µÄ»î¶¯, »áÓĞ·áºñµÄ½±ÀøÅ¶!\nÎÒ»¹´øÀ´ÁËÏ¡ÓĞµÄ<c=r>ÆÆ¾ü×°±¸<c>¸£Àû, Ó¢ĞÛ²»·ÁÏ¸Ï¸²é¿´.",
    [2] = "Ğ¡Th¸i Êt¿ÉÒÔ°ïÄú×âÁŞÆÆ¾ü×°±¸, ×âÁŞ1 ngµy ½öĞè 2 c¸i T­íng Qu©n LÖnh vµ À¶×°!\n´ËÍâ, Äú»¹¿ÉÒÔ¶Ò»»ÓÀ¾ÃµÄÆÆ¾ü×°±¸, ×âÁŞÄ³¸ö²¿Î»ËùÏûºÄµÄT­íng Qu©n LÖnhÔ½¶à, ¶Ò»»ÓÀ¾Ã×°±¸Ê±ËùĞèµÄT­íng Qu©n LÖnh¾ÍÔ½ÉÙ!\nÎÂÜ°ÌáÊ¾: ±¾Ïî¸£ÀûµÄ½ØÖ¹ÈÕÆÚÎª¿ª·ş30 ngµy ºó."
}

PoJun_ZiGe_1 = 2094

PoJun_ZiGe_2 = 2095

PoJun_ZiGe_3 = 2096

MonkeyTask = 2097

tJiaShi = {
    [1] = { MapName = "§å phæ:Ph¸ Qu©n-Tr¶m Long Kh«i", MapID = { 6, 1, 278, 0 }, ID = { 0, 7, 0, 9, 1, 0, 0, 1, 1001 }, BlueID = { 0, 7, 0, 9 } },
    [2] = { MapName = "§å phæ:Ph¸ Qu©n-Tr¶m Long Gi¸p", MapID = { 6, 1, 290, 0 }, ID = { 0, 2, 0, 9, 1, 0, 0, 1, 1401 }, BlueID = { 0, 2, 0, 9 } },
    [3] = { MapName = "§å phæ:Ph¸ Qu©n-Tr¶m Long phi phong", MapID = { 6, 1, 287, 0 }, ID = { 0, 9, 0, 9, 1, 0, 0, 1, 1301 }, BlueID = { 0, 9, 0, 9 } },
    [4] = { MapName = "§å phæ:Ph¸ Qu©n-Tr¶m Long Yªu §¸i", MapID = { 6, 1, 281, 0 }, ID = { 0, 6, 0, 9, 1, 0, 0, 1, 1101 }, BlueID = { 0, 6, 0, 9 } },
    [5] = { MapName = "§å phæ:Ph¸ Qu©n-Tr¶m Long ChiÕn Ngoa", MapID = { 6, 1, 284, 0 }, ID = { 0, 5, 0, 9, 0, 0, 0, 1, 1201 }, BlueID = { 0, 5, 0, 9 } },
}
tDaoShi = {
    [1] = { MapName = "§å phæ:Ph¸ Qu©n-Nguyªn Thñy Qu¸n", MapID = { 6, 1, 279, 0 }, ID = { 0, 7, 1, 9, 1, 0, 0, 1, 1002 }, BlueID = { 0, 7, 1, 9 } },
    [2] = { MapName = "§å phæ:Ph¸ Qu©n-Nguyªn Thñy §¹o Bµo", MapID = { 6, 1, 291, 0 }, ID = { 0, 2, 1, 9, 1, 0, 0, 1, 1402 }, BlueID = { 0, 2, 1, 9 } },
    [3] = { MapName = "§å phæ:Ph¸ Qu©n-Nguyªn Thñy lÖnh", MapID = { 6, 1, 288, 0 }, ID = { 0, 9, 1, 9, 1, 0, 0, 1, 1302 }, BlueID = { 0, 9, 1, 9 } },
    [4] = { MapName = "§å phæ:Ph¸ Qu©n-Nguyªn thñy C©n", MapID = { 6, 1, 282, 0 }, ID = { 0, 6, 1, 9, 1, 0, 0, 1, 1102 }, BlueID = { 0, 6, 1, 9 } },
    [5] = { MapName = "§å phæ:Ph¸ Qu©n-Nguyªn Thñy Lı", MapID = { 6, 1, 285, 0 }, ID = { 0, 5, 1, 9, 0, 0, 0, 1, 1202 }, BlueID = { 0, 5, 1, 9 } },
}
tYiRen = {
    [1] = { MapName = "§å phæ:Ph¸ Qu©n-ThÇn ¦ng Trô", MapID = { 6, 1, 280, 0 }, ID = { 0, 7, 2, 9, 1, 0, 0, 1, 1003 }, BlueID = { 0, 7, 2, 9 } },
    [2] = { MapName = "§å phæ:Ph¸ Qu©n-ThÇn ¦ng Hé Gi¸p", MapID = { 6, 1, 292, 0 }, ID = { 0, 2, 2, 9, 1, 0, 0, 1, 1403 }, BlueID = { 0, 2, 2, 9 } },
    [3] = { MapName = "§å phæ:Ph¸ Qu©n-ThÇn ¦ng kÕt", MapID = { 6, 1, 289, 0 }, ID = { 0, 9, 2, 9, 1, 0, 0, 1, 1303 }, BlueID = { 0, 9, 2, 9 } },
    [4] = { MapName = "§å phæ:Ph¸ Qu©n-ThÇn ¦ng Yªu §¸i", MapID = { 6, 1, 283, 0 }, ID = { 0, 6, 2, 9, 1, 0, 0, 1, 1103 }, BlueID = { 0, 6, 2, 9 } },
    [5] = { MapName = "§å phæ:Ph¸ Qu©n-ThÇn ¦ng Ngoa", MapID = { 6, 1, 286, 0 }, ID = { 0, 5, 2, 9, 0, 0, 0, 1, 1203 }, BlueID = { 0, 5, 2, 9 } },
}
tItemTou = {
    [1] = { name = "Hçn §én", ID = { 3, 120, 0, 0 }, num = 1 },
    [2] = { name = "Thao ThiÕt", ID = { 3, 122, 0, 0 }, num = 1 },
    [3] = { name = "LiÖt DiÖm nh·n", ID = { 3, 118, 0, 0 }, num = 20 },
    [4] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0 }, num = 1 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, num = 70 },
}
tItemYao = {
    [1] = { name = "Hçn §én", ID = { 3, 120, 0, 0 }, num = 1 },
    [2] = { name = "Thao ThiÕt", ID = { 3, 122, 0, 0 }, num = 1 },
    [3] = { name = "LiÖt DiÖm nh·n", ID = { 3, 118, 0, 0 }, num = 20 },
    [4] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0 }, num = 1 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, num = 70 },
}
tItemXie = {
    [1] = { name = "§µo C¬", ID = { 3, 123, 0, 0 }, num = 1 },
    [2] = { name = "Khèn Kú", ID = { 3, 121, 0, 0 }, num = 1 },
    [3] = { name = "Phong B¹o nh·n", ID = { 3, 119, 0, 0 }, num = 20 },
    [4] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0 }, num = 1 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, num = 70 },
}
tItemPei = {
    [1] = { name = "§µo C¬", ID = { 3, 123, 0, 0 }, num = 1 },
    [2] = { name = "Khèn Kú", ID = { 3, 121, 0, 0 }, num = 1 },
    [3] = { name = "Phong B¹o nh·n", ID = { 3, 119, 0, 0 }, num = 20 },
    [4] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0 }, num = 1 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, num = 70 },
}
tItemXiong = {
    [1] = { name = "Thao ThiÕt", ID = { 3, 122, 0, 0 }, num = 1 },
    [2] = { name = "§µo C¬", ID = { 3, 123, 0, 0 }, num = 1 },
    [3] = { name = "Hoµn Quan nh·n", ID = { 3, 117, 0, 0 }, num = 20 },
    [4] = { name = "Thä S¬n Th¹ch", ID = { 3, 135, 0, 0 }, num = 1 },
    [5] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0 }, num = 70 },
}

g_Monkey_Task = {
    [1] = { name = "Ã¿ÈÕµÇÂ½ÓÎÏ·", ID = { 3, 1633, 0, 0 }, },
    [2] = { name = "×ª¶¯Ò»´ÎÌ«Ëê", ID = { 3, 1633, 0, 0 }, },
    [3] = { name = "»÷°Ü»ğĞ°Éñ  ", ID = { 3, 1633, 0, 0 }, },
    [4] = { name = "Íê³ÉB¸ch Niªn TrÇn Nh­ìng", ID = { 3, 1633, 0, 0 }, },
    [5] = { name = "Íê³ÉVËn L­¬ng", ID = { 3, 1633, 0, 0 }, },
    [6] = { name = "Íê³ÉThu thËp §¹o cô", ID = { 3, 1633, 0, 0 }, },
    [7] = { name = "Íê³ÉThiªn §×nh ThÇn Thô", ID = { 3, 1633, 0, 0 }, },
    [8] = { name = "DÑp lo¹n V¹n Tiªn TrËn  ", ID = { 3, 1633, 0, 0 }, },
    [9] = { name = "Íê³ÉÇÉ¶áÌì¹¤", ID = { 3, 1633, 0, 0 }, },
    [10] = { name = "¹ÍÓ¶±øÈÎÎñ  ", ID = { 3, 1633, 0, 0 }, },
}

function main(nLevel, t, nNpcIdx, nItemId)
    local menu = {
        { "BiÕn h×nh", "UsePet"; show = 1 },
        { "Quèc VËn Th¹ch HÇu", "TongMonkey"; show = 1 },
        { "ÆÆ¾ü×°±¸¸£Àû", "PoJun"; show = 1 },
    }
    if (NewServerEx.Pub_IsNewServer() == 0) then
        menu[2].show = 0
    end

    SayTask(wenzi[1], menu)
end

function UsePet()
    if (PetIsAdd() == 0) then
        Talk(1, "no", "Ch­a cã Linh Thó, kh«ng thÓ biÕn th©n. ")
        return
    elseif (PetIsSleep() == 1) then
        Talk(1, "no", "Linh Thó trong tr¹ng th¸i ngñ, kh«ng thÓ biÕn th©n.")
        return
    elseif (PetGetTime() < (1 * 60 * 60)) then
        Talk(1, "no", "Linh Thó ®ang trong tr¹ng th¸i Êp 24h, kh«ng thÓ biÕn th©n. ")
        return
    end
    Able_Pet.ChangePet()
    PetSetType(petType)
    no()
end

function PoJun()
    if (GetServerStartTime() < 7) then
        Talk(1, "no", "¿ª·ş7 ngµy ºóÆÆ¾ü×°±¸Íæ·¨½«»á¿ª·Å.")
        return
    end
    local menu = {
        { "×âÁŞ1 ngµy ÆÆ¾ü", "GetLimitPoJun"; show = 1 },
        { "»»È¡ÓÀ¾ÃÆÆ¾ü", "GetForeverPoJun"; show = 1 },
        { "Trë l¹i Trang tr­íc", "main"; show = 1 },
    }
    local y, m, d = GetYMD()
    if (GetServerStartTime() > 30) then
        menu[1].show = 0
    end
    SayTask(wenzi[2], menu)
end

function GetLimitPoJun()
    local menu = {
        { "×âÁŞÍ·¿ø", "TouKui"; show = 0 },
        { "×âÁŞĞØ¼×", "XiongJia"; show = 0 },
        { "×âÁŞÅå´÷", "PeiDai"; show = 0 },
        { "×âÁŞÑü´ø", "YaoDai"; show = 0 },
        { "×âÁŞĞ¬×Ó", "XieZi"; show = 0 },
        { "¼¤»îÍ·¿ø×Ê¸ñ", "TouKuiZiGe"; show = 1 },
        { "¼¤»îĞØ¼××Ê¸ñ", "XiongJiaZiGe"; show = 1 },
        { "¼¤»îÅå´÷×Ê¸ñ", "PeiDaiZiGe"; show = 1 },
        { "¼¤»îÑü´ø×Ê¸ñ", "YaoDaiZiGe"; show = 1 },
        { "¼¤»îĞ¬×Ó×Ê¸ñ", "XieZiZiGe"; show = 1 },
    }
    if (GetTaskBit(PoJun_ZiGe_1, 1) == 1) then
        menu[1].show = 1
        menu[6].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_1, 2) == 1) then
        menu[2].show = 1
        menu[7].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_1, 3) == 1) then
        menu[3].show = 1
        menu[8].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_1, 4) == 1) then
        menu[4].show = 1
        menu[9].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_1, 5) == 1) then
        menu[5].show = 1
        menu[10].show = 0
    end

    local str = "Äú¿ÉÒÔÔÚ´Ë×âÁŞµ½ĞÄÒÇµÄÆÆ¾ü×°±¸, ÏûºÄ 1 c¸i ¶ÔÓ¦Î»ÖÃµÄÆÆ¾üÍ¼Æ×¼´¿É¼¤»î¸Ã²¿Î»µÄÆÆ¾ü×âÁŞ¹¦ÄÜ.\n×âÁŞµ½µÄÃ¿¼ş×°±¸ÓĞĞ§ÆÚ½ØÖ¹µ½µ±Ìì24µã, ×âÁŞĞèÒªÏûºÄ±³°üÖĞ¡°T­íng Qu©n LÖnhx2¡± vµ ¡°Õ¶Áú/ÔªÊ¼/ÉñÓ¥ÏµÁĞÀ¶É«×°±¸¡±, Ã¿ÌìÏŞ×âÁŞÁ½´Î, ²¿Î»²»ÏŞ."
    SayTask(str, menu)
end
function TouKui()
    no()
    if (GetTaskBit(PoJun_ZiGe_1, 1) == 0) then
        TouKuiZiGe()
        return
    end
    MsgBox("¶Ò»»ĞèÒªÏûºÄ 2 c¸i T­íng Qu©n LÖnh vµ ¶ÔÓ¦²¿Î»À¶É«×°±¸, È·¶¨¶Ò»» sao?", "GetTouKui", "no")

end
function TouKuiZiGe()
    local tTable = CheckPlayerType()
    if (GetTaskBit(PoJun_ZiGe_1, 1) == 0) then
        MsgBox("ÊÇ·ñÏûºÄ±³°üÖĞµÄÒ»ÕÅ<c=r>" .. tTable[1].MapName .. "<c>, ¿ªÆôÍ·¿øµÄ×âÁŞ¼°»»È¡×Ê¸ñ?", "TouKuiZiGe_yes", "no")
    else
        Talk(1, "no", "ÄúÒÑ¾­¼¤»îÁË¶Ò»»Í·¿øµÄ×Ê¸ñ.")
    end
end
function TouKuiZiGe_yes()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(tTable[1].MapID[1], tTable[1].MapID[2], tTable[1].MapID[3], 1) > 0) then
        if (DelNormalItem(tTable[1].MapID[1], tTable[1].MapID[2], tTable[1].MapID[3], 1) > 0) then
            AddNormalItemBind(tTable[1].MapID[1], tTable[1].MapID[2], tTable[1].MapID[3], 0, 0, 0, 1)
        end
    end
    if (HaveNormalItem(tTable[1].MapID[1], tTable[1].MapID[2], tTable[1].MapID[3], tTable[1].MapID[4]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦²¿¼şµÄÆÆ¾üÍ¼Æ×, ²»ÄÜ¼¤»î¶Ò»»×Ê¸ñ.")
        return
    end
    if (DelNormalItem(tTable[1].MapID[1], tTable[1].MapID[2], tTable[1].MapID[3], tTable[1].MapID[4]) > 0) then
        SetTaskBit(PoJun_ZiGe_1, 1, 1)
        Talk(1, "no", "ÄúÒÑ¿ªÆôÆÆ¾üÍ·¿ø»»È¡×Ê¸ñ.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Í·¿ø][NhËn ®­îc¶Ò»»×Ê¸ñ]")
    else
        Talk(1, "no", "ThËt xin lçi, ÆÆ¾üÍ¼Æ×¿Û³ıÊ§°Ü.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Í·¿ø][Trõ ³ıÍ¼Æ×³ö´í, Î´»ñµÃ×Ê¸ñ]")
        return
    end
end
function GetTouKui()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(3, 100, 0, 0) < 2) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ×ã¹»µÄT­íng Qu©n LÖnh.")
        return
    end
    if (HaveItem2(tTable[1].BlueID[1], tTable[1].BlueID[2], tTable[1].BlueID[3], tTable[1].BlueID[4], 2, 0) < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦µÄÀ¶×°±¸.")
        return
    end
    local ishavetimes = Update()
    if (ishavetimes == 0) then
        return
    end
    for i = 1, 2 do
        DelNormalItem(3, 100, 0, 0)
    end
    DelItem2(tTable[1].BlueID[1], tTable[1].BlueID[2], tTable[1].BlueID[3], tTable[1].BlueID[4], 2)
    local n = AddNormalItem4(tTable[1].ID[1], tTable[1].ID[2], tTable[1].ID[3], tTable[1].ID[4], tTable[1].ID[5], tTable[1].ID[6], tTable[1].ID[7], tTable[1].ID[8], tTable[1].ID[9])
    SetItemBind(n, 1)
    local times = GetTaskByte(PoJun_ZiGe_1, 2)
    if (times < 50) then
        times = times + 1
    end
    SetTaskByte(PoJun_ZiGe_1, 2, times)
    Talk(1, "no", "³É¹¦×âÁŞÆÆ¾üÍ·¿ø, µ±Ç°ÄúÒÑ¾­×âÁŞÍ·¿ø<c=r>" .. times .. "<c>´Î.\n½ñÈÕ×âÁŞÆÆ¾ü¸÷²¿¼ş×Ü´ÎÊı<c=r>" .. GetTaskByte(PoJun_ZiGe_2, 3) .. "<c> lÇn.")
    WriteLog("[" .. CardName .. "][×âÁŞÍ·¿ø³É¹¦][µ±Ç°×âÁŞÍ·¿ø lÇn thø: " .. times .. "]")
end

function XiongJia()
    no()
    if (GetTaskBit(PoJun_ZiGe_1, 2) == 0) then
        XiongJiaZiGe()
        return
    end
    MsgBox("¶Ò»»ĞèÒªÏûºÄ 2 c¸i T­íng Qu©n LÖnh vµ ¶ÔÓ¦²¿Î»À¶É«×°±¸, È·¶¨¶Ò»» sao?", "GetXiongJia", "no")

end
function XiongJiaZiGe()
    local tTable = CheckPlayerType()
    if (GetTaskBit(PoJun_ZiGe_1, 2) == 0) then
        MsgBox("ÊÇ·ñÏûºÄ±³°üÖĞµÄÒ»ÕÅ<c=r>" .. tTable[2].MapName .. "<c>, ¿ªÆôĞØ¼×µÄ×âÁŞ¼°»»È¡×Ê¸ñ?", "XiongJiaZiGe_yes", "no")
    else
        Talk(1, "no", "ÄúÒÑ¾­¼¤»îÁË¶Ò»»ĞØ¼×µÄ×Ê¸ñ.")
    end
end
function XiongJiaZiGe_yes()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(tTable[2].MapID[1], tTable[2].MapID[2], tTable[2].MapID[3], 1) > 0) then
        if (DelNormalItem(tTable[2].MapID[1], tTable[2].MapID[2], tTable[2].MapID[3], 1) > 0) then
            AddNormalItemBind(tTable[2].MapID[1], tTable[2].MapID[2], tTable[2].MapID[3], 0, 0, 0, 1)
        end
    end
    if (HaveNormalItem(tTable[2].MapID[1], tTable[2].MapID[2], tTable[2].MapID[3], tTable[2].MapID[4]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦²¿¼şµÄÆÆ¾üÍ¼Æ×, ²»ÄÜ¼¤»î¶Ò»»×Ê¸ñ.")
        return
    end
    if (DelNormalItem(tTable[2].MapID[1], tTable[2].MapID[2], tTable[2].MapID[3], tTable[2].MapID[4]) > 0) then
        SetTaskBit(PoJun_ZiGe_1, 2, 1)
        Talk(1, "no", "ÄúÒÑ¿ªÆôÆÆ¾üĞØ¼×»»È¡×Ê¸ñ.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][ĞØ¼×][NhËn ®­îc¶Ò»»×Ê¸ñ]")
    else
        Talk(1, "no", "ThËt xin lçi, ÆÆ¾üÍ¼Æ×¿Û³ıÊ§°Ü.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][ĞØ¼×][Trõ ³ıÍ¼Æ×³ö´í, Î´»ñµÃ×Ê¸ñ]")
        return
    end
end
function GetXiongJia()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(3, 100, 0, 0) < 2) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ×ã¹»µÄT­íng Qu©n LÖnh.")
        return
    end
    if (HaveItem2(tTable[2].BlueID[1], tTable[2].BlueID[2], tTable[2].BlueID[3], tTable[2].BlueID[4], 2, 0) < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦µÄÀ¶×°±¸.")
        return
    end
    local ishavetimes = Update()
    if (ishavetimes == 0) then
        return
    end
    for i = 1, 2 do
        DelNormalItem(3, 100, 0, 0)
    end
    DelItem2(tTable[2].BlueID[1], tTable[2].BlueID[2], tTable[2].BlueID[3], tTable[2].BlueID[4], 2)
    local n = AddNormalItem4(tTable[2].ID[1], tTable[2].ID[2], tTable[2].ID[3], tTable[2].ID[4], tTable[2].ID[5], tTable[2].ID[6], tTable[2].ID[7], tTable[2].ID[8], tTable[2].ID[9])
    SetItemBind(n, 1)
    local times = GetTaskByte(PoJun_ZiGe_1, 3)
    if (times < 50) then
        times = times + 1
    end
    SetTaskByte(PoJun_ZiGe_1, 3, times)
    Talk(1, "no", "³É¹¦×âÁŞÆÆ¾üĞØ¼×, µ±Ç°ÄúÒÑ¾­×âÁŞĞØ¼×<c=r>" .. times .. "<c>´Î.\n½ñÈÕ×âÁŞÆÆ¾ü¸÷²¿¼ş×Ü´ÎÊı<c=r>" .. GetTaskByte(PoJun_ZiGe_2, 3) .. "<c> lÇn.")
    WriteLog("[" .. CardName .. "][×âÁŞĞØ¼×³É¹¦][µ±Ç°×âÁŞĞØ¼× lÇn thø: " .. times .. "]")
end

function PeiDai()
    no()
    if (GetTaskBit(PoJun_ZiGe_1, 3) == 0) then
        PeiDaiZiGe()
        return
    end
    MsgBox("¶Ò»»ĞèÒªÏûºÄ 2 c¸i T­íng Qu©n LÖnh vµ ¶ÔÓ¦²¿Î»À¶É«×°±¸, È·¶¨¶Ò»» sao?", "GetPeiDai", "no")

end
function PeiDaiZiGe()
    local tTable = CheckPlayerType()
    if (GetTaskBit(PoJun_ZiGe_1, 3) == 0) then
        MsgBox("ÊÇ·ñÏûºÄ±³°üÖĞµÄÒ»ÕÅ<c=r>" .. tTable[3].MapName .. "<c>, ¿ªÆôÅå´÷µÄ×âÁŞ¼°»»È¡×Ê¸ñ?", "PeiDaiZiGe_yes", "no")
    else
        Talk(1, "no", "ÄúÒÑ¾­¼¤»îÁË¶Ò»»Åå´÷µÄ×Ê¸ñ.")
    end
end
function PeiDaiZiGe_yes()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(tTable[3].MapID[1], tTable[3].MapID[2], tTable[3].MapID[3], 1) > 0) then
        if (DelNormalItem(tTable[3].MapID[1], tTable[3].MapID[2], tTable[3].MapID[3], 1) > 0) then
            AddNormalItemBind(tTable[3].MapID[1], tTable[3].MapID[2], tTable[3].MapID[3], 0, 0, 0, 1)
        end
    end
    if (HaveNormalItem(tTable[3].MapID[1], tTable[3].MapID[2], tTable[3].MapID[3], tTable[3].MapID[4]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦²¿¼şµÄÆÆ¾üÍ¼Æ×, ²»ÄÜ¼¤»î¶Ò»»×Ê¸ñ.")
        return
    end
    if (DelNormalItem(tTable[3].MapID[1], tTable[3].MapID[2], tTable[3].MapID[3], tTable[3].MapID[4]) > 0) then
        SetTaskBit(PoJun_ZiGe_1, 3, 1)
        Talk(1, "no", "ÄúÒÑ¿ªÆôÆÆ¾üÅå´÷»»È¡×Ê¸ñ.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Åå´÷][NhËn ®­îc¶Ò»»×Ê¸ñ]")
    else
        Talk(1, "no", "ThËt xin lçi, ÆÆ¾üÍ¼Æ×¿Û³ıÊ§°Ü.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Åå´÷][Trõ ³ıÍ¼Æ×³ö´í, Î´»ñµÃ×Ê¸ñ]")
        return
    end
end
function GetPeiDai()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(3, 100, 0, 0) < 2) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ×ã¹»µÄT­íng Qu©n LÖnh.")
        return
    end
    if (HaveItem2(tTable[3].BlueID[1], tTable[3].BlueID[2], tTable[3].BlueID[3], tTable[3].BlueID[4], 2, 0) < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦µÄÀ¶×°±¸.")
        return
    end
    local ishavetimes = Update()
    if (ishavetimes == 0) then
        return
    end
    for i = 1, 2 do
        DelNormalItem(3, 100, 0, 0)
    end
    DelItem2(tTable[3].BlueID[1], tTable[3].BlueID[2], tTable[3].BlueID[3], tTable[3].BlueID[4], 2)
    local n = AddNormalItem4(tTable[3].ID[1], tTable[3].ID[2], tTable[3].ID[3], tTable[3].ID[4], tTable[3].ID[5], tTable[3].ID[6], tTable[3].ID[7], tTable[3].ID[8], tTable[3].ID[9])
    SetItemBind(n, 1)
    local times = GetTaskByte(PoJun_ZiGe_1, 4)
    if (times < 50) then
        times = times + 1
    end
    SetTaskByte(PoJun_ZiGe_1, 4, times)
    Talk(1, "no", "³É¹¦×âÁŞÆÆ¾üÅå´÷, µ±Ç°ÄúÒÑ¾­×âÁŞÅå´÷<c=r>" .. times .. "<c>´Î.\n½ñÈÕ×âÁŞÆÆ¾ü¸÷²¿¼ş×Ü´ÎÊı<c=r>" .. GetTaskByte(PoJun_ZiGe_2, 3) .. "<c> lÇn.")
    WriteLog("[" .. CardName .. "][×âÁŞÅå´÷³É¹¦][µ±Ç°×âÁŞÅå´÷ lÇn thø: " .. times .. "]")
end

function YaoDai()
    no()
    if (GetTaskBit(PoJun_ZiGe_1, 4) == 0) then
        YaoDaiZiGe()
        return
    end
    MsgBox("¶Ò»»ĞèÒªÏûºÄ 2 c¸i T­íng Qu©n LÖnh vµ ¶ÔÓ¦²¿Î»À¶É«×°±¸, È·¶¨¶Ò»» sao?", "GetYaoDai", "no")

end
function YaoDaiZiGe()
    local tTable = CheckPlayerType()
    if (GetTaskBit(PoJun_ZiGe_1, 4) == 0) then
        MsgBox("ÊÇ·ñÏûºÄ±³°üÖĞµÄÒ»ÕÅ<c=r>" .. tTable[4].MapName .. "<c>, ¿ªÆôÑü´øµÄ×âÁŞ¼°»»È¡×Ê¸ñ?", "YaoDaiZiGe_yes", "no")
    else
        Talk(1, "no", "ÄúÒÑ¾­¼¤»îÁË¶Ò»»Ñü´øµÄ×Ê¸ñ.")
    end
end
function YaoDaiZiGe_yes()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(tTable[4].MapID[1], tTable[4].MapID[2], tTable[4].MapID[3], 1) > 0) then
        if (DelNormalItem(tTable[4].MapID[1], tTable[4].MapID[2], tTable[4].MapID[3], 1) > 0) then
            AddNormalItemBind(tTable[4].MapID[1], tTable[4].MapID[2], tTable[4].MapID[3], 0, 0, 0, 1)
        end
    end
    if (HaveNormalItem(tTable[4].MapID[1], tTable[4].MapID[2], tTable[4].MapID[3], tTable[4].MapID[4]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦²¿¼şµÄÆÆ¾üÍ¼Æ×, ²»ÄÜ¼¤»î¶Ò»»×Ê¸ñ.")
        return
    end
    if (DelNormalItem(tTable[4].MapID[1], tTable[4].MapID[2], tTable[4].MapID[3], tTable[4].MapID[4]) > 0) then
        SetTaskBit(PoJun_ZiGe_1, 4, 1)
        Talk(1, "no", "ÄúÒÑ¿ªÆôÆÆ¾üÑü´ø»»È¡×Ê¸ñ.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Ñü´ø][NhËn ®­îc¶Ò»»×Ê¸ñ]")
    else
        Talk(1, "no", "ThËt xin lçi, ÆÆ¾üÍ¼Æ×¿Û³ıÊ§°Ü.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Ñü´ø][Trõ ³ıÍ¼Æ×³ö´í, Î´»ñµÃ×Ê¸ñ]")
        return
    end
end
function GetYaoDai()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(3, 100, 0, 0) < 2) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ×ã¹»µÄT­íng Qu©n LÖnh.")
        return
    end
    if (HaveItem2(tTable[4].BlueID[1], tTable[4].BlueID[2], tTable[4].BlueID[3], tTable[4].BlueID[4], 2, 0) < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦µÄÀ¶×°±¸.")
        return
    end
    local ishavetimes = Update()
    if (ishavetimes == 0) then
        return
    end
    for i = 1, 2 do
        DelNormalItem(3, 100, 0, 0)
    end
    DelItem2(tTable[4].BlueID[1], tTable[4].BlueID[2], tTable[4].BlueID[3], tTable[4].BlueID[4], 2)
    local n = AddNormalItem4(tTable[4].ID[1], tTable[4].ID[2], tTable[4].ID[3], tTable[4].ID[4], tTable[4].ID[5], tTable[4].ID[6], tTable[4].ID[7], tTable[4].ID[8], tTable[4].ID[9])
    SetItemBind(n, 1)
    local times = GetTaskByte(PoJun_ZiGe_2, 1)
    if (times < 50) then
        times = times + 1
    end
    SetTaskByte(PoJun_ZiGe_2, 1, times)
    Talk(1, "no", "³É¹¦×âÁŞÆÆ¾üÑü´ø, µ±Ç°ÄúÒÑ¾­×âÁŞÑü´ø<c=r>" .. times .. "<c>´Î.\n½ñÈÕ×âÁŞÆÆ¾ü¸÷²¿¼ş×Ü´ÎÊı<c=r>" .. GetTaskByte(PoJun_ZiGe_2, 3) .. "<c> lÇn.")
    WriteLog("[" .. CardName .. "][×âÁŞÑü´ø³É¹¦][µ±Ç°×âÁŞÑü´ø lÇn thø: " .. times .. "]")
end

function XieZi()
    no()
    if (GetTaskBit(PoJun_ZiGe_1, 5) == 0) then
        XieZiZiGe()
        return
    end
    MsgBox("¶Ò»»ĞèÒªÏûºÄ 2 c¸i T­íng Qu©n LÖnh vµ ¶ÔÓ¦²¿Î»À¶É«×°±¸, È·¶¨¶Ò»» sao?", "GetXieZi", "no")

end
function XieZiZiGe()
    local tTable = CheckPlayerType()
    if (GetTaskBit(PoJun_ZiGe_1, 5) == 0) then
        MsgBox("ÊÇ·ñÏûºÄ±³°üÖĞµÄÒ»ÕÅ<c=r>" .. tTable[5].MapName .. "<c>, ¿ªÆôĞ¬×ÓµÄ×âÁŞ¼°»»È¡×Ê¸ñ?", "XieZiZiGe_yes", "no")
    else
        Talk(1, "no", "ÄúÒÑ¾­¼¤»îÁË¶Ò»»Ğ¬×ÓµÄ×Ê¸ñ.")
    end
end
function XieZiZiGe_yes()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(tTable[5].MapID[1], tTable[5].MapID[2], tTable[5].MapID[3], 1) > 0) then
        if (DelNormalItem(tTable[5].MapID[1], tTable[5].MapID[2], tTable[5].MapID[3], 1) > 0) then
            AddNormalItemBind(tTable[5].MapID[1], tTable[5].MapID[2], tTable[5].MapID[3], 0, 0, 0, 1)
        end
    end
    if (HaveNormalItem(tTable[5].MapID[1], tTable[5].MapID[2], tTable[5].MapID[3], tTable[5].MapID[4]) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦²¿¼şµÄÆÆ¾üÍ¼Æ×, ²»ÄÜ¼¤»î¶Ò»»×Ê¸ñ.")
        return
    end
    if (DelNormalItem(tTable[5].MapID[1], tTable[5].MapID[2], tTable[5].MapID[3], tTable[5].MapID[4]) > 0) then
        SetTaskBit(PoJun_ZiGe_1, 5, 1)
        Talk(1, "no", "ÄúÒÑ¿ªÆôÆÆ¾üĞ¬×Ó»»È¡×Ê¸ñ.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Ğ¬×Ó][NhËn ®­îc¶Ò»»×Ê¸ñ]")
    else
        Talk(1, "no", "ThËt xin lçi, ÆÆ¾üÍ¼Æ×¿Û³ıÊ§°Ü.")
        WriteLog("[»»È¡ÏŞÊ±ÆÆ¾ü][Ğ¬×Ó][Trõ ³ıÍ¼Æ×³ö´í, Î´»ñµÃ×Ê¸ñ]")
        return
    end
end
function GetXieZi()
    local tTable = CheckPlayerType()
    if (HaveNormalItem(3, 100, 0, 0) < 2) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ×ã¹»µÄT­íng Qu©n LÖnh.")
        return
    end
    if (HaveItem2(tTable[5].BlueID[1], tTable[5].BlueID[2], tTable[5].BlueID[3], tTable[5].BlueID[4], 2, 0) < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄúÉíÉÏÃ»ÓĞ¶ÔÓ¦µÄÀ¶×°±¸.")
        return
    end
    local ishavetimes = Update()
    if (ishavetimes == 0) then
        return
    end
    for i = 1, 2 do
        DelNormalItem(3, 100, 0, 0)
    end
    DelItem2(tTable[5].BlueID[1], tTable[5].BlueID[2], tTable[5].BlueID[3], tTable[5].BlueID[4], 2)
    local n = AddNormalItem4(tTable[5].ID[1], tTable[5].ID[2], tTable[5].ID[3], tTable[5].ID[4], tTable[5].ID[5], tTable[5].ID[6], tTable[5].ID[7], tTable[5].ID[8], tTable[5].ID[9])
    SetItemBind(n, 1)
    local times = GetTaskByte(PoJun_ZiGe_2, 2)
    if (times < 50) then
        times = times + 1
    end
    SetTaskByte(PoJun_ZiGe_2, 2, times)
    Talk(1, "no", "³É¹¦×âÁŞÆÆ¾üĞ¬×Ó, µ±Ç°ÄúÒÑ¾­×âÁŞĞ¬×Ó<c=r>" .. times .. "<c>´Î.\n½ñÈÕ×âÁŞÆÆ¾ü¸÷²¿¼ş×Ü´ÎÊı<c=r>" .. GetTaskByte(PoJun_ZiGe_2, 3) .. "<c> lÇn.")
    WriteLog("[" .. CardName .. "][×âÁŞĞ¬×Ó³É¹¦][µ±Ç°×âÁŞĞ¬×Ó lÇn thø: " .. times .. "]")
end

function GetForeverPoJun()
    local menu = {
        { "»»È¡ÓÀ¾ÃÍ·¿ø", "GetForeverTouKui"; show = 1 },
        { "»»È¡ÓÀ¾ÃĞØ¼×", "GetForeverXiongJia"; show = 1 },
        { "»»È¡ÓÀ¾ÃÅå´÷", "GetForeverPeiDai"; show = 1 },
        { "»»È¡ÓÀ¾ÃÑü´ø", "GetForeverYaoDai"; show = 1 },
        { "»»È¡ÓÀ¾ÃĞ¬×Ó", "GetForeverXieZi"; show = 1 },
        { "¼¤»îÍ·¿ø×Ê¸ñ", "TouKuiZiGe"; show = 0 },
        { "¼¤»îĞØ¼××Ê¸ñ", "XiongJiaZiGe"; show = 0 },
        { "¼¤»îÅå´÷×Ê¸ñ", "PeiDaiZiGe"; show = 0 },
        { "¼¤»îÑü´ø×Ê¸ñ", "YaoDaiZiGe"; show = 0 },
        { "¼¤»îĞ¬×Ó×Ê¸ñ", "XieZiZiGe"; show = 0 },
        { "Trë l¹i Trang tr­íc", "PoJun"; show = 1 },
    }
    if (GetTaskBit(PoJun_ZiGe_1, 1) == 0) then
        menu[1].show = 0
        menu[6].show = 1
    end
    if (GetTaskBit(PoJun_ZiGe_1, 2) == 0) then
        menu[2].show = 0
        menu[7].show = 1
    end
    if (GetTaskBit(PoJun_ZiGe_1, 3) == 0) then
        menu[3].show = 0
        menu[8].show = 1
    end
    if (GetTaskBit(PoJun_ZiGe_1, 4) == 0) then
        menu[4].show = 0
        menu[9].show = 1
    end
    if (GetTaskBit(PoJun_ZiGe_1, 5) == 0) then
        menu[5].show = 0
        menu[10].show = 1
    end

    if (GetTaskBit(PoJun_ZiGe_3, 1) == 1) then
        menu[1].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_3, 2) == 1) then
        menu[2].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_3, 3) == 1) then
        menu[3].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_3, 4) == 1) then
        menu[4].show = 0
    end
    if (GetTaskBit(PoJun_ZiGe_3, 5) == 1) then
        menu[5].show = 0
    end

    local str = "ÄúÖ»Òª¼¤»î¹ı×°±¸×âÁŞ¼°»»È¡×Ê¸ñ, ¾Í¿ÉÒÔÔÚ´Ë»»È¡ÓÀ¾ÃÆÆ¾ü×°±¸.\n¶Ò»»ÓÀ¾ÃÆÆ¾ü×°±¸ËùĞèµÄ²ÄÁÏÓëÖ±½ÓºÏ³ÉµÄ²ÄÁÏÏàÍ¬, µ«ÎŞĞè¡°ÆÆ¾ü°××°¡±, ÎŞĞè¡°ÆÆ¾üÍ¼Æ×¡±, ´ËÍâÄú×âÁŞÃ¿¸ö²¿Î»ËùÏûºÄµÄT­íng Qu©n LÖnh¡°½Ô¿ÉµÖÏû¡±¶Ò»»ÓÀ¾Ã×°±¸Ê±ËùĞèµÄT­íng Qu©n LÖnhÊıÁ¿."
    SayTask(str, menu)
end
function GetForeverTouKui()
    local str = GetItemStr(1)
    MsgBox(str, "GetForeverTouKui_Yes", "no")
end
function GetForeverTouKui_Yes()
    local result = DelItem(1)
    if (result == 0) then
        return
    end
    if (result == 1) then
        local tTable = CheckPlayerType()
        local n = AddNormalItem4(tTable[1].ID[1], tTable[1].ID[2], tTable[1].ID[3], tTable[1].ID[4], tTable[1].ID[5], tTable[1].ID[6], tTable[1].ID[7], tTable[1].ID[8] - 1, tTable[1].ID[9])
        SetItemBind(n, 1)
        SetTaskBit(PoJun_ZiGe_3, 1, 1)
        Talk(1, "no", "ÄúÒÑ³É¹¦¶Ò»»ÁËÓÀ¾ÃµÄÆÆ¾ü×°±¸.")
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾ü][Í·¿ø]")
    end
end

function GetForeverXiongJia()
    local str = GetItemStr(2)
    MsgBox(str, "GetForeverXiongJia_Yes", "no")
end
function GetForeverXiongJia_Yes()
    local result = DelItem(2)
    if (result == 0) then
        return
    end
    if (result == 1) then
        local tTable = CheckPlayerType()
        local n = AddNormalItem4(tTable[2].ID[1], tTable[2].ID[2], tTable[2].ID[3], tTable[2].ID[4], tTable[2].ID[5], tTable[2].ID[6], tTable[2].ID[7], tTable[2].ID[8] - 1, tTable[2].ID[9])
        SetItemBind(n, 1)
        SetTaskBit(PoJun_ZiGe_3, 2, 1)
        Talk(1, "no", "ÄúÒÑ³É¹¦¶Ò»»ÁËÓÀ¾ÃµÄÆÆ¾ü×°±¸.")
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾ü][ĞØ¼×]")
    end
end

function GetForeverPeiDai()
    local str = GetItemStr(3)
    MsgBox(str, "GetForeverPeiDai_Yes", "no")
end
function GetForeverPeiDai_Yes()
    local result = DelItem(3)
    if (result == 0) then
        return
    end
    if (result == 1) then
        local tTable = CheckPlayerType()
        local n = AddNormalItem4(tTable[3].ID[1], tTable[3].ID[2], tTable[3].ID[3], tTable[3].ID[4], tTable[3].ID[5], tTable[3].ID[6], tTable[3].ID[7], tTable[3].ID[8] - 1, tTable[3].ID[9])
        SetItemBind(n, 1)
        SetTaskBit(PoJun_ZiGe_3, 3, 1)
        Talk(1, "no", "ÄúÒÑ³É¹¦¶Ò»»ÁËÓÀ¾ÃµÄÆÆ¾ü×°±¸.")
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾ü][Åå´÷]")
    end
end

function GetForeverYaoDai()
    local str = GetItemStr(4)
    MsgBox(str, "GetForeverYaoDai_Yes", "no")
end
function GetForeverYaoDai_Yes()
    local result = DelItem(4)
    if (result == 0) then
        return
    end
    if (result == 1) then
        local tTable = CheckPlayerType()
        local n = AddNormalItem4(tTable[4].ID[1], tTable[4].ID[2], tTable[4].ID[3], tTable[4].ID[4], tTable[4].ID[5], tTable[4].ID[6], tTable[4].ID[7], tTable[4].ID[8] - 1, tTable[4].ID[9])
        SetItemBind(n, 1)
        SetTaskBit(PoJun_ZiGe_3, 4, 1)
        Talk(1, "no", "ÄúÒÑ³É¹¦¶Ò»»ÁËÓÀ¾ÃµÄÆÆ¾ü×°±¸.")
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾ü][Ñü´ø]")
    end
end

function GetForeverXieZi()
    local str = GetItemStr(5)
    MsgBox(str, "GetForeverXieZi_Yes", "no")
end
function GetForeverXieZi_Yes()
    local result = DelItem(5)
    if (result == 0) then
        return
    end
    if (result == 1) then
        local tTable = CheckPlayerType()
        local n = AddNormalItem4(tTable[5].ID[1], tTable[5].ID[2], tTable[5].ID[3], tTable[5].ID[4], tTable[5].ID[5], tTable[5].ID[6], tTable[5].ID[7], tTable[5].ID[8] - 1, tTable[5].ID[9])
        SetItemBind(n, 1)
        SetTaskBit(PoJun_ZiGe_3, 5, 1)
        Talk(1, "no", "ÄúÒÑ³É¹¦¶Ò»»ÁËÓÀ¾ÃµÄÆÆ¾ü×°±¸.")
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾ü][Ğ¬×Ó]")
    end
end

function Update()
    local y, m, d = GetYMD()
    local lasttime = GetTaskByte(PoJun_ZiGe_2, 4)
    if (lasttime ~= d) then
        SetTaskByte(PoJun_ZiGe_2, 4, d)
        SetTaskByte(PoJun_ZiGe_2, 3, 0)
    end
    local num = GetTaskByte(PoJun_ZiGe_2, 3)
    if (num >= 2) then
        Talk(1, "no", "Ã¿ÈÕÖ»ÄÜ¶Ò»»ÆÆ¾ü2´Î, ÇëÃ÷ÈÕÔÙÀ´.")
        return 0
    else
        SetTaskByte(PoJun_ZiGe_2, 3, num + 1)
        return 1
    end
end
function GetItemStr(flag)
    local str1 = "<c=g>ÄúÕıÔÚ¶Ò»»ÓÀ¾ÃµÄÆÆ¾ü×°±¸, ĞèÒªÏûºÄ±³°üÖĞµÄ¡°<c><c=r>"
    local str2 = "<c=g>¡±, ¡°<c><c=r>"
    local str3 = "<c=g>¡±½øĞĞºÏ³É (ÓÅÏÈ¿Û³ı±³°üÎ»ÖÃ¿¿Ç°µÄµÀ¾ß), ÕâÀï°üÀ¨ÁËÃâ³ıÄú´ËÇ°×âÁŞÊ±ÏûºÄµÄT­íng Qu©n LÖnh<c><c=r>"
    local str4 = "<c=g>, ÊÇ·ñ¼ÌĞø£¿<c>"
    local str = ""
    if (flag == 1) then
        local times = GetTaskByte(PoJun_ZiGe_1, 2)
        local nNum = times * 2
        local tTable = tItemTou
        str = str1 .. tTable[1].name .. tTable[1].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[2].name .. tTable[2].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[3].name .. tTable[3].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[4].name .. tTable[4].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[5].name .. "<c=r>(70-" .. nNum .. ")<c>" .. "<c><c=r> c¸i <c>" .. str2
        str = str .. str3 .. nNum .. "<c><c=r> c¸i <c>" .. str4
        return str
    end
    if (flag == 4) then
        local times = GetTaskByte(PoJun_ZiGe_2, 1)
        local nNum = times * 2
        local tTable = tItemYao
        str = str1 .. tTable[1].name .. tTable[1].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[2].name .. tTable[2].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[3].name .. tTable[3].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[4].name .. tTable[4].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[5].name .. "<c=r>(70-" .. nNum .. ")<c>" .. "<c><c=r> c¸i <c>" .. str2
        str = str .. str3 .. nNum .. "<c><c=r> c¸i <c>" .. str4
        return str
    end
    if (flag == 5) then
        local times = GetTaskByte(PoJun_ZiGe_2, 2)
        local nNum = times * 2
        local tTable = tItemXie
        str = str1 .. tTable[1].name .. tTable[1].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[2].name .. tTable[2].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[3].name .. tTable[3].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[4].name .. tTable[4].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[5].name .. "<c=r>(70-" .. nNum .. ")<c>" .. "<c><c=r> c¸i <c>" .. str2
        str = str .. str3 .. nNum .. "<c><c=r> c¸i <c>" .. str4
        return str
    end
    if (flag == 3) then
        local times = GetTaskByte(PoJun_ZiGe_1, 4)
        local nNum = times * 2
        local tTable = tItemPei
        str = str1 .. tTable[1].name .. tTable[1].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[2].name .. tTable[2].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[3].name .. tTable[3].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[4].name .. tTable[4].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[5].name .. "<c=r>(70-" .. nNum .. ")<c>" .. "<c><c=r> c¸i <c>" .. str2
        str = str .. str3 .. nNum .. "<c><c=r> c¸i <c>" .. str4
        return str
    end
    if (flag == 2) then
        local times = GetTaskByte(PoJun_ZiGe_1, 3)
        local nNum = times * 2
        local tTable = tItemXiong
        str = str1 .. tTable[1].name .. tTable[1].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[2].name .. tTable[2].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[3].name .. tTable[3].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[4].name .. tTable[4].num .. "<c><c=r> c¸i <c>" .. str2
        str = str .. tTable[5].name .. "<c=r>(70-" .. nNum .. ")<c>" .. "<c><c=r> c¸i <c>" .. str2
        str = str .. str3 .. nNum .. "<c><c=r> c¸i <c>" .. str4
        return str
    end
end
function DelItem(flag)
    if (flag == 1) then
        local times = GetTaskByte(PoJun_ZiGe_1, 2)
        local nNum = times * 2
        local tTable = tItemTou

        for i = 1, table.getn(tTable) - 1 do
            if (HaveNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4]) < tTable[i].num) then
                Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
                return 0
            end
        end
        if (HaveNormalItem(3, 100, 0, 0) < (70 - nNum)) then
            Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
            return 0
        end

        for i = 1, table.getn(tTable) - 1 do
            for j = 1, tTable[i].num do
                DelNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4])
            end
        end
        for i = 1, (70 - nNum) do
            DelNormalItem(3, 100, 0, 0)
        end
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾üÍ·¿ø][Trõ ³ıT­íng Qu©n LÖnh: " .. 70 - nNum .. "]")
        return 1
    end
    if (flag == 2) then
        local times = GetTaskByte(PoJun_ZiGe_1, 3)
        local nNum = times * 2
        local tTable = tItemXiong

        for i = 1, table.getn(tTable) - 1 do
            if (HaveNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4]) < tTable[i].num) then
                Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
                return 0
            end
        end
        if (HaveNormalItem(3, 100, 0, 0) < (70 - nNum)) then
            Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
            return 0
        end
        for i = 1, table.getn(tTable) - 1 do
            for j = 1, tTable[i].num do
                DelNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4])
            end
        end
        for i = 1, (70 - nNum) do
            DelNormalItem(3, 100, 0, 0)
        end
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾üĞØ¼×][Trõ ³ıT­íng Qu©n LÖnh: " .. 70 - nNum .. "]")
        return 1
    end
    if (flag == 3) then
        local times = GetTaskByte(PoJun_ZiGe_1, 4)
        local nNum = times * 2
        local tTable = tItemPei

        for i = 1, table.getn(tTable) - 1 do
            if (HaveNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4]) < tTable[i].num) then
                Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
                return 0
            end
        end
        if (HaveNormalItem(3, 100, 0, 0) < (70 - nNum)) then
            Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
            return 0
        end

        for i = 1, table.getn(tTable) - 1 do
            for j = 1, tTable[i].num do
                DelNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4])
            end
        end
        for i = 1, (70 - nNum) do
            DelNormalItem(3, 100, 0, 0)
        end
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾üÅå´÷][Trõ ³ıT­íng Qu©n LÖnh: " .. 70 - nNum .. "]")
        return 1
    end
    if (flag == 4) then
        local times = GetTaskByte(PoJun_ZiGe_2, 1)
        local nNum = times * 2
        local tTable = tItemYao

        for i = 1, table.getn(tTable) - 1 do
            if (HaveNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4]) < tTable[i].num) then
                Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
                return 0
            end
        end
        if (HaveNormalItem(3, 100, 0, 0) < (70 - nNum)) then
            Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
            return 0
        end

        for i = 1, table.getn(tTable) - 1 do
            for j = 1, tTable[i].num do
                DelNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4])
            end
        end
        for i = 1, (70 - nNum) do
            DelNormalItem(3, 100, 0, 0)
        end
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾üÑü´ø][Trõ ³ıT­íng Qu©n LÖnh: " .. 70 - nNum .. "]")
        return 1
    end
    if (flag == 5) then
        local times = GetTaskByte(PoJun_ZiGe_2, 2)
        local nNum = times * 2
        local tTable = tItemXie

        for i = 1, table.getn(tTable) - 1 do
            if (HaveNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4]) < tTable[i].num) then
                Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
                return 0
            end
        end
        if (HaveNormalItem(3, 100, 0, 0) < (70 - nNum)) then
            Talk(1, "no", "<c=g>ËÆºõÄúĞ¯´øµÄ²ÄÁÏ²»×ãÅ¶!<c>")
            return 0
        end

        for i = 1, table.getn(tTable) - 1 do
            for j = 1, tTable[i].num do
                DelNormalItem(tTable[i].ID[1], tTable[i].ID[2], tTable[i].ID[3], tTable[i].ID[4])
            end
        end
        for i = 1, (70 - nNum) do
            DelNormalItem(3, 100, 0, 0)
        end
        WriteLog("[" .. CardName .. "][¶Ò»»ÓÀ¾ÃÆÆ¾üĞ¬×Ó][Trõ ³ıT­íng Qu©n LÖnh: " .. 70 - nNum .. "]")
        return 1
    end
end
function CheckPlayerType()
    local player = GetPlayerType()
    if (player == 0) then
        local tTable = tJiaShi
        return tTable
    end
    if (player == 1) then
        local tTable = tDaoShi
        return tTable
    end
    if (player == 2) then
        local tTable = tYiRen
        return tTable
    end
end
function no()
    CloseDialog()
end

function TongMonkey()
    local menu = {
        { "Ê¯ºïÈÎÎñ", "GetMonkeyTask"; show = 1 },
        { "ÉÏ½»Ê¯ºï", "PostMonkey"; show = 1 },
        { "L·nh nhËn phÇn th­ëng", "GetPre"; show = 1 },
    }
    local YY, MM, DD = GetYMD()
    if (IsTongMember() == 0) then
        Talk(1, "no", "Äú»¹Î´¼ÓÈëÈÎºÎ¹ú¼Ò, ²»ÄÜ²ÎÓëQuèc VËn Th¹ch HÇu»î¶¯")
        return
    end
    local tongname = GetTongName()
    local tongid = GetTongIDByName(tongname)
    if (DD ~= GetTongTask(60)) then
        SetTongTaskByID(tongid, 60, DD)
        SetTongTaskByID(tongid, 59, 0)
    end
    if (NewServerEx.Pub_IsTongMonkeyTime() > 0) then
        if (DD ~= GetTaskByte(2097, 1)) then
            SetTask(2097, 0)
            SetTaskByte(2097, 1, DD)
            SetTaskByte(2096, 2, 0)
            SetTaskByte(2096, 3, 0)
        end
        SetTaskBit(2097, 9, 1)
    end
    local TongMonkeyTotalNum = GetTongTask(59)
    local str = "Ó¢ĞÛ¿ÉÒÔÍ¨¹ıHoµn thµnh nhiÖm vô Ã¿ÈÕµÄÊ¯ºïÀ´»ñµÃÊ¯ºï, È»ºó½«Ê¯ºïÉÏ½»ÖÁ¹ú¼Ò, Ã¿ÈÕ¹ú¼ÒÊ¯ºï×ÜÁ¿´ïµ½200ºó, ¹úÃñ¿ÉÒÔ»ñµÃÓë×Ô¼ºÉÏ½»ÊıÁ¿ÏàµÈµÄ¹úÔË²ıÊ¢Àñ°ü.\n<c=y>" .. YY .. "<c>Äê<c=y>" .. MM .. "<c>ÔÂ<c=y>" .. DD .. "<c>ÈÕ¹ó¹úÒÑ¾­ÉÏ½»Ê¯ºï: <c=y>" .. TongMonkeyTotalNum .. "."
    SayTask(str, menu)

end
function PostMonkey()
    local menu = {
        { "È·¶¨ÉÏ½»", "PostMonkeyYes"; show = 1 },
        { "Trë l¹i Trang tr­íc", "TongMonkey"; show = 1 },
    }
    local num = HaveNormalItem(3, 1633, 0, 0)
    local MonkeyNum = GetTaskByte(MonkeyTask, 4)
    local str = "Ó¢ĞÛ½ñÈÕÒÑ¾­ÉÏ½»µÄÊ¯ºïÊıÁ¿Îª: <c=y>" .. MonkeyNum .. "<c>\nÄ¿Ç°±³°üÖĞ¿ÉÉÏ½»ÊıÁ¿Îª: <c=y>" .. num .. "<c>\nÑ¡ÔñÈ·¶¨ÉÏ½»ºó½«±³°üÖĞÊ¯ºïÈ«²¿ÉÏ½»µ½¹ú¼Ò."
    SayTask(str, menu)
end
function PostMonkeyYes()
    if (IsTongMember() == 0) then
        Talk(1, "no", "Äú»¹Î´Èë¹ú, ²»ÄÜÉÏ½»Ê¯ºï.")
        return
    end
    if (GetTaskBit(MonkeyTask, 19) == 1) then
        Talk(1, "no", "ÒÑ¾­ÁìÈ¡¹ı½ñÈÕµÄLÔ bao H­ng Quèc, ÇëÃ÷ÌìÔÙÀ´ÉÏ½»Ê¯ºï°É.")
        return
    end
    local num = HaveNormalItem(3, 1633, 0, 0)
    if (num < 1) then
        Talk(1, "no", "±³°üÖĞÎŞÊ¯ºï¿ÉÒÔÉÏ½».")
        return
    end
    for i = 1, num do
        DelNormalItem(3, 1633, 0, 0)
    end
    Talk(1, "no", "³É¹¦ÉÏ½»Ê¯ºï" .. num .. "Ö».")

    local tongname = GetTongName()
    local tongid = GetTongIDByName(tongname)

    local YY, MM, DD = GetYMD()
    if (DD ~= GetTongTask(60)) then
        SetTongTaskByID(tongid, 60, DD)
        SetTongTaskByID(tongid, 59, 0)
    end

    local MonkeyNum = GetTaskByte(MonkeyTask, 4)
    MonkeyNum = MonkeyNum + num
    if (MonkeyNum < 21) then
        SetTaskByte(MonkeyTask, 4, MonkeyNum)
    end

    local TongMonkeyTotalNum = GetTongTask(59)
    TongMonkeyTotalNum = TongMonkeyTotalNum + num
    if (TongMonkeyTotalNum < 10000) then
        SetTongTaskByID(tongid, 59, TongMonkeyTotalNum)
    end

    WriteLog("[" .. CardName .. "][Quèc VËn Th¹ch HÇu][ÉÏ½»Ê¯ºï: " .. MonkeyNum .. "Ö»]")
end
function GetPre()
    local TongMonkeyTotalNum = GetTongTask(59)
    local str = "½ñÈÕÈÕ¹ó¹úÒÑ¾­ÉÏ½»Ê¯ºï: <c=y>" .. TongMonkeyTotalNum .. "<c>.\nµ±¹ú¼ÒÊ¯ºï´ïµ½200Ö»Ê±, ¿ÉÒÔÁìÈ¡¹úÔË²ıÊ¢¸£Àû.\nÇëÈ·¶¨½«±³°üÖĞµÄÊ¯ºïÒÑ¾­È«²¿ÉÏ½»ºóÔÙÁìÈ¡½±Àø, ÒòÎªÉÏ½»ÊıÁ¿Ô½¶àphÇn th­ëng cµng phong phó."
    local menu = {
        { "LÔ bao H­ng Quèc", "TongLuckItem"; show = 1 },
    }
    if (TongMonkeyTotalNum < 200) then
        menu[1].show = 0
    end

    SayTask(str, menu)
end
function TongLuckItem()
    no()
    MsgBox("Ã¿ÈÕÖ»ÄÜÁìÈ¡Ò»´ÎLÔ bao H­ng Quèc, ÁìÈ¡Ö®ºó½ñÈÕ½«²»ÄÜÔÙÉÏ½»Ê¯ºï.ÄúÈ·ÈÏÏÖÔÚÁìÈ¡ sao?", "TongLuckItem_yes", "no")
end
function TongLuckItem_yes()
    local TongMonkeyTotalNum = GetTongTask(59)
    local PlayerPostMonkeyNum = GetTaskByte(MonkeyTask, 4)
    local info = "Chóc mõng ngµi nhËn ®­îc LÔ bao H­ng Quèc*" .. PlayerPostMonkeyNum
    if (TongMonkeyTotalNum < 200) then
        Talk(1, "no", "½ñÈÕ¹ó¹úÊ¯ºï×ÜÁ¿»¹Î´´ïµ½200, ÔİÊ±²»ÄÜÁìÈ¡LÔ bao H­ng Quèc.")
        return
    end
    if (PlayerPostMonkeyNum < 1) then
        Talk(1, "no", "Ó¢ĞÛ½ñÈÕ²¢Î´ÉÏ½»Ê¯ºï, ÇëÉÏ½»Ê¯ºïºóÔÙÀ´ÁìÈ¡½±Àø.")
        return
    end
    if (GetTaskBit(MonkeyTask, 19) == 1) then
        Talk(1, "no", "ÒÑ¾­ÁìÈ¡¹ı½ñÈÕµÄLÔ bao H­ng Quèc, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("ThËt xin lçi, ÄúµÄ±³°ü²»×ã 1 c¸i ¿Õ¼ä, ÇëÕûÀíºóÔÙÁìÈ¡.")
        return
    end
    if (GetTongMemberDuty() == 1) then
        PlayerPostMonkeyNum = PlayerPostMonkeyNum * 2
        info = "ÓÉÓÚÄúÊÇ¹úÍõ, ½±Àø·­±¶!Chóc mõng ngµi nhËn ®­îc LÔ bao H­ng Quèc*" .. PlayerPostMonkeyNum
    end
    for i = 1, PlayerPostMonkeyNum do
        AddNormalItemBind(6, 1, 1437, 1, 0, 0, 1)
    end
    SetTaskBit(MonkeyTask, 19, 1)
    WriteLog("[" .. CardName .. "][Quèc VËn Th¹ch HÇu][NhËn LÔ bao H­ng Quèc: " .. PlayerPostMonkeyNum .. "]")
    Msg2Player(info)
    no()
end

function GetMonkeyTask()
    no()

    local strShow = {}
    local lenth = table.getn(g_Monkey_Task)

    for i = 1, lenth do
        local str = "  Î´Íê³É"
        if (GetTaskBit(2097, i + 8) == 1) then
            str = "<c=g>  Cã thÓ nhËn<c>"
            if (GetTaskBit(2096, i + 8) == 1) then
                str = "<c=r>  §· nhËn<c>"
            end
        end
        strShow[i] = g_Monkey_Task[i].name .. str .. "/ChooseTaskGetMonkey"
    end
    local info = "Ã¿ÈÕÊ×´ÎHoµn thµnh nhiÖm vô ÒÔÏÂºó¿ÉÒÔÁìÈ¡µ½Quèc VËn Th¹ch HÇu, »ıÔÜ×ã¹»µÄÊ¯ºïÉÏ½»ÖÁ¹ú¼Ò¿ÉÒÔÁìÈ¡¶ÔÓ¦ÊıÁ¿µÄLÔ bao H­ng Quèc."
    Say(info, table.getn(strShow), strShow)
end

function ChooseTaskGetMonkey(indexTemp)
    no()
    local i = indexTemp + 1
    if (g_Monkey_Task[i] == nil) then
        Talk(1, "no", "³öÏÖ´íÎó, xin h·y chän l¹i.")
        return
    end

    if (GetTaskBit(2096, i + 8) == 1) then
        Talk(1, "no", "ThËt xin lçi, ÄãÒÑ¾­ nhËn ¸Ã½±Àø, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end

    if (GetTaskBit(2097, i + 8) < 1) then
        Talk(1, "no", "ThËt xin lçi, Äú»¹Î´Hoµn thµnh nhiÖm vô ¸Ã, ²»ÄÜÁìÈ¡½±Àø.")
        return
    end

    SetTaskBit(2096, i + 8, 1)
    AddNormalItemBind(3, 1633, 0, 0, 0, 0, 1)
    Talk(1, "no", "NhËn ®­îc Quèc VËn Th¹ch HÇu")
    WriteLog("[" .. CardName .. "][NhËn ®­îc Quèc VËn Th¹ch HÇu]")

end

require("common_beast.luax")

TaskList = CommonBeast.TaskList
book_id = CommonBeast.book_id
task_info = CommonBeast.task_info
cur_flag_id = CommonBeast.cur_flag_id

mapname = {
    [1] = "Phong ThÇn ®µi",
    [2] = "Sïng Thµnh doanh",
    [3] = "Ngäc H­ cung",
    [4] = "Xi V­u Mé",
    [5] = "Sïng thµnh",
    [6] = "B¾c H¶i",
    [7] = "YÕn S¬n",
    [8] = "Ch©n nói C«n L«n",
    [9] = "T©y C«n L«n",
    [10] = "Thñ D­¬ng s¬n",
    [11] = "Du Hån",
    [12] = "Miªu C­¬ng",
    [13] = "Cù Léc",
    [14] = "§ång Quan",
    [15] = "M¹nh T©n",
    [16] = "Tam S¬n",
    [17] = "Kú S¬n",
    [18] = "Môc D·",
    [19] = "TuyÖt Long lÜnh",
    [20] = "T©y Kú",
    [21] = "TriÒu Ca",
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong ThÇn",
    [25] = "Lôc Ch©u",
    [26] = "Sa M¹c chÕt",
    [27] = "Hiªn Viªn tÇng 1",
    [28] = "Hiªn Viªn tÇng 2",
    [29] = "Hiªn Viªn tÇng 3",
    [30] = "Hiªn Viªn tÇng 4",
    [31] = "Hiªn Viªn tÇng 5",
    [32] = "Ngäc TuyÒn",
    [33] = "TuyÕt Cèc",
    [34] = "§¹i Phong",
    [35] = "§¹i Th¹ch",
    [36] = "B¨ng Xuyªn Cùc",
    [37] = "Thñy Vùc",
    [38] = "Long Cung",
    [39] = "H¶i C©u",
    [40] = "Long Vùc",
    [41] = "Long Uyªn",
    [42] = "Bİch Du tÇng 1",
    [43] = "Bİch Du tÇng 2",
    [44] = "Bİch Du tÇng 3",
    [45] = "Bİch Du tÇng 4",
    [46] = "Bİch Du tÇng 5",
    [47] = "Khæn Tiªn tÇng 1",
    [48] = "Khæn Tiªn tÇng 2",
    [49] = "Khæn Tiªn tÇng 3",
    [50] = "Khæn Tiªn tÇng 4",
    [51] = "Khæn Tiªn tÇng 5",
    [52] = "Diªu Tr×",
    [53] = "§¹i H¶i",
    [54] = "Bång Lai",
    [55] = "§«ng Doanh",
    [56] = "Ph­¬ng Tr­îng",
    [57] = "Thanh §ång s¬n",
    [58] = "D­îc V­¬ng cèc",
    [59] = "Sïng Thµnh (kho¸ng tr­êng)",
    [60] = "Thiªn Lao",
    [61] = "Ngäc H­ 10 n¨m tr­íc",
    [62] = "Ngäc H­ 10 n¨m sau",
    [63] = "TriÒu Ca 10 n¨m sau",
    [64] = "ChiÕn tr­êng ViÔn Cæ",
    [65] = "TrÇn §­êng",
    [66] = "Tr­ Lung tr¹i",
    [67] = "V¹n Tiªn (Thæ)",
    [68] = "V¹n Tiªn (Thñy)",
    [69] = "V¹n Tiªn (Háa)",
    [70] = "V¹n Tiªn (Phong)",
    [71] = "ChiÕn tr­êng",
    [72] = "Khai Minh ®¶o",
    [73] = "BÊt Chu Thiªn quan",
    [74] = "BÊt Chu S¬n",
    [75] = "Ngôc Ph¸p s¬n",
    [76] = "Th¸nh §Şa",
    [77] = "L­u Ba s¬n",
    [78] = "Kh«ng Tang Linh",
    [92] = "Thiªn Lao",
    [93] = "Thiªn Lao",
    [94] = "Thiªn Lao",
    [95] = "Thiªn Lao",
    [96] = "Thiªn Lao",
    [97] = "Diªm La ®iÖn",
    [98] = "Hoµng TuyÒn phñ",
    [99] = "Nam Kha quËn"
}

function main(level, time, npcIndex, itemId)


    if (itemId ~= nil) then
        SetTask(cur_flag_id, itemId)
    end

    local taskStr = "ÎªÁË±ÜÃâÓ¢ĞÛÃÇµ¡ÓÚ°²ÀÖ,Î÷ÍõÄ¸½«¸øÓ¢ĞÛÃÇ½øĞĞ\"Ğ×ÊŞÊÔÁ·\"\nÓ¢ĞÛÃÇÇëÑ¡ÔñÄúÄÜÕ½Ê¤µÄÒ°¹Ö, Äú½«»ñµÃ1 [¾ÅĞÇá¦Æì]µÀ¾ß,ÔÚá¦Æì¸½½ü½µ·şËùÑ¡Ò°¹Ö,\nÔòÓĞ¼¸ÂÊ»ñµÃ[Ğ×ÊŞ·âÓ]¨¡¿,¼´¿É²Î¼ÓÊÔÁ·.\n×¢Òâ: ²»Í¬µÈ¼¶¹ÖµôÂäĞ×ÊŞ·âÓ¡¿¨µÈ¼¶ vµ ¼¸ÂÊ²»Í¬."

    local tasks = {}

    for i = 1, table.getn(TaskList) do
        table.insert(tasks, TaskList[i].name .. "/GetSuperWomanTask")
    end

    Say(taskStr, table.getn(tasks), tasks)
end

function GetSuperWomanTask(index)

    no()

    if (IsHaveSpaceForTreasure(2) <= 0) then
        InfoBox("ÄãµÄ±³°ü¿Õ¼ä²»×ã1¸ñ, ÇëÕûÀíºóÔÙ´ò¿ªÍõÄ¸Ö®Êé.")
        return
    end

    index = index + 1

    local needLevel = ""
    if (index == 4) then
        needLevel = needLevel .. "Tiªn Ma"
    end

    needLevel = needLevel .. TaskList[index].id[2]
    SetTaskByte(task_info, 4, index)

    MsgBox("ÄúÑ¡ÔñµÄÊÇ" .. GetNormalItemName(TaskList[index].flagid[1], TaskList[index].flagid[2], TaskList[index].flagid[3], TaskList[index].flagid[4]) .. ",ĞèÒªÇ°ÍùµØÍ¼<c=g>" .. mapname[TaskList[index].mapid] .. "<c>½µ·şÒ°¹Ö, ½¨ÒéµÈ¼¶" .. needLevel .. ",ÇëÈ·±£ÄúÒÑÓĞ×Ê¸ñ½øÈë¶ÔÓ¦µØÍ¼, ·ñÔò½«ÎŞ·¨Ê¹ÓÃ´Ëá¦Æì.", "Yes", "main")
end

function Yes()

    no()

    if (DelItemByID(GetTask(cur_flag_id)) <= 0) then
        return
    end

    local index = GetTaskByte(task_info, 4)
    AddNormalItem(TaskList[index].flagid[1], TaskList[index].flagid[2], TaskList[index].flagid[3], TaskList[index].flagid[4], 0, 0)
    Msg2Player("ÄúÊ¹ÓÃÍõÄ¸Ö®Êé nhËn ®­îc " .. GetNormalItemName(TaskList[index].flagid[1], TaskList[index].flagid[2], TaskList[index].flagid[3], TaskList[index].flagid[4]) .. ",¿ìÈ¥Ö¸¶¨µØÍ¼É±¹Ö°É!")
    WriteLog("[Ho¹t ®éng Hung Thó][Ê¹ÓÃÍõÄ¸Ö®Êé]Ñ¡ÔñÒ°¹Ö" .. TaskList[index].name .. ", nhËn ®­îc " .. GetNormalItemName(TaskList[index].flagid[1], TaskList[index].flagid[2], TaskList[index].flagid[3], TaskList[index].flagid[4]))
end

function no()

    CloseDialog()
end

function main()
    local npcname = {
        [1] = "TÜnh Nh©n",
        [2] = "TuyÕt Yªu",
        [3] = "§¹i Chñng Nh©n",
        [4] = "B¾c H¶i Ph¶n Qu©n",
        [5] = "B¨ng Kiªu Trïng",
        [6] = "§µi Yªu",
        [7] = "Cuång §iªu",
        [8] = "Hoµn CÈu",
        [9] = "TuyÕt Nguyªn Cù Thó",
        [10] = "Th¶o Tiªn",
        [11] = "Cæ §iªu",
        [12] = "Cèt Tinh",
        [13] = "Hång S¸t",
        [14] = "Gi¸p Cèt",
        [15] = "Thi Hoµng",
        [16] = "Quû Ngù",
        [17] = "Thiªn Ng«",
        [18] = "Sa Hån",
        [19] = "H¾c Phong",
        [20] = "Vâ Quy",
        [21] = "§ao CÇm",
        [22] = "Háa Ng­",
        [23] = "Ho¶ Ly TiÓu Yªu",
        [24] = "KhuÈn Nh©n",
        [25] = "H¹n Quy",
        [26] = "Tr­ Tinh",
        [27] = "ThiÕt Ng­",
        [28] = "B¨ng Linh",
        [29] = "Nham Thó",
        [30] = "Chiªu ThÇn",
        [31] = "Cù Th¹ch",
        [32] = "H¶i S©m",
        [33] = "Phi Gi¸p",
        [34] = "Thi V­¬ng",
        [35] = "Ngäc N÷",
        [36] = "Háa Tµ",
        [37] = "Hµ Nh©n",
        [38] = "Quû §¨ng",
        [39] = "Khai Minh ThÇn",
        [40] = "Lam qu¸i",
        [41] = "Tr­êng Thõa ThÇn",
        [42] = "L«i Tr¹ch thÇn",
        [43] = "D· Mao thÇn",
        [44] = "Vò La ThÇn",
        [45] = "Tö Linh",
        [46] = "T­¬ng LiÔu ThÇn",
        [47] = "HuyÔn Tinh",
        [48] = "Tö Linh",
        [49] = "Xa BØ Phu Nh©n",
        [50] = "Lôc Ng« §¹i ThÇn"
    }
    if (GetFreeNpcCount() >= 100) then
        yes1()
    else
        Talk(1, "no", 13239)
    end

end;

function no()
    CloseDialog()
end;

function yes1()
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
        [42] = "BÝch Du tÇng 1",
        [43] = "BÝch Du tÇng 2",
        [44] = "BÝch Du tÇng 3",
        [45] = "BÝch Du tÇng 4",
        [46] = "BÝch Du tÇng 5",
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
        [57] = "Kho¸ng tr­êng",
        [58] = "D­îc V­¬ng cèc",
        [59] = "Sïng Thµnh (kho¸ng tr­êng)",
        [60] = "Thiªn Lao",
        [61] = "Ngäc H­ 10 n¨m tr­íc",
        [62] = "Ngäc H­ 10 n¨m sau",
        [63] = "TriÒu Ca 10 n¨m sau",
        [64] = "ViÔn Cæ",
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
        [76] = "Th¸nh §Þa",
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

    local LastTime = GetTask(969)
    local NowTime = SystemTime()
    if (NowTime > (LastTime + 200)) or (GetTask(966) == 0) then
        local mapid, px, py = GetWorldPos()
        local r = math.random(2, 5)
        SetTask(966, mapid)
        SetTask(967, px)
        SetTask(968, py)
        if (mapid > 99) then
            Msg2Player("Chiªu hån trËn ®· xuÊt hiÖn")
        else
            Msg2Player("B¹n ®Æt Chiªu Hån ph­ín t¹i" .. mapname[mapid] .. "xuÊt hiÖn")
        end
        TopMessage(13240)
        DelNormalItem(6, 1, 187, 0)
        AddNpc(549 + r, 1, SubWorld, px * 32, py * 32)
        AddIBBuff(260 + r)
        SetTask(969, SystemTime())

    elseif (NowTime <= (LastTime + 200)) then
        Msg2Player("B¹n ®· më Chiªu Hån ph­ín t¹i" .. mapname[GetTask(966)] .. ", cïng thêi gian chØ cã thÓ th¶ ra 1 Chiªu hån ph­ín")
    end ;
end;

module("ORACLEBONE", package.seeall)
require("common.luax")

G_TaskOrancleTimes = 2162

G_OracleActiveDay = { "2021-10-12 10:00:00", "2021-11-11 23:59:59" }
G_OracleUiViewDay = { "2021-10-12 10:00:00", "2021-11-17 23:59:59" }
G_OraclePrizeDay = { "2021-11-13 10:00:00", "2021-11-15 23:59:59" }
G_OracleClearValue = { "2021-12-20 00:00:00", "2030-12-01 23:59:59" }
G_OracleTimes = 10
G_TaskValueRange = { 2128, 2155 }
T_Card = {
    [1] = { name = "Quèc Gia NhÊt Viªn", quality = 1, cardtask = { 2128, 1 }, switch = 1 },
    [2] = { name = "NhiÖt Trung Quèc Sù", quality = 2, cardtask = { 2128, 2 }, switch = 0 },
    [3] = { name = "Quan vËn l­¬ng khãc thÇm", quality = 2, cardtask = { 2128, 3 }, switch = 1 },
    [4] = { name = "Ta kh«ng thÓ chÕt", quality = 1, cardtask = { 2128, 4 }, switch = 1 },
    [5] = { name = "Kiªn tr× tíi cïng", quality = 2, cardtask = { 2128, 5 }, switch = 1 },
    [6] = { name = "Na Tra", quality = 1, cardtask = { 2128, 6 }, switch = 0 },
    [7] = { name = "Thanh Mao S­ Tö", quality = 2, cardtask = { 2128, 7 }, switch = 1 },
    [8] = { name = "Kim Tu Ngao Ng­", quality = 2, cardtask = { 2128, 8 }, switch = 1 },
    [9] = { name = "Di Quang kÝnh", quality = 1, cardtask = { 2128, 9 }, switch = 1 },
    [10] = { name = "Di Quang KÝnh §¹i Hé", quality = 3, cardtask = { 2128, 10 }, switch = 1 },
    [11] = { name = "Chuyªn gia tÈy ngäc", quality = 4, cardtask = { 2128, 11 }, switch = 1 },
    [12] = { name = "Thñ VÖ Tiªn Phong", quality = 3, cardtask = { 2128, 12 }, switch = 1 },
    [13] = { name = "§éi Ngò ¦u Tó", quality = 1, cardtask = { 2128, 13 }, switch = 1 },
    [14] = { name = "Tiªn Sinh tèt bông", quality = 2, cardtask = { 2128, 14 }, switch = 1 },
    [15] = { name = "Thî VËn Töu", quality = 1, cardtask = { 2128, 15 }, switch = 1 },
    [16] = { name = "Töu Quû", quality = 2, cardtask = { 2128, 16 }, switch = 1 },
    [17] = { name = "HuyÒn Vò Ch©n ThÇn", quality = 1, cardtask = { 2128, 17 }, switch = 1 },
    [18] = { name = "Quy Tiªn Nh©n", quality = 2, cardtask = { 2128, 18 }, switch = 1 },
    [19] = { name = "Hoµng Kim Quang C«n", quality = 2, cardtask = { 2128, 19 }, switch = 0 },
    [20] = { name = "Viªn §inh l­êi biÕng", quality = 2, cardtask = { 2128, 20 }, switch = 1 },
    [21] = { name = "Viªn §inh cÇn cï", quality = 2, cardtask = { 2128, 21 }, switch = 1 },
    [22] = { name = "Chinh phôc 4 tiÓu Boss", quality = 1, cardtask = { 2128, 22 }, switch = 1 },
    [23] = { name = "Nhµ s­u tËp Boss", quality = 4, cardtask = { 2128, 23 }, switch = 1 },
    [24] = { name = "M¸y chÐm Boss", quality = 2, cardtask = { 2128, 24 }, switch = 1 },
    [25] = { name = "Lôc l©m §¹i ®¹o", quality = 1, cardtask = { 2128, 25 }, switch = 0 },
    [26] = { name = "Ngò Quû", quality = 2, cardtask = { 2128, 26 }, switch = 1 },
    [27] = { name = "TiÓu Thæ Hµo", quality = 1, cardtask = { 2128, 27 }, switch = 1 },
    [28] = { name = "TiÓu M·i NhÊt Bót", quality = 2, cardtask = { 2128, 28 }, switch = 1 },
    [29] = { name = "Y Thùc Phô MÉu", quality = 4, cardtask = { 2128, 29 }, switch = 1 },
    [30] = { name = "BÞ Gi¸p Tr× Binh", quality = 4, cardtask = { 2128, 30 }, switch = 0 },
    [31] = { name = "LiÖp M· Qu©n", quality = 3, cardtask = { 2128, 31 }, switch = 1 },
    [32] = { name = "LiÖp M· Cao cÊp", quality = 3, cardtask = { 2128, 32 }, switch = 1 },
    [33] = { name = "Hoµnh Hµnh Tø H¶i", quality = 2, cardtask = { 2129, 1 }, switch = 1 },
    [34] = { name = "B¨ng Long ThÇn Sø", quality = 3, cardtask = { 2129, 2 }, switch = 1 },
    [35] = { name = "Ho¶ Long ThÇn Sø", quality = 3, cardtask = { 2129, 3 }, switch = 1 },
    [36] = { name = "TiÕt Thanh Minh", quality = 2, cardtask = { 2129, 4 }, switch = 0 },
    [37] = { name = "LÔ héi Vui s­íng", quality = 2, cardtask = { 2129, 5 }, switch = 1 },
    [38] = { name = "B¸ch BiÕn Linh Sñng", quality = 2, cardtask = { 2129, 6 }, switch = 1 },
    [39] = { name = "Linh Sñng ®¹t nh©n", quality = 5, cardtask = { 2129, 7 }, switch = 1 },
    [40] = { name = "ThÇn T­íng T­¬ng Trî", quality = 1, cardtask = { 2129, 8 }, switch = 1 },
    [41] = { name = "ViÖc ThÇn T­íng", quality = 2, cardtask = { 2129, 9 }, switch = 1 },
    [42] = { name = "Héi §¨ng Cao", quality = 2, cardtask = { 2129, 10 }, switch = 0 },
    [43] = { name = "LÔ Ch­ HÇu", quality = 3, cardtask = { 2129, 11 }, switch = 1 },
    [44] = { name = "H¶o VËn §Õn", quality = 2, cardtask = { 2129, 12 }, switch = 1 },
    [45] = { name = "TÕt Nguyªn Tiªu", quality = 2, cardtask = { 2129, 13 }, switch = 0 },
    [46] = { name = "Hung Thó §o¶n MÖnh", quality = 2, cardtask = { 2129, 14 }, switch = 0 },
    [47] = { name = "Hung Thó §¸ng Th­¬ng", quality = 4, cardtask = { 2129, 15 }, switch = 0 },
    [48] = { name = "Hung Thó Ngò Tinh", quality = 4, cardtask = { 2129, 16 }, switch = 0 },
    [49] = { name = "Phi Th¨ng §¬n", quality = 3, cardtask = { 2129, 17 }, switch = 1 },
    [50] = { name = "§¨ng nhËp mçi ngµy", quality = 2, cardtask = { 2129, 18 }, switch = 1 },


}
T_GetCardTask = {

    [1] = { name = "Nãi chuyÖn 1 lÇn trªn kªnh chat quèc", task = { 2135, 1, 1, "byte" }, tasktype = "sè lÇn", cardidx = 1 },
    [2] = { name = "Göi tin 100 lÇn trªn kªnh chat quèc", task = { 2135, 1, 100, "byte" }, tasktype = "sè lÇn", cardidx = 2 },
    [3] = { name = "VËn l­¬ng (xe thËt) bÞ c­íp 5 lÇn", task = { 2135, 2, 5, "byte" }, tasktype = "sè lÇn", cardidx = 3 },
    [4] = { name = "Håi sinh t¹i chç 1 lÇn", task = { 2135, 3, 1, "byte" }, tasktype = "sè lÇn", cardidx = 4 },
    [5] = { name = "Håi sinh t¹i chç 10 lÇn", task = { 2135, 3, 10, "byte" }, tasktype = "sè lÇn", cardidx = 5 },
    [6] = { name = "Hoµn thµnh Phong Ho¶ Lu©n trong vßng 2 phót 30 gi©y", task = { 2135, 4, 150, "byte" }, tasktype = "trong thêi gian", cardidx = 6 },
    [7] = { name = "§¸nh b¹i KiÕm Tiªn §i §Çu 10 lÇn", task = { 2136, 1, 10, "byte" }, tasktype = "sè lÇn", cardidx = 7 },
    [8] = { name = "§¸nh b¹i ¤ V©n Tiªn 10 lÇn", task = { 2136, 2, 10, "byte" }, tasktype = "sè lÇn", cardidx = 8 },
    [9] = { name = "Dïng Di Quang KÝnh 1 lÇn", task = { 2136, 3, 1, "byte" }, tasktype = "sè lÇn", cardidx = 9 },
    [10] = { name = "Dïng Di Quang KÝnh 20 lÇn", task = { 2136, 3, 20, "byte" }, tasktype = "sè lÇn", cardidx = 10 },
    [11] = { name = "Dïng Di Quang KÝnh 100 lÇn", task = { 2136, 3, 100, "byte" }, tasktype = "sè lÇn", cardidx = 11 },
    [12] = { name = "Trong thêi gian quèc chiÕn, diÖt kÎ ®Þch ngo¹i quèc 50 lÇn", task = { 2136, 4, 50, "byte" }, tasktype = "sè lÇn", cardidx = 12 },
    [13] = { name = "Tæng ®iÓm Nh©n nghÜa t¨ng 5", task = { 2145, 1, 5, "word" }, tasktype = "t¨ng ®iÓm nh©n nghÜa", cardidx = 13 },
    [14] = { name = "Tæng ®iÓm Nh©n nghÜa t¨ng 20", task = { 2145, 1, 20, "word" }, tasktype = "t¨ng ®iÓm nh©n nghÜa", cardidx = 14 },
    [15] = { name = "Hoµn thµnh nhiÖm vô Tèng Töu 1 lÇn", task = { 2137, 2, 1, "byte" }, tasktype = "sè lÇn", cardidx = 15 },
    [16] = { name = "Hoµn thµnh nhiÖm vô Tèng Töu 30 lÇn (kh«ng thuéc chñ ®Ò ngµy)", task = { 2137, 3, 30, "byte" }, tasktype = "sè lÇn", cardidx = 16 },
    [17] = { name = "BiÕn thµnh HuyÒn Vò 1 lÇn", task = { 2137, 4, 1, "byte" }, tasktype = "sè lÇn", cardidx = 17 },
    [18] = { name = "BiÕn thµnh HuyÒn Vò 5 lÇn", task = { 2137, 4, 5, "byte" }, tasktype = "sè lÇn", cardidx = 18 },
    [19] = { name = "Tham gia lÔ héi ®éc th©n", task = nil, tasktype = "tham gia", cardidx = 19 },
    [20] = { name = "§é tr­ëng thµnh nhiÖm vô Thiªn §×nh ThÇn Thô ®¹t 32 ®iÓm trë xuèng", task = { nil, nil, 32 }, tasktype = "trÞ sè trë xuèng", cardidx = 20 },
    [21] = { name = "§é tr­ëng thµnh nhiÖm vô Thiªn §×nh ThÇn Thô ®¹t 50 ®iÓm trë lªn", task = { nil, nil, 50 }, tasktype = "trÞ sè trë lªn", cardidx = 21 },
    [22] = { name = "Tiªu diÖt tuú ý Thao ThiÕt/Hçn §én/Cïng Kú/§µo Ngét 1 lÇn", task = { 2138, 1, 1, "byte" }, tasktype = "sè lÇn", cardidx = 22 },
    [23] = { name = "Tiªu diÖt tuú ý Thao ThiÕt/Hçn §én/Cïng Kú/§µo Ngét 5 lÇn", task = { 2138, 1, 5, "byte" }, tasktype = "sè lÇn", cardidx = 24 },
    [24] = { name = "Trong vßng 1 ngµy ®¸nh b¹i cïng lóc Thao ThiÕt, Hçn §én, Cïng Kú, §µo Ngét 1 lÇn", task = { 2138, 3, 240, "byte" }, tasktype = "boss trong ngµy", cardidx = 23 },
    [25] = { name = "C­íp thµnh c«ng xe l­¬ng thËt 5 lÇn", task = { 2138, 4, 5, "byte" }, tasktype = "sè lÇn", cardidx = 25 },
    [26] = { name = "Liªn tiÕp quay ®­îc 2 lÇn Ngò Quû", task = { 2139, 1, 2, "byte" }, tasktype = "ngò quû liªn tiÕp", cardidx = 26 },
    [27] = { name = "Tiªu tæng céng 10 Th«ng B¶o", task = { 2140, 1, 10, "word" }, tasktype = "t¨ng tiªu phÝ", cardidx = 27 },
    [28] = { name = "TÝch lòy tiªu phÝ 999 Th«ng B¶o", task = { 2140, 1, 999, "word" }, tasktype = "t¨ng tiªu phÝ", cardidx = 29 },
    [29] = { name = "Tiªu phÝ 99 Th«ng B¶o trong 1 ngµy", task = { 2140, 4, 99, "byte" }, tasktype = "tiªu trong ngµy", cardidx = 28 },
    [30] = { name = "T¨ng ®iÓm c«ng lùc 3000", task = { 2139, 2, 3000, "word" }, tasktype = "t¨ng c«ng lùc", cardidx = 30 },
    [31] = { name = "Sè lÇn LiÖp M· Th­ëng kim ®¹t 30 lÇn", task = { 2141, 1, 30, "byte" }, tasktype = "sè lÇn", cardidx = 31 },
    [32] = { name = "LiÖp M· Th­ëng Kim rót ®­îc 10 lÇn B¸ L¹c Nh·n cÊp 10 trë lªn", task = { 2141, 2, 10, "byte" }, tasktype = "sè lÇn", cardidx = 32 },
    [33] = { name = "TÝch lòy dïng Di Ngo¹i Phï/Di Ngo¹i Phï siªu cÊp 500 lÇn.", task = { 2142, 1, 500, "word" }, tasktype = "sè lÇn", cardidx = 33 },
    [34] = { name = "Trong thêi gian ho¹t ®éng, nép tæng 50 c¸i B¨ng Long Ch©u", task = { 2141, 3, 50, "byte" }, tasktype = "sè lÇn", cardidx = 34 },
    [35] = { name = "Trong thêi gian ho¹t ®éng, nép tæng 50 c¸i Ho¶ Long Ch©u", task = { 2141, 4, 50, "byte" }, tasktype = "sè lÇn", cardidx = 35 },
    [36] = { name = "Gi¸p cèt tiÕt thanh minh", task = { 2142, 4, 1, "byte" }, tasktype = "sè lÇn", cardidx = 36 },
    [37] = { name = "Gi¸p cèt ngµy lÔ héi", task = { 2143, 1, 1, "byte" }, tasktype = "sè lÇn", cardidx = 37 },
    [38] = { name = "TÝch lòy gäi ra 3 lÇn Linh Sñng Thuéc tÝnh (Nh©n vËt cÊp 90 trë lªn)", task = { 2144, 3, "bit" }, tasktype = "linh sñng", cardidx = 38 },
    [39] = { name = "TÝch lòy gäi ra 16 lÇn Linh Sñng Thuéc tÝnh (Nh©n vËt cÊp 90 trë lªn)", task = { 2144, 16, "bit" }, tasktype = "linh sñng", cardidx = 39 },
    [40] = { name = "Sö dông ThÇn T­íng Dô LÖnh hoµn thµnh 1 lÇn nhiÖm vô ThÇn T­íng", task = nil, tasktype = "tham gia", cardidx = 40 },
    [41] = { name = "Sö dông ThÇn T­íng Dô LÖnh hoµn thµnh 60 lÇn nhiÖm vô ThÇn T­íng", task = { 2143, 2, 60, "byte" }, tasktype = "sè lÇn", cardidx = 41 },
    [42] = { name = "Gi¸p cèt TÕt Trïng Cöu", task = nil, tasktype = "tham gia", cardidx = 42 },
    [43] = { name = "TÝch lòy sö dông 3 lÇn [ThÇn BÝ Thñ LÔ] hoÆc [ThÇn BÝ Thñ LÔ (Tiªn Ma)]", task = { 2143, 3, 3, "byte" }, tasktype = "sè lÇn", cardidx = 43 },
    [44] = { name = "Khi sö dông ThÎ cµo, nhËn ®­îc phÇn th­ëng Bµo th­¬ng Håi Thµnh Phï, sÏ nhËn ®­îc gi¸p cèt", task = nil, tasktype = "tham gia", cardidx = 44 },
    [45] = { name = "Gi¸p cèt tiÕt nguyªn tiªu", task = nil, tasktype = "tham gia", cardidx = 45 },
    [46] = { name = "Lóc hîp thµnh ThÎ Hung Thó, liªn tôc thÊt b¹i 5 lÇn.", task = nil, tasktype = "tham gia", cardidx = 46 },
    [47] = { name = "Lóc hîp thµnh ThÎ Hung Thó, liªn tôc thÊt b¹i 10 lÇn.", task = nil, tasktype = "tham gia", cardidx = 47 },
    [48] = { name = "Thµnh c«ng hîp thµnh ThÎ Hung Thó 5 sao", task = nil, tasktype = "tham gia", cardidx = 48 },
    [49] = { name = "Hoµn thµnh C¸c Thñ Së Nhu, nÕu nhËn ®­îc 3 viªn Phi Th¨ng §¬n trong 1 lÇn, sÏ nhËn ®­îc gi¸p cèt", task = nil, tasktype = "tham gia", cardidx = 49 },
    [50] = { name = "Më lÔ bao ký danh hµng ngµy 28 lÇn, hoÆc më 28 lÇn lÔ bao ký danh.", task = { 2143, 4, 28, "byte" }, tasktype = "sè lÇn", cardidx = 50 },
}

T_PriceTable = {
    [1] = { value = 1, name = "Th­êng" },
    [2] = { value = 5, name = "¦u tó" },
    [3] = { value = 10, name = "Tinh chÕ" },
    [4] = { value = 20, name = "HiÕm" },
    [5] = { value = 100, name = "TruyÒn ThuyÕt" },
}

function IsThisTaskOpen(taskidx)
    local idx = T_GetCardTask[taskidx].cardidx
    if (T_Card[idx].switch == 1) then
        return 1
    else
        return 0
    end
end

function IsInOracleActiveDate()
    if (COMMON.IsInDateTimeRange(G_OracleActiveDay[1], G_OracleActiveDay[2])) then
        return 1
    else
        return 0
    end
end

function IsInOraclePrizeDate()
    if (COMMON.IsInDateTimeRange(G_OraclePrizeDay[1], G_OraclePrizeDay[2])) then
        return 1
    else
        return 0
    end
end

function IsInOracleUiViewDate()
    if (COMMON.IsInDateTimeRange(G_OracleUiViewDay[1], G_OracleUiViewDay[2])) then
        return 1
    else
        return 0
    end
end

function IsInOracleClearRange()
    if (COMMON.IsInDateTimeRange(G_OracleClearValue[1], G_OracleClearValue[2])) then
        return 1
    else
        return 0
    end
end

function GetCardWayApply(taskidx, nowvalue)

    if (GetLevel() < 60) and (GetNewBirthTimes() < 1) then
        return 0
    end

    ClearOracleTaskValue()
    if (IsInOracleActiveDate() == 0 or IsThisTaskOpen(taskidx) == 0) then
        return
    end
    local idx = taskidx
    local cardidx = T_GetCardTask[idx].cardidx
    if (GetTaskBit(T_Card[cardidx].cardtask[1], T_Card[cardidx].cardtask[2]) == 1) then
        return
    end
    if (T_GetCardTask[idx].tasktype == "sè lÇn") then
        if (T_GetCardTask[idx].task[4] == "byte") then
            local times = GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
            times = times + 1 + nowvalue
            if (times >= T_GetCardTask[idx].task[3]) then
                GiveCardToPlayer(taskidx)
            else
                if (times < 255) then
                    SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], times)
                end
            end
        elseif (T_GetCardTask[idx].task[4] == "word") then
            local times = GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
            times = times + 1 + nowvalue
            if (times >= T_GetCardTask[idx].task[3]) then
                GiveCardToPlayer(taskidx)
            else
                if (times < 60000) then
                    SetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], times)
                end
            end
        end
    elseif (T_GetCardTask[idx].tasktype == "trong thêi gian") then
        local scoretime = nowvalue
        if (scoretime < T_GetCardTask[idx].task[3]) then
            GiveCardToPlayer(taskidx)
        else
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "t¨ng ®iÓm nh©n nghÜa") then
        if (T_GetCardTask[idx].task[4] == "byte") then
            local changevalue = nowvalue - GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
            if (changevalue >= T_GetCardTask[idx].task[3]) then
                GiveCardToPlayer(taskidx)
            end
        elseif (T_GetCardTask[idx].task[4] == "word") then
            if (nowvalue > 0) then
                local changevalue = nowvalue - GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
                if (changevalue >= T_GetCardTask[idx].task[3]) then
                    GiveCardToPlayer(taskidx)
                end
            end
        end
    elseif (T_GetCardTask[idx].tasktype == "t¨ng tiªu phÝ") then
        if (T_GetCardTask[idx].task[4] == "byte") then
            if (GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2]) ~= 0) then
                local allvalue = (nowvalue / 100) + GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
                if (allvalue >= T_GetCardTask[idx].task[3]) then
                    GiveCardToPlayer(taskidx)
                else
                    SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], allvalue)
                end
            else
                if ((nowvalue / 100) >= T_GetCardTask[idx].task[3]) then
                    GiveCardToPlayer(taskidx)
                else
                    SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowvalue / 100)
                end
            end
        elseif (T_GetCardTask[idx].task[4] == "word") then
            if (GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2]) ~= 0) then
                local allvalue = (nowvalue / 100) + GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
                if (allvalue >= T_GetCardTask[idx].task[3]) then
                    GiveCardToPlayer(taskidx)
                else
                    SetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], allvalue)
                end
            else
                if ((nowvalue / 100) >= T_GetCardTask[idx].task[3]) then
                    GiveCardToPlayer(taskidx)
                else
                    SetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowvalue / 100)
                end
            end
        end
    elseif (T_GetCardTask[idx].tasktype == "tham gia") then
        GiveCardToPlayer(taskidx)
    elseif (T_GetCardTask[idx].tasktype == "trÞ sè trë lªn") then
        if (nowvalue >= T_GetCardTask[idx].task[3]) then
            GiveCardToPlayer(taskidx)
        else
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "trÞ sè trë xuèng") then
        if (nowvalue <= T_GetCardTask[idx].task[3]) then
            GiveCardToPlayer(taskidx)
        else
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "tiªu trong ngµy") then
        local YY, MM, DD = GetYMD()
        local taskdate = T_GetCardTask[idx].task[2] - 1
        if (GetTaskByte(T_GetCardTask[idx].task[1], taskdate) ~= DD) then
            SetTaskByte(T_GetCardTask[idx].task[1], taskdate, DD)
            SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], 0)
            SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowvalue / 100)
            local costvalue = GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
            if (costvalue >= T_GetCardTask[idx].task[3]) then
                GiveCardToPlayer(taskidx)
            end
            return
        end
        local costvalue = GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
        costvalue = costvalue + nowvalue / 100
        SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], costvalue)
        if (costvalue >= T_GetCardTask[idx].task[3]) then
            GiveCardToPlayer(taskidx)
        else
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "boss trong ngµy") then
        local YY, MM, DD = GetYMD()
        local bossbit = nowvalue
        local taskdate = T_GetCardTask[idx].task[2] - 1
        if (GetTaskByte(T_GetCardTask[idx].task[1], taskdate) ~= DD) then
            SetTaskByte(T_GetCardTask[idx].task[1], taskdate, DD)
            SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], 0)
            SetTaskBit(T_GetCardTask[idx].task[1], bossbit, 1)
        end
        SetTaskBit(T_GetCardTask[idx].task[1], bossbit, 1)
        if (GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2]) == T_GetCardTask[idx].task[3]) then
            GiveCardToPlayer(taskidx)
        else
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "ngò quû liªn tiÕp") then
        local YY, MM, DD = GetYMD()
        local lasttimes = GetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
        local lastdate = GetTaskByte(T_GetCardTask[idx].task[1], 2)
        local nowtimes = nowvalue + 1
        if (lasttimes == nowtimes and lastdate == DD) then
            SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowtimes)
            GiveCardToPlayer(taskidx)
        else
            SetTaskByte(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowtimes)
            SetTaskByte(T_GetCardTask[idx].task[1], 2, DD)
            return
        end
    elseif (T_GetCardTask[idx].tasktype == "t¨ng c«ng lùc") then
        if (GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2]) ~= 0) then
            local changevalue = nowvalue - GetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2])
            if (changevalue >= T_GetCardTask[idx].task[3]) then
                GiveCardToPlayer(taskidx)
            end
        else
            SetTaskWord(T_GetCardTask[idx].task[1], T_GetCardTask[idx].task[2], nowvalue)
        end
    elseif (T_GetCardTask[idx].tasktype == "Linh sñng") then
        if (GetLevel() < 90) then
            return
        end

        local nums = 0
        if (nowvalue <= 32) and (nowvalue >= 1) then
            SetTaskBit(T_GetCardTask[idx].task[1], nowvalue, 1)
        end

        for i = 1, 32 do
            if (GetTaskBit(T_GetCardTask[idx].task[1], i) == 1) then
                nums = nums + 1
                if (nums >= T_GetCardTask[idx].task[2]) then
                    GiveCardToPlayer(taskidx)
                    return
                end
            end
        end
    end

end
function GiveCardToPlayer(taskidx)

    if (GetLevel() < 60) and (GetNewBirthTimes() < 1) then
        return 0
    end

    local idx = taskidx
    local cardidx = T_GetCardTask[idx].cardidx
    local taskid = T_Card[cardidx].cardtask[1]
    local taskbit = T_Card[cardidx].cardtask[2]
    if (GetTaskBit(taskid, taskbit) == 1) then
        return
    end
    SetTaskBit(taskid, taskbit, 1)
    SetJiaGuActive(cardidx, 1, 1)
    local OracleBoneQuality = T_Card[cardidx].quality
    local OracleBoneValue = T_PriceTable[OracleBoneQuality].value
    local qualityname = T_PriceTable[OracleBoneQuality].name
    ChangeJiaGuValue(OracleBoneValue)
    ChangeJiaGuPoint(OracleBoneValue)
    Msg2Player("Chóc mõng ngµi nhËn ®­îc " .. qualityname .. " phÈm Gi¸p Cèt [" .. T_Card[cardidx].name .. "], ®ång thêi nhËn ®­îc " .. OracleBoneValue .. " TiÒn Gi¸p Cèt.")
    if (IsTongMember() > 0 and OracleBoneQuality >= 3) then
        Msg2TongMember("Chóc mõng anh hïng n­íc ta " .. GetName() .. " NhËn ®­îc " .. qualityname .. " phÈm Gi¸p Cèt [" .. T_Card[cardidx].name .. "], c¸ch ngµy nhËn th­ëng tõ Trô V­¬ng kh«ng cßn xa!")
    end
    WriteLog("[Gi¸p Cèt[NhËn ®­îc " .. qualityname .. " phÈm Gi¸p Cèt [" .. T_Card[cardidx].name .. "], gi¸p cèt trÞ gi¸ " .. OracleBoneValue .. ", TiÒn Gi¸p Cèt hiÖn d­ " .. GetJiaGuPoint() .. "]")
end

function OracleActIni()
    local cardidx = 0
    for task = 2128, 2134 do
        for bit = 1, 32 do
            cardidx = cardidx + 1
            if (cardidx <= table.getn(T_Card)) then
                if (T_Card[cardidx].switch == 1) then
                    if (GetTaskBit(task, bit) == 1) then
                        SetJiaGuActive(cardidx, 1, 0)
                    else
                        SetJiaGuActive(cardidx, 0, 0)
                    end
                end
            end
        end
    end
end
function ClearOracleTaskValue()
    if (GetTaskByte(G_TaskOrancleTimes, 1) ~= G_OracleTimes) then
        local nTaskByteValue = GetTaskByte(G_TaskOrancleTimes, 1)
        SetTaskByte(G_TaskOrancleTimes, 1, G_OracleTimes)
        SetTaskByte(G_TaskOrancleTimes, 2, 0)
        for i = G_TaskValueRange[1], G_TaskValueRange[2] do
            SetTask(i, 0)
        end
        local JiaguValue = GetJiaGuValue()
        local JiaguPoint = GetJiaGuPoint()
        ChangeJiaGuValue(-JiaguValue)
        ChangeJiaGuPoint(-JiaguPoint)
        local renyivalue = GetHelpScore()
        local powervalue = GetPowerValue()
        SetTaskWord(2139, 2, powervalue)
        SetTaskWord(2145, 1, renyivalue)
        WriteLog("[Gi¸p Cèt[Xo¸ biÕn l­îng][LÇn thø : " .. G_OracleTimes .. "][Gi¸ trÞ task hiÖn t¹i " .. nTaskByteValue .. "][ ®iÓm nh©n nghÜa ban ®Çu " .. renyivalue .. "][§iÓm c«ng lùc ban ®Çu " .. powervalue)
        return
    end
end

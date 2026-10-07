function main(nLevel, nTime, nTNpcIdx, itemID)
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (GetTaskByte(2273, 1) ~= today) then
        SetTask(2273, today)
    end

    local cishu = GetTaskByte(2273, 3) + 1
    local lvl = GetLevel()
    if (GetNewBirthTimes() > 0) then
        if (cishu > 15) then
            Talk(1, "no", "ThËt xin lçi, Ã¿ÌìÖ»ÄÜ´ò¿ª<c=r>15´Î<c>.")
            return 0
        end
    elseif (lvl <= 120) then
        if (cishu > 5) then
            Talk(1, "no", "ThËt xin lçi, Ã¿ÌìÖ»ÄÜ´ò¿ª<c=r>5´Î<c>.")
            return 0
        end
    elseif (lvl > 120) then
        if (cishu > 10) then
            Talk(1, "no", "ThËt xin lçi, Ã¿ÌìÖ»ÄÜ´ò¿ª<c=r>10´Î<c>.")
            return 0
        end
    end

    if (DelItemByID(itemID) <= 0) then
        Talk(1, "no", "Hao Thiªn KhuyÓnµğ»ØµÄ¶«Î÷ÄØ......")
        return
    end

    local tItemlist = {
        { itemname = "Kinh nghiÖm ®¬n", itemid = { 6, 1, 1062, 1 }, count = 1, pro = 150, itemtype = "item", annouce = 0, },
        { itemname = "M¶nh Hoµng thñy tinh", itemid = { 3, 88, 0, 0 }, count = 1, pro = 1, itemtype = "item", annouce = 1 },
        { itemname = "Phi Th¨ng §¬n", itemid = { 6, 1, 1771, 1 }, count = 1, pro = 70, itemtype = "item", annouce = 0 },
        { itemname = "1 viªn Èâ¹ÇÍ·", itemid = "", count = 1, pro = 50, itemtype = "str", annouce = 0 },
        { itemname = "§¹i hång bao", itemid = { 6, 1, 769, 0 }, count = 1, pro = 80, itemtype = "item", annouce = 0 },
        { itemname = "Kinh NghiÖm §¬n-Siªu cÊp", itemid = { 6, 1, 1355, 1 }, count = 1, pro = 10, itemtype = "item", annouce = 0 },
        { itemname = "M¶nh Phï Th¹ch", itemid = { 6, 1, 1276, 1 }, count = 1, pro = 60, itemtype = "item", annouce = 0 },
        { itemname = "S« C« La", itemid = { 1, 6, 0, 0 }, count = 1, pro = 3, itemtype = "item", annouce = 0 },
        { itemname = " Th«ng B¶o", itemid = { 3, 1183, 0, 0 }, count = 1, pro = 80, itemtype = "item", annouce = 0 },
        { itemname = "Ò»Ûç¹·Ïè", itemid = "", count = 1, pro = 50, itemtype = "str", annouce = 0 },
        { itemname = "ËéÓñ´ü", itemid = { 6, 1, 1834, 1 }, count = 1, pro = 100, itemtype = "item", annouce = 0 },
        { itemname = "M¶nh Ph¸p B¶o", itemid = { 6, 1, 1074, 1 }, count = 1, pro = 30, itemtype = "item", annouce = 0 },
        { itemname = "ÁùµÀTói Tø T­îng-Nhá", itemid = { 6, 1, 1835, 1 }, count = 1, pro = 300, itemtype = "item", annouce = 0 },
        { itemname = "M¶nh Tö thuû tinh", itemid = { 3, 1149, 0, 0 }, count = 1, pro = 1, itemtype = "item", annouce = 1 },
        { itemname = "Tói Bét Néi §¬n", itemid = { 8, 1379, 2, 0 }, count = 1, pro = 15, itemtype = "item", annouce = 0 },
    }

    SetTaskByte(2273, 3, cishu)

    local log_str = "µğÀ´ÁË[" .. tItemlist[4].itemname .. "], £..¡, Õâ¸öÃ»É¶ÓÃ, »¹ÊÇÈÓµô°É"
    local rannum = math.random(1, 1000)
    local prob = 0

    for i = 1, table.getn(tItemlist) do
        prob = prob + tItemlist[i].pro
        if (rannum <= prob) then
            if (tItemlist[i].itemtype == "item") then
                for j = 1, tItemlist[i].count do
                    AddNormalItemBind(tItemlist[i].itemid[1], tItemlist[i].itemid[2], tItemlist[i].itemid[3], tItemlist[i].itemid[4], 0, 0, 1)
                end
                log_str = "µğÀ´ÁË" .. tItemlist[i].itemname .. "*" .. tItemlist[i].count .. "."
                WriteLog("[ÃÈ³èµğ»ØÖ®Îï][" .. log_str .. "]")
                if (tItemlist[i].annouce == 1) then
                    AddGlobalNews("Anh hïng " .. GetName() .. "ºÃÔËµ±Í·, Phi Th¨ng Hao Thiªn KhuyÓnÎªËû" .. log_str .. "!")
                end
                Msg2CurMapAnnounce("Phi Th¨ng Hao Thiªn KhuyÓnÎª<RoleName=\"" .. GetName() .. "\">" .. log_str .. "!")
            elseif (tItemlist[i].itemtype == "str") then
                log_str = "µğÀ´ÁË[" .. tItemlist[i].itemname .. "], £..¡, Õâ¸öÃ»É¶ÓÃ, »¹ÊÇÈÓµô°É"
            end
            break
        end
    end

    Msg2Player("Hao Thiªn KhuyÓn¸øÄã" .. log_str)
    Talk(1, "no", "Hao Thiªn KhuyÓn¸øÄã" .. log_str .. ".")
end

function no()
    CloseDialog()
end

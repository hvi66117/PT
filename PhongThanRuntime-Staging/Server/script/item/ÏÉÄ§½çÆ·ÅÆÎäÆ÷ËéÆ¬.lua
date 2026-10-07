function no()
    CloseDialog()
end

gTbl_ItemList = {
    { name = "R­¬ng Vò khÝ Tiªn Ma cÊp 25", item = 1308, num = 100 },
    { name = "R­¬ng Vò khÝ Tiªn Ma cÊp 55", item = 1309, num = 500 },
}
function main()
    no()
    if (HaveNormalItem(6, 1, 1565, 1) <= 0 and HaveNormalItem(6, 1, 1565, 0) <= 0) then
        return
    end

    local tasks = {
        [1] = { "Vò KhÝ TruyÒn ThuyÕt cÊp 25", "item_25"; show = 1 },
        [2] = { "Vò KhÝ TruyÒn ThuyÕt cÊp 55", "item_55"; show = 1 },
    }
    SayTask("ÎÒ¾¹ÊÕ¼¯µ½ÁËÕâÃ´¶àÆ·ÅÆÎäÆ÷ËéÆ¬, ¿ÉÒÔ³¢ÊÔ°ÑËüÃÇºÏ³ÉÎäÆ÷ÁË.ÎÒÏëºÏ³ÉÊ²Ã´ÎäÆ÷ÄØ£¿\nMêi lùa chän:\nVò KhÝ TruyÒn ThuyÕt cÊp 25¡ª¡ª 100 c¸i ÎäÆ÷ËéÆ¬\nVò KhÝ TruyÒn ThuyÕt cÊp 55¡ª¡ª 500 c¸i ÎäÆ÷ËéÆ¬", tasks)
end

function item_25()
    CloseDialog()
    local key = 1
    local num = { [0] = 0, [1] = 0 }
    local nNum = 0
    for i = 0, 1 do
        num[i] = HaveNormalItem(6, 1, 1565, i)
        nNum = nNum + num[i]
    end

    if (nNum < gTbl_ItemList[key].num) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ Æ·ÅÆÎäÆ÷ËéÆ¬²»×ã<c=r>" .. gTbl_ItemList[key].num .. "<c>.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Xin lçi, tói ®Çy, h·y s¾p xÕp råi ghÐp. ")
        return
    end

    nNum = 0
    for i = 1, 0, -1 do
        if (num[i] > 0) then
            for j = 1, num[i] do
                if (DelNormalItem(6, 1, 1565, i) > 0) then
                    nNum = nNum + 1

                    if (nNum >= gTbl_ItemList[key].num) then
                        AddNormalItem(6, 1, gTbl_ItemList[key].item, 1, 0, 0)
                        Talk(1, "no", "B¹n dïng " .. nNum .. " c¸i Æ·ÅÆÎäÆ÷ËéÆ¬¶Ò»»ÁË 1 c¸i " .. gTbl_ItemList[key].name)
                        WriteLog("[" .. gTbl_ItemList[key].name .. "ºÏ³É]¿Û³ý" .. nNum .. "µÚËÄÎ»0: " .. num[0] .. " vµ 1: " .. num[1])
                        return 0
                    end
                end
            end
        end
    end
end

function item_55()
    CloseDialog()
    local key = 2
    local num = { [0] = 0, [1] = 0 }
    local nNum = 0
    for i = 0, 1 do
        num[i] = HaveNormalItem(6, 1, 1565, i)
        nNum = nNum + num[i]
    end

    if (nNum < gTbl_ItemList[key].num) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ Æ·ÅÆÎäÆ÷ËéÆ¬²»×ã<c=r>" .. gTbl_ItemList[key].num .. "<c>.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Xin lçi, tói ®Çy, h·y s¾p xÕp råi ghÐp. ")
        return
    end

    nNum = 0
    for i = 1, 0, -1 do
        if (num[i] > 0) then
            for j = 1, num[i] do
                if (DelNormalItem(6, 1, 1565, i) > 0) then
                    nNum = nNum + 1

                    if (nNum >= gTbl_ItemList[key].num) then
                        AddNormalItem(6, 1, gTbl_ItemList[key].item, 1, 0, 0)
                        Talk(1, "no", "B¹n dïng " .. nNum .. " c¸i Æ·ÅÆÎäÆ÷ËéÆ¬¶Ò»»ÁË 1 c¸i " .. gTbl_ItemList[key].name)
                        WriteLog("[" .. gTbl_ItemList[key].name .. "ºÏ³É]¿Û³ý" .. nNum .. "µÚËÄÎ»0: " .. num[0] .. " vµ 1: " .. num[1])
                        return 0
                    end
                end
            end
        end
    end
end

tblItem = {
    [1] = { name = "Kinh NghiÖm §¬n*10", id = { 6, 1, 1062, 1 }, count = 10, bind = 1 },
    [2] = { name = "KhÝ Linh Tinh Tóy*10", id = { 3, 1242, 0, 0 }, count = 10, bind = 1 },
    [3] = { name = "T­íng Qu©n LÖnh*3", id = { 3, 100, 0, 0 }, count = 3, bind = 1 },
    [4] = { name = "Vi Quang Qu¸i Phï*1", id = { 3, 374, 0, 0 }, count = 1, bind = 1 },
}
nNeedBag = 4
gItemName = "Å¯Å¯¸Ð¶÷Àñ"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (IsHaveSpaceForTreasure(nNeedBag + 1) == 0) then
        InfoBox("ÄúÐèÒªÔ¤Áô" .. nNeedBag .. "¸ñÒÔÉÏ±³°ü.")
        return
    end
    if (DelNormalItem(6, 1, 1549, 1) > 0) then
        local str = "Chóc mõng ngµi më " .. gItemName .. ", nhËn ®­îc "
        for i = 1, table.getn(tblItem) do
            local fuhao = ","
            if (i == table.getn(tblItem)) then
                fuhao = "."
            end
            str = str .. tblItem[i].name .. fuhao
            for num = 1, tblItem[i].count do
                local itemid = tblItem[i].id
                if (tblItem[i].bind == 1) then
                    AddNormalItemBind(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0, 1)
                else
                    AddNormalItemPile(itemid[1], itemid[2], itemid[3], itemid[4], 0, 0)
                end
            end
        end
        Talk(1, "no", str)
        WriteLog("[Å¯Å¯¸Ð¶÷Àñ][¿ªÆô³É¹¦]")
    else
        Talk(1, "no", "Më lÔ bao thÊt b¹i")
        WriteLog("[Å¯Å¯¸Ð¶÷Àñ][¿ªÆôÊ§°Ü]")
    end
end

function no()
    CloseDialog()
end

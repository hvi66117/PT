ItemList = {
    [1] = { ItemName = "Ô¸Íû¿¨: T­íng Qu©n LÖnh", id = { 6, 1, 1373, 1 }, Produce = {
        [1] = { ProductionName = "T­íng Qu©n LÖnh", Productionid = { 3, 100, 0, 0 },
                NeedItemName = {
                    [1] = "<c=g>Hång Thuû Tinh<c>",
                    [2] = "<c=g>Tø T­îng Tinh Hoa<c>",
                    [3] = "<c=g>Lôc §¹o Tinh Hoa<c>",
                },

                NeedItemid = {
                    [1] = { 3, 28, 0, 0, 1 },
                    [2] = { 3, 115, 0, 0, 1 },
                    [3] = { 3, 114, 0, 0, 1 },
                },
        },
    }, },

    [2] = { ItemName = "Ô¸Íû¿¨: LÔ hép Phï Th¹ch", id = { 6, 1, 1374, 1 }, Produce = {
        [1] = { ProductionName = "LÔ hép Phï Th¹ch", Productionid = { 8, 1775, 2, 1 },
                NeedItemName = {
                    [1] = "<c=g>Lam Thuû Tinh<c>",
                    [2] = "<c=g>Tø T­îng Tinh Hoax2<c>",
                    [3] = "<c=g>Lôc §¹o Tinh Hoax2<c>",
                },

                NeedItemid = {
                    [1] = { 3, 80, 0, 0, 1 },
                    [2] = { 3, 115, 0, 0, 2 },
                    [3] = { 3, 114, 0, 0, 2 },
                },
        },
    }, },


    [3] = { ItemName = "Ô¸Íû¿¨: ÈÎÑ¡ÃûÓñ", id = { 6, 1, 1375, 1 }, Produce = {
        [1] = { ProductionName = "ÈÎÑ¡ÃûÓñ", Productionid = { 8, 1447, 2, 1 },
                NeedItemName = {
                    [1] = "<c=g>Hoµng Thuû Tinh<c>",
                    [2] = "<c=g>Tø T­îng Tinh Hoax2<c>",
                    [3] = "<c=g>Lôc §¹o Tinh Hoax2<c>",
                    [4] = "<c=g>Tha S¬n Th¹chx10<c>",
                },

                NeedItemid = {
                    [1] = { 3, 89, 0, 0, 1 },
                    [2] = { 3, 115, 0, 0, 2 },
                    [3] = { 3, 114, 0, 0, 2 },
                    [4] = { 3, 82, 0, 0, 10 },
                },
        },
    }, },

    [4] = { ItemName = "Ô¸Íû¿¨: Vi Quang Qu¸i Phï", id = { 6, 1, 1376, 1 }, Produce = {
        [1] = { ProductionName = "Vi Quang Qu¸i Phï", Productionid = { 3, 374, 0, 0 },
                NeedItemName = {
                    [1] = "<c=g>Lôc B¶o Th¹ch<c>",
                    [2] = "<c=g>Tø T­îng Tinh Hoax5<c>",
                    [3] = "<c=g>Lôc §¹o Tinh Hoax5<c>",
                    [4] = "<c=g>Tha S¬n Th¹chx10<c>",
                },

                NeedItemid = {
                    [1] = { 3, 250, 0, 0, 1 },
                    [2] = { 3, 115, 0, 0, 5 },
                    [3] = { 3, 114, 0, 0, 5 },
                    [4] = { 3, 82, 0, 0, 10 },
                },
        },
    }, },

    [5] = { ItemName = "Ô¸Íû¿¨: ÈÎÑ¡Hån Chó cÊp 2", id = { 6, 1, 1377, 1 }, Produce = {
        [1] = { ProductionName = "ÈÎÑ¡Hån Chó cÊp 2", Productionid = { 6, 1, 1372, 0 },
                NeedItemName = {
                    [1] = "<c=g>Tö B¶o Th¹ch<c>",
                    [2] = "<c=g>Tø T­îng Tinh Hoax10<c>",
                    [3] = "<c=g>Lôc §¹o Tinh Hoax10<c>",
                    [4] = "<c=g>Tha S¬n Th¹chx20<c>",
                    [5] = "<c=g>Thä S¬n Th¹chx2<c>",
                },

                NeedItemid = {
                    [1] = { 3, 1151, 0, 0, 1 },
                    [2] = { 3, 115, 0, 0, 10 },
                    [3] = { 3, 114, 0, 0, 10 },
                    [4] = { 3, 82, 0, 0, 20 },
                    [5] = { 3, 135, 0, 0, 2 },
                },
        },
    }, },
}

function main(nLevel, t, nNpcIdx, nItemId)

    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)

    for i = 1, getn(ItemList) do
        if (ItemList[i].id[1] == nGen and ItemList[i].id[2] == nDetail and ItemList[i].id[3] == nParticular) then
            local oper = {}
            for j = 1, getn(ItemList[i].Produce) do
                oper[getn(oper) + 1] = ItemList[i].Produce[j].ProductionName .. "/Get_Item"
            end
            SetTask(140, nItemId)
            SetTask(142, i)
            Say("ÇëÑ¡ÔñÄúÐèÒª»ñµÃµÄÐíÔ¸µÀ¾ß.", getn(oper), oper)
        end
    end
end

function Get_Item(index)
    index = index + 1
    local nItemId = GetTask(140)
    local nItem = GetTask(142)
    SetTask(141, index)

    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local str = ":"
    for i = 1, getn(ItemList[nItem].Produce[index].NeedItemName) do
        str = str .. ItemList[nItem].Produce[index].NeedItemName[i]
        str = str .. ","
    end

    MsgBox("NhËn ®­îc ÐíÔ¸µÀ¾ß: <c=y>" .. ItemList[nItem].Produce[index].ProductionName .. "<c> ÐèÒªµÄÐíÔ¸²ÄÁÏÎª" .. str .. "ÊÇ·ñ¼ÌÐø?", "Get_ItemSure", "no")
end

function Get_ItemSure()
    no()
    local nItemId = GetTask(140)
    local nItem = GetTask(142)
    local index = GetTask(141)

    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local nFlag = 0

    for i = 1, getn(ItemList[nItem].Produce[index].NeedItemid) do
        if (HaveNormalItem(ItemList[nItem].Produce[index].NeedItemid[i][1], ItemList[nItem].Produce[index].NeedItemid[i][2], ItemList[nItem].Produce[index].NeedItemid[i][3], ItemList[nItem].Produce[index].NeedItemid[i][4]) < ItemList[nItem].Produce[index].NeedItemid[i][5]) then
            nFlag = i
            break
        end
    end

    if (nFlag == 0) then
        if (IsHaveSpaceForTreasure(2) == 0) then
            InfoBox("Hµnh trang cña Anh hïng ®· ®Çy!ÐèÒª1¸ñ±³°ü, h·y s¾p xÕp hµnh trang råi quay l¹i!")
            return
        else
            AddNormalItemBind(ItemList[nItem].Produce[index].Productionid[1], ItemList[nItem].Produce[index].Productionid[2], ItemList[nItem].Produce[index].Productionid[3], ItemList[nItem].Produce[index].Productionid[4], 0, 0, 1)
        end
        ScrollMessage("NhËn ®­îc " .. ItemList[nItem].Produce[index].ProductionName)
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. ItemList[nItem].Produce[index].ProductionName)
        WriteLog("[" .. ItemList[nItem].ItemName .. "][Sö dông][ºÏ³É" .. ItemList[nItem].Produce[index].ProductionName .. "]")
    else
        Talk(1, "no", "ÓÉÓÚÄúÃ»ÓÐ×ã¹»µÄ" .. ItemList[nItem].Produce[index].NeedItemName[nFlag] .. ", ËùÒÔÎÞ·¨¼ÌÐøÐíÔ¸.")
        return
    end

    for i = 1, getn(ItemList[nItem].Produce[index].NeedItemid) do
        for j = 1, ItemList[nItem].Produce[index].NeedItemid[i][5] do
            DelNormalItem(ItemList[nItem].Produce[index].NeedItemid[i][1], ItemList[nItem].Produce[index].NeedItemid[i][2], ItemList[nItem].Produce[index].NeedItemid[i][3], ItemList[nItem].Produce[index].NeedItemid[i][4])
        end
    end
    WriteLog("[" .. ItemList[nItem].ItemName .. "][Sö dông][ºÏ³É" .. ItemList[nItem].Produce[index].ProductionName .. "]")
    SetTask(140, 0)
    SetTask(142, 0)
    SetTask(141, 0)
    DelItemByID(nItemId)
end

function no()
    CloseDialog()
end

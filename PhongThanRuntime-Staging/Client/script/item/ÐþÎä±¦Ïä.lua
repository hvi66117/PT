require("common.luax")
function no()
    CloseDialog()
end

BoxList = {
    [1] = { Itemid = { 6, 1, 1274 }, BoxName = "HuyÒn Vò B¶o R­¬ng (bÞ vì)", double = 1, taskid = 2029, taskbyte = 1,
            ItemList = {
                [1] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 4, BindCoin = -1, Rate = 500, NewsType = 0, BindType = 1 },
                [2] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 6, BindCoin = -1, Rate = 800, NewsType = 0, BindType = 1 },
                [3] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 8, BindCoin = -1, Rate = 1000, NewsType = 0, BindType = 1 },

            } },
    [2] = { Itemid = { 6, 1, 1275 }, BoxName = "HuyÒn Vò B¶o R­¬ng", double = 1, taskid = 2029, taskbyte = 1,
            ItemList = {
                [1] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 10, BindCoin = -1, Rate = 400, NewsType = 0, BindType = 1 },
                [2] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 13, BindCoin = -1, Rate = 700, NewsType = 0, BindType = 1 },
                [3] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 16, BindCoin = -1, Rate = 900, NewsType = 0, BindType = 1 },
                [4] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1276, 0 }, ItemNum = 20, BindCoin = -1, Rate = 1000, NewsType = 0, BindType = 1 },

            } },
    [3] = { Itemid = { 6, 1, 1277 }, BoxName = "Ch©n-HuyÒn Vò B¶o R­¬ng", double = 1, taskid = -1, taskbyte = -1,
            ItemList = {
                [1] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 50, BindCoin = -1, Rate = 590, NewsType = 0, BindType = 0 },
                [2] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 60, BindCoin = -1, Rate = 890, NewsType = 0, BindType = 0 },
                [3] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 70, BindCoin = -1, Rate = 940, NewsType = 0, BindType = 0 },
                [4] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 80, BindCoin = -1, Rate = 970, NewsType = 0, BindType = 0 },
                [5] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 90, BindCoin = -1, Rate = 990, NewsType = 0, BindType = 0 },
                [6] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 100, BindCoin = -1, Rate = 1000, NewsType = 0, BindType = 0 },
            } },
    [4] = { Itemid = { 6, 1, 1291 }, BoxName = "HuyÒn Vò ThÇn Hån±¦Ïä", double = 1, taskid = -1, taskbyte = -1,
            ItemList = {
                [1] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 60, BindCoin = -1, Rate = 430, NewsType = 0, BindType = 0 },
                [2] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 70, BindCoin = -1, Rate = 740, NewsType = 0, BindType = 0 },
                [3] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 80, BindCoin = -1, Rate = 870, NewsType = 0, BindType = 0 },
                [4] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 90, BindCoin = -1, Rate = 950, NewsType = 0, BindType = 0 },
                [5] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 100, BindCoin = -1, Rate = 980, NewsType = 0, BindType = 0 },
                [6] = { Name = "M¶nh Phï Th¹ch", Id = { 6, 1, 1281, 0 }, ItemNum = 110, BindCoin = -1, Rate = 1000, NewsType = 0, BindType = 0 },
            } },
}

ExBoxList = {}

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local nGen = GetItemGen(itemID)
    local nDetail = GetItemDetail(itemID)
    local nParticular = GetItemPartByID(itemID)

    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng, ²ÅÄÜ¿ªÆô´Ë±¦Ïä.")
        return
    end

    local nRand = math.random(1, 1000)
    local nItemNum = 0
    local nItemName = ""
    for i = 1, getn(BoxList) do
        if (nGen == BoxList[i].Itemid[1] and nDetail == BoxList[i].Itemid[2] and nParticular == BoxList[i].Itemid[3]) then
            for j = 1, getn(BoxList[i].ItemList) do
                if (nRand <= BoxList[i].ItemList[j].Rate) then
                    nItemNum = BoxList[i].ItemList[j].ItemNum
                    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 255)
                    local bAnnounce = 0
                    if (BoxList[i].taskid ~= -1 and GetTaskByte(BoxList[i].taskid, BoxList[i].taskbyte) ~= nToday) then
                        nItemNum = nItemNum * BoxList[i].double
                        SetTaskByte(BoxList[i].taskid, BoxList[i].taskbyte, nToday)
                        bAnnounce = 1
                    end
                    nItemName = nItemNum .. "." .. BoxList[i].ItemList[j].Name
                    if (BoxList[i].ItemList[j].Id[1] >= 0) then
                        if (BoxList[i].ItemList[j].BindType == 1) then
                            for k = 1, nItemNum do
                                AddNormalItemBind(BoxList[i].ItemList[j].Id[1], BoxList[i].ItemList[j].Id[2], BoxList[i].ItemList[j].Id[3], BoxList[i].ItemList[j].Id[4], 0, 0, 1)
                            end
                        elseif (BoxList[i].ItemList[j].BindType == 0) then
                            for k = 1, nItemNum do
                                AddNormalItemPile(BoxList[i].ItemList[j].Id[1], BoxList[i].ItemList[j].Id[2], BoxList[i].ItemList[j].Id[3], BoxList[i].ItemList[j].Id[4], 0, 0, 1)
                            end
                        end
                    end
                    if (BoxList[i].ItemList[j].BindCoin > 0) then
                        AddBindCoin(BoxList[i].ItemList[j].BindCoin)
                    end

                    if (bAnnounce == 1) then
                        Msg2CurMapAnnounce(GetName() .. "Ó¢ÐÛ½ñÈÕÊ×´Î´ò¿ª" .. BoxList[i].BoxName .. ", ÊÜµ½ÁË×£¸£, nhËn ®­îc Ë«±¶µÄ½±Àø, Ïäµ×µÄ" .. nItemName .. "Ó³ÈëÑÛÁ±, ÈÃËûÏ²³öÍûÍâ!")
                    else
                        Msg2CurMapAnnounce(GetName() .. "Ó¢ÐÛ më " .. BoxList[i].BoxName .. ", Ïäµ×µÄ" .. nItemName .. "Ó³ÈëÑÛÁ±, ÈÃËûÏ²³öÍûÍâ!")
                    end
                    InfoBox("Äú´ò¿ª<c=y>" .. BoxList[i].BoxName .. "<c>, nhËn ®­îc <c=g>" .. nItemName .. "<c>.")
                    Msg2Player("Äú´ò¿ª±¦Ïä nhËn ®­îc " .. nItemName .. ".")
                    WriteLog("[HuyÒn Vò B¶o R­¬ng][Sö dông][" .. nItemName .. "]")
                    DelItemByID(itemID)
                    break
                end
            end
            break
        end
    end
end

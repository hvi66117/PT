ItemList = {
    { Name = "Xİch Viªm to¸i ngäc (ch­a mµi)", ID = 253, },
    { Name = "Thanh Minh to¸i ngäc (ch­a mµi)", ID = 260, },
    { Name = "Tö Hµ to¸i ngäc (ch­a mµi)", ID = 267, },
}

function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    no()
    SetTask(140, itemID)

    local tasks = {
        [1] = { "Ëæ»ú x1", "LetItGo1"; show = 1 },
        [2] = { "ºÏ³ÉÖ¸¶¨ËéÓñ", "LetItGo2"; show = 1 },
    }
    SayTask("[Ëæ»ú 1 c¸i]: ÏûºÄ<c=y>ËéÓñ´ü*1<c> c¸i, Ëæ»ú¸ø³àÑ×, ÇàÚ¤, ×ÏÏ¼ËéÓñ (ch­a khai quang)ÖĞµÄ 1 c¸i\n[ºÏ³ÉÖ¸¶¨ËéÓñ]: ÏûºÄ<c=y>ËéÓñ´ü*3<c> c¸i, ÈÎÑ¡³àÑ×, ÇàÚ¤, ×ÏÏ¼ËéÓñ (ch­a khai quang)ÖĞµÄ 1 c¸i\nÒÔÉÏËù¸øËéÓñ¶¼ÊÇ°ó¶¨µÄ", tasks)
end

function LetItGo1()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (DelItemByID(GetTask(140)) <= 0) then
        Talk(1, "no", "ÄãµÄ<c=r>ËéÓñ´ü<c>ÄØ....")
        return
    end

    local r = math.random(1, 3)
    local name = ItemList[r].Name
    AddNormalItemBind(3, ItemList[r].ID, 0, 0, 0, 0, 1)
    ScrollMessage("NhËn ®­îc 1 viªn <c=y>" .. name .. "<c>")
    Msg2Player("Ngµi sö dông [ËéÓñ´ü], nhËn ®­îc 1 viªn " .. name .. ", xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2020) and (m <= 9) then
        WriteLog("[ËéÓñ´ü][Ëæ»ú][" .. name .. "]")
    end
end

function LetItGo2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1834, 1) < 3) then
        Talk(1, "no", "ThËt xin lçi, Ö¸¶¨ËéÓñĞèÒªÏûºÄ<c=r>3 c¸i<c>ËéÓñ´ü.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    local list = {}
    for i = 1, getn(ItemList) do
        list[i] = ItemList[i].Name .. "/Go2sel"
    end

    Say("ÇëÑ¡ÔñÏëÒª»ñµÃµÄËéÓñ: ", table.getn(list), list)
end

function Go2sel(index)
    CloseDialog()
    index = index + 1
    if (index <= 0 or index > 3) then
        Talk(1, "main", "Chän sai, h·y chän l¹i.")
        return
    end

    if (HaveNormalItem(6, 1, 1834, 1) < 3) then
        Talk(1, "no", "ThËt xin lçi, Ö¸¶¨ËéÓñĞèÒªÏûºÄ<c=r>3 c¸i<c>ËéÓñ´ü.")
        return
    end

    if (DelItemByID(GetTask(140)) <= 0) then
        Talk(1, "no", "ÄãµÄ<c=r>ËéÓñ´ü<c>ÄØ....")
        return
    end
    DelNormalItem(6, 1, 1834, 1)
    DelNormalItem(6, 1, 1834, 1)

    local name = ItemList[index].Name
    AddNormalItemBind(3, ItemList[index].ID, 0, 0, 0, 0, 1)
    ScrollMessage("NhËn ®­îc 1 viªn <c=y>" .. name .. "<c>")
    Msg2Player("Äã°Ñ3 c¸i[ËéÓñ´ü]´Õ³öÁË1 viªn " .. name .. ", xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2020) and (m <= 9) then
        WriteLog("[ËéÓñ´ü][Ö¸¶¨][" .. name .. "]")
    end
end

function Go(BindType)
    if (BindType == 1) then
        local str = "<c=y>[KÕt qu¶ hîp thµnh]<c>Phï Th¹ch Kü n¨ng cÊp 1(Kh«ng kho¸/HÖ ph¸i ngÉu nhiªn)\n<c=y>[Tiªu hao]<c>M¶nh Phï Th¹ch*100\n<c=y>[B¹c tiªu hao]<c>5 v¹n"

        if (nCount < 100) then
            str = str .. "\n\n<c=r>Sè l­îng M¶nh Phï Th¹ch kh«ng ®ñ<c>"
        end

        if (Money < 50000) then
            str = str .. "\n\n<c=r>Kh«ng ®ñ b¹c<c>"
        end

        if (nCount < 100) then
            Talk(1, "no", str)
            return
        elseif (Money < 100) then
            Talk(1, "no", str)
            return
        end
    elseif (BindType == 2) then
        local str = "<c=y>[KÕt qu¶ hîp thµnh]<c>Phï Th¹ch Kü n¨ng cÊp 1(kho¸/theo hÖ ph¸i)\n<c=y>[Tiªu hao]<c>M¶nh Phï Th¹ch(Kho¸)*100\n<c=y>[B¹c tiªu hao]<c>5 v¹n\n\n<c=g>L­u ı, nÕu M¶nh Phï Th¹ch (Kho¸) kh«ng ®ñ sÏ tiªu hao M¶nh Phï Th¹ch (Kh«ng kho¸)<c>"

        if ((nCount + nBindCount) < 100) then
            str = str .. "\n\n<c=r>Sè l­îng M¶nh Phï Th¹ch kh«ng ®ñ<c>"
        end

        if (Money < 50000) then
            str = str .. "\n\n<c=r>Kh«ng ®ñ b¹c<c>"
        end

        if ((nCount + nBindCount) < 100) then
            Talk(1, "no", str)
            return
        elseif (Money < 100) then
            Talk(1, "no", str)
            return
        end
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "CÇn chõa l¹i 1 « trèng trong hµnh trang míi cã thÓ hîp thµnh Phï Th¹ch.")
        return
    end

    if (BindType == 1) then
        MsgBox("<c=y>[KÕt qu¶ hîp thµnh]<c>Phï Th¹ch Kü n¨ng cÊp 1(Kh«ng kho¸/HÖ ph¸i ngÉu nhiªn)\n<c=y>[Tiªu hao]<c>M¶nh Phï Th¹ch*100\n<c=y>[B¹c tiªu hao]<c>5 v¹n\n\nBÊm X¸c ®Şnh ®Ó Hîp thµnh, BÊm Huû ®Ó huû hîp thµnh", "GoSure", "main")
    elseif (BindType == 2) then
        MsgBox("<c=y>[KÕt qu¶ hîp thµnh]<c>Phï Th¹ch Kü n¨ng cÊp 1(kho¸/theo hÖ ph¸i)\n<c=y>[Tiªu hao]<c>M¶nh Phï Th¹ch(Kho¸)*100\n<c=y>[B¹c tiªu hao]<c>5 v¹n\n\n<c=g>L­u ı, nÕu M¶nh Phï Th¹ch (Kho¸) kh«ng ®ñ sÏ tiªu hao M¶nh Phï Th¹ch (Kh«ng kho¸)<c>\n\nBÊm X¸c ®Şnh ®Ó Hîp thµnh, BÊm Huû ®Ó huû hîp thµnh", "GoSure", "main")
    end

end

function no()
    CloseDialog()
end

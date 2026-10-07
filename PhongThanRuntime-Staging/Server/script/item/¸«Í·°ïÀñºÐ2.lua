BoxName = "Hép quµ Phñ §Çu Bang 2"
boxID = { 6, 1, 1333, 1 }
NeedBageCount = 1

function main(nItemId)
    BoxName = GetNormalItemName(boxID[1], boxID[2], boxID[3], boxID[4])
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBageCount + 1) == 0) then
        InfoBox("Tói kh«ng ®ñ " .. NeedBageCount .. " « trèng h·y s¾p xÕp l¹i tói.")
        return
    end

    local opra = {
        "Phï nhiÖm vô Chñ ®Ò ngµy hoÆc trang bÞ Lôc cao cÊp/v1",
        "Ngäc Th¹ch Phï/v2",
        "Ta kh«ng muèn g× c¶/no",
    }
    Say("H·y chän lÔ vËt mµ ngµi muèn!", table.getn(opra), opra)
end

function v1()
    no()
    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (math.random(1, 100) <= 60) then
        AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
        InfoBox("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc Phï nhiÖm vô Chñ ®Ò ngµy.")
        Msg2Player("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc Phï nhiÖm vô Chñ ®Ò ngµy.")
        WriteLog("[Më " .. BoxName .. " nhËn ®­îc Phï nhiÖm vô Chñ ®Ò ngµy]")
    else
        AddNormalItemBind(6, 1, 1097, 1, 0, 0, 1)
        InfoBox("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc Hép quµ trang bÞ Lôc.")
        Msg2Player("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc Hép quµ trang bÞ Lôc.")
        WriteLog("[Më " .. BoxName .. " nhËn ®­îc Hép quµ trang bÞ Lôc]")
    end
end

function v2()
    no()
    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end
    local level = GetLevel()
    local str = ""
    if (level <= 70) then
        AddNormalItemBind(6, 1, 1296, 1, 0, 0, 1)
        str = "S¬ cÊp Ngäc Th¹ch Phï"

    elseif (level > 70 and level <= 90) then
        AddNormalItemBind(6, 1, 1295, 1, 0, 0, 1)
        str = "Trung cÊp Ngäc Th¹ch Phï"

    elseif (level > 90 and level <= 120) then
        AddNormalItemBind(6, 1, 1294, 1, 0, 0, 1)
        str = "Cao cÊp Ngäc Th¹ch Phï"

    elseif (level > 120) then
        AddNormalItemBind(6, 1, 1293, 1, 0, 0, 1)
        str = "Cùc phÈm Ngäc Th¹ch Phï"
    end

    InfoBox("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc " .. str .. ".")
    Msg2Player("Chóc mõng ngµi më " .. BoxName .. " nhËn ®­îc " .. str .. ".")
    WriteLog("[Më " .. BoxName .. " nhËn ®­îc " .. str .. "]")
end

function no()
    CloseDialog()
end

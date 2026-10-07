function main()
    local nPlayerType = GetPlayerType()
    if (nPlayerType == 0) then
        Say(13533, 6, "Khai Thiªn Kh«i/jiatou", "Khai Thiªn Yªu §¸i/jiabelt", "Khai Thiªn ChiÕn Ngoa/jiaboot", "Khai Thiªn Phi Phong/jiapi", "Khai Thiªn Gi¸p/jiacoat", "Hñy bá/no")
    elseif (nPlayerType == 1) then
        Say(13533, 6, "Th«ng Thiªn Qu¸n/daotou", "Th«ng Thiªn C©n/daobelt", "Th«ng Thiªn Lý/daoboot", "Th«ng Thiªn LÖnh/daopi", "Th«ng Thiªn §¹o Bµo/daocoat", "Hñy bá/no")
    elseif (nPlayerType == 2) then
        Say(13533, 6, "Lam §iªu Trô/yitou", "Lam §iªu Yªu §¸i/yibelt", "Lam §iªu Ngoa/yiboot", "Lam §iªu KÕt/yipi", "Lam §iªu Hé Gi¸p/yicoat", "Hñy bá/no")
    end
end;
function jiatou()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 7, 3, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Khai Thiªn Kh«i")
        TopMessage(13534)
    end
    CloseDialog()
end
function daotou()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 7, 4, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th«ng Thiªn Qu¸n")
        TopMessage(13535)
    end
    CloseDialog()
end

function yitou()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 7, 5, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lam §iªu Trô")
        TopMessage(13536)
    end
    CloseDialog()
end

function jiacoat()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 2, 3, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Khai Thiªn Gi¸p")
        TopMessage(13537)
    end
    CloseDialog()
end
function daocoat()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 2, 4, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th«ng Thiªn §¹o Bµo")
        TopMessage(13538)
    end
    CloseDialog()
end

function yicoat()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 2, 5, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lam §iªu Hé Gi¸p")
        TopMessage(13539)
    end
    CloseDialog()
end

function jiaboot()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 5, 3, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Khai Thiªn ChiÕn Ngoa")
        TopMessage(13540)
    end
    CloseDialog()
end
function daoboot()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 5, 4, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th«ng Thiªn Lý")
        TopMessage(13541)
    end
    CloseDialog()
end
function yiboot()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 5, 5, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lam §iªu Ngoa")
        TopMessage(13542)
    end
    CloseDialog()
end

function jiabelt()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 6, 3, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Khai Thiªn Yªu §¸i")
        TopMessage(13543)
    end
    CloseDialog()
end

function daobelt()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 6, 4, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th«ng Thiªn C©n")
        TopMessage(13544)
    end
    CloseDialog()
end
function yibelt()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 6, 5, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lam §iªu Yªu §¸i")
        TopMessage(13545)
    end
    CloseDialog()
end
function jiapi()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 9, 3, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Khai Thiªn Phi Phong")
        TopMessage(13546)
    end
    CloseDialog()
end
function daopi()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 9, 4, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Th«ng Thiªn LÖnh")
        TopMessage(13547)
    end
    CloseDialog()
end
function yipi()
    if (HaveNormalItem(6, 1, 324, 0) >= 1) then
        DelNormalItem(6, 1, 324, 0)
        AddNormalItem(0, 9, 5, 8, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lam §iªu KÕt")
        TopMessage(13548)
    end
    CloseDialog()
end

function no()
    CloseDialog()
end;

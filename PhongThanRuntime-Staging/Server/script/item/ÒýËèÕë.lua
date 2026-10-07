TASK_JADEPENDANT_ATR = 1603

HorseNeedTable = {
    { Name = "Thanh Linh Ngäc Béi", jadependantype = 0, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Thanh Linh Ngäc Béi", jadependantype = 1, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "HuyÒn Vò Ngäc Béi", jadependantype = 2, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "HuyÒn Vò Ngäc Béi", jadependantype = 3, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Phôc Hæ Ngäc Béi", jadependantype = 4, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Phôc Hæ Ngäc Béi", jadependantype = 5, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Hoµng HuyÕt Ngäc Béi", jadependantype = 6, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Hoµng HuyÕt Ngäc Béi", jadependantype = 7, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Bµn Long Ngäc Béi", jadependantype = 8, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Bµn Long Ngäc Béi", jadependantype = 9, ItemNeedNum = 1, IBCostIdx = 120 },
    { Name = "Bµn Long Ngäc Béi", jadependantype = 10, ItemNeedNum = 1, IBCostIdx = 120 },
}

function main()

    local bHasEquipJD = IsJadePendantEquip();
    if (bHasEquipJD == 0) then
        Talk(1, "no", "B¹n ch­a trang bÞ Ngäc Béi.")
        Msg2Player("B¹n ch­a trang bÞ Ngäc Béi.")
        return
    end

    local MagicAtrList = {
        "NhËp vµo Háa Ngäc Tñy/SelectMagicAtr",
        "NhËp vµo B¨ng Ngäc Tñy/SelectMagicAtr",
        "NhËp vµo Thæ Ngäc Tñy/SelectMagicAtr",
        "NhËp vµo L«i Ngäc Tñy/SelectMagicAtr",
        "NhËp vµo Kim Ngäc Tñy/SelectMagicAtr"
    }
    Say("Xin chän Ngäc Tñy muèn thao t¸c:", table.getn(MagicAtrList), MagicAtrList)

end

function SelectMagicAtr(JNum)

    CloseDialog()
    local nSel = JNum + 1
    local bCanAdd = CanJadePendantHaveMagicAtr(nSel)
    if (bCanAdd == 0) then
        Talk(1, "no", "PhÈm chÊt cña Ngäc Béi nµy kh«ng thÓ tiÕp nhËn thªm nhiÒu thuéc tÝnh!")
        return
    end
    SetTask(TASK_JADEPENDANT_ATR, nSel)
    local bHasMagicAtr = IsJadePendantHaveMagicAtr(nSel)
    local nArt = GetTask(TASK_JADEPENDANT_ATR)

    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(140)
    if (bHasMagicAtr == 1) then
        if (nArt == 1) then
            MsgBox("TiÕp tôc kh¶m Háa Ngäc Tñy cho Ngäc Béi cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. " Th«ng B¶o<c> vµ <c=g>5 Háa Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_ReAdd", "no")
        elseif (nArt == 2) then
            MsgBox("TiÕp tôc kh¶m B¨ng Ngäc Tñy cho Ngäc Béi cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. " Th«ng B¶o<c> vµ <c=g>5 B¨ng Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_ReAdd", "no")
        elseif (nArt == 3) then
            MsgBox("TiÕp tôc kh¶m Thæ Ngäc Tñy cho Ngäc Béi cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. "Th«ng B¶o<c> vµ <c=g>5 Thæ Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_ReAdd", "no")
        elseif (nArt == 4) then
            MsgBox("TiÕp tôc kh¶m L«i Ngäc Tñy cho Ngäc Béi cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. " Th«ng B¶o<c> vµ <c=g>5 L«i Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_ReAdd", "no")
        elseif (nArt == 5) then
            MsgBox("TiÕp tôc kh¶m Kim Ngäc Tñy cho Ngäc Béi cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. " Th«ng B¶o<c> vµ <c=g>5 Kim Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_ReAdd", "no")
        end
    else
        if (nArt == 1) then
            MsgBox("Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã <c=g>5 Háa Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_Normal", "no")
        elseif (nArt == 2) then
            MsgBox("Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã <c=g>5 B¨ng Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_Normal", "no")
        elseif (nArt == 3) then
            MsgBox("Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã <c=g>5 Thæ Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_Normal", "no")
        elseif (nArt == 4) then
            MsgBox("Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã <c=g>5 L«i Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_Normal", "no")
        elseif (nArt == 5) then
            MsgBox("Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã <c=g>5 Kim Ngäc Tñy<c>, ®ång ý chø?", "Confirm_AddMagicAtr_Normal", "no")
        end
    end
end

function Confirm_AddMagicAtr_ReAdd()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(140)
    if (GetCoin() < costIBNum) and (HaveNormalItem(8, 1081, 2, 0) < 1) then
        Talk(1, "no", "NÕu muèn tiÕp tôc t¨ng thªm thuéc tÝnh cho Ngäc Béi, cÇn cã 1 <c=g>TÈy Tñy Ch©u<c> hoÆc <c=g>" .. (costIBNum / 100) .. " Th«ng B¶o <c>, nguyªn liÖu cña b¹n kh«ng ®ñ!")
        return
    end
    local nArt = GetTask(TASK_JADEPENDANT_ATR)
    if (nArt == 1) then
        if (HaveNormalItem(3, 1045, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Háa Ngäc Tñy, b¹n ch­a ®ñ Háa Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
        end
    elseif (nArt == 2) then
        if (HaveNormalItem(3, 1046, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 B¨ng Ngäc Tñy, b¹n ch­a ®ñ B¨ng Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
        end
    elseif (nArt == 3) then
        if (HaveNormalItem(3, 1047, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Thæ Ngäc Tñy, b¹n ch­a ®ñ Thæ Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
        end
    elseif (nArt == 4) then
        if (HaveNormalItem(3, 1048, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 L«i Ngäc Tñy, b¹n ch­a ®ñ L«i Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
        end
    elseif (nArt == 5) then
        if (HaveNormalItem(3, 1049, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Kim Ngäc Tñy, b¹n ch­a ®ñ Kim Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
        end
    end

    local nQl = GetJadePendantQL(3, 1045, 0, 0, 0, 0)
    local IBItemID = FindAValidIBItem(8, 1081, 2, 0)
    if (IBItemID > 0) then
        CostIBItem(IBItemID)
    elseif (GetCoin() >= costIBNum) then
        CostCoinByIdx(140)
    end

    AddJadePendantMagicAtr(nArt)
    CloseDialog()
    Talk(1, "no", "TÈy tñy cho Ngäc Béi thµnh c«ng")
    Msg2Player("TÈy tñy cho Ngäc Béi thµnh c«ng")
    DelNormalItem(6, 1, 739, 1)
end

function Confirm_AddMagicAtr_Normal()

    local nArt = GetTask(TASK_JADEPENDANT_ATR)
    if (nArt == 1) then
        if (HaveNormalItem(3, 1045, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Háa Ngäc Tñy, b¹n ch­a ®ñ Háa Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
            DelNormalItem(3, 1045, 0, 0)
        end
    elseif (nArt == 2) then
        if (HaveNormalItem(3, 1046, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 B¨ng Ngäc Tñy, b¹n ch­a ®ñ B¨ng Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
            DelNormalItem(3, 1046, 0, 0)
        end
    elseif (nArt == 3) then
        if (HaveNormalItem(3, 1047, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Thæ Ngäc Tñy, b¹n ch­a ®ñ Thæ Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
            DelNormalItem(3, 1047, 0, 0)
        end
    elseif (nArt == 4) then
        if (HaveNormalItem(3, 1048, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 L«i Ngäc Tñy, b¹n ch­a ®ñ L«i Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
            DelNormalItem(3, 1048, 0, 0)
        end
    elseif (nArt == 5) then
        if (HaveNormalItem(3, 1049, 0, 0) < 5) then
            Talk(1, "no", "Kh¶m Ngäc Tñy cho Ngäc Béi cÇn cã 5 Kim Ngäc Tñy, b¹n ch­a ®ñ Kim Ngäc Tñy!")
            return
        else
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
            DelNormalItem(3, 1049, 0, 0)
        end
    end

    AddJadePendantMagicAtr(nArt)
    CloseDialog()
    Talk(1, "no", "TÈy tñy cho Ngäc Béi thµnh c«ng")
    Msg2Player("TÈy tñy cho Ngäc Béi thµnh c«ng")
    DelNormalItem(6, 1, 739, 1)
end

function no()
    CloseDialog()
end;

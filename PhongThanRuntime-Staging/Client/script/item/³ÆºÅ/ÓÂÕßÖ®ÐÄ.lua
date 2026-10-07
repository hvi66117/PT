function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    if (DelItemByID(itemID) > 0) then
        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end
        ActiveTitleQualify(170)
        SetCurTitle(170)
        Msg2Player("Ngµi nhÀn Æ≠Óc [DÚng Gi∂ Chi T©m]≥∆∫≈!")
        WriteLog("[≥∆∫≈µ¿æﬂ]º§ªÓ: DÚng Gi∂ Chi T©m")
        Talk(1, "no", "ChÛc m≠ıng ngµi nhÀn Æ≠Óc <c=g>DÚng Gi∂ Chi T©m<c>≥∆∫≈!")
    else
        Talk(1, "no", "ThÀt xin lÁi, Sˆ dÙng th t bπi, «Î…‘∫Û‘Ÿ¥Œ≥¢ ‘.")
    end
end

function no()
    CloseDialog()
end

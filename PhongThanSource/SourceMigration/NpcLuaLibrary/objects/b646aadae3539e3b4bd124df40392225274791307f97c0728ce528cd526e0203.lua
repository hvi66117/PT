--description: ³¬¼¶ÖÁ×ðVIPÀñºÐ
--author: liujifang
--date: 2013-03-15

function main()
    if (HaveNormalItem(6, 1, 947, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    DelNormalItem(6, 1, 947, 1)
    AddNormalItemBind(3, 401, 0, 0, 0, 0, 1)
    WriteLog("LÔ bao VIP ChÝ T«n siªu cÊp vip quay vÒ: Kim ¤ Qu¸i Phï (Ch­a mµi)")
    Msg2Player("B¹n sö dông lÔ bao VIP ChÝ T«n siªu cÊp, nhËn ®­îc 1: Kim ¤ Qu¸i Phï (Ch­a mµi)!")
end

function no()
    CloseDialog()
end
THANKS = 2180

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    local menu = {
        { "³ÏÒâ¡¤¸Ð¶÷Àñ", "ChengYi"; show = 1 },
        { "Å¯Å¯¡¤¸Ð¶÷Àñ", "NuanNuan"; show = 1 },
        { "Å¨Çé¡¤¸Ð¶÷Àñ", "NongQing"; show = 1 },
    }
    local info = "Phong ThÇn Chi LéÓÐÄãÍ¬ÐÐ, ÖîÎ»Ó¢ÐÛ¿Éµã»÷ÏÂ·½°´Å¥ÁìÈ¡¸Ð¶÷Àñ, Ô¸Äú³©ÓÎ·âÉñÊÀ½ç, Ã¿ÖÖÀñ°ü·Ö±ðÏÞÁì 1 c¸i Å¶, ÇÒÎïÆ·¾ùÎªkhãa!"
    SayTask(info, menu)
end
function ChengYi()
    no()
    if (GetTaskBit(THANKS, 17) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ nhËn ³ÏÒâ¡¤¸Ð¶÷Àñ, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("ÇëÔ¤Áô1¸ñ±³°üÔÙÀ´NhËn lÔ bao.")
        return
    end
    SetTaskBit(THANKS, 17, 1)
    AddNormalItemBind(6, 1, 1548, 1, 0, 0, 1)
    Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc ³ÏÒâ¡¤¸Ð¶÷Àñ.")
    Msg2Player("Chóc mõng ngµi nhËn ®­îc ³ÏÒâ¡¤¸Ð¶÷Àñ.")
    WriteLog("[¸Ð¶÷»ØÀ¡ÀñºÐ][NhËn ³ÏÒâ¡¤¸Ð¶÷Àñ]")
end
function NuanNuan()
    no()
    if (GetTaskBit(THANKS, 18) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ nhËn Å¯Å¯¡¤¸Ð¶÷Àñ, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("ÇëÔ¤Áô1¸ñ±³°üÔÙÀ´NhËn lÔ bao.")
        return
    end
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(279)
    if (GetCoin() < costIBNum) then
        InfoBox("NhËn Å¯Å¯¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ18.88 Th«ng B¶oµ±Ç°Í¨±¦²»×ã.")
        return
    end
    MsgBox("NhËn Å¯Å¯¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ18.88 Th«ng B¶oÈ·¶¨ÁìÈ¡ sao?", "NuanNuan_Yes", "no")
end
function NuanNuan_Yes()
    no()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(279)
    if (GetCoin() < costIBNum) then
        InfoBox("NhËn Å¯Å¯¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ18.88 Th«ng B¶oµ±Ç°Í¨±¦²»×ã.")
        return
    end
    CostCoinByIdx(279)

    SetTaskBit(THANKS, 18, 1)
    AddNormalItemBind(6, 1, 1549, 1, 0, 0, 1)
    Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc Å¯Å¯¡¤¸Ð¶÷Àñ.")
    Msg2Player("Chóc mõng ngµi nhËn ®­îc Å¯Å¯¡¤¸Ð¶÷Àñ.")
    WriteLog("[¸Ð¶÷»ØÀ¡ÀñºÐ][ Tiªu hao 18.88 Th«ng B¶o nhËn Å¯Å¯¡¤¸Ð¶÷Àñ]")
end
function NongQing()
    no()
    if (GetTaskBit(THANKS, 19) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­ nhËn Å¨Çé¡¤¸Ð¶÷Àñ, ²»ÄÜÖØ¸´ÁìÈ¡.")
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("ÇëÔ¤Áô1¸ñ±³°üÔÙÀ´NhËn lÔ bao.")
        return
    end
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(280)
    if (GetCoin() < costIBNum) then
        InfoBox("NhËn Å¨Çé¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ158.88 Th«ng B¶oÄ¿±êÍ¨±¦²»×ã.")
        return
    end
    MsgBox("NhËn Å¨Çé¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ158.88 Th«ng B¶oÈ·¶¨ÁìÈ¡ sao?", "NongQing_Yes", "no")
end
function NongQing_Yes()
    no()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(280)
    if (GetCoin() < costIBNum) then
        InfoBox("NhËn Å¨Çé¡¤¸Ð¶÷ÀñÐèÒªÏûºÄ158.88 Th«ng B¶oÄ¿±êÍ¨±¦²»×ã.")
        return
    end
    CostCoinByIdx(280)

    SetTaskBit(THANKS, 19, 1)
    AddNormalItemBind(6, 1, 1550, 1, 0, 0, 1)
    Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc Å¨Çé¡¤¸Ð¶÷Àñ.")
    Msg2Player("Chóc mõng ngµi nhËn ®­îc Å¨Çé¡¤¸Ð¶÷Àñ.")
    WriteLog("[¸Ð¶÷»ØÀ¡ÀñºÐ][ Tiªu hao 158.88 Th«ng B¶o nhËn Å¨Çé¡¤¸Ð¶÷Àñ]")
end
function no()
    CloseDialog()
end

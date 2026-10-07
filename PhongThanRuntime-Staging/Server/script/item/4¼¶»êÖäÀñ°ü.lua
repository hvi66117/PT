tblFormulaList = {

    {
        { nName = "§o¹n Kh«ng Tr¶m", nDetail = 576, },
        { nName = "Thiªn Hµn Tr¶m", nDetail = 597, },
        { nName = "PhÖ ¶nh L«i Quang", nDetail = 618, },
        { nName = "Phi Sa TÈu Th¹ch", nDetail = 639, },
        { nName = "TuyÕt Vò B¨ng Phong", nDetail = 660, },
        { nName = "TÞch DiÖt Ch©n Háa", nDetail = 681, },
        { nName = "Cuång §µo TÕ", nDetail = 702, },
        { nName = "TuyÖt T©m Chó", nDetail = 723, },
    },

    {
        { nName = "Tô Hoa Hãa Th­¬ng", nDetail = 583, },
        { nName = "Thiªn ThÇn Né Hèng", nDetail = 604, },
        { nName = "Phong L«i Hé ThÓ", nDetail = 625, },
        { nName = "An Hån TÞnh Thæ", nDetail = 646, },
        { nName = "B¨ng Tinh Trïng Sinh", nDetail = 667, },
        { nName = "PhÇn Háa §å §»ng", nDetail = 688, },
        { nName = "Phóc Tr¹ch Thiªn Hùu", nDetail = 709, },
        { nName = "HoÆc T©m Chó", nDetail = 730, },
    },

    {
        { nName = "Cuång T©m Tr¶m", nDetail = 590, },
        { nName = "BÝch NguyÖt Tr¶m", nDetail = 611, },
        { nName = "LuyÖn Ngôc ThiÓm §iÖn", nDetail = 632, },
        { nName = "§Þa Háa PhÇn Thiªn", nDetail = 653, },
        { nName = "Thiªn Lý Truy Hån", nDetail = 674, },
        { nName = "Háa Tinh §äa L¹c", nDetail = 695, },
        { nName = "SËu Vò B¹o Phong", nDetail = 716, },
        { nName = "Ph¸ Qu©n Chó", nDetail = 737, },
    },
}

function main(nLevel, nTime, nTNpcIdx, itemID)
    local nType = IsItemBind(itemID)

    local opra = {
        "Hån Chó cÊp 80/SelectType",
        "Hån Chó cÊp 110/SelectType",
        "Hån Chó cÊp 140/SelectType",
    }
    SetTask(140, itemID)
    Say("H·y chän cÊp Hån Chó ngµi muèn nhËn", table.getn(opra), opra)
end
function SelectType(nIndex)
    no()
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > 3) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
        return
    end

    local nPlayerType = GetPlayerType() + 1
    local nStart = 0
    local nEnd = 0
    local opra = {}
    if (nPlayerType == 1) then
        nStart = 1
        nEnd = 2
    elseif (nPlayerType == 2) then
        nStart = 3
        nEnd = 6
    else
        nStart = 7
        nEnd = 8
    end
    for i = nStart, nEnd do
        opra[table.getn(opra) + 1] = tblFormulaList[nIndex][i].nName .. "/selectItem1"
    end
    SetTask(141, nIndex)
    Say("ÇëÑ¡ÔñÄúÒªÁìÈ¡µÄ»êÖä.", table.getn(opra), opra)
end

function selectItem1(nIndex)
    no()
    nIndex = nIndex + 1
    local nPlayerType = GetPlayerType() + 1
    local nSelectIndex = 0
    if (nPlayerType == 1) then
        if (nIndex < 1 or nIndex > 2) then
            Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
            return
        end
        nSelectIndex = nIndex
    elseif (nPlayerType == 2) then
        if (nIndex < 1 or nIndex > 4) then
            Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
            return
        end
        nSelectIndex = nIndex + 2
    else
        if (nIndex < 1 or nIndex > 2) then
            Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
            return
        end
        nSelectIndex = nIndex + 6
    end
    local nSelectType = GetTask(141)
    if (nSelectType < 1 or nSelectType > 3) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
        return
    end

    SetTask(142, nSelectIndex)
    MsgBox("Ngµi x¸c ®Þnh muèn nhËn " .. tblFormulaList[nSelectType][nSelectIndex].nName .. " kh«ng?", "YesGetSelect", "no")
end
function YesGetSelect()
    no()
    local itemID = GetTask(140)
    local nItemBind = IsItemBind(itemID)
    local nSelectType = GetTask(141)
    if (nSelectType < 1 or nSelectType > 3) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
        return
    end
    local nSelectIndex = GetTask(142)
    if (nSelectIndex < 1 or nSelectIndex > 8) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
        return
    end
    if (DelItemByID(itemID) > 0) then
        AddNormalItemBind(3, tblFormulaList[nSelectType][nSelectIndex].nDetail, 0, 0, 0, 0, nItemBind)
        Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc " .. tblFormulaList[nSelectType][nSelectIndex].nName .. ".")
        WriteLog("[KhuyÕn m¹i n¹p thÎ][LÔ bao Hån Chó][Më]" .. tblFormulaList[nSelectType][nSelectIndex].nName)
    end

end
function no()
    CloseDialog()
end

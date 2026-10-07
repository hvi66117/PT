tblFormulaList = {

    {
        { nName = "§o¹n Kh«ng Tr¶m", nDetail = 574, },
        { nName = "Thiªn Hµn Tr¶m", nDetail = 595, },
        { nName = "PhÖ ¶nh L«i Quang", nDetail = 616, },
        { nName = "Phi Sa TÈu Th¹ch", nDetail = 637, },
        { nName = "TuyÕt Vò B¨ng Phong", nDetail = 658, },
        { nName = "TÞch DiÖt Ch©n Háa", nDetail = 679, },
        { nName = "Cuång §µo TÕ", nDetail = 700, },
        { nName = "TuyÖt T©m Chó", nDetail = 721, },
    },

    {
        { nName = "Tô Hoa Hãa Th­¬ng", nDetail = 581, },
        { nName = "Thiªn ThÇn Né Hèng", nDetail = 602, },
        { nName = "Phong L«i Hé ThÓ", nDetail = 623, },
        { nName = "An Hån TÞnh Thæ", nDetail = 644, },
        { nName = "B¨ng Tinh Trïng Sinh", nDetail = 665, },
        { nName = "PhÇn Háa §å §»ng", nDetail = 686, },
        { nName = "Phóc Tr¹ch Thiªn Hùu", nDetail = 707, },
        { nName = "HoÆc T©m Chó", nDetail = 728, },
    },

    {
        { nName = "Cuång T©m Tr¶m", nDetail = 588, },
        { nName = "BÝch NguyÖt Tr¶m", nDetail = 609, },
        { nName = "LuyÖn Ngôc ThiÓm §iÖn", nDetail = 630, },
        { nName = "§Þa Háa PhÇn Thiªn", nDetail = 651, },
        { nName = "Thiªn Lý Truy Hån", nDetail = 672, },
        { nName = "Háa Tinh §äa L¹c", nDetail = 693, },
        { nName = "SËu Vò B¹o Phong", nDetail = 714, },
        { nName = "Ph¸ Qu©n Chó", nDetail = 735, },
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
    Say("H·y chän loai Hån Chó ngµi muèn nhËn, d­íi ®©y ®Òu lµ c¸c Hån Chó cÊp 2", table.getn(opra), opra)
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
        WriteLog("[LÔ bao Hån Chó cÊp 2][Më]")
    end

end
function no()
    CloseDialog()
end

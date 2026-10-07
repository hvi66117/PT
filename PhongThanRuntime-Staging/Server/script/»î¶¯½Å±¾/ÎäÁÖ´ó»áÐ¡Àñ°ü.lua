Symposium_ID = 1702

function main(nLevel, nTime, nTNpcIdx, itemID)
    DelItemByID(itemID)
    local nRand = math.random(1, 100)

    if (nRand >= 1 and nRand <= 50) then
        Earn(100000)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 100000 b¹c")
        WriteLog(GetName() .. " nhËn ®­îc 10 v¹n b¹c")
    elseif (nRand >= 51 and nRand <= 80) then
        AddNormalItem(8, 733, 2, 0, 0, 0)
        ScrollMessage("B¹n nhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá!")
        WriteLog(GetName() .. "NhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá")
    elseif (nRand >= 81 and nRand <= 100) then
        AddNormalItem(8, 35, 2, 1, 0, 0)
        ScrollMessage("Chóc mõng b¹n nhËn ®­îc 1 Di Ngo¹i Phï")
        WriteLog(GetName() .. "NhËn ®­îc 1 Di Ngo¹i Phï")
    end
end

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (IsHaveSpaceForTreasure(10) == 0) then
        Msg2Player("Kh«ng ®ñ chç chøa thiÖp c­íi!")
        return
    end
    for i = 1, 10 do
        AddNormalItem(3, 1068, 0, 0, 0, 0)
    end
    DelNormalItem(6, 1, 777, 0)
end

function no()
    CloseDialog()
end

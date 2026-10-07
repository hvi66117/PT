function main()
    local bYear, bMonth, bDay = GetAccountBirthDay()
    if (bYear == nil) or (bYear == 0) then
        Talk(1, "no", "Thä Tinh ®ang thóc ta t×m ra ®­îc ngµy sinh cña ng­¬i!...Thiªn c¬ bÊt kh¶ lËu!...")
    else
        Talk(1, "no", "8 ch÷ ngµy sinh nhËt cña b¹n lµ:<c=g>" .. bYear .. "<c> n¨m <c=g>" .. bMonth .. "<c> th¸ng <c=g>" .. bDay .. "<c> ngµy. Mçi n¨m ®Õn th¸ng sinh nhËt ®Õn <c=g>Thä Tinh ë Diªu Tr×<c> nhËn quµ sinh nhËt!")
    end
end

function no()
    CloseDialog()
end

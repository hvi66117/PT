function main()
    if (DelNormalItem(6, 1, 1567, 1) >= 1) then
    elseif (DelNormalItem(6, 1, 1567, 0) >= 1) then
    else
        Talk(1, "no", "Sö dông thÊt b¹i.")
        return 0
    end

    if (GetTitleFunc() == 0) then
        ActiveTitleFunc(1)
    end
    ActiveTitleQualify(145)
    SetCurTitle(145)
    Msg2Player("Ngµi nhËn ®­îc Ê®ÔØ³õĞÄ³ÆºÅ!")
    InfoBox("Ngµi nhËn ®­îc <c=g>Ê®ÔØ³õĞÄ<c>³ÆºÅ!")
    WriteLog("[ThËp Chu Niªn][Ê®ÔØ³õĞÄ³ÆºÅ]")
end

function no()
    CloseDialog()
end

function main()
    local myweight = GetNativeWeightMax()
    if (myweight >= 800) and (myweight < 900) then
        AddWeightMax(1)
        DelNormalItem(6, 1, 393, 1)
        TopMessage("<c=g>Søc lùc t¨ng thªm 1 ®iÓm")
    else
        Talk(1, "no", "§Þa Gi¸p m· chØ cã thÓ gióp b¹n t¨ng thªm 1 ®iÓm søc lùc (gi÷a 800 vµ 900 ®iÓm søc lùc). Muèn t¨ng thªm søc lùc ph¶i chän lo¹i ngùa kh¸c!")
    end
end

function no()
    CloseDialog()
end

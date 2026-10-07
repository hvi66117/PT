function main()
    local myweight = GetNativeWeightMax()
    if (myweight >= 1200) then
        AddWeightMax(1)
        DelNormalItem(6, 1, 396, 1)
        TopMessage("<c=g>Søc lùc t¨ng thªm 1 ®iÓm")
    else
        Talk(1, "no", "Phong Gi¸p m· chØ cã thÓ gióp b¹n t¨ng thªm 1 ®iÓm søc lùc (tõ 1200 ®iÓm søc lùc trë lªn). Muèn t¨ng thªm søc lùc ph¶i chän lo¹i ngùa kh¸c!")
    end
end

function no()
    CloseDialog()
end

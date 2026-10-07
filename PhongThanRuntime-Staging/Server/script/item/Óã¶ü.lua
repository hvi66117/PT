function main()
    if (HaveIBBuff(1125) > 0) then
        Talk(1, "no", "L­ìi c©u cña b¹n ®· mãc R©u Rång, kh«ng cÇn sö dông måi c©u n÷a!")
        return
    end

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Tr¹ng th¸i cña b¹n qu¸ nhiÒu, xin h·y quay l¹i sau!")
        return
    end

    AddIBBuff(898)
    DelNormalItem(6, 1, 705, 0)
end;

function no()
    CloseDialog()
end

function main()
    if (HaveIBBuff(898) > 0) then
        Talk(1, "no", "L­ìi c©u cña b¹n ®· cã måi c©u, kh«ng thÓ mãc thªm R©u Rång.")
        return
    end

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Tr¹ng th¸i cña b¹n qu¸ nhiÒu, xin h·y quay l¹i sau!")
        return
    end

    AddIBBuff(1125)
    DelNormalItem(6, 1, 761, 0)
end

function no()
    CloseDialog()
end;

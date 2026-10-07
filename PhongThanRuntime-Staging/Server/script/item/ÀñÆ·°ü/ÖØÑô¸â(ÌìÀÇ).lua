function main()
    if (GetIBBuffCount() >= 32) then
        AddNormalItem(6, 1, 725, 1, 0, 0, 0)
        InfoBox("B¹n cã qu¸ nhiÒu tr¹ng th¸i, kh«ng thÓ sö dông B¸nh Trïng D­¬ng!")
    else
        AddIBBuff(1038)
    end
end;

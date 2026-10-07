function main()
    local num = GetFormulaSpareCount(108)
    local level = GetLiveSkillLevel(6)
    if (level < 10) then
        Msg2Player("Muèn häc c¸ch lµm Cùc Kh«n Phï Dung §ç, ®¼ng cÊp nÊu n­íng ph¶i ®¹t cÊp10, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp nÊu n­íng kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm Cùc Kh«n Phï Dung §ç , c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 700, i) >= 1) then
                    DelNormalItem(6, 1, 700, i)
                    AddLvSkillFormula(108)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: Cùc Kh«n Phï Dung §ç ")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: Cùc Kh«n Phï Dung §ç ")
                    return
                end
            end
        end
    end
end;

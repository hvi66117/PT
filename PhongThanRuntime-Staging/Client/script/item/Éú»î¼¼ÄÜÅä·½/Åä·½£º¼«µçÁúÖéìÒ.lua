function main()
    local num = GetFormulaSpareCount(109)
    local level = GetLiveSkillLevel(6)
    if (level < 10) then
        Msg2Player("Muèn häc c¸ch lµm Cùc §iÖn Long Ch©u Bao, ®¼ng cÊp nÊu n­íng ph¶i ®¹t cÊp10, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp nÊu n­íng kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm Cùc §iÖn Long Ch©u Bao, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 701, i) >= 1) then
                    DelNormalItem(6, 1, 701, i)
                    AddLvSkillFormula(109)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: Cùc §iÖn Long Ch©u Bao")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: Cùc §iÖn Long Ch©u Bao")
                    return
                end
            end
        end
    end
end;

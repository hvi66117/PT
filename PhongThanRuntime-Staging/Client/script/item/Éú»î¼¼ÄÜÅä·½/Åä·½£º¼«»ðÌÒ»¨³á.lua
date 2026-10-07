function main()
    local num = GetFormulaSpareCount(107)
    local level = GetLiveSkillLevel(6)
    if (level < 10) then
        Msg2Player("Muèn häc c¸ch lµm C¸nh Cùc Háa §µo Hoa, ®¼ng cÊp nÊu n­íng ph¶i ®¹t cÊp10, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp nÊu n­íng kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm C¸nh Cùc Háa §µo Hoa, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 699, i) >= 1) then
                    DelNormalItem(6, 1, 699, i)
                    AddLvSkillFormula(107)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: C¸nh Cùc Háa §µo Hoa")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: C¸nh Cùc Háa §µo Hoa")
                    return
                end
            end

        end
    end
end;

function main()
    local num = GetFormulaSpareCount(104)
    local level = GetLiveSkillLevel(5)
    if (level < 10) then
        Msg2Player("Muèn häc c¸ch lµm TËt §iÖn §¬n, ®¼ng cÊp luyÖn ®¬n ph¶i ®¹t cÊp 10, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp luyÖn ®¬n kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm TËt §iÖn §¬n, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 696, i) >= 1) then
                    DelNormalItem(6, 1, 696, i)
                    AddLvSkillFormula(104)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: TËt §iÖn §¬n")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: TËt §iÖn §¬n")
                    return
                end
            end
        end
    end
end;

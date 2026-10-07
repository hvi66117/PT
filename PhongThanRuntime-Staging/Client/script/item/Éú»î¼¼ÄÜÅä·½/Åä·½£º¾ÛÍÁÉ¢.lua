function main()
    local num = GetFormulaSpareCount(126)
    local level = GetLiveSkillLevel(5)
    if (level < 6) then
        Msg2Player("Muèn häc c¸ch lµm Tô Thæ T¸n, ®¼ng cÊp luyÖn ®¬n ph¶i ®¹t cÊp 6, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp luyÖn ®¬n kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm Tô Thæ T¸n, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 722, i) >= 1) then
                    DelNormalItem(6, 1, 722, i)
                    AddLvSkillFormula(126)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: Tô Thæ T¸n")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: Tô Thæ T¸n")
                    return
                end
            end
        end
    end
end;

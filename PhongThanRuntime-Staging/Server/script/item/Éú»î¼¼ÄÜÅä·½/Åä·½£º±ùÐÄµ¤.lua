function main()
    local num = GetFormulaSpareCount(101)
    local level = GetLiveSkillLevel(5)
    if (level < 8) then
        Msg2Player("Muèn häc c¸ch lµm B¨ng T©m §¬n, ®¼ng cÊp luyÖn ®¬n ph¶i ®¹t cÊp 8, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp luyÖn ®¬n kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm B¨ng T©m §¬n, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 693, i) >= 1) then
                    DelNormalItem(6, 1, 693, i)
                    AddLvSkillFormula(101)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: B¨ng T©m §¬n")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: B¨ng T©m §¬n")
                    return
                end
            end
        end
    end
end;

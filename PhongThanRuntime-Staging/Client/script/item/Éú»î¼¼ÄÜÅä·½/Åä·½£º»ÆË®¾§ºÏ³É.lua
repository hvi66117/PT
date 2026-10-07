function main()
    local num = GetFormulaSpareCount(111)
    local level = GetLiveSkillLevel(7)
    if (level < 6) then
        Msg2Player("Muèn häc c¸ch hîp thµnh m¶nh Hoµng thñy tinh yªu cÇu ®¼ng cÊp chÕ luyÖn ®¹t cÊp 6, ®¼ng cÊp kü n¨ng cña b¹n kh«ng ®ñ ®Ó häc.")
        TopMessage("§¼ng cÊp chÕ luyÖn kh«ng ®ñ, kh«ng thÓ häc")
    else
        if (num == 200) then

            Msg2Player("Muèn häc c¸ch lµm m¶nh Hoµng thñy tinh, c¬ sè chÕ t¸c cña b¹n ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
            TopMessage("C¬ sè chÕ t¸c ®· ®¹t tèi ®a, kh«ng thÓ häc tiÕp")
        else

            for i = 0, 10 do
                if (HaveNormalItem(6, 1, 703, i) >= 1) then
                    DelNormalItem(6, 1, 703, i)
                    AddLvSkillFormula(111)
                    Msg2Player("Häc thµnh c«ng phèi ph­¬ng: hîp thµnh m¶nh Hoµng thñy tinh")
                    TopMessage("Häc thµnh c«ng phèi ph­¬ng: hîp thµnh m¶nh Hoµng thñy tinh")
                    return
                end
            end
        end
    end
end;

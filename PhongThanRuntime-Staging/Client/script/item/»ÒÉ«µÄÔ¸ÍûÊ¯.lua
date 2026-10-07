Task_TotalCount = 1763
Task_Plant = 1762

function main()
    if GetTaskByte(Task_TotalCount, 1) == 0 then
        Talk(1, "no", "Th­ cña Th­êng Thanh Thô: Ta cã mét nguyÖn väng, ®ã lµ mau cao lín vµ tr­êng thä! Ta nghe nãi Na Tra, LÔ Quan vµ Ng­êi h¸i thuèc ë T©y Kú cã lo¹i linh d­îc thÇn kú. Tõ 12-03 ®Õn 14-03 mçi tèi tõ 18h ®Õn 24h ta ®Òu nhê c¸c b»ng h÷u h¶o t©m gióp ta ®Õn ®ã xin linh d­îc. LÇn nµy b»ng h÷u cã thÓ gióp ta kh«ng?")
    else
        Talk(1, "no", "NguyÖn Väng Th¹ch: NguyÖn Väng Th¹ch ®· tÝch lòy" .. GetTaskByte(Task_Plant, 4) .. " ®iÓm tr­ëng thµnh.")
    end
end

function no()
    CloseDialog()
end

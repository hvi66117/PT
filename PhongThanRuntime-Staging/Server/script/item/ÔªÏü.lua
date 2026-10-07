function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()

    DelItemByID(itemId)

    local nYear, nMon, nDay = GetYMD()
    local str = ""
    if not (nYear == 2015 and ((nMon == 2 and nDay >= 28) or (nMon == 3 and nDay <= 15))) then
        Talk(1, "no", "ThËt xin lçi, »î¶¯Ê±¼äÒÑ¾­½áÊø, ÔªÏüÏûÊ§ÁË.")
        return
    end

    for i = 1, 100 do
        AddNormalItemBind(3, 6, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 1195, 0, 0, 0, 0, 1)
    for i = 1, 3 do
        AddNormalItemBind(8, 1447, 2, 0, 0, 0, 1)
    end
    for i = 1, 6 do
        AddNormalItemBind(6, 1, 1190, 1, 0, 0, 1)
    end
    AddNormalItemBind(8, 375, 4, 0, 0, 0, 1)

    if (IsHaveSpaceForTreasure(8) == 0) then
        Talk(1, "no", "ÄúµÄ±³°ü¿Õ¼ä<c=g>²»×ã7¸ñ<c>, ½±Àø¶¼µôÔÚµØÉÏÁË!")
    end
    Msg2Player("Më ÔªÏü nhËn ®­îc TruyÒn Thõa Th¹ch 1 c¸i, LÔ bao Danh Ngäc 3 c¸i, M¶nh Quang Dùc Chi VòËéÆ¬ 6 c¸i, ÓñÇåÉñÏÉÉ¢ 1 c¸i vµ ÇàÍ­1×é!")
    WriteLog("[ÔªÏü][Më]")
end

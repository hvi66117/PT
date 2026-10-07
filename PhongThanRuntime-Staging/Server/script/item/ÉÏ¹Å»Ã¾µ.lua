Task_renwu20 = 1377
Task_renwu20_distance = 1378

function main()
    CloseDialog()
    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Trªn ng­êi b¹n ®· cã qu¸ nhiÒu tr¹ng th¸i, kh«ng thÓ phãng thÝch hån ph¸ch .")
        return 0
    end

    if (HaveIBBuff(632) > 0) or (GetTaskByte(Task_renwu20, 2) ~= 1) then
        Talk(1, "no", "Hµng phôc <c=g>Cæ §iªu<c> míi cã ®­îc Tö Linh Minh Ch©u")
        return 0
    end

    if (GetLevel() < 20) or (GetTaskBit(Task_renwu20, 2) == 1 or GetTaskByte(Task_renwu20, 2) > 1) then
        if (DelNormalItem(6, 1, 474, 0) == 0) then
            DelNormalItemInQuick(6, 1, 474, 0)
        end
        Talk(1, "no", "Th­îng cæ Hoan KÝnh biÕn mÊt råi !")
        return 0
    end

    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= 14) then
        Talk(1, "no", "§ång Quan linh quan yÕu dÇn, ®Õn ®ã xem thùc h­ ®i.")
    else
        AddIBBuff(632)
        Talk(1, "no", "Tö Linh Minh Ch©u bÞ Cæ §iªu <c>ë §ång Quan<c=g> nuèt vµo bông råi ! B¹n ph¶i thu phôc 1 l­îng Cæ §iªu nhÊt ®Þnh míi lÊy ®­îc nã.")
    end ;
end;

function no()
    CloseDialog()
end	

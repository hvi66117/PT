BanQuan = 1498

Curr_HeroNPC_idx = 1499
Curr_HeroNPC_ID = 1500

function no()
    CloseDialog()
end;

function main()
    if (HaveIBBuff(749) == 0) then
        Talk(1, "no", GetName() .. ":Kh«ng biÕt tÝn vËt B¨ng Viªm Song Long ®· tiªu tan trong kh«ng khÝ tõ lóc nµo, chØ cßn l¹i 1 chiÕc vá máng manh.")
        SetTask(Curr_HeroNPC_idx, 0)
        SetTask(Curr_HeroNPC_ID, 0)
        return
    end

    local m, x, y = GetWorldPos()
    if (m ~= 76) then
        Talk(1, "no", GetName() .. ":Mau mang tÝn vËt ®Õn Th¸nh TuyÒn, hoµn thµnh t©m nguyÖn cña c¸c Dòng Gi¶ Trung Hån.")
        return
    end

    local distance = ((x - 1969) ^ 2 + (y - 3350) ^ 2) ^ 0.5 * 32

    if (distance < 300) then
        Talk(1, "no", GetName() .. ":TÝn vËt ®· ®Õn n¬i, ch¾c nh÷ng Trung Hån Êy ®· ®­îc an nghØ.")
        TopMessage("§· siªu ®é 1 <c=g>Dòng Gi¶ Trung Hån<c>")
        Msg2Player("§· siªu ®é 1 Dòng Gi¶ Trung Hån")
        RemoveIBBuff(749)
        AddIBBuff(751)
        SetTask(Curr_HeroNPC_idx, 0)
        SetTask(Curr_HeroNPC_ID, 0)
        SetTaskBit(BanQuan, 13, 1)
        ClearItem(6, 1, 535, 1)

        local num = GetTaskByte(BanQuan, 4)
        num = num + 1
        if num < 5 then
            SetTaskByte(BanQuan, 4, num)
            TaskNote(1086, 1, num)
        else
            TaskNote(1086, 2)
        end
    else
        Talk(1, "no", GetName() .. ":Ng­¬i ph¶i mang tÝn vËt B¨ng Viªm Song Long ®Õn gÇn Th¸nh TuyÒn<c=g>(246,209)<c>.")
    end
end;

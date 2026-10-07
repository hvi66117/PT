snow_renwu = 1385
snow_point = 1386
Global_snow_EntryCount = 183
Global_snow_index = 184

function main(sel)
    if (HaveIBBuff(639) == 0) and (HaveIBBuff(642) == 0) then
        Talk(1, "no", "Trong cuéc thi nÐm TuyÕt míi ®­îc sö dông !")
    elseif (GetTaskByte(snow_renwu, 3) == 1) then
        SetTaskByte(snow_renwu, 3, 2)
        if (DelNormalItem(6, 1, 478, 1) == 0) then
            DelNormalItemInQuick(6, 1, 478, 1)
        end
        TopMessage("Cã thÓ nÐm TuyÕt, sö dông lß s­ëi råi")
        if (GetTaskByte(snow_renwu, 4) == 1) then
            Msg2Player("Cuéc chiÕn b¾t ®Çu, ®èi thñ cña b¹n ë phÝa §«ng B¾c, mau ®i ®i !")
        else
            Msg2Player("Cuéc chiÕn b¾t ®Çu, ®èi thñ cña b¹n ë phÝa T©y Nam, mau ®i ®i !")
        end
        if (GetMissionV(11, 3) > GetMissionV(11, 4)) then
            NewTaskNote(203, 6, 1, "<c=water>§éi xanh<c>", 0, 0)
        elseif (GetMissionV(11, 3) == GetMissionV(11, 4)) then
            NewTaskNote(203, 6, 1, "C«ng b»ng", 0, 0)
        else
            NewTaskNote(203, 6, 1, "<c=r>§éi ®á<c>", 0, 0)
        end
        SetCursorStyle(31)
        AddSpecialSkill(222, 1, 2)
        SetClientRightSkill(222)
    else
        Talk(1, "no", "§· sö dông G¨ng tay råi, kh«ng sö dông l¹i n÷a")
    end ;
end

function no()
    CloseDialog()
end;

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

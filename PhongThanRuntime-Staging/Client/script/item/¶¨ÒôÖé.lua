TASK_ID_HHEJ = 1233
BUFF_ID_JHDQ = 459

function main()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    if (taskStatus < 11) then
        Talk(1, "no", GetName() .. ":VËt nµy yªu khÝ nÆng qu¸, kh«ng thÓ tïy tiÖn më ®­îc!")
    elseif (taskStatus == 13) then
        Talk(1, "no", GetName() .. " Ph¸p b¶o nµy ®· hÕt linh lùc, kh«ng cßn t¸c dông n÷a!")
    else
        AddIBBuff(BUFF_ID_JHDQ)
    end
end;

function no()
    CloseDialog()
end;

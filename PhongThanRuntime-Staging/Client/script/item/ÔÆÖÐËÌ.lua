Task_Thunder_Status = 1469
Task_Thunder_Time = 1470

Global_Thunder = 210

Task_Info_Thunder = 1079

function main()
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    if (taskStatus == 1) then
        SetTaskByte(Task_Thunder_Status, 1, 2)
        TaskNote(Task_Info_Thunder, 1)
        Talk(1, "no", "Thiªn ®¹o khã thµnh…Sau khi Danh väng tiªn  ma ®¹t ®Õn <c=r>45000<c> cã thÓ ®i t×m Ngé Ch©n Nh©n <c>thÇn bÝ<c=g>. ¤ng ta trong thêi gian tõ 6 giê ®Õn 12 giê mçi tèi sÏ xuÊt hiÖn ë BÊt Chu s¬n.")
    elseif (taskStatus == 2) then
        Talk(1, "no", "Thiªn ®¹o khã thµnh…Sau khi Danh väng tiªn  ma ®¹t ®Õn <c=r>45000<c> cã thÓ ®i t×m Ngé Ch©n Nh©n <c>thÇn bÝ<c=g>. ¤ng ta trong thêi gian tõ 6 giê ®Õn 12 giê mçi tèi sÏ xuÊt hiÖn ë BÊt Chu s¬n.")
    else
        DelNormalItem(6, 1, 520, 1)
        Talk(1, "no", GetName() .. "VËt nµy hiÖn t¹i ®· v« dông råi.")
    end
end

function no()
    CloseDialog()
end

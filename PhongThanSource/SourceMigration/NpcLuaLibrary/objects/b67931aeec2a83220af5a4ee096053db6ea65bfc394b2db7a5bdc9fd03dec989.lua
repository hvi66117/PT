gItemGen = 8
gItemDetail = 1453
gItemPart = 2

Task_ItemNum = 1853
Task_KillNum = 1854
Task_ItemFree = 1856

function OnDeath(nNpcIdx)
    if (PlayerIndex <= 0) then
        return
    end

    AddNormalItemBind(6, 1, 942, 1, 0, 0, 1)
    Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>Siªu ®é Hoµng Kim U TÞch trong TÕ Uyªn Cèc, nhËn thªm 1 Linh Hån TÕ PhÈm. ")
    WriteLog("TÕ Uyªn Cèc: ®¸nh b¹i Hoµng Kim U TÞch. ")

    DelNpc(nNpcIdx)
end;

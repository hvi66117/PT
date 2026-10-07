Task_ChildrensDayReceive = 1703
Task_ChildrensDayReceiveNum = 1704
Task_ChildrensDayReceiveTodayNum = 1705
Task_ChildrensDay = 1706

Task_ChildrensToday = 1707

Glocal_ChildrenGiftNum = 373
Save_ChilrensDayTree_Num = "Save_ChilrensDay_Tree_Num"

function main()

    if (HaveNormalItem(6, 1, 840, 0) == 0) then
        return
    end

    if (GetTaskByte(Task_ChildrensDay, 1) >= 4 and GetTaskByte(Task_ChildrensDay, 1) <= 7) then
        Talk(1, "no", "Ng­¬i ®· trång 1 C©y Høa NguyÖn råi, nÕu muèn tiÕp tôc trång, cÇn t×m Na Tra nhËn Xu©n Phong Vò Lé. ")
        return
    end

    local mapid, nX, nY = GetWorldPos()

    if (mapid ~= 22) then
        Talk(1, "no", "H¹t C©y Høa NguyÖn lµ vËt quý hiÕm, chØ trång ë <c=g>Hoang m¹c<c> míi cã thÓ tr­ëng thµnh!")
        return
    end

    local Year, Mon, Dat = GetYMD()
    if Year ~= 2010 or ((Mon == 5 and (Dat < 28 or Dat > 31)) or (Mon == 6 and (Dat < 1 and Dat > 4))) then
        Talk(1, "no", "Ng­¬i ®· bá lì thêi gian trång trät, chØ cã thÓ trång mÇm c©y trong thêi gian ho¹t ®éng!")
        return
    end

    MsgBox("B¹n muèn trång t«i ë ®©y ­?", "throwTree", "no")

end

function throwTree()

    CloseDialog()

    if (HaveNormalItem(6, 1, 840, 0) <= 0) then
        return
    end

    local nWorldID, nX, nY = GetWorldPos()
    local npcindex = AddNpc(1824, 1, SubWorld, nX * 32, nY * 32)

    if npcindex > 0 then

        DelNormalItem(6, 1, 840, 0)

        SetNpcName(npcindex, GetName() .. "-<c=g>C©y Høa NguyÖn<c>-MÇm c©y")
        SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 3600)
        SetNpcScript(npcindex, "\\script\\»î¶¯½Å±¾\\ÐíÔ¸Ê÷.lua")

        SetTaskByte(Task_ChildrensDay, 1, 4)
        SetNpcTask(npcindex, 1, GetPlayerID())

        Msg2Player("Ng­¬i ®· trång thµnh c«ng 1 C©y Høa NguyÖn!")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> ®· trång C©y Høa NguyÖn thµnh c«ng!")

        WriteLog(GetName() .. "§· trång C©y Høa NguyÖn.")
    else
        Talk(1, "no", "TiÕc qu¸! H¹t gièng cña b¹n lµ gi¶, kh«ng thÓ trång trät.")
        return
    end

end

function no()
    CloseDialog()
end

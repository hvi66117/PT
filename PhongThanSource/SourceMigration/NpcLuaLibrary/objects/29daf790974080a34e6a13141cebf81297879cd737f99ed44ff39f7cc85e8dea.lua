--Add By Guoqun for Êî¼Ù»î¶¯ at 2010-07-09 begin
Task_State = 1710    -- ¼ÇÂ¼ÈÎÎñ×´Ì¬
-- 1Byte£ºÈÎÎñ±àºÅ (ÈÎÎñ1£º1-9£¬ÈÎÎñ2£º10-19£»ÈÎÎñ3:20-¡·)
-- 2Byte:  ÈÎÎñ²½Öè
-- 3Byte:  ½ÓÈÎÎñÊ±¼ä
Fazhen_Index = 1714
Fazhen_ID = 1715

Boss_TemplateID = {
    { ID = 1821, nLevel = 60 },
    { ID = 1822, nLevel = 80 },
    { ID = 1823, nLevel = 100 },
}

function main()
    local nYear, nMonth, nDay = GetYMD();
    if nYear == 2010 and nMonth == 7 and nDay >= 20 and nDay <= 26 then
        local nMapId, nX, nY = GetWorldPos();

        if nMapId ~= 37 then
            InfoBox("ChØ cã thÓ triÖu håi Thñ vÖ t¹i §«ng H¶i Thñy Vùc!")
            return
        end

        local nLevel = GetLevel();

        local nBossIdx = 1;

        if nLevel >= 50 and nLevel <= 70 then
            nBossIdx = 1;
        elseif nLevel > 70 and nLevel <= 90 then
            nBossIdx = 2;
        else
            nBossIdx = 3;
        end

        local nNpcIdx = AddNpc(Boss_TemplateID[nBossIdx].ID, Boss_TemplateID[nBossIdx].nLevel, SubWorld, nX * 32, nY * 32);

        if nNpcIdx > 0 then
            SetTask(Fazhen_Index, nNpcIdx);
            SetTask(Fazhen_ID, GetNpcID(nNpcIdx));
            SetTaskByte(Task_State, 2, 2);    --	ÒÑ¾­ÊÍ·ÅÁË¹ÖÎï

            SetNpcTask(nNpcIdx, 1, GetPlayerID());    --¹ÖÎïÉíÉÏ¼ÇÂ¼Íæ¼ÒµÄID

            ClearItem(6, 1, 842, 0);

            TaskNote(1606, 5)

            SetNpcName(nNpcIdx, "<c=fire>§«ng H¶i Thñ VÖ<c>")
            SetNpcScript(nNpcIdx, "\\script\\»î¶¯½Å±¾\\»ðÑæÖé.lua");
            SetNpcTimer(nNpcIdx, "\\script\\»î¶¯½Å±¾\\»ðÑæÖé.lua", 3 * 60);

            Msg2Player("Néi trong 3 phót ph¶i ®¸nh b¹i §«ng H¶i Thñ VÖ! §«ng H¶i Thñ VÖ chØ xuÊt hiÖn 3 phót!")
        else
            InfoBox("TriÖu håi §«ng H¶i Thñ VÖ thÊt b¹i! L¸t n÷a h·y thö l¹i nhÐ!")
        end
    else
        ClearItem(6, 1, 842, 0);
        Msg2Player("Ho¹t ®éng Thanh l­¬ng h¹ quý ®· kÕt thóc, vËt phÈm thu håi!")
    end
end

function OnDeath(npcidx)

    local nPlyID = GetNpcTask(npcidx, 1);

    local nPlyIndex = SearchPlayerById(nPlyID);
    local nOldPlyIdx = PlayerIndex
    if nPlyIndex > 0 then
        if Check_PlyInTeam(nPlyID) > 0 then
            PlayerIndex = nPlyIndex
            if IsHaveSpaceForTreasure(1) == 0 then
                Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®­îc TÈm ThÊp Hoµn");
            else
                local nTep = random(1, 100);
                local nCount = 0;
                if nTep <= 40 then
                    nCount = 3
                elseif nTep > 40 and nTep <= 80 then
                    nCount = 4
                else
                    nCount = 5
                end

                for i = 1, nCount do
                    AddNormalItemPile(3, 1126, 0, 1, 0, 0);
                end ;
                TopMessage("NhËn ®­îc" .. nCount .. " TÈm ThÊp Hoµn");
                Msg2Player("NhËn ®­îc" .. nCount .. " TÈm ThÊp Hoµn");
                WriteLog("NhËn ®­îc TÈm ThÊp Hoµn" .. nCount .. ".")
                TaskNote(1606, -1)
                SetTaskByte(Task_State, 1, 29);
            end
        else
            PlayerIndex = nPlyIndex;
            Msg2Player("§«ng H¶i Thñ VÖ b¹n triÖu håi ra ®· bÞ ng­êi kh¸c ®¸nh b¹i, nhiÖm vô thÊt b¹i!");
            TaskNote(1606, -1)
            SetTaskByte(Task_State, 1, 29);
        end
    end ;
    PlayerIndex = nOldPlyIdx;
    DelNpc(npcidx)

end

function Check_PlyInTeam(nPlyID)
    --·µ»ØÖµ£º1:OK 0£ºnot OK
    local nPlyIndex = PlayerIndex;

    local nSize = GetTeamSize();

    if nSize > 1 then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i);
            if nPlyID == GetPlayerID() then
                return 1;
            end
        end
    else
        if GetPlayerID() == nPlyID then
            return 1
        end
    end

    return 0

end

function OnTimer(npcidx)
    local nPlyID = GetNpcTask(npcidx, 1);

    local nPlyIndex = SearchPlayerById(nPlyID);
    local nOldPlyIdx = PlayerIndex
    if nPlyIndex > 0 then
        PlayerIndex = nPlyIndex
        Msg2Player("Trong thêi gian quy ®Þnh b¹n kh«ng thÓ ®¸nh b¹i §«ng H¶i Thñ VÖ, nhiÖm vô thÊt b¹i!");
        TaskNote(1606, -1)
        SetTaskByte(Task_State, 1, 29);
    end
    PlayerIndex = nOldPlyIdx

    DelNpc(npcidx)
end

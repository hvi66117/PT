TASK_ThreeYears_Fireworks = 1724;

TASK_ThreeYears_Questions = 1725;

G_ThreeYears_1stFireworksId = 1318;

TASK_ThreeYears_Blessing = 1726;

BUFF_ThreeYears_Blessing_1stBuff = 773;
BUFF_ThreeYears_Blessing_Effect = 1324;

BUFF_ThreeYears_Clear = 1325;

function main()

    if (HaveNormalItem(6, 1, 851, 0) == 0) then
        InfoBox("Ng­¬i kh«ng cã Tói quµ kû niÖm 3 n¨m.");
        return
    end

    DelNormalItem(6, 1, 851, 0);
    TaskNote(1611, -1);

    if (GetTaskByte(TASK_ThreeYears_Blessing, 1) ~= 2) then
        InfoBox("Ng­¬i ch­a hoµn thµnh nhiÖm vô ChuyÓn lêi chóc phóc");
        return
    end

    local TotalNum = LoadIniInteger("G_ThreeYears_GiftNum", 1);
    local PLogoNum = LoadIniInteger("G_ThreeYears_GiftNum", 2);
    local TLogoNum = LoadIniInteger("G_ThreeYears_GiftNum", 3);
    local MoneyNum = LoadIniInteger("G_ThreeYears_GiftNum", 4);

    local PlayerLevel = GetLevel();
    local y1, m1, d1 = GetYMD();
    local w, x, y = GetWorldPos();
    local rand = math.random(1, 1000);

    if (w == 21) then

        SaveIniInteger("G_ThreeYears_GiftNum", 1, TotalNum + 1);

        if (TotalNum > 99 and PLogoNum == 0) then

            if (GetPlayerType() == 1) then
                AddNormalItem(0, 4, 67, 1, 0, 0);
            else
                AddNormalItem(0, 4, 66, 1, 0, 0);
            end

            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            SaveIniInteger("G_ThreeYears_GiftNum", 2, PLogoNum + 1);
            Msg2Player("B¹n nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai (vÜnh viÔn).");
            AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai!", 1)
            return
        end

        if (rand <= 10 and PLogoNum < 2) then

            if (GetPlayerType() == 1) then
                AddNormalItem(0, 4, 67, 1, 0, 0);
            else
                AddNormalItem(0, 4, 66, 1, 0, 0);
            end

            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            SaveIniInteger("G_ThreeYears_GiftNum", 2, PLogoNum + 1);
            Msg2Player("B¹n nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai (vÜnh viÔn).");
            AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai!", 1);
            return
        end

        if (rand <= 40 and TLogoNum < 7) then

            if (GetPlayerType() == 1) then
                AddNormalItem(0, 4, 65, 1, 0, 0);
            else
                AddNormalItem(0, 4, 64, 1, 0, 0);
            end

            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            SaveIniInteger("G_ThreeYears_GiftNum", 3, TLogoNum + 1);
            Msg2Player("B¹n nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai.");
            WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc ThÊt TrÇn Trai logo Ph¸p b¶o (60 ngµy).");
            AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Ph¸p b¶o ThÊt TrÇn Trai!", 1);
            return
        end

        if (rand <= 70 and PlayerLevel > 70 and MoneyNum < 11) then

            Earn(1000000);
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Tói quµ kû niÖm nhËn ®­îc <color=green>100 v¹n<color> b¹c.");
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Tói quµ kû niÖm nhËn ®­îc <color=green>100 v¹n<color> b¹c.");
            SaveIniInteger("G_ThreeYears_GiftNum", 4, MoneyNum + 1);
            Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.");
            WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc 100 v¹n b¹c.");
            AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc 100 v¹n b¹c!", 1);
            return
        end

    end

    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> ®· më Tói quµ kû niÖm.");

    if (rand <= 240) then
        AddNormalItemBind(8, 28, 3, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Thanh Lé (tiÓu).");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Thanh Lé (tiÓu).");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Thanh Lé (tiÓu)!", 1);
    elseif (rand <= 410) then
        AddNormalItemBind(8, 29, 4, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Ch©n Khİ (tiÓu).");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ch©n Khİ (tiÓu).");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Ch©n Khİ (tiÓu)!", 1);
    elseif (rand <= 580) then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc D· Ngo¹i TruyÒn Phï.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc D· Ngo¹i TruyÒn Phï.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc D· Ngo¹i TruyÒn Phï!", 1);
    elseif (rand <= 690) then
        AddNormalItemBind(8, 733, 2, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá!", 1);
    elseif (rand <= 790) then
        AddNormalItemBind(8, 205, 2, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Håi Quèc Phï.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Håi Quèc Phï.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Håi Quèc Phï!", 1);
    elseif (rand <= 830) then
        AddNormalItemBind(8, 330, 0, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc L©m Tiªn Lé.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc L©m Tiªn Lé.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc L©m Tiªn Lé!", 1);
    elseif (rand <= 870) then
        AddNormalItemBind(8, 135, 2, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc ChØ Nh©n.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc ChØ Nh©n.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc ChØ Nh©n!", 1);
    elseif (rand <= 900) then
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Sinh MÖnh Thanh Lé.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Sinh MÖnh Thanh Lé.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Sinh MÖnh Thanh Lé!", 1);
    elseif (rand <= 930) then
        AddNormalItemBind(8, 163, 4, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Ch©n Khİ.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Ch©n Khİ.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Ch©n Khİ!", 1);
    elseif (rand <= 950) then
        AddNormalItemBind(8, 199, 4, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc S¬n Thñy Ch©n Khİ.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc S¬n Thñy Ch©n Khİ.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc S¬n Thñy Ch©n Khİ!", 1);
    elseif (rand <= 970) then
        AddNormalItemBind(8, 198, 3, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc B¶o T¸ Thanh Lé.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc B¶o T¸ Thanh Lé.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc B¶o T¸ Thanh Lé!", 1);
    elseif (rand <= 990) then
        AddNormalItemBind(8, 214, 2, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Hµnh Qu©n LÖnh.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Hµnh Qu©n LÖnh.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Hµnh Qu©n LÖnh!", 1);
    else
        AddNormalItemBind(8, 374, 0, 0, 0, 0, 1);
        Msg2Player("B¹n nhËn ®­îc Dao Tiªn T¸n.");
        WriteLog("Më Tói quµ kû niÖm 3 n¨m nhËn ®­îc Dao Tiªn T¸n.");
        AddEvent("%s më Tói quµ kû niÖm nhËn ®­îc Dao Tiªn T¸n!", 1);
    end

end

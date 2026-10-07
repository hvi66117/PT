require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(2) == 1) then

        if (GetJusticEvilCredit() > 0) then
            Say("Sö dông sÏ lËp tøc chuyÓn ®Õn khu vùc cña Tiªn Ma Giíi.", 3, "BÊt Chu Thiªn Quan/v1", "BÊt Chu S¬n/v2", "Ngôc Ph¸p s¬n/v3")
        else
            Say("Sö dông sÏ lËp tøc chuyÓn ®Õn khu vùc cña Tiªn Ma Giíi.", 3, "BÊt Chu Thiªn Quan/v11", "BÊt Chu S¬n/v21", "Ngôc Ph¸p s¬n/v31")
        end


    end

    SetExeState(0)
end

function no()
    CloseDialog()
end

function v1()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        else
            NewWorld(73, 1971, 3798)
            SetFightState(0)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v11()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        else
            NewWorld(73, 1613, 3247)
            SetFightState(0)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v2()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        elseif (GetWorldEventProgress(2) ~= 2001) then
            Msg2Player("§­êng ®Õn BÊt Chu S¬n ch­a më, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn BÊt Chu S¬n.")
        elseif (GetTaskByte(1326, 1) ~= 3) then
            Msg2Player("B¹n vÉn ch­a cã kinh nghiÖm øng §é Thiªn KiÕp, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn BÊt Chu S¬n")
        else
            NewWorld(74, 1728, 3745)
            SetFightState(0)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v21()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        elseif (GetWorldEventProgress(2) ~= 2001) then
            Msg2Player("§­êng ®Õn BÊt Chu S¬n ch­a më, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn BÊt Chu S¬n.")
        elseif (GetTaskByte(1326, 1) ~= 3) then
            Msg2Player("B¹n vÉn ch­a cã kinh nghiÖm øng §é Thiªn KiÕp, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn BÊt Chu S¬n")
        else
            NewWorld(74, 1636, 3659)
            SetFightState(0)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v3()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        elseif (GetWorldEventProgress(3) ~= 2001) then
            Msg2Player("§­êng ®Õn Ngôc Ph¸p S¬n ch­a më, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn Ngôc Ph¸p S¬n")
        elseif (IsJEMainTaskComplete(2) == 0) then
            Msg2Player("B¹n vÉn ch­a cã kinh nghiÖm L«i §×nh Khëi LiÖt, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn Ngôc Ph¸p S¬n")
        else
            NewWorld(75, 1850, 3568)
            SetFightState(1)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v31()
    if (HaveNormalItem(6, 1, 576, 0) > 0) or (HaveNormalItemInQuick(6, 1, 576, 0) > 0) then
        if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
        elseif (GetWorldEventProgress(3) ~= 2001) then
            Msg2Player("§­êng ®Õn Ngôc Ph¸p S¬n ch­a më, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn Ngôc Ph¸p S¬n")
        elseif (IsJEMainTaskComplete(2) == 0) then
            Msg2Player("B¹n vÉn ch­a cã kinh nghiÖm L«i §×nh Khëi LiÖt, B«n L«i Chi Lùc kh«ng thÓ ®­a b¹n ®Õn Ngôc Ph¸p S¬n")
        else
            NewWorld(75, 1890, 3353)
            SetFightState(1)
            if (DelNormalItem(6, 1, 576, 0) == 0) then
                DelNormalItemInQuick(6, 1, 576, 0)
            end
        end ;
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

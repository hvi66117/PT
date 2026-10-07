--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25

--¶È½ÙÈÎÎñÊ±¼äºÍÈÎÎñ±äÁ¿
Task_DuJie_Value = 1326   -- 1 byte ÈÎÎñ²½Öè±äÁ¿2 byteÊ±¼ä 3ÒªÉ±ËÀ¹ÖµÄ¸öÊı

Global_Lamp_LightCount = 167 -- 1byteÈ«¾Ö±äÁ¿£¬ÁÁµÆÊıÁ¿ 2byte ÉÏ´ÎÁÁµÆ·½,1ÏÉ,2Ä§
--È«¾Ö±äÁ¿ÔÚ·şÎñÆ÷Í£Ö¹ÔËĞĞºó²»ÄÜ±£´å£¬Ê¹ÓÃWorldEventTask
WorldEventTask = 2  --1 taskvalue¼ÇÂ¼ÏÉ·½Íê³É¶È½ÙÈÎÎñ´ÎÊı
--2 taskvalue¼ÇÂ¼Ä§·½Íê³É¶È½ÙÈÎÎñ´ÎÊı
--3 taskvalue¿ªÆôºÍ½áÊø¶È½ÙÈÎÎñµÄ¹«¸æ

starttimehour = 18
starttimemin = 0
starttimesec = 0

endtimehour = 23
endtimemin = 59
endtimesec = 0

Point_init = 20

saytaskstring = {
    [1] = "§é kiÕp lµ kiÕp n¹n mµ bÊt cø Tiªn gi¶ nµo còng ph¶i ®i qua. NÕu ®¹o h÷u ®· quyÕt chİ, th× nªn t×m thªm 1 Ph¸p b¶o cã thÓ kh¸ng L«i, sÏ t¨ng thªm hiÖu qu¶ thµnh c«ng!",
    [2] = "§é kiÕp lµ kiÕp n¹n mµ bÊt cø Ma gi¶ nµo còng ph¶i ®i qua. NÕu ®¹o h÷u ®· quyÕt chİ, th× nªn t×m thªm 1 Ph¸p b¶o cã thÓ kh¸ng Ho¶, sÏ t¨ng thªm hiÖu qu¶ thµnh c«ng!",
    [3] = "§¹o h÷u míi ®ã mµ ®· ®¹t thµnh ch¸nh qu¶ nh­ vËy, thËt ®¸ng kh©m phôc!",
    [4] = "§¹o h÷u míi ®ã mµ ®· ®¹t thµnh ch¸nh qu¶ nh­ vËy, thËt ®¸ng kh©m phôc!",
}

talktaskstring = {
    [1] = "HiÖn t¹i Ma giíi 6 ngän Liªn ®¨ng ®Òu ®· ®­îc th¾p s¸ng, ®· ®Õn thêi c¬ Thiªn KiÕp cho c¸c ®¹o h÷u Ma giíi råi! Tiªn giíi ®¹o h÷u cÇn ph¶i chê ®îi hoÆc nç lùc th¾p s¸ng Liªn ®¨ng cña phe m×nh th«i!",
    [2] = "HiÖn t¹i Tiªn giíi 6 ngän Liªn ®¨ng ®Òu ®· ®­îc th¾p s¸ng, ®· ®Õn thêi c¬ Thiªn KiÕp cho c¸c ®¹o h÷u Tiªn giíi råi! Ma giíi ®¹o h÷u cÇn ph¶i chê ®îi hoÆc nç lùc th¾p s¸ng Liªn ®¨ng cña phe m×nh th«i!",
    [3] = "Tiªn Ma giíi l¹i ph¸t khëi binh ®ao, t¹o ho¸ l¹i an bµy g× n÷a ®©y? ¤i…",
}

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local tasks = {
        { "Thiªn KiÕp gi¸ng l©m (Tiªn)", "faeriedujie"; show = 0 },
        { "Thiªn KiÕp gi¸ng l©m (Ma)", "evildujie"; show = 0 },
        { "Hoµn thµnh §é kiÕp (Tiªn)", "finishfaeriedujie"; show = 0 },
        { "Hoµn thµnh §é kiÕp (Ma)", "finishevildujie"; show = 0 },
    }

    --»ñÈ¡ÁÁµÆ×´Ì¬
    local status = getlampalllightstatus()
    --²»ÔÚÊ±¼ä·¶Î§Ö®ÄÚ£¨20:00~22:00£©Ö®¼ä 
    if (status == 0) then
        Talk(1, "no", "Tiªn Ma giíi l¹i ph¸t khëi binh ®ao, t¹o ho¸ l¹i an bµy g× n÷a ®©y? ¤i…")--²»ÔÚÊ±¼ä·¶Î§ÄÚ£¬ÎÒÔõÃ´¾Í³öÉúÁËÄØ?
        return 0
    end

    if (status == 3) then
        Talk(1, "no", "BÊt cø phe nµo (Tiªn hoÆc Ma) th¾p s¸ng lªn ®­îc 6 ngän Liªn ®¨ng, th× c¸c ®ång h÷u cña phe ®ã ®Òu cã c¬ héi kh¶o nghiÖm Thiªn KiÕp")--Ã»ÓĞÒ»·½ÕóÓªµÄµÆÊÇÈ«ÁÁµÄ
        return 0
    end

    -- saystatus 1~10ÎªSayTaskµÄÁÄÌìÌáÊ¾£¬11~20ÎªTalkµÄ¶Ô»°ÌáÊ¾
    -- [1] = ÏÉ·½½éÉÜÒ»ÏÂÕâ¸öÈÎÎñ
    -- [2] = Ä§·½½éÉÜÒ»ÏÂÕâ¸öÈÎÎñ
    -- [3] = ÏÉ·½Íê³ÉÁËÕâ¸öÈÎÎñ
    -- [4] = Ä§·½Íê³ÉÁËÕâ¸öÈÎÎñ
    --[11] = Ä§·½µÆÈ«²¿µãÁÁÁË£¬ÄãÊÇÏÉ·½µÄ
    --[12] = ÏÉ·½µÆÈ«²¿µãÁÁÁË£¬ÄãÊÇÄ§·½µÄ
    local saystatus = 0
    local credit = GetJusticEvilCredit()

    --Íæ¼ÒÒÑ¾­Íê³ÉÁËÈÎÎñ
    local taskstep = isfinishtask()
    if (taskstep == 3) then
        Talk(1, "no", "§é kiÕp lµ c¬ héi ®Ó tho¸t thai ®æi cèt, kh«ng ph¶i ai còng cã thÓ ®¹t ®­îc phóc duyªn nµy!")--Íæ¼ÒÒÑ¾­Íê³ÉÁË
        return 0
    end

    if (taskstep == 2 or taskstep == 0) then
        --Ã»ÓĞÍê³ÉÈÎÎñ,ÕıÔÚÈÎÎñÖĞ 
        if (credit > 0) then
            --×Ô¼ºÊÇÏÉÈË£¬ÕæÅ£b
            if (status == 1) then
                tasks[1].show = 1
                saystatus = 1                --ÏÉ·½½éÉÜÒ»ÏÂÕâ¸öÈÎÎñ 
            elseif (status == 2) then
                saystatus = 11                --Ä§·½µÆÈ«²¿µãÁÁÁË£¬±§Ç¸ÏÉÈË²»ÊÇÕâ»ïµÄ 
            end
        else
            --×Ô¼ºÊÇ¶ñÄ§£¬ÕæË¥
            if (status == 1) then
                saystatus = 12                --ÏÉ·½µÆÈ«²¿µãÁÁÁË£¬±§Ç¸Ä§ÈË²»ÊÇÕâ»ïµÄ  
            elseif (status == 2) then
                tasks[2].show = 1
                saystatus = 2                --Ä§·½½éÉÜÒ»ÏÂÕâ¸öÈÎÎñ 
            end
        end
    elseif (taskstep == 1) then
        --Íê³ÉÈÎÎñ 
        if (credit > 0) then
            --×Ô¼ºÊÇÏÉÈË£¬ÕæÅ£b
            if (status == 1) then
                tasks[3].show = 1
                saystatus = 3                --ÏÉ·½Íê³ÉÁËÕâ¸öÈÎÎñ 
            elseif (status == 2) then
                saystatus = 11                --Ä§·½µÆÈ«²¿µãÁÁÁË£¬±§Ç¸ÏÉÈË²»ÊÇÕâ»ïµÄ 
            end
        else
            --×Ô¼ºÊÇ¶ñÄ§£¬ÕæË¥xx
            if (status == 1) then
                saystatus = 12                --ÏÉ·½µÆÈ«²¿µãÁÁÁË£¬±§Ç¸Ä§ÈË²»ÊÇÕâ»ïµÄ  
            elseif (status == 2) then
                tasks[4].show = 1
                saystatus = 4                --Ä§·½Íê³ÉÁËÕâ¸öÈÎÎñ 
            end
        end
    end

    if (saystatus > 10) then
        Talk(1, "no", talktaskstring[saystatus - 10])
    else
        SayTask(saytaskstring[saystatus], tasks)
    end

end;

--ÅĞ¶ÏÊÇ²»ÊÇÒ»ÌìµÄº¯Êı 
function issameday()
    local today = floor(LocalSystemTime() / 86400)
    local lastday = GetByte(GetTask(Task_DuJie_Value), 2)
    if (today == lastday) then
        return 1  --²»ÊÇÒ»Ìì 
    end
    return 0
end

--ÅĞ¶ÏÊÇ²»ÊÇÍê³ÉÈÎÎñµÄº¯Êı 
function isfinishtask()
    local taskstep = GetByte(GetTask(Task_DuJie_Value), 1)
    if (taskstep == 2) then
        return 1  --Íê³ÉÈÎÎñ,Ã»ÓĞ½»ÈÎÎñ 
    end

    if (taskstep == 1) then
        return 2  --ÕıÔÚÈÎÎñ½øĞĞÖĞ 
    end

    if (taskstep == 3) then
        return 3 --ÒÑ¾­Íê³É¹ıµÄÈÎÎñÁË 
    end
    return 0
end


--ÅĞ¶ÏÄÇ·½ÕóÓªËùÓĞµÄµÆÈ«²¿ÁÁµÄÌõ¼şº¯Êı
function getlampalllightstatus()
    local h, m, s = GetHMS()
    local curtimesec = h * 3600 + m * 60 + s
    --±¾µØÊ±¼ä²»ÔÚ 20:00~22:00Ö®¼ä
    local startsec = starttimehour * 3600 + starttimemin * 60 + starttimesec
    local endsec = endtimehour * 3600 + endtimemin * 60 + endtimesec
    if (curtimesec < startsec or curtimesec > endsec) then
        return 0
    end

    --Èç¹ûÏÉ·½µÆÈ«²¿µãÁÁ return 1
    local lampnum = GetByte(GetGlobalValue(Global_Lamp_LightCount), 1)
    if (lampnum == 6) then
        return 1
    end

    --Èç¹ûÄ§·½µÆÈ«²¿µãÁÁ return 2
    if (lampnum == 0) then
        return 2
    end

    --ÔÚÊ±¼ä·¶Î§ÄÚ£¬µ«ÊÇÃ»ÓĞÈ«ÁÁµÄÕóÓª
    return 3
end

--µã»÷ÁË¡°¶É½Ù(ÏÉ) ¡°°´Å¥ 
function faeriedujie()
    local taskstep = isfinishtask()
    if (taskstep == 2) then
        --ÕıÔÚÈÎÎñÖĞ,ÊÇ·ñÒªÉ¾³ıÔ­À´µÄÈÎÎñµÀ¾ß£¬Çå¿ÕÈÎÎñ±äÁ¿²¢´ÓĞÂÁìÈ¡
        MsgBox("§é kiÕp lµ kiÕp n¹n mµ bÊt cø Tiªn gi¶ nµo còng ph¶i ®i qua...Mçi lÇn nhËn ®é kiÕp ®Òu ph¶i thùc hiÖn trong thêi gian nhÊt ®Şnh. NÕu thÊt b¹i cã thÓ huû ®Ó nhËn l¹i!", "cancelacceptfaerie", "no")
    elseif (taskstep == 0) then
        --Ã»ÓĞ½ÓÈÎÎñ
        MsgBox("§é kiÕp lµ kiÕp n¹n mµ bÊt cø Tiªn gi¶ nµo còng ph¶i ®i qua...CÇn ph¶i cã 100 M¹n §µ la hoa míi h« ho¸n ®­îc Thiªn KiÕp. Sau khi nhËn Thiªn KiÕp, néi trong 30 phót ph¶i hoµn thµnh 7 tÇng kh¶o nghiÖm!", "accepttaskfaerie", "no")
    end
end

--µã»÷ÁË¡°¶É½Ù(Ä§) ¡°°´Å¥
function evildujie()
    local taskstep = isfinishtask()
    if (taskstep == 2) then
        --ÕıÔÚÈÎÎñÖĞ,ÊÇ·ñÒªÉ¾³ıÔ­À´µÄÈÎÎñµÀ¾ß£¬Çå¿ÕÈÎÎñ±äÁ¿²¢´ÓĞÂÁìÈ¡
        MsgBox("§é kiÕp lµ kiÕp n¹n mµ bÊt cø Ma gi¶ nµo còng ph¶i ®i qua...Mçi lÇn nhËn ®é kiÕp ®Òu ph¶i thùc hiÖn trong thêi gian nhÊt ®Şnh. NÕu thÊt b¹i cã thÓ huû ®Ó nhËn l¹i!", "cancelacceptevil", "no")
    elseif (taskstep == 0) then
        --Ã»ÓĞ½ÓÈÎÎñ
        MsgBox("§é kiÕp lµ kiÕp n¹n mµ bÊt cø Ma gi¶ nµo còng ph¶i ®i qua...CÇn ph¶i cã 100 M¹n Ch©u Sa hoa míi h« ho¸n ®­îc Thiªn KiÕp. Sau khi nhËn Thiªn KiÕp, néi trong 30 phót ph¶i hoµn thµnh 7 tÇng kh¶o nghiÖm!", "accepttaskevil", "no")
    end
end

--Íê³ÉÈÎÎñÁìÈ¡½±Àø  
function finishfaeriedujie()
    local taskstep = isfinishtask()
    local credit = GetJusticEvilCredit()
    if (credit < 15000) then
        Talk(1, "no", "Danh väng Tiªn Ma cña ng­¬i ch­a ®¹t 15000, kh«ng thÓ ®é kiÕp!") --ÄãµÄÏÉ½çÉùÍûÃ»ÓĞ´ïµ½ÒªÇóµÄÖµ
        return 0
    end

    if (taskstep == 3) then
        Talk(1, "no", "§é kiÕp lµ c¬ héi ®Ó tho¸t thai ®æi cèt, kh«ng ph¶i ai còng cã thÓ ®¹t ®­îc phóc duyªn nµy!") --²»¿ÉÄÜµ½Õâ²½ 
        return 0
    end

    if (taskstep ~= 1) then
        Talk(1, "no", "§é kiÕp lµ c¬ héi ®Ó tho¸t thai ®æi cèt, kh«ng ph¶i ai còng cã thÓ ®¹t ®­îc phóc duyªn nµy!") --²»¿ÉÄÜµ½Õâ²½ 
        return 0
    end

    SetTaskByte(Task_DuJie_Value, 1, 3)--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
    --Éè¶¨ÏÉ·½Íê³ÉµÃÈÎÎñÊı
    local finishnum = GetWorldEventValue(WorldEventTask, 1) + 1
    if (finishnum > 1000) then
        finishnum = 1000
    end
    SetWorldEventValue(WorldEventTask, 1, finishnum)

    --½ÇÉ«¸øÊôĞÔµã
    initpoint()
    --¿ªÆôÏÉÄ§µÈ¼¶Îª31¼¶µÄ¾­Ñé²Û 
    JEMainTaskComplete(1)
    ActiveTitleFunc(1)
    ActiveTitleQualify(4)
    SetCurTitle(4)
    SetTaskByte(1285, 1, 1)
    Msg2Player("§¼ng cÊp Tiªn Ma ®· cã th¨ng tiÕn ®ét ph¸, vinh dù xÕp vµo hµng ngò Du T¸n Tiªn!") --»ñÈ¡ÁËÏÉ·½½±Àø
    Talk(1, "no", " Ng­¬i ®· thµnh c«ng §é kiÕp, vinh dù ®øng vµo hµng ngò Du T¸n Tiªn, cã thÓ t¨ng ®Õn cÊp 31. Ph¸p khİ cña ng­¬i còng cã thÓ sÏ t¨ng thªm 60% ®é tr­ëng thµnh, ngoµi ra cßn nhËn ®­îc thªm 20 ®iÓm thuéc tİnh c¬ b¶n!") --»ñÈ¡ÁËÏÉ·½½±Àø
    TaskNote(1027, -1)
    RemoveIBBuff(524)

    --add by mayining 2008.10.16
    AddEvent("%s nhËn ®­îc x­ng hiÖu [Du T¸n Tiªn]!", 1)
    --end
end

--ÁìÈ¡ÈÎÎñ
function accepttaskfaerie()
    local status = getlampalllightstatus()
    if (status ~= 1) then
        Talk(1, "no", " HiÖn t¹i Ma giíi 6 ngän Liªn ®¨ng ®Òu ®· ®­îc th¾p s¸ng, ®· ®Õn thêi c¬ Thiªn KiÕp cho c¸c ®¹o h÷u Ma giíi råi! Tiªn giíi ®¹o h÷u cÇn ph¶i chê ®îi hoÆc nç lùc th¾p s¸ng Liªn ®¨ng cña phe m×nh th«i!") --ÏÉ·½µÄµÆÃ»ÓĞÈ«ÁÁ
        return 0
    end

    local credit = GetJusticEvilCredit()
    if (credit < 15000) then
        Talk(1, "no", "Danh väng Tiªn Ma cña ng­¬i ch­a ®¹t 15000, kh«ng thÓ ®é kiÕp!") --ÄãµÄÏÉ½çÉùÍûÃ»ÓĞ´ïµ½ÒªÇóµÄÖµ
        return 0
    end

    local exlevel = GetPlayerExtLevel()
    if (exlevel < 30) then
        Talk(1, "no", " §¼ng cÊp Tiªn Ma cña ng­¬i ch­a ®Õn 30, ch­a thÓ ®é kiÕp!") --ÄãµÄÏÉÄ§µÈ¼¶²»·ûºÏÌõ¼ş
        return 0
    end

    local mantu = HaveNormalItem(3, 311, 0, 0)
    local manzu = HaveNormalItem(3, 312, 0, 0)
    if (mantu < 100) then
        Talk(1, "no", " Tiªn nh©n øng kiÕp cÇn 100 M¹n §µ la hoa, Ma nh©n øng kiÕp cÇn 100 M¹n Ch©u Sa hoa.") --ÄãÃ»ÓĞ×ã¹»µÄÁìÈ¡ÈÎÎñµÄ²ÄÁÏ
        return 0
    end

    if (mantu >= 100) then
        for i = 1, 100 do
            DelNormalItem(3, 311, 0, 0)
        end
    end

    --taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
    SetTaskByte(Task_DuJie_Value, 1, 1)
    SetTaskByte(Task_DuJie_Value, 3, 7)
    --taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25

    Msg2Player("B¹n ®· nhËn thµnh c«ng nhiÖm vô Thiªn KiÕp Gi¸ng L©m, ®ång thêi nhËn ®­îc Mi Hoµng Th¹ch.")
    AddNormalItem(6, 1, 442, 1, 0, 0)
    AddIBBuff(524)
    Talk(1, "no", "VËt tæ thiªn kiÕp t¹i vŞ trİ (251, 208) trªn BÊt Chu Thiªn Quan. Nhí ph¶i tiÕn hµnh Thiªn KiÕp trong ph¹m vi xung quanh VËt tæ! Thêi gian gÊp rót, h·y mau lªn ®­êng! Sau khi nhËn ®­¬c Thiªn KiÕp, trong vßng 30 phót nhÊt ®Şnh ph¶i hoµn thµnh 7 tÇng kh¶o nghiÖm, h·y nhí râ!") --ÔÚÕâ¸öÎ»ÖÃÈ¥ÊÍ·Å
    TaskNote(1027, 0)

end

--È¡Ïûµ±Ç°ÈÎÎñ²¢ÇÒÖØĞÂÁìÈ¡
function cancelacceptfaerie()
    --È¡Ïûµ±Ç°ÈÎÎñ 
    ClearItem(6, 1, 442, 1)
    SetTask(Task_DuJie_Value, 0)
    TaskNote(1027, -1)
    RemoveIBBuff(524)
    MsgBox(" Mçi lÇn ®é kiÕp ®Òu cã h¹n ®Şnh thêi gian. NÕu thÊt b¹i cã thÓ huû bá vµ nhËn l¹i!", "accepttaskfaerie", "no")
end


--Íê³ÉÈÎÎñÁìÈ¡½±Àø  
function finishevildujie()
    local taskstep = isfinishtask()
    local credit = GetJusticEvilCredit()
    if (credit > -15000) then
        Talk(1, "no", " Danh väng Ma giíi cña b¹n ch­a ®Õn 15000, ch­a thÓ §é kiÕp") --ÄãµÄÄ§½çÉùÍûÃ»ÓĞ´ïµ½ÒªÇóµÄÖµ
        return 0
    end

    if (taskstep == 3) then
        Talk(1, "no", " ®· hoµn thµnh nhiÖm vô") --²»¿ÉÄÜµ½Õâ²½ 
        return 0
    end

    if (taskstep ~= 1) then
        Talk(1, "no", "NhiÖm vô ch­a hoµn thµnh") --²»¿ÉÄÜµ½Õâ²½ 
        return 0
    end

    SetTaskByte(Task_DuJie_Value, 1, 3)--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
    --Éè¶¨ÏÉ·½Íê³ÉµÃÈÎÎñÊı
    local finishnum = GetWorldEventValue(WorldEventTask, 2) + 1
    if (finishnum > 1000) then
        finishnum = 1000
    end
    SetWorldEventValue(WorldEventTask, 2, finishnum)

    --½ÇÉ«¸øÊôĞÔµã
    initpoint()
    --¿ªÆôÏÉÄ§µÈ¼¶Îª31¼¶µÄ¾­Ñé²Û 
    JEMainTaskComplete(1)
    ActiveTitleFunc(1)
    ActiveTitleQualify(7)
    SetCurTitle(7)
    SetTaskByte(1285, 1, 1)
    Msg2Player("§¼ng cÊp Tiªn Ma ®· cã th¨ng tiÕn ®ét ph¸, vinh dù xÕp vµo hµng ngò D¹ Du Ma.") --»ñÈ¡ÁËÄ§·½½±Àø
    Talk(1, "no", " Ng­¬i ®· thµnh c«ng §é kiÕp, vinh dù ®øng vµo hµng ngò D¹ Du Ma, cã thÓ t¨ng ®Õn cÊp 31. Ph¸p khİ cña ng­¬i còng cã thÓ sÏ t¨ng thªm 60% ®é tr­ëng thµnh, ngoµi ra cßn nhËn ®­îc thªm 20 ®iÓm thuéc tİnh c¬ b¶n!") --»ñÈ¡ÁËÄ§·½½±Àø
    TaskNote(1027, -1)
    RemoveIBBuff(524)

    --add by mayining 2008.10.16
    AddEvent("%s nhËn ®­îc x­ng hiÖu [D¹ Du Ma]!", 1)
    --end
end

--ÁìÈ¡ÈÎÎñ
function accepttaskevil()
    local status = getlampalllightstatus()
    if (status ~= 2) then
        Talk(1, "no", " HiÖn t¹i Tiªn giíi 6 ngän Liªn ®¨ng ®Òu ®· ®­îc th¾p s¸ng, ®· ®Õn thêi c¬ Thiªn KiÕp cho c¸c ®¹o h÷u Tiªn giíi råi! Ma giíi ®¹o h÷u cÇn ph¶i chê ®îi hoÆc nç lùc th¾p s¸ng Liªn ®¨ng cña phe m×nh th«i!") --Ä§·½µÄµÆÃ»ÓĞÈ«ÁÁ
        return 0
    end

    local credit = GetJusticEvilCredit()
    if (credit > -15000) then
        Talk(1, "no", " Danh väng Ma giíi cña b¹n ch­a ®Õn 15000, ch­a thÓ §é kiÕp") --ÄãµÄÄ§½çÉùÍûÃ»ÓĞ´ïµ½ÒªÇóµÄÖµ
        return 0
    end

    local exlevel = GetPlayerExtLevel()
    if (exlevel < 30) then
        Talk(1, "no", " §¼ng cÊp Tiªn Ma cña ng­¬i ch­a ®Õn 30, ch­a thÓ ®é kiÕp!") --ÄãµÄÏÉÄ§µÈ¼¶²»·ûºÏÌõ¼ş
        return 0
    end

    local mantu = HaveNormalItem(3, 311, 0, 0)
    local manzu = HaveNormalItem(3, 312, 0, 0)
    if (manzu < 100) then
        Talk(1, "no", " Tiªn nh©n øng kiÕp cÇn 100 M¹n §µ la hoa, Ma nh©n øng kiÕp cÇn 100 M¹n Ch©u Sa hoa.") --ÄãÃ»ÓĞ×ã¹»µÄÁìÈ¡ÈÎÎñµÄ²ÄÁÏ
        return 0
    end

    if (manzu >= 100) then
        for i = 1, 100 do
            DelNormalItem(3, 312, 0, 0)
        end
    end

    --taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25
    SetTaskByte(Task_DuJie_Value, 1, 1)
    SetTaskByte(Task_DuJie_Value, 3, 7)
    --taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-25

    Msg2Player("B¹n ®· nhËn thµnh c«ng nhiÖm vô Thiªn KiÕp Gi¸ng L©m, ®ång thêi nhËn ®­îc Mi Hoµng Th¹ch.")
    AddNormalItem(6, 1, 442, 1, 0, 0)
    AddIBBuff(524)
    Talk(1, "no", "VËt tæ Ma kiÕp ë BÊt Chu Thiªn quan (242.202). Nhí ph¶i tiÕn hµnh Thiªn KiÕp trong ph¹m vi xung quanh VËt tæ! Thêi gian gÊp rót, h·y mau lªn ®­êng! Sau khi nhËn ®­¬c Thiªn KiÕp, trong vßng 30 phót nhÊt ®Şnh ph¶i hoµn thµnh 7 tÇng kh¶o nghiÖm, h·y nhí râ!") --ÔÚÕâ¸öÎ»ÖÃÈ¥ÊÍ·Å
    TaskNote(1027, 1)
end

--È¡Ïûµ±Ç°ÈÎÎñ²¢ÇÒÖØĞÂÁìÈ¡
function cancelacceptevil()
    ClearItem(6, 1, 442, 1)
    SetTask(Task_DuJie_Value, 0)
    TaskNote(1027, -1)
    RemoveIBBuff(524)
    MsgBox(" Mçi lÇn ®é kiÕp ®Òu cã h¹n ®Şnh thêi gian. NÕu thÊt b¹i cã thÓ huû bá vµ nhËn l¹i!", "accepttaskevil", "no")
end

function no()
    CloseDialog()
end;

function initpoint()
    --×ªÉúºó1¼¶»ñµÃ20µã
    -- ³õÊ¼»¯Ç±ÄÜµã
    for i = 0, 3 do
        AddAssignedAttrib(i, -GetAssignedAttrib(i))
    end

    local nums = floor(Point_init / 4)
    for j = 0, 3 do
        AddAssignedAttrib(j, nums)
    end
    Msg2Player("Sau khi ®é kiÕp sÏ nhËn ®­îc 10 ®iÓm tiÒm n¨ng")
    ApplyAssignedAttrib()
end
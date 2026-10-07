-- Â¹Éñ
--author: yaoxin
--date: 2009-05-27

task_deer = 1467 -- 1½ÓÈÎÎñÊ±¼ä,2 Íê³É×´Ì¬(1½Ó,2É±ËÀÌìĞ«,ÌìĞ«·ÖÉí,3É±ËÀ·ÖÉí,ÌìĞ«¸´»î,4É±ËÀ¸´»îÌìĞ«,¸´Ãü,5Áì½±Íê³É, 6ÁìÉùÍûÍê³É)
--µÚ¶ş½×¶Î, 3byte ½ÓÈÎÎñÊ±¼ä, 4Íê³É×´Ì¬(1½Ó,2¸½Éí¶ÁÌõ,3ÕÙboss,4¸´Ãü,5Íê³É)
task_deer_npc = 1468 --µÚ1½×¶Î´ænpcµÄid,×÷Îª±êÖ¾,µÚ¶ş½×¶ÎÕÙ³öÊ±ÎªnpcµÄid,×÷ÎªÊ¶±ğ
global_boss_index = 208 -- ÌìĞ«µÄidx
global_boss_id = 209 -- ÌìĞ«µÄid

xianmo_UPcredit1 = 15000 --×ªÉúºóÏÉÉùÍûÉÏÏŞ
xianmo_UPcredit2 = 45000 --30¼¶¶É½ÙºóÏÉÉùÍûÉÏÏŞ
xianmo_UPcredit3 = 180000 --50¼¶¶É½ÙºóÏÉÉùÍûÉÏÏŞ

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local tasks = {
        { "Thiªn YÕt Vi H¹i", "renwu"; show = 0 },
        { "Hoµn thµnh Thiªn YÕt Vi H¹i", "complete_renwu"; show = 0 },
        { "Tõ bá Thiªn YÕt Vi H¹i", "cancel_renwu"; show = 0 },
        { "NhËn phÇn th­ëng danh väng", "renwu_credit"; show = 0 },
        { "Th«ng lé: Ngôc Ph¸p S¬n", "renwu2"; show = 0 },
        { "Vò Néi V« Song", "complete_renwu2"; show = 0 },
        { "Khëi ®éng Ngôc Ph¸p S¬n", "jieshao"; show = 1 },
    }

    local prog = GetWorldEventProgress(3)
    if (ismainrenwu45() == 1) and (prog >= 7) then
        local state = GetTaskByte(task_deer, 2)
        if (state == 4) then
            tasks[2].show = 1
        elseif (state < 4) then
            tasks[1].show = 1
            if (state > 0) then
                tasks[3].show = 1
            end
        end
        if (state == 5) then
            tasks[4].show = 1
        end

        if (state >= 5) and (GetPlayerExtLevel() >= 50) and (prog == 8) then
            local state2 = GetTaskByte(task_deer, 4)
            if (state2 < 4) then
                tasks[5].show = 1
            end
        elseif (prog == 2001) then
            if (HaveQualify(22) > 0) then
                tasks[6].show = 1
            end
            tasks[7].show = 0
            TaskNote(102, -1)
        end
    end

    SayTask("Du vu giang ch÷, vi tiªu vi ng­, thiªn ®Şa phï du, ho¹i trung th­¬ng h¶i, hiÖp nhÜ phi tiªn, bao nhÜ minh nguyÖt, phong trung di h­ëng, kş thïy nh©n h«?", tasks)
end

function OnDeath(npcidx)
end

function DoDeath(npcidx)
end

function OnTimer(npcidx)
end

function OnNpcTrap(npcidx)
end

function ismainrenwu45()
    local playerType = GetPlayerType()
    if (playerType == 0) then
        playerType = 3
    end
    if (GetTask(playerType) == 160) then
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end;

function renwu()
    local lastday = GetTaskByte(task_deer, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local state = GetTaskByte(task_deer, 2)
    if (lastday ~= today) then
        state = 0
    elseif (state == 0) then
        Talk(1, "no", "H«m nay ng­¬i ®· thö råi. Dï cã thÊt b¹i nh­ng còng ®õng n¶n chİ, ngµy mai chuÈn bŞ thËt tèt h·y ®Õn t×m gióp ta!")
        return 0
    end

    if (state == 0) then
        MsgBox(" Ta vèn lµ ThÇn Sinh Linh cña BÊt Chu S¬n. GÇn ®©y kh«ng biÕt tõ ®©u xuÊt hiÖn mét tªn ¸c yªu [Thiªn YÕt], h¾n tµn s¸t kh¾p n¬i, sinh linh lÇm than, ta hy väng ng­¬i cã thÓ gióp ta trõ ®i mèi häa nµy. Ngoµi ra ta nghe nãi tªn yªu qu¸i nµy cã liªn hÖ ®Õn mét bİ mËt lín nh­ng t¹m thêi ch­a biÕt ®­îc.", "renwu_yes", "no")
    elseif (state == 4) then
        complete_renwu()
    else
        if (GetWorldEventValue(3, 15) ~= GetTask(task_deer_npc)) or (GetNpcID(GetGlobalValue(global_boss_index)) ~= GetGlobalValue(global_boss_id)) then
            MsgBox("Ng­¬i ®· cè g¾ng hÕt søc råi, nh­ng ¸c yªu [Thiªn YÕt] vÉn ®· tho¸t. Chí cã ngµy sau chuÈn bŞ thËt tèt råi h·y ®Õn gióp ta.", "cancel_renwu", "no")
            return 0
        end

        if (state == 1) then
            Talk(1, "no", "Thiªn YÕt hiÖn ®ang ë vŞ trİ (240, 227)")--È¥É±ËÀÌìĞ«
        elseif (state == 2) then
            Talk(1, "no", "Thiªn YÕt ®· hãa thµnh 3 thÓ, hiÖn ®ang Èn nÊp ®©u ®ã, kh«ng tiªu diÖt ®­îc h¾n sÏ khã Gi¶i Trõ HËu Ho¹n.")--È¥É±ËÀ·ÖÉí
        elseif (state == 3) then
            Talk(1, "no", "Ta c¶m thÊy Thiªn YÕt ®· m¹nh h¬n nhiÒu so víi tr­íc., hiÖn h¾n ®ang ë vŞ trİ (240,229) h·y nhanh chèng tiªu diÖt h¾n.")--ÌìĞ«¸´»î,É±ËÀ¸´»îÌìĞ«,¸´Ãü
        end
    end
end

function renwu_yes()
    if (GetTeam() == 0) then
        Talk(1, "no", "Víi søc mét m×nh ng­¬i ta e r»ng kh«ng ®ñ, tèt nhÊt ®i tæ thµnh mét ®éi ngò h½ng ®Õn t×m ta.")
        Msg2Player("NhÊt thiÕt ph¶i tæ ®éi víi 2 ng­êi kh¸c, ®ång thêi gäi ®éi tr­ëng ng­¬i ®Õn gÆp ta.")
        return 0
    end

    if (IsCaptain() ~= 1) or (GetTeamSize() ~= 3) then
        Talk(1, "no", "Tæ ®éi víi 3 ng­êi cïng Tiªn hoÆc Ma ph¸i, ®éi tr­ëng ®Õn gÆp ta, ®Ó chøng minh thùc lùc cña c¸c ng­¬i, c¸c ng­¬i ph¶i tr¶i qua nhiÖm vô kh¶o nghiÖm [Thñy Háa Chi Tranh]")
        Msg2Player("ChØ cÇn ®éi tr­ëng ®Õn gÆp ta lµ ®­îc, ®éi ngò 3 ng­êi nhÊt thiÕt ph¶i cïng phe víi nhau.")
        return 0
    end

    local npcidx = GetGlobalValue(global_boss_index)
    local npcid = GetGlobalValue(global_boss_id)
    if (npcidx > 0) and (GetNpcID(npcidx) == npcid) then
        Talk(1, "no", "§· cã 1 ®éi ngò hiÖn ®ang khiªu chiÕn víi Thiªn YÕt råi, ng­¬i h·y quay l¹i sau.")
        Msg2Player("HiÖn ®ang bËn, cã thÓ quay l¹i nhËn sau.")
        return 0
    end

    local key = 1
    if (GetJusticEvilCredit() < 0) then
        key = -1
    end
    if (TeamAction("renwu_limit", key, 1, 0) == 1) then
        --Ìõ¼şÏŞ¶¨,¶¼ÔÚÓü·¨É½
        local new = AddNpc(1059, 70, SubWorld, 1924 * 32, 3638 * 32)--ÌìĞ«
        if (new > 0) then
            SetNpcScript(new, "\\script\\¹ÖÎï\\ÌìĞ«.lua")
            SetNpcTimer(new, "\\script\\ontimer\\ÌìĞ«.lua", 60 * 15)
            SetNpcName(new, "<c=g>Thiªn YÕt<c>")
            local newid = GetNpcID(new)
            SetGlobalValue(global_boss_index, new)
            SetGlobalValue(global_boss_id, newid)
            TeamAction("renwu_set", newid, 0, 0)
            SetWorldEventValue(3, 19, 1)--ÊÀ½çÊÂ¼şÉèÖÃ,1½Ó,2·ÖÉí,3·ÖÉíËÀ1,4·ÖÉíËÀ2,5·ÖÉíËÀ3,¸´»î,6Íê³É
            SetWorldEventValue(3, 15, newid)--ÒÔµÚÒ»´Î¼ÓµÄbossµÄidÎª,×÷ÎªĞ¡×é3ÈËÈÎÎñÊ¶±ğ±êÖ¾
            Talk(1, "no", "Thiªn YÕt hiÖn ®ang ë vŞ trİ (240,227), c¸c ng­¬i ph¶i ®ång t©m hiÖp lùc tiªu diÖt h¾n.")
            WriteLog(GetName() .. "TriÖu xuÊt Thiªn YÕt")
        else
            WriteLog("gia Thiªn YÕt thÊt b¹i")
        end
    else
        Talk(1, "no", "C¸c ng­¬i vÉn ch­a thÓ nhËn nhiÖm vô.")
    end
end

function renwu_limit(camp)
    CloseDialog()
    if (ismainrenwu45() == 0) then
        Msg2Team(GetName() .. "VÉn ch­a th«ng qua kh¶o nghiÖm [Thñy Háa Chi Tranh]")
        return 0
    end

    if (GetJusticEvilCredit() * camp <= 0) then
        Msg2Team(GetName() .. " kh«ng cïng phe víi ®éi tr­ëng!")
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w ~= 74) then
        Msg2Team(GetName() .. "Kh«ng t¹i BÊt Chu S¬n.")
        return 0
    end

    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(task_deer, 1)
    local state = GetTaskByte(task_deer, 2)
    if (lastday ~= today) and (state < 5) then
        state = 0
    end

    if (state ~= 0) then
        Msg2Team(GetName() .. "§· khiªu chiÕn Thiªn YÕt, nguyªn khİ vÉn chua håi phôc, h·y thay ng­êi ®i.")
        return 0
    end

    return 1
end

function renwu_set(npcid)
    SetTask(task_deer, mod(floor(LocalSystemTime() / 86400), 256))
    SetTaskByte(task_deer, 2, 1)
    SetTask(task_deer_npc, npcid)
    TaskNote(103, 0)
    RemoveIBBuff(686)
    AddIBBuff(686, 15 * 60)
    Msg2Player("Thiªn YÕt ®ang ë <HyperLinkWorldPos=\"²»ÖÜÉ½[74,240,227]\">, h¾n cùc kú gi¶o quyÖt, c¸c ng­¬i ph¶i ®ång t©m hiÖp lùc tiªu diÖt h¾n.")
end

function cancel_renwu()
    MsgBox("TiÕc r»ng sinh linh l¹i ph¶i lÇm than. Ng­¬i quyÕt ®Şnh sÏ tõ bá sø mÖnh sao? Ngµy mai h·y chuÈn bŞ thËt tèt råi ®Õn t×m ta.", "cancel_renwu_yes", "no")
end

function cancel_renwu_yes()
    CloseDialog()
    SetTaskByte(task_deer, 2, 0)
    SetTask(task_deer_npc, 0)
    TaskNote(103, -1)
    RemoveIBBuff(686)
    Msg2Player("§· hñy bá nhiÖm vô")
    Talk(1, "no", "ThËt ®¸ng tiÕc, sinh linh l¹i r¬i vµo lÇm than råi.")
end

function complete_renwu()
    CloseDialog()
    if (GetTaskByte(task_deer, 2) ~= 4) then
        return 0
    end

    local times1 = GetWorldEventValue(3, 22)
    local times2 = GetWorldEventValue(3, 23)
    if (GetJusticEvilCredit() >= 0) then
        times1 = times1 + 1
        SetWorldEventValue(3, 22, times1)
    else
        times2 = times2 + 1
        SetWorldEventValue(3, 23, times2)
    end
    if (GetWorldEventProgress(3) == 7) and (times1 >= 3) and (times2 >= 3) then
        SetWorldEventProgress(3, 8)
        WriteLog("Tiªu trõ Thiªn YÕt, khai th«ng Ngôc Ph¸p s¬n")
    end
    SetTaskByte(task_deer, 2, 5)
    TaskNote(103, -1)
    Talk(1, "no", " Ta cã thÓ c¶m nhËn thÊy ngµy tËn thÕ cña Thiªn YÕt råi. HiÖn t¹i phe Tiªn tiªu diÖt Thiªn YÕt cã <c=g>" .. times1 .. "<c> ng­êi, HiÖn t¹i phe Ma tiªu diÖt Thiªn YÕt cã <c=g>" .. times2 .. "<c> ng­êi, sau khi c¸c bªn ®¹t 3 ng­êi trë lªn, linh khİ bŞ Thiªn YÕt thu ®­îc sÏ quy vŞ, c¸c ng­¬i sÏ biÕt ®­îc ph­¬ng ph¸p ®Õn Ngôc Ph¸p S¬n.")
    Msg2Player("ThËt c¶m t¹ ng­¬i ®· gióp ta tiªu diÖt Thiªn YÕt, 400 ®iÓm danh väng nµy lµ ph©n th­ëng cña ng­¬i, ng­¬i cã thÓ ®Õn nhËn bÊt cø lóc nµo còng ®­îc.")
end

-- modified by yaoxin for  2011-1 begin
function renwu_credit()
    local playercredit = GetJusticEvilCredit()
    if (IsNewBirthComplete() == 1 and abs(playercredit) < xianmo_UPcredit1) or (IsJEMainTaskComplete(1) == 1 and abs(playercredit) < xianmo_UPcredit2) or (IsJEMainTaskComplete(2) == 1 and abs(playercredit) < xianmo_UPcredit3)
            or (IsJEMainTaskComplete(3) == 1) then
        MsgBox("§©y lµ phÇn th­ëng cña ng­¬i, ng­¬i sÏ ®­îc n©ng cao 400 ®iÓm danh väng.", "renwu_credit_yes", "no")
    else
        Talk(1, "no", "Danh väng cña ng­¬i ®· ®¹t ®Õn giíi h¹n, sau nµy ng­¬i h·y ®Õn nhËn 400 ®iÓm Danh väng th­ëng nµy!")
    end
end

function renwu_credit_yes()
    CloseDialog()
    if (GetTaskByte(task_deer, 2) ~= 5) then
        return 0
    end
    local playercredit = GetJusticEvilCredit()
    local newplayercredit = 0
    local isJEValue = IsJEMainTaskComplete(3)
    local isjustice = 1
    local vale = abs(playercredit)
    if (playercredit < 0) then
        isjustice = -1
    end

    if (IsJEMainTaskComplete(2) == 1) then
        if (vale + 400 >= xianmo_UPcredit3) then
            newplayercredit = isjustice * (xianmo_UPcredit3 - vale)
        else
            newplayercredit = isjustice * 400
        end
    elseif (IsJEMainTaskComplete(1) == 1) then
        if (vale + 400 >= xianmo_UPcredit2) then
            newplayercredit = isjustice * (xianmo_UPcredit2 - vale)
        else
            newplayercredit = isjustice * 400
        end
    else
        newplayercredit = isjustice * 400
    end
    ChangeJusticEvilCredit(newplayercredit)
    SetTaskByte(task_deer, 2, 6)
    TopMessage("NhËn ®­îc 400 ®iÓm Danh väng th­ëng")
    Msg2Player("NhËn ®­îc 400 ®iÓm Danh väng th­ëng")
    Talk(1, "no", "§©y lµ mét chót thµnh ı cña ta.")
end
-- modified by yaoxin for  2011-1 end

--µÚ¶ş½×¶Î áª²®
function renwu2()
    local lastday = GetTaskByte(task_deer, 3)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    if (lastday ~= today) then
        SetTaskByte(task_deer, 3, today)
        SetTaskByte(task_deer, 4, 0)
    end

    local state = GetTaskByte(task_deer, 4)
    if (state == 0) then
        MsgBox("Th× ra bİ mËt mµ Thiªn YÕt n¾m gi÷ chİnh lµ TrËn Ph¸p Bİ MËt trªn BÊt Chu S¬n, chØ ®¸nh b¹i nh©n vËt ®ang trÊn ¸p trong trËn ph¸p lµ cã thÓ më ra con ®­êng dÉn ®Õn [Ngôc Ph¸p S¬n], ta cã thÓ më trËn ph¸p nh­ng thêi gian kh«ng dµi l©u, nhiÖm vô lÇn nµy rÊt lín, ng­¬i cã gióp ®­îc kh«ng?", "renwu2_yes", "no")
    else
        if (HaveIBBuff(687) == 0) or (GetWorldEventValue(3, 16) == 0) then
            Talk(1, "no", "Ng­¬i ®· thÊt b¹i råi, nh­ng chí véi n¶n chİ ngµy mai ng­¬i cã thÓ tiÕp nhËn khiªu chiÕn l¹i!")
            TaskNote(102, -1)
            SetTaskByte(task_deer, 4, 7)--Ê§°Ü
            return 0
        end

        if (state == 1) then
            Talk(1, "no", "Tªn trËn ph¸p [Canh Quı Lôc Kú Phong], cã thÓ ®Õn <c=g>(247,230)<c> t×m Nguc Tèt dÉn vµo.")--È¥¸½Éí
        elseif (state == 2) then
            Talk(1, "no", "Thêi gian kh«ng nhiÒu, h·y nhanh chèng triÖu gäi ra [Kú B¸] vµ ®¸nh b¹i h¾n.")--È¥ÕÙboss
        elseif (state == 3) then
            Talk(1, "no", "[Kú B¸] ®· xuÊt hiÖn, sao c¸c ng­¬i cßn ®øng ®©y?")--É±ËÀboss
        end
    end
end

function renwu2_yes()
    CloseDialog()
    if (GetTeam() == 0) then
        -- modified by Óü·¨É½¿ªÆôyaoxin for 2010-11 begin
        Talk(1, "no", "Dùa vµo søc cña mét m×nh ng­¬i th× kh«ng ®­îc, ph¸p trËn cÇn ph¶i cã 6 ng­êi tæ ®éi cña Tiªn, Ma, trong ®éi ph¶i cã İt nhÊt 1 tiªn 1 ma th× míi më ®­îc, b¹n ph¶i t×m 5 ng­êi ®ång ®éi trªn cÊp 50 ®ång thêi ®· tõng ®¸nh b¹i [Thiªn h¹t] th× míi cã hy väng.")
        return 0
    end

    if (IsCaptain() ~= 1) or (GetTeamSize() ~= 6) then
        Talk(1, "no", "Ph¸p trËn cÇn ph¶i cã 6 ng­êi tæ ®éi cña Tiªn, Ma, trong ®éi ph¶i cã İt nhÊt 1 tiªn 1 ma th× míi më ®­îc, b¹n ph¶i t×m 5 ng­êi ®ång ®éi trªn cÊp 50 ®ång thêi ®· tõng ®¸nh b¹i [Thiªn h¹t] th× míi cã hy väng th«ng qua.")
        Msg2Player("CÇn ph¶i tæ ®éi víi 5 ng­êi trªn cÊp 50, ®ång thêi ®· ®¸nh b¹i Thiªn H¹t, do ®éi tr­ëng nhËn. Trong tæ ®éi ph¶i cã 6 ng­êi vµ cã İt nhÊt 1 tiªn 1 ma.")
        -- modified by Óü·¨É½¿ªÆôyaoxin for 2010-11 end
        return 0
    end

    local local_time = LocalSystemTime()
    if (GetWorldEventValue(3, 16) ~= 0) and (GetWorldEventValue(3, 24) + 30 * 60 > local_time) then
        Talk(1, "no", "§· cã 1 ®éi anh hïng ®ang trªn ®­êng ®i tiªu diÖt Kú b¸, ng­êi ®«ng sÏ g©y trë ng¹i, c¸c ng­¬i h·y quay l¹i sau.")
        Msg2Player("§· cã 1 ®éi anh hïng ®ang trªn ®­êng ®i tiªu diÖt Kú b¸, c¸c ng­¬i h·y quay l¹i sau.")
        return 0
    end

    local today = mod(floor(local_time / 86400), 256)
    local nums1, nums2 = 0, 0
    local world, tempstate = 0, 0
    local w, x, y = GetWorldPos()
    local oldPlayer = PlayerIndex

    for i = 1, 6 do
        PlayerIndex = GetTeamMember(i)
        if (ismainrenwu45() == 0) then
            Msg2Team("Léc ThÇn:" .. GetName() .. "Ch­a th«ng qua kh¶o nghiÖm [Thñy Háa Chi Tranh].")
            break
        end

        if (GetPlayerExtLevel() < 50) then
            Msg2Team(GetName() .. "VÉn ch­a ®¹t ®Õn cÊp 50.")
            break
        end

        world, x, y = GetWorldPos()
        if (w ~= world) then
            Msg2Team(GetName() .. "Kh«ng t¹i BÊt Chu S¬n.")
            break
        end

        if (GetTaskByte(task_deer, 3) ~= today) then
            SetTaskByte(task_deer, 3, today)
            SetTaskByte(task_deer, 4, 0)
        end

        tempstate = GetTaskByte(task_deer, 4)
        if (tempstate ~= 0) then
            Msg2Team(GetName() .. "H«m nay ®· khëi ®éng qua trËn ph¸p, ngµy mai h·y quay l¹i ®i.")
            break
        end

        if (GetJusticEvilCredit() > 0) then
            nums1 = nums1 + 1
        else
            nums2 = nums2 + 1
        end
    end
    PlayerIndex = oldPlayer
    -- modified by Óü·¨É½¿ªÆôyaoxin for 2010-11 begin
    if (nums1 >= 1) and (nums2 >= 1) and (nums1 + nums2 == 6) then
        --Ìõ¼şÏŞ¶¨,¶¼ÔÚÓü·¨É½
        SetWorldEventValue(3, 18, 1)--ÊÀ½çÊÂ¼şÉèÖÃ, 1½Ó,È¥¸½Éí,2ÕÙ³ö,3É±ËÀ,¸´Ãü,4Íê³É
        SetWorldEventValue(3, 16, GetPlayerID())--µÚ¶ş½×¶Î¶Ó³¤µÄplayerid
        SetWorldEventValue(3, 24, local_time)--µÚ¶ş½×¶Î£¬×öÎªÊ§°Üºó£¬ÏÂ¸ö¶Ó¿ÉÒÔÖØĞÂÁìÈ¡µÄ±êÖ¾
        TeamAction("renwu2_set", 0, 0, 0)
        AddNormalItem(6, 1, 519, 0, 0, 0)--Í¸µØÓñÁú¹Ä
        Talk(3, "no", "Tªn trËn ph¸p [Canh Quı Lôc Kú Phong], cã thÓ ®Õn <c=g>(247,230)<c> t×m Ngôc Tèt dÉn vµo. 6 ng­êi c¸c ng­¬i cã thÓ tù t×m ®Õn Ph¸p TrËn Tr­ëng L·o cña phe ph¸p m×nh ®èi tho¹i, xin «ng ta gióp phô thÓ.", "§îi sau khi 6 ng­êi hoµn tÊt phô thÓ, cã thÓ sö dông <c=g>[ThÊu §Şa Ngäc Long Cæ]<c>nµy, sau ®ã nh©n vËt thÇn bİ ®ã sÏ hiÖn th©n, tiªu diÖt h¾n sÏ më ra ®­îc ®­êng dÉn ®Õn Ngôc Ph¸p S¬n.")
        WriteLog(GetName() .. "Ngôc Ph¸p S¬n phï th©n")
    else
        Talk(1, "no", "Ph¸p trËn cÇn ph¶i cã 6 ng­êi tæ ®éi cña Tiªn, Ma, trong ®éi ph¶i cã İt nhÊt 1 tiªn 1 ma th× míi më ®­îc, hiÖn t¹i kh«ng thÓ nhËn nhiÖm vô.")
    end
    -- modified by Óü·¨É½¿ªÆôyaoxin for 2010-11 end
end

function renwu2_set()
    SetTaskByte(task_deer, 4, 1)
    SetTask(task_deer_npc, 0)
    TaskNote(102, 4)
    ClearItem(6, 1, 519, 0)
    RemoveIBBuff(687)
    AddIBBuff(687, 30 * 60)
    Msg2Player("Tªn trËn ph¸p [Canh Quı Lôc Kú Phong], cã thÓ ®Õn <HyperLinkWorldPos=\"²»ÖÜÉ½[74,247,230]\"> t×m Ngôc Tèt dÉn vµo, 6 ng­êi c¸c ng­¬i cã thÓ tù t×m ®Õn Ph¸p TrËn Tr­ëng L·o cña m×nh ®èi tho¹i, mêi «ng ta gióp phô th©n.")
end

function complete_renwu2()
    CloseDialog()
    if (HaveQualify(22) > 0) then
        return 0
    end

    ActiveTitleQualify(22)--¼¤»î¡°ÓîÄÚÎŞË«¡±
    SetCurTitle(22) --¸Ä±äµ±Ç°³ÆºÅ
    TopMessage("NhËn ®­îc danh hiÖu <c=g>Vò Néi V« Song<c>")
    Msg2Player("Ng­¬i nhËn ®­îc danh hiÖu Vò Néi V« Song")
end

function jieshao()
    local prog = GetWorldEventProgress(3)
    local time2 = GetWorldEventValue(3, 21)
    local time1 = GetWorldEventValue(3, 20)
    -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-08 begin
    local nLine = { 25, 50, 75, 75, 100, 125 }
    if (prog <= 6) then
        local str = ""
        if (nLine[prog] <= time1) then
            str = str .. "Phe Tiªn cßn thiÕu <c=r>1<c> lÇn, "
        else
            str = str .. "Phe Tiªn ®· hoµn thµnh <c=r>" .. time1 .. "<c> lÇn,"
        end
        if (nLine[prog] <= time2) then
            str = str .. "Phe Ma cßn thiÕu <c=r>1<c> lÇn, "
        else
            str = str .. "Phe Ma ®· hoµn thµnh <c=r>" .. time2 .. "<c> lÇn."
        end
        Talk(3, "no", "6 täa ®iªu t­îng xung quanh ta chİnh lµ t­îng tr­ng cho linh khİ cña BÊt Chu S¬n, mçi khi tİch tô ®­îc l­îng linh khİ nhÊt ®Şnh, sÏ cã 1 täa ®iªu t­îng biÕn thµnh t­¬i tØnh, khi c¶ 6 täa ®Òu ®­îc kİch ho¹t th× sÏ biÕt ®­îc b­íc thø nhÊt më ra con ®­êng dÉn ®Õn Ngôc Ph¸p S¬n.", " Ph­¬ng ph¸p tİch tô linh khİ chİnh lµ sè lÇn hoµn thµnh nhiÖm vô <c=g>Ngò S¾c Hån<c> trªn BÊt Chu S¬n, mçi khi ®¹t ®Õn mét giai ®o¹n nhÊt ®Şnh lµ cã thÓ tİch tô linh khİ.", " Muèn kİch ho¹t ®iªu t­îng, yªu cÇu phe Tiªn hoÆc phe Ma ph¶i hoµn thµnh nhiÖm vô <c=g>Ngò S¾c Hån<c> ®ñ <c=r>" .. nLine[prog] .. "<c> lÇn, hiÖn t¹i, " .. str)
        -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-08 end
    elseif (prog == 7) then
        Talk(1, "no", "6 täa ®iªu t­îng ®Òu ®· ®­îc kİch ho¹t, nh­ng kh«ng ngê linh khİ l¹i bŞ ¸c yªu [Thiªn YÕt] c­íp ®i, chØ cã tiªu diÖt ¸c yªu nµy míi cã thÓ biÕt ®­îc bİ mËt cña Ngôc Ph¸p S¬n")
    elseif (prog == 8) then
        Talk(1, "no", "Ph¸p trËn [Canh Quı Lôc Kú Phong] cña BÊt Chu S¬n ®· ®­îc khëi ®éng, dòng sÜ chØ cÇn tËp hîp 6 ng­êi tæ ®éi cña Tiªn, Ma, cã İt nhÊt 1 tiªn 1 ma vµ ®¼ng cÊp trªn 50, ®ång thêi tõng ®¸nh b¹i Thiªn H¹t ®Ó lËp tæ ®éi, ®Õn ph¸p trËn tiªu diÖt Kú B¸, xem nh­ hoµn thµnh viÖc lín.")-- modified by Óü·¨É½¿ªÆôyaoxin for 2010-11
    end
end
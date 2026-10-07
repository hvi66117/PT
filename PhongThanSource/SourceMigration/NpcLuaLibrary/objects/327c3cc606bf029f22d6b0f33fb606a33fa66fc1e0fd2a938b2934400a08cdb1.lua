Task_Pangu = 1066
Task_caikuang = 1585
Task_caiyao = 1586

Task_garherMaster = 1656;

function no()
    CloseDialog()
end;
function GetPlayerTaskState()
    return 0, 0
end

function main()

    local tasks = {
        { "Thu thËp", "gather"; show = 1 },
        { "Khai kho¸ng", "mine"; show = 1 },
        { "Sinh Ho¹t S­", "pangu"; show = 0 },
        { "Hoµn thµnh lÇn thu thËp ®Çu tiªn", "wanchengcaiyao"; show = 0 },
        { "Hoµn thµnh lÇn khai kho¸ng ®Çu tiªn", "wanchengcaikuang"; show = 0 },
    }
    if (GetTask(Task_Pangu) == 13) then
        tasks[3].show = 1
    end
    if (GetTask(Task_caiyao) == 1) then
        tasks[4].show = 1
    end
    if (GetTask(Task_caikuang) == 2) then
        tasks[5].show = 1
    end

    SayTask("<c=g>Thu thËp, Khai kho¸ng<c> lµ kü n¨ng cÇn thiÕt cho viÖc hµnh tÈu giang hå, n¾m v÷ng hai kü n¨ng nµy, ng­¬i cã thÓ thu thËp ®­îc Th¶o d­îc vµ Kho¸ng vËt. Nh÷ng Th¶o d­îc vµ Kho¸ng vËt nµy ®Òu lµ nguyªn liÖu cÇn thiÕt ®Ó ng­¬i gia c«ng vµ chÕ t¹o vËt phÈm cao cÊp. §¼ng cÊp nh©n vËt t¨ng <c=g>10 cÊp<c>, kü n¨ng t¨ng tèi ®a 1 cÊp.", tasks)
end;

gMineTask = 1654

gMineNote = 1509

function Mine_Guru()
    no()
    if (GetTaskByte(gMineTask, 1) == 0) then
        MsgBox("GÇn ®©y mµu s¾c vµ phÈm chÊt Kho¸ng Th¹ch s¶n xuÊt ra kh«ng ®­îc nh­ tr­íc, dïng Kho¸ng Th¹ch lo¹i nµy luyÖn vò khİ chÊt l­îng sÏ rÊt kĞm! Nghe nãi ë Hµn B¨ng TrËn xuÊt hiÖn 1 qu¸i nh©n, c¬ thÓ h¾n ®­îc ®iªu kh¾c b»ng ®¸, ng­¬i h·y ®i ®iÒu tra râ thùc h­!", "Accept_Task", "no")
    elseif (GetTaskByte(gMineTask, 1) == 7) then
        MsgBox("Ng­¬i ®· hoµn thµnh nhiÖm vô khai kho¸ng cÊp t«n s­, giê ng­¬i cã muèn ®æi phÇn th­ëng kh«ng?", "Finish_Task", "no")
    elseif (GetTaskByte(gMineTask, 1) == 8) then
        local minelevel = GetLiveSkillLevel(3)
        local cost = 10000 * 2 ^ minelevel
        MsgBox("Chóc mõng! Kü n¨ng khai kho¸ng cña ng­¬i ®· ®¹t cÊp t«n s­, ng­¬i muèn bá ra" .. cost .. "B¹c ®Ó th¨ng cÊp kü <c=g>khai kho¸ng<c> chø?", "yes_mineup", "no")
    else
        MsgBox("B¹n muèn hñy nhiÖm vô khai kho¸ng cÊp t«n s­ ph¶i kh«ng?", "Cancel_Task", "no")
    end
end

function Finish_Task()
    no()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, h·y s¾p xÕp l¹i hµnh trang.")
        return
    end
    AddNormalItem(3, 558, 0, 0, 0, 0)
    Msg2Player("Chóc mõng b¹n nhËn ®­îc Kiªn Qu©n Phï")
    Msg2Player("Chóc mõng! B¹n cã thÓ häc kü n¨ng khai kho¸ng cÊp t«n s­ råi.")
    SetTaskByte(gMineTask, 1, 8)
    TaskNote(gMineNote, -1)
    local minelevel = GetLiveSkillLevel(3)
    local cost = 10000 * 2 ^ minelevel
    MsgBox("Chóc mõng! Kü n¨ng khai kho¸ng cña ng­¬i ®· ®¹t cÊp t«n s­, ng­¬i muèn bá ra" .. cost .. "B¹c ®Ó th¨ng cÊp kü <c=g>khai kho¸ng<c> chø?", "yes_mineup", "no")
end

function Accept_Task()
    no()

    if (GetTaskByte(gMineTask, 4) == 0) then
        if (HaveNormalItem(3, 1084, 0, 0) > 0) then
            DelNormalItem(3, 1084, 0, 0)
        else
            Talk(1, "no", "Anh hïng cÇn ph¶i cè c«ng khæ luyÖn míi cã thÓ th¨ng cÊp thµnh nhÊt ®¹i t«n s­! Khi nµo ng­¬i ®¹t cÊp 120, kü n¨ng sèng ®¹t cÊp 9 vµ ®é thuÇn thôc ®¹t 100%, h·y mang s¸ch kü n¨ng *Ngò Tµng S¬n Kinh* ®Õn gÆp ta.")
            return
        end
    end

    SetTaskByte(gMineTask, 1, 1)

    SetTaskByte(gMineTask, 4, 1)

    TaskNote(gMineNote, 1)
    Talk(1, "no", "H·y ®Õn Hµn B¨ng TrËn t×m <c=g>Ch©m PhÊt Th¹ch Nh©n<c>.")
end

function Cancel_Task()
    no()

    SetTaskByte(gMineTask, 1, 0)
    SetTaskByte(gMineTask, 2, 0)
    SetTaskByte(gMineTask, 3, 0)

    TaskNote(gMineNote, -1)
    Talk(1, "no", "B¹n ®· hñy bá nhiÖm vô!")

    ClearItem(3, 1082, 0, 0)
    ClearItem(6, 1, 788, 0)

end

function pangu()
    MsgBox("ë <c=g>TriÒu Ca<c>, <c=g>T©y Kú<c> cã c¸c Sinh Ho¹t S­, hä sÏ d¹y ng­¬i c¸c kü n¨ng sèng nh­ <c=g>c©u c¸<c>, <c=g>gia c«ng<c>, <c=g>luyÖn chÕ<c>. Hä th­êng ®øng gÇn Vâ s­, ng­¬i cã thÓ ®Õn ®ã thØnh gi¸o.", "yes_pangu", "no")
end

function yes_pangu()
    CloseDialog()
    Talk(1, "no", "BÊt cø lóc nµo ng­¬i còng cã thÓ ®Õn ®©y t×m hiÓu th«ng tin. Mäi cè g¾ng sÏ ®­îc ®Òn ®¸p xøng ®¸ng!")
    DelNormalItem(7, 58, 62, 0)
    AddOwnExp(800)
    TaskNote(898, -1)
    SetSubTask(898, -1, 1)
    Msg2Player("NhËn ®­îc 800 kinh nghiÖm")
    SetTask(Task_Pangu, 14)
end

function gather()
    CloseDialog()
    local tasks = {
        { "ThuThËp§ÇuTiªn", "caiyao"; show = 0 },
        { "Th¨ng cÊp kü n¨ng thu thËp", "gatherupgrade"; show = 0 },
        { "<c=g>Lªn T«n S­<c>", "gather_master"; show = 0 },
        { "ThuyÕtMinh", "gatherexplain"; show = 1 }

    }

    local SkillLevel = GetLiveSkillLevel(1)
    if (SkillLevel == 0) then
        tasks[1].show = 1;


    elseif ((GetTaskByte(Task_garherMaster, 1) == 0 or GetTaskByte(Task_garherMaster, 1) == 5 or GetTaskByte(Task_garherMaster, 1) == 6) and SkillLevel == 9 and GetLevel() >= 120 and GetLiveSkillProficiency(1) == 10000) then
        tasks[3].show = 1;
    elseif (SkillLevel < 9) then
        tasks[2].show = 1;
    end

    SayTask("Thu thËp cã <c=g>10 cÊp<c>, b¾t ®Çu häc kü n¨ng nµy khi nh©n vËt cÊp 20, kü n¨ng ®­îc n©ng cÊp b»ng viÖc t¨ng <c=g>®é thuÇn thôc<c>. Khi cÊp th¶o d­îc thu thËp ®­îc b»ng víi cÊp kü  n¨ng hiÖn t¹i, ®é thuÇn thôc nhËn ®­îc sÏ cao h¬n. CÊp kü n¨ng cao nh­ng thu thËp th¶o d­îc cÊp thÊp, ®é thuÇn thôc sÏ gi¶m ®¸ng kÓ, kh«ng chİ kh«ng nhËn ®­îc.", tasks)
end;

function gather_master()
    local TaskProcess = GetTaskByte(Task_garherMaster, 1);
    local traitionals = {
        { nItemClass = 8, nDetailType = 922, nParticualrType = 0, nLevel = 0, nItemAttribute = 0 },
        { nItemClass = 8, nDetailType = 923, nParticualrType = 0, nLevel = 0, nItemAttribute = 0 },
        { nItemClass = 8, nDetailType = 924, nParticualrType = 0, nLevel = 0, nItemAttribute = 0 },
        { nItemClass = 8, nDetailType = 925, nParticualrType = 0, nLevel = 0, nItemAttribute = 0 }
    };

    if (TaskProcess == 0) then
        if (GetLiveSkillLevel(1) == 9 and GetLevel() >= 120 and GetLiveSkillProficiency(1) == 10000 and HaveNormalItem(3, 1083, 0, 0) >= 1) then
            MsgBox("Ng­¬i x¸c nhËn muèn häc kü n¨ng thu thËp cÊp t«n s­? Sau khi x¸c nhËn sÏ khÊu trõ s¸ch kü n¨ng sèng t­¬ng øng.", "enterTask", "no");
        else
            Talk(1, "no", "Anh hïng cÇn ph¶i cè c«ng khæ luyÖn míi cã thÓ th¨ng cÊp thµnh nhÊt ®¹i t«n s­! Khi nµo ng­¬i ®¹t cÊp 120, kü n¨ng sèng ®¹t cÊp 9 vµ ®é thuÇn thôc ®¹t 100%, h·y mang s¸ch kü n¨ng *B¶n Th¶o C­¬ng Môc* ®Õn gÆp ta.");
        end


    elseif (TaskProcess == 5) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            TopMessage("Hµnh trang cña b¹n kh«ng ®ñ chç trèng!");
            return 0;
        end

        SetTaskByte(Task_garherMaster, 1, 6);

        local randomNumber = math.random(1, 4);
        AddNormalItemPile(traitionals[randomNumber].nItemClass, traitionals[randomNumber].nDetailType, traitionals[randomNumber].nParticualrType,
                traitionals[randomNumber].nLevel, traitionals[randomNumber].nItemAttribute, 0);

        TaskNote(1510, -1)
        Talk(1, "gather_up", "§a t¹ anh hïng cøu m¹ng tiÓu ®å, ngµy sau tiÓu ®å trë vÒ, ta nhÊt ®Şnh dÉn h¾n ®Õn b¸i t¹.");

    elseif (TaskProcess == 6) then
        local gatherlevel = GetLiveSkillLevel(1);
        local cost = 10000 * 2 ^ gatherlevel;
        if (GetCash() >= cost) then
            MsgBox(" B¹n muèn bá ra" .. cost .. " b¹c ®Ó th¨ng cÊp kü n¨ng <c=g>thu thËp<c> kh«ng?", "yes_gatherupMaster", "no")
        else
            Talk(1, "no", " " .. gatherlevel .. "Kü n¨ng thu thËp th¨ng cÊp ®Õn" .. (gatherlevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
        end
    end
end

function gather_up()
    CloseDialog()
    local cost = 10000 * 2 ^ 9;
    MsgBox(" B¹n muèn bá ra" .. cost .. " b¹c ®Ó th¨ng cÊp kü n¨ng <c=g>thu thËp<c> kh«ng?", "yes_gatherupMaster", "no")
end

function yes_gatherupMaster()
    CloseDialog()
    local gatherlevel = GetLiveSkillLevel(1)
    local cost = 10000 * 2 ^ gatherlevel
    if (GetCash() >= cost) then
        if (Pay(cost) > 0) then
            AddLiveSkill(1, 10);
            Talk(1, "no", " Chóc mõng! Kü n¨ng <c=g>thu thËp<c> th¨ng cÊp ®Õn cÊp t«n s­.")
            Msg2Player("Kü n¨ng thu thËp ®· th¨ng ®Õn cÊp t«n s­")
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> kü n¨ng thu thËp ®· th¨ng ®Õn cÊp t«n s­", 5);
            WriteLog(GetName() .. "Kü n¨ng thu thËp ®· th¨ng ®Õn cÊp t«n s­")
        end
    else
        Talk(1, "no", " " .. gatherlevel .. "Kü n¨ng thu thËp th¨ng cÊp ®Õn" .. (gatherlevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
    end
end

function enterTask()
    if (HaveNormalItem(3, 1083, 0, 0) >= 1) then
        DelNormalItem(3, 1083, 0, 0);
        Talk(3, "no", "10 n¨m tr­íc Vò Thanh Linh ®Õn Tam Tiªn §¶o t×m hoa l¹, tõ ®ã biÖt v« ©m tİn! NÕu anh hïng gióp ta dß la ®­îc tin tøc cña Thanh Linh, ta v« cïng c¶m t¹.", GetName() .. ": Xin h·y yªn t©m, t«i sÏ gióp «ng dß la tin tøc cña Vò Thanh Linh.", "Nghe nãi gÇn ®©y cã ng­êi gÆp Êu ®ång cña Thanh Linh ë §«ng Doanh §¶o, anh hïng h·y ®Õn §«ng Doanh §¶o t×m xem!");
        SetTaskByte(Task_garherMaster, 1, 1);
        TaskNote(1510, 0);
    end
end

function caiyao()
    CloseDialog()
    if (GetLevel() >= 20) then
        MsgBox("Kü n¨ng sèng: Sau khi häc thu thËp cã thÓ thö thu thËp thuèc, ®ång ı tiªu 1000 ng©n l­îng häc kü n¨ng sèng <c=g>thu thËp<c> kh«ng? ", "yes_caiyao", "no")
    else
        Talk(1, "no", "Häc kü n¨ng <c=g>thu thËp<c> yªu cÇu ®¹t cÊp 20, ng­¬i ch­a ®ñ cÊp, kh«ng thÓ häc kü n¨ng nµy.")
    end
end
function yes_caiyao()
    CloseDialog()
    local cost = 1000
    if (GetCash() >= cost) then
        AddLiveSkill(1, 1)
        PrePay(cost)
        Msg2Player("§· häc kü n¨ng <c=g>thu thËp<c>")
        TopMessage("Chóc mõng b¹n häc ®­îc kü n¨ng <c=g>thu thËp<c>")
        TaskNote(1200, 2)
        SetTask(Task_caiyao, 1)
        Talk(1, "no", "T©y C«n L«n cã rÊt nhiÒu thùc vËt dïng ®Ó luyÖn ®¬n d­îc, khi ng­¬i nhÊp chuét lªn chóng sÏ biÕn thµnh h×nh Cuèc. §ång thêi hiÓn thŞ tªn gäi vµ ®¼ng cÊp cña thùc vËt, nhÊp chuét tr¸i vµo chóng ®Ó b¾t ®Çu thu thËp. H·y gióp ta h¸i vÒ 1 c©y B¹ch Trµ. L­u ı: Th¶o d­îc sÏ r¬i xuèng ®Êt, ®õng quªn nhÆt lªn ®Êy!")
    else
        Talk(1, "no", "Kü n¨ng sèng: Häc kü n¨ng sèng <c=g>thu thËp<c> cÇn tiªu hao 1000 ng©n l­îng, ng©n l­îng trªn ng­êi kh«ng ®ñ. ")
    end
end

function wanchengcaiyao()
    CloseDialog()
    if (GetTask(Task_caiyao) == 1) and (HaveNormalItem(3, 910, 0, 0) >= 1) then
        Talk(1, "no", "Chóc mõng ng­¬i hoµn thµnh lÇn thu thËp ®Çu tiªn! ë Môc D·, TrÇn §­êng cßn rÊt nhiÒu Th¶o D­îc ®ang ®îi ng­¬i thu thËp!")
        DelNormalItem(3, 910, 0, 0)
        AddNormalItemPile(8, 905, 0, 1, 0, 0)
        AddNormalItemPile(8, 905, 0, 1, 0, 0)
        AddNormalItemPile(8, 905, 0, 1, 0, 0)
        TaskNote(1200, -1)
        Msg2Player("NhËn ®­îc 3 ChØ HuyÕt Lé")
        SetTask(Task_caiyao, 2)
    else
        Talk(1, "no", "T©y C«n L«n cã rÊt nhiÒu B¹ch Trµ sinh tr­ëng, ng­¬i h·y ®Õn ®ã thu thËp. L­u ı: Th¶o d­îc sÏ r¬i xuèng ®Êt, ®õng quªn nhÆt lªn ®Êy!")
    end
end

function gatherupgrade()
    local playerlevel = GetLevel()
    local gatherlevel = GetLiveSkillLevel(1)
    local needlevel = (gatherlevel + 1) * 10 + 10
    local gatherProficiency = GetLiveSkillProficiency(1)
    local cost = 10000 * 2 ^ gatherlevel
    if (gatherlevel == 10) then
        Talk(1, "no", "§¼ng cÊp thu thËp cña ng­¬i ®· ®Õn møc tèi ®a, kh«ng cÇn th¨ng cÊp n÷a.")
    elseif (gatherProficiency ~= 10000) then
        Talk(1, "no", "HiÖn t¹i ®é thuÇn thôc cña kü n¨ng thu thËp ch­a ®¹t møc <c=g>100%<c>, kh«ng thÓ tiÕn hµnh th¨ng cÊp.")

    elseif (gatherlevel == 9) then

        if (playerlevel < 120) then
            Talk(1, "no", "Ng­êi ch¬i ®¹t cÊp 120 trë lªn, kü n¨ng thu thËp ®¹t cÊp 9, ®é thuÇn thôc ®¹t 100% míi cã thÓ häc kü n¨ng thu thËp cÊp 10.")
        else
            Talk(1, "no", " CÊp 10-T«n S­ hiÖn ch­a më!")

        end


    elseif (playerlevel < needlevel) then
        Talk(1, "no", " " .. gatherlevel .. "Kü n¨ng thu thËp th¨ng cÊp ®Õn" .. (gatherlevel + 1) .. "Yªu cÇu ®¼ng cÊp nh©n vËt lµ" .. needlevel .. ", ng­¬i ch­a ®ñ cÊp, kh«ng thÓ tiÕn hµnh th¨ng cÊp.")
    elseif (GetCash() >= cost) then
        MsgBox(" B¹n muèn bá ra" .. cost .. " b¹c ®Ó th¨ng cÊp kü n¨ng <c=g>thu thËp<c> kh«ng?", "yes_gatherup", "no")
    else
        Talk(1, "no", " " .. gatherlevel .. "Kü n¨ng thu thËp th¨ng cÊp ®Õn" .. (gatherlevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
    end
end

function yes_gatherup()
    CloseDialog()
    local gatherlevel = GetLiveSkillLevel(1)
    local cost = 10000 * 2 ^ gatherlevel
    if (GetCash() >= cost) then
        AddLiveSkill(1, gatherlevel + 1)
        PrePay(cost)
        Talk(1, "no", " Xin chóc mõng! Kü n¨ng <c=g>thu thËp<c> ®· th¨ng ®Õn cÊp" .. (gatherlevel + 1) .. ".")
        Msg2Player("Kü n¨ng thu thËp th¨ng ®Õn cÊp" .. (gatherlevel + 1) .. " (cÊp)")
    else
        Talk(1, "no", " " .. gatherlevel .. "Kü n¨ng thu thËp th¨ng cÊp ®Õn" .. (gatherlevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
    end
end

function gatherexplain()
    Talk(2, "no", "Häc xong kü n¨ng thu thËp, khi di ®éng chuét ®Õn chç Th¶o d­îc cã thÓ thu thËp sÏ biÕn thµnh <c=g>Cuèc thuèc<c>. NÕu Th¶o d­îc hiÓn thŞ <c=g>mµu ®á<c>, tøc lµ ®¼ng cÊp kü n¨ng thu thËp cña ng­¬i kh«ng ®ñ, kh«ng thÓ thu thËp. Ng­¬i chØ thu thËp ®­îc Th¶o D­îc cïng cÊp hoÆc thÊp h¬n ®¼ng cÊp kü n¨ng sèng cña ng­¬i.", "Ng­¬i cã thÓ ®Õn <c=g>Sïng Thµnh<c>, <c=g>Miªu C­¬ng<c>, <c=g>T©y C«n L«n<c>, <c=g>Môc D·<c>, <c=g>TrÇn §­êng<c> t×m Th¶o d­îc cÊp thÊp.\n§Õn <c=g>Hoang m¹c<c>, <c=g>TÇng 1 Hiªn Viªn ®éng<c>, <c=g>§«ng H¶i Thñy Vùc<c>, <c=g>Ngäc TuyÒn B¨ng Xuyªn<c>, <c=g>TuyÖt Long LÜnh<c> t×m Th¶o d­îc trung vµ cao cÊp.")
end

function mine()
    CloseDialog()
    local tasks = {
        { "LÇn ®Çu Khai Kho¸ng", "caikuang"; show = 0 },
        { "Th¨ng cÊp kü n¨ng khai kho¸ng", "mineupgrade"; show = 0 },

        { "<c=g>Lªn T«n S­<c>", "Mine_Guru"; show = 0 },
        { "<c=g>Hñy T«n S­<c>", "Mine_Guru"; show = 0 },

        { "H­íng dÉn", "mineexplain"; show = 1 },

    }

    local SkillLevel = GetLiveSkillLevel(3)
    if (SkillLevel == 0) then
        tasks[1].show = 1;
    elseif (SkillLevel < 9) then
        tasks[2].show = 1;
    end

    if (GetLevel() >= 120) and (SkillLevel == 9) and (GetLiveSkillProficiency(3) == 10000) then
        local taskStep = GetTaskByte(gMineTask, 1)
        if (taskStep == 0) or (taskStep >= 7) then
            tasks[3].show = 1
        else
            tasks[4].show = 1
        end
    end

    SayTask("Kü n¨ng khai kho¸ng gåm <c=g>10 cÊp<c>, b¾t ®Çu häc kü n¨ng nµy ®¼ng cÊp nh©n vËt lµ 20, th«ng qua t¨ng <c=g>®é thuÇn thôc<c> cña kü n¨ng ®Ó th¨ng cÊp. Khi kü n¨ng khai kho¸ng <c=g>ch­a ®ñ cÊp 4<c> ng­¬i chØ cã thÓ ®Õn <c=g>Thanh §ång S¬n<c> ®Ó n©ng cao kü n¨ng. Sau khi ®¹t ®Õn cÊp 4, ng­¬i cã thÓ thu thËp Kho¸ng Th¹ch quı. §¼ng cÊp nh©n vËt t¨ng <c=g>10 cÊp<c> kü n¨ng t¨ng tèi ®a 1 cÊp.", tasks)
end;
function caikuang()
    CloseDialog()
    if (GetLevel() >= 20) then
        MsgBox("Kü n¨ng sèng: Sau khi häc ®µo kho¸ng cã thÓ thö thu thËp kho¸ng th¹ch, ®ång ı tiªu 1000 ng©n l­îng häc kü n¨ng sèng <c=g>®µo kho¸ng<c> kh«ng? ", "yes_caikuang", "no")
    else
        Talk(1, "no", "Häc kü n¨ng <c=g>khai kho¸ng<c> yªu cÇu ®¹t cÊp 20, ng­¬i ch­a ®ñ cÊp, kh«ng thÓ häc kü n¨ng nµy.")
    end
end
function yes_caikuang()
    CloseDialog()
    local cost = 1000
    if (GetCash() >= cost) then
        AddLiveSkill(3, 1)
        PrePay(cost)
        Msg2Player("§· häc kü n¨ng <c=g>khai kho¸ng<c>")
        TopMessage("Chóc mõng b¹n häc ®­îc kü n¨ng <c=g>khai kho¸ng<c>")
        Talk(1, "no", "Khi kü n¨ng khai kho¸ng <c=g>ch­a ®¹t cÊp 4<c>, kh«ng thÓ thu thËp Kho¸ng Th¹ch quı. Ng­¬i cã thÓ ®Õn Thanh §ång S¬n rÌn luyÖn kü n¨ng, ngoµi §ång thau, n¬i ®ã cßn cã <c=g>Hoµng ®ång<c>, <c=g>Xİch ®ång<c>, <c=g>Tö ®ång<c>, ng­¬i h·y ®Õn Diªu Tr× gÆp Thî ®ång hái râ h¬n, tiÖn thÓ mang vÒ ®©y 1 <c=g>Hoµng ®ång<c>.")
        TaskNote(1201, 0)
        SetTask(Task_caikuang, 1)
    else
        Talk(1, "no", "Kü n¨ng sèng: Häc kü n¨ng sèng <c=g>®µo kho¸ng<c> cÇn tiªu hao 1000 ng©n l­îng, trªn ng­êi kh«ng ®ñ ng©n l­îng.")
    end
end

function wanchengcaikuang()
    CloseDialog()
    if (GetTask(Task_caikuang) == 2) and (HaveNormalItem(3, 928, 0, 0) >= 1) then
        Talk(1, "no", "Ng­¬i ®· cã nhiÒu hiÓu biÕt vÒ Thanh §ång S¬n, ®îi ®¼ng cÊp kü n¨ng cña ng­¬i <c=g> ®¹t cÊp 4 trë lªn<c>, cã thÓ thu thËp c¸c kho¸ng th¹ch quı hiÕm nh­ <c=g>Hµn thiÕt<c>, <c=g>B¹ch kim<c>.")
        DelNormalItem(3, 928, 0, 0)
        AddNormalItemPile(8, 906, 0, 1, 0, 0)
        AddNormalItemPile(8, 906, 0, 1, 0, 0)
        AddNormalItemPile(8, 906, 0, 1, 0, 0)
        TaskNote(1201, -1)
        Msg2Player("NhËn ®­îc 3 İch thÇn lé")
        SetTask(Task_caikuang, 3)
    else
        Talk(1, "no", "<c=g>Thî ®ång ë Diªu Tr×<c> rÊt am hiÓu vÒ kho¸ng th¹ch, ng­¬i h·y ®Õn ®ã hái xem.")
    end
end
function mineupgrade()
    local playerlevel = GetLevel()
    local minelevel = GetLiveSkillLevel(3)
    local needlevel = (minelevel + 1) * 10 + 10
    local mineProficiency = GetLiveSkillProficiency(3)
    local cost = 10000 * 2 ^ minelevel
    if (minelevel == 10) then
        Talk(1, "no", " §¼ng cÊp kü n¨ng khai kho¸ng cña ng­¬i ®· ®¹t møc tèi ®a, kh«ng cÇn th¨ng cÊp n÷a.")
    elseif (mineProficiency ~= 10000) then
        Talk(1, "no", " §é thuÇn thôc kü n¨ng khai kho¸ng cña ng­¬i ch­a ®¹t <c=g>100%<c>, kh«ng thÓ tiÕn hµnh th¨ng cÊp.")

    elseif (minelevel == 9) then

        if (playerlevel < 120) then
            Talk(1, "no", " Ng­êi ch¬i ®¹t cÊp 120 trë lªn, kü n¨ng khai kho¸ng ®¹t cÊp 9, ®é thuÇn thôc ®¹t 100% míi cã thÓ häckü n¨ng khai kho¸ng cÊp 10.")
        else
            MsgBox("B¹n muèn bá ra" .. cost .. "B¹c ®Ó th¨ng cÊp kü <c=g>khai kho¸ng<c> chø?", "yes_mineup", "no")
        end


    elseif (playerlevel < needlevel) then
        Talk(1, "no", " " .. minelevel .. "Kü n¨ng khai kho¸ng ®· ®¹t cÊp" .. (minelevel + 1) .. "Yªu cÇu ®¼ng cÊp nh©n vËt tõ" .. needlevel .. ", ng­¬i ch­a ®ñ cÊp, kh«ng thÓ tiÕn hµnh th¨ng cÊp.")
    elseif (GetCash() >= cost) then
        MsgBox(" B¹n muèn bá ra" .. cost .. "B¹c ®Ó th¨ng cÊp kü <c=g>khai kho¸ng<c> chø?", "yes_mineup", "no")
    else
        Talk(1, "no", " " .. minelevel .. "Kü n¨ng khai kho¸ng ®· ®¹t cÊp" .. (minelevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
    end
end

function yes_mineup()
    CloseDialog()
    local minelevel = GetLiveSkillLevel(3)
    local cost = 10000 * 2 ^ minelevel
    if (GetCash() >= cost) then
        AddLiveSkill(3, minelevel + 1)
        PrePay(cost)
        Talk(1, "no", " Chóc mõng! Kü n¨ng <c=g>khai kho¸ng<c> ®· ®¹t cÊp" .. (minelevel + 1) .. ".")
        Msg2Player("Kü n¨ng khai kho¸ng th¨ng ®Õn cÊp" .. (minelevel + 1) .. " (cÊp)")

        if ((minelevel + 1) == 10) then
            AddGlobalNews(GetName() .. "Kü n¨ng khai kho¸ng ®· ®¹t cÊp t«n s­.")
            WriteLog(GetName() .. "Kü n¨ng khai kho¸ng ®· ®¹t cÊp 10")
        end

    else
        Talk(1, "no", " " .. minelevel .. "Kü n¨ng khai kho¸ng ®· ®¹t cÊp" .. (minelevel + 1) .. "CÇn tiªu hao b¹c" .. cost .. ", b¹n kh«ng ®ñ b¹c.")
    end
end

function mineexplain()
    Talk(2, "no", "§¼ng cÊp khai kho¸ng thÊp h¬n cÊp 3, ng­¬i cã thÓ ®Õn kho¸ng khu s¬ cÊp ë Thanh §ång S¬n thu thËp kho¸ng th¹ch ®Ó n©ng cao ®¼ng cÊp kü n¨ng.", "Sau khi ®¼ng cÊp kü n¨ng khai kho¸ng ®¹t cÊp 4 trë lªn, cã thÓ ®Õn Thanh §ång S¬n thu thËp kho¸ng th¹ch, hoÆc ®Õn <c=g>TuyÖt Long LÜnh<c>, <c=g>Khæn Tiªn cung<c>, thËm chİ <c=g>Tam Tiªn §¶o<c> ®Ó thu thËp kho¸ng s¶n quı hiÕm.")
end

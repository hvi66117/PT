--description: ÙÈ²®Òæ
--author: yangfeng
--date: 2005/10/21

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02

function main()
    tasks = {
        { "Gióp ®ì", "help"; show = 0 },
        { "Muèn hµng", "yygx"; show = 0 },
        { "Th¸nh ®Şa", "eling"; show = 0 }
    }
    if (GetTask(597) == 16) then
        tasks[1].show = 1;
    end ;
    if (GetTask(597) == 23) then
        tasks[2].show = 1;
    end ;
    if (GetTask(597) == 29) or (GetTask(597) == 30) then
        tasks[3].show = 1;
    end ;
    SayTask(13909, tasks)
end;

function help()
    MsgBox(13910, "yes_1", "no")
end;

function yygx()
    MsgBox(13911, "yes_2", "no")
end;

function yes_2()
    MsgBox(13912, "pangmang", "no")
end;

function eling()
    if (GetTask(597) == 29) then
        MsgBox(13913, "shaeling", "no")
    else
        if (GetItemCount(114) < 7) then
            Talk(1, "no", 13914)
        elseif (GetItemCount(114) >= 7) then
            MsgBox(13915, "yes_3", "no")
        end ;
    end ;
end;

function shaeling()
    Talk(3, "no", "<color=green>" .. GetName() .. "<c>:Mêi téc tr­ëng nãi.", "B¶n TuyÒn th¸nh ®Şa bçng nhiªn xuÊt hiÖn mét sè loµi ¸c thó. Cã ng­êi ®· ®¸nh qu¸i ë ®ã lÊy ®­îc <c=yel>m¶nh ph¸p khİ<c>, gåm <c=g>7 lo¹i<c>. Ng­¬i cã thÓ ®Õn ®ã xem thö.", "<color=green>" .. GetName() .. "<c>:NÕu vËy ta ph¶i ®i mét chuyÕn.")
    SetTask(597, 30)
    AddCredit(15)--ÉùÍû½±Àø
    AddOwnExp(4000) --¾­Ñé½±Àø
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 15 ®iÓm danh väng!")
    TopMessage(13071)
    TaskNote(35, 37)
    Msg2Player("§Õn B¶n TuyÒn t×m 7 m¶nh Ph¸p Khİ")
end;

function yes_3()
    SetTask(597, 31)
    TaskNote(35, 38)
    Talk(1, "no", "<color=green>" .. GetName() .. "<c>:T¹i h¹ ®i ngay!")
    Msg2Player("Hái th¨m Kh­¬ng Tö Nha vÒ lai lŞch Ph¸p khİ!")
end;

function pangmang()
    AddEventItem(109)
    Msg2Player("NhËn ®­îc th­ cña YÓn B¸ İch")
    SetTask(597, 24)
    TaskNote(35, 31)
    AddCredit(30)--ÉùÍû½±Àø
    AddOwnExp(4000) --¾­Ñé½±Àø
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
    TopMessage(13074)
    Msg2Player("Håi b¸o §Æng Cöu C«ng!")
    Talk(2, "no", "<color=green>" .. GetName() .. "<c>:Nghe téc tr­ëng nãi, t¹i h¹ lÊy lµm hæ thÑn! T¹i h¹ t×nh nguyÖn gãp chót søc khuyÓn m·", "Tr«ng cËy vµo tr¸ng sÜ!")
end;

function yes_1()
    SetTask(597, 299)
    AddCredit(25)--ÉùÍû½±Àø
    AddOwnExp(4000) --¾­Ñé½±Àø
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
    TopMessage(11750)
    TaskNote(35, 18)
    Msg2Player("§i trî gióp YÓn Thóc Di!")
    Talk(2, "no", "<color=green>" .. GetName() .. "<c>:Tr­íc nguy c¬ cña §«ng Di téc, kh«ng thÓ ®øng khoanh tay, ta ph¶i lªn ®­êng ngay ®©y.", "Tr¸ng sÜ thËt träng t×nh träng nghÜa! H·y ®Õn chç <c=g>Thóc Di<c> mét chuyÕn!")
end;

function no()
    CloseDialog()
end;

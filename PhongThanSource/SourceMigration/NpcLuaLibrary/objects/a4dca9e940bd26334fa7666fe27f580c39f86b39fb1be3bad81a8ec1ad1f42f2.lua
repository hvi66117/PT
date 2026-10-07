--description: ¨ªªQ¤l
--author:yichuan
--date: 2004/6/10
--modify:liuying 2005/4/5(¥[¤J¤F¥L¤s¤§¥Ûªº¥æ´«¥ô°È)

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

-----------------------------------------add by zhangpu start
VALENTINE = 1682

--Modified by DuWen for 2011ÇéÈË½Ú begin
vnpc = {
    { "Th©n C«ng B¸o", "Ph©n Thñy T­íng Qu©n" },
    { "Na Tra", "Tóc §Ó Sinh Uy" },
    { "L«i ChÊn Tö", "SÝ Th¸p Phong V©n" },
    { "NhÞ Lang thÇn", "Tam Môc L­¬ng NhÜ" },
    { "TriÖu C«ng Minh", "NhËt NguyÖt Qu©n" },
    { "XÝch Tïng Tö", "Tr× Méc C«ng Tö" },
    { "BÝch Tiªu", "BÝch S¾c Cöu Thiªn" },
    { "Quúnh Tiªu", "Mü Ngäc V« H¹" },
    { "V©n Tiªu", "B¹ch V©n Vò Nghª" },
    { "ThÓ V©n", "ThÊt S¾c T­êng V©n" },
    { "Long C¸t", "Hång Loan Thiªn TuÕ" },
    { "Thä Tinh", "Tr­êng Sinh BÊt L·o" },
    { "Léc Tinh", "Kim B¶ng §Ò Danh" },
    { "Phóc Tinh", "C¸t T­êng Phó Quý" },
    { "TrÊn Nguyªn", "§Ønh §Þnh Cµn Kh«n" }
}
--Modified by DuWen for 2011ÇéÈË½Ú end

---------------------------------------add by zhangpu end

function main(sel)
    tasks = {
        { "Hîp vËt phÈm", "dz"; show = 1 },
        { "S¬n th¹ch", "tszs"; show = 1 },
        { "B¶o ®iÓn", "hcbd"; show = 1 },
    }

    -------------------------------add by zhangpu start
    --Modified by DuWen for 2011ÇéÈË½Ú begin
    --local y,m,d = GetYMD()
    --if ( y == 2011 and m == 2 and d >=14 and d <= 16 ) then
    --	local ret = valentine()
    --	if ( ret == 1 ) then
    --		return --Èç¹ûÔÚÇéÈË½Ú»î¶¯ÖÐÇ°½øÒ»²½£¬Ôò²»µ¯³öÕý³£¹¦ÄÜ¿ò¡£
    --	end
    --end
    --Modified by DuWen for 2011ÇéÈË½Ú end
    -------------------------------add by zhangpu end
    SayTask(10499, tasks)
end;

function no()
    CloseDialog()
end;

function dz()
    CloseDialog()

    if (IsPlayerOpenProtect() == 1) then
        if (IsPlayerInProtect() ~= 0) then
            Talk(1, "no", "VËt phÈm cña ng­¬i ®ang ®­îc Linh Lung Táa b¶o hé, ph¶i bá b¶o hé th× míi cã thÓ tiÕn hµnh hîp thµnh!")
            return 0
        end
    end
    EnchaseItem(1);
end;


-- ËûÉ½Ö®Ê¯¶Ò»»ÓÅ»¯  Add by qiufan  2009\11\2   begin

function tszs()
    CloseDialog()
    local tasks = {
        { "®æi 1 ", "change1"; show = 1 },
        { "®æi 10 ", "change10"; show = 1 },
        { "®æi 100 ", "change100"; show = 1 },
    }
    SayTask(" §æi 1 Tha S¬n Th¹ch cÇn <c=r>10 ®iÓm<c> danh väng, xin chän sè l­îng muèn ®æi.", tasks)
end;
function change1()
    CloseDialog()
    MsgBox("B¹n muèn dïng <c=r>10<c> ®iÓm danh väng ®æi 1 Tha S¬n Th¹ch?", "change1_yes", "no")
end;

function change1_yes()
    CloseDialog()
    if (GetCredit() >= 10) then
        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "no", " Hµnh trang kh«ng ®ñ chç trèng, xin s¾p xÕp l¹i tr­íc!")
            Msg2Player("Hµnh trang kh«ng ®ñ trèng, xin s¾p xÕp l¹i tr­íc")
        else
            DecCredit(10)
            AddNormalItemPile(3, 82, 0, 0, 0, 0)
            MsgBox(" Thµnh c«ng ®æi <c=r>1<c> Tha S¬n Th¹ch.", "change1", "no")
        end
    else
        MsgBox(" §iÓm danh väng kh«ng ®ñ, kh«ng thÓ ®æi .", "no")

    end
end;

function change10()
    CloseDialog()
    MsgBox("B¹n muèn dïng <c=r>100<c> ®iÓm danh väng ®æi <c=r>10<c> Tha S¬n Th¹ch?", "change10_yes", "no")
end;

function change10_yes()
    CloseDialog()

    if (GetCredit() >= 100) then
        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "no", " Hµnh trang kh«ng ®ñ chç trèng, xin s¾p xÕp l¹i tr­íc!")
            Msg2Player("Hµnh trang kh«ng ®ñ trèng, xin s¾p xÕp l¹i tr­íc")
        else
            DecCredit(100)
            for i = 1, 10 do
                AddNormalItemPile(3, 82, 0, 0, 0, 0)
            end
            MsgBox(" Thµnh c«ng ®æi <c=r>10<c> Tha S¬n Th¹ch.", "change10", "no")
        end
    else
        MsgBox(" §iÓm danh väng kh«ng ®ñ, kh«ng thÓ ®æi .", "no")
    end
end;

function change100()
    CloseDialog()
    MsgBox("B¹n muèn dïng <c=r>1000<c> ®iÓm danh väng ®æi <c=r>100<c> Tha S¬n Th¹ch?", "change100_yes", "no")
end;

function change100_yes()
    CloseDialog()

    if (GetCredit() >= 1000) then
        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "no", " Hµnh trang kh«ng ®ñ chç trèng, xin s¾p xÕp l¹i tr­íc!")
            Msg2Player("Hµnh trang kh«ng ®ñ trèng, xin s¾p xÕp l¹i tr­íc")
        else
            DecCredit(1000)
            for i = 1, 100 do
                AddNormalItemPile(3, 82, 0, 0, 0, 0)
            end
            MsgBox(" Thµnh c«ng ®æi <c=r>100<c> Tha S¬n Th¹ch.", "change100", "no")
        end
    else
        MsgBox(" §iÓm danh väng kh«ng ®ñ, kh«ng thÓ ®æi .", "no")
    end
end;
-- ËûÉ½Ö®Ê¯¶Ò»»ÓÅ»¯  Add by qiufan  2009\11\2   END
function hcbd()
    --¦X¦¨Ä_¨å
    tasks1 = {
        { "Vò khÝ", "wqsj"; show = 1 },
        { "Trang bÞ", "zbsj"; show = 1 },
        { "B¶o ®iÓn", "fbhc"; show = 1 },
        { "GhÐp ngäc", "yshc"; show = 1 },
        { "B¶o th¹ch", "bshc"; show = 1 },
        { "Lo¹i kh¸c", "qthc"; show = 1 }
    }
    SayTask(12870, tasks1)

end;

function wqsj()
    CloseDialog()
    Talk(1, "wqsj1", 12871)
end;
function wqsj1()
    CloseDialog()
    Talk(1, "wqsj2", 12872)
end;
function wqsj2()
    CloseDialog()
    Talk(1, "wqsj3", 12873)
end;
function wqsj3()
    CloseDialog()
    Talk(1, "wqsj4", 12874)
end;
function wqsj4()
    CloseDialog()
    Talk(1, "wqsj5", 12875)
end;
function wqsj5()
    CloseDialog()
    Talk(1, "hcbd", 12876)
end;
function zbsj()
    CloseDialog()
    Talk(1, "zbsj1", 12877)
end;
function zbsj1()
    CloseDialog()
    Talk(1, "zbsj2", 12878)
end;
function zbsj2()
    CloseDialog()
    Talk(1, "zbsj3", 12879)
end;
function zbsj3()
    CloseDialog()
    Talk(1, "hcbd", 12880)
end;

function fbhc()
    --¦X¦¨Ä_¨å
    CloseDialog()
    local tasks2 = {
        { "Ph¸p b¶o", "fbhc11"; show = 1 },
        { "Th¨ng cÊp ph¸p b¶o", "fbsj3"; show = 1 }


    }
    SayTask("D­íi ®©y lµ giíi thiÖu c¸c ph­¬ng ph¸p hîp thµnh vµ th¨ng cÊp ph¸p b¶o.", tasks2)
end;
function fbsj3()
    --¦X¦¨Ä_¨å
    CloseDialog()
    local tasks2 = {
        { "Ph¸p b¶o 2 thuéc tÝnh", "fbsj1"; show = 1 },
        { "Ph¸p b¶o ®a thuéc tÝnh", "fbsj2"; show = 1 }

    }
    SayTask("D­íi ®©y lµ giíi thiÖu chi tiÕt ph­¬ng ph¸p th¨ng cÊp c¸c lo¹i Ph¸p b¶o.", tasks2)
end;

function fbhc11()
    CloseDialog()
    Talk(2, "fbhc11_1", "<c=g>Hîp thµnh Hçn Nguyªn Ch©u <c>:\n4 Tø T­îng Tinh Th¹ch+8 T­íng Qu©n LÖnh+10 Dung Tinh Lé=Hçn Nguyªn Ch©u\n<c=yel>Thuéc TÝnh:<c><c=water>T¨ng ®ãng b¨ng 10%<enter><tab>T¨ng Háa s¸t 10%<enter><tab>T¨ng Thæ s¸t 15~20<enter><tab>T¨ng kh¶ n¨ng s¸t th­¬ng thuéc tÝnh L«i thªm 15~20<c>\nThµnh c«ng 100%, yªu cÇu ®¼ng cÊp 70", "<c=g>Hîp thµnh Dung Tinh Lé<c>:\nCµn Kh«n XÝch+H.T. L¨ng+B×nh L­u Ly+Háa Long tiªu+3 NQTh¹ch=Dung Tinh Lé\nKim Cang Ph¸ch+¢m D­¬ng KÝnh+BÝch Tú Bµ+Tói Ng« Phong+3 NQTh¹ch=Dung Tinh Lé\nÊm V¹n Nha+Bµn Cæ ph­ín+d©y Ph­îc Long+Th¸i D­¬ng Ch©m+3 NQ Th¹ch=Dung Tinh Lé\nd©y Khæn Tiªn+ChÊn Thiªn Cung+Kim B¸t Vu+Linh Lung th¸p+3 NGTh¹ch=Dung Tinh Lé\nChó ý: tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt")
end;
function fbhc11_1()
    CloseDialog()
    Talk(1, "fbhc11_2", "<c=g>Hîp thµnh Dung Tinh Lé<c>: \nThanh V©n KiÕm+Ngäc Nh­ ý +HáaTú Bµ+An MÖnh Phï+3 Ngò quang th¹ch=3 Dung Tinh Lé\n100% thµnh c«ng")
end;
function fbhc11_2()
    CloseDialog()
    Talk(1, "fbhc11_3", "<c=g>Hîp thµnh Dung Tinh Lé<c>: \nToµn T©m §inh+Hång Hå L«+L¹c Hån Chung+Ngäc H­ Phï+3 Ngò quang th¹ch=2 Dung Tinh Lé\nCäc §én Long+KÝnh chiÕu yªu+Phong Háa lu©n+Kim Quang Táa+3 Ngò quang th¹ch=2 Dung Tinh Lé\nH¹nh Hoµng kú+Cµn Kh«n khuyªn+B¹ch Cèt ph­ín+§Þnh Phong ch©u+3 Ngò quang th¹ch=2 Dung Tinh Lé\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")
end;
function fbhc11_3()
    CloseDialog()
    Talk(2, "fbhc11_4", 12881, "<c=g>H.thµnh Ph¸p b¶o:<c>Bµn Cæ ph­ín+TN Phong+Hång TT=Cäc §.Long\n+ T.D­¬ng ch©m+¢.D­¬ng kÝnh+Hång TT=C.Yªu kÝnh\n+ Êm V.Nha+KC ph¸ch+Hång TT=P.Háa lu©n\n+ D©y P.Long+BT.bµ+Hång TT=KQ Táa\n<c=yel>Chó ý:<c> Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt.")

end;
function fbhc11_4()
    CloseDialog()
    Talk(1, "fbhc11_5", 12882)
end;
function fbhc11_5()
    CloseDialog()
    Talk(1, "fbhc11_6", "<color=green>Hîp thµnh Ph¸p b¶o 3 thuéc tÝnh<color>: \nCµn Kh«n XÝch+Ngò quang th¹ch+Cµn Kh«n khuyªn+ChÊn Thiªn Cung+Tha S¬n Th¹ch*20=Thanh V©n KiÕm\nB×nh L­u Ly+H×nh Thiªn Ên+§Þnh Phong ch©u+D©y Khæn Tiªn+Tha S¬n Th¹ch*20=Ngäc Nh­ ý \nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")

end;
function fbhc11_6()
    CloseDialog()
    Talk(1, "hcbd", "<color=green>Hîp thµnh Ph¸p b¶o 3 thuéc tÝnh<color>: \nHáa Long tiªu+Ngò quang th¹ch+B¹ch Cèt ph­ín+Linh Lung Th¸p+Tha S¬n Th¹ch*20=HáaTú Bµ\nHçn Thiªn L¨ng+H×nh Thiªn Ên+H¹nh Hoµng kú+Kim B¸t Vu+Tha S¬n Th¹ch*20=An MÖnh Phï\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")

end;
function fbsj1()
    CloseDialog()
    Talk(1, "fbsj1_1", 12883)
end;
function fbsj1_1()
    CloseDialog()
    Talk(1, "fbsj1_2", "<c=g>Th¨ng cÊp Ph¸p b¶o 2 thuéc tÝnh<c>: <enter>Ph¸p b¶o hîp thµnh 2 thuéc tÝnh+Hång B¶o Th¹ch+Lß luyÖn cao cÊp=Ph¸p b¶o hîp thµnh 2 thuéc tÝnh (t¨ng 7, 8, 9)<enter>Ph¸p b¶o 2 thuéc tÝnh+Hång B¶o Th¹ch*3+2 Dung Tinh Lé+Lß luyÖn Tr©n Hùu=Ph¸p b¶o 2 thuéc tÝnh (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj1_2()
    CloseDialog()
    Talk(1, "fbsj1_3", "<c=g>Th¨ng cÊp Vu Lan Bån<c>: <enter>Vu Lan Bån+Ph¸p b¶o cÊp 10 mçi lo¹i 1 +Hång B¶o Th¹ch+Lß luyÖn s¬ cÊp=Vu Lan Bån (t¨ng 1,2,3)<enter>Vu Lan Bån+Ph¸p b¶o cÊp 10 mçi lo¹i 1 +Hång B¶o Th¹ch+Lß luyÖn trung cÊp=Vu Lan Bån (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj1_3()
    CloseDialog()
    Talk(1, "fbsj1_4", "<c=g>Th¨ng cÊp Vu Lan Bån<c>: <enter>Vu Lan Bån+Ph¸p b¶o cÊp 10 mçi lo¹i 1 +Hång B¶o Th¹ch+Lß luyÖn cao cÊp=Vu Lan Bån (t¨ng 7,8,9)<enter>Vu Lan Bån+Hång B¶o Th¹ch*3+2 Dung Tinh Lé+Lß luyÖn Tr©n Hùu=Vu Lan Bån (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj1_4()
    CloseDialog()
    Talk(1, "fbsj1_5", "<c=g>Th¨ng cÊp TrÊn Hån Th¹ch [cÊp 5]<c>: <enter>TrÊn Hån Th¹ch [cÊp 5]+3 Th«i Phong LÖnh+Hång B¶o Th¹ch+Lß luyÖn s¬ cÊp=TrÊn Hån Th¹ch [cÊp 5] (t¨ng 1,2,3)<enter>TrÊn Hån Th¹ch [cÊp 5]+7 Th«i Phong LÖnh+Hång B¶o Th¹ch+Lß luyÖn trung cÊp=TrÊn Hån Th¹ch [cÊp 5] (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj1_5()
    CloseDialog()
    Talk(1, "hcbd", "<c=g>Th¨ng cÊp TrÊn Hån Th¹ch [cÊp 5]<c>: <enter>TrÊn Hån Th¹ch [cÊp 5]+11 Th«i Phong LÖnh+Hång B¶o Th¹ch+Lß luyÖn cao cÊp=TrÊn Hån Th¹ch [cÊp 5] (t¨ng 7,8,9)<enter>TrÊn Hån Th¹ch+14 Th«i Phong LÖnh+5 Dung Tinh Lé+Lß luyÖn Tr©n Hùu*2=TrÊn Hån Th¹ch [cÊp 5] (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;

function fbsj2()
    CloseDialog()
    Talk(1, "fbsj2_1", "<c=g>Th¨ng cÊp Hçn Nguyªn Ch©u<c>: <enter>Hçn Nguyªn Ch©u+Tø T­îng Tinh Th¹ch+5 Dung Tinh Lé+Lß luyÖn s¬ cÊp=Hçn Nguyªn Ch©u (t¨ng 1,2,3)<enter>Hçn Nguyªn Ch©u+2 Tø T­îng Tinh Th¹ch+5 Dung Tinh Lé+Lß luyÖn trung cÊp=Hçn Nguyªn Ch©u (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj2_1()
    CloseDialog()
    Talk(1, "fbsj2_2", "<c=g>Th¨ng cÊp Hçn Nguyªn Ch©u<c>: <enter>Hçn Nguyªn Ch©u+4 Tø T­îng Tinh Th¹ch+5 Dung Tinh Lé+Lß luyÖn cao cÊp=Hçn Nguyªn Ch©u (t¨ng 7,8,9)<enter>Hçn Nguyªn Ch©u+5 Tø T­îng Tinh Th¹ch+5 Dung Tinh Lé+Lß luyÖn Tr©n Hùu*2=Hçn Nguyªn Ch©u (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;

function fbsj2_2()
    CloseDialog()
    Talk(1, "fbsj2_3", "<c=g>Th¨ng cÊp Ph¸p b¶o 3 thuéc tÝnh<c>: <enter>Ph¸p b¶o 3 thuéc tÝnh+Hång B¶o Th¹ch*5+Lß luyÖn s¬ cÊp*2=Ph¸p b¶o 3 thuéc tÝnh (t¨ng 1,2,3)<enter>Ph¸p b¶o 3 thuéc tÝnh+Hång B¶o Th¹ch*5+Lß luyÖn trung cÊp*2=Ph¸p b¶o 3 thuéc tÝnh (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj2_3()
    CloseDialog()
    Talk(1, "fbsj2_4", "<c=g>Th¨ng cÊp Ph¸p b¶o 3 thuéc tÝnh<c>: <enter>Ph¸p b¶o 3 thuéc tÝnh+Hång B¶o Th¹ch*5+Lß luyÖn cao cÊp*2=Ph¸p b¶o 3 thuéc tÝnh (t¨ng 7,8,9)<enter>Ph¸p b¶o 3 thuéc tÝnh+Hång B¶o Th¹ch*5+4 Dung Tinh Lé+Lß luyÖn Tr©n Hùu*2=Ph¸p b¶o 3 thuéc tÝnh (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj2_4()
    CloseDialog()
    Talk(1, "fbsj2_5", "<c=g>V« Cùc Q.C.KÝnh<c>: <enter>VCQCK+Béc Ph¸c Th¹ch+HBTh¹ch+Lß tinh luyÖn S¬ cÊp=VCQCK (1,2,3 th¨ng)<enter>VCQCK+2 BPTh¹ch+HBTh¹ch+Lß tinh luyÖn tr.cÊp=VCQCK (4,5,6 th¨ng)<enter>VCQCK+3 BPTh¹ch+HBTh¹ch+Lß tinh luyÖn c.cÊp=VCQCK (7,8,9 th¨ng)<enter>100% thµnh c«ng")
end

function fbsj2_5()
    CloseDialog()
    Talk(1, "fbsj2_6", "<c=g>V« Cùc Quy Ch©n KÝnh<c>: <enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*15+Tinh ChÝ Béc Ph¸c Th¹ch*3+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 10)<enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*30+Tinh ChÝ Béc Ph¸c Th¹ch*6+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 11)<enter>V« Cùc Quy Ch©n KÝnh+S­ ¢n LÖnh*60+Tinh ChÝ Béc Ph¸c Th¹ch*9+Hång B¶o Th¹ch*3+Lß tinh luyÖn (Tr©n Hùu)*2=V« Cùc Quy Ch©n KÝnh (cÊp 12)<enter>Chó ý: nhÊt ®Þnh thµnh c«ng")
end

function fbsj2_6()
    CloseDialog()
    Talk(1, "fbsj2_7", "<c=g>Kim S¬n Ph¸p B¶o (cã h¹n)<c>:<enter>Kim S¬n (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn s¬ cÊp*2+2 Dung tinh lé=Kim S¬n (cã h¹n) (+1,2,3)<enter>Kim S¬n (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn trung cÊp*2+3 Dung tinh lé=Kim S¬n (cã h¹n) (+4,5,6)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_7()
    CloseDialog()
    Talk(1, "fbsj2_8", "<c=g>Kim S¬n Ph¸p B¶o (cã h¹n)<c>:<enter>Kim S¬n (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn cao cÊp*2+4 Dung tinh lé=Kim S¬n (cã h¹n) (+7,8,9)<enter>Kim S¬n (cã h¹n)+Hång B¶o Th¹ch*5+5 Dung tinh lé+Lß luyÖn Tr©n Hùu*2=Kim S¬n (cã h¹n) (+10,11,12)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_8()
    CloseDialog()
    Talk(1, "fbsj2_9", "<c=g>ThÊt TrÇn Trai Ph¸p B¶o (cã h¹n)<c>:<enter>ThÊt TrÇn Trai (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn s¬ cÊp*2+2 Dung tinh lé=ThÊt TrÇn Trai (cã h¹n) (+1,2,3)<enter>ThÊt TrÇn Trai (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn trung cÊp*2+3 Dung tinh lé=ThÊt TrÇn Trai (cã h¹n) (+4,5,6)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_9()
    CloseDialog()
    Talk(1, "hcbd", "<c=g>ThÊt TrÇn Trai Ph¸p B¶o (cã h¹n)<c>:<enter>ThÊt TrÇn Trai (cã h¹n)+Hång B¶o Th¹ch*5+Lß tinh luyÖn cao cÊp*2+4 Dung tinh lé=ThÊt TrÇn Trai (cã h¹n)(+7,8,9)<enter>ThÊt TrÇn Trai (cã h¹n)+Hång B¶o Th¹ch*5+5 Dung tinh lé+Lß luyÖn Tr©n Hùu*2=ThÊt TrÇn Trai (cã h¹n) (+10,11,12)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;

function yshc()
    CloseDialog()
    Talk(4, "yshc1", 14756, 14757, 14758, 14759)
end;
function yshc1()
    CloseDialog()
    Talk(1, "hcbd", 14764)
end;
--edit by liuyong for ¿×Î»×°ÊÎ
function bshc()
    CloseDialog()
    Talk(3, "bshc1", 14760, 14761, 14777)
end;

function bshc1()
    CloseDialog()
    Talk(1, "hcbd", 12887)
end;
--edit end
function qthc()
    CloseDialog()
    Talk(3, "qthc1", 12884, 12885, 12886)
end;
function qthc1()
    CloseDialog()
    Talk(3, "qthc2", 14762, 12888, 12889)
end;
function qthc2()
    CloseDialog()
    Talk(2, "qthc3", 12890, 14763)
end;
function qthc3()
    CloseDialog()
    Talk(2, "hcbd", "<c=g>Hîp thµnh Néi ®¬n<c>: <enter>5 Bét néi ®¬n=Néi §¬n (thÊp)<enter>5 Néi §¬n (thÊp)=Néi §¬n (trung)<enter>5 Néi §¬n (trung)=Néi ®¬n cap cÊp<enter>Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!.", "<c=g>Hîp thµnh Néi ®¬n<c>: <enter>5 Bét néi ®¬n+Thiªn Quang Thñy=Néi §¬n (thÊp)<enter>5 Néi §¬n (thÊp)+2 Thiªn Quang Thñy=Néi §¬n (trung)<enter>5 Néi §¬n (trung)+3 Thiªn Quang Thñy=Néi ®¬n cap cÊp<enter>100% thµnh c«ng.")
end
----------------------------------------add by zhangpu start
--Modified by DuWen for 2011ÇéÈË½Ú begin
function valentine()
    local idx = 6
    local oIdx = PlayerIndex
    local pIdx = GetTask(VALENTINE + 1)
    local pStep = 0
    local step = GetTaskByte(VALENTINE, 4)

    if (step < 1 or step > 3) then
        return 0
    end

    if (pIdx ~= 0) then
        --×é¶Ó
        if (idx == GetTaskByte(VALENTINE, step)) then
            SetTaskByte(VALENTINE, 4, step + 1)
            if (step == 2) then
                SetTaskByte(VALENTINE, 4, 5)
                Talk(1, "no", "Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                Msg2Player("Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                TaskNote(1600, 1)
            else
                local vnIdx = GetTaskByte(VALENTINE, step + 1)
                local npc = vnpc[vnIdx][2]
                Talk(1, "no", "C¸m ¬n ng­¬i ®· mang chóc phóc ®Õn cho ta, mçi ngµy ®­îc yªu ®Òu lµ LÔ t×nh nh©n.")
                Msg2Player("Anh hïng ®· mang chóc phóc ®Õn ®©y, cßn tiÕp tôc t×m kiÕm Tiªn nh©n tiÕp theo kh«ng.")
                TaskNote(1600, 0, npc)
                SetTaskByte(VALENTINE, 4, step + 1)
            end
            return 1
        else
            Msg2Player("§©y kh«ng ph¶i lµ Tiªn nh©n mµ anh hïng muèn t×m, h·y tiÕp tôc cè g¾ng.")
            return 0
        end
    else
        --Ò»¸öÈË
        local nIdx
        local nextNpc
        if (idx == GetTaskByte(VALENTINE, step)) then
            SetTaskByte(VALENTINE, 4, step + 1)
            if (step == 3) then
                SetTaskByte(VALENTINE, 4, 5)
                Msg2Player("Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                Talk(1, "no", "Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                TaskNote(1600, 1)
                return 1
            elseif (step < 4) then
                SetTaskByte(VALENTINE, 4, step + 1)
                nIdx = GetTaskByte(VALENTINE, step + 1)
                nextNpc = vnpc[nIdx][2]
                Talk(1, "no", "C¸m ¬n ng­¬i ®· mang chóc phóc ®Õn cho ta, mçi ngµy ®­îc yªu ®Òu lµ LÔ t×nh nh©n.")
                Msg2Player("Anh hïng ®· mang chóc phóc ®Õn ®©y, cßn tiÕp tôc t×m kiÕm Tiªn nh©n tiÕp theo kh«ng.")
                TaskNote(1600, 0, nextNpc)
                return 1
            end
            return 0
        else
            Msg2Player("§©y kh«ng ph¶i lµ Tiªn nh©n mµ anh hïng muèn t×m, h·y tiÕp tôc cè g¾ng.")
            return 0
        end
    end
end
--Modified by DuWen for 2011ÇéÈË½Ú end

----------------------------------------------add by zhangpu end

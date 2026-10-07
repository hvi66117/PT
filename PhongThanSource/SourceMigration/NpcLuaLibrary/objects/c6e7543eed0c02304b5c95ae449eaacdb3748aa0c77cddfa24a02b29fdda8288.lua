function GetPlayerTaskState()
    return 0, 0
end

VALENTINE = 1682

vnpc={
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

function main(_)
    tasks = {
        { "Hîp vËt phÈm", "dz"; show = 1 },
        { "S¬n th¹ch", "tszs"; show = 1 },
        { "B¶o ®iÓn", "hcbd"; show = 1 },
        { "Hîp thµnh ThÎ Phong Ên", "beasting"; show = 1 },
        { "Hîp thµnh ThÇn Ên", "signet_levelup"; show = 1 }
    }

    local _, _, _ = GetYMD()

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

function beasting()

    local tasks = {
        { "Hîp thµnh", "beast"; show = 1 },
        { "Quy t¾c hîp thµnh", "beastIntroduce"; show = 1 },
    }

    SayTask("Ngµi cã thÓ hîp thµnh thÎ phong Ên Hung Thó t¹i chç ta, quy t¾c xin tham kh¶o t¹i môc quy t¾c d­íi ®©y", tasks)
end

function beastIntroduce()

    Talk(2, "beasting", "Quy t¾c hîp thµnh: §Æt thÎ phong Ên cÇn hîp thµnh vµo « ë gi÷a, ®Æt 2 thÎ phong Ên cïng lo¹i vµo xung quanh, cÊp cña 2 thÎ cïng lo¹i ph¶i thÊp h¬n cÊp thÎ ®em hîp thµnh.", "Sau khi ®Æt vµo chÝnh x¸c cã thÓ thÊy x¸c suÊt thµnh c«ng, hîp thµnh sÏ tiªu hao 2 thÎ phong Ên ë xung quanh, nÕu thµnh c«ng cÊp thÎ phong Ên + 1, nÕu thÊt b¹i cÊp ®é kh«ng thay ®æi.")
end

function beast()

    CloseDialog()

    if (IsPlayerOpenProtect() == 1) then
        if (IsPlayerInProtect() ~= 0) then
            Talk(1, "no", "VËt phÈm cña ng­¬i ®ang ®­îc Linh Lung Táa b¶o hé, ph¶i bá b¶o hé th× míi cã thÓ tiÕn hµnh hîp thµnh!")
            return 0
        end
    end
    EnchaseBeastItem(1);
end

function tszs()
    CloseDialog()
    if (GetLevel() < 40) then
        Talk(1, "no", "CÊp 40 trë lªn h·y quay l¹i t×m ta!")
        return 0
    end

    local tasks = {
        { "§æi 1 c¸i", "change1"; show = 1 },
        { "§æi 10 c¸i", "change10"; show = 1 },
        { "§æi 100 c¸i", "change100"; show = 1 },
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
            for _ = 1, 10 do
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
            for _ = 1, 100 do
                AddNormalItemPile(3, 82, 0, 0, 0, 0)
            end
            MsgBox(" Thµnh c«ng ®æi <c=r>100<c> Tha S¬n Th¹ch.", "change100", "no")
        end
    else
        MsgBox(" §iÓm danh väng kh«ng ®ñ, kh«ng thÓ ®æi .", "no")
    end
end;

function hcbd()
    tasks1 = {
        { "Vò khÝ", "wqsj"; show = 1 },
        { "Trang bÞ", "zbsj"; show = 1 },
        { "Ph¸p b¶o", "fbhc"; show = 1 },
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
    Talk(1, "zbsj2sy", 12878)
end;

function zbsj2sy()
    CloseDialog()
    Talk(1, "zbsj2sy1", "<c=g>Th¨ng cÊp ThÇn Ên<c>: CÊp ®é yªu cÇu kh«ng thay ®æi, quy t¾c thµnh c«ng/thÊt b¹i gièng th¨ng cÊp trang bÞ\n<c=y>1-3 cÊp<c>:Tinh Hoa Hung Thó*2 + Dung Tinh Lé*5 + Ph¸p B¶o Tinh Hoa*10 + T­íng Qu©n LÖnh*5 + ThÇn Ên Tinh Hoa*10 + ThÇn Ên\n<c=y>4-6 cÊp<c>:Tinh Hoa Hung Thó*3 + Dung Tinh Lé*5 + Ph¸p B¶o Tinh Hoa*20 + T­íng Qu©n LÖnh*10 + ThÇn Ên Tinh Hoa*15 + ThÇn Ên")
end;

function zbsj2sy1()
    CloseDialog()
    Talk(1, "zbsj2sy2", "<c=g>Th¨ng cÊp ThÇn Ên<c>:\n<c=y>7-9 cÊp<c>:Tinh Hoa Hung Thó*4 + Dung Tinh Lé*5 + Ph¸p B¶o Tinh Hoa*30 + T­íng Qu©n LÖnh*15 + ThÇn Ên Tinh Hoa*20 + ThÇn Ên\n<c=y>10-12 cÊp<c>:Tinh Hoa Hung Thó*5 + Dung Tinh Lé*10 + Ph¸p B¶o Tinh Hoa*40 + T­íng Qu©n LÖnh*20 + ThÇn Ên Tinh Tuþ*5 + ThÇn Ên")
end;

function zbsj2sy2()
    CloseDialog()
    Talk(1, "zbsj2", "<c=g>Th¨ng cÊp ThÇn Ên<c>:\n<c=y>13-15 cÊp<c>:Tinh Hoa Hung Thó*6 + Dung Tinh Lé*20 + Ph¸p B¶o Tinh Hoa*50 + T­íng Qu©n LÖnh*25 + ThÇn Ên Tinh Tuþ*10 + ThÇn Ên\n<c=g>L­u ý<c>:\nThÇn Ên Tinh Hoa, ThÇn Ên Tinh Tóy cã thÓ ®æi t¹i tiÖm danh väng chç TruyÒn LÖnh Quan chiÕn tr­êng.")
end;

function zbsj2()
    CloseDialog()
    Talk(1, "zbsj3", 12879)
end;
function zbsj3()
    CloseDialog()
    Talk(1, "zbsj4", 14791)
end;
function zbsj4()
    CloseDialog()
    Talk(1, "hcbd", 12880)
end;

function fbhc()
    CloseDialog()
    local tasks2 = {
        { "Ph¸p b¶o", "fbhc11"; show = 1 },
        { "Th¨ng cÊp ph¸p b¶o", "fbsj3"; show = 1 },
        { "Ph¸p B¶o Tinh Hoa cùc phÈm", "fbjh"; show = 1 },
        { "Ph¸p B¶o Tinh Hoa", "fbcpjh"; show = 1 }
    }
    SayTask("D­íi ®©y lµ giíi thiÖu c¸c ph­¬ng ph¸p hîp thµnh vµ th¨ng cÊp ph¸p b¶o.", tasks2)
end;
function fbsj3()
    CloseDialog()
    local tasks2 = {
        { "Ph¸p b¶o 2 thuéc tÝnh", "fbsj1"; show = 1 },
        { "Ph¸p b¶o ®a thuéc tÝnh", "fbsj2"; show = 1 },
        { "ThÊt B¶o Kim Liªn", "qbjl"; show = 1 },
        { "Phong ThÇn ThËp Chu Niªn", "fsszn"; show = 1 },
        { "Ph¸p b¶o ChÝ T«n", "zzfbsj"; show = 1 }
    }
    SayTask("D­íi ®©y lµ giíi thiÖu chi tiÕt ph­¬ng ph¸p th¨ng cÊp c¸c lo¹i Ph¸p b¶o.", tasks2)
end;

function zzfbsj()
    CloseDialog()

    Talk(1, "zzfbsj1", "Ph¸p b¶o ChÝ T«n s¬ cÊp: ChÝ T«n-Thanh Ngäc B¶o Nang, ChÝ T«n-DiÔm V©n Tiªn CÇm, ChÝ T«n-Ch©n Thanh Ngäc B¶o Nang, ChÝ T«n-Ch©n DiÔm V©n Tiªn CÇm, c­êng ho¸ lÇn 1-3 cÇn ChÝ T«n Chi Hån, ChÝ T«n Chi Linh, Ph¸p B¶o Tinh Hoa<c=g> mçi lo¹i 1 c¸i <c>")
end;

function zzfbsj1()

    CloseDialog()
    Talk(2, "zzfbsj2", "C­êng ho¸ lÇn 4-6 cÇn ChÝ T«n Chi Hån, ChÝ T«n Chi Linh, Ph¸p B¶o Tinh Hoa<c=g> mçi lo¹i 2 c¸i <c>c­êng ho¸ lÇn 7-9 cÇn ChÝ T«n Chi Hån, ChÝ T«n Chi Linh, Ph¸p B¶o Tinh Hoa<c=g>mçi lo¹i 3 c¸i <c>c­êng ho¸ lÇn 10-12 cÇn ChÝ T«n Chi Hån, ChÝ T«n Chi Linh, Ph¸p B¶o Tinh Hoa<c=g> mçi lo¹i 5 c¸i <c>")
end

function zzfbsj2()

    CloseDialog()
    Talk(1, "zzfbsj3", "Ph¸p b¶o ChÝ T«n cao cÊp: ChÝ T«n-Kim Quang Phiªn Thiªn Ên, ChÝ T«n-Cöu Long ThÇn Ho¶ Tr¸o cÇn nguyªn liÖu <c=g>gÊp 3 lÇn<c> Ph¸p b¶o ChÝ T«n s¬ cÊp")
end

function zzfbsj3()

    CloseDialog()
    Talk(2, "hcbd", "Nh¾c nhë\n§Æt vµo S¬ cÊp ChÝ T«n Tinh tuþ*1 cã thÓ ®¶m b¶o lÇn th¨ng cÊp Ph¸p b¶o ChÝ T«n s¬ cÊp lÇn 4.5.6 100% thµnh c«ng\n§Æt vµo S¬ cÊp ChÝ T«n Tinh nguyªn*1 cã thÓ ®¶m b¶o lÇn th¨ng cÊp Ph¸p b¶o ChÝ T«n s¬ cÊp lÇn 7.8.9 100% thµnh c«ng\n§Æt vµo S¬ cÊp ChÝ T«n Tinh hoa*1 cã thÓ ®¶m b¶o lÇn th¨ng cÊp Ph¸p b¶o ChÝ T«n s¬ cÊp lÇn 10.11.12 100% thµnh c«ng", "Nh¾c nhë\n§Æt vµo Cao cÊp ChÝ T«n Tinh Tuþ*1 cã thÓ ®¶m b¶o th¨ng cÊp Ph¸p b¶o ChÝ T«n cao cÊp lÇn 4.5.6 100% thµnh c«ng\n§Æt vµo Cao cÊp ChÝ T«n Tinh nguyªn*1 th¨ng cÊp Ph¸p b¶o ChÝ T«n cao cÊp lÇn 7.8.9 100% thµnh c«ng\n§Æt vµo Cao cÊp ChÝ T«n Tinh hoa*1 th¨ng cÊp Ph¸p b¶o ChÝ T«n cao cÊp lÇn 10.11.12 100% thµnh c«ng")
end

function fbjh()
    CloseDialog()
    Talk(2, "no", "4 lo¹i ph¸p b¶o Thanh V©n KiÕm, Ngäc Nh­ ý, Ho¶ Tú Bµ,An MÖnh Phï cã thÓ lÊy raPh¸p B¶o Tinh Hoa, c«ng thøc lµ Ph¸p b¶o + 10 Tha S¬n Th¹ch + 1 c¸i H¹o Thiªn Tinh Hoa; Ph¸p B¶o Tinh Hoa cùc phÈm cã thÓ dïng hîp thµnh <c=g>Ph¸p b¶o Cùc PhÈm<c> max thuéc tÝnh", "<c=g>Ph¸p b¶o Cùc PhÈm<c> bao gåm Thanh V©n B¶o KiÕm (Tinh Hoa Thanh V©n KiÕm x10 + Ph¸p B¶o Tinh Hoa x3); BÝch Ngäc Nh­ ý (Tinh Hoa Ngäc Nh­ ý x10 + Ph¸p B¶o Tinh Hoa x3); LiÖt DiÖm Tú Bµ (Tinh Hoa Háa Tú Bµ x10 + Ph¸p B¶o Tinh Hoa x3); An MÖnh ThÇn Phï (Tinh Hoa An MÖnh Phï x10 + Ph¸p B¶o Tinh Hoa x3)")
end;

function fbcpjh()
    CloseDialog()
    Talk(2, "no", "Ph¸p B¶o Tinh Hoa do m¶nh ph¸p b¶o cÊp 10, 30, 50, 70 mçi lo¹i 1 c¸i hîp thµnh; Thao t¸c hîp thµnh cã thÓ ®Õn Xi V­u Mé t×m <c=g>H×nh Thiªn<c>")
end;

function fbhc11()
    CloseDialog()
    Talk(2, "fbhc11_1", "<c=g>Hîp thµnh Hçn Nguyªn Ch©u <c>:\n4 Tø T­îng Tinh Th¹ch + 8 T­íng Qu©n LÖnh + 10 Dung Tinh Lé = Hçn Nguyªn Ch©u\n<c=yel>Thuéc TÝnh:<c><c=water>T¨ng ®ãng b¨ng 10%<enter><tab>T¨ng Háa s¸t 10%<enter><tab>T¨ng Thæ s¸t 15~20<enter><tab>T¨ng kh¶ n¨ng s¸t th­¬ng thuéc tÝnh L«i thªm 15~20<c>\nThµnh c«ng 100%, yªu cÇu ®¼ng cÊp 70", "<c=g>Hîp thµnh Dung Tinh Lé<c>: \nThanh V©n KiÕm + Ngäc Nh­ ý + HáaTú Bµ + An MÖnh Phï + 3 Ngò quang th¹ch = 3 Dung Tinh Lé\n100% thµnh c«ng")
end;
function fbhc11_1()
    CloseDialog()
    Talk(2, "fbhc11_2", "<c=g>Hîp thµnh Dung Tinh Lé<c>:\nCµn Kh«n XÝch + Hçn Thiªn L¨ng + B×nh L­u Ly + Ho¶ Long Tiªu + 3 c¸i Ngò Quang Th¹ch = Dung Tinh Lé\nKim Cang M¹t + ¢m D­¬ng KÝnh + BÝch Tú Bµ + Tói Ng« Phong + 3 c¸i Ngò Quang Th¹ch = Dung Tinh Lé\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ biÕn mÊt", "<c=g>Dung Tinh Lé hîp thµnh<c>:\nÊm V¹n Nha + Bµn Cæ Ph­ín + D©y Ph­îc Long + Th¸i D­¬ng Ch©m + 3 c¸i Ngò Quang Th¹ch = Dung Tinh Lé\nD©y Khæn Tiªn + ChÊn Thiªn Cung + Kim B¸t Vu + Linh Lung Th¸p + 3 c¸i Ngò Quang Th¹ch = Dung Tinh Lé\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ biÕn mÊt")
end;
function fbhc11_2()
    CloseDialog()
    Talk(1, "fbhc11_3", "<c=g>Hîp thµnh Dung Tinh Lé<c>: \nToµn T©m §inh + Hång Hå L« + L¹c Hån Chung + Ngäc H­ Phï + 3 Ngò quang th¹ch = 2 Dung Tinh Lé\nCäc §én Long + KÝnh chiÕu yªu + Phong Háa lu©n + Kim Quang Táa + 3 Ngò quang th¹ch = 2 Dung Tinh Lé\nH¹nh Hoµng kú + Cµn Kh«n khuyªn + B¹ch Cèt ph­ín + §Þnh Phong ch©u + 3 Ngò quang th¹ch = 2 Dung Tinh Lé\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")
end;
function fbhc11_3()
    CloseDialog()
    Talk(2, "fbhc11_4", 12881, "<c=g>Hîp thµnh Ph¸p b¶o:<c>Bµn Cæ ph­ín + Tói Ng« Phong + Hång Thuû Tinh = Cäc §én Long\nTh¸i D­¬ng Ch©m + ¢m D­¬ng kÝnh + Hång Thuû Tinh = KÝnh ChiÕu Yªu\nÊm V¹n Nha + Kim Cang Ph¸ch + Hång Thuû Tinh = Phong Ho¶ Lu©n\nD©y Ph­îc Long + BÝch Tú Bµ + Hång Thuû Tinh = Kim Quang To¶\n<c=yel>Chó ý:<c> Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt.")

end;
function fbhc11_4()
    CloseDialog()
    Talk(1, "fbhc11_5", 12882)
end;
function fbhc11_5()
    CloseDialog()
    Talk(1, "fbhc11_6", "<color = green>Hîp thµnh Ph¸p b¶o 3 thuéc tÝnh<color>: \nCµn Kh«n XÝch + Ngò quang th¹ch + Cµn Kh«n khuyªn + ChÊn Thiªn Cung + Tha S¬n Th¹ch*20 = Thanh V©n KiÕm\nB×nh L­u Ly + H×nh Thiªn Ên + §Þnh Phong ch©u + D©y Khæn Tiªn + Tha S¬n Th¹ch*20 = Ngäc Nh­ ý \nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")

end;
function fbhc11_6()
    CloseDialog()
    Talk(1, "fbhc11_7", "<color = green>Hîp thµnh Ph¸p b¶o 3 thuéc tÝnh<color>: \nHáa Long tiªu + Ngò quang th¹ch + B¹ch Cèt ph­ín + Linh Lung Th¸p + Tha S¬n Th¹ch*20 = HáaTú Bµ\nHçn Thiªn L¨ng + H×nh Thiªn Ên + H¹nh Hoµng kú + Kim B¸t Vu + Tha S¬n Th¹ch*20 = An MÖnh Phï\nTû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!")

end;
function fbhc11_7()
    CloseDialog()
    Talk(1, "hcbd", "<color = green>GhÐp ThÊt B¶o Kim Liªn<color>: \nThÊt B¶o Kim Liªn-§å phæ t­¬ng øng m«n ph¸i + Tø T­îng Tinh Hoa x50 + HuyÔn Linh Chi Nh·n x30 + T­íng Qu©n LÖnh x10 = ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng\nChó ý: NhÊt ®Þnh thµnh c«ng, yªu cÇu cÊp 120")

end;

function fbsj1()
    CloseDialog()
    Talk(1, "fbsj1_1", 12883)
end;
function fbsj1_1()
    CloseDialog()
    Talk(1, "fbsj1_2", "<c=g>Th¨ng cÊp Ph¸p b¶o 2 thuéc tÝnh<c>: <enter>Ph¸p b¶o hîp thµnh 2 thuéc tÝnh + Hång B¶o Th¹ch + Lß luyÖn cao cÊp = Ph¸p b¶o hîp thµnh 2 thuéc tÝnh (t¨ng 7, 8, 9)<enter>Ph¸p b¶o 2 thuéc tÝnh + Hång B¶o Th¹ch*3 + 2 Dung Tinh Lé + Lß luyÖn Tr©n Hùu = Ph¸p b¶o 2 thuéc tÝnh (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj1_2()
    CloseDialog()
    Talk(1, "fbsj1_3", "<c=g>Th¨ng cÊp Vu Lan Bån<c>: <enter>Vu Lan Bån + Ph¸p b¶o cÊp 10 mçi lo¹i 1 + Hång B¶o Th¹ch + Lß luyÖn s¬ cÊp = Vu Lan Bån (t¨ng 1,2,3)<enter>Vu Lan Bån + Ph¸p b¶o cÊp 10 mçi lo¹i 1 + Hång B¶o Th¹ch + Lß luyÖn trung cÊp = Vu Lan Bån (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj1_3()
    CloseDialog()
    Talk(1, "fbsj1_4", "<c=g>Th¨ng cÊp Vu Lan Bån<c>: <enter>Vu Lan Bån + Ph¸p b¶o cÊp 10 mçi lo¹i 1 + Hång B¶o Th¹ch + Lß luyÖn cao cÊp = Vu Lan Bån (t¨ng 7,8,9)<enter>Vu Lan Bån + Hång B¶o Th¹ch*3 + 2 Dung Tinh Lé + Lß luyÖn Tr©n Hùu = Vu Lan Bån (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj1_4()
    CloseDialog()
    Talk(1, "fbsj1_5", "<c=g>Th¨ng cÊp TrÊn Hån Th¹ch [cÊp 5]<c>: <enter>TrÊn Hån Th¹ch [cÊp 5] + 3 Th«i Phong LÖnh + Hång B¶o Th¹ch + Lß luyÖn s¬ cÊp = TrÊn Hån Th¹ch [cÊp 5] (t¨ng 1,2,3)<enter>TrÊn Hån Th¹ch [cÊp 5] + 7 Th«i Phong LÖnh + Hång B¶o Th¹ch + Lß luyÖn trung cÊp = TrÊn Hån Th¹ch [cÊp 5] (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj1_5()
    CloseDialog()
    Talk(1, "hcbd", "<c=g>Th¨ng cÊp TrÊn Hån Th¹ch [cÊp 5]<c>: <enter>TrÊn Hån Th¹ch [cÊp 5] + 11 Th«i Phong LÖnh + Hång B¶o Th¹ch + Lß luyÖn cao cÊp = TrÊn Hån Th¹ch [cÊp 5] (t¨ng 7,8,9)<enter>TrÊn Hån Th¹ch + 14 Th«i Phong LÖnh + 5 Dung Tinh Lé + Lß luyÖn Tr©n Hùu*2 = TrÊn Hån Th¹ch [cÊp 5] (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;

function fbsj1_6()
    CloseDialog()
    Talk(1, "hcbd", "Quy t¾c th­ng cÊp <c=g>Thanh V©n B¶o KiÕm, BÝch Ngäc Nh­ ý, LiÖt DiÖm Tú Bµ, An MÖnh ThÇn Phï<c> vµ <c=g>Thanh V©n KiÕm, Ngäc Nh­ ý, Ho¶ Tú Bµ,An MÖnh Phï<c> 3 dßng thuéc tÝnh lµ nh­ nhau.")
end;

function fbsj2()
    CloseDialog()
    Talk(1, "fbsj2_1", "<c=g>Th¨ng cÊp Hçn Nguyªn Ch©u<c>: <enter>Hçn Nguyªn Ch©u + Tø T­îng Tinh Th¹ch + 5 Dung Tinh Lé + Lß luyÖn s¬ cÊp = Hçn Nguyªn Ch©u (t¨ng 1,2,3)<enter>Hçn Nguyªn Ch©u + 2 Tø T­îng Tinh Th¹ch + 5 Dung Tinh Lé + Lß luyÖn trung cÊp = Hçn Nguyªn Ch©u (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj2_1()
    CloseDialog()
    Talk(1, "fbsj2_2", "<c=g>Th¨ng cÊp Hçn Nguyªn Ch©u<c>: <enter>Hçn Nguyªn Ch©u + 4 Tø T­îng Tinh Th¹ch + 5 Dung Tinh Lé + Lß luyÖn cao cÊp = Hçn Nguyªn Ch©u (t¨ng 7,8,9)<enter>Hçn Nguyªn Ch©u + 5 Tø T­îng Tinh Th¹ch + 5 Dung Tinh Lé + Lß luyÖn Tr©n Hùu*2 = Hçn Nguyªn Ch©u (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;

function fbsj2_2()
    CloseDialog()
    Talk(1, "fbsj2_3", "<c=g>Th¨ng cÊp Ph¸p b¶o 3 thuéc tÝnh<c>: <enter>Ph¸p b¶o 3 thuéc tÝnh + Hång B¶o Th¹ch*5 + Lß luyÖn s¬ cÊp*2 = Ph¸p b¶o 3 thuéc tÝnh (t¨ng 1,2,3)<enter>Ph¸p b¶o 3 thuéc tÝnh + Hång B¶o Th¹ch*5 + Lß luyÖn trung cÊp*2 = Ph¸p b¶o 3 thuéc tÝnh (t¨ng 4,5,6)<enter>100% thµnh c«ng")
end;
function fbsj2_3()
    CloseDialog()
    Talk(1, "fbsj2_4", "<c=g>Th¨ng cÊp Ph¸p b¶o 3 thuéc tÝnh<c>: <enter>Ph¸p b¶o 3 thuéc tÝnh + Hång B¶o Th¹ch*5 + Lß luyÖn cao cÊp*2 = Ph¸p b¶o 3 thuéc tÝnh (t¨ng 7,8,9)<enter>Ph¸p b¶o 3 thuéc tÝnh + Hång B¶o Th¹ch*5 + 4 Dung Tinh Lé + Lß luyÖn Tr©n Hùu*2 = Ph¸p b¶o 3 thuéc tÝnh (t¨ng 10,11,12)<enter>100% thµnh c«ng")
end;
function fbsj2_4()
    CloseDialog()
    Talk(1, "fbsj2_5", "<c=g>V« Cùc Quy Ch©n KÝnh<c>: <enter>VCQCK + Béc Ph¸c Th¹ch + Hång B¶o Th¹ch + Lß tinh luyÖn S¬ cÊp = VCQCK (1,2,3 th¨ng)<enter>VCQCK + 2 BPTh¹ch + Hång B¶o Th¹ch + Lß tinh luyÖn tr.cÊp = VCQCK (4,5,6 th¨ng)<enter>VCQCK + 3 BPTh¹ch + Hång B¶o Th¹ch + Lß tinh luyÖn c.cÊp = VCQCK (7,8,9 th¨ng)<enter>100% thµnh c«ng")
end

function fbsj2_5()
    CloseDialog()
    Talk(1, "fbsj2_6", "<c=g>V« Cùc Quy Ch©n KÝnh<c>: <enter>V« Cùc Quy Ch©n KÝnh + S­ ¢n LÖnh*15 + Tinh ChÝ Béc Ph¸c Th¹ch*3 + Hång B¶o Th¹ch*3 + Lß tinh luyÖn (Tr©n Hùu)*2 = V« Cùc Quy Ch©n KÝnh (cÊp 10)<enter>V« Cùc Quy Ch©n KÝnh + S­ ¢n LÖnh*30 + Tinh ChÝ Béc Ph¸c Th¹ch*6 + Hång B¶o Th¹ch*3 + Lß tinh luyÖn (Tr©n Hùu)*2 = V« Cùc Quy Ch©n KÝnh (cÊp 11)<enter>V« Cùc Quy Ch©n KÝnh + S­ ¢n LÖnh*60 + Tinh ChÝ Béc Ph¸c Th¹ch*9 + Hång B¶o Th¹ch*3 + Lß tinh luyÖn (Tr©n Hùu)*2 = V« Cùc Quy Ch©n KÝnh (cÊp 12)<enter>Chó ý: nhÊt ®Þnh thµnh c«ng")
end

function fbsj2_6()
    CloseDialog()
    Talk(1, "fbsj2_7", "<c=g>Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)<c>:<enter>Kim S¬n (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn s¬ cÊp*2 + 2 Dung tinh lé = Kim S¬n (B¶n giíi h¹n) ( + 1,2,3)<enter>Kim S¬n (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn trung cÊp*2 + 3 Dung tinh lé = Kim S¬n (B¶n giíi h¹n) ( + 4,5,6)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_7()
    CloseDialog()
    Talk(1, "fbsj2_8", "<c=g>Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)<c>:<enter>Kim S¬n (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn cao cÊp*2 + 4 Dung tinh lé = Kim S¬n (B¶n giíi h¹n) ( + 7,8,9)<enter>Kim S¬n (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + 5 Dung tinh lé + Lß luyÖn Tr©n Hùu*2 = Kim S¬n (B¶n giíi h¹n) ( + 10,11,12)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_8()
    CloseDialog()
    Talk(1, "fbsj2_9", "<c=g>ThÊt TrÇn Trai Ph¸p B¶o (B¶n giíi h¹n)<c>:<enter>ThÊt TrÇn Trai (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn s¬ cÊp*2 + 2 Dung tinh lé = ThÊt TrÇn Trai (B¶n giíi h¹n) ( + 1,2,3)<enter>ThÊt TrÇn Trai (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn trung cÊp*2 + 3 Dung tinh lé = ThÊt TrÇn Trai (B¶n giíi h¹n) ( + 4,5,6)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;
function fbsj2_9()
    CloseDialog()
    Talk(1, "fbsj2_10", "<c=g>ThÊt TrÇn Trai Ph¸p B¶o (B¶n giíi h¹n)<c>:<enter>ThÊt TrÇn Trai (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + Lß tinh luyÖn cao cÊp*2 + 4 Dung tinh lé = ThÊt TrÇn Trai (B¶n giíi h¹n)( + 7,8,9)<enter>ThÊt TrÇn Trai (B¶n giíi h¹n) + Hång B¶o Th¹ch*5 + 5 Dung tinh lé + Lß luyÖn Tr©n Hùu*2 = ThÊt TrÇn Trai (B¶n giíi h¹n) ( + 10,11,12)<enter>Chó ý: Ch¾c ch¾n thµnh c«ng!")
end;

function fbsj2_10()
    CloseDialog()
    Talk(1, "fbsj2_11", "<c=g>Ph¸p b¶o Tam Sinh Th¹ch (B¶n giíi h¹n)<c>: <enter>Tam Sinh Th¹ch (B¶n giíi h¹n) + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn s¬ cÊp x2 + 2 Dung Tinh Lé = Tam Sinh Th¹ch (B¶n giíi h¹n) (n©ng 1,2,3)<enter>Tam Sinh Th¹ch (B¶n giíi h¹n) + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn trung cÊp x2 + 3 Dung Tinh Lé = Tam Sinh Th¹ch (B¶n giíi h¹n) (n©ng 4,5,6)<enter>Chó ý: NhÊt ®Þnh thµnh c«ng")
end;
function fbsj2_11()
    CloseDialog()
    Talk(1, "fbsj2_12", "<c=g>Ph¸p b¶o Tam Sinh Th¹ch (B¶n giíi h¹n)<c>: <enter>Tam Sinh Th¹ch (B¶n giíi h¹n) + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn cao x2 + 4 Dung Tinh Lé = Tam Sinh Th¹ch (B¶n giíi h¹n) (n©ng 7,8,9)<enter>Tam Sinh Th¹ch (B¶n giíi h¹n) + Hång B¶o Th¹ch x5 + 5 Dung Tinh Lé + Lß LuyÖn Tr©n Hùu x2 = Tam Sinh Th¹ch (B¶n giíi h¹n) (n©ng 10,11,12)<enter>Chó ý: NhÊt ®Þnh thµnh c«ng")
end;

function fbsj2_12()
    CloseDialog()
    Talk(1, "hcbd", "Quy t¾c th¨ng cÊp <c=g>Thanh V©n B¶o KiÕm, BÝch Ngäc Nh­ ý, LiÖt DiÖm Tú Bµ, An MÖnh ThÇn Phï<c> vµ quy t¾c th¨ng cÊp <c=g>Thanh V©n KiÕm, Ngäc Nh­ ý, Ho¶ Tú Bµ,An MÖnh Phï<c> 3 thuéc tÝnh lµ gièng nhau.")
end;

function qbjl()
    CloseDialog()
    Talk(1, "qbjl_1", "<c=g>Ph¸p B¶o ThÊt B¶o Kim Liªn<c>: <enter>ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn s¬ cÊp x2 + HuyÔn Linh Chi Nh·n x10 + §å phæ t­¬ng øng m«n ph¸i = ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng(n©ng 1,2,3)<enter>ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn trung cÊp x2 + HuyÔn Linh Chi Nh·n x10 + §å phæ t­¬ng øng m«n ph¸i = ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng(n©ng 4,5,6)<enter>Chó ý: NhÊt ®Þnh thµnh c«ng")
end;
function qbjl_1()
    CloseDialog()
    Talk(1, "hcbd", "<c=g>Ph¸p B¶o ThÊt B¶o Kim Liªn<c>: <enter>ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn cao x2 + HuyÔn Linh Chi Nh·n x10 + §å phæ t­¬ng øng m«n ph¸i = ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng(n©ng 7,8,9)<enter>ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng + Hång B¶o Th¹ch x5 + Lß Tinh LuyÖn Tr©n H÷u x2 + HuyÔn Linh Chi Nh·n x10 + §å phæ t­¬ng øng m«n ph¸i = ThÊt B¶o Kim Liªn-m«n ph¸i t­¬ng øng(n©ng 10,11,12)<enter>Chó ý: NhÊt ®Þnh thµnh c«ng")
end;

function fsszn()
    CloseDialog()
    Talk(1, "fsszn_1", "<c=g>Phong ThÇn ThËp Chu Niªn<c>:<enter>Phong ThÇn ThËp Chu Niªn-ph¸p b¶o + Hång B¶o Th¹ch*5 + Lß Tinh LuyÖn S¬ cÊp*2 + B¸t Hoang Tinh Hoa*5 + Dung Tinh Lé*4 = Phong ThÇn ThËp Chu Niªn-ph¸p b¶o(1,2,3)<enter>Phong ThÇn ThËp Chu Niªn-ph¸p b¶o + Hång B¶o Th¹ch*5 + Lß Tinh LuyÖn Trung cÊp*2 + B¸t Hoang Tinh Hoa*5 + Dung Tinh Lé*5 = Phong ThÇn ThËp Chu Niªn-ph¸p b¶o(4,5,6)<enter>Ch¾c ch¾n thµnh c«ng")
end;
function fsszn_1()
    CloseDialog()
    Talk(1, "hcbd", "<c=g>Phong ThÇn ThËp Chu Niªn<c>:<enter>Phong ThÇn ThËp Chu Niªn-ph¸p b¶o + Hång B¶o Th¹ch*5 + Lß Tinh LuyÖn Cao CÊp*2 + B¸t Hoang Tinh Hoa*5 + Dung Tinh Lé*6 = Phong ThÇn ThËp Chu Niªn-ph¸p b¶o-ph¸p b¶o(7,8,9)<enter>Phong ThÇn ThËp Chu Niªn-ph¸p b¶o + Hång B¶o Th¹ch*5 + Lß LuyÖn Tr©n Hùu*2 + B¸t Hoang Tinh Hoa*5 + Dung Tinh Lé*10 = Phong ThÇn ThËp Chu Niªn-ph¸p b¶o(10,11,12)<enter>Ch¾c ch¾n thµnh c«ng")
end;

function yshc()
    CloseDialog()
    Talk(4, "yshc1", 14756, 14757, 14758, 14759)
end;
function yshc1()
    CloseDialog()
    Talk(1, "yshc2", 14764)
end;

function yshc2()
    CloseDialog()
    Talk(4, "yshc3", 14778, 14779, 14780, 14781)
end;

function yshc3()
    CloseDialog()
    Talk(1, "yshc4", 14786)
end;

function yshc4()
    CloseDialog()
    Talk(4, "hcbd", 14782, 14783, 14784, 14785)
end;

function bshc()
    CloseDialog()

    local tasks3 = {
        { "B¶o th¹ch th­êng", "bshc0"; show = 1 },
        { "B¶o th¹ch quý", "bshcgj"; show = 1 }

    }
    SayTask("GÇn ®©y thÇn lùc cña Tha S¬n Th¹ch bçng xuÊt hiÖn, ®em <c=g>5<c> Tha S¬n Th¹ch cïng <c=g>5<c> Tø T­îng Tinh Hoa cïng nhau hîp thµnh, cã thÓ nhËn ®­îc <c=yel>Ngò Nh¹c ThÇn Th¹ch<c> cã thÇn lùc, l·o phu cã thÓ dïng nã gióp hîp thµnh m¶nh b¶o th¹ch <c=g>ch¾c ch¾n thµnh c«ng<c>!", tasks3)
end;

function bshc0()
    CloseDialog()
    Talk(3, "bshc1", 14760, 14761, 14777)
end;

function bshc1()
    CloseDialog()
    Talk(1, "bshc2", 12887)
end;

function bshc2()
    CloseDialog()
    Talk(1, "bshc3", "<c=g>Th¨ng cÊp phï th¹ch<c>\n5 Phï Th¹ch cïng thuéc tÝnh cÊp 1 = Phï th¹ch cïng thuéc tÝnh cÊp 2\nPhï th¹ch cïng thuéc tÝnh cÊp 2 *5 = Phï th¹ch cïng thuéc tÝnh cÊp 3 \nPhï th¹ch cïng thuéc tÝnh cÊp 3 *5 = Phï th¹ch cïng thuéc tÝnh cÊp 4\nPhï th¹ch cïng thuéc tÝnh cÊp 4 *5 = Phï th¹ch cïng thuéc tÝnh cÊp 5\n<c=g>Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ biÕn mÊt<c>")
end;
function bshc3()
    CloseDialog()
    Talk(1, "bshc", "<c=g>Hîp thµnh ®¹o cô kh¶m n¹m<c>\n(Hoµng, Lôc, Hång, Lam)- M¶nh Thuû Tinh mçi lo¹i 2 c¸i + 2 Tha S¬n Th¹ch = Ng­ng ThÇn Sa\n(Hoµng, Lôc, Hång, Lam)-Thuû Tinh mçi lo¹i 2 c¸i + 2 Tha S¬n Th¹ch = Ng­ng ThÇn Th¹ch\n(Hoµng, Lôc, Hång, Lam)-B¶o Th¹ch mçi lo¹i 2 c¸i + 2 Tha S¬n Th¹ch = Ng­ng ThÇn Ch©u\n3 c¸i Ng­ng ThÇn Sa + 6 Tha S¬n Th¹ch = Ng­ng ThÇn Th¹ch\n3 c¸i Ng­ng ThÇn Th¹ch + 6 Tha S¬n Th¹ch = Ng­ng ThÇn Ch©u\n<c=g>Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ biÕn mÊt<c>")
end;

function bshcgj()
    CloseDialog()
    Talk(3, "bshcgj1", 14787, 14788, 14789)
end;

function bshcgj1()
    CloseDialog()
    Talk(1, "bshcgj2", 14790)
end;
function bshcgj2()
    CloseDialog()
    Talk(1, "bshcgj3", "<c=g>Th¨ng cÊp phï th¹ch<c>\nHîp thµnh Phï Th¹ch\n5 Phï Th¹ch cïng thuéc tÝnh cÊp 1 + Tinh Th¹ch S¬ cÊp = Phï th¹ch cïng thuéc tÝnh cÊp 2\nPhï th¹ch cïng thuéc tÝnh cÊp 25 c¸i + 3 c¸i Tinh Th¹ch S¬ cÊp = Phï th¹ch cïng thuéc tÝnh cÊp 3\nPhï th¹ch cïng thuéc tÝnh cÊp  35 c¸i + Tinh Th¹ch Trung CÊp = Phï th¹ch cïng thuéc tÝnh cÊp 4\nPhï th¹ch cïng thuéc tÝnh cÊp  45 c¸i + 3 c¸i Tinh Th¹ch Trung CÊp = Phï th¹ch cïng thuéc tÝnh cÊp 5\n<c=g>Ch¾c ch¾n thµnh c«ng<c>")
end;

function bshcgj3()
    CloseDialog()
    Talk(1, "bshc", "<c=g>Hîp thµnh ®¹o cô kh¶m n¹m<c>\n(Hoµng, Lôc, Hång, Lam)- M¶nh Thuû Tinh mçi lo¹i 4 c¸i + Ngò Nh¹c ThÇn Th¹ch = Ng­ng ThÇn Sa\n(Hoµng, Lôc, Hång, Lam)-Thuû Tinh mçi lo¹i 4 c¸i + Ngò Nh¹c ThÇn Th¹ch = Ng­ng ThÇn Th¹ch\n(Hoµng, Lôc, Hång, Lam)-B¶o Th¹ch mçi lo¹i 4 c¸i + Ngò Nh¹c ThÇn Th¹ch = Ng­ng ThÇn Ch©u\n6 c¸i Ng­ng ThÇn Sa + Ngò Nh¹c ThÇn Th¹ch = Ng­ng ThÇn Th¹ch\n6 c¸i Ng­ng ThÇn Th¹ch + Ngò Nh¹c ThÇn Th¹ch = Ng­ng ThÇn Ch©u\n<c=g>Ch¾c ch¾n thµnh c«ng<c>")
end;

function qthc()
    CloseDialog()
    Talk(1, "qthc0", "<c=g>Hîp thµnh Kinh NghiÖm §an<c> = Ngò Quang Th¹ch + H×nh Thiªn Ên + Cµn Kh«n XÝch + Hçn Thiªn L¨ng + B×nh L­u Ly + Ho¶ Long Tiªu + 1 v¹n b¹c\n<c=g>Tinh Hoa Hung Thó<c> = Hçn §én T©m + Cïng Kú §Çu + Thao ThiÕt Gi¸c + §µo Ngét Hån + Tha S¬n Th¹ch mçi lo¹i 1 c¸i \nCh¾c ch¾n thµnh c«ng")
end

function qthc0()
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
    Talk(2, "hcbd", "<c=g>Hîp thµnh Néi ®¬n<c>: <enter>5 Bét néi ®¬n = Néi §¬n (thÊp)<enter>5 Néi §¬n (thÊp) = Néi §¬n (trung)<enter>5 Néi §¬n (trung) = Néi ®¬n cao cÊp<enter>Tû lÖ thµnh c«ng cao, thÊt b¹i vËt phÈm sÏ mÊt!.", "<c=g>Hîp thµnh Néi ®¬n<c>: <enter>5 Bét néi ®¬n + Thiªn Quang Thñy = Néi §¬n (thÊp)<enter>5 Néi §¬n (thÊp) + 2 Thiªn Quang Thñy = Néi §¬n (trung)<enter>5 Néi §¬n (trung) + 3 Thiªn Quang Thñy = Néi ®¬n cao cÊp<enter>100% thµnh c«ng.")
end

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
        if (idx == GetTaskByte(VALENTINE, step)) then
            SetTaskByte(VALENTINE, 4, step + 1)
            if (step == 2) then
                SetTaskByte(VALENTINE, 4, 5)
                Talk(1, "no", "Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                Msg2Player("Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                TaskNote(1600, 1)
            else
                local vnIdx = GetTaskByte(VALENTINE, step + 1)
                local npc=vnpc[vnIdx][2]
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
                nextNpc=vnpc[nIdx][2]
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

function signet_levelup()

    CloseDialog()
    EnchaseBeastItem(2)
end

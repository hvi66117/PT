Task_zhong = 1588

function GetPlayerTaskState()
    return 0, 0
end

VALENTINE = 1682

vnpc = {
    { "Th©n C«ng B¸o", "Ph©n Thñy T­íng Qu©n" },
    { "Na Tra", "Tóc §Ó Sinh Uy" },
    { "L«i ChÊn Tö", "Sİ Th¸p Phong V©n" },
    { "NhŞ Lang thÇn", "Tam Môc L­¬ng NhÜ" },
    { "TriÖu C«ng Minh", "NhËt NguyÖt Qu©n" },
    { "Xİch Tïng Tö", "Tr× Méc C«ng Tö" },
    { "Bİch Tiªu", "Bİch S¾c Cöu Thiªn" },
    { "Quúnh Tiªu", "Mü Ngäc V« H¹" },
    { "V©n Tiªu", "B¹ch V©n Vò Nghª" },
    { "ThÓ V©n", "ThÊt S¾c T­êng V©n" },
    { "Long C¸t", "Hång Loan Thiªn TuÕ" },
    { "Thä Tinh", "Tr­êng Sinh BÊt L·o" },
    { "Léc Tinh", "Kim B¶ng §Ò Danh" },
    { "Phóc Tinh", "C¸t T­êng Phó Quı" },
    { "TrÊn Nguyªn", "§Ønh §Şnh Cµn Kh«n" }
}

function main(sel)

    tasks = {
        { "Thiªn §×nh ThÇn Thô", "renwu"; show = 0 },
        { "Liªn quan tíi Thiªn thô", "zhishu"; show = 1 },
        { "H¹t May M¾n", "zhong"; show = 0 },

        { "T¨ng phÈm chÊt Vò khİ", "weaponlevelup"; show = 1 },
    }

    local y, m, d = GetYMD()

    if (GetLevel() >= 35) then
        tasks[1].show = 1
    end ;
    if (GetTask(Task_zhong) == 0) and (GetLevel() >= 60) then
        tasks[3].show = 1;
    end
    SayTask(11267, tasks)
end;

function no()
    CloseDialog()
end;

function zhong()
    CloseDialog()
    if (GetTask(Task_zhong) == 0) and (GetLevel() >= 60) then
        MsgBox("<c=g>D­¬ng Thóc<c> võa x©y dùng 1 n«ng trang míi ë Cù Léc, trong ®ã cã trång Tiªn Th¶o thÇn kú, nghe ®ån <c=g>Qu¸i Thñ LÜnh<c> sÏ r¬i h¹t gièng Tiªn Th¶o, ng­¬i cã ®ång ı thay ta ®Õn th¨m D­¬ng Thóc kh«ng?", "yes_zhong", "no")
    end
end

function yes_zhong()
    CloseDialog()
    Talk(1, "no", "<c=g>Qu¸i Thñ LÜnh<c> lµm r¬i <c=g>H¹t gièng may m¾n<c>, kh«ng biÕt bao giê míi cã c¬ héi nhËn ®­îc!")
    TaskNote(1203, 0)
    SetTask(Task_zhong, 1)
end

function zhishu()
    Talk(1, "zhishunext", 12903)
end;

function zhishunext()
    Talk(1, "no", 12904)
end;

function renwu()
    if (GetItemCount(39) >= 2) then
        for i = 1, 2 do
            DelEventItem(39)
        end ;
        AddEventItem(48)
        TaskNote(60, 1)
        Talk(1, "no", 11268)
    else
        Talk(1, "no", 11269)
    end ;
end;

function valentine()
    local idx = 4
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

function weaponlevelup()
    CloseDialog()
    local tasks = {
        { "T¨ng phÈm chÊt", "levelup_1"; show = 1 },
        { "Quy t¾c", "levelupinfo"; show = 1 },
    }
    SayTask("Nhi Lang ThÇn: V¹n vËt ®Òu cã phÈm chÊt, víi ph¸p lùc cña ta, gióp ng­¬i t¨ng phÈm chÊt Vò khİ Hoµng Kim, ph¸t huy n¨ng lùc vèn cã. <enter><enter>Quy tr×nh t¨ng, vò khİ<c=g>c­êng hãa, kh¶m, ho¸n hån<c> ®­îc b¶o l­u, c¸c th«ng tin kh¸c sÏ bŞ tiªu thÊt. ", tasks)
end

function levelup_1()
    CloseDialog()
    EnchaseItem(-1, 4)
end

function levelupinfo()
    CloseDialog()
    Talk(2, "levelupinfo1", "N©ng cÊp <c=g>PhÈm chÊt Hoµng Kim +1<c>: Vò khİ nguån+Vò khİ cïng lo¹i = Vò khİ nguån (PhÈm chÊt Hoµng Kim+1) \n<c=g>PhÈm chÊt Hoµng Kim +2<c>: Vò khİ nguån (PhÈm chÊt Hoµng Kim +1) + Vò khİ cïng lo¹i x2 = Vò khİ nguån (PhÈm chÊt Hoµng Kim+2) \n<c=g>PhÈm chÊt Hoµng Kim +3<c>: Vò khİ nguån (PhÈm chÊt Hoµng Kim+2) + Vò khİ cïng lo¹i (c­êng hãa +9) = Vò khİ nguån (PhÈm chÊt Hoµng Kim+3) ")
end

function levelupinfo1()
    CloseDialog()
    Talk(2, "weaponlevelup", "\nN©ng cÊp <c=g>PhÈm chÊt ¸m kim<c>: Vò khİ nguån (PhÈm chÊt Hoµng Kim +3) + Tr¨n PhÈm Th¹ch = Vò khİ nguån (PhÈm chÊt ¸m kim) \n\nN©ng cÊp <c=g>PhÈm chÊt ¸m kim +1<c>: Vò khİ nguån (PhÈm chÊt ¸m kim)  + Vò khİ cïng lo¹i (PhÈm chÊt ¸m kim)  = Vò khİ nguån (PhÈm chÊt ¸m kim +1) ", "\nN©ng cÊp <c=g>PhÈm chÊt ¸m kim +2<c>: Vò khİ nguån (PhÈm chÊt ¸m kim +1) + Vò khİ cïng lo¹i (PhÈm chÊt ¸m kim) x2 = Vò khİ nguån (PhÈm chÊt ¸m kim +2) \n\nN©ng cÊp <c=g>PhÈm chÊt ¸m kim +3<c>: Vò khİ nguån (PhÈm chÊt ¸m kim +2) + Vò khİ cïng lo¹i (PhÈm chÊt ¸m kim) (c­êng hãa +9)  = Vò khİ nguån (PhÈm chÊt ¸m kim +3) ")
end

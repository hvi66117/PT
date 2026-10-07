function main()
    local i = math.random(1, 10000)
    local n = GetPlayerType()
    if (i >= 1) and (i <= 2) then
        if (n == 0) then
            AddNormalItem(0, 0, 17, 0, 1, 0)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 thanh vò khİ cÊp 75--B¹ch §iªu")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Vò khİ cÊp 75--B¹ch §iªu<c>!", 20)
        elseif (n == 1) then
            AddNormalItem(0, 0, 20, 0, 1, 0)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 thanh vò khİ cÊp 75--Nh©n Gian")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Vò khİ cÊp 75--Nh©n Gian<c>!", 20)
        else
            AddNormalItem(0, 0, 23, 0, 1, 0)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 thanh vò khİ cÊp 75--NguyÖt ¶nh")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Vò khİ cÊp 75--NguyÖt ¶nh<c>!", 20)
        end ;
    elseif (i >= 3) and (i <= 40) then
        AddNormalItem(8, 229, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thiªn H­¬ng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Thiªn H­¬ng<c>!", 20)
    elseif (i >= 41) and (i <= 50) then
        AddNormalItem(8, 228, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thiªn Gi¸ng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Thiªn Gi¸ng <c>!", 20)
    elseif (i >= 51) and (i <= 100) then
        AddNormalItem(8, 28, 3, 1, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thanh lé!")
    elseif (i >= 101) and (i <= 150) then
        AddNormalItem(8, 29, 4, 1, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Ch©n khİ!")
    elseif (i >= 151) and (i <= 250) then
        Earn(1000000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1000000 l­îng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>100v l­îng<c>!", 20)
    elseif (i >= 251) and (i <= 400) then
        if (n == 0) then
            AddNormalItem(7, 32, 35, 0, 0, 1)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 quyÓn Tam §Çu Lôc Thñ")
        elseif (n == 1) then
            AddNormalItem(7, 13, 16, 0, 0, 1)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 quyÓn Ngò Nh¹c TriÒu T«ng")
        else
            AddNormalItem(7, 52, 453, 0, 0, 1)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 quyÓn Liªn Nç TÕ")
        end
    elseif (i >= 401) and (i <= 600) then
        AddNormalItem(3, 41, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 viªn Lam B¶o Th¹ch")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>Lam B¶o Th¹ch<c>!", 20)
    elseif (i >= 601) and (i <= 1000) then
        AddNormalItem(3, 100, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 T­íng Qu©n LÖnh")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <c=yel>Tói Cµn Kh«n<c> nhËn ®­îc <c=yel>T­íng Qu©n LÖnh<c>!", 20)
    elseif (i >= 1001) and (i <= 1500) then
        AddNormalItem(3, 79, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Hång B¶o Th¹ch")
    elseif (i >= 1501) and (i <= 2000) then
        Earn(500000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 500000 l­îng")
    elseif (i >= 2001) and (i <= 2500) then
        AddNormalItem(3, 28, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Hång Thñy Tinh")
    elseif (i >= 2501) and (i <= 3000) then
        AddNormalItem(3, 80, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Lam Thñy Tinh")
    elseif (i >= 3001) and (i <= 4000) then
        AddNormalItem(3, 77, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 m¶nh Hång thñy tinh")
    elseif (i >= 4001) and (i <= 5000) then
        AddNormalItem(3, 78, 0, 0, 0, 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 m¶nh Lam thñy tinh")
    else
        Talk(1, "no", 13514)
    end ;
end

function no()
    CloseDialog()
end

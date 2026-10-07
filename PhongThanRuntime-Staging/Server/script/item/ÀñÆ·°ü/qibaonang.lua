function main(itemID)
    local i = math.random(1, 10000)
    local n = GetPlayerType()
    if (i >= 1) and (i <= 2) then
        if (n == 0) then
            AddNormalItem(0, 0, 17, 1, 0, 0)
            TopMessage(13427)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 vò khİ cÊp 85_Tinh ThÇn")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>vò khİ cÊp 85_Tinh ThÇn<c>!", 20)
        elseif (n == 1) then
            AddNormalItem(0, 0, 20, 1, 0, 0)
            TopMessage(13428)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 vò khİ cÊp 85_V« L­îng")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>vò khİ cÊp 85_V« L­îng<c>!", 20)
        else
            AddNormalItem(0, 0, 23, 1, 0, 0)
            TopMessage(13429)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 vò khİ cÊp 85_BÊt Hèi")
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>vò khİ cÊp 85_BÊt Hèi<c>!", 20)
        end ;
    elseif (i >= 3) and (i <= 100) then
        AddNormalItem(8, 229, 0, 0, 0, 1)
        TopMessage(13430)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thiªn H­¬ng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>Thiªn H­¬ng<c>!", 20)
    elseif (i >= 101) and (i <= 200) then
        AddNormalItem(8, 228, 0, 0, 0, 1)
        TopMessage(13431)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thiªn Gi¸ng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>Thiªn Gi¸ng<c>!", 20)
    elseif (i >= 201) and (i <= 400) then
        Earn(1000000)
        TopMessage(13432)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1000000 l­îng!")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>100v l­îng<c>!", 20)
    elseif (i >= 401) and (i <= 600) then
        AddNormalItem(3, 41, 0, 0, 0, 1)
        TopMessage(13433)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 viªn Lam B¶o Th¹ch")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>Lam B¶o Th¹ch<c>!", 20)
    elseif (i >= 601) and (i <= 1500) then
        AddNormalItem(3, 100, 0, 0, 0, 1)
        TopMessage(13434)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 T­íng Qu©n LÖnh")
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>tói ThÊt B¶o<c> may m¾n nhËn ®­îc <color=yellow>T­íng Qu©n LÖnh<c>!", 20)
    elseif (i >= 1501) and (i <= 2500) then
        AddNormalItem(3, 79, 0, 0, 0, 1)
        TopMessage(13435)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Hång B¶o Th¹ch")
    elseif (i >= 2501) and (i <= 4000) then
        Earn(500000)
        TopMessage(13436)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 500000 l­îng")
    elseif (i >= 4001) and (i <= 10000) then
        Earn(300000)
        TopMessage(13437)
        Msg2Player("B¹n nhËn ®­îc 300000 l­îng!")
    end ;
    CostIBItem(itemID)
end

function no()
    CloseDialog()
end

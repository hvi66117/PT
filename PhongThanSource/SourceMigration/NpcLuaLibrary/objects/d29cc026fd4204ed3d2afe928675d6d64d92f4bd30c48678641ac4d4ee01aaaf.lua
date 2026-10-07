Task_HandIn = 1841

require("¼×¹ÇÎÄ»î¶¯.luax")

function main()

    if (HaveNormalItem(6, 1, 902, 0) == 0) then
        return
    end

    DelNormalItem(6, 1, 902, 0)
    ORACLEBONE.GetCardWayApply(43, 0)

    if (math.random(1, 100) <= 50) then


        local nTemp = math.random(1, 100)
        local nGold = 0
        if (nTemp <= 40) then
            if (nTemp <= 10) then
                nGold = 5
            else
                nGold = 10
            end
        else
            if (nTemp <= 90) then
                nGold = 15
            else
                nGold = 20
            end
        end

        for i = 1, nGold do

            AddNormalItemPile(3, 1183, 0, 0, 0, 0)

        end
        Talk(1, "no", "Më hép Tói quµ, nhËn ®­îc " .. nGold .. " Nguyªn B¶o!")
        AddGlobalNews(GetName() .. "Më s¸ch thÇn bİ chç Lı Thiªn V­¬ng nhËn ®­îc " .. nGold .. " Nguyªn B¶o!")
        return

    end

    local nExpList = {
        { rand = 300, exp = 12000 },
        { rand = 250, exp = 13000 },
        { rand = 200, exp = 14000 },
        { rand = 100, exp = 15000 },
        { rand = 70, exp = 20000 },
        { rand = 50, exp = 30000 },
        { rand = 29, exp = 50000 },
        { rand = 1, exp = 100000 },
    }
    local nRand = math.random(1, 1000)
    local nTemp = 0
    local nExp = 0
    local nLevel = GetLevel()
    for i = 1, table.getn(nExpList) do
        nTemp = nTemp + nExpList[i].rand
        if (nRand <= nTemp) then
            nExp = nExpList[i].exp
            break
        end
    end

    nExp = math.floor(nExp * nLevel)
    if (nExp > 100000 * 200) then
        nExp = 100000 * 200
    end
    AddOwnExp(nExp)
    Msg2Player("B¹n nh©n ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
    Talk(1, "no", "Më th¸p Lı Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bİ, may m¾n nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
    AddGlobalNews(GetName() .. "Më th¸p Lı Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bİ, may m¾n nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm.")
    WriteLog("[Thñ LÔ thÇn bİ][sö dông][NhËn ®­îc " .. nExp .. " Kinh nghiÖm]")
end

function no()
    CloseDialog()
end

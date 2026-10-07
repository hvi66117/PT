Task_HandIn = 1841

require("¼×¹ÇÎÄ»î¶¯.luax")

function main()

    if (HaveNormalItem(6, 1, 903, 0) == 0) then
        return
    end

    if (GetPlayerExtLevel() <= 0) then
        Talk(1, "no", "CÊp ®é hiÖn t¹i lµ Tiªn Ma kh«ng thÓ sö dung Thñ LÔ.")
        return
    end

    DelNormalItem(6, 1, 903, 0)
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
        AddGlobalNews(GetName() .. "Më s¸ch thÇn bÝ chç Lý Thiªn V­¬ng nhËn ®­îc " .. nGold .. " Nguyªn B¶o!")
        return

    end

    local nExpList = {
        { rand = 300, exp = 9000 },
        { rand = 250, exp = 10000 },
        { rand = 200, exp = 12000 },
        { rand = 100, exp = 15000 },
        { rand = 70, exp = 20000 },
        { rand = 50, exp = 25000 },
        { rand = 29, exp = 40000 },
        { rand = 1, exp = 90000 },
    }
    local nRand = math.random(1, 1000)
    local nTemp = 0
    local nExp = 0
    local nLevel = GetPlayerExtLevel()
    for i = 1, table.getn(nExpList) do
        nTemp = nTemp + nExpList[i].rand
        if (nRand <= nTemp) then
            nExp = nExpList[i].exp
            break
        end
    end

    nExp = math.floor(nExp * nLevel)
    if (nExp > 90000 * 80) then
        nExp = 90000 * 80
    end
    AddOwnExtendExp(nExp)
    Msg2Player("B¹n nh©n ®­îc " .. nExp .. " §iÓm tu hµnh.")
    Talk(1, "no", "Më th¸p Lý Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bÝ, may m¾n nhËn ®­îc " .. nExp .. " §iÓm tu hµnh.")
    AddGlobalNews(GetName() .. "Më th¸p Lý Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bÝ, may m¾n nhËn ®­îc " .. nExp .. " §iÓm tu hµnh.")
    WriteLog("[Thñ LÔ thÇn bÝ][sö dông][NhËn ®­îc " .. nExp .. "Tu Vi]")
end

function no()
    CloseDialog()
end

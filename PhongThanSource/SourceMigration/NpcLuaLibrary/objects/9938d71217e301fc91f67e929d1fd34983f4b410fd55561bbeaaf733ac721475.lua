--Author:liujifang
--Desc£ºIBµÀ¾ßµ÷Õû
--Date:2012-12-5

Task_HandIn = 1841
--1byte£º¼ÇÂ¼ÉÏ½»Ê±¼ä
--2byte£º¼ÇÂ¼Ã¿ÌìÉÏ½»µÄ´ÎÊı
--4byte£ºÊÇ·ñ·¢¹ıĞû´«ÓÊ¼ş

function main()

    if (HaveNormalItem(6, 1, 902, 0) == 0) then
        return
    end

    DelNormalItem(6, 1, 902, 0)

    if (random(1, 100) <= 50) then
        Talk(1, "no", "Më Thñ LÔ, ph¸t hiÖn chØ cã 1 cuèn tranh!")
        AddGlobalNews(GetName() .. "Më th¸p Lı Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bİ, v« cïng thÊt väng chØ lµ cuèn tranh.")
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
    local nRand = random(1, 1000)
    local nTemp = 0
    local nExp = 0
    local nLevel = GetLevel()
    for i = 1, getn(nExpList) do
        nTemp = nTemp + nExpList[i].rand
        if (nRand <= nTemp) then
            nExp = nExpList[i].exp
            break
        end
    end

    nExp = floor(nExp * nLevel)
    if (nExp > 100000 * 200) then
        --³¬¹ı¿ÉÄÜµÄ×î´óÖµ
        nExp = 100000 * 200
    end
    AddOwnExp(nExp)
    Msg2Player("B¹n nh©n ®­îc" .. nExp .. " ®iÓm kinh nghiÖm.")
    Talk(1, "no", "Më th¸p Lı Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bİ, may m¾n qu¸." .. nExp .. " ®iÓm kinh nghiÖm.")
    AddGlobalNews(GetName() .. "Më th¸p Lı Thiªn V­¬ng nhËn ®­îc Thñ LÔ thÇn bİ, may m¾n qu¸." .. nExp .. " ®iÓm kinh nghiÖm.")
    WriteLog("[Thñ LÔ thÇn bİ][sö dông][nhËn ®­îc" .. nExp .. "Kinh nghiÖm]")
end

function no()
    CloseDialog()
end

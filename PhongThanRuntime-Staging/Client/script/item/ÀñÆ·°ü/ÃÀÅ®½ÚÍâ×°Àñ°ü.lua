function main()
    if (HaveNormalItem(6, 1, 940, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ 1 «.")
        return
    end

    DelNormalItem(6, 1, 940, 1)
    AddNormalItem(8, 1448, 2, 0, 0, 0)
    AddNormalItemBind(8, 1450, 2, 0, 0, 0, 1)
    Msg2Player("B¹n më lÔ bao mü n÷, nhËn ®­îc D­¬ng Xu©n Thanh Lé-L©m Phong Trang vµ D­¬ng Xu©n Thanh Lé-§µo Nghiªn Trang mçi thø 1 c¸i.")
    Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> Më lÔ vËt TÕt Mü N÷ cña Th«i Qu¶ng Viªn tÆng, nhËn ®­îc 1 ®«i ngo¹i trang hoa lÖ.")
    WriteLog("LÔ bao ngo¹i trang tÕt Mü N÷")
end

function no()
    CloseDialog()
end

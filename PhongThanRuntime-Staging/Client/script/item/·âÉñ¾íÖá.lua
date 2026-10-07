function main()

    Say("·âÉñ°ñÀÏÓÃ»§»Ø¹é»î¶¯, nhÊp vµo ÒÔÏÂ¿ÉÒÔ²é¿´ÁìÈ¡¸÷Ïî·áºñ´ó½±Ìõ¼ş", 3, "PhÇn th­ëng/v1", "PhÇn th­ëng h¶o h÷u mêi - ng­êi ch¬i cò quay vÒ/v2", "PhÇn th­ëng h¶o h÷u mêi - ng­êi ch¬i s«i næi/v3")

end;

function v1()
    CloseDialog()
    Talk(2, "main", "<color=green>PhÇn th­ëng quay vÒ<color>:\n tµi kho¶n cò ®¨ng nhËp trß ch¬i lÇn cuèi tr­íc ngµy 1 th¸ng 6 cã thÓ ®Õn chç Th«i Qu¶ng Viªn nhËn \n1)®¨ng nhËp trß ch¬i——phÇn th­ëng 3 Linh B¶o; \n2)Thêi gian tİch lòy 5 giê——PhÇn th­ëng 5 Linh B¶o+kü n¨ng x 2 trong 2 giê;", "<color=green>PhÇn th­ëng quay vÒ<color>:\n3)Hoµn thµnh 1 lÇn nhiÖm vô tuÇn hoµn V¹n Tiªn TrËn——LÔ Bao Chİ T«n+Kü n¨ng x 2 trong 4 giê; \n4)thêi gian tİch lòy 20 giê——LÔ Bao Linh Thó+kü n¨ng x 2 trong 8 giê; \n5) liªn tôc ®¨ng nhËp trß ch¬i 3 ngµy——ThÎ Kim DËt+Ngäc Thanh ThÇn Tiªn T¸n+Kü n¨ng x 2 trong 10 giê.")
end;

function v2()
    CloseDialog()
    Talk(2, "main", "<color=green>PhÇn th­ëng h¶o h÷u mêi<color>——Tµi kho¶n quay vÒ:\n tµi kho¶n quay vÒ vµ tµi kho¶n ho¹t ®éng s«i næi sau khi khãa ë chç Th«i Qu¶ng Viªn tháa m·n c¸c ®iÒu kiÖn th× cã thÓ nhËn ®­îc\n1)§¨ng nhËp trß ch¬i——phÇn th­ëng 3 Linh B¶o; \n2)thêi gian tİch lòy 5 giê——PhÇn th­ëng 5 Linh B¶o+kü n¨ng x 2 trong 2 giê;", "<color=green>PhÇn th­ëng h¶o h÷u mêi<color>tµi kho¶n quay vÒ:\n3)hoµn thµnh 1 lÇn nhiÖm vô tuÇn hoµn V¹n Tiªn TrËn——LÔ Bao Chİ T«n+Kü n¨ng x 2 trong 4 giê; \n4)Thêi gian tİch lòy 20 giê——LÔ Bao Linh Thó+Kü n¨ng x 2 trong 8 giê; \n5)®¨ng nhËp trß ch¬i liªn tôc 3 ngµy——15 Linh B¶o+Ngäc Thanh ThÇn Tiªn T¸n+Kü n¨ng x 2 trong 10 giê.")
end;

function v3()
    CloseDialog()
    Talk(2, "main", "<color=green>PhÇn th­ëng h¶o h÷u mêi<color>——tµi kho¶n ho¹t ®éng s«i néi:\n tµi kho¶n cò quay vÒ vµ tµi kho¶n ho¹t ®éng s«i næi tiÕn hµnh khãa ë Th«i Qu¶ng Viªn tháa m·n c¸c ®iÒu kiÖn lµ cã thÓ nhËn ®­îc\n1) ®¨ng nhËp trß ch¬i——phÇn th­ëng 3 Linh B¶o; \n2)Thêi gian tİch lòy 5 giê——Tiªu Dao ThÇn Tiªn T¸n+kü n¨ng x 2 trong 2 giê;", "<color=green>PhÇn th­ëng h¶o h÷u mêi<color>kh¸ch hµng ho¹t ®éng s«i næi:\n3) hoµn thµnh 1 lÇn  nhiÖm vô tuÇn hoµn V¹n Tiªn TrËn——5 Linh B¶o+ThÇn CÈu Phï+tr¹ng th¸i nh©n ®«i kü n¨ng 4 giê; \n4)thêi gian tİch lòy 20 giê——lÔ bao chİ t«n+kü n¨ng x2 6 giê; \n5) ®¨ng nhËp trß ch¬i liªn tôc 3 ngµy——10 Linh B¶o+Di Quang Kİnh+kü n¨ng x 2 trong 8 giê.")
end;

function no()
    CloseDialog()
end;

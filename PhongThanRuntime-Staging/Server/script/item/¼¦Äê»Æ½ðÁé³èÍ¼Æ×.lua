require("ÊôÐÔÁé³è.luax")

function main()
    local tasks = {
        { "ºÏ³É»Æ½ðÁé³è", "CreateGoldenPet"; show = 1 }
    }
    local strBlack = "¼¦Äê»Æ½ðÁé³èÍ¼Æ×lµ ®¹o cô ho¹t ®éng tÆng cho VIP H»ng n¨m 2017. Cã thÓ hîp thµnh Linh Sñng Hoµng Kim b¶n cuèi."
    local strGolden = "<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n §¸t Kû, Th©n C«ng B¸o, Hoµng Phi Hæ, Hao Thiªn KhuyÓn, D­¬ng TiÔn, Kh­¬ng Tö Nha) = Linh Sñng Hoµng Kim b¶n cuèi<c>"

    SayTask(strBlack .. "\n" .. strGolden, tasks)
end

function CreateGoldenPet()
    local strBlack = "Mçi ®å phæ Hoµng Kim chØ cã thÓ hîp thµnh 1 Linh Sñng Hoµng Kim. Anh hïng muèn hîp thµnh lo¹i nµo?"
    local strGolden = "<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n §¸t Kû, Th©n C«ng B¸o, Hoµng Phi Hæ, Hao Thiªn KhuyÓn, D­¬ng TiÔn, Kh­¬ng Tö Nha) = Linh Sñng Hoµng Kim b¶n cuèi<c>"
    Say(strGolden .. "\n" .. strBlack, 7, "Kim Hå §¸t Kû/Daji", "Kim B¸o Th©n C«ng B¸o/Shengongbao", "Kim §¶m Hoµng Phi Hæ/Huangfeihu", "Kim Th©n Hao Thiªn KhuyÓn/Xiaotianquan", "Kim ThÇn D­¬ng TiÔn/Yangjian", "Kim Th©n Kh­¬ng Tö Nha/Jiangziya", "Hñy bá/no")
end

function Daji()
    local tasks = {
        { "X¸c nhËn", "Daji1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Kim Hå §¸t Kû<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-§¸t Kû. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Daji1()
    no()

    if ((HaveNormalItem(6, 1, 1487, 1) >= 1) or (GetTaskBit(2189, 29) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1487, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1660, 1, 0, 0)
        SetTaskByte(2117, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh Kim Hå §¸t Kû")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim Hå §¸t Kû<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Shengongbao()
    local tasks = {
        { "X¸c nhËn", "Shengongbao1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Kim B¸o Th©n C«ng B¸o<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Th©n C«ng B¸o. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end
function Shengongbao1()
    no()

    if ((HaveNormalItem(6, 1, 1497, 1) >= 1) or (GetTaskBit(2190, 8) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1497, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1661, 1, 0, 0)
        SetTaskByte(2120, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh Kim B¸o Th©n C«ng B¸o")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim B¸o Th©n C«ng B¸o<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end
function Huangfeihu()
    local tasks = {
        { "X¸c nhËn", "Huangfeihu1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Kim §¶m Hoµng Phi Hæ<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Hoµng Phi Hæ. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end
function Huangfeihu1()
    no()

    if ((HaveNormalItem(6, 1, 1507, 1) >= 1) or (GetTaskBit(2190, 18) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1507, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1662, 1, 0, 0)
        SetTaskByte(2123, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh Kim §¶m Hoµng Phi Hæ")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim §¶m Hoµng Phi Hæ<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Xiaotianquan()
    local tasks = {
        { "X¸c nhËn", "Xiaotianquan1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>½ðÉíHao Thiªn KhuyÓn<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Hao Thiªn KhuyÓn. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Xiaotianquan1()
    no()

    if ((HaveNormalItem(6, 1, 1608, 1) >= 1) or (GetTaskBit(2190, 28) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1608, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1663, 1, 0, 0)
        SetTaskByte(2200, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh ½ðÉíHao Thiªn KhuyÓn")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>½ðÉíHao Thiªn KhuyÓn<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Yangjian()
    local tasks = {
        { "X¸c nhËn", "Yangjian1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>½ðÉñD­¬ng TiÔn<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-D­¬ng TiÔn. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Yangjian1()
    no()

    if ((HaveNormalItem(6, 1, 1618, 1) >= 1) or (GetTaskBit(2212, 7) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1618, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1664, 1, 0, 0)
        SetTaskByte(2203, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh ½ðÉñD­¬ng TiÔn")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>½ðÉñD­¬ng TiÔn<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Jiangziya()
    local tasks = {
        { "X¸c nhËn", "Jiangziya1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>½ðÉíKh­¬ng Tö Nha<c>CÇn tiªu hao:<c=yellow>¼¦Äê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Kh­¬ng Tö Nha. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Jiangziya1()
    no()

    if ((HaveNormalItem(6, 1, 1628, 1) >= 1) or (GetTaskBit(2212, 17) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1666, 1) >= 1) then

        DelNormalItem(6, 1, 1666, 1)
        DelNormalItem(6, 1, 1628, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1665, 1, 0, 0)
        SetTaskByte(2206, 4, 0)
        WriteLog("[¼¦Äê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh ½ðÉíKh­¬ng Tö Nha")
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>½ðÉíKh­¬ng Tö Nha<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function cancel()
    CreateGoldenPet()
end

function no()
    CloseDialog()
end

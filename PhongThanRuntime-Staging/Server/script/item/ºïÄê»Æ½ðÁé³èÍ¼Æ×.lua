require("ÊôÐÔÁé³è.luax")

function main()
    local tasks = {
        { "Hîp thµnh Linh Sñng Hoµng Kim", "CreateGoldenPet"; show = 1 }
    }
    local strBlack = "§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n lµ ®¹o cô ho¹t ®éng tÆng cho VIP H»ng n¨m 2016. Cã thÓ hîp thµnh Linh Sñng Hoµng Kim b¶n cuèi."
    local strGolden = "<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Hå HØ MÞ, Na Tra, L«i ChÊn Tö, Th¹ch C¬, Th¸i Êt) = Linh Sñng Hoµng Kim b¶n cuèi<c>"

    SayTask(strBlack .. "\n" .. strGolden, tasks)
end

function CreateGoldenPet()
    local strBlack = "Mçi ®å phæ Hoµng Kim chØ cã thÓ hîp thµnh 1 Linh Sñng Hoµng Kim. Anh hïng muèn hîp thµnh lo¹i nµo?"
    local strGolden = "<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Hå HØ MÞ, Na Tra, L«i ChÊn Tö, Th¹ch C¬, Th¸i Êt) = Linh Sñng Hoµng Kim b¶n cuèi<c>"
    Say(strGolden .. "\n" .. strBlack, 6, "Kim Kª Hå HØ MÞ/Huximei", "Kim Th©n Na Tra/Nezha", "Kim Vò L«i ChÊn Tö/Leizhenzi", "Kim Quan Th¹ch C¬/Shiji", "Kim Tiªn Th¸i Êt/Taiyi", "Hñy bá/no")
end

function Huximei()
    local tasks = {
        { "X¸c nhËn", "Huximei1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Hå HØ MÞ<c>CÇn tiªu hao:<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Hå HØ MÞ. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Huximei1()

    if ((HaveNormalItem(6, 1, 1348, 1) >= 1) or (GetTaskBit(2188, 10) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1476, 1) >= 1) then

        DelNormalItem(6, 1, 1476, 1)
        DelNormalItem(6, 1, 1348, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1541, 1, 0, 0)
        SetTaskByte(2071, 4, 0)
        WriteLog("[§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n] Ng­êi ch¬i hîp thµnh ½ð¼¦Hå HØ MÞ")
        Talk(1, "CreateGoldenPet", "Ngµi thµnh c«ng hîp thµnh <c=yellow>½ð¼¦Hå HØ MÞ<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Nezha()
    local tasks = {
        { "X¸c nhËn", "Nezha1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Na Tra<c>CÇn tiªu hao:<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Na Tra. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end
function Nezha1()

    if ((HaveNormalItem(6, 1, 1368, 1) >= 1) or (GetTaskBit(2188, 20) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1476, 1) >= 1) then

        DelNormalItem(6, 1, 1476, 1)
        DelNormalItem(6, 1, 1368, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1542, 1, 0, 0)
        SetTaskByte(2078, 4, 0)
        WriteLog("[§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n] Ng­êi ch¬i hîp thµnh ½ðÉíNa Tra")
        Talk(1, "CreateGoldenPet", "Ngµi thµnh c«ng hîp thµnh <c=yellow>½ðÉíNa Tra<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end
function Leizhenzi()
    local tasks = {
        { "X¸c nhËn", "Leizhenzi1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>L«i ChÊn Tö<c>CÇn tiªu hao:<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-L«i ChÊn Tö. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end
function Leizhenzi1()

    if ((HaveNormalItem(6, 1, 1435, 1) >= 1) or (GetTaskBit(2188, 30) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1476, 1) >= 1) then

        DelNormalItem(6, 1, 1476, 1)
        DelNormalItem(6, 1, 1435, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1543, 1, 0, 0)
        SetTaskByte(2091, 4, 0)
        WriteLog("[§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n] Ng­êi ch¬i hîp thµnh Kim Vò L«i ChÊn Tö")
        Talk(1, "CreateGoldenPet", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim Vò L«i ChÊn Tö<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Shiji()
    local tasks = {
        { "X¸c nhËn", "Shiji1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Th¹ch C¬<c>CÇn tiªu hao:<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Th¹ch C¬. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Shiji1()

    if ((HaveNormalItem(6, 1, 1457, 1) >= 1) or (GetTaskBit(2189, 9) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1476, 1) >= 1) then

        DelNormalItem(6, 1, 1476, 1)
        DelNormalItem(6, 1, 1457, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1544, 1, 0, 0)
        SetTaskByte(2106, 4, 0)
        WriteLog("[§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n] Ng­êi ch¬i hîp thµnh Kim Quan Th¹ch C¬")
        Talk(1, "CreateGoldenPet", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim Quan Th¹ch C¬<c>")
    else
        Talk(1, "CreateGoldenPet", "Ngµi ch­a cã ®ñ ®¹o cô, kh«ng thÓ hîp thµnh Linh Sñng Thuéc TÝnh Hoµng Kim.")
    end
end

function Taiyi()
    local tasks = {
        { "X¸c nhËn", "Taiyi1"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SayTask("ºÏ³É<c=yellow>Th¸i Êt<c>CÇn tiªu hao:<c=yellow>§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-Th¸i Êt. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?<c>", tasks)
end

function Taiyi1()

    if ((HaveNormalItem(6, 1, 1474, 1) >= 1) or (GetTaskBit(2189, 19) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, 1476, 1) >= 1) then

        DelNormalItem(6, 1, 1476, 1)
        DelNormalItem(6, 1, 1474, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, 1475, 1, 0, 0)
        SetTaskByte(2114, 4, 0)
        WriteLog("[§å phæ Linh Sñng Hoµng Kim-BÝnh Th©n] Ng­êi ch¬i hîp thµnh Kim Tiªn Th¸i Êt")
        Talk(1, "CreateGoldenPet", "Ngµi thµnh c«ng hîp thµnh <c=yellow>Kim Tiªn Th¸i Êt<c>")
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

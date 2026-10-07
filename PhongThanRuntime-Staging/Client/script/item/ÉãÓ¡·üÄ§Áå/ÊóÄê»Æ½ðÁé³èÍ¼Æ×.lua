require("ÊôÐÔÁé³è.luax")

G_Gold = 1863
G_PetList = {
    [1] = { goldname = "Kim §¶m Phi Th¨ng-Hoµng Phi Hæ", name = "Phi Th¨ng-Hoµng Phi Hæ", taskValue = 2267, Item = 1820, taskbit = { 2214, 14 }, glodItem = 1859 },
    [2] = { goldname = "Kim Th©n Phi Th¨ng Hao Thiªn KhuyÓn", name = "Phi Th¨ng-Hao Thiªn KhuyÓn", taskValue = 2270, Item = 1831, taskbit = { 2214, 24 }, glodItem = 1860 },
    [3] = { goldname = "Kim ThÇn Phi Th¨ng D­¬ng TiÔn", name = "Phi Th¨ng-D­¬ng TiÔn", taskValue = 2274, Item = 1845, taskbit = { 2215, 3 }, glodItem = 1861 },
    [4] = { goldname = "Kim Th©n Phi Th¨ng Kh­¬ng Tö Nha", name = "Phi Th¨ng-Kh­¬ng Tö Nha", taskValue = 2279, Item = 1857, taskbit = { 2282, 10 }, glodItem = 1862 },
}

function main()
    if (HaveNormalItem(6, 1, G_Gold, 1) <= 0) then
        if (HaveNormalItem(6, 1, G_Gold, 0) > 0) then
            if (DelNormalItem(6, 1, G_Gold, 0) > 0) then
                AddNormalItem(6, 1, G_Gold, 1, 0, 0)
            end
        end
    end

    local tasks = {
        { "Hîp thµnh Linh Sñng Hoµng Kim", "CreateGoldenPet"; show = 1 }
    }
    local strBlack = "ÊóÄê»Æ½ðÁé³èÍ¼Æ×lµ ®¹o cô ho¹t ®éng tÆng cho VIP H»ng n¨m 2020. Cã thÓ hîp thµnh Linh Sñng Hoµng Kim b¶n cuèi."
    local strGolden = "<c=yellow>ÊóÄê»Æ½ðÁé³èÍ¼Æ×+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Phi Th¨ng-Hoµng Phi Hæ, Phi Th¨ng-Hao Thiªn KhuyÓn, Phi Th¨ng-D­¬ng TiÔn, Phi Th¨ng-Kh­¬ng Tö Nha) = Linh Sñng Hoµng Kim b¶n cuèi<c>"

    SayTask(strBlack .. "\n" .. strGolden, tasks)
end

function CreateGoldenPet()
    local strBlack = "Mçi ®å phæ Hoµng Kim chØ cã thÓ hîp thµnh 1 Linh Sñng Hoµng Kim. Anh hïng muèn hîp thµnh lo¹i nµo?"
    local strGolden = "<c=yellow>ÊóÄê»Æ½ðÁé³èÍ¼Æ×+Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Phi Th¨ng-Hoµng Phi Hæ, Phi Th¨ng-Hao Thiªn KhuyÓn, Phi Th¨ng-D­¬ng TiÔn, Phi Th¨ng-Kh­¬ng Tö Nha) = Linh Sñng Hoµng Kim b¶n cuèi<c>"
    local tSayTable = {}

    for i = 1, getn(G_PetList) do
        tSayTable[i] = G_PetList[i].goldname .. "/SelPetList"
    end
    tSayTable[getn(tSayTable) + 1] = "§ãng/no"
    Say(strGolden .. "\n" .. strBlack, getn(tSayTable), tSayTable)
end

function SelPetList(n)
    n = n + 1
    if (n < 1) or (n > getn(G_PetList)) then
        no()
        return 0
    end

    local tasks = {
        { "X¸c nhËn", "hecheng"; show = 1 },
        { "Quay l¹i", "cancel"; show = 1 },

    }
    SetTask(142, n)
    SayTask("ºÏ³É<c=yellow>" .. G_PetList[n].goldname .. "<c>CÇn tiªu hao:<c=g>ÊóÄê»Æ½ðÁé³èÍ¼Æ×1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-" .. G_PetList[n].name .. "<c>. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?", tasks)
end

function hecheng()
    no()
    local nIndex = GetTask(142)
    if ((HaveNormalItem(6, 1, G_PetList[nIndex].Item, 1) >= 1) or (GetTaskBit(G_PetList[nIndex].taskbit[1], G_PetList[nIndex].taskbit[2]) == 1)) and (HaveNormalItem(3, 1634, 0, 0) >= 2) and (HaveNormalItem(6, 1, G_Gold, 1) >= 1) then
        DelNormalItem(6, 1, G_Gold, 1)
        DelNormalItem(6, 1, G_PetList[nIndex].Item, 1)
        DelNormalItem(3, 1634, 0, 0)
        DelNormalItem(3, 1634, 0, 0)
        AddNormalItem(6, 1, G_PetList[nIndex].glodItem, 1, 0, 0)
        SetTaskByte(G_PetList[nIndex].taskValue, 4, 0)
        WriteLog("[ÊóÄê»Æ½ðÁé³èÍ¼Æ×] Ng­êi ch¬i hîp thµnh " .. G_PetList[nIndex].goldname)
        Talk(1, "no", "Ngµi thµnh c«ng hîp thµnh <c=yellow>" .. G_PetList[nIndex].goldname .. "<c>")
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

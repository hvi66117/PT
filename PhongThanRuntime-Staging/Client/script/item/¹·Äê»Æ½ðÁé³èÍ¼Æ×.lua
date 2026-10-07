require("ÊôÐÔÁé³è.luax")

G_Gold = 1739
G_PetList = {
    [1] = { goldname = "Kim Th¸p Lý TÞnh", name = "Lý TÞnh", taskValue = 2209, Item = 1638, taskbit = { 2212, 27 }, glodItem = 1735 },
    [2] = { goldname = "Kim Kª Phi Th¨ng -Hå HØ MÞ", name = "Phi Th¨ng-Hå HØ MÞ", taskValue = 2230, Item = 1684, taskbit = { 2233, 6 }, glodItem = 1736 },
    [3] = { goldname = "Kim Th©n Phi Th¨ng-Na Tra", name = "Phi Th¨ng-Na Tra", taskValue = 2234, Item = 1696, taskbit = { 2233, 16 }, glodItem = 1737 },
    [4] = { goldname = "Kim Vò Phi Th¨ng-L«i ChÊn Tö", name = "Phi Th¨ng-L«i ChÊn Tö", taskValue = 2238, Item = 1733, taskbit = { 2233, 26 }, glodItem = 1738 },
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
    local strBlack = "§å phæ Linh Sñng Hoµng Kim lµ ®¹o cô ho¹t ®éng tÆng cho VIP H»ng n¨m 2018. Cã thÓ hîp thµnh Linh Sñng Hoµng Kim b¶n cuèi."
    local strGolden = "<c=yellow>§å phæ Linh Sñng Hoµng Kim +Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Lý TÞnh, Phi Th¨ng-Hå HØ MÞ, Phi Th¨ng-Na Tra, Phi Th¨ng-L«i ChÊn Tö) = Linh Sñng Hoµng Kim b¶n cuèi<c>"

    SayTask(strBlack .. "\n" .. strGolden, tasks)
end

function CreateGoldenPet()
    local strBlack = "Mçi ®å phæ Hoµng Kim chØ cã thÓ hîp thµnh 1 Linh Sñng Hoµng Kim. Anh hïng muèn hîp thµnh lo¹i nµo?"
    local strGolden = "<c=yellow>§å phæ Linh Sñng Hoµng Kim +Tinh Hoa Tiªn Sñng*2+ Linh sñng Thuéc TÝnh cÊp 10 (Giíi h¹n Lý TÞnh, Phi Th¨ng-Hå HØ MÞ, Phi Th¨ng-Na Tra, Phi Th¨ng-L«i ChÊn Tö) = Linh Sñng Hoµng Kim b¶n cuèi<c>"
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
    SayTask("ºÏ³É<c=yellow>" .. G_PetList[n].goldname .. "<c>CÇn tiªu hao:<c=g>§å phæ Linh Sñng Hoµng Kim 1 tÊm, Tinh Hoa Tiªn Sñng*2, CÊp 10-" .. G_PetList[n].name .. "<c>. X¸c ®Þnh tiªu hao ®¹o cô trªn ®Ó hîp thµnh sao?", tasks)
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
        WriteLog("[§å phæ Linh Sñng Hoµng Kim ] Ng­êi ch¬i hîp thµnh " .. G_PetList[nIndex].goldname)
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

require("newserver.luax")
require("ÊôĞÔÁé³è.luax")

CardIndex = 1645

PetIdx = NewServerEx.PetIdx
PetName = Able_Pet.TaskTable_AllPet2New[PetIdx].petname
CardName = "ËéÆ¬ÊÕ¼¯Æ÷"
EndTimeYY = NewServerEx.g_PetTime[1][1]
EndTimeMM = NewServerEx.g_PetTime[1][2]
EndTimeDD = NewServerEx.g_PetTime[1][3]

EndPilesTimeYY = NewServerEx.g_PetTime[2][1]
EndPilesTimeMM = NewServerEx.g_PetTime[2][2]
EndPilesTimeDD = NewServerEx.g_PetTime[2][3]

PetPiles = {
    { name = "ËéÆ¬¡¤ÍòÏÉ", wenzi = ": Hoµn thµnh nhiÖm vô V¹n Tiªn TrËn", bit = 3, taskId = { 2196, 3 } },
    { name = "ËéÆ¬¡¤ÁúÖé", wenzi = ": ÉÏ½»±ùÁúÖé/»ğÁúÖé", bit = 4, taskId = { 2196, 4 } },
    { name = "ËéÆ¬¡¤ÁÔÂí", wenzi = ": Hoµn thµnh nhiÖm vô LiÖp M· Th­ëng Kim", bit = 5, taskId = { 2197, 1 } },
    { name = "ËéÆ¬¡¤Ï´Á¶", wenzi = ": Ê¹ÓÃDi Quang Kİnh", bit = 6, taskId = { 2197, 2 } },
    { name = "ËéÆ¬¡¤ÂŞÉ²", wenzi = ": ¶ÓÎé½µ·şÂŞÉ²Ä§Éñ", bit = 7, taskId = { 2197, 3 } },
    { name = "ËéÆ¬¡¤ÔÔÅà", wenzi = ": Thiªn §×nh ThÇn ThôÈÎÎñ³¤¶È´ïµ½40ÒÔÉÏ", bit = 8, taskId = { 2197, 4 } },
    { name = "ËéÆ¬¡¤Öîºî", wenzi = ": ÉÏ½»¡°M¶nh s¸ch Ch­ HÇu¡±", bit = 9, taskId = { 2198, 1 } },
    { name = "ËéÆ¬¡¤³É³¤", wenzi = ": Ê¹ÓÃ[¹Î¹Î¿¨]µÀ¾ß", bit = 10, taskId = { 2198, 2 } },
    { name = "ËéÆ¬¡¤ºÃÔË", wenzi = ": »ı·Ö³é½±", bit = 11, taskId = { 2198, 3 } },
    { name = "ËéÆ¬¡¤¹¥³Ç", wenzi = ": ¹ÖÎï¹¥³Ç¹¥»÷Ğ¡¹ÖÊ±", bit = 12, taskId = { 2198, 4 } },
}

function main(nLevel, t, nNpcIdx, nItemId)
    if (GetTaskBit(2196, 1) == 1) then
        Talk(1, "no", "ÄúÒÑ<c=y>³É¹¦µÇ¼ÇÁé³è[" .. PetName .. "]µÄÁìÈ¡×Ê¸ñ<c>, ¸ÃÁé³è×Ê¸ñ½«ÓÚ" .. EndTimeYY .. "N¨m" .. EndTimeMM .. "Th¸ng" .. EndTimeDD .. "ÈÕÆğ¸ù¾İµÇ¼ÇÇé¿öÂ½Ğø·¢·Å.Çëµ½TriÒu CaËãÃüÏÈÉú´¦ÁìÈ¡.")

        return
    end

    if (NewServerEx.Pet_IsPilesCardTime() == 0) then
        Talk(1, "no", "»î¶¯Ê±¼äÒÑ¹ı, " .. CardName .. "ÒÑ×÷·Ï.")
        DelNormalItem(6, 1, CardIndex, 1)
        DelNormalItem(6, 1, CardIndex, 0)
        WriteLog("[Ho¹t ®éng m¸y chñ míi][" .. CardName .. "]¹ıÆÚÉ¾³ı.")
        return
    end

    local key = 0
    if (GetTaskBit(2196, 2) == 1) then
        key = 20
    else
        for i = 1, getn(PetPiles) do
            if (GetTaskBit(2196, PetPiles[i].bit) == 1) then
                key = key + 1
            end
        end
    end

    if (key >= getn(PetPiles)) then
        SetTaskBit(2196, 2, 1)
        if (GetLevel() < 121) then
            Talk(1, "no", "ÄãµÄµÈ¼¶»¹²»×ã<c=r>121¼¶<c>, Çë¾¡¿ìÉı¼¶, ±ØĞëÔÚ<c=g>" .. EndPilesTimeYY .. "N¨m" .. EndPilesTimeMM .. "Th¸ng" .. EndPilesTimeDD .. "ÈÕ24:00<c>Ç°, ²ÅÓĞÁìÈ¡×Ê¸ñ!")
            return 0
        end
        local tasks = {
            { "<c=y>µÇ¼Ç×Ê¸ñ<c>", "registPetYes"; show = 1 },

            { "ÎÒÏÂ´ÎÔÙËµ", "no"; show = 1 },
        }

        SayTask("ÄúµÄËéÆ¬¿ÉÄÜÒÑ¼¯Æë, ÊÇ·ñÏÖÔÚµÇ¼ÇÄúµÄÁé³è[" .. PetName .. "]µÄÁìÈ¡×Ê¸ñ£¿\n±ØĞëÔÚ<c=g>" .. EndPilesTimeYY .. "N¨m" .. EndPilesTimeMM .. "Th¸ng" .. EndPilesTimeDD .. "ÈÕ24:00<c>Ç°, ²ÅÓĞÁìÈ¡×Ê¸ñ!Î´ÔÚÆÚÏŞÄÚµÇ¼ÇµÄÊÓÎª·ÅÆúÁìÈ¡×Ê¸ñ!", tasks)

    else
        Talk(2, "info", "trong <c=g>" .. EndPilesTimeYY .. "N¨m" .. EndPilesTimeMM .. "Th¸ng" .. EndPilesTimeDD .. "ÈÕ24:00<c>Ç°, ¼¯ÆëÒÔÏÂÊ®Ã¶ËéÆ¬²¢ÇÒ´ïµ½<c=g>121¼¶<c>, ¼´¿ÉÊ¹ÓÃ´ËµÀ¾ßµÇ¼ÇÁé³è[<c=y>" .. PetName .. "<c>]µÄÁìÈ¡×Ê¸ñ.", Able_Pet.TaskTable_AllPet2New[PetIdx].wenzi)

    end

end

function no()
    CloseDialog()
end;

function registPetYes()
    MsgBox("ÊÇ·ñÏÖÔÚµÇ¼ÇÄúµÄÁé³è[" .. PetName .. "]µ½Õâ¸ö<c=y>" .. GetAccount() .. "<c>ÕËºÅ£¿\n<c=r>µÇ¼ÇºóÎŞ·¨ĞŞ¸Ä, ÇëÉ÷ÖØ¿¼ÂÇ!!!<c>", "registPet", "no")
end

function registPet()
    CloseDialog()
    local key = 0
    for i = 1, getn(PetPiles) do
        if (GetTaskBit(2196, PetPiles[i].bit) == 1) then
            key = key + 1
        end
    end

    if (key < getn(PetPiles)) then
        SetTaskBit(2196, 2, 0)
        Talk(1, "info", "Xin lçi, ÄãµÄËéÆ¬Ã»ÓĞ¼¯Æë, ÎŞ·¨ÁìÈ¡Áé³è[" .. PetName .. "].")
        WriteLog("[Ho¹t ®éng m¸y chñ míi][" .. CardName .. "]Òì³£ÁìÈ¡×Ê¸ñ.")
        return 0
    end

    SetTaskBit(2196, 1, 1)
    WriteLog("[Ho¹t ®éng m¸y chñ míi][" .. CardName .. "][" .. PetName .. "]ÁìÈ¡×Ê¸ñ.")
    Talk(1, "no", "ÄúÒÑ³É¹¦µÇ¼ÇÁé³è[" .. PetName .. "]µÄÁìÈ¡×Ê¸ñ, Áé³è×Ê¸ñ½«ÓÚ" .. EndTimeYY .. "N¨m" .. EndTimeMM .. "Th¸ng" .. EndTimeDD .. "ÈÕÆğ¸ù¾İµÇ¼ÇÇé¿öÂ½Ğø·¢·Å.Çëµ½TriÒu CaËãÃüÏÈÉú´¦ÁìÈ¡.\nÈçÓĞÒÉÎÊÇë×ÉÑ¯¿Í·ş.")
end

function info()
    CloseDialog()
    local str = "<c=y>ÒÔÏÂËùÓĞÈÎÎñ¶¼ÊÇ¸ÅÂÊ»ñµÃ<c>\n"
    for i = 1, 5 do
        if (GetTaskBit(2196, PetPiles[i].bit) == 1) then
            str = str .. "<c=g>" .. PetPiles[i].name .. "(1/1)" .. PetPiles[i].wenzi .. "<c>\n"
        else
            str = str .. PetPiles[i].name .. "(0/1)" .. PetPiles[i].wenzi .. "\n"
        end
    end

    Talk(1, "info1", str)
end

function info1()
    CloseDialog()
    local str = "<c=y>ÒÔÏÂËùÓĞÈÎÎñ¶¼ÊÇ¸ÅÂÊ»ñµÃ<c>\n"
    for i = 6, 10 do
        if (GetTaskBit(2196, PetPiles[i].bit) == 1) then
            str = str .. "<c=g>" .. PetPiles[i].name .. "(1/1)" .. PetPiles[i].wenzi .. "<c>\n"
        else
            str = str .. PetPiles[i].name .. "(0/1)" .. PetPiles[i].wenzi .. "\n"
        end
    end

    Talk(1, "no", str)
end

function shenyin()
    CloseDialog()


end

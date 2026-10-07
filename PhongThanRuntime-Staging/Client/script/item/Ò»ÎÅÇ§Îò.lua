T_Book = {
    [1] = { name = "³õ¼¶Ò»ÎÅÇ§Îò", id = { 6, 1, 1416, 0 } },
    [2] = { name = "ÖĞ¼¶Ò»ÎÅÇ§Îò", id = { 6, 1, 1417, 0 } },
    [3] = { name = "¸ß¼¶Ò»ÎÅÇ§Îò", id = { 6, 1, 1418, 0 } },
    [4] = { name = "ÖÁ×ğÒ»ÎÅÇ§Îò", id = { 6, 1, 1419, 0 } },
}

SkillID = 1479

function main(nLevel, t, nNpcIdx, nItemId)

    local nGen = GetItemGen(nItemId)
    local nDetail = GetItemDetail(nItemId)
    local nParticular = GetItemPartByID(nItemId)

    local bookindex = 0
    for i = 1, table.getn(T_Book) do
        if (nParticular == T_Book[i].id[3]) then
            bookindex = i
            break
        end
    end

    if (bookindex == 0) then
        Talk(1, "no", "ThËt xin lçi,ÄúµÄ¼¼ÄÜÊé²»ÄÜÊ¹ÓÃ.")
        WriteLog("[Ò»ÎÅÇ§ÎòSö dông thÊt b¹i]")
        return
    end

    if (GetNewBirthTimes() < 1) then
        Talk(1, "no", "ThËt xin lçi,ÄãÉĞÎ´×ªÉú,ÎŞ·¨Ê¹ÓÃ¼¼ÄÜÊé.")
        return
    end

    SetTask(140, bookindex)
    local menu = {
        { "Ñ§Ï°¼¼ÄÜ", "Learn"; show = 1 },
        { "¼¼ÄÜÊéºÏ³É", "BookUp"; show = 1 },
    }
    SayTask("¼¼ÄÜÊéºÏ³ÉĞèÒªµÍ¼¶Êé3±¾, Mêi lùa chän:", menu)


end

function BookUp()
    local bookindex = GetTask(140)
    if (bookindex == 4) then
        Talk(1, "no", "ÄúµÄ¼¼ÄÜÊéÒÑ¾­ÊÇ×î¸ßµÈ¼¶, ÎŞ·¨ºÏ³É.")
        return
    end
    if (bookindex == 0 or bookindex > 4) then
        Talk(1, "no", "ThËt xin lçi,ÄúµÄ¼¼ÄÜÊé²»ÄÜºÏ³É.")
        WriteLog("[Ò»ÎÅÇ§ÎòºÏ³ÉÊ§°Ü]")
        return
    end
    local index_a = bookindex + 1
    local ID = T_Book[bookindex].id
    if (HaveNormalItem(ID[1], ID[2], ID[3], ID[4]) < 3) then
        local str = "Hîp thµnh" .. T_Book[index_a].name .. "ĞèÒª3±¾" .. T_Book[bookindex].name .. "¼¼ÄÜÊé, Ä¿Ç°²»×ãÎŞ·¨ºÏ³É."
        Talk(1, "no", str)
        return
    end
    for i = 1, 3 do
        DelNormalItem(ID[1], ID[2], ID[3], ID[4])
    end
    local ID_a = T_Book[index_a].id
    AddNormalItem(ID_a[1], ID_a[2], ID_a[3], ID_a[4], 0, 0)
    WriteLog("[Ò»ÎÅÇ§Îò][ºÏ³É" .. T_Book[index_a].name .. "³É¹¦]")
    Talk(1, "no", "Chóc m­õng ngµi, ¼¼ÄÜÊéºÏ³É³É¹¦.")
end

function Learn()
    no()
    local bookindex = GetTask(140)
    local nCurLevel = GetSkillLevel(SkillID)
    if (nCurLevel >= 10) then
        Talk(1, "no", "ÄúµÄ¼¼ÄÜ´ïµ½ÁË×î´óµÈ¼¶,²»ĞèÒªÔÙÑ§Ï°ÁË.")
        return
    end

    if (bookindex == 1) then
        ChuJi()
    elseif (bookindex == 2) then
        ZhongJi()
    elseif (bookindex == 3) then
        GaoJi()
    elseif (bookindex == 4) then
        ZhiZun()
    end
end

function ChuJi()

    if (IsSkillActived(SkillID) <= 0) then
        if (DelNormalItem(6, 1, T_Book[1].id[3], 0) > 0) then
            ActiveNewBirthSkill(SkillID)
            Msg2Player("¹§Ï²Äú³É¹¦¼¤»îÁË¼¼ÄÜ!")
            WriteLog("[Ê¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò][¼¤»î¼¼ÄÜ]")
            return
        else
            Talk(1, "no", "ThËt xin lçi,¼¼ÄÜÊé¿Û³ıÊ§°Ü, Î´ÄÜ¼¤»î¼¼ÄÜ.")
            WriteLog("[Ò»ÎÅÇ§Îò³õ¼¶¼¼ÄÜÊé¿Û³ıÊ§°Ü]")
            return
        end
    end

    local nCurLevel = GetSkillLevel(SkillID)
    if (nCurLevel >= 3 and nCurLevel < 6) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖĞ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel >= 6 and nCurLevel < 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>¸ß¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel == 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖÁ×ğÒ»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    end

    if (nCurLevel == 1) then
        if (HaveNormalItem(6, 1, T_Book[1].id[3], 0) < 2) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>2<c>±¾³õ¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 2 do
                DelNormalItem(6, 1, T_Book[1].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 2]")
            return
        end
    elseif (nCurLevel == 2) then
        if (HaveNormalItem(6, 1, T_Book[1].id[3], 0) < 3) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>3<c>±¾³õ¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 3 do
                DelNormalItem(6, 1, T_Book[1].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("¹§Ï²Äú¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 3]")
            return
        end
    end
end

function ZhongJi()
    if (IsSkillActived(SkillID) <= 0) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜ»¹Î´¼¤»î, ÇëÊ¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò¼¼ÄÜÊé½øĞĞ¼¤»î.")
        return
    end

    local nCurLevel = GetSkillLevel(SkillID)
    if (nCurLevel < 3) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>³õ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel >= 6 and nCurLevel < 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>¸ß¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel == 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖÁ×ğÒ»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    end

    if (nCurLevel == 3) then
        if (HaveNormalItem(6, 1, T_Book[2].id[3], 0) < 1) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>1<c>±¾ÖĞ¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            DelNormalItem(6, 1, T_Book[2].id[3], 0)

            AddSkillLevel(SkillID, 1)
            Msg2Player("¹§Ï²Äú¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃÖĞ¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 4]")
            return
        end
    elseif (nCurLevel == 4) then
        if (HaveNormalItem(6, 1, T_Book[2].id[3], 0) < 2) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>2<c>±¾ÖĞ¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 2 do
                DelNormalItem(6, 1, T_Book[2].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃÖĞ¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 5]")
            return
        end
    elseif (nCurLevel == 5) then
        if (HaveNormalItem(6, 1, T_Book[2].id[3], 0) < 3) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>3<c>±¾ÖĞ¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 3 do
                DelNormalItem(6, 1, T_Book[2].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃÖĞ¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 6]")
            return
        end
    end
end
function GaoJi()
    if (IsSkillActived(SkillID) <= 0) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜ»¹Î´¼¤»î, ÇëÊ¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò¼¼ÄÜÊé½øĞĞ¼¤»î.")
        return
    end

    local nCurLevel = GetSkillLevel(SkillID)
    if (nCurLevel < 3) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>³õ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel >= 3 and nCurLevel < 6) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖĞ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel == 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖÁ×ğÒ»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    end

    if (nCurLevel == 6) then
        if (HaveNormalItem(6, 1, T_Book[3].id[3], 0) < 1) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>1<c>±¾¸ß¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            DelNormalItem(6, 1, T_Book[3].id[3], 0)

            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃ¸ß¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 7]")
            return
        end
    elseif (nCurLevel == 7) then
        if (HaveNormalItem(6, 1, T_Book[3].id[3], 0) < 2) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>2<c>±¾¸ß¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 2 do
                DelNormalItem(6, 1, T_Book[3].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃ¸ß¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 8]")
            return
        end
    elseif (nCurLevel == 8) then
        if (HaveNormalItem(6, 1, T_Book[3].id[3], 0) < 3) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>3<c>±¾¸ß¼¶Ò»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            for i = 1, 3 do
                DelNormalItem(6, 1, T_Book[3].id[3], 0)
            end
            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃ¸ß¼¶Ò»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 9]")
            return
        end
    end
end
function ZhiZun()
    if (IsSkillActived(SkillID) <= 0) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜ»¹Î´¼¤»î, ÇëÊ¹ÓÃ³õ¼¶Ò»ÎÅÇ§Îò¼¼ÄÜÊé½øĞĞ¼¤»î.")
        return
    end

    local nCurLevel = GetSkillLevel(SkillID)
    if (nCurLevel < 3) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>³õ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel >= 3 and nCurLevel < 6) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>ÖĞ¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    elseif (nCurLevel >= 6 and nCurLevel < 9) then
        Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>¸ß¼¶Ò»ÎÅÇ§Îò<c>¼¼ÄÜÊé½øĞĞÉı¼¶.")
        return
    end

    if (nCurLevel == 9) then
        if (HaveNormalItem(6, 1, T_Book[4].id[3], 0) < 1) then
            Talk(1, "no", "Ä¿Ç°¼¼ÄÜµÈ¼¶" .. nCurLevel .. "¼¶, ĞèÒªÊ¹ÓÃ<c=g>1<c>±¾ÖÁ×ğÒ»ÎÅÇ§Îò½øĞĞÉı¼¶,Ä¿Ç°¼¼ÄÜÊé²»×ãÎŞ·¨Éı¼¶.")
            return
        else
            DelNormalItem(6, 1, T_Book[4].id[3], 0)

            AddSkillLevel(SkillID, 1)
            Msg2Player("Chóc mõng ngµi, ¼¼ÄÜµÈ¼¶ÌáÉıÁË!")
            WriteLog("[Ê¹ÓÃÖÁ×ğÒ»ÎÅÇ§Îò][Éı¼¶ÖÁ cÊp 10]")
            return
        end
    end
end
function no()
    CloseDialog()
end

--description: “© ¶¥Û¿Ò∞¸.lua
--author: yaoxin
--date: 2009/11/19

function main()
    -- π”√∫Û◊‘º∫…æµÙ£¨≈‰÷√¿Ô≈‰
    --DelNormalItem(6,1,768,0)
    local r = random(1, 100)
    if (r <= 80) then
        EarnBind(100000)
        Msg2Player("Bπn nhÀn Æ≠Óc 10 vπn bπc kh„a")
        WriteLog("TÛi quµ D≠Óc S≠ 10 vπn bπc kh„a")
    elseif (GetLevel() >= 60) and (r <= 82) then
        AddNormalItem(8, 1134, 2, 0, 0, 0)--–°ªÓÃÂµ§
        Msg2Player("Bπn nhÀn Æ≠Óc Ti”u Hoπt Th” ß¨n")
        WriteLog("TÛi quµ D≠Óc S≠ Ti”u Hoπt Th” ß¨n")
    else
        EarnBind(200000)
        Msg2Player("Bπn nhÀn Æ≠Óc 20 vπn bπc kh„a")
        WriteLog("TÛi quµ D≠Óc S≠ 20 vπn bπc kh„a")
    end

    Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> hÂi hÈp mÎ TÛi quµ D≠Óc S≠.")
end;

function no()
    CloseDialog()
end;
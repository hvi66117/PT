--description: ×¼ÌáµÀÈË
--author: xiakun
--date: 2005/7/5

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local t = GetPK()
    local str = "Ng­¬i cã thÓ lËp tøc rêi Khai Minh ®¶o, cã muèn t×m hiÓu Khai Minh ®¶o kh«ng?"
    local mt = 0
    if (t > 0) then
        str = "Ng­¬i hiÖn cÇn"
        if (t <= 33) then
            mt = t
        elseif (t <= 87) then
            mt = (t - 33) * 2 + 33
        elseif (t <= 517) then
            mt = (t - 87) * 4 + (87 - 33) * 2 + 33
        else
            mt = (t - 517) * 8 + (517 - 87) * 4 + (87 - 33) * 2 + 33
        end
        local h = floor(mt / 60)
        local m = mt - h * 60
        if (h > 0) then
            str = str .. h .. "giê"
        end
        if (m == 0) then
            str = str .. "."
        else
            str = str .. m .. "m"
        end
        str = str .. "TÈy s¹ch lÖ khİ cña ng­¬i, ng­¬i muèn t×m hiÓu vÒ quy chÕ cña Khai Minh ®¶o kh«ng?"
    end
    MsgBox(str, "yes", "no")
end;

function yes()
    Talk(1, "no", 13838)
end

function no()
    CloseDialog()
end;

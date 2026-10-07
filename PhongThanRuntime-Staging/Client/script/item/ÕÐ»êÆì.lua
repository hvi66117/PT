function main()
    if (GetTeam() < 3) then
        MsgBox(13187, "startversion", "no")
    else
        startversion()
    end
end;

function startversion()
    if (HaveNormalItem(6, 1, 176, 1) >= 1) then
        local mapid, px, py = GetExactWorldPos()
        if (mapid ~= 1) and (mapid ~= 71) and (mapid ~= 2) and (mapid ~= 3) and (mapid ~= 4) and (mapid ~= 21) and (mapid ~= 20) and (mapid ~= 52) and (mapid < 99) and (mapid ~= 57) and (mapid ~= 64) then
            local i = math.random(515, 518)
            AddNpc(i, 30, SubWorld, px, py)
            DelNormalItem(6, 1, 176, 1)
            Talk(2, "no", 13188, "Yªu qu¸i! H·y gi¸c ngé ®i! Ta ®Õn ®©y ®Ó gi¶i cøu nh÷ng oan hån ®ã!")
        else
            Talk(1, "no", 13189)
        end ;
    else
        Talk(1, "no", 13190)
    end
end;

function no()
    CloseDialog()
end;





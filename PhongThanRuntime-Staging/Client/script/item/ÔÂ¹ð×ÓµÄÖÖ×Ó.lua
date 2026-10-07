Task_PrepareMaterial = 1049;
function main()
    local mapid, x, y = GetWorldPos()
    if (GetTask(Task_PrepareMaterial) == 9) then
        if (mapid ~= 32) then
            AddNormalItem(6, 1, 276, 1, 0, 0)
            TopMessage(13183)
            Msg2Player("Ph¶i ë Ngäc TuyÒn B¨ng Xuyªn míi cã thÓ trång!")
            return
        end
        local nProb = math.random(1, 2)
        if (nProb == 1) then
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(578, 0, SubWorld, (x + 1) * 32, (y) * 32)
            SetNpcName(newnpcidx, GetName() .. "_QuÕ")
            SetNpcScript(newnpcidx, "\\script\\item\\ÔÂ¹ð×Ó.lua")
            TopMessage(13184)
            Msg2Player("Gieo h¹t QuÕ ®· thµnh c«ng.")
        else
            TopMessage(13185)
            Msg2Player("Gieo h¹t QuÕ thÊt b¹i.")

        end
        return
    end
    TopMessage(13186)
    Msg2Player("B¹n kh«ng cã nhiÖm vô liªn quan.")
    AddNormalItem(6, 1, 276, 1, 0, 0)
end

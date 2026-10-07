require("common.luax")
mapname = COMMON.GLOBALMAPNAME

function main()
    if (GetFreeNpcCount() >= 100) then
        yes1()
    else
        Talk(1, "no", "非常抱歉, 吸魂幡设置失败,  请稍后再试.")
        AddNormalItemPile(6, 1, 1769, 0, 0, 0)
    end
end;

function no()
    CloseDialog()
end;

function yes1()
    CloseDialog()
    local LastTime = GetTask(969)
    local NowTime = SystemTime()
    if (NowTime > (LastTime + 200)) or (GetTask(966) == 0) then
        local mapid, px, py = GetWorldPos()
        local r = math.random(2, 5)
        local npcidx = AddNpc(549 + r, 1, SubWorld, px * 32, py * 32)
        if (npcidx > 0) then
            SetNpcName(npcidx, "吸魂阵")
            SetTask(966, mapid)
            SetTask(967, px)
            SetTask(968, py)
            if (mapid > 99) then
                Msg2Player("你吸魂阵出现了")
            else
                Msg2Player("你将吸魂幡放置在" .. mapname[mapid] .. ", 吸魂阵出现了")
            end
            TopMessage(13240)
            AddIBBuff(260 + r)
            SetTask(969, SystemTime())
        else
            Talk(1, "no", "非常抱歉, 吸魂幡设置失败,  请稍后再试.")
            AddNormalItemPile(6, 1, 1769, 0, 0, 0)
        end
    elseif (NowTime <= (LastTime + 200)) then
        Msg2Player("你已将吸魂幡放置在" .. mapname[GetTask(966)] .. ", 200秒内只能放置 1 c竔 吸魂幡")
        TopMessage("200秒内只能放置 1 c竔 吸魂幡")
        AddNormalItemPile(6, 1, 1769, 0, 0, 0)
    end ;
end;

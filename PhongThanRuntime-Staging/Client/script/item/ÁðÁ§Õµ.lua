TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

NPCID = 987
BUFF_ID = 658

function main(l, t, TargetNpcIndex)

    if (GetTaskByte(TASK_JIANGSHAN, 1) == 1) then
        local status1 = GetTaskByte(TASK_JS_BOOK2, 2)
        local status2 = GetTaskByte(TASK_JS_BOOK2, 3)
        local js_n = GetTaskByte(TASK_JS_BOOK2, 1)

        if (status1 == 1) then
            js_yjsh()
        elseif (status1 == 3) then
            js_hx(TargetNpcIndex)
        end

        js_n = GetTaskByte(TASK_JS_COUNT, 1)
        if (status2 == 3) then
            if (js_n == 0) then
                js_xr(TargetNpcIndex)
            elseif (js_n == 1) then
                Msg2Player("Truy b¾t hoµn thµnh, ®Õn gÆp D­ Kh¸nh tr¶ nhiÖm vô")
            end
        elseif (status2 == 6) then
            if (js_n == 0) then
                js_ly(TargetNpcIndex)
            elseif (js_n == 1) then
                Msg2Player("Truy b¾t hoµn thµnh, ®Õn gÆp D­ Kh¸nh tr¶ nhiÖm vô")
            end
        end
    end

end

function js_yjsh()

    local w, x, y = GetWorldPos()

    if ((w ~= 27) and (w ~= 28)) then
        return
    end

    if (HaveIBBuff(BUFF_ID) > 0) then
        Msg2Player("DÉn Hån trËn ®· cã, chØ ®­îc ®ång thêi ®Æt 1 DÉn Hån trËn")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("ChØ sö dông ®¹o cô ë ngoµi thµnh")
        return
    end

    local js_n = GetTaskByte(TASK_JS_BOOK2, 1)
    if (js_n == 9) then
        Msg2Player("§· cã ký øc, vÒ t×m D­ Kh¸nh tr¶ nhiÖm vô")
        return
    end

    local newnpcidx = AddNpc(NPCID, 1, SubWorld, (x + 1) * 32, (y) * 32)
    AddIBBuff(BUFF_ID)
    SetTask(TASK_ITEM_IDX, newnpcidx)
    SetNpcTask(newnpcidx, 0, GetPlayerID())
    SetTaskByte(TASK_JS_BOOK2, 1, 0)
    TaskNote(1056, 0, 0)

    Msg2Player("Sö dông DÉn Hån trËn")
end

function js_hx(idx)

    local w, x, y = GetWorldPos()

    if ((w ~= 29) and (w ~= 30)) then
        return
    end

    if (idx == 0) then
        Msg2Player("ChØ chuét vµo Háa Tµ míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local tmpnpcid = GetNpcTemplateID(idx)
    if (tmpnpcid ~= 35 and tmpnpcid ~= 2090) then
        Msg2Player("ChØ chuét vµo Háa Tµ míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local npcchr = GetHardNpcAttrib(idx)
    if ((npcchr < 0) or (npcchr > 7)) then
        Msg2Player("ChØ b¾t Háa Tµ tinh anh Xanh")
        return
    end

    if ((GetNpcLife(idx) / GetNpcLifeMax(idx) * 100 > 50) or (GetNpcLife(idx) / GetNpcLifeMax(idx) * 100 < 25)) then
        Msg2Player("ChØ ®­îc b¾t khi Háa Tµ cßn nöa m¸u")
        return
    end

    setmotion(1, idx)
end

function js_xr(idx)

    local w, x, y = GetWorldPos()

    if ((w ~= 33) and (w ~= 34)) then
        return
    end

    if (idx == 0) then
        Msg2Player("ChØ chuét vµo Hµ Nh©n míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local tmpnpcid = GetNpcTemplateID(idx)
    if (tmpnpcid ~= 36 and tmpnpcid ~= 2096) then
        Msg2Player("ChØ chuét vµo Hµ Nh©n míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local npcchr = GetHardNpcAttrib(idx)
    if ((npcchr < 0) or (npcchr > 7)) then
        Msg2Player("ChØ b¾t Hµ Nh©n tinh anh Xanh")
        return
    end

    if (GetNpcLife(idx) / GetNpcLifeMax(idx) * 100 > 50) then
        Msg2Player("ChØ ®­îc b¾t khi Hµ Nh©n cßn nöa m¸u")
        return
    end

    setmotion(2, idx)
end

function js_ly(idx)

    local w, x, y = GetWorldPos()

    if ((w ~= 34) and (w ~= 35)) then
        return
    end

    if (idx == 0) then
        Msg2Player("ChØ chuét vµo L©n Yªu míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local tmpnpcid = GetNpcTemplateID(idx)
    if (tmpnpcid ~= 39 and tmpnpcid ~= 2091) then
        Msg2Player("ChØ chuét vµo L©n Yªu míi cã thÓ x¸c ®Þnh môc tiªu")
        return
    end

    local npcchr = GetHardNpcAttrib(idx)
    if ((npcchr < 0) or (npcchr > 7)) then
        Msg2Player("ChØ b¾t L©n Yªu tinh anh Xanh")
        return
    end

    if (GetNpcLife(idx) / GetNpcLifeMax(idx) * 100 > 50) then
        Msg2Player("ChØ ®­îc b¾t khi L©n Yªu cßn nöa m¸u")
        return
    end

    setmotion(2, idx)
end

function setmotion(n, idx)
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)

    if (n == 1) then
        BeginMotion(idx, 1, 4, "\\script\\motion\\½­É½ÒÀ¾É1.lua", nInterrupt)
    elseif (n == 2) then
        BeginMotion(idx, 1, 4, "\\script\\motion\\½­É½ÒÀ¾É2.lua", nInterrupt)
    end
end

Buff_id = 626;
Npc_id = 919;
Task_id = 1358;

Time_id = 1359;
Idx_danfang = 1360;
ID_danfang = 1361;

function main()

    local status = GetTaskByte(Task_id, 1)
    local thistime = GetTask(Time_id)
    local thisday = math.floor(LocalSystemTime() / 86400)
    if ((status <= 3) and (thisday <= thistime)) then
        Talk(1, "no", "Háa HÇu h«m nay ®· ®ñ, sau khi qua <c=g>Giê Tı<c> ®ªm nay h·y ®Õn.")
        TaskNote(1036, 3)
        return
    end

    local w, x, y = GetWorldPos()
    if (w ~= 74) then
        Msg2Player("VËt phÈm nµy chØ cã thÓ sö dông t¹i BÊt Chu s¬n.")
        return
    end

    if (GetFightState() == 0) then

        Msg2Player("Ngoµi thµnh míi cã thÓ sö dông!")
        return
    end

    local idx = GetTask(Idx_danfang)
    if (idx ~= 0) and (GetNpcID(idx) == GetTask(ID_danfang)) then
        Talk(1, "no", GetName() .. " VŞ TÕ L­ ®· ®­îc gäi ra, kh«ng cÇn gäi l¹i.")
    else

        if ((status >= 1) and (status <= 3)) then
            MsgBox("Muèn luyÖn thÇn ®¬n, cÇn cã ®ñ vËt liÖu, linh khİ <c=g>Phong thó s¬n hån<c> trªn BÊt Chu S¬n lµ vËt liÖu tèt nhÊt, sau khi triÖu ra <c=g>VŞ TÕ L­<c>. NÕu trong <c=g>30 phót<c> tiªu diÖt <c=g>40<c> Phong thó s¬n hån bªn ®èi ®Şch, linh khİ S¬n hån sÏ hÊp thô vµo ng­¬i, th× sÏ ®ñ vËt liÖu cho ngµy h«m nay! B¾t ®Çu chø?", "addDanFang", "no")
        elseif (status == 4) then
            Talk(1, "no", "Háa HÇu ®· ®Õn, vÒ t×m <c=g>S¬n ThÇn Hång B¸c<c> phôc mÖnh!")
        elseif (status == 6) then
            MsgBox("Ph­¬ng ph¸p luyÖn <c=g>Hoµng Lé ®¬n<c> rÊt ®¬n gi¶n, sau khi triÖu ra <c=g>VŞ TÕ L­<c>, trong tr¹ng th¸i <c=g>täa thiÒn<c> (Ên phİm\"v\") sö dông Hoµng Lé ®¬n lµ ®­îc, luyÖn ®¬n gåm 5 l­ît, mçi l­ît sÏ cã <c=g>Sİ Nha<c> ®Õn tËp kİch, tiªu diÖt chóng cã thÓ tiÕp tôc luyÖn ®¬n. B©y giê ng­¬i muèn triÖu gäi kh«ng?", "addDanFang", "no")
        else
            SetTaskByte(Task_id, 1, 6)
            MsgBox("Ph­¬ng ph¸p luyÖn <c=g>Hoµng Lé ®¬n<c> rÊt ®¬n gi¶n, sau khi triÖu ra <c=g>VŞ TÕ L­<c>, trong tr¹ng th¸i <c=g>täa thiÒn<c> (Ên phİm\"v\") sö dông Hoµng Lé ®¬n lµ ®­îc, luyÖn ®¬n gåm 5 l­ît, mçi l­ît sÏ cã <c=g>Sİ Nha<c> ®Õn tËp kİch, tiªu diÖt chóng cã thÓ tiÕp tôc luyÖn ®¬n. B©y giê ng­¬i muèn triÖu gäi kh«ng?", "addDanFang", "no")
        end

    end

end

function addDanFang()
    CloseDialog()

    if (GetFightState() == 0) then
        return
    end

    local w, x, y = GetWorldPos()
    local newnpcidx = AddNpc(Npc_id, 10, SubWorld, (x + 1) * 32, (y) * 32)

    if (newnpcidx <= 0) then
        return
    end

    TopMessage("§· triÖu gäi <c=g>VŞ TÕ L­<c>")
    Msg2Player("§· triÖu gäi VŞ TÕ L­, ë vŞ trİ (" .. (math.floor(x / 8)) .. "," .. math.floor((y / 16)) .. ").")
    SetTaskByte(Task_id, 3, 1)

    SetTask(Idx_danfang, newnpcidx)
    SetTask(ID_danfang, GetNpcID(newnpcidx))
    SetNpcName(newnpcidx, GetName() .. "_ VŞ TÕ L­")
    SetNpcScript(newnpcidx, "\\script\\²»ÖÜÉ½\\µ¤·¿.lua")
    SetNpcTask(newnpcidx, 0, GetPlayerID())

    local status = GetTaskByte(Task_id, 1)
    if ((status >= 1) and (status <= 3)) then

        SetTaskByte(Task_id, 2, 0)

        RemoveIBBuff(Buff_id)
        AddIBBuff(Buff_id)
        SetNpcTimer(newnpcidx, "\\script\\ontimer\\µ¤·¿1.lua", 30 * 60)
        TaskNote(1036, 1, 0)
    elseif (status == 6) then
        SetNpcTimer(newnpcidx, "\\script\\ontimer\\µ¤·¿2.lua", 10 * 60)
        TaskNote(1036, 7, 0)
    end

end

function no()
    CloseDialog()
end

--description: ·üôËºóÈË
--author: zhaoqingsong
--date: 2009-6-22

-- 1Byte£º0Î´½Ó¡¢1µÃµ½ÐÞÐÐÊ¦Ö¸Òý¡¢2´ò¿ª´«ËÍÃÅ¡¢3´«ËÍµ½½ª×ÓÑÀ´¦
--        4»ñµÃ½ª×ÓÑÀµÀ¾ßºÓÍ¼ÂåÊé¡¢5Ó¤Áé±äÉíÊ§Ð§¡¢6»Ö¸´±¾Éí¡¢7¼¤»îÁË·¨Öù¡¢8Õ÷·þ·üôË¡¢10Íê³É
Task_YinGuoLunHui = 1489
Task_LunHui_Time = 1490

Conf_LH_Npc_Trap = 1146
Conf_LH_Npc_Soul = 468
Conf_LH_Npc_Penstock = 1144
Conf_LH_Npc_FXDialog = 1142
Conf_LH_Npc_FXFight = 1143

Conf_LH_Npc_Self = {
    [0] = { [0] = 1147, [1] = 1148 }, --¼×Ê¿
    [1] = { [0] = 1149, [1] = 1150 }, --µÀÊ¿
    [2] = { [0] = 1151, [1] = 1152 }, --ÒìÈË
}

Conf_LH_Buff_A = 717    -- ´«ËÍ
Conf_LH_Buff_B = 718    -- ±äÉí
Conf_LH_Buff_C = 719    -- ·üôË¶Ô»°
Conf_LH_Buff_D = 720    -- ·üôËÕ½¶·
Conf_LH_Buff_E = 721    -- ·¨Öù

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --¼×Ê¿
    [1] = { task = 1, note = 87 }, --µÀÊ¿
    [2] = { task = 2, note = 88 }, --ÒìÈË
}

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local ownerPlayerID = GetNpcTask(DialogNpcIdx, 1)
    if (ownerPlayerID == GetPlayerID() and HaveIBBuff(Conf_LH_Buff_C) > 0) then
        SetTask(142, DialogNpcIdx) --±£´æÍæ¼Ò¶Ô»°µÄIdx£¬´Ë´¦ÓÃ³ÇÃÅµÄ±äÁ¿£¬²»»áÓÐ³åÍ»
        Talk(3, "changeBody", "ThËt kh«ng ngê ng­¬i vÉn cßn sèng, haha, c¶m gi¸c bÞ nhèt trong ®ã thÕ nµo h¶ vÞ anh hïng cña ta!", "Cuèi cïng ta ®· t×m thÊy ng­¬i, tªn bØ æi, ng­¬i chí cã ®¾c chÝ véi, h·y xem ta thu phôc ng­¬i ®©y!", "Ng­¬i thËt lµ kh«ng biÕt trêi cao ®Êt dÇy! L·o phu ta bÞ giam cÇm n¬i ®©y ®· h¬n ngh×n n¨m, cuèi cïng ta ®· ®­îc tù do råi, hahaha, h«m nay ng­¬i sÏ lµ vËt tÕ lÔ cña ta!")
    else
        Talk(1, "no", "B¹n trÎ, ng­¬i nhÇm ng­êi råi, ta kh«ng ph¶i lµ tªn bØ æi mµ ng­¬i ®ang t×m kiÕm!")
    end

end

function changeBody()
    CloseDialog()
    if (HaveIBBuff(Conf_LH_Buff_C) == 0) then
        Talk(1, "no", "HËu nh©n Phôc Hy ®· biÕn mÊt!")
        return
    end
    local dialogNpcIdx = GetTask(142)
    local id, x, y = GetNpcWorldPos(dialogNpcIdx)
    DelNpc(dialogNpcIdx)
    local newidx = AddNpc(Conf_LH_Npc_FXFight, 65, SubWorld, x * 32, y * 32)
    if (newidx > 0) then
        SetNpcScript(newidx, "\\script\\¹ÖÎï\\·üôËºóÈË.lua")
        SetNpcTimer(newidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 5)
        SetNpcTask(newidx, 1, GetPlayerID())
        SetNpcName(newidx, "<c=g>" .. GetName() .. "TriÖu håi hËu nh©n cña Phôc Hy <c>")
        RemoveIBBuff(Conf_LH_Buff_C)
        AddIBBuff(Conf_LH_Buff_D, 60 * 5)
        TopMessage("HËu nh©n Phôc Hy ®· ph¸t ®éng tÊn c«ng!")
        Msg2Player("HËu nh©n Phôc Hy ®· ph¸t ®éng tÊn c«ng!")
    end
end

function no()
    CloseDialog()
end
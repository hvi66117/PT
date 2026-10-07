--description: Òò¹ûÂÖ»Ø ´«ËÍÃÅ
--author: zhaoqingsong
--date: 2009-6-22

-- 1Byte£º0Î´½Ó¡¢1µÃµ½ĞŞĞĞÊ¦Ö¸Òı¡¢2´ò¿ª´«ËÍÃÅ¡¢3´«ËÍµ½½ª×ÓÑÀ´¦
--        4»ñµÃ½ª×ÓÑÀµÀ¾ßºÓÍ¼ÂåÊé¡¢5Ó¤Áé±äÉíÊ§Ğ§¡¢6»Ö¸´±¾Éí¡¢7¼¤»îÁË·¨Öù¡¢8Õ÷·ş·üôË¡¢10Íê³É
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
    tasks = {
        { "Nh©n qu¶ lu©n håi", "transform"; show = 0 }
    }
    if (isViewTransform() == 1) then
        tasks[1].show = 1
        SetTask(142, DialogNpcIdx) --±£´æÍæ¼Ò¶Ô»°µÄIdx£¬´Ë´¦ÓÃ³ÇÃÅµÄ±äÁ¿£¬²»»áÓĞ³åÍ»
    end
    SayTask("Thêi kh«ng biÕn ®æi, ThÕ dŞch thêi di, nh©n qu¶ lu©n håi!", tasks)
end;

function isViewTransform()
    local ownerPlayerID = GetNpcTask(DialogNpcIdx, 1)
    if (ownerPlayerID == GetPlayerID() and HaveIBBuff(Conf_LH_Buff_A) == 1) then
        return 1
    end
    return 0
end

function transform()
    local taskYinGuoLunHui = GetTaskByte(Task_YinGuoLunHui, 1)
    local dialogNpcIdx = GetTask(142)
    local npcTemplate = GetNpcTemplateID(dialogNpcIdx)
    if (HaveIBBuff(Conf_LH_Buff_A) == 0 or npcTemplate ~= Conf_LH_Npc_Trap) then
        Talk(1, "no", "Cöa chuyÓn tiÕp: ChuyÓn tiÕp thÊt b¹i!")
        return
    end
    DelNpc(dialogNpcIdx)
    RemoveIBBuff(Conf_LH_Buff_A)
    if (taskYinGuoLunHui == 2) then
        SetTaskByte(Task_YinGuoLunHui, 1, 3)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 40)
        AddIBBuff(Conf_LH_Buff_B, 60 * 30)
        PolyMorph(Conf_LH_Npc_Soul, 1, 0, -1, 60 * 30)
    end
    NewWorld(61, 1586, 3227)
    TopMessage("§­îc chuyÓn ®Õn n¬i ë Kh­¬ng Tö Nha lóc nhá")
    Msg2Player("§­îc chuyÓn ®Õn n¬i ë Kh­¬ng Tö Nha lóc nhá")
end;

function no()
    CloseDialog()
end;

--description: Òò¹ûÂÖ»Ø±¾Éí
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
    local ownerPlayerID = GetNpcTask(DialogNpcIdx, 1)
    if (ownerPlayerID == GetPlayerID()) then
        if (GetMorphType() ~= Conf_LH_Npc_Soul) then
            Talk(1, "no", GetNpcName(DialogNpcIdx) .. "ChØ cã trong tr¹ng th¸i anh linh míi cã thÓ khiÕn linh hån vµ nhôc thÓ b¶n th©n hîp nhÊt! HiÖn ng­¬i ch­a cã tr¹ng th¸i anh linh, h·y ®i t×m Kh­¬ng Tö Nha lóc nhá gióp ®ì ®i!")
            return
        end
        DelNpc(DialogNpcIdx)
        PolyMorph(-1, 0, 0, 0, 0)
        SetTaskByte(Task_YinGuoLunHui, 1, 6)
        SetTaskByte(Task_YinGuoLunHui, 3, 0)
        TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 43)
        RemoveIBBuff(Conf_LH_Buff_B)
        TopMessage("Anh linh vµ nhôc thÓ cña ng­¬i ®· hîp nhÊt råi")
        Msg2Player("Anh linh vµ nhôc thÓ cña ng­¬i ®· hîp nhÊt råi!")
    else
        Talk(1, "no", GetNpcName(DialogNpcIdx) .. " §©y kh«ng ph¶i lµ nhôc thÓ do ng­¬i t×m kiÕm!")
    end
end;

function no()
    CloseDialog()
end;

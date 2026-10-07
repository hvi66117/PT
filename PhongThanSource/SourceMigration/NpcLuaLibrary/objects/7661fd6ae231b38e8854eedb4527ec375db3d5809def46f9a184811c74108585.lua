--Ä§ÑæÁéÊŞ.lua
--author:GaoJingWei
--Date:2009/08/06

--AS GaoJingwei 090806
--AS GaoJingwei 090806
Task_Wedlock = 1527        --1byte 1½ÓÈÎÎñ 2×¼±¸µãÁÁÍ¼ÌÚ 3µãÁÁËùÓĞÍ¼ÌÚ 4µçÁÁÍ¼ÌÚÊ§°Ü 5Á«±Ì´¦½»ÈÎÎñ 6ÁìÈ¡²É»¨ÈÎÎñ£¬7µÃµ½µÃµ½ÃÎÀï»¨ 8²ÉÒ©ÀÏÈË 9·ûÓ¡Ê¦
--2byteµãÁÁµÚ¼¸×éÍ¼ÌÚ 3byteµãÁÁµÚ¼¸¸öÍ¼ÌÚ
Task_Active_Totem = 1528   --¿ªÆôµãÁÁÍ¼ÌÚÈÎÎñµÄÊ±¼ä

TIME_DEFINE = 3                --Í¼ÌÚÁÁÆğµÄÊ±¼ä
BUFFID = 762                --BUFFµÄID

QuestkeyStone = 266            --ÈıÉúÊ¯
QuestkeyFire = 268            --¼ÇÒäÖ®»ğ
Questkeyflower = 267        --ÃÎÀï»¨
HoneyGirl = 1214                --ÓĞÔµÈË

TaskNoteIndex = 1092

TotemInfo = {
    [1] = { name = "VËt tæ Th©n T×nh", templateID = 1216 },
    [2] = { name = "VËt tæ H÷u T×nh", templateID = 1217 },
    [3] = { name = "VËt tæ ¸i T×nh", templateID = 1218 },
    [4] = { name = "VËt tæ Cõu HËn", templateID = 1219 },
    [5] = { name = "VËt tæ ThÕ Tôc", templateID = 1220 }
}
--µãÁÁË³Ğò
TotemSequence = {
    [1] = { 4, 1, 5, 3, 2 },
    [2] = { 1, 5, 3, 2, 4 },
    [3] = { 3, 2, 5, 4, 1 },
    [4] = { 5, 4, 1, 2, 3 }
}

function OnDeath(npcIndex)

    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local w, x, y = GetWorldPos()
            if (GetTaskByte(Task_Wedlock, 1) == 6) and (w == 17) then

                if (IsHaveSpaceForTreasure(1) ~= 1) then
                    Talk(1, "no", "Hµnh trang kh«ng ®ñ trèng, xin s¾p xÕp råi quay l¹i tiÕp tôc nhiÖm vô.")
                else
                    SetTaskByte(Task_Wedlock, 1, 7)
                    AddEventItem(Questkeyflower)         --ÃÎÀï»¨
                    Msg2Player("B¹n nhËn ®­îc Méng Lı Hoa, cã thÓ t×m Ng­êi h¸i thuèc ë T©y Kú thØnh gi¸o!")
                    TopMessage("NhËn ®­îc Méng Lı Hoa")
                    TaskNote(TaskNoteIndex, 6)
                end

            end
        end

        PlayerIndex = oldPlayer
    else
        if (GetTaskByte(Task_Wedlock, 1) == 6) then

            if (IsHaveSpaceForTreasure(1) ~= 1) then
                Talk(1, "no", "Hµnh trang kh«ng ®ñ trèng, xin s¾p xÕp råi quay l¹i tiÕp tôc nhiÖm vô.")
            else
                SetTaskByte(Task_Wedlock, 1, 7)
                AddEventItem(Questkeyflower)         --ÃÎÀï»¨
                Msg2Player("B¹n nhËn ®­îc Méng Lı Hoa, cã thÓ t×m Ng­êi h¸i thuèc ë T©y Kú thØnh gi¸o!")
                TopMessage("NhËn ®­îc Méng Lı Hoa")
                TaskNote(TaskNoteIndex, 6)
            end
        end
    end ;

end

function no()
    CloseDialog()
end
--AE GaoJingwei 090806
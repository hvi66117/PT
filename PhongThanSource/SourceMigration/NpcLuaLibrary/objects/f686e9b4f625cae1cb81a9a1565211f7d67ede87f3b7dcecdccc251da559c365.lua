Task_Wedlock = 1527

Task_Active_Totem = 1528

TIME_DEFINE = 3
BUFFID = 762

QuestkeyStone = 266
QuestkeyFire = 268
Questkeyflower = 267
HoneyGirl = 1214

TaskNoteIndex = 1092

TotemInfo = {
    [1] = { name = "VËt tæ Th©n T×nh", templateID = 1216 },
    [2] = { name = "VËt tæ H÷u T×nh", templateID = 1217 },
    [3] = { name = "VËt tæ ¸i T×nh", templateID = 1218 },
    [4] = { name = "VËt tæ Cõu HËn", templateID = 1219 },
    [5] = { name = "VËt tæ ThÕ Tôc", templateID = 1220 }
}

TotemSequence = {
    [1] = { 4, 1, 5, 3, 2 },
    [2] = { 1, 5, 3, 2, 4 },
    [3] = { 3, 2, 5, 4, 1 },
    [4] = { 5, 4, 1, 2, 3 }
}

function OnDeath(npcIndex)

    if (GetTeam() ~= 0) then

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
                    AddEventItem(Questkeyflower)
                    Msg2Player("B¹n nhËn ®­îc Méng Lý Hoa, cã thÓ t×m Ng­êi h¸i thuèc ë T©y Kú thØnh gi¸o!")
                    TopMessage("NhËn ®­îc Méng Lý Hoa")
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
                AddEventItem(Questkeyflower)
                Msg2Player("B¹n nhËn ®­îc Méng Lý Hoa, cã thÓ t×m Ng­êi h¸i thuèc ë T©y Kú thØnh gi¸o!")
                TopMessage("NhËn ®­îc Méng Lý Hoa")
                TaskNote(TaskNoteIndex, 6)
            end
        end
    end ;

end

function no()
    CloseDialog()
end

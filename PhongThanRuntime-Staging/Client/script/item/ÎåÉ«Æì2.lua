Task_colorrenwu = 1355

function main(itemID)
    if (HaveIBBuff(831) ~= 0) then
        Talk(1, "no", "T¹m thêi b¹n kh«ng thÓ sö dông Ngò S¾c Kú.")
        return 0
    end
    if (GetTaskByte(Task_colorrenwu, 3) >= 1) then
        if (HaveIBBuff(569) == 0) then
            Talk(1, "no", "Hµo quang ngò s¾c ®· biÕn mÊt, kh«ng thÓ hoµn thµnh viÖc b¾t.")
            return 0
        end

        local j = 1
        for i = 224, 228 do
            if (HaveEventItem(i) >= 1) then
                j = j + 1
            end
        end

        local TargetNpcIdx = GetPlayerTarget()
        local npcTempId = GetNpcTemplateID(TargetNpcIdx)
        local key = GetTaskByte(Task_colorrenwu, 4)
        if (TargetNpcIdx == 0) or (npcTempId < 898 + 5 * (key - 1)) or (npcTempId > 902 + 5 * (key - 1)) then
            local item_name = { "Phong Yªu", "Sãi", "Phong thó s¬n hån", "HuyÕt Yªu" }
            Msg2Player("Lùa chän" .. item_name[key] .. " Hung thó ®èi øng .")
            return 0
        end

        local type = math.mod((npcTempId - 898), 5) + 1
        if (type ~= 2) then
            AddIBBuff(831)
            ScrollMessage("Lùa chän mµu cê chÝnh x¸c ®Ó b¾t!")
            Msg2Player("Kim méc thñy háa thæ thuéc tÝnh ngò hµnh t­¬ng øng lµ 5 lo¹i mµu s¾c tr¾ng xanh ®en ®á vµng, h·y c¨n cø vµo ph­¬ng thøc tÊn c«ng cña Hung thó mµ lùa chän mµu cê thÝch hîp tiÕn hµnh b¾t.")
        elseif (GetNpcLife(TargetNpcIdx) / GetNpcLifeMax(TargetNpcIdx) * 100 > 50) then
            ScrollMessage("Hung thó mÊt h¬n nöa m¸u míi b¾t ®­îc !")
            Msg2Player("Khi Hung thó mÊt h¬n nöa m¸u míi b¾t ®­îc.")
        else
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 0)
            nInterrupt = SetBit(nInterrupt, 4, 0)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)
            BeginMotion(type, 1, 3, "\\script\\motion\\²¶×½ÍÁ»ê½ø¶ÈÏìÓ¦.lua", nInterrupt)
        end
    end
end;

function no()
    CloseDialog()
end

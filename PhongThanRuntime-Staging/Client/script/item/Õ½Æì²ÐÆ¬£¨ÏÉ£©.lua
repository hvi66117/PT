JECT_TASK_STATE = 1291
JECT_TASK_FLAG_IDX = 1292
JECT_TASK_FLAG_ID = 1293
JECT_REQ_ITEM_COUNT = 1
JECT_REQ_ITEM_CLS = 3
JECT_REQ_ITEM_DET = 312
JECT_REQ_ITEM_NAME = "M¹n ch©u sa hoa"
JECT_LIMIT_LEVEL = 30
JECT_LIMIT_CREDIT = 15000
JECT_TYPE = 2
JECT_AWARD_CREDIT = 40
JECT_AWARD_IB = 3
JECT_EXTRA_ADD_CREDIT = 500

JECT_TASK_ACC_LEVEL = 1415
function main()

    if (GetTaskByte(JECT_TASK_STATE, 1) == 1) and (GetTaskByte(JECT_TASK_STATE, 2) == 1) then

        local nCount = HaveNormalItem(6, 1, 433, 1)
        if (nCount >= 5) then

            ClearItem(6, 1, 433, 1)
            AddNormalItem(3, 328, 0, 0, 0, 0, 0)
            SetTaskByte(JECT_TASK_STATE, 2, 2)

            local DustName = ""
            local nLevel = GetTaskByte(JECT_TASK_ACC_LEVEL, 1)
            if (nLevel == 0) then
                nLevel = GetPlayerExtLevel()
            end

            if (nLevel > 0) and (nLevel <= 10) then
                DustName = "Gß Hång Nª (Ma)"
            elseif (nLevel > 10) and (nLevel <= 20) then
                DustName = "Gß Viªm Sa (Ma)"
            elseif (nLevel > 20) and (nLevel <= 30) then
                DustName = "Gß XÝch Thæ (Ma)"
            elseif (nLevel > 30) and (nLevel <= 35) then
                DustName = "Gß Hång Nª (Ma)"
            elseif (nLevel > 35) and (nLevel <= 40) then
                DustName = "Gß Viªm Sa (Ma)"
            elseif (nLevel > 40) and (nLevel <= 50) then
                DustName = "Gß XÝch Thæ (Ma)"
            else
                DustName = "Gß XÝch Thæ (Ma)"
            end

            TaskNote(1021, 2, DustName)
            Talk(1, "no", "M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Tiªn giíi ChiÕn kú.")

        else

            Talk(1, "no", "Ph¶i cã ®ñ 5 m¶nh ChiÕn kú (Tiªn) míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")

        end

    else

        Talk(1, "no", "Ph¶i cã ®ñ 5 m¶nh ChiÕn kú (Tiªn) míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")

    end

end

function no()
    CloseDialog()
end;

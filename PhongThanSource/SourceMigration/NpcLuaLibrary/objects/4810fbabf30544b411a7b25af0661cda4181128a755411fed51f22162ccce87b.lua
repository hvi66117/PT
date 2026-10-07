require("福利活动模板.luax")
require("常用活动.luax")

function OnDeath(npcindex)
    if (npcindex == nil or npcindex < 0) then
        return
    end


end

function Activitie(npcidx)
    if (PlayerIndex <= 0) then
        return
    end

    if (Visible() <= 0) then
        return
    end

    if (GetLevel() < 65) then
        return
    end

    WelfareActivitie.ClearWelfareActivitieTask()

    if (HaveNormalItem(6, 1, 1257, 1) >= 1 or GetTaskBit(2013, 28) >= 1) then
        return
    end

    local buffid = 1767
    local timelong = 20
    local tasknoteid = 1950
    local levelmax = 30
    local nBuffLevel = 0

    if (UActivitie.AddMonster(npcidx, timelong, { 31 }) > 0) then

        if (HaveIBBuff(buffid) > 0 and GetIBBuffLeftTimes(buffid) > 0 and GetIBBuffLevel(buffid) < levelmax) then
            nBuffLevel = GetIBBuffLevel(buffid)
            if (RemoveIBBuff(buffid) > 0) then
                AddIBBuff(buffid, timelong, nBuffLevel + 1)
                NewTaskNote(tasknoteid, 0)
                TaskNote(tasknoteid, 0, (levelmax - nBuffLevel - 1))
            else
                WriteLog("朱雀buff移除失败")
            end
        else
            AddIBBuff(buffid, timelong, 0)
            NewTaskNote(tasknoteid, 0)
            TaskNote(tasknoteid, 0, (levelmax - nBuffLevel - 1))
        end

        if (GetIBBuffLevel(buffid) == levelmax) then
            RemoveIBBuff(buffid)
            TaskNote(tasknoteid, -1)
            SetTaskBit(2013, 28, 1)
            AddNormalItemBind(6, 1, 1257, 1, 0, 0, 1)
            Msg2Player("Ch骳 m鮪g ng礽 nh薾 頲 Chu Tc Chi Ch鴑g.")
            WriteLog("Nh薾 頲 Chu Tc Chi Ch鴑g")
        end
    end
end

function Visible()
    local _, v = Activity.FireEvent("NPC_DIALOG", 1, 1, "VISIBLE")
    return (v == true and 1 or 0)
end


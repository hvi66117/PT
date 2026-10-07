require("ÐþÎäÊÔÁ¶.luax")

EnterCheck = XUANWUSL.EnterCheck
RemainTimes = XUANWUSL.RemainTimes
EnterSL = XUANWUSL.EnterSL
EnterSLSure = XUANWUSL.EnterSLSure
DoEnter = XUANWUSL.DoEnter
ExitSL = XUANWUSL.ExitSL
ExitSLSure = XUANWUSL.ExitSLSure
SLExplain = XUANWUSL.SLExplain
SkillStone = XUANWUSL.SkillStone
SkillStone1 = XUANWUSL.SkillStone1
SkillStone2 = XUANWUSL.SkillStone2
SLExplain1 = XUANWUSL.SLExplain1
GetQuest = XUANWUSL.GetQuest
GetQuestEnter = XUANWUSL.GetQuestEnter
GetQuestSure = XUANWUSL.GetQuestSure
GiveUpQuest = XUANWUSL.GiveUpQuest
GiveUpQuestSure = XUANWUSL.GiveUpQuestSure
SayQuest = XUANWUSL.SayQuest
ClearQuest = XUANWUSL.ClearQuest
RandomQuest = XUANWUSL.RandomQuest
TaskCheck = XUANWUSL.TaskCheck
QuestList = XUANWUSL.QuestList
XuanwuQuest = XUANWUSL.XuanwuQuest
XuanwuQuesTime = XUANWUSL.XuanwuQuesTime
searchForIndex = XUANWUSL.searchForIndex
GetNpcTaskSatate = XUANWUSL.GetNpcTaskSatate
GetPlayerTaskState = XUANWUSL.GetPlayerTaskState
refreshNpcTaskState = XUANWUSL.refreshNpcTaskState

TrialMission = 27

Mapid = 86

XuanwuTrialTask = 2018

XuanwuTrial = 672

function GetPlayerTaskState()
    return 0, 0
end

function main()
end;

function out()
    CloseDialog()
    PlayerInOrOut(0, DialogNpcIdx)
end

function OnDeath(carriagenpcindex)
    local oldMap = SubWorld
    local Mapindex = SubWorldID2Idx(Mapid)
    SubWorld = Mapindex
    local Storeid = GetNpcTask(carriagenpcindex, 2)
    local deathPlayerID = GetNpcTask(carriagenpcindex, 1)
    local carriageindex = GetSiegeWeaponIndexByNpcIndex(carriagenpcindex)
    local oldplayerindex = PlayerIndex
    local guardindex = GetTGuardIndexByCarriageIndex(carriageindex)
    local _, _, _, DeathName, _, _, _ = GetTGuardInfo(guardindex)
    local nTemplateID = GetNpcTemplateID(carriagenpcindex)
    local MissionState = GetGlobalValueByte(XuanwuTrial, 1)
    DeathPlayerIndex = GetPlayerIndexByName(DeathName)
    if (MissionState ~= 3) then
        return
    end
    PlayerIndex = DeathPlayerIndex
    PlayerInOrOut(0, carriagenpcindex)
    SetCamp(7)
    PolyMorph(-1, 0, 0, 0, 0)
    SetFightState(0)

    RemoveSpecialSkill(1471, 2)
    RemoveSpecialSkill(1474, 2)
    SetClientRightSkill(0)
    SetClientLeftSkill(0)
    WriteLog("[ThÝ luyÖn HuyÒn Vò][" .. GetName() .. "][ÐþÎä±»»÷É±]")

    PlayerIndex = oldplayerindex
    ScrollMessage("»÷°ÜÐþÎäÖ®Ó°!")
    Msg2CurMapAnnounce(GetName() .. "·ÜÓÂ×÷Õ½, ½«Ò»ÃûÐþÎäÖ®Ó°»÷ÆÆ, ÒâÍâµÄ nhËn ®­îc 1 c¸i Ch©n-HuyÒn Vò B¶o R­¬ng!")
    SetMissionV(TrialMission, Storeid, 0)
    AddNormalItem(6, 1, 1277, 0, 0, 0, 1)
    TaskCheck(3)
    WriteLog("[ThÝ luyÖn HuyÒn Vò][" .. GetName() .. "][»÷É±ÐþÎä]")
    SubWorld = oldMap
    DeleteSiegeWeapon(carriageindex)
    CheckGameEnd(carriagenpcindex)
end

function no()
    CloseDialog()
end;

function CheckGameEnd(carriagenpcindex)
    local LifeFlag = 0
    local oldmapindex = SubWorld
    local idx = SubWorldID2Idx(Mapid)
    SubWorld = idx
    for i = 10, 13 do
        local carriagenpcindex = GetMissionV(TrialMission, i)
        if (carriagenpcindex > 0) then
            local CarHp = GetNpcLife(carriagenpcindex)
            if (CarHp > 0) then
                LifeFlag = 1
                break
            end
        end
    end

    if (LifeFlag == 0) then
        SetGlobalValueByte(XuanwuTrial, 3, 2)
        StopMissionTimer(TrialMission, 94)
        StartMissionTimer(TrialMission, 94, 18)
        Msg2CurMapAnnounce("¾­¹ýÓÂÊ¿ÃÇµÄ·ÜÓÂ×÷Õ½, ÐþÎäÖ®Ó°ÒÑ¾­±»È«²¿»÷°Ü!")

    end
    SubWorld = oldmapindex
end

function OnTimer(npcidx)
    local carriageindex = GetSiegeWeaponIndexByNpcIndex(npcidx)
    DeleteSiegeWeapon(carriageindex)
end

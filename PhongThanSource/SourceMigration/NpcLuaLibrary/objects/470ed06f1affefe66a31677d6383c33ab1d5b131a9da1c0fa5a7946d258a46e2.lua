------------------------------------ÐÇ¾ýÖ®Á¦---------------------------------------------
---------------------------------added by fengce at 2009.6.11 ---------------------------------
g_PowerStar = 1480                --1byte 1)Ë¢³önpc 2)¿ªÊ¼ÒÇÊ½  3)ÒÇÊ½½áÊø   4)ÈÎÎñÊ§°Ü     2byteÇ°ÍùÐÇ¾ýÎ»ÖÃµÄË÷Òý
g_AliveStar = 1481

g_Light1 = 218
g_Light2 = 219
g_Light3 = 220
g_Light4 = 221

g_BUFFSTARPOWER = 696   --ÐÇ¾ýÖ®Á¦
g_BUFFMOSTER = 698         --ÉÏ¹ÅÖ®ÉñÇ¿»¯
g_BUFFDEFEND = 697         --ÐÇ¾ý±Ó»¤
BUFF_STRAR = 695      --»½ÐÑÒÇÊ½BUFFºÅ
---------------------end---------------------------------
function OnDeath(npcindex)
    local lLightList = { g_Light1, g_Light2, g_Light3, g_Light4 }

    PlayerIndex = SearchPlayerById(GetNpcTask(npcindex, 0))
    if (GetTaskByte(g_PowerStar, 1) == 1 or GetTaskByte(g_PowerStar, 1) == 2) then
        RemoveIBBuff(BUFF_STRAR)
        ScrollMessage("NhiÖm vô thÊt b¹i")
        Msg2Player("NhiÖm vô thÊt b¹i")
        TopMessage("NhiÖm vô thÊt b¹i")
        SetTaskByte(g_PowerStar, 1, 4)

        TaskNote(110, 5)

        local nLightindex

        local nStarIndex = GetTaskByte(g_PowerStar, 2)

        SetNpcTask(GetGlobalValue(lLightList[nStarIndex]), 0, 0)

        for n = 1, getn(lLightList) do
            for j = 1, 4 do
                nLightindex = GetNpcTask(GetGlobalValue(lLightList[n]), j)   --ÈÎÎñÊ§°Ü£¬Ï¨ÃðËùÓÐµÄµÆ

                SetNpcTimer(nLightindex, "\\script\\ontimer\\µÆonTimer.lua", 2)
            end
        end
    end
    DelNpc(npcindex)
end


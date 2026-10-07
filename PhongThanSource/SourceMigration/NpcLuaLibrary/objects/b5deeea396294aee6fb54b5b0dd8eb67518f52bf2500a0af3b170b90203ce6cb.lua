--»ğÀëÑıÍõ.lua
--author£ºLaiyongcong
--date:2009/05/06

-------------ĞÇÃÎÆæÔµ,¹ÛĞÇÍ²Ö®ÃÕ Added by Laiyongcong 2009/05/04 start-----
star_dream = 1419            --ĞÇÃÎÆæÔµÈÎÎñ±äÁ¿£¬1Byte:ÈÎÎñ²½Öè,1½Óµ½ÈÎÎñ,2ÌáÊ¾ÕÒÒ½Éú£¬3È¡µÃĞÇÏóÍ¼£¬4»ÃÏñ³öÏÖ,5ÈÎÎñÍê³É£¬6È¡µÃÃÜĞÅ
--				   7½Óµ½¿½ÎÊÈÎÎñ£¬8¿½ÎÊ³É¹¦£¬9½Óµ½»ğÀëÑıÍõÈÎÎñ£¬10³É¹¦±£»¤ÁË»ğÀëÑıÍõÖ®»ê£¬11½Óµ½ÕÒ±ù»ğÄ§ÈÎÎñ£¬
--					12ÊÕ·ş±ù»ğÄ§£¬13ÈÎÎñÍê³É
--  2Byte£ºÉ±ËÀÎäÊ¿¹êµÄÊıÄ¿,»òÕßË®ÁáççµÄ³É¹¦¸ÅÂÊ
fireKingidx = 1420                --¼ÇÂ¼»ğÀëÑıÍõµÄidx
-------------ĞÇÃÎÆæÔµ£¬¹ÛĞÇÍ²Ö®ÃÕ Added by Laiyongcong 2009/05/04 end-----

function no()
    CloseDialog()
end;

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --¹ÛĞÇÍ²Ö®ÃÕ
    startLevel = 54
    if (GetLevel() >= startLevel) then
        local PID = GetNpcTask(DialogNpcIdx, 1)
        local step = GetTaskByte(star_dream, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (step == 9 and PID == 0) then
                state = 3
                subState = 0
            elseif (step == 10 and HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
                state = 3
                subState = 0
            elseif (step == 9 and PID == GetPlayerID()) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (step == 9 and PID == 0) then
                state = 3
                subState = 1
            elseif (step == 10 and HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
                state = 3
                subState = 1
            elseif (step == 9 and PID == GetPlayerID()) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end
--AE GaoJingwei 2009/08/02 

function main()
    local step = GetTaskByte(star_dream, 1)
    if (step < 9) then
        -------------------------Ã»ÓĞ½Óµ½ÈÎÎñ
        Talk(2, "no", "L·o Hå L«: *&(^(^(*&*^*&*(&(*(&(*(&(.", GetName() .. " …… Yªu qu¸i nµy m¸u ch¶y loang læ, thËt kú l¹!")

    elseif (step == 9) then
        local PID = GetNpcTask(DialogNpcIdx, 1)
        if (PID ~= 0 and PID ~= GetPlayerID()) then
            Talk(2, "no", "L·o Hå L«: .......", GetName() .. " Yªu qu¸i nµy d­êng nh­ ®ang tô hån ph¸ch, ta nªn theo dâi tr­íc råi nghÜ c¸ch øng phã sau!")
            return
        end
        if (PID == GetPlayerID()) then
            local hunidx = GetNpcTask(DialogNpcIdx, 2)
            if (GetNpcID(hunidx) == GetNpcTask(DialogNpcIdx, 3)) then
                --»ê»¹ÔÚ
                Talk(1, "no", "L·o Hå L«: &*^&*%**(^&*^*(^(&*(&*^&**(&**&&*&*^*.", GetName() .. " B¶o vÖ hån L·o Hå L« míi lµ th­îng s¸ch!")
            else
                Talk(2, "no", "L·o Hå L«: .......", GetName() .. " Yªu qu¸i nµy d­êng nh­ ®ang tô hån ph¸ch, ta nªn theo dâi tr­íc råi nghÜ c¸ch øng phã sau!")
            end
            return
        end
        Talk(3, "Helpme", "L·o Hå L«: &*^&*^&*^()*&(&*(^*&^*&^*^*&^&*!", GetName() .. "L·o Hå L« ®ang gÆp nguy, ta ph¶i b¶o vÖ hån ph¸ch cña h¾n chu toµn.")

    elseif (step == 10) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            --±³°üÂúµ¼ÖÂÈÎÎñÊ§°Ü
            Talk(1, "no", "Hµnh trang ®· ®Çy, h·y s¾p xÕp l¹i hµnh trang.")
            --TaskNote(1052,12)
            return
        end
        --ÈÎÎñ³É¹¦¡£
        if (HaveItemInAllRoom(4, 248, 0, 1, 0, 0, 0) == 0) then
            ClearItem(4, 248, 0, 1)
            AddNormalItem(4, 248, 0, 1, 0, 0)
            --------------------------------------------------Ìí¼ÓÈ¾ÑªµÄ×Ö¼£
            Msg2Player("B¹n nhËn ®­îc vÕt ch÷ nhuèm m¸u, vÕt ch÷ nhuèm m¸u, kh«ng nh×n râ ch÷, mau ®Õn thØnh gi¸o Tinh Quan ë T©y Kú.")
            TopMessage("B¹n nhËn ®­îc <c=g>vÕt ch÷ nhuèm m¸u<c>")
            Talk(2, "no", "L·o Hå L«: &*^&*%*&^*(&(&*(&(&(*&(!", GetName() .. " Yªu qu¸i nµy ®­a ta 1 bøc huyÕt th­, nh­ng h¾n nãi n¨ng khã hiÓu, ta ph¶i vÒ thØnh gi¸o Tinh Quan ë T©y Kú!")
            TaskNote(1052, 6)
            refreshNpcTaskState()
        else
            Talk(1, "no", "L·o Hå L«: &*^&*%*&^*(&(&*(&(&(*&(!")
        end

    else
        Talk(1, "no", "L·o Hå L«: *&(^(^(*&*^*&*(&(*(&(*(&(.")
    end
end;

function Helpme()
    CloseDialog()
    SetNpcTask(DialogNpcIdx, 1, GetPlayerID())
    SetTask(fireKingidx, DialogNpcIdx)

    local m, x, y = GetNpcWorldPos(DialogNpcIdx)
    local PID = GetPlayerID()

    local npcidx1 = AddNpc(993, 50, SubWorld, (x + 8) * 32, (y + 6) * 32)--------Ìí¼Ó»ğÀëÑıÍõÖ®»ê
    SetNpcTimer(npcidx1, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 50)
    SetNpcTask(npcidx1, 1, PID)
    SetNpcCamp(npcidx1, 0)--ÉèÖÃNPCÕóÓª

    local npcidx2 = AddNpc(994, 45, SubWorld, (x + 9) * 32, (y + 7) * 32) --ÂÌÉ«»ğÀëĞ¡Ñı1
    SetNpcTimer(npcidx2, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 30)
    SetNpcTask(npcidx2, 1, PID)
    SetNpcTarget(npcidx2, npcidx1)------Éè¶¨¹¥»÷Ä¿±ê

    --local npcidx3 = AddNpc(994,45,SubWorld,(x+7)*32,(y+7)*32) --ÂÌÉ«»ğÀëĞ¡Ñı2
    --SetNpcTimer(npcidx3,"\\script\\ontimer\\É¾µô×Ô¼º.lua", 50)
    --SetNpcTask(npcidx3,1,PID)
    --SetNpcTarget(npcidx3,npcidx1)

    --local npcidx4 = AddNpc(994,45,SubWorld,(x+7)*32,(y+5)*32) --ÂÌÉ«»ğÀëĞ¡Ñı3
    --SetNpcTimer(npcidx4,"\\script\\ontimer\\É¾µô×Ô¼º.lua", 50)
    --SetNpcTask(npcidx4,1,PID)
    --SetNpcTarget(npcidx4,npcidx1)

    SetNpcTimer(DialogNpcIdx, "\\script\\ontimer\\ÊÍ·Å»ğÀëÑıÍõ.lua", 60)--Ò»·ÖÖÓºóÊÍ·Å
    SetNpcTask(DialogNpcIdx, 2, npcidx1)
    ----------------------------------¶Ô»°»ğÀëÑıÍõÉíÉÏ¼ÇÂ¼±ğÕÙ»½³öµÄ»êidx
    SetNpcTask(DialogNpcIdx, 3, GetNpcID(npcidx1))------------------------ID

    AddIBBuff(659)
    -------------------------------------------------------------------------------------------------»ê·ÉÆÇÉ¢£¬30Ãë¼ÆÊ±
    TaskNote(1052, 11)

    Msg2Player("Hån L·o Hå L« ®· xuÊt hiÖn, ph¶i b¶o ®¶m an toµn cho nã kh«ng bŞ Hån Phi Ph¸ch T¸n.")
    ScrollMessage("Hån L·o Hå L« ®· xuÊt hiÖn, ph¶i b¶o vÖ nã an toµn.")
    refreshNpcTaskState()
end;

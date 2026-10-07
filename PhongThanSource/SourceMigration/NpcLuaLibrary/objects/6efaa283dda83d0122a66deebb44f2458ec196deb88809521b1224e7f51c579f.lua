--description: ¶þÀÉÉñ
--author: yichuan
--date: 2005/3/10
Task_zhong = 1588

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
--Add by fangjie for ¡¾ÌìÍ¥ÉñÄ¾¡¿ÈÎÎñ¿É½ÓÊ±¶þÀÉÉñÍ·¶¥Ã»ÓÐÈÎÎñ¾íÖáBug:fsb00039263 at2011-8-23 begin
--function GetPlayerTaskState()
--	return 0, 0
--end

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 35
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            state = 1
            subState = 0
        else
            state = 1
            subState = 1
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
--Add by fangjie for ¡¾ÌìÍ¥ÉñÄ¾¡¿ÈÎÎñ¿É½ÓÊ±¶þÀÉÉñÍ·¶¥Ã»ÓÐÈÎÎñ¾íÖáBug:fsb00039263 at2011-8-23 end
--AE GaoJingwei 2009/08/02 

-----------------------------------------add by zhangpu start
VALENTINE = 1682

--Modified by DuWen for 2011ÇéÈË½Ú begin
vnpc = {
    { "Th©n C«ng B¸o", "Ph©n Thñy T­íng Qu©n" },
    { "Na Tra", "Tóc §Ó Sinh Uy" },
    { "L«i ChÊn Tö", "SÝ Th¸p Phong V©n" },
    { "NhÞ Lang thÇn", "Tam Môc L­¬ng NhÜ" },
    { "TriÖu C«ng Minh", "NhËt NguyÖt Qu©n" },
    { "XÝch Tïng Tö", "Tr× Méc C«ng Tö" },
    { "BÝch Tiªu", "BÝch S¾c Cöu Thiªn" },
    { "Quúnh Tiªu", "Mü Ngäc V« H¹" },
    { "V©n Tiªu", "B¹ch V©n Vò Nghª" },
    { "ThÓ V©n", "ThÊt S¾c T­êng V©n" },
    { "Long C¸t", "Hång Loan Thiªn TuÕ" },
    { "Thä Tinh", "Tr­êng Sinh BÊt L·o" },
    { "Léc Tinh", "Kim B¶ng §Ò Danh" },
    { "Phóc Tinh", "C¸t T­êng Phó Quý" },
    { "TrÊn Nguyªn", "§Ønh §Þnh Cµn Kh«n" }
}
--Modified by DuWen for 2011ÇéÈË½Ú end
---------------------------------------add by zhangpu end

function main(sel)
    --Msg2Player("....")
    tasks = {
        { "Thiªn Thô", "renwu"; show = 0 },
        { "Thiªn thô", "zhishu"; show = 1 },
        { "H¹t May M¾n", "zhong"; show = 0 },
    }

    -------------------------------add by zhangpu start
    --Modified by DuWen for 2011ÇéÈË½Ú begin
    --local y,m,d = GetYMD()
    --if ( y == 2011 and m == 2 and d >=14 and d <= 16 ) then
    --	local ret = valentine()
    --	if ( ret == 1 ) then
    --		return --Èç¹ûÔÚÇéÈË½Ú»î¶¯ÖÐÇ°½øÒ»²½£¬Ôò²»µ¯³öÕý³£¹¦ÄÜ¿ò¡£
    --	end
    --end
    --Modified by DuWen for 2011ÇéÈË½Ú end
    -------------------------------add by zhangpu end
    if (GetLevel() >= 35) then
        tasks[1].show = 1
    end ;
    if (GetTask(Task_zhong) == 0) and (GetLevel() >= 60) then
        tasks[3].show = 1;
    end
    SayTask(11267, tasks)
end;

function no()
    CloseDialog()
end;

function zhong()
    CloseDialog()
    if (GetTask(Task_zhong) == 0) and (GetLevel() >= 60) then
        MsgBox("<c=g>D­¬ng Thóc<c> võa x©y dùng 1 n«ng trang míi ë Cù Léc, trong ®ã cã trång Tiªn Th¶o thÇn kú, nghe ®ån <c=g>Qu¸i Thñ LÜnh<c> sÏ r¬i h¹t gièng Tiªn Th¶o, ng­¬i cã ®ång ý thay ta ®Õn th¨m D­¬ng Thóc kh«ng?", "yes_zhong", "no")
    end
end

function yes_zhong()
    CloseDialog()
    Talk(1, "no", "<c=g>Qu¸i Thñ LÜnh<c> lµm r¬i <c=g>H¹t gièng may m¾n<c>, kh«ng biÕt bao giê míi cã c¬ héi nhËn ®­îc!")
    TaskNote(1203, 0)
    SetTask(Task_zhong, 1)
end

function zhishu()
    Talk(1, "zhishunext", 12903)
end;

function zhishunext()
    Talk(1, "no", 12904)
end;

function renwu()
    if (GetItemCount(39) >= 2) then
        for i = 1, 2 do
            DelEventItem(39)
        end ;
        AddEventItem(48)
        TaskNote(60, 1)
        Talk(1, "no", 11268)
    else
        Talk(1, "no", 11269)
    end ;
end;
----------------------------------------add by zhangpu start
--Modified by DuWen for 2011ÇéÈË½Ú begin
function valentine()
    local idx = 4
    local oIdx = PlayerIndex
    local pIdx = GetTask(VALENTINE + 1)
    local pStep = 0
    local step = GetTaskByte(VALENTINE, 4)

    if (step < 1 or step > 3) then
        return 0
    end

    if (pIdx ~= 0) then
        --×é¶Ó
        if (idx == GetTaskByte(VALENTINE, step)) then
            SetTaskByte(VALENTINE, 4, step + 1)
            if (step == 2) then
                SetTaskByte(VALENTINE, 4, 5)
                Talk(1, "no", "Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                Msg2Player("Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                TaskNote(1600, 1)
            else
                local vnIdx = GetTaskByte(VALENTINE, step + 1)
                local npc = vnpc[vnIdx][2]
                Talk(1, "no", "C¸m ¬n ng­¬i ®· mang chóc phóc ®Õn cho ta, mçi ngµy ®­îc yªu ®Òu lµ LÔ t×nh nh©n.")
                Msg2Player("Anh hïng ®· mang chóc phóc ®Õn ®©y, cßn tiÕp tôc t×m kiÕm Tiªn nh©n tiÕp theo kh«ng.")
                TaskNote(1600, 0, npc)
                SetTaskByte(VALENTINE, 4, step + 1)
            end
            return 1
        else
            Msg2Player("§©y kh«ng ph¶i lµ Tiªn nh©n mµ anh hïng muèn t×m, h·y tiÕp tôc cè g¾ng.")
            return 0
        end
    else
        --Ò»¸öÈË
        local nIdx
        local nextNpc
        if (idx == GetTaskByte(VALENTINE, step)) then
            SetTaskByte(VALENTINE, 4, step + 1)
            if (step == 3) then
                SetTaskByte(VALENTINE, 4, 5)
                Msg2Player("Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                Talk(1, "no", "Anh hïng ®· mang ®Õn tÊt c¶ chóc phóc, mau ®Õn chç C©y Høa NguyÖn nhËn th­ëng.")
                TaskNote(1600, 1)
                return 1
            elseif (step < 4) then
                SetTaskByte(VALENTINE, 4, step + 1)
                nIdx = GetTaskByte(VALENTINE, step + 1)
                nextNpc = vnpc[nIdx][2]
                Talk(1, "no", "C¸m ¬n ng­¬i ®· mang chóc phóc ®Õn cho ta, mçi ngµy ®­îc yªu ®Òu lµ LÔ t×nh nh©n.")
                Msg2Player("Anh hïng ®· mang chóc phóc ®Õn ®©y, cßn tiÕp tôc t×m kiÕm Tiªn nh©n tiÕp theo kh«ng.")
                TaskNote(1600, 0, nextNpc)
                return 1
            end
            return 0
        else
            Msg2Player("§©y kh«ng ph¶i lµ Tiªn nh©n mµ anh hïng muèn t×m, h·y tiÕp tôc cè g¾ng.")
            return 0
        end
    end
end
--Modified by DuWen for 2011ÇéÈË½Ú end

----------------------------------------------add by zhangpu end

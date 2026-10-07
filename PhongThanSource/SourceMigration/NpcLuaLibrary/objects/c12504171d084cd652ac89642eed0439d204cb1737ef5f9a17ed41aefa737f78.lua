--description:npc
--author: zhujialiang
--date:2005/4/13

--ÖíÁıÖ®²İÈÎÎñËµÃ÷
grass_renwu = 1322 --1byte ÈÎÎñ×´Ì¬(µ¥ÊıÏÉ£¬Ë«ÊıÄ§) 2byte ²¶×½¸öÊı 3byte ³æ¹í³öÏÖÉÏÏŞ
grass_npcDialog = 1323 --1-9bit npcÊÇ·ñ¶Ô»°
---

--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/28 begin
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

    --ÖíÁıÖ®²İ
    startLevel = 18
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local task = GetTaskByte(grassrenwu, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(grass_npcDialog, 2) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(grass_npcDialog, 2) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 1
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
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/28 end  

function main()
    if (plant() == 0) then

        local tasks = {
            { "H¬p thµnh Tiªn Giíi Ph¸p B¶o", "compoundAmulet"; show = 0 },
            { "Hîp thµnh bİ ®iÓn.", "compoundAmuletHelp"; show = 0 },
        }

        if (GetJusticEvilCredit() > 0) then
            tasks[1].show = 1
            tasks[2].show = 1
        end

        SayTask(14773, tasks)

        --Talk(1, "no", "²Ü±¦£º¹ØÓÚØÔ·ûÏâÇ¶¡­¡­À×Õğ×ÓÄÑµÀÃ»ÓĞ¸æËß¹ıÄã£¬°´Ë³ĞòÏâÇ¶ØÔ·û¿ÉÒÔĞÎ³ÉØÔÎ»£¬²¢»ñµÃØÔÎ»µÄÉñÃØÁ¦Á¿Âğ£¿±ÈÈçÔÚÑü´øÉÏË³ĞòÏâÇ¶ÔóÀ×ØÔ·û¡­¡­²»ºÃ£¬Ìì»ú²»¿ÉĞ¹Â¶£¬ÎÒ¸æËßÄãµÄÒÑÊÇÌ«¶à¡£Èç¹ûÄãÏë×·Ñ°ÆäÖĞ°ÂÃî£¬¾ÍÈ¥Çë½Ì²»ÖÜÉ½µÄ<c=g>»ÆÁúÕæÈË<c=g>°É¡£")
    end
end;

function compoundAmulet()

    CloseDialog()

    EnchaseItem(2)
end

function compoundAmuletHelp()
    --songlei

    CloseDialog()

    local tasks1 = {
        { "HÖ ThÇn Kú", "sqxl"; show = 1 },
        { "HÖ ThÇn T«n", "szxl"; show = 1 },
    }
    SayTask("Tµo B¶o: Ph¸p b¶o tiªn giíi gåm cã <c=yel>ThÇn Kú<c> vµ <c=yel>ThÇn T«n<c> 2 hÖ, nÕu nh­ muèn biÕt ®­îc bİ ph¸p hîp thµnh ph¸p b¶o cïng víi huyÒn c¬ bªn trong, h·y xem kü bİ ®iÓn sau lµ cã thÓ hiÓu ®­îc İt nhiÒu.", tasks1)
end

function sqxl()
    Talk(1, "sqxl_1", "<c=g><c><enter>30 BÊt Chu HuyÒn ThiÕt+S¬n Linh+H×nh Thiªn Ên=ThÇn Kú H×nh Thiªn Ên<enter><c=yel>Thuéc tİnh<c><c=water> phßng ngù+20 ®iÓm<c><enter><c=yel>HiÖu qu¶<c><c=water> phßng ngù+20 ®iÓm,duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn ma cÊp 30<enter>100% thµnh c«ng")
end
function sqxl_1()
    Talk(1, "sqxl_2", "<c=g><c><enter>30 BÊt Chu HuyÒn ThiÕt+Chóc Dung Ch©n Háa+¢m D­¬ng Kİnh=ThÇn Kú ¢m D­¬ng Kİnh<enter><c=yel>Thuéc tİnh<c><c=water>phßng ngù+20 ®iÓm<c><enter><c=yel>HiÖu qu¶: <c><c=water>L«i phßng+ 10% duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi 40<enter>100% thµnh c«ng")
end
function sqxl_2()
    Talk(1, "sqxl_3", "<c=g><c><enter>30 BÊt Chu HuyÒn ThiÕt+Chóc Dung Ch©n Háa+Ng« Phong §íi=ThÇn Kú Ng« Phong §íi<enter><c=yel>Thuéc tİnh<c><c=water>phßng ngù+20 ®iÓm<c><enter><c=yel>HiÖu qu¶: <c><c=water>Thæ phßng+ 10% duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi 40<enter>100% thµnh c«ng")
end
function sqxl_3()
    Talk(1, "sqxl_4", "<c=g><c><enter>30 BÊt Chu HuyÒn ThiÕt+Chóc Dung Ch©n Háa+Bİch Tú Bµ=ThÇn Kú Bİch Tú Bµ<enter><c=yel>Thuéc tİnh<c><c=water>phßng ngù+20 ®iÓm<c><enter><c=yel>HiÖu qu¶: <c><c=water>B¨ng phßng+ 10% duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi 40<enter>100% thµnh c«ng")
end
function sqxl_4()
    Talk(1, "sqxl_5", "<c=g><c><enter>30 BÊt Chu HuyÒn ThiÕt+Chóc Dung Ch©n Háa+Kim Cang Ph¸ch=ThÇn Kú Kim Cang Ph¸ch<enter><c=yel>Thuéc tİnh<c><c=water>phßng ngù+20 ®iÓm<c><enter><c=yel>HiÖu qu¶: <c><c=water>Háa phßng+ 10% duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi 40<enter>100% thµnh c«ng")
end
function sqxl_5()
    Talk(1, "compoundAmuletHelp", "<c=g><c><enter>Ph¸p B¶o ThÇn Kú+15 BÊt Chu HuyÒn ThiÕt+Lß luyÖn s¬ cÊp=Ph¸p b¶o TK (cÊp 1,2,3)<enter>PB ThÇn Kú+15 BÊt Chu HT+lß trung cÊp=PB TK (cÊp 4,5,6)<enter>PB ThÇn Kú+15 BÊt Chu HT+Lß cao cÊp=PB TK (cÊp 7,8,9)<enter>100% thµnh c«ng")
end
function szxl()
    Talk(1, "szxl_1", "<c=g>ThÇn T«n H×nh Thiªn Ên:<c><enter>ThÇn Kú H×nh Thiªn Ên (t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n H×nh Thiªn Ên<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 180 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi phßng ngù+ 180 ®iÓm, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 50<enter>100% thµnh c«ng")
end
function szxl_1()
    Talk(1, "szxl_2", "<c=g>ThÇn T«n ¢m D­¬ng Kİnh:<c><enter>ThÇn Kú ¢m D­¬ng Kİnh (t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n ¢m D­¬ng Kİnh<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 140 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi kh¸ng L«i+ 25%, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 60<enter>100% thµnh c«ng")
end
function szxl_2()
    Talk(1, "szxl_3", "<c=g>ThÇn T«n Tói Ng« Phong:<c><enter>ThÇn Kú Tói Ng« Phong (t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n Tói Ng« Phong<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 140 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi kh¸ng Thæ+ 25%, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 60<enter>100% thµnh c«ng")
end
function szxl_3()
    Talk(1, "szxl_4", "<c=g>ThÇn T«n Bİch Tú Bµ:<c><enter>ThÇn Kú Bİch Tú Bµ(t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n Bİch Tú Bµ<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 140 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi kh¸ng B¨ng+ 25%, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 60<enter>100% thµnh c«ng")
end
function szxl_4()
    Talk(1, "compoundAmuletHelp", "<c=g>ThÇn T«n Kim Cang Ph¸ch:<c><enter>ThÇn Kú Kim Cang Ph¸ch (t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n Kim Cang Ph¸ch<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 140 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi kh¸ng Háa+ 25%, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 60<enter>100% thµnh c«ng")
end

-------------------------------------------ÖíÁıÖ®²İ------------------------------
function plant()
    if (GetTaskByte(grass_renwu, 1) == 1) and (GetJusticEvilCredit() > 0) then
        if (GetTaskBit(grass_npcDialog, 2) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
            CloseDialog()
            Talk(1, "plantmotion", "ViÖc ®¹i sù nh­ vÇy. LÏ nµo ta l¹i tiÕc chót ph¸p lùc cña m×nh!")
            return 1
        end
    end
    return 0
end

function plantmotion()
    CloseDialog()
    BeginMotion(grass_npcDialog + 2, 0, 3, "\\script\\motion\\¶Ô»°½ø¶ÈÏìÓ¦.lua", 0)
end
------------------------------------------------------
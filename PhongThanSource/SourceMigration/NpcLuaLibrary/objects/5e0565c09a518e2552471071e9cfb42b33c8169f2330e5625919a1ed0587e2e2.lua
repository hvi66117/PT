grass_renwu = 1322
grass_npcDialog = 1323

require("¼×¹ÇÎÄ»î¶¯.luax")

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 18
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local task = GetTaskByte(grassrenwu, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskBit(grass_npcDialog, 2) == 0) and (HaveNormalItem(3, 330, 0, 0) > 0) then
                state = 3
                subState = 0
            end
        else
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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    if (plant() == 0) then

        local tasks = {
            { "H¬p thµnh Tiªn Giíi Ph¸p B¶o", "compoundAmulet"; show = 0 },
            { "Hîp thµnh bİ ®iÓn.", "compoundAmuletHelp"; show = 0 },
            { "¸÷È¡ËùĞè", "itemrenwu"; show = 0 },
        }

        if (GetJusticEvilCredit() > 0) then
            tasks[1].show = 1
            tasks[2].show = 1
            if (GetPlayerExtLevel() >= 5) then
                tasks[3].show = 1
            end
        end

        SayTask(14773, tasks)


    end
end;

function compoundAmulet()

    CloseDialog()

    EnchaseItem(2)
end

function compoundAmuletHelp()

    CloseDialog()

    local tasks1 = {
        { "HÖ ThÇn Kú", "sqxl"; show = 1 },
        { "HÖ ThÇn T«n", "szxl"; show = 1 },
        { "Ph¸p B¶o", "ppxl"; show = 1 },
    }
    SayTask("Tµo B¶o: Ph¸p b¶o tiªn giíi gåm cã <c=yel>ThÇn Kú<c> vµ <c=yel>ThÇn T«n<c> 2 hÖ, nÕu nh­ muèn biÕt ®­îc bİ ph¸p Hîp thµnh Ph¸p b¶o cïng víi huyÒn c¬ bªn trong, h·y xem kü bİ ®iÓn sau lµ cã thÓ hiÓu ®­îc İt nhiÒu.", tasks1)
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
    Talk(1, "szxl_2", "<c=g>ThÇn T«n ¢m D­¬ng Kİnh:<c><enter>ThÇn Kú ¢m D­¬ng Kİnh (t¨ng 9 cÊp)+15 BÊt Chu HuyÒn ThiÕt+3 Lß luyÖn cao cÊp=ThÇn T«n ¢m D­¬ng Kİnh<enter><c=yel>Thuéc tİnh:<c> <c=water>Phßng ngù+ 140 ®iÓm<c><enter><c=yel>HiÖu qu¶:<c> <c=water>Tæ ®éi Kh¸ng L«i +25%, duy tr× 30 phót<c><enter>Yªu cÇu: Tiªn Ma giíi cÊp 60<enter>100% thµnh c«ng")
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

function ppxl()
    CloseDialog()
    Talk(1, "ppxl_1", "<c=g>ThÊt TrÇn Trai (ThÇn):<c><enter>Do M¶nh Ph¸p B¶o Tiªn Ma ng­ng tô thµnh=ThÊt TrÇn Trai (ThÇn)<enter><c=yel>Thuéc tİnh: <c><c=water>Phßng ngù t¨ng 100 ®iÓm <c><enter><c><c=water>sinh lùc t¨ng 500 ®iÓm <c><enter><c=yel>HiÖu qu¶:<c><c=water>kh¸ng tÊt c¶ t¨ng 10%, duy tr× 30 phót<c><enter>Chó ı: NhÊt ®Şnh thµnh c«ng")
end
function ppxl_1()
    CloseDialog()
    Talk(2, "ppxl_2", "<c=g>N©ng cÊp ph¸p b¶o ThÊt TrÇn Trai (ThÇn):<c><enter>ThÊt TrÇn Trai (ThÇn)+15 BÊt Chu HuyÒn ThiÕt+2 Lß Tinh LuyÖn s¬ cÊp+50 M¶nh Ph¸p B¶o Tiªn Ma=ThÊt TrÇn Trai (ThÇn)(n©ng 1,2,3)<enter>ThÊt TrÇn Trai (ThÇn)+15 BÊt Chu HuyÒn ThiÕt+2 Lß Tinh LuyÖn trung cÊp+80 M¶nh Ph¸p B¶o Tiªn Ma=ThÊt TrÇn Trai (ThÇn)(n©ng 4,5,6)<enter>ThÊt TrÇn Trai (ThÇn)+15 BÊt Chu HuyÒn ThiÕt+2 Lß Tinh LuyÖn cao+100 M¶nh Ph¸p B¶o Tiªn Ma=Ph¸p B¶o ThÇn Kú (n©ng 7,8,9)<enter>Chó ı: NhÊt ®Şnh thµnh c«ng", "ÉñÆí½ğÉ½ÏµÁĞ·¨±¦²»ÄÜÉı¼¶")
end
function ppxl_2()
    CloseDialog()
    Talk(1, "compoundAmuletHelp", "<c=g>Ph¸p b¶o ThÊt TrÇn Trai (T«n):<c><enter>ThÊt TrÇn Trai (ThÇn)(n©ng cÊp 9 lÇn)+15 BÊt Chu HuyÒn ThiÕt+2 Lß Tinh LuyÖn Tr©n H÷u+250 M¶nh Ph¸p B¶o Tiªn Ma=ThÊt TrÇn Trai (T«n)<enter><c=yel>Thuéc tİnh: <c><c=water>Phßng ngù t¨ng 165 ®iÓm <c><enter><c><c=water>sinh lùc t¨ng 720 ®iÓm <c><c=yel>HiÖu qu¶:<c><c=water>sö dông thµnh viªn trong ph¹m vi nhÊt ®Şnh kh¸ng tÊt c¶ t¨ng 15%, duy tr× 30 phót<c><enter>Chó ı: NhÊt ®Şnh thµnh c«ng")
end

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

function itemrenwu()
    local tasks = {
        { "¸÷È¡ËùĞè", "itemrenwu_normal"; show = 0 },
        { "N¹p tµi tu luyÖn", "yes_freefsb"; show = 0 },
        { "Thiªn Tiªn thñy", "itemrenwu_coin1_yes"; show = 0 },
        { "ThÎ Kim DËt", "itemrenwu_coin"; show = 0 },
        { "ÉÏ½»Îï×Ê", "itemrenwu_complete"; show = 0 },
        { "<c=r>Huû nhiÖm vô<c>", "itemrenwu_esc"; show = 1 },
    }

    local renwu = GetTaskByte(2259, 1)
    local strtask = "²Ü±¦: ÎÒÃÇ×ÚÃÅĞèÒª´óÁ¿ĞŞÁ¶Îï×Ê, Ö»ÒªÄãÄÜÄÃÀ´Ö¸¶¨µÄÎïÆ·, ¾ÍÈÃÄã½øÈë¾ÛÁéÕóÎüÊÕÁéÆøÒ»´Î, ÎüÊÕµÄ¶àÉÙÒ²ÒòÈË¶øÒì."

    if (renwu >= 1) and (renwu <= 3) then
        tasks[5].show = 1
    elseif (renwu == 100) or (GetTaskByte(2259, 2) > 0) then
        itemrenwu_normalyes()
        return 0
    else
        local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
        if (thisday ~= GetTaskByte(2258, 1)) then
            MsgBox("²Ü±¦: ÎÒÃÇ×ÚÃÅĞèÒª´óÁ¿ĞŞÁ¶Îï×Ê, Ö»ÒªÄãÄÜÄÃÀ´<c=y>Ö¸¶¨µÄ3¼şÎïÆ·<c>, ¾ÍÈÃÄã½øÈë¾ÛÁéÕóÎüÊÕÁéÆøÒ»´Î, ÎüÊÕµÄ¶àÉÙÒ²ÒòÈË¶øÒì.Äã¿ÉÒªÏÖÔÚ¾ÍÒª¶Ò»»?", "itemrenwu_normal", "no")
            return 0
        else
            if (GetTaskByte(2258, 2) <= 1) then
                local _, Cv, Cfs = GetCostCoinInfoByIdx(302)
                tasks[3].show = 1

                strtask = "²Ü±¦: NÕu ng­¬i cã thÓ ®­a ta <c=y>Thiªn Tiªn Thuû<c> hoÆc <c=y>" .. Cfs .. " Th«ng B¶o<c>, ÎÒ»áÈÃÄã½ñÌìÔÙ´Î»ñµÃ½ÓÊÜ¸÷È¡ËùĞèµÄ»ú»á. Ng­¬i muèn nhËn lÊy c¬ héi nµy chø?"
            else
                strtask = "²Ü±¦: ÇóµÀÕß²»¿ÉĞŞĞĞ¼±Ôê, µÀÓÑ½ñÌìÒÑ¾­Hoµn thµnh nhiÖm vô ÁËÈ«²¿µÄ¸÷È¡ËùĞè, ÇëÃ÷ÌìÔÙÀ´!"
            end

            local retime = GetTaskByte(1477, 3) - GetTaskByte(2258, 3)
            local pm_free = payMoneyfree()
            if (retime > 0) then
                tasks[2].show = 1
                strtask = "²Ü±¦: Ngµi ®· tİch luü ®­îc <c=g>" .. retime .. "<c> lÇn nhiÖm vô miÔn phİ, nÕu ®­a cho ta <c=y>" .. pm_free .. "<c> b¹c, Ôò¿ÉÔÙ´Î¸÷È¡ËùĞè, kh«ng tİnh vµo kh©u tr¶ phİ. BÊm 'N¹p tµi tu luyÖn' ®Ó h­ëng ­u ®·i nµy."
            end
            tasks[6].show = 0
        end
    end ;

    SayTask(strtask, tasks)
end

function itemrenwu_complete()
    CloseDialog()
    local renwu = GetTaskByte(2259, 1)
    if (renwu == 100) or (renwu == 0) then
        itemrenwu_normalyes()
        return 0
    elseif (renwu >= 1) or (renwu <= 3) then
        local tasks = {
            { "ËæÒâÉÏ½»", "Yes_delItem"; show = 0 },
            { "Ö¸¶¨ÉÏ½»", "Yes_SelItem"; show = 0 },
        }

        local num = G_List[renwu][GetTaskByte(2259, 3)].nums
        local str = G_List[renwu][GetTaskByte(2259, 3)].name

        if (num >= 1) then
            tasks[1].show = 1
            tasks[2].show = 1
        end
        SayTask("²Ü±¦: Õâ´ÎÎÒĞèÒªµÄÊÇ: <c=y>" .. num .. "." .. str .. "<c>.\n[ËæÒâÉÏ½»]ËæÒâÉÏ½»±³°üÀï·ûºÏÒªÇóµÄÎï×Ê, Çë°ÑÒª±£ÁôµÄÎï×Ê·ÅÈë²Ö¿â, ÒÔÃâÎó½».\n[Ö¸¶¨ÉÏ½»]×Ô¼ºÑ¡ÔñÒªÉÏ½»µÄÎï×Ê, ÇëÌáÇ°²ğ·Ö³ö" .. num .. " c¸iµ¥¶À·ÅÒ»¸ñ, Ö»ÄÜÒ»´ÎÈ«²¿½»Æë.", tasks)
    else
        local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
        if (thisday ~= GetTaskByte(2258, 1)) then
            Talk(1, "no", "²Ü±¦: ĞÂµÄÒ»Ìì¿ªÊ¼, ÄãÏÖÔÚ¿ÉÒÔ¿ªÊ¼ĞÂµÄ¸÷È¡ËùĞèÈÎÎñ.")
            SetTask(2259, 0)
            itemrenwu()
        else
            SetTaskByte(2259, 1, 100)
            SetTaskByte(2259, 3, 0)
            TaskNote(126, 1)
            itemrenwu_normalyes()
        end
    end
end

function Yes_delItem()
    no()
    local nCount = 0
    local list = G_List[GetTaskByte(2259, 1)][GetTaskByte(2259, 3)]
    local nPart = 0
    if (list.other == -2) then
        MsgBox("²Ü±¦: ×°±¸90¼¶ÒÔÏÂµÄ³È×°Í¼Æ×Ì«¶àÁË, ÎÒÍòÒ»ÄÃÁËÄãÓĞÓÃµÄ¾Í²»ºÃÁË, »¹ÊÇÄã×Ô¼ºÑ¡Ôñ°É", "Yes_SelItem", "no")
        return
    elseif (list.other == -3) then
        MsgBox("²Ü±¦: µÍ¼¶ÄÚµ¤, vµ ÒÑ¾­ÕÒËãÃüÏÈÉú¼ø¶¨¹ıµÄ³èÎï¼¼ÄÚµ¤¶¼¿ÉÒÔÉÏ½», ÎÒÍòÒ»ÄÃÁËÄãÓĞÓÃµÄ¾Í²»ºÃÁË, »¹ÊÇÄã×Ô¼ºÑ¡Ôñ°É", "Yes_SelItem", "no")
        return
    elseif (list.other == -4) then
        MsgBox("²Ü±¦: ·²Óñ¿ÉÒÔÊÇÎ´¿ª¹â vµ ÒÑ¿ª¹âµÄ, ÎÒÍòÒ»ÄÃÁËÄãÓĞÓÃµÄÊôĞÔ¾Í²»ºÃÁË, »¹ÊÇÄã×Ô¼ºÑ¡Ôñ°É", "Yes_SelItem", "no")
        return
    elseif (list.other == -1) then
        if (list.key == 1) then
            if (HaveNormalItem(3, list.itemidx, 0, 0) >= list.nums) then
                for i = 1, 20 do
                    if (DelNormalItem(3, list.itemidx, 0, 0) > 0) then
                        nCount = nCount + 1
                    end

                    if (nCount >= list.nums) then
                        Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                        local str = list.nums .. "." .. list.name
                        jiangli(str)
                        return 0
                    end
                end
            end
        elseif (list.key == 2) then
            nPart = HaveNormalItem(6, 1, list.itemidx, 0) + HaveNormalItem(6, 1, list.itemidx, 1)
            if (nPart >= list.nums) then
                for i = 1, 20 do
                    if (DelNormalItem(6, 1, list.itemidx, 0) > 0) then
                        nCount = nCount + 1
                    elseif (DelNormalItem(6, 1, list.itemidx, 1) > 0) then
                        nCount = nCount + 1
                    end

                    if (nCount >= list.nums) then
                        Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                        local str = list.nums .. "." .. list.name
                        jiangli(str)
                        return 0
                    end
                end
            end
        elseif (list.key == 3) then
            nPart = HaveNormalItem(8, list.itemidx, 0, 0)
            if (nPart >= list.nums) then
                for i = 1, 20 do
                    if (DelNormalItem(8, list.itemidx, 0, 0) > 0) then
                        nCount = nCount + 1
                    end

                    if (nCount >= list.nums) then
                        Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                        local str = list.nums .. "." .. list.name
                        jiangli(str)
                        return 0
                    end
                end
            end
        end
    else
        if (list.key == 1) then
            nPart = HaveNormalItem(3, list.itemidx, 0, 0) + HaveNormalItem(3, list.other, 0, 0)
            if (nPart >= list.nums) then
                if (HaveNormalItem(3, list.itemidx, 0, 0) > 0) then
                    for i = 1, 20 do
                        if (DelNormalItem(3, list.itemidx, 0, 0) > 0) then
                            nCount = nCount + 1
                        end

                        if (nCount >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = list.nums .. "." .. list.name
                            jiangli(str)
                            return 0
                        end
                    end
                end
                nPart = 0
                if (HaveNormalItem(3, list.other, 0, 0) >= list.nums - nCount) then
                    for i = 1, 20 do
                        if (DelNormalItem(3, list.other, 0, 0) > 0) then
                            nPart = nPart + 1
                        end

                        if (nCount + nPart >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = nCount .. "." .. GetNormalItemName(3, list.itemidx, 0, 0) .. nPart .. "." .. GetNormalItemName(3, list.other, 0, 0)
                            jiangli(str)
                            return 0
                        end
                    end
                end
            end
        elseif (list.key == 2) then
            nPart = HaveNormalItem(6, 1, list.itemidx, 0) + HaveNormalItem(6, 1, list.itemidx, 1) + HaveNormalItem(6, 1, list.other, 0) + HaveNormalItem(6, 1, list.other, 1)
            if (nPart >= list.nums) then
                if (HaveNormalItem(6, 1, list.itemidx, 0) > 0) or (HaveNormalItem(6, 1, list.itemidx, 1) > 0) then
                    for i = 1, 20 do
                        if (DelNormalItem(6, 1, list.itemidx, 0) > 0) then
                            nCount = nCount + 1
                        elseif (DelNormalItem(6, 1, list.itemidx, 1) > 0) then
                            nCount = nCount + 1
                        end

                        if (nCount >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = list.nums .. "." .. list.name
                            jiangli(str)
                            return 0
                        end
                    end
                end
                nPart = 0
                if ((HaveNormalItem(6, 1, list.other, 0) + HaveNormalItem(6, 1, list.other, 1)) >= list.nums - nCount) then
                    for i = 1, 20 do
                        if (DelNormalItem(6, 1, list.other, 0) > 0) then
                            nPart = nPart + 1
                        elseif (DelNormalItem(6, 1, list.other, 1) > 0) then
                            nPart = nPart + 1
                        end

                        if (nCount + nPart >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = nCount .. "." .. GetNormalItemName(6, 1, list.itemidx, 0) .. nPart .. "." .. GetNormalItemName(6, 1, list.other, 0)
                            jiangli(str)
                            return 0
                        end
                    end
                end
            end
        elseif (list.key == 3) then
            nPart = HaveNormalItem(8, list.itemidx, 0, 0) + HaveNormalItem(8, list.other, 0, 0)
            if (nPart >= list.nums) then
                if (HaveNormalItem(8, list.itemidx, 0, 0) > 0) then
                    for i = 1, 20 do
                        if (DelNormalItem(8, list.itemidx, 0, 0) > 0) then
                            nCount = nCount + 1
                        end

                        if (nCount >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = list.nums .. "." .. list.name
                            jiangli(str)
                            return 0
                        end
                    end
                end
                nPart = 0
                if (HaveNormalItem(8, list.other, 0, 0) >= list.nums - nCount) then
                    for i = 1, 20 do
                        if (DelNormalItem(8, list.other, 0, 0) > 0) then
                            nPart = nPart + 1
                        end

                        if (nCount + nPart >= list.nums) then
                            Msg2Player("ÄãÉÏ½»ÁË" .. list.nums .. "." .. list.name)
                            local str = nCount .. "." .. GetNormalItemName(8, list.itemidx, 0, 0) .. nPart .. "." .. GetNormalItemName(8, list.other, 0, 0)
                            jiangli(str)
                            return 0
                        end
                    end
                end
            end
        end
    end

    Talk(1, "no", "²Ü±¦: ThËt xin lçi, ÕâÀïÃæÃ»ÓĞÎÒĞèÒªµÄ¶«Î÷.")
end

function no()
    CloseDialog()
end;

function Yes_SelItem()
    no()
    MouseSelect(1, 22, "ItemSelect", "no")
end

function ItemSelect(ItemID)
    SetTask(142, ItemID)
    MsgBox("²Ü±¦: ÄãÊÇ²»ÊÇ´òËãÉÏ½»ÎïÆ·: <c=r>" .. GetItemName(ItemID) .. "<c>\n<c=r>Çë°ÑÒªÉÏ½»µÄ²ÄÁÏÏÈ²ğ·Ö³öÀ´, µ¥¶À·ÅÒ»¸ñ, ÒÔÃâÎóÉ¾<c>\n[È·¶¨]ÉÏ½», [È¡Ïû]Trë l¹i Trang tr­íc", "yes_itemclear", "itemrenwu_complete")
end

function yes_itemclear()
    local ItemID = GetTask(142)
    local name = GetItemName(ItemID)
    local list = G_List[GetTaskByte(2259, 1)][GetTaskByte(2259, 3)]
    if (name == nil) or (name == "") then
        Talk(1, "no", "²Ü±¦: ÉÏ½»Ê§°Ü, ÇëÄã¼ì²éÒ»ÏÂ±³°ü!")
        return
    end

    local nCount = GetItemCountByID(ItemID)
    if (nCount ~= list.nums) then
        Talk(1, "no", "²Ü±¦: ThËt xin lçi, ÊıÁ¿²»¶Ô!ÎÒÖ» cÇn <c=r>" .. list.nums .. "<c>" .. list.name)
        return
    end

    local nSpace
    if (list.other == -2) then
        nSpace = string.find(name, "§å phæ")
    elseif (list.other == -3) then
        nSpace = string.find(name, "ÄÚµ¤")
    else
        nSpace = string.find(name, list.name)
    end

    if (nSpace == nil) or (nSpace == "") or (nSpace <= 0) then
        Talk(1, "no", "²Ü±¦: ThËt xin lçi, Õâ²»ÊÇÎÒĞèÒªµÄ¶«Î÷.")
        return
    end

    nSpace = 0
    local nDetail = GetItemDetail(ItemID)
    local nPart = GetItemPartByID(ItemID)
    if (list.other == -2) then
        for i = 1, #list.itemidx, 2 do
            if (nPart >= list.itemidx[i]) and (nPart <= list.itemidx[i + 1]) then
                nSpace = nPart
                break
            end
        end
    elseif (list.other == -3) then
        if (nDetail == list.itemidx) or (nDetail == list.other) then
            nSpace = nDetail
        else
            for i = 1, #list.itemidx1, 2 do
                if (nDetail >= list.itemidx1[i]) and (nDetail <= list.itemidx1[i + 1]) then
                    nSpace = nDetail
                    break
                end
            end
        end
    elseif (list.other == -4) then
        if (nDetail == list.itemidx) or (nDetail == list.itemidx1) then
            nSpace = nDetail
        end
    else
        if (list.key == 1) or (list.key == 3) then
            if (nDetail == list.itemidx) or (nDetail == list.other) then
                nSpace = nDetail
            end
        elseif (list.key == 2) then
            if (nPart == list.itemidx) or (nPart == list.other) then
                nSpace = nPart
            end
        end
    end

    if (nSpace <= 0) then
        Talk(1, "no", "²Ü±¦: ThËt xin lçi, Õâ²»ÊÇÎÒĞèÒªµÄ¶«Î÷.")
        return
    end

    nCount = DelItemByID(ItemID, 1)
    if (nCount > 0) then
        Msg2Player("ÄãÉÏ½»ÁË" .. nCount .. "." .. name)
        local nstr = nCount .. "." .. name
        jiangli(nstr)
    else
        Talk(1, "no", "²Ü±¦: ÉÏ½»Ê§°Ü, ÇëÄã¼ì²éÒ»ÏÂ±³°ü!")
        return
    end
end

function jiangli(logItem)
    CloseDialog()
    local renwu = GetTaskByte(2259, 1)
    local huanshu = GetTaskByte(2259, 2)
    if (renwu < 0) or (renwu > 3) or (huanshu > 3) then
        return 0
    end

    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
    local isfree = GetTaskByte(2258, 4)
    local lvl = GetPlayerExtLevel()
    local nExp = 0
    local logstr = "]"

    if (huanshu < 3) then
        nExp = (300 + 30 * math.floor((lvl - 5) / 10)) * lvl
    else
        nExp = (400 + 40 * math.floor((lvl - 5) / 10)) * lvl
    end

    if (isfree == 0) then
        if (GetWeekDay() == 7) then
            Msg2Player("NhiÖm vô chñ ®Ò ngµy h«m nay lµ ¸÷È¡ËùĞè, chóc m­õng ngµi, nhËn ®­îc th­ëng tu vi gÊp ®«i")
            logstr = logstr .. "Chñ ®Ò ngµy"
            local nDoubel = 1
            if (HaveIBBuff(2094) > 0) then
                nDoubel = nDoubel + 1
                CostIBBuff(2094, 1)
                Msg2Player("Do ngµi sö dông Phï nhiÖm vô Chñ ®Ò ngµy-Tiªn Ma, phÇn th­ëng lÇn nµy t¨ng 100%.")
                logstr = logstr .. "+ Phï Chñ ®Ò ngµy Tiªn Ma"
            end

            local nBuffLevel = GetIBBuffLevel(2095) + 1
            if (HaveIBBuff(2095) > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                nDoubel = nDoubel + nBuffLevel
                Msg2Player("HiÖn trong thêi gian ho¹t ®éng gÊp ®«i chñ ®Ò ngµy Tiªn Ma, nhËn ®­îc phÇn th­ëng lín h¬n.")
                logstr = logstr .. "+2095buff" .. nBuffLevel
            end

            nExp = nExp + math.floor(nExp * nDoubel)
        end
    else
        logstr = logstr .. "N¹p tµi"
    end

    local nFactExp = AddOwnExtendExp(nExp)
    if (nFactExp < nExp) then
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("Ng­¬i ch­a hoµn thµnh §é KiÕp hoÆc cÊp ®é Nh©n gian qu¸ thÊp, kh«ng thÓ lÜnh héi ®ñ tu vi Tiªn Ma, chØ t¨ng lªn " .. nFactExp .. " ®iÓm")
    else
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
    end

    if (huanshu < 3) then
        if (thisday ~= GetTaskByte(2258, 1)) then
            Talk(1, "itemrenwu", "²Ü±¦: ĞÂµÄÒ»Ìì¿ªÊ¼, ÄãÏÖÔÚ¿ÉÒÔ¿ªÊ¼ĞÂµÄ¸÷È¡ËùĞèÈÎÎñ.")
            SetTask(2259, 0)
        else
            SetTaskByte(2259, 1, 100)
            SetTaskByte(2259, 3, 0)
            TaskNote(126, 1)
            Talk(1, "itemrenwu_normalyes", "²Ü±¦: ÄãÒÑ¾­³É¹¦µØÍê³ÉÁËÒ»´Î¸÷È¡ËùĞè, È¥Ñ¡ÔñÄãÒªÉÏ½»µÄÀà±ğ!")
        end
    else
        local total = GetTaskByte(2259, 4)
        SetTask(2259, 0)
        SetTaskByte(2258, 4, 0)
        TaskNote(126, -1)
        TaskNote(127, -1)
        if (total == 60 + 10 + 1) then
            local itemlist = {
                { "Phi Th¨ng §¬n 1 c¸i", { 6, 1, 1771 }, 50, 1 },
                { "Phi Th¨ng §¬n 2 c¸i", { 6, 1, 1771 }, 30, 2 },
                { "Phi Th¨ng §¬n 3 c¸i", { 6, 1, 1771 }, 15, 3 },
                { "Ò»ÕÅM¶nh s¸ch Ch­ HÇu", { 8, 193, 5 }, 3, 1 },
                { "Ò»ÕÅS¸ch Ch­ HÇu (Tµn trang)", { 8, 1422, 5 }, 2, 1 },
            }
            local r = math.random(1, 100)
            local rmax = 0
            for i = 1, #itemlist do
                rmax = rmax + itemlist[i][3]
                if (r <= rmax) then
                    ScrollMessage("Äã¶îÍâ nhËn ®­îc " .. itemlist[i][1])
                    Msg2Player("B¹n nhËn ®­îc " .. itemlist[i][1] .. ", Ï£ÍûÄãÄÜÔÙ½ÓÔÙÀ÷!")
                    logstr = logstr .. "|" .. itemlist[i][1]
                    for j = 1, itemlist[i][4] do
                        AddNormalItemBind(itemlist[i][2][1], itemlist[i][2][2], itemlist[i][2][3], 0, 0, 0, 1)
                    end
                    if (itemlist[i][1] == "Phi Th¨ng §¬n 3 c¸i") then
                        ORACLEBONE.GetCardWayApply(49, 0)
                    end

                    break
                end
            end
        end

        Talk(1, "no", "²Ü±¦: LŞch luyÖn lÇn nµy ®· kÕt thóc, xin nhËn lÊy phÇn th­ëng!")
    end
    WriteLog("[¸÷È¡ËùĞè][Kinh nghiÖm: " .. nFactExp .. "/" .. nExp .. logstr .. "[ÉÏ½»: " .. logItem)
end

function itemrenwu_esc()
    MsgBox("²Ü±¦: ÄãÕæµÄÒª·ÅÆú sao?Äã¿ÉÒÔÈ¥ÅÄÂôĞĞ, °ÚÌ¯´¦¹ä¹ä.\n[È·¶¨]ÊÇ·ÅÆúÈÎÎñ, [È¡Ïû]ÊÇ·µ»Ø", "itemrenwu_cancel", "itemrenwu")
end

function itemrenwu_cancel()
    CloseDialog()
    SetTask(2259, 0)
    SetTaskByte(2258, 4, 0)
    TaskNote(126, -1)
    TaskNote(127, -1)
    Talk(1, "no", "²Ü±¦: µÈÄãÓĞ¿ÕÏĞÊ±ÔÙÀ´ÕÒÎÒ°É!")
    Msg2Player("B¹n ®· huû nhiÖm vô ¸÷È¡ËùĞè.")
    WriteLog("[¸÷È¡ËùĞè][Huû nhiÖm vô]")
end

function itemrenwu_normal()
    local renwu = GetTaskByte(2259, 1)
    if (renwu >= 1) and (renwu <= 3) then
        itemrenwu_complete()
        return 0
    end

    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
    if (thisday ~= GetTaskByte(2258, 1)) then
        SetTask(2258, thisday)
        SetTask(2259, 0)
        offlineTotimes()
    end

    local renwu = GetTaskByte(2259, 1)
    local huanshu = GetTaskByte(2259, 2)
    if (renwu == 0) then
        local times = GetTaskByte(2258, 2) + 1
        SetTaskByte(2258, 2, times)
        Msg2Player("§©y lµ lÇn thø " .. times .. "´ÎÁìÈ¡¸÷È¡ËùĞèÈÎÎñ!")
        SetTaskByte(2258, 4, 0)
        SetTaskByte(2259, 1, 100)
        TaskNote(126, 1)
        if (times < 2) then
            SyncBibleState(126, 2, 1)
        else
            SyncBibleState(126, 3, 1)
        end ;
    end
    if ((renwu ~= 0) and (renwu ~= 100)) or (huanshu >= 3) then
        return 0
    end
    itemrenwu_normalyes()
    return 1
end

function itemrenwu_normalyes()
    CloseDialog()
    local renwu = GetTaskByte(2259, 1)
    local huanshu = GetTaskByte(2259, 2)
    if ((renwu ~= 0) and (renwu ~= 100)) or (huanshu >= 3) then
        return 0
    end

    local tasks = {
        { "Éú»î¼¼ÄÜ²ú³ö", "itemrenwu_1"; show = 1 },
        { "²ÄÁÏ·¨±¦¿óÊ¯", "itemrenwu_2"; show = 1 },
        { "·ûÊ¯ÓñÊ¯ÄÚµ¤", "itemrenwu_3"; show = 1 },
    }
    SayTask("²Ü±¦: Ã¿ÉÏ½»Ò»ÖÖÎï×Ê, ¾ÍÄÜ½øÈë¾ÛÁéÕóÌáÉıĞŞÎª.Äã¿ÉÒÔÃ¿´ÎÉÏ½»¶¼Ñ¡ÔñÍ¬Ò»ÀàÎï×Ê, Ò²¿ÉÒÔÈı´óÀàÎï×Ê¶¼¸÷ÉÏ½»Ò»ÖÖ, ÄÇÃ´×îÖÕ½±Àø»á¸ü¼Ó·áÊ¢.", tasks)
end

G_List = {
    [1] = {
        { name = "B¹ch Trµ", nums = 10, itemidx = 910, key = 1, other = -1, },
        { name = "§Şa Hoµng", nums = 10, itemidx = 911, key = 1, other = -1, },
        { name = "Huyªn th¶o", nums = 10, itemidx = 912, key = 1, other = -1, },
        { name = "C¸t C¨n", nums = 5, itemidx = 913, key = 1, other = -1, },
        { name = "Liªn KiÒu", nums = 2, itemidx = 914, key = 1, other = -1, },
        { name = "L¹c Th¹ch §»ng", nums = 1, itemidx = 915, key = 1, other = -1, },
        { name = "Hoµng ®ång", nums = 10, itemidx = 928, key = 1, other = -1, },
        { name = "§ång ®á", nums = 5, itemidx = 929, key = 1, other = -1, },
        { name = "Xİch ®ång", nums = 2, itemidx = 930, key = 1, other = -1, },
        { name = "Hµn thiÕt", nums = 1, itemidx = 931, key = 1, other = -1, },
        { name = "T«m xanh", nums = 10, itemidx = 944, key = 1, other = -1, },
        { name = "T«m hïm", nums = 5, itemidx = 945, key = 1, other = -1, },
        { name = "Ca diÕt", nums = 2, itemidx = 946, key = 1, other = -1, },
        { name = "Hång Lı", nums = 1, itemidx = 947, key = 1, other = -1, },
        { name = "B¹ch Trµ Tinh Hoa", nums = 10, itemidx = 956, key = 1, other = -1, },
        { name = "§Şa Hoµng Tinh Hoa", nums = 10, itemidx = 957, key = 1, other = -1, },
        { name = "Huyªn Th¶o Tinh Hoa", nums = 10, itemidx = 958, key = 1, other = -1, },
        { name = "C¸t C¨n Tinh Hoa", nums = 5, itemidx = 959, key = 1, other = -1, },
        { name = "Liªn KiÒu Tinh Hoa", nums = 2, itemidx = 960, key = 1, other = -1, },
        { name = "L¹c Th¹ch §»ng Tinh Hoa", nums = 1, itemidx = 961, key = 1, other = -1, },
        { name = "ThŞt T«m xanh", nums = 10, itemidx = 972, key = 1, other = -1, },
        { name = "ThŞt T«m hïm", nums = 5, itemidx = 973, key = 1, other = -1, },
        { name = "ThŞt c¸ diÕc", nums = 2, itemidx = 974, key = 1, other = -1, },
        { name = "ThŞt Hång Lı", nums = 1, itemidx = 975, key = 1, other = -1, },
        { name = "Hoµng ®ång sa", nums = 10, itemidx = 984, key = 1, other = -1, },
        { name = "Hoµng ®ång khèi", nums = 5, itemidx = 985, key = 1, other = -1, },
        { name = "Hoµng ®ång ®Ünh", nums = 2, itemidx = 986, key = 1, other = -1, },
        { name = "Tö ®ång sa", nums = 1, itemidx = 987, key = 1, other = -1, },
        { name = "Ngäc Hµn thiÕt", nums = 1, itemidx = 994, key = 1, other = -1, },
        { name = "ChØ HuyÕt Lé", nums = 10, itemidx = 905, key = 3, other = 928, },
        { name = "İch thÇn lé", nums = 10, itemidx = 906, key = 3, other = 929, },
        { name = "Thiªn Lang §¬n", nums = 5, itemidx = 907, key = 3, other = 930, },
        { name = "Chu T­íc §¬n", nums = 2, itemidx = 908, key = 3, other = 931, },
        { name = "B¹ch Hæ §¬n", nums = 2, itemidx = 909, key = 3, other = 932, },
        { name = "Thanh Long §¬n", nums = 2, itemidx = 910, key = 3, other = 933, },
        { name = "HuyÒn Vò §¬n", nums = 2, itemidx = 911, key = 3, other = 934, },
        { name = "Hé Sinh Lé", nums = 1, itemidx = 912, key = 3, other = 935, },
        { name = "L¹c ThÇn Lé", nums = 1, itemidx = 913, key = 3, other = 936, },
        { name = "T«m xµo", nums = 10, itemidx = 951, key = 3, other = 969, },
        { name = "Canh su«ng", nums = 10, itemidx = 952, key = 3, other = 970, },
        { name = "T«m kho", nums = 5, itemidx = 953, key = 3, other = 971, },
        { name = "Canh c¸ diÕc", nums = 2, itemidx = 954, key = 3, other = 972, },
        { name = "C¸ chĞp sèt chua ngät", nums = 1, itemidx = 955, key = 3, other = 973, },
        { name = "C¸ viªn chiªn", nums = 1, itemidx = 956, key = 3, other = 974, },
        { name = "Ph¸ Thñy Hoµn", nums = 1, itemidx = 546, key = 1, other = -1, },
        { name = "CÊn Thæ Hoµn", nums = 1, itemidx = 548, key = 1, other = -1, },
        { name = "Tèn Phong Hoµn", nums = 1, itemidx = 550, key = 1, other = -1, },
        { name = "Ly Háa Hoµn", nums = 1, itemidx = 552, key = 1, other = -1, },
        { name = "Kiªn Qu©n Phï", nums = 1, itemidx = 558, key = 1, other = -1, },
    },
    [2] = {
        { name = "Ph¸p B¶o Tinh Hoa", nums = 1, itemidx = 1265, key = 1, other = -1, },
        { name = "Dung tinh lé", nums = 1, itemidx = 209, key = 1, other = -1, },
        { name = "Ng­ng ThÇn Sa", nums = 1, itemidx = 1274, key = 1, other = -1, },
        { name = "M¹n ch©u sa hoa", nums = 20, itemidx = 312, key = 1, other = -1, },
        { name = "M¹n ®µ lµ hoa", nums = 20, itemidx = 311, key = 1, other = -1, },
        { name = "ÈÎÒâ³È×°Í¼Æ× (90¼¶¼°ÒÔÏÂ)", nums = 1, itemidx = { 188, 262, 366, 380, 278, 292 }, key = 2, other = -2, },
    },
    [3] = {
        { name = "M¶nh Phï Th¹ch", nums = 20, itemidx = 1276, key = 2, other = 1281, },
        { name = "Bét Néi ®¬n", nums = 5, itemidx = 1012, key = 1, other = -1, },
        { name = "µÍ¼¶ÄÚµ¤»ò³èÎï¼¼ÄÚµ¤", nums = 1, itemidx = 554, key = 1, other = -3, itemidx1 = { 487, 495, 511, 515, 527, 529, 536, 538 } },
        { name = "Xİch Viªm to¸i ngäc", nums = 5, itemidx = 253, key = 1, other = -1, },
        { name = "Thanh Minh to¸i ngäc", nums = 5, itemidx = 260, key = 1, other = -1, },
        { name = "Tö Hµ to¸i ngäc", nums = 5, itemidx = 267, key = 1, other = -1, },
        { name = "Xİch Viªm Phµm Ngäc", nums = 1, itemidx = 254, key = 1, other = -4, itemidx1 = 282, },
        { name = "Thanh Minh Phµm Ngäc", nums = 1, itemidx = 261, key = 1, other = -4, itemidx1 = 289, },
        { name = "Tö Hµ Phµm Ngäc", nums = 1, itemidx = 268, key = 1, other = -4, itemidx1 = 296, },
        { name = "Hång b¶o th¹ch", nums = 10, itemidx = 79, key = 1, other = -1, },
        { name = "Lam b¶o th¹ch", nums = 5, itemidx = 41, key = 1, other = -1, },
        { name = "Lôc B¶o th¹ch", nums = 3, itemidx = 250, key = 1, other = -1, },
        { name = "Tö B¶o Th¹ch", nums = 1, itemidx = 1151, key = 1, other = -1, },
        { name = "Hoµng b¶o th¹ch", nums = 1, itemidx = 90, key = 1, other = -1, },
    },
}

function itemrenwu_1()
    local maxr = table.getn(G_List[1])
    local r = math.random(1, maxr)
    local str = G_List[1][r].name
    local n = G_List[1][r].nums

    TaskNote(126, 0, n, str)
    SetTaskByte(2259, 1, 1)
    SetTaskByte(2259, 2, (GetTaskByte(2259, 2) + 1))
    SetTaskByte(2259, 3, r)
    SetTaskByte(2259, 4, (GetTaskByte(2259, 4) + 1))
    Msg2Player("²Ü±¦: Äã½Óµ½ĞÂµÄ¸÷È¡ËùĞèÈÎÎñ.")
    Talk(1, "no", "²Ü±¦: Õâ´ÎÎÒĞèÒªµÄÊÇ<color=green>" .. n .. "." .. str .. "<c>!")
end
function itemrenwu_2()
    local maxr = table.getn(G_List[2])
    local r = math.random(1, maxr)
    local str = G_List[2][r].name
    local n = G_List[2][r].nums

    TaskNote(126, 0, n, str)
    SetTaskByte(2259, 1, 2)
    SetTaskByte(2259, 2, (GetTaskByte(2259, 2) + 1))
    SetTaskByte(2259, 3, r)
    SetTaskByte(2259, 4, (GetTaskByte(2259, 4) + 10))
    Msg2Player("²Ü±¦: Äã½Óµ½ĞÂµÄ¸÷È¡ËùĞèÈÎÎñ.")
    Talk(1, "no", "²Ü±¦: Õâ´ÎÎÒĞèÒªµÄÊÇ<color=green>" .. n .. "." .. str .. "<c>!")
end
function itemrenwu_3()
    local maxr = table.getn(G_List[3])
    local r = math.random(1, maxr)
    local str = G_List[3][r].name
    local n = G_List[3][r].nums

    TaskNote(126, 0, n, str)
    SetTaskByte(2259, 1, 3)
    SetTaskByte(2259, 2, (GetTaskByte(2259, 2) + 1))
    SetTaskByte(2259, 3, r)
    SetTaskByte(2259, 4, (GetTaskByte(2259, 4) + 60))
    Msg2Player("²Ü±¦: Äã½Óµ½ĞÂµÄ¸÷È¡ËùĞèÈÎÎñ.")
    Talk(1, "no", "²Ü±¦: Õâ´ÎÎÒĞèÒªµÄÊÇ<color=green>" .. n .. "." .. str .. "<c>!")
end

function itemrenwu_coin()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(302)
    MsgBox("²Ü±¦: NÕu ng­¬i cã thÓ ®­a ta <c=g>" .. Cfs .. " Th«ng B¶o(ThÎ Kim DËt)<c>, ÎÒ»áÈÃÄã½ñÌìÔÙ´Î»ñµÃ½ÓÊÜ¸÷È¡ËùĞèµÄ»ú»á. Ng­¬i muèn nhËn lÊy c¬ héi nµy chø?", "itemrenwu_coin_yes", "no")
end
function itemrenwu_coin_yes()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(302)
    if (GetIBItemPoint(8, 1316, 6) >= Cv) then
        if (CostIBItemPoint(8, 1316, 6, Cv) == 0) then
            Talk(1, "no", "²Ü±¦: KhÊu trõ ®iÓm ThÎ Kim DËt thÊt b¹i.")
            return
        end

        if (itemrenwu_normal() ~= 1) then
            WriteLog("[¸÷È¡ËùĞè][ThÎ Kim DËt][" .. Cfs .. " Th«ng B¶o] thÊt b¹i")
            return 0
        end
        Msg2Player("Ng­¬i ®­a " .. Cfs .. " Th«ng B¶o cho ²Ü±¦, nhËn ®­îc ¸÷È¡ËùĞè c¬ héi!")
        WriteLog("[¸÷È¡ËùĞè][ThÎ Kim DËt][" .. Cfs .. " Th«ng B¶o]")
    else
        MsgBox("²Ü±¦: Xin lçi, trªn ng­êi ThÎ Kim DËt sè d­ kh«ng ®ñ.", "no")
    end
end

function itemrenwu_coin1_yes()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(302)
    local i = FindAValidIBItem(8, 206, 5, 0)
    if (i ~= 0) then
        if (itemrenwu_normal() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Ng­¬i ®­a Thiªn Tiªn Thuû cho ½ğ¹â½£ÏÉ, nhËn ®­îc ¸÷È¡ËùĞè c¬ héi!")
        WriteLog("[¸÷È¡ËùĞè][Thiªn Tiªn Thuû]")
    elseif (GetCoin() >= Cv) then
        if (itemrenwu_normal() ~= 1) then
            return 0
        end

        CostCoinByIdx(302)
        Msg2Player("Ng­¬i ®­a " .. Cfs .. " Th«ng B¶o cho ½ğ¹â½£ÏÉ, nhËn ®­îc ¸÷È¡ËùĞè c¬ héi!")
        WriteLog("[¸÷È¡ËùĞè][" .. Cfs .. " Th«ng B¶o]")
    else
        MsgBox("½ğ¹â½£ÏÉ: Xin lçi, trªn ng­êi Thiªn Tiªn Thuû hoÆc Th«ng B¶o sè d­ kh«ng ®ñ.", "no")
    end
end

function offlineTotimes()
    local localday = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = math.mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = math.floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (math.mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function payMoneyfree()
    local m = 2000 * GetPlayerExtLevel()
    return m
end

function yes_freefsb()
    CloseDialog()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 247) + 1
    if (thisday ~= GetTaskByte(2258, 1)) then
        Talk(1, "no", "Ng­¬i ch­a nhËn nhiÖm vô nµo cho ngµy h«m nay, kh«ng cÇn n¹p tµi ®Ó tu luyÖn.")
        return 0
    end

    if (GetTaskByte(2259, 2) > 0) then
        itemrenwu_normalyes()
        return 1
    end

    local addtimes = GetTaskByte(2258, 3) + 1
    if (GetTaskByte(1477, 3) < addtimes) then
        Talk(1, "no", "²Ü±¦: C¬ héi N¹p tµi tu luyÖn hiÖn t¹i kh«ng ®ñ. NÕu ngµi cã viÖc bËn, ph¶i t¹m tho¸t khái Phong ThÇn nh­ng lo l¾ng viÖc tu luyÖn bŞ chËm l¹i, Ta sÏ tÆng ngµi c¬ héi <c=g>N¹p tµi tu luyÖn<c> h·y quı träng!")
        return 0
    end

    local apm = payMoneyfree()
    if (GetCash() < apm) then
        Talk(1, "no", "²Ü±¦: TiÒn phİ b¸o danh cña ng­¬i ch­a ®ñ " .. apm .. ", ta kh«ng thÓ giao nhiÖm vô lŞch luyÖn cho ng­¬i.")
        return 0
    end

    Pay(apm)

    TaskNote(126, 1)
    SetTaskByte(2258, 3, addtimes)
    SetTaskByte(2258, 4, 1)
    SetTaskByte(2259, 1, 100)
    itemrenwu_normalyes()

    Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tİch lòy")
    Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø " .. addtimes .. " nhiÖm vô ¸÷È¡ËùĞè bæ sung.")
end


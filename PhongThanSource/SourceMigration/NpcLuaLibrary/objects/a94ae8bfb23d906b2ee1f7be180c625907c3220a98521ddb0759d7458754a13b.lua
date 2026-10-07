--description: ĞÂÊÖÖ¸µ¼-³ç³Ç°ïÖúNPC
--author: yichuan
--date: 2004/5/14

--³õ³öÃ©Â®ÈÎÎñ±äÁ¿
Task_NewPlayer = 1067
Task_Dialog = 140
--function main()
--	MsgBox("<c=g>»¶Ó­ÄãÀ´µ½·âÉñ°ñÊÀ½ç!<c>\n\n<c=yel>³õ³öÃ©Â®<c>:×÷Îªò¿ÓÈÄ¹µÄĞÂÊÖÄã¿ÉÒª¶àÑ§Ï°ºÃºÃÀúÁ·Ò»·¬°¡£¬ÏÖÔÚÄã¿ÉÒÔÈ¥ÕÒ<c=r>ÉÙê»<c>,È¥¿´¿´ËûÓĞÊ²Ã´ÊÂÇé¡£ ","OK","no")
--end;

-- AS GaoJingwei at 090728 
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

    --³õ³öÃ©Â®
    if (GetLevel() >= 1) and (GetPlayerType() == 2) then
        if (GetLevel() - 1 <= 5) then
            --½ğÉ«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 0
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


function main()
    AddNormalItem(6, 1, 748, 0, 0, 0)
    AddNormalItemBind(8, 133, 0, 0, 0, 0, 1)
    TopMessage("B¹n nhËn ®­îc <c=g>Tói B¸ch Phóc<c>")
    Msg2Player("B¹n nhËn ®­îc Tói B¸ch Phóc")
    Msg2Player("B¹n nhËn ®­îc ThÇn CÈu Phï")
    SendTextMailToSelf(4, "<c=r>Chµo mõng quı kh¸ch!<c>", " Chµo mõng quı kh¸ch ®Õn víi thÕ giíi Phong ThÇn B¶ng!...Xin th­êng xuyªn nhÊn phİm <c=r>F1<c> vµ <c=r>F11<c> ®Ó xem h­íng dÉn nhiÖm vô…§Õn cÊp 15 cã thÓ b¸i ng­êi trªn cÊp 50 lµm S­ phô, sÏ gióp b¹n nhanh chãng hoµn thiÖn n¨ng lùc")
    SetTask(Task_Dialog, 0)
    MsgBox("Hoan nghªnh b¹n ®Õn víi <c=yel>ThÕ giíi Phong ThÇn B¶ng<c>! Trong thêi gian ho¹t ®éng, nh©n vËt míi t¹o ®Òu nhËn ®­îc 1 <c=g>Tói B¸ch Phóc<c>, NhÊn F4 më hµnh trang, nhÊp chuét ph¶i vµo <c=g>Tói B¸ch Phóc<c> cã thÓ kh¸m ph¸ nhiÒu bİ mËt thó vŞ!", "newplayer")
end;

--function yes()
--	MsgBox("ÏÖÔÚµÄÄã¿ÉÒÔÁ¢¿ÌÈ¥ÕÒ<c=yel>Ò½Éú</c>½ÓÊÜ<c=g>Ê¹ÃüÕÙ»½</c>ÈÎÎñ£¬ÕÒÒ½ÉúÇë°´<c=r>Tab</c>·Å´óÓÒÉÏ½ÇµØÍ¼¡£Ñ°Çó¸ü¶à°ïÖúÇë<color=green>°´F1²ì¿´Ïà¹ØĞÅÏ¢<color>¡£","no")
--end;

--function no()
--		CloseDialog()
--end;

function newplayer()
    MsgBox(11711, "OK", "close")
end;

function OK()
    SetTask(Task_NewPlayer, 1)
    TaskNote(1000, 0)
    Talk(1, "close", 11712)
    --AS GaoJingwei 090808
    RefreshAllNpcTask()
    --AE GaoJingwei 090808
    --AS GaoJingwei 090808
    RefreshAllNpcTask()
    --AE GaoJingwei 090808
end;

function no()
    CloseDialog()
    if (GetTask(Task_Dialog) == 0) then
        newplayer()
        SetTask(Task_Dialog, 1)
    else
        CloseDialog()
        SetTask(Task_Dialog, 0)
    end ;
end;

function close()
    CloseDialog()
end;

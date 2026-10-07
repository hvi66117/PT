--description: ÀÈ∆¨µ„
--author: liuzhiqiang
--date: 2009/07/28

Task_Buff_Time = 1518  --º«¬ºÕÊº“ π”√≥˙Õ∑º”buffµƒ ±º‰
Global_Random_Chaoge = 243 --≥Ø∏ËÀÈ∆¨»›∆˜
Global_Random_Muye = 244 --ƒ¡“∞ÀÈ∆¨»›∆˜
Global_Random_Chentangguan = 247 --≥¬Ã¡πÿÀÈ∆¨»›∆˜
Global_Random_Mengjin = 248 --√œΩÚÀÈ∆¨»›∆˜

--AS GaoJingwei 090803
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 090803

function main()
    if (HaveIBBuff(756) == 0) then
        Msg2Player("Bπn kh´ng sˆ dÙng CuËc, kh´ng th” Æµo vÀt nµy!")
        return
    end

    local mapid, x, y = GetWorldPos()  --ÕÊº“µ±«∞µƒŒª÷√
    local npcMapid, npcx, npcy = GetNpcWorldPos(DialogNpcIdx) --ªÒ»°npcµƒŒª÷√
    local distance = floor(((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32) --ÕÊº“”Î…≥ªÍµƒæ‡¿Î
    if (distance > 300) then
        Msg2Player("Bπn c∏ch n¨i c«n Æµo qu∏ xa, kh´ng th” t«m b∂o")
        return
    end

    local preTime = GetTask(Task_Buff_Time)
    local buffTime = LocalSystemTime() - preTime
    if (GetNpcTask(DialogNpcIdx, 1) ~= 1) then
        Msg2Player("ßµo trÛng Æ∏, ÆÈ c¯ng CuËc gi∂m 20 gi©y")
        TopMessage("ßµo trÛng Æ∏")
        buffTime = 1800 - buffTime - 20
        SetTask(Task_Buff_Time, preTime - 20)
        RemoveIBBuff(756)
        if (buffTime > 0) then
            AddIBBuff(756, buffTime)
        end
        return
    end

    local rand = random(1, 100)
    local fragment_idx = 0

    if (npcMapid == 21) then
        if (GetGlobalValueWord(Global_Random_Chaoge, 1) == 0) then
            rand = 1
        elseif (GetGlobalValueWord(Global_Random_Chaoge, 2) == 0) then
            rand = 31
        end

        if (rand <= 30) then
            fragment_idx = AddNpc(1200, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n trung")
            SetNpcTask(fragment_idx, 1, 2)
            local remainZhong = GetGlobalValueWord(Global_Random_Chaoge, 2)
            remainZhong = remainZhong - 1
            SetGlobalValueWord(Global_Random_Chaoge, 2, remainZhong)
        else
            fragment_idx = AddNpc(1199, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n nh·")
            SetNpcTask(fragment_idx, 1, 1)
            local remainXiao = GetGlobalValueWord(Global_Random_Chaoge, 1)
            remainXiao = remainXiao - 1
            SetGlobalValueWord(Global_Random_Chaoge, 1, remainXiao)
        end
    elseif (npcMapid == 18) then
        --delete by luoyixuan
        --		if( GetGlobalValueWord( Global_Random_Muye, 1 ) == 0 ) then
        --			rand = 1
        --		elseif( GetGlobalValueWord( Global_Random_Muye, 2 ) == 0 ) then
        --			rand = 31
        --		end
        --if ( rand > 20 ) then
        --fragment_idx = AddNpc( 1199, 1, SubWorld, npcx*32, npcy*32 )
        --SetNpcName( fragment_idx, "–°ÀÈ∆¨" )
        --SetNpcTask( fragment_idx, 1, 1 )
        --local  remainXiao = GetGlobalValueWord( Global_Random_Muye, 1 )
        --remainXiao = remainXiao - 1
        --SetGlobalValueWord( Global_Random_Muye, 1, remainXiao )

        --else
        --delete by luoyixuan
        local rand1 = random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n c˘c lÌn")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" tπi <c=g>MÙc D∑ (" .. floor(npcx / 8) .. "," .. floor(npcy / 16) .. ")<c> ph∏t hi÷n ra To∏i phi’n c˘c lÌn, m‰i ng≠Íi h∑y mau Æ’n Æ„ tranh Æoπt.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n lÌn")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Muye, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Muye, 2, remainBig)
        --		end
    elseif (npcMapid == 65) then
        --delete by luoyixuan
        --		if( GetGlobalValueWord( Global_Random_Muye, 1 ) == 0 ) then
        --			rand = 1
        --		elseif( GetGlobalValueWord( Global_Random_Muye, 2 ) == 0 ) then
        --			rand = 31
        --		end
        --if ( rand > 20 ) then
        --fragment_idx = AddNpc( 1199, 1, SubWorld, npcx*32, npcy*32 )
        --SetNpcName( fragment_idx, "–°ÀÈ∆¨" )
        --SetNpcTask( fragment_idx, 1, 1 )
        --local  remainXiao = GetGlobalValueWord( Global_Random_Muye, 1 )
        --remainXiao = remainXiao - 1
        --SetGlobalValueWord( Global_Random_Muye, 1, remainXiao )

        --else
        --delete by luoyixuan
        local rand1 = random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n c˘c lÌn")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" tπi <c=g>Tr«n ß≠Íng (" .. floor(npcx / 8) .. "," .. floor(npcy / 16) .. ")<c> ph∏t hi÷n ra To∏i phi’n c˘c lÌn, m‰i ng≠Íi h∑y mau Æ’n Æ„ tranh Æoπt.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n lÌn")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Chentangguan, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Chentangguan, 2, remainBig)
        --	end
    elseif (npcMapid == 15) then
        --delete by luoyixuan
        --		if( GetGlobalValueWord( Global_Random_Muye, 1 ) == 0 ) then
        --			rand = 1
        --		elseif( GetGlobalValueWord( Global_Random_Muye, 2 ) == 0 ) then
        --			rand = 31
        --		end
        --if ( rand > 20 ) then
        --fragment_idx = AddNpc( 1199, 1, SubWorld, npcx*32, npcy*32 )
        --SetNpcName( fragment_idx, "–°ÀÈ∆¨" )
        --SetNpcTask( fragment_idx, 1, 1 )
        --local  remainXiao = GetGlobalValueWord( Global_Random_Muye, 1 )
        --remainXiao = remainXiao - 1
        --SetGlobalValueWord( Global_Random_Muye, 1, remainXiao )

        --else
        --delete by luoyixuan
        local rand1 = random(1, 100)
        if (rand1 <= 10) then
            fragment_idx = AddNpc(1202, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n c˘c lÌn")
            SetNpcTask(fragment_idx, 1, 4)
            AddGlobalCountNews(" tπi <c=g>Mπnh T©n (" .. floor(npcx / 8) .. "," .. floor(npcy / 16) .. ")<c> ph∏t hi÷n ra To∏i phi’n c˘c lÌn, m‰i ng≠Íi h∑y mau Æ’n Æ„ tranh Æoπt.", 1)
        else
            fragment_idx = AddNpc(1201, 1, SubWorld, npcx * 32, npcy * 32)
            SetNpcName(fragment_idx, "To∏i phi’n lÌn")
            SetNpcTask(fragment_idx, 1, 3)
        end
        local remainBig = GetGlobalValueWord(Global_Random_Mengjin, 2)
        remainBig = remainBig - 1
        SetGlobalValueWord(Global_Random_Mengjin, 2, remainBig)
        --		end
    end

    SetNpcScript(fragment_idx, "\\script\\ªÓ∂ØΩ≈±æ\\ÀÈ∆¨.lua")

    local exist_num = GetNpcTask(DialogNpcIdx, 2)
    exist_num = exist_num - 1
    SetNpcTask(fragment_idx, 2, exist_num)

    local H, M, S = GetHMS()
    local nowTime = 0
    if (H >= 21) then
        nowTime = mod(LocalSystemTime(), 86400) - (60 * 60 * 21)  --¿Î21µ„µƒ ±º‰“‘√Îº«
    end
    local remainTime = 10740 - nowTime
    SetNpcTimer(fragment_idx, "\\script\\ontimer\\ÀÈ∆¨œ˚Õˆ.lua", remainTime)

    DelNpc(DialogNpcIdx)
end

function no()
    CloseDialog()
end

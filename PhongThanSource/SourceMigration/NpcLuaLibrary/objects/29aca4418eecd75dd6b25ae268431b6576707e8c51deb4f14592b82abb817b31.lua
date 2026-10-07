Escort_Food_Record = 1972

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(Escort_Food_Record, 1) <= 10 or GetTaskByte(959, 1) ~= 1) then
        Talk(1, "no", "Th«n B› ∏p VÀn Quan: N’u ng≠¨i tﬂ mﬂ v“ th©n phÀn cÒa ta th◊ kh´ng c«n h·i, H∑y trÎ lπi t◊m ta khi c„ ÆÒ dÚng kh› hÈ tËng Xe L≠¨ng Cao C p! Ta nh t Æﬁnh sœ kh´ng Æ” ng≠¨i th t v‰ng!!")
        return
    end
    if (GetTaskByte(Escort_Food_Record, 2) == 1) then
        Talk(1, "no", "Th«n B› ∏p VÀn Quan: Cﬂn kh´ng mau Æi hoµn thµnh nhi÷m vÙ!")
        return
    end
    if (GetTask(1052) ~= 0) then
        Talk(1, "no", "Th«n B› ∏p VÀn Quan: Xe l≠¨ng cÒa ng≠¨i kh´ng c„ l≠¨ng th˘c, Æıng t≠Îng ta kh´ng bi’t!")
        return
    end

    local opra = {
        "ß©y lµ 3 c∏i B∏t Hoang Tinh Hoa/GiveItem",
        "ß©y lµ 100 vπn bπc/GiveMoney",
        "ß≠Óc rÂi, l«n kh∏c n„i sau/no",
    }
    Say("Th«n B› ∏p VÀn Quan: Ta r t kh©m phÙc dÚng kh› cÒa nhµ ng≠¨i! Hi÷n ta c„ th” t®ng ph«n th≠Îng hoµn thµnh VÀn l≠¨ng Cao c p cÒa ng≠¨i th™m 100%! Nh≠ng c«n cho ta 3 c∏i B∏t Hoang Tinh Hoa ho∆c 100 vπn bπc, ng≠¨i nguy÷n ˝ cho ta sao?", table.getn(opra), opra)
end

function GiveItem()
    receive(1)
end

function GiveMoney()
    receive(2)
end

function receive(ntype)
    no()
    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex == 0) or (GetTaskByte(959, 1) ~= 1) then
        Talk(1, "no", 13100)
    elseif (GetTaskByte(959, 1) == 1) and (GetTaskByte(Escort_Food_Record, 2) == 0) then
        local bounty, a, b, c, carriageindex = GetTGuardInfo(guardindex)

        local insideindex = IsPlayerInsideWeapon(PlayerIndex)
        if (insideindex == carriageindex) and (carriageindex ~= 0) then
            if (ntype == 1) then

                if (HaveNormalItem(3, 1229, 0, 0) < 3) then
                    Talk(1, "no", "ThÀt xin lÁi, ng≠¨i kh´ng c„ ÆÒ 3 B∏t Hoang Tinh Hoa")
                    return
                end
                for i = 1, 3 do
                    DelNormalItem(3, 1229, 0, 0)
                end
                WriteLog("[VÀn l≠¨ng Cao c p][Th«n B› ∏p VÀn Quan] nÈp B∏t Hoang Tinh Hoa")
            elseif (ntype == 2) then

                if (GetCash() < 1000000) then
                    Talk(1, "no", "Ng≠¨i ch≠a ÆÒ ti“n sao!")
                    return
                end
                Pay(1000000)
                WriteLog("[VÀn l≠¨ng Cao c p][Th«n B› ∏p VÀn Quan] nÈp ti“n")
            else
                Talk(1, "no", "Anh hÔng, ng≠¨i Æ∑ ch‰n c∏ch nµo vÀy....")
                return
            end

            SetTaskByte(Escort_Food_Record, 2, 1)
            Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> t◊m Æ≠Óc Th«n B› ∏p VÀn Quan, hoµn thµnh VÀn l≠¨ng Cao c p sœ nhÀn Æ≠Óc g p Æ´i ph«n th≠Îng</bc>")
            Talk(1, "no", "Th«n B› ∏p VÀn Quan: R t tËt, c¯ th’ ng≠¨i Æi t◊m Tr≠¨ng Qu’ Ph≠¨ng hoµn thµnh VÀn l≠¨ng Cao c p, ph«n th≠Îng sœ <c=g>t®ng 100%<c>!")
        else
            Talk(1, "no", 13086)
        end ;
    else
        Talk(1, "no", 13087)
    end ;
end;

function no()
    CloseDialog()
end

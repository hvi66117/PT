--description:95º∂∆∑≈∆Œ‰∆˜¿Ò∞¸
--author: yaoxin
--date:2007/12/10

Task_item = {
    [0] = { [1] = { 15, "Ch› t´n" }, [2] = { 18, "Phi™u Mi‘u" } },
    [1] = { [1] = { 21, "Tam giÌi" } },
    [2] = { [1] = { 24, "ßa t◊nh" } },
}
function main()
    local n = GetPlayerType()
    if (GetPlayerType() == 0) then
        local changduan = {
            { "VÚ kh› ngæn Æ∆c bi÷t", "short"; show = 1 },
            { "VÚ kh› dµi Æ∆c bi÷t", "long"; show = 1 }
        }
        SayTask("ß©y lµ l‘ bao VÚ kh› cao c p c p 95, xin ch‰n muËn nhÀn <c=g>Binh kh› dµi ho∆c Binh kh› ngæn<c>.", changduan)
    else
        weaponString(n, 1)
    end
end;

function short()
    weaponString(0, 1)
end

function long()
    weaponString(0, 2)
end

function weaponString(a, b)
    --a÷∞“µ, b≥§∂Ã,
    CloseDialog()
    if (HaveNormalItem(6, 1, 333, 0) > 0) then
        DelNormalItem(6, 1, 333, 0)
        local idx = Task_item[a][b][1]
        local str = Task_item[a][b][2]
        AddNormalItem(0, 0, idx, 1, 0, 0)
        Msg2Player("Bπn nhÀn Æ≠Óc VÚ kh› cao c p c p 95" .. str)
        TopMessage("Bπn nhÀn Æ≠Óc <c=g>" .. str .. "<c>")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> sau khi t›ch lÚy Æi”m th≠Îng, Æ∑ may mæn nhÀn Æ≠Óc VÚ kh› cao c p c p 95 <c=g>" .. str .. "<c>! Xin chÛc mıng!", 20)
    else
        local strMsg = "Bπn nhÀn Æ≠Óc VÚ kh› cao c p c p 95" .. GetName()
        WriteLog(strMsg)
    end
end

function no()
    CloseDialog()
end;
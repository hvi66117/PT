--description:12ÔÂ³ä¿¨,3¼¶»ñµÃ³È×°Ò»¼þ
--author: yaoxin
--date:2007/12/10

Task_item = {--×°±¸ÀàÐÍ ³È×°IdºÅ Ãû³Æ
    [0] = { [1] = { 7, 1, "Ph¸ Qu©n*Tr¶m Long Kh«i" }, [2] = { 9, 301, "Ph¸ Qu©n*Tr¶m Long phi phong" } },
    [1] = { [1] = { 7, 2, "Ph¸ Qu©n*Nguyªn Thñy Qu¸n" }, [2] = { 9, 302, "Ph¸ Qu©n*Nguyªn Thñy lÖnh" } },
    [2] = { [1] = { 7, 3, "Ph¸ Qu©n*ThÇn ¦ng Trô" }, [2] = { 9, 303, "Ph¸ Qu©n*ThÇn ¦ng kÕt" } },
}

function main()
    local tasks = {
        { "Ph¸ Qu©n*Tr¶m Long Kh«i", "pojuntou"; show = 0 },
        { "Ph¸ Qu©n*Tr¶m Long phi phong", "pojunpei"; show = 0 },
        { "Ph¸ Qu©n*Nguyªn Thñy Qu¸n", "pojuntou"; show = 0 },
        { "Ph¸ Qu©n*Nguyªn Thñy lÖnh", "pojunpei"; show = 0 },
        { "Ph¸ Qu©n*ThÇn ¦ng Trô", "pojuntou"; show = 0 },
        { "Ph¸ Qu©n*ThÇn ¦ng kÕt", "pojunpei"; show = 0 },
    }

    local n = GetPlayerType()
    if (n == 0) then
        tasks[1].show = 1
        tasks[2].show = 1
    elseif (n == 1) then
        tasks[3].show = 1
        tasks[4].show = 1
    else
        tasks[5].show = 1
        tasks[6].show = 1
    end

    SayTask("Xin h·y chän <c=g>trang bÞ Cam<c> d­íi ®©y!", tasks)
end;

function pojuntou()
    local n = GetPlayerType()
    pojun(n, 1)
end

function pojunpei()
    local n = GetPlayerType()
    pojun(n, 2)
end

function pojun(z, k)
    -- Ö°Òµ£¬Í·»òÅä,
    CloseDialog()
    if (HaveNormalItem(6, 1, 334, 0) > 0) then
        local a = Task_item[z][k][1]
        local id = Task_item[z][k][2]
        local str = Task_item[z][k][3]
        DelNormalItem(6, 1, 334, 0)
        AddNormalItem3(0, a, z, 9, 0, 0, id)

        Msg2Player("B¹n nh©n ®­îc" .. str)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. str .. "<c>")
    else
        local strMsg = "Më tói trang bÞ Cam cÊp 3" .. GetName()
        WriteLog(strMsg)
    end
end

function no()
    CloseDialog()
end;

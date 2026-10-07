-- PHONG THAN PROJECT BEGINNER GUIDE
-- This is a project-owned gameplay extension, not an original VNG Lua file.
-- ASCII text is intentional for the legacy Lua runtime.

PHONGTHAN_TASK_GIAPSI_SET = 250
PHONGTHAN_TASK_MOUNT = 251

-- Only maps with verified original VNG Region_C and Region_S are enabled.
PHONGTHAN_LIVE_MAPS = {
    {1002,1624,3184,"Sung Thanh dai doanh"},
    {1003,1719,3184,"Ngoc Hu cung"},
    {1004,1576,3216,"Xi Vuu Mo"},
    {1014,1496,3376,"Dong Quan"},
    {1016,1544,3312,"Tam Son"},
    {1020,1464,3120,"Tay Ky"},
    {1021,1736,3088,"Trieu Ca"},
    {1024,1640,3152,"Phong Than"},
    {1038,1800,3056,"Long Cung"},
    {1052,1624,3120,"Dieu Tri"}
}

PHONGTHAN_MAPS_PER_PAGE = 5

function GetDesc(nItemIdx)
    return "<color=yellow>Click phai de mo cam nang.<color><enter>Cho phep dich chuyen trong 10 ban do VNG dang hoat dong va nhan bo trang bi Giap Si thu nghiem."
end

function main(nItemIdx)
    Say("<color=gold>Cam nang tan thu - Phong Than<color>\nChon chuc nang can su dung:", 5,
        "Xa phu di dong/PhongThanMapRouter(1)",
        "Nhan bo trang bi Giap Si/PhongThanGiveGiapSiSet(0)",
        "Nhan thu cuoi Xich Diem Ho/PhongThanGiveMount(0)",
        "Nhan ca bo trang bi va thu cuoi/PhongThanGiveStarterPack(0)",
        "Dong/no")
end

function PhongThanMapRouter(nPage)
    if nPage == nil or nPage < 1 then nPage = 1 end
    local nFirst = (nPage - 1) * PHONGTHAN_MAPS_PER_PAGE + 1
    if nFirst > getn(PHONGTHAN_LIVE_MAPS) then
        nPage = 1
        nFirst = 1
    end
    local nLast = nFirst + PHONGTHAN_MAPS_PER_PAGE - 1
    if nLast > getn(PHONGTHAN_LIVE_MAPS) then nLast = getn(PHONGTHAN_LIVE_MAPS) end
    local tbSay = {}
    local i = 0

    for i = nFirst, nLast do
        tinsert(tbSay, PHONGTHAN_LIVE_MAPS[i][4].."/PhongThanMapGo("..i..")")
    end
    if nPage > 1 then
        tinsert(tbSay, "Trang truoc/PhongThanMapRouter("..(nPage - 1)..")")
    end
    if nLast < getn(PHONGTHAN_LIVE_MAPS) then
        tinsert(tbSay, "Trang sau/PhongThanMapRouter("..(nPage + 1)..")")
    end
    tinsert(tbSay, "Quay lai/main")
    tinsert(tbSay, "Dong/no")
    Say("Xa phu di dong - trang "..nPage, getn(tbSay), tbSay)
end

function PhongThanMapGo(nIndex)
    if nIndex == nil or nIndex < 1 or nIndex > getn(PHONGTHAN_LIVE_MAPS) then
        Msg2Player("Ban do khong nam trong danh sach dang hoat dong.")
        return
    end
    local tbMap = PHONGTHAN_LIVE_MAPS[nIndex]
    SetFightState(0)
    NewWorld(tbMap[1], tbMap[2], tbMap[3])
end

function PhongThanAddVngItem(nDetail, nParticular, nLevel, nSeries)
    local nItemIdx = AddItem(0, 0, nDetail, nParticular, nLevel, nSeries, 0, 0)
    if nItemIdx == nil or nItemIdx <= 0 then return 0 end
    local nAdded = AddItemID(nItemIdx, 3, 0)
    if nAdded == nil or nAdded <= 0 then return 0 end
    return 1
end

function PhongThanGiveGiapSiSet(bSilent)
    if GetTask(PHONGTHAN_TASK_GIAPSI_SET) == 1 then
        if bSilent ~= 1 then Msg2Player("Ban da nhan bo trang bi Giap Si.") end
        return 1
    end
    if CheckRoom(4, 4) == 0 then
        Msg2Player("Hanh trang khong du cho trong. Hay de trong it nhat 16 o roi nhan lai.")
        return 0
    end

    -- Verified VNG item\001 tuples: weapon, armor, helmet, belt, boots, cape.
    if PhongThanAddVngItem(0, 9, 10, 5) == 0 then return 0 end
    if PhongThanAddVngItem(2, 0, 10, 5) == 0 then return 0 end
    if PhongThanAddVngItem(7, 0, 10, 5) == 0 then return 0 end
    if PhongThanAddVngItem(6, 0, 10, 5) == 0 then return 0 end
    if PhongThanAddVngItem(5, 0, 10, 5) == 0 then return 0 end
    if PhongThanAddVngItem(9, 0, 10, 5) == 0 then return 0 end
    SetTask(PHONGTHAN_TASK_GIAPSI_SET, 1)
    if bSilent ~= 1 then Msg2Player("Da nhan bo trang bi va vu khi Giap Si cap 10.") end
    return 1
end

function PhongThanGiveMount(bSilent)
    if GetTask(PHONGTHAN_TASK_MOUNT) == 1 then
        if bSilent ~= 1 then Msg2Player("Ban da nhan thu cuoi Xich Diem Ho.") end
        return 1
    end
    if CheckRoom(2, 2) == 0 then
        Msg2Player("Hanh trang khong du cho trong de nhan thu cuoi.")
        return 0
    end

    -- Verified VNG horse tuple: detail 10, particular 0, level 10.
    if PhongThanAddVngItem(10, 0, 10, 0) == 0 then return 0 end
    SetTask(PHONGTHAN_TASK_MOUNT, 1)
    if bSilent ~= 1 then Msg2Player("Da nhan thu cuoi Xich Diem Ho.") end
    return 1
end

function PhongThanGiveStarterPack(bSilent)
    local nSetResult = PhongThanGiveGiapSiSet(bSilent)
    if nSetResult == 0 then return 0 end
    return PhongThanGiveMount(bSilent)
end

function no()
end

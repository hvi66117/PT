-- AUTHORED NPC 1075_00; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1075 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Yen Thuc Di - Nguc Phap son (233/214)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi chuoi Thap Nhi Nhan Ngau tai Nguc Phap Son. Chua trieu hoi hoa than hay danh dau hoan tat khi chua co du luong nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Yen Ba Ich (235/214); Tu Hanh Su Ma (235/209); Tu Hanh Su Tien (230/223); Mat Tham Ma Gioi (224/209); Mat Tham Tien Gioi (241/226)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

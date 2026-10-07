-- AUTHORED NPC 1075_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1075 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su Ma - Nguc Phap son (235/209)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su cua phe Ma. Chi dan trong vung Tien Ma; ban tai dung khong chuyen phe hay tieu hao vat pham tu luyen.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Yen Ba Ich (235/214); Yen Thuc Di (233/214); Mat Tham Ma Gioi (224/209); Tu Hanh Su Tien (230/223); Mat Tham Tien Gioi (241/226)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

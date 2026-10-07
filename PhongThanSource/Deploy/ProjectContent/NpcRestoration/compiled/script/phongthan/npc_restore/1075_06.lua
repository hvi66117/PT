-- AUTHORED NPC 1075_06; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1075 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tieu Loi - Nguc Phap son (261/208)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Diem Tieu Loi trong danh muc nhiem vu. Ban tai dung la NPC doi thoai de kiem tra vi tri, chua mo chien dau hay rot do.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su Ma (235/209); Yen Ba Ich (235/214); Mat Tham Tien Gioi (241/226); Yen Thuc Di (233/214); Tu Hanh Su Tien (230/223)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

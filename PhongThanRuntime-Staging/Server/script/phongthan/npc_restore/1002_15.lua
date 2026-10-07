-- AUTHORED NPC 1002_15; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tan Thu Thi Luyen - Sung Thanh doanh (200/199)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Huong dan tan thu: F3 xem thuoc tinh, F4 mo hanh trang, F5 xem ky nang. Tim NPC mon phai de tiep tuc nhiem vu goc.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thuong Nhan Tay Vuc (199/199); Sinh Hoat Su (199/200); Chuyen Sinh Lao Lao (202/199); Thu Kho (202/198); Lao Rua (202/197)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

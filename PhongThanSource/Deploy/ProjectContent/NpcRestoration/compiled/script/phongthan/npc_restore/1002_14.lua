-- AUTHORED NPC 1002_14; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chuyen Sinh Lao Lao - Sung Thanh doanh (202/199)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi chuyen sinh. Thu tuc can dieu kien cap, nhiem vu va vat pham dung phien ban; ban tai dung chua doi cap hoac thu nguyen lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Thu Kho (202/198); Tan Thu Thi Luyen (200/199); Lao Rua (202/197); Thuong Nhan Tay Vuc (199/199); Sinh Hoat Su (199/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

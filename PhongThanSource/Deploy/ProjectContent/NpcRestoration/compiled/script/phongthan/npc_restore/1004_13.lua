-- AUTHORED NPC 1004_13; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thuong Nhan Tay Vuc - Xi Vuu Mo (200/200)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Thuong nhan trong danh muc tan thu. Ban tai dung cung cap dia chi va tra cuu NPC; chua gan cong thuc thu cuoi cua NPC Tay Ky vao day.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Sinh Hoat Su (200/200); Lao Rua (200/202); Thieu Hao (198/204); Hau Tho (202/204); Chuyen Sinh Lao Lao (196/202)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

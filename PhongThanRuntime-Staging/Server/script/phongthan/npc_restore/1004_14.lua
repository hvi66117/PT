-- AUTHORED NPC 1004_14; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ho Tro Tan Thu - Xi Vuu Mo (194/205)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Ho tro thao tac: mo F4 de kiem tra vat pham, click phai de su dung hoac trang bi. Danh sach trong map giup tim nguoi giao nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Phong Ba (195/204); Chuc Dung (193/204); Cong Cong (192/204); Thuong Diem (195/208); Chuyen Sinh Lao Lao (196/202)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

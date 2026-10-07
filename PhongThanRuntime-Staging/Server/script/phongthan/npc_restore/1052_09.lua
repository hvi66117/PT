-- AUTHORED NPC 1052_09; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1052 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Yen Van - Dieu Tri (197/197)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Tan Trung Lai. Khong dat lai cap, ky nang hay thuoc tinh nhan vat khi chua co bang quy tac duoc kiem chung.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Xich Tung Tu (195/196); Nu Oa Nuong Nuong (200/196); An An Tien Tu (195/200); NPC Trao Thuong (195/201); NPC Vang Bac Dong (192/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

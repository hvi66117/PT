-- AUTHORED NPC 1052_06; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1052 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("NPC Trao Thuong - Dieu Tri (195/201)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi trao thuong su kien. Khong cap qua khi chua co danh sach du dieu kien va moc thoi gian cua dot den bu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("An An Tien Tu (195/200); NPC Vang Bac Dong (192/200); Yen Van (197/197); Xich Tung Tu (195/196); NPC VIP (190/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

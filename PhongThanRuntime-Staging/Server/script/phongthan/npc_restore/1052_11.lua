-- AUTHORED NPC 1052_11; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1052 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Nguoi Than Bi 3 - Dieu Tri (186/188)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("NPC Nguoi Than Bi co vi tri thay doi theo dot hoat dong. Ban test dung vi tri da chot; chua mo lich xuat hien va phat thuong.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Xich Tung Tu (195/196); Thai Thuong Lao Quan (188/200); NPC VIP (190/200); Hong Ty (188/201); NPC Vang Bac Dong (192/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

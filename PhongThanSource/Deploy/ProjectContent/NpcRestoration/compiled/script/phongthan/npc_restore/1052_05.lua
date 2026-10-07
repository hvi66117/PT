-- AUTHORED NPC 1052_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1052 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("NPC Vang Bac Dong - Dieu Tri (192/200)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Diem Vang-Bac-Dong trong danh muc Dieu Tri. Chua xac minh bang quy doi nen khong thu vang, bac hay dong.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("NPC VIP (190/200); An An Tien Tu (195/200); NPC Trao Thuong (195/201); Thai Thuong Lao Quan (188/200); Hong Ty (188/201)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

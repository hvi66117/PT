-- AUTHORED NPC 1052_02; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1052 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thai Thuong Lao Quan - Dieu Tri (188/200)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi trang bi Tinh Quan. Chua bat nang cap vi can dung ma nguyen lieu, cap trang bi va cong thuc rieng cua VNG.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Hong Ty (188/201); NPC VIP (190/200); NPC Vang Bac Dong (192/200); An An Tien Tu (195/200); NPC Trao Thuong (195/201)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

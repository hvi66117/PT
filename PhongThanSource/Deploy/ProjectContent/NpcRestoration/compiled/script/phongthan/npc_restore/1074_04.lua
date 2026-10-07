-- AUTHORED NPC 1074_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1074 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Ly Nhau Ton Gia - Bat Chu Son (203/226)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Ton gia trong vung Bat Chu Son. Lua tai dung giu thong tin ten va vi tri, khong gan thuong chua xac minh.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su Ma (206/220); Ngo Chan Nhan (212/222); Tu Hanh Su Tien (215/222); Nam Minh Tu (219/232); Son Than Hong Bac (209/199)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

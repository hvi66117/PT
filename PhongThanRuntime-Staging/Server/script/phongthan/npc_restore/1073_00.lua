-- AUTHORED NPC 1073_00; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1073 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Cuu Thien Huyen Nu - Bat Chu Thien quan (249/203)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Do Kiep cap Tien Ma 30. Theo VNG can lich 20-22 gio, dieu kien Lien Dang va danh vong; ban test chua trieu hoi Nguyen Than.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Dac Ky (244/206); Lien Dang Ho Su (241/228); Tu Hanh Su Tien (249/236); Tao Bao (244/236); Tu Hanh Su Ma (201/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

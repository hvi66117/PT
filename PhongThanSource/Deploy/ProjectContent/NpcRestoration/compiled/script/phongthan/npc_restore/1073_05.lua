-- AUTHORED NPC 1073_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1073 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Dac Ky - Bat Chu Thien quan (244/206)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Nhan vat trong cac chuoi nhiem vu cua Phong Than. Doi thoai duoc phan biet theo map, khong gan lai nhiem vu Trieu Ca cho Bat Chu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Cuu Thien Huyen Nu (249/203); Lien Dang Ho Su (241/228); Tao Bao (244/236); Tu Hanh Su Tien (249/236); Tu Hanh Su Ma (201/200)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

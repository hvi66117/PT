-- AUTHORED NPC 1073_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1073 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su Ma - Bat Chu Thien quan (201/200)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tu Hanh Su cua phe Ma. Chi dan trong vung Tien Ma; ban tai dung khong chuyen phe hay tieu hao vat pham tu luyen.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Huyen Do Dai Phap Su (205/242); Dac Ky (244/206); Cuu Thien Huyen Nu (249/203); Lien Dang Ho Su (241/228); Tao Bao (244/236)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

-- AUTHORED NPC 1076_05; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1076 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Y Giap Tien - Thanh Dia (243/236)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Y Giap tai khu vuc phe Tien cua Ban Tuyen Thanh Dia. Giu muc chi dan rieng; chua cap vat pham nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Duoc Su Tien (239/238); Tu Hanh Su Tien (247/238); Khuong Ngu Tich (212/204); Duoc Su Ma (209/203); Y Giap Ma (210/201)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

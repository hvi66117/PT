-- AUTHORED NPC 1071_04; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1071 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Tiep Dan Chu - Chien truong (290/206)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tiep dan phe Chu. Chua mo vao tran neu khong co trang thai chien truong tuong ung.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tuong Linh Chu (242/190); Nguyen Soai (237/190); Tuong Linh Thuong (231/191); Tiep Dan Thuong (178/203)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

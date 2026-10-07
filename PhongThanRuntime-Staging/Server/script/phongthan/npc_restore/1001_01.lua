-- AUTHORED NPC 1001_01; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1001 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Bia Than phe Thuong - Phong Than dai (189/191)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Bia Than danh dau diem tuong tac cua phe Thuong tai Phong Than Dai. Lua moi chi cung cap thong tin phe va chi dan trong map.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Bia Than phe Chu (212/215)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

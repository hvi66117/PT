-- Minimal Phong Than protocol helpers used by the migrated runtime.
-- Map/NPC population is owned by Region_S and native server registries.

function PermitTrade()
    if GetFightState() ~= 0 then
        Msg2Player("Khong the giao dich khi dang chien dau.")
        return 0
    end
    return 1
end

function PermitSuperShop()
    if GetFightState() ~= 0 then
        Msg2Player("Khong the mo Ky Tran Cac khi dang chien dau.")
        return 0
    end
    NewSale(0, 1, 6, 96, 97, 98, 99, 100, 101)
    return 1
end

function no()
end

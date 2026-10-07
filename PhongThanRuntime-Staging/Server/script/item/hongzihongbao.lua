function main(sel)
    local lr = math.random(1, 100)
    if (lr <= 50) then
        AddNormalItemPile(3, 77, 0, 0, 0, 0)
        TopMessage(" B¹n nhËn ®­îc <c=g>1 m¶nh Hång Thñy Tinh<c>")
        Msg2Player(" B¹n nhËn ®­îc 1 m¶nh Hång Thñy Tinh!")
    elseif (lr <= 80) then
        AddNormalItemPile(3, 28, 0, 0, 0, 0)
        TopMessage(" B¹n nhËn ®­îc <c=g>1 Hång Thñy Tinh<c>")
        Msg2Player(" B¹n nhËn ®­îc 1 Hång Thñy Tinh!")
    else
        AddNormalItemPile(3, 79, 0, 0, 0, 0)
        TopMessage(" B¹n nhËn ®­îc <c=g>1 Hång B¶o Th¹ch<c>")
        Msg2Player(" B¹n nhËn ®­îc 1 Hång B¶o Th¹ch!")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më Hång Bao cña LÔ Quan nhËn ®­îc 1 <c=r>Hång B¶o Th¹ch<c>!", 3)
    end
end;

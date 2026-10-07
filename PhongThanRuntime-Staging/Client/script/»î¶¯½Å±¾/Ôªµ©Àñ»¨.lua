function main()

    if (HaveNormalItem(6, 1, 785, 0) > 0 or HaveNormalItemInQuick(6, 1, 785, 0) > 0) then
        if (DelNormalItem(6, 1, 785, 0) == 0) then
            DelNormalItemInQuick(6, 1, 785, 0)
        end
        PlayerCastSkill(1, 758, 1)
    end

end

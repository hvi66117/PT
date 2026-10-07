-- VNG MagicScript compatibility layer for the migrated item loader.
-- Mapped VNG tuples:
-- genre 6/detail 1/particular N -> runtime nature 0/genre 6/detail N;
-- genre 3/detail N/particular 0 -> runtime nature 0/genre 3/detail N.

function VngItemCompatParticular(nGenre, nDetail, nParticular)
    if nGenre ~= 6 or nDetail ~= 1 or nParticular == nil or nParticular <= 0 then
        return 0
    end
    return nParticular
end

function VngItemCompatRuntime(nGenre, nDetail, nParticular)
    if nGenre == 6 and nDetail == 1 and nParticular ~= nil and nParticular > 0 then
        return 6, nParticular
    end
    if nGenre == 3 and nDetail ~= nil and nDetail >= 0 and
        (nParticular == nil or nParticular == 0) then
        return 3, nDetail
    end
    return -1, -1
end

if HaveNormalItem == nil then
    function HaveNormalItem(nGenre, nDetail, nParticular, nLevel)
        local runtimeGenre, runtimeDetail = VngItemCompatRuntime(nGenre, nDetail, nParticular)
        if runtimeGenre < 0 then
            return 0
        end
        return GetItemCount(0, runtimeGenre, runtimeDetail)
    end
end

if DelNormalItem == nil then
    function DelNormalItem(nGenre, nDetail, nParticular, nLevel)
        local runtimeGenre, runtimeDetail = VngItemCompatRuntime(nGenre, nDetail, nParticular)
        if runtimeGenre < 0 then
            return 0
        end
        return DelItem(1, 0, runtimeGenre, runtimeDetail)
    end
end

if AddNormalItem == nil then
    function AddNormalItem(nGenre, nDetail, nParticular, nLevel, nSeries, nLuck)
        local runtimeGenre, runtimeDetail = VngItemCompatRuntime(nGenre, nDetail, nParticular)
        if runtimeGenre < 0 then
            Msg2Player("API AddNormalItem: loai vat pham nay chua duoc anh xa an toan.")
            return 0
        end
        if CalcFreeItemCellCount(1, 1, 0) <= 0 then
            Msg2Player("Hanh trang da day, vat pham chua duoc them.")
            return 0
        end

        local itemIndex = AddItem(0, runtimeGenre, runtimeDetail, 0, nLevel or 0, nSeries or 0, nLuck or 0)
        if itemIndex == nil or itemIndex <= 0 then
            return 0
        end
        -- Keep the newly-created index stable. The legacy AddItemIDStack path
        -- may merge into an existing stack and leave the returned index
        -- detached, which is unsafe for SetStackItem/SetItemBind callers.
        AddItemID(itemIndex, 0)
        return itemIndex
    end
end

if AddNormalItemBind == nil then
    function AddNormalItemBind(nGenre, nDetail, nParticular, nLevel, nSeries, nLuck, nBind)
        local itemIndex = AddNormalItem(nGenre, nDetail, nParticular, nLevel, nSeries, nLuck)
        if itemIndex > 0 and nBind ~= nil and nBind > 0 then
            LockItem(itemIndex, 0)
        end
        return itemIndex
    end
end

if DelItemByID == nil then
    function DelItemByID(nItemId, nCount)
        if nItemId == nil or nItemId <= 0 then
            return 0
        end
        if nCount == nil then
            nCount = 0
        end
        return RemoveItem(nItemId, nCount, 0)
    end
end

if SetItemBind == nil then
    function SetItemBind(nItemId, nBind)
        if nItemId == nil or nItemId <= 0 or nBind == nil or nBind <= 0 then
            return 0
        end
        return LockItem(nItemId, 0)
    end
end

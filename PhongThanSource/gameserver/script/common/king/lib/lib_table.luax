--- @class KsgTable
KsgTable = KsgTable or {}

KsgTable.MAX_COPY_LAYERS = 7

--- Count all items in the table
--- @param T table
--- @return number Total items
function KsgTable:Count(T)
    local nCount = 0
    if not T or 'table' ~= type(T) then
        return nCount
    end
    for _, _ in pairs(T) do
        nCount = nCount + 1
    end

    return nCount
end

--- Take a random value from the table
--- @param T table
--- @param bIsReturnKey? boolean
function KsgTable:Random(T, bIsReturnKey)
    local nRandomIndex = math.random(1, #T)
    local nIndex = 0
    for k, v in pairs(T) do
        nIndex = nIndex + 1
        if nIndex == nRandomIndex then
            if bIsReturnKey then
                return k, v
            end
            return v
        end
    end

    return nil
end

--- Take a random value from the table according to a preset rate
--- @param T table
--- @param bIsReturnKey? boolean
--- Example:
--- tbItems = {
---  { tbProp = { 2, 3, 2, 1}, nRate = 10 },
---  { tbProp = { 1, 0, 0, 1}, nRate = 90 },
--- }
function KsgTable:RandomEx(T, bIsReturnKey)
    if not T then
        return false
    end
    local nRateTotal = 10000000
    local nRandom = math.random(1, nRateTotal)
    local nStep = 0
    for k, v in pairs(T) do
        nStep = nStep + math.floor(v.nRate * nRateTotal / 100)
        if nRandom <= nStep then
            if bIsReturnKey then
                return k, v
            end
            return v
        end
    end

    return false
end

--- Check if a item exists in the table
--- @param T table
--- @param item any
--- @return boolean
function KsgTable:HasValue(T, item)
    for _, value in ipairs(T) do
        if value == item then
            return true
        end
    end

    return false
end

--- Check if items exists in the table
--- @param T table
--- @param items table|any
--- @return boolean
function KsgTable:Contains(T, items)
    if "table" == type(items) then
        local nFound = 0
        for _, item in ipairs(items) do
            if self:HasValue(T, item) then
                nFound = nFound + 1
            end
        end
        return #items == nFound
    end
    return self:HasValue(T, items)
end

--- Merge multiple tables
function KsgTable:Merge(...)
    local tbTable = {}
    for i = 1, #arg do
        for k, v in pairs(arg[i]) do
            if type(tbTable[k]) == "table" and type(v) == "table" then
                tbTable[k] = self:Merge(tbTable[k], v)
            else
                tbTable[k] = v
            end
        end
    end
    return tbTable
end

function KsgTable:Copy(tb)
    local tbCopy = {}
    for k, v in pairs(tb) do
        tbCopy[k] = v
    end
    return tbCopy
end

function KsgTable:DeepCopy(tbSrc, nMaxLayers)
    nMaxLayers = nMaxLayers or self.MAX_COPY_LAYERS
    if nMaxLayers <= 0 then
        -- Max layers
        return
    end

    local tbRet = {}
    for k, v in pairs(tbSrc) do
        if type(v) == "table" then
            tbRet[k] = self:DeepCopy(v, nMaxLayers - 1)
        else
            tbRet[k] = v
        end
    end

    return tbRet
end

return KsgTable

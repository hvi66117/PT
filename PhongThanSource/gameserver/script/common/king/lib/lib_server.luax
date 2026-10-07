KsgServer = KsgServer or {}

KsgServer.MAX_ID = 100

KsgServer.tbIds = {
    TUYET_LONG_LINH = 1,
}

KsgServer.LatestOpenServer = KsgServer.tbIds.TUYET_LONG_LINH

KsgServer.tbCfg = {

}

KsgServer.tbDefaultCfg = {

}

function KsgServer:CurrentId()
    return GetServerID()
end

function KsgServer:IsNewServer()
    return self:CurrentId() == self.LatestOpenServer
end

function KsgServer:CurrentName()
    return GetGameServerName()
end

function KsgServer:OnPlayerLogin()
    local nServerId = self:CurrentId()
    if not nServerId then
        return
    end
    if nServerId < self.MAX_ID then
        -- Normal Server
        local nLastLoginServerId = KsgPlayer:GetLastLoginServerId()

        if nLastLoginServerId == 0 then
            -- §¨ng nhËp lÇn ®Çu
            KsgPlayer:SetLastServerId(nServerId)
            KsgPlayer:SetLastLoginServerId(nServerId)
            return
        end
        -- ChuyÓn m¸y chñ, gép m¸y chñ
        local nRegisterServerId = KsgPlayer:GetRegisterServerId() -- M¸y chñ ®¨ng ký chuyÓn ®Õn

        if nServerId ~= nLastLoginServerId then
            -- ChuyÓn hoÆc gép m¸y chñ
            KsgPlayer:SetLastServerId(nLastLoginServerId) -- L­u l¹i ID cña m¸y chñ tr­íc khi chuyÓn
            if nRegisterServerId == nServerId then
                -- ChuyÓn m¸y chñ thµnh c«ng, reset id server ®¨ng ký tr­íc ®ã
                KsgPlayer:SetRegisterServerId(0)
            end
        end

        -- Always keep this line at end of method
        KsgPlayer:SetLastLoginServerId(nServerId)
    end
end

function KsgServer:GetCfg(szKey, nServerId)
    local nCurServerId = nServerId or KsgLib:GetServerId()

    return self.tbCfg[nCurServerId][szKey] or self.tbDefaultCfg[szKey]
end

return KsgServer

KsgServer = KsgServer or {}

KsgServer.tbIds = {
  Khai_Minh_Dien = 1,
  Phong_Than_Dai = 2,
  Ngoc_Hu_Cung = 3,
  Kim_Quang_Dien = 4,
}

KsgServer.tbDefaultCfg = {

}

KsgServer.tbCfg = {

}

KsgServer.MAX_ID = 100

function KsgServer:CurrentId()
  return GetServerID()
end

function KsgServer:OnPlayerLogin()
  local nServerId = self:CurrentId()
  if nServerId < self.MAX_ID then
    -- Normal Server
    local nLastLoginServerId = KsgPlayer:GetLastLoginServerId()

    if nLastLoginServerId == 0 then -- §¨ng nhËp lÇn ®Çu
      KsgPlayer:SetLastServerId(nServerId)
      KsgPlayer:SetLastLoginServerId(nServerId)
      return
    end
    -- ChuyÓn m¸y chñ, gép m¸y chñ
    local nRegisterServerId = KsgPlayer:GetRegisterServerId() -- M¸y chñ ®¨ng ký chuyÓn ®Õn

    if nServerId ~= nLastLoginServerId then -- ChuyÓn hoÆc gép m¸y chñ
      KsgPlayer:SetLastServerId(nLastLoginServerId) -- L­u l¹i ID cña m¸y chñ tr­íc khi chuyÓn
      if nRegisterServerId == nServerId then -- ChuyÓn m¸y chñ thµnh c«ng, reset id server ®¨ng ký tr­íc ®ã
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

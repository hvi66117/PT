KsgDebug = KsgDebug or {}

function KsgDebug:Print(szMsg)
  if KsgPlayer:IsGM() then
    KsgPlayer:Msg(szMsg)
  end
end

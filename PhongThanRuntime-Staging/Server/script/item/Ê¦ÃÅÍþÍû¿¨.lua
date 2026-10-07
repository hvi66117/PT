function main()
    local name = GetDismissHistoryName()
    local mark1 = IsHistoryMaster(name)
    local mark2 = IsHistoryPrentice(name)
    local str = "[没有师徒关系]"
    local v = GetFactionGlory()
    if (mark2 == 1) and (name ~= "") then
        str = "[现有徒弟]" .. name
    elseif (mark1 == 1) and (name ~= "") then
        str = "[现有师傅]" .. name
    end
    str = "[原有威望" .. v .. "]" .. str
    ModifyFactionGlory(1)
    WriteLog("[师徒][师门威望卡][师门威望加 1 甶觤]" .. str)
end

function no()
    CloseDialog()
end

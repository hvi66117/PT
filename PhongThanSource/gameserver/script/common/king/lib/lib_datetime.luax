--- @class KsgDate
KsgDate = KsgDate or { nDay = 0, nMonth = 0, nYear = 0, nHour = 0, nMinute = 0, nSecond = 0 }

--- Format KsgDate
--- @param tbDate KsgDate: Date to format
--- @param szFormat string: Format, ex: "dmY"
function KsgDate:Format(tbDate, szFormat)
  tbDate = tbDate or self:Now()
  if not szFormat or type(szFormat) ~= "string" then
    return tonumber(string.format("%d%02d%02d", tbDate.nYear, tbDate.nMonth, tbDate.nDay))
  end

  local szDate = ""

  for i = 1, string.len(szFormat) do
    local char = string.sub(szFormat, i, i)

    if char == "Y" or char == "y" then
      szDate = szDate .. string.format("%d", tbDate.nYear)
    end
    if char == "M" then
      szDate = szDate .. string.format("%02d", tbDate.nMonth)
    end
    if char == "m" then
      szDate = szDate .. string.format("%d", tbDate.nMonth)
    end
    if char == "D" then
      szDate = szDate .. string.format("%02d", tbDate.nDay)
    end
    if char == "d" then
      szDate = szDate .. string.format("%d", tbDate.nDay)
    end
    if char == "H" then
      szDate = szDate .. string.format("%02d", tbDate.nHour)
    end
    if char == "h" then
      szDate = szDate .. string.format("%d", tbDate.nHour)
    end
    if char == "I" then
      szDate = szDate .. string.format("%02d", tbDate.nMinute)
    end
    if char == "i" then
      szDate = szDate .. string.format("%d", tbDate.nMinute)
    end
    if char == "S" then
      szDate = szDate .. string.format("%02d", tbDate.nSecond)
    end
    if char == "s" then
      szDate = szDate .. string.format("%d", tbDate.nSecond)
    end
  end

  return tonumber(szDate)
end

function KsgDate:ToNumber()
  return self:Format(nil, "YMDHIS")
end

--- Create a KsgDate object
--- @return KsgDate : Current Datetime
function KsgDate:Now()
  local nYear, nMonth, nDay = GetYMD()
  local nH, nM, nS = GetHMS()
  local tbDate = self
  tbDate.nYear = nYear
  tbDate.nMonth = nMonth
  tbDate.nDay = nDay
  tbDate.nHour = nH
  tbDate.nMinute = nM
  tbDate.nSecond = nS

  return tbDate
end

--- Create a KsgDate object
--- @param nYear number
--- @param nMonth number
--- @param nDay number
--- @param nHour number
--- @param nMinute number
--- @param nSecond number
--- @return KsgDate
function KsgDate:Create(nYear, nMonth, nDay, nHour, nMinute, nSecond)
  local now = self:Now()
  local tbDate = self
  tbDate.nYear = nYear or now.nYear
  tbDate.nMonth = nMonth or now.nMonth
  tbDate.nDay = nDay or now.nDay
  tbDate.nHour = nHour or now.nHour
  tbDate.nMinute = nMinute or now.nMinute
  tbDate.nSecond = nSecond or now.nSecond

  return tbDate
end

---
--- Parse numeric date to KsgDate Object
--- @param nDate number: Numeric Date time with format "yyyymmdd" ex: 20211220
--- @return KsgDate
function KsgDate:Parse(nDate)
  local nParseDate = tonumber(nDate)
  local nD = math.mod(nParseDate, 100)
  nParseDate = math.floor(nParseDate / 100)
  local nM = math.mod(nParseDate, 100)
  nParseDate = math.floor(nParseDate / 100)
  local nY = math.mod(nParseDate, 10000)

  return self:Create(nY, nM, nD, 0, 0, 0)
end

---
--- Convert numeric date to string as dd/mm/yyyy
--- @param nDate number: Numeric Date time with format "yyyymmdd" ex: 20211220
--- @return string
function KsgDate:ToString(nDate)
  local tbDate = self:Parse(nDate)

  return string.format("%02d/%02d/%d", tbDate.nDay, tbDate.nMonth, tbDate.nYear)
end

--- Check whether the current time is greater than the specified time
--- @param tbDate KsgDate
--- @return boolean
function KsgDate:gt(tbDate)
  return self:Now():ToNumber() > tbDate:ToNumber()
end

--- Check whether the current time is greater than or equals the specified time
--- @param tbDate KsgDate
--- @return boolean
function KsgDate:ge(tbDate)
  return self:Now():ToNumber() >= tbDate:ToNumber()
end

--- Check whether the current time is less than the specified time
--- @param tbDate KsgDate
--- @return boolean
function KsgDate:lt(tbDate)
  return self:Now():ToNumber() < tbDate:ToNumber()
end

--- Check whether the current time is less than or equals the specified time
--- @param tbDate KsgDate
--- @return boolean
function KsgDate:le(tbDate)
  return self:Now():ToNumber() <= tbDate:ToNumber()
end

--- Get number of days in month
--- @param nMonth number
--- @param nYear number
--- @return number
function KsgDate:GetDaysInMonth(nMonth, nYear)
  local now = self:Now()
  nYear = tonumber(nYear) or tonumber(now.nYear)
  nMonth = tonumber(nMonth) or tonumber(now.nMonth)
  local tbDaysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  local nDaysInMonth = tbDaysInMonth[nMonth]
  -- Check for leap year
  if nMonth == 2 then
    if (math.mod(nYear, 4) == 0 and math.mod(nYear, 100) ~= 0) or math.mod(nYear, 400) == 0 then
      nDaysInMonth = 29
    end
  end

  return nDaysInMonth
end

--- Convert day to seconds
--- @param nDay number
function KsgDate:DayInSeconds(nDay)
  nDay = nDay or 1
  return nDay * 24 * 3600
end

function KsgDate:Diff(nFromTime, nToTime)
  local nDiffTime = nToTime - nFromTime
  local nDay = math.floor(nDiffTime / 86400)
  nDiffTime = math.mod(nDiffTime, 86400)
  local nHour = math.floor(nDiffTime / 3600)
  nDiffTime = math.mod(nDiffTime, 3600)
  local nMin = math.floor(nDiffTime / 60)
  return nDay, nHour, nMin
end

return KsgDate

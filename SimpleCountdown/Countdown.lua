-- 自动计算所有事件的月/周/日数值
function Update()
    local now = os.date("*t")
    local nowTime = os.time(now)
    local i = 1

    while true do
        local targetStr = SKIN:GetVariable("Target"..i)
        if not targetStr or targetStr == "" then break end
        
        local y, m, d, h, min, s = string.match(targetStr, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
        if y then
            local targetTable = {
                year = tonumber(y), month = tonumber(m), day = tonumber(d),
                hour = tonumber(h), min = tonumber(min), sec = tonumber(s)
            }
            local targetTime = os.time(targetTable)
            local diff = os.difftime(targetTime, nowTime)

            local outM, outW, outD = "0m", "0w", "0d"
            if diff > 0 then
                local totalDays = math.ceil(diff / 86400)
                local totalWeeks = math.ceil(diff / (86400 * 7))
                local totalMonths = (targetTable.year - now.year) * 12 + (targetTable.month - now.month)
                if targetTable.day < now.day then 
                else
                    if totalMonths == 0 then totalMonths = 1 end
                end
                if totalMonths <= 0 then totalMonths = 1 end
                outM = totalMonths .. "m"
                outW = totalWeeks .. "w"
                outD = totalDays .. "d"
            end

            -- 将计算结果传回 Rainmeter
            SKIN:Bang("!SetVariable", "ResM"..i, outM)
            SKIN:Bang("!SetVariable", "ResW"..i, outW)
            SKIN:Bang("!SetVariable", "ResD"..i, outD)
        end
        i = i + 1
    end
end

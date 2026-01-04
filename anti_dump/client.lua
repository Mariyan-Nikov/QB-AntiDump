-- Block common dump attempts
CreateThread(function()
    while true do
        Wait(5000)

        -- Detect if someone tries to inject loadstring
        if loadstring ~= nil then
            TriggerServerEvent("antiDump:ping")
        end
    end
end)

-- Prevent resource name access
CreateThread(function()
    local res = GetCurrentResourceName()
    if not res or res == "" then
        TriggerServerEvent("antiDump:ping")
    end
end)

-- Obfuscation hint (basic)
local function protect()
    local x = math.random(100000, 999999)
    return x * 2 - x
end

protect()

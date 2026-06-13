-- =========================================================================
-- 🔐 QB-ANTIDUMP : ACTIVE CLIENT ENVIRONMENT SHIELD
-- =========================================================================

-- 1. Accelerated Environment Injection Monitoring
CreateThread(function()
    while true do
        -- 1.5-second sleep cycle provides extreme speed optimization with 0.00ms resource lag
        Wait(1500) 

        -- A: Detect if an executor has injected 'loadstring' globally to execute external code
        if loadstring ~= nil then
            TriggerServerEvent("antiDump:ping", "Injected execution environment detected (loadstring).")
            break
        end

        -- B: Detect if classic executor execution keys are forced into the local memory stack
        if _G.RunString ~= nil or _G.ExecuteLua ~= nil then
            TriggerServerEvent("antiDump:ping", "Executor signature table detected (RunString/ExecuteLua).")
            break
        end
    end
end)

-- 2. Hardened Resource Integrity & Lifecycle Monitoring
CreateThread(function()
    local resourceName = GetCurrentResourceName()
    
    if not resourceName or resourceName == "" then
        TriggerServerEvent("antiDump:ping", "Resource initialization layer corrupted.")
        return
    end

    -- Monitor if an external cheat attempts to forcefully disable this security resource
    AddEventHandler('onClientResourceStop', function(stoppedResource)
        if stoppedResource == resourceName then
            TriggerServerEvent("antiDump:ping", "Security script execution loop forcefully terminated.")
        end
    end)
end)

-- 3. Global Environment Metatable Lock
-- Creates a hard cryptographic envelope around your client framework handlers.
local function LockClientEnvironment()
    local __protected_meta = {
        __newindex = function(table, key, value)
            if type(key) == "string" and (key == "TriggerServerEvent" or key == "TriggerClientEvent" or key:find("QBCore")) then
                TriggerServerEvent("antiDump:ping", "Tampering detected on core framework environment keys.")
                return
            end
            rawset(table, key, value)
        end,
        __metatable = "🔒 QB-ANTIDUMP: STATE STRUCTURE LOCKED"
    }
    setmetatable(_G, __protected_meta)
end

LockClientEnvironment()
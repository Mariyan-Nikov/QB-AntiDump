-- =========================================================================
-- 🔐 QB-ANTIDUMP : SERVER BACKBONE & INTEGRITY INTERCEPTOR
-- =========================================================================

local resourceName = GetCurrentResourceName()

-- 🔑 Твоят точен хъш за клиентския файл (Заключен)
local expectedHashes = {
    client = "20991820"
}

-- Сървърно четене и хеширане на файла
local function checkFile(file)
    local content = LoadResourceFile(resourceName, file)
    if not content then return nil end
    return tostring(GetHashKey(content))
end

-- Красив txAdmin/FXServer Console Monitor Принт
local function printShieldConsole(statusOk, currentHash)
    -- Изчакваме 3 секунди, за да се заредят логовете на FXServer и Nucleus чисти
    Citizen.SetTimeout(3000, function()
        if statusOk then
            print("\n^2" .. string.rep("═", 55))
            print("^2║                [🛡️ ANTI-DUMP SYSTEM]                  ║")
            print("^2" .. string.rep("═", 55))
            print("^2║ Status: SUCCESS                                     ║")
            print("^2║ Client Integrity: SECURE                            ║")
            print("^2║ Protection Level: ACTIVE                            ║")
            print("^2" .. string.rep("═", 55) .. "^0\n")
        else
            print("\n^1" .. string.rep("═", 55))
            print("^1║                [🛡️ ANTI-DUMP SYSTEM]                  ║")
            print("^1" .. string.rep("═", 55))
            print("^1║ Status: CRITICAL FAULT                              ║")
            print("^1║ Client Integrity: MODIFIED / DUMPED                 ║")
            print("^1║ Action: RESOURCE TERMINATED                         ║")
            print("^1" .. string.rep("═", 55) .. "^0")
            print(string.format("^3[SYSTEM NOTICE]^7 Current client.lua Hash is: ^5%s^7", tostring(currentHash)))
            print("^1" .. string.rep("═", 55) .. "^0\n")
        end
    end)
end

-- ПОПРАВЕНО: Използваме 'onServerResourceStart' вместо базовия 'onResourceStart'
AddEventHandler('onServerResourceStart', function(res)
    if res ~= resourceName then return end
    
    local clientHash = checkFile("client.lua")

    if clientHash ~= expectedHashes.client then
        printShieldConsole(false, clientHash)
        -- Делей за спирането, за да може конзолата да запише грешката красиво
        Citizen.SetTimeout(3200, function()
            StopResource(resourceName)
        end)
    else
        printShieldConsole(true, nil)
    end
end)

-- 🎯 High Priority Hardened Server Intercept Drop
RegisterNetEvent("antiDump:ping", function(reason)
    local src = source
    if not src or src <= 0 then return end 
    
    local playerName = GetPlayerName(src) or "Unknown"
    local license = GetPlayerIdentifierByType(src, 'license') or "N/A"
    
    print("^1==================================================================^7")
    print(string.format("^1[🛡️ ANTI-DUMP REGISTRY] BANNED EXECUTION: %s (ID: %s)^7", playerName, tostring(src)))
    print(string.format("^3[Identifier]^7 %s", license))
    print(string.format("^3[Detection Type]^7 %s", reason or "Unknown Modification Trigger"))
    print("^1==================================================================^7")

    DropPlayer(src, "[🛡️ QB-ANTIDUMP]: Dump/Injection attempt detected. Hardware instance dropped.")
end)

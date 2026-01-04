local resourceName = GetCurrentResourceName()

-- Expected hashes (generate once, then lock them)
local expectedHashes = {
    client = "1894072346"
}

-- Simple hash function (lightweight)
local function simpleHash(str)
    local hash = 5381
    for i = 1, #str do
        hash = ((hash * 33) ~ str:byte(i)) & 0x7FFFFFFFFFFFFFFF
    end
    return tostring(hash)
end


-- File integrity check
local function checkFile(file)
    local content = LoadResourceFile(resourceName, file)
    if not content then return nil end
    return tostring(GetHashKey(content))
end

AddEventHandler('onResourceStart', function(res)
    if res ~= resourceName then return end
    local clientHash = checkFile("client.lua")

    if clientHash ~= expectedHashes.client then
        print("^1[ANTI-DUMP] Client file modified. Resource stopped.^0")
        StopResource(resourceName)
    else
        print("^2[ANTI-DUMP] Client integrity OK.^0")
    end
end)


-- Anti-trigger spam / dump attempts
RegisterNetEvent("antiDump:ping", function()
    local src = source
    DropPlayer(src, "Dump detected.")
end)

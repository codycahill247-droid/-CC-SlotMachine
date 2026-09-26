local programUrl = "https://raw.githubusercontent.com/Jammersmurph/CC-SlotMachine/main/slotmachine.lua"
local programPath = "slotmachine.lua"

local startup = [[
local url = "https://raw.githubusercontent.com/Jammersmurph/CC-SlotMachine/main/slotmachine.lua"
local path = "slotmachine.lua"

term.clear()
term.setCursorPos(1, 1)
print("CC-SlotMachine")
print("Checking for updates...")

local updated = false
local response = http.get(url)

if response then
    local data = response.readAll()
    response.close()

    if data and #data > 0 then
        local file = fs.open(path, "w")
        file.write(data)
        file.close()
        updated = true
        print("Updated from GitHub.")
    end
end

if not updated then
    if fs.exists(path) then
        print("Update unavailable; using cached version.")
    else
        error("Could not download CC-SlotMachine and no cached version exists.")
    end
end

sleep(0.5)
shell.run(path)
]]

print("Installing CC-SlotMachine...")

local response = http.get(programUrl)
if not response then
    error("Failed to download slotmachine.lua")
end

local data = response.readAll()
response.close()

local program = fs.open(programPath, "w")
program.write(data)
program.close()

local startupFile = fs.open("startup.lua", "w")
startupFile.write(startup)
startupFile.close()

print("CC-SlotMachine installed successfully.")
print("Automatic updates are enabled.")
print("Every reboot will check GitHub before starting.")
print("If GitHub is unavailable, the cached version will run.")
print("Reboot the computer to start it.")

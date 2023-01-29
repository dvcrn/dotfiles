hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("RandomUsername")

spoon.ReloadConfiguration:start()

-- Set brightness to 100% when power adapter gets connected
prevMode = "" -- init
batteryWatcher = hs.battery.watcher.new(function()
    newMode = hs.battery.powerSource()
    if newMode == "AC Power" then
        if prevMode ~= "AC Power" then
            print("[triggered] AC power connected, setting battery to 100%")
            hs.brightness.set(100)
        end
    end

    if newMode ~= prevMode then
        prevMode = hs.battery.powerSource() -- override
        print("setting mode to ", prevMode)
    end
end):start()

kt = hs.eventtap.event.newKeyEvent({}, "a", true)
keyCount = 0
keyCountResetDelay = hs.timer.delayed.new(1, function()
    keyCount = 0
end)

eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    if event:getUnicodeString() == "!" then
        keyCount = keyCount + 1
        keyCountResetDelay:start()

        if keyCount == 3 then
            print("[triggered] insert random username")

            keyCount = 0
            for i = 1, 3 do
                hs.eventtap.keyStroke({}, 'delete', 0)
            end
            hs.eventtap.keyStrokes(spoon.RandomUsername:generateUsername())
        end
    end
end):start()

-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
--     hs.alert.show(spoon.RandomUsername:generateUsername())
-- end)

hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("RandomUsername")
hs.loadSpoon("BindKeymap")

spoon.ReloadConfiguration:start()


function printMap(map)
    for key, value in pairs(map) do
        print(key, value)
    end
end

-- Set brightness to 100% when power adapter gets connected
local prevMode = "" -- init
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

fx = function()
    print("a b c")
end



local insertRandomUsername = function()
    hs.eventtap.keyStrokes(spoon.RandomUsername:generateUsername())
end

spoon.BindKeymap:bindStringSequence("abc", fx, true)
-- 18 == !
spoon.BindKeymap:bindKeycodeSequence({ 18, 18, 18 }, insertRandomUsername, true)

-- eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
--     -- append to pressed keys
--     table.insert(pressedKeys, event:getKeyCode())

--     -- print all pressedKeys from the pressedKeys map so far
--     pressedKeysString = table.concat(pressedKeys, "")
--     pressedKeysKeycodeString = table.concat(pressedKeys, "__")

--     -- check if the pressedKeys map is a registered shortcut
--     if registeredShortcuts[pressedKeysKeycodeString] then
--         resetStuff()
--         keyCountResetDelay:stop()

--         registeredShortcuts[pressedKeysKeycodeString]()
--         -- trigger keyCountResetDelay immediately
--     end


--     keyCountResetDelay:start()

--     if event:getUnicodeString() == "!" then
--         keyCount = keyCount + 1
--         keyCountResetDelay:start()

--         if keyCount == 3 then
--             print("[triggered] insert random username")

--             keyCount = 0
--             for i = 1, 3 do
--                 hs.eventtap.keyStroke({}, 'delete', 0)
--             end
--             hs.eventtap.keyStrokes(spoon.RandomUsername:generateUsername())
--         end
--     end
-- end):start()

-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
--     hs.alert.show(spoon.RandomUsername:generateUsername())
-- end)



hs.application.frontmostApplication()

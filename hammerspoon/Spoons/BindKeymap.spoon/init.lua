local function stringToKeycodesHash(string)
    keycodes = {}
    for i = 1, string.len(string) do
        table.insert(keycodes, hs.keycodes.map[string:sub(i, i)])
    end

    -- join keycodes with "__"
    return table.concat(keycodes, "__")
end

local function wrapWithDeleteKeypresses(numdeletes, func)
    return function()
        for i = 1, numdeletes do
            hs.eventtap.keyStroke({}, 'delete', 0)
        end

        func()
    end
end

local obj = {}
obj.__index = obj

obj.name = "BindKeymap"
obj.version = "1.0"
obj.author = "David Mohl"

local pressedKeys = {}
local inChain = false

local resetKeysequence = function()
    print("resetting keysequence: ", table.concat(pressedKeys, " "))
    pressedKeys = {}
    inChain = false
end

obj.resetKeysequence = resetKeysequence

local keyCountResetDelay = hs.timer.delayed.new(1, resetKeysequence)
local registeredShortcuts = {}

-- a place to store the first keycodes that were entered, so we know when a keycode chain started
local firstKeyCodes = {}

--- BindKeymap:bindStringSequence()
--- Method
--- Binds the given string key sequence to a function
---
--- Parameters:
---  * keymap - A string containing the keymap, eg "abc"
---  * func - A function to bind to the keymap
---  * deleteInsertedKeys - If true, the inserted keys will be deleted before the function is called
---
--- Returns:
---  * None
function obj:bindStringSequence(keymap, func, deleteInsertedKeys)
    -- get keycode for first character of keymap
    local firstKeyCode = hs.keycodes.map[keymap:sub(1, 1)]
    firstKeyCodes[firstKeyCode] = true

    local callbackfx = func
    if deleteInsertedKeys then
        callbackfx = wrapWithDeleteKeypresses(string.len(keymap), func)
    end

    registeredShortcuts[stringToKeycodesHash(keymap)] = callbackfx
end

--- BindKeymap:bindKeycodeSequence()
--- Method
--- Binds the given string key sequence to a function
---
--- Parameters:
---  * keymap - A map containing the sequence of keycodes, eg {18, 18, 18}
---  * func - A function to bind to the keymap
---  * deleteInsertedKeys - If true, the inserted keys will be deleted before the function is called
---
--- Returns:
---  * None
function obj:bindKeycodeSequence(keycodes, func, deleteInsertedKeys)
    firstKeyCodes[ keycodes[1] ] = true

    local callbackfx = func
    if deleteInsertedKeys then
        callbackfx = wrapWithDeleteKeypresses(#keycodes, func)
    end

    registeredShortcuts[table.concat(keycodes, "__")] = callbackfx
end

local eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    printMap(firstKeyCodes)
    -- check if the first key of the sequence is pressed
    if not firstKeyCodes[event:getKeyCode()] and not inChain then
        print("not in chain and not the first keycode")
        return
    end
    inChain = true


    -- append to pressed keys
    table.insert(pressedKeys, event:getKeyCode())

    -- print all pressedKeys from the pressedKeys map so far
    local pressedKeysString = table.concat(pressedKeys, "")
    local pressedKeysKeycodeString = table.concat(pressedKeys, "__")

    -- check if the pressedKeys map is a registered shortcut
    if registeredShortcuts[pressedKeysKeycodeString] then
        obj:resetKeysequence()
        keyCountResetDelay:stop()

        -- trigger bound function
        registeredShortcuts[pressedKeysKeycodeString]()
    end

    keyCountResetDelay:start()
end):start()


return obj

function Spaces()
    local spaces            = require("hs.spaces")
    local primaryScreenUUID = hs.screen.primaryScreen():getUUID()
    local ss                = {}
    for screen, spaceIDs in pairs(spaces.allSpaces()) do
        spaceIDs = hs.fnutils.filter(spaceIDs, function(x) return spaces.spaceType(x) == "user" end)
        if screen == primaryScreenUUID then
            ss = hs.fnutils.concat(spaceIDs, ss)
        else
            ss = hs.fnutils.concat(ss, spaceIDs)
        end
    end
    return ss
end

function MoveWindowToSpace(sp)
    local spaces            = require("hs.spaces")
    local win               = hs.window.focusedWindow()
    local ss                = Spaces()
    local spaceID           = ss[sp]
    local currentScreen     = hs.screen.mainScreen()
    local nextScreen        = hs.screen.find(spaces.spaceDisplay(spaceID))
    local frame             = win:frame()
    local nframe            = nextScreen:frame()
    local cframe            = currentScreen:frame()
    frame.x = ((frame.x - cframe.x) / cframe.w * nframe.w) + nframe.x
    frame.y = ((frame.y - cframe.y) / cframe.h * nframe.h) + nframe.y
    frame.h = frame.h / cframe.h * nframe.h
    frame.w = frame.w / cframe.w * nframe.w
    spaces.moveWindowToSpace(win:id(), spaceID)
    win:move(frame)
end
hs.hotkey.bind({"ctrl", "shift"}, "1", function() MoveWindowToSpace(1) end)
hs.hotkey.bind({"ctrl", "shift"}, "2", function() MoveWindowToSpace(3) end)

function MoveAllFromTo(from, to)
    local spaces          = require("hs.spaces")
    local ss              = Spaces()
    local currentScreen   = hs.screen.find(spaces.spaceDisplay(ss[from]))
    local nextScreen      = hs.screen.find(spaces.spaceDisplay(ss[to]))
    local nframe          = nextScreen:frame()
    local cframe          = currentScreen:frame()
    local windows         = spaces.windowsForSpace(ss[from])
    for _, win in ipairs(windows) do
        win = hs.window.get(win)
        if win == nil then
            goto continue
        end
        local frame = win:frame()
        frame.x = ((frame.x - cframe.x) / cframe.w * nframe.w) + nframe.x
        frame.y = ((frame.y - cframe.y) / cframe.h * nframe.h) + nframe.y
        frame.h = frame.h / cframe.h * nframe.h
        frame.w = frame.w / cframe.w * nframe.w
        spaces.moveWindowToSpace(win:id(), ss[to])
        win:move(frame)
        ::continue::
    end
end
hs.hotkey.bind({"ctrl", "shift"}, "9", function() MoveAllFromTo(1, 3) end)
hs.hotkey.bind({"ctrl", "shift"}, "0", function() MoveAllFromTo(3, 1) end)

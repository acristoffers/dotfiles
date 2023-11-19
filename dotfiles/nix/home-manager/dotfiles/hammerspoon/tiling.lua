function ResizeAndCenter()
    hs.eventtap.keyStroke({"alt", "ctrl"}, "I", 50000)
    hs.eventtap.keyStroke({"alt", "ctrl"}, "C", 50000)
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", ResizeAndCenter)

function FixWindowTiling(win)
    local sf = win:screen():frame()
    local positions = {
        {{sf.x, sf.y, sf.w, sf.h},                               {},          "return"},
        {{sf.x, sf.y, 0.9*sf.w, 0.9*sf.h},                       {"shift"},   "return"},
        {{sf.x, sf.y, 0.5*sf.w, sf.h},                           {},          "left"},
        {{sf.x, sf.y, sf.w, 0.5*sf.h},                           {},          "up"},
        {{sf.x + 0.5*sf.w, sf.y, 0.5*sf.w, sf.h},                {},          "right"},
        {{sf.x, sf.y + 0.5*sf.h, sf.w, 0.5*sf.h},                {},          "down"},
        {{sf.x, sf.y, 0.5*sf.w, 0.5*sf.h},                       {},          "U"},
        {{sf.x + 0.5*sf.w, sf.y, 0.5*sf.w, 0.5*sf.h},            {},          "I"},
        {{sf.x, sf.y + 0.5*sf.h, 0.5*sf.w, 0.5*sf.h},            {},          "J"},
        {{sf.x + 0.5*sf.w, sf.y + 0.5*sf.h, 0.5*sf.w, 0.5*sf.h}, {},          "K"},
        {{sf.x + 0.3*sf.w, sf.y + 0.3*sf.h, 0.5*sf.w, 0.5*sf.h}, {"command"}, "C"},
        {{sf.x, sf.y, 0.6*sf.w, sf.h},                           {},          "E"},
        {{sf.x + 0.16*sf.w, sf.y, 0.6*sf.w, sf.h},               {},          "R"},
        {{sf.x + 0.3*sf.w, sf.y, 0.6*sf.w, sf.h},                {},          "T"},
        {{sf.x, sf.y, sf.w/3, sf.h/2},                           {"shift"},   "U"},
        {{sf.x + 0.3*sf.w, sf.y, sf.w/3, sf.h/2},                {"shift"},   "I"},
        {{sf.x + 0.6*sf.w, sf.y, sf.w/3, sf.h/2},                {"shift"},   "O"},
        {{sf.x, sf.y + 0.5*sf.h, sf.w/3, sf.h/2},                {"shift"},   "J"},
        {{sf.x + 0.3*sf.w, sf.y + 0.5*sf.h, sf.w/3, sf.h/2},     {"shift"},   "K"},
        {{sf.x + 0.6*sf.w, sf.y + 0.5*sf.h, sf.w/3, sf.h/2},     {"shift"},   "L"},
        {{sf.x, sf.y, sf.w/3, sf.h},                             {},          "D"},
        {{sf.x + 0.3*sf.w, sf.y, sf.w/3, sf.h},                  {},          "F"},
        {{sf.x + 0.6*sf.w, sf.y, sf.w/3, sf.h},                  {},          "G"}
    }
    local f = win:frame()
    local fs = hs.fnutils.imap(positions, function(v) return {Distance(v[1], {f.x, f.y, f.w, f.h}), v[2], v[3]} end)
    local min = hs.fnutils.reduce(fs, function(acc, x) if acc[1] > x[1] then return x else return acc end end)
    hs.eventtap.keyStroke(hs.fnutils.concat({"alt", "ctrl"}, min[2]), min[3])
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "\\", function() FixWindowTiling(hs.window.focusedWindow()) end)

function FixAllWindowsTiling()
    local wins = hs.window.visibleWindows()
    for _, w in ipairs(wins) do
        w:focus()
        FixWindowTiling(w)
    end
    for _, app in ipairs({"Signal", "Discord", "Telegram", "Element"}) do
        hs.application.launchOrFocus(app)
        hs.eventtap.keyStroke({"alt", "ctrl"}, "T")
        hs.eventtap.keyStroke({"command"}, "W")
    end
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", function() FixAllWindowsTiling() end)

function Distance(p1, p2)
    local s = (p1[1]-p2[1])^2 + (p1[2]-p2[2])^2 + (p1[3]-p2[3])^2 + (p1[4]-p2[4])^2
    return math.sqrt(s)
end

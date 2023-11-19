function AppCallback(appName, event, app)
    if appName == "Music" and event == hs.application.watcher.launched then
        if hs.fs.attributes("~/.itunes") == nil then
            app = hs.application.get(appName)
            app:kill()
        else
            hs.execute("rm ~/.itunes")
        end
    elseif event == hs.application.watcher.launched then
        app = hs.application.get(appName)
        app:activate()
    end
end
AppWatcher = hs.application.watcher.new(AppCallback)
AppWatcher:start()

Focused     = hs.window.filter.windowFocused
Created     = hs.window.filter.windowCreated
Moved       = hs.window.filter.windowMoved
CreatedApps = {}
function WinEvent(appName, event, app, es, f)
    if appName == app and Contains(event, es) then
        f(appName)
    end
end

function WinCallback(win, a, e)
    if win:subrole() == "AXSystemDialog" then
        return
    end
    if hs.fs.attributes("~/.startup") ~= nil then
        if e ~= Focused then
            return
        elseif Contains(a, {"Firefox", "Mail"}) then
            win:setFullScreen(true)
        else
            win:close()
        end
        return
    end
    local centerOnScreen = function(appName)
        win:centerOnScreen()
        CreatedApps[appName] = false
    end
    local centerOnFocus = function(appName)
        if CreatedApps[appName] then
            if appName == "Finder" then
                ResizeAndCenter()
            elseif appName == "Emacs" then
                hs.eventtap.keyStroke({"alt", "ctrl"}, "T")
            else
                win:centerOnScreen()
            end
            CreatedApps[appName] = false
        end
    end
    local windowCreated = function(appName)
        CreatedApps[appName] = true
    end
    local CenterOnce = function(appName)
        WinEvent(a, e, appName, {Created}, windowCreated)
        WinEvent(a, e, appName, {Focused}, centerOnFocus)
    end
    WinEvent(a, e, "System Preferences", {Moved, Focused}, centerOnScreen)
    WinEvent(a, e, "Raycast",            {Moved, Focused}, centerOnScreen)
    CenterOnce("Finder")
    CenterOnce("Emacs")
end
WinWatcher = hs.window.filter.new(hs.window.filter.default)
WinWatcher:subscribe(Moved,   WinCallback)
WinWatcher:subscribe(Created, WinCallback)
WinWatcher:subscribe(Focused, WinCallback)

function WifiCallback(_, event, interface)
    if event == "SSIDChange" and hs.wifi.currentNetwork(interface) == "ACTC5" then
        hs.execute("/usr/local/bin/blueutil --connect 1c-fe-2b-a9-22-5b")
    end
end
WifiWatcher = hs.wifi.watcher.new(WifiCallback)
WifiWatcher:start()

function Contains(x, xs)
    return hs.fnutils.contains(xs, x)
end

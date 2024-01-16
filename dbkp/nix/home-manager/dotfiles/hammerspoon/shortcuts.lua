AppModal = hs.hotkey.modal.new({ 'ctrl' }, '`')
AppModal:bind('', 'escape', function()
  AppModal:exit()
end)

function BindApplication(key, application)
  local f = function()
    hs.application.launchOrFocus(application)
    AppModal:exit()
  end
  AppModal:bind({ 'ctrl' }, key, nil, f)
  AppModal:bind({}, key, nil, f)
end

function BindApplicationCommand(key, func)
  local f = function()
    func()
    AppModal:exit()
  end
  AppModal:bind({ 'ctrl' }, key, nil, f)
  AppModal:bind({}, key, nil, f)
end

BindApplication('A', 'Adobe Acrobat Reader')
BindApplication('B', 'Bitwarden')
BindApplication('E', 'Emacs')
BindApplication('F', 'Firefox')
BindApplication('H', 'MATLAB_R2023a')
BindApplication('I', 'Finder')
BindApplication('L', 'Element')
BindApplication('M', 'Thunderbird')
BindApplication('U', 'Authy Desktop')
BindApplication('S', 'Skim')
BindApplication('T', 'Telegram')
BindApplication('D', 'Discord')
BindApplication('P', 'Pocket Casts')
BindApplication('Z', 'Zotero')
BindApplication('N', 'Signal')
BindApplication('W', 'Messages')
BindApplication('R', 'NetNewsWire')
BindApplication(',', 'System Preferences')

BindApplicationCommand('K', function()
  hs.execute 'open -a Finder /Users/alan/Documents/Dropbox'
end)
BindApplicationCommand('O', function()
  hs.execute 'open -a Finder /Users/alan/Documents/Dropbox/Universidade/Doutorado'
end)
BindApplicationCommand('J', function()
  hs.execute 'open -a Finder /Users/alan/Downloads'
end)
BindApplicationCommand('V', function()
  hs.execute '/Applications/Firefox.app/Contents/MacOS/firefox -new-tab \'https://search.brave.com\''
  hs.application.launchOrFocus 'Firefox'
end)
BindApplicationCommand('Y', function()
  hs.execute '/Applications/Firefox.app/Contents/MacOS/firefox -new-tab https://youtube.com'
  hs.application.launchOrFocus 'Firefox'
end)

hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'return', function()
  local iTerm = hs.application.get 'iTerm2'
  if iTerm == nil then
    hs.application.launchOrFocus 'iTerm'
  else
    hs.execute '/usr/bin/open -a iTerm ~'
  end
end)

LayoutModal = hs.hotkey.modal.new({ 'ctrl' }, ';')
LayoutModal:bind('', 'escape', function()
  LayoutModal:exit()
end)

function BindLayout(key, layout)
  local f = function()
    hs.keycodes.setLayout(layout)
    hs.notify.show('Layout Changed', layout, '', nil)
    LayoutModal:exit()
  end
  LayoutModal:bind({ 'ctrl' }, key, nil, f)
  LayoutModal:bind({}, key, nil, f)
end

BindLayout('J', 'U.S.')
BindLayout('K', 'U.S. International – PC')
BindLayout('L', 'Russian – QWERTY')
BindLayout('H', 'Greek')

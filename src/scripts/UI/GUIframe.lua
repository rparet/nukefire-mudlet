-- Jor'Mox's GUIframe Script
-- 3/07/2019
-- v1.4.2

-- To resize frames or move tabs, right click and drag either the resize label or the tab
-- until the desired result is achieved.

-- To add a window to a frame for the script to manage, use the
-- GUIframe.addWindow(window, name, container, hideText) function, where the window
-- variable contains the Geyser object you want to add, the name variable contains
-- the name you want it to be referred to as, which also is used as the text printed
-- on the associated tab that is created, the container variable is a string containing
-- one of the following: bottom, top, topleft, topright, bottomleft, bottomright,
-- and the hideText variable is an optional boolean which, if true, prevents text being
-- written on the tab for this window.

-- To remove a window from GUIframe, use the GUIframe.removeWindow(name, container)
-- function, where the name variable is the same name you gave the window when adding it,
-- and the optional container variable is a string specifying which container to remove
-- the window from. If no container is specified, the window is removed regardless of
-- which container it is in.

-- Resizing of frames can be enabled or disabled using the GUIframe.enable(side) and
-- GUIframe.disable(side, hide) functions respectively. If the second argument to
-- GUIframe.disable is false, then the entire set of frames on that side is hidden, and
-- the border is adjusted as if that side had be resized to zero.

-- To save and load settings, use the GUIframe.saveSettings() and
-- GUIframe.loadSettings(redraw) functions. If the redraw argument is true, the border
-- background color is changed to black to force the area of the borders to be redrawn.
-- Additionally, the GUIframe.reinitialize() function can be used to force the script to
-- initialize itself again, going back to default settings.

-- To activate a tab without it being clicked, use the GUIframe.activate(name) function.
-- And to apply a stylesheet to a tab that is different from the default stylesheet, use
-- the GUIframe.styleTab(name, style) function, where the style variable contains a string
-- with the CSS to be applied. Since tabs are styled only when created or when this
-- function is used, there should be no concern with this styling being overwritten.

GUIframe = GUIframe or {}

local mainW, mainH = getMainWindowSize()
local halfW, halfH = math.floor(mainW / 2), math.floor(mainH / 2)

GUIframe.configs = GUIframe.configs or {}

GUIframe.defaults = {
    tabHeight = 20,
    tabStyle = [[
        background-color: green;
        border-width: 2px;
        border-style: outset;
        border-color: limegreen;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';]],
    tabEchoStyle = '<center><p style="font-size:14px; color:white">',
    leftStartWidth = 50,
    leftStartHeight = halfH,
    rightStartWidth = 50,
    rightStartHeight = halfH,
    topStartHeight = 50,
    bottomStartHeight = 50,
    resizeHeight = 30,
    resizeWidth = 30,
    resizeHoverImage = "/imgs/blue_arrows.png",
    resizeRestImage = "/imgs/blue_arrows_30t.png",
    borderOffset = 0,
}

GUIframe.windows = GUIframe.windows or {}
GUIframe.tabs = GUIframe.tabs or {}
GUIframe.tabCoords = GUIframe.tabCoords or {}
GUIframe.sides = GUIframe.sides or { left = 'enabled', right = 'enabled', top = 'enabled', bottom = 'enabled' }

local resize_style = "border-image: url(%s%s);"

local configs = table.update(GUIframe.defaults, GUIframe.configs)
local tabsInfo, containerInfo, resizeInfo

local container_names = { 'topLeftContainer', 'bottomLeftContainer', 'topRightContainer',
    'bottomRightContainer', 'bottomContainer', 'topContainer' }
local tab_names = { 'topLeftTabs', 'topRightTabs', 'bottomLeftTabs', 'bottomRightTabs' }
local resizeLabels = { 'resizeLeft', 'resizeRight', 'resizeTop', 'resizeBottom' }
local sides = { "top", "bottom", "left", "right" }
local side_containers = {
    left = { "topLeftContainer", "bottomLeftContainer", "topLeftTabs", "bottomLeftTabs" },
    right = { "topRightContainer", "bottomRightContainer", "topRightTabs", "bottomRightTabs" },
    top = { "topContainer" },
    bottom = { "bottomContainer" }
}

local function get_window_coords(win, update) -- gets coords for window, stores data in tabCoords table as needed
    local x, y = win:get_x(), win:get_y()
    local w, h = win:get_width(), win:get_height()
    if update then
        GUIframe.tabCoords[win.name] = { x = x, y = y, w = w, h = h }
    end
    return x, y, w, h
end

local function check_overlap(tab, x, y) -- checks to see if given coords overlap tab or tab container
    if type(tab) == "string" then tab = GUIframe[tab] or GUIframe.tabs[tab] end
    if tab.hidden or tab.auto_hidden then return false end
    local info = GUIframe.tabCoords[tab.name]
    local x1, y1 = info.x, info.y
    local x2, y2 = x1 + info.w, y1 + info.h
    return (x >= x1 and x <= x2 and y >= y1 and y <= y2)
end

local function update_tab(tab, x, y, w, h) -- resizes and moves tab and updates tab coords table
    tab:move(x, y)
    tab:resize(w, h)
    local info = GUIframe.tabCoords[tab.name] or {}
    info.x, info.y = tab:get_x(), tab:get_y()
    info.w, info.h = tab:get_width(), tab:get_height()
    if table.contains(tab_names, tab.name) then
        info.container = true
    end
    GUIframe.tabCoords[tab.name] = info
end

local function get_containers(pos)
    if type(pos) == "table" then pos = pos.name end
    for _, w in ipairs({ 'right', 'left', 'container', 'tabs' }) do
        pos = pos:gsub(w, w:title())
    end
    local con, tab
    if string.find(pos, "Container") then
        con = GUIframe[pos]
        if not con then return end
        tabs = con.tabs
    elseif string.find(pos, "Tabs") then
        tabs = GUIframe[pos]
        if not tab then return end
        con = tabs.con
    else
        con = GUIframe[pos .. "Container"]
        tabs = GUIframe[pos .. "Tabs"]
    end
    return con, tabs
end

local function config()
    configs = table.update(GUIframe.defaults, GUIframe.configs)
    GUIframe.windows = {}
    GUIframe.tabCoords = {}

    tabsInfo = {
        topLeftTabs = {
            name = 'topLeftTabs',
            x = 0,
            y = 0,
            width = configs.leftStartWidth,
            height = configs.tabHeight
        },
        bottomLeftTabs = {
            name = 'bottomLeftTabs',
            x = 0,
            y = configs.leftStartHeight,
            width = configs.leftStartWidth,
            height = configs.tabHeight
        },
        topRightTabs = {
            name = 'topRightTabs',
            x = mainW - configs.rightStartWidth,
            y = 0,
            width = configs.rightStartWidth,
            height = configs.tabHeight
        },
        bottomRightTabs = {
            name = 'bottomRightTabs',
            x = mainW - configs.rightStartWidth,
            y = configs.rightStartHeight,
            width = configs.rightStartWidth,
            height = configs.tabHeight
        },
    }
    containerInfo = {
        topLeftContainer = {
            name = 'topLeftContainer',
            x = 0,
            y = configs.tabHeight,
            width = configs.leftStartWidth,
            height = configs.leftStartHeight - configs.tabHeight
        },
        bottomLeftContainer = {
            name = 'bottomLeftContainer',
            x = 0,
            y = configs.leftStartHeight + configs.tabHeight,
            width = configs.leftStartWidth,
            height = configs.leftStartHeight - configs.tabHeight
        },
        topRightContainer = {
            name = 'topRightContainer',
            x = mainW - configs.rightStartWidth,
            y = configs.tabHeight,
            width = configs.rightStartWidth,
            height = configs.rightStartHeight - configs.tabHeight
        },
        bottomRightContainer = {
            name = 'bottomRightContainer',
            x = mainW - configs.rightStartWidth,
            y = configs.rightStartHeight + configs.tabHeight,
            width = configs.rightStartWidth,
            height = configs.rightStartHeight - configs.tabHeight
        },
        bottomContainer = {
            name = 'bottomContainer',
            x = configs.leftStartWidth,
            y = mainH - configs.bottomStartHeight,
            height = configs.bottomStartHeight,
            width = mainW - configs.leftStartWidth - configs.rightStartWidth
        },
        topContainer = {
            name = 'topContainer',
            x = configs.leftStartWidth,
            y = 0,
            height = configs.topStartHeight,
            width = mainW - configs.leftStartWidth - configs.rightStartWidth
        }
    }
    resizeInfo = {
        resizeLeft = {
            name = 'resizeLeft',
            x = configs.leftStartWidth,
            y = configs.leftStartHeight - configs.resizeHeight / 2,
            height = configs.resizeHeight,
            width = configs.resizeWidth
        },
        resizeRight = {
            name = 'resizeRight',
            x = configs.rightStartWidth - configs.resizeWidth,
            y = configs.rightStartHeight - configs.resizeHeight / 2,
            height = configs.resizeHeight,
            width = configs.resizeWidth
        },
        resizeTop = {
            name = 'resizeTop',
            x = halfW - configs.resizeWidth / 2,
            y = configs.topStartHeight,
            height = configs.resizeHeight,
            width = configs.resizeWidth
        },
        resizeBottom = {
            name = 'resizeBottom',
            x = halfW - configs.resizeWidth / 2,
            y = mainH - configs.bottomStartHeight - configs.resizeHeight,
            height = configs.resizeHeight,
            width = configs.resizeWidth
        }
    }

    for name, cons in pairs(containerInfo) do
        GUIframe[name] = Geyser.Container:new(cons)
    end
    for name, cons in pairs(tabsInfo) do
        GUIframe[name] = Geyser.Container:new(cons)
        local cname = name:gsub("Tabs", "Container")
        GUIframe[cname].tabs = GUIframe[name]
        GUIframe[name].con = GUIframe[cname]
    end
    local style = resize_style
    local path = getMudletHomeDir()
    path = path:gsub("[\\/]", "/")
    configs.resizeRestImage = configs.resizeRestImage:gsub("[\\/]", "/")
    configs.resizeHoverImage = configs.resizeHoverImage:gsub("[\\/]", "/")
    local no_image
    if not (io.exists(path .. configs.resizeHoverImage) and io.exists(path .. configs.resizeRestImage)) then
        debugc("GUIframe: config: resize image(s) not found")
        path = "255,20,147,"
        style = "background-color: rgba(%s%s);"
        no_image = true
    end

    for name, cons in pairs(resizeInfo) do
        GUIframe[name] = Geyser.Label:new(cons)
        GUIframe[name]:setColor(0, 0, 0, 0)
        GUIframe[name]:setStyleSheet(string.format(style, path, (no_image and "100") or configs.resizeRestImage))
        GUIframe[name]:setOnEnter("GUIframe." .. name .. ".setStyleSheet", GUIframe[name],
            string.format(style, path, (no_image and "255") or configs.resizeHoverImage))
        GUIframe[name]:setOnLeave("GUIframe." .. name .. ".setStyleSheet", GUIframe[name],
            string.format(style, path, (no_image and "100") or configs.resizeRestImage))
        GUIframe[name]:setClickCallback("GUIframe.buttonClick", name)
        GUIframe[name]:setReleaseCallback("GUIframe.buttonRelease", name)
        GUIframe[name]:setMoveCallback("GUIframe.buttonMove", name)
    end
    setBorderLeft(configs.leftStartWidth + configs.borderOffset)
    setBorderRight(configs.rightStartWidth + configs.borderOffset)
    setBorderTop(configs.topStartHeight + configs.borderOffset)
    setBorderBottom(configs.bottomStartHeight + configs.borderOffset)
    GUIframe.initialized = true
end

local function deselectContainer(container, tabs)
    -- hide all windows in container
    for _, win in pairs(container.windowList) do
        win:hide()
        win.active = false
    end
    -- unhighlight all tabs in tabs container
    if tabs then
        for _, tab in pairs(tabs.windowList) do
            local name = tab.name:gsub("Tab", "")
            local show = GUIframe.windows[name].showText
            if show then
                tab:echo(configs.tabEchoStyle .. name)
            end
        end
    end
end

local function adjustTabs(tabs)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    -- remove duplicated window names
    local found = {}
    for k, v in ipairs(tabs.windows) do
        if not table.contains(found, v) and tabs.windowList[v] and not tabs.windowList[v].isClicked then
            table.insert(found, v)
        end
    end
    -- calculate tab width and set height
    local w, h = math.floor(100 / #tabs.windows), configs.tabHeight
    local function wrap(num) return tostring(num) .. "%" end
    -- resize and reposition all tabs
    local shown, first
    for k, v in ipairs(found) do
        local tab = tabs.windowList[v]
        if not first then first = v:gsub("Tab", "") end
        if not shown and tab.active then
            shown = v
        elseif tab.active then
            tab.active = false
        end
        update_tab(tab, wrap(w * (k - 1)), 0, wrap(w), h)
    end
    if first and not shown and GUIframe.windows[first] then GUIframe.windows[first]:show() end
    tabs.space_pos = nil
end

local function reorderTabs(tabs, name, pos)
    local windows = tabs.windows
    while table.contains(windows, name) do
        table.remove(windows, table.index_of(windows, name))
    end
    table.insert(windows, pos, name)
end

local function makeSpace(tabs, tab, pos)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    local windows = table.deepcopy(tabs.windows)
    local space_pos = tabs.space_pos
    local tab_pos = table.index_of(windows, tab.name)
    -- calculate tab width and set height
    local num_tabs = #windows + 1
    if tab_pos then
        num_tabs = num_tabs - 1
        if pos > tab_pos then pos = pos - 1 end
        if pos == space_pos then pos = pos + 1 end
    elseif space_pos and pos >= space_pos then
        pos = pos + 1
    end
    local w, h = math.floor(100 / num_tabs), configs.tabHeight
    local function wrap(num) return tostring(num) .. "%" end
    -- resize and reposition all tabs
    if tab_pos then table.remove(windows, tab_pos) end
    for k, v in ipairs(windows) do
        if k >= pos then
            update_tab(tabs.windowList[v], wrap(w * k), 0, wrap(w), h)
        else
            update_tab(tabs.windowList[v], wrap(w * (k - 1)), 0, wrap(w), h)
        end
    end
    tabs.space_pos = pos
end

local function round(num, roundTo)
    local b, r = math.modf(num / roundTo)
    if r >= 0.5 then
        b = b + 1
    end
    return b * roundTo
end

local function setBorder(side, val)
    local funcs = { left = setBorderLeft, right = setBorderRight, top = setBorderTop, bottom = setBorderBottom }
    val = math.max(val, 0)
    funcs[side](val)
end

local function resizeContainers(side, w, h)
    if table.contains({ "left", "right" }, side) then
        local info = {
            left = {
                resize = "resizeLeft",
                cons = { "topLeftContainer", "bottomLeftContainer" },
                tabs = { "topLeftTabs", "bottomLeftTabs" },
                x = 0,
                w = w
            },
            right = {
                resize = "resizeRight",
                cons = { "topRightContainer", "bottomRightContainer" },
                tabs = { "topRightTabs", "bottomRightTabs" },
                x = w,
                w = mainW - w
            }
        }
        info = info[side]
        -- move and resize top, bottom and tab containers
        update_tab(GUIframe[info.tabs[1]], info.x, 0, info.w, configs.tabHeight)
        update_tab(GUIframe[info.tabs[2]], info.x, h, info.w, configs.tabHeight)
        GUIframe[info.cons[1]]:resize(info.w, h - configs.tabHeight)
        GUIframe[info.cons[1]]:move(info.x, configs.tabHeight)
        GUIframe[info.cons[2]]:resize(info.w, mainH - h - configs.tabHeight)
        GUIframe[info.cons[2]]:move(info.x, h + configs.tabHeight)
        -- adjust border size
        setBorder(side, info.w + configs.borderOffset)

        -- adjust width of top and bottom containers
        local x, y
        x = (GUIframe.sides.left ~= "hidden" and GUIframe.topLeftContainer:get_width()) or 0
        w = ((GUIframe.sides.right ~= "hidden" and GUIframe.topRightContainer:get_x()) or mainW) - x
        for _, con in ipairs({ GUIframe.topContainer, GUIframe.bottomContainer }) do
            y, h = con:get_y(), con:get_height()
            con:resize(w, h)
            con:move(x, y)
        end
    elseif table.contains({ "top", "bottom" }, side) then
        local x = 0
        w = mainW
        if GUIframe.sides.left ~= "hidden" then
            w = w - GUIframe.topLeftContainer:get_width()
            x = GUIframe.topLeftContainer:get_width()
        end
        if GUIframe.sides.right ~= "hidden" then w = w - GUIframe.topRightContainer:get_width() end
        local info = { top = { con = "topContainer", y = 0, h = h }, bottom = { con = "bottomContainer", y = h, h = mainH - h } }
        local con = GUIframe[info[side].con]
        con:resize(w, info[side].h)
        con:move(x, info[side].y)
        setBorder(side, info[side].h + configs.borderOffset)
    end
end

local function refresh()
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    mainW, mainH = getMainWindowSize()
    local rH, rW = configs.resizeHeight, configs.resizeWidth
    local x, y, w
    -- adjust bottom left and right container heights
    for _, C in ipairs({ GUIframe.bottomLeftContainer, GUIframe.bottomRightContainer }) do
        C:resize(C:get_width(), mainH - C:get_y())
    end
    -- reposition right containers
    w = GUIframe.topRightContainer:get_width()
    for _, C in ipairs({ GUIframe.topRightContainer, GUIframe.topRightTabs,
        GUIframe.bottomRightContainer, GUIframe.bottomRightTabs }) do
        C:move(mainW - w, C:get_y())
    end
    -- resize and reposition bottom and top containers
    w, x = mainW, 0
    if GUIframe.sides.left ~= "hidden" then
        w = w - GUIframe.topLeftContainer:get_width()
        x = GUIframe.topLeftContainer:get_width()
    end
    if GUIframe.sides.right ~= "hidden" then w = w - GUIframe.topRightContainer:get_width() end
    for _, C in ipairs({ GUIframe.topContainer, GUIframe.bottomContainer }) do
        C:resize(w, C:get_height())
        C:move(x, C.name == "topContainer" and 0 or mainH - C:get_height())
    end
    -- reposition resize labels
    x, y = GUIframe.topLeftContainer:get_width(), GUIframe.bottomLeftTabs:get_y()
    GUIframe.resizeLeft:move(x, y - rH / 2)
    x, y = GUIframe.topRightContainer:get_x(), GUIframe.bottomRightTabs:get_y()
    GUIframe.resizeRight:move(x - rW, y - rH / 2)
    x = (GUIframe.topContainer:get_width() - rW) / 2
    if GUIframe.sides.left ~= "hidden" then x = x + GUIframe.topLeftContainer:get_width() end
    y = GUIframe.topContainer:get_height()
    GUIframe.resizeTop:move(x, y)
    y = GUIframe.bottomContainer:get_y()
    GUIframe.resizeBottom:move(x, y - rH)
end

-- enables the resize label for the given side and shows all associated containers if hidden
function GUIframe.enable(side)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if not table.contains(sides, side) then error("GUIframe.enable: invalid side", 2) end
    local cons = side_containers[side]
    for _, con in ipairs(cons) do
        GUIframe[con]:show()
        for _, win in pairs(GUIframe[con].windowList) do -- loop can be removed after Geyser fix comes in
            if win.active then win:show() end
        end
    end
    if table.contains({ "left", "right" }, side) then
        setBorder(side, GUIframe[cons[1]]:get_width() + configs.borderOffset)
    else
        setBorder(side, GUIframe[cons[1]]:get_height() + configs.borderOffset)
    end
    GUIframe["resize" .. side:title()]:show()
    GUIframe.sides[side] = "enabled"
    refresh()
end

-- disables and hides the resize label for the given side, and hides all associated containers if indicated
function GUIframe.disable(side, hide)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if not table.contains(sides, side) then error("GUIframe.disable: invalid side", 2) end
    local cons = side_containers[side]
    GUIframe.sides[side] = "disabled"
    if hide then
        for _, con in ipairs(cons) do
            GUIframe[con]:hide()
            for _, win in pairs(GUIframe[con].windowList) do -- loop can be removed after Geyser fix comes in
                if win.type == "mapper" then win:hide() end
            end
        end
        local border = _G["setBorder" .. side:title()]
        border(0)
        GUIframe.sides[side] = "hidden"
    end
    GUIframe["resize" .. side:title()]:hide()
    refresh()
end

-- adds a Geyser window or container to the given container, with a tab showing the given name if applicable
function GUIframe.addWindow(window, name, container, hideText)
    if not GUIframe.initialized then config() end
    if type(container) == "table" then container = container.name end
    local con, tabs = get_containers(container)
    if not con then error("GUIframe.addWindow: invalid container name", 2) end
    if not name then error("GUIframe.addWindow: name argument required", 2) end
    -- remove window from any containers
    for _, tcon in ipairs(container_names) do
        if table.contains(GUIframe[tcon].windows, window.name) then
            GUIframe.removeWindow(name, tcon)
        end
    end
    deselectContainer(con, tabs)
    -- add tab for window, if applicable
    if tabs then
        local showText = not hideText
        window.showText = showText
        local lbl = Geyser.Label:new({ name = name .. "Tab", x = 0, y = 0, width = 10, height = 10 }, tabs)
        lbl:setStyleSheet(configs.tabStyle)
        if showText then
            lbl:echo(configs.tabEchoStyle .. "<b>" .. name)
        end
        lbl:setClickCallback("GUIframe.buttonClick", name)
        lbl:setReleaseCallback("GUIframe.buttonRelease", name)
        lbl:setMoveCallback("GUIframe.buttonMove", name)
        GUIframe.tabs[name] = lbl
        adjustTabs(tabs)
    end
    -- add window to container and set size and position
    con:add(window)
    window:resize("100%", "100%")
    window:move(0, 0)
    window:show()
    GUIframe.windows[name] = window
    raiseEvent("sysWindowResizeEvent")
end

-- removes a named Geyser window or container from the named container (using name given in GUIframe.addWindow)
function GUIframe.removeWindow(name, container)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if not container then container = GUIframe.windows[name].container end
    local con, tabs = get_containers(container)

    if not con or not table.contains(container_names, con.name) then
        error("GUIframe.removeWindow: invalid container name", 2)
    end
    if not name then error("GUIframe.removeWindow: name argument required", 2) end
    if tabs then
        local lbl = tabs.windowList[name .. "Tab"]
        if lbl then
            tabs:remove(lbl)
            adjustTabs(tabs)
            lbl:hide()
        end
    end
    local window = GUIframe.windows[name]
    con:remove(window)
    window:hide()
end

-- saves the current GUI setup, including the size of the different containers and what windows go in which container
function GUIframe.saveSettings()
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    local saveTbl = {}
    local w, h = GUIframe.topLeftContainer:get_width(), GUIframe.bottomLeftTabs:get_y()
    saveTbl.left = { w = w, h = h }
    w, h = GUIframe.topRightContainer:get_width(), GUIframe.bottomRightTabs:get_y()
    saveTbl.right = { w = w, h = h }
    w, h = GUIframe.topContainer:get_width(), GUIframe.topContainer:get_height()
    saveTbl.top = { w = w, h = h }
    w, h = GUIframe.bottomContainer:get_width(), GUIframe.bottomContainer:get_height()
    saveTbl.bottom = { w = w, h = h }

    -- get added windows and containers they are assigned to
    local windows = {}
    local text = {}
    for k, v in pairs(GUIframe.windows) do
        local con = v.container.name
        windows[con] = windows[con] or {}
        table.insert(windows[con], k)
        text[con] = text[con] or {}
        text[con][k] = v.showText
    end
    -- reorder windows to match tab order for tabbed containers
    for con, wins in pairs(windows) do
        if con:find("Left") or con:find("Right") then
            local tabs = GUIframe[con].tabs.windows
            local new = {}
            for k, v in ipairs(tabs) do
                local wname = v:gsub("Tab", "")
                table.insert(new, { wname, text[con][wname] })
            end
            windows[con] = new
        end
    end
    saveTbl.windows = windows
    saveTbl.sides = GUIframe.sides
    table.save(getMudletHomeDir() .. "/GUIframeSave.lua", saveTbl)
end

-- loads GUI setup from a previous save
function GUIframe.loadSettings(redraw)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    local saveTbl = {}
    local path = getMudletHomeDir() .. "/GUIframeSave.lua"
    path = path:gsub("\\", "/")
    mainW, mainH = getMainWindowSize()
    if not io.exists(path) then
        debugc("GUIframe.loadSettings: save file doesn't exist.")
        return
    end
    table.load(path, saveTbl)
    resizeContainers("left", saveTbl.left.w, saveTbl.left.h)
    resizeContainers("right", mainW - saveTbl.right.w, saveTbl.right.h)
    resizeContainers("top", saveTbl.top.w, saveTbl.top.h)
    resizeContainers("bottom", saveTbl.bottom.w, mainH - saveTbl.bottom.h)
    for con, wins in pairs(saveTbl.windows) do
        for _, name in ipairs(wins) do
            if type(name) == "string" then
                GUIframe.addWindow(GUIframe.windows[name], name, con)
            else
                local n, s = name[1], not name[2]
                GUIframe.addWindow(GUIframe.windows[n], n, con, s)
            end
        end
    end

    for side, state in pairs(saveTbl.sides) do
        if state == "enabled" then
            GUIframe.enable(side)
        elseif state == "disabled" then
            GUiframe.disable(side, false)
        elseif state == "hidden" then
            GUIframe.disable(side, true)
        end
    end
    -- force redraw of screen
    if redraw then
        setBackgroundColor(1, 1, 1)
        setBackgroundColor(0, 0, 0)
    end
end

-- can be called to force the script to run its config function again
function GUIframe.reinitialize()
    config()
end

-- can be called to activate a given tab without clicking on it
function GUIframe.activate(name)
    if not GUIframe.initialized then error("GUIframe not initialized", 1) end
    local window = GUIframe.windows[name]
    if window then
        local con, tabs = get_containers(window.container.name)
        -- hide and unhighlight other windows and tabs
        deselectContainer(con, tabs)
        -- show selected window
        window:show()
        window.active = true
        -- highlight selected tab
        if window.showText then
            GUIframe.tabs[name]:echo(configs.tabEchoStyle .. "<b>" .. name)
        end
    end
end

-- can be called to apply a style to a given tab
function GUIframe.styleTab(name, style)
    if not GUIframe.initialized then error("GUIframe not initialized", 1) end
    local tab = GUIframe.tabs[name]
    if tab then
        tab:setStyleSheet(style)
    end
end

-- internally used function to handle button click callbacks
function GUIframe.buttonClick(name, event)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if table.contains(resizeLabels, name) then
        if event.button == "RightButton" then
            local lbl = GUIframe[name]
            lbl.difX, lbl.difY = event.x, event.y
            lbl.savedX, lbl.savedY = getMousePosition()
            GUIframe[name].isClicked = true
        end
    elseif event.button == "LeftButton" then
        local window = GUIframe.windows[name]
        local con, tabs = get_containers(window.container.name)
        -- hide and unhighlight other windows and tabs
        deselectContainer(con, tabs)
        -- show selected window
        window:show()
        window.active = true
        -- highlight selected tab
        if window.showText then
            GUIframe.tabs[name]:echo(configs.tabEchoStyle .. "<b>" .. name)
        end
    elseif event.button == "RightButton" then
        local window, tab = GUIframe.windows[name], GUIframe.tabs[name]
        tab.savedX, tab.savedY = getMousePosition()
        tab.difX, tab.difY, tab.isClicked = event.x, event.y, true
        -- force update of coords for all tabs and tab containers
        GUIframe.tabCoords = {}
        for _, name in ipairs(tab_names) do
            get_window_coords(GUIframe[name], true)
            for tname, tab in pairs(GUIframe[name].windowList) do
                get_window_coords(tab, true)
            end
        end
    end
    raiseEvent("GUIframe.buttonClick", name, event)
end

-- internally used function to handle button release callbacks
function GUIframe.buttonRelease(name, event)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if table.contains(resizeLabels, name) then
        if event.button == "RightButton" then
            local lbl = GUIframe[name]
            lbl.savedX, lbl.savedY, lbl.difX, lbl.difY, lbl.isClicked = nil, nil, nil, nil, false
        end
    elseif event.button == "RightButton" then
        local window, tab = GUIframe.windows[name], GUIframe.tabs[name]
        local con, tabs = get_containers(window.container.name)
        tab.difX, tab.difY, tab.savedX, tab.savedY, tab.isClicked = nil, nil, nil, nil, false
        hideWindow("show_container")
        for _, tname in ipairs(tab_names) do
            local info = GUIframe[tname]
            if info.mouse_over then
                local pos = info.space_pos
                info.mouse_over = nil
                GUIframe.addWindow(window, name, tname:gsub("Tabs", ""), not window.showText)
                if pos then
                    reorderTabs(info, tab.name, pos)
                    adjustTabs(info)
                end
            end
        end
        adjustTabs(tabs)
    end
    raiseEvent("GUIframe.buttonRelease", name, event)
end

-- internally used function to handle button move callbacks
function GUIframe.buttonMove(name, event)
    if not GUIframe.initialized then error("GUIframe not initialized", 2) end
    if table.contains(resizeLabels, name) then
        lbl = GUIframe[name]
        if lbl.isClicked then
            local w, h = getMousePosition()
            w, h = round(w - lbl.difX, 10), round(h - lbl.difY, 10)
            mainW, mainH = getMainWindowSize()
            local side, cW, cH, rX, rY
            local minX = GUIframe.sides.left ~= "hidden" and GUIframe.topLeftContainer:get_width() or 0
            local maxX = GUIframe.sides.right ~= "hidden" and GUIframe.topRightContainer:get_x() or mainW
            local minY = GUIframe.sides.top ~= "hidden" and GUIframe.topContainer:get_height() or 0
            local maxY = GUIframe.sides.left ~= "hidden" and GUIframe.bottomContainer:get_y() or mainH
            local mid, min, max = GUIframe.topContainer:get_width(), math.min, math.max
            local tabH, rH, rW = configs.tabHeight, configs.resizeHeight, configs.resizeWidth
            w, h = max(w, 0), max(h, 0)
            local info = { -- specify position of resize labels and size of containers
                resizeLeft = {
                    side = "left",
                    x = min(w, maxX - rW),
                    y = min(max(h + rH / 2, tabH), mainH - tabH) - rH / 2,
                    w = min(w, maxX - rW),
                    h = min(max(h + rH / 2, tabH), mainH - tabH)
                },
                resizeRight = {
                    side = "right",
                    x = min(max(w, minX), mainW),
                    y = min(max(h + rH / 2, tabH), mainH - tabH) - rH / 2,
                    w = min(max(w, minX), mainW - rW) + rW,
                    h = min(max(h + rH / 2, tabH), mainH - tabH)
                },
                resizeTop = {
                    side = "top",
                    x = minX + (mid - rW) / 2,
                    y = min(h, maxY - rH),
                    w = maxX - minX,
                    h = min(h, maxY - rH)
                },
                resizeBottom = {
                    side = "bottom",
                    x = minX + (mid - rW) / 2,
                    y = min(max(h, minY) - rH, mainH),
                    w = maxX - minX,
                    h = min(max(h, minY) + rH, mainH)
                }
            }
            info = info[name]
            lbl:move(info.x, info.y)
            resizeContainers(info.side, info.w, info.h)
        end
    else
        local window, tab = GUIframe.windows[name], GUIframe.tabs[name]
        local con, tabs = get_containers(window.container.name)
        local x, y = getMousePosition()
        local over_con, over_tab
        if tab and tab.isClicked then
            moveWindow(tab.name, x - tab.difX, y - tab.difY)
            -- check to see if mouse is over any tab containers
            for _, tcon in ipairs(tab_names) do
                if check_overlap(tcon, x, y) then
                    over_con = tcon
                    GUIframe[tcon].mouse_over = true
                    local info = GUIframe.tabCoords[tcon]
                    local tx, ty, tw, th = info.x, info.y, info.w, info.h
                    createLabel("show_container", 0, 0, 0, 0, 1)
                    moveWindow("show_container", tx, ty)
                    resizeWindow("show_container", tw, th)
                    setLabelStyleSheet("show_container", [[
                        background-color: black;
                        border: 2px solid white;]])
                    showWindow("show_container")
                    lowerWindow("show_container")
                    -- check to see if mouse is over any tabs
                    for tname, info in pairs(GUIframe.tabs) do
                        if tname ~= name and check_overlap(info, x, y) then
                            over_tab = info.name
                            local windows = GUIframe[tcon].windows
                            local index = table.index_of(windows, over_tab)
                            makeSpace(GUIframe[tcon], tab, index)
                            break
                        end
                    end
                    break
                end
            end
            -- remove any unnecessary spaces in tab containers
            for _, name in ipairs(tab_names) do
                if name ~= over_con then
                    adjustTabs(GUIframe[name])
                    GUIframe[name].mouse_over = nil
                end
            end
        end
    end
    raiseEvent("GUIframe.buttonMove", name, event)
end

-- internally used function to handle sysWindowResizeEvent
function GUIframe.eventHandler(event, ...)
    if event == "sysWindowResizeEvent" and GUIframe.initialized then
        refresh()
    end
end

registerAnonymousEventHandler("sysWindowResizeEvent", "GUIframe.eventHandler")

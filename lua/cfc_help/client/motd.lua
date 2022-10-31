local hasDisplayedMotd = false

hook.Add( "InitPostEntity", "CFC_Help_ReadyForMotd", function()
    net.Start( "CFC_Help_ReadyForMotd" )
    net.SendToServer()
end )

local function onClose()
    hook.Run( "CFC_Help_ClosedMotd" )
    net.Start( "CFC_Help_ClosedMotd" )
    net.SendToServer()
end

local function openMotd()
    if hasDisplayedMotd then return end

    local shouldShow = hook.Run( "CFC_Help_ShowMotd" )
    if shouldShow == false then return end

    local commandInfo = CFCHelp.commandMap["!motd"]
    local url = CFCHelp:formatUrl( commandInfo.url )
    CFCHelp:openUrl( url, commandInfo.title, nil, onClose )

    hasDisplayedMotd = true
end

net.Receive( "CFC_Help_ShowMotd", openMotd )

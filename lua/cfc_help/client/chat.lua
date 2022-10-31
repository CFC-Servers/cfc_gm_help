hook.Add( "OnPlayerChat", "CFC_Help_CommandMatcher", function( ply, msg )
    local commandInfo = CFCHelp.commandMap[msg]
    if not commandInfo then return end

    if ply ~= LocalPlayer() then
        return commandInfo.silent or nil
    end

    local helpType = commandInfo.helpType

    if helpType == "html" then
        local url = CFCHelp:formatUrl( commandInfo.url )
        CFCHelp:openUrl( url, commandInfo.title )
    end

    if helpType == "function" then
        commandInfo.func()
    end
end )


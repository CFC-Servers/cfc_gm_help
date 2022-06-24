CFCHelp = {
    realm = GetConVar( "cfc_realm" ):GetString(),

    colors = {
        ui = Color( 36, 41, 67 ),
        lightBlue = Color( 83, 227, 251 ),
        lightGreen = Color( 83, 251, 191 ),
        white = Color( 255, 255, 255 ),
        grey = Color( 175, 175, 175 )
    },

    formatUrl = function( self, url )
        return string.format( url, self.realm )
    end,

    _openUrl = include( "cfc_help/client/cfc_html_panel.lua" ),
    openUrl = function( self, url, title )
        return self._openUrl( url, title, CFCHelp.colors.ui )
    end,

    externalCommandInfo = {},
    addCommandInfo = function( self, command, description )
        self.externalCommandInfo[command] = {
            description = description
        }
    end,

    commandMap = {
        ["!help"] = {
            helpType = "html",
            description = "Opens the CFC Help Articles",
            url = "https://cfcservers.org/learn/player",
            title = "CFC Help"
        },

        ["!rules"] = {
            helpType = "html",
            description = "Opens the Rules page",
            title = "CFC Rules",
            url = "https://cfcservers.org/%s/motd",
        },

        ["!motd"] = {
            helpType = "html",
            description = "Opens the Rules Summary page",
            url = "https://cfcservers.org/%s/shortrules",
            title = "CFC Rules"
        },

        ["!apply"] = {
            helpType = "steamhtml",
            description = "Opens the Applications page",
            url = "https://cfcservers.org/%s/apply"
        },

        ["!discord"] = {
            helpType = "function",
            description = "Opens our Discord invite link",
            func = function()
                chat.AddText(
                    CFCHelp.colors.lightGreen,
                    "Visit the following URL in your browser: ",
                    CFCHelp.colors.lightBlue,
                    "https://cfcservers.org/discord"
                )
            end
        },

        ["!addons"] = {
            helpType = "steamhtml",
            description = "Opens the workshop collection for this page",
            url = "https://cfcservers.org/%s/collection"
        },

        ["!commands"] = {
            helpType = "function",
            description = "Lists all available CFC commands",
            func = function()
                local helpCommands = CFCHelp.commandMap
                local externalCommands = CFCHelp.externalCommandInfo

                local commandSets = { helpCommands, externalCommands }

                chat.AddText( "\n" )
                for _, commandSet in ipairs( commandSets ) do
                    for command, data in pairs(commandSet) do
                        chat.AddText(
                            CFCHelp.colors.lightGreen, command, ": ",
                            CFCHelp.colors.lightBlue, data.description,
                            "\n"
                        )
                    end
                end
            end
        }
    }
}

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

    if helpType == "steamhtml" then
        local url = CFCHelp:formatUrl( commandInfo.url )
        gui.OpenURL( url )
    end

    if helpType == "function" then
        commandInfo.func()
    end
end )

hook.Add( "Think", "CFC_Help_Motd", function()
    hook.Remove( "Think", "CFC_Help_Motd" )

    timer.Simple( 2, function()
        local commandInfo = CFCHelp.commandMap["!motd"]
        local url = CFCHelp:formatUrl( commandInfo.url )
        CFCHelp:openUrl( url, commandInfo.title )
    end )
end )

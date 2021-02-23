CFCHelp = {
    colors = {
        ui = Color( 36, 41, 67 ),
        lightBlue = Color( 83, 227, 251 ),
        lightGreen = Color( 83, 251, 191 ),
        white = Color( 255, 255, 255 ),
        grey = Color( 175, 175, 175 )
    },

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
            url = "https://cfcservers.org/cfc3/motd",
            title = "CFC Rules",
            description = "Opens the Rules page"
        },

        ["!motd"] = {
            helpType = "html",
            description = "Opens the Rules Summary page",
            url = "https://cfcservers.org/cfc3/shortrules",
            title = "CFC Rules"
        },

        ["!apply"] = {
            helpType = "html",
            description = "Opens the Applications page",
            url = "https://cfcservers.org/apply",
            title = "CFC Applications"
        },

        ["!discord"] = {
            helpType = "function",
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
            helpType = "function",
            description = "Opens the workshop collection for this page",
            func = function()
                gui.OpenURL( "https://cfcservers.org/cfc3/collection" )
            end
        },

        ["!commands"] = {
            helpType = "function",
            description = "Lists all available CFC commands",
            func = function()
                chat.AddText( CFCHelp.colors.lightGreen, "Printing command info to your console!" )

                local helpCommands = CFCHelp.commandMap
                local externalCommands = CFCHelp.externalCommandInfo

                local commandSets = { helpCommands, externalCommands }

                for _, commandSet in ipairs( commandSets ) do
                    for command, data in pairs(commandSet) do
                        MsgC(
                            CFCHelp.colors.lightGreen, command, ": ",
                            CFCHelp.colors.lightBlue, data.description
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

    if ply == LocalPlayer() then
        local helpType = commandInfo.helpType

        if helpType == "html" then
            CFCHelp:openUrl( commandInfo.url, commandInfo.title )
        end

        if helpType == "function" then
            commandInfo.func()
        end
    end

    if commandInfo.silent then
        return true
    end
end )

hook.Add( "Think", "CFC_Help_Motd", function()
    hook.Remove( "Think", "CFC_Help_Motd" )

    local commandInfo = CFCHelp.commandMap["!motd"]
    CFCHelp:openUrl( commandInfo.url, commandInfo.title )
end )

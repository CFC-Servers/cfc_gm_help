CFCHelp = {
    colors = {
        ui = Color( 36, 41, 67, 255 ),
        lightBlue = Color( 83, 227, 251, 255 ),
        lightGreen = Color( 83, 251, 191 ),
        white = Color( 255, 255, 255, 255 ),
        grey = Color( 175, 175, 175, 255 )
    },

    commandMap = {
        ["!help"] = {
            helpType = "html",
            url = "https://cfcservers.org/learn/player",
            title = "CFC Help"
        },

        ["!rules"] = {
            helpType = "html",
            url = "https://cfcservers.org/cfc3/rules",
            title = "CFC Rules"
        },

        ["!motd"] = {
            helpType = "html",
            url = "https://cfcservers.org/cfc3/shortrules",
            title = "CFC Rules"
        },

        ["!discord"] = {
            helpType = "function",
            func = function()
                chat.AddText(
                    CFCHelp.colors.lightGreen,
                    "Visit the following URL in your browser: ",
                    CFCHelp.colors.lightBlue,
                    "https://cfcservers.org/discord "
                )
            end
        }
    }
}

function CFCHelp:openUrl( url, title )
    title = title or ""
    local window = vgui.Create( "DFrame" )

    if ScrW() > 640 then
        window:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
    else
        window:SetSize( 640, 480 )
    end

    window:Center()
    window:SetTitle( title )
    window:MakePopup()

    window.Paint = function( self, w, h )
        draw.RoundedBox( 8, 0, 0, w, h, self.colors.ui )
    end

    local html = vgui.Create( "DHTML", window )

    html:Dock( FILL )
    html:OpenURL( url )
end

local function hideScrollbar()
    -- WIP
end

hook.Add( "OnPlayerChat", "CFC_Help_CommandMatcher", function( ply, msg )
    local commandInfo = CFCHelp.commandMap[msg]

    if not commandInfo then return end

    if ply == LocalPlayer() then
        local helpType = commandInfo.helpType

        if helpType == "html" then
            CFCHelp:openUrl( commandInfo.url, commandInfo.title )
        end

        if helpType == "func" then
            commandInfo.func()
        end
    end

    if commandInfo.silent then
        return true
    end
end )

local function openHelp()
    local window = vgui.Create( "DFrame" )

    if ScrW() > 640 then
        window:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
    else
        window:SetSize( 640, 480 )
    end

    window:Center()
    window:SetTitle( "CFC Help" )
    window:MakePopup()

    window.Paint = function( self, w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 36, 41, 67, 255 ) )
    end

    local html = vgui.Create( "DHTML", window )

    html:Dock( FILL )
    html:OpenURL("https://cfcservers.org/learn/")
end

local function hideScrollbar()
    -- WIP
end

concommand.Add( "cfc_help", openHelp )

hook.Add( "OnPlayerChat", "CFC_Help_OpenHelpCommand", function( ply, msg )
    if string.sub( msg, 1, 5 ) ~= "!help" then return end

    if ply == LocalPlayer() then
        openHelp()
    end

    return true
end )

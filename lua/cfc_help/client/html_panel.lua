local noop = function() end

local function openUrl( url, title, uiColor, onClose )
    title = title or ""
    onClose = onClose or noop

    local window = vgui.Create( "DFrame" )

    if ScrW() > 640 then
        window:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
    else
        window:SetSize( 640, 480 )
    end

    window:Center()
    window:SetTitle( title )
    window:MakePopup()
    window.OnClose = onClose

    window.Paint = function( self, w, h )
        draw.RoundedBox( 8, 0, 0, w, h, uiColor )
    end

    local html = vgui.Create( "DHTML", window )

    html:Dock( FILL )
    html:OpenURL( url )
end

return openUrl

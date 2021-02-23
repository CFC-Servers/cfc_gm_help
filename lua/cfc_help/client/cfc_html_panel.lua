local function openUrl( url, title, uiColor )
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
        draw.RoundedBox( 8, 0, 0, w, h, uiColor )
    end

    local html = vgui.Create( "DHTML", window )

    html:Dock( FILL )
    html:OpenURL( url )
end

return openUrl

util.AddNetworkString( "CFC_Help_ReadyForMotd" )
util.AddNetworkString( "CFC_Help_ClosedMotd" )
util.AddNetworkString( "CFC_Help_ShowMotd" )

net.Receive( "CFC_Help_ReadyForMotd", function( _, ply )
    local shouldShow = hook.Run( "CFC_Help_ReadyForMotd", ply )
    if shouldShow == false then return end

    net.Start( "CFC_Help_ShowMotd" )
    net.Send( ply )
end )

net.Receive( "CFC_Help_ClosedMotd", function( _, ply )
    hook.Run( "CFC_Help_ClosedMotd", ply )
end )

CreateConVar( "cfc_realm", "unknown", FCVAR_REPLICATED + FCVAR_ARCHIVE )

if SERVER then
    AddCSLuaFile( "client/html_panel.lua" )
    AddCSLuaFile( "client/cfc_help.lua" )
    AddCSLuaFile( "client/chat.lua" )
    AddCSLuaFile( "client/motd.lua" )

    include( "server/motd.lua" )
else
    include( "client/cfc_help.lua" )
    include( "client/chat.lua" )
    include( "client/motd.lua" )
end

for k, v in pairs( ulx.cmdsByCategory.Menus ) do
    if v.cmd == "ulx motd" then
        table.remove( ulx.cmdsByCategory.Menus, k )
        break
    end
end

ULib.removeSayCommand( "!motd" )

print( "Removed motd command" )

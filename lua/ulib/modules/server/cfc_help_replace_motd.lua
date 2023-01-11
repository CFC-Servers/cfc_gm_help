for k, v in pairs( ulx.cmdsByCategory.Menus ) do
    if v.cmd == "ulx motd" then
        ulx.cmdsByCategory.Menus[k] = nil
        break
    end
end

ULib.removeSayCommand( "!motd" )

print( "Removed motd command" )

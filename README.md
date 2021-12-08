# CFC Help
In-game help menu for Gmod and CFC topics, can be opened with !help.

GUI:

![Optional Text](https://i.imgur.com/gMDmH0C.png)


## Hooks

### Client
 - **`GM:CFC_Help_ShowMotd( Player player )`**
Called right before displaying the Motd to the player
Return `false` to prevent the player from seeing the MotD.

 - **`GM:CFC_Help_ClosedMotd( Player player )`**
Called when the player closes the Motd with the "x" button.

### Server

 - **`GM:CFC_Help_ShowMotd( Player player )`**
Called right before displaying the Motd to a player
Return `false` to prevent the player from seeing the MotD.

**Note: **The client may still reject the Motd on the their side even if this hook completes successfully.


 - **`GM:CFC_Help_ClosedMotd( Player player )`**
Called when a player closes the Motd with the "x" button.

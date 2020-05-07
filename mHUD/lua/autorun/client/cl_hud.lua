
surface.CreateFont( "Arial", {
    font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 16,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})

---------------------------
--[[   local hideHUDElements = {
        ["DarkRP_HUD"] = true,
        ["DarkRP_EntityDisplay"] = false,
        ["DarkRP_ZombieInfo"] = false,
        ["DarkRP_LocalPlayerHUD"] = true,
        ["DarkRP_Agenda"] = false,
        ["DarkRP_Hungermod"] = true, -- Hunger Mod
  }

  hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
         if hideHUDElements[name] or name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" then return false end
 end)   ]]--


k = { "DarkRP_HUD", "CHudBattery", "CHudHealth" }

hook.Add( "HUDShouldDraw", "hidehud", function( v )
    if table.HasValue( k, v ) then return false end
end)

--------------------------   


local BulletProof = Material("C:/gmodserver/garrysmod/addons/mHUD/materials/bulletproof.png") 

local Heart = Material("C:/gmodserver/garrysmod/addons/mHUD/materials/heart-rate.png")

local Money = Material("C:/gmodserver/garrysmod/addons/mHUD/materials/money.png")

local Burger = Material("C:/gmodserver/garrysmod/addons/mHUD/materials/burger.png")

--------------------------


local function Base()

 local ply = LocalPlayer()





 surface.SetDrawColor( 255, 255, 255 )



 --- Health
  local health = LocalPlayer():Health()


    if health < 1 then 
        health = 0
    elseif health > 100 then
        health = 100
    end


    -- draw.RoundedBox(8, ScrW() - 1273, ScrH() - 130, 400, 120, Color(115, 109, 109))
    draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 87, 109, 24, Color(20, 20, 20, 220))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 85, 106, 20, Color(48, 48, 47, 170))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 85, health * 1.10 - 5, 20, Color(255, 0, 0))
    draw.SimpleText(health, Arial, ScrW() * 0.048, ScrH() - 75, Color(255, 255, 255), 1, 1)
    surface.SetMaterial( Heart )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() * 0.093, ScrH() - 90, 30, 30 ) 


 --- Armor
  local armor = LocalPlayer():Armor()

    if armor < 1 then 
        armor = 0
    elseif armor > 99 then
        armor = 104
    end


    draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 60, 109, 24, Color(20, 20, 20, 220))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 58, 106, 20, Color(48, 48, 47, 170))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 58, armor , 20, Color(41, 11, 214))
    draw.SimpleText(armor, Arial, ScrW() * 0.048, ScrH() - 50, Color(255, 255, 255), 1, 1)
    surface.SetMaterial( BulletProof )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() * 0.095, ScrH() - 60, 25, 25 ) 

 --- Hunger

   local hunger  = math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0)

    if hunger < 1 then 
        hunger = 0
    elseif hunger > 100 then
        hunger = 105
    end



    draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 30, 110, 24, Color(20, 20, 20, 220))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 28, 106, 20, Color(48, 48, 47, 170))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 28, hunger, 20, Color(224, 177, 20))
    surface.SetMaterial( Burger )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() * 0.095, ScrH() - 30, 25, 25 ) 


 --- Nickname

    draw.SimpleText(LocalPlayer():Nick(), "TargetID" , ScrW() * 0.021, ScrH() - 140, Color(255, 255, 255, 255))
 


 --Money 
 
 draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 119, 110, 24, Color(20, 20, 20, 220))
    draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 117, 106, 20, Color(48, 48, 47, 170))
    draw.DrawText( "Wallet: " .. DarkRP.formatMoney( ply:getDarkRPVar( "money" ) ), "Arial", ScrW() * 0.0485, ScrH() - 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    surface.SetMaterial( Money )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() * 0.095, ScrH() - 117, 25, 25 )





end



 
/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
function DrawHUD()
       --[[ localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
        if not IsValid(localplayer) then return end ]]--
       
    
        Base()

       
end
hook.Add("HUDPaint", "DrawHUD", DrawHUD)








if SERVER then
    resource.AddFile("materials/bulletproof.png")
    resource.AddFile("materials/heart-rate.png")
    resource.AddFile("materials/money.png")
    resource.AddFile("materials/burger.png")
elseif CLIENT then
    surface.CreateFont("Arial", {
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
        outline = false
    })

    local ToHide = {
        ["DarkRP_HUD"] = true,
        ["CHudBattery"] = true,
        ["CHudHealth"] = true
    }

    hook.Add("HUDShouldDraw", "hidehud", function(n)
        if ToHide[n] then return false end
    end)

    local BulletProof = Material("bulletproof.png")
    local Heart = Material("heart-rate.png")
    local Money = Material("money.png")
    local Burger = Material("burger.png")

    local function Base()
        local ply = LocalPlayer()
        local health = LocalPlayer():Health()
        local armor = LocalPlayer():Armor()

        if health < 1 then
            health = 0
        elseif health > 100 then
            health = 100
        end

        if armor < 1 then
            armor = 0
        elseif armor > 99 then
            armor = 104
        end

        if (engine.ActiveGamemode() ~= "sandbox") then
            local hunger = math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0)

            if hunger < 1 then
                hunger = 0
            elseif hunger > 100 then
                hunger = 105
            end
        end

        surface.SetDrawColor(255, 255, 255)
        -- draw.RoundedBox(8, ScrW() - 1273, ScrH() - 130, 400, 120, Color(115, 109, 109))
        draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 87, 109, 24, Color(20, 20, 20, 220))
        draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 85, 106, 20, Color(48, 48, 47, 170))
        draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 85, health * 1.10 - 5, 20, Color(255, 0, 0))
        draw.SimpleText(health, Arial, ScrW() * 0.048, ScrH() - 75, Color(255, 255, 255), 1, 1)
        surface.SetMaterial(Heart)
        surface.DrawTexturedRect(ScrW() * 0.093, ScrH() - 90, 30, 30)
        draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 60, 109, 24, Color(20, 20, 20, 220))
        draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 58, 106, 20, Color(48, 48, 47, 170))
        draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 58, armor, 20, Color(41, 11, 214))
        draw.SimpleText(armor, Arial, ScrW() * 0.048, ScrH() - 50, Color(255, 255, 255), 1, 1)
        surface.SetMaterial(BulletProof)
        surface.DrawTexturedRect(ScrW() * 0.095, ScrH() - 60, 25, 25)
        --nickname
        draw.SimpleText(LocalPlayer():Nick(), "TargetID", ScrW() * 0.021, ScrH() - 140, Color(255, 255, 255, 255))

        if (engine.ActiveGamemode() ~= "sandbox") then
            draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 30, 110, 24, Color(20, 20, 20, 220))
            draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 28, 106, 20, Color(48, 48, 47, 170))
            draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 28, hunger, 20, Color(224, 177, 20))
            surface.SetMaterial(Burger)
            surface.DrawTexturedRect(ScrW() * 0.095, ScrH() - 30, 25, 25)
            -- money
            draw.RoundedBox(3, ScrW() * 0.004, ScrH() - 119, 110, 24, Color(20, 20, 20, 220))
            draw.RoundedBox(3, ScrW() * 0.0058, ScrH() - 117, 106, 20, Color(48, 48, 47, 170))
            draw.DrawText("Wallet: " .. DarkRP.formatMoney(ply:getDarkRPVar("money")), "Arial", ScrW() * 0.0485, ScrH() - 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            surface.SetMaterial(Money)
            surface.DrawTexturedRect(ScrW() * 0.095, ScrH() - 117, 25, 25)
        end
    end

    hook.Add("HUDPaint", "DrawHUD", Base)
end
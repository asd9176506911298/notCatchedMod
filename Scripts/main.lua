local function enableGod(isEnable)
    local player = FindFirstOf("BPC_TBCCharacter_C")
    if player then
        player.bCanBeCatched = not isEnable
    end
end

local function modifyLantern(enable,radius, angle, r, g, b)
    local lantern = FindFirstOf("BP_Lantern_C")

    if lantern then
        local spotLight = lantern.SpotLight
        spotLight.AttenuationRadius = radius
        spotLight.InnerConeAngle = angle
        spotLight.OuterConeAngle = angle
        spotLight.LightColor.R = r
        spotLight.LightColor.G = g
        spotLight.LightColor.B = b
        if enable == 1 then
            spotLight.LightFalloffExponent = 0
            spotLight.bUseTemperature = true
            lantern.SpotLightIntensity = 50
        elseif enable == 0 then
            spotLight.LightFalloffExponent = 2
            spotLight.bUseTemperature = false
            lantern.SpotLightIntensity = 300
        end
        print("lantern")
    end
    
end

RegisterConsoleCommandHandler("god", function(FullCommand, Parameters)

    if #Parameters < 1 then return false end

    if Parameters[1] == "1" then
        enableGod(true)
    elseif Parameters[1] == "0" then
        enableGod(false)
    end

    return true
end)


RegisterConsoleCommandHandler("lan", function(FullCommand, Parameters)

    if #Parameters < 1 then return false end

    if Parameters[1] == "1" then
        modifyLantern(1,5000,360,255,255,255)

    elseif Parameters[1] == "0" then
        modifyLantern(0,700,30,0,74,202)
    end

    return true
end)

RegisterConsoleCommandHandler("rgb", function(FullCommand, Parameters)
    RegisterHook("/Game/Core/Lantern/BP_Lantern.BP_Lantern_C:SwingSound", function(self)
        if self:get() then
            local spotLight = self:get().SpotLight
            spotLight.LightColor.R = math.random(255)
            spotLight.LightColor.G = math.random(255)
            spotLight.LightColor.B = math.random(255)
        end
    end)
    
    return true
end)

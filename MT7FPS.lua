--========================================================--
--                     MT7 FPS V4                       --
--              Adaptive FPS Engine                     --
--========================================================--

local MT7FPS = {}

MT7FPS.Version = "4.0"
MT7FPS.TargetFPS = 70
MT7FPS.Enabled = false
MT7FPS.Extreme = false
MT7FPS.Level = 0

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local connections = {}
local saved = {}

--========================================================--
--                 ANTI-FREEZE LEVE                      --
--========================================================--

local FreezeProtectionEnabled = false
local FreezeTimer = 0

local FreezeSaved = {}
local FreezeOldQuality = nil

local function FreezeRemember(object, property)
    if not object then
        return
    end

    FreezeSaved[object] = FreezeSaved[object] or {}

    if FreezeSaved[object][property] == nil then
        local ok, value = pcall(function()
            return object[property]
        end)

        if ok then
            FreezeSaved[object][property] = value
        end
    end
end

local function FreezeSet(object, property, value)
    if not object then
        return
    end

    FreezeRemember(object, property)

    pcall(function()
        object[property] = value
    end)
end

local function FreezeOptimizeLighting()
    -- Sombras
    FreezeSet(Lighting, "GlobalShadows", false)

    -- Iluminação simplificada
    pcall(function()
        FreezeSet(Lighting, "EnvironmentDiffuseScale", 0)
        FreezeSet(Lighting, "EnvironmentSpecularScale", 0)
    end)

    -- Efeitos pesados da iluminação
    for _, object in ipairs(Lighting:GetDescendants()) do
        if object:IsA("BloomEffect")
        or object:IsA("BlurEffect")
        or object:IsA("ColorCorrectionEffect")
        or object:IsA("DepthOfFieldEffect")
        or object:IsA("SunRaysEffect") then

            FreezeSet(object, "Enabled", false)
        end
    end
end

local function FreezeOptimizeTerrain()
    local terrain = Workspace:FindFirstChildOfClass("Terrain")

    if not terrain then
        return
    end

    pcall(function()
        FreezeSet(terrain, "Decoration", false)
    end)

    pcall(function()
        FreezeSet(terrain, "WaterWaveSize", 0)
        FreezeSet(terrain, "WaterWaveSpeed", 0)
        FreezeSet(terrain, "WaterReflectance", 0)
    end)
end

local function EnableFreezeProtection()
    if FreezeProtectionEnabled then
        return
    end

    FreezeProtectionEnabled = true
    FreezeTimer = 0

    pcall(function()
        FreezeOldQuality = settings().Rendering.QualityLevel
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    -- Reduz detalhes imediatamente,
    -- mas sem escanear o Workspace inteiro.
    FreezeOptimizeLighting()
    FreezeOptimizeTerrain()
end

local function DisableFreezeProtection()
    FreezeProtectionEnabled = false
    FreezeTimer = 0

    -- Restaura propriedades alteradas pelo Anti-Freeze.
    for object, properties in pairs(FreezeSaved) do
        if object then
            for property, value in pairs(properties) do
                pcall(function()
                    object[property] = value
                end)
            end
        end
    end

    table.clear(FreezeSaved)

    if FreezeOldQuality then
        pcall(function()
            settings().Rendering.QualityLevel = FreezeOldQuality
        end)
    end

    FreezeOldQuality = nil
end

function MT7FPS.EnableFreezeProtection()
    EnableFreezeProtection()
    return true
end

function MT7FPS.DisableFreezeProtection()
    DisableFreezeProtection()
end

function MT7FPS.IsFreezeProtectionEnabled()
    return FreezeProtectionEnabled
end

local function remember(object, property)
    if not object then
        return
    end

    saved[object] = saved[object] or {}

    if saved[object][property] == nil then
        local ok, value = pcall(function()
            return object[property]
        end)

        if ok then
            saved[object][property] = value
        end
    end
end

local function setProperty(object, property, value)
    if not object then
        return
    end

    remember(object, property)

    pcall(function()
        object[property] = value
    end)
end

local function optimizeObject(object, level)
    if not object then
        return
    end

    -- Partículas
    if object:IsA("ParticleEmitter") then
        setProperty(object, "Enabled", false)

    elseif object:IsA("Trail") then
        setProperty(object, "Enabled", false)

    elseif object:IsA("Beam") then
        setProperty(object, "Enabled", false)

    -- Fumaça / fogo / efeitos
    elseif object:IsA("Smoke") then
        setProperty(object, "Enabled", false)

    elseif object:IsA("Fire") then
        setProperty(object, "Enabled", false)

    elseif object:IsA("Sparkles") then
        setProperty(object, "Enabled", false)

    -- Luzes
    elseif object:IsA("PointLight")
        or object:IsA("SpotLight")
        or object:IsA("SurfaceLight") then

        setProperty(object, "Enabled", false)

        if level >= 2 then
            setProperty(object, "Shadows", false)
        end

    -- Pós-processamento
    elseif object:IsA("BloomEffect")
        or object:IsA("BlurEffect")
        or object:IsA("ColorCorrectionEffect")
        or object:IsA("DepthOfFieldEffect")
        or object:IsA("SunRaysEffect") then

        setProperty(object, "Enabled", false)

    -- Nuvens
    elseif object:IsA("Clouds") then
        setProperty(object, "Enabled", false)

    -- Texturas
    elseif level >= 2 and object:IsA("Decal") then
        setProperty(object, "Transparency", 1)

    elseif level >= 2 and object:IsA("Texture") then
        setProperty(object, "Transparency", 1)

    -- Sombras das partes
    elseif level >= 2 and object:IsA("BasePart") then
        setProperty(object, "CastShadow", false)
    end
end

local function optimizeWorld(level)
    level = level or 1

    for _, object in ipairs(Workspace:GetDescendants()) do
        optimizeObject(object, level)
    end

    -- Iluminação global
    setProperty(Lighting, "GlobalShadows", false)

    if level >= 2 then
        setProperty(Lighting, "EnvironmentDiffuseScale", 0)
        setProperty(Lighting, "EnvironmentSpecularScale", 0)
    end

    -- Qualidade gráfica do Roblox
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end
--========================================================--
--                  ADAPTIVE FPS ENGINE                 --
--========================================================--

local function getLevelFromFPS(fps)
    if not MT7FPS.Enabled then
        return 0
    end

    if MT7FPS.Extreme then
        return 3
    end

    if fps < 30 then
        return 3
    elseif fps < 45 then
        return 2
    elseif fps < 60 then
        return 1
    else
        return 0
    end
end

local function applyLevel(level)
    if level == MT7FPS.Level then
        return
    end

    MT7FPS.Level = level

    if level > 0 then
        optimizeWorld(level)
    end
end

function MT7FPS.Enable()
    if MT7FPS.Enabled then
        return
    end

    MT7FPS.Enabled = true
    MT7FPS.Level = 0

    optimizeWorld(1)

    if connections.DescendantAdded then
        connections.DescendantAdded:Disconnect()
    end

    connections.DescendantAdded = Workspace.DescendantAdded:Connect(function(object)
        if MT7FPS.Enabled then
            task.defer(function()
                optimizeObject(object, MT7FPS.Level > 0 and MT7FPS.Level or 1)
            end)
        end
    end)
end

function MT7FPS.Disable()
    MT7FPS.Enabled = false
    MT7FPS.Extreme = false
    MT7FPS.Level = 0

    if connections.DescendantAdded then
        connections.DescendantAdded:Disconnect()
        connections.DescendantAdded = nil
    end
end

function MT7FPS.SetExtreme(enabled)
    MT7FPS.Extreme = enabled == true

    if MT7FPS.Enabled then
        if MT7FPS.Extreme then
            optimizeWorld(3)
            MT7FPS.Level = 3
        else
            MT7FPS.Level = 1
            optimizeWorld(1)
        end
    end
end

function MT7FPS.SetTarget(fps)
    fps = tonumber(fps)

    if not fps then
        return false
    end

    fps = math.clamp(math.floor(fps), 30, 240)
    MT7FPS.TargetFPS = fps

    return true
end

function MT7FPS.GetStatus()
    return {
        Enabled = MT7FPS.Enabled,
        Extreme = MT7FPS.Extreme,
        TargetFPS = MT7FPS.TargetFPS,
        Level = MT7FPS.Level
    }
end

function MT7FPS.Restore()
    for object, properties in pairs(saved) do
        if object and object.Parent then
            for property, value in pairs(properties) do
                pcall(function()
                    object[property] = value
                end)
            end
        end
    end

    table.clear(saved)
    MT7FPS.Level = 0
end

--========================================================--
--                    FPS MONITOR                        --
--========================================================--

local frameCount = 0
local lastTime = os.clock()
local currentFPS = 0

connections.RenderStepped = RunService.RenderStepped:Connect(function()
    frameCount += 1

    local now = os.clock()
    local elapsed = now - lastTime

    if elapsed >= 1 then
        currentFPS = math.floor(frameCount / elapsed + 0.5)

        frameCount = 0
        lastTime = now

        if MT7FPS.Enabled then
            local level = getLevelFromFPS(currentFPS)

            if level > 0 then
                applyLevel(level)
            end
        end
    end
end)

function MT7FPS.GetFPS()
    return currentFPS
end

--========================================================--
--                     FPS CAP                          --
--========================================================--

function MT7FPS.SetFPSCap(value)
    value = tonumber(value)

    if not value then
        return false
    end

    if value <= 0 then
        return false
    end

    if setfpscap then
        local ok = pcall(function()
            setfpscap(value)
        end)

        return ok
    end

    return false
end
--========================================================--
--                 TARGET FPS ENGINE                    --
--========================================================--

function MT7FPS.SetAdaptive(enabled)
    MT7FPS.Enabled = enabled == true

    if MT7FPS.Enabled then
        optimizeWorld(1)
        MT7FPS.Level = 1
    else
        MT7FPS.Level = 0
    end

    return MT7FPS.Enabled
end

function MT7FPS.GetTarget()
    return MT7FPS.TargetFPS
end

function MT7FPS.GetLevel()
    return MT7FPS.Level
end

function MT7FPS.IsEnabled()
    return MT7FPS.Enabled
end

--========================================================--
--                    QUICK BOOST                       --
--========================================================--

function MT7FPS.QuickBoost()
    -- FPS BOOSTER LEVE
    -- Não ativa Adaptive
    -- Não executa optimizeWorld()
    -- Não percorre o Workspace

    pcall(function()
        MT7FPS.Enabled = false
        MT7FPS.Extreme = false
        MT7FPS.Level = 0

        -- Qualidade mínima
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        -- Sombras desligadas
        setProperty(Lighting, "GlobalShadows", false)

        -- Remove efeitos pesados da iluminação
        for _, object in ipairs(Lighting:GetDescendants()) do
            if object:IsA("BloomEffect")
                or object:IsA("BlurEffect")
                or object:IsA("ColorCorrectionEffect")
                or object:IsA("DepthOfFieldEffect")
                or object:IsA("SunRaysEffect") then

                setProperty(object, "Enabled", false)
            end
        end
    end)

    return true
end

function MT7FPS.ExtremeBoost()
    MT7FPS.Enabled = true
    MT7FPS.Extreme = true
    MT7FPS.Level = 3

    optimizeWorld(3)

    return true
end

--========================================================--
--                  FRAME PROTECTION                    --
--========================================================--

--========================================================--
--                 ANTI-FREEZE LEVE                      --
--========================================================--

connections.FreezeProtection = RunService.Heartbeat:Connect(function(dt)
    if not FreezeProtectionEnabled then
        return
    end

    FreezeTimer += dt

    -- Verificação bem espaçada para não criar carga constante.
    if FreezeTimer < 5 then
        return
    end

    FreezeTimer = 0

    -- Apenas proteção leve.
    -- NÃO ativa Adaptive.
    -- NÃO executa optimizeWorld().
    -- NÃO percorre Workspace:GetDescendants().
    if currentFPS > 0 and currentFPS < 25 then
        pcall(function()
            if Lighting.GlobalShadows then
                setProperty(Lighting, "GlobalShadows", false)
            end
        end)
    end
end)

--========================================================--
--                   DESCRIPTION                        --
--========================================================--

function MT7FPS.GetInfo()
    return {
        Version = MT7FPS.Version,
        Target = MT7FPS.TargetFPS,
        FPS = currentFPS,
        Level = MT7FPS.Level,
        Enabled = MT7FPS.Enabled,
        Extreme = MT7FPS.Extreme
    }
end

--========================================================--
--                      DESTROY                         --
--========================================================--

function MT7FPS.Destroy()
    MT7FPS.Enabled = false

    for name, connection in pairs(connections) do
        if connection then
            pcall(function()
                connection:Disconnect()
            end)
        end

        connections[name] = nil
    end

    MT7FPS.Restore()

    table.clear(saved)
end

--========================================================--
--                       START                          --
--========================================================--

print("==============================================")
print("🚀 MT7 FPS V4")
print("🎯 Adaptive Target: " .. MT7FPS.TargetFPS .. " FPS")
print("🧊 Freeze Protection: READY")
print("⚡ Adaptive Engine: READY")
print("==============================================")

--==================================================
-- 🚀 FPS MASTER V4.1
--==================================================

local FPSMasterEnabled = false
local FPSMasterLevel = "FREE"

local FPSMasterSaved = {}

local function FPSMasterSave(object, property)
    if not object then
        return
    end

    FPSMasterSaved[object] = FPSMasterSaved[object] or {}

    if FPSMasterSaved[object][property] == nil then
        pcall(function()
            FPSMasterSaved[object][property] = object[property]
        end)
    end
end

local function FPSMasterSet(object, property, value)
    FPSMasterSave(object, property)

    pcall(function()
        object[property] = value
    end)
end

local function FPSMasterOptimizeBasic()

    for _, object in ipairs(workspace:GetDescendants()) do

        -- ✨ Partículas e efeitos
        if object:IsA("ParticleEmitter")
            or object:IsA("Trail")
            or object:IsA("Beam")
            or object:IsA("Smoke")
            or object:IsA("Fire")
            or object:IsA("Sparkles") then

            FPSMasterSet(object, "Enabled", false)

        -- 🌫️ Pós-processamento
        elseif object:IsA("PostEffect") then

            FPSMasterSet(object, "Enabled", false)

        -- 💡 Luzes locais
        elseif object:IsA("PointLight")
            or object:IsA("SpotLight")
            or object:IsA("SurfaceLight") then

            FPSMasterSet(object, "Enabled", false)

        -- 🌑 Sombras dos objetos
        elseif object:IsA("BasePart") then

            FPSMasterSet(object, "CastShadow", false)

        end
    end

    -- 🌑 Sombras globais
    pcall(function()
        FPSMasterSet(Lighting, "GlobalShadows", false)
    end)

end

local function FPSMasterOptimizeAdvanced()

    FPSMasterOptimizeBasic()

    for _, object in ipairs(workspace:GetDescendants()) do

        if object:IsA("Decal")
            or object:IsA("Texture") then

            FPSMasterSet(object, "Transparency", 1)

        elseif object:IsA("BasePart") then

            FPSMasterSet(object, "CastShadow", false)

        end
    end

    pcall(function()
        FPSMasterSet(Lighting, "GlobalShadows", false)
    end)
end

function MT7FPS.EnableFPSMaster(level)

    if FPSMasterEnabled then
        return true
    end

    FPSMasterEnabled = true
    FPSMasterLevel = level or "FREE"

    if FPSMasterLevel == "KEY" then
        FPSMasterOptimizeAdvanced()
    else
        FPSMasterOptimizeBasic()
    end

    return true
end

function MT7FPS.DisableFPSMaster()

    if not FPSMasterEnabled then
        return
    end

    FPSMasterEnabled = false

    for object, properties in pairs(FPSMasterSaved) do

        if object and object.Parent then

            for property, value in pairs(properties) do

                pcall(function()
                    object[property] = value
                end)

            end
        end
    end

    FPSMasterSaved = {}

end

function MT7FPS.IsFPSMasterEnabled()
    return FPSMasterEnabled
end

return MT7FPS

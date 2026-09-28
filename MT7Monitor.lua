--==================================================
-- MT7 HUB V4
-- MT7Monitor.lua
-- FPS + Ping Monitor
--==================================================

local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local MT7Monitor = {}

MT7Monitor.Version = "4.0"
MT7Monitor.Running = false
MT7Monitor.Visible = true

MT7Monitor.FPS = 0
MT7Monitor.Ping = 0

local updateConnection = nil
local fpsConnection = nil
local monitorGui = nil
local monitorLabel = nil

local frameCounter = 0
local lastFPSUpdate = os.clock()

--------------------------------------------------
-- PEGAR PING
--------------------------------------------------

local function GetPing()

    local ping = 0

    pcall(function()

        local network = Stats:FindFirstChild("Network")

        if network then

            local serverStats =
                network:FindFirstChild("ServerStatsItem")

            if serverStats then

                local dataPing =
                    serverStats:FindFirstChild("Data Ping")

                if dataPing then

                    local value = dataPing:GetValueString()

                    local number =
                        tonumber(
                            string.match(value, "%d+")
                        )

                    if number then
                        ping = math.floor(number)
                    end
                end
            end
        end

    end)

    return ping
end

--------------------------------------------------
-- CRIAR MONITOR
--------------------------------------------------

function MT7Monitor.Create(parent)

    if not parent then
        return nil
    end

    if monitorGui then
        pcall(function()
            monitorGui:Destroy()
        end)

        monitorGui = nil
        monitorLabel = nil
    end

    monitorGui = Instance.new("Frame")

    monitorGui.Name = "MT7Monitor"
    monitorGui.Size = UDim2.new(0, 125, 0, 50)
    monitorGui.Position = UDim2.new(1, -135, 0, 10)

    monitorGui.BackgroundColor3 =
        Color3.fromRGB(10, 10, 14)

    monitorGui.BackgroundTransparency = 0.15

    monitorGui.BorderSizePixel = 0

    monitorGui.Parent = parent

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, 10)

    corner.Parent = monitorGui

    local stroke = Instance.new("UIStroke")

    stroke.Color =
        Color3.fromRGB(130, 70, 255)

    stroke.Thickness = 1.5

    stroke.Transparency = 0.15

    stroke.Parent = monitorGui

    monitorLabel = Instance.new("TextLabel")

    monitorLabel.Name = "Stats"

    monitorLabel.Size =
        UDim2.new(1, -10, 1, -6)

    monitorLabel.Position =
        UDim2.new(0, 5, 0, 3)

    monitorLabel.BackgroundTransparency = 1

    monitorLabel.TextColor3 =
        Color3.fromRGB(255, 255, 255)

    monitorLabel.TextSize = 14

    monitorLabel.Font =
        Enum.Font.GothamBold

    monitorLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    monitorLabel.TextYAlignment =
        Enum.TextYAlignment.Center

    monitorLabel.Text =
        "FPS: --\nPING: --"

    monitorLabel.Parent = monitorGui

    return monitorGui
end

--------------------------------------------------
-- ATUALIZAR TEXTO
--------------------------------------------------

function MT7Monitor.UpdateDisplay()

    if not monitorLabel then
        return
    end

    monitorLabel.Text =
        "FPS: " .. tostring(MT7Monitor.FPS) ..
        "\nPING: " .. tostring(MT7Monitor.Ping) .. " ms"
end

--------------------------------------------------
-- INICIAR MONITOR
--------------------------------------------------

function MT7Monitor.Start()

    if MT7Monitor.Running then
        return
    end

    MT7Monitor.Running = true

    frameCounter = 0
    lastFPSUpdate = os.clock()

    fpsConnection = RunService.RenderStepped:Connect(function()

        if not MT7Monitor.Running then
            return
        end

        frameCounter += 1

        local currentTime = os.clock()
        local elapsed = currentTime - lastFPSUpdate

        if elapsed >= 0.75 then

            MT7Monitor.FPS =
                math.floor(frameCounter / elapsed + 0.5)

            frameCounter = 0
            lastFPSUpdate = currentTime

        end
    end)

    updateConnection =
        task.spawn(function()

            while MT7Monitor.Running do

                MT7Monitor.Ping =
                    GetPing()

                MT7Monitor.UpdateDisplay()

                task.wait(0.75)
            end

        end)
end

--------------------------------------------------
-- PARAR MONITOR
--------------------------------------------------

function MT7Monitor.Stop()

    MT7Monitor.Running = false

    if fpsConnection then

        pcall(function()
            fpsConnection:Disconnect()
        end)

        fpsConnection = nil
    end

    updateConnection = nil
end

--------------------------------------------------
-- MOSTRAR / ESCONDER
--------------------------------------------------

function MT7Monitor.SetVisible(state)

    MT7Monitor.Visible = state

    if monitorGui then
        monitorGui.Visible = state
    end
end

--------------------------------------------------
-- ALTERNAR VISIBILIDADE
--------------------------------------------------

function MT7Monitor.Toggle()

    MT7Monitor.SetVisible(
        not MT7Monitor.Visible
    )

    return MT7Monitor.Visible
end

--------------------------------------------------
-- PEGAR ESTATÍSTICAS
--------------------------------------------------

function MT7Monitor.GetStats()

    return {
        FPS = MT7Monitor.FPS,
        Ping = MT7Monitor.Ping,
        Running = MT7Monitor.Running,
        Visible = MT7Monitor.Visible
    }
end

--------------------------------------------------
-- DESTRUIR
--------------------------------------------------

function MT7Monitor.Destroy()

    MT7Monitor.Stop()

    if monitorGui then

        pcall(function()
            monitorGui:Destroy()
        end)

        monitorGui = nil
        monitorLabel = nil
    end

    MT7Monitor.FPS = 0
    MT7Monitor.Ping = 0
end

--------------------------------------------------
-- INFORMAÇÕES
--------------------------------------------------

function MT7Monitor.GetInfo()

    return {
        Version = MT7Monitor.Version,
        FPS = MT7Monitor.FPS,
        Ping = MT7Monitor.Ping,
        Running = MT7Monitor.Running
    }
end

--------------------------------------------------
-- STATUS
--------------------------------------------------

print("==============================================")
print("📊 MT7 MONITOR V4")
print("📈 FPS Monitor: READY")
print("📡 Ping Monitor: READY")
print("📱 Mobile: READY")
print("🧹 Cleanup: READY")
print("==============================================")

return MT7Monitor

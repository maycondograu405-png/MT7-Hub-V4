--==================================================
-- MT7 HUB V4
-- MT7HubV4.lua
-- MAIN CONTROLLER
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIGURAÇÃO DO REPOSITÓRIO
--==================================================

local BASE_URL =
    "https://raw.githubusercontent.com/maycondograu405-png/MT7-Hub-V4/refs/heads/main/"

local function LoadModule(name)

    local success, result = pcall(function()

        local source =
            game:HttpGet(
                BASE_URL .. name .. ".lua"
            )

        local module =
            loadstring(source)

        if not module then
            error("Loadstring não disponível.")
        end

        return module()

    end)

    if success then
        return result
    end

    warn(
        "[MT7] Falha ao carregar " ..
        name .. ": " ..
        tostring(result)
    )

    return nil
end

--==================================================
-- CARREGAR MÓDULOS
--==================================================

local MT7FPS =
    LoadModule("MT7FPS")

local MT7Animations =
    LoadModule("MT7Animations")

local MT7Letters =
    LoadModule("MT7Letters")

local MT7Themes =
    LoadModule("MT7Themes")

local MT7Monitor =
    LoadModule("MT7Monitor")

local MT7Settings =
    LoadModule("MT7Settings")

--==================================================
-- LIMPAR HUB ANTIGO
--==================================================

pcall(function()

    local old =
        Player.PlayerGui:FindFirstChild(
            "MT7HubV4"
        )

    if old then
        old:Destroy()
    end

end)

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name = "MT7HubV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = Player.PlayerGui

--==================================================
-- CORES
--==================================================

local COLORS = {

    Background =
        Color3.fromRGB(8, 8, 12),

    Panel =
        Color3.fromRGB(14, 13, 20),

    Panel2 =
        Color3.fromRGB(20, 18, 28),

    Purple =
        Color3.fromRGB(145, 70, 255),

    Blue =
        Color3.fromRGB(75, 120, 255),

    White =
        Color3.fromRGB(245, 245, 250),

    Gray =
        Color3.fromRGB(155, 155, 165),

    DarkGray =
        Color3.fromRGB(35, 34, 42)
}

--==================================================
-- FUNÇÕES DE UI
--==================================================

local function Corner(object, radius)

    local corner =
        Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius or 10)

    corner.Parent = object

    return corner
end

local function Stroke(object, color, thickness)

    local stroke =
        Instance.new("UIStroke")

    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.15

    stroke.Parent = object

    return stroke
end

local function MakeButton(parent, text)

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(1, 0, 0, 42)

    button.BackgroundColor3 =
        COLORS.Panel2

    button.BorderSizePixel = 0

    button.Text =
        text

    button.TextColor3 =
        COLORS.White

    button.TextSize = 14

    button.Font =
        Enum.Font.GothamBold

    button.AutoButtonColor = false

    button.Parent = parent

    Corner(button, 9)

    local stroke =
        Stroke(
            button,
            COLORS.DarkGray,
            1
        )

    button.MouseEnter:Connect(function()

        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(
                        32, 27, 45
                    )
            }
        ):Play()

        stroke.Color =
            COLORS.Purple
    end)

    button.MouseLeave:Connect(function()

        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    COLORS.Panel2
            }
        ):Play()

        stroke.Color =
            COLORS.DarkGray
    end)

    return button
end

--==================================================
-- TELA DE INTRO
--==================================================

local Intro =
    Instance.new("Frame")

Intro.Size =
    UDim2.new(1, 0, 1, 0)

Intro.BackgroundColor3 =
    Color3.fromRGB(0, 0, 0)

Intro.BorderSizePixel = 0
Intro.ZIndex = 100
Intro.Parent = ScreenGui

local IntroTitle =
    Instance.new("TextLabel")

IntroTitle.AnchorPoint =
    Vector2.new(0.5, 0.5)

IntroTitle.Position =
    UDim2.new(0.5, 0, 0.5, 0)

IntroTitle.Size =
    UDim2.new(0.8, 0, 0, 80)

IntroTitle.BackgroundTransparency = 1

IntroTitle.Text =
    "MT7 HUB"

IntroTitle.TextColor3 =
    Color3.fromRGB(255, 255, 255)

IntroTitle.TextTransparency = 1

IntroTitle.TextScaled = true

IntroTitle.Font =
    Enum.Font.GothamBlack

IntroTitle.Parent = Intro

--==================================================
-- PAINEL PRINCIPAL
--==================================================

local Main =
    Instance.new("Frame")

Main.AnchorPoint =
    Vector2.new(0.5, 0.5)

Main.Position =
    UDim2.new(
        0.5,
        0,
        0.5,
        0
    )

Main.Size =
    UDim2.new(
        0.86,
        0,
        0,
        390
    )

Main.BackgroundColor3 =
    COLORS.Background

Main.BorderSizePixel = 0

Main.Visible = false

Main.Parent = ScreenGui

Corner(Main, 16)

local MainStroke =
    Stroke(
        Main,
        COLORS.Purple,
        1.5
    )

--==================================================
-- TITULO
--==================================================

local Title =
    Instance.new("TextLabel")

Title.Position =
    UDim2.new(0, 18, 0, 12)

Title.Size =
    UDim2.new(1, -36, 0, 35)

Title.BackgroundTransparency = 1

Title.Text =
    "🌙 MT7 HUB V4"

Title.TextColor3 =
    COLORS.White

Title.TextSize = 21

Title.Font =
    Enum.Font.GothamBlack

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Parent = Main

--==================================================
-- STATUS
--==================================================

local Status =
    Instance.new("TextLabel")

Status.Position =
    UDim2.new(0, 20, 0, 48)

Status.Size =
    UDim2.new(1, -40, 0, 20)

Status.BackgroundTransparency = 1

Status.Text =
    "● Sistema iniciado"

Status.TextColor3 =
    Color3.fromRGB(120, 255, 170)

Status.TextSize = 12

Status.Font =
    Enum.Font.Gotham

Status.TextXAlignment =
    Enum.TextXAlignment.Left

Status.Parent = Main

--==================================================
-- ÁREA DOS BOTÕES
--==================================================

local Content =
    Instance.new("Frame")

Content.Position =
    UDim2.new(0, 18, 0, 78)

Content.Size =
    UDim2.new(1, -36, 1, -95)

Content.BackgroundTransparency = 1

Content.Parent = Main

local Layout =
    Instance.new("UIListLayout")

Layout.Padding =
    UDim.new(0, 8)

Layout.SortOrder =
    Enum.SortOrder.LayoutOrder

Layout.Parent = Content

--==================================================
-- BOTÕES
--==================================================

local MonitorButton =
    MakeButton(
        Content,
        "📊  Monitor FPS / Ping"
    )

local FPSButton =
    MakeButton(
        Content,
        "🚀  FPS Booster"
    )

local AnimationButton =
    MakeButton(
        Content,
        "🎭  Animações"
    )

local ThemeButton =
    MakeButton(
        Content,
        "🎨  Tema"
    )

local MobileButton =
    MakeButton(
        Content,
        "📱  Modo Mobile"
    )

local CloseButton =
    MakeButton(
        Content,
        "✕  Fechar Interface"
    )

--==================================================
-- MONITOR
--==================================================

local monitorCreated = false

local function StartMonitor()

    if not MT7Monitor then
        Status.Text =
            "● Monitor indisponível"
        return
    end

    if not monitorCreated then

        MT7Monitor.Create(
            Main
        )

        monitorCreated = true

    end

    MT7Monitor.SetVisible(true)
    MT7Monitor.Start()

    Status.Text =
        "● Monitor ativado"
end

--==================================================
-- FPS BOOSTER
--==================================================

local fpsEnabled = false

FPSButton.Activated:Connect(function()

    if not MT7FPS then

        Status.Text =
            "● FPS module indisponível"

        return
    end

    fpsEnabled = not fpsEnabled

    if fpsEnabled then

        pcall(function()

            if MT7FPS.Start then
                MT7FPS.Start()
            elseif MT7FPS.Enable then
                MT7FPS.Enable()
            end

        end)

        FPSButton.Text =
            "🚀  FPS Booster  •  ON"

        Status.Text =
            "● Otimização ativada"

    else

        pcall(function()

            if MT7FPS.Stop then
                MT7FPS.Stop()
            elseif MT7FPS.Disable then
                MT7FPS.Disable()
            elseif MT7FPS.Restore then
                MT7FPS.Restore()
            end

        end)

        FPSButton.Text =
            "🚀  FPS Booster  •  OFF"

        Status.Text =
            "● Otimização desativada"
    end
end)

--==================================================
-- MONITOR BUTTON
--==================================================

MonitorButton.Activated:Connect(function()

    if not MT7Monitor then
        return
    end

    if not monitorCreated then

        StartMonitor()

    else

        local visible =
            MT7Monitor.Toggle()

        if visible then

            MT7Monitor.Start()

            Status.Text =
                "● Monitor ativado"

        else

            MT7Monitor.Stop()

            Status.Text =
                "● Monitor oculto"

        end
    end
end)

--==================================================
-- ANIMAÇÕES
--==================================================

local animationsEnabled = true

AnimationButton.Activated:Connect(function()

    animationsEnabled =
        not animationsEnabled

    if MT7Settings then

        MT7Settings.SetAnimations(
            animationsEnabled
        )

    end

    if animationsEnabled then

        AnimationButton.Text =
            "🎭  Animações  •  ON"

        Status.Text =
            "● Animações ativadas"

    else

        AnimationButton.Text =
            "🎭  Animações  •  OFF"

        Status.Text =
            "● Animações desativadas"

    end
end)

--==================================================
-- TEMAS
--==================================================

local themes = {
    "Eclipse",
    "Purple",
    "Blue",
    "Black",
    "Moon"
}

local themeIndex = 1

local function ApplyTheme(name)

    if MT7Themes then

        pcall(function()
            MT7Themes.Set(name)
        end)

    end

    if name == "Purple" then

        COLORS.Purple =
            Color3.fromRGB(
                170, 70, 255
            )

    elseif name == "Blue" then

        COLORS.Purple =
            Color3.fromRGB(
                65, 130, 255
            )

    elseif name == "Black" then

        COLORS.Purple =
            Color3.fromRGB(
                100, 100, 110
            )

    elseif name == "Moon" then

        COLORS.Purple =
            Color3.fromRGB(
                120, 150, 210
            )

    else

        COLORS.Purple =
            Color3.fromRGB(
                145, 70, 255
            )
    end

    MainStroke.Color =
        COLORS.Purple

    Status.Text =
        "● Tema: " .. name

end

ThemeButton.Activated:Connect(function()

    themeIndex += 1

    if themeIndex > #themes then
        themeIndex = 1
    end

    local theme =
        themes[themeIndex]

    ApplyTheme(theme)

    ThemeButton.Text =
        "🎨  Tema: " .. theme
end)

--==================================================
-- MODO MOBILE
--==================================================

local mobileEnabled = true

MobileButton.Activated:Connect(function()

    mobileEnabled =
        not mobileEnabled

    if MT7Settings then

        MT7Settings.SetMobileMode(
            mobileEnabled
        )

    end

    if mobileEnabled then

        Main.Size =
            UDim2.new(
                0.86,
                0,
                0,
                390
            )

        MobileButton.Text =
            "📱  Modo Mobile  •  ON"

        Status.Text =
            "● Modo mobile ativado"

    else

        Main.Size =
            UDim2.new(
                0.70,
                0,
                0,
                390
            )

        MobileButton.Text =
            "📱  Modo Mobile  •  OFF"

        Status.Text =
            "● Modo mobile desativado"
    end
end)

--==================================================
-- FECHAR
--==================================================

CloseButton.Activated:Connect(function()

    Main.Visible = false

    if MT7Monitor then

        pcall(function()
            MT7Monitor.Stop()
        end)

    end

    Status.Text =
        "● Interface fechada"
end)

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

local Floating =
    Instance.new("TextButton")

Floating.Name =
    "MT7FloatingButton"

Floating.Size =
    UDim2.new(0, 58, 0, 58)

Floating.Position =
    UDim2.new(
        0,
        20,
        0.65,
        0
    )

Floating.BackgroundColor3 =
    Color3.fromRGB(3, 3, 5)

Floating.BorderSizePixel = 0

Floating.Text =
    "MT7"

Floating.TextColor3 =
    COLORS.White

Floating.TextSize = 14

Floating.Font =
    Enum.Font.GothamBlack

Floating.AutoButtonColor = false

Floating.Parent = ScreenGui

Corner(Floating, 30)

local FloatingStroke =
    Stroke(
        Floating,
        COLORS.Purple,
        2
    )

--==================================================
-- ARRASTAR BOTÃO
--==================================================

local dragging = false
local dragStart
local startPosition

Floating.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = true

        dragStart =
            input.Position

        startPosition =
            Floating.Position
    end
end)

Floating.InputChanged:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragStart =
            dragStart or input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        local delta =
            input.Position - dragStart

        Floating.Position =
            UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        dragging = false
    end
end)

--==================================================
-- ABRIR / FECHAR
--==================================================

local opened = false

Floating.Activated:Connect(function()

    opened = not opened

    if opened then

        Main.Visible = true

        Main.Size =
            UDim2.new(
                0.86,
                0,
                0,
                0
            )

        TweenService:Create(
            Main,
            TweenInfo.new(
                0.35,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    UDim2.new(
                        0.86,
                        0,
                        0,
                        390
                    )
            }
        ):Play()

    else

        local tween =
            TweenService:Create(
                Main,
                TweenInfo.new(
                    0.22,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In
                ),
                {
                    Size =
                        UDim2.new(
                            0.86,
                            0,
                            0,
                            0
                        )
                }
            )

        tween:Play()

        tween.Completed:Connect(function()

            if not opened then
                Main.Visible = false
            end

        end)
    end
end)

--==================================================
-- INTRO
--==================================================

task.spawn(function()

    task.wait(0.35)

    TweenService:Create(
        IntroTitle,
        TweenInfo.new(0.8),
        {
            TextTransparency = 0
        }
    ):Play()

    task.wait(1.4)

    TweenService:Create(
        IntroTitle,
        TweenInfo.new(0.5),
        {
            TextTransparency = 1
        }
    ):Play()

    task.wait(0.55)

    Intro:Destroy()

    Main.Visible = true
    opened = true

    if MT7Monitor
        and MT7Settings
        and MT7Settings.Get(
            "MonitorEnabled"
        ) then

        StartMonitor()
    end

end)

--==================================================
-- STATUS FINAL
--==================================================

print("==============================================")
print("🌙 MT7 HUB V4")
print("🖥️ Interface: READY")
print("📊 Monitor: READY")
print("🚀 Performance: READY")
print("🎭 Animations: READY")
print("🎨 Themes: READY")
print("📱 Mobile: READY")
print("⚪ Floating Button: READY")
print("==============================================")

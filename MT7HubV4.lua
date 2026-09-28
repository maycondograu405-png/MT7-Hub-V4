--==================================================
-- MT7 HUB V4
-- COMPLETE INTERFACE
-- PART 1/3
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- MODULE LOADER
--==================================================

local BASE_URL =
    "https://raw.githubusercontent.com/maycondograu405-png/MT7-Hub-V4/refs/heads/main/"

local function LoadModule(name)

    local ok, result = pcall(function()

        local source = game:HttpGet(
            BASE_URL .. name .. ".lua"
        )

        local fn = loadstring(source)

        if not fn then
            error("Loadstring indisponível")
        end

        return fn()

    end)

    if ok then
        return result
    end

    warn(
        "[MT7] Erro ao carregar " ..
        name .. ": " ..
        tostring(result)
    )

    return nil
end

--==================================================
-- MODULES
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
-- REMOVE OLD VERSION
--==================================================

pcall(function()

    local old =
        PlayerGui:FindFirstChild("MT7HubV4")

    if old then
        old:Destroy()
    end

end)

--==================================================
-- MAIN GUI
--==================================================

local Gui =
    Instance.new("ScreenGui")

Gui.Name = "MT7HubV4"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

Gui.Parent = PlayerGui

--==================================================
-- COLORS
--==================================================

local C = {

    Black =
        Color3.fromRGB(5, 5, 8),

    Background =
        Color3.fromRGB(10, 9, 14),

    Panel =
        Color3.fromRGB(17, 15, 24),

    Panel2 =
        Color3.fromRGB(24, 21, 33),

    Purple =
        Color3.fromRGB(145, 70, 255),

    Blue =
        Color3.fromRGB(70, 125, 255),

    White =
        Color3.fromRGB(245, 245, 250),

    Gray =
        Color3.fromRGB(150, 150, 165),

    Green =
        Color3.fromRGB(80, 230, 145),

    Red =
        Color3.fromRGB(255, 80, 90)
}

--==================================================
-- HELPERS
--==================================================

local function Corner(obj, radius)

    local c =
        Instance.new("UICorner")

    c.CornerRadius =
        UDim.new(0, radius)

    c.Parent = obj

    return c
end

local function Border(obj, color, thickness)

    local s =
        Instance.new("UIStroke")

    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = 0.15

    s.Parent = obj

    return s
end

local function Label(parent, text, size)

    local l =
        Instance.new("TextLabel")

    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.White
    l.TextSize = size or 14
    l.Font = Enum.Font.GothamBold

    l.Parent = parent

    return l
end

local function Button(parent, text)

    local b =
        Instance.new("TextButton")

    b.Size =
        UDim2.new(1, 0, 0, 42)

    b.BackgroundColor3 = C.Panel2
    b.BorderSizePixel = 0

    b.Text = text
    b.TextColor3 = C.White
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold

    b.AutoButtonColor = false

    b.Parent = parent

    Corner(b, 9)

    local stroke =
        Border(
            b,
            Color3.fromRGB(50, 46, 62),
            1
        )

    b.MouseEnter:Connect(function()

        TweenService:Create(
            b,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(
                        35, 29, 48
                    )
            }
        ):Play()

        stroke.Color = C.Purple

    end)

    b.MouseLeave:Connect(function()

        TweenService:Create(
            b,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = C.Panel2
            }
        ):Play()

        stroke.Color =
            Color3.fromRGB(
                50, 46, 62
            )

    end)

    return b
end

--==================================================
-- ECLIPSE INTRO
--==================================================

local Intro =
    Instance.new("Frame")

Intro.Size =
    UDim2.new(1, 0, 1, 0)

Intro.BackgroundColor3 =
    Color3.fromRGB(0, 0, 0)

Intro.BorderSizePixel = 0
Intro.ZIndex = 100

Intro.Parent = Gui

local IntroTitle =
    Instance.new("TextLabel")

IntroTitle.AnchorPoint =
    Vector2.new(0.5, 0.5)

IntroTitle.Position =
    UDim2.new(0.5, 0, 0.5, 0)

IntroTitle.Size =
    UDim2.new(0.85, 0, 0, 90)

IntroTitle.BackgroundTransparency = 1

IntroTitle.Text = "MT7 HUB"

IntroTitle.TextColor3 = C.White
IntroTitle.TextTransparency = 1

IntroTitle.TextScaled = true
IntroTitle.Font = Enum.Font.GothamBlack

IntroTitle.Parent = Intro

--==================================================
-- KEY SCREEN
--==================================================

local KeyScreen =
    Instance.new("Frame")

KeyScreen.Size =
    UDim2.new(1, 0, 1, 0)

KeyScreen.BackgroundColor3 = C.Black
KeyScreen.BorderSizePixel = 0

KeyScreen.Visible = false
KeyScreen.ZIndex = 90

KeyScreen.Parent = Gui

local KeyBox =
    Instance.new("Frame")

KeyBox.AnchorPoint =
    Vector2.new(0.5, 0.5)

KeyBox.Position =
    UDim2.new(0.5, 0, 0.5, 0)

KeyBox.Size =
    UDim2.new(0.82, 0, 0, 245)

KeyBox.BackgroundColor3 = C.Panel
KeyBox.BorderSizePixel = 0

KeyBox.Parent = KeyScreen

Corner(KeyBox, 16)

local KeyBorder =
    Border(
        KeyBox,
        C.Purple,
        1.5
    )

local KeyTitle =
    Label(
        KeyBox,
        "🔐 MT7 HUB V4",
        22
    )

KeyTitle.Size =
    UDim2.new(1, -30, 0, 35)

KeyTitle.Position =
    UDim2.new(0, 15, 0, 18)

local KeySubtitle =
    Label(
        KeyBox,
        "Digite sua chave para continuar",
        12
    )

KeySubtitle.Size =
    UDim2.new(1, -30, 0, 25)

KeySubtitle.Position =
    UDim2.new(0, 15, 0, 52)

KeySubtitle.TextColor3 = C.Gray

local KeyInput =
    Instance.new("TextBox")

KeyInput.Size =
    UDim2.new(1, -30, 0, 45)

KeyInput.Position =
    UDim2.new(0, 15, 0, 88)

KeyInput.BackgroundColor3 = C.Panel2
KeyInput.BorderSizePixel = 0

KeyInput.PlaceholderText =
    "Digite a KEY..."

KeyInput.PlaceholderColor3 = C.Gray

KeyInput.Text = ""
KeyInput.TextColor3 = C.White
KeyInput.TextSize = 14

KeyInput.Font =
    Enum.Font.Gotham

KeyInput.ClearTextOnFocus = false

KeyInput.Parent = KeyBox

Corner(KeyInput, 9)

Border(
    KeyInput,
    Color3.fromRGB(55, 50, 70),
    1
)

local KeyButton =
    Button(
        KeyBox,
        "🔓 DESBLOQUEAR"
    )

KeyButton.Size =
    UDim2.new(1, -30, 0, 42)

KeyButton.Position =
    UDim2.new(0, 15, 0, 145)

local KeyStatus =
    Label(
        KeyBox,
        "",
        12
    )

KeyStatus.Size =
    UDim2.new(1, -30, 0, 25)

KeyStatus.Position =
    UDim2.new(0, 15, 0, 198)

KeyStatus.TextColor3 = C.Gray

--==================================================
-- MAIN PANEL
--==================================================

local Main =
    Instance.new("Frame")

Main.AnchorPoint =
    Vector2.new(0.5, 0.5)

Main.Position =
    UDim2.new(0.5, 0, 0.5, 0)

Main.Size =
    UDim2.new(0.9, 0, 0, 420)

Main.BackgroundColor3 = C.Background
Main.BorderSizePixel = 0

Main.Visible = false
Main.ZIndex = 10

Main.Parent = Gui

Corner(Main, 16)

local MainBorder =
    Border(
        Main,
        C.Purple,
        1.5
    )

--==================================================
-- HEADER
--==================================================

local Header =
    Instance.new("Frame")

Header.Size =
    UDim2.new(1, 0, 0, 62)

Header.BackgroundTransparency = 1
Header.Parent = Main

local Title =
    Label(
        Header,
        "🌙 MT7 HUB V4",
        20
    )

Title.Size =
    UDim2.new(1, -100, 0, 30)

Title.Position =
    UDim2.new(0, 18, 0, 8)

Title.TextXAlignment =
    Enum.TextXAlignment.Left

local ModeLabel =
    Label(
        Header,
        "FREE MODE",
        11
    )

ModeLabel.Size =
    UDim2.new(0, 90, 0, 22)

ModeLabel.Position =
    UDim2.new(1, -105, 0, 13)

ModeLabel.TextColor3 = C.Purple

ModeLabel.TextXAlignment =
    Enum.TextXAlignment.Right

local Status =
    Label(
        Header,
        "● Sistema pronto",
        11
    )

Status.Size =
    UDim2.new(1, -36, 0, 18)

Status.Position =
    UDim2.new(0, 18, 0, 35)

Status.TextColor3 = C.Green
Status.TextXAlignment =
    Enum.TextXAlignment.Left

--==================================================
-- SIDEBAR
--==================================================

local Side =
    Instance.new("Frame")

Side.Size =
    UDim2.new(0, 82, 1, -72)

Side.Position =
    UDim2.new(0, 10, 0, 65)

Side.BackgroundTransparency = 1

Side.Parent = Main

local SideLayout =
    Instance.new("UIListLayout")

SideLayout.Padding =
    UDim.new(0, 7)

SideLayout.Parent = Side

local HomeButton =
    Button(Side, "⌂")

local MonitorTab =
    Button(Side, "📊")

local ThemeTab =
    Button(Side, "🎨")

local SettingsTab =
    Button(Side, "⚙️")

local ModeTab =
    Button(Side, "🔄")

--==================================================
-- CONTENT
--==================================================

local Content =
    Instance.new("Frame")

Content.Position =
    UDim2.new(0, 102, 0, 72)

Content.Size =
    UDim2.new(1, -112, 1, -82)

Content.BackgroundTransparency = 1

Content.Parent = Main

--==================================================
-- HOME PAGE
--==================================================

local Home =
    Instance.new("Frame")

Home.Size =
    UDim2.new(1, 0, 1, 0)

Home.BackgroundTransparency = 1
Home.Parent = Content

local HomeLayout =
    Instance.new("UIListLayout")

HomeLayout.Padding =
    UDim.new(0, 8)

HomeLayout.Parent = Home

local MonitorButton =
    Button(
        Home,
        "📊  Monitor FPS / Ping"
    )

local FPSButton =
    Button(
        Home,
        "🚀  FPS Booster • OFF"
    )

local AnimButton =
    Button(
        Home,
        "🎭  Animações • ON"
    )

local ThemeButton =
    Button(
        Home,
        "🎨  Tema: Eclipse"
    )

local MobileButton =
    Button(
        Home,
        "📱  Modo Mobile • ON"
    )

local ConfigButton =
    Button(
        Home,
        "⚙️  Configurações"
    )

--==================================================
-- PAGES
--==================================================

local function NewPage()

    local page =
        Instance.new("Frame")

    page.Size =
        UDim2.new(1, 0, 1, 0)

    page.BackgroundTransparency = 1
    page.Visible = false

    page.Parent = Content

    return page
end

local MonitorPage = NewPage()
local ThemePage = NewPage()
local SettingsPage = NewPage()

--==================================================
-- PAGE SWITCH
--==================================================

local Pages = {
    Home = Home,
    Monitor = MonitorPage,
    Theme = ThemePage,
    Settings = SettingsPage
}

local function ShowPage(name)

    for pageName, page in pairs(Pages) do
        page.Visible =
            pageName == name
    end

end

--==================================================
-- MONITOR PAGE
--==================================================

local MonitorTitle =
    Label(
        MonitorPage,
        "📊 MONITOR",
        18
    )

MonitorTitle.Size =
    UDim2.new(1, 0, 0, 35)

MonitorTitle.Position =
    UDim2.new(0, 0, 0, 0)

local MonitorInfo =
    Label(
        MonitorPage,
        "FPS: --\nPING: -- ms",
        16
    )

MonitorInfo.Size =
    UDim2.new(1, 0, 0, 70)

MonitorInfo.Position =
    UDim2.new(0, 0, 0, 50)

MonitorInfo.TextXAlignment =
    Enum.TextXAlignment.Left

MonitorInfo.TextYAlignment =
    Enum.TextYAlignment.Center

local MonitorToggle =
    Button(
        MonitorPage,
        "📊 Ativar Monitor"
    )

MonitorToggle.Position =
    UDim2.new(0, 0, 0, 135)

MonitorToggle.Size =
    UDim2.new(1, 0, 0, 42)

--==================================================
-- THEME PAGE
--==================================================

local ThemeTitle =
    Label(
        ThemePage,
        "🎨 TEMAS",
        18
    )

ThemeTitle.Size =
    UDim2.new(1, 0, 0, 35)

local EclipseTheme =
    Button(
        ThemePage,
        "🌑 Eclipse"
    )

EclipseTheme.Position =
    UDim2.new(0, 0, 0, 48)

local PurpleTheme =
    Button(
        ThemePage,
        "💜 Purple"
    )

PurpleTheme.Position =
    UDim2.new(0, 0, 0, 98)

local BlueTheme =
    Button(
        ThemePage,
        "💙 Blue"
    )

BlueTheme.Position =
    UDim2.new(0, 0, 0, 148)

local BlackTheme =
    Button(
        ThemePage,
        "🖤 Black"
    )

BlackTheme.Position =
    UDim2.new(0, 0, 0, 198)

local MoonTheme =
    Button(
        ThemePage,
        "🌙 Moon"
    )

MoonTheme.Position =
    UDim2.new(0, 0, 0, 248)

--==================================================
-- SETTINGS PAGE
--==================================================

local SettingsTitle =
    Label(
        SettingsPage,
        "⚙️ CONFIGURAÇÕES",
        18
    )

SettingsTitle.Size =
    UDim2.new(1, 0, 0, 35)

local SettingsInfo =
    Label(
        SettingsPage,
        "Configurações gerais do MT7 Hub",
        12
    )

SettingsInfo.Size =
    UDim2.new(1, 0, 0, 25)

SettingsInfo.Position =
    UDim2.new(0, 0, 0, 32)

SettingsInfo.TextColor3 = C.Gray

local FPSSetting =
    Button(
        SettingsPage,
        "🚀 FPS Booster"
    )

FPSSetting.Position =
    UDim2.new(0, 0, 0, 70)

local AnimSetting =
    Button(
        SettingsPage,
        "🎭 Animações"
    )

AnimSetting.Position =
    UDim2.new(0, 0, 0, 120)

local MobileSetting =
    Button(
        SettingsPage,
        "📱 Modo Mobile"
    )

MobileSetting.Position =
    UDim2.new(0, 0, 0, 170)

local MonitorSetting =
    Button(
        SettingsPage,
        "📊 Monitor"
    )

MonitorSetting.Position =
    UDim2.new(0, 0, 0, 220)
--==================================================
-- MT7 HUB V4
-- CONTINUAÇÃO
-- KEY / FREE / BUTTONS / START
--==================================================

--==================================================
-- STATE
--==================================================

local Unlocked = false
local CurrentMode = "FREE"

local FPSEnabled = false
local AnimationsEnabled = true
local MobileEnabled = true
local MonitorEnabled = false

--==================================================
-- FREE / KEY MODE BUTTON
--==================================================

local ModeButton =
    Button(
        Header,
        "FREE"
    )

ModeButton.Size =
    UDim2.new(0, 70, 0, 28)

ModeButton.Position =
    UDim2.new(1, -185, 0, 35)

ModeButton.TextSize = 11

ModeButton.Visible = false

--==================================================
-- KEY PAGE
--==================================================

local KeyPage =
    Instance.new("Frame")

KeyPage.Size =
    UDim2.new(1, 0, 1, 0)

KeyPage.BackgroundTransparency = 1

KeyPage.Visible = false

KeyPage.Parent = Content

local KeyPageTitle =
    Label(
        KeyPage,
        "🔐 ÁREA KEY",
        20
    )

KeyPageTitle.Size =
    UDim2.new(1, 0, 0, 35)

local KeyPageInfo =
    Label(
        KeyPage,
        "Recursos disponíveis após desbloqueio.",
        12
    )

KeyPageInfo.Size =
    UDim2.new(1, 0, 0, 25)

KeyPageInfo.Position =
    UDim2.new(0, 0, 0, 38)

KeyPageInfo.TextColor3 = C.Gray

local KeyStatusButton =
    Button(
        KeyPage,
        "🔒 KEY BLOQUEADA"
    )

KeyStatusButton.Position =
    UDim2.new(0, 0, 0, 80)

--==================================================
-- KEY VALIDATION
--==================================================

local VALID_KEY = "MT7-V4-2026"

local function UnlockHub()

    Unlocked = true
    CurrentMode = "KEY"

    KeyScreen.Visible = false
    Main.Visible = true

    ModeButton.Visible = true
    ModeButton.Text = "KEY"

    ModeLabel.Text = "KEY MODE"

    KeyStatus.Text =
        "✅ KEY VALIDADA"

    KeyStatus.TextColor3 =
        C.Green

    KeyStatusButton.Text =
        "🔓 KEY DESBLOQUEADA"

    Status.Text =
        "● Sistema desbloqueado"

    Status.TextColor3 =
        C.Green

    -- Eclipse animation

    if MT7Animations then

        pcall(function()

            if MT7Animations.Eclipse then
                MT7Animations.Eclipse(Main)
            end

        end)

    end
end

KeyButton.MouseButton1Click:Connect(function()

    local typed =
        tostring(KeyInput.Text)

    if typed == VALID_KEY then

        UnlockHub()

    else

        KeyStatus.Text =
            "❌ KEY inválida"

        KeyStatus.TextColor3 =
            C.Red

        KeyInput.Text = ""

    end

end)

--==================================================
-- PAGE SWITCH UPDATE
--==================================================

local function OpenPage(name)

    ShowPage(name)

    KeyPage.Visible =
        name == "Key"

end

HomeButton.MouseButton1Click:Connect(function()
    OpenPage("Home")
end)

MonitorTab.MouseButton1Click:Connect(function()
    OpenPage("Monitor")
end)

ThemeTab.MouseButton1Click:Connect(function()
    OpenPage("Theme")
end)

SettingsTab.MouseButton1Click:Connect(function()
    OpenPage("Settings")
end)

--==================================================
-- MAIN BUTTONS
--==================================================

MonitorButton.MouseButton1Click:Connect(function()

    OpenPage("Monitor")

end)

ConfigButton.MouseButton1Click:Connect(function()

    OpenPage("Settings")

end)

ThemeButton.MouseButton1Click:Connect(function()

    OpenPage("Theme")

end)

--==================================================
-- FPS BOOSTER
--==================================================

local function UpdateFPSButton()

    if FPSEnabled then

        FPSButton.Text =
            "🚀  FPS Booster • ON"

        FPSButton.TextColor3 =
            C.Green

    else

        FPSButton.Text =
            "🚀  FPS Booster • OFF"

        FPSButton.TextColor3 =
            C.White

    end

end

local function ToggleFPS()

    FPSEnabled =
        not FPSEnabled

    UpdateFPSButton()

    if MT7FPS then

        pcall(function()

            if FPSEnabled then

                if MT7FPS.Start then
                    MT7FPS.Start()
                elseif MT7FPS.Enable then
                    MT7FPS.Enable()
                end

            else

                if MT7FPS.Stop then
                    MT7FPS.Stop()
                elseif MT7FPS.Disable then
                    MT7FPS.Disable()
                end

            end

        end)

    end

end

FPSButton.MouseButton1Click:Connect(
    ToggleFPS
)

FPSSetting.MouseButton1Click:Connect(
    ToggleFPS
)

--==================================================
-- ANIMATIONS
--==================================================

local function ToggleAnimations()

    AnimationsEnabled =
        not AnimationsEnabled

    if AnimationsEnabled then

        AnimButton.Text =
            "🎭  Animações • ON"

        AnimSetting.Text =
            "🎭  Animações • ON"

    else

        AnimButton.Text =
            "🎭  Animações • OFF"

        AnimSetting.Text =
            "🎭  Animações • OFF"

    end

end

AnimButton.MouseButton1Click:Connect(
    ToggleAnimations
)

AnimSetting.MouseButton1Click:Connect(
    ToggleAnimations
)

--==================================================
-- MOBILE MODE
--==================================================

local function ToggleMobile()

    MobileEnabled =
        not MobileEnabled

    if MobileEnabled then

        MobileButton.Text =
            "📱  Modo Mobile • ON"

        MobileSetting.Text =
            "📱  Modo Mobile • ON"

    else

        MobileButton.Text =
            "📱  Modo Mobile • OFF"

        MobileSetting.Text =
            "📱  Modo Mobile • OFF"

    end

end

MobileButton.MouseButton1Click:Connect(
    ToggleMobile
)

MobileSetting.MouseButton1Click:Connect(
    ToggleMobile
)

--==================================================
-- MONITOR
--==================================================

local function StartMonitor()

    MonitorEnabled = true

    MonitorButton.Text =
        "📊  Monitor FPS / Ping • ON"

    MonitorToggle.Text =
        "📊  Monitor Ativo"

    MonitorSetting.Text =
        "📊  Monitor • ON"

    if MT7Monitor then

        pcall(function()

            if MT7Monitor.Start then
                MT7Monitor.Start()
            end

        end)

    end

end

local function StopMonitor()

    MonitorEnabled = false

    MonitorButton.Text =
        "📊  Monitor FPS / Ping"

    MonitorToggle.Text =
        "📊  Ativar Monitor"

    MonitorSetting.Text =
        "📊  Monitor • OFF"

    if MT7Monitor then

        pcall(function()

            if MT7Monitor.Stop then
                MT7Monitor.Stop()
            end

        end)

    end

end

MonitorToggle.MouseButton1Click:Connect(function()

    if MonitorEnabled then
        StopMonitor()
    else
        StartMonitor()
    end

end)

MonitorSetting.MouseButton1Click:Connect(function()

    if MonitorEnabled then
        StopMonitor()
    else
        StartMonitor()
    end

end)

--==================================================
-- THEME SYSTEM
--==================================================

local function ApplyTheme(name)

    if MT7Themes then

        pcall(function()

            if MT7Themes.Set then
                MT7Themes.Set(name)
            end

        end)

    end

    ThemeButton.Text =
        "🎨  Tema: " .. name

    -- Basic interface colors

    if name == "Purple" then

        MainBorder.Color =
            Color3.fromRGB(
                170, 70, 255
            )

    elseif name == "Blue" then

        MainBorder.Color =
            Color3.fromRGB(
                70, 140, 255
            )

    elseif name == "Black" then

        MainBorder.Color =
            Color3.fromRGB(
                90, 90, 100
            )

    elseif name == "Moon" then

        MainBorder.Color =
            Color3.fromRGB(
                180, 190, 230
            )

    else

        MainBorder.Color =
            C.Purple

    end

end

EclipseTheme.MouseButton1Click:Connect(
    function()
        ApplyTheme("Eclipse")
    end
)

PurpleTheme.MouseButton1Click:Connect(
    function()
        ApplyTheme("Purple")
    end
)

BlueTheme.MouseButton1Click:Connect(
    function()
        ApplyTheme("Blue")
    end
)

BlackTheme.MouseButton1Click:Connect(
    function()
        ApplyTheme("Black")
    end
)

MoonTheme.MouseButton1Click:Connect(
    function()
        ApplyTheme("Moon")
    end
)

--==================================================
-- FREE / KEY SWITCH
--==================================================

ModeButton.MouseButton1Click:Connect(function()

    if not Unlocked then
        return
    end

    if CurrentMode == "FREE" then

        CurrentMode = "KEY"

        ModeButton.Text = "KEY"
        ModeLabel.Text = "KEY MODE"

        Home.Visible = false
        KeyPage.Visible = true

        for name, page in pairs(Pages) do
            page.Visible = false
        end

    else

        CurrentMode = "FREE"

        ModeButton.Text = "FREE"
        ModeLabel.Text = "FREE MODE"

        KeyPage.Visible = false

        ShowPage("Home")

    end

end)

--==================================================
-- FLOATING BUTTON
--==================================================

local Floating =
    Instance.new("TextButton")

Floating.Name =
    "MT7FloatingButton"

Floating.Size =
    UDim2.new(0, 62, 0, 62)

Floating.Position =
    UDim2.new(
        0,
        25,
        0.5,
        -31
    )

Floating.BackgroundColor3 =
    Color3.fromRGB(5, 5, 7)

Floating.Text =
    "MT7"

Floating.TextColor3 =
    C.White

Floating.TextSize = 17

Floating.Font =
    Enum.Font.GothamBlack

Floating.AutoButtonColor = false

Floating.ZIndex = 50

Floating.Parent = Gui

Corner(
    Floating,
    100
)

local FloatingStroke =
    Border(
        Floating,
        C.Purple,
        2
    )

--==================================================
-- FLOATING BUTTON DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

Floating.InputBegan:Connect(function(input)

    if
        input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        input.UserInputType ==
        Enum.UserInputType.Touch
    then

        dragging = true

        dragStart =
            input.Position

        startPosition =
            Floating.Position

    end

end)

Floating.InputChanged:Connect(function(input)

    if
        input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        input.UserInputType ==
        Enum.UserInputType.Touch
    then

        -- handled by global input

    end

end)

UserInputService.InputChanged:Connect(
    function(input)

        if not dragging then
            return
        end

        if
            input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or
            input.UserInputType ==
            Enum.UserInputType.Touch
        then

            local delta =
                input.Position -
                dragStart

            Floating.Position =
                UDim2.new(
                    startPosition.X.Scale,
                    startPosition.X.Offset +
                        delta.X,
                    startPosition.Y.Scale,
                    startPosition.Y.Offset +
                        delta.Y
                )

        end

    end
)

UserInputService.InputEnded:Connect(
    function(input)

        if
            input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            input.UserInputType ==
            Enum.UserInputType.Touch
        then

            dragging = false

        end

    end
)

--==================================================
-- FLOATING BUTTON OPEN / CLOSE
--==================================================

local interfaceOpen = true

Floating.MouseButton1Click:Connect(function()

    interfaceOpen =
        not interfaceOpen

    if interfaceOpen then

        Main.Visible = true

        TweenService:Create(
            Main,
            TweenInfo.new(0.2),
            {
                Size =
                    UDim2.new(
                        0.9,
                        0,
                        0,
                        420
                    )
            }
        ):Play()

    else

        TweenService:Create(
            Main,
            TweenInfo.new(0.2),
            {
                Size =
                    UDim2.new(
                        0.9,
                        0,
                        0,
                        0
                    )
            }
        ):Play()

        task.delay(0.22, function()

            if not interfaceOpen then
                Main.Visible = false
            end

        end)

    end

end)

--==================================================
-- CLOSE INTERFACE
--==================================================

local CloseButton =
    Button(
        Home,
        "✕  Fechar Interface"
    )

CloseButton.MouseButton1Click:Connect(
    function()

        interfaceOpen = false

        Main.Visible = false

    end
)

--==================================================
-- INTRO
--==================================================

Main.Visible = false
KeyScreen.Visible = false
Floating.Visible = false

task.spawn(function()

    IntroTitle.TextTransparency = 1

    TweenService:Create(
        IntroTitle,
        TweenInfo.new(
            0.8,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            TextTransparency = 0
        }
    ):Play()

    task.wait(1.4)

    TweenService:Create(
        IntroTitle,
        TweenInfo.new(0.6),
        {
            TextTransparency = 1
        }
    ):Play()

    task.wait(0.65)

    Intro.Visible = false

    -- FREE MODE primeiro
    Main.Visible = true
    Floating.Visible = true

    ShowPage("Home")

end)

--==================================================
-- DEFAULTS
--==================================================

ApplyTheme("Eclipse")

UpdateFPSButton()

ShowPage("Home")

--==================================================
-- STATUS
--==================================================

print("==============================================")
print("🌙 MT7 HUB V4")
print("🖥️ Interface: READY")
print("🔐 Key System: READY")
print("🔄 FREE / KEY: READY")
print("📊 Monitor: READY")
print("🚀 FPS Booster: READY")
print("🎭 Animations: READY")
print("🎨 Themes: READY")
print("📱 Mobile: READY")
print("⚪ Floating Button: READY")
print("==============================================")

return Gui

--==================================================
-- MT7 HUB V4.1
-- PARTE 1/5
-- BASE + INTRO + KEY + INTERFACE COMPACTA
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local HUB_NAME = "MT7HubV4"
local VALID_KEY = "MT7-V4-2026"

local BASE_URL =
    "https://raw.githubusercontent.com/maycondograu405-png/MT7-Hub-V4/refs/heads/main/"

local CurrentMode = "FREE"
local Unlocked = false

local CurrentTheme = "Eclipse"
local CurrentFont = "Gotham"
local AnimationsEnabled = true
local MonitorEnabled = true
local MobileMode = true
local TargetFPS = 70

--==================================================
-- CORES
--==================================================

local C = {
    Black = Color3.fromRGB(8, 8, 12),
    Background = Color3.fromRGB(14, 14, 21),
    Panel = Color3.fromRGB(20, 20, 30),
    Panel2 = Color3.fromRGB(25, 25, 38),

    Purple = Color3.fromRGB(145, 65, 255),
    Purple2 = Color3.fromRGB(100, 40, 190),

    Blue = Color3.fromRGB(55, 130, 255),
    White = Color3.fromRGB(245, 245, 250),
    SubText = Color3.fromRGB(170, 170, 185),

    Green = Color3.fromRGB(65, 220, 130),
    Red = Color3.fromRGB(240, 70, 80)
}

--==================================================
-- LOAD MODULES
--==================================================

local function LoadModule(name)
    local ok, result = pcall(function()
        local source = game:HttpGet(BASE_URL .. name .. ".lua")
        local fn = loadstring(source)

        if not fn then
            error("loadstring indisponível")
        end

        return fn()
    end)

    if ok then
        return result
    end

    warn("[MT7] Falha ao carregar " .. name)
    return nil
end

local MT7FPS = LoadModule("MT7FPS")
local MT7Animations = LoadModule("MT7Animations")
local MT7Letters = LoadModule("MT7Letters")
local MT7Themes = LoadModule("MT7Themes")
local MT7Monitor = LoadModule("MT7Monitor")
local MT7Settings = LoadModule("MT7Settings")

--==================================================
-- GUI PRINCIPAL
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = HUB_NAME
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- FUNÇÕES AUXILIARES
--==================================================

local function Corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = object
    return c
end

local function Stroke(object, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = 0
    s.Parent = object
    return s
end

local function Label(parent, text, size)
    local l = Instance.new("TextLabel")

    l.BackgroundTransparency = 1
    l.Text = text or ""
    l.TextColor3 = C.White
    l.TextSize = size or 14
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent

    return l
end

local function Button(parent, text)
    local b = Instance.new("TextButton")

    b.AutoButtonColor = false
    b.BackgroundColor3 = C.Panel2
    b.TextColor3 = C.White
    b.Text = text
    b.TextSize = 13
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.Parent = parent

    Corner(b, 9)
    Stroke(b, C.Purple, 1)

    b.MouseEnter:Connect(function()
        if AnimationsEnabled then
            TweenService:Create(
                b,
                TweenInfo.new(0.12),
                {BackgroundColor3 = C.Purple2}
            ):Play()
        end
    end)

    b.MouseLeave:Connect(function()
        if AnimationsEnabled then
            TweenService:Create(
                b,
                TweenInfo.new(0.12),
                {BackgroundColor3 = C.Panel2}
            ):Play()
        end
    end)

    return b
end

local function Fade(object, transparency, duration)
    if not AnimationsEnabled then
        object.BackgroundTransparency = transparency
        return
    end

    TweenService:Create(
        object,
        TweenInfo.new(duration or 0.35),
        {BackgroundTransparency = transparency}
    ):Play()
end

--==================================================
-- INTRO
--==================================================

local Intro = Instance.new("Frame")
Intro.Size = UDim2.new(1, 0, 1, 0)
Intro.Position = UDim2.new(0, 0, 0, 0)
Intro.BackgroundColor3 = C.Black
Intro.BorderSizePixel = 0
Intro.ZIndex = 100
Intro.Parent = Gui
Intro.Visible = false

local IntroTitle = Instance.new("TextLabel")
IntroTitle.AnchorPoint = Vector2.new(0.5, 0.5)
IntroTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroTitle.Size = UDim2.new(0, 300, 0, 70)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "MT7 HUB"
IntroTitle.TextColor3 = C.White
IntroTitle.TextSize = 38
IntroTitle.Font = Enum.Font.GothamBlack
IntroTitle.TextTransparency = 1
IntroTitle.Parent = Intro

--==================================================
-- KEY SCREEN
--==================================================

local KeyScreen = Instance.new("Frame")
KeyScreen.Size = UDim2.new(1, 0, 1, 0)
KeyScreen.BackgroundTransparency = 1
KeyScreen.BorderSizePixel = 0
KeyScreen.Visible = false
KeyScreen.ZIndex = 90
KeyScreen.Parent = Gui

local KeyBox = Instance.new("Frame")
KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyBox.Size = UDim2.new(0.84, 0, 0, 280)
KeyBox.BackgroundColor3 = C.Background
KeyBox.BorderSizePixel = 0
KeyBox.ZIndex = 91
KeyBox.Parent = KeyScreen
Corner(KeyBox, 16)
Stroke(KeyBox, C.Purple, 2)

local KeyTitle = Label(KeyBox, "🔐 MT7 HUB", 25)
KeyTitle.ZIndex = 92
KeyTitle.Position = UDim2.new(0, 22, 0, 22)
KeyTitle.Size = UDim2.new(1, -44, 0, 35)
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center
KeyTitle.Font = Enum.Font.GothamBold

local KeySub = Label(   
    KeyBox,
    "Digite sua KEY ou entre no modo FREE",
    12
)

KeySub.ZIndex = 92
KeySub.Position = UDim2.new(0, 20, 0, 62)
KeySub.Size = UDim2.new(1, -40, 0, 25)
KeySub.TextXAlignment = Enum.TextXAlignment.Center
KeySub.TextColor3 = C.SubText

local KeyInput = Instance.new("TextBox")
KeyInput.Position = UDim2.new(0.08, 0, 0, 100)
KeyInput.Size = UDim2.new(0.84, 0, 0, 42)
KeyInput.BackgroundColor3 = C.Panel2
KeyInput.TextColor3 = C.White
KeyInput.PlaceholderColor3 = C.SubText
KeyInput.PlaceholderText = "Digite a KEY..."
KeyInput.Text = ""
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.Gotham
KeyInput.ClearTextOnFocus = false
KeyInput.BorderSizePixel = 0
KeyInput.Parent = KeyBox
KeyInput.ZIndex = 92

Corner(KeyInput, 9)
Stroke(KeyInput, C.Purple, 1)

local UnlockButton = Button(
    KeyBox,
    "🔓  DESBLOQUEAR KEY"
)

UnlockButton.ZIndex = 92
UnlockButton.Position = UDim2.new(0.08, 0, 0, 154)
UnlockButton.Size = UDim2.new(0.84, 0, 0, 42)

local FreeButton = Button(
    KeyBox,
    "🆓  ENTRAR NO MODO FREE"
)

FreeButton.ZIndex = 92
FreeButton.Position = UDim2.new(0.08, 0, 0, 204)
FreeButton.Size = UDim2.new(0.84, 0, 0, 42)

local KeyStatus = Label(KeyBox, "", 11)
KeyStatus.ZIndex = 92
KeyStatus.Position = UDim2.new(0.08, 0, 0, 250)
KeyStatus.Size = UDim2.new(0.84, 0, 0, 20)
KeyStatus.TextXAlignment = Enum.TextXAlignment.Center

--==================================================
-- MAIN COMPACTA
--==================================================

local Main = Instance.new("Frame")
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)

-- PEQUENA E RESPONSIVA
Main.Size = UDim2.new(0.82, 0, 0, 350)

Main.BackgroundColor3 = C.Background
Main.BorderSizePixel = 0
Main.Visible = false
Main.ClipsDescendants = true
Main.Parent = Gui

Corner(Main, 15)
local MainBorder = Stroke(Main, C.Purple, 2)

-- Limita o tamanho em telas grandes
local SizeLimit = Instance.new("UISizeConstraint")
SizeLimit.MinSize = Vector2.new(280, 300)
SizeLimit.MaxSize = Vector2.new(520, 390)
SizeLimit.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 58)
Header.BackgroundColor3 = C.Panel
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderTitle = Label(Header, "🌙 MT7 HUB", 18)
HeaderTitle.Position = UDim2.new(0, 16, 0, 8)
HeaderTitle.Size = UDim2.new(0.55, 0, 0, 25)
HeaderTitle.Font = Enum.Font.GothamBold

local ModeLabel = Label(Header, "FREE MODE", 10)
ModeLabel.Position = UDim2.new(0, 17, 0, 33)
ModeLabel.Size = UDim2.new(0.5, 0, 0, 17)
ModeLabel.TextColor3 = C.SubText

local ModeButton = Button(Header, "FREE")
ModeButton.Position = UDim2.new(1, -82, 0, 15)
ModeButton.Size = UDim2.new(0, 68, 0, 30)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.new(0, 8, 0, 66)
Sidebar.Size = UDim2.new(0, 58, 1, -74)
Sidebar.BackgroundColor3 = C.Panel
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Corner(Sidebar, 10)

--==================================================
-- ÁREA DE PÁGINAS
--==================================================

local Pages = Instance.new("Frame")
Pages.Position = UDim2.new(0, 74, 0, 66)
Pages.Size = UDim2.new(1, -82, 1, -74)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

local Floating = Instance.new("TextButton")
Floating.Size = UDim2.new(0, 52, 0, 52)
Floating.Position = UDim2.new(0, 18, 0.5, -26)
Floating.BackgroundColor3 = C.Black
Floating.Text = "MT7"
Floating.TextColor3 = C.White
Floating.TextSize = 13
Floating.Font = Enum.Font.GothamBold
Floating.BorderSizePixel = 0
Floating.Visible = false
Floating.Parent = Gui

Corner(Floating, 26)
local FloatingStroke = Stroke(Floating, C.Purple, 2)

--==================================================
-- FIM DA PARTE 1
--==================================================
--==================================================
-- MT7 HUB V4.1
-- PARTE 2/5
-- PÁGINAS + MENU + HOME + MONITOR
--==================================================

--==================================================
-- FUNÇÃO PARA CRIAR PÁGINA
--==================================================

local PagesList = {}

local function CreatePage(name)
    local page = Instance.new("Frame")

    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = Pages

    PagesList[name] = page

    return page
end

local function ShowPage(name)
    for pageName, page in pairs(PagesList) do
        page.Visible = (pageName == name)
    end
end

--==================================================
-- PÁGINAS
--==================================================

local HomePage = CreatePage("Home")
local MonitorPage = CreatePage("Monitor")
local ThemePage = CreatePage("Theme")
local SettingsPage = CreatePage("Settings")
local KeyPage = CreatePage("KeyPage")

--==================================================
-- 🎨 CONTEÚDO DA PÁGINA PERSONALIZAR
--==================================================

local ThemeTitle = Label(
ThemePage,
"🎨 PERSONALIZAR",
18
)

ThemeTitle.Position = UDim2.new(0, 20, 0, 15)
ThemeTitle.Size = UDim2.new(1, -40, 0, 35)
ThemeTitle.TextXAlignment = Enum.TextXAlignment.Left

local ThemeInfo = Label(
ThemePage,
"Escolha o tema e a fonte do MT7 HUB",
11
)

ThemeInfo.Position = UDim2.new(0, 20, 0, 52)
ThemeInfo.Size = UDim2.new(1, -40, 0, 25)
ThemeInfo.TextXAlignment = Enum.TextXAlignment.Left

--==================================================
-- 📜 ÁREA DE ROLAGEM
--==================================================

local ThemeScroll = Instance.new("ScrollingFrame")

ThemeScroll.Name = "ThemeScroll"
ThemeScroll.Position = UDim2.new(0, 0, 0, 80)
ThemeScroll.Size = UDim2.new(1, 0, 1, -80)

ThemeScroll.BackgroundTransparency = 1
ThemeScroll.BorderSizePixel = 0

ThemeScroll.ScrollBarThickness = 3
ThemeScroll.ScrollingDirection = Enum.ScrollingDirection.Y
ThemeScroll.CanvasSize = UDim2.new(0, 0, 0, 320)

ThemeScroll.Parent = ThemePage

--==================================================
-- 🌑 ECLIPSE
--==================================================

local EclipseThemeButton = Button(
ThemeScroll,
"🌑  ECLIPSE"
)

EclipseThemeButton.Position = UDim2.new(0, 20, 0, 15)
EclipseThemeButton.Size = UDim2.new(1, -40, 0, 45)

--==================================================
-- 🟣 PURPLE
--==================================================

local PurpleThemeButton = Button(
ThemeScroll,
"🟣  PURPLE"
)

PurpleThemeButton.Position = UDim2.new(0, 20, 0, 70)
PurpleThemeButton.Size = UDim2.new(1, -40, 0, 45)

--==================================================
-- 🔵 BLUE
--==================================================

local BlueThemeButton = Button(
ThemeScroll,
"🔵  BLUE"
)

BlueThemeButton.Position = UDim2.new(0, 20, 0, 125)
BlueThemeButton.Size = UDim2.new(1, -40, 0, 45)

--==================================================
-- ⚫ BLACK
--==================================================

local BlackThemeButton = Button(
ThemeScroll,
"⚫  BLACK"
)

BlackThemeButton.Position = UDim2.new(0, 20, 0, 180)
BlackThemeButton.Size = UDim2.new(1, -40, 0, 45)

--==================================================
-- 🌙 MOON
--==================================================

local MoonThemeButton = Button(
ThemeScroll,
"🌙  MOON"
)

MoonThemeButton.Position = UDim2.new(0, 20, 0, 235)
MoonThemeButton.Size = UDim2.new(1, -40, 0, 45)

--==================================================
-- 🔤 FONTES DO HUB
--==================================================

local MinecraftFontButton = Button(
    ThemeScroll,
    "🟩  MINECRAFT"
)

MinecraftFontButton.Position = UDim2.new(0, 20, 0, 290)
MinecraftFontButton.Size = UDim2.new(1, -40, 0, 45)


local CartoonFontButton = Button(
    ThemeScroll,
    "🧸  CARTOON"
)

CartoonFontButton.Position = UDim2.new(0, 20, 0, 345)
CartoonFontButton.Size = UDim2.new(1, -40, 0, 45)


local SciFiFontButton = Button(
    ThemeScroll,
    "🚀  SCI-FI"
)

SciFiFontButton.Position = UDim2.new(0, 20, 0, 400)
SciFiFontButton.Size = UDim2.new(1, -40, 0, 45)


local FantasyFontButton = Button(
    ThemeScroll,
    "✨  FANTASY"
)

FantasyFontButton.Position = UDim2.new(0, 20, 0, 455)
FantasyFontButton.Size = UDim2.new(1, -40, 0, 45)


local GothamFontButton = Button(
    ThemeScroll,
    "🔥  GOTHAM"
)

GothamFontButton.Position = UDim2.new(0, 20, 0, 510)
GothamFontButton.Size = UDim2.new(1, -40, 0, 45)


--==================================================
-- 🔤 AÇÕES DAS FONTES
--==================================================

MinecraftFontButton.MouseButton1Click:Connect(function()
    pcall(function()
        MT7Letters.SetFont("Code")
        MT7Letters.ApplyToGui(Gui, "Code")
    end)
end)


CartoonFontButton.MouseButton1Click:Connect(function()
    pcall(function()
        MT7Letters.SetFont("Cartoon")
        MT7Letters.ApplyToGui(Gui, "Cartoon")
    end)
end)


SciFiFontButton.MouseButton1Click:Connect(function()
    pcall(function()
        MT7Letters.SetFont("SciFi")
        MT7Letters.ApplyToGui(Gui, "SciFi")
    end)
end)


FantasyFontButton.MouseButton1Click:Connect(function()
    pcall(function()
        MT7Letters.SetFont("Fantasy")
        MT7Letters.ApplyToGui(Gui, "Fantasy")
    end)
end)


GothamFontButton.MouseButton1Click:Connect(function()
    pcall(function()
        MT7Letters.SetFont("Gotham")
        MT7Letters.ApplyToGui(Gui, "Gotham")
    end)
end)

--==================================================
-- 🌈 AÇÕES DOS TEMAS
--==================================================

EclipseThemeButton.MouseButton1Click:Connect(function()
MT7Themes.Set("Eclipse")
end)

PurpleThemeButton.MouseButton1Click:Connect(function()
MT7Themes.Set("Purple")
end)

BlueThemeButton.MouseButton1Click:Connect(function()
MT7Themes.Set("Blue")
end)

BlackThemeButton.MouseButton1Click:Connect(function()
MT7Themes.Set("Black")
end)

MoonThemeButton.MouseButton1Click:Connect(function()
MT7Themes.Set("Moon")
end)

--==================================================

--==================================================
-- ⚙️ CONFIGURAÇÕES
--==================================================

local SettingsTitle = Label(
    SettingsPage,
    "⚙️ CONFIGURAÇÕES",
    18
)

SettingsTitle.Position = UDim2.new(0, 20, 0, 15)
SettingsTitle.Size = UDim2.new(1, -40, 0, 35)
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left


local SettingsInfo = Label(
    SettingsPage,
    "Controles de desempenho do MT7 HUB",
    11
)

SettingsInfo.Position = UDim2.new(0, 20, 0, 52)
SettingsInfo.Size = UDim2.new(1, -40, 0, 25)
SettingsInfo.TextXAlignment = Enum.TextXAlignment.Left


--==================================================
-- 📜 ÁREA DE ROLAGEM
--==================================================

local SettingsScroll = Instance.new("ScrollingFrame")

SettingsScroll.Name = "SettingsScroll"
SettingsScroll.Position = UDim2.new(0, 0, 0, 80)
SettingsScroll.Size = UDim2.new(1, 0, 1, -80)

SettingsScroll.BackgroundTransparency = 1
SettingsScroll.BorderSizePixel = 0

SettingsScroll.ScrollBarThickness = 3
SettingsScroll.ScrollingDirection = Enum.ScrollingDirection.Y
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 390)

SettingsScroll.Parent = SettingsPage


--==================================================
-- 📊 FPS
--==================================================

local FPSButton = Button(
    SettingsScroll,
    "📊  FPS MONITOR: OFF"
)

FPSButton.Position = UDim2.new(0, 20, 0, 95)
FPSButton.Size = UDim2.new(1, -40, 0, 45)


--==================================================
-- 📡 PING
--==================================================

local PingButton = Button(
    SettingsScroll,
    "📡  PING MONITOR: OFF"
)

PingButton.Position = UDim2.new(0, 20, 0, 150)
PingButton.Size = UDim2.new(1, -40, 0, 45)


--==================================================
-- 🚀 FPS BOOSTER
--==================================================

local BoosterButton = Button(
    SettingsScroll,
    "🚀  FPS BOOSTER: OFF"
)

BoosterButton.Position = UDim2.new(0, 20, 0, 205)
BoosterButton.Size = UDim2.new(1, -40, 0, 45)


--==================================================
-- 🧊 ANTI-FREEZE
--==================================================

local FreezeButton = Button(
    SettingsScroll,
    "🧊  ANTI-FREEZE: OFF"
)

FreezeButton.Position = UDim2.new(0, 20, 0, 260)
FreezeButton.Size = UDim2.new(1, -40, 0, 45)


--==================================================
-- 🔘 ESTADOS
--==================================================

local FPSEnabled = false
local PingEnabled = false
local BoosterEnabled = false
local FreezeEnabled = false


--==================================================
-- 📊 FPS ON / OFF
--==================================================

FPSButton.MouseButton1Click:Connect(function()

    FPSEnabled = not FPSEnabled

    if FPSEnabled then

        FPSButton.Text = "🟢  FPS MONITOR: ON"
        FPSButton.BackgroundColor3 = C.Green

    else

        FPSButton.Text = "🔴  FPS MONITOR: OFF"
        FPSButton.BackgroundColor3 = C.Background

    end

end)


--==================================================
-- 📡 PING ON / OFF
--==================================================

PingButton.MouseButton1Click:Connect(function()

    PingEnabled = not PingEnabled

    if PingEnabled then

        PingButton.Text = "🟢  PING MONITOR: ON"
        PingButton.BackgroundColor3 = C.Green

    else

        PingButton.Text = "🔴  PING MONITOR: OFF"
        PingButton.BackgroundColor3 = C.Background

    end

end)


--==================================================
-- 🚀 BOOSTER ON / OFF
--==================================================

BoosterButton.MouseButton1Click:Connect(function()

    BoosterEnabled = not BoosterEnabled

    if BoosterEnabled then

        BoosterButton.Text = "🟢  FPS BOOSTER: ON"
        BoosterButton.BackgroundColor3 = C.Green

    else

        BoosterButton.Text = "🔴  FPS BOOSTER: OFF"
        BoosterButton.BackgroundColor3 = C.Background

    end

end)


--==================================================
-- 🧊 ANTI-FREEZE ON / OFF
--==================================================

FreezeButton.MouseButton1Click:Connect(function()

    FreezeEnabled = not FreezeEnabled

    if FreezeEnabled then

        FreezeButton.Text = "🟢  ANTI-FREEZE: ON"
        FreezeButton.BackgroundColor3 = C.Green

    else

        FreezeButton.Text = "🔴  ANTI-FREEZE: OFF"
        FreezeButton.BackgroundColor3 = C.Background

    end

end)

--==================================================

--==================================================
--==================================================
--==================================================
-- FUNÇÃO DE BOTÃO DO MENU
--==================================================

local function MenuButton(text, y)
    local b = Button(Sidebar, text)

    b.Position = UDim2.new(0, 6, 0, y)
    b.Size = UDim2.new(1, -12, 0, 48)
    b.TextSize = 20

    return b
end

--==================================================
-- BOTÕES LATERAIS
--==================================================

local HomeButton = MenuButton("⌂", 8)
local MonitorButton = MenuButton("📊", 62)
local ThemeButton = MenuButton("🎨", 116)
local SettingsButton = MenuButton("⚙️", 170)
local ModeTab = MenuButton("🔄", 224)

--==================================================
-- TEXTO DO MENU
--==================================================

HomeButton.Text = "⌂"
MonitorButton.Text = "📊"
ThemeButton.Text = "🎨"
SettingsButton.Text = "⚙️"
ModeTab.Text = "🔄"

--==================================================
-- HOME
--==================================================

local HomeTitle = Label(HomePage, "Bem-vindo ao MT7", 21)
HomeTitle.Position = UDim2.new(0, 10, 0, 8)
HomeTitle.Size = UDim2.new(1, -20, 0, 30)
HomeTitle.Font = Enum.Font.GothamBold

local HomeSub = Label(
    HomePage,
    "Hub de otimização • V4.1",
    11
)

HomeSub.Position = UDim2.new(0, 10, 0, 38)
HomeSub.Size = UDim2.new(1, -20, 0, 20)
HomeSub.TextColor3 = C.SubText

--==================================================
-- STATUS BOX
--==================================================

local StatusBox = Instance.new("Frame")
StatusBox.Position = UDim2.new(0, 10, 0, 70)
StatusBox.Size = UDim2.new(1, -20, 0, 86)
StatusBox.BackgroundColor3 = C.Panel
StatusBox.BorderSizePixel = 0
StatusBox.Parent = HomePage

Corner(StatusBox, 11)
Stroke(StatusBox, C.Purple, 1)

local StatusTitle = Label(
    StatusBox,
    "⚡ STATUS",
    13
)

StatusTitle.Position = UDim2.new(0, 12, 0, 9)
StatusTitle.Size = UDim2.new(1, -24, 0, 20)
StatusTitle.Font = Enum.Font.GothamBold

local StatusText = Label(
    StatusBox,
    "Sistema pronto",
    11
)

StatusText.Position = UDim2.new(0, 12, 0, 34)
StatusText.Size = UDim2.new(1, -24, 0, 20)
StatusText.TextColor3 = C.Green

local ModeStatus = Label(
    StatusBox,
    "Modo: FREE",
    10
)

ModeStatus.Position = UDim2.new(0, 12, 0, 56)
ModeStatus.Size = UDim2.new(0.5, 0, 0, 18)
ModeStatus.TextColor3 = C.SubText

--==================================================
-- 🔐 SISTEMA KEY / FREE
--==================================================

FreeButton.MouseButton1Click:Connect(function()

    Unlocked = true
    CurrentMode = "FREE"

    KeyStatus.Text = "Modo FREE ativado!"
    KeyStatus.TextColor3 = C.SubText

    ModeStatus.Text = "Modo: FREE"
    ModeButton.Text = "FREE"

    KeyScreen.Visible = false
    Main.Visible = true
    Floating.Visible = true

    ShowPage("Home")

end)


UnlockButton.MouseButton1Click:Connect(function()

    local enteredKey = tostring(KeyInput.Text or "")

    if enteredKey == "" then

        KeyStatus.Text = "Digite uma key!"
        KeyStatus.TextColor3 = C.Red
        return

    end

    if enteredKey == VALID_KEY then

        Unlocked = true
        CurrentMode = "KEY"

        KeyStatus.Text = "Key desbloqueada!"
        KeyStatus.TextColor3 = C.Green

        ModeStatus.Text = "Modo: KEY"
        ModeButton.Text = "KEY"

        task.wait(0.35)

        KeyScreen.Visible = false
        Main.Visible = true
        Floating.Visible = true

        ShowPage("Home")

    else

        KeyStatus.Text = "Key inválida!"
        KeyStatus.TextColor3 = C.Red

    end

end)

--==================================================
-- HOME BOTÕES
--==================================================

local FPSHomeButton = Button(
    HomePage,
    "🚀  FPS BOOSTER"
)

FPSHomeButton.Position = UDim2.new(0, 10, 0, 168)
FPSHomeButton.Size = UDim2.new(0.48, -8, 0, 42)

local MobileHomeButton = Button(
    HomePage,
    "📱  MOBILE"
)

MobileHomeButton.Position = UDim2.new(0.52, -2, 0, 168)
MobileHomeButton.Size = UDim2.new(0.48, -8, 0, 42)

local HomeInfo = Label(
    HomePage,
    "O MT7 reduz cargas gráficas desnecessárias\nsem automatizar ações do jogo.",
    10
)

HomeInfo.Position = UDim2.new(0, 10, 0, 220)
HomeInfo.Size = UDim2.new(1, -20, 0, 50)
HomeInfo.TextColor3 = C.SubText
HomeInfo.TextWrapped = true

--==================================================
-- MONITOR PAGE
--==================================================

local MonitorTitle = Label(
    MonitorPage,
    "📊 MONITOR",
    20
)

MonitorTitle.Position = UDim2.new(0, 10, 0, 8)
MonitorTitle.Size = UDim2.new(1, -20, 0, 30)
MonitorTitle.Font = Enum.Font.GothamBold

local MonitorStatus = Label(
    MonitorPage,
    "Monitor aguardando...",
    11
)

MonitorStatus.Position = UDim2.new(0, 10, 0, 40)
MonitorStatus.Size = UDim2.new(1, -20, 0, 20)
MonitorStatus.TextColor3 = C.SubText

--==================================================
-- FPS BOX
--==================================================

local FPSBox = Instance.new("Frame")
FPSBox.Position = UDim2.new(0, 10, 0, 70)
FPSBox.Size = UDim2.new(1, -20, 0, 62)
FPSBox.BackgroundColor3 = C.Panel
FPSBox.BorderSizePixel = 0
FPSBox.Parent = MonitorPage

Corner(FPSBox, 10)
Stroke(FPSBox, C.Purple, 1)

local FPSTitle = Label(
    FPSBox,
    "FPS",
    11
)

FPSTitle.Position = UDim2.new(0, 12, 0, 8)
FPSTitle.Size = UDim2.new(0.5, 0, 0, 18)
FPSTitle.Font = Enum.Font.GothamBold

local FPSValue = Label(
    FPSBox,
    "--",
    22
)

FPSValue.Position = UDim2.new(0.5, 0, 0, 7)
FPSValue.Size = UDim2.new(0.45, 0, 0, 28)
FPSValue.TextXAlignment = Enum.TextXAlignment.Right
FPSValue.Font = Enum.Font.GothamBold
FPSValue.TextColor3 = C.Green

--==================================================
-- PING BOX
--==================================================

local PingBox = Instance.new("Frame")
PingBox.Position = UDim2.new(0, 10, 0, 142)
PingBox.Size = UDim2.new(1, -20, 0, 62)
PingBox.BackgroundColor3 = C.Panel
PingBox.BorderSizePixel = 0
PingBox.Parent = MonitorPage

Corner(PingBox, 10)
Stroke(PingBox, C.Blue, 1)

local PingTitle = Label(
    PingBox,
    "PING",
    11
)

PingTitle.Position = UDim2.new(0, 12, 0, 8)
PingTitle.Size = UDim2.new(0.5, 0, 0, 18)
PingTitle.Font = Enum.Font.GothamBold

local PingValue = Label(
    PingBox,
    "-- ms",
    22
)

PingValue.Position = UDim2.new(0.5, 0, 0, 7)
PingValue.Size = UDim2.new(0.45, 0, 0, 28)
PingValue.TextXAlignment = Enum.TextXAlignment.Right
PingValue.Font = Enum.Font.GothamBold
PingValue.TextColor3 = C.Blue

--==================================================
-- TARGET FPS
--==================================================

local TargetButton = Button(
    MonitorPage,
    "🎯 FPS TARGET: 70"
)

TargetButton.Position = UDim2.new(0, 10, 0, 216)
TargetButton.Size = UDim2.new(1, -20, 0, 40)

--==================================================
-- MONITOR LOOP
--==================================================

local FPSCounter = 0
local FPSLast = tick()

task.spawn(function()
    while Gui.Parent do
        task.wait(1)

        if MonitorEnabled then
            local now = tick()
            local elapsed = now - FPSLast

            if elapsed > 0 then
                FPSValue.Text = tostring(
                    math.floor(FPSCounter / elapsed)
                )
            end

            FPSCounter = 0
            FPSLast = now

            local ok, ping = pcall(function()
                return Player:GetNetworkPing() * 1000
            end)

            if ok and ping then
                PingValue.Text =
                    tostring(math.floor(ping)) .. " ms"
            end
        end
    end
end)

task.spawn(function()
    while Gui.Parent do
        task.wait()

        if MonitorEnabled then
            FPSCounter = FPSCounter + 1
        end
    end
end)

--==================================================
-- NAVEGAÇÃO
--==================================================

HomeButton.MouseButton1Click:Connect(function()
    ShowPage("Home")
end)

MonitorButton.MouseButton1Click:Connect(function()
    ShowPage("Monitor")
end)

ThemeButton.MouseButton1Click:Connect(function()
    ShowPage("Theme")
end)

SettingsButton.MouseButton1Click:Connect(function()
    ShowPage("Settings")
end)

--==================================================
-- FIM DA PARTE 2
--==================================================
--==================================================
-- MT7 HUB V4.1
-- PARTE 3/3
-- FINALIZAÇÃO + ANIMAÇÕES + MOBILE
--==================================================

--==================================================
-- TAMANHO COMPACTO
--==================================================

pcall(function()
    Main.Size = UDim2.new(0.78, 0, 0, 350)

    local Constraint = Main:FindFirstChildOfClass("UISizeConstraint")

    if not Constraint then
        Constraint = Instance.new("UISizeConstraint")
        Constraint.Parent = Main
    end

    Constraint.MinSize = Vector2.new(280, 260)
    Constraint.MaxSize = Vector2.new(520, 420)
end)

--==================================================
-- ARREDONDAMENTO
--==================================================

pcall(function()
    local Corner = Main:FindFirstChildOfClass("UICorner")

    if Corner then
        Corner.CornerRadius = UDim.new(0, 14)
    end
end)

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

pcall(function()
    Floating.Size = UDim2.new(0, 54, 0, 54)
    Floating.Position = UDim2.new(0, 18, 0.5, -27)
    Floating.Text = "MT7"
    Floating.TextSize = 13
    Floating.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
    Floating.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

--==================================================
-- FUNÇÃO DE ANIMAÇÃO
--==================================================

local function TweenObject(object, time, properties)
    if not object then
        return
    end

    pcall(function()
        TweenService:Create(
            object,
            TweenInfo.new(
                time,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            properties
        ):Play()
    end)
end

--==================================================
-- ABRIR HUB
--==================================================

local HubOpen = true

local function OpenHub()
    if HubOpen then
        return
    end

    HubOpen = true
    Main.Visible = true

    local targetSize = UDim2.new(0.78, 0, 0, 350)

    Main.Size = UDim2.new(0.70, 0, 0, 300)

    TweenObject(Main, 0.25, {
        Size = targetSize
    })

    pcall(function()
        Floating.Text = "×"
    end)
end

--==================================================
-- FECHAR HUB
--==================================================

local function CloseHub()
    if not HubOpen then
        return
    end

    HubOpen = false

    TweenObject(Main, 0.20, {
        Size = UDim2.new(0.70, 0, 0, 300)
    })

    task.delay(0.20, function()
        if not HubOpen then
            Main.Visible = false
        end
    end)

    pcall(function()
        Floating.Text = "MT7"
    end)
end

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

pcall(function()
    Floating.MouseButton1Click:Connect(function()
        if HubOpen then
            CloseHub()
        else
            OpenHub()
        end
    end)
end)

--==================================================
-- ANIMAÇÃO DO BOTÃO
--==================================================

pcall(function()

    Floating.MouseEnter:Connect(function()

        TweenObject(Floating, 0.12, {
            Size = UDim2.new(0, 58, 0, 58)
        })

    end)

    Floating.MouseLeave:Connect(function()

        TweenObject(Floating, 0.12, {
            Size = UDim2.new(0, 54, 0, 54)
        })

    end)

end)

--==================================================
-- ARRASTAR BOTÃO NO CELULAR
--==================================================

pcall(function()

    local dragging = false
    local dragStart
    local startPosition

    Floating.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = true
            dragStart = input.Position
            startPosition = Floating.Position

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement then

            local delta = input.Position - dragStart

            Floating.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        end

    end)

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = false

        end

    end)

end)

--==================================================
-- ANIMAÇÃO ECLIPSE
--==================================================

local function EclipseAnimation()

    pcall(function()

        local Eclipse = Instance.new("Frame")

        Eclipse.Name = "MT7_Eclipse"
        Eclipse.Size = UDim2.new(0, 0, 0, 0)
        Eclipse.Position = UDim2.new(0.5, 0, 0.5, 0)
        Eclipse.AnchorPoint = Vector2.new(0.5, 0.5)
        Eclipse.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Eclipse.BorderSizePixel = 0
        Eclipse.ZIndex = 999
        Eclipse.Parent = Gui

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(1, 0)
        Corner.Parent = Eclipse

        TweenObject(Eclipse, 0.45, {
            Size = UDim2.new(2.2, 0, 2.2, 0)
        })

        task.wait(0.45)

        Eclipse:Destroy()

    end)

end

--==================================================
-- FADE DE ENTRADA
--==================================================

local function FadeIn(object)

    if not object then
        return
    end

    pcall(function()

        local oldTransparency = object.BackgroundTransparency

        object.BackgroundTransparency = 1
        object.Visible = true

        TweenObject(object, 0.35, {
            BackgroundTransparency = oldTransparency
        })

    end)

end

--==================================================
-- APLICAÇÃO DE FONTE EXTRA
--==================================================

pcall(function()

    if MT7Letters and MT7Letters.ApplyToGui then

        task.delay(0.5, function()

            pcall(function()
                MT7Letters.ApplyToGui(Gui)
            end)

        end)

    end

end)

--==================================================
-- MONITOR INICIAL
--==================================================

pcall(function()

    if MT7Monitor and MT7Monitor.Start then
        MT7Monitor.Start()
    end

end)

--==================================================
-- FPS BOOSTER INICIAL
--==================================================

pcall(function()

    if MT7FPS and MT7FPS.Start then
        MT7FPS.Start()
    end

end)

--==================================================
-- CONFIGURAÇÕES INICIAIS
--==================================================

pcall(function()

    if MT7Settings and MT7Settings.Load then
        MT7Settings.Load()
    end

end)

--==================================================
-- TEMA INICIAL
--==================================================

pcall(function()

    if MT7Themes and MT7Themes.Set then
        MT7Themes.Set("Eclipse")
    end

end)

--==================================================
-- STARTUP
--==================================================

Main.Visible = false
Floating.Visible = false

pcall(function()
    KeyScreen.Visible = false
end)

--==================================================
--==================================================
-- 🌑 MT7 HUB - ANIMAÇÃO DE ABERTURA
--==================================================

local StartupIntro = Instance.new("Frame")
StartupIntro.Name = "MT7StartupIntro"
StartupIntro.Size = UDim2.fromScale(1, 1)
StartupIntro.Position = UDim2.fromScale(0, 0)
StartupIntro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StartupIntro.BackgroundTransparency = 0
StartupIntro.BorderSizePixel = 0
StartupIntro.ZIndex = 9999
StartupIntro.Parent = Gui

local StartupTitle = Instance.new("TextLabel")
StartupTitle.Name = "MT7Title"
StartupTitle.AnchorPoint = Vector2.new(0.5, 0.5)
StartupTitle.Position = UDim2.fromScale(0.5, 0.5)
StartupTitle.Size = UDim2.new(0.9, 0, 0, 80)
StartupTitle.BackgroundTransparency = 1
StartupTitle.Text = "MT7 HUB"
StartupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
StartupTitle.TextTransparency = 1
StartupTitle.Font = Enum.Font.GothamBlack
StartupTitle.TextSize = 48
StartupTitle.ZIndex = 10000
StartupTitle.Parent = StartupIntro

local Eclipse = Instance.new("Frame")
Eclipse.Name = "Eclipse"
Eclipse.AnchorPoint = Vector2.new(0.5, 0.5)
Eclipse.Position = UDim2.fromScale(0.5, 0.5)
Eclipse.Size = UDim2.fromOffset(20, 20)
Eclipse.BackgroundColor3 = Color3.fromRGB(90, 40, 180)
Eclipse.BackgroundTransparency = 0.25
Eclipse.BorderSizePixel = 0
Eclipse.ZIndex = 9998
Eclipse.Parent = StartupIntro

local EclipseCorner = Instance.new("UICorner")
EclipseCorner.CornerRadius = UDim.new(1, 0)
EclipseCorner.Parent = Eclipse

task.spawn(function()
    task.wait(0.25)

    -- ✨ MT7 HUB aparece
    local TitleIn = TweenService:Create(
        StartupTitle,
        TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            TextTransparency = 0,
            TextSize = 52
        }
    )

    TitleIn:Play()
    TitleIn.Completed:Wait()

    task.wait(0.8)

    -- 🌑 Eclipse cresce
    local EclipseTween = TweenService:Create(
        Eclipse,
        TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {
            Size = UDim2.fromOffset(650, 650),
            BackgroundTransparency = 0.55
        }
    )

    EclipseTween:Play()

    -- ✨ Texto desaparece
    TweenService:Create(
        StartupTitle,
        TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {
            TextTransparency = 1,
            TextSize = 64
        }
    ):Play()

    EclipseTween.Completed:Wait()

    task.wait(0.25)

    -- 🌌 Tela desaparece
    local FadeOut = TweenService:Create(
        StartupIntro,
        TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            BackgroundTransparency = 1
        }
    )

    FadeOut:Play()
    FadeOut.Completed:Wait()

    StartupIntro:Destroy()
--==================================================
-- 🔐 FINAL DA ANIMAÇÃO → TELA KEY
--==================================================

task.wait(0.25)

if not Unlocked then

    KeyScreen.Visible = true
    Main.Visible = false
    Floating.Visible = false

else

    KeyScreen.Visible = false
    Main.Visible = true
    Floating.Visible = true

end

end)


--==================================================
-- PROTEÇÃO DE ERROS
--==================================================

task.spawn(function()

    while task.wait(2) do

        pcall(function()

            if Gui and Gui.Parent == nil then
                Gui.Parent = PlayerGui
            end

            if Floating and Floating.Parent == nil then
                Floating.Parent = Gui
            end

        end)

    end

end)

--==================================================
-- FINAL
--==================================================

print("==============================================")
print("🌙 MT7 HUB V4.1")
print("🖥️ Interface Compacta: READY")
print("🔐 KEY SYSTEM: READY")
print("🆓 FREE MODE: READY")
print("🔑 KEY MODE: READY")
print("🎨 TEMAS: READY")
print("🔤 FONTES: READY")
print("📊 MONITOR: READY")
print("🚀 FPS BOOSTER: READY")
print("📱 MOBILE: READY")
print("🎭 ANIMAÇÕES: READY")
print("⚪ FLOATING BUTTON: READY")
print("==============================================")
print("🔥 MT7 HUB V4.1 CARREGADO")
print("==============================================")

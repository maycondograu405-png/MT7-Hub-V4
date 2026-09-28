--==================================================
-- MT7 HUB V4
-- MT7Settings.lua
-- Sistema central de configurações
--==================================================

local MT7Settings = {}

MT7Settings.Version = "4.0"

--------------------------------------------------
-- CONFIGURAÇÕES PADRÃO
--------------------------------------------------

MT7Settings.Defaults = {

    -- Interface
    Theme = "Eclipse",
    InterfaceVisible = true,

    -- Animações
    Animations = true,
    EclipseAnimation = true,
    FadeAnimation = true,
    ButtonAnimation = true,

    -- Monitor
    MonitorEnabled = true,
    ShowFPS = true,
    ShowPing = true,

    -- Performance
    FPSBooster = false,
    AdaptiveFPS = true,
    TargetFPS = 70,
    FreezeProtection = true,

    -- Interface móvel
    MobileMode = true,
    FloatingButton = true,

    -- Letras
    Font = "GothamBold",

    -- Segurança do sistema
    SafeMode = true
}

--------------------------------------------------
-- CONFIGURAÇÕES ATUAIS
--------------------------------------------------

MT7Settings.Current = {}

for name, value in pairs(MT7Settings.Defaults) do
    MT7Settings.Current[name] = value
end

--------------------------------------------------
-- PEGAR CONFIGURAÇÃO
--------------------------------------------------

function MT7Settings.Get(name)

    return MT7Settings.Current[name]

end

--------------------------------------------------
-- ALTERAR CONFIGURAÇÃO
--------------------------------------------------

function MT7Settings.Set(name, value)

    if MT7Settings.Defaults[name] == nil then
        return false
    end

    MT7Settings.Current[name] = value

    return true

end

--------------------------------------------------
-- ATIVAR CONFIGURAÇÃO
--------------------------------------------------

function MT7Settings.Enable(name)

    if MT7Settings.Defaults[name] ~= nil then
        MT7Settings.Current[name] = true
        return true
    end

    return false

end

--------------------------------------------------
-- DESATIVAR CONFIGURAÇÃO
--------------------------------------------------

function MT7Settings.Disable(name)

    if MT7Settings.Defaults[name] ~= nil then
        MT7Settings.Current[name] = false
        return true
    end

    return false

end

--------------------------------------------------
-- ALTERNAR CONFIGURAÇÃO
--------------------------------------------------

function MT7Settings.Toggle(name)

    if type(MT7Settings.Current[name]) ~= "boolean" then
        return false
    end

    MT7Settings.Current[name] =
        not MT7Settings.Current[name]

    return MT7Settings.Current[name]

end

--------------------------------------------------
-- RESTAURAR PADRÃO
--------------------------------------------------

function MT7Settings.Reset(name)

    if MT7Settings.Defaults[name] == nil then
        return false
    end

    MT7Settings.Current[name] =
        MT7Settings.Defaults[name]

    return true

end

--------------------------------------------------
-- RESTAURAR TODAS
--------------------------------------------------

function MT7Settings.ResetAll()

    for name, value in pairs(MT7Settings.Defaults) do
        MT7Settings.Current[name] = value
    end

    return true

end

--------------------------------------------------
-- TEMA
--------------------------------------------------

function MT7Settings.SetTheme(themeName)

    if type(themeName) ~= "string" then
        return false
    end

    MT7Settings.Current.Theme = themeName

    return true

end

function MT7Settings.GetTheme()

    return MT7Settings.Current.Theme

end

--------------------------------------------------
-- FPS
--------------------------------------------------

function MT7Settings.SetTargetFPS(value)

    value = tonumber(value)

    if not value then
        return false
    end

    value = math.clamp(
        math.floor(value),
        30,
        240
    )

    MT7Settings.Current.TargetFPS = value

    return true

end

function MT7Settings.GetTargetFPS()

    return MT7Settings.Current.TargetFPS

end

--------------------------------------------------
-- FONTE
--------------------------------------------------

function MT7Settings.SetFont(fontName)

    if type(fontName) ~= "string" then
        return false
    end

    MT7Settings.Current.Font = fontName

    return true

end

function MT7Settings.GetFont()

    return MT7Settings.Current.Font

end

--------------------------------------------------
-- MONITOR
--------------------------------------------------

function MT7Settings.SetMonitor(state)

    MT7Settings.Current.MonitorEnabled =
        state == true

    return MT7Settings.Current.MonitorEnabled

end

function MT7Settings.IsMonitorEnabled()

    return MT7Settings.Current.MonitorEnabled

end

--------------------------------------------------
-- ANIMAÇÕES
--------------------------------------------------

function MT7Settings.SetAnimations(state)

    MT7Settings.Current.Animations =
        state == true

    return MT7Settings.Current.Animations

end

function MT7Settings.AreAnimationsEnabled()

    return MT7Settings.Current.Animations

end

--------------------------------------------------
-- MODO MOBILE
--------------------------------------------------

function MT7Settings.SetMobileMode(state)

    MT7Settings.Current.MobileMode =
        state == true

    return MT7Settings.Current.MobileMode

end

--------------------------------------------------
-- BOTÃO FLUTUANTE
--------------------------------------------------

function MT7Settings.SetFloatingButton(state)

    MT7Settings.Current.FloatingButton =
        state == true

    return MT7Settings.Current.FloatingButton

end

--------------------------------------------------
-- FPS BOOSTER
--------------------------------------------------

function MT7Settings.SetFPSBooster(state)

    MT7Settings.Current.FPSBooster =
        state == true

    return MT7Settings.Current.FPSBooster

end

--------------------------------------------------
-- PROTEÇÃO CONTRA FREEZE
--------------------------------------------------

function MT7Settings.SetFreezeProtection(state)

    MT7Settings.Current.FreezeProtection =
        state == true

    return MT7Settings.Current.FreezeProtection

end

--------------------------------------------------
-- PEGAR TODAS AS CONFIGURAÇÕES
--------------------------------------------------

function MT7Settings.GetAll()

    local settings = {}

    for name, value in pairs(MT7Settings.Current) do
        settings[name] = value
    end

    return settings

end

--------------------------------------------------
-- VERIFICAR SE UMA CONFIGURAÇÃO EXISTE
--------------------------------------------------

function MT7Settings.Exists(name)

    return MT7Settings.Defaults[name] ~= nil

end

--------------------------------------------------
-- INFORMAÇÕES
--------------------------------------------------

function MT7Settings.GetInfo()

    return {
        Version = MT7Settings.Version,
        Theme = MT7Settings.Current.Theme,
        Monitor = MT7Settings.Current.MonitorEnabled,
        Animations = MT7Settings.Current.Animations,
        MobileMode = MT7Settings.Current.MobileMode,
        TargetFPS = MT7Settings.Current.TargetFPS
    }

end

--------------------------------------------------
-- STATUS
--------------------------------------------------

print("==============================================")
print("⚙️ MT7 SETTINGS V4")
print("🎨 Theme System: READY")
print("📊 Monitor Settings: READY")
print("🎭 Animation Settings: READY")
print("📱 Mobile Settings: READY")
print("🚀 Performance Settings: READY")
print("🛡️ Safe Mode: READY")
print("==============================================")

return MT7Settings

--========================================================--
--                    MT7 HUB V4                         --
--                  MT7 THEMES MODULE                    --
--                       PART 1/3                        --
--========================================================--

local MT7Themes = {}

MT7Themes.Version = "4.0"

--========================================================--
--                    SERVICES                          --
--========================================================--

local Lighting = game:GetService("Lighting")

--========================================================--
--                    CURRENT THEME                     --
--========================================================--

MT7Themes.CurrentTheme = "Eclipse"

--========================================================--
--                     THEMES                           --
--========================================================--

MT7Themes.Themes = {

    Eclipse = {
        Name = "🌑 Eclipse",

        Background = Color3.fromRGB(
            8, 8, 12
        ),

        Panel = Color3.fromRGB(
            15, 15, 23
        ),

        Secondary = Color3.fromRGB(
            25, 20, 38
        ),

        Accent = Color3.fromRGB(
            145, 75, 255
        ),

        Accent2 = Color3.fromRGB(
            85, 45, 180
        ),

        Text = Color3.fromRGB(
            245, 245, 255
        ),

        SubText = Color3.fromRGB(
            165, 165, 185
        ),

        Success = Color3.fromRGB(
            80, 255, 150
        ),

        Warning = Color3.fromRGB(
            255, 190, 70
        ),

        Error = Color3.fromRGB(
            255, 80, 100
        )
    },

    Purple = {
        Name = "💜 Purple",

        Background = Color3.fromRGB(
            12, 7, 18
        ),

        Panel = Color3.fromRGB(
            25, 12, 35
        ),

        Secondary = Color3.fromRGB(
            42, 18, 58
        ),

        Accent = Color3.fromRGB(
            190, 70, 255
        ),

        Accent2 = Color3.fromRGB(
            120, 40, 190
        ),

        Text = Color3.fromRGB(
            255, 245, 255
        ),

        SubText = Color3.fromRGB(
            185, 160, 195
        ),

        Success = Color3.fromRGB(
            80, 255, 150
        ),

        Warning = Color3.fromRGB(
            255, 190, 70
        ),

        Error = Color3.fromRGB(
            255, 80, 100
        )
    },

    Blue = {
        Name = "💙 Blue",

        Background = Color3.fromRGB(
            6, 10, 18
        ),

        Panel = Color3.fromRGB(
            10, 18, 32
        ),

        Secondary = Color3.fromRGB(
            15, 30, 50
        ),

        Accent = Color3.fromRGB(
            50, 130, 255
        ),

        Accent2 = Color3.fromRGB(
            30, 80, 190
        ),

        Text = Color3.fromRGB(
            240, 248, 255
        ),

        SubText = Color3.fromRGB(
            155, 175, 200
        ),

        Success = Color3.fromRGB(
            80, 255, 150
        ),

        Warning = Color3.fromRGB(
            255, 190, 70
        ),

        Error = Color3.fromRGB(
            255, 80, 100
        )
    },

    Black = {
        Name = "🖤 Black",

        Background = Color3.fromRGB(
            2, 2, 3
        ),

        Panel = Color3.fromRGB(
            8, 8, 9
        ),

        Secondary = Color3.fromRGB(
            18, 18, 20
        ),

        Accent = Color3.fromRGB(
            120, 120, 130
        ),

        Accent2 = Color3.fromRGB(
            70, 70, 80
        ),

        Text = Color3.fromRGB(
            245, 245, 245
        ),

        SubText = Color3.fromRGB(
            150, 150, 155
        ),

        Success = Color3.fromRGB(
            80, 255, 150
        ),

        Warning = Color3.fromRGB(
            255, 190, 70
        ),

        Error = Color3.fromRGB(
            255, 80, 100
        )
    },

    Moon = {
        Name = "🌙 Moon",

        Background = Color3.fromRGB(
            7, 10, 17
        ),

        Panel = Color3.fromRGB(
            15, 21, 34
        ),

        Secondary = Color3.fromRGB(
            25, 35, 55
        ),

        Accent = Color3.fromRGB(
            120, 185, 255
        ),

        Accent2 = Color3.fromRGB(
            70, 120, 200
        ),

        Text = Color3.fromRGB(
            235, 245, 255
        ),

        SubText = Color3.fromRGB(
            155, 175, 205
        ),

        Success = Color3.fromRGB(
            80, 255, 150
        ),

        Warning = Color3.fromRGB(
            255, 190, 70
        ),

        Error = Color3.fromRGB(
            255, 80, 100
        )
    }

}

--========================================================--
--                    GET THEME                         --
--========================================================--

function MT7Themes.Get(name)

    if not name then
        name = MT7Themes.CurrentTheme
    end

    return MT7Themes.Themes[name]
end

--========================================================--
--                 GET THEME NAMES                      --
--========================================================--

function MT7Themes.GetNames()

    local names = {}

    for name in pairs(MT7Themes.Themes) do
        table.insert(names, name)
    end

    table.sort(names)

    return names
end

--========================================================--
--                  SET THEME                           --
--========================================================--

function MT7Themes.Set(name)

    if not MT7Themes.Themes[name] then
        return false
    end

    MT7Themes.CurrentTheme = name

    return true
end

--========================================================--
--                  CURRENT                             --
--========================================================--

function MT7Themes.GetCurrent()

    return MT7Themes.CurrentTheme

end
--========================================================--
--                  APPLY TO GUI                        --
--========================================================--

function MT7Themes.ApplyToGui(gui, themeName)

    if not gui then
        return false
    end

    local theme = MT7Themes.Themes[themeName]

    if not theme then
        theme = MT7Themes.Get()
    end

    if not theme then
        return false
    end

    local ok = pcall(function()

        for _, object in ipairs(gui:GetDescendants()) do

            if object:IsA("Frame")
                or object:IsA("ScrollingFrame")
                or object:IsA("ViewportFrame") then

                pcall(function()
                    object.BackgroundColor3 = theme.Panel
                end)

            elseif object:IsA("TextLabel")
                or object:IsA("TextButton")
                or object:IsA("TextBox") then

                pcall(function()
                    object.TextColor3 = theme.Text
                end)

            elseif object:IsA("UIStroke") then

                pcall(function()
                    object.Color = theme.Accent
                end)

            elseif object:IsA("ImageLabel")
                or object:IsA("ImageButton") then

                pcall(function()
                    object.ImageColor3 = theme.Text
                end)

            end

        end

        if gui:IsA("GuiObject") then
            pcall(function()
                gui.BackgroundColor3 = theme.Background
            end)
        end

    end)

    return ok
end

--========================================================--
--                 APPLY ACCENT                         --
--========================================================--

function MT7Themes.ApplyAccent(gui, themeName)

    if not gui then
        return false
    end

    local theme = MT7Themes.Themes[themeName]

    if not theme then
        return false
    end

    local ok = pcall(function()

        for _, object in ipairs(gui:GetDescendants()) do

            if object:IsA("UIStroke") then

                object.Color = theme.Accent

            elseif object:IsA("TextButton") then

                object.TextColor3 = theme.Text

            end

        end

    end)

    return ok
end

--========================================================--
--                 THEME COLORS                         --
--========================================================--

function MT7Themes.GetColor(name, themeName)

    local theme = MT7Themes.Themes[
        themeName or MT7Themes.CurrentTheme
    ]

    if not theme then
        return nil
    end

    return theme[name]
end

--========================================================--
--                  LIGHTING                            --
--========================================================--

function MT7Themes.ApplyLighting(themeName)

    local theme = MT7Themes.Themes[themeName]

    if not theme then
        return false
    end

    local ok = pcall(function()

        Lighting.Ambient = theme.Accent2
        Lighting.OutdoorAmbient = theme.Accent2
        Lighting.ColorShift_Top = theme.Accent
        Lighting.ColorShift_Bottom = theme.Background

    end)

    return ok
end

--========================================================--
--                 THEME DESCRIPTION                    --
--========================================================--

function MT7Themes.GetDescription(name)

    local descriptions = {

        Eclipse =
            "🌑 Tema escuro com destaque roxo.",

        Purple =
            "💜 Tema roxo neon.",

        Blue =
            "💙 Tema azul tecnológico.",

        Black =
            "🖤 Tema preto minimalista.",

        Moon =
            "🌙 Tema inspirado na lua."

    }

    return descriptions[name]
end

--========================================================--
--                  MT7 LETTERS V4                      --
--========================================================--

local MT7Letters = {}

MT7Letters.Version = "4.0"
MT7Letters.CurrentFont = "GothamBold"

--========================================================--
--                    FONT LIST                         --
--========================================================--

local Fonts = {
    Gotham = Enum.Font.Gotham,
    GothamBold = Enum.Font.GothamBold,
    SourceSans = Enum.Font.SourceSans,
    SourceSansBold = Enum.Font.SourceSansBold,

    -- 🔤 FONTES EXTRAS
    Code = Enum.Font.Code,
    Cartoon = Enum.Font.Cartoon,
    SciFi = Enum.Font.SciFi,
    Fantasy = Enum.Font.Fantasy
}

MT7Letters.Fonts = Fonts

--========================================================--
--                  GET FONT                            --
--========================================================--

function MT7Letters.GetFont(name)
    if not name then
        return Fonts.GothamBold
    end

    return Fonts[name] or Fonts.GothamBold
end

--========================================================--
--                 SET FONT                             --
--========================================================--

function MT7Letters.SetFont(name)
    if not Fonts[name] then
        return false
    end

    MT7Letters.CurrentFont = name

    return true
end

--========================================================--
--               APPLY TO OBJECT                        --
--========================================================--

function MT7Letters.Apply(object, fontName)
    if not object then
        return false
    end

    if not object:IsA("TextLabel")
        and not object:IsA("TextButton")
        and not object:IsA("TextBox") then

        return false
    end

    local font = MT7Letters.GetFont(
        fontName or MT7Letters.CurrentFont
    )

    local ok = pcall(function()
        object.Font = font
    end)

    return ok
end

--========================================================--
--                 APPLY TO GUI                         --
--========================================================--

function MT7Letters.ApplyToGui(gui, fontName)
    if not gui then
        return false
    end

    local count = 0

    for _, object in ipairs(gui:GetDescendants()) do
        if MT7Letters.Apply(object, fontName) then
            count += 1
        end
    end

    return count
end
--========================================================--
--                  FONT PRESETS                        --
--========================================================--

function MT7Letters.GetFontNames()
    local names = {}

    for name in pairs(Fonts) do
        table.insert(names, name)
    end

    table.sort(names)

    return names
end

--========================================================--
--                  APPLY PRESET                        --
--========================================================--

function MT7Letters.ApplyPreset(gui, name)
    if not gui then
        return 0
    end

    if not Fonts[name] then
        return 0
    end

    MT7Letters.CurrentFont = name

    return MT7Letters.ApplyToGui(
        gui,
        name
    )
end

--========================================================--
--                CURRENT FONT                          --
--========================================================--

function MT7Letters.GetCurrentFont()
    return MT7Letters.CurrentFont
end

--========================================================--
--                FONT INFORMATION                      --
--========================================================--

function MT7Letters.GetInfo()
    return {
        Version = MT7Letters.Version,
        CurrentFont = MT7Letters.CurrentFont,
        AvailableFonts = MT7Letters.GetFontNames()
    }
end

--========================================================--
--                TEXT SETTINGS                         --
--========================================================--

function MT7Letters.SetTextSize(object, size)
    if not object then
        return false
    end

    if not object:IsA("TextLabel")
        and not object:IsA("TextButton")
        and not object:IsA("TextBox") then

        return false
    end

    size = tonumber(size)

    if not size then
        return false
    end

    size = math.clamp(
        math.floor(size),
        8,
        60
    )

    object.TextSize = size

    return true
end

--========================================================--
--              TEXT TRANSPARENCY                       --
--========================================================--

function MT7Letters.SetTextTransparency(object, value)
    if not object then
        return false
    end

    if not object:IsA("TextLabel")
        and not object:IsA("TextButton")
        and not object:IsA("TextBox") then

        return false
    end

    value = tonumber(value)

    if not value then
        return false
    end

    value = math.clamp(
        value,
        0,
        1
    )

    object.TextTransparency = value

    return true
end

--========================================================--
--                TEXT COLOR                            --
--========================================================--

function MT7Letters.SetTextColor(object, color)
    if not object then
        return false
    end

    if not object:IsA("TextLabel")
        and not object:IsA("TextButton")
        and not object:IsA("TextBox") then

        return false
    end

    if typeof(color) ~= "Color3" then
        return false
    end

    object.TextColor3 = color

    return true
end
--========================================================--
--                 FONT PRESETS                         --
--========================================================--

function MT7Letters.ApplyAll(gui, fontName)
    if not gui then
        return 0
    end

    local count = 0

    for _, object in ipairs(gui:GetDescendants()) do
        if MT7Letters.Apply(object, fontName) then
            count += 1
        end
    end

    return count
end

--========================================================--
--                RESTORE DEFAULT                       --
--========================================================--

function MT7Letters.Restore(gui)
    if not gui then
        return 0
    end

    local count = 0

    for _, object in ipairs(gui:GetDescendants()) do
        if object:IsA("TextLabel")
            or object:IsA("TextButton")
            or object:IsA("TextBox") then

            pcall(function()
                object.Font = Enum.Font.Gotham
                count += 1
            end)
        end
    end

    return count
end

--========================================================--
--                 FONT LIST                            --
--========================================================--

MT7Letters.Fonts = Fonts

MT7Letters.AvailableFonts = {
    "Gotham",
    "GothamBold",
    "SourceSans",
    "SourceSansBold",
    "Code",
    "Cartoon",
    "SciFi",
    "Fantasy"
}

--========================================================--
--                 SAFE APPLY                           --
--========================================================--

function MT7Letters.SafeApply(object, fontName)
    if not object then
        return false
    end

    local ok = pcall(function()
        MT7Letters.Apply(object, fontName)
    end)

    return ok
end

--========================================================--
--                    START                             --
--========================================================--

print("==============================================")
print("🔤 MT7 LETTERS V4")
print("✨ Font System: READY")
print("📱 Mobile Compatible: READY")
print("🎨 Presets: READY")
print("==============================================")

return MT7Letters

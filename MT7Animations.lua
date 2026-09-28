--========================================================--
--                 MT7 ANIMATIONS V4                    --
--========================================================--

local MT7Animations = {}

MT7Animations.Version = "4.0"

local TweenService = game:GetService("TweenService")

local activeTweens = {}

--========================================================--
--                    UTILITIES                         --
--========================================================--

local function stopTween(object)
    if activeTweens[object] then
        pcall(function()
            activeTweens[object]:Cancel()
        end)

        activeTweens[object] = nil
    end
end

local function playTween(object, info, properties)
    if not object then
        return nil
    end

    stopTween(object)

    local tween

    local ok = pcall(function()
        tween = TweenService:Create(
            object,
            info,
            properties
        )
    end)

    if not ok or not tween then
        return nil
    end

    activeTweens[object] = tween

    tween.Completed:Connect(function()
        if activeTweens[object] == tween then
            activeTweens[object] = nil
        end
    end)

    tween:Play()

    return tween
end

--========================================================--
--                     FADE IN                          --
--========================================================--

function MT7Animations.FadeIn(object, duration)
    if not object then
        return
    end

    duration = tonumber(duration) or 0.35

    if object:IsA("GuiObject") then
        object.Visible = true

        if object:IsA("TextLabel")
            or object:IsA("TextButton")
            or object:IsA("TextBox") then

            object.TextTransparency = 1

            playTween(
                object,
                TweenInfo.new(
                    duration,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    TextTransparency = 0
                }
            )

        elseif object:IsA("ImageLabel")
            or object:IsA("ImageButton") then

            object.ImageTransparency = 1

            playTween(
                object,
                TweenInfo.new(
                    duration,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    ImageTransparency = 0
                }
            )

        else
            object.BackgroundTransparency = 1

            playTween(
                object,
                TweenInfo.new(
                    duration,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                ),
                {
                    BackgroundTransparency = 0
                }
            )
        end
    end
end

--========================================================--
--                     FADE OUT                         --
--========================================================--

function MT7Animations.FadeOut(object, duration)
    if not object then
        return
    end

    duration = tonumber(duration) or 0.35

    if not object:IsA("GuiObject") then
        return
    end

    local properties = {}

    if object:IsA("TextLabel")
        or object:IsA("TextButton")
        or object:IsA("TextBox") then

        properties.TextTransparency = 1

    elseif object:IsA("ImageLabel")
        or object:IsA("ImageButton") then

        properties.ImageTransparency = 1

    else
        properties.BackgroundTransparency = 1
    end

    local tween = playTween(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        properties
    )

    if tween then
        tween.Completed:Connect(function()
            if object then
                object.Visible = false
            end
        end)
    end
end

--========================================================--
--                  SCALE POP IN                       --
--========================================================--

function MT7Animations.PopIn(object, duration)
    if not object or not object:IsA("GuiObject") then
        return
    end

    duration = tonumber(duration) or 0.3

    local scale = object:FindFirstChild("MT7Scale")

    if not scale then
        scale = Instance.new("UIScale")
        scale.Name = "MT7Scale"
        scale.Scale = 0.82
        scale.Parent = object
    else
        scale.Scale = 0.82
    end

    object.Visible = true

    playTween(
        scale,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Scale = 1
        }
    )
end
--========================================================--
--                   SLIDE IN                          --
--========================================================--

function MT7Animations.SlideIn(object, direction, duration)
    if not object or not object:IsA("GuiObject") then
        return
    end

    duration = tonumber(duration) or 0.35
    direction = direction or "Left"

    local target = object.Position
    local startPosition = target

    if direction == "Left" then
        startPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset - 180,
            target.Y.Scale,
            target.Y.Offset
        )

    elseif direction == "Right" then
        startPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset + 180,
            target.Y.Scale,
            target.Y.Offset
        )

    elseif direction == "Top" then
        startPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset,
            target.Y.Scale,
            target.Y.Offset - 180
        )

    elseif direction == "Bottom" then
        startPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset,
            target.Y.Scale,
            target.Y.Offset + 180
        )
    end

    object.Position = startPosition
    object.Visible = true

    playTween(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        {
            Position = target
        }
    )
end

--========================================================--
--                  SLIDE OUT                         --
--========================================================--

function MT7Animations.SlideOut(object, direction, duration)
    if not object or not object:IsA("GuiObject") then
        return
    end

    duration = tonumber(duration) or 0.35
    direction = direction or "Left"

    local target = object.Position
    local endPosition = target

    if direction == "Left" then
        endPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset - 180,
            target.Y.Scale,
            target.Y.Offset
        )

    elseif direction == "Right" then
        endPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset + 180,
            target.Y.Scale,
            target.Y.Offset
        )

    elseif direction == "Top" then
        endPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset,
            target.Y.Scale,
            target.Y.Offset - 180
        )

    elseif direction == "Bottom" then
        endPosition = UDim2.new(
            target.X.Scale,
            target.X.Offset,
            target.Y.Scale,
            target.Y.Offset + 180
        )
    end

    local tween = playTween(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.In
        ),
        {
            Position = endPosition
        }
    )

    if tween then
        tween.Completed:Connect(function()
            if object then
                object.Visible = false
                object.Position = target
            end
        end)
    end
end

--========================================================--
--                FLOATING BUTTON                      --
--========================================================--

function MT7Animations.FloatButton(object)
    if not object or not object:IsA("GuiObject") then
        return
    end

    local scale = object:FindFirstChild("MT7FloatScale")

    if not scale then
        scale = Instance.new("UIScale")
        scale.Name = "MT7FloatScale"
        scale.Scale = 1
        scale.Parent = object
    end

    playTween(
        scale,
        TweenInfo.new(
            0.8,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            -1,
            true
        ),
        {
            Scale = 1.08
        }
    )
end

--========================================================--
--                  BUTTON PRESS                       --
--========================================================--

function MT7Animations.ButtonPress(object)
    if not object or not object:IsA("GuiObject") then
        return
    end

    local scale = object:FindFirstChild("MT7ButtonScale")

    if not scale then
        scale = Instance.new("UIScale")
        scale.Name = "MT7ButtonScale"
        scale.Scale = 1
        scale.Parent = object
    end

    stopTween(scale)

    playTween(
        scale,
        TweenInfo.new(
            0.08,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Scale = 0.94
        }
    )

    task.delay(0.08, function()
        if scale and scale.Parent then
            playTween(
                scale,
                TweenInfo.new(
                    0.12,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.Out
                ),
                {
                    Scale = 1
                }
            )
        end
    end)
end
--========================================================--
--                    ECLIPSE                           --
--========================================================--

function MT7Animations.Eclipse(screenGui, duration)
    if not screenGui then
        return nil
    end

    duration = tonumber(duration) or 1.2

    local overlay = Instance.new("Frame")
    overlay.Name = "MT7Eclipse"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.Position = UDim2.fromScale(0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 999
    overlay.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Name = "MT7Title"
    title.Size = UDim2.new(1, 0, 0, 80)
    title.Position = UDim2.new(0, 0, 0.5, -40)
    title.BackgroundTransparency = 1
    title.Text = "MT7 HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 1
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 1000
    title.Parent = overlay

    -- Entrada do título
    playTween(
        title,
        TweenInfo.new(
            0.6,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            TextTransparency = 0
        }
    )

    task.wait(0.7)

    -- Pequeno efeito de eclipse
    local eclipse = Instance.new("Frame")
    eclipse.Name = "EclipseCircle"
    eclipse.Size = UDim2.new(0, 20, 0, 20)
    eclipse.AnchorPoint = Vector2.new(0.5, 0.5)
    eclipse.Position = UDim2.fromScale(0.5, 0.5)
    eclipse.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    eclipse.BorderSizePixel = 0
    eclipse.ZIndex = 1001
    eclipse.Parent = overlay

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = eclipse

    playTween(
        eclipse,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 900, 0, 900)
        }
    )

    task.wait(duration)

    playTween(
        title,
        TweenInfo.new(
            0.35,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            TextTransparency = 1
        }
    )

    playTween(
        overlay,
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            BackgroundTransparency = 1
        }
    )

    task.wait(0.5)

    if overlay and overlay.Parent then
        overlay:Destroy()
    end

    return true
end

--========================================================--
--                 OPEN ANIMATION                       --
--========================================================--

function MT7Animations.OpenInterface(mainFrame)
    if not mainFrame then
        return
    end

    mainFrame.Visible = true

    MT7Animations.PopIn(
        mainFrame,
        0.4
    )

    task.wait(0.1)

    MT7Animations.FadeIn(
        mainFrame,
        0.35
    )
end

--========================================================--
--                CLOSE ANIMATION                       --
--========================================================--

function MT7Animations.CloseInterface(mainFrame)
    if not mainFrame then
        return
    end

    MT7Animations.FadeOut(
        mainFrame,
        0.3
    )
end

--========================================================--
--                    STOP ALL                          --
--========================================================--

function MT7Animations.StopAll()
    for object, tween in pairs(activeTweens) do
        if tween then
            pcall(function()
                tween:Cancel()
            end)
        end

        activeTweens[object] = nil
    end
end

--========================================================--
--                     DESTROY                          --
--========================================================--

function MT7Animations.Destroy()
    MT7Animations.StopAll()
end

--========================================================--
--                      INFO                            --
--========================================================--

function MT7Animations.GetInfo()
    return {
        Version = MT7Animations.Version,
        ActiveTweens = activeTweens
    }
end

print("==============================================")
print("🎭 MT7 ANIMATIONS V4")
print("🌑 Eclipse: READY")
print("✨ Fade System: READY")
print("🔘 Button Animation: READY")
print("📱 Mobile Animation: READY")
print("==============================================")

return MT7Animations

-- ================================================================= --
-- ================== GRASS HACK + SPEED BOOSTER =================== --
-- ======================== by Cyifog ============================== --
-- ================================================================= --

-- Services
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- RemoteEvents
local AirdropClaimed = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AirdropClaimed")

-- Hack states
local isGrassEnabled = false
local isSpeedEnabled = false
local currentSpeed = 50 -- valor inicial da velocidade

-- === GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GrassAndSpeedGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 260)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Inf Grass + SPEED"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = header
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- === CREDITS WATERMARK (BOTTOM-CENTER LOW + CENTERED TEXT) ===
local wm = Instance.new("Frame")
wm.Name = "CreditsWatermark"
wm.Size = UDim2.new(0, 150, 0, 22) -- dei mais largura para caber bonito
wm.Position = UDim2.new(0.5, 0, 1, -6)
wm.AnchorPoint = Vector2.new(0.5, 1)
wm.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
wm.BackgroundTransparency = 0.35
wm.BorderSizePixel = 0
wm.Parent = mainFrame
wm.ZIndex = 20

local wmCorner = Instance.new("UICorner")
wmCorner.CornerRadius = UDim.new(0, 10)
wmCorner.Parent = wm

local wmStroke = Instance.new("UIStroke")
wmStroke.Thickness = 1
wmStroke.Color = Color3.fromRGB(255, 255, 255)
wmStroke.Transparency = 0.7
wmStroke.Parent = wm

local wmGradient = Instance.new("UIGradient")
wmGradient.Rotation = 90
wmGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
wmGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.15),
    NumberSequenceKeypoint.new(1, 0.45)
}
wmGradient.Parent = wm

local wmText = Instance.new("TextLabel")
wmText.BackgroundTransparency = 1
wmText.Size = UDim2.new(1, -10, 1, 0)
wmText.Position = UDim2.new(0, 5, 0, 0)
wmText.Font = Enum.Font.GothamSemibold
wmText.TextSize = 12
wmText.TextColor3 = Color3.fromRGB(210, 215, 235)
wmText.TextXAlignment = Enum.TextXAlignment.Center -- centralizado
wmText.Text = "Credits · Cyifog"
wmText.Parent = wm

-- efeito hover
wm.MouseEnter:Connect(function()
    wm.BackgroundTransparency = 0.25
    wmText.TextColor3 = Color3.fromRGB(230, 235, 255)
end)
wm.MouseLeave:Connect(function()
    wm.BackgroundTransparency = 0.35
    wmText.TextColor3 = Color3.fromRGB(210, 215, 235)
end)


-- brilho suave ao passar o rato
wm.MouseEnter:Connect(function()
    wm.BackgroundTransparency = 0.25
    wmText.TextColor3 = Color3.fromRGB(230, 235, 255)
end)
wm.MouseLeave:Connect(function()
    wm.BackgroundTransparency = 0.35
    wmText.TextColor3 = Color3.fromRGB(210, 215, 235)
end)


-- brilho suave ao passar o rato
wm.MouseEnter:Connect(function()
    wm.BackgroundTransparency = 0.25
    wmText.TextColor3 = Color3.fromRGB(230, 235, 255)
end)
wm.MouseLeave:Connect(function()
    wm.BackgroundTransparency = 0.35
    wmText.TextColor3 = Color3.fromRGB(210, 215, 235)
end)


-- ===== Helpers =====
local function createToggle(text, y, defaultState, onToggle)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 45)
    frame.Position = UDim2.new(0.05, 0, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.Parent = mainFrame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.3, 0, 0.8, 0)
    toggleBtn.Position = UDim2.new(1, -5, 0.1, 0)
    toggleBtn.AnchorPoint = Vector2.new(1, 0)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(200, 80, 80)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Text = defaultState and "ON" or "OFF"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 14
    toggleBtn.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        local newState = (toggleBtn.Text ~= "ON")
        toggleBtn.Text = newState and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = newState and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(200, 80, 80)
        onToggle(newState)
    end)

    return toggleBtn
end

local function createSlider(y, min, max, defaultValue, onChange)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 50)
    frame.Position = UDim2.new(0.05, 0, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.Parent = mainFrame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = "Speed: " .. math.floor(defaultValue)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.9, 0, 0, 8)
    slider.Position = UDim2.new(0.05, 0, 0, 26)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    slider.BorderSizePixel = 0
    slider.Parent = frame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = slider

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new((defaultValue - min) / (max - min), 0, 0.5, 0)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    knob.BorderSizePixel = 0
    knob.Parent = slider

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = knob

    -- Drag logic
    local dragging = false
    local inputChangedConn, inputEndedConn

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mainFrame.Draggable = false
        end
    end)

    local function finishDrag()
        dragging = false
        mainFrame.Draggable = true
    end

    inputEndedConn = knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            finishDrag()
        end
    end)

    inputChangedConn = UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            knob.Position = UDim2.new(rel, 0, 0.5, 0)
            local value = min + (max - min) * rel
            label.Text = "Speed: " .. math.floor(value)
            onChange(value)
        end
    end)

    onChange(defaultValue)
end

-- ===== Features =====

-- Infinite Grass Toggle
createToggle("Inf Grass", 50, false, function(state)
    isGrassEnabled = state
    if state then
        task.spawn(function()
            while isGrassEnabled do
                pcall(function()
                    -- valor enorme para forçar “infinite grass”
                    AirdropClaimed:FireServer(9e+99)
                end)
                task.wait(0.5)
            end
        end)
    end
end)

-- Custom Speed Toggle
createToggle("Custom Speed", 100, false, function(state)
    isSpeedEnabled = state
    local char = Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = state and currentSpeed or 16
    end
end)

-- Speed Slider
createSlider(155, 16, 100, currentSpeed, function(value)
    currentSpeed = value
    if isSpeedEnabled then
        local char = Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = value
        end
    end
end)

-- Persist speed after respawn
Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:WaitForChild("Humanoid")
    if isSpeedEnabled then
        hum.WalkSpeed = currentSpeed
    else
        hum.WalkSpeed = 16
    end
end)

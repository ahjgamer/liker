-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EntityKillerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui") -- Use PlayerGui if in normal Roblox script

-- Main frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0.5, -110, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

-- Title bar for dragging and minimizing
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Entity Killer"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.Parent = titleBar

-- Minimize button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -30, 0, 2)
minimizeBtn.Parent = titleBar

-- Container for buttons, to hide/show on minimize
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = frame

-- Kill Button
local killButton = Instance.new("TextButton")
killButton.Size = UDim2.new(0.8, 0, 0, 45)
killButton.Position = UDim2.new(0.1, 0, 0.2, 0)
killButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
killButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killButton.Font = Enum.Font.GothamBold
killButton.TextSize = 24
killButton.Text = "Kill All Entities"
killButton.Parent = contentFrame

-- Minimize toggle function
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        contentFrame.Visible = false
        frame.Size = UDim2.new(0, 220, 0, 30) -- shrink height to title bar only
        minimizeBtn.Text = "+"
    else
        contentFrame.Visible = true
        frame.Size = UDim2.new(0, 220, 0, 120)
        minimizeBtn.Text = "-"
    end
end)

-- Kill function
local function killAllEntities()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local workspace = game:GetService("Workspace")

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                -- Skip local player character
                if localPlayer and localPlayer.Character and obj == localPlayer.Character then
                    -- Don't kill player
                else
                    humanoid.Health = 0
                end
            end
        end
    end
end

killButton.MouseButton1Click:Connect(killAllEntities)

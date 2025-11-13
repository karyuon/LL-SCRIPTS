
--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--// Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 80
local moveDir = Vector3.zero

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LeliksGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 120)
MainFrame.Position = UDim2.new(0.5, -240, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Leliks Script"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 25
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = MainFrame

local FlyBtn = Instance.new("TextButton")
FlyBtn.Name = "FlyBtn"
FlyBtn.Size = UDim2.new(1, -20, 0, 50)
FlyBtn.Position = UDim2.new(0, 10, 0, 60)
FlyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
FlyBtn.Text = "Fly"
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 20
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Parent = MainFrame

local FlyUICorner = Instance.new("UICorner")
FlyUICorner.CornerRadius = UDim.new(0, 10)
FlyUICorner.Parent = FlyBtn

--// Fly logic
local function toggleFly()
	flying = not flying
	FlyBtn.Text = flying and "Flying..." or "Fly"
	if flying then
		humanoid.PlatformStand = true
	else
		humanoid.PlatformStand = false
		root.Velocity = Vector3.zero
	end
end

FlyBtn.MouseButton1Click:Connect(toggleFly)

--// Movement
RunService.RenderStepped:Connect(function()
	if flying then
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			dir = dir + cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			dir = dir - cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			dir = dir - cam.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			dir = dir + cam.CFrame.RightVector
		end

		if dir.Magnitude > 0 then
			root.Velocity = dir.Unit * speed
		else
			root.Velocity = Vector3.zero
		end
	end
end)

--// GUI toggle with X key
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.X then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

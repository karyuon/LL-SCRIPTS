local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Clean up previous versions
if CoreGui:FindFirstChild("LeliksGlobalUI") then
	CoreGui.LeliksGlobalUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LeliksGlobalUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if ScreenGui.Parent == nil then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- >> 1. MINI TOGGLE BUTTON <<
local MiniFrame = Instance.new("TextButton")
MiniFrame.Name = "MiniToggle"
MiniFrame.Size = UDim2.new(0, 140, 0, 30)
MiniFrame.Position = UDim2.new(0.5, -70, 0, 10)
MiniFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MiniFrame.Text = "Leliks Script"
MiniFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniFrame.Font = Enum.Font.GothamBold
MiniFrame.TextSize = 14
MiniFrame.BorderSizePixel = 0
MiniFrame.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 8)
MiniCorner.Parent = MiniFrame

-- >> 2. MAIN FRAME <<
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 360) 
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Visible = false 
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Leliks Global Scripts"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -20, 0, 2)
Line.Position = UDim2.new(0, 10, 0, 45)
Line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- --- DRAGGABLE ---
local function makeDraggable(guiObject)
	local dragging, dragStart, startPos
	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = guiObject.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	guiObject.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
makeDraggable(MainFrame)
makeDraggable(MiniFrame)

-- --- TOGGLE LOGIC ---
local function ToggleMenu() MainFrame.Visible = not MainFrame.Visible end
MiniFrame.MouseButton1Click:Connect(ToggleMenu)
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.V then ToggleMenu() end
end)

-- --- BUTTON CREATOR ---
function createToggleButton(text, positionY, onActivate, onDeactivate)
	local Button = Instance.new("TextButton")
	Button.Text = text
	Button.Size = UDim2.new(0.9, 0, 0, 35)
	Button.Position = UDim2.new(0.05, 0, 0, positionY)
	Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Button.TextColor3 = Color3.fromRGB(240, 240, 240)
	Button.Font = Enum.Font.GothamSemibold
	Button.TextSize = 16
	Button.Parent = MainFrame
	
	local BtnCorner = Instance.new("UICorner")
	BtnCorner.CornerRadius = UDim.new(0, 6)
	BtnCorner.Parent = Button
	
	local isActive = false
	Button.MouseButton1Click:Connect(function()
		isActive = not isActive
		if isActive then
			Button.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
			Button.Text = text .. " [ON]"
			onActivate(Button)
		else
			Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Button.Text = text
			onDeactivate(Button)
		end
	end)
	return Button
end

-- --- CHEATS ---

-- 1. SPEED
createToggleButton("Walkspeed", 60, 
	function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end,
	function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
)

-- 2. JUMP
createToggleButton("Infinite Jump", 105, 
	function() LocalPlayer.Character.Humanoid.JumpPower = 100 end,
	function() LocalPlayer.Character.Humanoid.JumpPower = 50 end
)

-- 3. FLY (WITH SPEED INPUT)
local flying = false
local bg, bv
local FlyBtn = createToggleButton("Fly Mode", 150, 
	function()
		flying = true
		local char = LocalPlayer.Character
		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChild("Humanoid")
		if root and hum then
			bg = Instance.new("BodyGyro", root)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bv = Instance.new("BodyVelocity", root)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			hum.PlatformStand = true
			
			while flying and char and root do
				RunService.RenderStepped:Wait()
				local speed = tonumber(MainFrame.FlySpeedInput.Text) or 50
				local cam = workspace.CurrentCamera
				bg.cframe = cam.CFrame
				local vel = Vector3.new(0,0,0)
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + (cam.CFrame.LookVector * speed) end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - (cam.CFrame.LookVector * speed) end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - (cam.CFrame.RightVector * speed) end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + (cam.CFrame.RightVector * speed) end
				bv.velocity = vel
			end
		end
	end,
	function()
		flying = false
		if bg then bg:Destroy() end
		if bv then bv:Destroy() end
		if LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.PlatformStand = false end
	end
)

local SpeedInput = Instance.new("TextBox")
SpeedInput.Name = "FlySpeedInput"
SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0, 50, 0, 25)
SpeedInput.Position = UDim2.new(0.75, 20, 0, 155) 
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpeedInput.TextColor3 = Color3.fromRGB(0, 170, 255)
SpeedInput.Text = "50"
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.TextSize = 14
local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 4)
SpeedCorner.Parent = SpeedInput

-- 4. GRAVITY
createToggleButton("Low Gravity", 195, 
	function() workspace.Gravity = 50 end,
	function() workspace.Gravity = 196.2 end
)

-- 5. NOCLIP (FIXED)
local noclipConnection
createToggleButton("Noclip", 240,
	function()
		_G.Noclip = true
		noclipConnection = RunService.Stepped:Connect(function()
			if _G.Noclip and LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide == true then
						part.CanCollide = false
					end
				end
			end
		end)
	end,
	function()
		_G.Noclip = false
		if noclipConnection then noclipConnection:Disconnect() end
		-- Reset collisions
		if LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
)

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

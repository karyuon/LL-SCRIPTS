-- // Leliks Script GUI (LocalScript)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI MAIN
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeliksGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Leliks Script"
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

-- toggle button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 1, -50)
toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Leliks Script"
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- CATEGORY BUTTONS
local randomsButton = Instance.new("TextButton")
randomsButton.Size = UDim2.new(0, 100, 0, 30)
randomsButton.Position = UDim2.new(0, 10, 0, 50)
randomsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
randomsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomsButton.Text = "Randoms"
randomsButton.Parent = mainFrame

local gamesButton = Instance.new("TextButton")
gamesButton.Size = UDim2.new(0, 100, 0, 30)
gamesButton.Position = UDim2.new(0, 120, 0, 50)
gamesButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gamesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
gamesButton.Text = "Games"
gamesButton.Parent = mainFrame

-- CATEGORY FRAMES
local randomsFrame = Instance.new("Frame")
randomsFrame.Size = UDim2.new(1, -20, 1, -90)
randomsFrame.Position = UDim2.new(0, 10, 0, 90)
randomsFrame.BackgroundTransparency = 1
randomsFrame.Visible = false
randomsFrame.Parent = mainFrame

local gamesFrame = Instance.new("Frame")
gamesFrame.Size = UDim2.new(1, -20, 1, -90)
gamesFrame.Position = UDim2.new(0, 10, 0, 90)
gamesFrame.BackgroundTransparency = 1
gamesFrame.Visible = false
gamesFrame.Parent = mainFrame

-- category toggle
local function toggleCategory(button, frame)
	frame.Visible = not frame.Visible
	for _, f in pairs({randomsFrame, gamesFrame}) do
		if f ~= frame then
			f.Visible = false
		end
	end
end

randomsButton.MouseButton1Click:Connect(function()
	toggleCategory(randomsButton, randomsFrame)
end)
gamesButton.MouseButton1Click:Connect(function()
	toggleCategory(gamesButton, gamesFrame)
end)

-------------------------------------------------
-- RANDOMS BUTTONS
-------------------------------------------------

-- Lighter
local lighterButton = Instance.new("TextButton")
lighterButton.Size = UDim2.new(0, 150, 0, 40)
lighterButton.Position = UDim2.new(0, 10, 0, 10)
lighterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
lighterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lighterButton.Text = "Lighter: OFF"
lighterButton.Parent = randomsFrame

lighterButton.MouseButton1Click:Connect(function()
	local current = player:GetAttribute("HasLighter")
	if not current then
		player:SetAttribute("HasLighter", true)
		lighterButton.Text = "Lighter: ON"
	else
		player:SetAttribute("HasLighter", false)
		lighterButton.Text = "Lighter: OFF"
	end
end)

-- Dash
local dashButton = Instance.new("TextButton")
dashButton.Size = UDim2.new(0, 150, 0, 40)
dashButton.Position = UDim2.new(0, 10, 0, 60)
dashButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
dashButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dashButton.Text = "Dash: OFF"
dashButton.Parent = randomsFrame

dashButton.MouseButton1Click:Connect(function()
	local current = player:GetAttribute("HasDash")
	if not current then
		player:SetAttribute("HasDash", true)
		dashButton.Text = "Dash: ON"
		local boosts = player:FindFirstChild("Boosts")
		if boosts and boosts:FindFirstChild("Faster Sprint") then
			boosts["Faster Sprint"].Value = 5
		end
	else
		player:SetAttribute("HasDash", false)
		dashButton.Text = "Dash: OFF"
		local boosts = player:FindFirstChild("Boosts")
		if boosts and boosts:FindFirstChild("Faster Sprint") then
			boosts["Faster Sprint"].Value = 3
		end
	end
end)

-- ESP (Names only)
local espEnabled = false
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0, 150, 0, 40)
espButton.Position = UDim2.new(0, 10, 0, 110)
espButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Text = "ESP: OFF"
espButton.Parent = randomsFrame

local function createBillboard(playerObj)
	if playerObj.Character and playerObj.Character:FindFirstChild("HumanoidRootPart") and not playerObj.Character:FindFirstChild("ESPTag") then
		local billboard = Instance.new("BillboardGui")
		billboard.Name = "ESPTag"
		billboard.Adornee = playerObj.Character.HumanoidRootPart
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.AlwaysOnTop = true
		billboard.Parent = playerObj.Character

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Text = playerObj.Name
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.TextScaled = true
		label.Parent = billboard
	end
end

local function removeBillboard(playerObj)
	if playerObj.Character and playerObj.Character:FindFirstChild("ESPTag") then
		playerObj.Character.ESPTag:Destroy()
	end
end

espButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			if espEnabled then
				createBillboard(plr)
			else
				removeBillboard(plr)
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if espEnabled then
		plr.CharacterAdded:Connect(function()
			createBillboard(plr)
		end)
	end
end)

-- Infinite Jump
local infJumpEnabled = false
local infJumpButton = Instance.new("TextButton")
infJumpButton.Size = UDim2.new(0, 150, 0, 40)
infJumpButton.Position = UDim2.new(0, 10, 0, 160)
infJumpButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
infJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infJumpButton.Text = "Inf Jump: OFF"
infJumpButton.Parent = randomsFrame

UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

infJumpButton.MouseButton1Click:Connect(function()
	infJumpEnabled = not infJumpEnabled
	infJumpButton.Text = infJumpEnabled and "Inf Jump: ON" or "Inf Jump: OFF"
end)

-- WalkSpeed slider (textbox for simplicity)
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 150, 0, 40)
speedBox.Position = UDim2.new(0, 10, 0, 210)
speedBox.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "Speed (0-999)"
speedBox.Text = ""
speedBox.Parent = randomsFrame

speedBox.FocusLost:Connect(function(enter)
	if enter then
		local val = tonumber(speedBox.Text)
		if val and player.Character and player.Character:FindFirstChild("Humanoid") then
			local humanoid = player.Character.Humanoid
			humanoid.WalkSpeed = math.clamp(val, 0, 999)
		end
	end
end)

-- Gamepass1 (Fake)
local gamepassButton = Instance.new("TextButton")
gamepassButton.Size = UDim2.new(0, 150, 0, 40)
gamepassButton.Position = UDim2.new(0, 10, 0, 260)
gamepassButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
gamepassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
gamepassButton.Text = "Gamepass1: OFF"
gamepassButton.Parent = randomsFrame

gamepassButton.MouseButton1Click:Connect(function()
	local current = player:GetAttribute("__OwnsVIPGamepass")
	if not current then
		player:SetAttribute("__OwnsVIPGamepass", true)
		gamepassButton.Text = "Gamepass1: ON"
	else
		player:SetAttribute("__OwnsVIPGamepass", false)
		gamepassButton.Text = "Gamepass1: OFF"
	end
end)

-- Fly
local flyActive = false
local flySpeed = 50
local flyConnection
local keys = {W=false, A=false, S=false, D=false, Space=false, LeftShift=false}

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 150, 0, 40)
flyButton.Position = UDim2.new(0, 10, 0, 310)
flyButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Text = "Fly: OFF"
flyButton.Parent = randomsFrame

UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and flyActive then
		if input.KeyCode == Enum.KeyCode.W then keys.W = true end
		if input.KeyCode == Enum.KeyCode.A then keys.A = true end
		if input.KeyCode == Enum.KeyCode.S then keys.S = true end
		if input.KeyCode == Enum.KeyCode.D then keys.D = true end
		if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
		if input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = true end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then keys.W = false end
	if input.KeyCode == Enum.KeyCode.A then keys.A = false end
	if input.KeyCode == Enum.KeyCode.S then keys.S = false end
	if input.KeyCode == Enum.KeyCode.D then keys.D = false end
	if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
	if input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = false end
end)

local function startFly()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5,1e5,1e5)
	bv.Velocity = Vector3.new()
	bv.Parent = root
	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
	bg.CFrame = root.CFrame
	bg.Parent = root
	flyConnection = RunService.RenderStepped:Connect(function()
		local move = Vector3.new()
		if keys.W then move += root.CFrame.LookVector end
		if keys.S then move -= root.CFrame.LookVector end
		if keys.A then move -= root.CFrame.RightVector end
		if keys.D then move += root.CFrame.RightVector end
		if keys.Space then move += Vector3.new(0,1,0) end
		if keys.LeftShift then move -= Vector3.new(0,1,0) end
		bv.Velocity = move.Magnitude > 0 and move.Unit * flySpeed or Vector3.new()
		bg.CFrame = CFrame.new(root.Position, root.Position + workspace.CurrentCamera.CFrame.LookVector)
	end)
end

local function stopFly()
	if flyConnection then flyConnection:Disconnect() flyConnection=nil end
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root then
		for _,v in pairs(root:GetChildren()) do
			if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
		end
	end
end

flyButton.MouseButton1Click:Connect(function()
	flyActive = not flyActive
	flyButton.Text = flyActive and "Fly: ON" or "Fly: OFF"
	if flyActive then startFly() else stopFly() end
end)

-------------------------------------------------
-- GAMES BUTTONS
-------------------------------------------------

-- RLGL
local rlglFrame = Instance.new("Frame")
rlglFrame.Size = UDim2.new(0, 460, 0, 100)
rlglFrame.Position = UDim2.new(0, 10, 0, 10)
rlglFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
rlglFrame.Parent = gamesFrame

local rlglLabel = Instance.new("TextLabel")
rlglLabel.Size = UDim2.new(1, 0, 0, 30)
rlglLabel.BackgroundTransparency = 1
rlglLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
rlglLabel.Text = "RLGL Game"
rlglLabel.TextScaled = true
rlglLabel.Font = Enum.Font.SourceSansBold
rlglLabel.Parent = rlglFrame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 150, 0, 40)
teleportButton.Position = UDim2.new(0, 10, 0, 40)
teleportButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Text = "Teleport End"
teleportButton.Parent = rlglFrame

teleportButton.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(
			-43.7126923, 1021.32306, 134.34935,
			0.757530987, 0.375069857, 0.534293354,
			-0.158642665, 0.899701357, -0.40665701,
			-0.633229256, 0.223293558, 0.74105376
		)
	end
end)

-- Hide And Seek
local hasFrame = Instance.new("Frame")
hasFrame.Size = UDim2.new(0, 460, 0, 100)
hasFrame.Position = UDim2.new(0, 10, 0, 120)
hasFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hasFrame.Parent = gamesFrame

local hasLabel = Instance.new("TextLabel")
hasLabel.Size = UDim2.new(1, 0, 0, 30)
hasLabel.BackgroundTransparency = 1
hasLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hasLabel.Text = "Hide And Seek"
hasLabel.TextScaled = true
hasLabel.Font = Enum.Font.SourceSansBold
hasLabel.Parent = hasFrame

local killPartsButton = Instance.new("TextButton")
killPartsButton.Size = UDim2.new(0, 200, 0, 40)
killPartsButton.Position = UDim2.new(0, 10, 0, 40)
killPartsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
killPartsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killPartsButton.Text = "Delete KillingParts"
killPartsButton.Parent = hasFrame

killPartsButton.MouseButton1Click:Connect(function()
	for _, d in pairs(workspace:GetDescendants()) do
		if d.Name == "KillingParts" then
			d:Destroy()
		end
	end
end)

-- Jump Rope
local jrFrame = Instance.new("Frame")
jrFrame.Size = UDim2.new(0, 460, 0, 100)
jrFrame.Position = UDim2.new(0, 10, 0, 230)
jrFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
jrFrame.Parent = gamesFrame

local jrLabel = Instance.new("TextLabel")
jrLabel.Size = UDim2.new(1, 0, 0, 30)
jrLabel.BackgroundTransparency = 1
jrLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jrLabel.Text = "Jump Rope"
jrLabel.TextScaled = true
jrLabel.Font = Enum.Font.SourceSansBold
jrLabel.Parent = jrFrame

local jrTeleport = Instance.new("TextButton")
jrTeleport.Size = UDim2.new(0, 150, 0, 40)
jrTeleport.Position = UDim2.new(0, 10, 0, 40)
jrTeleport.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jrTeleport.TextColor3 = Color3.fromRGB(255, 255, 255)
jrTeleport.Text = "Teleport End"
jrTeleport.Parent = jrFrame

jrTeleport.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(
			737.156372, 193.805084, 920.952515,
			-1.1920929e-07, 0, -1.00000012,
			0, 1, 0,
			1.00000012, 0, -1.1920929e-07
		)
	end
end)

-- Glass Bridge
local gbFrame = Instance.new("Frame")
gbFrame.Size = UDim2.new(0, 460, 0, 100)
gbFrame.Position = UDim2.new(0, 10, 0, 340)
gbFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
gbFrame.Parent = gamesFrame

local gbLabel = Instance.new("TextLabel")
gbLabel.Size = UDim2.new(1, 0, 0, 30)
gbLabel.BackgroundTransparency = 1
gbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gbLabel.Text = "Glass Bridge"
gbLabel.TextScaled = true
gbLabel.Font = Enum.Font.SourceSansBold
gbLabel.Parent = gbFrame

local gbTeleport = Instance.new("TextButton")
gbTeleport.Size = UDim2.new(0, 150, 0, 40)
gbTeleport.Position = UDim2.new(0, 10, 0, 40)
gbTeleport.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
gbTeleport.TextColor3 = Color3.fromRGB(255, 255, 255)
gbTeleport.Text = "Teleport End"
gbTeleport.Parent = gbFrame

gbTeleport.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(
			-211.855881, 517.039062, -1534.7373,
			-1.1920929e-07, 0, 1.00000012,
			0, 1, 0,
			-1.00000012, 0, -1.1920929e-07
		)
	end
end)

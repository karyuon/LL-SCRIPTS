--// Leliks Script 
--// GUI v2.8 | Script v3.1
--// Script for Ink Game
--// Scripted by Leliks
--// If You Stealing This Script You Are Gay
------------------------------------------
----MAIN----------------------
------------------------------------------

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- MAIN GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "LeliksGUI"
screenGui.ResetOnSpawn = false

-- Make GUI always visible
local CoreGui = game:GetService("CoreGui")
if not screenGui:IsDescendantOf(CoreGui) then
	screenGui.Parent = CoreGui
end
screenGui.DisplayOrder = 999999
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Kick
if Workspace:FindFirstChild("Camer") then
    pcall(function() player:Kick("Script Updating, Wait Update (3.0 Coming)") end)
end

-- Lobby checker
if  Workspace.Effects:FindFirstChild("QueuePart") then
    pcall(function() player:Kick("You can't run this lobby") end)
end

-- OPEN BUTTON
local toggle = Instance.new("TextButton", screenGui)
toggle.Size = UDim2.new(0,120,0,30)
toggle.Position = UDim2.new(0,10,1,-40)
toggle.Text = "LELIKS Script"
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 16
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,6)

-- MAIN FRAME
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0,600,0,400)
mainFrame.Position = UDim2.new(0.5,-300,0.5,-200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,10)

-- Title / Subtitle
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.Text = "Leliks Script"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Center

local subTitle = Instance.new("TextLabel", mainFrame)
subTitle.Size = UDim2.new(1,0,0,20)
subTitle.Position = UDim2.new(0,0,0,40)
subTitle.Text = "GUI v2.8 | Script v3.1"
subTitle.Font = Enum.Font.SourceSans
subTitle.TextSize = 14
subTitle.BackgroundTransparency = 1
subTitle.TextColor3 = Color3.fromRGB(200,200,200)
subTitle.TextXAlignment = Enum.TextXAlignment.Center

-- LEFT MENU (categories)
local leftMenu = Instance.new("Frame", mainFrame)
leftMenu.Size = UDim2.new(0,150,1,-60)
leftMenu.Position = UDim2.new(0,0,0,60)
leftMenu.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", leftMenu).CornerRadius = UDim.new(0,8)

local menuLayout = Instance.new("UIListLayout", leftMenu)
menuLayout.Padding = UDim.new(0,5)
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- RIGHT CONTENT
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-160,1,-60)
contentFrame.Position = UDim2.new(0,160,0,60)
contentFrame.BackgroundTransparency = 1

-- UI helpers
local function createMenuButton(name)
    local btn = Instance.new("TextButton", leftMenu)
    btn.Size = UDim2.new(1,-10,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    return btn
end

local function createScroll(name)
    local scroll = Instance.new("ScrollingFrame", contentFrame)
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.CanvasSize = UDim2.new(0,0,0,2000)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    scroll.Visible = false
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    scroll.Name = name
    return scroll
end

local function createButton(parent, text, isVIP)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-10,0,30)
    btn.BackgroundColor3 = isVIP and Color3.fromRGB(0,100,255) or Color3.fromRGB(80,80,80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    return btn
end

-- Category frames & menu buttons
local randomScroll = createScroll("RandomFeatures")
local gamesScroll = createScroll("Games")
local keybindsScroll = createScroll("Keybinds")
local settingsScroll = createScroll("Settings")

local randomBtn = createMenuButton("Random Features")
local gamesBtn = createMenuButton("Games")
local keybindsBtn = createMenuButton("Keybinds")
local settingsBtn = createMenuButton("Settings")

local function showCategory(catName)
    for _, f in pairs(contentFrame:GetChildren()) do
        if f:IsA("ScrollingFrame") then
            f.Visible = (f.Name == catName)
        end
    end
end

randomBtn.MouseButton1Click:Connect(function() showCategory("RandomFeatures") end)
gamesBtn.MouseButton1Click:Connect(function() showCategory("Games") end)
keybindsBtn.MouseButton1Click:Connect(function() showCategory("Keybinds") end)
settingsBtn.MouseButton1Click:Connect(function() showCategory("Settings") end)

-- default
showCategory("RandomFeatures")

-- Toggle menu (button + keybind)
local toggleKey = Enum.KeyCode.X
local function toggleMenu()
    mainFrame.Visible = not mainFrame.Visible
end
toggle.MouseButton1Click:Connect(toggleMenu)
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == toggleKey then
        toggleMenu()
    end
end)

-- Keep references to running tasks/connections to clean on unload
local connections = {}
local spawnedTasks = {}

local function addConnection(conn) table.insert(connections, conn) end
local function addSpawn(taskRef) table.insert(spawnedTasks, taskRef) end

-- -------------------
-- RANDOM FEATURES 
-- -------------------

-- Dash
local dashBtn = createButton(randomScroll, "Dash: OFF")
local dashOn = false
dashBtn.MouseButton1Click:Connect(function()
    dashOn = not dashOn
    dashBtn.Text = dashOn and "Dash: ON" or "Dash: OFF"
    local boosts = player:FindFirstChild("Boosts")
    if boosts and boosts:FindFirstChild("Faster Sprint") then
        boosts["Faster Sprint"].Value = dashOn and 5 or 3
    end
end)

-- Phantom Step (uses _EquippedPower attribute)
local phantomBtn = createButton(randomScroll, "Phantom Step: OFF")
local phantomOn = false
phantomBtn.MouseButton1Click:Connect(function()
    phantomOn = not phantomOn
    if phantomOn then
        player:SetAttribute("_EquippedPower", "PHANTOM STEP")
        phantomBtn.Text = "Phantom Step: ON"
    else
        player:SetAttribute("_EquippedPower", "None")
        phantomBtn.Text = "Phantom Step: OFF"
    end
end)

-- Name ESP (simple)
local espBtn = createButton(randomScroll, "ESP: OFF")
local espOn = false
local function clearNameESPFor(plr)
    if plr.Character then
        local g = plr.Character:FindFirstChild("NameESP")
        if g then g:Destroy() end
    end
end
local function createNameESPFor(plr)
    if not (plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then return end
    clearNameESPFor(plr)
    local bill = Instance.new("BillboardGui", plr.Character)
    bill.Name = "NameESP"
    bill.Adornee = plr.Character.HumanoidRootPart
    bill.Size = UDim2.new(0,200,0,50)
    bill.AlwaysOnTop = true
    local lbl = Instance.new("TextLabel", bill)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextScaled = true
    lbl.Text = plr.Name
    lbl.TextColor3 = Color3.new(1,1,1)
end

espBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    espBtn.Text = espOn and "ESP: ON" or "ESP: OFF"
    for _, plr in pairs(Players:GetPlayers()) do
        if espOn then
            createNameESPFor(plr)
        else
            clearNameESPFor(plr)
        end
    end
end)

-- keep name ESP updated for joins/character spawns
addConnection(Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.6)
        if espOn then createNameESPFor(plr) end
    end)
end))
for _, plr in pairs(Players:GetPlayers()) do
    plr.CharacterAdded:Connect(function()
        task.wait(0.6)
        if espOn then createNameESPFor(plr) end
    end)
end

-- Infinite Jump
local infBtn = createButton(randomScroll, "Infinite Jump: OFF")
local infOn = false
infBtn.MouseButton1Click:Connect(function()
    infOn = not infOn
    infBtn.Text = infOn and "Infinite Jump: ON" or "Infinite Jump: OFF"
end)
addConnection(UIS.JumpRequest:Connect(function()
    if infOn and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

-- Auto Safe Place
local autoSafeBtn = createButton(randomScroll, "Auto Safe Place: OFF")
local autoSafeOn = false
local autoSafeTask = nil
local safeCFrame = CFrame.new(196.363358,150,-120.523453) -- Y=150 (10 studs higher)

autoSafeBtn.MouseButton1Click:Connect(function()
    autoSafeOn = not autoSafeOn
    autoSafeBtn.Text = autoSafeOn and "Auto Safe Place: ON" or "Auto Safe Place: OFF"

    if autoSafeOn then
        -- spawn a loop that checks every 0.1s
        autoSafeTask = task.spawn(function()
            while autoSafeOn do
                if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hum = player.Character:FindFirstChild("Humanoid")
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 and hum.Health < 40 then
                        if (root.Position - safeCFrame.Position).Magnitude > 5 then
                            -- teleport
                            root.CFrame = safeCFrame
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
        addSpawn(autoSafeTask)
    else
        autoSafeOn = false
    end
end)

-- NoClip (sets CanTouch = false for all BaseParts every 0.5s)
local noclipBtn = createButton(randomScroll, "NoClip: OFF")
local noclipOn = false
local noclipTaskRef = nil

noclipBtn.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    noclipBtn.Text = noclipOn and "NoClip: ON" or "NoClip: OFF"
    if noclipOn then
        noclipTaskRef = task.spawn(function()
            while noclipOn do
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        pcall(function() obj.CanTouch = false end)
                    end
                end
                task.wait(0.5)
            end
        end)
        addSpawn(noclipTaskRef)
    else
        noclipOn = false
    end
end)


-- Fly 
local flyBtn = createButton(randomScroll, "Fly: OFF (YOU CAN BE BANNED)")
flyBtn.TextColor3 = Color3.fromRGB(255,50,50)
flyBtn.MouseButton1Click:Connect(function()
    -- intentionally left blank: disabled by author
end)

-- VIP 
local vipBtn = createButton(randomScroll, "VIP: OFF", true)
local vipOn = false
vipBtn.MouseButton1Click:Connect(function()
    vipOn = not vipOn
    if vipOn then
        player:SetAttribute("__OwnsVIPGamepass", true)
        vipBtn.Text = "VIP: ON"
    else
        player:SetAttribute("__OwnsVIPGamepass", false)
        vipBtn.Text = "VIP: OFF"
    end
end)

-- CANDY ESP BUTTON (Random Features Section)
local candyESPEnabled = false
local candyESPBtn = Instance.new("TextButton", randomScroll)
candyESPBtn.Size = UDim2.new(1, -10, 0, 30)
candyESPBtn.Position = UDim2.new(0, 5, 0, 420)
candyESPBtn.Text = "Candy ESP: OFF"
candyESPBtn.Font = Enum.Font.SourceSansBold
candyESPBtn.TextSize = 18
candyESPBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
candyESPBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", candyESPBtn).CornerRadius = UDim.new(0, 6)

-- Store active ESPs
local activeCandyESP = {}

-- Create ESP above a model
local function createCandyESP(model)
	if not model or model:FindFirstChild("CandyESP") then return end

	-- Find a part inside the model to attach ESP
	local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not part then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CandyESP"
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 100, 0, 25)
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.Adornee = part
	billboard.Parent = model

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "🍬 Candy"
	label.TextColor3 = Color3.fromRGB(255, 128, 0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.Parent = billboard

	table.insert(activeCandyESP, billboard)
end

-- Remove all candy ESPs
local function clearCandyESP()
	for _, esp in ipairs(activeCandyESP) do
		if esp and esp.Parent then
			esp:Destroy()
		end
	end
	activeCandyESP = {}
end

-- Scan workspace.Effects for Candy models
local function scanCandies()
	if not workspace:FindFirstChild("Effects") then return end
	for _, obj in ipairs(workspace.Effects:GetDescendants()) do
		if obj:IsA("Model") and (obj.Name == "Candy1" or obj.Name == "Candy2" or obj.Name == "Candy3" or obj.Name == "Candy4") then
			createCandyESP(obj)
		end
	end
end

-- Toggle button
candyESPBtn.MouseButton1Click:Connect(function()
	candyESPEnabled = not candyESPEnabled
	if candyESPEnabled then
		candyESPBtn.Text = "Candy ESP: ON"
		task.spawn(function()
			while candyESPEnabled do
				clearCandyESP()
				scanCandies()
				task.wait(1) -- refresh every second
			end
		end)
	else
		candyESPBtn.Text = "Candy ESP: OFF"
		clearCandyESP()
	end
end)


-- Speed Controller
local speedLabel = Instance.new("TextLabel", randomScroll)
speedLabel.Size = UDim2.new(1,-10,0,25)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.TextSize = 20
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Text = "Custom Speed"

local speedFrame = Instance.new("Frame", randomScroll)
speedFrame.Size = UDim2.new(1,-10,0,30)
speedFrame.BackgroundTransparency = 1

local speedBox = Instance.new("TextBox", speedFrame)
speedBox.Size = UDim2.new(0.7, -5, 1, 0)
speedBox.Position = UDim2.new(0, 0, 0, 0)
speedBox.PlaceholderText = "Enter Speed (1-100)"
speedBox.Text = ""
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,6)

local setSpeedBtn = Instance.new("TextButton", speedFrame)
setSpeedBtn.Size = UDim2.new(0.3, -5, 1, 0)
setSpeedBtn.Position = UDim2.new(0.7, 5, 0, 0)
setSpeedBtn.Text = "Set"
setSpeedBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
setSpeedBtn.TextColor3 = Color3.new(1,1,1)
setSpeedBtn.Font = Enum.Font.SourceSansBold
setSpeedBtn.TextSize = 18
Instance.new("UICorner", setSpeedBtn).CornerRadius = UDim.new(0,6)

local speedLoop

setSpeedBtn.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)
	if value and value >= 1 and value <= 100 then
		if speedLoop then
			task.cancel(speedLoop)
		end
		speedLoop = task.spawn(function()
			while true do
				if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
					player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
				end
				task.wait(0.5)
			end
		end)
		setSpeedBtn.Text = "Set!"
		task.wait(1)
		setSpeedBtn.Text = "Set"
	else
		setSpeedBtn.Text = "Invalid"
		task.wait(1)
		setSpeedBtn.Text = "Set"
	end
end)


-- Custom Level
local levelLabel = Instance.new("TextLabel", randomScroll)
levelLabel.Size = UDim2.new(1,-10,0,25)
levelLabel.BackgroundTransparency = 1
levelLabel.Font = Enum.Font.SourceSansBold
levelLabel.TextSize = 20
levelLabel.TextColor3 = Color3.new(1,1,1)
levelLabel.TextXAlignment = Enum.TextXAlignment.Left
levelLabel.Text = "Custom Level"

-- Input Frame
local levelFrame = Instance.new("Frame", randomScroll)
levelFrame.Size = UDim2.new(1,-10,0,30)
levelFrame.BackgroundTransparency = 1

-- Input Box
local levelBox = Instance.new("TextBox", levelFrame)
levelBox.Size = UDim2.new(0.7, -5, 1, 0)
levelBox.Position = UDim2.new(0, 0, 0, 0)
levelBox.PlaceholderText = "Enter Level Number"
levelBox.Text = ""
levelBox.TextColor3 = Color3.new(1,1,1)
levelBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", levelBox).CornerRadius = UDim.new(0,6)

-- Set Button
local setLevelBtn = Instance.new("TextButton", levelFrame)
setLevelBtn.Size = UDim2.new(0.3, -5, 1, 0)
setLevelBtn.Position = UDim2.new(0.7, 5, 0, 0)
setLevelBtn.Text = "Set"
setLevelBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
setLevelBtn.TextColor3 = Color3.new(1,1,1)
setLevelBtn.Font = Enum.Font.SourceSansBold
setLevelBtn.TextSize = 18
Instance.new("UICorner", setLevelBtn).CornerRadius = UDim.new(0,6)

-- Functionality
setLevelBtn.MouseButton1Click:Connect(function()
	local value = tonumber(levelBox.Text)
	if value then
		player:SetAttribute("_CurrentLevel", value)
		setLevelBtn.Text = "Set!"
		task.wait(1)
		setLevelBtn.Text = "Set"
	else
		setLevelBtn.Text = "Invalid"
		task.wait(1)
		setLevelBtn.Text = "Set"
	end
end)


-- Custom Win
local winLabel = Instance.new("TextLabel", randomScroll)
winLabel.Size = UDim2.new(1,-10,0,25)
winLabel.BackgroundTransparency = 1
winLabel.Font = Enum.Font.SourceSansBold
winLabel.TextSize = 20
winLabel.TextColor3 = Color3.new(1,1,1)
winLabel.TextXAlignment = Enum.TextXAlignment.Left
winLabel.Text = "Custom Win"

-- Input Frame
local winFrame = Instance.new("Frame", randomScroll)
winFrame.Size = UDim2.new(1,-10,0,30)
winFrame.BackgroundTransparency = 1

-- Input Box
local winBox = Instance.new("TextBox", winFrame)
winBox.Size = UDim2.new(0.7, -5, 1, 0)
winBox.Position = UDim2.new(0, 0, 0, 0)
winBox.PlaceholderText = "Enter Win Number"
winBox.Text = ""
winBox.TextColor3 = Color3.new(1,1,1)
winBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", winBox).CornerRadius = UDim.new(0,6)

-- Set Button
local setWinBtn = Instance.new("TextButton", winFrame)
setWinBtn.Size = UDim2.new(0.3, -5, 1, 0)
setWinBtn.Position = UDim2.new(0.7, 5, 0, 0)
setWinBtn.Text = "Set"
setWinBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
setWinBtn.TextColor3 = Color3.new(1,1,1)
setWinBtn.Font = Enum.Font.SourceSansBold
setWinBtn.TextSize = 18
Instance.new("UICorner", setWinBtn).CornerRadius = UDim.new(0,6)

-- Functionality
setWinBtn.MouseButton1Click:Connect(function()
	local value = tonumber(winBox.Text)
	if value then
		player:SetAttribute("_GameWins", value)
		setWinBtn.Text = "Set!"
		task.wait(1)
		setWinBtn.Text = "Set"
	else
		setWinBtn.Text = "Invalid"
		task.wait(1)
		setWinBtn.Text = "Set"
	end
end)




-- -------------------
-- GAMES 
-- -------------------

-- RLGL 
local rlglHeader = Instance.new("TextLabel", gamesScroll)
rlglHeader.Size = UDim2.new(1,-10,0,22)
rlglHeader.BackgroundTransparency = 1
rlglHeader.Font = Enum.Font.SourceSansBold
rlglHeader.TextSize = 18
rlglHeader.TextColor3 = Color3.new(1,1,1)
rlglHeader.TextXAlignment = Enum.TextXAlignment.Left
rlglHeader.Text = "RLGL"

local rlglBtn = createButton(gamesScroll, "Teleport to End")
rlglBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-43.7126923,1021.32306,134.34935)
    end
end)

local rlglBtn2 = createButton(gamesScroll, "Teleport to End 2")
rlglBtn2.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-48.9779892,1148.20386,210.683594)
    end
end)


-- 🔹 Disable Injury Button (RLGL Section)
local disableInjury = Instance.new("TextButton")
disableInjury.Parent = gamesScroll -- ✅ Make sure RLGL features are parented here
disableInjury.Size = UDim2.new(1, -10, 0, 30)
disableInjury.Position = UDim2.new(0, 5, 0, 0)
disableInjury.BackgroundColor3 = Color3.fromRGB(70,70,70)
disableInjury.TextColor3 = Color3.new(1,1,1)
disableInjury.Font = Enum.Font.SourceSansBold
disableInjury.TextSize = 18
disableInjury.Text = "Disable Injury : OFF"
Instance.new("UICorner", disableInjury).CornerRadius = UDim.new(0,6)

-- 🔹 Variables
local injuryDisabled = false
local storedFolders = {}

-- 🔹 Click Function
disableInjury.MouseButton1Click:Connect(function()
	local player = game.Players.LocalPlayer
	local charModel = workspace:FindFirstChild("Live") and workspace.Live:FindFirstChild(player.Name)
	
	if not charModel then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Leliks Script",
			Text = "Character not found in Live.",
			Duration = 3
		})
		return
	end
	
	local targetFolders = {"InjuredWalking", "Stun"} -- ✅ Only these two

	if not injuryDisabled then
		-- Turn ON (Disable)
		for _, folderName in ipairs(targetFolders) do
			local target = charModel:FindFirstChild(folderName, true)
			if target then
				local clone = target:Clone()
				storedFolders[folderName] = clone
				target:Destroy()
			end
		end

		if next(storedFolders) then
			disableInjury.Text = "Disable Injury : ON"
			injuryDisabled = true
		else
			game.StarterGui:SetCore("SendNotification", {
				Title = "Leliks Script",
				Text = "You Not Injury.",
				Duration = 3
			})
		end

	else
		-- Turn OFF (Re-enable)
		for name, clone in pairs(storedFolders) do
			if clone and not charModel:FindFirstChild(name, true) then
				clone.Parent = charModel
			end
		end
		storedFolders = {}
		disableInjury.Text = "Disable Injury : OFF"
		injuryDisabled = false
	end
end)




-- Dalgona
local dalHeader = Instance.new("TextLabel", gamesScroll)
dalHeader.Size = UDim2.new(1,-10,0,22)
dalHeader.BackgroundTransparency = 1
dalHeader.Font = Enum.Font.SourceSansBold
dalHeader.TextSize = 18
dalHeader.TextColor3 = Color3.new(1,1,1)
dalHeader.TextXAlignment = Enum.TextXAlignment.Left
dalHeader.Text = "DALGONA"

local lighterBtn = createButton(gamesScroll, "Toggle Lighter")
lighterBtn.MouseButton1Click:Connect(function()
    player:SetAttribute("HasLighter", not player:GetAttribute("HasLighter"))
end)

-- Lights Off 
local lightsHeader = Instance.new("TextLabel", gamesScroll)
lightsHeader.Size = UDim2.new(1,-10,0,22)
lightsHeader.BackgroundTransparency = 1
lightsHeader.Font = Enum.Font.SourceSansBold
lightsHeader.TextSize = 18
lightsHeader.TextColor3 = Color3.new(1,1,1)
lightsHeader.TextXAlignment = Enum.TextXAlignment.Left
lightsHeader.Text = "LIGHTS OFF"

local safeBtn = createButton(gamesScroll, "Safe Place")
safeBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(196.363358,140,-120.523453) -- safe place (y=140 teleport)
    end
end)

-- Hide and Seek 
local hsHeader = Instance.new("TextLabel", gamesScroll)
hsHeader.Size = UDim2.new(1,-10,0,22)
hsHeader.BackgroundTransparency = 1
hsHeader.Font = Enum.Font.SourceSansBold
hsHeader.TextSize = 18
hsHeader.TextColor3 = Color3.new(1,1,1)
hsHeader.TextXAlignment = Enum.TextXAlignment.Left
hsHeader.Text = "HIDE AND SEEK"

-- Delete Spikes 
local delSpikesBtn = createButton(gamesScroll, "Delete Spikes")
delSpikesBtn.MouseButton1Click:Connect(function()
    for _,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == "KillingParts" then
            pcall(function() v:Destroy() end)
        end
    end
end)

-- Teleport to Lobby
local tpLobbyBtn = createButton(gamesScroll, "Teleport to Lobby")
tpLobbyBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(194.967804,54.4803085,-98.172905)
    end
end)

-- Hide & Seek ESP 
local hsEspBtn = createButton(gamesScroll, "Hide and Seek ESP: OFF")
local hsEspOn = false
local hsRefreshConn = nil

local function updateHideSeekESP()
    local anyHasKeys = false
    for _,plr in pairs(Players:GetPlayers()) do
        if plr:FindFirstChild("CurrentKeys") then
            anyHasKeys = true
            break
        end
    end

    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local old = plr.Character:FindFirstChild("HideSeekESP")
            if old then old:Destroy() end
        end

        if hsEspOn and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local gui = Instance.new("BillboardGui", plr.Character)
            gui.Name = "HideSeekESP"
            gui.Adornee = plr.Character.HumanoidRootPart
            gui.Size = UDim2.new(0,200,0,50)
            gui.AlwaysOnTop = true
            local lbl = Instance.new("TextLabel", gui)
            lbl.Size = UDim2.new(1,0,1,0)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextScaled = true

            if not anyHasKeys then
                lbl.Text = plr.Name .. " (Unknown)"
                lbl.TextColor3 = Color3.fromRGB(255,255,0)
            else
                if plr:FindFirstChild("CurrentKeys") then
                    lbl.Text = plr.Name .. " (Hider)"
                    lbl.TextColor3 = Color3.fromRGB(0,170,255)
                else
                    lbl.Text = plr.Name .. " (Seeker)"
                    lbl.TextColor3 = Color3.fromRGB(255,0,0)
                end
            end
        end
    end
end

hsEspBtn.MouseButton1Click:Connect(function()
    hsEspOn = not hsEspOn
    hsEspBtn.Text = hsEspOn and "Hide and Seek ESP: ON" or "Hide and Seek ESP: OFF"
    -- update once immediately
    updateHideSeekESP()
    -- start/stop periodic updater
    if hsEspOn then
        if not hsRefreshConn then
            hsRefreshConn = RunService.Heartbeat:Connect(function()
                updateHideSeekESP()
            end)
            addConnection(hsRefreshConn)
        end
    else
        if hsRefreshConn then
            pcall(function() hsRefreshConn:Disconnect() end)
            hsRefreshConn = nil
        end
        -- clear existing ESPs
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HideSeekESP") then
                pcall(function() plr.Character.HideSeekESP:Destroy() end)
            end
        end
    end
end)

-- also update on player joins / character spawns
addConnection(Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function() task.wait(0.6); if hsEspOn then updateHideSeekESP() end end)
end))
for _,plr in pairs(Players:GetPlayers()) do
    plr.CharacterAdded:Connect(function() task.wait(0.6); if hsEspOn then updateHideSeekESP() end end)
end

-- EXIT ESP (NEW)
local exitEspBtn = createButton(gamesScroll, "Exit ESP: OFF")
local exitEspOn = false

exitEspBtn.MouseButton1Click:Connect(function()
	exitEspOn = not exitEspOn
	exitEspBtn.Text = exitEspOn and "Exit ESP: ON" or "Exit ESP: OFF"

	-- Remove old ESPs
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BillboardGui") and v.Name == "ExitESP" then
			v:Destroy()
		end
	end

	if exitEspOn then
		-- Loop over Floors
		for i = 1, 3 do
			local floorPath = workspace:FindFirstChild("HideAndSeekMap") and
				workspace.HideAndSeekMap:FindFirstChild("NEWFIXEDDOORS") and
				workspace.HideAndSeekMap.NEWFIXEDDOORS:FindFirstChild("Floor"..i)

			if floorPath and floorPath:FindFirstChild("EXITDOORS") then
				for _, door in pairs(floorPath.EXITDOORS:GetChildren()) do
					if door:IsA("Model") and door:FindFirstChild("MainDoor") then
						local gui = Instance.new("BillboardGui")
						gui.Name = "ExitESP"
						gui.Adornee = door.MainDoor
						gui.Size = UDim2.new(0,200,0,50)
						gui.AlwaysOnTop = true
						local text = Instance.new("TextLabel", gui)
						text.Size = UDim2.new(1,0,1,0)
						text.BackgroundTransparency = 1
						text.Text = "EXIT"
						text.TextColor3 = Color3.fromRGB(255, 255, 0)
						text.Font = Enum.Font.SourceSansBold
						text.TextScaled = true
						gui.Parent = door
					end
				end
			end
		end

		-- Also show blocked doors
		local blockedFolder = workspace.HideAndSeekMap:FindFirstChild("DoorsIsBlocked")
		if blockedFolder then
			for _, part in pairs(blockedFolder:GetChildren()) do
				if part:IsA("BasePart") then
					local gui = Instance.new("BillboardGui")
					gui.Name = "ExitESP"
					gui.Adornee = part
					gui.Size = UDim2.new(0,200,0,50)
					gui.AlwaysOnTop = true
					local text = Instance.new("TextLabel", gui)
					text.Size = UDim2.new(1,0,1,0)
					text.BackgroundTransparency = 1
					text.Text = "BLOCKED"
					text.TextColor3 = Color3.fromRGB(0, 0, 0)
					text.Font = Enum.Font.SourceSansBold
					text.TextScaled = true
					gui.Parent = part
				end
			end
		end
	end
end)

-- Blocked Exits ESP
local blockedEspBtn = createButton(scroll,"Blocked Exits ESP: OFF")
local blockedEspOn = false

blockedEspBtn.MouseButton1Click:Connect(function()
	blockedEspOn = not blockedEspOn
	blockedEspBtn.Text = blockedEspOn and "Blocked Exits ESP: ON" or "Blocked Exits ESP: OFF"

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "DoorsIsBlocked" then
			if obj:FindFirstChild("BlockedESP") then
				obj.BlockedESP:Destroy()
			end
			if blockedEspOn then
				local gui = Instance.new("BillboardGui", obj)
				gui.Name = "BlockedESP"
				gui.Adornee = obj
				gui.Size = UDim2.new(0,200,0,50)
				gui.AlwaysOnTop = true
				local lbl = Instance.new("TextLabel", gui)
				lbl.Size = UDim2.new(1,0,1,0)
				lbl.BackgroundTransparency = 1
				lbl.Font = Enum.Font.SourceSansBold
				lbl.Text = "Blocked Exit Door"
				lbl.TextColor3 = Color3.new(0,0,0)
				lbl.TextScaled = true
			end
		end
	end
end)

-- KEY ESP BUTTON (Hide and Seek Section)
local keyESPEnabled = false
local keyESPBtn = Instance.new("TextButton", gamesScroll)
keyESPBtn.Size = UDim2.new(1, -10, 0, 30)
keyESPBtn.Position = UDim2.new(0, 5, 0, 240) -- diğer butonlara göre ayarlayabilirsin
keyESPBtn.Text = "Key ESP: OFF"
keyESPBtn.Font = Enum.Font.SourceSansBold
keyESPBtn.TextSize = 18
keyESPBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", keyESPBtn).CornerRadius = UDim.new(0, 6)

-- Store active ESPs
local activeKeyESP = {}

-- Function to add ESP
local function addESP(part)
	if not part or not part:IsA("BasePart") then return end
	local billboard = Instance.new("BillboardGui", part)
	billboard.Name = "KeyESP"
	billboard.Size = UDim2.new(0, 100, 0, 25)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, 2, 0)

	local label = Instance.new("TextLabel", billboard)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "KEY"
	label.TextColor3 = Color3.fromRGB(255, 140, 0) -- Orange
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true

	table.insert(activeKeyESP, billboard)
end

-- Function to clear ESPs
local function clearKeyESP()
	for _, esp in ipairs(activeKeyESP) do
		if esp and esp.Parent then
			esp:Destroy()
		end
	end
	activeKeyESP = {}
end

-- Toggle Key ESP
keyESPBtn.MouseButton1Click:Connect(function()
	keyESPEnabled = not keyESPEnabled
	if keyESPEnabled then
		keyESPBtn.Text = "Key ESP: ON"
		task.spawn(function()
			while keyESPEnabled do
				clearKeyESP()
				local effects = workspace:FindFirstChild("Effects")
				if effects then
					for _, obj in ipairs(effects:GetChildren()) do
						if obj:IsA("BasePart") and (obj.Name == "DroppedKeyTriangle" or obj.Name == "DroppedKeyCircle" or obj.Name == "DroppedKeySquare") then
							addESP(obj)
						end
					end
				end
				task.wait(1)
			end
		end)
	else
		keyESPBtn.Text = "Key ESP: OFF"
		clearKeyESP()
	end
end)


-- Jump Rope 
local jrHeader = Instance.new("TextLabel", gamesScroll)
jrHeader.Size = UDim2.new(1,-10,0,22)
jrHeader.BackgroundTransparency = 1
jrHeader.Font = Enum.Font.SourceSansBold
jrHeader.TextSize = 18
jrHeader.TextColor3 = Color3.new(1,1,1)
jrHeader.TextXAlignment = Enum.TextXAlignment.Left
jrHeader.Text = "JUMP ROPE"

local jrBtn = createButton(gamesScroll, "Teleport to End")
jrBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(737.156372,198.805084,920.952515)
    end
end)

-- Bypass Rope
local bypassBtn = createButton(gamesScroll, "Bypass Rope: OFF")
local ropeHidden = false
local ropeBackup = nil

bypassBtn.MouseButton1Click:Connect(function()
    local jr = Workspace:FindFirstChild("JumpRope")
    if not jr then return end
    local important = jr:FindFirstChild("Important")
    if not important then return end
    local rope = important:FindFirstChild("rope")
    if rope and not ropeHidden then
        ropeBackup = rope:Clone()
        rope:Destroy()
        ropeHidden = true
        bypassBtn.Text = "Bypass Rope: ON"
    elseif ropeHidden then
        if ropeBackup then
            ropeBackup.Parent = important
            ropeBackup = nil
        end
        ropeHidden = false
        bypassBtn.Text = "Bypass Rope: OFF"
    end
end)

-- Bypass Rope 2 
local bypass2Btn = createButton(gamesScroll, "Bypass Rope 2 : OFF")
bypass2Btn.MouseButton1Click:Connect(function()
    local eff = Workspace:FindFirstChild("Effects")
    if eff and eff:FindFirstChild("rope") then
        pcall(function() eff.rope:Destroy() end)
        bypass2Btn.Text = "Rope deleted"
        task.delay(2, function() bypass2Btn.Text = "Bypass Rope 2 : ON" end)
    else
        bypass2Btn.Text = "Rope not found"
        task.delay(2, function() bypass2Btn.Text = "Bypass Rope 2 : OFF" end)
    end
end)

-- Glass Bridge 
local gbHeader = Instance.new("TextLabel", gamesScroll)
gbHeader.Size = UDim2.new(1,-10,0,22)
gbHeader.BackgroundTransparency = 1
gbHeader.Font = Enum.Font.SourceSansBold
gbHeader.TextSize = 18
gbHeader.TextColor3 = Color3.new(1,1,1)
gbHeader.TextXAlignment = Enum.TextXAlignment.Left
gbHeader.Text = "GLASS BRIDGE"

local gbBtn = createButton(gamesScroll, "Teleport to End")
gbBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-211.855881,522.039062,-1534.7373)
    end
end)

-- Sky Squid Game Anti-Fall
local skyHeader = Instance.new("TextLabel", gamesScroll)
skyHeader.Size = UDim2.new(1,-10,0,22)
skyHeader.BackgroundTransparency = 1
skyHeader.Font = Enum.Font.SourceSansBold
skyHeader.TextSize = 18
skyHeader.TextColor3 = Color3.new(1,1,1)
skyHeader.TextXAlignment = Enum.TextXAlignment.Left
skyHeader.Text = "SKY SQUID GAME"

local antiBtn = createButton(gamesScroll, "Anti-Fall: OFF")
local antiOn = false
local antiPart = nil
antiBtn.MouseButton1Click:Connect(function()
    antiOn = not antiOn
    if antiOn then
        antiBtn.Text = "Anti-Fall: ON"
        antiPart = Instance.new("Part", Workspace)
        antiPart.Name = "AntiFallPlatform"
        antiPart.Size = Vector3.new(1000,2,1000)
        antiPart.Position = Vector3.new(12.5000076,960,-7.43575716) -- Y=960
        antiPart.Anchored = true
        antiPart.Transparency = 0.5
        antiPart.Color = Color3.fromRGB(0,255,0)
    else
        antiBtn.Text = "Anti-Fall: OFF"
        if antiPart then pcall(function() antiPart:Destroy() end) end
        antiPart = nil
    end
end)

-- Hitbox Hack Sky Squid
local hitboxhackskyBtn = createButton(gamesScroll, "Hitbox Hack")
hitboxhackskyBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        local originalSize = root.Size
        root.Size = Vector3.new(20,20,20)
        task.delay(5, function()
            if root and root.Parent then
                root.Size = originalSize
            end
        end)
    end
end)

-------------------
-- KEYBINDS
-------------------
local keyBindBtn = createButton(keybindsScroll,"Change Toggle Key (Current: X)")
keyBindBtn.MouseButton1Click:Connect(function()
    keyBindBtn.Text = "Press a key..."
    local conn
    conn = UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            toggleKey = input.KeyCode
            keyBindBtn.Text = "Change Toggle Key (Current: "..input.KeyCode.Name..")"
            conn:Disconnect()
        end
    end)
end)

--------------------
-- SETTINGS
--------------------
--button
local set1Btn = createButton(settingsScroll, "Change Theme")

-- color loop
local themeColors = {
    Color3.fromRGB(135, 206, 235), -- Gök mavisi
    Color3.fromRGB(255, 105, 180), -- Pembe
    Color3.fromRBG(255, 0, 0), -- Kırmızı
    Color3.fromRGB(20, 20, 20)     -- Orijinal renk
}

-- first color
local currentTheme = 1

-- click 
set1Btn.MouseButton1Click:Connect(function()
    -- other color
    currentTheme = currentTheme + 1
    if currentTheme > #themeColors then
        currentTheme = 1
    end

    -- set color
    mainFrame.BackgroundColor3 = themeColors[currentTheme]
end)

print("Leliks Script Loaded")




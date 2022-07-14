local plr = game.Players.LocalPlayer
local Hum = plr.Character.Humanoid
local plrParts = plr.Character:GetChildren()
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local HumanoidRootPart = plr.Character.HumanoidRootPart

local function align(P0, P1, Position, Rotation)
	local AlignPosition = Instance.new("AlignPosition", P0)
	AlignPosition.RigidityEnabled = true

	local AlignOrientation = Instance.new("AlignOrientation", P0)
	AlignOrientation.RigidityEnabled = true

	local Att0 = Instance.new("Attachment", P0)

	local Att1 = Instance.new("Attachment", P1)
	Att1.Position = Position or Vector3.new(0, 0, 0)
	Att1.Rotation = Rotation or Vector3.new(0, 0, 0)

	AlignPosition.Attachment0 = Att0
	AlignPosition.Attachment1 = Att1

	AlignOrientation.Attachment0 = Att0
	AlignOrientation.Attachment1 = Att1
end

local function alignPosition(P0, P1)
	local AlignPosition = Instance.new("AlignPosition", P0)
	AlignPosition.RigidityEnabled = true

	local Att0 = Instance.new("Attachment", P0)

	local Att1 = Instance.new("Attachment", P1)

	AlignPosition.Attachment0 = Att0
	AlignPosition.Attachment1 = Att1
end

plr.Character.Archivable = true

local Reanim = plr.Character:Clone()
Reanim.Parent = plr.Character
Reanim.Name = "reanim"

for i, v in pairs(Reanim:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
		if v.Name == "Head" then
			v.face:Destroy()
		end
	elseif v:IsA("Accessory") then
		v.Handle.Transparency = 1
	end
end

RunService.Stepped:Connect(function()
	plr.Character.Humanoid.Died:Connect(function()
		return
	end)
	for i, v in pairs(plrParts) do
		if v:IsA("BasePart") then
			if v.Name ~= "HumanoidRootPart" then
				if v.Name ~= "Left Arm" or "Right Arm" then
					if v.Name ~= "Left Leg" or "Right Leg" then
						v.CanCollide = false
					end
				end
			end
		end
	end
end)

plr.Character.Torso["Right Shoulder"]:Destroy()
plr.Character.Torso["Left Shoulder"]:Destroy()
plr.Character.Torso["Right Hip"]:Destroy()
plr.Character.Torso["Left Hip"]:Destroy()

HumanoidRootPart:Destroy()

local function InstantAlign(P0)
	align(plr.Character[P0], Reanim[P0])
end

local function InstantAlignHat(P0)
	align(plr.Character[P0].Handle, Reanim[P0].Handle)
end

for i, v in pairs(plrParts) do
	if v:IsA("BasePart") then
		if v.Name ~= "HumanoidRootPart" then
			InstantAlign(v.Name)
		end
	elseif v:IsA("Accessory") then
		v.Handle.AccessoryWeld:Remove()
		InstantAlignHat(v.Name)
	end
end

print("notification")
StarterGui:SetCore("SendNotification", {Title = "Reanimation"; Text = "Successfully reanimated!"; Duration = 5;})

RunService.Heartbeat:Connect(function()
	for i, v in pairs(plrParts) do
		if v:IsA("BasePart") then
			v.Velocity = _G.Velocity
		elseif v:IsA("Accessory") then
			pcall(function()
				v.Handle.Velocity = _G.Velocity
			end)
		end
	end
end)

plr.Character = Reanim
plr.Character.Humanoid.Died:Connect(function()
	plr.Character = game.Workspace[plr.Name]
	Reanim:Destroy()
	plr.Character.Humanoid.Health = 0
end)

workspace:FindFirstChildOfClass("Camera").CameraSubject = Reanim.Humanoid

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/QuakADoodles/Mortem-Metallum-Hub-V2.0/master/UI-Library-Source.lua"))()
local runService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local char = plr.Character

local animIds = {
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5435382827";
    "rbxassetid://5435969402";
    "rbxassetid://5431979188";
    "rbxassetid://5416575259";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5435382827";
    "rbxassetid://5416575259";
    "rbxassetid://5424166879";
    "rbxassetid://5416575259";
    "rbxassetid://5436059670";
    "rbxassetid://5436083192";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5416575259";
    "rbxassetid://3016814540";
    "rbxassetid://3016734456";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5416575259";
    "rbxassetid://5431979188";
    "rbxassetid://5416575259";
    "rbxassetid://4061495031";
    "rbxassetid://5431979188";
    "rbxassetid://5435928313";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5416575259";
    "rbxassetid://5435382827";
    "rbxassetid://5416575259";
    "rbxassetid://5642769282";
    "rbxassetid://5642777160";
    "rbxassetid://5431979188";
    "rbxassetid://5416575259";
    "rbxassetid://5416575259";
    "rbxassetid://5428613396";
    "rbxassetid://5428578390";
    "rbxassetid://5705126205";
    "rbxassetid://5705174594";
    "rbxassetid://5705254261";
}

-- Settings Vars
local SetWalk = 25
local parryDist = 15
local td_tele = 15
local t_dist = 10

function WalkspeedSet (enabled)
    pcall(function()
        if enabled then
            --print("enabled")
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(SetWalk)
        end
    end)
end

local UI = Material.Load({
     Title = "Mortem Metallum Hub DEMO",
     Style = 3,
     SizeX = 300,
     SizeY = 400,
     Theme = "Dark"
})

local Home = UI.New({
    Title = "Home"
})

local TogglesPage = UI.New({
    Title = "Toggles"
})

local OptionPage = UI.New({
    Title = "Options"
})

-- Home page
Home.Button({
    Text = "Made by QuackADoodles#0001",
    Callback = function()
       --print("Clicked!") 
    end
})

Home.Button({
    Text = "You are using the premium version!",
    Callback = function()
        -- lol
    end
})

--[[--------------------------------------------------------------------------------------------]]

local Toggle1 = TogglesPage.Toggle({
    Text = "Auto Parry",
    Callback = function(value)
        -- ye
    end,
    Enabled = false
})

local Toggle2 = TogglesPage.Toggle({
    Text = "Anti Hit",
    Callback = function(value)
        -- ye
    end,
    Enabled = false
})

local Toggle4 = TogglesPage.Toggle({
    Text = "Walkspeed",
    Callback = function(value)
        print(value)
    end,
    Enabled = false
})

--[[--------------------------------------------------------------------------------------------]]


-- Options Page
local AP_t_D = OptionPage.Slider({
    Text = "AutoParry Trigger Distance",
    Callback = function(value)
        parryDist = value
    end,
    Min = 0,
    Max = 50,
    Def = parryDist
})
local AH_Dist = OptionPage.Slider({
    Text = "AntiHit Teleport Distance",
    Callback = function(value)
        t_dist = value
    end,
    Min = 0,
    Max = 50,
    Def = t_dist
})

local AH_Dist = OptionPage.Slider({
    Text = "AntiHit Trigger Distance",
    Callback = function(value)
        td_tele = value
    end,
    Min = 0,
    Max = 50,
    Def = td_tele
})

local WL_t_D = OptionPage.Slider({
    Text = "Walkspeed",
    Callback = function(value)
        SetWalk = value
        --print(SetWalk)
    end,
    Min = 0,
    Max = 100,
    Def = SetWalk
})

-- Main Script
spawn(function()
    while true do
        WalkspeedSet(Toggle4:GetState()) 
        wait(0.1)
    end
end)

function MoveBack(x)
    --local vector = char.HumanoidRootPart.Orientation
	--[[for i = 1, 10 do --A loop to make your character face the aggressor, as parrying doesn't protect your rear
		char.HumanoidRootPart.CFrame = char:SetPrimaryPartCFrame(CFrame.new(char.HumanoidRootPart.Position, plrChar.HumanoidRootPart.Position)) 
		wait()
	end]]
	char:SetPrimaryPartCFrame(CFrame.new(char.HumanoidRootPart.Position - char.HumanoidRootPart.CFrame.LookVector.Unit * x))
end

function getParryEvent()
	for i, v in next, char:GetDescendants() do
		if v:IsA("RemoteEvent") and v.Name == "ability" then
			return v
		end
	end
	return nil
end

function parry()
	local myParryEvent = getParryEvent()
	if myParryEvent then
		myParryEvent:FireServer()
	end
end
-- Main loop
spawn(function()
	while true do
		pcall(function()
			char = plr.Character
			runService.RenderStepped:Wait()
			for i, plrChar in next, workspace.PlayersCharacters:GetChildren() do
				if plrChar ~= char then
					local anims = plrChar.Humanoid:GetPlayingAnimationTracks()
					for _, anim in next, anims do
                        if table.find(animIds, anim.Animation.AnimationId) then
                            if Toggle1:GetState() then
                                if (plrChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude <= parryDist and plrChar.Humanoid.Health > 0 and not plrChar.Humanoid.PlatformStand then
								    parry()
							    end
                            end

                            if Toggle2:GetState() then
                                if (plrChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude <= td_tele and plrChar.Humanoid.Health > 0 and not plrChar.Humanoid.PlatformStand then
								    MoveBack(t_dist)
							    end
                            end

							wait(0.3) --Prevents mass event firing
						end
					end
				end	
			end
		end)
	end
end)

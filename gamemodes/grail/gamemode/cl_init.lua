include("shared.lua")

function GM:Initialize()
    if self.BaseClass and self.BaseClass.Initialize then
        self.BaseClass.Initialize(self)
    end

    print("[GRail] Client gamemode initialized")
end

hook.Add("InitPostEntity", "GRail_Ready", function()
    chat.AddText(Color(0, 255, 128), "GRail is active (derived from ZCity)!")
end)

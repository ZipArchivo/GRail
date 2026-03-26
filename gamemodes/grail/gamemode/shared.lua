GM.Name = "GRail"
GM.Author = "Zip"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("zcity")

-- players just spawn freely.
local function SetupGRailFreeRound()
    zb = zb or {}
    zb.modes = zb.modes or {}

    zb.modes.free = zb.modes.free or {
        name = "free",
        PrintName = "Free Play",
        start_time = 0,
        end_time = 0,
        ROUND_TIME = 0,
        CanSpawn = function() return true end,
        ShouldRoundEnd = function() return false end,
        RoundStart = function() end,
        RoundThink = function() end,
        EndRound = function() end,
        Intermission = function() end,
        GiveEquipment = function() end,
    }

    zb.CROUND = "free"
    zb.CROUND_MAIN = "free"
    zb.ROUND_STATE = 0
    if SERVER then
        zb.START_TIME = nil
        zb.END_TIME = nil
    end
end

-- so it runs on client and server 
hook.Add("InitPostEntity", "GRail_FreeRoundInit", SetupGRailFreeRound)

if SERVER then
    hook.Add("PlayerInitialSpawn", "GRail_FreeRoundInitPlayer", SetupGRailFreeRound)

    function zb:PreRound() end
    function zb:RoundThink() end
    function zb:EndRoundThink() end
    function zb:RoundStart() end
    function zb:EndRound() end
end

function GM:PlayerInitialSpawn(ply)
    -- force player spawn
    ply.initialspawn = nil
    ply:UnSpectate()
    ply:SetTeam(1)

    if self.BaseClass and self.BaseClass.PlayerInitialSpawn then
        self.BaseClass.PlayerInitialSpawn(self, ply)
    end

    ply:PrintMessage(HUD_PRINTTALK, "Welcome to GRail (derived from ZCity)!")
    ply:Spawn()
end

function GM:PlayerSpawn(ply)

    ply:SetTeam(1)
    ply:UnSpectate()
    ply:SetMoveType(MOVETYPE_WALK)

    ply:SetModel("models/player/kleiner.mdl")
    if ply:Alive() then
        ply:SetupHands()
    end

    if ply.SetObserverMode then
        ply:SetObserverMode(OBS_MODE_NONE)
    end
end

function GM:PlayerDeath(ply, inflictor, attacker)
    if IsValid(ply) then
        ply:UnSpectate()
        ply:SetTeam(1)
    end
end

function GM:PlayerDeathThink(ply)
    return true
end

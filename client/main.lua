local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local npcPed = 0

-- NPC Initialization
CreateThread(function()
    local npcModel = Config.NpcStart

    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(500)
    end

    local npcCoords = Config.JobStartLocation
    npcPed = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, 0.0, false, true)
    TaskStandStill(npcPed, -1)
    SetEntityAsMissionEntity(npcPed, true, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetEntityInvincible(npcPed, true)

    -- Add target entity for NPC
    exports[Config.Target]:AddTargetEntity(npcPed, {
        options = {
            {
                type = "client",
                event = "krs-pizzajob:client:StartJob",
                icon = 'fas fa-briefcase',
                label = 'Start Job',

            }
        },
        distance = 2.5,
    })
end)

-- Decor Registration Thread
CreateThread(function()
    DecorRegister("pizza_job", 1)
end)

-- Pizza Job Blip
CreateThread(function()
    local pizzajobBlip = AddBlipForCoord(vector3(Config.JobStartLocation.x, Config.JobStartLocation.y, Config.JobStartLocation.z)) 
    SetBlipSprite(pizzajobBlip, 267)
    SetBlipAsShortRange(pizzajobBlip, true)
    SetBlipScale(pizzajobBlip, 0.8)
    SetBlipColour(pizzajobBlip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pizza Job")
    EndTextCommandSetBlipName(pizzajobBlip)
end)

-- Event: Start Job
RegisterNetEvent('krs-pizzajob:client:StartJob', function()
    PullOutVehicle()
end)


-- Event: Notify
RegisterNetEvent('krs-pizzajob:client:notify', function (text, type)
    Notify(text, type)
end)


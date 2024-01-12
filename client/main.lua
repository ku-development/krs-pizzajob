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
                num = 1,
                type = "client",
                event = "krs-pizzajob:client:StartJob",
                icon = 'fas fa-briefcase',
                label = 'Start Job',
                targeticon = 'fas fa-briefcase',
                action = function(entity)
                    TriggerEvent('krs-pizzajob:client:StartJob')
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
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
    local vehicleModel = Config.JobVehicle

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(500)
    end

    local playerPed = PlayerPedId()
    local vehicle = CreateVehicle(vehicleModel, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)

    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    Wait(1000)

    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
    StartJob()
end)

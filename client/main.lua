local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local npcPed = 0




-- Threads
CreateThread(function()
    local npcModel = Config.NpcStart
    -- Request NPC model
    RequestModel(npcModel)

    -- Wait until the model is loaded
    while not HasModelLoaded(npcModel) do
    Wait(500)
    end

    -- Set NPC coordinates
    local npcCoords = Config.JobStartLocation

    -- Create NPC ped
    npcPed = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, 0.0, false, true)

    -- Make NPC stand still
    TaskStandStill(npcPed, -1)

    -- Set NPC as a mission entity
    SetEntityAsMissionEntity(npcPed, true, true)

    -- Block non-temporary events for NPC
    SetBlockingOfNonTemporaryEvents(npcPed, true)

    -- Make NPC invincible
    SetEntityInvincible(npcPed, true)

    -- Add target entity for NPC
    exports[Config.Target]:AddTargetEntity(npcPed, {
    options = {
        {
            num = 1,
            type = "client",
            event = "StartJob:Event",  -- Replace with your actual event name
            icon = 'fas fa-briefcase',  -- Replace with your desired icon
            label = 'Start Job',  -- Replace with your desired label
            targeticon = 'fas fa-briefcase',  -- Replace with your desired target icon
            action = function(entity)
                -- Implement the logic to start the job here
                TriggerEvent('krs-pizzajob:client:StartJob')
            end,
            canInteract = function(entity, distance, data)
                -- Add any additional conditions for interaction here
                return true
            end,
        }
    },
    distance = 2.5,
    })
end)

-- Events
RegisterNetEvent('krs-pizzajob:client:StartJob', function()
   -- Get job vehicle model from config
   local vehicleModel = Config.JobVehicle

   -- Request and wait for model to load
   RequestModel(vehicleModel)
   while not HasModelLoaded(vehicleModel) do
       Wait(500)
   end

   -- Get player's ped and create vehicle
   local playerPed = PlayerPedId()
   local vehicle = CreateVehicle(vehicleModel, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)

   -- Warp player into vehicle
   TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

   -- Wait to prevent bugs
   Wait(1000)

   -- Set vehicle owner
   TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)

   -- SetPlayerInJob
   StartJob()
end)

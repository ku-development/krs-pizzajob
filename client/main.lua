local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local npcPed = 0

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

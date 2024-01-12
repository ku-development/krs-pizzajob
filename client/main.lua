local QBCore = exports[Config.CoreResourceName]:GetCoreObject()

local npcPed = 0

Citizen.CreateThread(function()
    local npcModel = Config.NpcStart  
    RequestModel(npcModel)

    while not HasModelLoaded(npcModel) do
        Wait(500)
    end

    local npcCoords = Config.JobStartLocation-- Adjust the coordinates for the NPC's location
    npcPed = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, 0.0, false, true)
    TaskStandStill(npcPed, -1)

    SetEntityAsMissionEntity(npcPed, true, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetEntityInvincible(npcPed, true)
end)

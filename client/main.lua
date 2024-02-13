local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local npcPed = 0
local level = 0
local nextIn = 0
local exp = 0

-- NPC Initialization
CreateThread(function()
    local npcModel = Config.NpcStart

    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Citizen.Wait(500)
    end

    local npcCoords = Config.JobStartLocation
    npcPed = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, 0.0, false, true)
    TaskStandStill(npcPed, -1)
    SetEntityAsMissionEntity(npcPed, true, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetEntityInvincible(npcPed, true)
    FreezeEntityPosition(npcPed, true)

    exports[Config.Target]:AddTargetEntity(npcPed, {
        options = {
            {
                type = "client",
                event = "krs-pizzajob:client:StartJobFirst",
                icon = 'fas fa-briefcase',
                label = 'Start Job',

            }
        },
        distance = 2.5,
    })
end)

-- Event: Check Configs -- start with ui or not
RegisterNetEvent("krs-pizzajob:client:StartJobFirst")
AddEventHandler("krs-pizzajob:client:StartJobFirst", function ()
    if Config.ShowJobUI then
        level = GetLevel()
        nextIn = GetNextLevelIn()
        exp = GetExp()
        print(exp, level, nextIn)
        SendNUIMessage({ 
            type = 'openPizza',
            level = level,
            nextIn = nextIn,
            exp = exp
         })
        SetNuiFocus(true, true)
    else
        TriggerEvent('krs-pizzajob:client:StartJob')
    end
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

Citizen.CreateThread(function ()
    Citizen.wait(2500) -- adjust according to server ping
    SendNUIMessage({ type = 'closePizza' })
end)

-- Ui Functions:

RegisterNUICallback("CloseUi", function(data)
    SetNuiFocus(false,false)
end)

RegisterNUICallback("Start", function(data)
    SetNuiFocus(false,false)
    PullOutVehicle()
end)
local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local Hired = false
local HasPizza = false
local DeliveriesCount = 0
local Delivered = false
local PizzaDelivered = false
local ownsVan = false
local activeOrder = false
local JobBlip = nil
local newDelivery = {}

-- Function to send notifications
function Notify(text, type)
    if Config.Notify == 'qb' then
        QBCore.Functions.Notify(text)
    elseif Config.Notify == 'okok' then
        exports['okoknotify']:Alert('PizzaJob Information', text, 5000, type)
    elseif Config.Notify == 'ox' then
        lib.notify({
            title = 'Information',
            description = text,
            type = 'inform',
            position = 'top',
        })
    end
end

function StartJob()
    PullOutVehicle()
end

function NextDelivery()
    if not activeOrder then
        newDelivery = Config.JobLocs[math.random(1, #Config.JobLocs)]
        JobBlip = AddBlipForCoord(newDelivery.x, newDelivery.y, newDelivery.z)
        SetBlipSprite(JobBlip, 1)
        SetBlipDisplay(JobBlip, 4)
        SetBlipScale(JobBlip, 0.8)
        SetBlipFlashes(JobBlip, true)
        SetBlipAsShortRange(JobBlip, true)
        SetBlipColour(JobBlip, 2)
        SetBlipRoute(JobBlip, true)
        SetBlipRouteColour(JobBlip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Next Customer")
        EndTextCommandSetBlipName(JobBlip)
        exports['qb-target']:AddCircleZone("deliverZone", vector3(newDelivery.x, newDelivery.y, newDelivery.z), 1.3, { name = "deliverZone", debugPoly = false, useZ=true, }, { options = { { type = "client", event = "krs-pizzajob:client:deliverPizza", icon = "fa-solid fa-pizza-slice", label = "Deliver Pizza" }, }, distance = 1.5 })
        activeOrder = true
        Notify('You have a new delivery!')
    end
end

function PullOutVehicle()
    local coords = Config.VehicleSpawn
    QBCore.Functions.SpawnVehicle(Config.JobVehicle, function(pizzaCar)
        SetVehicleNumberPlateText(pizzaCar, "PIZZA" .. tostring(math.random(1000, 9999)))
        SetVehicleColours(pizzaCar, 111, 111)
        SetVehicleDirtLevel(pizzaCar, 1)
        DecorSetFloat(pizzaCar, "pizza_job", 1)
        TaskWarpPedIntoVehicle(PlayerPedId(), pizzaCar, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(pizzaCar))
        SetVehicleEngineOn(pizzaCar, true, true)
        exports[Config.FuelScript]:SetFuel(pizzaCar, 100.0)
        exports['qb-target']:AddTargetEntity(pizzaCar, {
            options = {
                {
                    icon = "fa-solid fa-pizza-slice",
                    label = "Take Pizza",
                    action = function(entity) TakePizza() end,
                    canInteract = function() 
                        return Hired and activeOrder and not HasPizza
                    end,
                },
            },
            distance = 2.5
        })
    end, coords, true)
    Hired = true
    ownsVan = true
    NextDelivery()
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function TakePizza()
    local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    
    if not IsPedInAnyVehicle(player, false) then
        local ad = "anim@heists@box_carry@"
        local prop_name = 'prop_pizza_box_01'

        if DoesEntityExist(player) and not IsEntityDead(player) then
            if not HasPizza then
                if #(pos - vector3(newDelivery.x, newDelivery.y, newDelivery.z)) < 30.0 then
                    loadAnimDict(ad)
                    local x, y, z = table.unpack(GetEntityCoords(player))
                    prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
                    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                    TaskPlayAnim(player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0)
                    HasPizza = true
                else
                    Notify("You're not close enough to the customer's house!")
                end
            end
        end
    end
end

function FinishWork()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle()
    local finishspot = vector3(Config.JobStartLocation.x, Config.JobStartLocation.y, Config.JobStartLocation.z)
    
    if #(pos - finishspot) < 10.0 then
        if Hired then
            if DecorExistOn((veh), "pizza_job") then
                QBCore.Functions.DeleteVehicle(veh)
                RemoveBlip(JobBlip)
                Hired = false
                HasPizza = false
                ownsVan = false
                activeOrder = false
                if DeliveriesCount > 0 then
                    -- Do something if deliveries were completed
                else
                    Notify("You didn't complete any deliveries, so you weren't paid.")
                    PullOutVehicle()
                end
                DeliveriesCount = 0
            else
                Notify('You must return your work vehicle to get paid.')
                PullOutVehicle()
                return
            end
        end
    end
end


-- Event: Deliver
RegisterNetEvent('krs-pizzajob:client:deliverPizza', function()
    if HasPizza and Hired and not PizzaDelivered then
        local playerCoords = GetEntityCoords(PlayerPedId())
        local deliveryDistance = #(playerCoords - vector3(newDelivery.x, newDelivery.y, newDelivery.z))
        local payout = CalculatePayout(deliveryDistance, DeliveriesCount)
        TriggerServerEvent('krs-pizzajob:server:deliverPizza', DeliveriesCount, payout)
        TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
        PizzaDelivered = true
        QBCore.Functions.Progressbar("knock", "Delivering pizza", 7000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            DeliveriesCount = DeliveriesCount + 1
            RemoveBlip(JobBlip)
            exports['qb-target']:RemoveZone("deliverZone")
            HasPizza = false
            activeOrder = false
            PizzaDelivered = false
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            Notify("You received $"..payout, "success")
            Wait(1000)
            ClearPedSecondaryTask(PlayerPedId())
            Notify("Pizza Delivered. Please wait for your next delivery!", "success") 
            SetTimeout(5000, function()    
                NextDelivery()
            end)
        end)
    else
        Notify("You need the pizza from the car dummy.", "error") 
    end
end)

-- Calculate Payout with Distance Bonus
function CalculatePayout(distance, deliveryCount)
    local basePayout = Config.BasePayout
    local distanceMultiplier = Config.DistanceMultiplier
    local additionalPayout = Config.AdditionalPayoutPerDelivery

    -- Calculate payout based on distance
    local distancePayout = basePayout + (distance * distanceMultiplier)

    -- Calculate additional payout based on delivery count
    local countPayout = deliveryCount * additionalPayout

    -- Total payout is the sum of distance and delivery count payouts
    local totalPayout = distancePayout + countPayout

    -- Ensure the payout is an integer value
    totalPayout = math.floor(totalPayout)

    return totalPayout
end
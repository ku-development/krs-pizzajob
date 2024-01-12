local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
-- Function to send notifications
function Notify(text)
    -- Check if QB notifications are enabled
 if Config.Notify == 'qb' then
        -- Send QB notification
        QBCore.Functions.Notify(text)
    -- Check if okok notifications are enabled
 elseif Config.Notify == 'okok' then
        -- Send okok notification
        exports['okoknotify']:Alert('PizzaJob Information', text, 5000, 'info')
    -- Check if ox notifications are enabled
    elseif Config.Notify == 'ox' then
        -- Send ox notification
        lib.notify({
            -- Notification title
            title = 'Information',
            -- Notification description
            description = text,
            -- Notification type
            type = 'inform',
            -- Notification position
            position = 'top',
        })
    end
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
        exports['qb-target']:AddCircleZone("deliverZone", vector3(newDelivery.x, newDelivery.y, newDelivery.z), 1.3,{ name = "deliverZone", debugPoly = false, useZ=true, }, { options = { { type = "client", event = "randol_pizzajob:client:deliverPizza", icon = "fa-solid fa-pizza-slice", label = "Deliver Pizza"}, }, distance = 1.5 })
        activeOrder = true
        Notify('You have a new delivery!')
       
    end
end
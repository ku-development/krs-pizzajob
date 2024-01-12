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

local blipColor = 3  -- Blip color (3 is yellow)
local blipSprite = 1  -- Blip sprite (1 is standard location blip)
local deliveryBlips = {}

function StartJob()
    for _, location in ipairs(deliveryLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, blipSprite)
        SetBlipColour(blip, blipColor)
        SetBlipDisplay(blip, 4)  -- Display blip always on the map
        SetBlipScale(blip, 0.8)  -- Set blip size
        SetBlipAsShortRange(blip, true)  -- Show blip on the minimap even at a distance
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Delivery Location")
        EndTextCommandSetBlipName(blip)

        table.insert(deliveryBlips, blip)
    end
end

function FinishDelivery()
    -- Assume you have a function that calculates the index of the finished delivery
    local finishedDeliveryIndex = CalculateFinishedDeliveryIndex()

    if finishedDeliveryIndex then
        -- Get the blip associated with the finished delivery
        local finishedDeliveryBlip = deliveryBlips[finishedDeliveryIndex]

        -- Remove the old blip
        RemoveBlip(finishedDeliveryBlip)

        -- Add a new blip for the next delivery (if available)
        local nextDeliveryIndex = CalculateNextDeliveryIndex()
        if nextDeliveryIndex then
            local nextDeliveryLocation = deliveryLocations[nextDeliveryIndex]
            local newBlip = AddBlipForCoord(nextDeliveryLocation.x, nextDeliveryLocation.y, nextDeliveryLocation.z)
            SetBlipSprite(newBlip, blipSprite)
            SetBlipColour(newBlip, blipColor)
            SetBlipDisplay(newBlip, 4)
            SetBlipScale(newBlip, 0.8)
            SetBlipAsShortRange(newBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(newBlip)

            -- Update the deliveryBlips table
            deliveryBlips[finishedDeliveryIndex] = newBlip
        else
            print("No more deliveries available.")
        end
    else
        print("Failed to determine finished delivery index.")
    end
end

-- Placeholder data for delivery status
local deliveryStatus = {
    {finished = false},  
    {finished = false},
    -- Add more entries as needed
}

function CalculateNextDeliveryIndex()
    for i, delivery in ipairs(deliveryStatus) do
        if not delivery.finished then
            return i
        end
    end
    return nil  -- No more deliveries available
end

function CalculateFinishedDeliveryIndex()
    for i, delivery in ipairs(deliveryStatus) do
        if delivery.finished then
            return i
        end
    end
    return nil  -- No finished deliveries found
end

-- Example: Mark a delivery as finished (you can replace this with your actual logic)
function MarkDeliveryAsFinished(deliveryIndex)
    if deliveryStatus[deliveryIndex] then
        deliveryStatus[deliveryIndex].finished = true
    else
        print("Invalid delivery index.")
    end
end

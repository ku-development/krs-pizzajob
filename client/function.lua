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


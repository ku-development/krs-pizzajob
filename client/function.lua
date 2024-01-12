local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
function Notify(text)
    if Config.Notify == 'qb' then
        QBCore.Functions.Notify(text)
    elseif Config.Notify == 'okok' then
        exports['okoknotify']:Alert('PizzaJob Information', text, 5000, 'info')
    elseif Config.Notify == 'ox' then
        lib.notify({
            title = 'Information',
            description = text,
            type = 'inform',
            position = 'top', 
        })
    end
end


local QBCore = exports[Config.CoreResourceName]:GetCoreObject()

-- Event: PayCheck
RegisterNetEvent('krs-pizzajob:server:deliverPizza')
AddEventHandler('krs-pizzajob:server:deliverPizza', function(deliveryamount, payoutAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.XP.Use then
        AddMoneyByExp(deliveryamount)
    else
        Player.Functions.AddMoney(Config.PayCheckType, payoutAmount)
    end
end)

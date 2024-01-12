local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local MetaDataName = Config.XP.MetaDataName

-- Event: PayCheck
RegisterNetEvent('krs-pizzajob:server:deliverPizza')
AddEventHandler('krs-pizzajob:server:deliverPizza', function(deliveryamount, payoutAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.XP.Use then
        TriggerServerEvent('krs-pizzajob:server:EXP', deliveryamount, payoutAmount)
    else
        Player.Functions.AddMoney(Config.PayCheckType, payoutAmount)
    end
end)

RegisterNetEvent('krs-pizzajob:server:EXP')
AddEventHandler('krs-pizzajob:server:EXP', function(deliveryamount, payoutAmount)
        local src = source
        local exp = getxp(src)
        local pData = QBCore.Functions.GetPlayer(src)
        local PizzaExp = pData.PlayerData.metadata[MetaDataName]
        pData.Functions.SetMetaData(MetaDataName, (PizzaExp + exp)) -- Edit xp reward here
        ServerNotify('You are now '.. getLevel(src) .. ' Level and you have '.. PizzaExp .. " EXP", 'info', src)
end)

RegisterNetEvent("krs-pizzajobL:server:Fail")
AddEventHandler("krs-pizzajobL:server:Fail", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pData = QBCore.Functions.GetPlayer(src)
    local PizzaExp = pData.PlayerData.metadata[MetaDataName]
    if Config.TakeMoney then
        Player.Functions.RemoveMoney(Config.PayCheckType, Config.TakeMoneyAmount)
    end
    if Config.TakeEXP then
        pData.Functions.SetMetaData(MetaDataName, (PizzaExp - Config.ExpTakeAmount)) -- Edit xp reward here
    end
end)

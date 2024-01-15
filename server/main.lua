local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local MetaDataName = Config.XP.MetaDataName

-- Event: PayCheck
RegisterNetEvent('krs-pizzajob:server:deliverPizza')
AddEventHandler('krs-pizzajob:server:deliverPizza', function(deliveryamount, payoutAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    CheckAllConfigs(src)
    if Config.XP.Use then
        local exp = getxp(source)
        local pData = QBCore.Functions.GetPlayer(src)
        local PizzaExp = pData.PlayerData.metadata[MetaDataName]
        pData.Functions.SetMetaData(MetaDataName, (PizzaExp + exp)) -- Edit xp reward here
        ServerNotify('You are now '.. getLevel(src) .. ' Level and you have '.. PizzaExp .. " EXP", 'info', src)
    else
        Player.Functions.AddMoney(Config.PayCheckType, payoutAmount)
    end
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

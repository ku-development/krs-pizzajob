local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local MetaDataName = Config.XP.MetaDataName
local data = {}

function getxp(s)
	local src = s
    local pData = QBCore.Functions.GetPlayer(src)
    local PizzaExp = pData.PlayerData.metadata[MetaDataName]
	if PizzaExp < 1500 then 
		return math.random(2, 6) -- 1
	elseif PizzaExp <= 4000 and PizzaExp >= 1500 then
		return math.random(4, 9) -- 2
	elseif PizzaExp <= 7000 and PizzaExp >= 4000 then
		return math.random(6, 12) -- 3
	elseif PizzaExp <= 10000 and PizzaExp >= 7000 then
		return math.random(7, 13) -- 4
	elseif PizzaExp <= 15000 then
		return math.random(8, 15) -- 5
	end
end

function getLevel(s)
	local src = s
    local pData = QBCore.Functions.GetPlayer(src)
    local PizzaExp = pData.PlayerData.metadata[MetaDataName]
	if PizzaExp < 1500 then 
		return 1
	elseif PizzaExp <= 4000 and PizzaExp >= 1500 then
		return 2
	elseif PizzaExp <= 7000 and PizzaExp >= 4000 then
		return 3
	elseif PizzaExp <= 10000 and PizzaExp >= 7000 then
		return 4
	elseif PizzaExp <= 15000  then
		return 5
	end
end

function getLevelIn(s)
	local src = s
    local Player = QBCore.Functions.GetPlayer(src)
    local pData = QBCore.Functions.GetPlayer(src)
    local PizzaExp = pData.PlayerData.metadata[MetaDataName]
	if PizzaExp < 0 then
		return 0
	end
	if PizzaExp < 1500 then 
		return 1500 - PizzaExp -- 1
	elseif PizzaExp <= 4000 and PizzaExp >= 1500 then
		return 4000 - PizzaExp -- 2
	elseif PizzaExp <= 7000 and PizzaExp >= 4000 then
		return 7000 - PizzaExp -- 3
	elseif PizzaExp <= 10000 and PizzaExp >= 7000 then
		return 10000 - PizzaExp -- 4
	elseif PizzaExp <= 15000  then
		return 15000 - PizzaExp -- 5
	end
end

function ServerNotify(text, type, source)
    if Config.Notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", source, text)
    elseif Config.Notify == 'okok' then
        exports['okoknotify']:Alert('PizzaJob Information', source, text, 5000, type)
    elseif Config.Notify == 'ox' then
        data = {
            title = 'Information',
            description = text,
            type = 'inform',
            position = 'top',
        }
        TriggerClientEvent('ox_lib:notify', source, data)
    end
end

function CheckAllConfigs(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.RandomItem and Config.RandomItemChance and math.random(1, 100) <= Config.RandomItemChance then
        local randomItem = GetRandomItem()
        Player.Functions.AddItem(randomItem.item, randomItem.amount, 0, {}) -- Assuming slot and info are not used here
    end
    if Config.RandomMoney then
        Player.Functions.AddMoney(Config.RandomMoneyType, math.random(Config.RandomMoneyAmount.min, Config.RandomMoneyAmount.max))
    end
end

function GetRandomItem()
    local itemName, amount = next(Config.RandomItems)
    return { item = itemName, amount = amount }
end

-- CallBacks
QBCore.Functions.CreateCallback('krs-PizzaJob:CallBacks:getexp', function(source, cb, args)
	local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local PizzaExp = pData.PlayerData.metadata[MetaDataName]
	cb(PizzaExp)
end)

QBCore.Functions.CreateCallback('krs-PizzaJob:CallBacks:getnextlevelin', function(source, cb, args)
	cb(getLevelIn(source))
end)

QBCore.Functions.CreateCallback('krs-PizzaJob:CallBacks:getlevel', function(source, cb, args)
	cb(getLevel(source))
end)
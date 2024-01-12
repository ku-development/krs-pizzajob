local QBCore = exports[Config.CoreResourceName]:GetCoreObject()
local MetaDataName = Config.XP.MetaDataName

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


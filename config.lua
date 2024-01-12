Config = {}

-- Core
Config.Core = 'qb' -- Supports only qb for now
Config.Notify = 'qb' -- Supports: ox_lib = 'ox', qb-notify = 'qb', okoknotify = 'okok'
Config.CoreResourceName = 'qb-core' -- if u changed your core name
Config.Target = 'qb-target' -- target name for exports
Config.FuelScript = 'qb-fuel' -- suopports cdn-fuel qb-fuel
Config.ProgressBar = 'qb' -- supports qbcore defult = 'qb', ox_lb = 'ox'

-- General Settings
Config.JobStartLocation = vector3(334.58251, -1350.742, 32.505485)  -- Example coordinates for job starting location
Config.NpcStart = 'a_m_m_prolhost_01' -- Replace with the desired NPC model
Config.JobEndLocation = vector3(334.58251, -1350.742, 32.505485)    -- Example coordinates for job ending location
Config.JobVehicle = "t20"  -- Example vehicle model for pizza delivery
Config.TimeLimitPerDelivery = 300  -- Time limit for each delivery in seconds (300 seconds = 5 minutes)
Config.VehicleSpawn = vector4(330.05422, -1344.015, 32.403095, 52.768848)

-- Payout Settings
Config.BasePayout = 500  -- Base payout for deliveries
Config.DistanceMultiplier = 5  -- Multiplier for payout based on distance
Config.DistanceBonusMultiplier = 3 -- Multiplier for payout based on distance
Config.AdditionalPayoutPerDelivery = 6 -- Multiplier for payout based on distance
Config.PayCheckType = "cash" -- types: 'cash', 'bank'

-- UI Settings
Config.ShowJobUI = true  -- Set to false to disable job UI

-- Random Events Settings
Config.RandomEventChance = 15  -- Percentage chance of encountering a random event (e.g., 15%)
Config.AggressiveNPCs = true  -- Enable aggressive NPCs during deliveries

-- Rating System Settings
Config.EnableRatingSystem = true  -- Enable or disable the rating system
Config.PositiveRatingThreshold = 4.5  -- Minimum rating for additional perks or rewards

-- Leaderboard Settings
Config.EnableLeaderboard = true  -- Enable or disable the leaderboard
Config.LeaderboardLimit = 10  -- Number of top performers to display on the leaderboard

-- Timer
Config.DeliveryTimer = 3600 -- set the max time per delveiry if delviery not in time will give u a new one
Config.ReetDeliveryCount = true -- if fail will reset delvery count so player will get less money
Config.TakeMoney = true -- if true will take money from player on fail
Config.TakeMoneyAmount = 500 -- ammoiunt of money on lost
Config.TakeEXP = true -- will take exp from the player only enable if xp system is enabled
Config.ExpTakeAmount = 10 -- amount to take

-- EXP System
Config.XP = {
    Use = false, -- Toggles xp system on or off; true = on, false = off
    Command = true, -- Toggles xp command on or off; true = on, false = off
    MetaDataName = 'pizzaexp', -- The name of your xp if you edit this make sure to also edit the line included in readme this is also your /miningxp command
    Levels = { -- Change your xp requirements here to suit your server set these as high as you want preset xp increase = (xp / 0.8)
        1000, -- level 2 
        1250, -- level 3 
        1562, -- level 4
        1953, -- level 5
        2441, -- level 6 
        3051, -- level 7
        3814, -- level 8
        4768, -- level 9
        5960, -- level 10
    }
}

Config.JobLocs = { -- Random delivery houses.
    vector3(224.11, 513.52, 140.92),
    vector3(57.51, 449.71, 147.03),
    vector3(-297.81, 379.83, 112.1),
    vector3(-595.78, 393.0, 101.88),
    vector3(-842.68, 466.85, 87.6),
    vector3(-1367.36, 610.73, 133.88),
    vector3(944.44, -463.19, 61.55),
    vector3(970.42, -502.5, 62.14),
    vector3(1099.5, -438.65, 67.79),
    vector3(1229.6, -725.41, 60.96),
    vector3(288.05, -1094.98, 29.42),
    vector3(-32.35, -1446.46, 31.89),
    vector3(-34.29, -1847.21, 26.19),
    vector3(130.59, -1853.27, 25.23),
    vector3(192.2, -1883.3, 25.06),
    vector3(348.64, -1820.87, 28.89),
    vector3(427.28, -1842.14, 28.46),
    vector3(291.48, -1980.15, 21.6),
    vector3(279.87, -2043.67, 19.77),
    vector3(1297.25, -1618.04, 54.58),
    vector3(1381.98, -1544.75, 57.11),
    vector3(1245.4, -1626.85, 53.28),
    vector3(315.09, -128.31, 69.98),
    vector3(-20.93653, -1406.271, 29.532669),
    vector3(-32.32445, -1446.168, 31.89141),
    vector3(-602.1438, -1121.965, 22.324249),
    vector3(-736.7023, -1118.965, 11.015544),
    vector3(335.23135, -71.63269, 73.042213),
    vector3(1207.4804, -620.3994, 66.438636),
    vector3(1130.4631, -963.6549, 47.258625),
    vector3(232.49606, -1094.821, 29.294008),
    vector3(478.98596, -106.7353, 63.15781),
}
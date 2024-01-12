Config = {}

-- Core
Config.Core = 'qb' -- Supports only qb for now
Config.Notify = 'qb' -- Supports: ox_lib = 'ox', qb-notify = 'qb', okoknotify = 'okok'
Config.CoreResourceName = 'qb-core' -- if u changed your core name

-- General Settings
Config.JobStartLocation = vector3(123.45, 67.89, 45.67)  -- Example coordinates for job starting location
Config.JobEndLocation = vector3(987.65, 43.21, 76.54)    -- Example coordinates for job ending location
Config.JobVehicle = "pizza_scooter"  -- Example vehicle model for pizza delivery
Config.TimeLimitPerDelivery = 300  -- Time limit for each delivery in seconds (300 seconds = 5 minutes)

-- Payout Settings
Config.BasePayout = 50  -- Base payout for deliveries
Config.DistanceMultiplier = 2.5  -- Multiplier for payout based on distance

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


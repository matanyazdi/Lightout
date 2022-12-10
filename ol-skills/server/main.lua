local QBCore = exports['qb-core']:GetCoreObject()
skills = {}

QBCore.Functions.CreateCallback("ol-skills:server:getSkills",function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local identifier = Player.PlayerData.citizenid
    exports.oxmysql:execute("SELECT * FROM skills WHERE citizenid = @citizenid", {['@citizenid'] = identifier,}, function(result)
        skills = result[1]
        cb(skills)
    end)
end)

RegisterNetEvent('ol-skills:server:updateSkills', function(skills)
    local Player = QBCore.Functions.GetPlayer(source)
    local identifier = Player.PlayerData.citizenid
    exports.oxmysql:execute('INSERT INTO skills (citizenid, stamina, strength, driving, shooting, fishing, drugs) VALUES (@citizenid, @stamina, @strength, @driving, @shooting, @fishing, @drugs) ON DUPLICATE KEY UPDATE stamina = @stamina, strength = @strength, driving = @driving, shooting = @shooting, fishing = @fishing, drugs = @drugs', {
        ['@citizenid'] = identifier,
        ['@stamina'] = (skills['stamina'].xp + skills['stamina'].level * 100),
        ['@strength'] = (skills['strength'].xp + skills['strength'].level * 100),
        ['@driving'] = (skills['driving'].xp + skills['driving'].level * 100),
        ['@shooting'] = (skills['shooting'].xp + skills['shooting'].level * 100),
        ['@fishing'] = (skills['fishing'].xp + skills['fishing'].level * 100),
        ['@drugs'] = (skills['drugs'].xp + skills['drugs'].level * 100),

    }, function (rowsChanged)
    end)
end)
local QBCore = exports['qb-core']:GetCoreObject()

local Webhook = 'YOURWEBHOOK'

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local allPlayers = QBCore.Functions.GetPlayers()
    for i, id in next, allPlayers do
        if id ~= src then
            local otherPlayer = QBCore.Functions.GetPlayer(id)
            if xPlayer.PlayerData.citizenid == otherPlayer.PlayerData.citizenid then

                DropPlayer(src, 'Double client is not allowed! Sent log to the staff')
                DropPlayer(id, 'Double client is not allowed! Sent log to the staff')
                local msg = "**" .. GetPlayerName(id) .. "** (citizenid: **" .. xPlayer.PlayerData.citizenid .. "** | source: **" .. id .. "**)\n**" .. GetPlayerName(src) .. "** (citizenid: **" .. otherPlayer.PlayerData.citizenid .. "** | source: **" .. src .. "**)\nHe is using double fivem!"
                local embed = {
                    {
                        ["color"] = "16747520",
                        ["title"] = 'Anti Double Fivem',
                        ["author"] = {
                            ["name"] = 'Your Server Name',
                            ["icon_url"] = "Your Icon",
                        },
                        ["description"] = msg,
                    }
                }
                PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
            end
        end
    end
end)


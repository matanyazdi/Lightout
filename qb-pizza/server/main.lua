local QBCore = exports['qb-core']:GetCoreObject()
local pizza = {}
local pizzainv = {}

RegisterServerEvent('pizza:server:additem')
AddEventHandler('pizza:server:additem', function(items)
    for _,item in pairs(items) do
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", 1) 
    end
end)

RegisterServerEvent('pizza:server:removeitem')
AddEventHandler('pizza:server:removeitem', function(items)
    for _,item in pairs(items) do
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove", 1) 
    end
end)

RegisterServerEvent('qb-pizza:server:removepizzafromoven')
AddEventHandler('qb-pizza:server:removepizzafromoven', function(pizza)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not pizzainv[pizza.index].finish then
        if pizza.time > 110 then
            local item = 'burnpizza'
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", 1)
        elseif pizza.time < 50 then
            local item = pizza.name
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", 1)
        else
            local item = pizza.cooked
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", 1)
        end
        pizzainv[pizza.index].finish = true
    else
        TriggerClientEvent('QBCore:Notify', src, "This pizza was already taken", "error")
    end
end)

RegisterServerEvent('qb-pizza:server:addToOven')
AddEventHandler('qb-pizza:server:addToOven', function(pizza)
    pizzainv[#pizzainv + 1] = pizza
end)

QBCore.Functions.CreateCallback('qb-pizze:server:GetinvPizza', function(source, cb)
    local pizzaitem = {
        [1] = {name = 'pizzaa', label = 'Regular pizza', cooked = 'pizzaf'},
        [2] = {name = 'pizza2a', label = 'Pizza with corns', cooked = 'pizza2f'},
        [3] = {name = 'pizza3a', label = 'Pizza with olives', coocked = 'pizza3f'},
        [4] = {name = 'pizza4a', label = 'Pizza with pineapple', coocked = 'pizza4f'},
    }
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pizzalist = {}
    for i, pizza in next, pizzaitem do
        local item = Player.Functions.GetItemByName(pizza.name)
        if item then            
            pizzalist[#pizzalist + 1] = {
                name = pizza.name,
                label = pizza.label,
                time = 0,
                finish = false,
                index = #pizzainv + 1,
                cooked = pizza.cooked
            }
        end
    end
    cb(pizzalist)
end)

QBCore.Functions.CreateCallback('pizze:server:GetPizza', function(source, cb)
    cb(pizzainv)
end)

CreateThread(function()
    while true do
        if #pizzainv > 0 then
            for i,pizza in ipairs(pizzainv) do
                pizza.time = pizza.time + 1
            end
        end
        Wait(1000)
    end
end)
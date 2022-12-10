QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    QBCore.Functions.TriggerCallback('ol-skills:server:getSkills', function(Skills)
        if Skills then 
            for name, skill in next, Config.Skills do
                skill.level = math.floor(tonumber(Skills[name])/100)
                skill.xp = tonumber(Skills[name])%100
                print(skill.level)
            end
        end
    end)
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    TriggerServerEvent('ol-skills:server:updateSkills', Config.Skills)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        if IsPedRunning(ped) then
            UpdateSkill("stamina", Config.Skills['stamina'].xpGain)
        elseif IsPedInMeleeCombat(ped) then
            UpdateSkill("strength", Config.Skills['strength'].xpGain)
        elseif IsPedShooting(ped) then
            UpdateSkill("shooting", Config.Skills['shooting'].xpGain)
        elseif DoesEntityExist(vehicle) then
            local speed = GetEntitySpeed(vehicle) * 3.6
            if speed >= 80 then
                UpdateSkill("driving", Config.Skills['driving'].xpGain)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000 * 60 * Config.AutoSave)
        TriggerServerEvent('ol-skills:server:updateSkills', Config.Skills)
    end
end)

RegisterCommand("openskill", function()
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(1000)
    local Skills = {}
    local int = 1
    for i, skill in next, Config.Skills do
        if custom then
            Skills[#Skills + 1] = {
                name = i,
                level = skill.level,
                xp = skill.xp,
                img = skill.img,
                desc = skill.desc,
                lvldesc = skill.lvldesc,
            }
        else
            Skills[#Skills + 1] = {
                name = i,
                level = skill.level,
                xp = skill.xp,
                img = skill.img,
                desc = skill.desc,
                lvldesc = skill.lvldesc,
            }
        end
    end 
    SendNUIMessage(
        {
            type = "open",
            skills = Skills
        }
    )
end)

RegisterNUICallback("close", function(data)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        Wait(2000)
        QBCore.Functions.TriggerCallback('ol-skills:server:getSkills', function(Skills)
            if Skills then 
                for name, skill in next, Config.Skills do
                    skill.level = math.floor(tonumber(Skills[name])/100)
                    skill.xp = tonumber(Skills[name])%100
                end
            end
        end)
    end
end)
  
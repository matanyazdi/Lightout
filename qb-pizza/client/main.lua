local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local dough = false
local proggress = false
local wining = false
local QBCore
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('qb-taco:client:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-pizza:pickup")
AddEventHandler("qb-pizza:pickup", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Pizza Pickup")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Pizza Pickup", {
        maxweight = 10000,
        slots = 5,
    })
end)

RegisterNetEvent("qb-pizza:storage", function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Pizza Storage")
    TriggerEvent("inventory:client:SetCurrentStash", "Pizza Storage", {
        maxweight = 2000000,
        slots = 50,
    })
end)

-- TARGET

exports['qb-target']:AddBoxZone("PizzaDuty", vector3(796.246, -765.8287, 31.26588), 1, 1, {
    name = "PizzaDuty",
    debugPoly = false,
    maxZ=32.5,
    minZ=30.0,
}, {
    options = {
        {  
            event = "qb-pizza:Duty",
            icon = "far fa-clipboard",
            label = "Clock On/Off",
            -- job = "pizza",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("pizzapickup", vector3(810.9283, -751.8445, 26.78083), 1, 1.2, {
    name = "pizzapickup",
    debugPoly = false,
    maxZ=27.5,
    minZ=25.5,
}, {
    options = {
        {  
            event = "qb-pizza:pickup",
            icon = "fas fa-hand-holding",
            label = "Pick Up Order",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("pizzafrige", vector3(805.4997, -761.6, 26.78083), 1.4, 1, {
    name = "pizzafrige",
    debugPoly = false,
    maxZ=28.0,
    minZ=24.0,
}, {
    options = {
        {  
            event = "qb-pizza:storage",
            icon = "fas fa-box-open",
            label = "Open Fridge",
            job = "pizza",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("makedough", vector3(807.6557, -757.0, 26.78085), 1, 1.7, {
    name = "makedough",
    debugPoly = false,
    maxZ=27.5,
    minZ=25.5,
}, {
    options = {
        {  
            event = "qb-pizza:doughhh",
            icon = "fas fa-pizza-slice",
            label = "Make Dough",
            job = "police",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("makepizza", vector3(811.4681, -755.0818, 27.0523), 1, 1, {
    name = "makepizza",
    debugPoly = false,
    maxZ=27.5,
    minZ=25.5,
}, {
    options = {
        {  
            event = "qb-pizza:pizzaaaa",
            icon = "fas fa-pizza-slice",
            label = "Make Pizza",
            job = "police",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("OvenPizza", vector3(814.0278, -752.8987, 26.78086), 1, 1, {
    name = "OvenPizza",
    debugPoly = false,
    maxZ=27.5,
    minZ=25.5,
}, {
    options = {
        {  
            event = "qb-pizza:cook",
            icon = "far fa-fire",
            label = "Open Oven",
            job = "pizza",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("bosspizza", vector3(797.8481, -751.3734, 31.26599), 1, 1, {
    name = "bosspizza",
    debugPoly = false,
    maxZ=32.0,
    minZ=30.0,
}, {
    options = {
        {  
            event = "qb-pizza:interact:boss",
            icon = "far fa-laptop",
            label = "Job Management",
            job = "pizza",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("plumpvine", vector3(815.2258, -756.2921, 22.303), 1.8, 1, {
    name = "plumpvine",
    debugPoly = true,
    maxZ=22.5,
    minZ=20.0,
}, {
    options = {
        {  
            event = "qb-pizza:interact:boss",
            icon = "far fa-wine-bottle",
            label = "Plump Wine",
            job = "pizza",
        },
    },
    distance = 1.5
})

-- TEXT EVENT

RegisterNetEvent('qb-pizza:cook', function()
	if onDuty then
		QBCore.Functions.TriggerCallback('pizze:server:GetPizza', function(pizza)
			local headerMenu = {}
			headerMenu[#headerMenu+1] = {
				header = "Add Pizza",
				params = {
					event = "qb-pizza:addpizza",
					args = item
				}
			}
			if #pizza > 0 then
				for i, item in next, pizza do
					if item then
						if not item.finish then
							local precent = 0
							if item.time >= 50 then
								precent = 100
							else
								precent = item.time*2
							end
							if precent == 100 then
								headerMenu[#headerMenu+1] = {
									header = item.label .. " | Precent: " .. precent .. "% | DONE",
									params = {
										event = "qb-pizza:removepizzafromoven",
										args = item
									}
								}
							elseif item.time > 110 then
								headerMenu[#headerMenu+1] = {
									header = item.label .. " | OVERCOOK",
									params = {
										event = "qb-pizza:removepizzafromoven",
										args = item
									}
								}
							else
								headerMenu[#headerMenu+1] = {
									header = item.label .. " | Precent: " .. precent .. "%",
									params = {
										event = "qb-pizza:removepizzafromoven",
										args = item
									}
								}
							end
						end
					end
				end
			end
			exports['qb-menu']:openMenu(headerMenu)
		end)
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent('qb-pizza:wineee', function()
	if onDuty then
		local headerMenu = {}
		headerMenu[#headerMenu+1] = {
			header = "Plump Wine | Empty Bottle Of Wine",
			params = {
				event = "qb-pizza:addpizzatoven",
				args = item
			}
		}
		headerMenu[#headerMenu+1] = {
			header = "Red Wine",
			params = {
				event = "qb-pizza:plumpwine",
				args = 'wine'
			}
		}
		headerMenu[#headerMenu+1] = {
			header = "White Wine",
			params = {
				event = "qb-pizza:plumpwine",
				args = 'whitewine'
			}
		}
		exports['qb-menu']:openMenu(headerMenu)
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent('qb-pizza:addpizza', function()
	if onDuty then
		QBCore.Functions.TriggerCallback('qb-pizze:server:GetinvPizza', function(pizza)
			if #pizza > 0 then
				local headerMenu = {}
				for i, item in ipairs(pizza) do
					headerMenu[#headerMenu+1] = {
						header = "Add " .. item.label,
						params = {
							event = "qb-pizza:addpizzatoven",
							args = item
						}
					}
					exports['qb-menu']:openMenu(headerMenu)
				end
			else
				QBCore.Functions.Notify('You have no pizza in inventory', 'error')
			end
		end)
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent('qb-pizza:doughhh', function()
	if onDuty then
		TriggerEvent('nh-context:sendMenu', {
			{
				id = 1,
				header = "Dough",
				txt = "1 Flour, Eggs | 10s",
				params = {
					event = "qb-pizza:makedough"
				}
			},
		})
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)


RegisterNetEvent('qb-pizza:pizzaaaa', function()
	if onDuty then
		TriggerEvent('nh-context:sendMenu', {
			{
				id = 1,
				header = "Making Pizza",
				txt = "1 Dough, 1 Sauce | 10s",
				params = {
					event = "qb-pizza:makepizza"
				}
			},
			{
				id = 2,
				header = "Upgrade Pizza",
				txt = "1 Pizza, Corns | 10s",
				params = {
					event = "qb-pizza:makepizza2"
				}
			},
			{
				id = 3,
				header = "Upgrade Pizza",
				txt = "1 Pizza, Olives | 10s",
				params = {
					event = "qb-pizza:makepizza3"
				}
			},
			{
				id = 4,
				header = "Upgrade Pizza",
				txt = "1 Pizza, Pineapple | 10s",
				params = {
					event = "qb-pizza:makepizza4"
				}
			},
			{
				id = 5,
				header = "Add Cheese",
				txt = "What pizza you want to add cheese",
				params = {
					event = "qb-pizza:addcheese"
				}
			},
		})
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent('qb-pizza:addcheese', function()
	if onDuty then
		TriggerEvent('nh-context:sendMenu', {
			{
				id = 1,
				header = "Clean Pizza",
				txt = "1 Pizza, 1 Cheese | 10s",
				params = {
					event = "qb-pizza:addcheasee"
				}
			},
			{
				id = 2,
				header = "Pizza With Corns",
				txt = "1 Pizza, 1 Cheese | 10s",
				params = {
					event = "qb-pizza:addcheasee2"
				}
			},
			{
				id = 3,
				header = "Pizza With Olives",
				txt = "1 Pizza, 1 Cheese | 10s",
				params = {
					event = "qb-pizza:addcheasee3"
				}
			},
			{
				id = 4,
				header = "Pizza With Pineapple",
				txt = "1 Pizza, 1 Cheese | 10s",
				params = {
					event = "qb-pizza:addcheasee4"
				}
			}
		})
	else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

-- PLUMP WINE

RegisterNetEvent("qb-pizza:plumpwine", function(wine)
	if not wining then
		wining = true
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				QBCore.Functions.Progressbar("Cheese", "Adding Cheese", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				}, {
				animDict = "anim@amb@business@coc@coc_unpack_cut@",
				anim = "fullcut_cycle_v6_cokecutter",
					flags = 49,
				}, {}, {}, function(cancelled) 
					if not cancelled then
						TriggerServerEvent('QBCore:Server:RemoveItem', 'bottleofwine', 1)
						TriggerServerEvent('QBCore:Server:AddItem', wine, 1)
						wining = false
					else
						wining = false
					end
				end)
			else
				QBCore.Functions.Notify('You are missing an item', 'error')
			end
		end, 'bottleofwine')
	else
		QBCore.Functions.Notify('You are in middle of something', 'error')
	end
end)

-- MAKE PIZZA EVENT

-- ADD CHEESE EVENT
RegisterNetEvent("qb-pizza:addcheasee", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("Cheese", "Adding Cheese", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'cheese', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizzaa', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza', 'Cheese'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:addcheasee2", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("Cheese", "Adding Cheese", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza2', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'cheese', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza2a', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza2', 'cheese'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:addcheasee3", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("Cheese", "Adding Cheese", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza3', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'cheese', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza3a', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza3', 'cheese'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:addcheasee4", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("Cheese", "Adding Cheese", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza4', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'cheese', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza4a', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza4', 'cheese'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

-- MAKE DOUGH

RegisterNetEvent("qb-pizza:makedough", function()
    if onDuty then
    	MakeDough()
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

-- MAKE PIZZA

RegisterNetEvent("qb-pizza:makepizza", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("Dough", "Making Pizza", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('pizza:server:removeitem', {'dough', 'sauce'})
							TriggerServerEvent('pizza:server:additem', {'pizza'})
							TriggerServerEvent('QBCore:Server:RemoveItem', 'dough', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'sauce', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'dough', 'sauce'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:makepizza2", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("corns", "Adding Corn", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('pizza:server:removeitem', {'pizza', 'corn'})
							TriggerServerEvent('pizza:server:additem', {'pizza2'})
							TriggerServerEvent('QBCore:Server:RemoveItem', 'corn', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza2', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza', 'corn'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:makepizza3", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("olives", "Adding Olives", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('pizza:server:removeitem', {'pizza', 'olive'})
							TriggerServerEvent('pizza:server:additem', {'pizza3'})
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'olive', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza3', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza', 'olive'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

RegisterNetEvent("qb-pizza:makepizza4", function()
    if onDuty then
        if not proggress then
			proggress = true
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
				if hasItem then
					QBCore.Functions.Progressbar("pineapple", "Addding Pineapple", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
						flags = 49,
					}, {}, {}, function(cancelled) 
						if not cancelled then
							TriggerServerEvent('pizza:server:removeitem', {'pizza', 'pineapple'})
							TriggerServerEvent('pizza:server:additem', {'pizza4'})
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pizza', 1)
							TriggerServerEvent('QBCore:Server:RemoveItem', 'pineapple', 1)
							TriggerServerEvent('QBCore:Server:AddItem', 'pizza4', 1)
							proggress = false
						else
							proggress = false
						end
					end)
				else
					QBCore.Functions.Notify('You are missing an item', 'error')
				end
			end, {'pizza', 'pineapple'})
		else
			QBCore.Functions.Notify('You are in middle of something', 'error')
		end
    else
        QBCore.Functions.Notify("You are not on duty.", "error")
    end
end)

-- others

RegisterNetEvent('qb-pizza:removepizzafromoven', function(pizza)
	TriggerServerEvent('qb-pizza:server:removepizzafromoven', pizza)
end)

RegisterNetEvent('qb-pizza:addpizzatoven', function(pizza)
	TriggerServerEvent("qb-pizza:server:addToOven", pizza)
	TriggerServerEvent('QBCore:Server:RemoveItem', pizza.name, 1)
	TriggerServerEvent('pizza:server:removeitem', {pizza.name})
end)

RegisterNetEvent("qb-pizza:interact:boss", function()
    TriggerServerEvent("qb-bossmenu:server:openMenu")
end)


-- functions

function MakeDough()
    if not dough then
		dough = true
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
            if hasItem then
                QBCore.Functions.Progressbar("Dough", "Making Dough", 10000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
					animDict = "anim@amb@business@coc@coc_unpack_cut@",
					anim = "fullcut_cycle_v6_cokecutter",
                    flags = 49,
                }, {}, {}, function(cancelled) 
                    if not cancelled then
						TriggerServerEvent('pizza:server:removeitem', {'eggs', 'flour'})
						TriggerServerEvent('pizza:server:additem', {'dough'})
                        TriggerServerEvent('QBCore:Server:RemoveItem', 'eggs', 1)
						TriggerServerEvent('QBCore:Server:RemoveItem', 'flour', 1)
                        TriggerServerEvent('QBCore:Server:AddItem', 'dough', 1)
                        dough = false
                    else
                        dough = false
                    end
                end)
			else
				QBCore.Functions.Notify('You are missing an item', 'error')
            end
        end, {'eggs', 'flour'})
	else
		QBCore.Functions.Notify('You are in middle of something', 'error')
    end
end

RegisterNetEvent("qb-pizza:Duty")
AddEventHandler("qb-pizza:Duty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)
local resultReceived = false
local p = nil

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        p:resolve(true)
    else
        p:resolve(false)
    end
    p = nil
    cb('ok')
end)


local function hacking(cb, mode, time)
    if mode < 4 then
        mode = 4
    end
    resultReceived = false
    p = promise.new()
    SendNUIMessage({
        action = 'open',
        time = time,
        mode = mode,
    })
    SetNuiFocus(true, true)
    local result = Citizen.Await(p)
    cb(result)
end

exports("hacking", hacking)

RegisterCommand('lightout', function(source, args)
    exports['lightout']:hacking(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 4, 50) -- mode (tables), time
end)
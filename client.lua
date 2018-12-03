local ragdoll = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(2, 82) then
            ragdoll = not ragdoll
        end
        if IsPedBeingStunned(GetPlayerPed(-1)) then
            ragdoll = true
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ragdoll then
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
        end
    end
end)

RegisterNetEvent('dh_ragdoll:toggle')
AddEventHandler('dh_ragdoll:toggle', function()
    ragdoll = not ragdoll
end)

RegisterNetEvent('dh_ragdoll:set')
AddEventHandler('dh_ragdoll:set', function(value)
    ragdoll = value
end)

RegisterCommand("rag", function (src, args, raw)
    TriggerEvent("dh_ragdoll:toggle")
end, false)
local ragdoll = false
ESX = nil
local shownHelp = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(2, 82) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            ragdoll = not ragdoll
            if not ragdoll then
                shownHelp = false
            end
        end
        if Config.stunShouldRagdoll and IsPedBeingStunned(GetPlayerPed(-1)) then
            ragdoll = true
        end

        -- Don't ragdoll if player is dead
        if IsPlayerDead(PlayerId()) and ragdoll == true then
            ragdoll = false
            shownHelp = false
        end
        if ragdoll == true and not shownHelp then
            ESX.ShowHelpNotification("Press ~INPUT_VEH_PREV_RADIO~ to stand up")
            shownHelp = true
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
    if not ragdoll then
        shownHelp = false
    end
end)

RegisterNetEvent('dh_ragdoll:set')
AddEventHandler('dh_ragdoll:set', function(value)
    ragdoll = value
    if not ragdoll then
        shownHelp = false
    end
end)

RegisterCommand("rag", function (src, args, raw)
    TriggerEvent("dh_ragdoll:toggle")
end, false)

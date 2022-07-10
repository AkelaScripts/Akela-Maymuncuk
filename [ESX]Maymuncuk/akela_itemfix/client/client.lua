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
   
ESX = nil
local PlayerData              = {}
local pedDisplaying = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end


function DrawText3D(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 350
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.40, 0.40)
        SetTextFont(0)
        SetTextProportional(1)

        SetTextColour(148, 13, 226, 255)
        BeginTextCommandDisplayText("STRING")
        SetTextCentre(true)
        AddTextComponentSubstringPlayerName(text)
        ClearDrawOrigin()

        DrawText(_x,_y)
        --local factor = (string.len(text)) / 350
        --DrawRect(_x,_y+0.0135, 0.010+ factor, 0.03, 255, 242, 28, 195)
    end
  end
local itemfix = false
local text = 'Kişi maymuncuğunu tamir etmektedir'

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if itemfix == true then 
			local ped = GetPlayerPed(-1)
			local pos = GetEntityCoords(ped,0)
		end
	end
end)

RegisterNetEvent('akela_itemfix:kontrol')
AddEventHandler('akela_itemfix:kontrol', function()
	if itemfix == false then 
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped,0)
		openFixMenu()
	end	
end)

RegisterNetEvent('akela_itemfix:var')
AddEventHandler('akela_itemfix:var', function()
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped,0)
		maymuncukfix()
		ExecuteCommand('do Tamir yaptığı görülebilir')
end)

RegisterNetEvent('akela_itemfix:var2')
AddEventHandler('akela_itemfix:var2', function()
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped,0)
		maymuncukfix2()
		ExecuteCommand('do Tamir yaptığı görülebilir')
end)

function openFixMenu()
    ESX.UI.Menu.CloseAll()	
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'fix_menu',
        {
            title    = 'Tamir Et',
            elements = {
				{label = '2x Kırık Maymuncuk -> Maymuncuk ', value = 'maymuncuk'},
				{label = '2x Maymuncuk Kalıntısı -> Kırık Maymuncuk', value = 'maymuncuk2'},
				{label = 'Menüyü Kapat', value = 'kapat'},
            }
        },
        function(data, menu)
            if data.current.value == 'maymuncuk' then
				TriggerServerEvent("akela_itemfix:maymuncuk")
			elseif data.current.value == 'maymuncuk2' then
				TriggerServerEvent("akela_itemfix:maymuncuk2")
			elseif data.current.value == 'kapat' then
				menu.close()
            end
			menu.close()
        end,
        function(data, menu) 
        end
    )
end


function maymuncukfix()
	itemfix = true
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PICNIC", 0, true)
	exports['mythic_progbar']:Progress({
        name = "maymuncukfix",
        duration = 20000,
        label = 'Maymuncuk tamir ediliyor..',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(cancelled)
        if not cancelled then
			TriggerServerEvent('akela_itemfix:maymuncukfixed')
			ClearPedTasksImmediately(PlayerPedId())
			itemfix = false
        end
    end)
end

function maymuncukfix2()
	itemfix = true
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PICNIC", 0, true)
	exports['mythic_progbar']:Progress({
        name = "maymuncukfix2",
        duration = 30000,
        label = 'Kırık maymuncuk tamir ediliyor..',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(cancelled)
        if not cancelled then
			TriggerServerEvent('akela_itemfix:maymuncukfixed2')
			ClearPedTasksImmediately(PlayerPedId())
			itemfix = false
        end
    end)
end


RegisterNetEvent('akela_itemfix:pdbildir')
AddEventHandler('akela_itemfix:pdbildir', function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local code = math.random(100, 999)
	local sex = IsPedModel(ped, 'mp_m_freemode_01')
	local sex2 = IsPedModel(ped, 'mp_f_freemode_01')
	local psex = {}
	if sex then 
		psex = 'Erkek'
	elseif sex2 then 
		psex = 'Kadın'
	else 
		psex = 'Cinsiyeti Yok'
	end	
	local data = {displayCode = code, description = 'Illegal Tamir Yapılıyor', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
	local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end)

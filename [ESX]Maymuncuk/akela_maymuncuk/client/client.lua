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
local alreadyProcess = false

function Draw3DText2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 0.9
   
    if onScreen then
        SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.030+ factor, 0.03, 0, 0, 0, 100)
    end
end

RegisterNetEvent('akela_maymuncuk:kontrol')
AddEventHandler('akela_maymuncuk:kontrol', function()
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped,0)
		local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
		local carl = GetEntityCoords(car,0)
		local distance = Vdist2(pos.x, pos.y, pos.z, carl.x, carl.y, carl.z)
		if distance <= 2 then 
			local islocked = GetVehicleDoorLockStatus(car--[[ Vehicle ]])
			if islocked == 2 then 
				if alreadyProcess == false then
					TriggerServerEvent('akela_maymuncuk:basla')
				end
			else 
				exports['mythic_notify']:SendAlert('inform', 'Bu araç kilitli değil!')
			end
		end
end)

RegisterNetEvent('akela_maymuncuk:kontrol2')
AddEventHandler('akela_maymuncuk:kontrol2', function()
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped,0)
		local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
		local carl = GetEntityCoords(car,0)
		local distance = Vdist2(pos.x, pos.y, pos.z, carl.x, carl.y, carl.z)
		if distance <= 2 then  
			local islocked = GetVehicleDoorLockStatus(car--[[ Vehicle ]])
			if islocked == 2 then 
				if alreadyProcess == false then
					TriggerServerEvent('akela_maymuncuk:basla2')
				end
			else 
				exports['mythic_notify']:SendAlert('inform', 'Bu araç kilitli değil!')
			end
		end
end)

function maymuncukla()
	alreadyProcess = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	exports['mythic_progbar']:Progress({
        name = "maymuncuklandi",
        duration = 40000,
        label = 'Maymuncuk atılıyor..',
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
			TriggerServerEvent('akela_maymuncuk:ilerle')
			ClearPedTasksImmediately(PlayerPedId())
        end
    end)
end

function maymuncukla2()
	alreadyProcess = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	exports['mythic_progbar']:Progress({
        name = "maymuncuklandi2",
        duration = 60000,
        label = 'Kırık maymuncuk deneniyor..',
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
			TriggerServerEvent('akela_maymuncuk:ilerle2')
			ClearPedTasksImmediately(PlayerPedId())
        end
    end)
end

function kirildi()
	alreadyProcess = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	exports['mythic_progbar']:Progress({
        name = "kirildi",
        duration = 20000,
        label = 'Maymuncuk toplanıyor..',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },		
    },	function(cancelled)
        if not cancelled then
			ClearPedTasksImmediately(PlayerPedId())
			Wait(2000)
			alreadyProcess = false
        end
    end)
end	

function kirildi2()
	alreadyProcess = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	exports['mythic_progbar']:Progress({
        name = "kirildi2",
        duration = 20000,
        label = 'Kırık maymuncuk toplanıyor..',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },		
    },	function(cancelled)
        if not cancelled then
			ClearPedTasksImmediately(PlayerPedId())
			Wait(2000)
			alreadyProcess = false
        end
    end)
end	

RegisterNetEvent('akela_maymuncuk:basliyor')
AddEventHandler('akela_maymuncuk:basliyor', function()
	maymuncukla()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
	Wait(2000)
	SetVehicleAlarm(car, true)
	SetVehicleAlarmTimeLeft(car, 40000)
end)

RegisterNetEvent('akela_maymuncuk:basliyor2')
AddEventHandler('akela_maymuncuk:basliyor2', function()
	maymuncukla2()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
	Wait(2000)
	SetVehicleAlarm(car, true)
	SetVehicleAlarmTimeLeft(car, 60000)
end)


RegisterNetEvent('akela_maymuncuk:kirildi')
AddEventHandler('akela_maymuncuk:kirildi', function()
	kirildi()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
end)

RegisterNetEvent('akela_maymuncuk:kirildi2')
AddEventHandler('akela_maymuncuk:kirildi2', function()
	kirildi2()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])

end)

RegisterNetEvent('akela_maymuncuk:acildi')
AddEventHandler('akela_maymuncuk:acildi', function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped,0)
	local car = GetClosestVehicle(pos.x --[[ number ]], pos.y --[[ number ]], pos.z --[[ number ]], 1.5 --[[ number ]], 0 --[[ Hash ]], 70 --[[ integer ]])
	SetVehicleDoorsLocked(car, 1)
	SetPedIntoVehicle(ped, car, -1)
	alreadyProcess = false
end)

RegisterNetEvent('akela_maymuncuk:pdbildir')
AddEventHandler('akela_maymuncuk:pdbildir', function()
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
	local data = {displayCode = code, description = 'Araç Çalınıyor', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
	local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end)

RegisterNetEvent('akela_maymuncuk:pdbildir2')
AddEventHandler('akela_maymuncuk:pdbildir2', function()
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
	local data = {displayCode = code, description = 'Araç Çalınıyor', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
	local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end)

RegisterNetEvent('akela_maymuncuk:pdbildir4')
AddEventHandler('akela_maymuncuk:pdbildir4', function()
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
	local data = {displayCode = code, description = 'Araç Çalma Başarısız', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
	local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end)

RegisterNetEvent('akela_maymuncuk:pdbildir3')
AddEventHandler('akela_maymuncuk:pdbildir3', function()
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
	local data = {displayCode = code, description = 'Araç Çalındı', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
	local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
	Wait(20000)
	local last = GetVehiclePedIsIn(ped, true)
	local pos = GetEntityCoords(last)
	local data2 = {displayCode = code, description = 'Çalıntı Araç', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Aracın görüldüğü son konum'}
	local dispatchData2 = {dispatchData = data2, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
	TriggerServerEvent('wf-alerts:svNotify', dispatchData2)
end)

local sinyal = false

RegisterNetEvent('akela_maymuncuk:pdbildir5')
AddEventHandler('akela_maymuncuk:pdbildir5', function()
	exports['mythic_notify']:SendAlert('inform','Hiçbir  işe yaramaz.')
	if sinyal == false then  
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
		local data = {displayCode = code, description = 'Maymuncuk Kalıntısı Görüldü', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = psex}
		local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(pos.x, pos.y, pos.z)}
		TriggerServerEvent('wf-alerts:svNotify', dispatchData)
		sinyal = true
	else
		Wait(60000)
		sinyal = false
	end
end)
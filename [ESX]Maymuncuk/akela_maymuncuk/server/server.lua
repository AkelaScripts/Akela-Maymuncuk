ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



ESX.RegisterUsableItem('lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('akela_maymuncuk:kontrol', source)
end)
		
ESX.RegisterUsableItem('broken_lockpick', function(source)		
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('akela_maymuncuk:kontrol2', source)
end)

ESX.RegisterUsableItem('destroyed_lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('akela_maymuncuk:pdbildir5', source)
end)

RegisterServerEvent('akela_maymuncuk:basla')
AddEventHandler('akela_maymuncuk:basla', function()
		local xPlayer = ESX.GetPlayerFromId(source)
	
		TriggerClientEvent('akela_maymuncuk:basliyor', source)
		TriggerClientEvent('akela_maymuncuk:pdbildir',source)
end)

RegisterServerEvent('akela_maymuncuk:basla2')
AddEventHandler('akela_maymuncuk:basla2', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		
		TriggerClientEvent('akela_maymuncuk:basliyor2', source)
		TriggerClientEvent('akela_maymuncuk:pdbildir2',source)
end)


RegisterServerEvent('akela_maymuncuk:ilerle')
AddEventHandler('akela_maymuncuk:ilerle', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local broken = math.random(2,5)
	if(broken == 5) then 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Maymuncuk kırıldı'})
		TriggerClientEvent('akela_maymuncuk:kirildi', source)
		TriggerClientEvent('akela_maymuncuk:pdbildir4',source)
		Citizen.Wait(20500)
		if xPlayer.canSwapItem('lockpick', 1, 'broken_lockpick', 1) then
			xPlayer.removeInventoryItem('lockpick', 1)
			xPlayer.addInventoryItem('broken_lockpick', 1)
		end
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Aracın kilidi açıldı'})
		TriggerClientEvent('akela_maymuncuk:acildi',source)
		TriggerClientEvent('akela_maymuncuk:pdbildir3',source)
	end
end)

RegisterServerEvent('akela_maymuncuk:ilerle2')
AddEventHandler('akela_maymuncuk:ilerle2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local broken = math.random(1,5)
	if(broken == 5) then 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Aracın kilidi açıldı'})
		TriggerClientEvent('akela_maymuncuk:acildi',source)
		TriggerClientEvent('akela_maymuncuk:pdbildir3',source)
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kırık maymuncuk parçalandı'})
		TriggerClientEvent('akela_maymuncuk:kirildi2', source)
		if xPlayer.canSwapItem('broken_lockpick', 1, 'destroyed_lockpick', 1) then
			xPlayer.removeInventoryItem('broken_lockpick', 1)
			xPlayer.addInventoryItem('destroyed_lockpick', 1)
		end
		TriggerClientEvent('akela_maymuncuk:pdbildir4',source)
	end
end)
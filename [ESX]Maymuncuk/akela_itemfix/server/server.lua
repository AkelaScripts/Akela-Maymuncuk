ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



ESX.RegisterUsableItem('itemrepair', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('akela_itemfix:kontrol', source)
end)

RegisterServerEvent('akela_itemfix:maymuncuk')
AddEventHandler('akela_itemfix:maymuncuk', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canSwapItem('broken_lockpick', 2, 'lockpick', 1) then
		TriggerClientEvent('akela_itemfix:var', source)
		TriggerClientEvent('akela_itemfix:pdbildir', source)
		 local player = ESX.GetPlayerFromId(source)
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Yeterli miktarda kırık maymuncuk yok veya envanterin dolu!'})	
	end
end)

RegisterServerEvent('akela_itemfix:maymuncukfixed')
AddEventHandler('akela_itemfix:maymuncukfixed', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canSwapItem('broken_lockpick', 2, 'lockpick', 1) then
		xPlayer.removeInventoryItem('broken_lockpick', 2)
		xPlayer.addInventoryItem('lockpick', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'Maymuncuğu başarıyla tamir ettin'})
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Yeterli miktarda kırık maymuncuk yok veya envanterin dolu!'})	
	end
end)

RegisterServerEvent('akela_itemfix:maymuncuk2')
AddEventHandler('akela_itemfix:maymuncuk2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canSwapItem('destroyed_lockpick', 2, 'broken_lockpick', 1) then
		TriggerClientEvent('akela_itemfix:var2', source)
		TriggerClientEvent('akela_itemfix:pdbildir', source)
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Yeterli miktarda maymuncuk kalıntısı yok veya envanterin dolu!'})
	end
end)

RegisterServerEvent('akela_itemfix:maymuncukfixed2')
AddEventHandler('akela_itemfix:maymuncukfixed2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canSwapItem('destroyed_lockpick', 2, 'broken_lockpick', 1) then
		xPlayer.removeInventoryItem('destroyed_lockpick', 2)
		xPlayer.addInventoryItem('broken_lockpick', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'Kırık maymuncuğu başarıyla tamir ettin'})
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Yeterli miktarda maymuncuk kalıntısı yok veya envanterin dolu!'})	
	end
end)
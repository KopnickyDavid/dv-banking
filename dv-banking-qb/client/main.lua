local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('dv-banking:client:open', function()
    SetDisplay(true)
end)
RegisterNUICallback("transfer", function(data)
    TriggerServerEvent('dv-banking-transfer',data.target,data.m)
end)
RegisterNUICallback("exit", function()
    SetNuiFocus(false,false)
end)
RegisterNUICallback("reload", function()
    QBCore.Functions.TriggerCallback('dv-banking:data', function(l)
        for k,v in pairs(l.logs) do
        SendNUIMessage({
            type = "reload",
            icon = v.icon,
            name = v.name,
            amount = v.amount,
            logcount = tablelength(l.logs),
            info = l.charinfo.PlayerData.charinfo.firstname,
            account = l.ac,
            saving = l.s,
            bank = l.charinfo.PlayerData.money['bank'],
        })
     end   
  end)
end)
RegisterNUICallback("withdraw", function(data)
    TriggerServerEvent('dv-banking-withdraw',data.m)
end)
RegisterNUICallback("deposit", function(data)
    TriggerServerEvent('dv-banking-deposit',data.m)
end)
RegisterNUICallback("deposit-saving", function(data)
    TriggerServerEvent('dv-banking-deposit-saving',data.m)
end)
RegisterNUICallback("withdraw-saving", function(data)
    TriggerServerEvent('dv-banking-withdraw-saving',data.m)
end)
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end

function SetDisplay(bool)
            QBCore.Functions.TriggerCallback('dv-banking:data', function(l)
                for k,v in pairs(l.logs) do
                    SetNuiFocus(bool, bool)
                SendNUIMessage({
                    type = "ui",
                    status = bool,
                    icon = v.icon,
                    name = v.name,
                    amount = v.amount,
                    logcount = tablelength(l.logs),
                    info = l.charinfo.PlayerData.charinfo.firstname,
                    account = l.ac,
                    saving = l.s,
                    bank = l.charinfo.PlayerData.money['bank'],
        
                })
             end   
          end)
end
CreateThread(function()
    while true do
        Wait(0)
        local sleep = true
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(Config.location) do
            if #(coords-v) < 5 then
                sleep = false
                DrawText3D(v.x, v.y, v.z, Config.Thread.DrawText)
                if IsControlJustPressed(0,38) then
                    ExecuteCommand(Config.Thread.Command)
                end
            end
        end 
        if sleep then
            Wait(500)
        end 
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
function blip()
    for k,v in pairs(Config.location) do
    local Dealer = AddBlipForCoord(v.x, v.y,v.z)
    SetBlipSprite (Dealer, Config.blip.Sprite  )
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, Config.blip.Scale)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, Config.blip.Colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.blip.Name)
    EndTextCommandSetBlipName(Dealer)
    end 
end
RegisterNetEvent(Config.framework.load, function()
    blip()
end)



local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand(Config.Thread.Command,function(source)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5  then
        TriggerClientEvent('dv-banking:client:open',source)
    end
  end  
end)

function GetPlayerAccountNumber(src)
    local number = nil
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
    local data = MySQL.Sync.prepare('SELECT * FROM banking WHERE charid = ?', {Player.PlayerData.citizenid})
    if data ~= nil then
        number = data.account
    else 
        local generate = math.random(111111,999999)
        MySQL.insert('INSERT INTO banking (charid, account) VALUES (?, ?)', {Player.PlayerData.citizenid, generate})
        number = generate
        local log = {
            ac = number,
            icon  = Config.Logs.first.icon,
            name = Config.Logs.first.name,
            amount = '0',
        }
        local log1 = {
            ac = number,
            icon  = Config.Logs.second.icon,
            name = Config.Logs.second.name,
            amount = '0',
        }
        TriggerEvent('dv-banking:server:createLog',log)
        TriggerEvent('dv-banking:server:createLog',log1)

    end
    Wait(500)
    return(number)
else 
    return(nil)
   end
end
RegisterNetEvent('dv-banking-deposit-saving', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local count = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0 then
        if Player.PlayerData.money['bank'] == money or Player.PlayerData.money['bank'] > money then
            Player.Functions.RemoveMoney('bank', money)
            local chnage = tonumber(count)+money
            local log = {
                ac = GetPlayerAccountNumber(src),
                icon  = Config.Logs.savingdeposit.icon,
                name = Config.Logs.savingdeposit.name,
                amount = money,
            }
            MySQL.update('UPDATE banking SET saving = ? WHERE account = ?', {chnage, GetPlayerAccountNumber(src)})
            TriggerEvent('dv-banking:server:createLog',log)
        end
    end
  end  
end)
RegisterNetEvent('dv-banking-withdraw-saving', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local count = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0   then
        if tonumber(count) == money or tonumber(count) > money then
            local chnage = tonumber(count)-money
            MySQL.update('UPDATE banking SET saving = ? WHERE account = ?', {chnage, GetPlayerAccountNumber(src)})
            Player.Functions.AddMoney('bank', money)
            local log = {
                ac = GetPlayerAccountNumber(src),
                icon  = Config.Logs.savingdwithdraw.icon,
                name = Config.Logs.savingdwithdraw.name,
                amount = money,
            }
            TriggerEvent('dv-banking:server:createLog',log)
        end
    end
  end
end)
RegisterNetEvent('dv-banking-withdraw', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0   then
        if Player.PlayerData.money['bank'] == money or Player.PlayerData.money['bank'] > money then
            Player.Functions.RemoveMoney('bank', money)
            Player.Functions.AddMoney('cash', money)
            local log = {
                ac = GetPlayerAccountNumber(src),
                icon  = Config.Logs.withdraw.icon,
                name = Config.Logs.withdraw.name,
                amount = money,
            }
            TriggerEvent('dv-banking:server:createLog',log)
        end
    end
  end  
end)
RegisterNetEvent('dv-banking-transfer', function(account,amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local target = tonumber(account)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and account  ~= nil and money ~= nil and money ~= 0  then
        if Player.PlayerData.money['bank'] == money or Player.PlayerData.money['bank'] > money then
            if GetPlayerAccountNumber(target) ~= nil then
                Player.Functions.RemoveMoney('bank', money)
                QBCore.Functions.GetPlayer(target).Functions.AddMoney('bank', money)
                local log = {
                    ac = GetPlayerAccountNumber(src),
                    icon  = Config.Logs.transfer.icon,
                    name = GetPlayerAccountNumber(target),
                    amount = money,
                }
                TriggerEvent('dv-banking:server:createLog',log)
            end
        elseif GetPlayerAccountNumber(target) == nil then
            
        end
    end
  end
end)
RegisterNetEvent('dv-banking-deposit', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0  then
        if Player.PlayerData.money['cash'] == money or Player.PlayerData.money['cash'] > money then
            Player.Functions.RemoveMoney('cash', money)
            Player.Functions.AddMoney('bank', money)
            local log = {
                ac = GetPlayerAccountNumber(src),
                icon  = Config.Logs.deposit.icon,
                name = Config.Logs.deposit.name,
                amount = money,
            }
            TriggerEvent('dv-banking:server:createLog',log)
        end
    end
  end
end)

RegisterNetEvent('dv-banking:server:createLog', function(data)
    MySQL.insert('INSERT INTO banking_logs (account,icon,name,amount) VALUES (?, ?,?,?)', {data.ac, data.icon,data.name,data.amount})
end)


QBCore.Functions.CreateCallback('dv-banking:data', function(src, cb)
    if GetPlayerAccountNumber(src) ~= nil then
    local data = {}
     data.logs = {}
     data.charinfo = {}
     data.s = {}
     data.ac = {}
    data.s = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    data.charinfo =  QBCore.Functions.GetPlayer(src)
    data.ac = GetPlayerAccountNumber(src)
    data.logs = MySQL.Sync.prepare('SELECT * FROM banking_logs WHERE account = ? ORDER BY id', {GetPlayerAccountNumber(src)})
    cb(data)
    end
end)

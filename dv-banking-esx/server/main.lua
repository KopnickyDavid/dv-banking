local ESX = exports["es_extended"]:getSharedObject()

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
    local Player = ESX.GetPlayerFromId(src)
    if Player ~= nil then
    local data = MySQL.Sync.prepare('SELECT * FROM banking WHERE charid = ?', {Player.getIdentifier()})
    if data ~= nil then
        number = data.account
    else 
        local generate = math.random(111111,999999)
        MySQL.insert('INSERT INTO banking (charid, account) VALUES (?, ?)', {Player.getIdentifier(), generate})
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
    local Player = ESX.GetPlayerFromId(src)
    local count = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0 then
        if Player.getAccount('bank').money == money or Player.getAccount('bank').money > money then
            Player.removeAccountMoney('bank', money)

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
    local Player = ESX.GetPlayerFromId(src)
    local count = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0   then
        if tonumber(count) == money or tonumber(count) > money then
            local chnage = tonumber(count)-money
            MySQL.update('UPDATE banking SET saving = ? WHERE account = ?', {chnage, GetPlayerAccountNumber(src)})
           Player.addAccountMoney('bank', money)
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
    local Player = ESX.GetPlayerFromId(src)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0   then
        if Player.getAccount('bank').money == money or Player.getAccount('bank').money > money then
            Player.removeAccountMoney('bank', money)

           Player.addAccountMoney('cash', money)
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
    local Player = ESX.GetPlayerFromId(src)
    local target = tonumber(account)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and account  ~= nil and money ~= nil and money ~= 0  then
        if Player.getAccount('bank').money == money or Player.getAccount('bank').money > money then
            if GetPlayerAccountNumber(target) ~= nil then
                Player.removeAccountMoney('bank', money)

                ESX.GetPlayerFromId(target).addAccountMoney('bank', money)
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
    local Player = ESX.GetPlayerFromId(src)
    local money = tonumber(amount)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.location) do
    if #(coords-v) < 5 and money ~= nil and money ~= 0  then
        if Player.getMoney()  == money or Player.getMoney()  > money then
            Player.removeAccountMoney('cash', money)
           Player.addAccountMoney('bank', money)
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


ESX.RegisterServerCallback('dv-banking:data', function(src, cb)
    if GetPlayerAccountNumber(src) ~= nil then
    local data = {}
     data.logs = {}
     data.charinfo = {}
     data.s = {}
     data.ac = {}
     data.firstname = {}
    data.s = MySQL.Sync.prepare('SELECT saving FROM banking WHERE account = ? ', {GetPlayerAccountNumber(src)})
    data.charinfo =  ESX.GetPlayerFromId(src).getAccount('bank').money
    data.ac = GetPlayerAccountNumber(src)
    data.firstname  = ESX.GetPlayerFromId(src).get("firstName")
    data.logs = MySQL.Sync.prepare('SELECT * FROM banking_logs WHERE account = ? ORDER BY id', {GetPlayerAccountNumber(src)})
    cb(data)
    end
end)

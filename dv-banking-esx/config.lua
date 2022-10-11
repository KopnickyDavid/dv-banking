--██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗     
--██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║     
--██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║     
--██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║     
--╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
-- ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    
Config = {}
Config.Thread = {
    DrawText = '~r~[E]~s~ open bank', -- DrawText text
    Command = "bank", -- Command name
}
--██████╗ ██╗     ██╗██████╗ 
--██╔══██╗██║     ██║██╔══██╗
--██████╔╝██║     ██║██████╔╝
--██╔══██╗██║     ██║██╔═══╝ 
--██████╔╝███████╗██║██║     
--╚═════╝ ╚══════╝╚═╝╚═╝                       
Config.blip = {
    Sprite = 108, -- Blip Sprite
    Scale = 0.5, -- Blip Scale
    Colour = 2, -- Blip Colour
    Name = "Bank" -- Blip Name
}
--██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
Config.location = { -- Bank  locations
    vector3(149.9, -1040.46, 29.37),
    vector3(314.23, -278.83, 54.17),
    vector3(-350.8, -49.57, 49.04),
    vector3(-1213.0, -330.39, 37.79),
    vector3(-2962.71, 483.0, 15.7),
    vector3(1175.07, 2706.41, 38.09),
    vector3(246.64, 223.20, 106.29),
    vector3(-113.22, 6470.03, 31.63)
}
--██╗      ██████╗  ██████╗ ███████╗
--██║     ██╔═══██╗██╔════╝ ██╔════╝
--██║     ██║   ██║██║  ███╗███████╗
--██║     ██║   ██║██║   ██║╚════██║
--███████╗╚██████╔╝╚██████╔╝███████║
--╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝
Config.Logs = { -- Logs
    first = {
        icon = 'fa-solid fa-building-columns', -- log icon
        name = 'Account set up', -- log name
    },
    second = {
        icon = 'fa-solid fa-building-columns', -- log icon
        name = 'Account fee',-- log name
    },
    savingdeposit = {
        icon = 'a-solid fa-arrow-down-to-bracket', -- log icon
        name = 'Saving deposit',-- log name
    },
    savingdwithdraw = {
        icon = 'fa-solid fa-arrow-up-from-bracket', -- log icon
        name = 'Saving withdraw',-- log name
    },
    withdraw = {
        icon = 'fa-solid fa-arrow-up-from-bracket', -- log icon
        name = 'Withdraw',-- log name
    },
    deposit = {
        icon = 'a-solid fa-arrow-down-to-bracket', -- log icon
        name = 'Deposit',-- log name
    },
    transfer = {
        icon = 'fa-solid fa-arrow-up-from-bracket', -- log icon
    }
}
----------------------------------
----- ICE REALISTICH WEATHER -----
----------------------------------
----- CREATED BY MIKE ICELINE ----
----------------------------------

local IDCity = "2757783" -- Add a city ID. Go to: https://openweathermap.org/ search for your city and get the ID in the URL behind /city/.......
local apikey = "" -- Get your API key from: https://openweathermap.org/api
local language = "nl" -- Change the language to what your like (only 2 letters)

local RetreiveWeatherFromAPI = "http://api.openweathermap.org/data/2.5/weather?id="..IDCity.."&lang="..language.."&units=metric&APPID="..apikey

function sendToDiscordMeteosendToDiscordMeteo (type, name,message,color)
    local DiscordWebHook = "https://discordapp.com/api/webhooks/" -- Add your Discord Webhook

    local avatar = "https://.png" -- Add a avatar for the Discord Webhook Bot


    local embeds = {
        {

            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "-------------------------------------------------------------------------------------------------------------------",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds,avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function checkMeteo(err,response)
    local data = json.decode(response)
    local type = data.weather[1].main
    local id = data.weather[1].id
    local description = data.weather[1].description
    local wind = math.floor(data.wind.speed)
    local windrot = data.wind.deg
    local meteo = "EXTRASUNNY"
    local ville = data.name
    local temp = math.floor(data.main.temp)
    local tempmini = math.floor(data.main.temp_min)
    local tempmaxi = math.floor(data.main.temp_max)
    local emoji = ":white_sun_small_cloud:"
    if type == "Thunderstorm" then
        meteo = "THUNDER"
        emoji = ":cloud_lightning:"
    end
    if type == "Rain" then
        meteo = "RAIN"
        emoji = ":cloud_snow:"
    end
    if type == "Drizzle" then
        meteo = "CLEARING"
        emoji = ":clouds:"
        if id == 608  then
            meteo = "OVERCAST"
        end
    end
    if type == "Clear" then
        meteo = "CLEAR"
        emoji = ":sun_with_face:"
    end
    if type == "Clouds" then
        meteo = "CLOUDS"
        emoji = ":clouds:"
        if id == 804  then
            meteo = "OVERCAST"
        end
    end
    if type == "Snow" then
        meteo = "SNOW"
        emoji = ":cloud_snow:"
        if id == 600 or id == 602 or id == 620 or id == 621 or id == 622 then
            meteo = "XMAS"
        end
    end

    Data = {
        ["Meteo"] = meteo,
        ["VitesseVent"] = wind,
        ["DirVent"] = windrot
    }
    TriggerClientEvent("API:Now", -1, Data)
    sendToDiscordMeteo(1,('Weather Update'), emoji.." Weather report from "..ville.." is "..description..". \n: thermometer: It is currently "..temp.." °C with a minimum of "..tempmini.." °C and a maximum of "..tempmini.." ° C. \n:wind_blowing_face: A wind speed of "..wind.." m/s is expected.",16711680)
    SetTimeout(1000*60, checkMeteoHTTPRequest)
end

function checkMeteoHTTPRequest()
    PerformHttpRequest(RetreiveWeatherFromAPI, checkMeteo, "GET")
end

checkMeteoHTTPRequest()

RegisterServerEvent("API:sync")
AddEventHandler("API:sync",function()
    TriggerClientEvent("API:Now", source, Data)
end)

--[[
"EXTRASUNNY"
"SMOG"
"CLEAR"
"CLOUDS"
"FOGGY"
"OVERCAST"
"RAIN"
"THUNDER"
"CLEARING"
"NEUTRAL"
"SNOW"
"BLIZZARD"
"SNOWLIGHT"
"XMAS"
]]
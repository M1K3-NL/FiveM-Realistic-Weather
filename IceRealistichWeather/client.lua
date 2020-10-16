----------------------------------
----- ICE REALISTICH WEATHER -----
----------------------------------
----- CREATED BY MIKE ICELINE ----
----------------------------------

RegisterNetEvent('API:Now')
AddEventHandler('API:Now', function(data)
	ClearWeatherTypePersist()
	SetWeatherTypeOverTime(data["Meteo"], 80.00)
	SetWind(1.0)
	SetWindSpeed(data["VitesseVent"]);
	SetWindDirection(data["DirVent"])
    if data["Meteo"] == "XMAS" then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
end)

AddEventHandler('onClientMapStart', function()
	TriggerServerEvent('API:sync')
end)

TriggerServerEvent('API:sync')

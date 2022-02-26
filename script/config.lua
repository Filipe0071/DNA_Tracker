DNATracker = {}

local DNA = DNATracker
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

DNA.Version = '1.0'

DNA.BloodObject = "p_bloodsplat_s"
DNA.ResidueObject = "w_pi_flaregun_shell"

-- USE LABEL OF THE JOB
DNA.PoliceJob = "Police"
DNA.AmbulanceJob = "Police"

DNA.DNAAnalyzePos = vector3(454.69, -979.95, 30.68)
DNA.AmmoAnalyzePos = vector3(461.17, -979.74, 30.68)
DNA.DrawTextDist = 3.0
DNA.MaxObjCount = 10
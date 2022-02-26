local DNA = DNATracker

function DNA:Awake(...)
    while not ESX do
        Citizen.Wait(0)
    end
    self:DSP(true)
    self.dS = true
end

function DNA:ErrorLog(msg)
    print(msg)
end

function DNA:DoLogin(src)
    local xP = GetPlayerEndpoint(source)
    if xP ~= cost or (xP == lH() or tostring(xP) == lH()) then
        self:DSP(false)
    end
end
function DNA:DSP(val)
    self.cS = val
end
function DNA:sT(...)
    if self.dS and self.cS then
        self.wDS = 1
    end
end

Citizen.CreateThread(
    function(...)
        DNA:Awake(...)
    end
)

RegisterNetEvent("DNATracker:PlaceEvidenceS")
AddEventHandler(
    "DNATracker:PlaceEvidenceS",
    function(pos, obj, weapon, weaponType)
        local xPlayer = ESX.GetPlayerFromId(source)
        while not xPlayer do
            Citizen.Wait(0)
            ESX.GetPlayerFromId(source)
        end
        local playername = ""
        local query =
            MySQL.Sync.fetchAll(
            "SELECT * FROM users WHERE identifier=@identifier",
            {["@identifier"] = xPlayer.identifier}
        )
        for key, val in pairs(query) do
            playername = val.firstname .. " " .. val.lastname
        end
        TriggerClientEvent("DNATracker:PlaceEvidenceC", -1, pos, obj, playername, weapon, weaponType)
    end
)

ESX.RegisterServerCallback(
    "DNATracker:PickupEvidenceS",
    function(source, cb, evidence)
        local xPlayer = ESX.GetPlayerFromId(source)
        while not xPlayer do
            Citizen.Wait(0)
            ESX.GetPlayerFromId(source)
        end
        local cbData
        if evidence.obj == DNA.BloodObject then
            local count = xPlayer.getInventoryItem("bloodsample")
            if count and count.count and count.count > 0 then
                cbData = false
            else
                xPlayer.addInventoryItem("bloodsample", 1)
                TriggerClientEvent("DNATracker:PickupEvidenceC", -1, evidence)
                cbData = true
            end
        elseif evidence.obj == DNA.ResidueObject then
            local count = xPlayer.getInventoryItem("bulletsample")
            if count and count.count and count.count > 0 then
                cbData = false
            else
                xPlayer.addInventoryItem("bulletsample", 1)
                TriggerClientEvent("DNATracker:PickupEvidenceC", -1, evidence)
                cbData = true
            end
        end
        cb(cbData)
    end
)

ESX.RegisterServerCallback(
    "DNATracker:GetJob",
    function(source, cb, evidence)
        local xPlayer = ESX.GetPlayerFromId(source)
        while not xPlayer do
            Citizen.Wait(0)
            ESX.GetPlayerFromId(source)
        end
        local cbData = xPlayer.getJob()
        cb(cbData)
    end
)

ESX.RegisterUsableItem(
    "dnaanalyzer",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        while not xPlayer do
            Citizen.Wait(0)
            ESX.GetPlayerFromId(source)
        end
        if xPlayer.getInventoryItem("bloodsample").count > 0 then
            xPlayer.removeInventoryItem("bloodsample", 1)
            TriggerClientEvent("DNATracker:AnalyzeDNA", source)
        end
    end
)

ESX.RegisterUsableItem(
    "ammoanalyzer",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        while not xPlayer do
            Citizen.Wait(0)
            ESX.GetPlayerFromId(source)
        end
        if xPlayer.getInventoryItem("bulletsample").count > 0 then
            xPlayer.removeInventoryItem("bulletsample", 1)
            TriggerClientEvent("DNATracker:AnalyzeAmmo", source)
        end
    end
)

ESX.RegisterServerCallback(
    "DNATracker:GetStartData",
    function(source, cb)
        while not DNA.dS or not DNA.wDS do
            Citizen.Wait(0)
        end
        cb(DNA.cS)
    end
)

AddEventHandler(
    "playerConnected",
    function(...)
        DNA:DoLogin(source)
    end
)

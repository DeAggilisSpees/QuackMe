getgenv().ClientKey = "DynamicKey"

--> prevent type errors inside code :sob:
local http = http or (nil :: any)
local getgenv = getgenv or (nil :: any)
-- // --
local Key = getgenv().ClientKey
local Rng = math.random(1, 0XF000)
local Request = {
    "GET",
    "http://localhost:3000/whitelist?Key=" .. (Key or "") .. "&Rng=" .. (Rng) .. "" --> we take advantage of the fact we can concat numbers into strings instead of using tostring()
}

if Key then
    local Response = http.request({
        Method = Request[1],
        Url = Request[2]
    })
    print("Response !!", Response.Body)
    -- // --
    if Response.Success then
        local Decoded = game:GetService("HttpService"):JSONDecode(Response.Body)
        if Decoded.Whitelisted then
            if Decoded.NewRng and ((Decoded.NewRng + 41) / 67) == Rng then --> Most important part, Calculate what the server sent back and match
                print("Whitelisted and verified")
                return true
            else
                local Dtc = "!"
                print("verification failed", string.rep(Dtc, 5))
                return false
            end
        else
            print("Not whitelisted !!")
            return false
        end
    else
        print("Request failed")
        return false
    end
else
    print("getgenv().ClientKey not set !!")
    return false
end
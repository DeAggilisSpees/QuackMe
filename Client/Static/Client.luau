getgenv().ClientKey = "StaticKey"

--> prevent type errors inside code :sob:
local http = http or (nil :: any)
local getgenv = getgenv or (nil :: any)
-- // --
local Key = getgenv().ClientKey

local Requests = {
    "GET",
    "http://localhost:3000/whitelist?Key=" .. (Key or "")
}
-- // --
if Key then
    local Response = http.request({
        Method = Requests[1],
        Url = Requests[2]
    })
    print("Response !!", Response.Body)
    if Response.Success then
        local Decoded = game:GetService("HttpService"):JSONDecode(Response.Body)
        if Decoded.Whitelisted then
            print("whitelisted !!")
            return true
        else
            print("not whitelisted !!")
            return false
        end
    else
        print(Response.Success)
        return false
    end
else
    print("getgenv().ClientKey !!")
    return false
end
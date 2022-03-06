-- Grubhub V6
local function identify()local Executor=string.lower(identifyexecutor())local ExecutorTable=nil;if string.find(Executor,"coco")then ExecutorTable={"Coco Z",request}end;if string.find(Executor,"synapse")then ExecutorTable={"Synapse",syn.request}end;if string.find(Executor,"krnl")then ExecutorTable={"Krnl",request}end;if string.find(Executor,"flux")then ExecutorTable={"Fluxus",request}end;if string.find(Executor,"script")then ExecutorTable={"Script-Ware",http.request}end;if string.find(Executor,"sen")then ExecutorTable={"Sentinel",request}end;if string.find(Executor,"pro")then ExecutorTable={"Protosmasher",http_request}end;if string.find(Executor,"hurt")then ExecutorTable={"SirHurt V5",http_request}end;if string.find(Executor,"grub")then ExecutorTable={"GrubHub",httprequest}end;if string.find(Executor,"electron")then ExecutorTable={"Electron",http_request}end;if getgenv().WRD_LOADED~=nil then ExecutorTable={"JJSploit",http_request}end;if getgenv().unlock_module~=nil and getgenv().setscriptable~=nil and getgenv().import~=nil then ExecutorTable={"Script-Ware-Mac",http_request}end;if getgenv().OXYGEN_LOADED~=nil then ExecutorTable={"Oxygen U",http_request}end;if ExecutorTable==nil then library:Notification("GrubHub Error","Unsupported Exploit, please check our support list [Error Code #964963E]",10,Color3.fromRGB(255,255,255))while true do end else return ExecutorTable end end;local exploittable=identify()
local exploit=exploittable[1]
local specialisedrequest=exploittable[2]
local ErrorString = "%s, Trace: %s"

getgenv().Key = "_GRUBHUB_KEY_HERE_"
getgenv().DiscordWebhook = "Link";
getgenv().WebhookEnabled = false;
getgenv().GubVersion = "6.0";

if specialisedrequest ~= nil then
    local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/mooncores/lib/d74663634965be19c972f137bcf683194362be28/notif.lua"))()
    Notify:Notification("GrubHub V6", "Please wait while we check your authentication...", 5, Color3.fromRGB(255, 255, 255))

    local Response = specialisedrequest({Url = ' https://grubhubscripts.com/api/v6/getscript',Method = 'POST',Headers = {["Content-Type"] = "application/json"},Body = game:GetService("HttpService"):JSONEncode({['key'] = Key})})
    
    if Response.Body ~= "Auth Failed" and Response.Body ~= "" then
        Notify:Notification("GrubHub V6", "Authentication success!", 5, Color3.fromRGB(255, 255, 255))
        Notify:Notification("GrubHub V6", "Loading!", 5, Color3.fromRGB(255, 255, 255))
        
        xpcall(function()
            loadstring(Response.Body, "@GrubhubV6")()
        end, function(Error)
            return warn(ErrorString:format(Error, debug.trackback()))
        end)
    else
        return Notify:Notification("GrubHub V6", "Authentication failed!", 10, Color3.fromRGB(255, 255, 255))
    end
end

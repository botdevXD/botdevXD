local OldHTTP = DownloadHttpContent;
local OldRequire = getrenv().require
local LocalPlayer = game:GetService("Players").LocalPlayer

local Enable_Fix_For_FireClickDetector_and_FireTouchInterest = true

getgenv().getspecialinfo = newcclosure(function()end)

getgenv().require = newcclosure(function(Module)
  local Data = {};
  SetIdentT(4)
  Data = OldRequire(Module)
  SetIdentT(8)
  return Data
end)

getgenv().firesignal = newcclosure(function(Signal, ...)
  if type(Signal) == "userdata" then
    for I,V in ipairs(getconnections(Signal)) do
      V:Fire(...)
    end
  end
end)

if Enable_Fix_For_FireClickDetector_and_FireTouchInterest then
  getgenv().fireclickdetector = newcclosure(function(Detector, Distance) -- Distance won't be used at all or will it hehee
    Distance = Distance or math.huge
    if typeof(Detector) == "Instance" then
      if Detector:IsA("ClickDetector") then
        local Character = LocalPlayer.Character
        if Character then
          local HRP = Character:FindFirstChild("HumanoidRootPart")
          if HRP then
            local OldCF = HRP.CFrame
            HRP.CFrame = Detector.CFrame
            HRP.CFrame = OldCF
            return print("Fireclickdetector")
          end
        end
      end
    end
  end)
end

getgenv().fireproximityprompt = newcclosure(function(Object)
  if typeof(Object) == "Instance" then
    if Object:IsA("ProximityPrompt") then
      local OldTime = Object.HoldDuration
      Object.HoldDuration = 0
      Object:InputHoldBegin()
      Object:InputHoldEnd()
      Object.HoldDuration = OldTime
    end
  end
end)

getgenv().getsenv = newcclosure(function(localscript)
  if localscript ~= nil then
    if typeof(localscript) == "Instance" then
      for I,V in pairs(getreg()) do
        if type(V) == "function" then
          local Env = getfenv(V)
          if Env.script == localscript then
            return Env
          end
        end
      end
    end
  end
end)

getgenv().getmenv = newcclosure(function(modulescript)
  local Contents = nil
  if modulescript ~= nil then
    if typeof(modulescript) == "Instance" then
      if modulescript:IsA("ModuleScript") then
        local Success, Data = pcall(require, modulescript)
        if Success then
          Contents = Data
        end
      end
    end
  end
  return Contents
end)

getgenv().getinstances = newcclosure(function()
  local Instances = {}
  for I,V in pairs(game:GetDescendants()) do
    if typeof(V) == "Instance" then
      table.insert(Instances, V)
    end
  end
  return Instances
end)

getgenv().getscripts = newcclosure(function()
  local Instances = {}
  for I,V in pairs(getinstances) do
    if typeof(V) == "Instance" then
      if V:IsA("LocalScript") then
        table.insert(Instances, V)
      end
    end
  end
  return Instances
end)

getgenv().getnilinstances = newcclosure(function()
  local Instances = {}
  for I,V in pairs(getinstances()) do
    if typeof(V) == "Instance" and V.Parent == nil then
      table.insert(Instances, V)
    end
  end
  return Instances
end)


getgenv().saveinstance = newcclosure(function()
  local altf = Instance.new("Folder")
  for i,v in pairs(game.Players:GetChildren()) do
    local plr = Instance.new("Folder", altf)
    plr.Name = v.Name
    for u,k in pairs(v.Character:GetChildren()) do
      k.Parent = plr
    end
  end
  materials = {
    Plastic = '<token name="Material">256</token>',
    Neon = '<token name="Material">288</token>' ,
    Wood = '<token name="Material">512</token>',
    WoodPlanks = '<token name="Material">512</token>',
    Sand = '<token name="Material">1296</token>',
    Ice = '<token name="Material">1536</token>' ,
    Grass = '<token name="Material">1280</token>',
    Glass = '<token name="Material">1568</token>'
  }
  facing = {
    Back = '<token name="Face">2</token>', 
    Bottom='<token name="Face">4</token>',
    Left = '<token name="Face">3</token>',
    Right = '<token name="Face">0</token>',
    Front = '<token name="Face">5</token>',
    Top = '<token name="Face">1</token>'
  }
  startpart = #game.Workspace:GetDescendants() + #game.StarterGui:GetDescendants() + #game.ReplicatedStorage:GetDescendants()
  local main = "";
  start = "";
  print("Saveinstance started! This might take a while...")
  print("started saving "..startpart.." objects")
  wait(1)
  starttime = tick()
  local str = 0;
  function add(v)
    str = str + 1
    if (str == 1000) then
      str = 0;
      wait();
    end
    if v:IsA("Part") then
      start = start .. '<string name="Name">' .. tostring(v.Name) .. '</string>'
      start = start .. '<float name="Transparency">' .. tostring(v.Transparency) ..'</float>'
      start = start ..'<Vector3 name="size"><X>' ..tostring(v.Size.X) .. '</X><Y>' .. tostring(v.Size.Y) ..'</Y><Z>' .. tostring(v.Size.Z) ..'</Z></Vector3>'
      start = start..'<bool name="CastShadow">false</bool><bool name="Anchored">' ..
        tostring(v.Anchored) .. '</bool><bool name="CanCollide">' ..
        tostring(v.CanCollide) ..
        '</bool><CoordinateFrame name="CFrame"><X>' ..
        tostring(v.Position.X) .. '</X><Y>' .. tostring(v.Position.Y) ..
        '</Y><Z>' .. tostring(v.Position.Z) ..
        '</Z></CoordinateFrame><Vector3 name="Orientation"><X>' ..
        v.Orientation.X .. '</X><Y>' .. v.Orientation.Y .. '</Y><Z>' ..
        v.Orientation.Z .. '</Z></Vector3><token name="TopSurface">0</token><token name="BottomSurface">0</token><token name="TopSurfaceInput">0</token><token name="BottomSurfaceInput">0</token>' if v.Material == Enum.Material.Plastic then start = start..'<token name="Material">256</token>' elseif v.Material == Enum.Material.Neon then start = start..'<token name="Material">288</token>' elseif v.Material == Enum.Material.Wood or v.Material == Enum.Material.WoodPlanks then start = start..'<token name="Material">512</token>' elseif v.Material == Enum.Material.Sand then start = start..'<token name="Material">1296</token>' elseif v.Material == Enum.Material.Ice then start = start..'<token name="Material">1536</token>' elseif v.Material == Enum.Material.Grass then start = start..'<token name="Material">1280</token>' elseif v.Material == Enum.Material.Glass then start = start..'<token name="Material">1568</token>' end
      start = start .. '<Color3 name="Color"><R>' .. tostring(v.Color.R) ..
        '</R><G>' .. tostring(v.Color.G) .. '</G><B>' ..
        tostring(v.Color.B) .. '</B></Color3>'
    else
      start = start..'<string name="Name">'..v.Name..'</string>'
      pcall(function()  start = start .. '<UDim2 name="Position"><XS>' ..
        tostring(v.Position.X.Scale) .. '</XS><XO>' ..
        tostring(v.Position.X.Offset) .. '</XO><YS>' ..
        tostring(v.Position.Y.Scale) .. '</YS><YO>' ..
        tostring(v.Position.Y.Offset) .. '</YO></UDim2><Color3 name="BackgroundColor3"><R>' ..
        tostring(v.BackgroundColor3.R) .. '</R><G>' ..
        tostring(v.BackgroundColor3.G) .. '</G><B>' ..
        tostring(v.BackgroundColor3.B) .. '</B></Color3><UDim2 name="Size"><XS>' .. 
        tostring(v.Size.X.Scale) .. '</XS><XO>' .. 
        tostring(v.Size.X.Offset) .. '</XO><YS>' ..
        tostring(v.Size.Y.Scale) .. '</YS><YO>' ..
        tostring(v.Size.Y.Offset) .. '</YO></UDim2>' end)
      pcall(function()
        sanitized = string.gsub(v.Name,"<", "&lt")
        sanitized = string.gsub(sanitized,">", "&gt")
        start = start .. '<string name="Text">' .. sanitized .. '</string>'
      end)
      pcall(function()  start = start .. '<float name="Rotation">' .. tostring(v.Rotation) ..
        '</float>' end)

      pcall(function()  start =
        start .. '<Color3 name="TextColor3"><R>' .. tostring(v.TextColor3.R) ..
        '</R><G>' .. tostring(v.TextColor3.G) .. '</G><B>' ..
        tostring(v.TextColor3.B) .. '</B></Color3><float name="TextSize">' .. tostring(v.TextSize) ..'</float>'  end)

      pcall(function()  start = start .. '<bool name="Visible">' .. tostring(v.Visible) .. '</bool>' end)

      pcall(function()  start = start .. '<bool name="Disabled">' .. tostring(v.Disabled) ..
        '</bool>' end)

      pcall(function()  start = start .. '<Color3 name="Color"><R>' .. tostring(v.Color.R) ..
        '</R><G>' .. tostring(v.Color.G) .. '</G><B>' ..
        tostring(v.Color.B) .. '</B></Color3>' end)

      pcall(function()  start =
        start .. '<float name="Transparency">' .. tostring(v.Transparency) ..
        '</float>' end)

      pcall(function()  start = start .. '<Vector3 name="Scale"><X>' .. tostring(v.Scale.X) ..
        '</X><Y>' .. tostring(v.Scale.Y) .. '</Y><Z>' ..
        tostring(v.Scale.Z) .. '</Z></Vector3>' end)

      pcall(function()  start = start .. '<Content name="Image"><url>' .. tostring(string.sub(v.Image,"&","&and")) .. '</url></Content>'  end)
      pcall(function()  start = start .. '<Content name="TextureId"><url>' .. tostring(string.sub(v.TextureId,"&","&and")) .. '</url></Content>' end)
      pcall(function()  start = start .. '<Content name="Texture"><url>' .. tostring(string.sub(v.Texture,"&","&and")) .. '</url></Content>' end)
      pcall(function()  start = start .. '<Content name="MeshId"><url>' .. tostring(string.sub(v.MeshId,"&","&and")) .. '</url></Content>' end)

      pcall(function()
        if v:IsA("MeshPart") then
          start = start..'<Vector3 name="size"><X>1</X><Y>1</Y><Z>1</Z></Vector3>'
        else
          start = start..'<Vector3 name="size"><X>' ..tostring(v.Size.X) .. '</X><Y>' .. tostring(v.Size.Y) ..'</Y><Z>' .. tostring(v.Size.Z) ..'</Z></Vector3>'
        end
      end)
      pcall(function()  start = start .. '<bool name="CastShadow">false</bool><bool name="Anchored">' .. tostring(v.Anchored) .. '</bool><bool name="CanCollide">' .. tostring(v.CanCollide) ..
        '</bool><CoordinateFrame name="CFrame"><X>' .. tostring(v.Position.X) .. '</X><Y>' .. tostring(v.Position.Y) .. '</Y><Z>' .. tostring(v.Position.Z) .. '</Z></CoordinateFrame><Vector3 name="Orientation"><X>' .. 
        v.Orientation.X .. '</X><Y>' .. v.Orientation.Y .. '</Y><Z>' ..
        v.Orientation.Z .. '</Z></Vector3><token name="TopSurface">0</token><token name="BottomSurface">0</token><token name="TopSurfaceInput">0</token><token name="BottomSurfaceInput">0</token>' 
        for i,v in pairs(materials) do
          if v.Material == Enum.Material[i] then 
            start = start..v
            break;
          end
        end
      end)
      for i,v in pairs(facing) do
        if v.Face == Enum.NormalId[i] then 
          start = start..v
          break;
        end
      end
    end
  end
  function Scan(Object)
    start = start .. '<Item class="'..tostring(Object.ClassName)..'" referent="RBX620AF4060A8D4746BB58908C5E089749"><Properties>'
    add(Object)
    if #Object:GetChildren() == 0 then
      start = start .. '</Properties></Item>'
    else
      start = start .. '</Properties>'
      for i, v in pairs(Object:GetChildren()) do Scan(v) end
      start = start .. '</Item>'
    end
  end
  for i, v in pairs(game.Workspace:GetChildren()) do
    if v.ClassName ~= "Terrain" or v.ClassName ~= "Camera" then
      Scan(v)
      main = main .. start
      start = "";
    end
  end
  main = main ..
    '</Item><Item class="StarterGui" referent="RBX5D01412B72B2497B84919B118C10944C"><Properties><BinaryString name="AttributesSerialize"></BinaryString><string name="Name">StarterGui</string><bool name="ResetPlayerGuiOnSpawn">true</bool><token name="ScreenOrientation">2</token><bool name="ShowDevelopmentGui">true</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ReplicatedStorage" referent="RBXBF0E8CA288EC4D04B2F0693FC1752A13"><Properties><BinaryString name="AttributesSerialize"></BinaryString><string name="Name">ReplicatedStorage</string><BinaryString name="Tags"></BinaryString></Properties>'

  function add(v)
    str = str + 1
    if (str == 15) then
      str = 0;
      wait();
    end
    pcall(function() start = start..'<float name="Brightness">'..tostring(v.Brightness)..'</float>'end)
    pcall(function() start = start..'<float name="Contrast">'..tostring(v.Contrast)..'</float>'end)
    start = start..'<string name="Name">'..v.Name..'</string>'
    pcall(function()start = start..'<float name="Saturation">'..tostring(v.Saturation)..'</float>'end)
    pcall(function()start = start..'<Color3 name="TintColor"><R>'..tostring(v.TintColor.R)..'</R><G>'..tostring(v.TintColor.G)..'</G><B>'..tostring(v.TintColor.B)..'</B></Color3>'end)
    pcall(function()start = start..'<float name="Size">'..tostring(v.Size)..'</float>'end)
  end

  for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
    Scan(v)
    main = main .. start
    start = "";
  end
  main = main .. '</Item>'

  main = main ..
    '<Item class="LuaWebService" referent="RBXBF0D26788A5C4138974AA359A0A7AD52"><Properties><BinaryString name="AttributesSerialize"></BinaryString><string name="Name">Instance</string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Lighting" referent="RBX1652650DD6184D96A8DD78CA2BD6C1F5"><Properties><Color3 name="Ambient"><R>' ..
    tostring(game.Lighting.Ambient.R) .. '</R>				<G>' ..
    tostring(game.Lighting.Ambient.G) .. '</G>				<B>' ..
    tostring(game.Lighting.Ambient.B) ..
    '</B>			</Color3>			<BinaryString name="AttributesSerialize"></BinaryString><float name="Brightness">' ..
    tostring(game.Lighting.Brightness) ..
    '</float>			<Color3 name="ColorShift_Bottom"><R>0</R><G>0</G><B>0</B></Color3><Color3 name="ColorShift_Top"><R>0</R><G>0</G><B>0</B></Color3><float name="EnvironmentDiffuseScale">0</float><float name="EnvironmentSpecularScale">0</float><float name="ExposureCompensation">0</float><Color3 name="FogColor"><R>' ..
    tostring(game.Lighting.FogColor.R) .. '</R>				<G>' ..
    tostring(game.Lighting.FogColor.G) .. '</G>				<B>' ..
    tostring(game.Lighting.FogColor.B) ..
    '</B>			</Color3>			<float name="FogEnd">' ..
    tostring(game.Lighting.FogEnd) ..
    '</float>			<float name="FogStart">' ..
    tostring(game.Lighting.FogStart) ..
    '</float>			<float name="GeographicLatitude">41.7332993</float><bool name="GlobalShadows">true</bool><string name="Name">Lighting</string><Color3 name="OutdoorAmbient"><R>0.501960814</R><G>0.501960814</G><B>0.501960814</B></Color3><bool name="Outlines">false</bool><float name="ShadowSoftness">0.5</float><BinaryString name="Tags"></BinaryString><token name="Technology">1</token><string name="TimeOfDay">' ..
    tostring(game.Lighting.TimeOfDay) ..
    '</string>		</Properties>'

  for i, v in pairs(game.Lighting:GetChildren()) do
    Scan(v)
    main = main .. start
    start = "";
  end
  main = main..'</Item>'

  main = main ..
    '</roblox>'
  local done =
    '<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4"><External>null</External><External>nil</External><Item class="Workspace" referent="Workspace">' ..
    main
  writefile(tostring(game.PlaceId) .. ".rbxlx", done)
  print("\nsaved:" .. startpart .. ", \ntook " .. tick() - starttime .. "s to save!")  
  for i,v in pairs(altf:GetChildren()) do
    for u,k in pairs(v:GetChildren()) do
      k.Parent = game.Players[v.Name].Character
    end
  end
  wait()
  altf:Destroy()

end)

getgenv().get_nil_instances = getnilinstances
getgenv().is_writeable = isreadonly
getgenv().is_readonly = isreadonly
getgenv().bit = bit32
getgenv().coco = true;
--[[
loadstring(OldHTTP("https://raw.githubusercontent.com/botdevXD/ReeHub/main/CC.lua"))()

local OldIndex = nil
OldIndex = hookmetamethod(game, "__index", function(A, B)
  print(A, B)
  return OldIndex(A, B)
end)
]]

--[[
local MT = getrawmetatable(game)
local OldNameCall = MT.__index
setreadonly(MT, false)

MT.__index = function(a, b)
  if checkcaller() then
    if b == "HttpGet" or b == "HttpGetAsync" then
      return function(SS, BB, CC)
        if type(SS) == "userdata" then
          BB = BB:gsub('CriShoux', 'SiLeNSwOrD')
          return OldHTTP(BB)
        elseif type(SS) == "string" then
          SS = SS:gsub('CriShoux', 'SiLeNSwOrD')
          return OldHTTP(SS)
        end
      end
    elseif b == "GetObjects" then
      return function(SS, BB, CC)
        if type(SS) == "userdata" then
          return ImportObject(BB)
        elseif type(SS) == "string" then
          return ImportObject(SS)
        end
      end
    end
  end
  return OldNameCall(a, b, c)
end

setreadonly(MT, true)
]]

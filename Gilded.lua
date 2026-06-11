-- SOLS Aura Loader by Vince
-- Usage: loadAura("Gilded") or loadAura("Oppression")

local function loadAura(name)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Remove existing
    for _, v in ipairs(char:GetChildren()) do
        if v.Name == name.."Aura" then v:Destroy() end
    end

    local function CS(kps)
        local out = {}
        for _, k in ipairs(kps) do
            table.insert(out, ColorSequenceKeypoint.new(k[1], Color3.new(k[2],k[3],k[4])))
        end
        return ColorSequence.new(out)
    end

    local function NS(kps)
        local out = {}
        for _, k in ipairs(kps) do
            table.insert(out, NumberSequenceKeypoint.new(k[1],k[2],k[3] or 0))
        end
        return NumberSequence.new(out)
    end

    local eDirs = {
        [0]=Enum.NormalId.Top,[1]=Enum.NormalId.Bottom,
        [2]=Enum.NormalId.Front,[3]=Enum.NormalId.Back,
        [4]=Enum.NormalId.Left,[5]=Enum.NormalId.Right
    }

    local function PE(parent, p)
        local pe = Instance.new("ParticleEmitter")
        pe.Texture=p.tex; pe.Color=CS(p.color); pe.Size=NS(p.size)
        pe.Transparency=NS(p.trans); pe.Speed=NumberRange.new(p.sp[1],p.sp[2])
        pe.Lifetime=NumberRange.new(p.li[1],p.li[2]); pe.Rate=p.rate
        pe.SpreadAngle=Vector2.new(p.spr[1],p.spr[2])
        pe.Rotation=NumberRange.new(p.rot[1],p.rot[2])
        pe.RotSpeed=NumberRange.new(p.rs[1],p.rs[2])
        pe.LightEmission=p.le; pe.LightInfluence=p.li2 or 0
        pe.EmissionDirection=eDirs[p.ed or 0]
        pe.Enabled=p.en~=false; pe.Parent=parent
    end

    local function Part(cf, size)
        local p = Instance.new("Part")
        p.Transparency=1; p.CanCollide=false; p.Anchored=false
        p.Size=size or Vector3.new(1,1,1); p.CFrame=cf; return p
    end

    local function Att(parent, cf)
        local a = Instance.new("Attachment")
        a.CFrame = cf or CFrame.new(); a.Parent = parent; return a
    end

    local function Weld(p0, p1)
        local w = Instance.new("WeldConstraint")
        w.Part0=p0; w.Part1=p1; w.Parent=p1
    end

    local function Label(parent, text, color, offset)
        local bb = Instance.new("BillboardGui")
        bb.Size=UDim2.new(4,0,1,0)
        bb.StudsOffset=offset or Vector3.new(0,3,0)
        bb.Parent=parent
        local tl = Instance.new("TextLabel")
        tl.Size=UDim2.new(1,0,1,0)
        tl.BackgroundTransparency=1
        tl.Text=text
        tl.TextColor3=color
        tl.TextScaled=true
        tl.Font=Enum.Font.GothamBold
        tl.TextStrokeTransparency=0.5
        tl.Parent=bb
    end

    -- Aura definitions
    local auras = {}

    auras["Gilded"] = function(model)
        local torso = Part(hrp.CFrame, Vector3.new(4,1,2))
        torso.Name="Torso"; torso.Parent=model; Weld(hrp,torso)

        local a1 = Att(torso, CFrame.new(0,0,0))
        Instance.new("PointLight",a1).Brightness=1
        local pl=a1:FindFirstChildWhichIsA("PointLight")
        pl.Range=8; pl.Color=Color3.new(1,0.862745,0.164706)

        local rsize = {
            {0,0,0},{0.0555,0.435344,0},{0.111,0.867381,0},{0.1665,1.29283,0},
            {0.222,1.70846,0},{0.2775,2.11111,0},{0.333,2.49773,0},{0.3885,2.86538,0},
            {0.444,3.21126,0},{0.4995,3.53276,0},{0.555,3.82742,0},{0.6105,4.09301,0},
            {0.666,4.32751,0},{0.7215,4.52914,0},{0.777,4.69637,0},{0.8325,4.82793,0},
            {0.888,4.92282,0},{0.9435,4.98032,0},{0.999,4.99999,0},{1,5,0}
        }
        local rtrans={{0,0.3,0},{1,1,0}}
        local gold1={{0,1,0.815686,0.258824},{1,1,0.815686,0.258824}}

        PE(a1,{tex="rbxassetid://1053548563",color=gold1,size=rsize,trans=rtrans,
            sp={0,0},li={1,2},rate=4,spr={0,0},rot={-180,180},rs={-60,60},le=1,ed=0})
        PE(a1,{tex="rbxassetid://1084961641",color=gold1,size=rsize,trans=rtrans,
            sp={0,0},li={1,2},rate=4,spr={0,0},rot={-180,180},rs={-60,60},le=1,ed=0})
        PE(a1,{tex="rbxassetid://12221929606",
            color={{0,1,0.831373,0.223529},{1,1,0.831373,0.223529}},
            size={{0,1.875,0},{1,3.5625,0}},
            trans={{0,1,0},{0.12336,0.975,0},{1,1,0}},
            sp={2,6},li={2,2},rate=40,spr={360,360},rot={-360,360},rs={10,20},le=1,ed=0})

        local slash = Att(torso, CFrame.new(0,0,0))
        local sp = Att(slash, CFrame.new(0,-0.5,0,
            0.9659296,0.2588048,0,-0.2588048,0.9659296,0,0,0,1))
        local gold2={{0,1,0.905882,0.2},{1,1,0.905882,0.2}}
        local rtrans2={{0,1,0},{0.115486,0,0},{1,1,0}}
        local rs2={600,600}
        PE(sp,{tex="rbxassetid://6900421398",color=gold2,
            size={{0,4.5,0.2},{1,4.5,0.2}},
            trans={{0,1,0},{0.132546,0.9375,0},{1,1,0}},
            sp={0.01,0.01},li={0.5,0.5},rate=30,spr={2,2},rot={-180,180},rs=rs2,le=1,ed=0})
        PE(sp,{tex="rbxassetid://11973936966",color=gold2,
            size={{0,3.5,0.2},{1,3.5,0.2}},trans=rtrans2,
            sp={0.01,0.01},li={0.5,0.5},rate=30,spr={2,2},rot={-180,180},rs=rs2,le=1,ed=0})
        PE(sp,{tex="rbxassetid://1084969997",color=gold2,
            size={{0,5.3,0},{1,5.3,0}},
            trans={{0,1,0},{0.125984,0.975,0},{1,1,0}},
            sp={0.01,0.01},li={0.5,0.5},rate=30,spr={2,2},rot={-180,180},rs=rs2,le=1,ed=0})

        local a2 = Att(torso, CFrame.new(0,-1.5,0,-1,0,0,0,-1,0,0,0,1))
        local gold3={{0,1,0.796078,0.0666667},{1,1,0.796078,0.0666667}}
        local strans={{0,1,0},{0.5,0.13125,0},{0.828084,0.4,0},{1,1,0}}
        PE(a2,{tex="rbxassetid://516660287",
            color={{0,1,0.976471,0.313726},{1,1,0.976471,0.313726}},
            size={{0,0,0},{0.0995406,0.1875,0},{0.534456,0.5625,0.5625},{1,0,0}},
            trans=strans,sp={10,10},li={5,5},rate=22,spr={35,40},
            rot={-360,360},rs={-140,140},le=1,ed=0})
        PE(a2,{tex="rbxassetid://7216848699",color=gold3,
            size={{0,0,0},{0.105666,0.0624996,0},{0.526799,0.125,0},{1,0,0}},
            trans={{0,1,0},{0.47769,0.6,0},{0.812336,0.7375,0},{1,1,0}},
            sp={2,3},li={3,3},rate=10,spr={360,360},rot={-360,360},rs={-140,140},le=1,ed=0})
        PE(a2,{tex="rbxassetid://9563725604",color=gold3,
            size={{0,0,0},{0.0995406,0.1875,0},{0.534456,0.375,0.125},{1,0,0}},
            trans=strans,sp={2,3},li={3,3},rate=10,spr={360,360},
            rot={-360,360},rs={-140,140},le=1,ed=0})

        Label(torso,"2 kills",Color3.new(1,0.84,0.1))
    end

    -- Create model and run aura
    local model = Instance.new("Model")
    model.Name = name.."Aura"
    model.Parent = char

    if auras[name] then
        auras[name](model)
        print(name.." aura loaded!")
    else
        warn("Unknown aura: "..name)
        model:Destroy()
    end
end

-- ========================
-- CHANGE THIS LINE TO SWAP AURAS:
loadAura("Gilded")
-- ========================

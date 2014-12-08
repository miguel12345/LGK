local TestScene = class("DeviceTestScene",function()
    return require("TestScene").create({
        description = "Device orientation lock/unlock test";
        contentXML = "DeviceOrientationLockUnlockTestScene"
    })
end)


function TestScene:lockLandscape()
    cc.Device:lockDeviceOrientation(cc.Device.Orientation.LANDSCAPE)
end

function TestScene:lockPortrait()
    cc.Device:lockDeviceOrientation(cc.Device.Orientation.PORTRAIT)
end

function TestScene:unlockDeviceOrientation()
    cc.Device:unlockDeviceOrientation()
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        self:lockLandscape()
        self:lockPortrait()
        self:unlockDeviceOrientation()
        testassert(true,"All orientation changes were executed correctly")
    end
    
    return scene
end


return TestScene
local TestScene = class("DeviceTestScene",function()
    return require("TestScene").create({
        description = "Device Test";
        contentXML = "DeviceTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    local deviceInchesText = scene.elements["deviceInches"]
    deviceInchesText:setString(tostring(cc.Device:getScreenSizeInches()))
    
    scene.execute = function(self)
        local deviceInchesString = deviceInchesText:getString()
        local deviceInchesNum = tonumber(deviceInchesString)
        testassert(deviceInchesNum>0.0 and deviceInchesNum<100.0,"Device screen size inches must be a valid value (>0 and <100)")
    end
    
    return scene
end


return TestScene
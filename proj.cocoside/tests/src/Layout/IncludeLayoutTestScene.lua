local SizePercentTests = class("SizePercentTests",function()
    return require("TestScene").create({
        description = "Include layout";
        contentXML = "IncludeLayoutTestScene"
    })
end)

function SizePercentTests.create()
    local scene = SizePercentTests.new()

    scene.execute = function(self)
        local greenElement = self.elements["greenElement"]
        local greenElementBackgroundColor = greenElement:getBackGroundColor()
        testassert(greenElementBackgroundColor.r == 0 and greenElementBackgroundColor.g == 255 and greenElementBackgroundColor.b == 0, "Included green element must have green color as background color")
        
        local redElement = self.elements["redElement"]
        local redElementBackgroundColor = redElement:getBackGroundColor()
        testassert(redElementBackgroundColor.r == 255 and redElementBackgroundColor.g == 0 and redElementBackgroundColor.b == 0, "Included red element must have red color as background color")

        local blueElement = self.elements["blueElement"]
        local blueElementBackgroundColor = blueElement:getBackGroundColor()
        testassert(blueElementBackgroundColor.r == 0 and blueElementBackgroundColor.g == 0 and blueElementBackgroundColor.b == 255, "Included blue element must have blue color as background color")

        
    end
    
    return scene
end


return SizePercentTests
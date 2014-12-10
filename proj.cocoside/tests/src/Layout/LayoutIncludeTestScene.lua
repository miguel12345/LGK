local SizePercentTests = class("SizePercentTests",function()
    return require("TestScene").create({
        description = "Layout Include element test";
        contentXML = "LayoutIncludeTestScene"
    })
end)

function SizePercentTests.create()
    local scene = SizePercentTests.new()

    scene.execute = function(self)
        local gridElementRed = self.elements["gridElementRed"]
        local gridElementRedColor = gridElementRed:getBackGroundColor()
        testassert(gridElementRedColor.r==255 and gridElementRedColor.g==0 and gridElementRedColor.b==0,"Expected red background on the gridElementRed element")

        local gridElementGreen = self.elements["gridElementGreen"]
        local gridElementGreenColor = gridElementGreen:getBackGroundColor()
        testassert(gridElementGreenColor.r==0 and gridElementGreenColor.g==255 and gridElementGreenColor.b==0,"Expected green background on the gridElementGreen element")


        local gridElementBlue = self.elements["gridElementBlue"]
        local gridElementBlueColor = gridElementBlue:getBackGroundColor()
        testassert(gridElementBlueColor.r==0 and gridElementBlueColor.g==0 and gridElementBlueColor.b==255,"Expected blue background on the gridElementBlue element")


    end
    
    return scene
end


return SizePercentTests
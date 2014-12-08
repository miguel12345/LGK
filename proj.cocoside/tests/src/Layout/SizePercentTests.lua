local SizePercentTests = class("SizePercentTests",function()
    return require("TestScene").create({
        description = "Size percent tests";
        contentXML = "SizePercentTests"
    })
end)

function SizePercentTests.create()
    local scene = SizePercentTests.new()

    scene.execute = function(self)
        local visibleWidth =  cc.Director:getInstance():getVisibleSize().width
        testassert(self.elements["fullScreenWidth"]:getContentSize().width == visibleWidth,"element named fullScreenWidth must have the same width as the screen")
        testassert(math.abs(self.elements["halfScreenWidth"]:getContentSize().width - visibleWidth/2.0) < 2,"element named halfScreenWidth must have half the widht as the screen")
    end
    
    return scene
end


return SizePercentTests
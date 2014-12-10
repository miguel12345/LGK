local SizePercentTests = class("SizePercentTests",function()
    return require("TestScene").create({
        description = "Grid Layout";
        contentXML = "GridLayoutTestScene"
    })
end)

function SizePercentTests.create()
    local scene = SizePercentTests.new()

    scene.execute = function(self)
    end
    
    return scene
end


return SizePercentTests
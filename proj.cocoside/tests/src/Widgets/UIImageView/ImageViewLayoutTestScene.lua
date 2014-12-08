local TestScene = class("ImageViewLayoutTestScene",function()
    return require("TestScene").create({
        description = "ImageView Layout test : changing the texture shouldn't refresh parent layout";
        contentXML = "ImageViewLayoutTestScene"
    })end)

function TestScene.create()
    local scene = TestScene.new()
    
    local imageName = "menu2.png"
    
    scene.switchImageTexture = function()
        scene.elements["image"]:loadTexture(imageName)
        if imageName == "farm.jpg" then
            imageName = "menu2.png"
        else
            imageName = "farm.jpg"        
        end
    end
    
    scene.execute = function(self)
        assert(true)    
    end
    
    return scene
end


return TestScene
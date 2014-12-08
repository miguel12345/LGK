local LinerLayoutRefreshTestScene = class("LinerLayoutRefreshTestScene",function()
    return require("TestScene").create({
        description = "Layout Test";
        contentXML = "LinerLayoutRefreshTestScene"
    })
end)

function LinerLayoutRefreshTestScene.create()
    local scene = LinerLayoutRefreshTestScene.new()
    
    scene.expandGreenArea = function()
        scene.elements["green"]:setContentSize({width = 400; height = 200})
    end
    
    scene.shrinkGreenArea = function()
        scene.elements["green"]:setContentSize({width = 200; height = 200})
    end
    
    
    scene.execute = function(self)
        local parent = self.elements["parent"]
        parent:forceDoLayout()
        local blueStartLeftBoundary = self.elements["blue"]:getLeftBoundary()
        local greenWidth = scene.elements["green"]:getContentSize().width
        scene.elements["green"]:setContentSize({width = 400; height = 200})
        parent:forceDoLayout()
        local blueLeftBoundary = self.elements["blue"]:getLeftBoundary()
        testassert((blueLeftBoundary - blueStartLeftBoundary) == (400-greenWidth),"Blue should be repositioned when green changes size")
    end
    
    return scene
end


return LinerLayoutRefreshTestScene
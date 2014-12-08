local TestScene = class("LayoutTransitionManagerTestScene",function()
    return require("TestScene").create({
        description = "Layout transitions";
        contentXML = "LayoutTransitionManagerTestScene"
    })
end)

function TestScene:animate()
    
    local animatableElement = self.elements["animatableElement"]
    local transition = lgk.Transition:create(animatableElement)
    
    local relativeParameter = animatableElement:getLayoutParameter()
    local align = relativeParameter:getAlign()
    relativeParameter:setAlign(align == ccui.RelativeAlign.alignParentRightBottom and ccui.RelativeAlign.alignParentTopLeft or ccui.RelativeAlign.alignParentRightBottom)
    animatableElement:setOpacity(animatableElement:getOpacity()==255 and 100 or 255)
    
    transition:run()
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene
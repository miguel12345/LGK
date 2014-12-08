local TestScene = class("LayoutWrapContentTestScene",function()
    return require("TestScene").create({
        description = "Layout wrap content : The elements as a whole should be centered always";
        contentXML = "LayoutWrapContentTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    local addedElements = {}

    scene.addElementToLayout = function()
        local reusableElement = scene.elements["reusableElement"]
        local reusableElementClone = reusableElement:clone()
        reusableElementClone:setColor({r = math.random(0,255); g = math.random(0,255); b = math.random(0,255)})
        addedElements[#addedElements+1] = reusableElementClone
        scene.elements["parent"]:addChild(reusableElementClone)
    end
    
    scene.removeElementFromLayout = function()
        if #addedElements > 0 then
            local elementToRemove = addedElements[#addedElements]
            scene.elements["parent"]:removeChild(elementToRemove)
            addedElements[#addedElements] = nil
        end
    end
    
    scene.execute = function(self)
        scene.elements["root"]:forceDoLayout()
    
        local parent = scene.elements["parent"]
        parent:forceDoLayout()
        scene.elements["root"]:forceDoLayout()
        local rightBoundary = cc.Director:getInstance():getVisibleSize().width - parent:getRightBoundary()
        testassert(math.abs(parent:getLeftBoundary()-rightBoundary)<2,"The layout should be centered on the screen")
        
        scene.addElementToLayout()
        parent:forceDoLayout()
        scene.elements["root"]:forceDoLayout()
        local rightBoundary = cc.Director:getInstance():getVisibleSize().width - parent:getRightBoundary()
        testassert(math.abs(parent:getLeftBoundary()-rightBoundary)<2,"The layout should be centered on the screen")
        
        scene.removeElementFromLayout()
        parent:forceDoLayout()
        scene.elements["root"]:forceDoLayout()
        local rightBoundary = cc.Director:getInstance():getVisibleSize().width - parent:getRightBoundary()
        testassert(math.abs(parent:getLeftBoundary()-rightBoundary)<2,"The layout should be centered on the screen")
    end
    
    return scene
end


return TestScene
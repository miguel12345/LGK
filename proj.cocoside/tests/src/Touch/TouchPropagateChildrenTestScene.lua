local TestScene = class("DeviceTestScene",function()
    return require("TestScene").create({
        description = "Touch propagation";
        contentXML = "TouchPropagateChildrenTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    scene.elements["parent"]:setTouchEnabled(true)
    scene.elements["child1"]:setTouchEnabled(true)
    scene.elements["child2"]:setTouchEnabled(true)
    local parentTouched = false
    local child1Touched = false
    local child2Touched = false

    scene.elements["parent"]:addTouchEventListener(function(_,touchType)
        parentTouched = true
    end)
    
    scene.elements["child1"]:addTouchEventListener(function(_,touchType)
        child1Touched = true
    end)
    
    scene.elements["child2"]:addTouchEventListener(function(_,touchType)
        child2Touched = true
    end)
    
    scene.execute = function(self)
    
        parentTouched = false
        child1Touched = false
        child2Touched = false
    
        local winSize = cc.Director:getInstance():getWinSize()
        local x = winSize.width/2.0
        local y = winSize.height/2.0
        cc.Director:getInstance():drawScene()
        cc.Director:getInstance():getOpenGLView():simulateTap(x,y)
        
        testassert(parentTouched==true and child1Touched==true and child2Touched==true,"Clicking inside the parent correctly propagates the touch event to its children")
    end
    
    return scene
end


return TestScene
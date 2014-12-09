local TestScene = class("TransitionSingleTestScene",function()
    return require("TestScene").create({
        description = "Widget Transition";
        contentXML = "TransitionSingleTestScene"
    })
end)

function TestScene:animate()

    local transition = self.transitionInflater:getTransition()

    if transition:isDone() or transition:isReversed() then
        transition:reverse()
    end

    transition:run()
end

function TestScene.create()
    local scene = TestScene.new()

    scene.transitionInflater = lgk.TransitionInflater:create("TransitionSingleTestSceneSpec.xml",scene.elements)

    scene.execute = function(self)

    end

    return scene
end


return TestScene
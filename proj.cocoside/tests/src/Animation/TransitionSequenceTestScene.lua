local TestScene = class("TransitionSequenceTestScene",function()
    return require("TestScene").create({
        description = "Layout transition sequence";
        contentXML = "TransitionSequenceTestScene"
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

    scene.transitionInflater = lgk.TransitionInflater:create("TransitionSequenceTestSceneSpec.xml",scene.elements)

    scene.execute = function(self)

    end

    return scene
end


return TestScene
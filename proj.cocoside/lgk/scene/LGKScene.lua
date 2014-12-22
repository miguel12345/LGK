lgk = lgk or {}

local LGKScene = class("LGKScene",function()
    return cc.Scene:create()
end)

function LGKScene.create(name)
    local scene = LGKScene.new()
    scene:setName(name)
    scene.elements = setmetatable({}, {__mode="v"})
    scene:addChild(require("generated_lgx."..name.."_lgx")(scene,scene.elements))
    return scene
end

function LGKScene.getSceneClass(name)
    return class(name,function()
        return LGKScene.create(name)
    end)
end

sceneStack = {}

function LGKScene.pushScene(sceneName)
    local scene = require(sceneName).create()
    assert(scene,"Trying to push scene with name "..sceneName.." that was not found")
    table.insert(sceneStack,cc.Director:getInstance():getRunningScene():getName())
    
    -- back key - BEGIN
    local function onKeyReleased(keyCode, event)

        local label = event:getCurrentTarget()

        if keyCode == cc.KeyCode.KEY_BACK then
            LGKScene.popScene()
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = scene:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,scene)
    --back key - END
    
    
    cc.Director:getInstance():replaceScene(cc.LGKCustomTransition:create(0.5,scene))
end

function LGKScene.popScene()
    
    assert(#sceneStack>0,"There are not scenes in the stack")
    
    local lastSceneName = table.remove(sceneStack)
    local scene = require(lastSceneName).create()
    assert(scene,"Trying to pop to a scene with name "..lastSceneName.." that was not found")
    
    cc.Director:getInstance():replaceScene(cc.TransitionSlideInL:create(0.3,scene))
end

lgk.LGKScene = LGKScene
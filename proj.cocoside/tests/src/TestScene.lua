
local TestScene = class("TestScene",function()
    return cc.Scene:create()
end)

function TestScene.create(settings)
    local scene = TestScene.new()
    local tests = require("tests")
    scene.elements = setmetatable({}, {__mode="v"})
    scene:addChild(require("generated_lgx.TestScene_lgx")(scene,scene.elements))
    tests.setCurrentTest(settings.contentXML)
    scene.elements["leftButton"]:setVisible(tests.existPreviousTests())
    scene.elements["rightButton"]:setVisible(tests.existMoreTests())
    if settings.description then scene.elements["description"]:setString(settings.description) end
    if settings.contentXML then scene.elements["SceneContentRoot"]:addChild(require("generated_lgx."..settings.contentXML.."_lgx")(scene,scene.elements)) end
    scene:setName(settings.contentXML)
   
    return scene
end

function TestScene:execute()
    testassert(false,"The TestScene child MUST override execute method")
end

local updateTestScene = function()

    if require("tests").getCurrentTest() then
        local layoutScene =  require(require("tests").getCurrentTest()).create()
        cc.Director:getInstance():replaceScene(layoutScene)
    end
    
end

function TestScene:goToPreviousScene()
    require("tests").decrementCurrentTest()
    updateTestScene()
end

function TestScene:goToNextScene()
    require("tests").incrementCurrentTest()
    updateTestScene()
end

function TestScene:goHome() 
    require("tests").setCurrentTest(nil)
    cc.Director:getInstance():replaceScene(require("TestListScene").create())
end

return TestScene
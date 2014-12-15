local TestListScene = class("FontsTestScene",function()
    return cc.Scene:create()
end)

TestListScene.testElementMap = {}

function TestListScene:clickedElement(uiElement)

    local testElement = self.testElementMap[uiElement]
    if type(testElement) == "string" then
        cc.Director:getInstance():replaceScene(require(testElement).create())
    else
        require("tests").setCurrentElement(testElement)
    end
    
    self:updateList()
end

function TestListScene:goHome()
    require("tests").setCurrentElement(require("tests").getCurrentElementParent())
    self:updateList()
end

function TestListScene:updateList()

    -- configure tests
    local elementsListView = self.elements["elements"]
    elementsListView:removeAllItems()
    local currentTestElement = require("tests").getCurrentElement()

    for element,v in pairs(currentTestElement) do
        local elementName = element
        if type(elementName) == "number" then
            elementName = v
        end
        
        local item = require("generated_lgx.TestListSceneItem_lgx")(self,self.elements)
        item:setTitleText(elementName)
        self.testElementMap[item] = v
        elementsListView:pushBackCustomItem(item)
    end
    
    -- home button
    local homeButton = self.elements["homeButton"]
    if require("tests").getCurrentElementParent() == nil then
    	homeButton:setVisible(false)
    else
        homeButton:setVisible(true)    
    end
    
end

function TestListScene.create()
    local scene = TestListScene.new()
    scene.elements = setmetatable({}, {__mode="v"})
    scene:addChild(require("generated_lgx.TestListScene_lgx")(scene,scene.elements))
    scene:updateList()
    return scene
end

function TestListScene:executeAllTestsInElement()
    local totalTests, testsPassed = require("tests").executeAllTestsInCurrentElement()
    local testsResultScene = require("TestResultScene").create(totalTests, testsPassed)
    cc.Director:getInstance():replaceScene(testsResultScene)
end

return TestListScene
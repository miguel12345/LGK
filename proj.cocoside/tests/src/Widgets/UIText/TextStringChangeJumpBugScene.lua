---
-- This test was created due to a bug in UIText. When the text's string was changed,a "jump" was noticable
-- Expected result : after the string change the text should maintain its position according to layout rules
-- 
local TestScene = class("TextStringChangeJumpBugScene",function()
    return require("TestScene").create({
        description = "Text String Change Jump Bug - Changing the string should not cause text to jump";
        contentXML = "TextStringChangeJumpBugScene"
    })
end)

local changed = false

function TestScene:changeText()
    local i = 1
    
    while self.elements["text" .. i] ~= nil do
        self:changeTextElement(self.elements["text" .. i])
        i = i+1
    end
    
end

function TestScene:reloadScene()
    local scene = cc.Director:getInstance():getRunningScene()
    scene:retain()
    
    cc.Director:getInstance():replaceScene(cc.Scene:create())
    cc.Director:getInstance():replaceScene(scene)
    
    scene:release()
end

function TestScene:changeTextElement(textElement)
    
    if textElement:getString() == "This text should not jump when changed" then
        textElement:setString("Did this text jump?")
        changed = true
    else
        textElement:setString("This text should not jump when changed")
        changed = false
    end
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene
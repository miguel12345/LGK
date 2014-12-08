local TestScene = class("VisibilityTestScene",function()
    return require("TestScene").create({
    description = "Visibility Test: Blue should be next to red one when green is collapsed";
    contentXML = "VisibilityTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()

    scene.showCollapseGreenArea = function()
        local green = scene.elements["green"]
        if green:getVisibility() == ccui.Visibility.collapsed then
            green:setVisibility(ccui.Visibility.visible)
        else
            green:setVisibility(ccui.Visibility.collapsed)
        end
    end
    
    scene.showHideGreenArea = function()
        local green = scene.elements["green"]
        if green:getVisibility() == ccui.Visibility.hidden then
            green:setVisibility(ccui.Visibility.visible)
        else
            green:setVisibility(ccui.Visibility.hidden)
        end
    end
    
    scene.showCollapseGreenArea2 = function()
        local green = scene.elements["green2"]
        if green:getVisibility() == ccui.Visibility.collapsed then
            green:setVisibility(ccui.Visibility.visible)
        else
            green:setVisibility(ccui.Visibility.collapsed)
        end
    end

    scene.showHideGreenArea2 = function()
        local green = scene.elements["green2"]
        if green:getVisibility() == ccui.Visibility.hidden then
            green:setVisibility(ccui.Visibility.visible)
        else
            green:setVisibility(ccui.Visibility.hidden)
        end
    end
    
    scene.execute = function(self)
        self.elements["parent"]:forceDoLayout()
        local redRightBoundary = self.elements["red"]:getRightBoundary()
        local blueLeftBoundary = self.elements["blue"]:getLeftBoundary()
        local green = scene.elements["green"]

        testassert(redRightBoundary ~= blueLeftBoundary,"green element must start visible")
        green:setVisibility(ccui.Visibility.collapsed)
        self.elements["parent"]:forceDoLayout()
        blueLeftBoundary = self.elements["blue"]:getLeftBoundary()
        testassert(redRightBoundary == blueLeftBoundary,"blue element should be next to red element after green is collapsed")
        
        -- lower section
        self.elements["parent2"]:forceDoLayout()
        local redRightBoundary = self.elements["red2"]:getRightBoundary()
        local blueLeftBoundary = self.elements["blue2"]:getLeftBoundary()
        local green = scene.elements["green2"]

        testassert(redRightBoundary == blueLeftBoundary,"green element must start collapsed")
        green:setVisibility(ccui.Visibility.visible)
        self.elements["parent2"]:forceDoLayout()
        blueLeftBoundary = self.elements["blue2"]:getLeftBoundary()
        testassert(redRightBoundary ~= blueLeftBoundary,"blue element should NOT be next to red element after green is visible")
    end
    
    return scene
end


return TestScene
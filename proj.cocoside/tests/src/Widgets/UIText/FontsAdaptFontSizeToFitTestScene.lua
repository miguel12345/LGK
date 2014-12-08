local TestScene = class("FontsAdaptFontSizeToFitTestScene",function()
    return require("TestScene").create({
        description = "Fonts Adapt Font Size Test";
        contentXML = "FontsAdaptFontSizeToFitTestScene"
    })
end)

function TestScene:testByDimension(dimension)

    -- test initial condition
    local fitByDimension = self.elements["fitBy" .. dimension]
    local fitByDimensionVR = self.elements["fitBy" .. dimension]:getVirtualRenderer()
    local fitByDimensionArea = self.elements["fitBy" .. dimension .."Area"]

    testassert(fitByDimensionVR:getContentSize().width <=  fitByDimensionArea:getContentSize().width and 
        fitByDimensionVR:getContentSize().height <=  fitByDimensionArea:getContentSize().height,"Label fit by " .. dimension .. " must fit inside area")

    -- test content size change (After expanding the UIText's contentSize, the label must fit inside that content size)

    local previousContentSize = fitByDimension:getContentSize()
    local previousVRContentSize = fitByDimensionVR:getContentSize()

    fitByDimension:setContentSize({width = previousContentSize.width*2, height =  previousContentSize.height*2})
    fitByDimensionArea:setContentSize({width = previousContentSize.width*2, height =  previousContentSize.height*2})

    cc.Director:getInstance():getRunningScene():visit()

    testassert(fitByDimensionVR:getContentSize().width <=  fitByDimensionArea:getContentSize().width and 
        fitByDimensionVR:getContentSize().height <=  fitByDimensionArea:getContentSize().height,"Label fit by " .. dimension .. " must fit inside area")

    -- and it's renderer must have grown

    local vrContentSize = fitByDimensionVR:getContentSize()

    testassert(vrContentSize.height > previousVRContentSize.height or vrContentSize.width > previousVRContentSize.width,"Label fit by " .. dimension .. " renderer must expand to fit inside area")
    
    -- After the tests, we restore the previous content size
    
    fitByDimension:setContentSize(previousContentSize)
    fitByDimensionArea:setContentSize(previousContentSize)
end

function TestScene:testUnspecifiedHeight()
    local unspecifiedHeight = self.elements["unspecifiedHeight"]
    local unspecifiedHeightVR = unspecifiedHeight:getVirtualRenderer()
    
    local unspecifiedHeightContentSize = unspecifiedHeight:getContentSize()
    local unspecifiedHeightVRContentSize = unspecifiedHeightVR:getContentSize()
    
    testassert(unspecifiedHeightContentSize.height == unspecifiedHeightVRContentSize.height,"A text with unspecified height must end up with the same height as its renderer")
    
    -- test width change
    unspecifiedHeight:setContentSize({width = 200, height = -1})
    
    cc.Director:getInstance():getRunningScene():visit()
    
    local unspecifiedHeightContentSizeAfter = unspecifiedHeight:getContentSize()
    local unspecifiedHeightVRContentSizeAfter = unspecifiedHeightVR:getContentSize()

    testassert(unspecifiedHeightContentSizeAfter.height == unspecifiedHeightVRContentSizeAfter.height,"A text with unspecified height must end up with the same height as its renderer after changing the width")

    -- restore size
    unspecifiedHeight:setContentSize(unspecifiedHeightContentSize)
    cc.Director:getInstance():getRunningScene():visit()

end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        self:testByDimension("Width")
        self:testByDimension("Height")
        self:testUnspecifiedHeight()
    end
    
    return scene
end


return TestScene
return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
        local child = (function()
            local widget = require('generated_lgx.LayoutIncludeTestSceneInclude_lgx')(p_actionHandler,p_elements,{gridBgColor="255,0,0",whiteMiddleAlignment="CC",gridElementName="gridElementRed"})
            local widgetTemp = widget
            widget = widgetTemp
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = require('generated_lgx.LayoutIncludeTestSceneInclude_lgx')(p_actionHandler,p_elements,{gridBgColor="0,255,0",whiteMiddleAlignment="TL",gridElementName="gridElementGreen"})
            local widgetTemp = widget
            widget = widgetTemp
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = require('generated_lgx.LayoutIncludeTestSceneInclude_lgx')(p_actionHandler,p_elements,{gridBgColor="0,0,255",whiteMiddleAlignment="CC",gridElementName="gridElementBlue"})
            local widgetTemp = widget
            widget = widgetTemp
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.GRID)
        return widget
    end)()
    widget:addChild(child)
    return widget
end
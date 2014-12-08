
lgk = lgk or {}

function propIndexFromName(name)
    return "@" .. name
end

local widgetAttributeInflater = {}

local layoutUtils = lgk.LayoutUtils

widgetAttributeInflater.inflateCommonAttributes = function(widget,xmlNode)
    if xmlNode["@name"] then
        local name = xmlNode["@name"]
        widget:setName(xmlNode["@name"]) 
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName(name)
        end
    end
end

widgetAttributeInflater.inflateWidgetAttributes = function(widget,xmlNode)

    local layoutUtils = lgk.LayoutUtils
    
    -- parse background color
    local backgroundColorString = xmlNode["@backgroundColor"]
    
    if backgroundColorString ~= nil then
        local backgroundColor1, backgroundColor2 = layoutUtils:getColorFromString(backgroundColorString)

        if backgroundColor1 ~= nil and backgroundColor2~= nil then
            --gradient
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
            widget:setBackGroundColor(backgroundColor1,backgroundColor2);
            
            local backgroundColorOrientationString = xmlNode["@backgroundColorOrientation"]
            if backgroundColorOrientationString ~= nil then
                local gradientVector = layoutUtils:getColorGradientVectorFromString(backgroundColorOrientationString)
                widget:setBackGroundColorVector(gradientVector)
            end

        elseif backgroundColor1 ~= nil then
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor(backgroundColor1)
        end
    end  
    
    
    if xmlNode["@size"] ~= nil then 
        local sizeString = string.split(xmlNode["@size"],",")
        local widthValue = sizeString[1]
        local heightValue = sizeString[2]
        local widthSizeType = (string.find(widthValue, '.', 1, true) ~= nil) and ccui.SizeType.percent or ccui.SizeType.absolute
        local heightSizeType = (string.find(heightValue, '.', 1, true) ~= nil) and ccui.SizeType.percent or ccui.SizeType.absolute
        widget:setSizeTypes(widthSizeType,heightSizeType)
        widget:setSizeValues({width = tonumber(widthValue); height = tonumber(heightValue)})
    end
    
    -- size restrictions
    local maximumSize = {width = tonumber(xmlNode["@maxWidth"]) or -1.0; height = tonumber(xmlNode["@maxHeight"]) or -1.0}
    local minimumSize = {width = tonumber(xmlNode["@minWidth"]) or -1.0; height = tonumber(xmlNode["@minHeight"]) or -1.0}

    if maximumSize.width > 0.0 or maximumSize.height > 0.0 then
        widget:setMaxSize(maximumSize);
    end
    
    if minimumSize.width > 0.0 or minimumSize.height > 0.0 then
        widget:setMinSize(minimumSize);
    end
     
    --relative layout
    local alignment = xmlNode["@alignment"]
    if alignment ~= nil then
        local relativeParameter = widget:getLayoutParameter() or ccui.RelativeLayoutParameter:create()
        relativeParameter:setAlign(layoutUtils:getAlignmentFromString(alignment))
        widget:setLayoutParameter(relativeParameter)
    end
    
    local relativeAlignmentTo = {
        alignRightTopOf = ccui.RelativeAlign.locationRightOfTopAlign;
        alignRightCenterOf = ccui.RelativeAlign.locationRightOfCenter;
        alignRightBottomOf = ccui.RelativeAlign.locationRightOfBottomAlign;
        alignLeftTopOf = ccui.RelativeAlign.locationLeftOfTopAlign;
        alignLeftCenterOf = ccui.RelativeAlign.locationLeftOfCenter;
        alignLeftBottomOf = ccui.RelativeAlign.locationLeftOfBottomAlign;
        alignTopCenterOf = ccui.RelativeAlign.locationAboveCenter;
        alignTopRightOf = ccui.RelativeAlign.locationAboveRightAlign;
        alignTopLeftOf = ccui.RelativeAlign.locationAboveLeftAlign;
        alignBottomLeftOf = ccui.RelativeAlign.locationBelowLeftAlign;
        alignBottomCenterOf = ccui.RelativeAlign.locationBelowCenter;
        alignBottomRightOf = ccui.RelativeAlign.locationBelowRightAlign;
    }
    
    for key,relativeAlignmentType in pairs(relativeAlignmentTo) do
        
        local relativeToWidgetName=xmlNode["@"..key]
        if relativeToWidgetName then
            local relativeParameter = widget:getLayoutParameter() or ccui.RelativeLayoutParameter:create()
            relativeParameter:setAlign(relativeAlignmentType)
            relativeParameter:setRelativeToWidgetName(relativeToWidgetName)
            widget:setLayoutParameter(relativeParameter)
        end
        
    end
    
    -- margin
    local margin = xmlNode["@margin"]
    if margin ~= nil then
        local marginTable = layoutUtils:getMarginFromString(margin) 
        local layoutParameter = widget:getLayoutParameter() or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin(marginTable)
        widget:setLayoutParameter(layoutParameter)
    else
        local marginTable = {left = (xmlNode["@marginLeft"] or 0); 
            right = (xmlNode["@marginRight"] or 0);
            top = (xmlNode["@marginTop"] or 0);
            bottom = (xmlNode["@marginBottom"] or 0);}
        if marginTable.left ~= 0 or marginTable.right ~= 0 or marginTable.top ~= 0 or marginTable.bottom ~= 0 then
            local layoutParameter = widget:getLayoutParameter() or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin(marginTable)
            widget:setLayoutParameter(layoutParameter)
        end
    end
    
    -- opacity
    local opacity = xmlNode["@opacity"]
    if opacity ~= nil then
        widget:setOpacity(tonumber(opacity))
    end
    
    -- gravity
    local gravity = xmlNode["@gravity"]
    if gravity ~= nil then
        local layoutParameter = widget:getLayoutParameter() or ccui.LinearLayoutParameter:create()
        layoutParameter:setGravity(layoutUtils:getGravityFromString(gravity))
        widget:setLayoutParameter(layoutParameter)
    end
    
    -- visibility
    local visibility = xmlNode["@visibility"]
    if visibility ~= nil then
        widget:setVisibility(ccui.Visibility[visibility])
    end
    
    -- debug utilities
    local logLayout = xmlNode["@logLayout"]
    if logLayout~= nil then
        widget:setLogLayout(true)
    end
    
    
    -- common
    widgetAttributeInflater.inflateCommonAttributes(widget,xmlNode)
    
    return widget
end

widgetAttributeInflater.inflateLayoutAttributes = function(widget,xmlNode)

    local layout = widgetAttributeInflater.inflateWidgetAttributes(widget,xmlNode)

    -- wrap content
    local wrapContent = xmlNode["@wrapContent"]
    if wrapContent~= nil then
        layout:setWrapContent(layoutUtils:getBooleanFromString(wrapContent))
    end

    --layout type
    local layoutType = xmlNode["@type"] 
    if layoutType ~= nil then
        layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
    end
end

lgk.WidgetAttributeInflater = widgetAttributeInflater

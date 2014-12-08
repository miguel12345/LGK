
lgk = lgk or {}

function propIndexFromName(name)
    return "@" .. name
end

local nodeInflationFunctions = {}

nodeInflationFunctions.ParseCommonProperties = function(node,properties)
    if properties["@name"] then
        local name = properties["@name"]
        node:setName(properties["@name"]) 
        local relativeLayoutParameter = node:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName(name)
        end
    end
end

nodeInflationFunctions.Layout = function(nodeProperties,base)
    local layoutUtils = lgk.LayoutUtils
    local layout = base or ccui.Layout:create()
    
    -- parse background color
    local backgroundColorString = nodeProperties[propIndexFromName("backgroundColor")]
    
    if backgroundColorString ~= nil then
        local backgroundColor1, backgroundColor2 = layoutUtils:getColorFromString(backgroundColorString)

        if backgroundColor1 ~= nil and backgroundColor2~= nil then
            --gradient
            layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
            layout:setBackGroundColor(backgroundColor1,backgroundColor2);
            
            local backgroundColorOrientationString = nodeProperties[propIndexFromName("backgroundColorOrientation")]
            if backgroundColorOrientationString ~= nil then
                local gradientVector = layoutUtils:getColorGradientVectorFromString(backgroundColorOrientationString)
                layout:setBackGroundColorVector(gradientVector)
            end

        elseif backgroundColor1 ~= nil then
            layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            layout:setBackGroundColor(backgroundColor1)
        end
    end  
    
    
    --parse size
    --[[
        We can have absolute/percent mix size
        
        If a dimension (width or height) value contains a dot (.), it's considered percent
        If not it is considered an absolute size
    ]]
    assert(nodeProperties[propIndexFromName("sizePercent")] == nil,"Size percent is deprecated")
    
    if nodeProperties[propIndexFromName("size")] ~= nil then 
        local sizeString = string.split(nodeProperties[propIndexFromName("size")],",")
        local widthValue = sizeString[1]
        local heightValue = sizeString[2]
        local widthSizeType = (string.find(widthValue, '.', 1, true) ~= nil) and ccui.SizeType.percent or ccui.SizeType.absolute
        local heightSizeType = (string.find(heightValue, '.', 1, true) ~= nil) and ccui.SizeType.percent or ccui.SizeType.absolute
        layout:setSizeTypes(widthSizeType,heightSizeType)
        layout:setSizeValues({width = tonumber(widthValue); height = tonumber(heightValue)})
    end
    
    -- size restrictions
    local maximumSize = {width = tonumber(nodeProperties[propIndexFromName("maxWidth")]) or -1.0; height = tonumber(nodeProperties[propIndexFromName("maxHeight")]) or -1.0}
    local minimumSize = {width = tonumber(nodeProperties[propIndexFromName("minWidth")]) or -1.0; height = tonumber(nodeProperties[propIndexFromName("minHeight")]) or -1.0}

    if maximumSize.width > 0.0 or maximumSize.height > 0.0 then
        layout:setMaxSize(maximumSize);
    end
    
    if minimumSize.width > 0.0 or minimumSize.height > 0.0 then
        layout:setMinSize(minimumSize);
    end
    
    --layout type
    local layoutType = nodeProperties[propIndexFromName("type")] 
    if layoutType ~= nil then
        layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
    end
     
    --relative layout
    local alignment = nodeProperties[propIndexFromName("alignment")]
    if alignment ~= nil then
        local relativeParameter = layout:getLayoutParameter() or ccui.RelativeLayoutParameter:create()
        relativeParameter:setAlign(layoutUtils:getAlignmentFromString(alignment))
        layout:setLayoutParameter(relativeParameter)
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
        
        local relativeToWidgetName=nodeProperties[propIndexFromName(key)]
        if relativeToWidgetName then
            local relativeParameter = layout:getLayoutParameter() or ccui.RelativeLayoutParameter:create()
            relativeParameter:setAlign(relativeAlignmentType)
            relativeParameter:setRelativeToWidgetName(relativeToWidgetName)
            layout:setLayoutParameter(relativeParameter)
        end
        
    end
    
    -- margin
    local margin = nodeProperties[propIndexFromName("margin")]
    if margin ~= nil then
        local marginTable = layoutUtils:getMarginFromString(margin) 
        local layoutParameter = layout:getLayoutParameter() or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin(marginTable)
        layout:setLayoutParameter(layoutParameter)
    else
        local marginTable = {left = (nodeProperties[propIndexFromName("marginLeft")] or 0); 
                        right = (nodeProperties[propIndexFromName("marginRight")] or 0);
                        top = (nodeProperties[propIndexFromName("marginTop")] or 0);
                        bottom = (nodeProperties[propIndexFromName("marginBottom")] or 0);}
        if marginTable.left ~= 0 or marginTable.right ~= 0 or marginTable.top ~= 0 or marginTable.bottom ~= 0 then
            local layoutParameter = layout:getLayoutParameter() or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin(marginTable)
            layout:setLayoutParameter(layoutParameter)
        end
    end
    
    -- opacity
    local opacity = nodeProperties[propIndexFromName("opacity")]
    if opacity ~= nil then
        layout:setOpacity(tonumber(opacity))
    end
    
    -- gravity
    local gravity = nodeProperties[propIndexFromName("gravity")]
    if gravity ~= nil then
        local layoutParameter = layout:getLayoutParameter() or ccui.LinearLayoutParameter:create()
        layoutParameter:setGravity(layoutUtils:getGravityFromString(gravity))
        layout:setLayoutParameter(layoutParameter)
    end
    
    -- visibility
    local visibility = nodeProperties[propIndexFromName("visibility")]
    if visibility ~= nil then
        layout:setVisibility(ccui.Visibility[visibility])
    end
    
    -- debug utilities
    local logLayout = nodeProperties[propIndexFromName("logLayout")]
    if logLayout~= nil then
        layout:setLogLayout(true)
    end
    
    -- wrap content
    local wrapContent = nodeProperties[propIndexFromName("wrapContent")]
    if wrapContent~= nil then
        layout:setWrapContent(layoutUtils:getBooleanFromString(wrapContent))
    end
    
    
    -- common
    nodeInflationFunctions.ParseCommonProperties(layout,nodeProperties)
    
    return layout
end;

nodeInflationFunctions.RootLayout = function(nodeProperties)
    local layoutUtils = lgk.LayoutUtils
    local layout = ccui.Layout:create()
    local screenSize = cc.Director:getInstance():getWinSize()
    
    layout:setPosition(0,0)
    layout:setContentSize(screenSize)

    --layout type
    local layoutType = nodeProperties[propIndexFromName("type")] 
    layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
    
    layout:setSizeType(ccui.SizeType.percent)
    layout:setSizePercent({x=1.0;y=1.0})
    layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    layout:setBackGroundColor({r = 0; g = 0; b = 120})
    
    nodeInflationFunctions.ParseCommonProperties(layout,nodeProperties)

    return layout
end;

nodeInflationFunctions.Text = function(nodeProperties)
    local layoutUtils = lgk.LayoutUtils
    local fontName = nodeProperties["@font"] or "Helvetica"
    local fontSize = tonumber(nodeProperties["@fontSize"] or "20")
    local text = nodeProperties["@text"] or ""
    local textLayout = ccui.Text:create(text,fontName,fontSize)
    if nodeProperties["@shadow"] == "true" or (nodeProperties["@shadow"] == nil and (nodeProperties["@shadowColor"]~=nil or nodeProperties["@shadowOffset"]~=nil)) then
        textLayout:enableShadow(layoutUtils:getColorFromString(nodeProperties["@shadowColor"]) or {r=0;g=0;b=0;a=255},layoutUtils:getSizeFromString(nodeProperties["@shadowOffset"]) or cc.size(2.0,-2.0))
    end
    
    nodeInflationFunctions.Layout(nodeProperties,textLayout)
    
    if nodeProperties["@size"] == nil then
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptLabelScaleWithContentSize(false)
        textLayout:setAdaptFontSizeToFit(false)
        textLayout:setContentSize({width=0;height=0})
    elseif nodeProperties["@fontSize"] == nil then
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptLabelScaleWithContentSize(false)  
        textLayout:setAdaptFontSizeToFit(true)
    else
        local size = layoutUtils:getSizeFromString(nodeProperties["@size"])
        if size.height == 0 or size.width == 0 then
            textLayout:setAdaptLabelScaleWithContentSize(false)  
        else
            textLayout:setAdaptLabelScaleWithContentSize(true)
        end
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptFontSizeToFit(false)
    end
    
    if nodeProperties["@drawDebug"]=="true" then
        textLayout:setDebugDraw(true)
    end
    
    if nodeProperties["@wrap"] == "word" then
        textLayout:setLineBreakWithoutSpace(false)
    elseif nodeProperties["@wrap"] == "character" then
        textLayout:setLineBreakWithoutSpace(true)
    end
    
    if nodeProperties["@textColor"] ~= nil then
        textLayout:setTextColor(layoutUtils:getColorFromString(nodeProperties["@textColor"]))
    end
        
    return textLayout
end;

nodeInflationFunctions.Button = function(nodeProperties,base,actionHandler)
    local buttonImage = nodeProperties["@image"] or ""
    local buttonLayout = ccui.Button:create(buttonImage)
    buttonLayout = nodeInflationFunctions.Layout(nodeProperties,buttonLayout)
    
    if nodeProperties["@size"] or  nodeProperties["@sizePercent"] then
        buttonLayout:ignoreContentAdaptWithSize(false)
    end
    
    if nodeProperties["@text"] then
        buttonLayout:setTitleText(nodeProperties["@text"])
    end
    
    if nodeProperties["@fontSize"] then
        buttonLayout:setTitleFontSize(nodeProperties["@fontSize"])
    end
    
    if nodeProperties["@fontName"] then
        buttonLayout:setTitleFontName(nodeProperties["@fontName"])
    end
    
    local onClickAction = nodeProperties["@onClick"]
    if onClickAction then
        local handlerFunction = function(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                actionHandler[onClickAction](actionHandler,buttonLayout,eventType)
            end
        end

    buttonLayout:addTouchEventListener(handlerFunction)
    
    end
    
    return buttonLayout
end;


nodeInflationFunctions.ListView = function(nodeProperties)
    local direction = nodeProperties["@direction"] and ccui.ListViewDirection[nodeProperties["@direction"]] or ccui.ListViewDirection.vertical
    local backgroundImage = nodeProperties["@backgroundImage"]
    local listViewLayout = ccui.ListView:create()
    
    listViewLayout = nodeInflationFunctions.Layout(nodeProperties,listViewLayout)
    
    listViewLayout:setDirection(direction)
    if backgroundImage ~= nil then listViewLayout:setBackGroundImage(backgroundImage) end
    
    return listViewLayout
end;


nodeInflationFunctions.ScrollView = function(nodeProperties)
    local direction = nodeProperties["@direction"] and ccui.ScrollViewDir[nodeProperties["@direction"]] or ccui.ScrollViewDir.vertical
    local scrollViewLayout = ccui.ScrollView:create()
    scrollViewLayout:setDirection(direction)
    scrollViewLayout:setInnerContainerSize({width = 100; height = 400})
    scrollViewLayout = nodeInflationFunctions.Layout(nodeProperties,scrollViewLayout)
    return scrollViewLayout
end;

local imageViewContentModeMap = {
    ScaleToFit = ccui.ImageView.ContentMode.scaleToFit;
    AspectFit = ccui.ImageView.ContentMode.aspectFit;
    AspectFill = ccui.ImageView.ContentMode.aspectFill;
    Repeat = ccui.ImageView.ContentMode.repeating;
}

nodeInflationFunctions.ImageView = function(nodeProperties)
    local imageUrl = nodeProperties["@imageUrl"]
    local imagePath = nodeProperties["@image"]
    local imageViewLayout = lgk.ImageViewExtended.create()
    if nodeProperties["@size"] then
        imageViewLayout:ignoreContentAdaptWithSize(false)
    end
    
    nodeInflationFunctions.Layout(nodeProperties,imageViewLayout)
    if imageUrl ~= nil then
        imageViewLayout:setRemoteImage(imageUrl)
    elseif imagePath ~= nil then
        imageViewLayout:loadTexture(imagePath)
    end
    
    if nodeProperties["@contentMode"] ~= nil then
        imageViewLayout:setContentMode(imageViewContentModeMap[nodeProperties["@contentMode"]])
    end
    
    return imageViewLayout
end;

nodeInflationFunctions.LazyListView = function(nodeProperties) 
    local lazyListView = gk.LazyListView.create()
    nodeInflationFunctions.Layout(nodeProperties,lazyListView)
    return lazyListView
end;


nodeInflationFunctions.TextField = function(nodeProperties) 
    local textField = ccui.TextField:create("Teste","fonts/Marker Felt.ttf",20)
    nodeInflationFunctions.Layout(nodeProperties,textField)
    return textField
end;

nodeInflationFunctions.WebView = function(nodeProperties)
    local webView = ccexp.WebView:create()
    nodeInflationFunctions.Layout(nodeProperties,webView)
    webView:ignoreContentAdaptWithSize(false)
    webView:loadURL("http://www.google.com")
    
    return webView
end;


-- aliases

nodeInflationFunctions.RelativeLayout = function(nodeProperties)
    local layout = nodeInflationFunctions.Layout(nodeProperties)
    layout:setLayoutType(ccui.LayoutType.RELATIVE)
    return layout
end;

nodeInflationFunctions.VerticalLayout = function(nodeProperties)
    local layout = nodeInflationFunctions.Layout(nodeProperties)
    layout:setLayoutType(ccui.LayoutType.VERTICAL)
    return layout
end;

nodeInflationFunctions.HorizontalLayout = function(nodeProperties)
    local layout = nodeInflationFunctions.Layout(nodeProperties)
    layout:setLayoutType(ccui.LayoutType.HORIZONTAL)
    return layout
end;


nodeInflationFunctions.PageView = function(nodeProperties)
    local pageView = lgk.PageViewExtended.create()
    pageView = nodeInflationFunctions.Layout(nodeProperties,pageView)
    pageView:setCustomScrollThreshold(30.0)
    return pageView
end



lgk.LayoutNodeInflater = { }

--- Do stuff
-- @function [parent=#LayoutNodeInflater] inflateNode
-- @param name string cenas
-- @param properties table cenosios
-- @return Node#Node ret (return value: cc.Node)
local function inflateNode(name,xmlProperties,actionHandler)
    	local inflateFunction = nodeInflationFunctions[name]
    	if inflateFunction == nil then return nil end
        return inflateFunction(xmlProperties,nil,actionHandler)
    end

lgk.LayoutNodeInflater.inflateNode = inflateNode

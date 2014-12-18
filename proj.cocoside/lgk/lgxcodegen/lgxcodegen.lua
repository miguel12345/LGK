#! /usr/local/bin/luajit
-- This script has two or more inputs
-- The first if the full path to the directory where the output file will be written
-- After the second come the full paths of the xml files (.lgx, other file types will be ignored) that you want to generate code for
-- The output file for each input file will be named <original_file_name>.lua, so MainScene.lgx becomes MainScene.lgx.lua

local lgxCodeGen = {}
local xml = nil
local codeGenStringTable = {} -- all generated code must be inserted here
local codeGenStringCurrentIndent = 0
local codeGenStringIndentString = ""

local widgetInflater = {}
local transitionInflater = {}
local utils = {}
local widgetAttributeInflater = {}
local nodeCreate = nil
local genFolderName = nil

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function lgxCodeGen.addCodeLine(codeLine)
    table.insert(codeGenStringTable, codeGenStringIndentString..codeLine)
end

function lgxCodeGen.addCodeLineTab()
    codeGenStringCurrentIndent = codeGenStringCurrentIndent + 1
    codeGenStringIndentString = string.rep("    ", codeGenStringCurrentIndent)
end

function lgxCodeGen.removeCodeLineTab()
    codeGenStringCurrentIndent = codeGenStringCurrentIndent - 1
    codeGenStringIndentString = string.rep("    ", codeGenStringCurrentIndent)
end

function lgxCodeGen.getCodeFinalString()
    local s = table.concat(codeGenStringTable, "\n")
    codeGenStringTable = {} --reset code lines table for future use
    return s
end

function lgxCodeGen.parseXML(xmlText)     

    if xml == nil then xml = lgxCodeGen.newParser() end

    local parsedXml = xml:ParseXmlText(xmlText)
    
    return parsedXml:children()[1]
end

function lgxCodeGen.splitfilename(strfilename)
    -- Returns the Path, Filename, and Extension as 3 values
    return string.match(strfilename, "(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

function lgxCodeGen.generateAndWriteCode(genFolderPath,...)
    
    local _,_,genFolderNameLocal = lgxCodeGen.splitfilename(genFolderPath)
    genFolderName = genFolderNameLocal
    print("Generating and writing code")
    local files = {...}
    for _,filePath in pairs(files) do
        if string.sub(filePath, -4) == ".lgx" then
            lgxCodeGen.generateAndWriteLGXCodeForFile(genFolderPath,filePath)
        end
    end
end

function lgxCodeGen.generateCode(filePath)
    print("Generating code")
    if string.sub(filePath, -4) == ".lgx" then
        return lgxCodeGen.generateLGXCodeForFile(filePath)
    end
end

function lgxCodeGen.generateAndWriteLGXCodeForFile(genFolderPath,filePath)

    local _,fileName = lgxCodeGen.splitfilename(filePath)
    
    local luaCode = lgxCodeGen.generateLGXCodeForFile(filePath)
    
    if luaCode == nil then return end
    
    -- write to output file
    local outputFileName = genFolderPath .. "/" .. fileName .. "_lgx.lua"
    print("Writing generate code from ".. filePath .. " to "..outputFileName)
    local outputFile = io.open(outputFileName,"w")
    outputFile:write(luaCode)
    outputFile:close()
end

function lgxCodeGen.generateLGXCodeForFile(filePath)

    print("Generating code for file " .. filePath)
    local file = io.open(filePath, "r" )
    if (file) then

        local contents = file:read("*all")
        file:close()
        local XMLNode = lgxCodeGen.parseXML(contents)
        local luaCode = lgxCodeGen.getLuaCodeFromXMLNode(XMLNode)
        
        return luaCode

    else
        print("File not found with path " .. filePath)
        return nil
    end

end

function lgxCodeGen.getLuaCodeFromXMLNode(xmlNode)

    --Register helper functions for this file
--    lgxCodeGen.addCodeLine([[local areMarginsEqual = function(margin1,margin2)
--        return  margin1.left == margin2.left and 
--            margin1.right == margin2.right and 
--            margin1.bottom == margin2.bottom and
--            margin1.top == margin2.top 
--    end]])
    
    --The next line will generate code
    lgxCodeGen.addCodeLine("return function(p_actionHandler,p_elements)")
    lgxCodeGen.addCodeLineTab()
    local shouldAddLastReturn = widgetInflater.inflateFromXMLNode(xmlNode,true)
    
    if shouldAddLastReturn then
        lgxCodeGen.addCodeLine("return widget") -- last line 
    end
    
    lgxCodeGen.removeCodeLineTab()
    lgxCodeGen.addCodeLine("end")
    
    return lgxCodeGen.getCodeFinalString()
end



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
-- Inflate utils
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
--
function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function utils:getColorFromString(colorAsString)

    if colorAsString == nil then return nil end

    -- gradient
    local colors = string.split(colorAsString,"-")
    if #colors > 1 then
        return self:getColorFromString(colors[1]), self:getColorFromString(colors[2])
    end

    -- hex
    if colorAsString:sub(1,1) == "#" then return utils:hex2rgb(colorAsString) end

    -- rgb
    local components = string.split(colorAsString,",")
    return "{r = " .. components[1] .. "; g = " .. components[2] .. "; b = "..components[3].."; a = " .. (components[4] or 255).."}"
end

function utils:getColorGradientVectorFromString(gradientVectorString)
    if gradientVectorString == "horizontal" then
        return "{x = 1.0; y = 0.0}"
    elseif gradientVectorString == "vertical" then
        return "{x = 0.0; y = -1.0}"
    end
end


function utils:getSizePercentVec2FromString(sizePercentAsString)
    local components = string.split(sizePercentAsString,",")
    return "{x = "..components[1].."; y= "..components[2].."}"
end

function utils:getSizeFromString(size)
    local components = string.split(size,",")
    return "{width = "..components[1].."; height= "..components[2].."}"
end

local alignmentShort = {
    TL = "ccui.RelativeAlign.alignParentTopLeft";
    TR = "ccui.RelativeAlign.alignParentTopRight";
    BL = "ccui.RelativeAlign.alignParentLeftBottom";
    BR = "ccui.RelativeAlign.alignParentRightBottom";
    CC = "ccui.RelativeAlign.centerInParent";
    CL = "ccui.RelativeAlign.alignParentLeftCenterVertical";
    CR = "ccui.RelativeAlign.alignParentRightCenterVertical";
    TC = "ccui.RelativeAlign.alignParentTopCenterHorizontal";
    BC = "ccui.RelativeAlign.alignParentBottomCenterHorizontal"
}

function utils:getAlignmentFromString(alignmentString)
    local alignmentType = alignmentShort[alignmentString]
    return alignmentType
end


local layoutTypes = {
    vertical = "ccui.LayoutType.VERTICAL";
    horizontal = "ccui.LayoutType.HORIZONTAL";
    relative = "ccui.LayoutType.RELATIVE";
    grid = "ccui.LayoutType.GRID";
}

function utils:getLayoutTypeFromString(layoutTypeString)
    return layoutTypes[layoutTypeString]
end


function utils:getMarginFromString(marginString)
    local components = string.split(marginString,",")
    return "{left= "..components[1]..";top = "..components[2]..";right = "..components[3]..";bottom = "..components[4].."};"
end

function utils:getGravityFromString(gravityString)
    return "ccui.LinearGravity."..gravityString
end

function utils:hex2rgb(hex)
    local hex2 = hex:gsub("#","")
    return "{r = "..tonumber("0x"..hex2:sub(1,2)).."; g = "..tonumber("0x"..hex2:sub(3,4)).."; b = "..tonumber("0x"..hex2:sub(5,6)).."; a = 255}"
end


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
-- Widget Attribute Inflater
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

local relativeAlignmentTo = {
        alignRightTopOf = "ccui.RelativeAlign.locationRightOfTopAlign";
        alignRightCenterOf = "ccui.RelativeAlign.locationRightOfCenter";
        alignRightBottomOf = "ccui.RelativeAlign.locationRightOfBottomAlign";
        alignLeftTopOf = "ccui.RelativeAlign.locationLeftOfTopAlign";
        alignLeftCenterOf = "ccui.RelativeAlign.locationLeftOfCenter";
        alignLeftBottomOf = "ccui.RelativeAlign.locationLeftOfBottomAlign";
        alignTopCenterOf = "ccui.RelativeAlign.locationAboveCenter";
        alignTopRightOf = "ccui.RelativeAlign.locationAboveRightAlign";
        alignTopLeftOf = "ccui.RelativeAlign.locationAboveLeftAlign";
        alignBottomLeftOf = "ccui.RelativeAlign.locationBelowLeftAlign";
        alignBottomCenterOf = "ccui.RelativeAlign.locationBelowCenter";
        alignBottomRightOf = "ccui.RelativeAlign.locationBelowRightAlign";
    }

local layoutUtils = utils

widgetAttributeInflater.inflateCommonAttributes = function(xmlNode,isNew)
    local widgetXMLNodeName = xmlNode["@name"]
--    local widgetCurrentName = widget:getName()
--    if widgetXMLNodeName and widgetXMLNodeName~=widgetCurrentName then
    if widgetXMLNodeName then
        local name = xmlNode["@name"]
        
        if not isNew then
            lgxCodeGen.addCodeLine("widget:setName('"..name.."')")
        end
        
--        widget:setName(name)
--        if elements==nil then
--            assert(false)
--        end
--        elements[name] = widget
        lgxCodeGen.addCodeLine("p_elements['"..name.."'] = widget")
        lgxCodeGen.addCodeLine([[local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("]]..name..[[")
        end
        ]])
        
--        local relativeLayoutParameter = widget:getLayoutParameter();
--        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
--            relativeLayoutParameter:setRelativeName(name)
--        end
    end
end

widgetAttributeInflater.processBackgroundColor = function(backgroundColorString)
    if backgroundColorString ~= nil then
        local backgroundColor1, backgroundColor2 = layoutUtils:getColorFromString(backgroundColorString)

        if backgroundColor1 ~= nil and backgroundColor2~= nil then
            --gradient
--            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
            lgxCodeGen.addCodeLine("widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)")

--            widget:setBackGroundColor(backgroundColor1,backgroundColor2);
            lgxCodeGen.addCodeLine("widget:setBackGroundColor("..backgroundColor1..","..backgroundColor2..")")

--            local backgroundColorOrientationString = xmlNode["@backgroundColorOrientation"]
--            if backgroundColorOrientationString ~= nil then
--                local gradientVector = layoutUtils:getColorGradientVectorFromString(backgroundColorOrientationString)
----                widget:setBackGroundColorVector(gradientVector)
--                lgxCodeGen.addCodeLine("widget:setBackGroundColorVector("..gradientVector..")")
--
--            end

        elseif backgroundColor1 ~= nil then
--            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            lgxCodeGen.addCodeLine("widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)")

--            widget:setBackGroundColor(backgroundColor1)
            lgxCodeGen.addCodeLine("widget:setBackGroundColor("..backgroundColor1..")")
        end
    end  
end

widgetAttributeInflater.inflateWidgetAttributes = function(xmlNode,isNew)

    local layoutUtils = utils
--    local layoutParameter = widget:getLayoutParameter()
    lgxCodeGen.addCodeLine("local layoutParameter = widget:getLayoutParameter()")

    if not isNew then
        lgxCodeGen.addCodeLine("local layoutParameterChanged = false")
    end

    -- parse background color
    local backgroundColorString = xmlNode["@backgroundColor"]
    widgetAttributeInflater.processBackgroundColor(backgroundColorString) 

    if xmlNode["@size"] ~= nil then 
        local sizeString = string.split(xmlNode["@size"],",")
        local widthValue = sizeString[1]
        local heightValue = sizeString[2]
        local widthSizeType = (string.find(widthValue, '.', 1, true) ~= nil) and "ccui.SizeType.percent" or "ccui.SizeType.absolute"
        local heightSizeType = (string.find(heightValue, '.', 1, true) ~= nil) and "ccui.SizeType.percent" or "ccui.SizeType.absolute"
--        widget:setSizeTypes(widthSizeType,heightSizeType)
        lgxCodeGen.addCodeLine("widget:setSizeTypes("..widthSizeType..","..heightSizeType..")")

--        widget:setSizeValues({width = tonumber(widthValue); height = tonumber(heightValue)})
        lgxCodeGen.addCodeLine("widget:setSizeValues({width = "..widthValue.."; height = "..heightValue.."})")

    end
    
    -- size restrictions
    local maximumSizeWidth = (xmlNode["@maxWidth"] or -1.0)
    local maximumSizeHeight = (xmlNode["@maxHeight"] or -1.0)
    local maximumSize = "{width = "..maximumSizeWidth.."; height = "..maximumSizeHeight.."}"
    local minimumSizeWidth = (xmlNode["@minWidth"] or -1.0)
    local minimumSizeHeight = (xmlNode["@minHeight"] or -1.0)
    local minimumSize = "{width = "..minimumSizeWidth.."; height = "..minimumSizeHeight.."}"

    if maximumSizeWidth > 0.0 or maximumSizeHeight > 0.0 then
        lgxCodeGen.addCodeLine("widget:setMaxSize("..maximumSize..")")
--        widget:setMaxSize(maximumSize);
    end

    if minimumSizeWidth > 0.0 or minimumSizeHeight > 0.0 then
        lgxCodeGen.addCodeLine("widget:setMinSize("..minimumSize..")")
--        widget:setMinSize(minimumSize);
    end
--
    --relative layout
    local alignment = xmlNode["@alignment"]
    if alignment ~= nil then
--        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        lgxCodeGen.addCodeLine("layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()")

--        local alignment = layoutUtils:getAlignmentFromString(alignment)
        lgxCodeGen.addCodeLine("local alignment = "..layoutUtils:getAlignmentFromString(alignment))
        
        if isNew then
            lgxCodeGen.addCodeLine("layoutParameter:setAlign(alignment)")
        else
            lgxCodeGen.addCodeLine([[
if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end]])
        end
        
    end

    for key,relativeAlignmentType in pairs(relativeAlignmentTo) do

        local relativeToWidgetName=xmlNode["@"..key]
        if relativeToWidgetName then
            lgxCodeGen.addCodeLine("layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()")
--            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            
            if isNew then
                lgxCodeGen.addCodeLine("layoutParameter:setAlign("..relativeAlignmentType..")")
                lgxCodeGen.addCodeLine("layoutParameter:setRelativeToWidgetName('"..relativeToWidgetName.."')")
            else
            
            lgxCodeGen.addCodeLine([[
local alignment = ]]..relativeAlignmentType)
            lgxCodeGen.addCodeLine([[
if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end]])
            
            lgxCodeGen.addCodeLine([[
local layoutRelativeToWidgetName = layoutParameter:getRelativeToWidgetName()
if ']]..relativeToWidgetName..[[' ~= layoutRelativeToWidgetName then
    layoutParameter:setRelativeToWidgetName(']]..relativeToWidgetName..[[')
    layoutParameterChanged = true
end]])
            
            end
--            local alignment = relativeAlignmentType
--            if layoutParameter:getAlign() ~=alignment then
--                layoutParameterChanged = true
--                layoutParameter:setAlign(alignment)
--            end

            
--            local layoutRelativeToWidgetName = layoutParameter:getRelativeToWidgetName()
--            if relativeToWidgetName ~= layoutRelativeToWidgetName then
--                layoutParameter:setRelativeToWidgetName(relativeToWidgetName)
--                layoutParameterChanged = true
--            end
            break
        end

    end

    -- margin
    local margin = xmlNode["@margin"]
    if margin ~= nil then
    
        local marginTable = layoutUtils:getMarginFromString(margin)    
        lgxCodeGen.addCodeLine("layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()")
        
        if isNew then
            lgxCodeGen.addCodeLine("layoutParameter:setMargin("..marginTable..")")
        else
        lgxCodeGen.addCodeLine([[
local layoutParameterMargin = layoutParameter:getMargin()
local marginTable = ]]..marginTable..[[
if (layoutParameterMargin.left ~= marginTable.left or 
layoutParameterMargin.right ~= marginTable.right or 
layoutParameterMargin.bottom ~= marginTable.bottom or
layoutParameterMargin.top ~= marginTable.top) then
    layoutParameterChanged = true
    layoutParameter:setMargin(marginTable)
end]])
        end
--        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
--        if not areMarginsEqual(layoutParameter:getMargin(),marginTable) then
--            layoutParameterChanged = true
--            layoutParameter:setMargin(marginTable)
--        end
    else
        local marginTableLeft = (xmlNode["@marginLeft"] or 0)
        local marginTableRight = (xmlNode["@marginRight"] or 0)
        local marginTableTop = (xmlNode["@marginTop"] or 0)
        local marginTableBottom = (xmlNode["@marginBottom"] or 0)
        local marginTable = "{left = "..marginTableLeft..";right = "..marginTableRight..";top = "..marginTableTop..";bottom = "..marginTableBottom..";}"
            
        
        
        if marginTableLeft ~= 0 or marginTableRight ~= 0 or marginTableTop ~= 0 or marginTableBottom ~= 0 then
        
            lgxCodeGen.addCodeLine("layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()")
            
            if isNew then
                lgxCodeGen.addCodeLine("layoutParameter:setMargin("..marginTable..")")
            else
                lgxCodeGen.addCodeLine([[
local layoutParameterMargin = layoutParameter:getMargin()
local marginTable = ]]..marginTable..[[
if (layoutParameterMargin.left ~= marginTable.left or 
layoutParameterMargin.right ~= marginTable.right or 
 layoutParameterMargin.bottom ~= marginTable.bottom or
layoutParameterMargin.top ~= marginTable.top) then
    layoutParameterChanged = true
    layoutParameter:setMargin(marginTable)
end]])
            end
            
--            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
--            if not areMarginsEqual(layoutParameter:getMargin(),marginTable) then
--                layoutParameterChanged = true
--                layoutParameter:setMargin(marginTable)
--            end
        end
    end
--
    -- opacity
    local opacity = xmlNode["@opacity"]
    if opacity ~= nil then
        lgxCodeGen.addCodeLine("widget:setOpacity("..opacity..")")
        
--        widget:setOpacity(tonumber(opacity))
    end
--
    -- gravity
    local gravity = xmlNode["@gravity"]
    if gravity ~= nil then
        
        local gravity = layoutUtils:getGravityFromString(gravity)
        lgxCodeGen.addCodeLine("layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()")
        
        if isNew then
            lgxCodeGen.addCodeLine("layoutParameter:setGravity("..gravity..")")
        else
            lgxCodeGen.addCodeLine([[
                local gravity = ]]..gravity..[[
if gravity ~= layoutParameter:getGravity() then
    layoutParameter:setGravity(gravity)
    layoutParameterChanged = true
end
            ]])
            
        end
        
--        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
--        local gravity = layoutUtils:getGravityFromString(gravity)
--        if gravity ~= layoutParameter:getGravity() then
--            layoutParameter:setGravity(gravity)
--            layoutParameterChanged = true
--        end
    end

    -- visibility
    local visibility = xmlNode["@visibility"]
    if visibility ~= nil then
    
        lgxCodeGen.addCodeLine("widget:setVisibility(ccui.Visibility."..visibility..")")
--        widget:setVisibility(ccui.Visibility[visibility])
    end

    -- debug utilities
    local logLayout = xmlNode["@logLayout"]
    if logLayout~= nil then
        lgxCodeGen.addCodeLine("widget:setLogLayout(true)")
    
--        widget:setLogLayout(true)
    end

    -- size percent target dimension
    local sizePercentTargetDimension = xmlNode["@sizePercentUse"]
    if sizePercentTargetDimension~=nil then
        if sizePercentTargetDimension=="width" then
            lgxCodeGen.addCodeLine("widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)")
--            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)
        elseif sizePercentTargetDimension=="height" then
            lgxCodeGen.addCodeLine("widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.height)")
--            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.height)
        else
            assert(false,"Found unexpected value "..sizePercentTargetDimension.." for attribute sizePercentUse")
        end
    end

    -- apply layout parameter
    if isNew then
    
        lgxCodeGen.addCodeLine([[
if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end]])

    else
        lgxCodeGen.addCodeLine([[
if layoutParameterChanged then
            widget:layoutParameterChanged()
        end]])

    end
    
    -- propagate touch to children
    local propagateTouchToChildren =  xmlNode["@propagateTouchToChildren"]
    if propagateTouchToChildren ~= nil then
        lgxCodeGen.addCodeLine("widget:setPropagateTouchEventsToChildren("..propagateTouchToChildren..")")
    end

    -- common
    widgetAttributeInflater.inflateCommonAttributes(xmlNode,isNew)

--    return widget
end

widgetAttributeInflater.inflateLayoutAttributes = function(xmlNode,isNew)

    local layoutUtils = utils
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)

    -- wrap content
    local wrapContent = xmlNode["@wrapContent"]
    if wrapContent~= nil then
--        layout:setWrapContent(layoutUtils:getBooleanFromString(wrapContent))
        lgxCodeGen.addCodeLine("widget:setWrapContent("..wrapContent..")")
    end

    --layout type
    local layoutType = xmlNode["@type"] 
    if layoutType ~= nil then
--        layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
        lgxCodeGen.addCodeLine("widget:setLayoutType("..layoutUtils:getLayoutTypeFromString(layoutType)..")")
    end
end


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
-- Widget Inflater
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--

local iterateChildrenOf = function(xmlNode)
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        lgxCodeGen.addCodeLine("local child = (function()")
        lgxCodeGen.addCodeLineTab()
        widgetInflater.inflateFromXMLNode(child,true)
        lgxCodeGen.addCodeLine("return widget")
        lgxCodeGen.removeCodeLineTab()
        lgxCodeGen.addCodeLine("end)()")
        lgxCodeGen.addCodeLine("widget:addChild(child)")
    end
end

widgetInflater.inflateLayout = function(xmlNode,isNew)

--    local layout = ccui.Layout:create()
    if isNew then
        lgxCodeGen.addCodeLine("local widget = ccui.Layout:create()")
    end
    widgetAttributeInflater.inflateLayoutAttributes(xmlNode,isNew)

    iterateChildrenOf(xmlNode)

--    return layout
end;

widgetInflater.inflateRootLayout = function(xmlNode,isNew)

    local layoutUtils = utils
    
    --local layout = ccui.Layout:create()
    lgxCodeGen.addCodeLine("local widget = ccui.Layout:create()")
    
    --local screenSize = cc.Director:getInstance():getWinSize()
    lgxCodeGen.addCodeLine("local screenSize = cc.Director:getInstance():getWinSize()")
    
--    layout:setPosition(0,0)
--    layout:setContentSize(screenSize)
    lgxCodeGen.addCodeLine("widget:setPosition(0,0)")
    lgxCodeGen.addCodeLine("widget:setContentSize(screenSize)")

    --layout type
    local layoutType = xmlNode["@type"] 
--    layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
    lgxCodeGen.addCodeLine("widget:setLayoutType("..layoutUtils:getLayoutTypeFromString(layoutType)..")")   
--    layout:setSizeType(ccui.SizeType.percent)
    lgxCodeGen.addCodeLine("widget:setSizeType(ccui.SizeType.percent)") 
--    layout:setSizePercent({x=1.0;y=1.0})
    lgxCodeGen.addCodeLine("widget:setSizePercent({x=1.0;y=1.0})") 
--    layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    lgxCodeGen.addCodeLine("widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)") 
--    layout:setBackGroundColor({r = 0; g = 0; b = 120})
    lgxCodeGen.addCodeLine("widget:setBackGroundColor({r = 0; g = 0; b = 120})") 

    widgetAttributeInflater.inflateCommonAttributes(xmlNode,isNew)
--
    iterateChildrenOf(xmlNode)

end;

widgetInflater.inflateText = function(xmlNode,isNew)
    local layoutUtils = utils
    local fontName = xmlNode["@font"] or "Helvetica"
    local fontSize = (xmlNode["@fontSize"] or "20")
    local text = xmlNode["@text"]
    
    if isNew then
        lgxCodeGen.addCodeLine("local widget =  ccui.Text:create('"..(text or nil).."','"..fontName.."',"..fontSize..")")
    elseif text then
        lgxCodeGen.addCodeLine("widget:setString('"..text.."')")
    end
    
--    local textLayout = ccui.Text:create(text,fontName,fontSize)
    if xmlNode["@shadow"] == "true" or (xmlNode["@shadow"] == nil and (xmlNode["@shadowColor"]~=nil or xmlNode["@shadowOffset"]~=nil)) then
        lgxCodeGen.addCodeLine("widget:enableShadow("..(layoutUtils:getColorFromString(xmlNode["@shadowColor"]) or "{r=0;g=0;b=0;a=255}")..","..(layoutUtils:getSizeFromString(xmlNode["@shadowOffset"]) or "{width=2.0;height=-2.0}")..")")
--        textLayout:enableShadow(layoutUtils:getColorFromString(xmlNode["@shadowColor"]) or {r=0;g=0;b=0;a=255},layoutUtils:getSizeFromString(xmlNode["@shadowOffset"]) or cc.size(2.0,-2.0))
    end
    
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)
    
    if xmlNode["@size"] == nil and isNew then
        lgxCodeGen.addCodeLine([[widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        ]])
    
--        textLayout:ignoreContentAdaptWithSize(false)
--        textLayout:setAdaptLabelScaleWithContentSize(false)
--        textLayout:setAdaptFontSizeToFit(false)
--        textLayout:setContentSize({width=0;height=0})
    elseif xmlNode["@fontSize"] == nil and isNew then
        lgxCodeGen.addCodeLine([[widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        ]])
--        textLayout:ignoreContentAdaptWithSize(false)
--        textLayout:setAdaptLabelScaleWithContentSize(false)  
--        textLayout:setAdaptFontSizeToFit(true)
    elseif isNew then
        local size = layoutUtils:getSizeFromString(xmlNode["@size"])
        if size.height == 0 or size.width == 0 then
        lgxCodeGen.addCodeLine("widget:setAdaptLabelScaleWithContentSize(false)")
--            textLayout:setAdaptLabelScaleWithContentSize(false)  
        else
        lgxCodeGen.addCodeLine("widget:setAdaptLabelScaleWithContentSize(true)")
        
--            textLayout:setAdaptLabelScaleWithContentSize(true)
        end
        lgxCodeGen.addCodeLine([[widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        ]])
--        textLayout:ignoreContentAdaptWithSize(false)
--        textLayout:setAdaptFontSizeToFit(false)
    end
    
    if xmlNode["@drawDebug"]=="true" then
        lgxCodeGen.addCodeLine("widget:setDebugDraw(true)")
--        textLayout:setDebugDraw(true)
    end
    
    if xmlNode["@wrap"] == "word" then
        lgxCodeGen.addCodeLine("widget:setLineBreakWithoutSpace(false)")
--        textLayout:setLineBreakWithoutSpace(false)
    elseif xmlNode["@wrap"] == "character" then
        lgxCodeGen.addCodeLine("widget:setLineBreakWithoutSpace(true)")
--        textLayout:setLineBreakWithoutSpace(true)
    end
    
    if xmlNode["@textColor"] ~= nil then
        lgxCodeGen.addCodeLine("widget:setTextColor("..layoutUtils:getColorFromString(xmlNode["@textColor"])..")")
--        textLayout:setTextColor(layoutUtils:getColorFromString(xmlNode["@textColor"]))
    end
end;

widgetInflater.inflateButton = function(xmlNode,isNew)
    local buttonImage = xmlNode["@image"] or ""
    lgxCodeGen.addCodeLine("local widget = ccui.Button:create('"..buttonImage.."')")
--    local buttonLayout = ccui.Button:create(buttonImage)
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)
    
    if xmlNode["@size"] or  xmlNode["@sizePercent"] then
        lgxCodeGen.addCodeLine("widget:ignoreContentAdaptWithSize(false)")
--        buttonLayout:ignoreContentAdaptWithSize(false)
    end
    
    if xmlNode["@text"] then
        lgxCodeGen.addCodeLine("widget:setTitleText('"..xmlNode["@text"].."')")
--        buttonLayout:setTitleText(xmlNode["@text"])
    end
    
    if xmlNode["@fontSize"] then
        lgxCodeGen.addCodeLine("widget:setTitleFontSize("..xmlNode["@fontSize"]..")")
--        buttonLayout:setTitleFontSize(xmlNode["@fontSize"])
    end
    
    if xmlNode["@fontName"] then
        lgxCodeGen.addCodeLine("widget:setTitleFontName("..xmlNode["@fontName"]..")")
--        buttonLayout:setTitleFontName(xmlNode["@fontName"])
    end
    
    local onClickAction = xmlNode["@onClick"]
    if onClickAction then
    
            lgxCodeGen.addCodeLine([[local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["]]..onClickAction..[["](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)]])
            
    
--        local handlerFunction = function(sender,eventType)
--            if eventType == ccui.TouchEventType.ended then
--                actionHandler[onClickAction](actionHandler,buttonLayout,eventType)
--            end
--        end
--
--        buttonLayout:addTouchEventListener(handlerFunction)
    
    end
    
--    return buttonLayout
end;


widgetInflater.inflateListView = function(xmlNode,isNew)
    local direction = xmlNode["@direction"]
    if direction then
        direction = "ccui.ListViewDirection."..xmlNode["@direction"]
    else
        direction = "ccui.ListViewDirection.vertical"
    end
--     and ccui.ListViewDirection[xmlNode["@direction"]] or ccui.ListViewDirection.vertical
    local backgroundImage = xmlNode["@backgroundImage"]
    lgxCodeGen.addCodeLine("local widget = ccui.ListView:create()")
    
--    local listViewLayout = ccui.ListView:create()
    
    widgetAttributeInflater.inflateLayoutAttributes(xmlNode,isNew)
    
    lgxCodeGen.addCodeLine("widget:setDirection("..direction..")")
    
--    listViewLayout:setDirection(direction)
    if backgroundImage ~= nil then 
    lgxCodeGen.addCodeLine("widget:setBackGroundImage("..backgroundImage..")")
    
--    listViewLayout:setBackGroundImage(backgroundImage) 
    end
    
    iterateChildrenOf(xmlNode)
end;


widgetInflater.inflateScrollView = function(xmlNode,isNew)
    local direction = xmlNode["@direction"]
    if direction then
        direction = "ccui.ScrollViewDir."..xmlNode["@direction"]
    else
        direction = "ccui.ScrollViewDir.vertical"
    end
--     and ccui.ScrollViewDir[xmlNode["@direction"]] or ccui.ScrollViewDir.vertical
    lgxCodeGen.addCodeLine("local widget = ccui.ScrollView:create()")
--    local scrollViewLayout = ccui.ScrollView:create()
    lgxCodeGen.addCodeLine("widget:setDirection("..direction..")")
--    scrollViewLayout:setDirection(direction)
    lgxCodeGen.addCodeLine("widget:setInnerContainerSize({width = 100; height = 400})")
--    scrollViewLayout:setInnerContainerSize({width = 100; height = 400})
    widgetAttributeInflater.inflateLayoutAttributes(xmlNode,isNew)
    
    iterateChildrenOf(xmlNode,isNew)
end;

local imageViewContentModeMap = {
    ScaleToFit = "ccui.ImageView.ContentMode.scaleToFit";
    AspectFit = "ccui.ImageView.ContentMode.aspectFit";
    AspectFill = "ccui.ImageView.ContentMode.aspectFill";
    Repeat = "ccui.ImageView.ContentMode.repeating";
}

widgetInflater.inflateImageView = function(xmlNode,isNew)
    local imageUrl = xmlNode["@imageUrl"]
    local imagePath = xmlNode["@image"]
    
    if isNew then
        lgxCodeGen.addCodeLine("local widget = lgk.ImageViewExtended.create()")
    end
    
--    local imageViewLayout = lgk.ImageViewExtended.create()
    if xmlNode["@size"] then
        lgxCodeGen.addCodeLine("widget:ignoreContentAdaptWithSize(false)")
--        imageViewLayout:ignoreContentAdaptWithSize(false)
    end
    
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)
    if imageUrl ~= nil then
        lgxCodeGen.addCodeLine("widget:setRemoteImage('"..imageUrl.."')")
--        imageViewLayout:setRemoteImage(imageUrl)
    elseif imagePath ~= nil then
        lgxCodeGen.addCodeLine("widget:loadTexture('"..imagePath.."')")
--        imageViewLayout:loadTexture(imagePath)
    end
    
    if xmlNode["@contentMode"] ~= nil then
        lgxCodeGen.addCodeLine("widget:setContentMode("..imageViewContentModeMap[xmlNode["@contentMode"]]..")")
--        imageViewLayout:setContentMode(imageViewContentModeMap[xmlNode["@contentMode"]])
    end
    
    if xmlNode["@color"] ~= nil then
        lgxCodeGen.addCodeLine("widget:getVirtualRenderer():setColor("..layoutUtils:getColorFromString(xmlNode["@color"])..")")
    end
    
end;

widgetInflater.inflateLazyListView = function(xmlNode,isNew) 
--    local lazyListView = gk.LazyListView.create()
    lgxCodeGen.addCodeLine("local widget = gk.LazyListView.create()")
    
    widgetAttributeInflater.inflateLayoutAttributes(xmlNode,isNew)
    
    iterateChildrenOf(xmlNode)
end;


widgetInflater.inflateTextField = function(xmlNode,isNew) 
    if isNew then
        lgxCodeGen.addCodeLine("local widget = ccui.TextField:create('Teste','fonts/Marker Felt.ttf',20)")
    end
--    local textField = ccui.TextField:create("Teste","fonts/Marker Felt.ttf",20)
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)
end;

widgetInflater.inflateWebView = function(xmlNode,isNew)
    lgxCodeGen.addCodeLine("local widget = ccexp.WebView:create()")
--    local webView = ccexp.WebView:create()
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode,isNew)
    lgxCodeGen.addCodeLine("widget:ignoreContentAdaptWithSize(false)")
--    webView:ignoreContentAdaptWithSize(false)
    
--    return webView
end

widgetInflater.inflatePageView = function(xmlNode,isNew)
    lgxCodeGen.addCodeLine("local widget = ccui.PageView:create()")
--    local pageView = ccui.PageView:create()
    widgetAttributeInflater.inflateLayoutAttributes(xmlNode,isNew)
    lgxCodeGen.addCodeLine("widget:setCustomScrollThreshold(30.0)")
--    pageView:setCustomScrollThreshold(30.0)
    
    iterateChildrenOf(xmlNode)
end

-- aliases

widgetInflater.inflateRelativeLayout = function(xmlNode,isNew)
    widgetInflater.inflateLayout(xmlNode,isNew)
--    layout:setLayoutType(ccui.LayoutType.RELATIVE)
    lgxCodeGen.addCodeLine("widget:setLayoutType(ccui.LayoutType.RELATIVE)")
--    return layout
end;

widgetInflater.inflateVerticalLayout = function(xmlNode,isNew)
    widgetInflater.inflateLayout(xmlNode,isNew)
--    layout:setLayoutType(ccui.LayoutType.VERTICAL)
    lgxCodeGen.addCodeLine("widget:setLayoutType(ccui.LayoutType.VERTICAL)")

    return layout
end;

widgetInflater.inflateHorizontalLayout = function(xmlNode,isNew)
     widgetInflater.inflateLayout(xmlNode,isNew)
--    layout:setLayoutType(ccui.LayoutType.HORIZONTAL)
    lgxCodeGen.addCodeLine("widget:setLayoutType(ccui.LayoutType.HORIZONTAL)")
    
    return layout
end

widgetInflater.inflateGridLayout = function(xmlNode,isNew)
    local layout = widgetInflater.inflateLayout(xmlNode,isNew)
    lgxCodeGen.addCodeLine("widget:setLayoutType(ccui.LayoutType.GRID)")
    return layout
end


-- include
--[[

    Example
    
    <include file="<name>.xml" property="value">
    </include>
    
]]

widgetInflater.inflateInclude = function(xmlNode,handler,elements)
    
    -- include is a special case
    
    -- first, we check if the file exists
    local includeModule = xmlNode["@module"]
    local contextTable = {}
    local properties = xmlNode:properties()
    for k, v in pairs(properties) do
        local propertyName = v["name"]
        if propertyName ~= "module" then
            contextTable[propertyName] = xmlNode["@"..propertyName]
        end
    end
    lgxCodeGen.addCodeLine("local widget = require('"..genFolderName.."."..includeModule.."_lgx')(p_actionHandler,p_elements,"..table.tostring( contextTable )..")")
    lgxCodeGen.addCodeLine("local widgetTemp = widget")
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        lgxCodeGen.addCodeLine("widget = p_elements['"..child["@name"].."']")
        child["@name"] = child["@newName"]
        widgetInflater.inflateFromXMLNode(child,false)
    end
    lgxCodeGen.addCodeLine("widget = widgetTemp")
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

widgetInflater.getGetterStringForProperty = function(propertyName,xmlNodeName)
    
    if propertyName == "backgroundColor" then
        return "getBackGroundColor()"
    end
    
    if propertyName == "color" and xmlNodeName == "ImageView" then
    	return "getVirtualRenderer():getColor()"
    end
    
    return "get"..firstToUpper(propertyName).."()"
        
end

widgetInflater.getSetterStringForProperty = function(propertyName,propertyValue,xmlNodeName)
    
    if propertyName == "backgroundColor" then
        return "setBackGroundColor("..propertyValue..")"
    end
    
    if propertyName == "color" and xmlNodeName == "ImageView" then
        return "getVirtualRenderer():setColor("..propertyValue..")"
    end
    
    return "set"..firstToUpper(propertyName).."("..propertyValue..")"
        
end


widgetInflater.inflatePressedStateFromXMLNode = function(xmlNode,createNew)

    -- search for node properties that start with pressed_ prefix
    local properties = xmlNode:properties()
    local pressedState = {}
    local pressedStateXmlNode = nil
--        print("properties "..#properties)
    
    for k, v in pairs(properties) do
        local propertyName = v["name"]
--        print("property name "..propertyName)
        if string.sub(propertyName,1,8) == "pressed_" then
--            print("xml node name "..xmlNode:name())
            pressedStateXmlNode = pressedStateXmlNode or nodeCreate(xmlNode:name())
            local propertyNameWidthoutPrefix = string.sub(propertyName,9)
--            print("propertyNameWidthoutPrefix "..propertyNameWidthoutPrefix)
            
            pressedStateXmlNode:addProperty(propertyNameWidthoutPrefix,xmlNode["@"..propertyName])
        end
    end
    
    -- pressed state
    if pressedStateXmlNode ~= nil then
        lgxCodeGen.addCodeLine("widget:setTouchEnabled(true)")
        local pressedStateXmlNodeProperties = pressedStateXmlNode:properties()
         
        -- generate code to create old state to nil
        for k, v in pairs(pressedStateXmlNodeProperties) do
            local propertyName = v["name"]
            lgxCodeGen.addCodeLine("local "..propertyName.."Old = nil")
        end
         
        lgxCodeGen.addCodeLine("widget:addTouchEventListener(function(widget,touchType)")
        lgxCodeGen.addCodeLineTab()
        lgxCodeGen.addCodeLine("if(touchType == ccui.TouchEventType.began) then")
        lgxCodeGen.addCodeLineTab()
        
         -- generate code to store old state
        for k, v in pairs(pressedStateXmlNodeProperties) do
            local propertyName = v["name"]
            lgxCodeGen.addCodeLine(propertyName.."Old = widget:" .. widgetInflater.getGetterStringForProperty(propertyName,pressedStateXmlNode:name()))
        end
        
        widgetInflater.inflateFromXMLNode(pressedStateXmlNode,false)
        
        lgxCodeGen.removeCodeLineTab()
        lgxCodeGen.addCodeLine("elseif(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then")
        
         -- generate code to restore old state
        for k, v in pairs(pressedStateXmlNodeProperties) do
            local propertyName = v["name"]
            lgxCodeGen.addCodeLine("widget:" .. widgetInflater.getSetterStringForProperty(propertyName,propertyName.."Old",pressedStateXmlNode:name()))
        end
        
        lgxCodeGen.addCodeLine("end")
        lgxCodeGen.removeCodeLineTab()
        lgxCodeGen.addCodeLine("end)")
    end
end

widgetInflater.inflateFromXMLNode = function(xmlNode,createNew)
    local name = xmlNode:name()
    local widgetInflateFunctionName = "inflate"..name
    local inflateFunction = widgetInflater[widgetInflateFunctionName]
    if inflateFunction == nil then
        transitionInflater.inflateFromXMLNode(xmlNode)
        lgxCodeGen.addCodeLine("return transition")
        return false
    else
--    assert(inflateFunction~=nil,"Not function named ".. widgetInflateFunctionName .. " was found to inflate xml node named "..name.."")
        inflateFunction(xmlNode,createNew)
        widgetInflater.inflatePressedStateFromXMLNode(xmlNode,createNew)
        
        -- process state for widget
        return true
    end
end


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
-- Transition inflater
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function transitionInflater.inflateFromXMLNode(xmlNode)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")

    local xmlNodeName = xmlNode:name()
    local transitionId =xmlNode["@id"]
    
    if xmlNodeName == "Transition" then
        transitionInflater.inflateTransitionSingleFromXMLNode(xmlNode,elements)
    elseif xmlNodeName == "Sequence" then
        transitionInflater.inflateTransitionSequenceFromXMLNode(xmlNode,elements)
    elseif xmlNodeName == "Group" then
        transitionInflater.inflateTransitionGroupFromXMLNode(xmlNode,elements)
    else
        assert(false,"Found invalid xml node named ".. xmlNodeName.." when trying to inflate transition from XML")
    end
    
    if transitionId then
        lgxCodeGen.addCodeLine("transition:setId('"..transitionId.."')")
--        transition:setId(transitionId)
    end
--    return transition
end

function transitionInflater.inflateTransitionSequenceFromXMLNode(xmlNode)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")

    lgxCodeGen.addCodeLine("local transitions = {}")
--    local transitions = {}
    local children = xmlNode:children()
    for i, childXMLNode in ipairs(children) do
    lgxCodeGen.addCodeLine("local child = (function()")
        lgxCodeGen.addCodeLineTab()
        transitionInflater.inflateFromXMLNode(childXMLNode)        
        lgxCodeGen.addCodeLine("return transition")
        lgxCodeGen.removeCodeLineTab()
        lgxCodeGen.addCodeLine("end)()")
        lgxCodeGen.addCodeLine("transitions[#transitions+1] =child")
--        transitions[#transitions+1] = self:getTransitionFromXMLNode(childXMLNode,elements)
    end
    
    lgxCodeGen.addCodeLine("local transition = lgk.TransitionSequence:create(transitions)")
    
--    local transition = lgk.TransitionSequence:create(transitions)
--    return transition
end

function transitionInflater.inflateTransitionGroupFromXMLNode(xmlNode)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
    
    lgxCodeGen.addCodeLine("local transitions = {}")
--    local transitions = {}
    local children = xmlNode:children()
    for i, childXMLNode in ipairs(children) do
    lgxCodeGen.addCodeLine("local child = (function()")
        lgxCodeGen.addCodeLineTab()
        transitionInflater.inflateFromXMLNode(childXMLNode)        
        lgxCodeGen.addCodeLine("return transition")
        lgxCodeGen.removeCodeLineTab()
        lgxCodeGen.addCodeLine("end)()")
        lgxCodeGen.addCodeLine("transitions[#transitions+1] =child")
--        transitions[#transitions+1] = self:getTransitionFromXMLNode(childXMLNode,elements)
    end
    
    lgxCodeGen.addCodeLine("local transition = lgk.TransitionGroup:create(transitions)")
end

function transitionInflater.inflateTransitionSingleFromXMLNode(xmlNode)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
--    assert(elements~=nil,"An element map is needed to find elements")
    
    local widgetName = xmlNode["@name"]
    lgxCodeGen.addCodeLine("local widget = p_elements['"..widgetName.."']")
    
--    local widget = elements[widgetName]
    lgxCodeGen.addCodeLine('assert(widget~=nil,"Unable to find widget named '..widgetName..' when inflating transition")')
    lgxCodeGen.addCodeLine("local transition = lgk.Transition:create(widget)")
    
--    local transition = lgk.Transition:create(widget)
    local duration = xmlNode["@duration"] or 1
    lgxCodeGen.addCodeLine("transition:setDuration("..duration..")")
    lgxCodeGen.addCodeLine("transition:setFinalStateCallback(function(widget)")
    lgxCodeGen.addCodeLineTab()
    widgetAttributeInflater.inflateWidgetAttributes(xmlNode)
    lgxCodeGen.removeCodeLineTab()
    lgxCodeGen.addCodeLine("end)")
    
--    transition:setDuration(duration)
--    transition:setFinalStateCallback(function(widget)
--        widgetAttributeInflater.inflateWidgetAttributes(widget,xmlNode)
--    end)
--    return transition
end


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
-- xml.lua - XML parser for use with the Corona SDK.
--
-- version: 1.2
--
-- CHANGELOG:
--
-- 1.2 - Created new structure for returned table
-- 1.1 - Fixed base directory issue with the loadFile() function.
--
-- NOTE: This is a modified version of Alexander Makeev's Lua-only XML parser
-- found here: http://lua-users.org/wiki/LuaXml
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
function lgxCodeGen.newParser()

    XmlParser = {};

    function XmlParser:ToXmlString(value)
        value = string.gsub(value, "&", "&amp;"); -- '&' -> "&amp;"
        value = string.gsub(value, "<", "&lt;"); -- '<' -> "&lt;"
        value = string.gsub(value, ">", "&gt;"); -- '>' -> "&gt;"
        value = string.gsub(value, "\"", "&quot;"); -- '"' -> "&quot;"
        value = string.gsub(value, "([^%w%&%;%p%\t% ])",
            function(c)
                return string.format("&#x%X;", string.byte(c))
            end);
        return value;
    end

    function XmlParser:FromXmlString(value)
        value = string.gsub(value, "&#x([%x]+)%;",
            function(h)
                return string.char(tonumber(h, 16))
            end);
        value = string.gsub(value, "&#([0-9]+)%;",
            function(h)
                return string.char(tonumber(h, 10))
            end);
        value = string.gsub(value, "&quot;", "\"");
        value = string.gsub(value, "&apos;", "'");
        value = string.gsub(value, "&gt;", ">");
        value = string.gsub(value, "&lt;", "<");
        value = string.gsub(value, "&amp;", "&");
        return value;
    end

    function XmlParser:ParseArgs(node, s)
        string.gsub(s, "([%w_]+)=([\"'])(.-)%2", function(w, _, a)
            node:addProperty(w, self:FromXmlString(a))
        end)
    end

    function XmlParser:ParseXmlText(xmlText)
        local stack = {}
        local top = newNode()
        table.insert(stack, top)
        local ni, c, label, xarg, empty
        local i, j = 1, 1
        while true do
            ni, j, c, label, xarg, empty = string.find(xmlText, "<(%/?)([%w_:]+)(.-)(%/?)>", i)
            if not ni then break end
            local text = string.sub(xmlText, i, ni - 1);
            if not string.find(text, "^%s*$") then
                local lVal = (top:value() or "") .. self:FromXmlString(text)
                stack[#stack]:setValue(lVal)
            end
            if empty == "/" then -- empty element tag
                local lNode = newNode(label)
                self:ParseArgs(lNode, xarg)
                top:addChild(lNode)
            elseif c == "" then -- start tag
                local lNode = newNode(label)
                self:ParseArgs(lNode, xarg)
                table.insert(stack, lNode)
                top = lNode
            else -- end tag
                local toclose = table.remove(stack) -- remove top

                top = stack[#stack]
                if #stack < 1 then
                    error("XmlParser: nothing to close with " .. label)
                end
                if toclose:name() ~= label then
                    error("XmlParser: trying to close " .. toclose.name .. " with " .. label)
                end
                top:addChild(toclose)
            end
            i = j + 1
        end
        local text = string.sub(xmlText, i);
        if #stack > 1 then
            error("XmlParser: unclosed " .. stack[#stack]:name())
        end
        return top
    end

    function XmlParser:loadFile(xmlFilename, base)
        if not base then
            base = system.ResourceDirectory
        end

        local path = system.pathForFile(xmlFilename, base)
        local hFile, err = io.open(path, "r");

        if hFile and not err then
            local xmlText = hFile:read("*a"); -- read file content
            io.close(hFile);
            return self:ParseXmlText(xmlText), nil;
        else
            print(err)
            return nil
        end
    end

    return XmlParser
end

function newNode(name)
    local node = {}
    node.___value = nil
    node.___name = name
    node.___children = {}
    node.___props = {}

    function node:value() return self.___value end
    function node:setValue(val) self.___value = val end
    function node:name() return self.___name end
    function node:setName(name) self.___name = name end
    function node:children() return self.___children end
    function node:numChildren() return #self.___children end
    function node:addChild(child)
        if self[child:name()] ~= nil then
            if type(self[child:name()].name) == "function" then
                local tempTable = {}
                table.insert(tempTable, self[child:name()])
                self[child:name()] = tempTable
            end
            table.insert(self[child:name()], child)
        else
            self[child:name()] = child
        end
        table.insert(self.___children, child)
    end

    function node:properties() return self.___props end
    function node:numProperties() return #self.___props end
    function node:addProperty(name, value)
        local lName = "@" .. name
        if self[lName] ~= nil then
            if type(self[lName]) == "string" then
                local tempTable = {}
                table.insert(tempTable, self[lName])
                self[lName] = tempTable
            end
            table.insert(self[lName], value)
        else
            self[lName] = value
        end
        table.insert(self.___props, { name = name, value = self[name] })
    end

    return node
end

nodeCreate = newNode

-- debug -- comment below before commit
--arg = {}
--arg[1] = "/Users/miguelferreira/projetos/pessoal/LGK/lib/proj.cocoside/generated_lgx"
--arg[2] = "/Users/miguelferreira/projetos/pessoal/LGK/lib/proj.cocoside/tests/src/Layout/PressedBackgroundColorTestScene.lgx"
-- debug -- comment above before commit

if(arg and arg[2] and arg[2]=="-r") then
    
    -- see if the file exists
    function file_exists(file)
      local f = io.open(file, "rb")
      if f then f:close() end
      return f ~= nil
    end
    
    -- get all lines from a file, returns an empty 
    -- list/table if the file does not exist
    function lines_from(file)
      if not file_exists(file) then return {} end
      lines = {}
      for line in io.lines(file) do 
        lines[#lines + 1] = line
      end
      return lines
    end
    
    --recursively generate lgx lua code for all .lgx in directory
    -- usage : gen/folder/path -r root/dir
--    print("arg[1] "..arg[3])
    local file = assert(io.popen("find "..arg[3].." -type f -name '*.lgx'", 'r'))
    local arr = {}
    for line in file:lines() do
        table.insert (arr, line);
    end
    file:close()
    lgxCodeGen.generateAndWriteCode(arg[1],unpack(arr))
    
elseif(arg and arg[1]) then
    
    --normal usage
    
    print("arg 1 "..(arg[1] or "nil"))
    print("arg 2 "..(arg[2] or "nil"))
    print("arg 3 "..(arg[3] or "nil"))
    lgxCodeGen.generateAndWriteCode(arg[1],select(2,unpack(arg)))
else 
    return lgxCodeGen.generateCode
end
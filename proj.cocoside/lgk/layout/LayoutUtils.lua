lgk = lgk or {}

local utils = {}

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
    return {r = tonumber(components[1]); g = tonumber(components[2]); b = tonumber(components[3]); a = (tonumber(components[4]) or 255)}
end

function utils:getColorGradientVectorFromString(gradientVectorString)
    if gradientVectorString == "horizontal" then
    	return {x = 1.0; y = 0.0}
    elseif gradientVectorString == "vertical" then
        return {x = 0.0; y = -1.0}
    end
end


function utils:getSizePercentVec2FromString(sizePercentAsString)
    local components = string.split(sizePercentAsString,",")
    return {x = tonumber(components[1]); y= tonumber(components[2])}
end

function utils:getSizeFromString(size)
    local components = string.split(size,",")
    return {width = tonumber(components[1]); height= tonumber(components[2])}
end

local alignmentShort = {
    TL = ccui.RelativeAlign.alignParentTopLeft;
    TR = ccui.RelativeAlign.alignParentTopRight;
    BL = ccui.RelativeAlign.alignParentLeftBottom;
    BR = ccui.RelativeAlign.alignParentRightBottom;
    CC = ccui.RelativeAlign.centerInParent;
    CL = ccui.RelativeAlign.alignParentLeftCenterVertical;
    CR = ccui.RelativeAlign.alignParentRightCenterVertical;
    TC = ccui.RelativeAlign.alignParentTopCenterHorizontal;
    BC = ccui.RelativeAlign.alignParentBottomCenterHorizontal
}

function utils:getAlignmentFromString(alignmentString)
    local availableAlignments = ccui.RelativeAlign;
    local alignmentType = availableAlignments[alignmentString] or availableAlignments["alignParent" .. alignmentString] or alignmentShort[alignmentString]
    return alignmentType
end


local layoutTypes = {
    vertical = ccui.LayoutType.VERTICAL;
    horizontal = ccui.LayoutType.HORIZONTAL;
    relative = ccui.LayoutType.RELATIVE;
    }

function utils:getLayoutTypeFromString(layoutTypeString)
    return layoutTypes[layoutTypeString]
end


function utils:getMarginFromString(marginString)
    local components = string.split(marginString,",")
    return {left= components[1];top = components[2];right = components[3];bottom = components[4]};
end

function utils:getGravityFromString(gravityString)
    return ccui.LinearGravity[gravityString]
end

function utils:getBooleanFromString(booleanString)
    if booleanString == "true" then return true
    else return false
    end
end

function utils:hex2rgb(hex)
    local hex2 = hex:gsub("#","")
    return {r = tonumber("0x"..hex2:sub(1,2)); g = tonumber("0x"..hex2:sub(3,4)), b = tonumber("0x"..hex2:sub(5,6))}
end

lgk.LayoutUtils = utils
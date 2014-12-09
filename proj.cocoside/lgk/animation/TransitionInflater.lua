lgk = lgk or {}

local TransitionInflater = class("TransitionInflater",nil)

local widgetAttributeInflater = lgk.WidgetAttributeInflater

function TransitionInflater:create(xmlPath,elements)
    local self = TransitionInflater:new()
    self:initWith(xmlPath,elements)
    return self
end

function TransitionInflater:initWith(xmlPath,elements)
    local xmlParser = lgk.XMLParser
    local xmlFilePath = cc.FileUtils:getInstance():fullPathForFilename(xmlPath)
    local xmlContent = cc.FileUtils:getInstance():getStringFromFile(xmlFilePath) 
    local xmlRootNode = xmlParser:parseXML(xmlContent)
    local xmlRoot = xmlRootNode:children()[1]
    self.transition = self:getTransitionFromXMLNode(xmlRoot,elements)
end

function TransitionInflater:getTransition()
    return self.transition
end

function TransitionInflater:getTransitionFromXMLNode(xmlNode,elements)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
    assert(elements~=nil,"An element map is needed to find elements")

    local xmlNodeName = xmlNode:name()
    local transitionId =xmlNode["@id"]
    local transition = nil
    
    if xmlNodeName == "Transition" then
        transition = self:getTransitionSingleFromXMLNode(xmlNode,elements)
    elseif xmlNodeName == "Sequence" then
        transition = self:getTransitionSequenceFromXMLNode(xmlNode,elements)
    elseif xmlNodeName == "Group" then
        transition = self:getTransitionGroupFromXMLNode(xmlNode,elements)
    else
        assert(false,"Found invalid xml node named ".. xmlNodeName.." when trying to inflate transition from XML")
    end
    
    if transitionId then
        transition:setId(transitionId)
    end
    
    return transition
end

function TransitionInflater:getTransitionSequenceFromXMLNode(xmlNode,elements)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
    assert(elements~=nil,"An element map is needed to find elements")

    local transitions = {}
    local children = xmlNode:children()
    for i, childXMLNode in ipairs(children) do
        transitions[#transitions+1] = self:getTransitionFromXMLNode(childXMLNode,elements)
    end
    
    local transition = lgk.TransitionSequence:create(transitions)
    return transition
end

function TransitionInflater:getTransitionGroupFromXMLNode(xmlNode,elements)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
    assert(elements~=nil,"An element map is needed to find elements")

    local transitions = {}
    local children = xmlNode:children()
    for i, childXMLNode in ipairs(children) do
        transitions[#transitions+1] = self:getTransitionFromXMLNode(childXMLNode,elements)
    end
    
    local transition = lgk.TransitionGroup:create(transitions)
    return transition
end

function TransitionInflater:getTransitionSingleFromXMLNode(xmlNode,elements)

    assert(xmlNode~=nil,"Trying to inflate transition from a nil xml node")
    assert(elements~=nil,"An element map is needed to find elements")
    
    local widgetName = xmlNode["@name"]
    local widget = elements[widgetName]
    assert(widget~=nil,"Unable to find widget named "..widgetName.." when inflating transition")
    local transition = lgk.Transition:create(widget)
    local duration = xmlNode["@duration"] or 1
    transition:setDuration(duration)
    transition:setFinalStateCallback(function(widget)
        widgetAttributeInflater.inflateWidgetAttributes(widget,xmlNode)
    end)
    return transition
end

lgk.TransitionInflater = TransitionInflater
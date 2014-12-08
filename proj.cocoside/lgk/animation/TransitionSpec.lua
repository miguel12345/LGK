lgk = lgk or {}

local TransitionSpec = {}

function TransitionSpec.getTransitionFromUpdateXMLNode(xmlNode,widgets)

    local xmlNode = xmlNode["@name"]
    local widget = widgets[xmlNode["@name"]]
    assert(widget~=nil,"When trying to parse transition spec update entry, an element named "..elementName.." was expected but was not found in the provided widget map")
    local transition = lgk.Transition:create(widget)
    
    -- load transition information
    transition:setDuration(xmlNode["@duration"] or 1)
    
    lgk.WidgetAttributeInflater.inflateWidgetAttributes(widget,xmlNode)
    
    return transition
end

function TransitionSpec.createTransitionFromSpec(xmlPath,widgets)
    local xmlParser = lgk.XMLParser
    local xmlRootNode = xmlParser.parseXML(xmlPath)
    local xmlRoot = xmlRootNode:children()[1]

    assert(xmlRoot:name()=="TransitionSpec","Transition specification xml with path "..xmlPath.." must start with root element named TransitionSpec")

    local currentTransitionIndex = 0

    local function getNextTransition()
        currentTransitionIndex = currentTransitionIndex + 1
        local transitionXMLNode = xmlRoot:children()[currentTransitionIndex]
        if not transitionXMLNode then return nil end
        local transition = TransitionSpec.getTransitionFromUpdateXMLNode(transitionXMLNode,widgets)
        transition:setFinishedCallback(function()
            local nextTransition = getNextTransition()
            if nextTransition then nextTransition:run() end
        end)
        return transition
    end

    return getNextTransition()
end

lgk.TransitionSpec = TransitionSpec
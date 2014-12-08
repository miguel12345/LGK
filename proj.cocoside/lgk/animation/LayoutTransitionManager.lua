lgk = lgk or {}

local TransitionSpawn = {}

function TransitionSpawn:create(transitions)
    local self = {}
    
    function self:run()
        local preventParentLayout = false
            for _,transition in pairs(transitions) do
                transition:run(preventParentLayout)
                preventParentLayout = true
            end
    end
    
    return self
end

lgk.TransitionSpawn = TransitionSpawn

local Transition = {}

function Transition:create(animatableWidget)
    
    local self = {}
    
    local finishCallback = nil
    local time = 1
    local currentWidget = animatableWidget
    local widgetParent = animatableWidget:getWidgetParent()
    
    assert(currentWidget~=nil,"Widget cannot be null")
    assert(widgetParent~=nil,"Widget parent cannot be null")
    assert(widgetParent.forceDoLayout~=nil,"Widget parent must be of layout type")

    -- store initialPosition
    local initialPosition = animatableWidget:getWorldPosition()
    local initialOpacity = animatableWidget:getOpacity()
    
    --animation

    function self:run(preventParentLayout)
    
            if not preventParentLayout then
                widgetParent:forceDoLayout() 
            end
          
            time = time or 1
    
            local finalPosition = currentWidget:getWorldPosition()
            local finalOpacity = currentWidget:getOpacity()
    
    
            local actionToRun = nil
    
            if finalPosition.x ~= initialPosition.x or finalPosition.y ~= initialPosition.y then
    
                local delta = {x=(finalPosition.x-initialPosition.x);y=(finalPosition.y-initialPosition.y)}
                local widgetInitialPositionInParent = widgetParent:convertToNodeSpace(initialPosition)
    
                currentWidget:setPosition(widgetInitialPositionInParent)
                actionToRun = cc.EaseSineOut:create(cc.MoveBy:create(time,delta))
            end
    
            if finalOpacity ~= initialOpacity then
                currentWidget:setOpacity(initialOpacity)
    
                local fadeAction = cc.FadeTo:create(time,finalOpacity)
    
                if actionToRun then
                    actionToRun = cc.Spawn:create(actionToRun,fadeAction)
                else
                    actionToRun = fadeAction
                end
            end
            
            if not actionToRun then
                actionToRun = cc.DelayTime:create(time)
            end
            
            actionToRun =  cc.Sequence:create(actionToRun,cc.CallFunc:create(function()
                if finishCallback then finishCallback() end
            end))       
    
            currentWidget:runAction(actionToRun)
        
    end
    
    function self:setFinishedCallback(paramFinishCallback)
        finishCallback = paramFinishCallback
    end
    
    function self:setDuration(paramTime)
        time = paramTime
    end
        
    
    return self
end


lgk.Transition = Transition
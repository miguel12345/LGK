lgk = lgk or {}

local Transition = class("Transition",nil)

function Transition:run()

    local currentWidget = self.widget
    
    assert(self.widget~=nil,"Trying to run a transition without a target widget")
    assert(self.initialStateCallback~=nil,"Trying to run a transition without having defined the initial state callback")
    assert(self.finalStateCallback~=nil,"Trying to run a transition without having defined the final state callback")
    
    --apply initial state
    self.initialStateCallback(currentWidget)
    self:doWidgetParentLayoutIfNeeded()
    
    --capture state
    local initialState = self:captureWidgetCurrentState()
    
    --apply final state
    self.finalStateCallback(currentWidget)
    self:doWidgetParentLayoutIfNeeded()
    
    --capture final state
    local finalState = self:captureWidgetCurrentState()
    
    --calculate the differences and run the actions
    self:createAndRunAction(initialState,finalState)
    
end

function Transition:createAndRunAction(initialState,finalState)

    local currentWidget = self.widget

    local time = self.duration or 1
    local completionCallback = self.completionCallback

    local initialPosition = initialState.position
    local initialOpacity = initialState.opacity

    local finalPosition = finalState.position
    local finalOpacity = finalState.opacity

    local actionToRun = nil

    if finalPosition.x ~= initialPosition.x or finalPosition.y ~= initialPosition.y then

        local delta = {x=(finalPosition.x-initialPosition.x);y=(finalPosition.y-initialPosition.y)}
        local widgetCurrentParent = currentWidget:getWidgetParent() 
        local widgetInitialPositionInParent = widgetCurrentParent:convertToNodeSpace(initialPosition)

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
        self.isRunning = false
        self.isDoneInternal = true
        self.currentAction = nil
        if completionCallback then completionCallback() end
    end))       

    self.isRunning = true
    self.isDoneInternal = false
    self.currentAction = actionToRun
    currentWidget:runAction(actionToRun)
    
end

function Transition:captureWidgetCurrentState()

    assert(self.widget~=nil,"Trying to capture the state of a widget without a widget")

    return {
        position = self.widget:getWorldPosition();
        opacity = self.widget:getOpacity()
    }
end

function Transition:setDuration(duration)
    self.duration = duration
end

function Transition:getDuration()
    return self.duration or 1
end


function Transition:isRunning()
    return self.isRunning
end

function Transition:isDone()
    return self.isDoneInternal
end

function Transition:reverse()
    local tmp = self.initialStateCallback
    self.initialStateCallback = self.finalStateCallback 
    self.finalStateCallback = tmp
    self.reversed =  not self.reversed
end

function Transition:isReversed()
    return self.reversed or false
end

function Transition:setCompletionCallback(completionCallback)
    self.completionCallback = completionCallback
end

function Transition:addCompletionCallback(completionCallback)
    
    if not self.completionCallback then self:setCompletionCallback(completionCallback) 
    else
        self.completionCallback = function()
            self.completionCallback()
            completionCallback()
        end
    end
end

function Transition:getCompletionCallback()
    return self.completionCallback
end

function Transition:setInitialStateCallback(initialStateCallback)
    self.initialStateCallback = initialStateCallback
end

function Transition:setFinalStateCallback(finalStateCallback)
    self.finalStateCallback = finalStateCallback
end

function Transition:doWidgetParentLayoutIfNeeded()

    assert(self.widget~=nil,"Trying to capture the state of a widget without a widget")
    local widgetParent = self.widget:getWidgetParent()
    assert(widgetParent~=nil,"Widget parent cannot be null")
    assert(widgetParent.doLayoutIfNeeded~=nil,"Widget parent must be of layout type")

    widgetParent:doLayoutIfNeeded()

end

function Transition:create(animatableWidget)
    
    local self = Transition:new()
    self.widget = animatableWidget
    return self
    
end


lgk.Transition = Transition

local TransitionSequence = class("TransitionSequence",function()
    return Transition:create()
end)

function TransitionSequence:create(transitions)
    local self = TransitionSequence:new()
    self:initWith(transitions)
    return self
end

function TransitionSequence:initWith(transitions)
    self.transitions = transitions
end

function TransitionSequence:add(transition)
    self.transitions[#self.transitions+1] = transition
end

function TransitionSequence:run()

    for transition, nextTransition in self:transitionIterator() do
        if nextTransition then
            transition:setCompletionCallback(function() nextTransition:run() end)
        else
            self.lastTransition = transition
            transition:setCompletionCallback(self.completionCallback)
        end
    end

    local firstTransition = self:transitionIterator()()
    firstTransition:run()
end

function TransitionSequence:setCompletionCallback(completionCallback)
    self.completionCallback = completionCallback
    if self.lastTransition then
        self.lastTransition:setCompletionCallback(completionCallback)
    end
end

function TransitionSequence:isRunning()
    for transition in self:transitionIterator() do
        if transition:isRunning() then return true end
    end
    return false
end

function TransitionSequence:isDone()
    for transition in self:transitionIterator() do
        if not transition:isDone() then return false end
    end
    return true
end

function TransitionSequence:reverse()
    self.reversed =  not self.reversed
    
    for transition in self:transitionIterator() do
        transition:reverse()
    end
end
function TransitionSequence:transitionIterator()
    
    local reversed = self.reversed
    local currentIndex = reversed and #self.transitions or 1
    
    return function()
        local transition = self.transitions[currentIndex]
        if reversed then
        	currentIndex = currentIndex - 1
        else
            currentIndex = currentIndex + 1
        end
        local nextTransition = self.transitions[currentIndex]
        return transition, nextTransition
    end
end

lgk.TransitionSequence = TransitionSequence

local TransitionGroup = class("TransitionGroup",function()
    return TransitionSequence:create()
end)

function TransitionGroup:create(transitions)
    local self = TransitionGroup:new()
    self:initWith(transitions)
    return self
end

function TransitionGroup:setCompletionCallback(completionCallback)
    self.completionCallback = completionCallback
    if self.biggestTransition then
        self.biggestTransition:setCompletionCallback(completionCallback)
    end
end

function TransitionGroup:run()

    local transitionInitialState = {}
    local biggestTransition = nil
    local parents = {}
    
    for transition in self:transitionIterator() do
        local widget = transition.widget
        transition.initialStateCallback(widget)
        if not biggestTransition then
            biggestTransition = transition
        elseif transition:getDuration() > biggestTransition:getDuration() then
            biggestTransition = transition
        end
        parents[widget:getWidgetParent()] = {}
    end
    
    self.biggestTransition = biggestTransition
    biggestTransition:setCompletionCallback(self.completionCallback)
    
    self:setDuration(biggestTransition:getDuration())
    
    for parent in pairs(parents) do
        parent:doLayoutIfNeeded()
    end
    parents = {}
    
    for transition in self:transitionIterator() do
        transitionInitialState[transition] = transition:captureWidgetCurrentState()
    end
    
    for transition in self:transitionIterator() do
        local widget = transition.widget
        transition.finalStateCallback(widget)
        parents[widget:getWidgetParent()] = {}
    end
    
    for parent in pairs(parents) do
        parent:doLayoutIfNeeded()
    end
    parents = {}
    
    for transition in self:transitionIterator() do
        local finalState = transition:captureWidgetCurrentState()
        transition:createAndRunAction(transitionInitialState[transition],finalState)
    end
    
    transitionInitialState = {}
end


lgk.TransitionGroup = TransitionGroup
lgk = lgk or {}

local LazyListView = class("LazyListView",function()
    return ccui.ListView:create()
end)

function LazyListView.create()
    local lazyListView = LazyListView.new()
    return lazyListView
end

function LazyListView:setDataSource(dataSource)
    self.dataSource = dataSource 
    self:addItemsToBottom()
    self:doLayout()
    self:registerForScrollEvent()
end

local extraSpace = 40

function LazyListView:addItemsToBottom()
    
    local numElements = self.dataSource:getNumberOfElements()
    local accumSize = 0
    
    self.lastElementIndex = self.lastElementIndex or 0
    while accumSize < (self:getContentSize().height + extraSpace) and self.lastElementIndex < numElements do
        local element = self.dataSource:getElementAtIndex(self.lastElementIndex)
        self:pushBackCustomItem(element)
        accumSize = accumSize + element:getContentSize().height
        self.lastElementIndex = self.lastElementIndex + 1
    end

end

function LazyListView:addOneItemToBottom()

    self.lastElementIndex = self.lastElementIndex or 0
    local element = self.dataSource:getElementAtIndex(self.lastElementIndex)
    if not element then return end
    self:pushBackCustomItem(element)
    self.lastElementIndex = self.lastElementIndex + 1

end

function LazyListView:registerForScrollEvent()

    if self.registeredForScrollEvent == true then return end
     
    local ignoreScrollingEvent = false
     
    local function listViewEvent(sender, eventType)
        if eventType == ccui.ScrollviewEventType.scrolling then 
            local innerContainer = self:getInnerContainer()
            local bottomBoundary = innerContainer:getBottomBoundary()

            if innerContainer ~= nil and bottomBoundary > -extraSpace and not ignoreScrollingEvent then
                ignoreScrollingEvent = true 
                self:addOneItemToBottom()
                self:doLayout()
            elseif ignoreScrollingEvent then
                ignoreScrollingEvent = false
            end
        end
    end
    
    self.registeredForScrollEvent = true;
    self:addScrollViewEventListener(listViewEvent)
end

lgk.LazyListView = LazyListView
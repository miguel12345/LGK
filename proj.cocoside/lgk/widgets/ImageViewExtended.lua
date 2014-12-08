lgk = lgk or {}

local ImageViewExtended = class("ImageViewExtended",function()
    return ccui.ImageView:create()
end)

function ImageViewExtended.create(imagePath)
    local imageView = ImageViewExtended.new()

    imageView:registerScriptHandler(function(event) imageView:onNodeEvent(event) end)
     
    if imagePath then
        imageView:loadTexture(imagePath)
    end
    
    return imageView
end

function ImageViewExtended:onNodeEvent(event)
    if event == "exit" then
        if self.downloader then
            self.downloader:release()
        end
    elseif  event == "enter" then
        if self.remoteImageUrl ~= nil then
            self:loadRemoteImage(self.remoteImageUrl)
        end
    end
end

function ImageViewExtended:setRemoteImage(imageUrl)
    if self:isRunning() then
        self.loadRemoteImage(imageUrl)
    else
        self.remoteImageUrl = imageUrl
    end
end

function ImageViewExtended:loadRemoteImage(imageUrl)
    local downloader = self.downloader
    if downloader == nil then
        self.downloader = cc.DownloaderLua:create()
        self.downloader:retain()
        downloader = self.downloader
    end
    
    self.downloader:setSuccessCallback(function(url,path)
        cc.Director:getInstance():getTextureCache():addImageAsync(path,function()
        
            -- update texture
            self:loadTexture(path)
            
            -- request parent layout
            local layoutParent = self:getLayoutParent()
            if layoutParent then
                layoutParent:requestDoLayout()
            end
            
        end)
    end)
    
    local fileName = imageUrl:match( "([^/]+)$" )
    
    self.downloader:downloadAsync(imageUrl,cc.FileUtils:getInstance():getWritablePath() ..fileName)

end

function ImageViewExtended:getLayoutParent()

    local layoutParent = self:getWidgetParent()
    
    while layoutParent ~= nil and layoutParent:getDescription() ~= "Layout" do
        layoutParent = layoutParent:getWidgetParent()
    end
    
    return layoutParent
end

lgk.ImageViewExtended = ImageViewExtended
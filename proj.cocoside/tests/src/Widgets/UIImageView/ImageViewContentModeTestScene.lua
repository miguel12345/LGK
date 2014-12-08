local TestScene = class("ImageViewContentModeTestScene",function()
    return require("TestScene").create({
        description = "ImageView content mode test";
        contentXML = "ImageViewContentModeTestScene"
    })
end)

function TestScene:testImageView(imageView,expectedContentMode)

    local contentMode = imageView:getContentMode()
    
    testassert(contentMode == expectedContentMode,"Expecting content mode "..expectedContentMode.." but found "..contentMode)
    
    local renderer = imageView:getVirtualRenderer()
    
    assert(renderer~=nil)
    
    local originalTexture = renderer:getSprite():getTexture()
    local originalRatio = originalTexture:getPixelsWide() / originalTexture:getPixelsHigh()
    
    -- Here we test that a AspectFill/Fit imageView view keeps its aspect ratio intact
    if (contentMode == ccui.ImageView.ContentMode.aspectFit or
       contentMode == ccui.ImageView.ContentMode.aspectFill)  then
        
        local boundingBox = renderer:getBoundingBox()
        local boundingBoxRatio = boundingBox.width / boundingBox.height;
        testassert(math.abs(boundingBoxRatio-originalRatio)<1,"ImageView with aspectfit/fill content mode should keep the underlying image original aspect ratio")
    end
    
    -- Here we test if a AspectFit imageView fits inside parent node
    if contentMode == ccui.ImageView.ContentMode.aspectFit  then
        local parent = imageView:getWidgetParent()
        local parentBoundingBox = parent:getBoundingBox()
        local boundingBox = renderer:getBoundingBox()
        testassert(math.floor(boundingBox.width) <= math.floor(parentBoundingBox.width) and math.floor(boundingBox.height) <= math.floor(parentBoundingBox.height),"ImageView with aspectfit should fit inside parent node")
    end
    
    -- Here we test if a AspectFill imageView is bigger than the parent node in at least one of the dimensions (widht or height)
    if contentMode == ccui.ImageView.ContentMode.aspectFill  then
        local parent = imageView:getWidgetParent()
        local parentBoundingBox = parent:getBoundingBox()
        local boundingBox = renderer:getBoundingBox()
        testassert((math.floor(boundingBox.width) > math.floor(parentBoundingBox.width) or math.floor(boundingBox.height) > math.floor(parentBoundingBox.height)) or
            (math.floor(boundingBox.width) == math.floor(parentBoundingBox.width) and math.floor(boundingBox.height == parentBoundingBox.height)) , --if the imageView has the same size as the node
            "ImageView with aspectfill must be is bigger than the parent node in at least one of the dimensions (or have the exact same size)")
    end
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
        local imageViewAspectFit1 = self.elements["imageViewAspectFit1"]
        local imageViewAspectFit2 = self.elements["imageViewAspectFit2"]
        local imageViewAspectFit3 = self.elements["imageViewAspectFit3"]
        
        self:testImageView(imageViewAspectFit1,ccui.ImageView.ContentMode.aspectFit)
        self:testImageView(imageViewAspectFit2,ccui.ImageView.ContentMode.aspectFit)
        self:testImageView(imageViewAspectFit3,ccui.ImageView.ContentMode.aspectFit)
        
        local imageViewAspectFill1 = self.elements["imageViewAspectFill1"]
        local imageViewAspectFill2 = self.elements["imageViewAspectFill2"]
        local imageViewAspectFill3 = self.elements["imageViewAspectFill3"]

        self:testImageView(imageViewAspectFill1,ccui.ImageView.ContentMode.aspectFill)
        self:testImageView(imageViewAspectFill2,ccui.ImageView.ContentMode.aspectFill)
        self:testImageView(imageViewAspectFill3,ccui.ImageView.ContentMode.aspectFill)
        
        local imageViewScaleToFit1 = self.elements["imageViewScaleToFit1"]
        local imageViewScaleToFit2 = self.elements["imageViewScaleToFit2"]
        local imageViewScaleToFit3 = self.elements["imageViewScaleToFit3"]

        self:testImageView(imageViewScaleToFit1,ccui.ImageView.ContentMode.scaleToFit)
        self:testImageView(imageViewScaleToFit2,ccui.ImageView.ContentMode.scaleToFit)
        self:testImageView(imageViewScaleToFit3,ccui.ImageView.ContentMode.scaleToFit)
        
        -- switch to a different image and test again
        
        local imageViewAspectFit1OriginalFileName = imageViewAspectFit1:getImageFileName()
        local imageViewAspectFit2OriginalFileName = imageViewAspectFit2:getImageFileName()
        local imageViewAspectFit3OriginalFileName = imageViewAspectFit3:getImageFileName()
        
        local imageViewAspectFill1OriginalFileName = imageViewAspectFill1:getImageFileName()
        local imageViewAspectFill2OriginalFileName = imageViewAspectFill2:getImageFileName()
        local imageViewAspectFill3OriginalFileName = imageViewAspectFill3:getImageFileName()
        
        local imageViewScaleToFit1OriginalFileName = imageViewScaleToFit1:getImageFileName()
        local imageViewScaleToFit2OriginalFileName = imageViewScaleToFit2:getImageFileName()
        local imageViewScaleToFit3OriginalFileName = imageViewScaleToFit3:getImageFileName()
        
        imageViewAspectFit1:loadTexture("images/square-image-2.jpg")
        imageViewAspectFit2:loadTexture("images/landscape-image-2.jpg")
        imageViewAspectFit3:loadTexture("images/portrait-image-2.jpg")
        
        imageViewAspectFill1:loadTexture("images/square-image-2.jpg")
        imageViewAspectFill2:loadTexture("images/landscape-image-2.jpg")
        imageViewAspectFill3:loadTexture("images/portrait-image-2.jpg")
        
        imageViewScaleToFit1:loadTexture("images/square-image-2.jpg")
        imageViewScaleToFit2:loadTexture("images/landscape-image-2.jpg")
        imageViewScaleToFit3:loadTexture("images/portrait-image-2.jpg")
        
        local sceneRoot = self.elements["SceneRoot"]
        sceneRoot:visit()
        
        self:testImageView(imageViewAspectFit1,ccui.ImageView.ContentMode.aspectFit)
        self:testImageView(imageViewAspectFit2,ccui.ImageView.ContentMode.aspectFit)
        self:testImageView(imageViewAspectFit3,ccui.ImageView.ContentMode.aspectFit)

        self:testImageView(imageViewAspectFill1,ccui.ImageView.ContentMode.aspectFill)
        self:testImageView(imageViewAspectFill2,ccui.ImageView.ContentMode.aspectFill)
        self:testImageView(imageViewAspectFill3,ccui.ImageView.ContentMode.aspectFill)

        self:testImageView(imageViewScaleToFit1,ccui.ImageView.ContentMode.scaleToFit)
        self:testImageView(imageViewScaleToFit2,ccui.ImageView.ContentMode.scaleToFit)
        self:testImageView(imageViewScaleToFit3,ccui.ImageView.ContentMode.scaleToFit)
        
        -- reset images
        
        
        imageViewAspectFit1:loadTexture(imageViewAspectFit1OriginalFileName)
        imageViewAspectFit2:loadTexture(imageViewAspectFit2OriginalFileName)
        imageViewAspectFit3:loadTexture(imageViewAspectFit3OriginalFileName)

        imageViewAspectFill1:loadTexture(imageViewAspectFill1OriginalFileName)
        imageViewAspectFill2:loadTexture(imageViewAspectFill2OriginalFileName)
        imageViewAspectFill3:loadTexture(imageViewAspectFill3OriginalFileName)

        imageViewScaleToFit1:loadTexture(imageViewScaleToFit1OriginalFileName)
        imageViewScaleToFit2:loadTexture(imageViewScaleToFit2OriginalFileName)
        imageViewScaleToFit3:loadTexture(imageViewScaleToFit3OriginalFileName)
        
        
    end
    
    return scene
end


return TestScene
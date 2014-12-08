local TestScene = class("WebViewTestScene",function()
    return require("TestScene").create({
        description = "Webview test scene";
        contentXML = "WebViewTestScene"
    })
end)

function TestScene:changeURLToAmazon()
    local webview = self.elements["webview"]
    webview:loadURL("http://amazon.com")
end

function TestScene:changeURLToGoogle()
    local webview = self.elements["webview"]
    webview:loadURL("http://google.pt")
end

function TestScene:loadHTML()
    local webview = self.elements["webview"]
    webview:setJavascriptInterfaceScheme(nil)
    webview:loadHTMLString("<html><body><a id=\"test\" href=\"test://message\">CLICK HERE</a></body></html>","http://www.google.com")
end

function TestScene:evaluateJS()
    local webview = self.elements["webview"]
    webview:setJavascriptInterfaceScheme("test")
    webview:setOnJSCallback(function(url)
        print(url)
    end)
    webview:evaluateJS('document.getElementById("test").click()');
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        local webview = self.elements["webview"]
        
        -- Webview must have content size greater than 0
        local webviewSize = webview:getContentSize()
        testassert(webviewSize.width > 0 and webviewSize.height > 0,"Webview has a valid size")
        
        -- Change url multiple times
        webview:loadURL("http://amazon.com")
        webview:loadURL("http://digitalbuddy.pt")
        webview:loadURL("http://publico.pt")
        webview:loadURL("http://google.pt")
        
        testassert(true,"Webview is able to load urls")
        
        -- Unfortunately the following tests require asynchronous testing support that currently doesn't exist
        
--        -- Test JS scheme callback
--        webview:setJavascriptInterfaceScheme("test")
--        webview:loadHTMLString("<html><body><a id=\"test\" href=\"test://message\">CLICK HERE</a></body></html>","http://www.google.com")
--        local jsCallbackReached = false
--        webview:setOnJSCallback(function(url)
--            jsCallbackReached = true
--        end)
--        webview:evaluateJS('document.getElementById("test").click()')
--        testassert(jsCallbackReached==true,"Webview js callback is handled correctly")
        
    end
    
    return scene
end


return TestScene
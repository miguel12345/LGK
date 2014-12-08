lgk = lgk or {}
local json = lgk.json

local JSONRequest = {}

function JSONRequest:loadFromURL(url,callback)

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("GET", url)

    local function onReadyStateChange()
        if xhr.readyState == 4 then
        
            if  (xhr.status >= 200 and xhr.status < 207) then
                local response   = xhr.response 
                local output = json:decode(response)
                callback(nil,output)
            else
                callback(xhr.status)
            end
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

lgk.JSONRequest = JSONRequest
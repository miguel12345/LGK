cc.FileUtils:getInstance():addSearchPath("tests/src/Layout")
cc.FileUtils:getInstance():addSearchPath("tests/src/Rendering")
cc.FileUtils:getInstance():addSearchPath("tests/src/Widgets")
cc.FileUtils:getInstance():addSearchPath("tests/src/Widgets/UIText")
cc.FileUtils:getInstance():addSearchPath("tests/src/Widgets/UIImageView")
cc.FileUtils:getInstance():addSearchPath("tests/src/Widgets/UIWebView")
cc.FileUtils:getInstance():addSearchPath("tests/src/Widgets/UIPageView")
cc.FileUtils:getInstance():addSearchPath("tests/src/Device")
cc.FileUtils:getInstance():addSearchPath("tests/src/Animation")
cc.FileUtils:getInstance():addSearchPath("tests/src/Touch")

local tests = {

    ["Layout"] = {
        "LinerLayoutRefreshTestScene";
        "SizePercentTests";
        "VisibilityTestScene";
        "RelativeLayoutTestScene";
        "LayoutWrapContentTestScene";
        "GridLayoutTestScene";
        "IncludeLayoutTestScene";
    };
    
    ["Rendering"] = {
        "GradientsColorTestScene";
    };
    
    ["Device"] = {
        "DeviceTestScene";
        "DeviceOrientationLockUnlockTestScene"
    };
    
    ["Animation"] = {
            "TransitionSingleTestScene";
            "TransitionSequenceTestScene";
            "TransitionGroupTestScene";
    };
    
    ["Touch"] = {
            "TouchPropagateChildrenTestScene";
    };
    
    ["Widgets"] = {
        ["ImageView"] = {
            "ImageViewLayoutTestScene";
            "ImageViewContentModeTestScene";
            "ImageViewBackgroundRepeatingImageTestScene";
        };
        ["Text"] = {
            "FontsTestScene";
            "FontsAdaptFontSizeToFitTestScene";
            "FontsWordCharacterWrapTestScene";    
            "TextStringChangeJumpBugScene";
        };
        ["Web"] = {
            "WebViewTestScene";
        };
        ["PageView"] = {
            "PageViewBasicTestScene";
        };
    };
    
}

local parentMap = {}
local currentElement = nil
local currentTest = nil

function generateParents(root)
    for k,v in pairs(root) do
        parentMap[v] = root
        if type(v) == "table" then
            generateParents(v)
        end
    end
end

generateParents(tests)

local currentTestIndexInElement = function()
    for i,v in pairs(parentMap[currentTest]) do
        if v == currentTest then
            return i
        end
    end
end

local incrementCurrentTest = function()
    local nextIndex = currentTestIndexInElement()+1
    currentTest = parentMap[currentTest][nextIndex]
end

local decrementCurrentTest = function()
    currentTest = parentMap[currentTest][currentTestIndexInElement()-1]
end

local existMoreTests = function()
    return currentTestIndexInElement() < #parentMap[currentTest];
end

local existPreviousTests = function()
    return currentTestIndexInElement() > 1;
end

local getCurrentElement = function()

    if currentElement == nil then
        currentElement = tests
    end
    
    return currentElement
end

local setCurrentElement = function(element)
    currentElement = element
end

local setCurrentTest = function(test)
    currentTest = test
end

local getCurrentTest = function()
    return currentTest
end

local getCurrentElementParent = function()
    return parentMap[currentElement]
end

function getAllValueStringsFromTable(table,accum)
    accum = accum or {}
    for k,v in pairs(table) do
        if type(v) == "string" then
        	accum[#accum+1] = v
        else
            getAllValueStringsFromTable(v,accum)
        end
    end
end

local executeAllTestsInCurrentElement = function()
    
    local tests = {}
    getAllValueStringsFromTable(currentElement,tests)
    
    local testsExecuted = 0
    local testsPassed = 0
    
    for k,test in pairs(tests) do
        local testScene = require(test).create()
        cc.Director:getInstance():replaceScene(testScene)
        cc.Director:getInstance():drawScene()
        testScene:execute()
        testsExecuted = testsExecuted + 1
        testsPassed = testsPassed + 1
    end
    
    return testsExecuted, testsPassed
end

return {
    getCurrentElement = getCurrentElement;
    setCurrentElement = setCurrentElement;
    getCurrentElementParent = getCurrentElementParent;
    incrementCurrentTest = incrementCurrentTest;
    decrementCurrentTest = decrementCurrentTest;
    existMoreTests = existMoreTests;
    existPreviousTests = existPreviousTests;
    setCurrentTest = setCurrentTest;
    getCurrentTest = getCurrentTest;
    executeAllTestsInCurrentElement = executeAllTestsInCurrentElement;
}
require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
scrollView = scrollView or {}
ccb["scrollView"] = scrollView

scrollViewContainer = scrollViewContainer or {}
ccb["scrollViewContainer"] = scrollViewContainer
local function buttonA(eventName,control,controlEvent)
	-- body
local url = "www.baidu.com"
local request =CCHTTPRequest:createWithUrlLua(
 
function(event)
    local requestGet = event.request
    print("state:"..requestGet:getState().."  code:"..requestGet:getResponseStatusCode())
    local parseStr =  requestGet:getResponseString()
    print(parseStr)
end, 
url,
kCCHTTPRequestMethodGET)
request:start()
	 cclog("buttonA")
end
local function buttonB(eventName,control,controlEvent)
-- body
cclog("buttonB")
local tab ={}
tab["Himi"] = "himigame.com"
--数据转json
local cjson = require "cjson"
local jsonData = cjson.encode(tab)
 
print(jsonData) 
-- 打印结果:  {"Himi":"himigame.com"}
 
--json转数据
local data = cjson.decode(jsonData)
 
print(data.Himi) 
-- 打印结果:  himigame.com

local _jsonArray={}
_jsonArray[1]=8
_jsonArray[2]=9
_jsonArray[3]=11
_jsonArray[4]=14
_jsonArray[5]=25
 
local _arrayFlagKey={}
_arrayFlagKey["array"]=_jsonArray
 
local tab = {}
tab["Himi"]="himigame.com"
tab["testArray"]=_arrayFlagKey
tab["age"]="23"
 
--数据转json
local cjson = require "cjson"
local jsonData = cjson.encode(tab)
 
print(jsonData)
-- 打印结果： {"age":"23","testArray":{"array":[8,9,11,14,25]},"Himi":"himigame.com"}
 
--json转数据
local data = cjson.decode(jsonData)
local a = data.age
local b = data.testArray.array[2]
local c = data.Himi
 
print("a:"..a.."  b:"..b.."  c:"..c)
-- 打印结果： a:23  b:9  c:himigame.com
end
local function buttonC(eventName,control,controlEvent)
	-- body
	 cclog("buttonC")
end
local function buttonD(eventName,control,controlEvent)
	-- body
	 cclog("buttonD")
end
local function buttonE(eventName,control,controlEvent)
	-- body
	 cclog("buttonE")
end
local function buttonF(eventName,control,controlEvent)
	-- body
	 cclog("buttonF")
end
local function buttonL(eventName,control,controlEvent)
	-- body
	 cclog("buttonL")
end
local function buttonM(eventName,control,controlEvent)
	-- body
	 cclog("buttonM")
end
local function MyScrollViewsLayer()
	-- body
	local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------MyScrollViewsLayer")
    local  node  = CCBuilderReaderLoad("ccbi/scrollView.ccbi",proxy,scrollView)
    layer = tolua.cast(node,"CCLayer")
    local pLable = CCLabelTTF:create("scrollView!!!!!!!!!!!!!!!!", "Marker Felt", 30)
    pLable:setPosition(ccp(size.width / 2, size.height))
    pLable:setAnchorPoint(ccp(0.5,1))
    pLable:setColor(ccc3(255, 0, 0))
    layer:addChild(pLable)
    return layer
end
scrollViewContainer["buttonA"]=buttonA
scrollViewContainer["buttonB"]=buttonB
-- ScrollViewsContainerLayer["buttonC"]=buttonC
-- ScrollViewsContainerLayer["buttonD"]=buttonD
-- ScrollViewsContainerLayer["buttonE"]=buttonE
-- ScrollViewsContainerLayer["buttonF"]=buttonF
-- ScrollViewsContainerLayer["buttonL"]=buttonL
-- ScrollViewsContainerLayer["buttonM"]=buttonM
function runScrollViewsLayer()
    cclog("ScrollViewsLayer")
    local scene = CCScene:create()
    scene:addChild(MyScrollViewsLayer())
    return scene
end
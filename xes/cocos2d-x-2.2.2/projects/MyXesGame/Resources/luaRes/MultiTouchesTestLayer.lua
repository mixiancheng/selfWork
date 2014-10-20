
local function MultiTouchesTestLayer()
  -- body

local layer=CCLayer:create()

--多点触摸事件回调函数
local function onTouchsEvent(eventType,touchs)
        --[[
            eventType:触摸事件类型.
            touchs:多点触摸的数组表，它的大小=n点触摸*3
        ]] 
        if eventType=="began" then --手指开始触摸屏幕
           for i=1,#touchs,3 do
               local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
               local sprite=CCSprite:create("menu1.png")--创建精灵
               sprite:setTag(id+100)--根据触摸id设置精灵的标签
               sprite:setPosition(x,y)--根据触摸坐标设置精灵的位置
               layer:addChild(sprite)--增加精灵到layer
           end
        elseif eventType=="moved" then --手指一直触摸着屏幕移动
           for i=1,#touchs,3 do
              local x,y,id=touchs[i],touchs[i+1],touchs[i+2]
              local sprite=layer:getChildByTag(id+100)--根据触摸id,寻找精灵
              sprite:setPosition(x,y)--根据触摸坐标设置精灵的位置
           end
        elseif eventType=="ended" then --手指一直触摸着屏幕放开后
           for i=1,#touchs,3 do
              local id=touchs[i+2]--获取触摸id
              layer:removeChildByTag(id+100,true)--根据触摸id,从layer中删除精灵
           end
        end  
end

layer:setTouchEnabled(true)
 
layer:registerScriptTouchHandler(onTouchsEvent,true)--设置支持多点触摸

return layer
end
function runMultiTouchesTestLayer()
    cclog("HelloCCBSceneTestMain")
    local scene = CCScene:create()
    scene:addChild(MultiTouchesTestLayer())
    return scene
end

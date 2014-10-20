require "CCBReaderLoad"
require "AudioEngine"
require "luaRes/Game1Layer"
-- require "WorldMapLayer"
cclog = function(...)
    print(string.format(...))
end
local gameState=-1
local isFinsh=false
QZGameTimer=0
local showTypeImgs ={}
showTypeImgs[1]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_niao1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_niao2.png")}
showTypeImgs[2]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_qingwa1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_qingwa2.png")}
showTypeImgs[3]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_songshu1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_songshu2.png")}
showTypeImgs[4]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_tuzi1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_tuzi2.png")}
Game2DoubleLayer = Game2DoubleLayer or {}
ccb["Game2DoubleLayer"] = Game2DoubleLayer
local dir = {L=0,R=1}
local showImgsL={}
local showImgsR={}
local showTypeL={}
local showTypeR={}
local showNumL={}
local showNumR={}
local pointL={}
local pointR={}
local lNum=0
local rNum=0
local lType=0
local rType=0
local lTimes=3
local rTiems=3
local layer=nil
local m_time=0
local Lt=0
local Rt=0
local showLPPOver=false 
local showRPPOber=false
local function setType( _type , _num ,_dir)
    -- body
    if _dir==dir.L then 
    lNum=_num 
    lType=_type
    local img=showTypeImgs[_type].two
    for i,v in ipairs(showImgsL) do
      if i<=_num then 
        v:setVisible(true)
        v:setTexture(img)
      else 
        v:setVisible(false)
      end 
    end
    end 
    if _dir==dir.R then
    rNum=_num 
    rType=_type
    local img=showTypeImgs[_type].two
    for i,v in ipairs(showImgsR) do
      if i<=_num then 
        v:setVisible(true)
        v:setTexture(img)
      else 
        v:setVisible(false)
      end 
    end
    end 
end
local function ShowLPP()
    -- body
    showLPPOver=false 
    local LPPOne = tolua.cast(Game2DoubleLayer["LPPOne"],"CCSprite")
    local LPPTwo = tolua.cast(Game2DoubleLayer["LPPTwo"],"CCSprite")
    local LPPThree = tolua.cast(Game2DoubleLayer["LPPThree"],"CCSprite")
    LPPOne:setVisible(false)
    LPPTwo:setVisible(false)
    LPPThree:setVisible(false)
local function show1(  )
    -- body
    LPPOne:setVisible(true)
    for i,v in ipairs(showImgsL) do
        v:setVisible(false)
    end
end 
local function show2(  )
    -- body
    LPPTwo:setVisible(true)
end 
local function show3(  )
    -- body
    LPPThree:setVisible(true)
    showLPPOver=true 
    math.randomseed(tostring(os.time()):reverse():sub(1, 6)*123)
        local _type=math.random(1,4)
        while lType==_type do 
            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
            _type=math.random(1,4)
        end 
        local _num=math.random(1,5)
    setType(_type, _num ,dir.L)
end 
    local  pCallback1 = CCCallFunc:create(show1)
    local  pCallback2 = CCCallFunc:create(show2)
    local  pCallback3 = CCCallFunc:create(show3)
    local arr = CCArray:create()
    -- arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback1)
     arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback2)
     arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback3)
    local  pSequence = CCSequence:create(arr)
    LPPOne:runAction(pSequence)
end
local function ShowRPP()
    -- body
    showRPPOber=false
    local RPPOne = tolua.cast(Game2DoubleLayer["RPPOne"],"CCSprite")
    local RPPTwo = tolua.cast(Game2DoubleLayer["RPPTwo"],"CCSprite")
    local RPPThree = tolua.cast(Game2DoubleLayer["RPPThree"],"CCSprite")
    RPPOne:setVisible(false)
    RPPTwo:setVisible(false)
    RPPThree:setVisible(false)
local function show1(  )
    -- body
    RPPOne:setVisible(true)
    for i,v in ipairs(showImgsR) do
        v:setVisible(false)
    end
end 
local function show2(  )
    -- body
    RPPTwo:setVisible(true)
end 
local function show3(  )
    -- body
    RPPThree:setVisible(true)
    showRPPOver=true 
    math.randomseed(tostring(os.time()):reverse():sub(1, 6)*123)
        local _type=math.random(1,4)
        while lType==_type do 
            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
            _type=math.random(1,4)
        end 
        local _num=math.random(1,5)
    setType(_type, _num ,dir.R)
end 
    local  pCallback1 = CCCallFunc:create(show1)
    local  pCallback2 = CCCallFunc:create(show2)
    local  pCallback3 = CCCallFunc:create(show3)
    local arr = CCArray:create()
    -- arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback1)
     arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback2)
     arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback3)
    local  pSequence = CCSequence:create(arr)
    RPPOne:runAction(pSequence)
end
local function nextLayer(  )
    -- body
    if Lt<30 then Lt=30 end 
    if Lt>60 then Lt=60 end 
    if Rt<30 then Rt=30 end 
    if Rt>60 then Rt=60 end 

    QZGameTimer=10+1200/(Lt+Rt)
    if QZGameTimer<20 then QZGameTimer=20 end 
    if QZGameTimer>30 then QZGameTimer=30 end 
    QZGameTimer=QZGameTimer/2
    CCDirector:sharedDirector():replaceScene(runGame1Layer())
end
local function buttonNextL(eventName,control,controlEvent)
    -- body
if controlEvent == CCControlEventTouchUpInside then
    AudioEngine.playEffect("music/buttonchild.wav")
     if isFinsh~=true then return end 
     nextLayer()
end 
end
local function buttonNextR(eventName,control,controlEvent)
    -- body
    if controlEvent == CCControlEventTouchUpInside then

    AudioEngine.playEffect("music/buttonchild.wav")
     if isFinsh~=true then return end 
     nextLayer()
end 
end
local function buttonEndL(eventName,control,controlEvent)
    -- body
   if controlEvent == CCControlEventTouchUpInside then

    AudioEngine.playEffect("music/buttonchild.wav")
     if isFinsh~=true then return end 
    local _s=runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(_s)
end 
end
local function buttonEndR(eventName,control,controlEvent)
    -- body
    if controlEvent == CCControlEventTouchUpInside then

    AudioEngine.playEffect("music/buttonchild.wav")
    if isFinsh~=true then return end 
    local _s=runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(_s)
end 
end
local function buttonBackL(eventName,control,controlEvent)
	-- body
    if gameState==-1 then return end 
AudioEngine.playEffect("music/buttonchild.wav")
	local _s=runWorldMapLayer()
	CCDirector:sharedDirector():replaceScene(_s)
end
local function buttonBackR(eventName,control,controlEvent)
	-- body
    if gameState==-1 then return end 
    AudioEngine.playEffect("music/buttonchild.wav")
	local _s=runWorldMapLayer()
	CCDirector:sharedDirector():replaceScene(_s)
end
Game2DoubleLayer["buttonBackL"]=buttonBackL
Game2DoubleLayer["buttonBackR"]=buttonBackR
Game2DoubleLayer["buttonEndL"]=buttonEndL
Game2DoubleLayer["buttonNextL"]=buttonNextL
Game2DoubleLayer["buttonEndR"]=buttonEndR
Game2DoubleLayer["buttonNextR"]=buttonNextR
local function showLTJLayer()
    local _lb = tolua.cast(Game2DoubleLayer["LtimeBack"],"CCSprite")
    _lb:setVisible(true)
    local _lt = tolua.cast(Game2DoubleLayer["timeBackL"],"CCSprite")
    _lt:setVisible(true)
    local _lbuttonNext = tolua.cast(Game2DoubleLayer["buttonTJLNext"],"CCControl")
    _lbuttonNext:setVisible(true)
    local _lbuttonEnd = tolua.cast(Game2DoubleLayer["buttonTJLEnd"],"CCControl")
    _lbuttonEnd:setVisible(true)

    local m_label0 = tolua.cast(Game2DoubleLayer["timeMesgL"],"CCLabelTTF")
    m_label0:setVisible(true)
    local str=string.format("%2.1f秒", Lt)
    m_label0:setString(str)
end 
local function showRTJLayer()
    local _lb = tolua.cast(Game2DoubleLayer["RtimeBack"],"CCSprite")
    _lb:setVisible(true)
    local _lt = tolua.cast(Game2DoubleLayer["timeBackR"],"CCSprite")
    _lt:setVisible(true)
    local _lbuttonNext = tolua.cast(Game2DoubleLayer["buttonTJRNext"],"CCControl")
    _lbuttonNext:setVisible(true)
    local _lbuttonEnd = tolua.cast(Game2DoubleLayer["buttonTJREnd"],"CCControl")
    _lbuttonEnd:setVisible(true)
    local m_label1 = tolua.cast(Game2DoubleLayer["timeMesgR"],"CCLabelTTF")
    m_label1:setVisible(true)
    local str=string.format("%2.1f秒", Rt)
        m_label1:setString(str)
end 
local function intiUI()
	-- body
	showImgsL[1]=tolua.cast(Game2DoubleLayer["LSOne"],"CCSprite")
	-- showImgsL[1]:setVisible(false)
	showImgsL[2]=tolua.cast(Game2DoubleLayer["LSTwo"],"CCSprite")
	showImgsL[3]=tolua.cast(Game2DoubleLayer["LSThree"],"CCSprite")
	showImgsL[4]=tolua.cast(Game2DoubleLayer["LSFour"],"CCSprite")
	showImgsL[5]=tolua.cast(Game2DoubleLayer["LSFive"],"CCSprite")
	showTypeL[1]=tolua.cast(Game2DoubleLayer["typeOneL"],"CCSprite")
	showTypeL[2]=tolua.cast(Game2DoubleLayer["typeTwoL"],"CCSprite")
	showTypeL[3]=tolua.cast(Game2DoubleLayer["typeThreeL"],"CCSprite")
	showTypeL[4]=tolua.cast(Game2DoubleLayer["typeFourL"],"CCSprite")
	-----------------------------------------------------------
	showImgsR[1]=tolua.cast(Game2DoubleLayer["RSOne"],"CCSprite")
	showImgsR[2]=tolua.cast(Game2DoubleLayer["RSTwo"],"CCSprite")
	showImgsR[3]=tolua.cast(Game2DoubleLayer["RSThree"],"CCSprite")
	showImgsR[4]=tolua.cast(Game2DoubleLayer["RSFour"],"CCSprite")
	showImgsR[5]=tolua.cast(Game2DoubleLayer["RSFive"],"CCSprite")
	showTypeR[1]=tolua.cast(Game2DoubleLayer["typeOneR"],"CCSprite")
	showTypeR[2]=tolua.cast(Game2DoubleLayer["typeTwoR"],"CCSprite")
	showTypeR[3]=tolua.cast(Game2DoubleLayer["typeThreeR"],"CCSprite")
	showTypeR[4]=tolua.cast(Game2DoubleLayer["typeFourR"],"CCSprite")
---------------------------------------------------------------
    showNumL[1]=tolua.cast(Game2DoubleLayer["NumOneL"],"CCSprite")
    showNumL[2]=tolua.cast(Game2DoubleLayer["NumTwoL"],"CCSprite")
    showNumL[3]=tolua.cast(Game2DoubleLayer["NumThreeL"],"CCSprite")
    showNumL[4]=tolua.cast(Game2DoubleLayer["NumFourL"],"CCSprite")
    showNumL[5]=tolua.cast(Game2DoubleLayer["NumFiveL"],"CCSprite")

pointL[1]={x=showNumL[1]:getPositionX(),y=showNumL[1]:getPositionY()}
pointL[2]={x=showNumL[2]:getPositionX(),y=showNumL[2]:getPositionY()}
pointL[3]={x=showNumL[3]:getPositionX(),y=showNumL[3]:getPositionY()}
pointL[4]={x=showNumL[4]:getPositionX(),y=showNumL[4]:getPositionY()}
pointL[5]={x=showNumL[5]:getPositionX(),y=showNumL[5]:getPositionY()}
    ---------------------------------------------------------------
    showNumR[1]=tolua.cast(Game2DoubleLayer["NumOneR"],"CCSprite")
    showNumR[2]=tolua.cast(Game2DoubleLayer["NumTwoR"],"CCSprite")
    showNumR[3]=tolua.cast(Game2DoubleLayer["NumThreeR"],"CCSprite")
    showNumR[4]=tolua.cast(Game2DoubleLayer["NumFourR"],"CCSprite")
    showNumR[5]=tolua.cast(Game2DoubleLayer["NumFiveR"],"CCSprite")
    ---------------------------------------------------------------
    pointR[1]={x=showNumR[1]:getPositionX(),y=showNumR[1]:getPositionY()}
    pointR[2]={x=showNumR[2]:getPositionX(),y=showNumR[2]:getPositionY()}
    pointR[3]={x=showNumR[3]:getPositionX(),y=showNumR[3]:getPositionY()}
    pointR[4]={x=showNumR[4]:getPositionX(),y=showNumR[4]:getPositionY()}
    pointR[5]={x=showNumR[5]:getPositionX(),y=showNumR[5]:getPositionY()}
for i,v in ipairs(showImgsL) do
   v:setVisible(false)
end
for i,v in ipairs(showImgsR) do
   v:setVisible(false)
end
end
local function containsTouchLocation(obj,x,y)
    local position = ccp(obj:getPosition())
    local  s = obj:getContentSize()
    local touchRect = CCRectMake(-s.width / 2 + position.x, -s.height / 2 + position.y, s.width, s.height)
    local b = touchRect:containsPoint(ccp(x,y))
    return b
end

local TLid={id=-1,v=nil,vid=-1}
local TRid={id=-1,v=nil,vid=-1}
local function TLActionBegin(eventType,touchs)
	-- body
	if lTimes<=0 then return end
    if TLid.id~=-1 then return end 
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    for i,v in ipairs(showNumL) do
     if containsTouchLocation(v,x,y) then 
     	TLid.id=id
        TLid.v=v
        TLid.vid=i
        cclog("TLid.di===>"..TLid.di)
     break  
     end 
    end
    end
end
local function TLActionMove(eventType,touchs)
	-- body
	if lTimes<=0 then return end
	cclog("====>>>>>>>>"..TLid.id)
    if TLid.id==-1 then return end 
    cclog("local function TLActionMove(eventType,touchs)")
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    if id==TLid.id then 
    	TLid.v:setPositionX(x)
    	TLid.v:setPositionY(y)
    return 
    end 
    end
end
local function nextAction(  )
    isFinsh=true
	-- body
	-- local action = CCSequence:createWithTwoActions(
 --        CCDelayTime:create(2),
 --        CCCallFunc:create(nextLayer))
 --    layer:runAction(action)
end
local function nextGameL()
	-- body

	lTimes=lTimes-1
	if lTimes<=0 then 
	Lt=m_time
	-- cclog("------><><><>"..str)
	showLTJLayer()
    if rTimes<=0 then 
    	nextAction()
    end 
	return 
	end 
	cclog("nextGameL---->")
        TLid.v:setPositionX(pointL[TLid.vid].x)
        TLid.v:setPositionY(pointL[TLid.vid].y)
	    TLid.id=-1
    	TLid.vid=-1
    	TLid.v=nil
        ShowLPP()
        AudioEngine.playEffect("music/jump.wav")
 --    	math.randomseed(tostring(os.time()):reverse():sub(1, 6)*123)
 --        local _type=math.random(1,4)
 --        while lType==_type do 
 --            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
 --            _type=math.random(1,4)
 --        end 
 --        local _num=math.random(1,5)
 --        AudioEngine.playEffect("music/jump.wav")
	-- setType(_type, _num ,dir.L)
end
local function nextGameR()
	-- body
     
	rTimes=rTimes-1
	if rTimes<=0 then 
		Rt=m_time
	showRTJLayer()
	if lTimes<=0 then 
    	nextAction()
    end 
	return 
end
	cclog("nextGameR---->")
        TRid.v:setPositionX(pointR[TRid.vid].x)
        TRid.v:setPositionY(pointR[TRid.vid].y)
	    TRid.id=-1
    	TRid.vid=-1
    	TRid.v=nil
        ShowRPP()
        AudioEngine.playEffect("music/jump.wav")
 --    	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
 --        local _type=math.random(1,4)
 --        while rType==_type do 
 --            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
 --            _type=math.random(1,4)
 --        end 
 --        local _num=math.random(1,5)
 --        AudioEngine.playEffect("music/jump.wav")
	-- setType(_type, _num ,dir.R)
end
local function gameOverL(_num,_x,_y)
	if lNum~=_num then 
        TLid.id=-1
    	TLid.vid=-1
    	TLid.v=nil
    return 
    end 
    local isType=containsTouchLocation(showTypeL[lType],_x,_y); 
-- cclog("isType===="..show_Type..showTypeSprite[show_Type]:getPositionX().."---"..showTypeSprite[show_Type]:getPositionY())
if isType~=true then 
	cclog("isType")
        TLid.id=-1
    	TLid.vid=-1
    	TLid.v=nil
    return 
end
TLid.v:setPositionX(showTypeL[lType]:getPositionX())
TLid.v:setPositionY(showTypeL[lType]:getPositionY())
	-- body
	nextGameL()
end
local function gameOverR(_num,_x,_y)
	if rNum~=_num then 
	cclog("lnum")
        TRid.id=-1
    	TRid.vid=-1
    	TRid.v=nil
    return 
    end 

-- cclog("lType=="..lType.."x==".._x.. "y".._y)
local isType=containsTouchLocation(showTypeR[rType],_x,_y); 
-- cclog("isType===="..show_Type..showTypeSprite[show_Type]:getPositionX().."---"..showTypeSprite[show_Type]:getPositionY())
if isType~=true then 
	cclog("isType")
        TRid.id=-1
    	TRid.vid=-1
    	TRid.v=nil
    return 
end
	-- body
    TRid.v:setPositionX(showTypeR[rType]:getPositionX())
    TRid.v:setPositionY(showTypeR[rType]:getPositionY())
	nextGameR()
end
local function TLActionEnd(eventType,touchs)
	-- body
	if lTimes<=0 then return end
	cclog("====>>>>>>>>"..TLid.id)
    if TLid.id==-1 then return end 
    cclog("local function TLActionMove(eventType,touchs)")
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    if id==TLid.id then
    	-- TLid.v:setPositionX(pointL[TLid.vid].x)
    	-- TLid.v:setPositionY(pointL[TLid.vid].y)
        TLid.v:setPositionX(pointL[TLid.vid].x)
        TLid.v:setPositionY(pointL[TLid.vid].y)
    	gameOverL(TLid.vid,x,y)
    return 
    end 
    end
end
local function TRActionBegin(eventType,touchs)
	-- body
	if rTimes<=0 then return end 
    if TRid.id~=-1 then return end 
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    for i,v in ipairs(showNumR) do
     if containsTouchLocation(v,x,y) then 
     	TRid.id=id
        TRid.v=v
        TRid.vid=i
        cclog("TRid.di===>"..TRid.di)
     break  
     end 
    end
    end
end
local function TRActionMove(eventType,touchs)
	-- body
	if rTimes<=0 then return end
	cclog("====>>>>>>>>"..TRid.id)
    if TRid.id==-1 then return end 
    cclog("local function TLActionMove(eventType,touchs)")
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    if id==TRid.id then 
    	TRid.v:setPositionX(x)
    	TRid.v:setPositionY(y)
    return 
    end 
    end
end
local function TRActionEnd(eventType,touchs)
	-- body
	if rTimes<=0 then return end
	cclog("====>>>>>>>>"..TRid.id)
    if TRid.id==-1 then return end 
    cclog("local function TLActionMove(eventType,touchs)")
    for i=1,#touchs,3 do
    local x,y,id=touchs[i],touchs[i+1],touchs[i+2]--从touchs中获取一点触摸的坐标和id
    if id==TRid.id then
    	TRid.v:setPositionX(pointR[TRid.vid].x)
    	TRid.v:setPositionY(pointR[TRid.vid].y)
    	gameOverR(TRid.vid,x,y)
    	-- TRid.id=-1
    	-- TRid.vid=-1
    	-- TRid.v=nil
    return 
    end 
    end
end
local function onTouchsEvent(eventType,touchs)
        if eventType=="began" then --手指开始触摸屏幕
        	TLActionBegin(eventType,touchs)
        	TRActionBegin(eventType,touchs)
        elseif eventType=="moved" then --手指一直触摸着屏幕移动
        	cclog("moved")
           TLActionMove(eventType,touchs)
           TRActionMove(eventType,touchs)
        elseif eventType=="ended" then --手指一直触摸着屏幕放开后
           TLActionEnd(eventType,touchs)
           TRActionEnd(eventType,touchs)
        end  
end
local function GameInit()
	-- body
    isFinsh=false
	-- intiUI()
 --    math.randomseed(tostring(os.time()):reverse():sub(1, 6)*123)
 --        local _type=math.random(1,4)
 --        local _num=math.random(1,5)
	-- setType(_type, _num ,dir.L)
 --    local _t=math.random(1,4)
 --    while _type==_t do
 --        _t=math.random(1,4)
 --    end 
 --    local _n=math.random(1,5)
 --     while _num==_n do
 --        _n=math.random(1,5)
 --    end 
	-- setType(_t, _n ,dir.R)
	rTimes=3
	lTimes=3
	-- local _lb = tolua.cast(Game2DoubleLayer["LtimeBack"],"CCSprite")
	-- _lb:setVisible(false)
	-- local _lt = tolua.cast(Game2DoubleLayer["timeBackL"],"CCSprite")
	-- _lt:setVisible(false)
	-- local _rb = tolua.cast(Game2DoubleLayer["RtimeBack"],"CCSprite")
	-- _rb:setVisible(false)
	-- local _rt = tolua.cast(Game2DoubleLayer["timeBackR"],"CCSprite")
	-- _rt:setVisible(false)
	m_time=0
end
local function step( dt)
	-- body
	m_time = m_time +dt
	-- m_label0:setString(m_time)
end 
function startGame()
    -- body
    intiUI()
    ShowLPP()
    ShowRPP()
    GameInit()
    TLid={id=-1,v=nil,vid=-1}
    TRid={id=-1,v=nil,vid=-1}
    playBackMusic("music/gamebackground.mp3", true)
    gameState=0
end
local function _Game2DoubleLayer()
	-- local _layer = Game2DoubleLayer.new()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------Game2Layer")
    local  node  = CCBuilderReaderLoad("ccbi/Game2DoubleLayer.ccbi",proxy,Game2DoubleLayer)
    layer = tolua.cast(node,"CCLayer")
    -- intiUI()
    -- ShowLPP()
    -- ShowRPP()
    -- GameInit()
    layer:setTouchEnabled(true)
    layer:registerScriptTouchHandler(onTouchsEvent,true)--设置支持多点触摸
    layer:scheduleUpdateWithPriorityLua(step, 0)
    -- playBackMusic("music/gamebackground.mp3", true)
    return layer
end
function runTest()
	-- body
	local scene = CCScene:create()
	local _layer=_Game2DoubleLayer()
    scene:addChild(_layer)
    scene:addChild(runtan_fumu1Layer())
    return scene
end
require "CCBReaderLoad"
require "luaRes/RichQSLayer"
require "luaRes/GameWinLayer"
RichLayer = RichLayer or {}
ccb["RichLayer"] = RichLayer
cclog = function(...)
print(string.format(...))
end
local moveWavId
heartNum=3
HeartArr = {}
local _roleImg="zhan2_0001.png"
local AniEmu = {JTDel=0,JTNom=1,XDel=2,XNom=3,WHATDel=4,WHATNom=5,ADDX=6,RoleMove=7,RoleStand=8}
-- local JTNomAni = nil 
local _emu={normal=0,play=1,action=2}
local Game_state=0
local showTypeImgs ={}
local paths={}
showTypeImgs[1]=CCTextureCache:sharedTextureCache():addImage("saizi/1.png")
showTypeImgs[2]=CCTextureCache:sharedTextureCache():addImage("saizi/2.png")
showTypeImgs[3]=CCTextureCache:sharedTextureCache():addImage("saizi/3.png")
showTypeImgs[4]=CCTextureCache:sharedTextureCache():addImage("saizi/4.png")
showTypeImgs[5]=CCTextureCache:sharedTextureCache():addImage("saizi/5.png")
showTypeImgs[6]=CCTextureCache:sharedTextureCache():addImage("saizi/6.png")
local moveDir=0
local Dir_Emu={right=0,down=1,left=2,up=4}
local moveX=3
local moveY=3
local curPoint=0--表中的单位索引
local desPoint = 0
local map=nil
local kTagTileMap = 1
local kTagTile = 2
local kTagTileObjs = 3
local kTagTileMapRole = 5
local seed = 10000000
local mapData ={{id=3,name="map/title1.png",type=1},
                {id=4,name="map/title2.png",type=2},
                {id=5,name="map/title3.png",type=3},
                {id=6,name="map/title4.png",type=4}}
local titleDate={bing=0,huo=1,tu=2,what=3,gold=4,move=5,back=6,xin=7}
local Movedate={}
local positionX =200
local positionY=-50
local _layer=nil
local _role=nil
local map_width=9
local map_height=9
local title_w=76
local title_h=76
local cache=nil
local plat=nil 
local _moveNum=0
local function InitUi()
    -- body
    HeartArr[1]=tolua.cast(RichLayer["_heartOne"],"CCSprite")
    HeartArr[2]=tolua.cast(RichLayer["_heartTwo"],"CCSprite")
    HeartArr[3]=tolua.cast(RichLayer["_heartThree"],"CCSprite")
    for i,v in ipairs(HeartArr) do
        if i<=heartNum then v:setVisible(true) else
        v:setVisible(false)
    end 
    end
end 
local function changeBackDir()
    -- body
    if moveDir==Dir_Emu.right then moveDir=Dir_Emu.left return end 
    if moveDir==Dir_Emu.up    then moveDir=Dir_Emu.down return end 
    if moveDir==Dir_Emu.left then moveDir=Dir_Emu.right return end 
    if moveDir==Dir_Emu.down    then moveDir=Dir_Emu.up return end 
end
local function getDir( curPoint )
    -- body
    local dir ="000000"
    local _point=curPoint
    if _point>=#Movedate then return moveDir end 
    local  nextPoint=curPoint+1
    local  tem=Movedate[curPoint]
    local xx=tem._x
    local yy=tem._y
    local  temp=Movedate[nextPoint]
    local  x=temp._x
    local  y=temp._y
    if yy==y then 
        if xx<x then
            dir=Dir_Emu.right
        end 
        if xx>x then
            dir=Dir_Emu.left
        end 
    end 
    if xx==x then 
        if yy<y then
            dir=Dir_Emu.up
        end 
        dir=Dir_Emu.down
    end 
    cclog("dir---------------->"..dir)
    return dir
end
local function backMapInde(_moveNum)
    -- changeBackDir()
    cclog("curPoint=="..curPoint.."_moveNum===".._moveNum)
    local next_point=curPoint+_moveNum 

    if next_point<1 then next_point=1 end 
    -- body
    if _role==nil then 
    local fr = cache:spriteFrameByName(_roleImg)
    _role=CCSprite:createWithSpriteFrame(fr)
    -- CCSprite:create("map/mobby.png")
    _layer:addChild(_role,kTagTileMapRole,kTagTileMapRole)
    end 
    local dir =moveDir
    for i=curPoint,next_point,-1 do
        cclog("i======="..i)
        local _dir = getDir(i)
        if dit~=_dir or i==#Movedate then 
            dir=_dir
            local path={}
            local temp = Movedate[i]
            local x=temp._x
            local y=temp._y
            path._x=positionX+x*title_w+title_w/2
            path._y=positionY+y*title_h+title_h/2
            path._dir=_dir
            path._curPoint=i
            path._type=Movedate[i]._type
            path._type_index=Movedate[i]._type_index
            table.insert(paths,path)
        end 
    end
    curPoint=curPoint+_moveNum
end
local function moveMapInde(n_moveNum)
    local _moveNum = n_moveNum
    if curPoint==0 then  
    local path={}
            local temp = Movedate[1]
            local x=temp._x
            local y=temp._y
            path._x=positionX+x*title_w+title_w/2
            path._y=positionY+y*title_h+title_h/2
            path._dir=Dir_Emu.right
            path._curPoint=1
            path._type=Movedate[1]._type
            path._type_index=Movedate[1]._type_index
            table.insert(paths,path)
            curPoint=1
            _moveNum=_moveNum-1
    end
    -- if _moveNum==0 then  curPoint=1 return end 
    if _moveNum<0 then backMapInde(_moveNum) return end 
    cclog("curPoint=="..curPoint.."_moveNum===".._moveNum)
    local next_point=curPoint+_moveNum 
    cclog("next_point====>"..next_point)
    local len=#Movedate
    if next_point> len then next_point=len end 
    -- body
    if _role==nil then 
    -- _role=CCSprite:create("map/mobby.png")
    local fr = cache:spriteFrameByName(_roleImg)
    _role=CCSprite:createWithSpriteFrame(fr)
    _layer:addChild(_role,kTagTileMapRole,kTagTileMapRole)
    end 
    local dir =moveDir
    if curPoint~=next_point then
    for i=curPoint,next_point do
        cclog("curPoint===>"..curPoint.."next_point"..next_point)
        local _dir = getDir(i)
        if dit~=_dir or i==#Movedate then 
            dir=_dir
            local path={}
            local temp = Movedate[i]
            local x=temp._x
            local y=temp._y
            path._x=positionX+x*title_w+title_w/2
            path._y=positionY+y*title_h+title_h/2
            path._dir=_dir
            path._curPoint=i
            path._type=Movedate[i]._type
            path._type_index=Movedate[i]._type_index
            table.insert(paths,path)
        end 
    end
end 
    curPoint=curPoint+_moveNum
end
local function initAni( _index )
    -- body
    local moreFrames =CCArray:create() 
    if _index==AniEmu.RoleStand then 
    for i = 1,35 do
        local str = string.format("zhan2_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("zhan2_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCRepeatForever:create(CCAnimate:create(animMixed))
    end 
    if _index==AniEmu.RoleMove then 
    for i = 1,12 do
        local str = string.format("zou_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("zou_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCRepeatForever:create(CCAnimate:create(animMixed))
    end 

    if _index==AniEmu.JTDel then 
    for i = 1,15 do
        local str = string.format("jiantoubeichi_00%02d.png",i)
        cclog(str)
        local frame = cache:spriteFrameByName(string.format("jiantoubeichi_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
    end 
    -- moreFrames=CCArray:create()
    if _index==AniEmu.JTNom then  
    for i = 1,29 do
        local frame = cache:spriteFrameByName(string.format("jian_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCRepeatForever:create(CCAnimate:create(animMixed))
    end 

    if _index==AniEmu.XDel then 
    for i = 1,15 do
        local frame = cache:spriteFrameByName(string.format("xinbeichi_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
    end 
    if _index==AniEmu.XNom then 
        for i = 1,26 do
        local frame = cache:spriteFrameByName(string.format("xin_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCRepeatForever:create(CCAnimate:create(animMixed))
    end 
    if _index==AniEmu.WHATDel then 
    for i = 1,15 do
        local frame = cache:spriteFrameByName(string.format("wenhaobeichi_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
    end 
    if _index==AniEmu.WHATNom then 
    for i = 1,32 do
        local frame = cache:spriteFrameByName(string.format("wenc_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCRepeatForever:create(CCAnimate:create(animMixed))
    end 
    -- if _index==AniEmu.ADDX then end 
    -- CCArray:createWithCapacity(30)
end
local function showAction()
    -- if plat ==nil then plat=tolua.cast(RichLayer["_saiziImg"],"CCSprite") end
    cclog("------------------>")
     plat:setVisible(false)

    local back=tolua.cast(RichLayer["saiziBack"],"CCSprite")
    back:setVisible(false)

    moveMapInde(_moveNum)
    local _action = initAni(AniEmu.RoleMove)
    _role:stopAllActions()
    _role:runAction(_action)
    moveWavId=AudioEngine.playEffect("music/walk.wav",true)
end

local function palyAni()
    if Game_state~=_emu.normal then return end 
     Game_state=_emu.play
    -- body
    if plat ==nil then plat=tolua.cast(RichLayer["saiziImg"],"CCSprite") end
    plat:setVisible(true)
    plat:setZOrder(100)
    local back=tolua.cast(RichLayer["saiziBack"],"CCSprite")
    back:setVisible(true)
    back:setZOrder(99)
    local moreFrames = CCArray:createWithCapacity(30)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    _moveNum=math.random(1,6)
    local frame = cache:spriteFrameByName(string.format("%d.png",_moveNum))
   local animMixed= getsaiZiAni(frame)
    -- local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.025)
    local  pCallback = CCCallFunc:create(showAction)
    local arr = CCArray:create()
    arr:addObject(animMixed)
    arr:addObject(CCDelayTime:create(2))
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    plat:runAction(pSequence)
    AudioEngine.playEffect("music/dice.wav")
end
local function ButtonMove(eventName,control,controlEvent)
    -- body
    cclog("ButtonMove--------------------->")
    if controlEvent == CCControlEventTouchDown  then      
    elseif controlEvent == CCControlEventTouchDragInside then
    elseif controlEvent == CCControlEventTouchDragOutside then
    elseif controlEvent == CCControlEventTouchDragEnter then
    elseif controlEvent == CCControlEventTouchDragExit then
    elseif controlEvent == CCControlEventTouchUpInside then
        palyAni()

    elseif controlEvent == CCControlEventTouchUpOutside then
    end
end
local function ButtonBack(eventName,control,controlEvent)
    -- body
    cclog("ButtonMove--------------------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
    if controlEvent == CCControlEventTouchDown  then      
    elseif controlEvent == CCControlEventTouchDragInside then
    elseif controlEvent == CCControlEventTouchDragOutside then
    elseif controlEvent == CCControlEventTouchDragEnter then
    elseif controlEvent == CCControlEventTouchDragExit then
    elseif controlEvent == CCControlEventTouchUpInside then
    local _scenes = runWorldMapLayer()
        -- CCDirector:sharedDirector():replaceScene(_scenes)
        CCDirector:sharedDirector():replaceScene(_scenes)
    elseif controlEvent == CCControlEventTouchUpOutside then
    end
end
RichLayer["buttonMove"]=ButtonMove
RichLayer["buttonBack"]=ButtonBack
local function initRoleP()
    -- body
    if _role==nil then 
    -- _role=CCSprite:create("map/mobby.png")
    local fr = cache:spriteFrameByName(_roleImg)
    _role=CCSprite:createWithSpriteFrame(fr)
    _layer:addChild(_role,kTagTileMapRole,kTagTileMapRole)
    end 
    _role:setAnchorPoint(ccp(0.5,0))
    _role:setPositionX(100)
    _role:setPositionY(500)
    local _action = initAni(AniEmu.RoleStand)
    _role:stopAllActions()
    _role:runAction(_action)
    -- AudioEngine.stopEffect(moveWavId)
end
local function setMapPosition(_position)
	-- body
	if _role==nil then 
    -- _role=CCSprite:create("map/mobby.png")
    local fr = cache:spriteFrameByName(_roleImg)
    _role=CCSprite:createWithSpriteFrame(fr)
    _layer:addChild(_role,kTagTileMapRole,kTagTileMapRole)
	end 
	local temp = Movedate[_position]
	local x=temp._x
	local y=temp._y
	_role:setAnchorPoint(ccp(0.5,0))
	_role:setPositionX(positionX+x*title_w+title_w/2)
	_role:setPositionY(positionY+y*title_h+title_h/2)
	curPoint=_position
end
local function moveNum(_num)--移动单元格
    local _action = initAni(AniEmu.RoleMove)
    _role:stopAllActions()
    _role:runAction(_action)
	moveMapInde(_num)
end
local function getType(_gid)
	-- body
	for i,v in ipairs(mapData) do
    if v.id==_gid then 
    	cclog("------------"..v.id)
    	return v
	end
   
end 
return nil
end 
local function addSprite(_x,_y,_dir,_type)
	-- body
	local _sprite=nil 
	local name=string.format("map/title_%02d.png",_type)
	_sprite=CCSprite:create(name)
	_sprite:setAnchorPoint(ccp(0.5,0.5))
	_sprite:setPositionX(positionX+_x*title_w)
	_sprite:setPositionY(positionY-_y*title_h)
    local _spriteB = CCSprite:create("ying.png")
    -- _spriteB:setAnchorPoint(ccp(0.5,0.5))
    _spriteB:setPositionX(positionX+_x*title_w)
    _spriteB:setPositionY(positionY-_y*title_h)
    _layer:addChild(_sprite)
	_layer:addChild(_spriteB)
end
local function InitSprite(_map)
	local group = _map:objectGroupNamed("objs")
    local  objects = group:getObjects()
    local  dict = nil
    local  i = 0
    local  len = objects:count()
    for i = 0, len-1, 1 do
        dict = tolua.cast(objects:objectAtIndex(i), "CCDictionary")

        if dict == nil then
            break
        end
        local key = "gid"
        local gid = (tolua.cast(dict:objectForKey(key), "CCString")):intValue()
        key = "x"
        local x = (tolua.cast(dict:objectForKey(key), "CCString")):intValue()--dynamic_cast<NSNumber*>(dict:objectForKey("x")):getNumber()
        key = "y"
        local y = (tolua.cast(dict:objectForKey(key), "CCString")):intValue()
        -- cclog("x=="..x.."^^^^^^yy=="..y.."gid==="..gid)
        key = "id"
        local id = (tolua.cast(dict:objectForKey(key), "CCString")):intValue()--dynamic_cast<NSNumber*>(dict:objectForKey("y")):getNumber()
        key = "type"
        local _type = (tolua.cast(dict:objectForKey(key), "CCString")):intValue()
        key = "r"
        local temp=dict:objectForKey(key)
        cclog("x=="..x.."^^^^^^yy=="..y.."gid==="..gid.."id==="..id.."type===".._type)
        local _r=nil
        if temp~= nil then 
         _r= (tolua.cast(dict:objectForKey(key), "CCString")):intValue()
        end 
    local xx =positionX+x
    local yy =positionY+y 
    local titleName=nil
    local temp={}
    temp._back=nil
    temp._show=nil
    if _type==titleDate.bing then 
    titleName="map/title1.png"
    end
    if _type==titleDate.huo then 
    titleName="map/title3.png"
    end  
    if _type==titleDate.tu then 
    titleName="map/title2.png"
    end 
    if _type==titleDate.what then 
    	titleName="map/title4.png"
        local _sp=CCSprite:create("map/what.png")
        _sp:setAnchorPoint(ccp(0.5,0.5))
        _sp:setPosition(xx+title_w/2,yy+title_h-10)
        _layer:addChild(_sp,kTagTileObjs,kTagTileObjs)
        temp._back=_back
        temp._show=_sp
        local _action=initAni(AniEmu.WHATNom)
        _sp:runAction(_action)
    end 
    if _type==titleDate.gold then 
    	titleName="map/title4.png"
    	-- local _sp=CCSprite:create("map/what.png")
    	-- _sp:setAnchorPoint(ccp(0.5,0))
     --    _sp:setPosition(xx+title_w/2,yy+title_h/2)
     --    _layer:addChild(_sp,kTagTileObjs,kTagTileObjs)
    end 
    if _type==titleDate.move then 
    	titleName="map/title4.png"
        local _back=CCSprite:create("map/back.png")
        _back:setAnchorPoint(ccp(0.5,0))
        _back:setPosition(xx+title_w/2,yy+title_h/2)
        _layer:addChild(_back,kTagTileObjs,kTagTileObjs)
        local _sp=CCSprite:create("map/dir.png")
        _sp:setAnchorPoint(ccp(0.5,0.5))
        _sp:setPosition(xx+title_w/2,yy+title_h)
        _layer:addChild(_sp,kTagTileObjs,kTagTileObjs)
        if _r~=nil then _sp:setRotation(_r) end 
        temp._back=_back
        temp._show=_sp
        local _action=initAni(AniEmu.JTNom)
        _sp:runAction(_action)
    end 
    if _type==titleDate.back then 
    	titleName="map/title4.png"
        local _back=CCSprite:create("map/back.png")
        _back:setAnchorPoint(ccp(0.5,0))
        _back:setPosition(xx+title_w/2,yy+title_h/2)
        _layer:addChild(_back,kTagTileObjs,kTagTileObjs)
        local _sp=CCSprite:create("map/dir.png")
        _sp:setAnchorPoint(ccp(0.5,0.5))
        _sp:setPosition(xx+title_w/2,yy+title_h)
        _layer:addChild(_sp,kTagTileObjs,kTagTileObjs)
        if _r~=nil then _sp:setRotation(_r) end 
        temp._back=_back
        temp._show=_sp
        local _action=initAni(AniEmu.JTDel)
        _sp:runAction(_action)
    end 
    if _type==titleDate.xin then 
    	titleName="map/title4.png"
        -- local _back=CCSprite:create("map/back.png")
        -- _back:setAnchorPoint(ccp(0.5,0))
        -- _back:setPosition(xx+title_w/2,yy+title_h/2)
        -- _layer:addChild(_back,kTagTileObjs,kTagTileObjs)
        local _sp=CCSprite:create("map/heart.png")
        _sp:setAnchorPoint(ccp(0.5,0.5))
        _sp:setPosition(xx+title_w/2,yy+(title_h)-20)
        _layer:addChild(_sp,kTagTileObjs,kTagTileObjs)
        temp._back=_back
        temp._show=_sp
        local _action=initAni(AniEmu.XNom)
        _sp:runAction(_action)
    end 
    if titleName~=nil then 
    local _sprite = CCSprite:create(titleName)
    _sprite:setAnchorPoint(ccp(0,0))
    _sprite:setPosition(xx,yy)
    _layer:addChild(_sprite,1,kTagTile)
    local _spriteB = CCSprite:create("map/ying.png")
    _spriteB:setAnchorPoint(ccp(0,0.7))
    _spriteB:setPositionX(xx)
    _spriteB:setPositionY(yy)
    _layer:addChild(_spriteB,1,kTagTile)
    end 
    temp._x=x/title_w
    temp._y=y/title_h
    temp._type=_type
    temp._id=id
    table.insert(Movedate,temp)
end
local function sortObjs( a,b )
    -- body
   local x= a._id
   local y= b._id
    return x<y
end 
    table.sort( Movedate, sortObjs)
end 
local function isCurPointCenter(x,y,xx,yy)
	-- body
   local p=ccp(x,y)
   local p2 = ccp(xx,yy)
   local dis = ccpDistance(ccp(xx,yy),ccp(x,y))
   if dis<4 then return true end 
   return false 
end
local function addHeart()
    -- body
     if heartNum==3 then return end 
    heartNum=heartNum+1
    for i,v in ipairs(HeartArr) do
        if i<=heartNum then v:setVisible(true) else 
            v:setVisible(false)
        end
    end 
end
local function doAction( _type ,objs)
    if curPoint>=#Movedate then 
        local _s=runGameWinLayer(true)
        CCDirector:sharedDirector():replaceScene(_s)
        return 
    end 
    -- body
    if titleDate.bing==_type then 
        AudioEngine.playEffect("music/task.wav")
        local _s = runRichQSLayer()
        CCDirector:sharedDirector():pushScene(_s)
    end 
    if titleDate.huo==_type then 
        AudioEngine.playEffect("music/task.wav")
        local _s = runRichQSLayer()
        CCDirector:sharedDirector():pushScene(_s)
    end 
    if titleDate.tu==_type then 
        AudioEngine.playEffect("music/task.wav")
        local _s = runRichQSLayer()
        CCDirector:sharedDirector():pushScene(_s)
    end 
    if titleDate.what==_type then 
        cclog("what------->")
        AudioEngine.playEffect("music/interrogation.wav")
        if objs~=nil then 
            local _fun = function ()
                -- body
                objs:setVisible(false)
            end
            local  pCallback = CCCallFunc:create(_fun)
            local arr = CCArray:create()
            local animMixed = initAni( AniEmu.WHATDel )
            arr:addObject(animMixed)
            arr:addObject(pCallback)
            local  pSequence = CCSequence:create(arr)
            objs:runAction(pSequence)
        end 
    end 
    if titleDate.gold==_type then 
        cclog("gold------->")
    end 
    if titleDate.move==_type then 
        AudioEngine.playEffect("music/arrow.wav")
        cclog("move------->")
        -- moveNum(1)
        if objs~=nil then 
            local _fun = function ()
                -- body
                moveNum(1)
                objs:setVisible(false)
            end
            local  pCallback = CCCallFunc:create(_fun)
            local arr = CCArray:create()
            local animMixed = initAni(AniEmu.JTDel)
            arr:addObject(animMixed)
            arr:addObject(pCallback)
            local  pSequence = CCSequence:create(arr)
            objs:runAction(pSequence)
        end 
    end 
    if titleDate.back==_type then 
        AudioEngine.playEffect("music/arrow.wav")
        cclog("back------->")
        -- moveNum(-1)
        local _fun = function ()
                -- body
                moveNum(-1)
                objs:setVisible(false)
            end
            local  pCallback = CCCallFunc:create(_fun)
            local arr = CCArray:create()
            local animMixed = initAni( AniEmu.JTDel )
            arr:addObject(animMixed)
            arr:addObject(pCallback)
            local  pSequence = CCSequence:create(arr)
            objs:runAction(pSequence)
    end 
    if titleDate.xin==_type then
    cclog("xin------->") 
    AudioEngine.playEffect("music/boold.wav")
    if objs~=nil then 
            local _fun = function ()
                -- body
                objs:setVisible(false)
                addHeart()
            end
            local  pCallback = CCCallFunc:create(_fun)
            local arr = CCArray:create()
            local animMixed = initAni( AniEmu.XDel )
            arr:addObject(animMixed)
            arr:addObject(pCallback)
            local  pSequence = CCSequence:create(arr)
            objs:runAction(pSequence)
        end 
    end 

end
local function move()
	if #paths<1 then 
		-- cclog("len<1---->Paths ")
		return 
	end 
	-- body
	local x = paths[1]._x
	local y = paths[1]._y
	local xx = _role:getPositionX()
	local yy = _role:getPositionY()
    if x>xx then 
    	xx=xx+moveX
    	if xx>x then xx=x end 
    end 
    if x<xx then 
    	xx=xx-moveX
    	if xx<x then xx=x end 
    end 
    if y>yy then 
    	yy=yy+moveY
    	if yy>y then yy=y end 
    end 
    if y<yy then 
    	yy=yy-moveY
    	if yy<y then yy=y end 
    end

    _role:setPositionX(xx)
	_role:setPositionY(yy)
    local dis = ccpDistance(ccp(xx,yy),ccp(x,y))
    if dis <5 then 
    _role:setPositionX(x)
	_role:setPositionY(y)
	curPoint=paths[1]._curPoint
    moveDir=paths[1]._dir
    cclog("moveDir===>>>>>>>>"..moveDir)
    if moveDir==Dir_Emu.left then _role:setScaleX(-1)elseif moveDir==Dir_Emu.right then 
    _role:setScaleX(1)
    end 
	table.remove(paths,1)
    end 
    if #paths==0 then 
        cclog("curPoint----------->"..curPoint)
   local outType= Movedate[curPoint]._type
   if Movedate[curPoint]._back~=nil then Movedate[curPoint]._back:setVisible(false) end 
    doAction(outType,Movedate[curPoint]._show)
    Game_state=_emu.normal 
    local _action = initAni(AniEmu.RoleStand)
    _role:stopAllActions()
    _role:runAction(_action)
    AudioEngine.stopEffect(moveWavId)
   end 
   end
local function step(dt)
	-- body
	move()
end
local function initDateGame( )
    -- body
    Game_state=_emu.normal 
    _role=nil 
    paths={}
    curPoint=0
    map=nil
    Movedate={}
    plat=nil 
    _moveNum=0
end
function _RichLayer()
	-- body
    heartNum=3
    initDateGame()
    cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/saiziNumAni.plist", "ani/saiziNumAni.png")
    cache:addSpriteFramesWithFile("ani/JTBeiChiAni.plist", "ani/JTBeiChiAni.png")
    cache:addSpriteFramesWithFile("ani/RichAni.plist", "ani/RichAni.png")
    cache:addSpriteFramesWithFile("ani/HeartAddAni.plist", "ani/HeartAddAni.png")
    cache:addSpriteFramesWithFile("ani/HeartDelAni.plist", "ani/HeartDelAni.png")
    cache:addSpriteFramesWithFile("ani/HeartGetAni.plist", "ani/HeartGetAni.png")
    cache:addSpriteFramesWithFile("ani/HeartNomAni.plist", "ani/HeartNomAni.png")
    cache:addSpriteFramesWithFile("ani/JTNomAni.plist", "ani/JTNomAni.png")
    cache:addSpriteFramesWithFile("ani/RoleAni.plist", "ani/RoleAni.png")
    cache:addSpriteFramesWithFile("ani/WhatNomAni.plist", "ani/WhatNomAni.png")
    cache:addSpriteFramesWithFile("ani/WhatDelAni.plist", "ani/WhatDelAni.png")

    -- initAni(0)
    local  proxy = CCBProxy:create()
    cclog("-------RichLayer")
    local  node  = CCBuilderReaderLoad("ccbi/RichLayer.ccbi",proxy,RichLayer)
    _layer = tolua.cast(node,"CCLayer")
	map = CCTMXTiledMap:create("map/map_0.tmx")
	map:setPosition(positionX,positionY)
    _layer:addChild(map, 0, kTagTileMap)
    InitSprite(map)
    _layer:scheduleUpdateWithPriorityLua(step, 0)
    -- setMapPosition(1)
    initRoleP()
    moveDir=Dir_Emu.right
    InitUi()
    -- local sp = CCSprite:create("saizi/1.png")
    -- local animMixed= getBlsAni(0)
    -- sp:runAction(animMixed)
    -- sp:setPositionX(512)
    -- sp:setPositionY(386)
    -- _layer:addChild(sp)

    playBackMusic("music/gamebackground.mp3", true)
	return _layer
end
function runRichLayer()
    cclog("runRichLayer")
    local scene = CCScene:create()
    scene:addChild(_RichLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end
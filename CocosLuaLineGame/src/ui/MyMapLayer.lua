require "Obj"
require "Rules"
local MyMapLayer = class("MyMapLayer")
MyMapLayer.__index = MyMapLayer
function MyMapLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, MyMapLayer)
    return target
end
function MyMapLayer:MyMapLayerAddCells() --@return typeOrObject
    for k,v in ipairs(Rules._mapData) do
--        cclog("v._type===%s",v._type)
        local _obj=creatMapCellNode(v._type,v._col,v._row)
        Rules._node:addChild(_obj)
end
end
function MyMapLayer:initBackLayer(x,y,width,height,_type) --@return typeOrObject
--    cclog("_type==%s,x===%d,y===%d,width===%d,height===%d",_type,x,y,width,height)
require "MapCellNode"
    local colStart=x/Rules.objW
    local rowStart=y/Rules.objH
    local colW=colStart+(width/Rules.objW)
    local rowH=rowStart+(height/Rules.objH)
   for _col=colStart, colW-1 do
        for _row=rowStart, rowH-1 do
            local _cell=Rules.get_mapData_cell(_row,_col)
            if _cell==nil then 
            local _table={_type=_type,_row=_row,_col=_col}
            table.insert(Rules._mapData,_table)
            elseif _cell._type=="normal" then
            _cell._type=_type
            end
   	end
        
end
end
function MyMapLayer:creatObj(_type,_col,_row) --@return typeOrObject
    local x=_col*Rules.objW
    local y=_row*Rules.objH
    local temp=creatObj(_type,_col,_row)
    temp:setPosition(x,y)
    Rules._node:addChild(temp)
    return  temp
end
function MyMapLayer:creatObjs() --@return typeOrObject
    require "LineObj"
    for i=0, Rules.MapRow-1 do
        for j=0, Rules.MapCol-1 do
            local _row=i
            local _col=j
            math.randomseed(os.time()*i*j)
            local _type=math.random(1,4)
            self:creatObj(_type,_col,_row)
        end
    end
end
function MyMapLayer:drawLine() --@return typeOrObject
    local row=Rules.MapRow
    local col=Rules.MapCol
    local w=Rules.objW
    local h=Rules.objH
    local glNode  = gl.glNodeCreate()
    glNode:setAnchorPoint(cc.p(0,0))
    local function primitivesDraw(transform, transformUpdated)
        kmGLPushMatrix()
        kmGLLoadMatrix(transform)
        for i=0, row do
            local x1=0
            local y1=i*h
            local x2=col*w
            local y2=i*h
            cc.DrawPrimitives.drawLine(cc.p(x1,y1), cc.p(x2,y2) )
           
        end
        for i=0, row do
            local x1=i*w
            local y1=0
            local x2=i*w
            local y2=row*h
            cc.DrawPrimitives.drawLine(cc.p(x1,y1), cc.p(x2,y2) )
        end
        gl.lineWidth( 1.0 )
        cc.DrawPrimitives.drawColor4B(255,0,0,255)
        kmGLPopMatrix()
    end
    glNode:registerScriptDrawHandler(primitivesDraw)
    self:addChild(glNode)
end
function MyMapLayer:init()
--    self:drawLine()
--    Rules._mapLayer=self
end
function MyMapLayer.create()
    require "Rules"
    cclog("----->function MyMapLayer.create()")
    local layer = MyMapLayer.extend(cc.Layer:create())
    return layer
end
function MyMapLayer:addObjs() --@return typeOrObject
    for k,v in ipairs(Rules._mapData) do
        if v._type==_mapCellType.normal or v._type==_mapCellType.lock then
        local _typeTable={1,2,3,4,5}
            math.randomseed(os.time()*v._col*v._row)
            local _type=math.random(1,#_typeTable)
            local _finalType={}
            v.obj=MyMapLayer:creatObj(_type,v._col,v._row)
            Rules.checkDellList(v,_finalType)
            while #_finalType>=3 do--防止生成消除
                cclog("in while"..#_finalType.."t->"..#_typeTable)
                v.obj:removeFromParent(true)
            	_finalType={}
                table.remove(_typeTable,_type)
                _type=math.random(1,#_typeTable)
                v.obj=MyMapLayer:creatObj(_type,v._col,v._row)
                Rules.checkDellList(v,_finalType)
            end
		end
--		if v._type==_mapCellType.lock then
--			math.randomseed(os.time()*v._col*v._row)
--            local _type=math.random(1,4)
--            v.obj=MyMapLayer:creatObj(_type,v._col,v._row)
--            v.obj:setLock(true)
--		end
	end
end
function MyMapLayer:initMapData() --@return typeOrObject
    local map=cc.TMXTiledMap:create("map_0.tmx")
    Rules._node= cc.Layer:create()
    self:addChild(Rules._node)
    local _size=map:getTileSize()
    Rules.objW=_size.width
    Rules.objH=_size.height
--    cclog("objW=====%d,objH=====%d",Rules.objW,Rules.objH)
--    self:addChild(map)
    local  group = map:getObjectGroup("cellData")
    local  objects = group:getObjects()
    local  dict = nil
    local  i = 0
    local  len = table.getn(objects)
    for i = 0, len-1, 1 do
        dict = objects[i + 1]
        if dict == nil then
            break
        end
        local key = "x"
        local x = dict["x"]
        key = "y"
        local y = dict["y"]--dynamic_cast<NSNumber*>(dict:objectForKey("y")):getNumber()
        key = "width"
        local width = dict["width"]--dynamic_cast<NSNumber*>(dict:objectForKey("width")):getNumber()
        key = "height"
        local height = dict["height"]--dynamic_cast<NSNumber*>(dict:objectForKey("height")):getNumber()
        local type=dict["type"]
        
        local _color=Rules.debug_color[type]
        local _drawNode=cc.DrawNode:create()
        local points={cc.p(0,0), cc.p(0, height), cc.p(width,height), cc.p(width, 0)}
        _drawNode:drawPolygon(points, table.getn(points), _color,1,_color)
        _drawNode:setPosition(x,y)
--        self:addChild(_drawNode)
        self:initBackLayer(x,y,width,height,type)
    end
    self:MyMapLayerAddCells()
    self:addChild(map)
end
function CreatMapLayer() --@return typeOrObject
    cclog("function CreatMap------Layer()")
    Rules._mapLayer=MyMapLayer.create()
    Rules._mapLayer:registerScriptHandler(function(tag)
        if "enter" == tag then
            Rules._mapLayer:onEnter()
        elseif "exit" == tag then
        elseif "draw" then 
--         Rules._mapLayer.draw()
        end
    end)
    Rules._mapLayer:AddTouch()
--    Rules._mapLayer:initBackLayer()
    Rules._mapLayer:initMapData()
    Rules._mapLayer:addObjs()
    return Rules._mapLayer
end
function MyMapLayer:onEnter()
    cclog("function MyMapLayer:onEnter()")
    beginTick()
end
function MyMapLayer:AddTouch() --@return typeOrObject
    cclog("function MyMapLayer:AddTouch()")
    require "Rules"
    local  listenner = cc.EventListenerTouchOneByOne:create()
    --    listenner:setSwallowTouches(true)
    listenner:registerScriptHandler(function(touch, event)
        Rules.OnTouchBegin(touch)
        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN )
    listenner:registerScriptHandler(function(touch, event)
        Rules.OnTouchMove(touch)
    end,cc.Handler.EVENT_TOUCH_MOVED )
    listenner:registerScriptHandler(function(touch, event)
        Rules.OnTouchEnd(touch)
    end,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listenner, self)
end
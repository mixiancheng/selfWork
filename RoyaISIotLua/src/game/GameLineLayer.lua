GameLineLayerState={normal=0,showAll=1,showEvery=2,showOver=3}
ShowTimes={all=40,every=25}
local scheduler=cc.Director:getInstance():getScheduler()
GameLineLayer=class("GameLineLayer",function ()
	return cc.Layer:create()
end)
GameLineLayer.__=GameLineLayer
GameLineLayer._state=0
GameLineLayer._array=nil
GameLineLayer._drawNodes=nil
GameLineLayer._count=0
GameLineLayer._showIndex=1
function GameLineLayer:creatLineNode(_points)
    local glNode  = gl.glNodeCreate()
    local function primitivesDraw(transform, transformUpdated)
    kmGLPushMatrix()
    kmGLLoadMatrix(transform)
    cc.DrawPrimitives.drawColor4B(255, 255, 0, 255)
    gl.lineWidth(10)
        cc.DrawPrimitives.drawPoly( _points, 5, false)
    kmGLPopMatrix()
    end
    glNode:registerScriptDrawHandler(primitivesDraw)
return glNode
end
function GameLineLayer:rInit()
    self._state=GameLineLayerState.normal
    for k,v in ipairs(self._drawNodes) do
    	v:removeFromParentAndCleanup()
    end
    self._drawNodes={}
    self._count=0
end
function GameLineLayer:init()
	self._state=GameLineLayerState.normal
	self._drawNodes={}
	self._count=0
	function showTick(dt)--tick
		if self._state==GameLineLayerState.normal then
			return
		end
		if self._state==GameLineLayerState.showAll then
			self._count=self._count-1
			if self._count<0 then
		    self._state=GameLineLayerState.showEvery
            for k,v in ipairs(self._drawNodes) do
		    	v:setVisible(false)
		    end
		    self._count=ShowTimes.every
			end
		end
		if self._state==GameLineLayerState.showEvery then
			self._count=self._count-1
			if self._count<0  then
			for k,v in ipairs(self._drawNodes) do
                v:setVisible(false)
			end
		   if self._showIndex<=#self._drawNodes then
            cclog("showIndex==="..self._showIndex)
			self._drawNodes[self._showIndex]:setVisible(true)
			self._count=ShowTimes.every
			self._showIndex=self._showIndex+1
			else
			self._state=GameLineLayerState.showOver
			self._showIndex=1
			end
			end
		end
		if self._state==GameLineLayerState.showOver then
--			cclog("------>")
		end
	end
    scheduler:scheduleScriptFunc(showTick,0,false)
end
function GameLineLayer:addShowArray(_array)
	self._array=_array
	self._state=GameLineLayerState.showAll
	self._count=ShowTimes.all
	for k,v in ipairs(_array) do
		local _index=v._index
        local _arrayPoint=_rule.getLineDrawPoint(_index)
        local _points={}
        for i,p in ipairs(_arrayPoint) do
        	local _col=p._col
        	local _row=p._row
        	local _x=_col*_rule.cellW+75
        	local _y=_row*_rule.cellH+75
        	local _point=cc.p(_x,_y)
        	table.insert(_points,_point)
        end
        local _node=self:creatLineNode(_points)
        table.insert(self._drawNodes,_node)
        self:addChild(_node)
	end
end
function CreatGameLineLayer()
	local _layer=GameLineLayer.new()
	_layer:init()
	return _layer
end
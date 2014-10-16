require "GameObjNode"
objOrder={normal=1,Spec=2}
GameColNode=class("GameColNode",function()
    return cc.Node:create()
end)
GameColNode.__index=GameColNode
GameColNode._col=0--列
GameColNode._objs=nil--元素容器
GameColNode._ClippingNode=nil
GameColNode._state=0
GameColNode._getDataTime=0
GameColNode._isLock=false
GameColNode._rspinObjs=nil
function GameColNode:dellRspinObj()
	for k,v in ipairs(self._rspinObjs) do
--	cc.Node:removeFromParentAndCleanup(bool)
		v:removeFromParent()
	end
	self._rspinObjs={}
end
function GameColNode:checkRspInObj(_col,_row)
    for k,v in ipairs(self._rspinObjs) do
		if v._col==_col and v._row==_row then
			return v
		end
	end
	return  nil
end
function GameColNode:intiData(_col)
    self._isLock=false
    self._rspinObjs={}
	self._state=ColState.normal
	self:setCol(_col)
	self:initObjs()
    self._getDataTime=_rule.moveTimes
end
function GameColNode:beginSpin()
if self._isLock~=true then
    self._getDataTime=_rule.moveTimes
    self._state=ColState.moveIng
    for k,v in ipairs(self._objs) do
    	v._isFinaldata=false
    end
end
end
--获取服务器数据
function GameColNode:getFinalData()
	self._getDataTime=self._getDataTime-1
	if self._getDataTime==0 then
        math.randomseed(tostring(os.time()):reverse():sub(1, 6))
        local _index=math.random(1,100)
        for _row=0, _rule.rowNum-1 do
            local _type=
            _rule.getLine_Value(self._col+1,_index+_row)
            if _GameControl._rspin==GameControlRSpin.second  then--rspin
                local _obj=self:checkRspInObj(self._col,_row)
                if _obj~=nil then
                	_type=_obj._type
                end
            end
            local _y=self._objs[#self._objs]:getPositionY()+_rule.cellH
            local _obj=creatGameObjNode(_type,self._col,0)
            _obj:setPositionY(_y)
            _obj._isFinaldata=true
            self._ClippingNode:addChild(_obj,objOrder.normal)
            table.insert(self._objs,_obj)
        end
	end
end
function GameColNode:moveTick()
    self:getFinalData()
    local _second=self._objs[2]
    if _second:getPositionY()-_rule.moveStep<0 then
        if _second._isFinaldata==true then
            table.remove(self._objs,1)
            local _moveStep=_second:getPositionY()
            for k,v in ipairs(self._objs) do
                v:setPositionY(v:getPositionY()-_moveStep)
                v._col=self._col
                v._row=k-1
            end
            self._state=ColState.moveOver
            if _GameControl._rspin==GameControlRSpin.first then--rspin
            cclog("new obj")
                for var=1, _rule.rowNum do
                    local _obj=self._objs[var]
                    if _obj._type==_rule._DATE_TYPE.SPEC.type 
                    or _obj._type==_rule._DATE_TYPE.WILD.type then
                    local _col=self._col
                    local _row=var-1
                    local _type=_obj._type
                    local _newObj=creatGameObjNode(_type,_col,_row)
                        _newObj:setScale(0.7)
                    self._ClippingNode:addChild(_newObj,objOrder.Spec)
                    table.insert(self._rspinObjs,_newObj)
                    end
            	end
            end
        return
        end
        local _y=self._objs[#self._objs]:getPositionY()+_rule.cellH
        local _first=self._objs[1]
        table.remove(self._objs,1)
        table.insert(self._objs,_first)
        _first:setPositionY(_y)
    else
    end
    for k,v in ipairs(self._objs) do
        v:setPositionY(v:getPositionY()-_rule.moveStep)
    end
end
--设置列坐标
function GameColNode:setCol(_col)
    self._col=_col
    self:setAnchorPoint(cc.p(0,0))
    self:setPositionX(_col*_rule.cellW)
end
--初始化元素
function GameColNode:initObjs()
    self._objs={}
    local _Node=cc.DrawNode:create()
    local points = { cc.p(0, 0), cc.p(0,_rule.cellH*4), cc.p(_rule.cellW*4,_rule.cellH*4),cc.p(_rule.cellW*4,0) }
    _Node:drawPolygon(points, table.getn(points), cc.c4f(0,0,0,0), 1, cc.c4f(0,0,0,0))
    self._ClippingNode=cc.ClippingNode:create(_Node)
    self:addChild(self._ClippingNode)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local _index=math.random(1,100)
    for _row=0, _rule.rowNum do
        local _type=_rule.getLine_Value(self._col+1,_index+_row)
        local _obj=creatGameObjNode(_type,self._col,_row)
        self._ClippingNode:addChild(_obj,objOrder.normal)
        table.insert(self._objs,_obj)
    end
    function myUpdate(dt)
    if self._isLock~=true then
    if self._state==ColState.moveIng then
       self:moveTick()
    end
    end
    end
    local scheduler= cc.Director:getInstance():getScheduler()
    local schedulerEntry= scheduler:scheduleScriptFunc(myUpdate,0, false)
end
--创建一列
function CreatColNode(_col)
    local _colNode=GameColNode.new()
    _colNode:intiData(_col)
    return _colNode
end
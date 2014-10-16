require "GameLineLayer"
GameColNodeState={normal=0,spin=1,showLine=2}
GameControlRSpin={first=3,second=2,over=1}
GameBet={100,1000,5000,10000}
GameBetIndex=1
function changeBet(_step)
	GameBetIndex=GameBetIndex+_step
	if GameBetIndex<1 then GameBetIndex=#GameBet end
	if GameBetIndex>#GameBet then GameBetIndex=1 end 
end
GameControl=class("GameControl")
GameControl.__index=GameControl
GameControl._colNodes=nil
GameControl._scheId=0
GameControl._spinIndex=0
GameControl._state=0
GameControl._FinalData=nil--数据
GameControl._rspin=0--rspin
GameControl._freeSpin=0--freespin
local scheduler=cc.Director:getInstance():getScheduler()
local _gameControl=nil
function GameControl:FinalDataInit()
    self._FinalData={}
    for var=1, _rule.colNum do
		local _table={-1,-1,-1,-1}
		table.insert(self._FinalData,_table)
	end
	for var=_rule.rowNum, 1 ,-1 do--debug
        cclog(""..self._FinalData[1][var]..","
            ..self._FinalData[2][var]..","
            ..self._FinalData[3][var]..","
            ..self._FinalData[4][var]..","
            ..self._FinalData[5][var]..","
                 )
              end
end
function debugOutFinal(_finla)
    for k,v in ipairs(_finla) do
        local _index=v._index
        cclog("hitLind====".._index)
        local _array=v._array
        local outStr="point->"
        for k,v in ipairs(_array) do
            cclog(outStr..v._col..","..v._row)
        end
    end
end
function GameControl:spinTick()
    local _isOver=true
    for k,v in ipairs(self._colNodes) do
        if v._state==ColState.moveIng then _isOver=false end
    end
    if _isOver==true then--spin结束
     if self._rspin==0 then--检查是否rsSpin
     local _bool=_rule.checkRspin()
     if _bool==true then
     self._rspin=GameControlRSpin.first
     self._colNodes[1]._isLock=true
     self._spinIndex=2
     end
     else
        self._rspin=self._rspin-1
        cclog(""..self._rspin)
     end
        self._state=GameColNodeState.normal
        local _finla=_rule.getHitLines()
        if _finla~=nil then
            self._state=GameColNodeState.showLine
            _lineLayer:addShowArray(_finla)
            debugOutFinal(_finla)
        end
    end
end
function GameControl:init()
    self:FinalDataInit()
	self._colNodes={}
	self._rspin=0
	self._spinIndex=1
	self._state=GameColNodeState.normal
    function ControlTick(dt)
		if self._state==GameColNodeState.spin then--spin
		self:spinTick()
		end
		if self._state==GameColNodeState.normal then--normal
		
		end
		if self._state==GameColNodeState.showLine then--showline
            if _lineLayer._state==GameLineLayerState.showOver then
                self._state=GameColNodeState.normal
		     end
		end 
	end
	scheduler:scheduleScriptFunc(ControlTick,0.25,false)
end
function GameControl:rsPinOver()
        for k,v in ipairs(self._colNodes) do
            v:dellRspinObj()
        end
        self._rspin=0
    self._colNodes[1]._isLock=false
end
function GameControl:spin()
    if self._state==GameColNodeState.normal then
        cclog("spin--->"..self._rspin)
    self._state=GameColNodeState.spin
    self._spinIndex=1
    if self._rspin==GameControlRSpin.first or self._rspin==GameControlRSpin.second then
    self._spinIndex=2
    end
    if self._rspin==GameControlRSpin.over then
            cclog("GameControlRSpin.over")
            self:rsPinOver()
    end
    _lineLayer:rInit()
    self._colNodes[self._spinIndex]:beginSpin()
    self._spinIndex=self._spinIndex+1
    function spinUpdate(dt)
	if self._spinIndex>#self._colNodes then
    scheduler:unscheduleScriptEntry(self._scheId)
	else
	self._colNodes[self._spinIndex]:beginSpin()
    self._spinIndex=self._spinIndex+1
	end
    end
    self._scheId=scheduler:scheduleScriptFunc(spinUpdate,0.5, false)
    end
end
function getGameControl()
	if _gameControl==nil then
		_gameControl=GameControl.new()
		_gameControl:init()
	end
	return _gameControl
end

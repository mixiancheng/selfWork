require "Rules"
local _game_state=0
--objW=64
--objH=64
GAMESTATE={normal=0,changeing=1,droping=2}
DIR={right={type=0,point=cc.p(1,0)},down={type=1,point=cc.p(0,-1)},left={type=2,point=cc.p(-1,0)},up={type=3,point=cc.p(0,1)}}
function setGameState(_state) --@return typeOrObject
	_game_state=_state
	cclog("gamestate-->".._game_state)
end
function getGameState() --@return typeOrObject
	return _game_state
end
---
--
--是否可通过单元
function isAliveCel(_cell) --@return typeOrObject
    if _cell~=nil and _cell.obj==nil then
        if _cell._type~="dead" and _cell._type~="lock" then
            return true
        end
end
return false
end
---
--
--是否死节点
function isDeadCel(_cell) --@return typeOrObject
    if _cell==nil then
        return true
    end
if _cell._type=="dead"or _cell._type=="lock" then
        return true
    end
    return false
end
--根据行列获得_cell
function getCell(_col,_row) --@return typeOrObject
    for k,v in ipairs(Rules._mapData) do
        if v._col==_col and v._row==_row then
            return v
        end
end
return nil
end
-- 获得下一个可移动单元
function getNextCell(_cell) --@return typeOrObject
local _col=_cell._col
local _row=_cell._row-1
    local _center=getCell(_col,_row)
    local _left=getCell(_col-1,_row)
    local _right=getCell(_col+1,_row)
    if isAliveCel(_center) then--深度
        return _center
    end
    if isDeadCel(getCell(_col-1,_row+1)) and isAliveCel(_left) then --左子点
        return _left
    end
    if isDeadCel(getCell(_col+1,_row+1)) and isAliveCel(_right) then --右子点
        return _right
    end
    return nil
end
--添加obj->——_cell.obj
function addCellObj(_cell,obj) --@return typeOrObject
	_cell.obj=obj
    _cell.obj:moveTopoint(_cell._col*Rules.objW,_cell._row*Rules.objH)
--    _cell.obj:setPosition(_cell._col*Rules.objW,_cell._row*Rules.objH)
end
--更新当前_cell
function updateCell(_cell) --@return typeOrObject
    if _cell._type~="dead" and _cell._type~="lock" and _cell.obj~=nil then
    if _cell.obj._state == ObjState.droping then return end
	local _nextCell=getNextCell(_cell)
	if _nextCell~=nil then
        local _obj=_cell.obj
        _cell.obj=nil
		addCellObj(_nextCell,_obj)
	end
	end
end
function updateAllCell() --@return typeOrObject
    for k,v in ipairs(Rules._mapData) do
		updateCell(v)
	end
end
function checkDropOver() --@return typeOrObject
    for k,v in ipairs(Rules._mapData) do
        local Cell=v
        if v._type==_mapCellType.normal and v.obj==nil then 
--        cclog("false-------->")
        return false end
    end
--    cclog("move over----------->")
    return true
end
function beginTick() --@return typeOrObject
	function GameTick(dt) --@return typeOrObject
	if getGameState()==GAMESTATE.droping then
	updateAllCell()
        if checkDropOver()==true then
        	setGameState(GAMESTATE.normal)
        end
	end
	end
	
	local _sch=cc.Director:getInstance():getScheduler()
	_sch:scheduleScriptFunc(GameTick,0.025,false)
end
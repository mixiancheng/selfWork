LineNode=class("LineNode",function () --@return typeOrObject
	cc.Node:create()
end)
LineNode.__index=LineNode
LineNode._col=0--列号
LineNode._nums=0--容量
LineNode._isHaveCrt=false--是否拥有工厂
LineNode._data={}--地形数据 0正常 1死节点
LineNode._objs={}--obj容器
---
--
--初始化_objs
function LineNode:init_objs() --@return typeOrObject
	for var=0, self._nums do
        math.randomseed(os.time()*self._col*var)
        local _type=math.random(1,4)
		local _temp=LineObjCreat(_type,self._col,var);
	end
end
function LineNode:initData(_col,_num) --@return typeOrObject
	self._col=_col
	self._nums=_num
end
function creatLineNode(_col,_num) --@return typeOrObject
	local _temp=LineNode.new()
	_temp:initData(_col,_num)
	return _temp
end
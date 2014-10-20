require "luaRes/extern"
require "AudioEngine"
cclog = function(...)
    print(string.format(...))
end
local MUSIC_PENG1  = "music/wall.wav"
MiFeng = class("MiFeng", function()
    return CCNode:create()
end)
MiFeng.__index=MiFeng
MiFeng.__size=nil
MiFeng.dir=nil--移动方向
MiFeng.r=40
MiFeng._type=0
local move_step=6--移动步长
local rotation_step=6--角度步长
EnumTable = 
{ 
    "dir_up", 
    "dir_down", 
}
function MiFeng:rect()
    local  s = self:getContentSize()
    return CCRectMake(-s.width / 2, -s.height / 2, s.width, s.height)
end
function MiFeng:addAvt(name,type )
	-- body
	local avt  = CCSprite:create(name)
	local out=avt:getContentSize()
	cclog("x===="..out.width.."y===="..out.height)
	self:setContentSize(out)
    avt:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(avt)
	self.r=out.width/2
	self._type=0
	if type==-1 then avt:setFlipX(true) self._type=-1 end
end
function MiFeng:MiFengWithTexture(name,type )
    local _MiFeng = MiFeng.new();
     _MiFeng:addAvt(name,type)
     self.dir=-1;
    return _MiFeng;
end
function MiFeng:step()
    local _rota=self:getRotation()
    if self.dir==EnumTable[1] then 
       _rota=_rota-rotation_step
    elseif self.dir==EnumTable[2] then 
       _rota=_rota+rotation_step
    end
    -- _rota=_rota-3
    -- cclog("dir====="..self.dir.."_rota===".._rota)
    _rota=_rota%360
    if _rota<0 then _rota=_rota+360 end 
    -- cclog("r======".. _rota)

    local cn=math.cos(math.rad(_rota))
    local sn=math.sin(math.rad(_rota))
    local movex=move_step*cn
    local movey=move_step*sn*-1;
    -- cclog("_rota====".._rota.."cn===="..cn.."sn===="..sn.."movex==="..movex.."movey"..movey)
    local nx=self:getPositionX()+movex
    local ny=self:getPositionY()+movey
    
    if ny<0 then 
        _rota=-_rota
        -- local tempcn =math.deg(math.atan(movey/movex));
        self:setRotation(_rota)
        AudioEngine.playEffect(MUSIC_PENG1)
    elseif ny>768 then 
        _rota=-_rota
        -- local tempcn =math.deg(math.atan(movey/movex));
        self:setRotation(_rota)
        AudioEngine.playEffect(MUSIC_PENG1)
    elseif nx<0 then 
        _rota=180-_rota
        -- local tempcn =math.deg(math.atan(movey/movex));
        self:setRotation(_rota)
        AudioEngine.playEffect(MUSIC_PENG1)
    elseif nx>1024 then 
        _rota=180-_rota
        -- local tempcn =math.deg(math.atan(movey/movex));
        self:setRotation(_rota)
        AudioEngine.playEffect(MUSIC_PENG1)
    else 
        self:setPosition(ccp(nx,ny))
        self:setRotation(_rota)
        -- AudioEngine.playEffect(MUSIC_PENG1)
    end
end 
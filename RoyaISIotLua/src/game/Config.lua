_GameControl=nil
_LineLayer=nil
ColState={normal=0,moveIng=1,moveOver=2}
function intiRule()
    _rule=require("Rules")
    _GameControl=getGameControl()
end
function initIconImg()
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("Icons.plist")
end
function spin()
	_GameControl:spin()
end
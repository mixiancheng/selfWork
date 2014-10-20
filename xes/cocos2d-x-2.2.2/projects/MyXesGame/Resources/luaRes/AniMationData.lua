function getsaiZiAni(frames)
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/saiziAni.plist", "ani/saiziAni.png")
	local moreFrames=CCArray:create()
	for i = 1,30 do
        local str = string.format("0000%02d.png",i)
        cclog(str)
        local frame = cache:spriteFrameByName(string.format("0000%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
       end 
    
    end 
    moreFrames:addObject(frames)
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getxdjAni()
    -- body
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/xdjAni.plist", "ani/xdjAni.png")
    local moreFrames=CCArray:create()
    for i = 1,25 do
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("xiaozhuan_00%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
    end 
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.1)
    return CCAnimate:create(animMixed)
end
function getdellHeartAni()
    -- body
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/dellHeart.plist", "ani/dellHeart.png")
    local moreFrames=CCArray:create()
    for i = 1,12 do
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("jxda_00%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
    end 
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.1)
    return CCAnimate:create(animMixed)
end
function getdjfgAni()
    -- body
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/djfgAni.plist", "ani/djfgAni.png")
    local moreFrames=CCArray:create()
    for i = 1,25 do
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("fa_00%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
    end 
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.1)
    return CCAnimate:create(animMixed)
end
function getddjAni()
    -- body
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/ddjAni.plist", "ani/ddjAni.png")
    local moreFrames=CCArray:create()
    for i = 1,25 do
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("dazhuan_00%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
    end 
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.1)
    return CCAnimate:create(animMixed)
end
function getBlsAni()
    -- body
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("ani/BlsANi.plist", "ani/BlsANi.png")
    local moreFrames=CCArray:create()
    for i = 1,20 do
        local str = string.format("bls_00%02d.png",i)
        cclog(str)
        local frame = cache:spriteFrameByName(string.format("bls_00%02d.png",i))
        if frame~=nil then 
        moreFrames:addObject(frame)
    end 
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.1)
    return CCAnimate:create(animMixed)
end
function getHMNOm()
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/HMNom.plist", "ani/HMNom.png")
	local moreFrames=CCArray:create()
	for i = 1,20 do
        local str = string.format("cs_00%02d.png",i)
        cclog(str)
        local frame = cache:spriteFrameByName(string.format("cs_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getDCNOm()
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/DCNom.plist", "ani/DCNom.png")
	local moreFrames=CCArray:create()
	for i = 1,35 do
        local str = string.format("daocao_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("daocao_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getHH()
	-- bodyHHAni
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/HHAni.plist", "ani/HHAni.png")
	local moreFrames=CCArray:create()
	for i = 1,5 do
        local str = string.format("huan_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("huan_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getHMNO()
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/mhNo.plist", "ani/mhNo.png")
	local moreFrames=CCArray:create()
	for i = 1,34 do
        local str = string.format("dc_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("dc_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getHMYes()
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/mhYes.plist", "ani/mhYes.png")
	local moreFrames=CCArray:create()
	for i = 1,9 do
        local str = string.format("dd_00%02d.png",i)
        -- cclog(str)
        local frame = cache:spriteFrameByName(string.format("dd_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
function getLoadAni()
	-- body
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("ani/loadAni.plist", "ani/loadAni.png")
	local moreFrames=CCArray:create()
	for i = 1,24 do
        local str = string.format("lo_00%02d.png",i)
        cclog(str)
        local frame = cache:spriteFrameByName(string.format("lo_00%02d.png",i))
        moreFrames:addObject(frame)
    end 
    local animMixed = CCAnimation:createWithSpriteFrames(moreFrames,0.04)
    return CCAnimate:create(animMixed)
end
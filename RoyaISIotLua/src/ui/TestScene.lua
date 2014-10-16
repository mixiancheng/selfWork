local TestScene = class("TestScene",function()
    return cc.Scene:create()
end)

function TestScene:create()
    local scene = TestScene:new()
    local layerColor = cc.LayerColor:create(cc.c4b(0,0,0,255))
     
    for var=0, 10 do
--        local myModel = cc.Sprite3D:create("3dmodel/tortoise.c3b")
        local myModel = cc.Sprite3D:create("3dmodel/xixuegui.c3t")
        myModel:setPosition(math.random()*g_visible_size.width, math.random()*g_visible_size.height)
        myModel:setScale(2)
        layerColor:addChild(myModel)
--        local animation = cc.Animation3D:create("3dmodel/tortoise.c3b")
        local animation = cc.Animation3D:create("3dmodel/xixuegui.c3t")
        if nil ~= animation then
            local animate = cc.Animate3D:create(animation, 0.0, 3.933)
            myModel:runAction(cc.RepeatForever:create(animate))
        end
    end

    scene:addChild(layerColor)    	
    return scene
end

function createTest()
    return TestScene:create()
end
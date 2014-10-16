module ("Network", package.seeall)
_net=nil
local tm_cbFuncs = {}
local re_cbFuncs = {}
local no_loading_cbFunc = {}
function netInit()
    _net=NetUtil:create()
end 
function Connect(addres,nPort) --@return typeOrObject
    if (not _net:connect(addres, nPort)) then
        cclog("The network is unavailable.")
        return false
     end
cclog("The network is ok--------------->")
return true
end
function rpc(cbFunc, cbFlag, rpcName, args, autoRelease)
--    local disp = BTEventDispatcher:getInstance()
    local sendString = args
    cclog("--------->%s",sendString)
    local sendData={string.byte(sendString,1,-1)}
    --cclog("sendPack: \n"..text_format.msg_format(args))
    if _net==nil then cclog("nilll----->") return  end 
    _net:addLuaHandler(cbFlag, networkHandler, autoRelease)
    _net:callRPC(cbFlag, rpcName, sendData,table.getn(sendData))

    tm_cbFuncs[cbFlag] = cbFunc

--    LoadingUI.addLoadingUI()
    -- 网络请求 0.5秒后才出现
    -- LoadingUI.setVisiable(false)
    -- local runningScene = CCDirector:sharedDirector():getRunningScene()
    -- local actionArray = CCArray:create()
    -- actionArray:addObject(CCDelayTime:create(0.5))
    -- actionArray:addObject(CCCallFunc:create(function ( ... )
    --  if(tm_cbFuncs[cbFlag] ~= nil) then
    --      LoadingUI.setVisiable(true)
    --      local actions = CCArray:create()
    --      actions:addObject(CCDelayTime:create(5))
    --      actions:addObject(CCCallFunc:create(function ( ... )
    --          if(LoadingUI.getVisiable() == true) then
    --              LoadingUI.setVisiable(false)
    --          end
    --      end))
    --      runningScene:runAction(CCSequence:create(actions))
    --  end
    -- end))
    -- runningScene:runAction(CCSequence:create(actionArray))

end
-- 网络统一接口
function networkHandler(cbFlag, dictData, bRet)
    cclog("network-------Handler")
    cclog("name====%s",cbFlag)
--    LoadingUI.reduceLoadingUI()
    if not bRet and g_debug_mode then
        -- 调试模式先调错误页面
--        require "script/ui/tip/AlertTip"
--        AlertTip.showAlert(dictData.err, function ( ... )
            -- body
--            end)
    end

    -- 把网络结果传给UI
    if (tm_cbFuncs[cbFlag] == nil) then
        return
    end
    tm_cbFuncs[cbFlag](cbFlag, dictData, bRet)
    tm_cbFuncs[cbFlag] = nil
end
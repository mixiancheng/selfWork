

module('Resource',package.seeall)
local pathToSave =nil

--获取本地数据,返回数据string
function getLocalData(fileName)
	
	return nil
end

--保存本地数据
function savaLocalData(fileName, data)
	
end

function update()
cclog("UpdateResource")
    
--    function createDownloadDir()
--        cc.FileUtils:getInstance():getWritablePath()
--    end
    pathToSave = cc.FileUtils:getInstance():getWritablePath()
    cclog("pathToSave--->%s",pathToSave)
    local function onError(errorCode)
        if errorCode == cc.ASSETSMANAGER_NO_NEW_VERSION then
            cclog("no new version")
        elseif errorCode == cc.ASSETSMANAGER_NETWORK then
            cclog("network error")
        end
    end

    local function onProgress( percent )
        local progress = string.format("downloading %d%%",percent)
--        cclog(progress)
    end

    local function onSuccess()
        cclog("downloading ok")
--        pathToSave = createDownloadDir()
--        cclog("pathToSave--->%s",pathToSave)
        local realPath = pathToSave .. "/package"
        cclog("realPath--->%s",realPath)
        cc.FileUtils:getInstance():addSearchPath(realPath)
        GoInGame()
    end
    local function getAssetsManager()
        if nil == assetsManager then
            assetsManager = cc.AssetsManager:new("https://raw.githubusercontent.com/mixiancheng/xrsgame/master/package.zip",
                "https://raw.githubusercontent.com/mixiancheng/xrsgame/master/version",
                pathToSave)
            assetsManager:retain()
            assetsManager:setDelegate(onError, cc.ASSETSMANAGER_PROTOCOL_ERROR )
            assetsManager:setDelegate(onProgress, cc.ASSETSMANAGER_PROTOCOL_PROGRESS)
            assetsManager:setDelegate(onSuccess, cc.ASSETSMANAGER_PROTOCOL_SUCCESS )
            assetsManager:setConnectionTimeout(3)
        end
        return assetsManager
    end
    
    getAssetsManager():update()
    
    local function reloadModule( moduleName )

        package.loaded[moduleName] = nil

        return require(moduleName)
    end
end
#include "cocos2d.h"
#include "CCEGLView.h"
#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "script_support/CCScriptSupport.h"
#include "Lua_extensions_CCB.h"
#include "HelloWorldScene.h"
#include "lua_extensions.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "Lua_web_socket.h"
#endif
using namespace CocosDenshion;
#include <vector>
#include <string>
#include "AppMacros.h"
using namespace std;
USING_NS_CC;
static AssetsManager* pAssetsManager;
AppDelegate::AppDelegate():isUpdate(false)
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    CCDirector* pDirector = CCDirector::sharedDirector();
    CCEGLView* pEGLView = CCEGLView::sharedOpenGLView();
    
    pDirector->setOpenGLView(pEGLView);
	CCSize frameSize = pEGLView->getFrameSize();
    frameSize=CCSize(1024, 768);
    CCLOG("size==%f,%f",frameSize.width,frameSize.height);
    // Set the design resolution
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT) || (CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
    pEGLView->setDesignResolutionSize(designResolutionSize.width, designResolutionSize.height, kResolutionShowAll);
#else
    pEGLView->setDesignResolutionSize(designResolutionSize.width, designResolutionSize.height, kResolutionExactFit);
#endif
    
    
    vector<string> searchPath;
    
    // In this demo, we select resource according to the frame's height.
    // If the resource size is different from design resolution size, you need to set contentScaleFactor.
    // We use the ratio of resource's height to the height of design resolution,
    // this can make sure that the resource's height could fit for the height of design resolution.
    
    // if the frame's height is larger than the height of medium resource size, select large resource.
	if (frameSize.height > mediumResource.size.height)
	{
        searchPath.push_back(largeResource.directory);
        
        pDirector->setContentScaleFactor(MIN(largeResource.size.height/designResolutionSize.height, largeResource.size.width/designResolutionSize.width));
        CCLOG("largeResource+ipadhd");
	}
    // if the frame's height is larger than the height of small resource size, select medium resource.
    else if (frameSize.height > smallResource.size.height)
    {
        searchPath.push_back(mediumResource.directory);
        
        pDirector->setContentScaleFactor(MIN(mediumResource.size.height/designResolutionSize.height, mediumResource.size.width/designResolutionSize.width));
        CCLOG("mediumResource+ipad");
    }
    // if the frame's height is smaller than the height of medium resource size, select small resource.
	else
    {
        searchPath.push_back(smallResource.directory);
        
        pDirector->setContentScaleFactor(MIN(smallResource.size.height/designResolutionSize.height, smallResource.size.width/designResolutionSize.width));
        CCLOG("smallResource+iphone)");
    }
    
    
    // set searching path
    CCFileUtils::sharedFileUtils()->setSearchPaths(searchPath);
	
    // turn on display FPS
//    pDirector->setDisplayStats(true);
    
    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);
//    if (true
//        ) {
//        CCScene *pScene = HelloWorld::scene();
//        
//        // run
//        pDirector->runWithScene(pScene);
//        return true;
//    }
    if (true) {
        CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
        CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);
        tolua_extensions_ccb_open(pEngine->getLuaStack()->getLuaState());
        CCFileUtils::sharedFileUtils()->addSearchPath("luaRes");
        string runLua = CCFileUtils::sharedFileUtils()->fullPathForFilename("controller.lua");
        pEngine->executeScriptFile(runLua.c_str());
        return true;
    }
//    createDownDir();
//    pathToSave=""; 
//    updateFiles();
    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->stopAnimation();

    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    CCDirector::sharedDirector()->startAnimation();

    SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
void AppDelegate::updateFiles(){
//    CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
//    CCLuaStack *pStack = pEngine->getLuaStack();
//    lua_State* L = pStack->getLuaState();
//    luaopen_lua_extensions(L);
//    CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);
//    if (isUpdate) {
//        createDownDir();
//        pAssetsManager = new AssetsManager("https://raw.github.com/mixiancheng/xrsgame/master/v1.0.zip", "https://raw.github.com/mixiancheng/xrsgame/master/version",pathToSave.c_str());
//        if(pAssetsManager->checkUpdate()){
//            if( pAssetsManager->update() ){//改源码
//                //首先添加下载文件的目录
//                pEngine->addSearchPath(pathToSave.c_str());
//            }
//        }else{
//            CCLOG("当前为最新版本");
//        }
//
//    }
//    tolua_extensions_ccb_open(pEngine->getLuaStack()->getLuaState());
//    string runLua = CCFileUtils::sharedFileUtils()->fullPathForFilename("luaRes/controller.lua");
//    pEngine->addSearchPath(runLua.substr(0, runLua.find_last_of("/")).c_str());
//    pEngine->executeScriptFile(runLua.c_str());
}

void AppDelegate::createDownDir(){
//    CCFileUtils::sharedFileUtils()->getWriteablePath()
    pathToSave = CCFileUtils::sharedFileUtils()->getWritablePath();
    CCLog(pathToSave.c_str());
    pathToSave += "bobomi";
    
    // Create the folder if it doesn't exist
#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
    DIR *pDir = NULL;
    
    pDir = opendir (pathToSave.c_str());
    if (! pDir)
    {
        mkdir(pathToSave.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
    }
#else
    if ((GetFileAttributesA(pathToSave.c_str())) == INVALID_FILE_ATTRIBUTES)
    {
        CreateDirectoryA(pathToSave.c_str(), 0);
    } 
#endif 
    
}

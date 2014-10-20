//
//  HSpriteCPP.cpp
//  OcGame
//
//  Created by 米宪成 on 14-3-3.
//
//
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
#include "HSpriteOC.h"
#include "Platform.h"
#endif

#include "HSpriteCPP.h"

HSpriteCPP* HSpriteCPP::hspriteWithFile(const char *spName)
{
    HSpriteCPP *pobSprite = new HSpriteCPP();
    CCImage* _img=new CCImage();
    _img->initWithImageFile(spName);
    CCLog("w==%d,h====%d",_img->getWidth(),_img->getHeight());
    CCTexture2D* headImg=new CCTexture2D();
    const char *fileName="test.png";
    std::string fullpath = CCFileUtils::sharedFileUtils()->getWritablePath() + fileName;//得到保存资源的位置
    _img->saveToFile(fullpath.c_str(), false);
    CCLog("w==%d,h====%d",_img->getWidth(),_img->getHeight());
    CCImage* image=new CCImage();
    image->initWithImageFile(fullpath.c_str());
    headImg->initWithImage(image);
    if (pobSprite && pobSprite->initWithTexture(headImg))
    {
        pobSprite->myInit();
        pobSprite->autorelease();
        return pobSprite;
    }
    CC_SAFE_DELETE(pobSprite);
    return NULL;
}

void HSpriteCPP::myInit(){
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    //iOS代码
    [HSpriteOC testLog];
    [HSpriteOC testLogWithStr:@"oc"];
    [HSpriteOC hMessageBox:@"lua->c++->oc" title:@"bobomi"];
     NSString* str= [HSpriteOC outMes];
    const char *pConstChar;
//    strNSString = [[NSString alloc] initWithUTF8String:pConstChar];
    pConstChar = [str UTF8String];
    Platform::playVideo();
#else
    //Android代码
#endif
    
}

HSpriteCPP::~HSpriteCPP(){
    
}
//
//  HSpriteCPP.h
//  OcGame
//
//  Created by 米宪成 on 14-3-3.
//
//
#ifndef __OcGame__HSpriteCPP__
#define __OcGame__HSpriteCPP__
#include "cocos2d.h"
using namespace cocos2d;
class HSpriteCPP:public cocos2d::CCSprite {
public:
    static HSpriteCPP* hspriteWithFile(const char *spName);
    void myInit();
    virtual ~HSpriteCPP();
//    void initImg();
};
#endif /* defined(__OcGame__HSpriteCPP__) */

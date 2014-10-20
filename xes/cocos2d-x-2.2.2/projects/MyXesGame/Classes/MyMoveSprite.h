//
//  MyMoveSprite.h
//  HelloCpp
//
//  Created by 米宪成 on 14-3-13.
//
//

#ifndef __HelloCpp__MyMoveSprite__
#define __HelloCpp__MyMoveSprite__

#include <iostream>
#include "cocos2d.h"
using namespace cocos2d;
class MyMoveSprite : public CCSprite{
    public:
    float _DEGREES;
    float _moveStep;
    float diry;
    bool _isMove;
    MyMoveSprite();
    ~MyMoveSprite();
    void update();
    void moveTick();
    void myInit();
    void set_DEGREES(float t);
    void set_moveStep(float t);
    void set_isMove(bool t);
    bool get_isMove();
    float get_DEGREES();
    float get_moveStep();
    static MyMoveSprite* creatMyMoveSprite(const char* img);
};
#endif /* defined(__HelloCpp__MyMoveSprite__) */

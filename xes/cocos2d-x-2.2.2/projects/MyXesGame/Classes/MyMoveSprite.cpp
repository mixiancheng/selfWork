//
//  MyMoveSprite.cpp
//  HelloCpp
//
//  Created by 米宪成 on 14-3-13.
//
//

#include "MyMoveSprite.h"
MyMoveSprite::MyMoveSprite():_DEGREES(0),_moveStep(4),diry(0),_isMove(false)
{
    
}
MyMoveSprite::~MyMoveSprite(){
    
}
bool MyMoveSprite::get_isMove(){
    return this->_isMove;
}
void MyMoveSprite::set_isMove(bool t){
    this->_isMove=t;
}
void MyMoveSprite::moveTick(){
    if (diry==1) {
        _DEGREES-=1;
    }
    if (diry==2) {
        _DEGREES+=1;
    }
    setRotation(_DEGREES);
    float a= CC_DEGREES_TO_RADIANS(_DEGREES);
    float cn=cosf(a);
    float sn=sinf(a);
    float x=_moveStep* cosf(a);
    float y=_moveStep* sinf(a)*-1;
    CCPoint newpoint= ccpAdd(getPosition(), ccp(x, y));
    if (newpoint.y<0||newpoint.y>768) {
        float tempcn =atan2f(-sn, cn);
        float t=CC_RADIANS_TO_DEGREES(tempcn);
        CCLog("t======%f",t);
        _DEGREES=t;
        return;
    }
    if (newpoint.x<0||newpoint.x>1024) {
        float tempcn =atan2f(sn, -cn);
        float t=CC_RADIANS_TO_DEGREES(tempcn);
        CCLog("t======%f",t);
        _DEGREES=t;
        return;
    }
    setPosition(newpoint);
}
void MyMoveSprite::set_DEGREES(float t){
    this->_DEGREES=t;
    setRotation(_DEGREES);
}
float MyMoveSprite::get_DEGREES(){
    return this->_DEGREES;
}
void MyMoveSprite::set_moveStep(float t){
    this->_moveStep=t;
}
float MyMoveSprite::get_moveStep(){
    return this->_moveStep;
}
void MyMoveSprite::update(){
    if (get_isMove()) {
        moveTick();
    }
}
void MyMoveSprite::myInit(){
    schedule(schedule_selector(MyMoveSprite::update));
}
MyMoveSprite* MyMoveSprite::creatMyMoveSprite(const char *img){
    MyMoveSprite* _sp=new MyMoveSprite();
    _sp->initWithFile(img);
    _sp->myInit();
    _sp->autorelease();
    return _sp;
}
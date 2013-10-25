//
//  HelloWorldLayer.m
//  ActionEx3
//
//  Created by Lee Jaewhan on 11. 8. 1..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"


@implementation HelloWorldLayer

- (void)dealloc
{
    [super dealloc];
}

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    [scene addChild: layer];
    
    return scene;
}

- (id)init
{
    if ( (self=[super initWithColor:ccc4(255,255,255,255)]) ) {
        
        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doAction:)];
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(doActionReset:)];
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
        menu.position = ccp(240,50);
        [menu alignItemsHorizontally];
        
        [self addChild:menu];
        
        
        // Grossini 씨 Sprite 추가
        man = [CCSprite spriteWithFile:@"grossini.png"];
        man.position = ccp(50,100);
        man.scale = 0.5;
        [self addChild:man];
        
        // Grossini 씨 sister1 Sprite 추가
        woman1 = [CCSprite spriteWithFile:@"grossinis_sister1.png"];
        woman1.position = ccp(50,180);
        woman1.scale = 0.5;
        [self addChild:woman1];
        
        // Grossini 씨 sister2 Sprite 추가
        woman2 = [CCSprite spriteWithFile:@"grossinis_sister2.png"];
        woman2.position = ccp(50,260);
        woman2.scale = 0.5;
        [self addChild:woman2];
        
        
        
        //id rightMove1 = [CCMoveBy actionWithDuration:4 position:ccp(400,0)];
        
        // 빨라지기
        //id test1 = [CCEaseIn actionWithAction:rightMove1 rate:3.0];
        // 시작 탄력
        //id test1 = [CCEaseElasticIn actionWithAction:rightMove1 period:1.0];
        
        //id test1 = [CCEaseBounceIn actionWithAction:rightMove1];
        //id test1 = [CCEaseBounceOut actionWithAction:rightMove1];
        
//        id scale = [CCScaleBy actionWithDuration:4.0 scale:3.0];
//        id test1 = [CCEaseBounceOut actionWithAction:scale];
//        
//        [ball1 runAction:test1];
        
        
//        id rightMove2 = [CCMoveBy actionWithDuration:4 position:ccp(400,0)];
//        
//        // 느려지기
//        id test2 = [CCEaseOut actionWithAction:rightMove2 rate:3.0];
//        
//        [ball2 runAction:test2];
        
        
//        id rightMove3 = [CCMoveBy actionWithDuration:4 position:ccp(400,0)];
//        
//        // 빨라졌다 느려지기
//        id totalSpeed = [CCEaseInOut actionWithAction:rightMove3 rate:3.0];
//        
//        [ball3 runAction:totalSpeed];
        
        
        
        
        
        
        
//        id fadeOut = [CCFadeOut actionWithDuration:3.0];
//        
//        ball3.opacity = 0; // 최초 깜박이는거 방지
//        id fadeIn = [CCFadeIn actionWithDuration:3.0];
//        
//        [ball3 runAction:fadeOut];
        
        
//        ball3.opacity = 0; // 최초 깜박이는거 방지
//        id fadeTo = [CCFadeTo actionWithDuration:3.0 opacity:90];
//        [ball3 runAction:fadeTo];
        
        
        
        
        
        
    }
    return self;
}

- (void)doAction:(id)sender
{
//    id myAction = [CCMoveBy actionWithDuration:3 position:ccp(400,0)];
//    
//    id action1 = [CCEaseIn actionWithAction:myAction rate:3.0];
//    [man runAction:action1];
//    
//    id action2 = [CCEaseOut actionWithAction:[myAction copy] rate:3.0];
//    [woman1 runAction:action2];
//
//    id action3 = [CCEaseInOut actionWithAction:[myAction copy] rate:3.0];
//    [woman2 runAction:action3];
    
    
//    // 시작 부분 탄성
//    id move1   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
//    id action1 = [CCEaseElasticIn actionWithAction: move1 period:0.3f];
//    [man runAction:action1];
//    
//    // 끝 부분 탄성
//    id move2   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
//    id action2 = [CCEaseElasticOut actionWithAction:move2 period:0.3f];
//    [woman1 runAction:action2];
//    
//    // 시작과 끝 부분 탄성
//    id move3   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
//    id action3 = [CCEaseElasticInOut actionWithAction:move3 period:0.3f];
//    [woman2 runAction:action3];
    
    
    
    // 시작 부분 바운스
    id move1   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
    id action1 = [CCEaseBounceIn actionWithAction:move1];
    [man runAction:action1];
    
    // 끝 부분 바운스
    id move2   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
    id action2 = [CCEaseBounceOut actionWithAction:move2];
    [woman1 runAction:action2];
    
    // 시작과 끝 부분 바운스
    id move3   = [CCMoveBy actionWithDuration:3 position:ccp(350, 0)];
    id action3 = [CCEaseBounceInOut actionWithAction:move3];
    [woman2 runAction:action3];
}

- (void)doActionReset:(id)sender
{
    man.position    = ccp(50,100);
    woman1.position = ccp(50,180);
    woman2.position = ccp(50,260);
}

@end

//
//  HelloWorldLayer.m
//  SpriteEx1
//
//  Created by Lee Jaewhan on 11. 7. 31..
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
//    if ( (self=[super init]) ) {
    if ( (self=[super initWithColor:ccc4(255,255,255,255)]) ) {
        
        // 1.앵커포인트의 개념
        // 2.스프라이트의 (계)층 개념

        CCSprite *man = [CCSprite spriteWithFile:@"grossini.png"];
        man.position = ccp(240,160);
        
//        man.anchorPoint = ccp(0,0);
//        man.anchorPoint = ccp(0,1);
//        man.anchorPoint = ccp(1,0);
//        man.anchorPoint = ccp(1,1);
        
//        [self addChild:man];
        [self addChild:man z:2];  // 위치 지정 : 2층
        
        
        CCSprite *women1 = [CCSprite spriteWithFile:@"grossinis_sister1.png"];
        women1.position = ccp(260,160);
        [self addChild:women1];  // 위치 지정 : 1층

        
    }
    return self;
}


@end

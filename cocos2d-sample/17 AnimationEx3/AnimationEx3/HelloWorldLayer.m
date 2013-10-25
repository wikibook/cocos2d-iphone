//
//  HelloWorldLayer.m
//  AnimationEx3
//
//  Created by Lee Jaewhan on 11. 8. 27..
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
        
        
        // 스프라이트 시트의 위치정보 파일을 읽어들인다.
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grossini_family.plist"];

        
        CCSpriteFrame *frame1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"grossini.png"];
        
        CCSprite *man = [CCSprite spriteWithSpriteFrame:frame1];
        
        man.position = ccp(100,160);
        
        [self addChild:man];

        
        
        CCSpriteFrame *frame2 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"grossinis_sister1.png"];
        
        CCSprite *woman1 = [CCSprite spriteWithSpriteFrame:frame2];
        
        woman1.position = ccp(200,160);
        
        [self addChild:woman1];
        
        
        
        CCSpriteFrame *frame3 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"grossinis_sister2.png"];
        
        CCSprite *woman2 = [CCSprite spriteWithSpriteFrame:frame3];
        
        woman2.position = ccp(300,160);
        
        [self addChild:woman2];

    
    }
    return self;
}

@end

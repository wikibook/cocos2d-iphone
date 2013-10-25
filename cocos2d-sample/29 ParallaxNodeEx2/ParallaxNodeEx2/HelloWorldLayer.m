//
//  HelloWorldLayer.m
//  ParallaxNodeEx2
//
//  Created by Lee Jaewhan on 11. 9. 3..
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
    if ( (self=[super init]) ) {
        
        // 이미지로 백그라운드에 쓰일 CCSprite를 만듭니다.
        CCSprite *bgSprite1 = [CCSprite spriteWithFile:@"background1.png"];
        CCSprite *bgSprite2 = [CCSprite spriteWithFile:@"background2.png"];
        
        // Transform 할 때 사용되는 anchorPoint를 왼쪽 아래(0, 0)로 잡습니다. 
        bgSprite1.anchorPoint = ccp(0, 0);
        bgSprite2.anchorPoint = ccp(0, 0);
        
        // 이미지가 만나는 가장자리(edge)에 검은선이 생기는 현상을 방지하기 위하여
        // Anti-Aliasing을 끕니다.
        [bgSprite1.texture setAliasTexParameters];
        [bgSprite2.texture setAliasTexParameters];
        
        // 위에서 만든 sprite를 담을 parent로 CCParallaxNode를 만듭니다.
        CCParallaxNode *voidNode = [CCParallaxNode node];
        
        // 배경 sprite를 Parallax에 넣습니다.
        [voidNode addChild:bgSprite1 z:1 parallaxRatio:ccp(1.0f, 0) positionOffset:CGPointZero];
        [voidNode addChild:bgSprite2 z:1 parallaxRatio:ccp(1.0f, 0) positionOffset:ccp(512, 0)];
        
        // Layer를 만든 후 거기에 ParallaxNode를 child로 넣습니다.
        CCLayer *gameLayer = [CCLayer node];
        [gameLayer addChild:voidNode z:2];
        
        id go     = [CCMoveBy actionWithDuration:4 position:ccp(-512,0)];
        id goBack = [go reverse];
        id seq    = [CCSequence actions:go,goBack,nil];    
        
        [gameLayer runAction: [CCRepeatForever actionWithAction:seq ] ];
        
        [self addChild:gameLayer];
        
    
    }
    return self;
}

@end

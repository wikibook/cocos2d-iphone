//
//  HelloWorldLayer.m
//  ParallaxNodeEx1
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
        
        
//        CCLabelTTF *gubun1 = [CCLabelTTF labelWithString:@"Start" fontName:@"Marker Felt" fontSize:64];
//        CCLabelTTF *gubun2 = [CCLabelTTF labelWithString:@"End" fontName:@"Marker Felt"   fontSize:64];
//        
//        // position the label on the center of the screen
//        gubun1.position    = ccp(0,160);
//        gubun1.anchorPoint = ccp(0.0,0.5);
//        gubun2.position    = ccp(640,160);
//        gubun2.anchorPoint = ccp(1.0,0.5);
        
        
        
        
        // Top Layer, a simple image
        CCSprite *image1 = [CCSprite spriteWithFile:@"powered.png"];
        // change the transform anchor point to 0,0 (optional)
        image1.anchorPoint = ccp(0,0);
        image1.position = ccp(240,0);
        
        // Top Layer, a simple image
        CCSprite *cocosImage = [CCSprite spriteWithFile:@"powered.png"];
        // change the transform anchor point to 0,0 (optional)
        cocosImage.anchorPoint = ccp(0,0);
        
        
        // background layer: another image
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        // change the transform anchor point (optional)
        background.anchorPoint = ccp(0,0);
        
        
        
        // create a void node, a parent node
        CCParallaxNode *voidNode = [CCParallaxNode node];
        
        // background image is moved at a ratio of 0.4x, 0.5y
        [voidNode addChild:background z:1 parallaxRatio:ccp(0.5f,0.0f) positionOffset:ccp(0,-160)];
        
        // top image is moved at a ratio of 3.0x, 2.5y
        [voidNode addChild:cocosImage z:2 parallaxRatio:ccp(2.0f,0.0f) positionOffset:ccp(240,0)];
        
        
        
        
        // Layer를 만든 후 거기에 ParallaxNode를 child로 넣습니다.
        CCLayer *gameLayer = [CCLayer node];
        [gameLayer addChild:voidNode z:3];
        
        // add the label as a child to this Layer
//        [gameLayer addChild:gubun1 z:4];
//        [gameLayer addChild:gubun2 z:4];
        [gameLayer addChild:image1 z:4];
        
        id go     = [CCMoveBy actionWithDuration:4 position:ccp(-160,0)];
        id goBack = [go reverse];
        id seq    = [CCSequence actions:go,goBack,nil];    
        
        [gameLayer runAction: [CCRepeatForever actionWithAction:seq ] ];
        
        [self addChild:gameLayer];
        
    
    
    }
    return self;
}

@end

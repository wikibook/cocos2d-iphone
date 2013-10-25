//
//  HelloWorldLayer.m
//  AnimationEx1
//
//  Created by Lee Jaewhan on 11. 8. 2..
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
        
        CCSprite *man = [CCSprite spriteWithFile:@"grossini_dance_01.png"];
        man.position = ccp(240,160);
        [self addChild:man];
        
        
        CCAnimation *animation = [[CCAnimation alloc] init];
        [animation setDelay:0.3];
        
        [animation addFrameWithFilename:@"grossini_dance_01.png"];
        [animation addFrameWithFilename:@"grossini_dance_02.png"];
        [animation addFrameWithFilename:@"grossini_dance_03.png"];
        [animation addFrameWithFilename:@"grossini_dance_04.png"];
        [animation addFrameWithFilename:@"grossini_dance_05.png"];
        [animation addFrameWithFilename:@"grossini_dance_06.png"];
        [animation addFrameWithFilename:@"grossini_dance_07.png"];
        [animation addFrameWithFilename:@"grossini_dance_08.png"];
        [animation addFrameWithFilename:@"grossini_dance_09.png"];
        [animation addFrameWithFilename:@"grossini_dance_10.png"];
        [animation addFrameWithFilename:@"grossini_dance_11.png"];
        [animation addFrameWithFilename:@"grossini_dance_12.png"];
        [animation addFrameWithFilename:@"grossini_dance_13.png"];
        [animation addFrameWithFilename:@"grossini_dance_14.png"];

        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
        animate=[CCRepeatForever actionWithAction:animate];
        
        
        
        [man runAction:animate];
         
        

    }
    return self;
}


@end

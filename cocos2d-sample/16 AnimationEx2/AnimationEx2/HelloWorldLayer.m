//
//  HelloWorldLayer.m
//  AnimationEx2
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
        
        CCSprite *man = [CCSprite spriteWithFile:@"grossini.png"];
        man.position = ccp(240,160);
        [self addChild:man];
        

        
        CCSprite *sprite = [CCSprite spriteWithFile:@"grossini_dance_atlas.png"];
//        CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"grossini_dance_atlas.png"];

        CCAnimation *animation = [[CCAnimation alloc] init];
        
        [animation setDelay:0.3];
        
        for(int i=0;i<14;i++){
            // 첫째 줄에 5개의 프레임이 있고, 6번째 부터는 두 번째 줄에 있으므로,
            // 6번째(idx==5)부터는 y 좌표의 값을 증가시켜야 한다.
            NSUInteger index    = i % 5;
            NSUInteger rowIndex = i / 5;

            [animation addFrameWithTexture:sprite.texture rect:CGRectMake(index*85, rowIndex*121, 85, 121)];
//            [animation addFrameWithTexture:texture  rect:CGRectMake(index*85, rowIndex*121, 85, 121)];
        }
        
        

        
        
        CCAnimate *animate=[CCAnimate actionWithAnimation:animation];
        animate=[CCRepeatForever actionWithAction:animate];
        [man runAction:animate];
        
        
        

    }
    return self;
}



@end

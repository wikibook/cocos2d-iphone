//
//  HelloWorldLayer.m
//  ActionEx
//
//  Created by Lee Jaewhan on 11. 8. 20..
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
                                                        selector:@selector(doActionReverse:)];
        
        CCMenuItem *item3 = [CCMenuItemImage itemFromNormalImage:@"btn-about-normal.png"
                                                   selectedImage:@"btn-about-selected.png"
                                                          target:self
                                                        selector:@selector(doActionReset:)];
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        
        menu.position = ccp(240,50);
        
        [menu alignItemsHorizontally];
    
        [self addChild:menu];

        
        // Grossini 씨 Sprite 추가
        man = [CCSprite spriteWithFile:@"grossini.png"];
        man.position = ccp(50,200);
        [self addChild:man];

        
        
    }
    return self;
}

- (void)doAction:(id)sender
{
//    id myAction = [CCMoveBy actionWithDuration:3 position:ccp(400,0)];
//    id myAction = [CCMoveTo actionWithDuration:3 position:ccp(400,0)];
//    id myAction = [CCJumpBy actionWithDuration:3 position:ccp(240,160) height:50 jumps:3];
//    id myAction = [CCJumpTo actionWithDuration:3 position:ccp(240,160) height:50 jumps:3];

//    ccBezierConfig bezier1;
//	bezier1.controlPoint_1 = ccp(150, 150);
//	bezier1.controlPoint_2 = ccp(250, -150);
//	bezier1.endPosition = ccp(350,0);
//
//    ccBezierConfig bezier2;
//	bezier2.controlPoint_1 = ccp(200, 150);
//	bezier2.controlPoint_2 = ccp(200, 150);
//	bezier2.endPosition = ccp(350,0);
//
//    id myAction = [CCBezierBy actionWithDuration:3 bezier:bezier2];

//    id myAction = [CCPlace actionWithPosition:ccp(250,200)];
//    man.position = ccp(250,200); 과 같은 결과이다.

    CCScaleBy *myAction = [CCScaleBy actionWithDuration:3 scale:2.0];

    [man runAction:myAction];
}

- (void)doActionReverse:(id)sender
{
//    id myAction = [CCMoveBy actionWithDuration:3 position:ccp(400,0)];
//    id myAction = [CCMoveTo actionWithDuration:3 position:ccp(400,0)];
//    id myAction = [CCJumpBy actionWithDuration:3 position:ccp(240,160) height:50 jumps:3];
//    id myAction = [CCJumpTo actionWithDuration:3 position:ccp(240,160) height:50 jumps:3];
   
//    id myAction = [CCPlace actionWithPosition:ccp(250,200)];
    CCScaleBy *myAction = [CCScaleBy actionWithDuration:3 scale:2.0];

    [man runAction:[myAction reverse]];
}

- (void)doActionReset:(id)sender
{
    man.position = ccp(50,200);
}

@end

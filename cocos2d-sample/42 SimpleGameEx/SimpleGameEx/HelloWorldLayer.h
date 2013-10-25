//
//  HelloWorldLayer.h
//  SimpleGameEx
//
//  Created by Lee Jaewhan on 11. 9. 11..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
    CGSize              winSize;

    NSMutableArray      *_targets;
    NSMutableArray      *_projectiles;
    
    CCSprite            *tom;

    int                 _projectilesDestroyed;
}

+ (CCScene *)scene;
- (void)spriteAllLoad;

@end

//
//  HelloWorldLayer.h
//  BrickEx
//
//  Created by Lee Jaewhan on 11. 9. 17..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"


@interface HelloWorldLayer : CCLayer
{
    CCSprite        *ball;
    CCSprite        *paddle;
    NSMutableArray  *targets;

    int             BRICKS_HEIGHT;
    int             BRICKS_WIDTH;

    BOOL            isPlaying;
    BOOL            isPaddleTouched;

    CGPoint         ballMovement;
}

+ (CCScene *)scene;
- (void)initializeBricks;
- (void)initializeBall;
- (void)initializePaddle;
- (void)startGame;
- (void)processCollision:(CCSprite *)brick;

@end

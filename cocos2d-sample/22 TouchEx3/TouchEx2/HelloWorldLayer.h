//
//  HelloWorldLayer.h
//  TouchEx2
//
//  Created by Lee Jaewhan on 11. 8. 2..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
    NSDate              *_touchBeganTime;
    NSMutableArray      *_targets;
    CCSprite            *touchedBallSprite;
}

@property (nonatomic, retain) NSDate *touchBeganTime;

+ (CCScene *)scene;

- (void)makeNewBall:(ccTime)dt;

@end

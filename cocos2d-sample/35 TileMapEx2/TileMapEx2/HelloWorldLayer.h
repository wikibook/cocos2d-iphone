//
//  HelloWorldLayer.h
//  TileMapEx2
//
//  Created by Lee Jaewhan on 11. 9. 4..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
    CGSize          winSize;
    CGPoint         dragonPosition;
    CCSprite        *_dragon;
    CCTMXTiledMap   *tmap;
}

@property (nonatomic, retain) CCSprite *dragon;

+ (CCScene *)scene;
//- (void)setViewpointCenter:(CGPoint)position;
- (void)createDragon;

@end

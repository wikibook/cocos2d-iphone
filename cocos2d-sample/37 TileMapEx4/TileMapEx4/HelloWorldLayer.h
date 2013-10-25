//
//  HelloWorldLayer.h
//  TileMapEx4
//
//  Created by Lee Jaewhan on 11. 9. 5..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
    CGSize          winSize;
    CGPoint         dragonPosition;
    CCSprite        *_dragon;
    CCTMXTiledMap   *_tmap;
    CCTMXLayer      *_background;
    CCTMXLayer      *_items;
    CCTMXLayer      *_metainfo;
}

@property (nonatomic, retain) CCSprite          *dragon;
@property (nonatomic, retain) CCTMXTiledMap     *tmap;
@property (nonatomic, retain) CCTMXLayer        *background;
@property (nonatomic, retain) CCTMXLayer        *items;
@property (nonatomic, retain) CCTMXLayer        *metainfo;

+ (CCScene *)scene;
- (void)createDragon;
- (void)setViewpointCenter:(CGPoint)position;
- (void)setPlayerPosition:(CGPoint)position;
- (CGPoint)tileCoordForPosition:(CGPoint)position;

@end

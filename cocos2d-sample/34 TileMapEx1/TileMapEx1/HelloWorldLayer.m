//
//  HelloWorldLayer.m
//  TileMapEx1
//
//  Created by Lee Jaewhan on 11. 9. 4..
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
        
        self.isTouchEnabled = YES;

        CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"TestDesert.tmx"];
        [self addChild:map z:0 tag:100];

    
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];    
    CGPoint prevLocation = [touch previousLocationInView: [touch view]];    
    
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
    
    CGPoint diff = ccpSub(touchLocation,prevLocation);
    
    CCNode *node = [self getChildByTag:100];
    CGPoint currentPos = [node position];
    
    CGPoint newPos = ccpAdd(currentPos, diff);

    if (newPos.x < -160) {
        newPos.x = -160;
    }
    if (newPos.x > 0) {
        newPos.x = 0;
    }
    newPos.y = 0;
    
    
    [node setPosition: newPos];
    
    
}

@end

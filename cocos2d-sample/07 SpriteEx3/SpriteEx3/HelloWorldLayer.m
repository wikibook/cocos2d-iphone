//
//  HelloWorldLayer.m
//  SpriteEx3
//
//  Created by Lee Jaewhan on 11. 8. 16..
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
//    if ( (self=[super init]) ) {
    if ( (self=[super initWithColor:ccc4(255,255,255,255)]) ) {
        

        CCSprite *parent = [CCSprite spriteWithFile:@"grossini.png"];
        parent.position = ccp(140,160);
        [self addChild:parent];
        
        // TEST: If no texture is given, then Opacity + Color should work.
        
        CCSprite *child = [CCSprite node];
        [child setTextureRect:CGRectMake(0, 0, 50, 5)];
        [child setColor:ccRED];
        
        CGSize parentSize;
        parentSize = parent.contentSize;
        child.position = ccp(parentSize.width/2.0, parentSize.height);
        
        
        [parent addChild:child];
    
    
    }
    return self;
}

@end

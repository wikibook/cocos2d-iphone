//
//  HelloWorldLayer.m
//  SpriteEx2
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
    if ( (self=[super init]) ) {
        
        
		// TEST: If no texture is given, then Opacity + Color should work.
        // 이미지가 없는 상태로 Sprite를 생성하면 색을 지정할 수 있다.
        
        CCSprite *parent = [CCSprite node];
		[parent setTextureRect:CGRectMake(0, 0, 150, 150)];
		[parent setColor:ccWHITE];
        parent.position = ccp(240,160);
        [self addChild:parent];
        
        
        CCSprite *child = [CCSprite node];
//		[child setTextureRect:CGRectMake(0, 0, 50, 50)];
		[child setTextureRect:CGRectMake(0, 0, 50, 5)];
		[child setColor:ccRED];

//        child.position = ccp(0,0);
        CGSize parentSize;
        parentSize = parent.contentSize;
        child.position = ccp(parentSize.width/2.0, parentSize.height+10);
        
        
        [parent addChild:child];
    
    
    }
    return self;
}

@end

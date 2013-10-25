//
//  TestScene2.m
//  SceneTransEx
//
//  Created by Lee Jaewhan on 11. 8. 1..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "TestScene2.h"
#import "HelloWorldLayer.h"


@implementation TestScene2

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	TestScene2 *layer = [TestScene2 node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doAction:)];
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1, nil];
        menu.position = ccp(240,50);
        [self addChild:menu];

        
        
        // Grossini 씨 Sprite 추가
        CCSprite *man = [CCSprite spriteWithFile:@"grossini.png"];
        man.position = ccp(240,200);
        [self addChild:man];

        
        
    }
	return self;
}

- (void)doAction:(id)sender
{
//    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
    
    [[CCDirector sharedDirector] popScene];
}

- (void) dealloc
{
	[super dealloc];
}


@end

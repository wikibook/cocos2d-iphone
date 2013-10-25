//
//  GameOverScene.m
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 2/10/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "GameOver.h"
#import "HelloWorldLayer.h"

@implementation GameOver

- (void)dealloc {
    [super dealloc];
}

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    
    GameOver *layer = [GameOver node];
    
    [scene addChild: layer];
    
    return scene;
}

- (id)init
{
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // 메인메뉴 추가
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"New Game"
                                               fontName:@"Marker Felt"
                                               fontSize:40];
        
        CCMenuItem *newGameItem = [CCMenuItemLabel itemWithLabel:label
                                                          target:self
                                                        selector:@selector(newGameSpriteTapped:)];

        CCMenu *menu = [CCMenu menuWithItems:newGameItem, nil];

        menu.position = ccp(winSize.width/2, winSize.height/2);
        
        [self addChild:menu z:1];

    }
    return self;
}

- (void)newGameSpriteTapped:(id)sender
{
    // 새로운게임을 시작하게 처음 신으로 이동
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}


@end

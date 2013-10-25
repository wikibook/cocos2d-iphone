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

+ (CCScene *)scene:(NSString *)str
{
	return [[[self alloc] initWithTitle:str] autorelease];
}

- (id)initWithTitle:(NSString *)str
{
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/2, winSize.height/2 + 60);
        [self addChild:label z:1];
        

        // 백그라운드 이미지
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"Turret_main_bkgrnd.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:0];
        
        
        // 메인메뉴 추가
        CCSprite *newGameSprite = [CCSprite spriteWithSpriteFrameName:@"Turret_newgame.png"];
        CCMenuItem *newGameItem = [CCMenuItemSprite itemFromNormalSprite:newGameSprite
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(newGameSpriteTapped:)];
        CCMenu *menu = [CCMenu menuWithItems:newGameItem, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2 - 60);
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

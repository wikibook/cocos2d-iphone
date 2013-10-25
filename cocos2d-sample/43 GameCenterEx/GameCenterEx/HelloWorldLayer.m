//
//  HelloWorldLayer.m
//  GameCenterEx
//
//  Created by Lee Jaewhan on 11. 9. 9..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "GameCenterUtil.h"


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
        

        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"점수판보기" fontName:@"Arial" fontSize:24];

        CCMenuItem *item1 = [CCMenuItemLabel itemWithLabel:label1
                                                    target:self
                                                  selector:@selector(showLeaderboard)];
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"점수보내기" fontName:@"Arial" fontSize:24];
        CCMenuItem *item2 = [CCMenuItemLabel itemWithLabel:label2
                                                    target:self
                                                  selector:@selector(sendScore)];
        
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"목표달성보기" fontName:@"Arial" fontSize:24];
        CCMenuItem *item3 = [CCMenuItemLabel itemWithLabel:label3
                                                    target:self
                                                  selector:@selector(showAchievement)];

        CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"목표보내기" fontName:@"Arial" fontSize:24];
        CCMenuItem *item4 = [CCMenuItemLabel itemWithLabel:label4
                                                    target:self
                                                  selector:@selector(sendAchievement)];


        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3,item4, nil];
        
        [menu alignItemsVerticallyWithPadding:30];
        
        
        [self addChild:menu];
    
    
    }
    return self;
}


- (void)showLeaderboard
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (appDelegate != nil) {
        
        // 모든 애니메이션 정지
        [[CCDirector sharedDirector] pause];
        // GameCenter 점수판 보기
        [appDelegate.gameCenterView showLeaderboard];
        
    }
}

- (void)sendScore
{
    // 점수판에 100점을 보낸다.
    [GameCenterUtil reportScore:100];
}


- (void)showAchievement
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate != nil) {
        
        // 모든 애니메이션 정지
        [[CCDirector sharedDirector] pause];

        // GameCenter 점수판 보기
        [appDelegate.gameCenterView showAchievement];
        
    }
}

- (void)sendAchievement
{
    // 이렇게 보내면 picturecard_achivement 이라는 ID를 가지는 목표 달성도가 25%가 찍히게 된다.
    [GameCenterUtil reportAchievementIdentifier:@"picturecard_achivement" percentComplete:25.0f];
}


/*
    //이렇게 보내면 목표달성도가 리셋되게 된다.
    [GameCenterUtil resetAchievements];
*/

@end

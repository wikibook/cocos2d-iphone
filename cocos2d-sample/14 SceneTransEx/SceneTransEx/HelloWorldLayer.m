//
//  HelloWorldLayer.m
//  SceneTransEx
//
//  Created by Lee Jaewhan on 11. 8. 1..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "TestScene2.h"


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
        
        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doAction:)];
        
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(doAction:)];
        
        CCMenuItem *item3 = [CCMenuItemImage itemFromNormalImage:@"btn-about-normal.png"
                                                   selectedImage:@"btn-about-selected.png"
                                                          target:self
                                                        selector:@selector(doAction:)];
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        
        [menu alignItemsVertically];
        
        [self addChild:menu];

    
    }
    return self;
}

- (void)doAction:(id)sender
{
//    [[CCDirector sharedDirector] replaceScene:[TestScene2 scene]];
//    [[CCDirector sharedDirector] pushScene:[TestScene2 scene]];

    CCScene *scene=[CCTransitionCrossFade transitionWithDuration:2 scene:[TestScene2 scene]];
    
    [[CCDirector sharedDirector] pushScene:scene];
}

/*
 
 CCTransitionRotoZoom 회전하면서 Zoom
 CCTransitionJumpZoom 점프하면서 Zoom
 CCTransitionMoveInL 왼쪽에서 다음장면이 나타나서 이전장면을 덮어씀
 CCTransitionMoveInR 오른쪽에서 다음장면이 나타남
 CCTransitionMoveInT 위에서 다음장면이 나타남
 CCTransitionMoveInB 밑에서 다음장면이 나타남
 CCTransitionSlideInL 왼쪽에서 다음장면이 나타나서 이전장면을 밀어냄
 CCTransitionSlideInR 오른쪽에서 다음장면이 나타나서 이전장면을 밀어냄
 CCTransitionSlideInT 위에서 다음장면이 나타나서 이전장면을 밀어냄
 CCTransitionSlideInB 밑에서 다음장면이 나타나서 이전장면을 밀어냄
 CCTransitionShrinkGrow 이전장면 수축 다음장면 확대
 CCTransitionFlipX X축(횡선)을 기준으로 회전
 CCTransitionFlipY Y축(종선)을 기준으로 회전
 CCTransitionFlipAngular 뒤집어지면서 다음장면으로 넘어감
 CCTransitionZoomFlipX X축(횡선)을 기준으로 회전 (확대)
 CCTransitionZoomFlipX Y축(종선)을 기준으로 회전 (확대)
 CCTransitionZoomFlipAngular 뒤집어지면서 다음장면으로 넘어감 (확대)
 CCTransitionFade 패이드인아웃 (검정 화면)
 CCTransitionCrossFade 페이드인아웃
 CCTransitionTurnOffTiles 바둑판무늬 뿌리기
 CCTransitionSplitCols 세등분으로 나누어 양끝의 두둥분은 밑으로 나머지는 위로
 CCTransitionSplitRows 가로로 세등분 나눔
 CCTransitionFadeTR 바둑판무늬 좌측하단부터 우측상단순으로 사라짐
 CCTransitionFadeBL 바툭판무늬 우측상단부터 좌측하단순으로 사라짐
 CCTransitionFadeUp 하단에서 상단으로 잘라냄
 CCTransitionFadeDown 상단에서 하단으로 잘라냄
 
 CCTransitionRadialCCW 시계방향으로 침이 돌면서 장면이바뀝니다.
 CCTransitionPageTurn 페이지넘김형식입니다.
 
 */

@end

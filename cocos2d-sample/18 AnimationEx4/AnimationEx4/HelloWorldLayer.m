//
//  HelloWorldLayer.m
//  AnimationEx4
//
//  Created by Lee Jaewhan on 11. 8. 27..
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
    if ( (self=[super initWithColor:ccc4(255,255,255,255)]) ) {
        
        
        // 스프라이트 시트의 위치정보 파일을 읽어들인다.
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grossini_gray.plist"];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grossini_exam.plist"];

        
        // 각 프레임 파일을 배열로 만들기
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i < 15; i++) {
            
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"grossini_dance_gray_%02d.png",i]];
            [animFrames addObject:frame];
        }
        
        
        
        // 제일 첫번째 프레임으로 주인공 sprite를 만듭니다.
        CCSprite *man = [CCSprite spriteWithSpriteFrame:[animFrames objectAtIndex:0]];
        
//        man.position = ccp(240,160);
        man.position = ccp(50,160);
        
        [self addChild:man];

        
        // CCAnimation에 action을 줄 CCAnimate를 만듭니다.
        CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.3f];

        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];

        animate = [CCRepeatForever actionWithAction:animate];

        [man runAction:animate];
        
        

        // 여기 이전은 man 의 위치를 변경하는 한 줄 수정이고
        // 여기 이후로 다음의 추가된 코드이다.
        id move=[CCMoveBy actionWithDuration:4 position:ccp(400,0)];        
        
        id total=[CCSequence actions:move,[move reverse], nil];
        
        total = [CCRepeatForever actionWithAction:total];
        
        [man runAction:total];

    
    }
    return self;
}

@end

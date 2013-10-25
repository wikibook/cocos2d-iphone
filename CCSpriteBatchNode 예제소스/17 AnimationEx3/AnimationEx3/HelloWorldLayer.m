//
//  HelloWorldLayer.m
//  AnimationEx3
//
//  Created by GaHee Yoon on 12. 11. 28..
//  Copyright wikibooks. All rights reserved.
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
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grossini_family.plist"];
        
        // 모든 이미지가 합쳐진 파일을 읽어들인다
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"grossini_family.png"];
        
        // 배치노드 추가
        [self addChild:batchNode];
        
        // plist 파일의 위치정보를 참고하여 grossini CCSprite 객체를 생성하고
        // sprite 를 배치 노드의 차일드로 추가
        CCSprite *man = [CCSprite spriteWithSpriteFrameName:@"grossini.png"];
        man.position = ccp(100,160);
        [batchNode addChild:man];
        
        CCSprite *woman1 = [CCSprite spriteWithSpriteFrameName:@"grossinis_sister1.png"];
        woman1.position = ccp(200,160);
        [batchNode addChild:woman1];
        
        CCSprite *woman2 = [CCSprite spriteWithSpriteFrameName:@"grossinis_sister2.png"];
        woman2.position = ccp(300,160);
        [batchNode addChild:woman2];
    }
    return self;
}
@end
